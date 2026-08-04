Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9381C55ABF
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CFDD10EA27;
	Tue,  4 Aug 2026 12:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cbG0odV3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D0AC10EA27;
 Tue,  4 Aug 2026 12:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785848103; x=1817384103;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p1gK6uGHvTzccKxl38fuVUV/BVY9Cgw+4vzGOQhhFg4=;
 b=cbG0odV3YEupQotJ4YCtXJlQfY6fLMEfVoI1VtVy5Cz58SthnQc/jBEk
 H+7U8vTlDvgUfHY7REs4RJpu8T/NjBLT7e8meOHVpmO/iJyuaqk4yCHH/
 Ku1XDEj/P/yk32/oTK9/w0ljZtJP7ISx8FBk2LffunYPvzvbO+VPtGUP7
 qG3VYRUEa9HYU3HfvwibYoVsFoIZXaT18+EEXxzE2SJes+VrbcG36SM0+
 XjoMvylvRWQy5uKhYQAUNyB4WQka+FiDhYEWl1Ha3Zz+ZWAmv39yiaufa
 Z6cPPbOMLXlMGndXvDQQPNW4/YO8ewLDQhXWO0t1B8tdOc7HeLd4ByAn0 A==;
X-CSE-ConnectionGUID: +EDvxHITSfyMGLolHMbb6w==
X-CSE-MsgGUID: NKdWqVDZTZWgvJOEgoEQQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90073196"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="90073196"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 05:55:03 -0700
X-CSE-ConnectionGUID: gTw4fuZ+TxqMFYMQ9q5hHQ==
X-CSE-MsgGUID: wEVAPr47SAWDXinxBAlFvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="262108267"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa009.jf.intel.com with ESMTP; 04 Aug 2026 05:54:59 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>,
 Robert Mader <robert.mader@collabora.com>, Alex Hung <alex.hung@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: [v6 1/9] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
Date: Tue,  4 Aug 2026 18:00:59 +0530
Message-ID: <20260804123107.2256124-2-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
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

Introduce DRM_COLOROP_FIXED_MATRIX, a new colorop type representing a
hardware that performs a fixed matrix operation.

Unlike CTM-based colorops, this block does not expose programmable
coefficients. Instead, userspace selects one of the predefined
hardware modes via a new FIXED_MATRIX_TYPE enum property. Supported modes
include common YCbCr->RGB and RGB709->RGB2020 conversions.

v5:
 - Drop YCbCr limited to full and RGB709 to RGB2020 matrices
   until we have non-IGT userspace that shows their use (Robert)

v4:
 - Add limited-range YCbCr-RGB conversion matrix enums (Robert)
 - Document matrix values (Pekka)
 - Clarify RGB709 to RGB2020 is a full-range matrix (Pekka)
 - Fix confusing "CSC preset" doc (Pekka)

v2:
 - Naming changes (Pekka)

v3:
 - Fix NC matrix enum name and string (Melissa)
 - Rebase

Co-developed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Robert Mader <robert.mader@collabora.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---
 drivers/gpu/drm/drm_atomic.c      |   4 +
 drivers/gpu/drm/drm_atomic_uapi.c |   7 ++
 drivers/gpu/drm/drm_colorop.c     | 107 +++++++++++++++++++++++++
 include/drm/drm_colorop.h         | 127 ++++++++++++++++++++++++++++++
 include/uapi/drm/drm_mode.h       |  12 +++
 5 files changed, 257 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index e5c8ef06caed..45df6376f408 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -925,6 +925,10 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 				  drm_get_colorop_lut3d_interpolation_name(state->lut3d_interpolation));
 		drm_printf_indent(p, 1, "data blob id=%d\n", state->data ? state->data->base.id : 0);
 		break;
+	case DRM_COLOROP_FIXED_MATRIX:
+		drm_printf_indent(p, 1, "fixed_matrix_type=%s\n",
+				  drm_get_colorop_fixed_matrix_type_name(state->fixed_matrix_type));
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1050dddadb17..d52504d823bc 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -786,6 +786,11 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
 		return drm_atomic_color_set_data_property(colorop, state,
 							  property, val,
 							  replaced);
+	} else if (property == colorop->fixed_matrix_type_property) {
+		if (state->fixed_matrix_type != val) {
+			state->fixed_matrix_type = val;
+			*replaced = true;
+		}
 	} else {
 		drm_dbg_atomic(colorop->dev,
 			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
@@ -818,6 +823,8 @@ drm_atomic_colorop_get_property(struct drm_colorop *colorop,
 		*val = state->lut3d_interpolation;
 	else if (property == colorop->data_property)
 		*val = (state->data) ? state->data->base.id : 0;
+	else if (property == colorop->fixed_matrix_type_property)
+		*val = state->fixed_matrix_type;
 	else
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 682fcc651525..95da03d6c65c 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -68,6 +68,7 @@ static const struct drm_prop_enum_list drm_colorop_type_enum_list[] = {
 	{ DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
 	{ DRM_COLOROP_MULTIPLIER, "Multiplier"},
 	{ DRM_COLOROP_3D_LUT, "3D LUT"},
+	{ DRM_COLOROP_FIXED_MATRIX, "Fixed Matrix"},
 };
 
 static const char * const colorop_curve_1d_type_names[] = {
@@ -90,6 +91,15 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
 	{ DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
 };
 
+static const char * const colorop_fixed_matrix_type_names[] = {
+	[DRM_COLOROP_FM_YCBCR601_FULL_RGB] = "YCbCr 601 Full to RGB",
+	[DRM_COLOROP_FM_YCBCR601_LIMITED_RGB] = "YCbCr 601 Limited to RGB",
+	[DRM_COLOROP_FM_YCBCR709_FULL_RGB] = "YCbCr 709 Full to RGB",
+	[DRM_COLOROP_FM_YCBCR709_LIMITED_RGB] = "YCbCr 709 Limited to RGB",
+	[DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] = "YCbCr 2020 NC Full to RGB",
+	[DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB] = "YCbCr 2020 NC Limited to RGB",
+};
+
 /* Init Helpers */
 
 static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *colorop,
@@ -453,6 +463,80 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
 }
 EXPORT_SYMBOL(drm_plane_colorop_3dlut_init);
 
+/**
+ * drm_plane_colorop_fixed_matrix_init - Initialize a DRM_COLOROP_FIXED_MATRIX
+ *
+ * @dev: DRM device
+ * @colorop: The drm_colorop object to initialize
+ * @plane: The associated drm_plane
+ * @funcs: control functions for the new colorop
+ * @supported_fm: A bitfield of supported drm_colorop_fixed_matrix_type enum values,
+ *               created using BIT(fixed_matrix_type) and combined with the OR '|'
+ *               operator.
+ * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
+ * @return zero on success, -E value on failure
+ */
+int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct drm_colorop *colorop,
+					struct drm_plane *plane,
+					const struct drm_colorop_funcs *funcs,
+					u64 supported_fm, uint32_t flags)
+{
+	struct drm_prop_enum_list enum_list[DRM_COLOROP_FM_COUNT];
+	int i, len;
+	struct drm_property *prop;
+	int ret;
+
+	if (!supported_fm) {
+		drm_err(dev,
+			"No supported FM type op for new Fixed Matrix colorop on [PLANE:%d:%s]\n",
+			plane->base.id, plane->name);
+		return -EINVAL;
+	}
+
+	if ((supported_fm & -BIT(DRM_COLOROP_FM_COUNT)) != 0) {
+		drm_err(dev, "Unknown Fixed Matrix provided on [PLANE:%d:%s]\n",
+			plane->base.id, plane->name);
+		return -EINVAL;
+	}
+
+	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_FIXED_MATRIX, flags);
+	if (ret)
+		return ret;
+
+	len = 0;
+	for (i = 0; i < DRM_COLOROP_FM_COUNT; i++) {
+		if ((supported_fm & BIT(i)) == 0)
+			continue;
+
+		enum_list[len].type = i;
+		enum_list[len].name = colorop_fixed_matrix_type_names[i];
+		len++;
+	}
+
+	if (WARN_ON(len <= 0))
+		return -EINVAL;
+
+	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC, "FIXED_MATRIX_TYPE",
+					enum_list, len);
+
+	if (!prop)
+		return -ENOMEM;
+
+	colorop->fixed_matrix_type_property = prop;
+	/*
+	 * Default to the first supported CSC mode as provided by the driver.
+	 * Intuitively this should be something that keeps the colorop in pixel bypass
+	 * mode but that is already handled via the standard colorop bypass
+	 * property.
+	 */
+	drm_object_attach_property(&colorop->base, colorop->fixed_matrix_type_property,
+				   enum_list[0].type);
+	drm_colorop_reset(colorop);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_plane_colorop_fixed_matrix_init);
+
 static void __drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop,
 							struct drm_colorop_state *state)
 {
@@ -533,6 +617,13 @@ static void __drm_colorop_state_init(struct drm_colorop_state *colorop_state,
 							   &val))
 			colorop_state->lut3d_interpolation = val;
 	}
+
+	if (colorop->fixed_matrix_type_property) {
+		if (!drm_object_property_get_default_value(&colorop->base,
+							   colorop->fixed_matrix_type_property,
+							   &val))
+			colorop_state->fixed_matrix_type = val;
+	}
 }
 
 /**
@@ -596,6 +687,7 @@ static const char * const colorop_type_name[] = {
 	[DRM_COLOROP_CTM_3X4] = "3x4 Matrix",
 	[DRM_COLOROP_MULTIPLIER] = "Multiplier",
 	[DRM_COLOROP_3D_LUT] = "3D LUT",
+	[DRM_COLOROP_FIXED_MATRIX] = "Fixed Matrix",
 };
 
 static const char * const colorop_lu3d_interpolation_name[] = {
@@ -652,6 +744,21 @@ const char *drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_inte
 	return colorop_lu3d_interpolation_name[type];
 }
 
+/**
+ * drm_get_colorop_fixed_matrix_type_name: return a string for fixed matrix type
+ * @type: fixed matrix type to compute name of
+ *
+ * In contrast to the other drm_get_*_name functions this one here returns a
+ * const pointer and hence is threadsafe.
+ */
+const char *drm_get_colorop_fixed_matrix_type_name(enum drm_colorop_fixed_matrix_type type)
+{
+	if (WARN_ON(type >= ARRAY_SIZE(colorop_fixed_matrix_type_names)))
+		return "unknown";
+
+	return colorop_fixed_matrix_type_names[type];
+}
+
 /**
  * drm_colorop_set_next_property - sets the next pointer
  * @colorop: drm colorop
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 224fae40ed2b..26ef67c835e2 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -134,6 +134,114 @@ enum drm_colorop_curve_1d_type {
 	DRM_COLOROP_1D_CURVE_COUNT
 };
 
+/**
+ * enum drm_colorop_fixed_matrix_type - type of Fixed Matrix
+ *
+ * Describes a Fixed Matrix operation to be applied by the DRM_COLOROP_FIXED_MATRIX
+ */
+enum drm_colorop_fixed_matrix_type {
+	/**
+	 * @DRM_COLOROP_FM_YCBCR601_FULL_RGB:
+	 *
+	 * enum string "YCbCr 601 Full to RGB"
+	 *
+	 * Converts full-range YCbCr into full-range RGB using the BT.601
+	 * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
+	 * at 0 (the nominal 0.5 offset removed) before the matrix::
+	 *
+	 *   | R |   | 1.0   0.000000   1.402000 |   | Y  |
+	 *   | G | = | 1.0  -0.344136  -0.714136 | x | Cb |
+	 *   | B |   | 1.0   1.772000   0.000000 |   | Cr |
+	 */
+	DRM_COLOROP_FM_YCBCR601_FULL_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
+	 *
+	 * enum string "YCbCr 601 Limited to RGB"
+	 *
+	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
+	 * the BT.601 coefficients. Before the matrix Y is offset by 16/255
+	 * and Cb, Cr are centered at 0, following the studio-range
+	 * convention of ITU-R BT.601::
+	 *
+	 *   | R |   | 1.164384   0.000000   1.596027 |   | Y - 16/255 |
+	 *   | G | = | 1.164384  -0.391762  -0.812968 | x | Cb         |
+	 *   | B |   | 1.164384   2.017232   0.000000 |   | Cr         |
+	 */
+	DRM_COLOROP_FM_YCBCR601_LIMITED_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR709_FULL_RGB:
+	 *
+	 * enum string "YCbCr 709 Full to RGB"
+	 *
+	 * Converts full-range YCbCr into full-range RGB using the BT.709
+	 * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
+	 * at 0 (the nominal 0.5 offset removed) before the matrix::
+	 *
+	 *   | R |   | 1.0   0.000000   1.574800 |   | Y  |
+	 *   | G | = | 1.0  -0.187324  -0.468124 | x | Cb |
+	 *   | B |   | 1.0   1.855600   0.000000 |   | Cr |
+	 */
+	DRM_COLOROP_FM_YCBCR709_FULL_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
+	 *
+	 * enum string "YCbCr 709 Limited to RGB"
+	 *
+	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
+	 * the BT.709 coefficients. Before the matrix Y is offset by 16/255
+	 * and Cb, Cr are centered at 0, following the studio-range
+	 * convention of ITU-R BT.709::
+	 *
+	 *   | R |   | 1.164384   0.000000   1.792741 |   | Y - 16/255 |
+	 *   | G | = | 1.164384  -0.213249  -0.532909 | x | Cb         |
+	 *   | B |   | 1.164384   2.112402   0.000000 |   | Cr         |
+	 */
+	DRM_COLOROP_FM_YCBCR709_LIMITED_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
+	 *
+	 * enum string "YCbCr 2020 NC Full to RGB"
+	 *
+	 * Converts full-range YCbCr into full-range RGB using the BT.2020
+	 * non-constant luminance coefficients. Y is normalized to [0, 1]
+	 * and Cb, Cr are centered at 0 (the nominal 0.5 offset removed)
+	 * before the matrix::
+	 *
+	 *   | R |   | 1.0   0.000000   1.474600 |   | Y  |
+	 *   | G | = | 1.0  -0.164553  -0.571353 | x | Cb |
+	 *   | B |   | 1.0   1.881400   0.000000 |   | Cr |
+	 */
+	DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
+	 *
+	 * enum string "YCbCr 2020 NC Limited to RGB"
+	 *
+	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
+	 * the BT.2020 non-constant luminance coefficients. Before the matrix
+	 * Y is offset by 16/255 and Cb, Cr are centered at 0, following the
+	 * studio-range convention of ITU-R BT.2020::
+	 *
+	 *   | R |   | 1.164384   0.000000   1.678674 |   | Y - 16/255 |
+	 *   | G | = | 1.164384  -0.187326  -0.650424 | x | Cb         |
+	 *   | B |   | 1.164384   2.141772   0.000000 |   | Cr         |
+	 */
+	DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB,
+
+	/**
+	 * @DRM_COLOROP_FM_COUNT:
+	 *
+	 * enum value denoting the size of the enum
+	 */
+	DRM_COLOROP_FM_COUNT
+};
+
 /**
  * struct drm_colorop_state - mutable colorop state
  */
@@ -197,6 +305,13 @@ struct drm_colorop_state {
 	 */
 	enum drm_colorop_lut3d_interpolation_type lut3d_interpolation;
 
+	/**
+	 * @fixed_matrix_type:
+	 *
+	 * Type of Fixed Matrix operation.
+	 */
+	enum drm_colorop_fixed_matrix_type fixed_matrix_type;
+
 	/** @state: backpointer to global drm_atomic_commit */
 	struct drm_atomic_commit *state;
 };
@@ -366,6 +481,13 @@ struct drm_colorop {
 	 */
 	struct drm_property *data_property;
 
+	/**
+	 * @fixed_matrix_type_property:
+	 *
+	 * Sub-type for DRM_COLOROP_FIXED_MATRIX type.
+	 */
+	struct drm_property *fixed_matrix_type_property;
+
 	/**
 	 * @next_property:
 	 *
@@ -422,6 +544,10 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
 				 uint32_t lut_size,
 				 enum drm_colorop_lut3d_interpolation_type interpolation,
 				 uint32_t flags);
+int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct drm_colorop *colorop,
+					struct drm_plane *plane,
+					const struct drm_colorop_funcs *funcs,
+					u64 supported_fm, uint32_t flags);
 
 struct drm_colorop_state *
 drm_atomic_helper_colorop_create_state(struct drm_colorop *colorop);
@@ -480,6 +606,7 @@ drm_get_colorop_lut1d_interpolation_name(enum drm_colorop_lut1d_interpolation_ty
 
 const char *
 drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_interpolation_type type);
+const char *drm_get_colorop_fixed_matrix_type_name(enum drm_colorop_fixed_matrix_type type);
 
 void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_colorop *next);
 
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index bd435effdcee..ed1a660a3dfd 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -955,6 +955,18 @@ enum drm_colorop_type {
 	 *         color = lut3d[index]
 	 */
 	DRM_COLOROP_3D_LUT,
+
+	/**
+	 * @DRM_COLOROP_FIXED_MATRIX:
+	 *
+	 * enum string "Fixed Matrix"
+	 *
+	 * A Colorop block that performs a pre-defined matrix operation selected
+	 * via the FIXED_MATRIX_TYPE enum property. The driver advertises the supported
+	 * operations through this property.
+	 */
+	DRM_COLOROP_FIXED_MATRIX,
+
 };
 
 /**
-- 
2.50.1

