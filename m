Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED43C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5BA10F557;
	Thu,  9 Jul 2026 11:52:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SU2vuGUF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE2C810F555
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:52:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D74FE41857;
 Thu,  9 Jul 2026 11:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AF21F000E9;
 Thu,  9 Jul 2026 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597969;
 bh=hQxEv9czX1ZokGsR+AkOQmDPqmwzOfPx177uoreYsKo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SU2vuGUF4pHyzKawC1EdZ7XDlt3NwPsA/M7fcx/vk8wsuLNfjeakBDIasSFd6sn7W
 EXkAVVS4/ZhLJRQlJI5eytbR8g1jklCqdlnV65kewSZ0TadE2wr7RoYlfwdKS1HHT9
 THkj94Ldbgp0Un9tNgU66Ojuj6zz3B/Kq9LxFG/VV8tSKrh/OGNPPmAjT36SyaFjFv
 QcRgEvMaNfjIew8rFp/qBRPZGcSm8NXn8B6Vj3u8tp41b/phY9LGZPAl44CfDbPXpA
 XyPtu25DrZeAkr+qW7yBXmm3ndKdHhbe9DNJwixg+IP0eklbxduO3vYMH7QG7bs7j7
 lN754Y+rRfjwQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:51:11 +0200
Subject: [PATCH 45/60] drm/imx/ipuv3: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-45-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Frank.Li@nxp.com, Sascha Hauer <s.hauer@pengutronix.de>, festevam@gmail.com, 
 imx@lists.linux.dev, kernel@pengutronix.de, p.zabel@pengutronix.de
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6992; i=mripard@kernel.org;
 h=from:subject:message-id; bh=p3L5yCKfboXr7PflJmag43CI0oO7dqWoEg/c9ILC1Ec=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3bIcHwwYTGLZ/+v+EOVlZ77IExE+/1PebrXUr26hF
 luCIp50TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIlsvcTYsOXxUyM+WV7GFT+7
 bJvuf5lu0zU3Wq+w/PfnBz/SZms2VIVlemw9c+z0NoHCb3tLhStrGBuW9Uz8UvwlvWY196UlfsE
 qbz3yla/WmU7j+fj4bUuW4m/vytCnDHKfHr52XL0hX6jysSAA
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
Cc: Frank.Li@nxp.com
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: festevam@gmail.com
Cc: imx@lists.linux.dev
Cc: kernel@pengutronix.de
Cc: p.zabel@pengutronix.de
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index c7ec09e557c1..afebd4fe4395 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -295,25 +295,22 @@ void ipu_plane_disable_deferred(struct drm_plane *plane)
 		ipu_plane->disabling = false;
 		ipu_plane_disable(ipu_plane, false);
 	}
 }
 
-static void ipu_plane_state_reset(struct drm_plane *plane)
+static struct drm_plane_state *ipu_plane_state_create_state(struct drm_plane *plane)
 {
 	struct ipu_plane_state *ipu_state;
 
-	if (plane->state) {
-		ipu_state = to_ipu_plane_state(plane->state);
-		__drm_atomic_helper_plane_destroy_state(plane->state);
-		kfree(ipu_state);
-		plane->state = NULL;
-	}
-
 	ipu_state = kzalloc_obj(*ipu_state);
 
-	if (ipu_state)
-		__drm_atomic_helper_plane_reset(plane, &ipu_state->base);
+	if (!ipu_state)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_plane_state_init(&ipu_state->base, plane);
+
+	return &ipu_state->base;
 }
 
 static struct drm_plane_state *
 ipu_plane_duplicate_state(struct drm_plane *plane)
 {
@@ -356,11 +353,11 @@ static bool ipu_plane_format_mod_supported(struct drm_plane *plane,
 }
 
 static const struct drm_plane_funcs ipu_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
-	.reset		= ipu_plane_state_reset,
+	.atomic_create_state = ipu_plane_state_create_state,
 	.atomic_duplicate_state	= ipu_plane_duplicate_state,
 	.atomic_destroy_state	= ipu_plane_destroy_state,
 	.format_mod_supported = ipu_plane_format_mod_supported,
 };
 

-- 
2.54.0

