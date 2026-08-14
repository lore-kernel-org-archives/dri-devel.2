Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A75C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85EEF10F627;
	Fri, 14 Aug 2026 14:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TLj5mAib";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A022310F622
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:57:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E8BD60254;
 Fri, 14 Aug 2026 14:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5641F000E9;
 Fri, 14 Aug 2026 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719470;
 bh=lDGY2dKVnZ0QRHZZiNbNrD2zMaCRGefg9yMvWAKprCk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TLj5mAibij7gt4A9Ahw/Hh7sIj2S8CV2AucYcY12C1eZO3IlziONSeOtda0xQpbRd
 x6cHB3ltb8l8Q8vZ46590egYZrgvFlwtFN7qK3hMmi/UQIhBH6ITxNT/fMtpnhc9Nw
 Lf9mzYccXhwNXSSufSaosa0xPF7AfoMBznZ2GEqJ2IOxMgP+gRsWFRRMWflVboVWuq
 ZZO01nFTaWdFRG6ZwJol2gZORiBftkpl02vC1sl8IhZy3DvAxY5kvP091o1gbRXhsp
 0Xr7J2qYbpIKfXS5ZZz5Ud8cpPCcXMotahYCsXmRLmkRIMnphLCNfAJhd29AmgSoyf
 vDSIHLkCERong==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:56:54 +0200
Subject: [PATCH v2 05/61] drm/gem-atomic-helper: Remove
 drm_gem_reset_shadow_plane()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-5-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2849; i=mripard@kernel.org;
 h=from:subject:message-id; bh=WaXpxqXgvbv3vX6FhKaHkX2TmHc3vFQPRX0tJsjal2E=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1OsdWzHe3Mq4ou6mcmbfziZPEK/aDbO+5/QQdX65K+
 cz1Y0pGx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIlCLGahaxY9YldrUc7xLl
 HyqGbf4fMym1TNiX71TXSwWu20LfqqJNwpJyP4W1uk6Wes7vnG/DWKeVdeyAoLS/1re+N+ue/cv
 lPhix4E65FU/R+83npR4nbChZdKgptHrPlPBXTeWp0uxzSgA=
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

drm_gem_reset_shadow_plane() is no longer used: all callers now go
through drm_gem_create_shadow_plane_state() via the
atomic_create_state hook. Remove it.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 23 -----------------------
 include/drm/drm_gem_atomic_helper.h     |  1 -
 2 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index ae854555fd12..3bb6bfd560d3 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -337,33 +337,10 @@ void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
 		__drm_atomic_helper_plane_reset(plane, NULL);
 	}
 }
 EXPORT_SYMBOL(__drm_gem_reset_shadow_plane);
 
-/**
- * drm_gem_reset_shadow_plane - resets a shadow-buffered plane
- * @plane: the plane
- *
- * This function implements struct &drm_plane_funcs.reset_plane for
- * shadow-buffered planes. It assumes the current plane state to be
- * of type struct drm_shadow_plane and it allocates the new state of
- * this type.
- */
-void drm_gem_reset_shadow_plane(struct drm_plane *plane)
-{
-	struct drm_shadow_plane_state *shadow_plane_state;
-
-	if (plane->state) {
-		drm_gem_destroy_shadow_plane_state(plane, plane->state);
-		plane->state = NULL; /* must be set to NULL here */
-	}
-
-	shadow_plane_state = kzalloc_obj(*shadow_plane_state);
-	__drm_gem_reset_shadow_plane(plane, shadow_plane_state);
-}
-EXPORT_SYMBOL(drm_gem_reset_shadow_plane);
-
 /**
  * drm_gem_begin_shadow_fb_access - prepares shadow framebuffers for CPU access
  * @plane: the plane
  * @plane_state: the plane state of type struct drm_shadow_plane_state
  *
diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
index da8a4fb442b4..2deb0cd9ebbe 100644
--- a/include/drm/drm_gem_atomic_helper.h
+++ b/include/drm/drm_gem_atomic_helper.h
@@ -92,11 +92,10 @@ void __drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane,
 					    struct drm_shadow_plane_state *new_shadow_plane_state);
 void __drm_gem_destroy_shadow_plane_state(struct drm_shadow_plane_state *shadow_plane_state);
 void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
 				  struct drm_shadow_plane_state *shadow_plane_state);
 
-void drm_gem_reset_shadow_plane(struct drm_plane *plane);
 void __drm_gem_shadow_plane_state_init(struct drm_plane *plane,
 				       struct drm_shadow_plane_state *shadow_plane_state);
 struct drm_plane_state *drm_gem_create_shadow_plane_state(struct drm_plane *plane);
 struct drm_plane_state *drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane);
 void drm_gem_destroy_shadow_plane_state(struct drm_plane *plane,

-- 
2.55.0

