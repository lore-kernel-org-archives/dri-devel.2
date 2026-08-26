Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9783EC61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4334289D30;
	Wed, 26 Aug 2026 10:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iyf4U7Le";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFD389149;
 Wed, 26 Aug 2026 10:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=wKbx8uDTILW4xi2/ITr/3Euabzf01GkQGGNisWsFjSw=; b=
 iyf4U7Le6Clknz6tRAR4Kiep7AaDYPk77+ZaNn1Zxk3kEyhnN69BjSJRa4JvsW47EpO3OA7Jj40SE
 Fd4ytSOan4P0Vlog9RavTDzo4ZthQQvr1Tgs/fDdZ9F8KVJBZ8n3Vul8BpVZ5/m5+y3IhfQr2W5x2
 OUx2NyWLczt1cI41McgCSQScjBaS9cZoMCDSKG3eXLHNLlt76zd2pBjapnLJpMmFnTTCw66f2xIpg
 XShTye5uRZAyYUiV8Ht1VnActs/JykKDgvtzeD4Ehq7ORyxDLmNFyyED0C8/Jp5nmf53/CZQ1GcHs
 fsfvaJ4n0G5YwX3vLYYpkmG3aUngeLvmvQ==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wzB4n-009Uut-EJ; Wed, 26 Aug 2026 12:41:49 +0200
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
Subject: [PATCH v4 2/3] drm/amd/display: fix missing blend-mode-prop warning
 for DCN
Date: Wed, 26 Aug 2026 12:37:06 +0200
Message-ID: <20260826104143.39077-3-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826104143.39077-1-mwen@igalia.com>
References: <20260826104143.39077-1-mwen@igalia.com>
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

validate_blend_mode_for_alpha_formats() warns when a plane supports
formats with alpha but doesn't expose the blend mode property. Fix this
by adding the same overlay plane blend modes to primary plane, since
they are all universal planes in DCN-generation. Cursor planes support
ARGB8888 format and CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA is set by
default (other color formats are not implemented), so only expose
support to PREMULTI, which is the default blend mode on DRM.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- keep primary planes w/o alpha property
- re-order if-conditions for readability
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 1b564cfe2120..ab9bbe8ca333 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1923,16 +1923,31 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	if (res)
 		return res;
 
-	if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
-	    plane_cap && plane_cap->per_pixel_alpha) {
+	/* TODO: Check which blend modes are supported in DCE-generation
+	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
+	 * property accordingly.
+	 */
+	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
+	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
+	    plane_cap && plane_cap->per_pixel_alpha &&
+	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
 		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 					  BIT(DRM_MODE_BLEND_PREMULTI) |
 					  BIT(DRM_MODE_BLEND_COVERAGE);
 
-		drm_plane_create_alpha_property(plane);
 		drm_plane_create_blend_mode_property(plane, blend_caps);
+
+		if (plane->type == DRM_PLANE_TYPE_OVERLAY)
+			drm_plane_create_alpha_property(plane);
 	}
 
+	/* Cursor color format is set to CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA
+	 * by default, so only advertise DRM_MODE_BLEND_PREMULTI blend mode for
+	 * this type of plane.
+	 */
+	if (plane->type == DRM_PLANE_TYPE_CURSOR)
+		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PREMULTI));
+
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
 		/*
 		 * Allow OVERLAY planes to be used as underlays by assigning an
-- 
2.53.0

