Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F247EC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4322010F654;
	Fri, 14 Aug 2026 14:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eAyVuvmT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7251510F645
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:59:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AE5E407F6;
 Fri, 14 Aug 2026 14:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54491F000E9;
 Fri, 14 Aug 2026 14:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719566;
 bh=zdQYcnn2A7evVZkhQgl/K+KL+bcJzQObIJuJPFnBFkM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eAyVuvmTj4ESLZf6tGrhTkVoKd+b2RNyPZbCEPz00ifGnOBRX6S5sqFTR7v8fLJc/
 8TRgnr6+gBfQTm3ByLsYS4D/I5EJAbgFCRd3p21co3gfJjDwhI4u/2TRgq/X7wZsrj
 8YgfoG2QA4Je14g70ci81a979iS+vdipu2Hr5PaRxEWXmP63TQpapJh2el3+/GaaiL
 NdDqBkl67oq6F8AvsBS7Cl6+ojNhMfjSrNB5mV2JCYjPkmsvMsS7198q0PHCja1dF5
 z0w36EDVwF4vcL+6+akOTKz6bJwYo6gOrAC5yg12uoTJ+qqemesFVZqVkl00Rtf1EN
 nkVdAibx4j4Aw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:57:34 +0200
Subject: [PATCH v2 45/61] drm/atmel-hlcdc: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-45-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
 dharma.b@microchip.com, manikandan.m@microchip.com, 
 nicolas.ferre@microchip.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7180; i=mripard@kernel.org;
 h=from:subject:message-id; bh=mE9QJtSX1ZYIKIYFMD5NkF08HlyTW/7xdvp58Luzap8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1Ojdq1FMMzO7NiF1a6Lhxm88Tl+0bJ3FJLM2Kvh7Qt
 nSH4qY7HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiz44z1lkYTV5adbdjNWvZ
 Ds102WSvLZnJzqnb0rX8Cnk00j+ZnCzMb950bpO59sNE0R3B8VdqGBuezDUS45Ke8H7pYXtx3r8
 5f+bfe9et3iC94av4Zu5XLNHhM0Xrme5P76048uqsS8zLfQ4A
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

Tested-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: alexandre.belloni@bootlin.com
Cc: claudiu.beznea@tuxon.dev
Cc: dharma.b@microchip.com
Cc: manikandan.m@microchip.com
Cc: nicolas.ferre@microchip.com
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 70a1cef24388..e09ce6342085 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -1181,35 +1181,35 @@ static void atmel_hlcdc_plane_atomic_destroy_state(struct drm_plane *p,
 	__drm_atomic_helper_plane_destroy_state(s);
 
 	kfree(state);
 }
 
-static void atmel_hlcdc_plane_reset(struct drm_plane *p)
+static struct drm_plane_state *atmel_hlcdc_plane_create_state(struct drm_plane *p)
 {
 	struct atmel_hlcdc_plane_state *state;
-
-	if (p->state) {
-		atmel_hlcdc_plane_atomic_destroy_state(p, p->state);
-		p->state = NULL;
-	}
+	int ret;
 
 	state = kzalloc_obj(*state);
-	if (state) {
-		if (atmel_hlcdc_plane_alloc_dscrs(p, state)) {
-			kfree(state);
-			drm_err(p->dev,
-				"Failed to allocate initial plane state\n");
-			return;
-		}
-		__drm_atomic_helper_plane_reset(p, &state->base);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	ret = atmel_hlcdc_plane_alloc_dscrs(p, state);
+	if (ret) {
+		kfree(state);
+		drm_err(p->dev, "Failed to allocate initial plane state\n");
+		return ERR_PTR(ret);
 	}
+
+	__drm_atomic_helper_plane_state_init(&state->base, p);
+
+	return &state->base;
 }
 
 static const struct drm_plane_funcs layer_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.reset = atmel_hlcdc_plane_reset,
+	.atomic_create_state = atmel_hlcdc_plane_create_state,
 	.atomic_duplicate_state = atmel_hlcdc_plane_atomic_duplicate_state,
 	.atomic_destroy_state = atmel_hlcdc_plane_atomic_destroy_state,
 };
 
 static int atmel_hlcdc_plane_create(struct drm_device *dev,

-- 
2.55.0

