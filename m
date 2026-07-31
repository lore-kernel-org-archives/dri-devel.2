Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C3FC55171
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A88F10F310;
	Fri, 31 Jul 2026 16:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BWSvj1aY";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032E610F2FB
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514757;
 bh=NoIEJfzsPnttpMy6TCleHNM/qDBVTlWkZiIKX22Bc5g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BWSvj1aYnurkJs2uxXnSS26owG5ntL/d5szAEDky5vXgvXrcGzZX3omWQ3eeA7kjp
 I/Qkx6d2n/oRr+MpGCyNUbx/+1LdMTop5+CU5EOkZR52suDzJrwTLGrJxTjKH/jfO8
 dlx8LIFCsHuEe8CVWHIn2us881q04bGRFWp1Vv2ISrRkGgwOshl8FCS16T7TG5RJFY
 ZrdlNmgm/Wt2mEN08QmYrCh8utCav4XlnV3mijR47//uye/34uBrl9J/tbcbW1l1mS
 2itLPKiWiDC4D/HYc0qXiif0eEGgMcVgFRmfQ29ose3mesfyy9fRP8YXFZ3bzNijyS
 h17IBVEAIksCw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A153417E08E0;
 Fri, 31 Jul 2026 18:19:17 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:19:11 +0300
Subject: [PATCH v10 04/69] drm/connector: Add drmm_connector_hdmi_init()
 with new signature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-4-294364b2cf15@collabora.com>
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

In preparation for providing HDMI 2.x source capabilities, move the
vendor, product, supported_formats and max_bpc parameters out of the
init function into struct drm_connector_hdmi_funcs, and add new
supported_hdmi_ver and supported_tmds_char_rate fields there as well.

Appending more HDMI-specific arguments to that function would not scale
well, hence introduce drmm_connector_hdmi_init() with the reduced
signature.

Additionally, add the max_tmds_char_rate field to struct
drm_connector_hdmi and use the supported HDMI version to determinate the
maximum TMDS character rate allowed by the specification.  Some
controllers, however, may support a lower rate than that version would
imply.  A non-zero supported_tmds_char_rate lets drivers override this
default with the actual controller capability.  A value of zero keeps
the limit inferred from supported_hdmi_ver.

Callers are converted in the following patches, while the old and now
renamed *_ini2() helper is removed at the end of the series.

No functional changes expected for existing callers.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 136 ++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     |  62 +++++++++++++++++-
 2 files changed, 197 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 5e520cff6094..4721cdeafc84 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -542,6 +542,142 @@ int drmm_connector_init(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drmm_connector_init);
 
+/**
+ * drmm_connector_hdmi_init - Init a preallocated HDMI connector
+ * @dev: DRM device
+ * @connector: A pointer to the HDMI connector to init
+ * @funcs: callbacks for this connector
+ * @hdmi_funcs: HDMI-related callbacks and capabilities for this connector
+ * @connector_type: user visible type of the connector
+ * @ddc: optional pointer to the associated ddc adapter
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
+int drmm_connector_hdmi_init(struct drm_device *dev,
+			     struct drm_connector *connector,
+			     const struct drm_connector_funcs *funcs,
+			     const struct drm_connector_hdmi_funcs *hdmi_funcs,
+			     int connector_type,
+			     struct i2c_adapter *ddc)
+{
+	int ret;
+
+	if (!hdmi_funcs)
+		return -EINVAL;
+
+	if (!hdmi_funcs->vendor || !hdmi_funcs->product)
+		return -EINVAL;
+
+	if ((strlen(hdmi_funcs->vendor) > DRM_CONNECTOR_HDMI_VENDOR_LEN) ||
+	    (strlen(hdmi_funcs->product) > DRM_CONNECTOR_HDMI_PRODUCT_LEN))
+		return -EINVAL;
+
+	if (!hdmi_funcs->supported_formats ||
+	    !(hdmi_funcs->supported_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444)))
+		return -EINVAL;
+
+	if (connector->ycbcr_420_allowed !=
+	    !!(hdmi_funcs->supported_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420)))
+		return -EINVAL;
+
+	if (!(hdmi_funcs->max_bpc == 8 ||
+	      hdmi_funcs->max_bpc == 10 ||
+	      hdmi_funcs->max_bpc == 12))
+		return -EINVAL;
+
+	if (!hdmi_funcs->avi.clear_infoframe ||
+	    !hdmi_funcs->avi.write_infoframe ||
+	    !hdmi_funcs->hdmi.clear_infoframe ||
+	    !hdmi_funcs->hdmi.write_infoframe)
+		return -EINVAL;
+
+	if (!(connector_type == DRM_MODE_CONNECTOR_HDMIA ||
+	      connector_type == DRM_MODE_CONNECTOR_HDMIB))
+		return -EINVAL;
+
+	ret = drmm_connector_init(dev, connector, funcs, connector_type, ddc);
+	if (ret)
+		return ret;
+
+	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
+	connector->hdmi.supported_formats = hdmi_funcs->supported_formats;
+
+	/*
+	 * The supported HDMI version can be used to determinate the maximum
+	 * TMDS character rate allowed by the specification. Some controllers,
+	 * however, may support a lower rate than that version would imply.
+	 *
+	 * A non-zero caps->max_tmds_char_rate lets drivers override this
+	 * default with the actual controller capability. A value of zero keeps
+	 * the limit inferred from supported_hdmi_ver.
+	 */
+	if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_2_0)
+		connector->hdmi.max_tmds_char_rate = HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
+	else if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_1_3)
+		connector->hdmi.max_tmds_char_rate = HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
+	else if (hdmi_funcs->supported_hdmi_ver >= HDMI_VERSION_1_0)
+		connector->hdmi.max_tmds_char_rate = HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
+
+	if (hdmi_funcs->supported_tmds_char_rate) {
+		if (hdmi_funcs->supported_tmds_char_rate > connector->hdmi.max_tmds_char_rate) {
+			drm_err(dev, "Enforced max_tmds_char_rate exceeds %llu spec limit\n",
+				connector->hdmi.max_tmds_char_rate);
+			return -EINVAL;
+		}
+		connector->hdmi.max_tmds_char_rate = hdmi_funcs->supported_tmds_char_rate;
+	}
+
+	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
+	strtomem_pad(connector->hdmi.vendor, hdmi_funcs->vendor, 0);
+	strtomem_pad(connector->hdmi.product, hdmi_funcs->product, 0);
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
+		if (!connector->state)
+			return -ENOMEM;
+	}
+
+	drm_connector_attach_max_bpc_property(connector, 8, hdmi_funcs->max_bpc);
+	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
+	connector->max_bpc = hdmi_funcs->max_bpc;
+
+	if (hdmi_funcs->max_bpc > 8)
+		drm_connector_attach_hdr_output_metadata_property(connector);
+
+	ret = drm_connector_attach_color_format_property(connector,
+							 hdmi_funcs->supported_formats);
+	if (ret)
+		return ret;
+
+	connector->hdmi.funcs = hdmi_funcs;
+
+	return 0;
+}
+EXPORT_SYMBOL(drmm_connector_hdmi_init);
+
 /**
  * drmm_connector_hdmi_ini2 - Init a preallocated HDMI connector
  * @dev: DRM device
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2e7d75cb0adf..2a49c4d55f77 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1403,8 +1403,50 @@ struct drm_connector_infoframe_funcs {
 
 /**
  * struct drm_connector_hdmi_funcs - drm_hdmi_connector control functions
+ * and controller capabilities
  */
 struct drm_connector_hdmi_funcs {
+	/**
+	 * @vendor: HDMI Controller Vendor name.
+	 */
+	const char *vendor;
+
+	/**
+	 * @product: HDMI Controller Product name
+	 */
+	const char *product;
+
+	/**
+	 * @supported_hdmi_ver:
+	 *
+	 * Maximum HDMI specification version supported by the controller side
+	 * of this connector. This describes the controller capability only;
+	 * the effective link capabilities may be further restricted by the
+	 * sink, bridge, or mode validation.
+	 */
+	enum hdmi_version supported_hdmi_ver;
+
+	/**
+	 * @supported_tmds_char_rate:
+	 *
+	 * Maximum TMDS character rate supported by the controller, in Hz.
+	 * A value of 0 means the core should use the default limit implied by
+	 * @supported_hdmi_ver.
+	 */
+	unsigned long long supported_tmds_char_rate;
+
+	/**
+	 * @supported_formats:
+	 *
+	 * Bitmask of @drm_output_color_format listing supported output formats.
+	 */
+	unsigned long supported_formats;
+
+	/**
+	 * @max_bpc: Maximum bits per char the HDMI connector supports.
+	 */
+	unsigned int max_bpc;
+
 	/**
 	 * @tmds_char_rate_valid:
 	 *
@@ -2052,7 +2094,19 @@ struct drm_connector_hdmi {
 	unsigned long supported_formats;
 
 	/**
-	 * @funcs: HDMI connector Control Functions
+	 * @max_tmds_char_rate: Maximum TMDS character rate, in Hz,
+	 * supported by the controller.
+	 *
+	 * This is inferred from &drm_connector_hdmi_funcs.supported_hdmi_ver,
+	 * by default. However, controllers may support a lower rate than that
+	 * specification version would imply. If that is the case, drivers are
+	 * expected to set &drm_connector_hdmi_funcs.supported_tmds_char_rate
+	 * to a non-zero value indicating the actual limit.
+	 */
+	unsigned long long max_tmds_char_rate;
+
+	/**
+	 * @funcs: HDMI connector Control Functions and controller capabilities
 	 */
 	const struct drm_connector_hdmi_funcs *funcs;
 
@@ -2549,6 +2603,12 @@ int drmm_connector_init(struct drm_device *dev,
 			const struct drm_connector_funcs *funcs,
 			int connector_type,
 			struct i2c_adapter *ddc);
+int drmm_connector_hdmi_init(struct drm_device *dev,
+			     struct drm_connector *connector,
+			     const struct drm_connector_funcs *funcs,
+			     const struct drm_connector_hdmi_funcs *hdmi_funcs,
+			     int connector_type,
+			     struct i2c_adapter *ddc);
 int drmm_connector_hdmi_ini2(struct drm_device *dev,
 			     struct drm_connector *connector,
 			     const char *vendor, const char *product,

-- 
2.55.0

