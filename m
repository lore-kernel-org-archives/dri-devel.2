Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7951D606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=LA6wi6tR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B42510FD9F;
	Wed, 11 Nov 2026 16:09:27 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E77510FD9F;
 Wed, 11 Nov 2026 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=BAE9idnwOD10qYdzSWIYNdE/NfvRDU68ledfePCFivU=;
 t=1794413347; x=2109773347; b=LA6wi6tRGqK9hqj1Z4+d+Bnc4ekwcJ913IREuIWYON4azQK
 aOd96lauGYMWoys67eJ/0xPWTBcsMYko7CMP05+Toi5ZbUE+vE4RYK7VxdYUH/dnHkYK4aeALqLRD
 f5HdCaA/kZ2E2z5z+d67cr5ppPUjbG72FZDowGjkwIBVlj2HzwkLps0jeZXV35/IzN+ZSskiiehDh
 oRouboxZOQOOZ1KjBI4/LJUFTPOtZ2sDUgPXnuCR28xOjU+auJgIE5o6oDX+qNGD8lsmdWd6D8mg5
 fuyeWEM/z+fjSkz1rVXsuPiUQC/eglNrQmWANv5kgVBQNL7Emu8nsH3AtwKqRdMg==;
Received: from 193.red-79-147-123.dynamicip.rima-tde.net ([79.147.123.193]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRAsM-008u8Y-G6; Wed, 11 Nov 2026 17:08:42 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, christian.koenig@amd.com, contact@emersion.fr,
 daniels@collabora.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mwen@igalia.com,
 sebastian.wick@redhat.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, louis.chauvet@bootlin.com,
 John Harrison <John.Harrison@igalia.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v5 12/15] drm/amd/display: don't ignore failure on blend
 colorop setup
Date: Wed, 11 Nov 2026 17:05:25 +0100
Message-ID: <20261111160814.21326-13-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111160814.21326-1-mwen@igalia.com>
References: <20261111160814.21326-1-mwen@igalia.com>
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

__set_input_tf_32() can fail on ENOMEM and let the blend transfer
function setup in an unstable state. Check its return value and only
enable blend if transfer function was successfully configured.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 5ed78b44e4e6 ("drm/amd/display: add shaper and blend colorops for 1D Curve Custom LUT")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c   | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 686f718bd155..f53228072fc8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1936,7 +1936,7 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 	const struct drm_color_lut32 *blend_lut = NULL;
 	struct drm_device *dev = colorop->dev;
 	uint32_t blend_size = 0;
-	int i = 0;
+	int i = 0, ret;
 
 	tf->type = TF_TYPE_BYPASS;
 	dc_plane_state->cm.flags.bits.blend_enable = 0;
@@ -1971,8 +1971,10 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(tf_state->curve_1d_type);
 		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
+		ret = __set_input_tf_32(NULL, tf, blend_lut, blend_size);
+		if (ret)
+			return ret;
 		dc_plane_state->cm.flags.bits.blend_enable = 1;
-		__set_input_tf_32(NULL, tf, blend_lut, blend_size);
 	}
 
 	if (lut_state && !lut_state->bypass) {
@@ -1980,13 +1982,16 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf;
 		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
-		dc_plane_state->cm.flags.bits.blend_enable = 1;
 		blend_lut = __extract_blob_lut32(lut_state->data, &blend_size);
 		blend_size = blend_lut != NULL ? blend_size : 0;
 
 		/* Custom LUT size must be the same as supported size */
-		if (blend_size == lut_colorop->size)
-			__set_input_tf_32(NULL, tf, blend_lut, blend_size);
+		if (blend_size == lut_colorop->size) {
+			ret = __set_input_tf_32(NULL, tf, blend_lut, blend_size);
+			if (ret)
+				return ret;
+			dc_plane_state->cm.flags.bits.blend_enable = 1;
+		}
 	}
 
 	return 0;
-- 
2.53.0

