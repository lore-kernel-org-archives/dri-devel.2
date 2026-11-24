Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D1606A338
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=bbXHcrN2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D058210F84E;
	Tue, 24 Nov 2026 18:20:38 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB3A10F4C1;
 Tue, 24 Nov 2026 18:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=yjvo2Db7lfUR2I4S0YWZlghYuPqL449M9yQbhl0ir4M=;
 t=1795544317; x=2110904317; b=bbXHcrN2q3WudOra/Jbcb3A8FF4sDiewE126daY1OqABDe9
 wX1HTIwCD/bBMcknsz1CxRjTd9Ryegd89/zKWiuknQcIG5XS/f/I7DGYiLWxVZY6J7WeP2Wr+0BRh
 dUDX9uSt7HkSJQ8sYYo40tB3/uK/Hzcfs/VH6W3TE5sKhvS/+Jq/I8EhKi30oLwhc7l2RXTTfSg01
 iXSdO9Bmc5MiDwzJm+siXLwMHcSA+qGdpwsXHrquLM02xEUIszqAoJYAUTJ8P+6jzXuYKz7lNSikf
 a8gVAWv1K3sRHLX84FjzT9yQ/NidqGHEdi7a6BgziiUUOcThwNqcbRSVtlgsZoRw==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv64-00000003axM-3kG1; Tue, 24 Nov 2026 19:18:29 +0100
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
Subject: [PATCH v3 18/19] drm/amd/display: add support to post-blend 1D-Curve
 colorop
Date: Tue, 24 Nov 2026 19:03:35 +0100
Message-ID: <20261124181652.1333986-19-mwen@igalia.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add Regamma TF operation as 1D Curve colorop to the AMD post-blend color
pipeline. Allow individual changes on colorop properties by using the
committed state of colorops that aren't in the commit.

Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- use the committed state of the curve colorop when it isn't part of the
  commit
- reject a colorop of unexpected type
- drop the NULL colorop path since it's now only called with a colorop
  set
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 58 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 20 +++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 243e52766701..97bdb8dbddb0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1287,6 +1287,41 @@ __set_dm_crtc_colorop_3x4_matrix(struct drm_crtc_state *crtc_state,
 	return 0;
 }
 
+static int
+__set_dm_crtc_colorop_regamma(struct drm_crtc_state *crtc_state,
+			      struct dc_stream_state *dc_stream_state,
+			      struct drm_colorop *colorop,
+			      struct dc_transfer_func *tf)
+{
+	struct drm_colorop_state *colorop_state = NULL;
+	struct drm_atomic_commit *state = crtc_state->state;
+	enum dc_transfer_func_predefined default_tf = TRANSFER_FUNCTION_LINEAR;
+	struct drm_device *dev = crtc_state->state->dev;
+	int ret = 0;
+
+	tf->type = TF_TYPE_BYPASS;
+
+	/* 1D Curve - Regamma TF */
+	if (colorop->type != DRM_COLOROP_1D_CURVE)
+		return -EINVAL;
+
+	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+	if (!colorop_state)
+		colorop_state = colorop->state;
+
+	if (!colorop_state->bypass) {
+		drm_dbg(dev, "Regamma TF colorop with ID: %d\n", colorop->base.id);
+		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
+		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
+		ret = __set_output_tf(tf, 0, 0, false);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * amdgpu_dm_crtc_set_colorop_properties: Set colorop props if programmable by DC.
  * @crtc_state: DRM crtc state
@@ -1312,6 +1347,7 @@ amdgpu_dm_crtc_set_colorop_properties(struct drm_crtc_state *crtc_state,
 {
 	struct drm_colorop *colorop = crtc_state->color_pipeline;
 	struct drm_device *dev = crtc_state->crtc->dev;
+	struct dc_transfer_func *out_tf;
 	int ret;
 
 	if (drm_WARN_ON(dev, !colorop))
@@ -1319,6 +1355,28 @@ amdgpu_dm_crtc_set_colorop_properties(struct drm_crtc_state *crtc_state,
 
 	/* 3x4 matrix */
 	ret = __set_dm_crtc_colorop_3x4_matrix(crtc_state, dc_stream_state, colorop, check_only);
+	if (ret)
+		return ret;
+
+	/* 1D Curve - REGAMMA TF */
+	colorop = colorop->next;
+	if (!colorop) {
+		drm_dbg(dev, "no regamma TF colorop found\n");
+		return -EINVAL;
+	}
+
+	if (check_only) {
+		out_tf = kvzalloc_obj(*out_tf);
+		if (!out_tf)
+			return -ENOMEM;
+	} else {
+		out_tf = &dc_stream_state->out_transfer_func;
+	}
+
+	ret = __set_dm_crtc_colorop_regamma(crtc_state, dc_stream_state, colorop, out_tf);
+
+	if (check_only)
+		kvfree(out_tf);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index c88c17da1058..c97a087682c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -307,6 +307,7 @@ int amdgpu_dm_initialize_crtc_default_pipeline(struct drm_crtc *crtc,
 {
 	struct drm_colorop *ops[MAX_COLOR_PIPELINE_OPS];
 	struct drm_device *dev = crtc->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
 	int ret;
 	int i = 0;
 
@@ -328,6 +329,25 @@ int amdgpu_dm_initialize_crtc_default_pipeline(struct drm_crtc *crtc,
 
 	i++;
 
+	if (adev->dm.dc->caps.color.mpc.ogam_ram) {
+		/* 1D Curve - REGAMMA TF */
+		ops[i] = kzalloc_obj(*ops[0]);
+		if (!ops[i]) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+
+		ret = drm_crtc_colorop_curve_1d_init(dev, ops[i], crtc, &dm_colorop_funcs,
+						     amdgpu_dm_supported_shaper_tfs,
+						     DRM_COLOROP_FLAG_ALLOW_BYPASS);
+		if (ret)
+			goto cleanup;
+
+		drm_colorop_set_next_property(ops[i-1], ops[i]);
+
+		i++;
+	}
+
 	list->name = kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.id);
 
 	return 0;
-- 
2.53.0

