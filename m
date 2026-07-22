Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE50C4453E
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E565010EE33;
	Wed, 22 Jul 2026 15:46:03 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31D310EE33
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 15:46:03 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wmZ8v-000000006ba-2fbo; Wed, 22 Jul 2026 15:45:57 +0000
Date: Wed, 22 Jul 2026 16:45:54 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>,
 Pin-yen Lin <treapking@chromium.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v5 03/11] drm/bridge: it6505: unregister DP AUX adapter on
 bridge detach
Message-ID: <a472535bc291e77aee5cae71ea2a26d695511fd6.1784717129.git.daniel@makrotopia.org>
References: <cover.1784717129.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784717129.git.daniel@makrotopia.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The DP AUX adapter is registered in .attach() but only unregistered
in i2c remove(). Unbinding and rebinding the DRM device while the
i2c driver stays bound registers the adapter a second time, which
fails. Unregister it in .detach() instead, and also on the .attach()
error path, which so far leaked the registration.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5: new patch

 drivers/gpu/drm/bridge/ite-it6505.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 6fcf2dc03d16..ff6471d3ef7a 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3091,6 +3091,7 @@ static int it6505_bridge_attach(struct drm_bridge *bridge,
 		ret = it6505_use_notifier_module(it6505);
 		if (ret < 0) {
 			dev_err(dev, "use notifier module failed");
+			drm_dp_aux_unregister(&it6505->aux);
 			return ret;
 		}
 	}
@@ -3104,6 +3105,7 @@ static void it6505_bridge_detach(struct drm_bridge *bridge)
 
 	flush_work(&it6505->link_works);
 	it6505_remove_notifier_module(it6505);
+	drm_dp_aux_unregister(&it6505->aux);
 }
 
 static enum drm_mode_status
@@ -3652,7 +3654,6 @@ static void it6505_i2c_remove(struct i2c_client *client)
 	struct it6505 *it6505 = i2c_get_clientdata(client);
 
 	drm_bridge_remove(&it6505->bridge);
-	drm_dp_aux_unregister(&it6505->aux);
 	it6505_debugfs_remove(it6505);
 	it6505_remove_notifier_module(it6505);
 	disable_irq(it6505->irq);
-- 
2.55.0
