Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F5AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C0810F277;
	Wed,  8 Jul 2026 19:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fwQBsuoN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C1D10F264;
 Wed,  8 Jul 2026 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g2gFe0ryYdUdJRocri9LN2xg4yLKDgHAX0vgmCaHB0I=; b=fwQBsuoNRBFoaLxRwQCo4asg8J
 AZyWgk3HUj13rwO0O7jmsX6WvWxICV+1HwXA7fe3qEPkLylCsPhbDTcwCsbdYBvPye64pexHNeoHL
 5od74uY4rgRXURkXgexCe4uDBt9Eg7FaCkOJ0Cm3CYgXjE4+w0QUngh52WwT61K8KMk/EGKnnEBBn
 VkptqAv5R0fk404b2USHwh0LluBwpqHDhdSf7yqc7rj7XTC2TOeLpf3dtsmVOLxQd55bb5JeWz68O
 whvAmbtE4gFRKnoSMwlh7mJ4nAi5Vfzi4N2jN5cCzniGMicwlwJ0C4JfDPQBkEmDEmHEVys3eTBlc
 vfyoZUgA==;
Received: from 100.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.100]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1whYBX-00BtrH-60; Wed, 08 Jul 2026 21:43:55 +0200
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
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 04/19] drm/crtc: Add COLOR_PIPELINE property
Date: Wed,  8 Jul 2026 21:37:19 +0200
Message-ID: <20260708194343.2578387-5-mwen@igalia.com>
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

Add a COLOR_PIPELINE property to the CRTC to allow userspace to set a
post-blend color pipeline analogously to how pre-blend color pipelines
are set on planes.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 50 ++++++++++++++++++++++++++++---
 drivers/gpu/drm/drm_crtc.c        | 31 +++++++++++++++++++
 include/drm/drm_atomic_uapi.h     |  2 ++
 include/drm/drm_crtc.h            | 11 +++++++
 4 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index d52504d823bc..9b4a32f1b694 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -294,6 +294,34 @@ drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
 }
 EXPORT_SYMBOL(drm_atomic_set_colorop_for_plane);
 
+/**
+ * drm_atomic_set_colorop_for_crtc - set colorop for crtc
+ * @crtc_state: atomic state object for the crtc
+ * @colorop: colorop to use for the crtc
+ *
+ * Helper function to select the color pipeline on a crtc by setting
+ * it to the first drm_colorop element of the pipeline.
+ */
+void
+drm_atomic_set_colorop_for_crtc(struct drm_crtc_state *crtc_state,
+				 struct drm_colorop *colorop)
+{
+	struct drm_crtc *crtc = crtc_state->crtc;
+
+	if (colorop)
+		drm_dbg_atomic(crtc->dev,
+			       "Set [COLOROP:%d] for [CRTC:%d:%s] state %p\n",
+			       colorop->base.id, crtc->base.id, crtc->name,
+			       crtc_state);
+	else
+		drm_dbg_atomic(crtc->dev,
+			       "Set [NOCOLOROP] for [CRTC:%d:%s] state %p\n",
+			       crtc->base.id, crtc->name, crtc_state);
+
+	crtc_state->color_pipeline = colorop;
+}
+EXPORT_SYMBOL(drm_atomic_set_colorop_for_crtc);
+
 /**
  * drm_atomic_set_crtc_for_connector - set CRTC for connector
  * @conn_state: atomic state object for the connector
@@ -402,8 +430,8 @@ static s32 __user *get_out_fence_for_connector(struct drm_atomic_commit *state,
 }
 
 static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
-		struct drm_crtc_state *state, struct drm_property *property,
-		uint64_t val)
+		struct drm_crtc_state *state, struct drm_file *file_priv,
+		struct drm_property *property, uint64_t val)
 {
 	struct drm_device *dev = crtc->dev;
 	struct drm_mode_config *config = &dev->mode_config;
@@ -412,7 +440,17 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 
 	if (property == config->prop_active)
 		state->active = val;
-	else if (property == config->prop_mode_id) {
+	else if (property == crtc->color_pipeline_property) {
+		/* find DRM colorop object */
+		struct drm_colorop *colorop = NULL;
+
+		colorop = drm_colorop_find(dev, file_priv, val);
+
+		if (val && !colorop)
+			return -EACCES;
+
+		drm_atomic_set_colorop_for_crtc(state, colorop);
+	} else if (property == config->prop_mode_id) {
 		struct drm_property_blob *mode =
 			drm_property_lookup_blob(dev, val);
 		ret = drm_atomic_set_mode_prop_for_crtc(state, mode);
@@ -519,6 +557,8 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
 		*val = state->scaling_filter;
 	else if (property == crtc->sharpness_strength_property)
 		*val = state->sharpness_strength;
+	else if (property == crtc->color_pipeline_property)
+		*val = (state->color_pipeline) ? state->color_pipeline->base.id : 0;
 	else if (crtc->funcs->atomic_get_property)
 		return crtc->funcs->atomic_get_property(crtc, state, property, val);
 	else {
@@ -1106,6 +1146,8 @@ int drm_atomic_get_property(struct drm_mode_object *obj,
 
 		if (colorop->plane)
 			WARN_ON(!drm_modeset_is_locked(&colorop->plane->mutex));
+		else if (colorop->crtc)
+			WARN_ON(!drm_modeset_is_locked(&colorop->crtc->mutex));
 
 		ret = drm_atomic_colorop_get_property(colorop, colorop->state, property, val);
 		break;
@@ -1262,7 +1304,7 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 		}
 
 		ret = drm_atomic_crtc_set_property(crtc,
-				crtc_state, prop, prop_value);
+				crtc_state, file_priv, prop, prop_value);
 		break;
 	}
 	case DRM_MODE_OBJECT_PLANE: {
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 63ead8ba6756..a0d82ba92f6c 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -991,3 +991,34 @@ bool drm_crtc_in_clone_mode(struct drm_crtc_state *crtc_state)
 	return hweight32(crtc_state->encoder_mask) > 1;
 }
 EXPORT_SYMBOL(drm_crtc_in_clone_mode);
+
+/**
+ * drm_crtc_create_color_pipeline_property - create a new color pipeline
+ * property
+ *
+ * @crtc: drm CRTC
+ * @pipelines: list of pipelines
+ * @num_pipelines: number of pipelines
+ *
+ * Create the COLOR_PIPELINE CRTC property to specify color pipelines on
+ * the CRTC.
+ *
+ * RETURNS:
+ * Zero for success or -errno
+ */
+int drm_crtc_create_color_pipeline_property(struct drm_crtc *crtc,
+					    const struct drm_prop_enum_list *pipelines,
+					    int num_pipelines)
+{
+	struct drm_property *prop;
+
+	prop = drm_property_create_color_pipeline(crtc->dev, &crtc->base,
+						  pipelines, num_pipelines);
+	if (IS_ERR(prop))
+		return PTR_ERR(prop);
+
+	crtc->color_pipeline_property = prop;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_crtc_create_color_pipeline_property);
diff --git a/include/drm/drm_atomic_uapi.h b/include/drm/drm_atomic_uapi.h
index 4e7e78f711e2..90e5c207a53b 100644
--- a/include/drm/drm_atomic_uapi.h
+++ b/include/drm/drm_atomic_uapi.h
@@ -54,6 +54,8 @@ void drm_atomic_set_fb_for_plane(struct drm_plane_state *plane_state,
 				 struct drm_framebuffer *fb);
 bool drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
 				      struct drm_colorop *colorop);
+void drm_atomic_set_colorop_for_crtc(struct drm_crtc_state *crtc_state,
+				     struct drm_colorop *colorop);
 int __must_check
 drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 				  struct drm_crtc *crtc);
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 30afa05b7c0f..5852b506c614 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -1141,6 +1141,14 @@ struct drm_crtc {
 	 */
 	struct drm_property *sharpness_strength_property;
 
+	/**
+	 * @color_pipeline_property:
+	 *
+	 * Optional "COLOR_PIPELINE" enum property for specifying
+	 * a color pipeline to use on the CRTC.
+	 */
+	struct drm_property *color_pipeline_property;
+
 	/**
 	 * @state:
 	 *
@@ -1376,6 +1384,9 @@ static inline struct drm_crtc *drm_crtc_find(struct drm_device *dev,
 
 int drm_crtc_create_scaling_filter_property(struct drm_crtc *crtc,
 					    unsigned int supported_filters);
+int drm_crtc_create_color_pipeline_property(struct drm_crtc *crtc,
+					     const struct drm_prop_enum_list *pipelines,
+					     int num_pipelines);
 bool drm_crtc_in_clone_mode(struct drm_crtc_state *crtc_state);
 int drm_crtc_create_sharpness_strength_property(struct drm_crtc *crtc);
 #endif /* __DRM_CRTC_H__ */
-- 
2.53.0

