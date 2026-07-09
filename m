Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D24C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 473B610F55F;
	Thu,  9 Jul 2026 11:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H6Pq/Z2O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E4EE10F55E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:53:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07BE74389E;
 Thu,  9 Jul 2026 11:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A4B1F000E9;
 Thu,  9 Jul 2026 11:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597996;
 bh=nBE76M5Kd+rRomTtDK3PBNc8OaFr1qk3sxdEoheiuOQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=H6Pq/Z2O/GzQSzCbfrIr9QyuChDQ+rmvqNZD1M6Pn8z16wP2XaQlZ82dzPvcIuAso
 sAjUDuZgmThcPEt28JrDc1qdQTBS2TKixupCo06bGhmERQYORHjRF5mYJ3Prjaf1yX
 8ih5sm6iXiabQtxTcAjEEHSdGGEpjh5RsnqY+vc4RB+Th1/hw9v2AEFS8CdDMhi5tZ
 kmwSaOpjloJDGB2iqLsJKHsz4x0CHPA7xYrC6Ozm1lUTLU6x+G/wXIEdLn6HIFDwih
 D3jmdiCNOGr2zBnTH8LxTcOZnSdY9t9k5DXw+m8jMtJ9L7t/S+HZ25mLTMMl8jyrlq
 GNDycFJGX3WHw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:51:22 +0200
Subject: [PATCH 56/60] drm/verisilicon: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-56-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 zhengxingda@iscas.ac.cn
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4369; i=mripard@kernel.org;
 h=from:subject:message-id; bh=DDNnW6ZjhuuOf7rQYmbBm85LzpuIXDKthx1xerppu2w=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3Yrx7UZhQrNYj8RrPOHkYT25h9ftaKj9/8tXqrwPv
 cqrVFnbMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYSL8rYcDVgm6Ps1WZ3//b6
 JcXbtfvv8N60dI1oPLT8+jQlnpC/nGsWdG/3mSi4OOf7+cpJJg9UGBt+Xhc6J9TaW30k9FsW5++
 Jr+vs57qkqzndXzDVsUp759Etv/+7Gzkm7D/dv3Ne/1r1s/sA
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

The plane reset implementation creates a custom state subclass, but
only initializes a pristine state without resetting any hardware. This
is equivalent to what atomic_create_state expects. Convert to it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: zhengxingda@iscas.ac.cn
---
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c  |  2 +-
 drivers/gpu/drm/verisilicon/vs_plane.c         | 14 +++++---------
 drivers/gpu/drm/verisilicon/vs_plane.h         |  2 +-
 drivers/gpu/drm/verisilicon/vs_primary_plane.c |  2 +-
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
index fa4f601dd0c8..a53ba72dd205 100644
--- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
@@ -227,14 +227,14 @@ static const struct drm_plane_helper_funcs vs_cursor_plane_helper_funcs = {
 	.atomic_enable	= vs_cursor_plane_atomic_enable,
 	.atomic_disable	= vs_cursor_plane_atomic_disable,
 };
 
 static const struct drm_plane_funcs vs_cursor_plane_funcs = {
+	.atomic_create_state	= drm_atomic_helper_plane_create_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.reset			= drm_atomic_helper_plane_reset,
 	.update_plane		= drm_atomic_helper_update_plane,
 };
 
 static const u32 vs_cursor_plane_formats[] = {
 	DRM_FORMAT_ARGB8888,
diff --git a/drivers/gpu/drm/verisilicon/vs_plane.c b/drivers/gpu/drm/verisilicon/vs_plane.c
index d81f7b8f4c65..47e5df6c951a 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_plane.c
@@ -154,21 +154,17 @@ void vs_plane_destroy_state(struct drm_plane *plane,
 	__drm_atomic_helper_plane_destroy_state(state);
 	kfree(state);
 }
 
 /* Called during init to allocate the plane's atomic state. */
-void vs_plane_reset(struct drm_plane *plane)
+struct drm_plane_state *vs_plane_create_state(struct drm_plane *plane)
 {
 	struct vs_plane_state *vs_state;
 
-	if (plane->state) {
-		__drm_atomic_helper_plane_destroy_state(plane->state);
-		kfree(plane->state);
-		plane->state = NULL;
-	}
-
 	vs_state = kzalloc_obj(*vs_state, GFP_KERNEL);
 	if (!vs_state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_plane_reset(plane, &vs_state->base);
+	__drm_atomic_helper_plane_state_init(&vs_state->base, plane);
+
+	return &vs_state->base;
 }
diff --git a/drivers/gpu/drm/verisilicon/vs_plane.h b/drivers/gpu/drm/verisilicon/vs_plane.h
index 32ed1d70f3b8..5d97c59ea7a0 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.h
+++ b/drivers/gpu/drm/verisilicon/vs_plane.h
@@ -79,11 +79,11 @@ dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
 			      const struct drm_rect *src_rect);
 
 struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane *plane);
 void vs_plane_destroy_state(struct drm_plane *plane,
 			    struct drm_plane_state *state);
-void vs_plane_reset(struct drm_plane *plane);
+struct drm_plane_state *vs_plane_create_state(struct drm_plane *plane);
 
 struct drm_plane *vs_primary_plane_init(struct drm_device *dev, struct vs_dc *dc);
 struct drm_plane *vs_cursor_plane_init(struct drm_device *dev, struct vs_dc *dc);
 
 #endif /* _VS_PLANE_H_ */
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index 1f2be41ae496..4eef28d5ff2d 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -153,14 +153,14 @@ static const struct drm_plane_helper_funcs vs_primary_plane_helper_funcs = {
 	.atomic_enable	= vs_primary_plane_atomic_enable,
 	.atomic_disable	= vs_primary_plane_atomic_disable,
 };
 
 static const struct drm_plane_funcs vs_primary_plane_funcs = {
+	.atomic_create_state	= vs_plane_create_state,
 	.atomic_destroy_state	= vs_plane_destroy_state,
 	.atomic_duplicate_state	= vs_plane_duplicate_state,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.reset			= vs_plane_reset,
 	.update_plane		= drm_atomic_helper_update_plane,
 };
 
 struct drm_plane *vs_primary_plane_init(struct drm_device *drm_dev, struct vs_dc *dc)
 {

-- 
2.54.0

