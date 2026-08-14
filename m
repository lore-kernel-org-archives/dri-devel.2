Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80FDC5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B9DB10F650;
	Fri, 14 Aug 2026 14:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mMz4QO+0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1899C10F645
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:59:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 01F5040E3A;
 Fri, 14 Aug 2026 14:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB561F000E9;
 Fri, 14 Aug 2026 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719551;
 bh=K1VwukKdTyLdiCQ5zr+IgW3w1fuC2LAwKaKOe+Bsx08=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mMz4QO+0kk5a9xihajkzswvyjbbKIBmY+tinskXTE04tOgrk7ABilUONlikGcXpaR
 pdfhits5wt/URiBpT/VOKcmsyMz29DieF5K6ywGMmyeBh5nJd7ai+ZQ1swmSRCUfZc
 kA1yAG0QhNHaHdcU4LRisLvbRqTiCb5Dsx2olWoFSwhzL69+9BL9GxuoHqO+r45iGe
 UwHg1R8nsVIhW7KTR5b9Lwq4JSe+mbyElbhyd7U/49LAMckq+XexXZzlj62RrAUqDT
 oke8ekhw+fMe4aXmJisXhd5pDbLLmC9TmX38uFAkS6jW+AJel1Vy7iGuCfheAxID0g
 EjF/GRiyCSG3w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:57:28 +0200
Subject: [PATCH v2 39/61] drm/atomic-state-helper: Remove
 drm_atomic_helper_plane_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-39-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211; i=mripard@kernel.org;
 h=from:subject:message-id; bh=U0xJ8/LzrMsRx6JyQWxTe93LdXQcFCFjhHV0odJzAxk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1OlcjXnoVb+Wa53/gR4/uX/OQiTeb800MXAt/i9oe2
 2Q+56RJx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIpDljfeSJ9aFLdPtsvD7F
 eHgpFynwnXu6gnHZkhtbH2b/NdqTzOAlxLhtn/0Bj2OaV4In2EreYKwzfTyjZV3BvDz5q4c3fJd
 6N4un9JSzXf328uk8HTapO7l115yz2qd69rWyqcDGfEuVeRIA
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

