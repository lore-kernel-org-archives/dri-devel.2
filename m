Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C98C44507
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C6F10F270;
	Wed,  8 Jul 2026 19:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QXYyFRcB";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BB410F262;
 Wed,  8 Jul 2026 19:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HAeo0RZH52dXqAgB9XDU8dBq6yXWaateAKX3L4UJFMI=; b=QXYyFRcBB8wpuhETjlnOd8DwcA
 vxUNxd63ZpF+l58CWIXWfGITSvOSK+bjOSwc+fIlXO7E/O7X3std5Nbs+9Q0DtMkoHImbpK5DcF+Z
 IcGn645GX5xsPfU0mcuiir3fVB53kzEPXD6GEb7iPzV25m0N2/Xp5E4+jxnn9v4H5ygStvckNW/jO
 Jawm/HBGVPrv0WeVnPdgQYPZtChS6HZMsjLP4fhi/XSD6tOJS/uUYRkGLhTt36m1EDJNdo+Oo/QcB
 JI/ER8q9DCf31FQZzwMuvFvwyX5CuSZ+i1P4QhwP+lwVSb2Ypw4VQ7FurjK0wSxl2Y4lUkOZPOM/y
 1j5jEALg==;
Received: from 100.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.100]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1whYBY-00BtrH-DB; Wed, 08 Jul 2026 21:43:56 +0200
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
Subject: [RFC PATCH 05/19] drm: Introduce DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE
Date: Wed,  8 Jul 2026 21:37:20 +0200
Message-ID: <20260708194343.2578387-6-mwen@igalia.com>
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

Introduce DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE which a DRM client can set
to enable the usage of CRTC (post-blend) color pipelines instead of the
now deprecated CRTC color management properties: "GAMMA_LUT",
"DEGAMMA_LUT" and "CTM".

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c   | 21 +++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c     |  1 +
 drivers/gpu/drm/drm_crtc_internal.h |  1 +
 drivers/gpu/drm/drm_ioctl.c         |  7 +++++++
 drivers/gpu/drm/drm_mode_object.c   |  9 +++++++++
 include/drm/drm_file.h              |  7 +++++++
 include/uapi/drm/drm.h              | 19 +++++++++++++++++++
 7 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 9b4a32f1b694..8f9c11bd94c6 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -441,6 +441,11 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 	if (property == config->prop_active)
 		state->active = val;
 	else if (property == crtc->color_pipeline_property) {
+		if (!file_priv->crtc_color_pipeline) {
+			drm_dbg_atomic(dev,
+				"Setting COLOR_PIPELINE CRTC property not permitted without DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE client cap\n");
+			return -EINVAL;
+		}
 		/* find DRM colorop object */
 		struct drm_colorop *colorop = NULL;
 
@@ -462,6 +467,11 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		const size_t elem_size = sizeof(struct drm_color_lut);
 		u64 lut_size;
 
+		if (file_priv->crtc_color_pipeline) {
+			drm_dbg_atomic(dev,
+				"Setting DEGAMMA_LUT CRTC property not permitted with DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE client cap\n");
+			return -EINVAL;
+		}
 		ret = drm_object_immutable_property_get_value(&crtc->base,
 							      config->degamma_lut_size_property,
 							      &lut_size);
@@ -476,6 +486,11 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		state->color_mgmt_changed |= replaced;
 		return ret;
 	} else if (property == config->ctm_property) {
+		if (file_priv->crtc_color_pipeline) {
+			drm_dbg_atomic(dev,
+				"Setting CTM CRTC property not permitted with DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE client cap\n");
+			return -EINVAL;
+		}
 		ret = drm_property_replace_blob_from_id(dev,
 					&state->ctm,
 					val,
@@ -487,6 +502,12 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		const size_t elem_size = sizeof(struct drm_color_lut);
 		u64 lut_size;
 
+		if (file_priv->crtc_color_pipeline) {
+			drm_dbg_atomic(dev,
+				"Setting GAMMA_LUT CRTC property not permitted with DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE client cap\n");
+			return -EINVAL;
+		}
+
 		ret = drm_object_immutable_property_get_value(&crtc->base,
 							      config->gamma_lut_size_property,
 							      &lut_size);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index cbb067d02cb9..2c1a6c6294d3 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3625,6 +3625,7 @@ int drm_mode_getconnector(struct drm_device *dev, void *data,
 	 */
 	ret = drm_mode_object_get_properties(&connector->base, file_priv->atomic,
 			file_priv->plane_color_pipeline,
+			file_priv->crtc_color_pipeline,
 			(uint32_t __user *)(unsigned long)(out_resp->props_ptr),
 			(uint64_t __user *)(unsigned long)(out_resp->prop_values_ptr),
 			&out_resp->count_props);
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 83146ffef00c..9752bf3c29ca 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -164,6 +164,7 @@ void drm_mode_object_unregister(struct drm_device *dev,
 				struct drm_mode_object *object);
 int drm_mode_object_get_properties(struct drm_mode_object *obj, bool atomic,
 				   bool plane_color_pipeline,
+				   bool crtc_color_pipeline,
 				   uint32_t __user *prop_ptr,
 				   uint64_t __user *prop_values,
 				   uint32_t *arg_count_props);
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index ff193155129e..ae374733e154 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -380,6 +380,13 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 			return -EINVAL;
 		file_priv->plane_color_pipeline = req->value;
 		break;
+	case DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE:
+		if (!file_priv->atomic)
+			return -EINVAL;
+		if (req->value > 1)
+			return -EINVAL;
+		file_priv->crtc_color_pipeline = req->value;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 21fc9deda437..e9f317126035 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -413,6 +413,7 @@ EXPORT_SYMBOL(drm_object_immutable_property_get_value);
 /* helper for getconnector and getproperties ioctls */
 int drm_mode_object_get_properties(struct drm_mode_object *obj, bool atomic,
 				   bool plane_color_pipeline,
+				   bool crtc_color_pipeline,
 				   uint32_t __user *prop_ptr,
 				   uint64_t __user *prop_values,
 				   uint32_t *arg_count_props)
@@ -441,6 +442,13 @@ int drm_mode_object_get_properties(struct drm_mode_object *obj, bool atomic,
 				continue;
 		}
 
+		if (!crtc_color_pipeline && obj->type == DRM_MODE_OBJECT_CRTC) {
+			struct drm_crtc *crtc = obj_to_crtc(obj);
+
+			if (prop == crtc->color_pipeline_property)
+				continue;
+		}
+
 		if (*arg_count_props > count) {
 			ret = __drm_object_property_get_value(obj, prop, &val);
 			if (ret)
@@ -500,6 +508,7 @@ int drm_mode_obj_get_properties_ioctl(struct drm_device *dev, void *data,
 
 	ret = drm_mode_object_get_properties(obj, file_priv->atomic,
 			file_priv->plane_color_pipeline,
+			file_priv->crtc_color_pipeline,
 			(uint32_t __user *)(unsigned long)(arg->props_ptr),
 			(uint64_t __user *)(unsigned long)(arg->prop_values_ptr),
 			&arg->count_props);
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 6ee70ad65e1f..d0c323378ae4 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -214,6 +214,13 @@ struct drm_file {
 	 */
 	bool plane_color_pipeline;
 
+	/**
+	 * @crtc_color_pipeline:
+	 *
+	 * True if client understands CRTC (post-blend) color pipelines
+	 */
+	bool crtc_color_pipeline;
+
 	/**
 	 * @was_master:
 	 *
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index bc7ef7684099..514c8f4b3aaf 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -903,6 +903,25 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
 
+/**
+ * DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE
+ *
+ * If set to 1 the DRM core will allow setting the COLOR_PIPELINE
+ * property on a &drm_crtc, as well as drm_colorop properties.
+ *
+ * Setting of these crtc properties will be rejected when this client
+ * cap is set:
+ * - GAMMA_LUT
+ * - DEGAMMA_LUT
+ * - CTM
+ *
+ * The client must enable &DRM_CLIENT_CAP_ATOMIC first.
+ *
+ * This client cap can only be set if the driver sets the corresponding driver
+ * cap &DRM_CAP_CRTC_COLOR_PIPELINE.
+ */
+#define DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE	8
+
 /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
-- 
2.53.0

