Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D30C5DF64
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5C010F369;
	Thu, 13 Aug 2026 14:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="N26J9noL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC74B10F367;
 Thu, 13 Aug 2026 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=Etx35r8TxvrUJmubjvNbEn/2+ygcpv0xiDaU+LNZ4fo=; b=
 N26J9noL47ihkVavRySQPLQcppfq1yLLfW4VyLVSY1N9PGAVUR8bEcyG1kV1g2r5ZHm1JbvCQQUyP
 AuJA137RjoKnGUnGJDT8nLfI0HxrA9xJSYl+LOibxxa4XGyjZQNgGZ6XI0BjCiH/y2M95JOOate94
 sEG+Y9UmhuJgbRTb7o7Jsl1DMhWG/2aSnHSbTBqkWrzP3SlRC/8q98tAu4lkWGi6KZFqT5YGxIjfW
 oSKivsgzWKkGD52A1uYnoT1IfkcBneqbzqlgaB8yTTk/Ccq1r187hopnz52HtzTbFFnO19QIdzLr6
 qyYBXsUxAvdjm8Zh3rdUJAjGivaW8ELPEw==;
Received: from [31.4.128.162] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wuWXf-000sKW-1Q; Thu, 13 Aug 2026 16:36:23 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniels@collabora.com, harry.wentland@amd.com,
 leandro.ribeiro@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Daniel Wheeler <Daniel.Wheeler@amd.com>,
 kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 3/3] drm/amd/display: advertise PIXEL_NONE as blend mode
 for DCE generations
Date: Thu, 13 Aug 2026 16:30:22 +0200
Message-ID: <20260813143605.106104-4-mwen@igalia.com>
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

DCE can support PREMULTI and COVERAGE blend mode depending on its
generation, however current driver implementation either doesn't expose
more than primary and cursor plane, or doesn't program registers for any
blend mode other than PIXEL_NONE. To fix the missing-blend-mode-prop
warning according to current DCE plane caps, create blend mode property
with PIXEL_NONE only for primary planes, instead of the DRM default
PREMULTI.

Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- fix indentation (Alex H)
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index ab9bbe8ca333..3b5b6943b67d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1923,14 +1923,18 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	if (res)
 		return res;
 
-	/* TODO: Check which blend modes are supported in DCE-generation
-	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
-	 * property accordingly.
+	/* Blend mode support varies on DCE generations according to HW caps
+	 * and number of planes per CRTC. However, as current driver
+	 * implementation only creates one primary and one cursor plane per
+	 * CRTC for DCE (overlay is only created if
+	 * DC_PLANE_TYPE_DCN_UNIVERSAL), the primary plane blend mode ends up
+	 * being always PIXEL_NONE across DCE versions.
 	 */
-	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
-	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
-	    plane_cap && plane_cap->per_pixel_alpha &&
-	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
+	if (plane_cap && plane_cap->type != DC_PLANE_TYPE_DCN_UNIVERSAL) {
+		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PIXEL_NONE));
+	} else if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
+		    plane->type == DRM_PLANE_TYPE_PRIMARY) &&
+		   plane_cap && plane_cap->per_pixel_alpha) {
 		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 					  BIT(DRM_MODE_BLEND_PREMULTI) |
 					  BIT(DRM_MODE_BLEND_COVERAGE);
-- 
2.53.0

