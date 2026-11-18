Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2541460A2613
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=J/xp2jZq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E8010FE81;
	Wed, 18 Nov 2026 16:51:53 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CEB10FE88
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:51:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 041FA1A16CA;
 Wed, 18 Nov 2026 16:51:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C7B035FE9B;
 Wed, 18 Nov 2026 16:51:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7677511BC28C8; Wed, 18 Nov 2026 17:51:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795020693; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dWxfOxs6Q0dpbo4RjDNuIDxsM7SkDxHUe3z8fq4Q1kY=;
 b=J/xp2jZquTe/vOWqVCmtWy9eaF6Mfv6x/+hq/4vcEivdM9AVG1LNAsrPXT7PhT3MXBo6Gs
 z1RU4KRAqWkY+Pgfbgpuqrcr2pCUjoBTfadAW1a6V+3Xv/sPDL41q1FOtLNI6yNJRkthLv
 +XJyvOI8ddPi838LQpe+OwzaWz2TxVKppoAzg7nH4/Qys2KwGyY7+ydSBZMVpCJWi/Ov2Z
 kOHGlSkEwaypk/x2hQn6Nk+b/CxZdVdl2CC4+AWDW7MjOR05WvGLefkP1l8+mThEr3Hujz
 O3mQJ23axbxKs/tl01yTckTEGChiB3GtX4d8onB/3e2YgJd8a9lhOsoEJNN6oQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 18 Nov 2026 17:49:57 +0100
Subject: [PATCH RFC v3 14/31] drm/bridge: ti-sn65dsi86: protect device
 resources on unplug
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-drm-bridge-hotplug-v3-14-44bb3b4a828f@bootlin.com>
References: <20261118-drm-bridge-hotplug-v3-0-44bb3b4a828f@bootlin.com>
In-Reply-To: <20261118-drm-bridge-hotplug-v3-0-44bb3b4a828f@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To support hot-unplug of this bridge we need to protect access to device
resources in case device removal happens concurrently to other code.

Some care is needed for the case when drm_bridge_unplug() happens before
ti_sn_bridge_atomic_post_disable(), so the latter cannot release supplier
resources taken by ti_sn_bridge_atomic_pre_enable(): runtime PM (and in
turn regulators) and refclk.

To ensure those resources are released exactly once on device removal:

 * move the code to release them to a dedicated function
 * register that function when the resources are taken in
   ti_sn_bridge_atomic_pre_enable()
 * if ti_sn_bridge_atomic_post_disable() happens before drm_bridge_unplug()
   (typical non-hot-unplug case):
   * ti_sn_bridge_atomic_post_disable() can enter the critical section
     (drm_bridge_enter() returns 0) -> it releases and executes the
     devres action
 * if ti_sn_bridge_atomic_post_disable() happens after drm_bridge_unplug()
   (typical hot-unplug case):
   * ti_sn_bridge_remove() -> drm_bridge_unplug() defuses
     ti_sn_bridge_atomic_post_disable() so it cannot execute the devres
     action
   * the devres action is executed just after ti_sn_bridge_remove()

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

New patch in v3

This commit basically replicates the same change done on the ti-sn65dsi83
driver, now upstream:
https://lore.kernel.org/all/20251112-drm-bridge-atomic-vs-remove-v3-2-85db717ce094@bootlin.com/
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 50 ++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 4fd9fde77d2b..75e36bf261b0 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -852,9 +852,15 @@ static void ti_sn_bridge_atomic_disable(struct drm_bridge *bridge,
 					struct drm_atomic_commit *state)
 {
 	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
 
 	/* disable video stream */
 	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABLE, 0);
+
+	drm_bridge_exit(idx);
 }
 
 static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata,
@@ -1124,11 +1130,16 @@ static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
 	int ret = -EINVAL;
 	int max_dp_lanes;
 	unsigned int bpp;
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
 
 	connector = drm_atomic_get_new_connector_for_encoder(state,
 							     bridge->encoder);
 	if (!connector) {
 		dev_err_ratelimited(pdata->dev, "Could not get the connector\n");
+		drm_bridge_exit(idx);
 		return;
 	}
 
@@ -1206,6 +1217,7 @@ static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
 	}
 	if (ret) {
 		DRM_DEV_ERROR(pdata->dev, "%s (%d)\n", last_err_str, ret);
+		drm_bridge_exit(idx);
 		return;
 	}
 
@@ -1215,26 +1227,57 @@ static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
 	/* enable video stream */
 	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABLE,
 			   VSTREAM_ENABLE);
+
+	drm_bridge_exit(idx);
+}
+
+/*
+ * Release resources taken by ti_sn_bridge_atomic_pre_enable().
+ *
+ * Invoked by ti_sn_bridge_atomic_post_disable() normally, or by devres
+ * after ti_sn_bridge_remove() in case this happens befora
+ * atomic_post_disable.
+ */
+static void ti_sn_bridge_release_resources(void *data)
+{
+	struct ti_sn65dsi86 *pdata = (struct ti_sn65dsi86 *)data;
+
+	if (!pdata->refclk)
+		ti_sn65dsi86_disable_comms(pdata);
+
+	pm_runtime_put_sync(pdata->dev);
 }
 
 static void ti_sn_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 					   struct drm_atomic_commit *state)
 {
 	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
 
 	pm_runtime_get_sync(pdata->dev);
 
 	if (!pdata->refclk)
 		ti_sn65dsi86_enable_comms(pdata, state);
 
+	devm_add_action(pdata->dev, ti_sn_bridge_release_resources, pdata);
+
 	/* td7: min 100 us after enable before DSI data */
 	usleep_range(100, 110);
+
+	drm_bridge_exit(idx);
 }
 
 static void ti_sn_bridge_atomic_post_disable(struct drm_bridge *bridge,
 					     struct drm_atomic_commit *state)
 {
 	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
 
 	/* semi auto link training mode OFF */
 	regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0);
@@ -1243,10 +1286,9 @@ static void ti_sn_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	/* disable DP PLL */
 	regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 0);
 
-	if (!pdata->refclk)
-		ti_sn65dsi86_disable_comms(pdata);
+	devm_release_action(pdata->dev, ti_sn_bridge_release_resources, pdata);
 
-	pm_runtime_put_sync(pdata->dev);
+	drm_bridge_exit(idx);
 }
 
 static enum drm_connector_status
@@ -1514,7 +1556,7 @@ static void ti_sn_bridge_remove(struct auxiliary_device *adev)
 	if (!pdata)
 		return;
 
-	drm_bridge_remove(&pdata->bridge);
+	drm_bridge_unplug(&pdata->bridge);
 
 	of_node_put(pdata->host_node);
 }

-- 
2.56.1

