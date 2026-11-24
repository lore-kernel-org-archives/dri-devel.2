Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E991606A697
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=JiPFBE6z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11A910F82D;
	Tue, 24 Nov 2026 18:18:38 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 852E510F082;
 Tue, 24 Nov 2026 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=KccyM5TjpjlktLv/mxqQWoDkztTOxUn9SEHj3qJ8Q1w=; t=1795544304; x=2110904304; 
 b=JiPFBE6zgTqOk14CyqrKhz6hA92hhA1CSA3GtVavKwDIYytck6COOzwX0GtYA2M4Gp1YvGH2L0c
 gIl0OTIvRcUaT7q/2/fvM8rQLhVWmejVUKx+95i+yQ79Q6Hv0ifBH21501mGqW+mJR0cTNLw2EL7f
 V87QdhEwgbQV8ApjvCOs7r5QUk6T5Hjsr5i8peyjBic1YpLMEcBXN+UIWT20tq1fdi+xOujKhYXVW
 VA98497z9c5XXglna1vDPCBpI0NfvAuyn3Uijb7VAYOE+8pjFSgiEcSwBfVVCDQuqaun5TjbaabGm
 CE87RL1aWe42MwAxrrblF4EsNyGhrYrJcQ7A==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5q-00000003axM-0gxU; Tue, 24 Nov 2026 19:18:14 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 nfraprado@collabora.com, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Daniel Stone <daniels@collabora.com>, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>
Subject: [PATCH v3 10/19] drm/colorop: Factor out common paths from colorops
 helpers
Date: Tue, 24 Nov 2026 19:03:27 +0100
Message-ID: <20261124181652.1333986-11-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124181652.1333986-1-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Factor out the common code paths from the colorop helpers so they can be
reused by the post-blend colorop helpers.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- rebase on drm-misc-next, no other changes
---
 drivers/gpu/drm/drm_colorop.c | 180 +++++++++++++++++++++-------------
 1 file changed, 114 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 6b15df55c84f..baef70460da9 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -103,10 +103,11 @@ static const char * const colorop_fixed_matrix_type_names[] = {
 
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
@@ -119,7 +120,6 @@ static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *co
 	colorop->base.properties = &colorop->properties;
 	colorop->dev = dev;
 	colorop->type = type;
-	colorop->plane = plane;
 	colorop->next = NULL;
 	colorop->funcs = funcs;
 
@@ -169,6 +169,22 @@ static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *co
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
@@ -220,45 +236,14 @@ void drm_colorop_pipeline_destroy(struct drm_device *dev)
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
@@ -287,6 +272,45 @@ int drm_plane_colorop_curve_1d_init(struct drm_device *dev, struct drm_colorop *
 
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
@@ -307,32 +331,15 @@ static int drm_colorop_create_data_prop(struct drm_device *dev, struct drm_color
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
@@ -363,18 +370,44 @@ int drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev, struct drm_color
 
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
@@ -383,6 +416,21 @@ int drm_plane_colorop_ctm_3x4_init(struct drm_device *dev, struct drm_colorop *c
 
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

