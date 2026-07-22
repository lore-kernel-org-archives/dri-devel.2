Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EDAC4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 18:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FEE010E283;
	Wed, 22 Jul 2026 18:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZCpFwouU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C728110E283;
 Wed, 22 Jul 2026 18:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=1X86lusJAwcuOrbdAdzzJUsyIr7/HABtmQGiJifQOFQ=; b=
 ZCpFwouU95YYwZo1PYndxn52wzOJRHyVHHiSAKbJPXY0QnQ5WxOuwac7YP9XDyuxzKgrH+BAtzXUJ
 aFO4Lohv+sY1SyhkD9QqGFgS0iudAQc9K93k9TNiI7P/Q179vLUxUjepAozF4szWSbk2nA/hTEyRl
 AvzsnBrZK0vWXjWhU/QZ6yUdqCqavBXyS3tF7UD5zbvIDUl3ikhrDRCIdRmkq+ARWb+Ii4qSb/+S7
 UfQW6O/bgjbDo+cI/3nce6DiK7eer0/dwfI3l1+TwsYc1CDeqi6x46HmcrmkJMK/KgjwkFYHWSu5n
 g8slbIeZ8TRWca7FMrDz1sHrs7SAK7SQuw==;
Received: from [31.4.129.34] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wmbkP-0037rG-9x; Wed, 22 Jul 2026 20:32:49 +0200
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, daniels@collabora.com, leandro.ribeiro@collabora.com,
 pekka.paalanen@collabora.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: [PATCH] drm/amd/display: fix missing blend-mode-prop warning
Date: Wed, 22 Jul 2026 20:32:21 +0200
Message-ID: <20260722183240.626522-1-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
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
by adding the same blend modes to primary plane, since they are all
universal planes in DCN-generation. Cursor planes support ARGB8888
format and CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA is set by default
(other color formats are not implemented), so only expose support to
PREMULTI, which is the default blend mode on DRM.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 1b564cfe2120..cfc780608682 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1923,7 +1923,12 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	if (res)
 		return res;
 
-	if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
+	/* TODO: per_pixel_alpha is not set to DCE planes. Check what blend
+	 * modes are supported in DCE-generation planes, i.e.
+	 * DC_PLANE_TYPE_DCE_RGB and expose blend mode property accordingly.
+	 */
+	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
+	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
 	    plane_cap && plane_cap->per_pixel_alpha) {
 		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 					  BIT(DRM_MODE_BLEND_PREMULTI) |
@@ -1931,6 +1936,13 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 
 		drm_plane_create_alpha_property(plane);
 		drm_plane_create_blend_mode_property(plane, blend_caps);
+	} else if (plane->type == DRM_PLANE_TYPE_CURSOR) {
+		/* Cursor color format is set to
+		 * CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA by default, so only
+		 * advertise DRM_MODE_BLEND_PREMULTI blend mode for this type
+		 * of plane.
+		 */
+		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PREMULTI));
 	}
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
-- 
2.53.0

