Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDAEC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6527810EC50;
	Tue,  8 Sep 2026 14:47:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A7D10EC50
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:47:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC1F2601DB;
 Tue,  8 Sep 2026 14:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB3F1F00A3F;
 Tue,  8 Sep 2026 14:47:17 +0000 (UTC)
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 08 Sep 2026 16:46:35 +0200
Subject: [PATCH v4 04/41] drm/gem-atomic-helper: Remove
 __drm_gem_reset_shadow_plane()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-no-more-plane-reset-v4-4-a31b3fcfc989@kernel.org>
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hB0NuhRA0pfQlUbai8h093SJ8CxVLKVo6RJ2iZ3PQ/Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkL5M87p4Xv/iykseXaPyOL3EABPYW/7+IzrocVH1Q+w
 FeXY72mYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzE7wpjw/PlMw7v+Sm5ZE5r
 6ALZcAmZ59ufLf7huYvFtFfvvOwq/VVfRPwP/ptgfEDJcsYU7qUspYw1/D81TkmYG7X92yjmlCl
 uWZb2uLj30cl5f5ef7lGL2pa9aZ2i6PHut2sZ5rUeWuO7tCERAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

__drm_gem_reset_shadow_plane() is no longer used: all callers now go
through __drm_gem_shadow_plane_state_init() or
drm_gem_create_shadow_plane_state(). Remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 20 --------------------
 include/drm/drm_gem_atomic_helper.h     |  2 --
 2 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index 3bb6bfd560d3..dd9efa7e3216 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -317,30 +317,10 @@ void drm_gem_destroy_shadow_plane_state(struct drm_plane *plane,
 	__drm_gem_destroy_shadow_plane_state(shadow_plane_state);
 	kfree(shadow_plane_state);
 }
 EXPORT_SYMBOL(drm_gem_destroy_shadow_plane_state);
 
-/**
- * __drm_gem_reset_shadow_plane - resets a shadow-buffered plane
- * @plane: the plane
- * @shadow_plane_state: the shadow-buffered plane state
- *
- * This function resets state for shadow-buffered planes. Helpful
- * for drivers that subclass struct drm_shadow_plane_state.
- */
-void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
-				  struct drm_shadow_plane_state *shadow_plane_state)
-{
-	if (shadow_plane_state) {
-		__drm_atomic_helper_plane_reset(plane, &shadow_plane_state->base);
-		drm_format_conv_state_init(&shadow_plane_state->fmtcnv_state);
-	} else {
-		__drm_atomic_helper_plane_reset(plane, NULL);
-	}
-}
-EXPORT_SYMBOL(__drm_gem_reset_shadow_plane);
-
 /**
  * drm_gem_begin_shadow_fb_access - prepares shadow framebuffers for CPU access
  * @plane: the plane
  * @plane_state: the plane state of type struct drm_shadow_plane_state
  *
diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
index 2deb0cd9ebbe..d41877f77b77 100644
--- a/include/drm/drm_gem_atomic_helper.h
+++ b/include/drm/drm_gem_atomic_helper.h
@@ -89,12 +89,10 @@ to_drm_shadow_plane_state(struct drm_plane_state *state)
 }
 
 void __drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane,
 					    struct drm_shadow_plane_state *new_shadow_plane_state);
 void __drm_gem_destroy_shadow_plane_state(struct drm_shadow_plane_state *shadow_plane_state);
-void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
-				  struct drm_shadow_plane_state *shadow_plane_state);
 
 void __drm_gem_shadow_plane_state_init(struct drm_plane *plane,
 				       struct drm_shadow_plane_state *shadow_plane_state);
 struct drm_plane_state *drm_gem_create_shadow_plane_state(struct drm_plane *plane);
 struct drm_plane_state *drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane);

-- 
2.55.0

