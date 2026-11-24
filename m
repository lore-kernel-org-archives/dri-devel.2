Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26588606A323
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=e0MOXOaM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77F710F7FD;
	Tue, 24 Nov 2026 18:18:44 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDEB410F081;
 Tue, 24 Nov 2026 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=pPlGh0h8Rsmy3c877rM0KUe9GynXMZW3yEpQ1J8MDJk=; t=1795544301; x=2110904301; 
 b=e0MOXOaMJbAQTPlyDPLMuk14SKKPmRVL6PHdeQtthpVT78T83V3UEiUg9mUsNEH3qdcZBK6YvxR
 gJOqGAxItxEBwArf55Vg9pYyLmsMDpwGObeBpMZGE+wEyZxUzgcHgadBzkw1Nkt9KddzoCfWIlgQx
 q9iJd3LZ28nTZw2bCiD5ZFPKnYoFW1vUGisi1i5j6nkWWrW2oQvD7oOD/JjNkIGhvgbe33n3pCLWT
 9AHqgw4pb3y6uvO7zwgofTzz7aoSQz593AZipWaP+oqybf7Z7Wf77+DaZJYe1SwrICcHExE/df+jH
 BBLS5tqO4JetFZDa6wrBkXhGXuU3DgySBNGA==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5m-00000003axM-1r2C; Tue, 24 Nov 2026 19:18:10 +0100
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
Subject: [PATCH v3 08/19] drm: Introduce DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE
Date: Tue, 24 Nov 2026 19:03:25 +0100
Message-ID: <20261124181652.1333986-9-mwen@igalia.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Introduce DRM_CLIENT_CAP_CRTC_COLOR_PIPELINE which a DRM client can set
to enable the usage of CRTC (post-blend) color pipelines instead of the
now deprecated CRTC color management properties: "GAMMA_LUT",
"DEGAMMA_LUT" and "CTM".

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- rebase on drm-misc-next, no other changes
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
index 183716cf0db9..195aaed55e7a 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -448,6 +448,11 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
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
 
@@ -470,6 +475,11 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
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
@@ -484,6 +494,11 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
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
@@ -495,6 +510,12 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
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
index d66188521881..a9a9aff02d30 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3767,6 +3767,7 @@ int drm_mode_getconnector(struct drm_device *dev, void *data,
 	 */
 	ret = drm_mode_object_get_properties(&connector->base, file_priv->atomic,
 			file_priv->plane_color_pipeline,
+			file_priv->crtc_color_pipeline,
 			(uint32_t __user *)(unsigned long)(out_resp->props_ptr),
 			(uint64_t __user *)(unsigned long)(out_resp->prop_values_ptr),
 			&out_resp->count_props);
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 3492787c3697..0e5def171222 100644
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
index 9039a39c4324..3e57453ef258 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -392,6 +392,13 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 		file_priv->plane_color_pipeline = req->value;
 		break;
 	}
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

