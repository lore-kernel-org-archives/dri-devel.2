Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F1EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8604510E6EA;
	Thu,  9 Jul 2026 11:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dwa2otTX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC7310F529
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:51:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C88FF439E5;
 Thu,  9 Jul 2026 11:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3636F1F00A3A;
 Thu,  9 Jul 2026 11:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597881;
 bh=NV9c+UmmXzzczh4rxrfdiEx/3vzr0Vudq09SWEHN0Gg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dwa2otTXuFNCSYFfaTVtF3izVzLw3NMXbt96FYffHDWljxJaZN2THhMcyBdffSPml
 5G6gKaKuFZBewJqaxohZ4a3BDD0qT4V/7R3NtaJKzzlyh0FTFK69uIKXHDR0yBhh7L
 D7LHzHYUpMZDJNe48Lnd/LC+evLWxuNZlJj1mZTmps+GqnqIVAO4L+puqw6tg1exAz
 M8RISxnxJoDzQS4i8i5HnS408HikLgOqYacRbP1GcDQcEhtidkNjUEn8Im+OElc+NG
 ettOlfVNkP06vzbbYJE9xz5kghJ4vlmEOTIUhHAnFl3AgTb7NGAkIw88SIR3Sh+Hvs
 rHs7kdrmGRWCw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 09 Jul 2026 13:50:34 +0200
Subject: [PATCH 08/60] drm/ssd130x: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-drm-no-more-plane-reset-v1-8-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 javierm@redhat.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6840; i=mripard@kernel.org;
 h=from:subject:message-id; bh=LqIg96UZLRVZe3dudpwsdRsZlnFfKediNDpHaxAj4S8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn+3TyrlWuemyxPDGC3l2eNm+D8/5dWs4qHvv2Vl7Ixv
 lfWxb/vmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABPZM5mx4Wx0jpRgr+RkJ9bF
 07hmzlxnX+Vyv8dMb3HKuy4H5mKrM0+3rI8U/xTe7cGYLSYjOvUTY8O/a+5ntbI5+v9mi7Y+6jh
 leXHC8k8xl3rMXoZ3VBbezfjBdCnqj7Hc+uhbPhd3Vl1P3wkA
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
Cc: javierm@redhat.com
---
 drivers/gpu/drm/solomon/ssd130x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 4907be694aec..08f78035ba67 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1276,21 +1276,21 @@ static void ssd133x_primary_plane_atomic_disable(struct drm_plane *plane,
 
 	drm_dev_exit(idx);
 }
 
 /* Called during init to allocate the plane's atomic state. */
-static void ssd130x_primary_plane_reset(struct drm_plane *plane)
+static struct drm_plane_state *ssd130x_primary_plane_create_state(struct drm_plane *plane)
 {
 	struct ssd130x_plane_state *ssd130x_state;
 
-	drm_WARN_ON_ONCE(plane->dev, plane->state);
-
 	ssd130x_state = kzalloc_obj(*ssd130x_state);
 	if (!ssd130x_state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	__drm_gem_reset_shadow_plane(plane, &ssd130x_state->base);
+	__drm_gem_shadow_plane_state_init(plane, &ssd130x_state->base);
+
+	return &(&ssd130x_state->base)->base;
 }
 
 static struct drm_plane_state *ssd130x_primary_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct drm_shadow_plane_state *new_shadow_plane_state;
@@ -1349,11 +1349,11 @@ static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs[]
 };
 
 static const struct drm_plane_funcs ssd130x_primary_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.reset = ssd130x_primary_plane_reset,
+	.atomic_create_state = ssd130x_primary_plane_create_state,
 	.atomic_duplicate_state = ssd130x_primary_plane_duplicate_state,
 	.atomic_destroy_state = ssd130x_primary_plane_destroy_state,
 	.destroy = drm_plane_cleanup,
 };
 

-- 
2.54.0

