Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5552FC61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3872110E3CB;
	Wed, 26 Aug 2026 10:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="HjlBFTUG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DFD10E2D2;
 Wed, 26 Aug 2026 10:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=9QR6miEH3XK8xb56PeZ6fZUlEL/CsSIBGndNNlYy64I=; b=HjlBFTUGdHkSekWtB2JpUkumv5
 iNDt5BW2oFugz5bl+5NDRq977PYiQDl2guzHppXjXREvyHuWvUXsWMY29VN3S2RxmRNUSDStoaMyq
 Xql+JdzZgwX+6mt6Pqt0WN3K2MZExWKvI6KWVPiKpcQg1a3g/75aGuk49aGCJ0haaTMGeO5r5cWVR
 Ft5KR5aLpVJPyQnKbz+GunNxz6BYwRnC4yB/f+VMDfkz3CvMNpy5A+NqR+M1JK29wS1wyBQecMI/T
 9P3kh5H+n5rg3TT+w29rP9Qe6ueIxKhvRI68oV01Enyy3J/gUMUDjR3YHTg53V+MpT2MdL3gyl7qC
 +GkaIACQ==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wzB4p-009Uut-23; Wed, 26 Aug 2026 12:41:51 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniels@collabora.com, harry.wentland@amd.com,
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Daniel Wheeler <Daniel.Wheeler@amd.com>,
 kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 =?UTF-8?q?Viktor=20J=C3=A4gersk=C3=BCpper?= <viktor_jaegerskuepper@freenet.de>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v4 3/3] drm/amd/display: advertise PIXEL_NONE and PREMULTI
 blend mode for DCE
Date: Wed, 26 Aug 2026 12:37:07 +0200
Message-ID: <20260826104143.39077-4-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826104143.39077-1-mwen@igalia.com>
References: <20260826104143.39077-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

DCE can support PREMULTI and COVERAGE blend mode depending on its
generation, however current driver implementation either doesn't expose
more than primary and cursor plane, or doesn't program registers for any
blend mode other than PIXEL_NONE. To fix the missing-blend-mode-prop
warning according to current DCE plane caps, create blend mode property
with PIXEL_NONE and PREMULTI for primary planes. As long as the
background is black and there is no overlay plane, PIXEL_NONE and
PREMULTI are equivalent, and PREMULTI has been the mandatory/default
mode for years, so keep it to avoid regressions.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Tested-by: Viktor Jägersküpper <viktor_jaegerskuepper@freenet.de>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com> #v3
Reviewed-by: Alex Hung <alex.hung@amd.com> #v3
Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com> #v2
Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- fix indentation (Alex H)
v4:
- add PREMULTI to avoid regression (reported by Viktor)
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index ab9bbe8ca333..402f0d333150 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1923,14 +1923,24 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	if (res)
 		return res;
 
-	/* TODO: Check which blend modes are supported in DCE-generation
-	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
-	 * property accordingly.
+	/* Blend mode support varies on DCE generations according to HW caps
+	 * and number of planes per CRTC. However, as current driver
+	 * implementation only creates one primary and one cursor plane per
+	 * CRTC for DCE (overlay is only created if
+	 * DC_PLANE_TYPE_DCN_UNIVERSAL), the primary plane blend mode is
+	 * ignored across DCE versions. Keep PREMULTI to avoid uAPI
+	 * regressions: it was the default/mandatory mode for many years and,
+	 * with no overlay plane, primary composes on top of a black
+	 * background, where PREMULTI and PIXEL_NONE are equivalent.
 	 */
-	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
-	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
-	    plane_cap && plane_cap->per_pixel_alpha &&
-	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
+	if (plane_cap && plane_cap->type != DC_PLANE_TYPE_DCN_UNIVERSAL) {
+		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+					  BIT(DRM_MODE_BLEND_PREMULTI);
+
+		drm_plane_create_blend_mode_property(plane, blend_caps);
+	} else if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
+		    plane->type == DRM_PLANE_TYPE_PRIMARY) &&
+		   plane_cap && plane_cap->per_pixel_alpha) {
 		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 					  BIT(DRM_MODE_BLEND_PREMULTI) |
 					  BIT(DRM_MODE_BLEND_COVERAGE);
-- 
2.53.0

