Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A55C44515
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091C610F38A;
	Thu, 16 Jul 2026 16:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="axAyEuVS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F3A10F389;
 Thu, 16 Jul 2026 16:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=1eajwanCzQP22dO6kO19c6VsSelTh4Sp1K+DcHgzFCs=; b=
 axAyEuVSHwqdvxjzaGHARZE92ADGANAcSWok7XUMcWNcEKUs9OugfE8VA+svCFbDMbz8A1pcnv0Rc
 Jpkh7R1DZKM9hZTR45pAvIOYCif7YlQ+nVVkKsiZkdRuyYFTyVbOI8wDVbxQk27Zn+qvz/bYQA1Pc
 CkoJgeO1n5HOon7OMDjRvLuVMR7miDia/f+ZrxJOBVcR088o/mJQ/Np9kmYTCZL9/SgrcKz7+DWAp
 hTk3XzUR86ODkhAZzJhL/2Zl/s71uvggZfYrhVMmEjyoghGBs91OKRCKnwse/mtXL96JT64CozA8U
 UoTDi4ye6blvxWF6OIITxu52spoGK4KlBg==;
Received: from [178.139.170.72] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkOc0-00G01i-5V; Thu, 16 Jul 2026 18:07:00 +0200
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
Subject: [RFC PATCH v2 19/20] drm/amd/display: move CRTC CTM color mgmt prop
 to check helper
Date: Thu, 16 Jul 2026 18:03:16 +0200
Message-ID: <20260716160556.227556-20-mwen@igalia.com>
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

Move legacy CRTC CTM color mgmt handlers to AMD atomic check helper to
centralize legacy properties in a single place, so that we can reuse the
callers to these helpers for colorop setup.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 66 +++++++++----------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 67a9ec48836d..9e5da58f26f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1385,6 +1385,7 @@ int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
 	uint32_t degamma_size, regamma_size;
 	bool has_regamma, has_degamma;
 	enum dc_transfer_func_predefined tf = TRANSFER_FUNCTION_LINEAR;
+	struct drm_color_ctm *ctm = NULL;
 	bool is_legacy;
 	int r;
 
@@ -1454,10 +1455,38 @@ int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
 	 * have to place the CTM in the OCSC in that case.
 	 */
 	crtc->cm_has_degamma = has_degamma;
-	if (check_only)
+	if (check_only) {
 		kvfree(out_tf);
+		return r;
+	}
 
-	return r;
+	if (r)
+		return r;
+
+	/* Setup CRTC CTM. */
+	if (crtc->base.ctm) {
+		ctm = (struct drm_color_ctm *)crtc->base.ctm->data;
+
+		/*
+		 * Gamut remapping must be used for gamma correction
+		 * since it comes before the regamma correction.
+		 *
+		 * OCSC could be used for gamma correction, but we'd need to
+		 * blend the adjustments together with the required output
+		 * conversion matrix - so just use the gamut remap block
+		 * for now.
+		 */
+		__drm_ctm_to_dc_matrix(ctm, stream->gamut_remap_matrix.matrix);
+
+		stream->gamut_remap_matrix.enable_remap = true;
+		stream->csc_color_matrix.enable_adjustment = false;
+	} else {
+		/* Bypass CTM. */
+		stream->gamut_remap_matrix.enable_remap = false;
+		stream->csc_color_matrix.enable_adjustment = false;
+	}
+
+	return 0;
 }
 
 /**
@@ -1484,38 +1513,7 @@ int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
  */
 int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 {
-	struct dc_stream_state *stream = crtc->stream;
-	struct drm_color_ctm *ctm = NULL;
-	int ret;
-
-	ret = amdgpu_dm_check_crtc_color_mgmt(crtc, false);
-	if (ret)
-		return ret;
-
-	/* Setup CRTC CTM. */
-	if (crtc->base.ctm) {
-		ctm = (struct drm_color_ctm *)crtc->base.ctm->data;
-
-		/*
-		 * Gamut remapping must be used for gamma correction
-		 * since it comes before the regamma correction.
-		 *
-		 * OCSC could be used for gamma correction, but we'd need to
-		 * blend the adjustments together with the required output
-		 * conversion matrix - so just use the gamut remap block
-		 * for now.
-		 */
-		__drm_ctm_to_dc_matrix(ctm, stream->gamut_remap_matrix.matrix);
-
-		stream->gamut_remap_matrix.enable_remap = true;
-		stream->csc_color_matrix.enable_adjustment = false;
-	} else {
-		/* Bypass CTM. */
-		stream->gamut_remap_matrix.enable_remap = false;
-		stream->csc_color_matrix.enable_adjustment = false;
-	}
-
-	return 0;
+	return amdgpu_dm_check_crtc_color_mgmt(crtc, false);
 }
 
 static int
-- 
2.53.0

