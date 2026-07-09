Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A9AC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C3D10F55A;
	Thu,  9 Jul 2026 11:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dpqEWKXX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E11F410F566
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:53:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CAFF743AFE;
 Thu,  9 Jul 2026 11:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A27C1F000E9;
 Thu,  9 Jul 2026 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597999;
 bh=bVppNs3l8pa+7BxNAnCaOfnUehqK20X8y5ImYzh6d38=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dpqEWKXXOWHbLrenNcrgWzvuy4KbsfzXP88JCMPib7KT8Fj7bW17S/ZDZ44/BD/Qh
 g0NfOaqhTYJfgksbCNi5MkkTff8JMH1uKjBBn7ALk5xbXBTXZC/XTR9g2ptMce4A2U
 nc7jztMvlyGvuVfXW72vaRs5OrQtiAbxGSjvg3BjcUqj12FGdjX6lLqgv5Xk6doKyf
 1MGNaPl/g/B/r9xjauQ91UtZca/spXywC9z3GK7oLThMGjV645P0PoY0p+WOLHGrPe
 EV4jZpu/9r3MGcURkLLs+dxlb+bjBGMuipxlqkk0q4z0cdVOETFWhybMU8y4ezTTqe
 TuthHWoQIz7cw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:51:23 +0200
Subject: [PATCH 57/60] drm/vmwgfx: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-57-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6276; i=mripard@kernel.org;
 h=from:subject:message-id; bh=st3vhkbH1yeG/cLmZ+SoGViZq1xqU/QbFw36r4Yw/OQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3UrvVVY8X81749ZEhtfmhqo5Vs0iP9wTPCN+aAU5H
 slv7j3cMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACayTo2x3uHxveOvQ5Yv/GWy
 8UaKCz8HB8uHApY7C5/+ep33xvLTkh1sOmqikm4sSrf2nji3/ZvyZ8b6Mrau9pvcDRlTrn+MZpc
 8+OuBRJGzaGLR9PvXyhvCtlf93ztNN/H7nbuX33KcXnwqacJJAA==
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

The plane reset implementation creates a custom state
subclass, but only initializes a pristine state without resetting any
hardware. This is equivalent to what atomic_create_state expects.
Convert to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: zack.rusin@broadcom.com
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 17 +++++++----------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  4 ++--
 5 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 1b407b61f683..dd9960060b08 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -285,31 +285,28 @@ vmw_du_plane_duplicate_state(struct drm_plane *plane)
 	return state;
 }
 
 
 /**
- * vmw_du_plane_reset - creates a blank vmw plane state
+ * vmw_du_plane_create_state - creates a blank vmw plane state
  * @plane: drm plane
  *
- * Resets the atomic state for @plane by freeing the state pointer (which might
- * be NULL, e.g. at driver load time) and allocating a new empty state object.
+ * Allocates a new empty state object.
  */
-void vmw_du_plane_reset(struct drm_plane *plane)
+struct drm_plane_state *vmw_du_plane_create_state(struct drm_plane *plane)
 {
 	struct vmw_plane_state *vps;
 
-	if (plane->state)
-		vmw_du_plane_destroy_state(plane, plane->state);
-
 	vps = kzalloc_obj(*vps);
-
 	if (!vps) {
 		DRM_ERROR("Cannot allocate vmw_plane_state\n");
-		return;
+		return ERR_PTR(-ENOMEM);
 	}
 
-	__drm_atomic_helper_plane_reset(plane, &vps->base);
+	__drm_atomic_helper_plane_state_init(&vps->base, plane);
+
+	return &vps->base;
 }
 
 
 /**
  * vmw_du_plane_destroy_state - destroy plane state
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 2224d7d91d1b..077e10082c8e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -409,11 +409,11 @@ void vmw_du_primary_plane_destroy(struct drm_plane *plane);
 /* Atomic Helpers */
 int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
 				      struct drm_atomic_commit *state);
 void vmw_du_plane_cleanup_fb(struct drm_plane *plane,
 			     struct drm_plane_state *old_state);
-void vmw_du_plane_reset(struct drm_plane *plane);
+struct drm_plane_state *vmw_du_plane_create_state(struct drm_plane *plane);
 struct drm_plane_state *vmw_du_plane_duplicate_state(struct drm_plane *plane);
 void vmw_du_plane_destroy_state(struct drm_plane *plane,
 				struct drm_plane_state *state);
 void vmw_du_plane_unpin_surf(struct vmw_plane_state *vps);
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index af3e32174563..056bc8df74a0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -362,20 +362,20 @@ vmw_ldu_primary_plane_atomic_update(struct drm_plane *plane,
 
 static const struct drm_plane_funcs vmw_ldu_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = vmw_du_primary_plane_destroy,
-	.reset = vmw_du_plane_reset,
+	.atomic_create_state = vmw_du_plane_create_state,
 	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
 	.atomic_destroy_state = vmw_du_plane_destroy_state,
 };
 
 static const struct drm_plane_funcs vmw_ldu_cursor_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = vmw_cursor_plane_destroy,
-	.reset = vmw_du_plane_reset,
+	.atomic_create_state = vmw_du_plane_create_state,
 	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
 	.atomic_destroy_state = vmw_du_plane_destroy_state,
 };
 
 /*
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index c83061cf7455..2e9d73500408 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -754,20 +754,20 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
 
 static const struct drm_plane_funcs vmw_sou_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = vmw_du_primary_plane_destroy,
-	.reset = vmw_du_plane_reset,
+	.atomic_create_state = vmw_du_plane_create_state,
 	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
 	.atomic_destroy_state = vmw_du_plane_destroy_state,
 };
 
 static const struct drm_plane_funcs vmw_sou_cursor_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = vmw_cursor_plane_destroy,
-	.reset = vmw_du_plane_reset,
+	.atomic_create_state = vmw_du_plane_create_state,
 	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
 	.atomic_destroy_state = vmw_du_plane_destroy_state,
 };
 
 /*
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 4139837f4caf..34b608756506 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1472,20 +1472,20 @@ vmw_stdu_crtc_atomic_flush(struct drm_crtc *crtc,
 
 static const struct drm_plane_funcs vmw_stdu_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = vmw_du_primary_plane_destroy,
-	.reset = vmw_du_plane_reset,
+	.atomic_create_state = vmw_du_plane_create_state,
 	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
 	.atomic_destroy_state = vmw_du_plane_destroy_state,
 };
 
 static const struct drm_plane_funcs vmw_stdu_cursor_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = vmw_cursor_plane_destroy,
-	.reset = vmw_du_plane_reset,
+	.atomic_create_state = vmw_du_plane_create_state,
 	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
 	.atomic_destroy_state = vmw_du_plane_destroy_state,
 };
 
 

-- 
2.54.0

