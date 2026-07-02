Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C87C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE9310F410;
	Thu,  2 Jul 2026 14:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WPsB6KJ6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6414010F375
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783003593;
 bh=alwKjX0qd04bQGKBybnZVjx1pcMm+oZgM4GGSs2jfak=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WPsB6KJ633mpnlMCJgd3Za/iV9saZ8Dp9jl1SAEjZAi+IsGQ3aWI+EICbdGlUWrQN
 AhCRIUiX5+8A2Hhl1Ey+xtq9SUbBIXVKyd+5J2JiwxPGnM1uOQbdc6yphjNtM3bcUy
 +dbwQmRO3210LsxGDKevY+hSth5nmejxET6zHFsBE7chxBbcXaOQpcywixKraDwtLL
 BmO/7epFP0JuTfZJaJDTWD/WvaT3HmlTQss5Az47+P5SaJWuHMMvOlIYhCoEAHV6UT
 WqdeeqpAMQTV8zbjiY7kYBaSDF03Ps+lLz3VssSxvN+xjH9nvlHqJdh2GbDyg0TDGA
 xTap0p7sJCdfA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 02FEF17E0F44;
 Thu,  2 Jul 2026 16:46:33 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 02 Jul 2026 17:46:15 +0300
Subject: [PATCH v8 02/39] drm/connector: Add caps-based HDMI connector init
 helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dw-hdmi-qp-scramb-v8-2-d79890d00b6a@collabora.com>
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

In preparation for adding HDMI 2.x source capabilities, introduce struct
drm_connector_hdmi_caps and a new drmm_connector_hdmi_init_with_caps()
helper.

The existing drmm_connector_hdmi_init() helper currently takes
individual capability arguments such as supported_formats and max_bpc.
Adding more HDMI-specific arguments to that function would not scale
well, so move those values into a dedicated capabilities structure and
implement the existing helper as a wrapper around the new caps-based
interface.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 202 +++++++++++++++++++++++++++-------------
 include/drm/drm_connector.h     |  55 +++++++++++
 2 files changed, 193 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 8b4baed060f3..c7ce6b7bd8b0 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -542,6 +542,137 @@ int drmm_connector_init(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drmm_connector_init);
 
+/**
+ * drmm_connector_hdmi_init_with_caps - Init a preallocated HDMI connector
+ * @dev: DRM device
+ * @connector: A pointer to the HDMI connector to init
+ * @vendor: HDMI Controller Vendor name
+ * @product: HDMI Controller Product name
+ * @funcs: callbacks for this connector
+ * @hdmi_funcs: HDMI-related callbacks for this connector
+ * @connector_type: user visible type of the connector
+ * @ddc: optional pointer to the associated ddc adapter
+ * @caps: optional HDMI connector capabilities
+ *
+ * Initialises a preallocated HDMI connector. Connectors can be
+ * subclassed as part of driver connector objects.
+ *
+ * Cleanup is automatically handled with a call to
+ * drm_connector_cleanup() in a DRM-managed action.
+ *
+ * The connector structure should be allocated with drmm_kzalloc().
+ *
+ * The @drm_connector_funcs.destroy hook must be NULL.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drmm_connector_hdmi_init_with_caps(struct drm_device *dev,
+				       struct drm_connector *connector,
+				       const char *vendor, const char *product,
+				       const struct drm_connector_funcs *funcs,
+				       const struct drm_connector_hdmi_funcs *hdmi_funcs,
+				       int connector_type,
+				       struct i2c_adapter *ddc,
+				       const struct drm_connector_hdmi_caps *caps)
+{
+	int ret;
+
+	if (!vendor || !product)
+		return -EINVAL;
+
+	if ((strlen(vendor) > DRM_CONNECTOR_HDMI_VENDOR_LEN) ||
+	    (strlen(product) > DRM_CONNECTOR_HDMI_PRODUCT_LEN))
+		return -EINVAL;
+
+	if (!(connector_type == DRM_MODE_CONNECTOR_HDMIA ||
+	      connector_type == DRM_MODE_CONNECTOR_HDMIB))
+		return -EINVAL;
+
+	if (!caps)
+		return -EINVAL;
+
+	if (!caps->supported_formats ||
+	    !(caps->supported_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444)))
+		return -EINVAL;
+
+	if (connector->ycbcr_420_allowed !=
+	    !!(caps->supported_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420)))
+		return -EINVAL;
+
+	if (!(caps->max_bpc == 8 || caps->max_bpc == 10 || caps->max_bpc == 12))
+		return -EINVAL;
+
+	if (!hdmi_funcs->avi.clear_infoframe ||
+	    !hdmi_funcs->avi.write_infoframe ||
+	    !hdmi_funcs->hdmi.clear_infoframe ||
+	    !hdmi_funcs->hdmi.write_infoframe)
+		return -EINVAL;
+
+	ret = drmm_connector_init(dev, connector, funcs, connector_type, ddc);
+	if (ret)
+		return ret;
+
+	connector->hdmi.supported_formats = caps->supported_formats;
+
+	/*
+	 * The supported HDMI version can be used to infer the maximum TMDS
+	 * character rate allowed by the specification. Some controllers,
+	 * however, may support a lower rate than that version would imply.
+	 *
+	 * A non-zero caps->max_tmds_char_rate lets drivers override the
+	 * inferred limit with the actual controller capability. A value of
+	 * zero keeps the default limit inferred from supported_hdmi_ver.
+	 */
+	if (caps->supported_hdmi_ver >= HDMI_VERSION_2_0)
+		connector->hdmi.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
+	else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_3)
+		connector->hdmi.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
+	else if (caps->supported_hdmi_ver >= HDMI_VERSION_1_0)
+		connector->hdmi.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+
+	if (caps->max_tmds_char_rate) {
+		if (caps->max_tmds_char_rate > connector->hdmi.max_tmds_char_rate)
+			return -EINVAL;
+		connector->hdmi.max_tmds_char_rate = caps->max_tmds_char_rate;
+	}
+
+	strtomem_pad(connector->hdmi.vendor, vendor, 0);
+	strtomem_pad(connector->hdmi.product, product, 0);
+
+	/*
+	 * drm_connector_attach_max_bpc_property() requires the
+	 * connector to have a state.
+	 */
+	if (connector->funcs->atomic_create_state) {
+		struct drm_connector_state *state;
+
+		state = connector->funcs->atomic_create_state(connector);
+		if (IS_ERR(state))
+			return PTR_ERR(state);
+
+		connector->state = state;
+	} else if (connector->funcs->reset) {
+		connector->funcs->reset(connector);
+	}
+
+	drm_connector_attach_max_bpc_property(connector, 8, caps->max_bpc);
+	connector->max_bpc = caps->max_bpc;
+
+	if (caps->max_bpc > 8)
+		drm_connector_attach_hdr_output_metadata_property(connector);
+
+	ret = drm_connector_attach_color_format_property(connector,
+							 caps->supported_formats);
+	if (ret)
+		return ret;
+
+	connector->hdmi.funcs = hdmi_funcs;
+
+	return 0;
+}
+EXPORT_SYMBOL(drmm_connector_hdmi_init_with_caps);
+
 /**
  * drmm_connector_hdmi_init - Init a preallocated HDMI connector
  * @dev: DRM device
@@ -578,71 +709,14 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 			     unsigned long supported_formats,
 			     unsigned int max_bpc)
 {
-	int ret;
+	struct drm_connector_hdmi_caps caps = {
+		.supported_formats = supported_formats,
+		.max_bpc = max_bpc,
+	};
 
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
+	return drmm_connector_hdmi_init_with_caps(dev, connector, vendor,
+						  product, funcs, hdmi_funcs,
+						  connector_type, ddc, &caps);
 }
 EXPORT_SYMBOL(drmm_connector_hdmi_init);
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index af075c38f4db..961a729d0869 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2029,6 +2029,47 @@ struct drm_connector_hdmi_audio {
 	int dai_port;
 };
 
+/**
+ * struct drm_connector_hdmi_caps - HDMI capabilities structure
+ *
+ * This structure is required to initialize the connector using
+ * drmm_connector_hdmi_init_with_caps().
+ */
+struct drm_connector_hdmi_caps {
+	/**
+	 * @supported_hdmi_ver:
+	 *
+	 * Maximum HDMI specification version supported by the controller side
+	 * of this connector. This describes the controller capability only;
+	 * the effective link capabilities may be further restricted by the
+	 * sink, bridge, or mode validation.
+	 *
+	 * HDMI_VERSION_UNKNOWN means legacy/default behaviour.
+	 */
+	enum hdmi_version supported_hdmi_ver;
+
+	/**
+	 * @supported_formats:
+	 *
+	 * Bitmask of @drm_output_color_format listing supported output formats.
+	 */
+	unsigned long supported_formats;
+
+	/**
+	 * @max_tmds_char_rate:
+	 *
+	 * Maximum TMDS character rate supported by the source, in Hz.
+	 * A value of 0 means the core should use the default limit implied by
+	 * @supported_hdmi_ver.
+	 */
+	unsigned long long max_tmds_char_rate;
+
+	/**
+	 * @max_bpc: Maximum bits per char the HDMI connector supports.
+	 */
+	unsigned int max_bpc;
+};
+
 /*
  * struct drm_connector_hdmi - DRM Connector HDMI-related structure
  */
@@ -2051,6 +2092,12 @@ struct drm_connector_hdmi {
 	 */
 	unsigned long supported_formats;
 
+	/**
+	 * @max_tmds_char_rate: Maximum TMDS character rate, in Hz,
+	 * supported by the controller.
+	 */
+	unsigned long long max_tmds_char_rate;
+
 	/**
 	 * @funcs: HDMI connector Control Functions
 	 */
@@ -2555,6 +2602,14 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 			     struct i2c_adapter *ddc,
 			     unsigned long supported_formats,
 			     unsigned int max_bpc);
+int drmm_connector_hdmi_init_with_caps(struct drm_device *dev,
+				       struct drm_connector *connector,
+				       const char *vendor, const char *product,
+				       const struct drm_connector_funcs *funcs,
+				       const struct drm_connector_hdmi_funcs *hdmi_funcs,
+				       int connector_type,
+				       struct i2c_adapter *ddc,
+				       const struct drm_connector_hdmi_caps *caps);
 void drm_connector_attach_edid_property(struct drm_connector *connector);
 int drm_connector_register(struct drm_connector *connector);
 int drm_connector_dynamic_register(struct drm_connector *connector);

-- 
2.54.0

