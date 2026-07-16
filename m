Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7763EC44515
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B645910F381;
	Thu, 16 Jul 2026 16:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Yj5hWrhM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57EA810F380;
 Thu, 16 Jul 2026 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=sl7GiLs+b2sUP7WAzFEwJHZGVFnW/Vn9aKsSJBYpJ6A=; b=
 Yj5hWrhMEneora7pi/v2Oz8oDYiuoifDQspUsb76r8nIbfxr0maNMy62XvCd50mOtOB7PNTb5EinN
 kHYaSOeFtf2wK948/iV82XafpoET2O94pbqCujZDupa4Z1igR8JTY2tmltleO7UP72ov8u1mEY36u
 ieQziy5MsFGF7t2fieGsb73lM444Nl5yOPG0wtOT796fx1kb1nlnPnTc1AEYLo+R5ZkDTV2gPb5po
 /Z0M8rC6xNcplD2fFT4YMeznSfc5XNB7D1M2ClYOD9wflRT2hO4Gt3CEc01Z8sCrzRrRIAz5R3/M9
 2m7ZRj1M9CXzUjQhviK1tcvvvJ/PDKwzwA==;
Received: from [178.139.170.72] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkObv-00G01i-LZ; Thu, 16 Jul 2026 18:06:55 +0200
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
 John Harrison <John.Harrison@Igalia.com>, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [RFC PATCH v2 17/20] drm/amd/display: add support to post-blend
 1D-Curve colorop
Date: Thu, 16 Jul 2026 18:03:14 +0200
Message-ID: <20260716160556.227556-18-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716160556.227556-1-mwen@igalia.com>
References: <20260716160556.227556-1-mwen@igalia.com>
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

Add Regamma TF operation as 1D Curve colorop to the AMD post-blend color
pipeline.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 62 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 20 ++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 20996af68f04..141c5238021e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1224,6 +1224,36 @@ __set_dm_crtc_colorop_3x4_matrix(struct drm_crtc_state *crtc_state,
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
+	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+
+	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_1D_CURVE) {
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
 /**
  * amdgpu_dm_crtc_set_colorop_properties: Set colorop props if programmable by DC.
  * @crtc_state: DRM crtc state
@@ -1249,10 +1279,42 @@ amdgpu_dm_crtc_set_colorop_properties(struct drm_crtc_state *crtc_state,
 				      bool check_only)
 {
 	struct drm_colorop *colorop = crtc_state->color_pipeline;
+	struct drm_device *dev = crtc_state->state->dev;
+	struct dc_transfer_func *out_tf;
 	int ret;
 
 	/* 3x4 matrix */
 	ret = __set_dm_crtc_colorop_3x4_matrix(crtc_state, dc_stream_state, colorop, check_only);
+	if (ret)
+		return ret;
+
+	if (colorop && check_only) {
+		out_tf = kvzalloc_obj(*out_tf);
+		if (!out_tf)
+			return -ENOMEM;
+	} else {
+		out_tf = &dc_stream_state->out_transfer_func;
+		if (!colorop) {
+			out_tf->type = TF_TYPE_BYPASS;
+			return 0;
+		}
+	}
+
+	/* 1D Curve - REGAMMA TF */
+	colorop = colorop->next;
+	if (!colorop) {
+		drm_dbg(dev, "no regamma TF colorop found\n");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = __set_dm_crtc_colorop_regamma(crtc_state, dc_stream_state, colorop, out_tf);
+	if (ret)
+		goto cleanup;
+
+cleanup:
+	if (check_only)
+		kvfree(out_tf);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 0abe8ab9184b..4c1204c683c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -258,6 +258,7 @@ int amdgpu_dm_initialize_crtc_default_pipeline(struct drm_crtc *crtc,
 {
 	struct drm_colorop *ops[MAX_COLOR_PIPELINE_OPS];
 	struct drm_device *dev = crtc->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
 	int ret;
 	int i = 0;
 
@@ -279,6 +280,25 @@ int amdgpu_dm_initialize_crtc_default_pipeline(struct drm_crtc *crtc,
 
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

