Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE80CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 19:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E05D10EE7B;
	Wed,  6 May 2026 19:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gYjH9Yn7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4C010EE7B;
 Wed,  6 May 2026 19:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hYqit04eLoTNv29GYN5qDqvnnNiY3Y9u0r+UiBBIIak=; b=gYjH9Yn7PemEE0cIIBP083xKvs
 Di+HekFwQHKgZ0H0CFcCBmuWWDbVUFjhiMJnWbx3ObVjtRYoHVzx5w5lN1fLbZBSwIz2rzEjHIXDz
 hBslQsdDO3xqUrwLjtTuHSclJK30U7KpZOag+uNHjUxq+baIgKV9wCEriHxTAsvst6BqCSYdNszxy
 5zsHFLcaOv9KYE2eljjekUTKRiEnAs9GsemWYf/IPA1ffhvy6MujQc98Jb09AqN+zZVOoQA0k/nzP
 NSFoYsHJd1gFZ7Kh2SX1L9sENs3WFpYU0P7yGSgtvjPh6WeFTcHNdY4ojROwDvwpf7fkJ09ZXMyJs
 NiJqSHfw==;
Received: from [186.208.73.228] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wKhtu-0072dZ-Gl; Wed, 06 May 2026 21:27:18 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v5 4/6] drm/colorop: make lut(1/3)d_interpolation mutable
Date: Wed,  6 May 2026 16:23:50 -0300
Message-ID: <20260506192633.16066-5-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506192633.16066-1-mwen@igalia.com>
References: <20260506192633.16066-1-mwen@igalia.com>
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

As it's not immutable anymore, any changes should be handled by
drm_colorop_state. Move their enum and make it correctly behaves as
mutable.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic.c      |  4 ++--
 drivers/gpu/drm/drm_atomic_uapi.c |  8 ++++----
 drivers/gpu/drm/drm_colorop.c     | 16 ++++++++++++++--
 include/drm/drm_colorop.h         | 28 ++++++++++++++--------------
 4 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 8eb519673fc5..1386172af92b 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -830,7 +830,7 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 	case DRM_COLOROP_1D_LUT:
 		drm_printf_indent(p, 1, "size=%d\n", colorop->size);
 		drm_printf_indent(p, 1, "interpolation=%s\n",
-				  drm_get_colorop_lut1d_interpolation_name(colorop->lut1d_interpolation));
+				  drm_get_colorop_lut1d_interpolation_name(state->lut1d_interpolation));
 		drm_printf_indent(p, 1, "data blob id=%d\n", state->data ? state->data->base.id : 0);
 		break;
 	case DRM_COLOROP_CTM_3X4:
@@ -842,7 +842,7 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 	case DRM_COLOROP_3D_LUT:
 		drm_printf_indent(p, 1, "size=%d\n", colorop->size);
 		drm_printf_indent(p, 1, "interpolation=%s\n",
-				  drm_get_colorop_lut3d_interpolation_name(colorop->lut3d_interpolation));
+				  drm_get_colorop_lut3d_interpolation_name(state->lut3d_interpolation));
 		drm_printf_indent(p, 1, "data blob id=%d\n", state->data ? state->data->base.id : 0);
 		break;
 	default:
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index bff8d58f8f12..25fe94410af7 100644
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
index 764d12060666..b6930ef278c3 100644
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
 							   &val))
 			colorop_state->curve_1d_type = val;
 	}
+
+	if (colorop->lut1d_interpolation_property) {
+		drm_object_property_get_default_value(&colorop->base,
+						      colorop->lut1d_interpolation_property,
+						      &val);
+		colorop_state->lut1d_interpolation = val;
+	}
+
+	if (colorop->lut3d_interpolation_property) {
+		drm_object_property_get_default_value(&colorop->base,
+						      colorop->lut3d_interpolation_property,
+						      &val);
+		colorop_state->lut3d_interpolation = val;
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

