Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E4DC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1DFF10F287;
	Wed,  8 Jul 2026 19:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ScNy4CMv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0434C10F287;
 Wed,  8 Jul 2026 19:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Hv3wmL7ypIqw04FS5X4dARu+I4jYPp3ZeAa9B0ydbFY=; b=ScNy4CMvMLanR04bFi4RFseNae
 prwkQy8vV3oCiJslx7DK+8SEXkCQrywurQDfDfcT+xlSBNBP79cgyf/tAbNcPCYIzrn/yLHEHm9qq
 jftFRxnOlnZqLHaBiquV1YBsmramzeCLykn2vd8XAhQqhHVHe/CaH4vmxH7/6oHgQkcJ/ebEAIgD7
 SFKIj0r6CNCYk/aTJVlObPbgmWkhoUUHADKBz3DK5YsF+0cwimvnAiOWsS7v2T6vVo4FmLcOBmwAY
 B2q1Wn8xQXCQKCnX5LmC7vouKk1Mx9DSwS78WNKl1EUQ5OpILpoXHTiOOJFnyOtaHWlw1zLiQiHh4
 Kd5gTSBg==;
Received: from 100.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.100]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1whYCy-00BtrH-BW; Wed, 08 Jul 2026 21:45:24 +0200
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
Subject: [RFC PATCH 15/19] drm/amd/display: add support to post-blend CTM
 colorop
Date: Wed,  8 Jul 2026 21:37:30 +0200
Message-ID: <20260708194343.2578387-16-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708194343.2578387-1-mwen@igalia.com>
References: <20260708194343.2578387-1-mwen@igalia.com>
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

Initialize the AMD post-blend color pipeline with CTM as the first color
operation in the AMD post-blend color pipeline. AMD post-blend color
pipeline for DCN3 is described in `DCN 3.0 family color caps and
mapping` of the kernel doc.

Link: https://dri.freedesktop.org/docs/drm/gpu/amdgpu/display/display-manager.html#dc-color-capabilities-between-dcn-generations
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 81 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 38 +++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |  2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 38 +++++++++
 5 files changed, 162 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 74f700fbeb6f..1c890ded8f9b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1100,6 +1100,9 @@ int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);
 int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
 int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
 				    bool check_only);
+int amdgpu_dm_crtc_set_colorop_properties(struct drm_crtc_state *crtc_state,
+					  struct dc_stream_state *dc_stream_state,
+					  bool check_only);
 int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 				      struct drm_plane_state *plane_state,
 				      struct dc_plane_state *dc_plane_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 54b3c163a36c..20996af68f04 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1176,6 +1176,87 @@ int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)
 	return 0;
 }
 
+static int
+__set_dm_crtc_colorop_3x4_matrix(struct drm_crtc_state *crtc_state,
+				 struct dc_stream_state *dc_stream_state,
+				 struct drm_colorop *colorop,
+				 bool check_only)
+{
+	struct drm_colorop_state *colorop_state = NULL;
+	struct drm_atomic_commit *state = crtc_state->state;
+	const struct drm_property_blob *blob;
+	struct drm_color_ctm_3x4 *ctm = NULL;
+
+	/* If CRTC COLOR_PIPELINE property == Bypass */
+	if (!colorop) {
+		if (!check_only) {
+			dc_stream_state->gamut_remap_matrix.enable_remap = false;
+			dc_stream_state->csc_color_matrix.enable_adjustment = false;
+		}
+		return 0;
+	}
+
+	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+
+	if (colorop_state && colorop->type == DRM_COLOROP_CTM_3X4) {
+		if (colorop_state->bypass) {
+			if (!check_only) {
+				dc_stream_state->gamut_remap_matrix.enable_remap = false;
+				dc_stream_state->csc_color_matrix.enable_adjustment = false;
+			}
+		} else {
+			drm_dbg(state->dev, "3x4 matrix colorop with ID: %d\n", colorop->base.id);
+			blob = colorop_state->data;
+			if (blob->length != sizeof(struct drm_color_ctm_3x4)) {
+				drm_warn(state->dev, "blob->length (%zu) isn't equal to drm_color_ctm_3x4 (%zu)\n",
+					 blob->length, sizeof(struct drm_color_ctm_3x4));
+				return -EINVAL;
+			}
+			if (!check_only) {
+				ctm = (struct drm_color_ctm_3x4 *) blob->data;
+				__drm_ctm_3x4_to_dc_matrix(ctm, dc_stream_state->gamut_remap_matrix.matrix);
+				dc_stream_state->gamut_remap_matrix.enable_remap = true;
+				dc_stream_state->csc_color_matrix.enable_adjustment = false;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * amdgpu_dm_crtc_set_colorop_properties: Set colorop props if programmable by DC.
+ * @crtc_state: DRM crtc state
+ * @dc_stream_state: AMDGPU DC stream state
+ * @check_only: only check color state without update dc stream
+ *
+ * This function verifies post-blend CTM and LUT sizes: if there is enough space, and for
+ * output transfer function, if its parameters can be calculated by AMD
+ * color module. The main difference with CRTC color mgmt properties is that
+ * post-blend degamma is not part of the color pipeline since it's actually
+ * supported pre-blend only.
+ *
+ * If it's not an atomic check, DC resources are checked and updated
+ * accordingly.
+ *
+ * Returns:
+ * 0 on success. Error code if validation fails.
+ */
+
+int
+amdgpu_dm_crtc_set_colorop_properties(struct drm_crtc_state *crtc_state,
+				      struct dc_stream_state *dc_stream_state,
+				      bool check_only)
+{
+	struct drm_colorop *colorop = crtc_state->color_pipeline;
+	int ret;
+
+	/* 3x4 matrix */
+	ret = __set_dm_crtc_colorop_3x4_matrix(crtc_state, dc_stream_state, colorop, check_only);
+
+	return ret;
+}
+
 /**
  * amdgpu_dm_check_crtc_color_mgmt: Check if DRM color props are programmable by DC.
  * @crtc: amdgpu_dm crtc state
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 1c3e7ccb9eda..0abe8ab9184b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -252,3 +252,41 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 
 	return ret;
 }
+
+int amdgpu_dm_initialize_crtc_default_pipeline(struct drm_crtc *crtc,
+					       struct drm_prop_enum_list *list)
+{
+	struct drm_colorop *ops[MAX_COLOR_PIPELINE_OPS];
+	struct drm_device *dev = crtc->dev;
+	int ret;
+	int i = 0;
+
+	memset(ops, 0, sizeof(ops));
+
+	/* 3x4 matrix */
+	ops[i] = kzalloc_obj(struct drm_colorop);
+	if (!ops[i]) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = drm_crtc_colorop_ctm_3x4_init(dev, ops[i], crtc, NULL,
+					    DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	if (ret)
+		goto cleanup;
+
+	list->type = ops[i]->base.id;
+
+	i++;
+
+	list->name = kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.id);
+
+	return 0;
+cleanup:
+	if (ret == -ENOMEM)
+		drm_err(crtc->dev, "KMS: Failed to allocate colorop\n");
+
+	drm_colorop_pipeline_destroy(dev);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
index 7b71d3144391..85c21669bf78 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
@@ -34,4 +34,6 @@ extern const u64 amdgpu_dm_supported_fm;
 
 int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
 
+int amdgpu_dm_initialize_crtc_default_pipeline(struct drm_crtc *crtc, struct drm_prop_enum_list *list);
+
 #endif /* __AMDGPU_DM_COLOROP_H__*/
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 3dcedaa67ed8..6226c9ba5fce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -32,6 +32,7 @@
 #include "amdgpu_dm_replay.h"
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_plane.h"
+#include "amdgpu_dm_colorop.h"
 #include "amdgpu_dm_trace.h"
 #include "amdgpu_dm_debugfs.h"
 #include "modules/inc/mod_power.h"
@@ -518,6 +519,43 @@ amdgpu_dm_atomic_crtc_get_property(struct drm_crtc *crtc,
 
 	return 0;
 }
+#else
+
+#define MAX_CRTC_COLOR_PIPELINES 5
+
+static int
+dm_crtc_init_colorops(struct drm_crtc *crtc)
+{
+	struct drm_prop_enum_list pipelines[MAX_CRTC_COLOR_PIPELINES] = {};
+	struct drm_device *dev = crtc->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct dc *dc = adev->dm.dc;
+	int len = 0;
+	int ret = 0;
+	int i;
+
+	/* initialize pipeline */
+	if (dc->ctx->dce_version >= DCN_VERSION_3_0) {
+		ret = amdgpu_dm_initialize_crtc_default_pipeline(crtc, &pipelines[len]);
+		if (ret) {
+			drm_err(dev, "Failed to create color pipeline for CRTC %d: %d\n",
+				crtc->base.id, ret);
+			goto out;
+		}
+		len++;
+
+		/* Create COLOR_PIPELINE property and attach */
+		ret = drm_crtc_create_color_pipeline_property(crtc, pipelines, len);
+	}
+
+out:
+	for (i = 0; i < len; i++)
+		kfree(pipelines[i].name);
+
+	return ret;
+}
+
+
 #endif
 
 /* Implemented only the options currently available for the driver */
-- 
2.53.0

