Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCFCC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C462010F65E;
	Fri, 14 Aug 2026 14:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YgXnzl9z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0087910F65B;
 Fri, 14 Aug 2026 14:59:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6EBFC60A5B;
 Fri, 14 Aug 2026 14:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF6E1F000E9;
 Fri, 14 Aug 2026 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719578;
 bh=nmvikvZ9DsGgzJdRTDK6gUneIIlYtnVrj1IscZLh0rI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YgXnzl9zZ6qcxKKT7I1TK2pbH4Ht7GUd8YdeG5i5/9wEb6EH5LV9YY4t6HCwxtShN
 WTVU0OMt8gcEYw6ipF0YU7vo9JKGThkWsGDRXUaaqjZKZcbjDCeBnnX/8Y+m4mr5L8
 kxaPC/G9+SYWRKOuIBrEVsLC97Fq7JhcWZ4FtTuF2LP7s4IxG8sP2758MGJ1YX/c5H
 Q1HyDTeSImPEctVIg3bWrpKeN5pOQBi15UaqU02+3M1KpEanj3ogCI39GLvQp/AEJ0
 JafwEuE02yrMpd7VwdKlJvK2EqqDdtHXi+IOR7OU05VyQMXSuAD7JNPcnAkMUdgtYE
 hNASIzsIGsOXw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:57:39 +0200
Subject: [PATCH v2 50/61] drm/msm/mdp5: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-50-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 abhinav.kumar@linux.dev, freedreno@lists.freedesktop.org, 
 jesszhan0024@gmail.com, linux-arm-msm@vger.kernel.org, lumag@kernel.org, 
 marijn.suijten@somainline.org, robin.clark@oss.qualcomm.com, 
 sean@poorly.run
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7187; i=mripard@kernel.org;
 h=from:subject:message-id; bh=sWW/yEfOvBDifTqIbyz+k9/X2yobVWz45WbKX8VOod4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1Ore+xbi1Wbe16Mx5eUr1yBt/9qmNS4rPTjaYtm2RS
 rYU57SrHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiX9cxNmyM1J5iYH769+7e
 RRqX3oT78rWELG5/Ws3ebdCv6O/cvv92RX/GmbTDuXVvlVVe+p+6xFinpqtn+izbl99lvXP1LK1
 VMioiOns2GbXs6vW583v+w4wdX5rWPZjGOFF2GcOzhODiPb0A
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: abhinav.kumar@linux.dev
Cc: freedreno@lists.freedesktop.org
Cc: jesszhan0024@gmail.com
Cc: linux-arm-msm@vger.kernel.org
Cc: lumag@kernel.org
Cc: marijn.suijten@somainline.org
Cc: robin.clark@oss.qualcomm.com
Cc: sean@poorly.run
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index 841f444a8d68..7e878c698247 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -78,23 +78,19 @@ mdp5_plane_atomic_print_state(struct drm_printer *p,
 	drm_printf(p, "\tnormalized_zpos=%u\n", pstate->base.normalized_zpos);
 	drm_printf(p, "\talpha=%u\n", pstate->base.alpha);
 	drm_printf(p, "\tstage=%s\n", stage2name(pstate->stage));
 }
 
-static void mdp5_plane_reset(struct drm_plane *plane)
+static struct drm_plane_state *mdp5_plane_create_state(struct drm_plane *plane)
 {
 	struct mdp5_plane_state *mdp5_state;
-
-	if (plane->state)
-		__drm_atomic_helper_plane_destroy_state(plane->state);
-
-	kfree(to_mdp5_plane_state(plane->state));
-	plane->state = NULL;
 	mdp5_state = kzalloc_obj(*mdp5_state);
 	if (!mdp5_state)
-		return;
-	__drm_atomic_helper_plane_reset(plane, &mdp5_state->base);
+		return ERR_PTR(-ENOMEM);
+	__drm_atomic_helper_plane_state_init(&mdp5_state->base, plane);
+
+	return &mdp5_state->base;
 }
 
 static struct drm_plane_state *
 mdp5_plane_duplicate_state(struct drm_plane *plane)
 {
@@ -124,11 +120,11 @@ static void mdp5_plane_destroy_state(struct drm_plane *plane,
 }
 
 static const struct drm_plane_funcs mdp5_plane_funcs = {
 		.update_plane = drm_atomic_helper_update_plane,
 		.disable_plane = drm_atomic_helper_disable_plane,
-		.reset = mdp5_plane_reset,
+		.atomic_create_state = mdp5_plane_create_state,
 		.atomic_duplicate_state = mdp5_plane_duplicate_state,
 		.atomic_destroy_state = mdp5_plane_destroy_state,
 		.atomic_print_state = mdp5_plane_atomic_print_state,
 };
 

-- 
2.55.0

