Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5BCC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E8A10F668;
	Fri, 14 Aug 2026 15:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fr8QlkF9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98A210F66A
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:59:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2D9744F5D;
 Fri, 14 Aug 2026 14:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF3F1F00A3A;
 Fri, 14 Aug 2026 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719599;
 bh=SWoJ7d/OLymWjXj+kedES1SfX750mTZ0/mjlxf+tiE8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fr8QlkF9BecNLNF4QTefUuEHgyh3rr/yVfU906Gc4zPAgKAM08K2qbYNTW1x0PEEJ
 lQA4zRfGahPx0k+U4CGOGeL8+P3fA5asxu8o/GIKDXiZlsdtWhNCYUzAJMOx7+1efS
 qqU7nkUBi8QkxFhE97UVjj95BDvelxqt8hQBVpya/uKl6tJHPVDsKvqZztZFw9EOGv
 q/ctNUKrs9FOQxKvSL/v06p49sS9+nvEnKbgIJkKDkUgRgFirKKffbNCpxJaUorf6K
 lbVPy8Y7e0PWyyfO8rXeYeu35bOKm/+n0ucXY0G+74VTTJsMYCBzaWrEDCy1MonMY4
 Kh9NYkrJIypBg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:57:48 +0200
Subject: [PATCH v2 59/61] drm/atomic-state-helper: Remove
 __drm_atomic_helper_plane_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-59-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648; i=mripard@kernel.org;
 h=from:subject:message-id; bh=XsZFR4s1avaC9AFT1MEDRR10MDGMqK27KcYsQkRbABY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1Ove03S6Y9zTc2edqVvrhpxZP1zbNE5Md5EONHgdZ7
 t+dpPevYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzEPYyx4QS38M8/fq8cb8wy
 7eGc68iz6iKPRYG3ce3jKYlClUcqfyuy9M+zOfpalk3U+syf/zoXGRumMnL/q74csqDorrDtqvn
 qL4uMwwKa2w96ZMjPPsxg8POM19IXaxR+FOtMuskc9etA3l0A
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

__drm_atomic_helper_plane_reset() is no longer used: all callers now go
through __drm_atomic_helper_plane_state_init(). Remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 22 ----------------------
 include/drm/drm_atomic_state_helper.h     |  2 --
 2 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index f184ce76e090..afd65f0c8f90 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -322,32 +322,10 @@ void __drm_atomic_helper_plane_state_init(struct drm_plane_state *plane_state,
 			plane_state->hotspot_y = val;
 	}
 }
 EXPORT_SYMBOL(__drm_atomic_helper_plane_state_init);
 
-/**
- * __drm_atomic_helper_plane_reset - reset state on plane
- * @plane: drm plane
- * @plane_state: plane state to assign
- *
- * Initializes the newly allocated @plane_state and assigns it to
- * the &drm_plane->state pointer of @plane, usually required when
- * initializing the drivers or when called from the &drm_plane_funcs.reset
- * hook.
- *
- * This is useful for drivers that subclass the plane state.
- */
-void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
-				     struct drm_plane_state *plane_state)
-{
-	if (plane_state)
-		__drm_atomic_helper_plane_state_init(plane_state, plane);
-
-	plane->state = plane_state;
-}
-EXPORT_SYMBOL(__drm_atomic_helper_plane_reset);
-
 /**
  * drm_atomic_helper_plane_create_state - default &drm_plane_funcs.atomic_create_state hook for planes
  * @plane: plane object
  *
  * Allocates and initializes pristine @drm_plane_state.
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 60635eb34758..9051217833e3 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -57,12 +57,10 @@ void drm_atomic_helper_crtc_destroy_state(struct drm_crtc *crtc,
 
 void __drm_atomic_helper_plane_state_init(struct drm_plane_state *state,
 					   struct drm_plane *plane);
 struct drm_plane_state *
 drm_atomic_helper_plane_create_state(struct drm_plane *plane);
-void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
-				     struct drm_plane_state *state);
 void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
 					       struct drm_plane_state *state);
 struct drm_plane_state *
 drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane);
 void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state);

-- 
2.55.0

