Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7771EC44506
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E49510F27C;
	Wed,  8 Jul 2026 19:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pHdj5Y9+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC26210F27C;
 Wed,  8 Jul 2026 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=T0dd42A00ctVokhWEF9sd6VQ1koAJcKJzWhHp3SsaYA=; b=pHdj5Y9+Ivd6PAwtf5nBMh2LJX
 Eyzw8Nr2xs9XYuoEXUGsC+/ks15y469/G4Ho9s93aQ9zPXPaxtikBsNK0YRlyQBoH5MMTYOoePqeU
 3RrlwOebyNAIp24LNrV442g9vj9WULaoZVZzpm8b1unKnRFXVXHOoj5O49M+Swcd0+a5ilWQTVlSv
 8saim8lPJYgZL8SeGAWcn+eovHWs2AnSWkvr/LQxahPjdRmxyxQDQvj9EtKQYHPBLioByvNgAv/Qz
 +GqgEUkd00Av7/UGkc3RLtzZNrkGcpSmFMtL3kuhCvu46Ju6KztUDnSY/Ht1GanISmCfoE+Dd1jMr
 WrtCnwhg==;
Received: from 100.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.100]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1whYBi-00BtrH-VQ; Wed, 08 Jul 2026 21:44:07 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Louis Chauvet <louis.chauvet@bootlin.com>,
 dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 08/19] drm/colorop: Factor out common paths from colorops
 helpers
Date: Wed,  8 Jul 2026 21:37:23 +0200
Message-ID: <20260708194343.2578387-9-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708194343.2578387-1-mwen@igalia.com>
References: <20260708194343.2578387-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Factor out the common code paths from the colorop helpers so they can be
reused by the post-blend colorop helpers.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_colorop.c | 180 +++++++++++++++++++++-------------
 1 file changed, 114 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 422c70a40bed..a3567b8380e3 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -109,10 +109,11 @@ static const char * const colorop_fixed_matrix_type_names[] = {
 
 /* Init Helpers */
 
-static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *colorop,
-				  struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
-				  enum drm_colorop_type type,
-				  uint32_t flags)
+static int drm_common_colorop_init(struct drm_device *dev,
+				   struct drm_colorop *colorop,
+				   const struct drm_colorop_funcs *funcs,
+				   enum drm_colorop_type type,
+				   uint32_t flags)
 {
 	struct drm_mode_config *config = &dev->mode_config;
 	struct drm_property *prop;
@@ -125,7 +126,6 @@ static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *co
 	colorop->base.properties = &colorop->properties;
 	colorop->dev = dev;
 	colorop->type = type;
-	colorop->plane = plane;
 	colorop->next = NULL;
 	colorop->funcs = funcs;
 
@@ -175,6 +175,22 @@ static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *co
 	return ret;
 }
 
+static int drm_plane_colorop_init(struct drm_device *dev,
+				  struct drm_colorop *colorop,
+				  struct drm_plane *plane,
+				  const struct drm_colorop_funcs *funcs,
+				  enum drm_colorop_type type,
+				  uint32_t flags)
+{
+	int ret;
+
+	ret = drm_common_colorop_init(dev, colorop, funcs, type, flags);
+
+	colorop->plane = plane;
+
+	return ret;
+}
+
 /**
  * drm_colorop_cleanup - Cleanup a drm_colorop object in color_pipeline
  *
@@ -226,45 +242,14 @@ void drm_colorop_pipeline_destroy(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_colorop_pipeline_destroy);
 
-/**
- * drm_plane_colorop_curve_1d_init - Initialize a DRM_COLOROP_1D_CURVE
- *
- * @dev: DRM device
- * @colorop: The drm_colorop object to initialize
- * @plane: The associated drm_plane
- * @funcs: control functions for the new colorop
- * @supported_tfs: A bitfield of supported drm_plane_colorop_curve_1d_init enum values,
- *                 created using BIT(curve_type) and combined with the OR '|'
- *                 operator.
- * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
- * @return zero on success, -E value on failure
- */
-int drm_plane_colorop_curve_1d_init(struct drm_device *dev, struct drm_colorop *colorop,
-				    struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
-				    u64 supported_tfs, uint32_t flags)
+static int drm_common_colorop_curve_1d_init(struct drm_device *dev,
+					    struct drm_colorop *colorop,
+					    u64 supported_tfs, uint32_t flags)
 {
 	struct drm_prop_enum_list enum_list[DRM_COLOROP_1D_CURVE_COUNT];
 	int i, len;
 
 	struct drm_property *prop;
-	int ret;
-
-	if (!supported_tfs) {
-		drm_err(dev,
-			"No supported TFs for new 1D curve colorop on [PLANE:%d:%s]\n",
-			plane->base.id, plane->name);
-		return -EINVAL;
-	}
-
-	if ((supported_tfs & -BIT(DRM_COLOROP_1D_CURVE_COUNT)) != 0) {
-		drm_err(dev, "Unknown TF provided on [PLANE:%d:%s]\n",
-			plane->base.id, plane->name);
-		return -EINVAL;
-	}
-
-	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_1D_CURVE, flags);
-	if (ret)
-		return ret;
 
 	len = 0;
 	for (i = 0; i < DRM_COLOROP_1D_CURVE_COUNT; i++) {
@@ -293,6 +278,45 @@ int drm_plane_colorop_curve_1d_init(struct drm_device *dev, struct drm_colorop *
 
 	return 0;
 }
+
+static int drm_colorop_has_supported_tf(struct drm_device *dev, struct drm_mode_object *obj,
+					const char *name, u64 supported_tfs)
+{
+	if (!supported_tfs) {
+		drm_err(dev,
+			"No supported TFs for new 1D curve colorop on [PLANE:%d:%s]\n",
+			obj->id, name);
+		return -EINVAL;
+	}
+
+	if ((supported_tfs & -BIT(DRM_COLOROP_1D_CURVE_COUNT)) != 0) {
+		drm_err(dev, "Unknown TF provided on [PLANE:%d:%s]\n",
+			obj->id, name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int drm_plane_colorop_curve_1d_init(struct drm_device *dev,
+				    struct drm_colorop *colorop,
+				    struct drm_plane *plane,
+				    const struct drm_colorop_funcs *funcs,
+				    u64 supported_tfs,
+				    uint32_t flags)
+{
+	int ret;
+
+	ret = drm_colorop_has_supported_tf(dev, &plane->base, plane->name, supported_tfs);
+	if (ret)
+		return ret;
+
+	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_1D_CURVE, flags);
+	if (ret)
+		return ret;
+
+	return drm_common_colorop_curve_1d_init(dev, colorop, supported_tfs, flags);
+}
 EXPORT_SYMBOL(drm_plane_colorop_curve_1d_init);
 
 static int drm_colorop_create_data_prop(struct drm_device *dev, struct drm_colorop *colorop)
@@ -313,32 +337,15 @@ static int drm_colorop_create_data_prop(struct drm_device *dev, struct drm_color
 	return 0;
 }
 
-/**
- * drm_plane_colorop_curve_1d_lut_init - Initialize a DRM_COLOROP_1D_LUT
- *
- * @dev: DRM device
- * @colorop: The drm_colorop object to initialize
- * @plane: The associated drm_plane
- * @funcs: control functions for new colorop
- * @lut_size: LUT size supported by driver
- * @interpolation: 1D LUT interpolation type
- * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
- * @return zero on success, -E value on failure
- */
-int drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev, struct drm_colorop *colorop,
-					struct drm_plane *plane,
-					const struct drm_colorop_funcs *funcs,
-					uint32_t lut_size,
-					enum drm_colorop_lut1d_interpolation_type interpolation,
-					uint32_t flags)
+static int drm_common_colorop_curve_1d_lut_init(struct drm_device *dev,
+						struct drm_colorop *colorop,
+						uint32_t lut_size,
+						enum drm_colorop_lut1d_interpolation_type interpolation,
+						uint32_t flags)
 {
 	struct drm_property *prop;
 	int ret;
 
-	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_1D_LUT, flags);
-	if (ret)
-		return ret;
-
 	/* initialize 1D LUT only attribute */
 	/* LUT size */
 	prop = drm_property_create_range(dev, DRM_MODE_PROP_IMMUTABLE | DRM_MODE_PROP_ATOMIC,
@@ -369,18 +376,44 @@ int drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev, struct drm_color
 
 	return 0;
 }
-EXPORT_SYMBOL(drm_plane_colorop_curve_1d_lut_init);
 
-int drm_plane_colorop_ctm_3x4_init(struct drm_device *dev, struct drm_colorop *colorop,
-				   struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
-				   uint32_t flags)
+/**
+ * drm_plane_colorop_curve_1d_lut_init - Initialize a DRM_COLOROP_1D_LUT
+ *
+ * @dev: DRM device
+ * @colorop: The drm_colorop object to initialize
+ * @plane: The associated drm_plane
+ * @lut_size: LUT size supported by driver
+ * @lut1d_interpolation: 1D LUT interpolation type
+ * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
+ * @return zero on success, -E value on failure
+ */
+int
+drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev,
+				    struct drm_colorop *colorop,
+				    struct drm_plane *plane,
+				    const struct drm_colorop_funcs *funcs,
+				    uint32_t lut_size,
+				    enum drm_colorop_lut1d_interpolation_type lut1d_interpolation,
+				    uint32_t flags)
 {
 	int ret;
 
-	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_CTM_3X4, flags);
+	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_1D_LUT, flags);
 	if (ret)
 		return ret;
 
+	return drm_common_colorop_curve_1d_lut_init(dev, colorop, lut_size,
+						    lut1d_interpolation, flags);
+}
+EXPORT_SYMBOL(drm_plane_colorop_curve_1d_lut_init);
+
+static int drm_common_colorop_ctm_3x4_init(struct drm_device *dev,
+					   struct drm_colorop *colorop,
+					   uint32_t flags)
+{
+	int ret;
+
 	ret = drm_colorop_create_data_prop(dev, colorop);
 	if (ret)
 		return ret;
@@ -389,6 +422,21 @@ int drm_plane_colorop_ctm_3x4_init(struct drm_device *dev, struct drm_colorop *c
 
 	return 0;
 }
+
+int drm_plane_colorop_ctm_3x4_init(struct drm_device *dev,
+				   struct drm_colorop *colorop,
+				   struct drm_plane *plane,
+				   const struct drm_colorop_funcs *funcs,
+				   uint32_t flags)
+{
+	int ret;
+
+	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_CTM_3X4, flags);
+	if (ret)
+		return ret;
+
+	return drm_common_colorop_ctm_3x4_init(dev, colorop, flags);
+}
 EXPORT_SYMBOL(drm_plane_colorop_ctm_3x4_init);
 
 /**
-- 
2.53.0

