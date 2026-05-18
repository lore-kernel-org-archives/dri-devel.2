Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E034CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B157910E8C8;
	Mon, 18 May 2026 19:48:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sDYQ76uj";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A4E810E8C8
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1779133723; bh=FcxEYOPmNuM9yRHj6lWDMsbsVp/OdK4Trn0fMntUI3A=;
 b=sDYQ76ujyOD1FkLIDdVuzIaggQpJORblJYaEhQUK4EIR7AC9WR0O0pW9NcLlifD8FqH4Cd+Mo
 yXk1ezm7ixY2gv2y5+S2IkudWCrFaC0DKWXGWUKfzjoXUbxaGyCDb9Z0B4gSAecWdA+91wTzJg5
 gvsoPKSzQVGrqzqTE2oIlh/40gZEyjL3tRukKeYWorWguQTsPcPEy4CIWZxcSClAPFDGVlI2whq
 6xWDsT2pfS1VJwD+FVgrRMsrRKnHeJepTiQBuBiFE0/w9+ggzX1P3/RA3NMgc6yanshYX1i3SmC
 Ko8sTzT3SlqIkZ/DI3D/E2viYnBZ+5kybMNMu5/nergQ==
X-Forward-Email-ID: 6a0b6d02b74b0ebd362eeec6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org
Subject: [PATCH 06/13] drm/meson: encoder_hdmi: Use bridge connector CEC
 notifier
Date: Mon, 18 May 2026 19:47:34 +0000
Message-ID: <20260518194744.2483580-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518194744.2483580-1-jonas@kwiboo.se>
References: <20260518194744.2483580-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The dw-hdmi bridge detect() func now updates EDID and CEC phys addr for
the connector and any registered generic CEC notifier.

Replace the open-coded CEC notifier handling with use of the bridge CEC
notifier op.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/meson/Kconfig              |  1 +
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 85 +++++-----------------
 2 files changed, 19 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/meson/Kconfig b/drivers/gpu/drm/meson/Kconfig
index 417f79829cf8..0dc5ca21e4fc 100644
--- a/drivers/gpu/drm/meson/Kconfig
+++ b/drivers/gpu/drm/meson/Kconfig
@@ -13,6 +13,7 @@ config DRM_MESON
 	select REGMAP_MMIO
 	select MESON_CANVAS
 	select CEC_CORE if CEC_NOTIFIER
+	select DRM_DISPLAY_HDMI_CEC_NOTIFIER_HELPER if CEC_NOTIFIER
 
 config DRM_MESON_DW_HDMI
 	tristate "HDMI Synopsys Controller support for Amlogic Meson Display"
diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 1b9a1d9ed3d3..45104ef35344 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -16,8 +16,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
-#include <media/cec-notifier.h>
-
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
@@ -41,7 +39,6 @@ struct meson_encoder_hdmi {
 	struct drm_connector *connector;
 	struct meson_drm *priv;
 	unsigned long output_bus_fmt;
-	struct cec_notifier *cec_notifier;
 };
 
 #define bridge_to_meson_encoder_hdmi(x) \
@@ -57,14 +54,6 @@ static int meson_encoder_hdmi_attach(struct drm_bridge *bridge,
 				 &encoder_hdmi->bridge, flags);
 }
 
-static void meson_encoder_hdmi_detach(struct drm_bridge *bridge)
-{
-	struct meson_encoder_hdmi *encoder_hdmi = bridge_to_meson_encoder_hdmi(bridge);
-
-	cec_notifier_conn_unregister(encoder_hdmi->cec_notifier);
-	encoder_hdmi->cec_notifier = NULL;
-}
-
 static void meson_encoder_hdmi_set_vclk(struct meson_encoder_hdmi *encoder_hdmi,
 					const struct drm_display_mode *mode)
 {
@@ -321,27 +310,9 @@ static int meson_encoder_hdmi_atomic_check(struct drm_bridge *bridge,
 	return 0;
 }
 
-static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
-					  struct drm_connector *connector,
-					  enum drm_connector_status status)
-{
-	struct meson_encoder_hdmi *encoder_hdmi = bridge_to_meson_encoder_hdmi(bridge);
-
-	if (!encoder_hdmi->cec_notifier)
-		return;
-
-	if (status == connector_status_connected)
-		cec_notifier_set_phys_addr(encoder_hdmi->cec_notifier,
-					   connector->display_info.source_physical_address);
-	else
-		cec_notifier_phys_addr_invalidate(encoder_hdmi->cec_notifier);
-}
-
 static const struct drm_bridge_funcs meson_encoder_hdmi_bridge_funcs = {
 	.attach = meson_encoder_hdmi_attach,
-	.detach = meson_encoder_hdmi_detach,
 	.mode_valid = meson_encoder_hdmi_mode_valid,
-	.hpd_notify = meson_encoder_hdmi_hpd_notify,
 	.atomic_enable = meson_encoder_hdmi_atomic_enable,
 	.atomic_disable = meson_encoder_hdmi_atomic_disable,
 	.atomic_get_input_bus_fmts = meson_encoder_hdmi_get_inp_bus_fmts,
@@ -374,9 +345,9 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
 
 	meson_encoder_hdmi->bridge.next_bridge = of_drm_find_and_get_bridge(remote);
 	if (!meson_encoder_hdmi->bridge.next_bridge) {
-		ret = dev_err_probe(priv->dev, -EPROBE_DEFER,
-				    "Failed to find HDMI transceiver bridge\n");
-		goto err_put_node;
+		of_node_put(remote);
+		return dev_err_probe(priv->dev, -EPROBE_DEFER,
+				     "Failed to find HDMI transceiver bridge\n");
 	}
 
 	/* HDMI Encoder Bridge */
@@ -384,6 +355,13 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
 	meson_encoder_hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	meson_encoder_hdmi->bridge.interlace_allowed = true;
 
+	pdev = of_find_device_by_node(remote);
+	of_node_put(remote);
+	if (pdev) {
+		meson_encoder_hdmi->bridge.ops |= DRM_BRIDGE_OP_HDMI_CEC_NOTIFIER;
+		meson_encoder_hdmi->bridge.hdmi_cec_dev = &pdev->dev;
+	}
+
 	drm_bridge_add(&meson_encoder_hdmi->bridge);
 
 	meson_encoder_hdmi->priv = priv;
@@ -391,30 +369,24 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
 	/* Encoder */
 	ret = drm_simple_encoder_init(priv->drm, &meson_encoder_hdmi->encoder,
 				      DRM_MODE_ENCODER_TMDS);
-	if (ret) {
-		dev_err_probe(priv->dev, ret, "Failed to init HDMI encoder\n");
-		goto err_put_node;
-	}
+	if (ret)
+		return dev_err_probe(priv->dev, ret, "Failed to init HDMI encoder\n");
 
 	meson_encoder_hdmi->encoder.possible_crtcs = BIT(0);
 
 	/* Attach HDMI Encoder Bridge to Encoder */
 	ret = drm_bridge_attach(&meson_encoder_hdmi->encoder, &meson_encoder_hdmi->bridge, NULL,
 				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
-	if (ret) {
-		dev_err_probe(priv->dev, ret, "Failed to attach bridge\n");
-		goto err_put_node;
-	}
+	if (ret)
+		return dev_err_probe(priv->dev, ret, "Failed to attach bridge\n");
 
 	/* Initialize & attach Bridge Connector */
 	meson_encoder_hdmi->connector = drm_bridge_connector_init(priv->drm,
 							&meson_encoder_hdmi->encoder);
-	if (IS_ERR(meson_encoder_hdmi->connector)) {
-		ret = dev_err_probe(priv->dev,
-				    PTR_ERR(meson_encoder_hdmi->connector),
-				    "Unable to create HDMI bridge connector\n");
-		goto err_put_node;
-	}
+	if (IS_ERR(meson_encoder_hdmi->connector))
+		return dev_err_probe(priv->dev,
+				     PTR_ERR(meson_encoder_hdmi->connector),
+				     "Unable to create HDMI bridge connector\n");
 
 	/*
 	 * We should have now in place:
@@ -437,32 +409,11 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
 	/* Handle this here until handled by drm_bridge_connector_init() */
 	meson_encoder_hdmi->connector->ycbcr_420_allowed = true;
 
-	pdev = of_find_device_by_node(remote);
-	of_node_put(remote);
-	if (pdev) {
-		struct cec_connector_info conn_info;
-		struct cec_notifier *notifier;
-
-		cec_fill_conn_info_from_drm(&conn_info, meson_encoder_hdmi->connector);
-
-		notifier = cec_notifier_conn_register(&pdev->dev, NULL, &conn_info);
-		if (!notifier) {
-			put_device(&pdev->dev);
-			return -ENOMEM;
-		}
-
-		meson_encoder_hdmi->cec_notifier = notifier;
-	}
-
 	priv->encoders[MESON_ENC_HDMI] = meson_encoder_hdmi;
 
 	dev_dbg(priv->dev, "HDMI encoder initialized\n");
 
 	return 0;
-
-err_put_node:
-	of_node_put(remote);
-	return ret;
 }
 
 void meson_encoder_hdmi_remove(struct meson_drm *priv)
-- 
2.54.0

