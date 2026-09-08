Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2477C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 332BA10EC85;
	Tue,  8 Sep 2026 14:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BBx60tWL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13CC10EC85
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:49:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB07443E2C;
 Tue,  8 Sep 2026 14:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398901F00A3D;
 Tue,  8 Sep 2026 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788878990;
 bh=OtkTrmVmvY7px/lNOwsqOutG6OoEn6b45s4L1hjGBkg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BBx60tWLTTGsHeAwSJ00ayXs3bjRHGBM8dRJAdykC+0CE7lEIJG5D/86FtOfu827b
 C4DVQ5TGESRTrZoS1/iKv3Mey+ZjSoftE5PRziLJO7QcU3fB7NNhgtGf9jW/A72p7u
 ky32WyY+Tjxoi5q1y33hmtnpwsino+AuuVe/R/solYydLP3sL/U3EPKjaS9M02xT0t
 VAct0OEforS8eGHrilUm3dBue6CtT5yYr+dtKQiXBFinhNnJatc+FOXzKRQHy8bej9
 7OSxGKxWWXjAE3MD3y3DWHM838Oy1C5m77brJ+Y4yBiPc4XPt80Sx2qf0E7QDnU1Sm
 y/8CXgH9QREZw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 08 Sep 2026 16:47:10 +0200
Subject: [PATCH v4 39/41] drm/vmwgfx: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-no-more-plane-reset-v4-39-a31b3fcfc989@kernel.org>
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Zack Rusin <zack.rusin@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
 zack.rusin@broadcom.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6327; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+seX76TXqZZsBxPUKdgiKHAI4yreNqj0Ear0CgOAVxo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkL5O+tCFh868naLT4R9j1sHf0v54kKvNmuxvJ2sw4Tb
 9/ErFPvOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEsrMY6wu6M5JXXZww905O
 14zGowZmpYU3f3uduhL9xzgh10CcO8fS5cLLAx538zq9/73ysmm1YKzPY7wlu9R9nee9RTuTGsX
 8FNm2SV/borvmwnLj/1XqQTLV0anqj79d2N9Q88jp18eYMyIA
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

Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
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
index 0b470809661c..9031dccad31d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -277,31 +277,28 @@ vmw_du_plane_duplicate_state(struct drm_plane *plane)
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
index e641f33341e6..5085d8bccf0a 100644
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
index a4b28341f622..b147f5db9df5 100644
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
index a05f935f1841..89714d5c235b 100644
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
index 939da0e11dbb..cbf55084110a 100644
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
2.55.0

