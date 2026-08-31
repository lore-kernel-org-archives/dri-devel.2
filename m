Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB3BC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8A510E9C2;
	Mon, 31 Aug 2026 16:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E6hZ+cKf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D89A710E9C3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:19:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D64760120;
 Mon, 31 Aug 2026 16:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC4E1F000E9;
 Mon, 31 Aug 2026 16:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788193144;
 bh=Xe7uGElJCtQCbTwrNqba9P/GGJYVmzJGn30he4R/0wY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=E6hZ+cKfFOJ7s+MDGE7QDcH7WoZXRYwB3zaO9faxxNUef2o0Qw/bjcCTp4i1XSAm9
 n5+VUGDww1nwf72PopzgctFWSRdV15Ih8XnD/u4O/AgQxJz0bwO4x0UBenLmBwCH+H
 CNQST0aizv9iJCFqmque9Rh+mFxTws+GDqmZLLAU5Ff3I7QDoIUrlnUxnsmd+lZZy+
 W4R2vXZg70A0fFM8qXCiM9FrwmTSAY/zGXAGHbfXrjGQaArBD6BpVU8nehv/ZUvQvL
 U1NROx13hL0xyIXlH62cUEhS35Jqj5s84vGMaf1D4wYhCxvSX0d+n3yF/0gPYxrsKQ
 V5o92FjMWdgFw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 18:17:37 +0200
Subject: [PATCH v3 21/40] drm/verisilicon: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-plane-reset-v3-21-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 zhengxingda@iscas.ac.cn
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4423; i=mripard@kernel.org;
 h=from:subject:message-id; bh=JCAgT04sVZOGPohd7Jlnl6sGhZ2u6YZ58W8aN7F/Rv0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlTV0o+yzhaL1kiJfvie+XKLR6XF0dOcb7lE7D1f1qqN
 N8m/nUtHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi/PMYG5YyNfrUvwmV4yzO
 P5EY5uu4/d+z/V5+P+Z1hvivKDNrnXl4xrVFaeXavJcZKvnmRnXkMtYXVLy32jDreNW6ycrn+Uw
 u72O6U6CbY6F4TffpJfcWZ57Nrre9+Wf+U727oDri86XVk7YCAA==
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
index 05e7a04e614c..6a7fd9e179bb 100644
--- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
@@ -229,14 +229,14 @@ static const struct drm_plane_helper_funcs vs_cursor_plane_helper_funcs = {
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
index 38b8b536eccb..864b54121b95 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_plane.c
@@ -134,21 +134,17 @@ void vs_plane_destroy_state(struct drm_plane *plane,
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
index e4f82f1fc6e9..b4ce14098aa3 100644
--- a/drivers/gpu/drm/verisilicon/vs_plane.h
+++ b/drivers/gpu/drm/verisilicon/vs_plane.h
@@ -77,11 +77,11 @@ static inline struct vs_plane_state *to_vs_plane_state(struct drm_plane_state *s
 int drm_format_to_vs_format(u32 drm_format, struct vs_format *vs_format);
 
 struct drm_plane_state *vs_plane_duplicate_state(struct drm_plane *plane);
 void vs_plane_destroy_state(struct drm_plane *plane,
 			    struct drm_plane_state *state);
-void vs_plane_reset(struct drm_plane *plane);
+struct drm_plane_state *vs_plane_create_state(struct drm_plane *plane);
 
 struct drm_plane *vs_primary_plane_init(struct drm_device *dev, struct vs_dc *dc);
 struct drm_plane *vs_cursor_plane_init(struct drm_device *dev, struct vs_dc *dc);
 
 #endif /* _VS_PLANE_H_ */
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index 2750016a7f2c..20a820f1ef30 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -158,14 +158,14 @@ static const struct drm_plane_helper_funcs vs_primary_plane_helper_funcs = {
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

