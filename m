Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F8DC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472E510E6BA;
	Thu,  9 Jul 2026 11:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GrlHV3sk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01E6F10E6BA
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:51:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E048D43AD7;
 Thu,  9 Jul 2026 11:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD1E1F00AC4;
 Thu,  9 Jul 2026 11:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597867;
 bh=F3P1vKvovppI+MgU1MV5GmcW0kh8/fdjtth994eT1UI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GrlHV3skf1SKNnRxz14DKPRMBTXmLIYkKP1fTAFZE5U6rE6Z+u3nGBa//106U+YoC
 kZX/bXID/UK2KFrbY5n4EIdzWia+5zYbr9PDzHyv9r1IL4t9uAncPxWspXnJtGnQBv
 8T8ytjIzBULPl5eKoA2FzBr8s871YOSOGkHxSi5ay/0TZzIQWZ68JJv7LHdSZSYPN9
 2Uco+Aezjy/WxOiFL9w6WgnR9B1fYaWifWpcZ4MgyNXVvoTmhz0X/W0i3oJy/0ul5z
 enpNq4gifl4/0Q6hk08OUMzTH8iSGQ66gnZ4XDvlG+kyICny6Hx32a/RDlWCUmBhg/
 mLhCCMK5CLleA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:50:28 +0200
Subject: [PATCH 02/60] drm/gem-atomic-helper: Create
 drm_gem_create_shadow_plane_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-2-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3802; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Xmoul8ugIfGvmnOWRaTPwFjzh3O5XmUIMLqoCGQp3gs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3VzfWvU880VOyGxKmPyslmfB3VSxGfMl42J3fffg5
 Xj7LWt2x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjI1hWMDYe9d2s++Rkhen3d
 PG7tvRqnxEJFUh+mTp/Jl8LzI3K1d9WJA4vvbjgSmtDU5Gn3xeX6T8aGp0f1p/TP5Og/MYvLMMb
 a9Xrg7zfCe+rYJzyzcPC5E9He16LqsUpt1oT0rT0vJpxftO48AA==
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

The GEM shadow-plane helpers only expose reset functions
(drm_gem_reset_shadow_plane and __drm_gem_reset_shadow_plane) that
handle both the initial state allocation and the reset path. The new
atomic_create_state hook requires a function that only allocates and
initializes a pristine state without any side effect.

Create __drm_gem_shadow_plane_state_init() to initialize a
pre-allocated shadow plane state, and
drm_gem_create_shadow_plane_state() to allocate and initialize one
from scratch.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 42 +++++++++++++++++++++++++++++++++
 include/drm/drm_gem_atomic_helper.h     |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index abef865c5f2c..7ef67c2d77ce 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -178,10 +178,52 @@ EXPORT_SYMBOL_GPL(drm_gem_plane_helper_prepare_fb);
 
 /*
  * Shadow-buffered Planes
  */
 
+/**
+ * __drm_gem_shadow_plane_state_init - initializes shadow-buffered plane state
+ * @plane: the plane
+ * @shadow_plane_state: the shadow-buffered plane state
+ *
+ * This function initializes a pre-allocated shadow-buffered plane state.
+ * Helpful for drivers that subclass struct drm_shadow_plane_state.
+ */
+void __drm_gem_shadow_plane_state_init(struct drm_plane *plane,
+				       struct drm_shadow_plane_state *shadow_plane_state)
+{
+	__drm_atomic_helper_plane_state_init(&shadow_plane_state->base, plane);
+	drm_format_conv_state_init(&shadow_plane_state->fmtcnv_state);
+}
+EXPORT_SYMBOL(__drm_gem_shadow_plane_state_init);
+
+/**
+ * drm_gem_create_shadow_plane_state - creates a shadow-buffered plane state
+ * @plane: the plane
+ *
+ * This function implements struct &drm_plane_funcs.atomic_create_state for
+ * shadow-buffered planes. It assumes the new state to be of type
+ * struct drm_shadow_plane_state.
+ *
+ * Returns:
+ * A pointer to a new plane state on success, or an ERR_PTR()-encoded
+ * error code otherwise.
+ */
+struct drm_plane_state *drm_gem_create_shadow_plane_state(struct drm_plane *plane)
+{
+	struct drm_shadow_plane_state *shadow_plane_state;
+
+	shadow_plane_state = kzalloc_obj(*shadow_plane_state);
+	if (!shadow_plane_state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_gem_shadow_plane_state_init(plane, shadow_plane_state);
+
+	return &shadow_plane_state->base;
+}
+EXPORT_SYMBOL(drm_gem_create_shadow_plane_state);
+
 /**
  * __drm_gem_duplicate_shadow_plane_state - duplicates shadow-buffered plane state
  * @plane: the plane
  * @new_shadow_plane_state: the new shadow-buffered plane state
  *
diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
index 3e01c619a25e..43657d8fb1c8 100644
--- a/include/drm/drm_gem_atomic_helper.h
+++ b/include/drm/drm_gem_atomic_helper.h
@@ -93,10 +93,13 @@ void __drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane,
 void __drm_gem_destroy_shadow_plane_state(struct drm_shadow_plane_state *shadow_plane_state);
 void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
 				  struct drm_shadow_plane_state *shadow_plane_state);
 
 void drm_gem_reset_shadow_plane(struct drm_plane *plane);
+void __drm_gem_shadow_plane_state_init(struct drm_plane *plane,
+				       struct drm_shadow_plane_state *shadow_plane_state);
+struct drm_plane_state *drm_gem_create_shadow_plane_state(struct drm_plane *plane);
 struct drm_plane_state *drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane);
 void drm_gem_destroy_shadow_plane_state(struct drm_plane *plane,
 					struct drm_plane_state *plane_state);
 
 /**

-- 
2.54.0

