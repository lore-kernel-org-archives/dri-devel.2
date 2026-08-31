Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190E5C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3709E10E9DD;
	Mon, 31 Aug 2026 16:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TZrOuwBW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF32710E9E3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:19:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2ACA460200;
 Mon, 31 Aug 2026 16:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3CA1F000E9;
 Mon, 31 Aug 2026 16:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788193193;
 bh=YtJOvhtwUBW3ab/W4pSzXNNA6rmV9u32icvhR4KDBhU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TZrOuwBWXsE1rNiCX4Oa1eCk9QsRwghc6bdjhFksP0X0eGpBkyyehKYj+NSwFfzH2
 gXB2KyKVgqwCzCrVLPpX7HhHg+ZtWD4qajEpcLQfgzzuGzD2V2t2092UTM1R+N+TV9
 IwXIpUyV7I35wB/HLDTO9CtidTdPQ7qXy89ch780//mdWsjbNykjathH76m/KXASSF
 E479mRpTUfB+AIqPttDMuI9b/4nc3kbJzzpoy8cOvPfpF4dcMfo+ysmWXE7vFssf72
 E/QA33IGxVkb8wt7QY41FKW1bGB0/2EpDSxXug6jLbtVk8B8uKDUTT4YXxz9KGQpKQ
 LQy0J4GXeXhPg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 18:17:50 +0200
Subject: [PATCH v3 34/40] drm/rcar-du: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-plane-reset-v3-34-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 geert+renesas@glider.be, kieran.bingham+renesas@ideasonboard.com, 
 laurent.pinchart+renesas@ideasonboard.com, 
 linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, 
 tomi.valkeinen+renesas@ideasonboard.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8862; i=mripard@kernel.org;
 h=from:subject:message-id; bh=FLMYnuKxjclMnsuZwZp6f2G+3BV9VyYNETiFrDi8dyU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlTV8rbSmhpfG2UztO/UZ8hem97s5C7u7iA0MHXluIfu
 7mKtud1TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIn0KDI2zNZVfF2tHTAp+tYK
 gTq7N+YdW2+7Xvi/r36K4Kqo8wrBof/Yu7bkrrlp0Dt5znbPzlsnGRvuzyv+ybtalbvovdPyWNs
 uTq5yuTlTtL5N93kvpLB5W8YauaNrp6xaUb/9kuWbHet91X8CAA==
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
Cc: geert+renesas@glider.be
Cc: kieran.bingham+renesas@ideasonboard.com
Cc: laurent.pinchart+renesas@ideasonboard.com
Cc: linux-renesas-soc@vger.kernel.org
Cc: magnus.damm@gmail.com
Cc: tomi.valkeinen+renesas@ideasonboard.com
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c | 15 ++++++---------
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c   | 15 ++++++---------
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
index 8870766b9e54..da2dff9bb317 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
@@ -710,28 +710,25 @@ static void rcar_du_plane_atomic_destroy_state(struct drm_plane *plane,
 {
 	__drm_atomic_helper_plane_destroy_state(state);
 	kfree(to_rcar_plane_state(state));
 }
 
-static void rcar_du_plane_reset(struct drm_plane *plane)
+static struct drm_plane_state *rcar_du_plane_create_state(struct drm_plane *plane)
 {
 	struct rcar_du_plane_state *state;
 
-	if (plane->state) {
-		rcar_du_plane_atomic_destroy_state(plane, plane->state);
-		plane->state = NULL;
-	}
-
 	state = kzalloc_obj(*state);
 	if (state == NULL)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_plane_reset(plane, &state->state);
+	__drm_atomic_helper_plane_state_init(&state->state, plane);
 
 	state->hwindex = -1;
 	state->source = RCAR_DU_PLANE_MEMORY;
 	state->colorkey = RCAR_DU_COLORKEY_NONE;
+
+	return &state->state;
 }
 
 static int rcar_du_plane_atomic_set_property(struct drm_plane *plane,
 					     struct drm_plane_state *state,
 					     struct drm_property *property,
@@ -765,11 +762,11 @@ static int rcar_du_plane_atomic_get_property(struct drm_plane *plane,
 }
 
 static const struct drm_plane_funcs rcar_du_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.reset = rcar_du_plane_reset,
+	.atomic_create_state = rcar_du_plane_create_state,
 	.destroy = drm_plane_cleanup,
 	.atomic_duplicate_state = rcar_du_plane_atomic_duplicate_state,
 	.atomic_destroy_state = rcar_du_plane_atomic_destroy_state,
 	.atomic_set_property = rcar_du_plane_atomic_set_property,
 	.atomic_get_property = rcar_du_plane_atomic_get_property,
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
index ae9f381b03c8..4293e792afdb 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
@@ -419,30 +419,27 @@ static void rcar_du_vsp_plane_atomic_destroy_state(struct drm_plane *plane,
 {
 	__drm_atomic_helper_plane_destroy_state(state);
 	kfree(to_rcar_vsp_plane_state(state));
 }
 
-static void rcar_du_vsp_plane_reset(struct drm_plane *plane)
+static struct drm_plane_state *rcar_du_vsp_plane_create_state(struct drm_plane *plane)
 {
 	struct rcar_du_vsp_plane_state *state;
 
-	if (plane->state) {
-		rcar_du_vsp_plane_atomic_destroy_state(plane, plane->state);
-		plane->state = NULL;
-	}
-
 	state = kzalloc_obj(*state);
 	if (state == NULL)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_plane_reset(plane, &state->state);
+	__drm_atomic_helper_plane_state_init(&state->state, plane);
+
+	return &state->state;
 }
 
 static const struct drm_plane_funcs rcar_du_vsp_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.reset = rcar_du_vsp_plane_reset,
+	.atomic_create_state = rcar_du_vsp_plane_create_state,
 	.destroy = drm_plane_cleanup,
 	.atomic_duplicate_state = rcar_du_vsp_plane_atomic_duplicate_state,
 	.atomic_destroy_state = rcar_du_vsp_plane_atomic_destroy_state,
 };
 

-- 
2.55.0

