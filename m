Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F50C5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F03310F31C;
	Fri, 31 Jul 2026 16:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="J3MWfpfP";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F66210F307
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514774;
 bh=F/ORXJLv87LmKmtOIy0lgbR5TcfqZIJa8uHK88OlK5U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=J3MWfpfPXI9l7szvDtMyKjDWsaxejYvAiwBFMRED/dY0sfSoK4zESg19H5Jrg3inw
 FtQW2ZehMvrQeTNrPShmo8xWH6Ny/M9+N/7C6pd7YnG6zGHguLrQJCwfbztEH7/vV3
 wsjDLy7Hx/u0HWVVkDy8Rm4jVTKRrLCTlyjla5IlkeQy4cflbq8fSt5MJV11ZeaMhr
 5r/mlVLjQEJIC2je7u8+wToI9nakvpohcnjj+EFc/3Lgf58M6aDZtGWUVNnywVbxUR
 0Me6z/MkhkfACpyVwm6tt32/nLa90n8JfSzPrbitqpiopxtGt3H+iMopVjGb58GzJT
 pVwhbTo6j624Q==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 26D4A17E095D;
 Fri, 31 Jul 2026 18:19:34 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:19:34 +0300
Subject: [PATCH v10 27/69] drm/bridge: dw-hdmi-qp: Add HDMI 2.0 scrambling
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-27-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 Maud Spierings <maud_spierings@hotmail.com>, 
 Diederik de Haas <diederik@cknow-tech.com>
X-Mailer: b4 0.15.2
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

Add support for SCDC scrambling and the high TMDS clock ratio required
by HDMI 2.0 modes with TMDS character rates above 340 MHz, such as
4K@60Hz.

Hook the bridge into the DRM HDMI connector scrambling helpers so the
sink-side SCDC state and the controller scrambler are updated together
as part of the atomic enable and disable paths.  This allows the driver
to advertise HDMI 2.0 support when HPD is available.

Keep no-HPD configurations limited to HDMI 1.4, since SCDC access
requires a connected HDMI sink.

Modes above the HDMI 2.0 600 MHz TMDS character-rate limit are now
implicitly rejected by the DRM HDMI connector/bridge infrastructure,
making the dw_hdmi_qp_bridge_tmds_char_rate_valid() callback redundant.
Drop it.

Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Acked-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 60 ++++++++++++++++++----------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 246c4161e627..ee74266b7aa9 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2021-2022 Rockchip Electronics Co., Ltd.
  * Copyright (c) 2024 Collabora Ltd.
+ * Copyright (c) 2025 Amazon.com, Inc. or its affiliates.
  *
  * Author: Algea Cao <algea.cao@rock-chips.com>
  * Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
@@ -751,6 +752,7 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
 	struct drm_connector_state *conn_state;
 	struct drm_connector *connector;
 	unsigned int op_mode;
+	int ret;
 
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	if (WARN_ON(!connector))
@@ -761,14 +763,20 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
 		return;
 
 	if (connector->display_info.is_hdmi) {
-		dev_dbg(hdmi->dev, "%s mode=HDMI %s rate=%llu bpc=%u\n", __func__,
-			drm_hdmi_connector_get_output_format_name(conn_state->hdmi.output_format),
-			conn_state->hdmi.tmds_char_rate, conn_state->hdmi.output_bpc);
 		op_mode = 0;
 		hdmi->tmds_char_rate = conn_state->hdmi.tmds_char_rate;
+
+		ret = drm_connector_hdmi_enable_scrambling(connector, conn_state);
+		if (ret)
+			dev_warn(hdmi->dev, "Failed to enable scrambling: %d\n", ret);
+
+		dev_dbg(hdmi->dev, "%s mode=HDMI %s rate=%llu bpc=%u scramb=%d\n", __func__,
+			drm_hdmi_connector_get_output_format_name(conn_state->hdmi.output_format),
+			conn_state->hdmi.tmds_char_rate, conn_state->hdmi.output_bpc,
+			connector->hdmi.scrambler_enabled);
 	} else {
-		dev_dbg(hdmi->dev, "%s mode=DVI\n", __func__);
 		op_mode = OPMODE_DVI;
+		dev_dbg(hdmi->dev, "%s mode=DVI\n", __func__);
 	}
 
 	hdmi->phy.ops->init(hdmi, hdmi->phy.data);
@@ -783,9 +791,13 @@ static void dw_hdmi_qp_bridge_atomic_disable(struct drm_bridge *bridge,
 					     struct drm_atomic_commit *state)
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
+	struct drm_connector *connector;
 
 	hdmi->tmds_char_rate = 0;
 
+	connector = drm_atomic_get_old_connector_for_encoder(state, bridge->encoder);
+	drm_connector_hdmi_disable_scrambling(connector);
+
 	hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
 }
 
@@ -820,24 +832,24 @@ dw_hdmi_qp_bridge_edid_read(struct drm_bridge *bridge,
 	return drm_edid;
 }
 
-static enum drm_mode_status
-dw_hdmi_qp_bridge_tmds_char_rate_valid(const struct drm_bridge *bridge,
-				       const struct drm_display_mode *mode,
-				       unsigned long long rate)
+static int dw_hdmi_qp_bridge_scrambler_enable(struct drm_bridge *bridge)
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
-	/*
-	 * TODO: when hdmi->no_hpd is 1 we must not support modes that
-	 * require scrambling, including every mode with a clock above
-	 * HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ.
-	 */
-	if (rate > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ) {
-		dev_dbg(hdmi->dev, "Unsupported TMDS char rate: %lld\n", rate);
-		return MODE_CLOCK_HIGH;
-	}
+	dw_hdmi_qp_write(hdmi, 1, SCRAMB_CONFIG0);
+	dev_dbg(hdmi->dev, "scrambler enabled\n");
 
-	return MODE_OK;
+	return 0;
+}
+
+static int dw_hdmi_qp_bridge_scrambler_disable(struct drm_bridge *bridge)
+{
+	struct dw_hdmi_qp *hdmi = bridge->driver_private;
+
+	dw_hdmi_qp_write(hdmi, 0, SCRAMB_CONFIG0);
+	dev_dbg(hdmi->dev, "scrambler disabled\n");
+
+	return 0;
 }
 
 static int dw_hdmi_qp_bridge_clear_avi_infoframe(struct drm_bridge *bridge)
@@ -1213,7 +1225,8 @@ static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs = {
 	.hpd_enable = dw_hdmi_qp_bridge_hpd_enable,
 	.hpd_disable = dw_hdmi_qp_bridge_hpd_disable,
 	.edid_read = dw_hdmi_qp_bridge_edid_read,
-	.hdmi_tmds_char_rate_valid = dw_hdmi_qp_bridge_tmds_char_rate_valid,
+	.hdmi_scrambler_enable = dw_hdmi_qp_bridge_scrambler_enable,
+	.hdmi_scrambler_disable = dw_hdmi_qp_bridge_scrambler_disable,
 	.hdmi_clear_avi_infoframe = dw_hdmi_qp_bridge_clear_avi_infoframe,
 	.hdmi_write_avi_infoframe = dw_hdmi_qp_bridge_write_avi_infoframe,
 	.hdmi_clear_hdmi_infoframe = dw_hdmi_qp_bridge_clear_hdmi_infoframe,
@@ -1341,13 +1354,18 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
 			   DRM_BRIDGE_OP_HDMI_AUDIO |
 			   DRM_BRIDGE_OP_HDMI_HDR_DRM_INFOFRAME |
 			   DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME;
-	if (!hdmi->no_hpd)
-		hdmi->bridge.ops |= DRM_BRIDGE_OP_HPD;
 	hdmi->bridge.of_node = pdev->dev.of_node;
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	hdmi->bridge.vendor = "Synopsys";
 	hdmi->bridge.product = "DW HDMI QP TX";
 
+	if (hdmi->no_hpd) {
+		hdmi->bridge.supported_hdmi_ver = HDMI_VERSION_1_4;
+	} else {
+		hdmi->bridge.supported_hdmi_ver = HDMI_VERSION_2_0;
+		hdmi->bridge.ops |= DRM_BRIDGE_OP_HPD;
+	}
+
 	if (plat_data->supported_formats)
 		hdmi->bridge.supported_formats = plat_data->supported_formats;
 

-- 
2.55.0

