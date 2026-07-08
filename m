Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B42C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED8510F28B;
	Wed,  8 Jul 2026 19:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iV0GCco7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB5810F294;
 Wed,  8 Jul 2026 19:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1eajwanCzQP22dO6kO19c6VsSelTh4Sp1K+DcHgzFCs=; b=iV0GCco7uH4vFlf4JVg1sdB8fr
 bMiR+uAS6bYU4zIhTQgxgBtJjCsba1WcumEZHaGAPb33uS5aiOQ50I3y+tRkBrMhUWf9fdx+Dwaue
 PkN5K/mvYMtab3KsNSb29au7nG5+RAM290hyHsb155Oa/EyiQY9YxE/rTGrqUOLN3vxFzR2m4n1Ad
 LMtnfMFXBjnpW5ElHYlH4Zfq+MzH2ThorlPtdZQGPx7xHyAOaHI9CiUguO8blxvq8ucQA2CK2578y
 mgrxFgVBkvGwOX2toebz9xu2Ax/Zgaif7nrvHYebj5CSzcMMpT2foTdqEJ3JJ6JBZC3ezWzl2qR6W
 nvRQcGPQ==;
Received: from 100.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.100]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1whYD5-00BtrH-A7; Wed, 08 Jul 2026 21:45:31 +0200
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
Subject: [RFC PATCH 18/19] drm/amd/display: move CRTC CTM color mgmt prop to
 check helper
Date: Wed,  8 Jul 2026 21:37:33 +0200
Message-ID: <20260708194343.2578387-19-mwen@igalia.com>
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

