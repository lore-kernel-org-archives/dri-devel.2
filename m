Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142A9C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 14:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AD1010EA78;
	Tue,  4 Aug 2026 14:08:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="i9HzDcU8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA23B10E65B;
 Tue,  4 Aug 2026 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=j8EwsuqnZT7WKgxoTOBU8dO+GvCq4qOuXkpo6P1D6kA=; b=
 i9HzDcU8khyuYOm6oN5Glcxf38iY256HTHXGn17eqkFHBT+unYp26TknPiKsaMAdvuzrVCDJPRhgo
 6IU4+2A5nzSn8MqeFaGWJisaS7w95Lfn98wUu8FK4MWebcNQSVvZE9iej+vsHifDp8SE1qT02A089
 6p0iXkh5DbwNVRn+dyQrPnoJBojINOJcHQajQrv+FhuXQPMufILutv+ooml4UQyOML6FZb+ldL9QU
 5CY2paRFnxTaj4Y5KXs0YaCcuInCKK168pQome4MtR5f34a7Gy5G8hA8YNi7Cq1mo7+rivgsvUrXP
 aFP4SfjD+AjKLrwq8sHAO3u3sNJtqHwvKw==;
Received: from 204.red-79-147-119.dynamicip.rima-tde.net ([79.147.119.204]
 helo=killbill.Home) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wrFoJ-00Dr5i-M2; Tue, 04 Aug 2026 16:08:03 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniels@collabora.com, harry.wentland@amd.com,
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, kernel-dev@igalia.com,
 Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/3] drm/amd/display: fix missing blend-mode-prop warning
 for DCN
Date: Tue,  4 Aug 2026 16:00:54 +0200
Message-ID: <20260804140758.107683-3-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804140758.107683-1-mwen@igalia.com>
References: <20260804140758.107683-1-mwen@igalia.com>
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
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 1b564cfe2120..a276f3730044 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1923,8 +1923,15 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
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
+	    plane_cap &&
+	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL &&
+	    plane_cap->per_pixel_alpha) {
 		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 					  BIT(DRM_MODE_BLEND_PREMULTI) |
 					  BIT(DRM_MODE_BLEND_COVERAGE);
@@ -1933,6 +1940,13 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 		drm_plane_create_blend_mode_property(plane, blend_caps);
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

