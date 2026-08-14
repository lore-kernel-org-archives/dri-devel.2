Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81270C5DF6A
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B8410F64F;
	Fri, 14 Aug 2026 14:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g7N0pudl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC1010F64F
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:59:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 008CE60A5D;
 Fri, 14 Aug 2026 14:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350C91F00A3A;
 Fri, 14 Aug 2026 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719544;
 bh=aPGNXlWlGY3+h6J9XBcnlpLqLaLj47luVkHd2NkYFq0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=g7N0pudlqLUKL7rudrbwM+Dd62LZKYsaOCIWmTnWKrNDTZHTdXe060bZAFR6eexRB
 ZOpxrWpre9ZE3kc/weBcWqbaQzuD/mNwAmn3CCghSLHDo8+7VGU19qORYSwTxICa+F
 vMaJhe8nF21KnrNz0zKMwVkpgrgTPEUd0ZDTbA/L6IIihhsXODi0A5SvfFJ3or+HOM
 G3SMRzDJ0LzeUIRwri9RVmVBjc3gKUqb1qSRhEJpUqLksfQjokla8U8w868nVPqzl8
 cnV0L3gBTJZ+heRfyISKfaOd9lm4kudtvv/TjPaV7RfPmlVSXOZHKy6AKztujx3ctl
 E3UK2iKulV9RQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:57:25 +0200
Subject: [PATCH v2 36/61] drm/verisilicon: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-36-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 zhengxingda@iscas.ac.cn
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4369; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+Rt2uSz/M8nMx+hVPxTMyO5ndoG7L96HXgwE8pBFuCA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1OldktjwJn8BqujCHofLvE41znz3f7t+w82C1sspei
 WrRw6fCOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEmloZG35xz8p7rCW+8If7
 FreZO0qj5loHHUp8ImGjb5brK7yvaa9Mx4Tgjjt/j6uc7/cIfeZ0mLHeifWfgXDj++JlojMktmn
 r3j19+U15n8MLK1vZpq0v19zhutW+b8If47mXVDR5t2tO6bsLAA==
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
2.55.0

