Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE816606A680
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Q6bUDIJ9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C738B10F83B;
	Tue, 24 Nov 2026 18:18:47 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E34810F081;
 Tue, 24 Nov 2026 18:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=v8hD3SlYIR4LKffRAmEgP5vVclXN/IJEueCUZzS2maI=;
 t=1795544315; x=2110904315; b=Q6bUDIJ9QGFKrOdQo0DXDebJ7Bpz79JlKJiUvomIezqnHIv
 chaNvImMcfM7WXVUYg53ohAS0CM0H8AHGlnTgcAu3jDfhb2a/ISeSpKpICPueK76GefpArsrMfNKI
 mHIHylgy5wUmcgjsScIhushYYxRgNkEjm4LmdOVvIQ1amCksWEpYzDvbfEnaQ+7d3WWv/IYgRvd82
 uEBelRQHzKU0PL3isCYTSNrT6w3rWYx3tXu9HDl6fy/Nz6yhT5yPINfZUh2vbN+QI5kUaDLEcqHM7
 LS6eVaxOhmsxiQwyGD5mxdU1L+8bijkj0SkHIc/T1Pbe0AZQBwcORB2skCXmwuZA==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv60-00000003axM-3tUG; Tue, 24 Nov 2026 19:18:25 +0100
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
Subject: [PATCH v3 16/19] drm/amd/display: move CRTC CTM color mgmt prop to
 check helper
Date: Tue, 24 Nov 2026 19:03:33 +0100
Message-ID: <20261124181652.1333986-17-mwen@igalia.com>
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

Move legacy CRTC CTM color mgmt handlers to AMD atomic check helper to
centralize legacy properties in a single place, so that we can reuse the
callers to these helpers for colorop setup.

Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- move before the post-blend colorop patches, so the previous CTM setup
  can't override the CTM colorop once the pipeline is enabled
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 66 +++++++++----------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index ebb05a20aa0c..220194df84c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1265,6 +1265,7 @@ int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
 	uint32_t degamma_size, regamma_size;
 	bool has_regamma, has_degamma;
 	enum dc_transfer_func_predefined tf = TRANSFER_FUNCTION_LINEAR;
+	struct drm_color_ctm *ctm = NULL;
 	bool is_legacy;
 	int r;
 
@@ -1334,10 +1335,38 @@ int amdgpu_dm_check_crtc_color_mgmt(struct dm_crtc_state *crtc,
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
 EXPORT_IF_KUNIT(amdgpu_dm_check_crtc_color_mgmt);
 
@@ -1365,38 +1394,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_check_crtc_color_mgmt);
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
 EXPORT_IF_KUNIT(amdgpu_dm_update_crtc_color_mgmt);
 
-- 
2.53.0

