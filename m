Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD697606A337
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6D11127D6;
	Thu, 19 Nov 2026 23:59:56 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38B81127D6
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:59:54 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xUC2h-0000000022k-3H1J;
 Thu, 19 Nov 2026 23:59:51 +0000
Date: Thu, 19 Nov 2026 23:59:42 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hermes Wu <hermes.wu@ite.com.tw>, Pin-yen Lin <treapking@chromium.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v9 04/14] drm/bridge: it6505: unregister DP AUX adapter on
 bridge detach
Message-ID: <c5de5b1b921f0d7a2b6ca7a40e1dc8951dcc261b.1795132452.git.daniel@makrotopia.org>
References: <cover.1795132452.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1795132452.git.daniel@makrotopia.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DP AUX adapter is registered in .attach() but only unregistered
in i2c remove(). Unbinding and rebinding the DRM device while the
i2c driver stays bound registers the adapter a second time, which
fails. Also unregister it in .detach() and on the .attach() error
path, which so far leaked the registration. remove() keeps its call,
which waits for in-flight AUX device users before devres frees the
regmap.

Track the registration in a flag so that each path only unregisters
an adapter that is actually registered. A mutex serialises the flag,
so that remove() cannot return while .detach() is still waiting for
AUX device users. aux_lock cannot be reused for this, as AUX
transfers take it while drm_dp_aux_unregister() waits for them.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 33 ++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 9c4aae383c1c5..42fd24de9e147 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -439,6 +439,8 @@ struct it6505 {
 	struct mutex extcon_lock;
 	struct mutex mode_lock; /* used to bridge_detect */
 	struct mutex aux_lock; /* used to aux data transfers */
+	struct mutex aux_reg_lock; /* protects aux_registered */
+	bool aux_registered;
 	struct regmap *regmap;
 	struct drm_display_mode source_output_mode;
 	struct drm_display_mode video_info;
@@ -3069,6 +3071,29 @@ static inline struct it6505 *bridge_to_it6505(struct drm_bridge *bridge)
 	return container_of(bridge, struct it6505, bridge);
 }
 
+static int it6505_register_aux(struct it6505 *it6505)
+{
+	int ret;
+
+	mutex_lock(&it6505->aux_reg_lock);
+	ret = drm_dp_aux_register(&it6505->aux);
+	if (!ret)
+		it6505->aux_registered = true;
+	mutex_unlock(&it6505->aux_reg_lock);
+
+	return ret;
+}
+
+static void it6505_unregister_aux(struct it6505 *it6505)
+{
+	mutex_lock(&it6505->aux_reg_lock);
+	if (it6505->aux_registered) {
+		drm_dp_aux_unregister(&it6505->aux);
+		it6505->aux_registered = false;
+	}
+	mutex_unlock(&it6505->aux_reg_lock);
+}
+
 static int it6505_bridge_attach(struct drm_bridge *bridge,
 				struct drm_encoder *encoder,
 				enum drm_bridge_attach_flags flags)
@@ -3085,8 +3110,7 @@ static int it6505_bridge_attach(struct drm_bridge *bridge,
 	/* Register aux channel */
 	it6505->aux.drm_dev = bridge->dev;
 
-	ret = drm_dp_aux_register(&it6505->aux);
-
+	ret = it6505_register_aux(it6505);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register aux: %d", ret);
 		return ret;
@@ -3096,6 +3120,7 @@ static int it6505_bridge_attach(struct drm_bridge *bridge,
 		ret = it6505_use_notifier_module(it6505);
 		if (ret < 0) {
 			dev_err(dev, "use notifier module failed");
+			it6505_unregister_aux(it6505);
 			return ret;
 		}
 	}
@@ -3109,6 +3134,7 @@ static void it6505_bridge_detach(struct drm_bridge *bridge)
 
 	flush_work(&it6505->link_works);
 	it6505_remove_notifier_module(it6505);
+	it6505_unregister_aux(it6505);
 }
 
 static enum drm_mode_status
@@ -3573,6 +3599,7 @@ static int it6505_i2c_probe(struct i2c_client *client)
 	mutex_init(&it6505->extcon_lock);
 	mutex_init(&it6505->mode_lock);
 	mutex_init(&it6505->aux_lock);
+	mutex_init(&it6505->aux_reg_lock);
 
 	it6505->bridge.of_node = client->dev.of_node;
 	it6505->connector_status = connector_status_disconnected;
@@ -3655,7 +3682,7 @@ static void it6505_i2c_remove(struct i2c_client *client)
 	struct it6505 *it6505 = i2c_get_clientdata(client);
 
 	drm_bridge_remove(&it6505->bridge);
-	drm_dp_aux_unregister(&it6505->aux);
+	it6505_unregister_aux(it6505);
 	it6505_debugfs_remove(it6505);
 	it6505_remove_notifier_module(it6505);
 	disable_irq(it6505->irq);
-- 
2.56.1

