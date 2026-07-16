Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD717C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3252210F37D;
	Thu, 16 Jul 2026 16:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="HVoDRd4x";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4CB10F383;
 Thu, 16 Jul 2026 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=gy2syMn21oBftAF3dRl9Bno6Ns0Y/lc49oBfZnBfnic=; b=
 HVoDRd4xCdGcxwasYZbtlfc5F/fNGJzvkxteqd104BTm5SkeYho4uK7OsHG7O4bwH0j+L0UplLCAi
 wz1D72Q/uPnWP3jYirACkcf5L/1vijEjPyRShknulqkrt5bAU2blCSyvu+1SS3ZlD6D/DJvr6UBEG
 feiOywvJN55xrZcdsnM4i7sx1YBrrTh4vMx5rBiiDPKNochf71dpFVp5/nHyMFbRwSd9YROvbtFlt
 95bSXRu7kbVrDkWX7g++z+NyzM5a/msB8vvsQdAlDtM8/RT5qubRb8/55Su/A666IT0u0EJDreGOU
 HeLW/pHxGMUGkNDv7FelFls8pts+LQ82nw==;
Received: from [178.139.170.72] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkObx-00G01i-RQ; Thu, 16 Jul 2026 18:06:58 +0200
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
Subject: [RFC PATCH v2 18/20] drm/amd/display: add support to post-blend
 1D-LUT colorop
Date: Thu, 16 Jul 2026 18:03:15 +0200
Message-ID: <20260716160556.227556-19-mwen@igalia.com>
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

Add Regamma LUT operation as 1D LUT colorop to AMD post-blend color
pipeline.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 38 ++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 18 +++++++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 141c5238021e..67a9ec48836d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1234,6 +1234,8 @@ __set_dm_crtc_colorop_regamma(struct drm_crtc_state *crtc_state,
 	struct drm_atomic_commit *state = crtc_state->state;
 	enum dc_transfer_func_predefined default_tf = TRANSFER_FUNCTION_LINEAR;
 	struct drm_device *dev = crtc_state->state->dev;
+	const struct drm_color_lut32 *regamma_lut;
+	u32 regamma_size;
 	int ret = 0;
 
 	tf->type = TF_TYPE_BYPASS;
@@ -1251,6 +1253,34 @@ __set_dm_crtc_colorop_regamma(struct drm_crtc_state *crtc_state,
 			return ret;
 	}
 
+	/* 1D LUT - Regamma LUT */
+	colorop = colorop->next;
+	if (!colorop) {
+		drm_dbg(dev, "no Regamma LUT colorop found\n");
+		return -EINVAL;
+	}
+
+	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+
+	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_1D_LUT) {
+		drm_dbg(dev, "Regamma LUT colorop with ID: %d\n", colorop->base.id);
+		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+		tf->tf = default_tf;
+		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
+		regamma_lut = __extract_blob_lut32(colorop_state->data, &regamma_size);
+		regamma_size = regamma_lut != NULL ? regamma_size : 0;
+
+		/* Custom LUT size must be the same as supported size */
+		if (regamma_size == colorop->size) {
+			ret = __set_output_tf_32(tf, regamma_lut, regamma_size, false);
+			if (ret)
+				return ret;
+		} else {
+			drm_dbg(dev, "Regamma LUT size doesn't match blob size\n");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
@@ -1300,7 +1330,7 @@ amdgpu_dm_crtc_set_colorop_properties(struct drm_crtc_state *crtc_state,
 		}
 	}
 
-	/* 1D Curve - REGAMMA TF */
+	/* 1D Curve & LUT - REGAMMA TF & LUT */
 	colorop = colorop->next;
 	if (!colorop) {
 		drm_dbg(dev, "no regamma TF colorop found\n");
@@ -1312,6 +1342,11 @@ amdgpu_dm_crtc_set_colorop_properties(struct drm_crtc_state *crtc_state,
 	if (ret)
 		goto cleanup;
 
+	/* REGAMMA LUT colorop is already handled, just skip here */
+	colorop = colorop->next;
+	if (!colorop)
+		ret = -EINVAL;
+
 cleanup:
 	if (check_only)
 		kvfree(out_tf);
@@ -1339,7 +1374,6 @@ amdgpu_dm_crtc_set_colorop_properties(struct drm_crtc_state *crtc_state,
  * Returns:
  * 0 on success. Error code if validation fails.
  */
-
 int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
 				    bool check_only)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 4c1204c683c4..2db17f2562ce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -297,6 +297,24 @@ int amdgpu_dm_initialize_crtc_default_pipeline(struct drm_crtc *crtc,
 		drm_colorop_set_next_property(ops[i-1], ops[i]);
 
 		i++;
+
+		/* 1D LUT - REGAMMA LUT */
+		ops[i] = kzalloc_obj(*ops[0]);
+		if (!ops[i]) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+
+		ret = drm_crtc_colorop_curve_1d_lut_init(dev, ops[i], crtc, &dm_colorop_funcs,
+							 MAX_COLOR_LUT_ENTRIES,
+							 DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
+							 DRM_COLOROP_FLAG_ALLOW_BYPASS);
+		if (ret)
+			goto cleanup;
+
+		drm_colorop_set_next_property(ops[i-1], ops[i]);
+
+		i++;
 	}
 
 	list->name = kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.id);
-- 
2.53.0

