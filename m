Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D29C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9899F10F36C;
	Thu, 13 Aug 2026 14:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZMq3jNAL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B043010F368;
 Thu, 13 Aug 2026 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=65An/KPArC1fl2N9US0daVHXmcNLJh/g3S1e2J1TRVU=; b=
 ZMq3jNALpaubDt4Dk6fhhzK9o+/66/SbKXD5ITXtmr1Hl6361F9W91NoqjgT9PCBjjUo2j15nO2iF
 /2f62f1rwWJF5XBuTeQlmr9cQbwP/ilYaQ3FwTwXnjElTlgYE8xa56enA6zRkWthzsl5fsONJAwtr
 QW8ICKCMxBb5D4bnH1x9MZmfgwQ11NFZD9nboFAOrYwTeNxatC5pMbeqAdGwUomu1hmBvN/zoK0sf
 5hxCvVF4J404jhXJypUCS2RK/VWme6XGl/NGrFgVot0QZYRcPhheLCtDGSeJfJphaM5Qrc3ituG2o
 9pJYlm9gRngnOfIwN37n+/GD4qbfGpOfkA==;
Received: from [31.4.128.162] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wuWXc-000sKW-VW; Thu, 13 Aug 2026 16:36:21 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniels@collabora.com, harry.wentland@amd.com,
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Daniel Wheeler <Daniel.Wheeler@amd.com>,
 kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/3] drm/amd/display: fix missing blend-mode-prop warning
 for DCN
Date: Thu, 13 Aug 2026 16:30:21 +0200
Message-ID: <20260813143605.106104-3-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813143605.106104-1-mwen@igalia.com>
References: <20260813143605.106104-1-mwen@igalia.com>
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

