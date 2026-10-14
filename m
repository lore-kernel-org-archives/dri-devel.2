Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDC8CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1200810FE82;
	Wed, 14 Oct 2026 17:31:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CC7310FF1D
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:31:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B598460229;
 Wed, 14 Oct 2026 17:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06D21F000C5;
 Wed, 14 Oct 2026 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999098;
 bh=9Kgn8x2Hs3XSTwhJLk5OIdekNU3FXpFVTMYE2NzAJWE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=V3G1nCP4XJ43cT7/qLC/tkI9bGuHWPLz9bVwF5AeptaHQtj7rmXJH2uOy+vPl6jpq
 Bo+iNIZjv3WMFQySgzQbeXV7dWwiNURw+8Otj/CZjeyEEpVupC9uAq+oou6YIYvz6b
 WXqrHvsu9YXij4+pYHf6fMDMlEyFNPtGwM/bE+VEJorkLQb4lIvgxlXQzyGkCKb1cY
 jkynm6y4uxsTdZ4YhBCtXWuOanZ3+qNtp0pwMdiQKgfnlGXJCi7ohird8mjeO9qlBi
 7k2e+fCBnMFZVlfmiB0Sle4YeGzLY5YropN99hqQHtV/KTckveyGPvasiSPO4yvPvt
 daA21oV1p0EBA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:36 +0200
Subject: [PATCH 73/75] drm/vmwgfx: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-73-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Zack Rusin <zack.rusin@broadcom.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5553; i=mripard@kernel.org;
 h=from:subject:message-id; bh=wrGHOlOgN6GvJQMok2IBgCHlEr0jcEw5Dvcsw35VLcg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd2ftdp9yP71pbmZHY6yGCYuEVcGlrnQuzl/hHk9n7
 K6O+vOyYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExk3xHGWpkdsk7TzX7u0ZhS
 nFJy8u6Z/sDdDvfYHVfyfu+xrw/YtD/7c7k4m/jckGMV06v0Xk64xtiwuvNKev+G1qh92rPDvk+
 wDLmXUZ6UL9pqVBvauiKu6MiGszyxht7R0kqqC3f6f3n67CEA
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

The vmwgfx connector reset implementation creates a custom state
subclass, but only initializes a pristine state without resetting any
hardware. This is equivalent to what atomic_create_state expects.
Convert to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 23 ++++++++---------------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  3 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  2 +-
 5 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 9031dccad31d..792758d92f3c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -351,36 +351,29 @@ vmw_du_connector_duplicate_state(struct drm_connector *connector)
 	return state;
 }
 
 
 /**
- * vmw_du_connector_reset - creates a blank vmw connector state
+ * vmw_du_connector_create_state - creates a blank vmw connector state
  * @connector: DRM connector
  *
- * Resets the atomic state for @connector by freeing the state pointer (which
- * might be NULL, e.g. at driver load time) and allocating a new empty state
- * object.
+ * Allocates a new empty state object for @connector.
  */
-void vmw_du_connector_reset(struct drm_connector *connector)
+struct drm_connector_state *
+vmw_du_connector_create_state(struct drm_connector *connector)
 {
 	struct vmw_connector_state *vcs;
 
-
-	if (connector->state) {
-		__drm_atomic_helper_connector_destroy_state(connector->state);
-
-		kfree(vmw_connector_state_to_vcs(connector->state));
-	}
-
 	vcs = kzalloc_obj(*vcs);
-
 	if (!vcs) {
 		DRM_ERROR("Cannot allocate vmw_connector_state\n");
-		return;
+		return ERR_PTR(-ENOMEM);
 	}
 
-	__drm_atomic_helper_connector_reset(connector, &vcs->base);
+	__drm_atomic_helper_connector_state_init(&vcs->base, connector);
+
+	return &vcs->base;
 }
 
 
 /**
  * vmw_du_connector_destroy_state - destroy connector state
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 5085d8bccf0a..283550363fac 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -423,11 +423,12 @@ void vmw_du_crtc_atomic_begin(struct drm_crtc *crtc,
 			      struct drm_atomic_commit *state);
 struct drm_crtc_state *vmw_du_crtc_create_state(struct drm_crtc *crtc);
 struct drm_crtc_state *vmw_du_crtc_duplicate_state(struct drm_crtc *crtc);
 void vmw_du_crtc_destroy_state(struct drm_crtc *crtc,
 				struct drm_crtc_state *state);
-void vmw_du_connector_reset(struct drm_connector *connector);
+struct drm_connector_state *
+vmw_du_connector_create_state(struct drm_connector *connector);
 struct drm_connector_state *
 vmw_du_connector_duplicate_state(struct drm_connector *connector);
 
 void vmw_du_connector_destroy_state(struct drm_connector *connector,
 				    struct drm_connector_state *state);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index b147f5db9df5..0dea09cc29a7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -285,11 +285,11 @@ static void vmw_ldu_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_funcs vmw_legacy_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = vmw_ldu_connector_destroy,
-	.reset = vmw_du_connector_reset,
+	.atomic_create_state = vmw_du_connector_create_state,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
 	.atomic_destroy_state = vmw_du_connector_destroy_state,
 };
 
 static const struct
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index 89714d5c235b..39d58fc392bf 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -340,11 +340,11 @@ static void vmw_sou_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_funcs vmw_sou_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = vmw_sou_connector_destroy,
-	.reset = vmw_du_connector_reset,
+	.atomic_create_state = vmw_du_connector_create_state,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
 	.atomic_destroy_state = vmw_du_connector_destroy_state,
 };
 
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index cbf55084110a..b505f8ba3e83 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -906,11 +906,11 @@ static int vmw_stdu_connector_atomic_check(struct drm_connector *conn,
 static const struct drm_connector_funcs vmw_stdu_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = vmw_stdu_connector_destroy,
-	.reset = vmw_du_connector_reset,
+	.atomic_create_state = vmw_du_connector_create_state,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
 	.atomic_destroy_state = vmw_du_connector_destroy_state,
 };
 
 

-- 
2.55.0

