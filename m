Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E85C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FDD10F522;
	Thu,  9 Jul 2026 11:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lJW0GhsU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C6A610F517
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:51:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 76739407E0;
 Thu,  9 Jul 2026 11:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A1E1F000E9;
 Thu,  9 Jul 2026 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597872;
 bh=X/UlzylNTiijiPjHGIWfvmLGHrH0STp6aB2taAHfBww=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lJW0GhsUoQNJHtzIWyDUzm9BVJSkV2VbFhxnSWfI00+/BPmydvaWVnlMUVzdSxN1T
 eQCiqZtIYcM866TLMfQSAhRA6OoVCq/Tuw9j41jPSm0Q8faLJfFc6QgE1s9Qll2LLJ
 kSk4I1YwCN1IlX3HedhCTf2cWDWHeay8jovXZTeKYHNGCEFyzuFBe/O2RVcq7+wxql
 SicfSrbhrH8xS9am//byWY7+u8qFEWybInmeGviYCX9dJ1gH6lC+MJq+DQIYPn/QFO
 evXL6JWR70QFF64Smc4kx5zd7lyIkCxawXGCZ06YYPWOIGMWJqsfNZsDdSC8SNuqKx
 Uy84dX+E8Rb4w==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:50:30 +0200
Subject: [PATCH 04/60] drm/gem-atomic-helper: Switch
 DRM_GEM_SHADOW_PLANE_FUNCS to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-4-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416; i=mripard@kernel.org;
 h=from:subject:message-id; bh=IGPWiHhf0muV+Cn8sO7QkP34R+F15ly7sznjzCA865c=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3dxLG3sES4TNJnlFHOzNqGfacvjP3YBFbLO6Tf8tT
 9wxZ69jx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhI5wzG+mp7v72CKuz155qX
 Nh15dUBsAr/mlEa50p7FuYsVStQ0Sxdq3JcvaVRUT1ifmltTH9LG2DBXU3zzvn25Dav291ydfOi
 BS6wjm9vHps19LGK1G+cZn4iyvWoqa3bEQnWlTSjz7VOTugA=
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

DRM_GEM_SHADOW_PLANE_FUNCS currently sets .reset to
drm_gem_reset_shadow_plane. Since
drm_gem_create_shadow_plane_state() now exists and only handles
pristine state allocation without conflating it with hardware or
suspend/resume reset, switch the macro to use .atomic_create_state
instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_gem_atomic_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
index 8a3bb27233db..da8a4fb442b4 100644
--- a/include/drm/drm_gem_atomic_helper.h
+++ b/include/drm/drm_gem_atomic_helper.h
@@ -108,11 +108,11 @@ void drm_gem_destroy_shadow_plane_state(struct drm_plane *plane,
  *
  * Drivers may use GEM BOs as shadow buffers over the framebuffer memory. This
  * macro initializes struct drm_plane_funcs to use the rsp helper functions.
  */
 #define DRM_GEM_SHADOW_PLANE_FUNCS \
-	.reset = drm_gem_reset_shadow_plane, \
+	.atomic_create_state = drm_gem_create_shadow_plane_state, \
 	.atomic_duplicate_state = drm_gem_duplicate_shadow_plane_state, \
 	.atomic_destroy_state = drm_gem_destroy_shadow_plane_state
 
 int drm_gem_begin_shadow_fb_access(struct drm_plane *plane, struct drm_plane_state *plane_state);
 void drm_gem_end_shadow_fb_access(struct drm_plane *plane, struct drm_plane_state *plane_state);

-- 
2.54.0

