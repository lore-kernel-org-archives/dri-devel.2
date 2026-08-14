Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE32C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE7B10F657;
	Fri, 14 Aug 2026 14:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VAhFUMQI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BD810F645
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:59:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E00E360254;
 Fri, 14 Aug 2026 14:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202431F000E9;
 Fri, 14 Aug 2026 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719568;
 bh=mfBNsgF3zidzgFiNnSm7qaGCxvi2ZdL05Ik1cbGf/so=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VAhFUMQIuGQQAbGIVcxftGuuvqqqtI5h5Bfb6rsJy302jKK69UXZt7kZtj8i/afaW
 +N06ooFAr3LUcnXtZEyDjTwFThQyA9Z5EUaL7fYImDulA3Yj8aG2dMhw4M+KhE4K3K
 JKU7sqI5atEFAPXSlzQnBWERaQmYfcvs/KYNsK3FYV4ZiogPXKQOnnoOdhxH8TQE5n
 QLlrtxelVXjmsLodhfqfD66dp4ewxgSUBzJd6WQB3HVWPKIu4qypi1YJCkJ7EIbMx6
 VKz09rVGdeXTWoHbWallN0I8aVgGdPaJHqURVWxMCCGOUV5Q7+j2bFL9MpCcdy343p
 O4eXLGyySuxBA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:57:35 +0200
Subject: [PATCH v2 46/61] drm/exynos: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-46-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 alim.akhtar@samsung.com, inki.dae@samsung.com, krzk@kernel.org, 
 kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org, 
 sw0312.kim@samsung.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7338; i=mripard@kernel.org;
 h=from:subject:message-id; bh=lawd9I8Vl3BnH0N/nvmouxRrGEsKUsKUHnpMfVrUYC0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1OjcmJeZ5qTcEdbNPW3MozevP9UNXNbpO/XjLsYaz2
 So8/tzUjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRJ8yMDZM+9UZd9MleZiHP
 t02OoU/3+q+HnZqd96NXvN8XEMNxb8ZD9efvXnnUFyu9lTW/4ykWxdgw7UW4Slj5LVu9eKEVTF7
 beMv9J/W21+6u3OjE9TD36VfN54vbp19KF2WMP8HVOFvbrhQA
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
Cc: alim.akhtar@samsung.com
Cc: inki.dae@samsung.com
Cc: krzk@kernel.org
Cc: kyungmin.park@samsung.com
Cc: linux-samsung-soc@vger.kernel.org
Cc: sw0312.kim@samsung.com
---
 drivers/gpu/drm/exynos/exynos_drm_plane.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index 5c04ef87e400..020e8c9cf7de 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -120,27 +120,23 @@ static void exynos_plane_mode_set(struct exynos_drm_plane_state *exynos_state)
 			  "plane : offset_x/y(%d,%d), width/height(%d,%d)",
 			  exynos_state->crtc.x, exynos_state->crtc.y,
 			  exynos_state->crtc.w, exynos_state->crtc.h);
 }
 
-static void exynos_drm_plane_reset(struct drm_plane *plane)
+static struct drm_plane_state *exynos_drm_plane_create_state(struct drm_plane *plane)
 {
 	struct exynos_drm_plane *exynos_plane = to_exynos_plane(plane);
 	struct exynos_drm_plane_state *exynos_state;
 
-	if (plane->state) {
-		exynos_state = to_exynos_plane_state(plane->state);
-		__drm_atomic_helper_plane_destroy_state(plane->state);
-		kfree(exynos_state);
-		plane->state = NULL;
-	}
-
 	exynos_state = kzalloc_obj(*exynos_state);
-	if (exynos_state) {
-		__drm_atomic_helper_plane_reset(plane, &exynos_state->base);
-		plane->state->zpos = exynos_plane->config->zpos;
-	}
+	if (!exynos_state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_plane_state_init(&exynos_state->base, plane);
+	exynos_state->base.zpos = exynos_plane->config->zpos;
+
+	return &exynos_state->base;
 }
 
 static struct drm_plane_state *
 exynos_drm_plane_duplicate_state(struct drm_plane *plane)
 {
@@ -167,11 +163,11 @@ static void exynos_drm_plane_destroy_state(struct drm_plane *plane,
 
 static struct drm_plane_funcs exynos_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
 	.destroy	= drm_plane_cleanup,
-	.reset		= exynos_drm_plane_reset,
+	.atomic_create_state = exynos_drm_plane_create_state,
 	.atomic_duplicate_state = exynos_drm_plane_duplicate_state,
 	.atomic_destroy_state = exynos_drm_plane_destroy_state,
 };
 
 static int

-- 
2.55.0

