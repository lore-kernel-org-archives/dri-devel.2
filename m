Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951D3F54AD8
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F7B10E72A;
	Tue, 24 Mar 2026 16:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="AMnbbNss";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F6B10E721;
 Tue, 24 Mar 2026 16:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774368121; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fHgt3z9rRnjn9NT8RIGXVUWX3XTsPXRMUOVollM11R/dVeG6HSP0sff+67/gCWNmVvD6CMZBAGgWQUpRdumpu2KsLsp6zkJLOUs5WA3JaLOZFAcGFG4U2pKQMd+ln8/Ad64Lll6ZyuA82omr1yr/cFqkhCbMKKI5dR1wYJNoQAU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774368121;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3WXYQ1KD9CKr1MODxvfjZZDaB8BQOT/LJkDq9jPD7Ts=; 
 b=KeoXI3+h40krpvwWEuKwCjXHhn3MoK+ng48acSC9zEg5sEeAvp6WzFfOKPZPmW1F/v9JptgXWTeXfrWMbfh66OrpPr3r5dfx16fMEORnIftczZfWoxKC0YP0we0FpdxcpdzZ3pS23mCaqkAslEFl3UtEFmq8Hr6elPhdp9gRyMc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774368121; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=3WXYQ1KD9CKr1MODxvfjZZDaB8BQOT/LJkDq9jPD7Ts=;
 b=AMnbbNss2kw78kJv1g0Ix9qnRImevjAX0QUqtwAdpci0ObntQ1UQTPY7frEr4dD6
 SxCTgWMNw+BUHUlH3H8ZVoxvrTrihP43Pw75ZUQzwNvdMMmHRpjZ0mzf1Ap6BHrcpFV
 DhTc2KcYwe9PnXpUt3nm1zq8yrN/RNKPzdlX/das=
Received: by mx.zohomail.com with SMTPS id 1774368120911238.6638807076763;
 Tue, 24 Mar 2026 09:02:00 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 24 Mar 2026 17:01:07 +0100
Subject: [PATCH v11 03/22] drm: Add new general DRM property "color format"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-color-format-v11-3-605559af4fb4@collabora.com>
References: <20260324-color-format-v11-0-605559af4fb4@collabora.com>
In-Reply-To: <20260324-color-format-v11-0-605559af4fb4@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Werner Sembach <wse@tuxedocomputers.com>, 
 Andri Yngvason <andri@yngvason.is>, Marius Vlad <marius.vlad@collabora.com>
X-Mailer: b4 0.15.0
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

Add a new general DRM property named "color format" which can be used by
userspace to request the display driver to output a particular color
format.

Possible options are:
    - auto (setup by default, driver internally picks the color format)
    - rgb
    - ycbcr444
    - ycbcr422
    - ycbcr420

Drivers should advertise from this list which formats they support.
Together with this list and EDID data from the sink we should be able
to relay a list of usable color formats to users to pick from.

Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Co-developed-by: Andri Yngvason <andri@yngvason.is>
Signed-off-by: Andri Yngvason <andri@yngvason.is>
Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_atomic_helper.c |   5 ++
 drivers/gpu/drm/drm_atomic_uapi.c   |  11 ++++
 drivers/gpu/drm/drm_connector.c     | 108 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h         | 104 ++++++++++++++++++++++++++++++++++
 4 files changed, 228 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 26953ed6b53e..b7753454b777 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -737,6 +737,11 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 			if (old_connector_state->max_requested_bpc !=
 			    new_connector_state->max_requested_bpc)
 				new_crtc_state->connectors_changed = true;
+
+			if (old_connector_state->color_format !=
+			    new_connector_state->color_format)
+				new_crtc_state->connectors_changed = true;
+
 		}
 
 		if (funcs->atomic_check)
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 5bd5bf6661df..dee510c85e59 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -935,6 +935,15 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->privacy_screen_sw_state = val;
 	} else if (property == connector->broadcast_rgb_property) {
 		state->hdmi.broadcast_rgb = val;
+	} else if (property == connector->color_format_property) {
+		if (val > INT_MAX || !drm_connector_color_format_valid(val)) {
+			drm_dbg_atomic(connector->dev,
+				       "[CONNECTOR:%d:%s] unknown color format %llu\n",
+				       connector->base.id, connector->name, val);
+			return -EINVAL;
+		}
+
+		state->color_format = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -1020,6 +1029,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->privacy_screen_sw_state;
 	} else if (property == connector->broadcast_rgb_property) {
 		*val = state->hdmi.broadcast_rgb;
+	} else if (property == connector->color_format_property) {
+		*val = state->color_format;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 47dc53c4a738..e848374dee0b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1388,6 +1388,18 @@ static const u32 hdmi_colorspaces =
 	BIT(DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65) |
 	BIT(DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER);
 
+static const u32 hdmi_colorformats =
+	BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+	BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
+	BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
+	BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
+
+static const u32 dp_colorformats =
+	BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+	BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
+	BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
+	BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
+
 /*
  * As per DP 1.4a spec, 2.2.5.7.5 VSC SDP Payload for Pixel Encoding/Colorimetry
  * Format Table 2-120
@@ -2940,6 +2952,102 @@ int drm_connector_attach_colorspace_property(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_connector_attach_colorspace_property);
 
+/**
+ * drm_connector_attach_color_format_property - create and attach color format property
+ * @connector: connector to create the color format property on
+ * @supported_color_formats: bitmask of bit-shifted &enum drm_output_color_format
+ *                           values the connector supports
+ *
+ * Called by a driver to create a color format property. The property is
+ * attached to the connector automatically on success.
+ *
+ * @supported_color_formats should only include color formats the connector
+ * type can actually support.
+ *
+ * Returns:
+ * 0 on success, negative errno on error
+ */
+int drm_connector_attach_color_format_property(struct drm_connector *connector,
+					       unsigned long supported_color_formats)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_prop_enum_list enum_list[DRM_CONNECTOR_COLOR_FORMAT_COUNT];
+	unsigned int i = 0;
+	unsigned long fmt;
+
+	if (connector->color_format_property)
+		return 0;
+
+	if (!supported_color_formats) {
+		drm_err(dev, "No supported color formats provided on [CONNECTOR:%d:%s]\n",
+			connector->base.id, connector->name);
+		return -EINVAL;
+	}
+
+	if (supported_color_formats & ~GENMASK(DRM_OUTPUT_COLOR_FORMAT_COUNT - 1, 0)) {
+		drm_err(dev, "Unknown color formats provided on [CONNECTOR:%d:%s]\n",
+			connector->base.id, connector->name);
+		return -EINVAL;
+	}
+
+	switch (connector->connector_type) {
+	case DRM_MODE_CONNECTOR_HDMIA:
+	case DRM_MODE_CONNECTOR_HDMIB:
+		if (supported_color_formats & ~hdmi_colorformats) {
+			drm_err(dev, "Color formats not allowed for HDMI on [CONNECTOR:%d:%s]\n",
+				connector->base.id, connector->name);
+			return -EINVAL;
+		}
+		break;
+	case DRM_MODE_CONNECTOR_DisplayPort:
+	case DRM_MODE_CONNECTOR_eDP:
+		if (supported_color_formats & ~dp_colorformats) {
+			drm_err(dev, "Color formats not allowed for DP on [CONNECTOR:%d:%s]\n",
+				connector->base.id, connector->name);
+			return -EINVAL;
+		}
+		break;
+	}
+
+	enum_list[0].name = "AUTO";
+	enum_list[0].type = DRM_CONNECTOR_COLOR_FORMAT_AUTO;
+
+	for_each_set_bit(fmt, &supported_color_formats, DRM_OUTPUT_COLOR_FORMAT_COUNT) {
+		switch (fmt) {
+		case DRM_OUTPUT_COLOR_FORMAT_RGB444:
+			enum_list[++i].type = DRM_CONNECTOR_COLOR_FORMAT_RGB444;
+			break;
+		case DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
+			enum_list[++i].type = DRM_CONNECTOR_COLOR_FORMAT_YCBCR444;
+			break;
+		case DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
+			enum_list[++i].type = DRM_CONNECTOR_COLOR_FORMAT_YCBCR422;
+			break;
+		case DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
+			enum_list[++i].type = DRM_CONNECTOR_COLOR_FORMAT_YCBCR420;
+			break;
+		default:
+			drm_warn(dev, "Unknown supported format %ld on [CONNECTOR:%d:%s]\n",
+				 fmt, connector->base.id, connector->name);
+			continue;
+		}
+		enum_list[i].name = drm_hdmi_connector_get_output_format_name(fmt);
+	}
+
+	connector->color_format_property =
+		drm_property_create_enum(dev, DRM_MODE_PROP_ENUM, "color format",
+					 enum_list, i + 1);
+
+	if (!connector->color_format_property)
+		return -ENOMEM;
+
+	drm_object_attach_property(&connector->base, connector->color_format_property,
+				   DRM_CONNECTOR_COLOR_FORMAT_AUTO);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_color_format_property);
+
 /**
  * drm_connector_atomic_hdr_metadata_equal - checks if the hdr metadata changed
  * @old_state: old connector state to compare
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index af8b92d2d5b7..bd549f912b76 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -571,14 +571,102 @@ enum drm_colorspace {
  *   YCbCr 4:2:2 output format (ie. with horizontal subsampling)
  * @DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
  *   YCbCr 4:2:0 output format (ie. with horizontal and vertical subsampling)
+ * @DRM_OUTPUT_COLOR_FORMAT_COUNT:
+ *   Number of valid output color format values in this enum
  */
 enum drm_output_color_format {
 	DRM_OUTPUT_COLOR_FORMAT_RGB444 = 0,
 	DRM_OUTPUT_COLOR_FORMAT_YCBCR444,
 	DRM_OUTPUT_COLOR_FORMAT_YCBCR422,
 	DRM_OUTPUT_COLOR_FORMAT_YCBCR420,
+	DRM_OUTPUT_COLOR_FORMAT_COUNT,
 };
 
+/**
+ * enum drm_connector_color_format - Connector Color Format Request
+ *
+ * This enum, unlike &enum drm_output_color_format, is used to specify requests
+ * for a specific color format on a connector through the DRM "color format"
+ * property. The difference is that it has an "AUTO" value to specify that
+ * no specific choice has been made.
+ */
+enum drm_connector_color_format {
+	/**
+	 * @DRM_CONNECTOR_COLOR_FORMAT_AUTO: The driver or display protocol
+	 * helpers should pick a suitable color format. All implementations of a
+	 * specific display protocol must behave the same way with "AUTO", but
+	 * different display protocols do not necessarily have the same "AUTO"
+	 * semantics.
+	 *
+	 * For HDMI, "AUTO" picks RGB, but falls back to YCbCr 4:2:0 if the
+	 * bandwidth required for full-scale RGB is not available, or the mode
+	 * is YCbCr 4:2:0-only, as long as the mode and output both support
+	 * YCbCr 4:2:0.
+	 *
+	 * For display protocols other than HDMI, the recursive bridge chain
+	 * format selection picks the first chain of bridge formats that works,
+	 * as has already been the case before the introduction of the "color
+	 * format" property. Non-HDMI bridges should therefore either sort their
+	 * bus output formats by preference, or agree on a unified auto format
+	 * selection logic that's implemented in a common state helper (like
+	 * how HDMI does it).
+	 */
+	DRM_CONNECTOR_COLOR_FORMAT_AUTO = 0,
+
+	/**
+	 * @DRM_CONNECTOR_COLOR_FORMAT_RGB444: RGB output format
+	 */
+	DRM_CONNECTOR_COLOR_FORMAT_RGB444,
+
+	/**
+	 * @DRM_CONNECTOR_COLOR_FORMAT_YCBCR444: YCbCr 4:4:4 output format (ie.
+	 * not subsampled)
+	 */
+	DRM_CONNECTOR_COLOR_FORMAT_YCBCR444,
+
+	/**
+	 * @DRM_CONNECTOR_COLOR_FORMAT_YCBCR422: YCbCr 4:2:2 output format (ie.
+	 * with horizontal subsampling)
+	 */
+	DRM_CONNECTOR_COLOR_FORMAT_YCBCR422,
+
+	/**
+	 * @DRM_CONNECTOR_COLOR_FORMAT_YCBCR420: YCbCr 4:2:0 output format (ie.
+	 * with horizontal and vertical subsampling)
+	 */
+	DRM_CONNECTOR_COLOR_FORMAT_YCBCR420,
+
+	/**
+	 * @DRM_CONNECTOR_COLOR_FORMAT_COUNT: Number of valid connector color
+	 * format values in this enum
+	 */
+	DRM_CONNECTOR_COLOR_FORMAT_COUNT,
+};
+
+/**
+ * drm_connector_color_format_valid - Validate drm_connector_color_format value
+ * @fmt: value to check against all values of &enum drm_connector_color_format
+ *
+ * Checks whether the passed in value of @fmt is one of the allowable values in
+ * &enum drm_connector_color_format.
+ *
+ * Returns: %true if it's a valid value for the enum, %false otherwise.
+ */
+static inline bool __pure
+drm_connector_color_format_valid(enum drm_connector_color_format fmt)
+{
+	switch (fmt) {
+	case DRM_CONNECTOR_COLOR_FORMAT_AUTO:
+	case DRM_CONNECTOR_COLOR_FORMAT_RGB444:
+	case DRM_CONNECTOR_COLOR_FORMAT_YCBCR444:
+	case DRM_CONNECTOR_COLOR_FORMAT_YCBCR422:
+	case DRM_CONNECTOR_COLOR_FORMAT_YCBCR420:
+		return true;
+	default:
+		return false;
+	}
+}
+
 const char *
 drm_hdmi_connector_get_output_format_name(enum drm_output_color_format fmt);
 
@@ -1129,6 +1217,13 @@ struct drm_connector_state {
 	 */
 	enum drm_colorspace colorspace;
 
+	/**
+	 * @color_format: State variable for Connector property to request
+	 * color format change on Sink. This is most commonly used to switch
+	 * between RGB to YUV and vice-versa.
+	 */
+	enum drm_connector_color_format color_format;
+
 	/**
 	 * @writeback_job: Writeback job for writeback connectors
 	 *
@@ -2127,6 +2222,12 @@ struct drm_connector {
 	 */
 	struct drm_property *colorspace_property;
 
+	/**
+	 * @color_format_property: Connector property to set the suitable
+	 * color format supported by the sink.
+	 */
+	struct drm_property *color_format_property;
+
 	/**
 	 * @path_blob_ptr:
 	 *
@@ -2610,6 +2711,9 @@ bool drm_connector_has_possible_encoder(struct drm_connector *connector,
 					struct drm_encoder *encoder);
 const char *drm_get_colorspace_name(enum drm_colorspace colorspace);
 
+int drm_connector_attach_color_format_property(struct drm_connector *connector,
+					       unsigned long supported_color_formats);
+
 /**
  * drm_for_each_connector_iter - connector_list iterator macro
  * @connector: &struct drm_connector pointer used as cursor

-- 
2.53.0

