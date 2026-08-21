Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A69C5DF95
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B7B110F2FB;
	Fri, 21 Aug 2026 14:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m+xUc9IV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71CF10F2EC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:42:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A24361834;
 Fri, 21 Aug 2026 14:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6BE1F000E9;
 Fri, 21 Aug 2026 14:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323325;
 bh=iSdZ3O434VE1+ISRP1TV2rd/S2gMfAKyMQk435eoMIQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=m+xUc9IVze4JrMZZsXORf7Swd4qksSh+tL2ZHz0fZLZNjMeGT+wqpz5XoINlgFlzp
 NWd9sykqOhfjUZ3qnkd/nNvP1pYnjkNCY4XE7vDdcXPTc9U6hFY5A5K/xLxwDo4gLH
 cU5qgHGoVI8tZt+YH9F3oP/y8pz3XA4JDEz+MBlCzy1G0tzcCbBYzNZYzsomx/fPMr
 wqZlNOEyKS5hwYYxnl1RNlMdCwv4iXeK0meeUuPa2zCiFsIRUHu5R3dIGGax2zUxni
 /pPaFoXVQeD+oTqEjFfP3w2Yxak4Mpix/v99QsuzoxKnLy6zETkOZsZD4+WU/AscF/
 /KgZJDTmmV0Cg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:44 +0200
Subject: [PATCH 68/70] drm/vmwgfx: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-68-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Zack Rusin <zack.rusin@broadcom.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5610; i=mripard@kernel.org;
 h=from:subject:message-id; bh=GEQryVgAhdA6WkmAWGMvJddBzSwie7cL4dSre/YVrTM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyWLPi0st3DK7lwmwqGxRrphaN4NzRot5lDB7do/rx
 mvVazQ6prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwEQe6TPWikbuD/vEpXV5+XJF
 nV1z+e2sqoMnFUw/3b+5pVrk+A6xju/ipz0ONRm1blneXTuzYpEMY8Mh9Z/ljG/cJFRV03KWxt1
 NOdl+/7q+6/ejiV+jPeL4N8sfj769dmZ7ONNn121XZk2rzQIA
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

The vmwgfx crtc implementation provides a custom reset hook. However,
this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 22 +++++++---------------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  2 +-
 5 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 1b407b61f683..0b470809661c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -204,36 +204,28 @@ vmw_du_crtc_duplicate_state(struct drm_crtc *crtc)
 	return state;
 }
 
 
 /**
- * vmw_du_crtc_reset - creates a blank vmw crtc state
+ * vmw_du_crtc_create_state - creates a blank vmw crtc state
  * @crtc: DRM crtc
  *
- * Resets the atomic state for @crtc by freeing the state pointer (which
- * might be NULL, e.g. at driver load time) and allocating a new empty state
- * object.
+ * Allocates a new empty state object for @crtc.
  */
-void vmw_du_crtc_reset(struct drm_crtc *crtc)
+struct drm_crtc_state *vmw_du_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct vmw_crtc_state *vcs;
 
-
-	if (crtc->state) {
-		__drm_atomic_helper_crtc_destroy_state(crtc->state);
-
-		kfree(vmw_crtc_state_to_vcs(crtc->state));
-	}
-
 	vcs = kzalloc_obj(*vcs);
-
 	if (!vcs) {
 		DRM_ERROR("Cannot allocate vmw_crtc_state\n");
-		return;
+		return ERR_PTR(-ENOMEM);
 	}
 
-	__drm_atomic_helper_crtc_reset(crtc, &vcs->base);
+	__drm_atomic_helper_crtc_state_init(&vcs->base, crtc);
+
+	return &vcs->base;
 }
 
 
 /**
  * vmw_du_crtc_destroy_state - destroy crtc state
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 2224d7d91d1b..e641f33341e6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -419,11 +419,11 @@ void vmw_du_plane_unpin_surf(struct vmw_plane_state *vps);
 
 int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
 			     struct drm_atomic_commit *state);
 void vmw_du_crtc_atomic_begin(struct drm_crtc *crtc,
 			      struct drm_atomic_commit *state);
-void vmw_du_crtc_reset(struct drm_crtc *crtc);
+struct drm_crtc_state *vmw_du_crtc_create_state(struct drm_crtc *crtc);
 struct drm_crtc_state *vmw_du_crtc_duplicate_state(struct drm_crtc *crtc);
 void vmw_du_crtc_destroy_state(struct drm_crtc *crtc,
 				struct drm_crtc_state *state);
 void vmw_du_connector_reset(struct drm_connector *connector);
 struct drm_connector_state *
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index af3e32174563..a4b28341f622 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -247,11 +247,11 @@ static void vmw_ldu_crtc_mode_set_nofb(struct drm_crtc *crtc)
 }
 
 static const struct drm_crtc_funcs vmw_legacy_crtc_funcs = {
 	.gamma_set = vmw_du_crtc_gamma_set,
 	.destroy = vmw_ldu_crtc_destroy,
-	.reset = vmw_du_crtc_reset,
+	.atomic_create_state = vmw_du_crtc_create_state,
 	.atomic_duplicate_state = vmw_du_crtc_duplicate_state,
 	.atomic_destroy_state = vmw_du_crtc_destroy_state,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.enable_vblank          = vmw_vkms_enable_vblank,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index c83061cf7455..a05f935f1841 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -303,11 +303,11 @@ static void vmw_sou_crtc_atomic_disable(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_funcs vmw_screen_object_crtc_funcs = {
 	.gamma_set = vmw_du_crtc_gamma_set,
 	.destroy = vmw_sou_crtc_destroy,
-	.reset = vmw_du_crtc_reset,
+	.atomic_create_state = vmw_du_crtc_create_state,
 	.atomic_duplicate_state = vmw_du_crtc_duplicate_state,
 	.atomic_destroy_state = vmw_du_crtc_destroy_state,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.enable_vblank          = vmw_vkms_enable_vblank,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 4139837f4caf..939da0e11dbb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -776,11 +776,11 @@ int vmw_kms_stdu_surface_dirty(struct vmw_private *dev_priv,
  *  Screen Target CRTC dispatch table
  */
 static const struct drm_crtc_funcs vmw_stdu_crtc_funcs = {
 	.gamma_set = vmw_du_crtc_gamma_set,
 	.destroy = vmw_stdu_crtc_destroy,
-	.reset = vmw_du_crtc_reset,
+	.atomic_create_state = vmw_du_crtc_create_state,
 	.atomic_duplicate_state = vmw_du_crtc_duplicate_state,
 	.atomic_destroy_state = vmw_du_crtc_destroy_state,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.enable_vblank		= vmw_vkms_enable_vblank,

-- 
2.55.0

