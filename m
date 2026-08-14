Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97267C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC1F10F61C;
	Fri, 14 Aug 2026 14:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EYTbcuYy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313BA10F61C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:57:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1780543F7E;
 Fri, 14 Aug 2026 14:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7531A1F000E9;
 Fri, 14 Aug 2026 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719466;
 bh=dnvfRHGVbNNRwlxt7CQzTerXa1uNh3IzVa0smAZESrA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=EYTbcuYy9H+/wPE4fiiofXPlVBQTXy6FtNwFLSmaQ9eQ3FMuPPQCLdYMrvsmFEI+w
 7lPbAYAJCZshpchdrvE5RmwkIXkJAK8KUE1M/AB1+00StJxB1gtwi4rSCoN66yhC2p
 i85/OIGM4IQKcmSGMCTEnQnUjZygPeqvkFb+33PBA4bm/pf7wA1RUCWa2yz0fp5lNu
 Vl7pBAD5eeFbLmnlJayV/1gLUAiTFHVaV1ND9UtDAJsjIpYmNCCUve9ieZRjuhM2fS
 qvkLyRk3o8uQnyJi/NK/d83keEeIfnpjoA+55g1c999HC/ODiFuiXu3dgBXeV56XpM
 sNHCEJUemQtMg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:56:52 +0200
Subject: [PATCH v2 03/61] drm/gem-atomic-helper: Convert simple-kms shadow
 helpers to create_plane_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-3-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4045; i=mripard@kernel.org;
 h=from:subject:message-id; bh=2GClp5z2t6Q6N2qV25q8BwZWTXf1H1jlLuAdBmh7a3M=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1OkdvTKj4vPq2R83qI7Hytn/TZz3aUSr3Q+OgqfzLx
 b7vAy5pdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJhMxjbHi+c0rZwWmn5xnf
 3BEav05+dlH91w+ce24GCqzsuKBwrHBy5nHr1Hm7I3zf7fQ8cIgr2Y+xPqFyzcz1qiJLX50wm1Q
 b+7W5qqXwoOREw5bDP+/zn+r+vV828nwJP3fFiZlrnr32m+xzFwA=
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

drm_gem_simple_kms_reset_shadow_plane() implements the reset_plane
hook for simple-kms shadow-buffered planes. Since the reset hook
conflates initial state creation with hardware and software reset
during suspend/resume, convert it to the create_plane_state pattern.

Replace it with drm_gem_simple_kms_create_shadow_plane_state(), which
implements the create_plane_state hook using
drm_gem_create_shadow_plane_state(). Update
DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS accordingly.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 15 ++++++++++-----
 include/drm/drm_gem_atomic_helper.h     |  5 +++--
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index 7ef67c2d77ce..ae854555fd12 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -448,21 +448,26 @@ void drm_gem_simple_kms_end_shadow_fb_access(struct drm_simple_display_pipe *pip
 	drm_gem_end_shadow_fb_access(&pipe->plane, plane_state);
 }
 EXPORT_SYMBOL(drm_gem_simple_kms_end_shadow_fb_access);
 
 /**
- * drm_gem_simple_kms_reset_shadow_plane - resets a shadow-buffered plane
+ * drm_gem_simple_kms_create_shadow_plane_state - creates shadow-buffered plane state
  * @pipe: the simple display pipe
  *
- * This function implements struct drm_simple_display_funcs.reset_plane
+ * This function implements struct drm_simple_display_pipe_funcs.create_plane_state
  * for shadow-buffered planes.
+ *
+ * Returns:
+ * A pointer to a new plane state on success, or an ERR_PTR()-encoded
+ * error code otherwise.
  */
-void drm_gem_simple_kms_reset_shadow_plane(struct drm_simple_display_pipe *pipe)
+struct drm_plane_state *
+drm_gem_simple_kms_create_shadow_plane_state(struct drm_simple_display_pipe *pipe)
 {
-	drm_gem_reset_shadow_plane(&pipe->plane);
+	return drm_gem_create_shadow_plane_state(&pipe->plane);
 }
-EXPORT_SYMBOL(drm_gem_simple_kms_reset_shadow_plane);
+EXPORT_SYMBOL(drm_gem_simple_kms_create_shadow_plane_state);
 
 /**
  * drm_gem_simple_kms_duplicate_shadow_plane_state - duplicates shadow-buffered plane state
  * @pipe: the simple display pipe
  *
diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
index 43657d8fb1c8..8a3bb27233db 100644
--- a/include/drm/drm_gem_atomic_helper.h
+++ b/include/drm/drm_gem_atomic_helper.h
@@ -131,11 +131,12 @@ void drm_gem_end_shadow_fb_access(struct drm_plane *plane, struct drm_plane_stat
 
 int drm_gem_simple_kms_begin_shadow_fb_access(struct drm_simple_display_pipe *pipe,
 					      struct drm_plane_state *plane_state);
 void drm_gem_simple_kms_end_shadow_fb_access(struct drm_simple_display_pipe *pipe,
 					     struct drm_plane_state *plane_state);
-void drm_gem_simple_kms_reset_shadow_plane(struct drm_simple_display_pipe *pipe);
+struct drm_plane_state *
+drm_gem_simple_kms_create_shadow_plane_state(struct drm_simple_display_pipe *pipe);
 struct drm_plane_state *
 drm_gem_simple_kms_duplicate_shadow_plane_state(struct drm_simple_display_pipe *pipe);
 void drm_gem_simple_kms_destroy_shadow_plane_state(struct drm_simple_display_pipe *pipe,
 						   struct drm_plane_state *plane_state);
 
@@ -148,10 +149,10 @@ void drm_gem_simple_kms_destroy_shadow_plane_state(struct drm_simple_display_pip
  * functions.
  */
 #define DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS \
 	.begin_fb_access = drm_gem_simple_kms_begin_shadow_fb_access, \
 	.end_fb_access = drm_gem_simple_kms_end_shadow_fb_access, \
-	.reset_plane = drm_gem_simple_kms_reset_shadow_plane, \
+	.create_plane_state = drm_gem_simple_kms_create_shadow_plane_state, \
 	.duplicate_plane_state = drm_gem_simple_kms_duplicate_shadow_plane_state, \
 	.destroy_plane_state = drm_gem_simple_kms_destroy_shadow_plane_state
 
 #endif /* __DRM_GEM_ATOMIC_HELPER_H__ */

-- 
2.55.0

