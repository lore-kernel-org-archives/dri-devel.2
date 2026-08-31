Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED425C624D1
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3046210E9CC;
	Mon, 31 Aug 2026 16:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yq6Otnk9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7D710E9C2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:19:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7AAE60120;
 Mon, 31 Aug 2026 16:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1E81F000E9;
 Mon, 31 Aug 2026 16:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788193155;
 bh=K1VwukKdTyLdiCQ5zr+IgW3w1fuC2LAwKaKOe+Bsx08=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Yq6Otnk9GMSoI3wc+dC8cLfL/BzU2i5bR2aNMMk8X/OheyTIzuDuvgqH0gzEKSdtd
 hr5UlsL5VjkT2jIFdTtlcIPUro4Oen1LS6yKlIqhWBzhgFqy4bBdO4Mp+xkCTTw0yl
 RN4AMbo4e/xnHH6Mvg655mWDNKia18ksqqDlrcr2B0s04AK+1cUL+GKL6JV8fHV99I
 SkGIRPNlq0PmkZIZqYTk7UjcpU7qRttYVGZsAoVOP7RhVYEPYW1XEXI+sAPrvyOupW
 Rxdy2jVJnyn2EzGfg5jWOLRQKEyxiKcfzcPrGF+p1IFvct/VPqLghm+1ehVMlL0yY/
 0Y+mBXO9V9ZQA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 18:17:40 +0200
Subject: [PATCH v3 24/40] drm/atomic-state-helper: Remove
 drm_atomic_helper_plane_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-plane-reset-v3-24-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211; i=mripard@kernel.org;
 h=from:subject:message-id; bh=U0xJ8/LzrMsRx6JyQWxTe93LdXQcFCFjhHV0odJzAxk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlTV0pfXBPm5lxTvODRxDPx6TntZZ/XeS4UOPjE5ss6i
 3Xxgjd4OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEDvQzNvTPMN+uZ1aqcfzG
 lZUJLw/Zfo7+xmC27s2FF2osHt+Wa3nURxhOviMWzO4rIvPS+Mv8nYwNl/yfPb7t1nbl2/b3fcW
 7NZ/fKJ02m/WxWLvHt+eCUQvMDEWvdf7hZ9j/734Vp8kVhnmPAQ==
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

drm_atomic_helper_plane_reset() is no longer used: all callers now go
through drm_atomic_helper_plane_create_state(). Remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 19 -------------------
 include/drm/drm_atomic_state_helper.h     |  1 -
 include/drm/drm_plane.h                   |  3 ---
 3 files changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index d90d1d7c9cf9..f184ce76e090 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -344,29 +344,10 @@ void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
 
 	plane->state = plane_state;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_plane_reset);
 
-/**
- * drm_atomic_helper_plane_reset - default &drm_plane_funcs.reset hook for planes
- * @plane: drm plane
- *
- * Resets the atomic state for @plane by freeing the state pointer (which might
- * be NULL, e.g. at driver load time) and allocating a new empty state object.
- */
-void drm_atomic_helper_plane_reset(struct drm_plane *plane)
-{
-	if (plane->state)
-		__drm_atomic_helper_plane_destroy_state(plane->state);
-
-	kfree(plane->state);
-	plane->state = kzalloc_obj(*plane->state);
-	if (plane->state)
-		__drm_atomic_helper_plane_reset(plane, plane->state);
-}
-EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
-
 /**
  * drm_atomic_helper_plane_create_state - default &drm_plane_funcs.atomic_create_state hook for planes
  * @plane: plane object
  *
  * Allocates and initializes pristine @drm_plane_state.
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 34a599c3d86d..60635eb34758 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -59,11 +59,10 @@ void __drm_atomic_helper_plane_state_init(struct drm_plane_state *state,
 					   struct drm_plane *plane);
 struct drm_plane_state *
 drm_atomic_helper_plane_create_state(struct drm_plane *plane);
 void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
 				     struct drm_plane_state *state);
-void drm_atomic_helper_plane_reset(struct drm_plane *plane);
 void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
 					       struct drm_plane_state *state);
 struct drm_plane_state *
 drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane);
 void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state);
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 2c5a5a70a71b..e757e9dbf132 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -363,13 +363,10 @@ struct drm_plane_funcs {
 	 * @reset:
 	 *
 	 * Reset plane hardware and software state to off. This function isn't
 	 * called by the core directly, only through drm_mode_config_reset().
 	 * It's not a helper hook only for historical reasons.
-	 *
-	 * Atomic drivers can use drm_atomic_helper_plane_reset() to reset
-	 * atomic state using this hook.
 	 */
 	void (*reset)(struct drm_plane *plane);
 
 	/**
 	 * @set_property:

-- 
2.55.0

