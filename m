Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08628C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5292710F551;
	Thu,  9 Jul 2026 11:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L6X+ePvT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F9110F54F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:52:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8AE2341620;
 Thu,  9 Jul 2026 11:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B9C1F000E9;
 Thu,  9 Jul 2026 11:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597953;
 bh=5qmZW+wW1FedVwgrUcu9w4euoKAjQkDUUwmWFQWuOmM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=L6X+ePvTykR9DIp0asuts2IexuVZbVoe9ANgdIK4ofqxfQ+0SFQwOBdTp6zDWdAxU
 DLiS1vhpBsRb8rBmPQLZBrPkwAn4jomtjvhm5LmARofh+2ZduaWd3jq8ro4UTx+IGn
 p0dRQqo5CH7XrDQd8PnZm6C7XZFd1UvuH72+qvHy1zEpxQI8FLLb0aE481C1VhizGt
 MPqCnOienhauKh3ekQ4MKui6b4ciTnxulqm+WgIkdYk0vaSVtb1Qf6Gts7S9xKeILz
 mDC+ITokobp4OL9J6p2tTq6JJGXcRfX2d8bAzLfV4udSKG1Pwj3CW4FN3ImEHWFqT+
 VP+aQ/b/sxq6w==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:51:04 +0200
Subject: [PATCH 38/60] drm/atomic-state-helper: Remove
 drm_atomic_helper_plane_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-38-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2525; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PrwWVOczvVmry0MXX2D0Q/caIyBWH52+l7vS8PNNJeY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3VKncnZn17sYylx7mjV/77earbsVMtsXp8xdrq36s
 cqOUZu3YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEwkZxtjfbr+1+dTVqZ11v6Y
 f7Iy90vHl7V/PPtvLIi2unqZ5anMdL2itbmmDCqvVZ7cP+9owzrHgLFO7+auK3Yruq4ynQ115/E
 3LFwxT6V99aH77A3b58hKb0kU8ZuSFDlbtKZg3dpql+aG7joA
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
 2 files changed, 20 deletions(-)

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

-- 
2.54.0

