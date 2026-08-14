Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7435AC5DF6A
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7300E10F63B;
	Fri, 14 Aug 2026 14:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dq7t7DA+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7292010F63B
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:58:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB94860254;
 Fri, 14 Aug 2026 14:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FF01F000E9;
 Fri, 14 Aug 2026 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719513;
 bh=5fXeu1cA9qTYjCs/YR8HQXC0pfrQS470n59EQYlftFI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dq7t7DA+uyQqkDboSe6P+EevGrL/bSf+qmXIq+Uom6T+4TSpDbBCsEhgTg0tBTB0k
 EZRFzx8CAPSOLgV6S5JyisOVqNdhkXLWuzL+tZ8MfL45z1XwZ+XTNxmVqPs9TY/zB3
 EnwU+XWSoOc7igEQzzUC5wo3GdBaGEbciOAyZ0JU9dniI/7NW7xYjbKa4JZYYHfWmX
 fmfWehZGcR/ludKbnwj2TX7vuUM87vrzHssG1o1IpDlYhdUkXplaRVjTqIC8K5Tixq
 Os4g7XRfv17dkNrso8gJhrAOAJWVNlJWW/X7gcuT7iQo/bRkO6sufL+oO7FnP6rmW9
 7TVrYTHjUia+w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:57:12 +0200
Subject: [PATCH v2 23/61] drm/meson: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-23-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 jbrunet@baylibre.com, khilman@baylibre.com, 
 linux-amlogic@lists.infradead.org, martin.blumenstingl@googlemail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7013; i=mripard@kernel.org;
 h=from:subject:message-id; bh=v/Xn1MpSU8Jfd7CMli0Hf2R6nYG1G9L0qAucBypcHL8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1OueMZHhU3vrVMreWH7iZe/KvUNFj9g1Xd3TPmdSw/
 8XUmz8TOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEvkxgrFPlFMndaKm54nND
 x7e9Gx6KL9GP4fxWNa/rEr9b+ov/z9dcvu65dY7PudMZKpZ7Vm11us5YzX7OiY156+yD0k8/Wr0
 zyPwe7dNWKuOaLWIv6nol/thXbxPGJ2w+kf4N7iIOuowHD64CAA==
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

The plane only initializes a pristine state in its reset hook
using drm_atomic_helper_plane_reset(), which is equivalent to what
atomic_create_state expects. Convert to it.

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

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: jbrunet@baylibre.com
Cc: khilman@baylibre.com
Cc: linux-amlogic@lists.infradead.org
Cc: martin.blumenstingl@googlemail.com
---
 drivers/gpu/drm/meson/meson_overlay.c | 2 +-
 drivers/gpu/drm/meson/meson_plane.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index 7047807f1a3e..930119e18a4f 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -800,11 +800,11 @@ static bool meson_overlay_format_mod_supported(struct drm_plane *plane,
 
 static const struct drm_plane_funcs meson_overlay_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
-	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_create_state = drm_atomic_helper_plane_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 	.format_mod_supported   = meson_overlay_format_mod_supported,
 };
 
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 2d88fe87a11a..cf8c90158fcf 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -464,11 +464,11 @@ static bool meson_plane_format_mod_supported(struct drm_plane *plane,
 
 static const struct drm_plane_funcs meson_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
-	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_create_state = drm_atomic_helper_plane_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 	.format_mod_supported   = meson_plane_format_mod_supported,
 };
 

-- 
2.55.0

