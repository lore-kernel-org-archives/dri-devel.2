Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42686C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 895F010F550;
	Thu,  9 Jul 2026 11:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="afmXWQs3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4693410F550
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:52:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FBC24162A;
 Thu,  9 Jul 2026 11:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88691F000E9;
 Thu,  9 Jul 2026 11:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597965;
 bh=QdU/5b1IZWK9+GODzUGSbRRyw6LPERg+IxIJRU/YYDs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=afmXWQs3Ee+gLMOKCKVp/TOAi7n8/jGEH32I+MySEwiY+i+gSTPnopHPmyqA1zIeM
 5G3qN88PDizn19//11XoQnMcyzPSJiPgkWOLYks7o8W2t+vSQB+Icv/SV/b7zT1Cu9
 YSgH4wuWIVig0mNpFescIS85DguAP16J6ZYo9qAy1DILljjqUG4KA64G+quZ4XAuAJ
 Os+fXTCj2FR2fcdTUs9EdluR8c92/GIrPUQgQ20ptrjVI7KpLSgAl1E2NbKeDQ9TJo
 /dzcmrUHpWOFQ0p0e5frDJLVcR4vLokUlDDI0Vc45XchNeP/p5luMFo4CKOiK9IDfg
 lq2S49HO6sDpA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:51:09 +0200
Subject: [PATCH 43/60] drm/atmel-hlcdc: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-43-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
 dharma.b@microchip.com, manikandan.m@microchip.com, 
 nicolas.ferre@microchip.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7315; i=mripard@kernel.org;
 h=from:subject:message-id; bh=0NKTQuyRg+0cqZTmNhz7bI5bc2e8QznE2MEocWAeGcU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3TL7mdMnZd51Kzj34w+zssUiC/6/Xx5HWmSdEz39k
 3Nt8qrbHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAibzcwNnTK2tdql7wVfyTy
 fcWNna+M3p1hi1l6SfqZcNn9/o/p2jYX+2Z1bbFf0HVU7dSJ18+b8hnrPS9s3HyDaes5i5z984p
 mlgVtPRPkuyZi3ulWKb9ZZXfF79l5cDbldeu9NS8/zv+n5LotAA==
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
Cc: alexandre.belloni@bootlin.com
Cc: claudiu.beznea@tuxon.dev
Cc: dharma.b@microchip.com
Cc: manikandan.m@microchip.com
Cc: nicolas.ferre@microchip.com
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 27 +++++++++++--------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index f17a832351e9..ff35251a0184 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -1181,40 +1181,37 @@ static void atmel_hlcdc_plane_atomic_destroy_state(struct drm_plane *p,
 	__drm_atomic_helper_plane_destroy_state(s);
 
 	kfree(state);
 }
 
-static void atmel_hlcdc_plane_reset(struct drm_plane *p)
+static struct drm_plane_state *atmel_hlcdc_plane_create_state(struct drm_plane *p)
 {
 	struct atmel_hlcdc_plane_state *state;
 	struct atmel_hlcdc_dc *dc = p->dev->dev_private;
 	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
 
-	if (p->state) {
-		atmel_hlcdc_plane_atomic_destroy_state(p, p->state);
-		p->state = NULL;
-	}
-
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
+	if (atmel_hlcdc_plane_alloc_dscrs(p, state)) {
+		kfree(state);
+		drm_err(p->dev, "Failed to allocate initial plane state\n");
+		return ERR_PTR(-EINVAL);
 	}
+	__drm_atomic_helper_plane_state_init(&state->base, p);
 
 	if (plane->layer.desc->layout.csc)
 		dc->desc->ops->lcdc_csc_init(plane, plane->layer.desc);
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
2.54.0

