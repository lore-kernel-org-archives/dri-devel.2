Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3768FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827BB10F516;
	Thu,  9 Jul 2026 11:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ERQ0cE1H";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B56710F516
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:51:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24FAD43E23;
 Thu,  9 Jul 2026 11:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847E01F000E9;
 Thu,  9 Jul 2026 11:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597870;
 bh=VK2cweAU97aWlzDptnpM4MzZ4o+XHqSNdidwrYtTS04=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ERQ0cE1H8KjgSnhoIaZVYn6zxnpdnnTGrl8MbMQIvUseQjiF6hK7BkHjiMtgiplcQ
 uenbGgWz6DkkPz2OeOhygOJpKCsToLfSO87VN/LSmprz5DqDmo1fYrsUmiA1p6GzYI
 owCzu4IrMtX0uURIy2uqwWPZXv8+1Aicd0iZDETJ1cTC707ajWz7om+yvSbb7oRYXI
 N43NkrZ6W7R8vfadrhAdKAQtOrjci2HZFeBr4EWgyWpo9xJ7xs0RsafVRwNRfqgG/u
 TgIEieidXfwEY9ijwIpju6IiKpM5JYC0hFOey4scodldpepx+GiSlhHmGk2dnjfolq
 9b0cFjaLWVY9Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:50:29 +0200
Subject: [PATCH 03/60] drm/gem-atomic-helper: Convert simple-kms shadow
 helpers to create_plane_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-3-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3991; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Mu+6p0KfRQFJdYt30N0VAV0BqOixO5wnRJ2ducT0lto=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3VydZ0vaBb85HzwovmX+ZAu+fIEFWrPFtaz+1Cz9f
 O7R5O7+jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRQ/6MdUontR/l5SUYPkxf
 MW3vZ12/T8c/mbcLNSxpYbt/f1mRnmTMMsbbjNqG/Xr7Tuw+9PPxb8Y6pZVF2/gvsUollLzsWvQ
 7ZZO8Mqf4VAv/9DmT3VacWWGR07N714t5wX3il3RXbClcvygSAA==
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
2.54.0

