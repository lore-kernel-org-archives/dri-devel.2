Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F1AC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9EE310F645;
	Fri, 14 Aug 2026 14:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mQt8LyaK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C3C10F654
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:59:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ADCC960204;
 Fri, 14 Aug 2026 14:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BBD1F000E9;
 Fri, 14 Aug 2026 14:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719561;
 bh=Ppwyhrb/ywrGWjpc5k+GhJzL8zeVg2kbFgwS+7tyWfQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mQt8LyaKRaReQgnCfBCe/b+Kdb8L6HGD6G2XTV97jPGpsck94MVQzFOZ65B2lvz+I
 dOZhBf9UZiv7iqRVTNEA0OXdeHRqC89xSYUmqJfNr8PxsWVrwd1tzScEXjNXq2VGpJ
 l2qwKZ/UIhJlNUnEy+iikZQdmbzKxWi5Y5jk7vhB7y8hz/dqyzX6F8G7/SPaLMyCAc
 uCAJLrBpKiXgg8m9RBzTQ4iJRUPDLPq35Ak5ER9WtI9eiIKuvjfNoamkJbph7SXheb
 4j40YQHeeFP10x2BhVVQejvBBbJBbWIuUQ19w7I77Q410HA0Auc9zPfXoscDz51kkn
 iryxpPpTDAvGw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:57:32 +0200
Subject: [PATCH v2 43/61] drm/armada: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-43-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 linux@armlinux.org.uk
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10636; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ulxmdfAQgV6myg18QMompnjRwVHaiZOXfEy0bXU+6UI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1Otf35cl9crOdOfliM/vBb3ZyvJVzuDxkZU6XCPCnL
 +acuju5YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkkTVjfYyUu0yDdT8v6wvF
 bWo2QXcrj6oICVkHZa7hK9y5/v6TFVxdDTfUPyj5nXywN/7036AljA1bFXweTJvG8i3468RS+2j
 t8tX7OJRDAng+3RfW4k4TY6/hcNIMltx2fye/vaBzwJOHTgA=
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

The conversion was done using the following Coccinelle semantic patch:

@@
identifier funcs;
symbol drm_atomic_helper_plane_reset;
symbol drm_atomic_helper_plane_create_state;
@@

struct drm_plane_funcs funcs = {
  ...,
- .reset = drm_atomic_helper_plane_reset,
+ .atomic_create_state = drm_atomic_helper_plane_create_state,
  ...,
};

@match_struct_reset@
identifier funcs, reset_func;
@@
struct drm_plane_funcs funcs = {
    ...,
    .reset = reset_func,
    ...,
};

@reset_uses_helpers depends on match_struct_reset@
identifier match_struct_reset.reset_func;
@@

 void reset_func(...)
 {
 	<+...
(
 	__drm_atomic_helper_plane_reset(...);
|
	__drm_gem_reset_shadow_plane(...);
)
 	...+>
 }

@match_struct_destroy@
identifier funcs, destroy_func;
@@
struct drm_plane_funcs funcs = {
    ...,
    .atomic_destroy_state = destroy_func,
    ...,
};

@script:python renamed_func@
old_name << match_struct_reset.reset_func;
new_name;
@@
if old_name.endswith("_reset"):
    coccinelle.new_name = old_name.replace("_reset", "_create_state")
else:
    coccinelle.new_name = old_name

@update_struct depends on match_struct_reset && reset_uses_helpers@
identifier match_struct_reset.funcs, match_struct_reset.reset_func;
identifier renamed_func.new_name;
@@
struct drm_plane_funcs funcs = {
    ...,
-   .reset = reset_func,
+   .atomic_create_state = new_name,
    ...,
};

@drop_destroy depends on update_struct && match_struct_destroy@
identifier match_struct_reset.reset_func;
identifier match_struct_destroy.destroy_func;
identifier container_func;
identifier P;
symbol drm_atomic_helper_plane_destroy_state;
symbol __drm_atomic_helper_plane_destroy_state;
@@

 void reset_func(struct drm_plane *P)
 {
 	...
(
-	if (P->state) {
- 		<+...
(
-		drm_atomic_helper_plane_destroy_state(P, P->state);
|
-		__drm_atomic_helper_plane_destroy_state(P->state);
|
-		P->funcs->atomic_destroy_state(P, P->state);
|
-		destroy_func(P, P->state);
)
- 		...+>
- 	}
|
-	drm_WARN_ON_ONCE(P->dev, P->state);
|
-	WARN_ON(P->state);
)
 	...
(
-	kfree(P->state);
|
-	kfree(container_func(P->state));
|
 	// kfree is optional
)
(
-	P->state = NULL;
|
 	// plane->state clearing is optional
)
 	...
 }

@drop_destroy_mtk depends on update_struct@
identifier P;
symbol __drm_atomic_helper_plane_destroy_state;
symbol to_mtk_plane_state;
@@

 void mtk_plane_reset(struct drm_plane *P)
 {
 	...
-	if (P->state) {
-		__drm_atomic_helper_plane_destroy_state(P->state);
-		...
-	} else {
 		...
-	}
 	...
 }

@transform_nv50_wndw depends on update_struct@
identifier S;
@@

 void nv50_wndw_reset(...)
 {
 	...
-	if (WARN_ON(!(S = kzalloc_obj(*S))))
+	S = kzalloc_obj(*S);
+	if (WARN_ON(!S))
 		return;
 	...
 }

@transform_kzalloc depends on update_struct@
identifier match_struct_reset.reset_func;
identifier P, S;
statement ST;
statement list STL;
@@

 void reset_func(struct drm_plane *P)
 {
 	<...
 	S = kzalloc_obj(*S);
(
-	if (S)
-	{
-		STL
-	}
+	if (!S) return;
+
+	STL
|
-	if (S) ST
+	if (!S) return;
+
+	ST
)
	...>
 }

@transform_body depends on update_struct@
identifier match_struct_reset.reset_func;
identifier renamed_func.new_name;
identifier S, P;
expression PS;
@@
- void reset_func(struct drm_plane *P)
+ struct drm_plane_state *new_name(struct drm_plane *P)
{
	...
 	S = kzalloc_obj(*S);
	...
(
 	if (!S) {
		...
-		return;
+		return ERR_PTR(-ENOMEM);
 	}
|
 	if (WARN_ON(!S)) {
		...
-		return;
+		return ERR_PTR(-ENOMEM);
 	}
|
 	if (S == NULL) {
 		...
-		return;
+		return ERR_PTR(-ENOMEM);
 	}
)
	...
(
-	__drm_atomic_helper_plane_reset(P, PS);
+	__drm_atomic_helper_plane_state_init(PS, P);
|
-	__drm_gem_reset_shadow_plane(P, PS);
+	__drm_gem_shadow_plane_state_init(P, PS);
)
	...
}

@update_early_return depends on update_struct@
identifier match_struct_reset.reset_func;
identifier renamed_func.new_name;
identifier P;
expression PS;
@@
 struct drm_plane_state *new_name(struct drm_plane *P)
{
	<+...
-	return;
+	return ERR_PTR(-EINVAL);
	...+>
}

@update_return_plane depends on update_struct@
identifier match_struct_reset.reset_func;
identifier renamed_func.new_name;
identifier P;
expression PS;
@@
 struct drm_plane_state *new_name(struct drm_plane *P)
{
	...
 	__drm_atomic_helper_plane_state_init(PS, P);
	...
+
+	return PS;
}

@update_return_shadow depends on update_struct@
identifier renamed_func.new_name;
identifier P;
expression PS;
@@
 struct drm_plane_state *new_name(struct drm_plane *P)
{
	...
 	__drm_gem_shadow_plane_state_init(P, PS);
	...
+
+	return &PS->base;
}

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: linux@armlinux.org.uk
---
 drivers/gpu/drm/armada/armada_overlay.c | 39 +++++++++++++++------------------
 drivers/gpu/drm/armada/armada_plane.c   | 15 +++++++------
 drivers/gpu/drm/armada/armada_plane.h   |  2 +-
 3 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_overlay.c b/drivers/gpu/drm/armada/armada_overlay.c
index 3da0b857ef95..e75706b85dd1 100644
--- a/drivers/gpu/drm/armada/armada_overlay.c
+++ b/drivers/gpu/drm/armada/armada_overlay.c
@@ -299,34 +299,31 @@ armada_overlay_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
 fail:
 	drm_atomic_commit_put(state);
 	return ret;
 }
 
-static void armada_overlay_reset(struct drm_plane *plane)
+static struct drm_plane_state *armada_overlay_create_state(struct drm_plane *plane)
 {
 	struct armada_overlay_state *state;
 
-	if (plane->state)
-		__drm_atomic_helper_plane_destroy_state(plane->state);
-	kfree(plane->state);
-	plane->state = NULL;
-
 	state = kzalloc_obj(*state);
-	if (state) {
-		state->colorkey_yr = 0xfefefe00;
-		state->colorkey_ug = 0x01010100;
-		state->colorkey_vb = 0x01010100;
-		state->colorkey_mode = CFG_CKMODE(CKMODE_RGB) |
-				       CFG_ALPHAM_GRA | CFG_ALPHA(0);
-		state->colorkey_enable = ADV_GRACOLORKEY;
-		state->brightness = DEFAULT_BRIGHTNESS;
-		state->contrast = DEFAULT_CONTRAST;
-		state->saturation = DEFAULT_SATURATION;
-		__drm_atomic_helper_plane_reset(plane, &state->base.base);
-		state->base.base.color_encoding = DEFAULT_ENCODING;
-		state->base.base.color_range = DRM_COLOR_YCBCR_LIMITED_RANGE;
-	}
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	state->colorkey_yr = 0xfefefe00;
+	state->colorkey_ug = 0x01010100;
+	state->colorkey_vb = 0x01010100;
+	state->colorkey_mode = CFG_CKMODE(CKMODE_RGB) | CFG_ALPHAM_GRA | CFG_ALPHA(0);
+	state->colorkey_enable = ADV_GRACOLORKEY;
+	state->brightness = DEFAULT_BRIGHTNESS;
+	state->contrast = DEFAULT_CONTRAST;
+	state->saturation = DEFAULT_SATURATION;
+	__drm_atomic_helper_plane_state_init(&state->base.base, plane);
+	state->base.base.color_encoding = DEFAULT_ENCODING;
+	state->base.base.color_range = DRM_COLOR_YCBCR_LIMITED_RANGE;
+
+	return &state->base.base;
 }
 
 static struct drm_plane_state *
 armada_overlay_duplicate_state(struct drm_plane *plane)
 {
@@ -464,11 +461,11 @@ static int armada_overlay_get_property(struct drm_plane *plane,
 
 static const struct drm_plane_funcs armada_ovl_plane_funcs = {
 	.update_plane	= armada_overlay_plane_update,
 	.disable_plane	= drm_atomic_helper_disable_plane,
 	.destroy	= drm_plane_helper_destroy,
-	.reset		= armada_overlay_reset,
+	.atomic_create_state = armada_overlay_create_state,
 	.atomic_duplicate_state = armada_overlay_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 	.atomic_set_property = armada_overlay_set_property,
 	.atomic_get_property = armada_overlay_get_property,
 };
diff --git a/drivers/gpu/drm/armada/armada_plane.c b/drivers/gpu/drm/armada/armada_plane.c
index fe46a8e4508a..1f5172d6816b 100644
--- a/drivers/gpu/drm/armada/armada_plane.c
+++ b/drivers/gpu/drm/armada/armada_plane.c
@@ -254,19 +254,20 @@ static const struct drm_plane_helper_funcs armada_primary_plane_helper_funcs = {
 	.atomic_check	= armada_drm_plane_atomic_check,
 	.atomic_update	= armada_drm_primary_plane_atomic_update,
 	.atomic_disable	= armada_drm_primary_plane_atomic_disable,
 };
 
-void armada_plane_reset(struct drm_plane *plane)
+struct drm_plane_state *armada_plane_create_state(struct drm_plane *plane)
 {
 	struct armada_plane_state *st;
-	if (plane->state)
-		__drm_atomic_helper_plane_destroy_state(plane->state);
-	kfree(plane->state);
 	st = kzalloc_obj(*st);
-	if (st)
-		__drm_atomic_helper_plane_reset(plane, &st->base);
+	if (!st)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_plane_state_init(&st->base, plane);
+
+	return &st->base;
 }
 
 struct drm_plane_state *armada_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct armada_plane_state *st;
@@ -283,11 +284,11 @@ struct drm_plane_state *armada_plane_duplicate_state(struct drm_plane *plane)
 
 static const struct drm_plane_funcs armada_primary_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
 	.destroy	= drm_plane_helper_destroy,
-	.reset		= armada_plane_reset,
+	.atomic_create_state = armada_plane_create_state,
 	.atomic_duplicate_state = armada_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
 
 int armada_drm_primary_plane_init(struct drm_device *drm,
diff --git a/drivers/gpu/drm/armada/armada_plane.h b/drivers/gpu/drm/armada/armada_plane.h
index 69bef09ea028..be2b1eaafad7 100644
--- a/drivers/gpu/drm/armada/armada_plane.h
+++ b/drivers/gpu/drm/armada/armada_plane.h
@@ -23,11 +23,11 @@ void armada_drm_plane_calc(struct drm_plane_state *state, u32 addrs[2][3],
 	u16 pitches[3], bool interlaced);
 void armada_drm_plane_cleanup_fb(struct drm_plane *plane,
 	struct drm_plane_state *old_state);
 int armada_drm_plane_atomic_check(struct drm_plane *plane,
 	struct drm_atomic_commit *state);
-void armada_plane_reset(struct drm_plane *plane);
+struct drm_plane_state *armada_plane_create_state(struct drm_plane *plane);
 struct drm_plane_state *armada_plane_duplicate_state(struct drm_plane *plane);
 void armada_plane_destroy_state(struct drm_plane *plane,
 				struct drm_plane_state *state);
 
 int armada_drm_primary_plane_init(struct drm_device *drm,

-- 
2.55.0

