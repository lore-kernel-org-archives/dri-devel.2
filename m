Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F359C624DE
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6E910EE8D;
	Tue,  1 Sep 2026 18:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="TbRf/D8l";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A5810EE7D
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288691;
 bh=2galnbkpG9rUKXb4RYIAo4kg/YAursFyYrkk89icIw8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=TbRf/D8lucN+Kde6yjwFOook2HCRfHFpJxY143FIc0CWD5JTvTVQ+7DVHcloM4ntW
 ZDUMdmCXJWY/0lLcWJfARV9j8UC5+70DvtAMALVE3lxdz3fqbfDyO9gNTcXnMuYSnY
 Jy2BDYg4BarABZ87/XojaSjp7LKVXqzISo6lKKJ9Etsoi6dC24J7GfWcrkxntT/c4P
 lLwjq//pKU7FXnbdZfyiJR3Uksq5iB28InWH4ohbpV17ndTg3UV1f3kMP/8W+/OhkJ
 eByTQa+iF8vls241JiUDm623IHar8dS36K1HOdpD4ql3dRFYNrETj19P+j1KjJGArJ
 BrO24pzp1ScWA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2349C17E3C9D;
 Tue, 01 Sep 2026 20:51:31 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:32 +0300
Subject: [PATCH v11 68/74] drm/connector: Remove drmm_connector_hdmi_ini2()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-68-bc12954a0688@collabora.com>
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
 linux-fbdev@vger.kernel.org, Diederik de Haas <diederik@cknow-tech.com>
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

All callers have been converted to the new drmm_connector_hdmi_init()
signature.  Remove the transitional drmm_connector_hdmi_ini2() function,
its declaration, its EXPORT_SYMBOL() and its kernel-doc.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 106 ----------------------------------------
 include/drm/drm_connector.h     |   9 ----
 2 files changed, 115 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index d94c86bfed86..c9540d58719a 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -686,112 +686,6 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drmm_connector_hdmi_init);
 
-/**
- * drmm_connector_hdmi_ini2 - Init a preallocated HDMI connector
- * @dev: DRM device
- * @connector: A pointer to the HDMI connector to init
- * @vendor: HDMI Controller Vendor name
- * @product: HDMI Controller Product name
- * @funcs: callbacks for this connector
- * @hdmi_funcs: HDMI-related callbacks for this connector
- * @connector_type: user visible type of the connector
- * @ddc: optional pointer to the associated ddc adapter
- * @supported_formats: Bitmask of @drm_output_color_format listing supported output formats
- * @max_bpc: Maximum bits per char the HDMI connector supports
- *
- * Initialises a preallocated HDMI connector. Connectors can be
- * subclassed as part of driver connector objects.
- *
- * Cleanup is automatically handled with a call to
- * drm_connector_cleanup() in a DRM-managed action.
- *
- * The connector structure should be allocated with drmm_kzalloc().
- *
- * The @drm_connector_funcs.destroy hook must be NULL.
- *
- * Returns:
- * Zero on success, error code on failure.
- */
-int drmm_connector_hdmi_ini2(struct drm_device *dev,
-			     struct drm_connector *connector,
-			     const char *vendor, const char *product,
-			     const struct drm_connector_funcs *funcs,
-			     const struct drm_connector_hdmi_funcs *hdmi_funcs,
-			     int connector_type,
-			     struct i2c_adapter *ddc,
-			     unsigned long supported_formats,
-			     unsigned int max_bpc)
-{
-	int ret;
-
-	if (!vendor || !product)
-		return -EINVAL;
-
-	if ((strlen(vendor) > DRM_CONNECTOR_HDMI_VENDOR_LEN) ||
-	    (strlen(product) > DRM_CONNECTOR_HDMI_PRODUCT_LEN))
-		return -EINVAL;
-
-	if (!(connector_type == DRM_MODE_CONNECTOR_HDMIA ||
-	      connector_type == DRM_MODE_CONNECTOR_HDMIB))
-		return -EINVAL;
-
-	if (!supported_formats || !(supported_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444)))
-		return -EINVAL;
-
-	if (connector->ycbcr_420_allowed != !!(supported_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420)))
-		return -EINVAL;
-
-	if (!(max_bpc == 8 || max_bpc == 10 || max_bpc == 12))
-		return -EINVAL;
-
-	if (!hdmi_funcs->avi.clear_infoframe ||
-	    !hdmi_funcs->avi.write_infoframe ||
-	    !hdmi_funcs->hdmi.clear_infoframe ||
-	    !hdmi_funcs->hdmi.write_infoframe)
-		return -EINVAL;
-
-	ret = drmm_connector_init(dev, connector, funcs, connector_type, ddc);
-	if (ret)
-		return ret;
-
-	connector->hdmi.supported_formats = supported_formats;
-	strtomem_pad(connector->hdmi.vendor, vendor, 0);
-	strtomem_pad(connector->hdmi.product, product, 0);
-
-	/*
-	 * drm_connector_attach_max_bpc_property() requires the
-	 * connector to have a state.
-	 */
-	if (connector->funcs->atomic_create_state) {
-		struct drm_connector_state *state;
-
-		state = connector->funcs->atomic_create_state(connector);
-		if (IS_ERR(state))
-			return PTR_ERR(state);
-
-		connector->state = state;
-	} else if (connector->funcs->reset) {
-		connector->funcs->reset(connector);
-		if (!connector->state)
-			return -ENOMEM;
-	}
-
-	drm_connector_attach_max_bpc_property(connector, 8, max_bpc);
-	connector->max_bpc = max_bpc;
-
-	if (max_bpc > 8)
-		drm_connector_attach_hdr_output_metadata_property(connector);
-
-	ret = drm_connector_attach_color_format_property(connector, supported_formats);
-	if (ret)
-		return ret;
-
-	connector->hdmi.funcs = hdmi_funcs;
-
-	return 0;
-}
-EXPORT_SYMBOL(drmm_connector_hdmi_ini2);
-
 /**
  * drm_connector_attach_edid_property - attach edid property.
  * @connector: the connector
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aa..d62a79b9699a 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2743,15 +2743,6 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 			     const struct drm_connector_hdmi_funcs *hdmi_funcs,
 			     int connector_type,
 			     struct i2c_adapter *ddc);
-int drmm_connector_hdmi_ini2(struct drm_device *dev,
-			     struct drm_connector *connector,
-			     const char *vendor, const char *product,
-			     const struct drm_connector_funcs *funcs,
-			     const struct drm_connector_hdmi_funcs *hdmi_funcs,
-			     int connector_type,
-			     struct i2c_adapter *ddc,
-			     unsigned long supported_formats,
-			     unsigned int max_bpc);
 void drm_connector_attach_edid_property(struct drm_connector *connector);
 int drm_connector_register(struct drm_connector *connector);
 int drm_connector_dynamic_register(struct drm_connector *connector);

-- 
2.55.0

