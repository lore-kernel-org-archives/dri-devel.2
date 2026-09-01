Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E49AC624D6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9BFA10EE1A;
	Tue,  1 Sep 2026 18:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Nyekdahj";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE8110EE26
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288645;
 bh=aCPsNOXneAIWZwZ2Fba20yR834SGq+o+OAWbOT7jfnw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=NyekdahjMqreSFz57eZFvAZfwcP9BLiuyXSCkR9r1ZyMyPaC+ALo4+ULYJxzOBQ7R
 lzhAEzwj9DeBnMetEg6+9mCvyWKL1auQQSCOQA3YDintaoXN1JKCf9WbbqTQeN0BjS
 ZxNiN66FOeMX+I65hBnQDPxWnIJ0CzPmSgjznSJHmCPQMiHP3EgmQ9ZSSEmKn2hq4j
 qtz6ZXgS8xTcUnXVu5BnMaT40HPwPr7ts1sWxkmpDsIcfQfUPoT0wfZSds+S6A+vsB
 t532E6iOmrRKYWTfeVPgurA+3H4+tSalolkHSDVQ1An5xb19FecljO7oacYu//+wxp
 gh2cw9GJY2VGw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D57C517E0FCC;
 Tue, 01 Sep 2026 20:50:44 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:29 +0300
Subject: [PATCH v11 05/74] drm/display: bridge_connector: Convert to
 drmm_connector_hdmi_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-5-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org, Maud Spierings <maud_spierings@hotmail.com>, 
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

Switch drm_bridge_connector to the new drmm_connector_hdmi_init()
signature.  The vendor, product, supported_formats and max_bpc values
now live in struct drm_connector_hdmi_funcs instead of being passed as
separate arguments.  This allows future HDMI 2.x capabilities to be
plumbed without growing the function's argument list.

Introduce the supported_hdmi_ver field in struct drm_bridge to let
bridges declare the HDMI specification version they comply with,
as well as max_tmds_char_rate to allow them to override the limit
inferred from that version.  This is particularly useful when handling
chip variants with different capabilities.

Additionally, add a warning in drm_bridge_add() if an HDMI bridge leaves
supported_hdmi_ver unset.  This alerts bridge drivers setting the
DRM_BRIDGE_OP_HDMI flag that they must also declare their supported HDMI
version.

Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 43 ++++++++++++++++----------
 drivers/gpu/drm/drm_bridge.c                   |  6 +++-
 include/drm/drm_bridge.h                       | 14 +++++++++
 3 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index d664237936ec..63cdc6eab132 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -593,6 +593,8 @@ drm_bridge_connector_read_edid(struct drm_connector *connector)
 }
 
 static const struct drm_connector_hdmi_funcs drm_bridge_connector_hdmi_funcs = {
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
 	.tmds_char_rate_valid = drm_bridge_connector_tmds_char_rate_valid,
 	.read_edid = drm_bridge_connector_read_edid,
 	.avi = {
@@ -826,8 +828,6 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	struct drm_connector *connector;
 	struct i2c_adapter *ddc = NULL;
 	struct drm_bridge *panel_bridge __free(drm_bridge_put) = NULL;
-	unsigned int supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
-	unsigned int max_bpc = 8;
 	bool support_hdcp = false;
 	int connector_type;
 	int ret;
@@ -910,11 +910,6 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 				return ERR_PTR(-EINVAL);
 
 			bridge_connector->bridge_hdmi = drm_bridge_get(bridge);
-
-			if (bridge->supported_formats)
-				supported_formats = bridge->supported_formats;
-			if (bridge->max_bpc)
-				max_bpc = bridge->max_bpc;
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_AUDIO) {
@@ -996,11 +991,31 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		return ERR_PTR(-EINVAL);
 
 	if (bridge_connector->bridge_hdmi) {
-		if (!connector->ycbcr_420_allowed)
-			supported_formats &= ~BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
-
 		bridge_connector->hdmi_funcs = drm_bridge_connector_hdmi_funcs;
 
+		bridge_connector->hdmi_funcs.vendor = bridge_connector->bridge_hdmi->vendor;
+		bridge_connector->hdmi_funcs.product = bridge_connector->bridge_hdmi->product;
+
+		if (bridge_connector->bridge_hdmi->supported_hdmi_ver)
+			bridge_connector->hdmi_funcs.supported_hdmi_ver =
+				bridge_connector->bridge_hdmi->supported_hdmi_ver;
+
+		if (bridge_connector->bridge_hdmi->supported_formats)
+			bridge_connector->hdmi_funcs.supported_formats =
+				bridge_connector->bridge_hdmi->supported_formats;
+
+		if (!connector->ycbcr_420_allowed)
+			bridge_connector->hdmi_funcs.supported_formats &=
+				~BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
+
+		if (bridge_connector->bridge_hdmi->max_tmds_char_rate)
+			bridge_connector->hdmi_funcs.supported_tmds_char_rate =
+				bridge_connector->bridge_hdmi->max_tmds_char_rate;
+
+		if (bridge_connector->bridge_hdmi->max_bpc)
+			bridge_connector->hdmi_funcs.max_bpc =
+				bridge_connector->bridge_hdmi->max_bpc;
+
 		if (bridge_connector->bridge_hdmi->ops & DRM_BRIDGE_OP_HDMI_AUDIO)
 			bridge_connector->hdmi_funcs.audio =
 				drm_bridge_connector_hdmi_audio_infoframe;
@@ -1013,14 +1028,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			bridge_connector->hdmi_funcs.spd =
 				drm_bridge_connector_hdmi_spd_infoframe;
 
-		ret = drmm_connector_hdmi_ini2(drm, connector,
-					       bridge_connector->bridge_hdmi->vendor,
-					       bridge_connector->bridge_hdmi->product,
+		ret = drmm_connector_hdmi_init(drm, connector,
 					       &drm_bridge_connector_funcs,
 					       &bridge_connector->hdmi_funcs,
-					       connector_type, ddc,
-					       supported_formats,
-					       max_bpc);
+					       connector_type, ddc);
 		if (ret)
 			return ERR_PTR(ret);
 	} else {
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 83f1809a5d37..afaae272347c 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -460,9 +460,13 @@ void drm_bridge_add(struct drm_bridge *bridge)
 	mutex_init(&bridge->hpd_state_mutex);
 	mutex_init(&bridge->hpd_mutex);
 
-	if (bridge->ops & DRM_BRIDGE_OP_HDMI)
+	if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
+		if (bridge->supported_hdmi_ver == HDMI_VERSION_UNKNOWN)
+			DRM_WARN("HDMI bridge misses supported HDMI version\n");
+
 		bridge->ycbcr_420_allowed = !!(bridge->supported_formats &
 					       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
+	}
 
 	mutex_lock(&bridge_lock);
 	list_add_tail(&bridge->list, &bridge_list);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 58fff047f43b..5a5a25995471 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1081,6 +1081,12 @@ struct drm_bridge {
 	 */
 	const char *product;
 
+	/**
+	 * @supported_hdmi_ver: HDMI version the bridge is conformant with.
+	 * This is only relevant if @DRM_BRIDGE_OP_HDMI is set.
+	 */
+	enum hdmi_version supported_hdmi_ver;
+
 	/**
 	 * @supported_formats: Bitmask of @drm_output_color_format listing
 	 * supported output formats. This is only relevant if
@@ -1088,6 +1094,14 @@ struct drm_bridge {
 	 */
 	unsigned int supported_formats;
 
+	/**
+	 * @max_tmds_char_rate: Maximum TMDS character rate, in Hz, the HDMI
+	 * bridge supports. A value of 0 means the core should use the default
+	 * limit implied by @supported_hdmi_ver. This is only relevant if
+	 * @DRM_BRIDGE_OP_HDMI is set.
+	 */
+	unsigned long long max_tmds_char_rate;
+
 	/**
 	 * @max_bpc: Maximum bits per char the HDMI bridge supports. Allowed
 	 * values are 8, 10 and 12. This is only relevant if

-- 
2.55.0

