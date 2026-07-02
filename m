Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752FAC44501
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55ED310F411;
	Thu,  2 Jul 2026 14:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bYq/jjt9";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A50D10F3F7
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783003593;
 bh=62ezjJKvz2Gj85vyfh7W4AzrLamHIuxXzzUjS74+Ghc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bYq/jjt9r9MtH8Dwz2pb+EeIhzs0/CjIo3T/JJNwsJC1HlwPZ18I58N5TWQJd7Mkf
 h21TY58DEF71aQ/moPJhayGzmMeU3ew1NBSL/KswPvDzfmRPmmq/UC1RpULwxaQ0/l
 xErtsKSyjkZCJNitGDt8rIYrtZKRw1HPKN32RSBIxz7jHKLmXPYF7xIBGj4MaWi1mZ
 twjacVNEpCrSW2DCNy3hX01KjYNOREVH1efkwXfPVd6cOV6H0SkeQl4NvyUxrgrTVo
 UfZunXPEs3DBQtCq26wghRKkHNdS3g36XuNvlACFV+iIRBjZHFGAHmsOB33ZxgAP2n
 poluuGHqZRBFA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B5B5117E0FAA;
 Thu,  2 Jul 2026 16:46:33 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 02 Jul 2026 17:46:16 +0300
Subject: [PATCH v8 03/39] drm/display: bridge_connector: Pass HDMI
 capabilities through caps struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dw-hdmi-qp-scramb-v8-3-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
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

Switch drm_bridge_connector_init() to
drmm_connector_hdmi_init_with_caps(), collecting the bridge's HDMI
properties into a stack drm_connector_hdmi_caps so future HDMI 2.x
capabilities can be plumbed without growing the argument list.

Introduce struct drm_bridge::supported_hdmi_ver to let bridges declare
the HDMI specification version they are conformant with, and forward it
to the connector layer through the new caps struct so HDMI 2.x features
can be gated on real source capability rather than guesswork.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 29 ++++++++++++++------------
 include/drm/drm_bridge.h                       |  6 ++++++
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 92f8a2d7aab4..796069dbf1a1 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -823,8 +823,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	struct drm_connector *connector;
 	struct i2c_adapter *ddc = NULL;
 	struct drm_bridge *panel_bridge __free(drm_bridge_put) = NULL;
-	unsigned int supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
-	unsigned int max_bpc = 8;
+	struct drm_connector_hdmi_caps caps = {
+		.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+		.max_bpc = 8,
+	};
 	bool support_hdcp = false;
 	int connector_type;
 	int ret;
@@ -885,6 +887,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
 			if (bridge_connector->bridge_hdmi)
 				return ERR_PTR(-EBUSY);
+
 			if (!bridge->funcs->hdmi_write_avi_infoframe ||
 			    !bridge->funcs->hdmi_clear_avi_infoframe ||
 			    !bridge->funcs->hdmi_write_hdmi_infoframe ||
@@ -908,10 +911,12 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 			bridge_connector->bridge_hdmi = drm_bridge_get(bridge);
 
+			if (bridge->supported_hdmi_ver)
+				caps.supported_hdmi_ver = bridge->supported_hdmi_ver;
 			if (bridge->supported_formats)
-				supported_formats = bridge->supported_formats;
+				caps.supported_formats = bridge->supported_formats;
 			if (bridge->max_bpc)
-				max_bpc = bridge->max_bpc;
+				caps.max_bpc = bridge->max_bpc;
 		}
 
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI_AUDIO) {
@@ -994,7 +999,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 	if (bridge_connector->bridge_hdmi) {
 		if (!connector->ycbcr_420_allowed)
-			supported_formats &= ~BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
+			caps.supported_formats &= ~BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
 
 		bridge_connector->hdmi_funcs = drm_bridge_connector_hdmi_funcs;
 
@@ -1010,14 +1015,12 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			bridge_connector->hdmi_funcs.spd =
 				drm_bridge_connector_hdmi_spd_infoframe;
 
-		ret = drmm_connector_hdmi_init(drm, connector,
-					       bridge_connector->bridge_hdmi->vendor,
-					       bridge_connector->bridge_hdmi->product,
-					       &drm_bridge_connector_funcs,
-					       &bridge_connector->hdmi_funcs,
-					       connector_type, ddc,
-					       supported_formats,
-					       max_bpc);
+		ret = drmm_connector_hdmi_init_with_caps(drm, connector,
+							 bridge_connector->bridge_hdmi->vendor,
+							 bridge_connector->bridge_hdmi->product,
+							 &drm_bridge_connector_funcs,
+							 &bridge_connector->hdmi_funcs,
+							 connector_type, ddc, &caps);
 		if (ret)
 			return ERR_PTR(ret);
 	} else {
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 18f3db367dc1..2d8b5e4c64ba 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1176,6 +1176,12 @@ struct drm_bridge {
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

-- 
2.54.0

