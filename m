Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7FCCD98C3
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6946A10E271;
	Tue,  9 Jun 2026 11:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JpkZc9hd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F08510E273;
 Tue,  9 Jun 2026 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H/Rir3hgfFUvZMJD+gSxYcl1pkwtmNMKfLWQ7X9NzEc=; b=JpkZc9hdOk4h8mNcyP2PfQbvoM
 Ki6MEH3Q1HMtzq8wNQ6jh6eBZgMRqqVO2+gneZyZJJf7/8borNYDYeU0RZK1mMuxqFu3FUfdvA34c
 iuxZHlntwIWqd2YlgpZv80EIPJmMKRon/LeG7Rx9nylb+ADpEVf6ugbb4E8QpSegHb32Usan0C/TX
 /k90a9TQGXBxbn+KLFIFILNis57vmiDE1fYuH9suuGJKyCqojd8pzoty3Cy8fUp1sxi697nkoMNur
 PVzTpkWVJ/Pr6HUsMq+5v9EBJWgSBOUtfCLSq/zWcpzJBD9KPOYlsDa2Z6xzwep6i1CV2OlHFCG7k
 SBgZA2+w==;
Received: from [79.117.146.159] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wWuG4-00Etww-56; Tue, 09 Jun 2026 13:04:36 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 christian.koenig@amd.com, contact@emersion.fr, daniels@collabora.com,
 harry.wentland@amd.com, louis.chauvet@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mwen@igalia.com,
 sebastian.wick@redhat.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v9 2/4] drm/colorop: make lut(1/3)d_interpolation props
 correctly behave as mutable
Date: Tue,  9 Jun 2026 12:20:19 +0200
Message-ID: <20260609110420.1298352-3-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609110420.1298352-1-mwen@igalia.com>
References: <20260609110420.1298352-1-mwen@igalia.com>
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

As interpolation props are actually mutable props, any changes should be
handled by drm_colorop_state. Move their enum and make it correctly
behaves as mutable.

Fixes: 7fa3ee8c0a79 ("drm/colorop: Define LUT_1D interpolation")
Fixes: db971856bbe0 ("drm/colorop: Add 3D LUT support to color pipeline")
Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Fixes: 9ba25915efba ("drm/amd/display: Add support for sRGB EOTF in DEGAM block")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic.c      |  4 ++--
 drivers/gpu/drm/drm_atomic_uapi.c |  8 ++++----
 drivers/gpu/drm/drm_colorop.c     | 16 ++++++++++++++--
 include/drm/drm_colorop.h         | 28 ++++++++++++++--------------
 4 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 41c57063f3b4..0eb52d1d5af2 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -830,7 +830,7 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 	case DRM_COLOROP_1D_LUT:
 		drm_printf(p, "\tsize=%d\n", colorop->size);
 		drm_printf(p, "\tinterpolation=%s\n",
-			   drm_get_colorop_lut1d_interpolation_name(colorop->lut1d_interpolation));
+			   drm_get_colorop_lut1d_interpolation_name(state->lut1d_interpolation));
 		drm_printf(p, "\tdata blob id=%d\n", state->data ? state->data->base.id : 0);
 		break;
 	case DRM_COLOROP_CTM_3X4:
@@ -842,7 +842,7 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 	case DRM_COLOROP_3D_LUT:
 		drm_printf(p, "\tsize=%d\n", colorop->size);
 		drm_printf(p, "\tinterpolation=%s\n",
-			   drm_get_colorop_lut3d_interpolation_name(colorop->lut3d_interpolation));
+			   drm_get_colorop_lut3d_interpolation_name(state->lut3d_interpolation));
 		drm_printf(p, "\tdata blob id=%d\n", state->data ? state->data->base.id : 0);
 		break;
 	default:
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 5bd5bf6661df..b81dbba4d8c3 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -751,13 +751,13 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
 	if (property == colorop->bypass_property) {
 		state->bypass = val;
 	} else if (property == colorop->lut1d_interpolation_property) {
-		colorop->lut1d_interpolation = val;
+		state->lut1d_interpolation = val;
 	} else if (property == colorop->curve_1d_type_property) {
 		state->curve_1d_type = val;
 	} else if (property == colorop->multiplier_property) {
 		state->multiplier = val;
 	} else if (property == colorop->lut3d_interpolation_property) {
-		colorop->lut3d_interpolation = val;
+		state->lut3d_interpolation = val;
 	} else if (property == colorop->data_property) {
 		return drm_atomic_color_set_data_property(colorop, state,
 							  property, val);
@@ -782,7 +782,7 @@ drm_atomic_colorop_get_property(struct drm_colorop *colorop,
 	else if (property == colorop->bypass_property)
 		*val = state->bypass;
 	else if (property == colorop->lut1d_interpolation_property)
-		*val = colorop->lut1d_interpolation;
+		*val = state->lut1d_interpolation;
 	else if (property == colorop->curve_1d_type_property)
 		*val = state->curve_1d_type;
 	else if (property == colorop->multiplier_property)
@@ -790,7 +790,7 @@ drm_atomic_colorop_get_property(struct drm_colorop *colorop,
 	else if (property == colorop->size_property)
 		*val = colorop->size;
 	else if (property == colorop->lut3d_interpolation_property)
-		*val = colorop->lut3d_interpolation;
+		*val = state->lut3d_interpolation;
 	else if (property == colorop->data_property)
 		*val = (state->data) ? state->data->base.id : 0;
 	else
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 566816e3c6f0..509678e5371f 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -342,7 +342,6 @@ int drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev, struct drm_color
 
 	colorop->lut1d_interpolation_property = prop;
 	drm_object_attach_property(&colorop->base, prop, interpolation);
-	colorop->lut1d_interpolation = interpolation;
 
 	/* data */
 	ret = drm_colorop_create_data_prop(dev, colorop);
@@ -442,7 +441,6 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
 
 	colorop->lut3d_interpolation_property = prop;
 	drm_object_attach_property(&colorop->base, prop, interpolation);
-	colorop->lut3d_interpolation = interpolation;
 
 	/* data */
 	ret = drm_colorop_create_data_prop(dev, colorop);
@@ -521,6 +519,20 @@ static void __drm_colorop_state_reset(struct drm_colorop_state *colorop_state,
 						      &val);
 		colorop_state->curve_1d_type = val;
 	}
+
+	if (colorop->lut1d_interpolation_property) {
+		if (!drm_object_property_get_default_value(&colorop->base,
+							   colorop->lut1d_interpolation_property,
+							   &val))
+			colorop_state->lut1d_interpolation = val;
+	}
+
+	if (colorop->lut3d_interpolation_property) {
+		if (!drm_object_property_get_default_value(&colorop->base,
+							   colorop->lut3d_interpolation_property,
+							   &val))
+			colorop_state->lut3d_interpolation = val;
+	}
 }
 
 /**
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 61cc8206b4c4..d5b45339333f 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -183,6 +183,20 @@ struct drm_colorop_state {
 	 */
 	struct drm_property_blob *data;
 
+	/**
+	 * @lut1d_interpolation:
+	 *
+	 * Interpolation for DRM_COLOROP_1D_LUT
+	 */
+	enum drm_colorop_lut1d_interpolation_type lut1d_interpolation;
+
+	/**
+	 * @lut3d_interpolation:
+	 *
+	 * Interpolation for DRM_COLOROP_3D_LUT
+	 */
+	enum drm_colorop_lut3d_interpolation_type lut3d_interpolation;
+
 	/** @state: backpointer to global drm_atomic_state */
 	struct drm_atomic_state *state;
 };
@@ -306,20 +320,6 @@ struct drm_colorop {
 	 */
 	uint32_t size;
 
-	/**
-	 * @lut1d_interpolation:
-	 *
-	 * Interpolation for DRM_COLOROP_1D_LUT
-	 */
-	enum drm_colorop_lut1d_interpolation_type lut1d_interpolation;
-
-	/**
-	 * @lut3d_interpolation:
-	 *
-	 * Interpolation for DRM_COLOROP_3D_LUT
-	 */
-	enum drm_colorop_lut3d_interpolation_type lut3d_interpolation;
-
 	/**
 	 * @lut1d_interpolation_property:
 	 *
-- 
2.53.0

