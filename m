Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848BA606A332
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=INPV0iHS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6A410F83D;
	Tue, 24 Nov 2026 18:18:54 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB7110F7FD;
 Tue, 24 Nov 2026 18:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=b+KcFfQ5+enEN+c8f/VKFiAXJzPF817e6tEGZeq7+QA=;
 t=1795544316; x=2110904316; b=INPV0iHSfQAVwBl3D8OhoeIeNJaKEFsfjhMSb08uUDf1lAA
 nXin1VAKhiLgwS4f02VFQ74DadkjDSql9yO7dyAhrp/E0kYcZ8dChMYNiVVEVp1OD2f2/qVZR3RUu
 WNvgReRqnRHe6qXQrMeIdn6/qnuJZDzeR4lbN0jC3xHO8ibEvb+FR/VzXRurVDmoxeptEXE+aVozv
 WLn/VAbJFFYuIthF3oC+nLbmK6m+DpjrN3JSLLHDXGJmHiD1UQ8hMnhuVQ49SdlHv2IMD/lUsVhTG
 uGtBTWbs2tUnK2q7cDTYZFWAX3zr9UN2BwqbEwEU0+o9kxAtZvF8XfNkMtnpc46g==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv62-00000003axM-3HaR; Tue, 24 Nov 2026 19:18:26 +0100
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
 Melissa Wen <mwen@igalia.com>
Subject: [PATCH v3 17/19] drm/amd/display: enable post-blend CTM colorop
Date: Tue, 24 Nov 2026 19:03:34 +0100
Message-ID: <20261124181652.1333986-18-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124181652.1333986-1-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

Initialize the AMD post-blend color pipeline with CTM as the first color
operation in the AMD post-blend color pipeline. AMD post-blend color
pipeline for DCN3 is described in `DCN 3.0 family color caps and
mapping` of the kernel doc.

Only enable post-blend colorop properties if there is no AMD private
color prop.

Link: https://dri.freedesktop.org/docs/drm/gpu/amdgpu/display/display-manager.html#dc-color-capabilities-between-dcn-generations
Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- merge "drm/amd/display: enable post-blend colorop properties" into this
  patch
- choose between the colorop and the CRTC color props from
  crtc_state->color_pipeline
- set colorop funcs on the CTM colorop (fixes a NULL pointer dereference
  on destroy)
- use the committed state of the CTM colorop when it isn't part of the
  commit
- reject a colorop of unexpected type and program bypass explicitly as
  in [1].
- reset the CRTC degamma flags when colorop is in use
- make amdgpu_dm_crtc_set_colorop_properties() static
- reject an enabled CTM colorop without a DATA blob. Note: becomes
  redundant if [1] is applied first.
  [1] https://lore.kernel.org/dri-devel/20261111160814.21326-1-mwen@igalia.com
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 97 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 38 ++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |  2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 42 ++++++++
 4 files changed, 179 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 220194df84c1..243e52766701 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1233,6 +1233,96 @@ int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_verify_lut_sizes);
 
+static int
+__set_dm_crtc_colorop_3x4_matrix(struct drm_crtc_state *crtc_state,
+				 struct dc_stream_state *dc_stream_state,
+				 struct drm_colorop *colorop,
+				 bool check_only)
+{
+	struct drm_colorop_state *colorop_state;
+	struct drm_atomic_commit *state = crtc_state->state;
+	const struct drm_property_blob *blob;
+	struct drm_color_ctm_3x4 *ctm = NULL;
+
+	if (colorop->type != DRM_COLOROP_CTM_3X4)
+		return -EINVAL;
+
+	/* A colorop that isn't part of this commit keeps its committed state.
+	 * It allows individual colorop changes.
+	 */
+	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+	if (!colorop_state)
+		colorop_state = colorop->state;
+
+	if (colorop_state->bypass) {
+		if (!check_only) {
+			dc_stream_state->gamut_remap_matrix.enable_remap = false;
+			dc_stream_state->csc_color_matrix.enable_adjustment = false;
+		}
+		return 0;
+	}
+
+	drm_dbg(state->dev, "3x4 matrix colorop with ID: %d\n", colorop->base.id);
+	blob = colorop_state->data;
+	if (!blob) {
+		drm_dbg_atomic(state->dev,
+			       "[COLOROP:%d] enabled without a DATA blob\n",
+			       colorop->base.id);
+		return -EINVAL;
+	}
+
+	if (blob->length != sizeof(struct drm_color_ctm_3x4)) {
+		drm_warn(state->dev, "blob->length (%zu) isn't equal to drm_color_ctm_3x4 (%zu)\n",
+			 blob->length, sizeof(struct drm_color_ctm_3x4));
+		return -EINVAL;
+	}
+
+	if (!check_only) {
+		ctm = (struct drm_color_ctm_3x4 *)blob->data;
+		__drm_ctm_3x4_to_dc_matrix(ctm, dc_stream_state->gamut_remap_matrix.matrix);
+		dc_stream_state->gamut_remap_matrix.enable_remap = true;
+		dc_stream_state->csc_color_matrix.enable_adjustment = false;
+	}
+
+	return 0;
+}
+
+/*
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
+static int
+amdgpu_dm_crtc_set_colorop_properties(struct drm_crtc_state *crtc_state,
+				      struct dc_stream_state *dc_stream_state,
+				      bool check_only)
+{
+	struct drm_colorop *colorop = crtc_state->color_pipeline;
+	struct drm_device *dev = crtc_state->crtc->dev;
+	int ret;
+
+	if (drm_WARN_ON(dev, !colorop))
+		return -EINVAL;
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
@@ -1269,6 +1359,13 @@ int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
 	bool is_legacy;
 	int r;
 
+	if (crtc->base.color_pipeline) {
+		crtc->cm_has_degamma = false;
+		crtc->cm_is_degamma_srgb = false;
+		r = amdgpu_dm_crtc_set_colorop_properties(&crtc->base, stream, check_only);
+		return r;
+	}
+
 	tf = amdgpu_tf_to_dc_tf(crtc->regamma_tf);
 
 	r = amdgpu_dm_verify_lut_sizes(&crtc->base);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 47d90b67120e..c88c17da1058 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -301,3 +301,41 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 	return amdgpu_dm_build_default_pipeline(dev, plane, hw_3d_lut, list);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_initialize_default_pipeline);
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
+	ret = drm_crtc_colorop_ctm_3x4_init(dev, ops[i], crtc, &dm_colorop_funcs,
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
index edf7df7c19e9..baf45b2bf954 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
@@ -34,6 +34,8 @@ extern const u64 amdgpu_dm_supported_fm;
 
 int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
 
+int amdgpu_dm_initialize_crtc_default_pipeline(struct drm_crtc *crtc, struct drm_prop_enum_list *list);
+
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 #include <drm/drm_colorop.h>
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 5036ac1c4fd5..85ccadc5f33e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -33,6 +33,7 @@
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_dm_plane.h"
+#include "amdgpu_dm_colorop.h"
 #include "amdgpu_dm_trace.h"
 #include "amdgpu_dm_debugfs.h"
 #include "dm_helpers.h"
@@ -577,6 +578,43 @@ amdgpu_dm_atomic_crtc_get_property(struct drm_crtc *crtc,
 
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
@@ -838,6 +876,10 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 
 #ifdef AMD_PRIVATE_COLOR
 	dm_crtc_additional_color_mgmt(&acrtc->base);
+#else
+	res = dm_crtc_init_colorops(&acrtc->base);
+	if (res)
+		return res;
 #endif
 	return 0;
 
-- 
2.53.0

