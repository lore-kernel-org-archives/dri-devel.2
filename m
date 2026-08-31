Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91370C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96B410E9D1;
	Mon, 31 Aug 2026 16:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WVIaRQyG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9181D10E9D0;
 Mon, 31 Aug 2026 16:19:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 763D043B86;
 Mon, 31 Aug 2026 16:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C658A1F000E9;
 Mon, 31 Aug 2026 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788193159;
 bh=zd4ANdjXNDith8D757dJVvUVaxz7Ox5RlsUoIEkFS84=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WVIaRQyG9OCCzyHUId4E5rYIS5SH1Qu2idmQ1DaI0Vc93AyzwwzPuIP0fqllv1KDc
 LRQMIJz6hG6tWkUMiz73AF5r/XckegSu8m41mZuxvT+f/opdwSxRMsv+YlNIydTz3c
 yE1r3hDobqmZamo/tEDljeq2FA5FknuHr2JwRIGUuWmDoYnapDYaWB4A1DwPa/USPM
 6qnKcCWcq274Zrn1vpEbcGVdwhYL19DzsQo0IAJK6wsXySX1h+qEs6Gz7o0kQlOYpF
 bRtfncXAQo+YJ13i5lXmImitu6bpKX9k0FG3u+OQZF59hftBznoT2H1JX0Lzc1OWHp
 HWBUOijiA0t5A==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 31 Aug 2026 18:17:41 +0200
Subject: [PATCH v3 25/40] drm/amdgpu_dm: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-drm-no-more-plane-reset-v3-25-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, harry.wentland@amd.com, siqueira@igalia.com, 
 sunpeng.li@amd.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13079; i=mripard@kernel.org;
 h=from:subject:message-id; bh=nSi/pOoXyQ6Id9goJRjNAT3goOSxZCeg/q0PRScaFqY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlTV0o/rFL/t8/v/P5HXe/kmdfL3n9Yft0h323/9mjpp
 rfuydn+HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiLEWMdVa/6ho4o3ZL3jtT
 MH259kMPhddeN8OTz9dL8O3eX/g68vwrgYf30ip7Ixu8Pid+iF4wk7G+VMluCotnR9zUnvBr87Z
 wrPnUdutY5C8BmWvPJ1kfOHV26eHtCcw1JzaFaoYo3MzVX6IFAA==
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
Cc: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Cc: harry.wentland@amd.com
Cc: siqueira@igalia.com
Cc: sunpeng.li@amd.com
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 28 ++++++++++++--------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |  2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c | 30 ++++++++--------------
 3 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 824ef3ce5de0..f9655f534d3b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1786,28 +1786,27 @@ static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
 	.atomic_async_update = amdgpu_dm_plane_atomic_async_update,
 	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
 	.panic_flush = amdgpu_dm_plane_panic_flush,
 };
 
-STATIC_IFN_KUNIT void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
+STATIC_IFN_KUNIT struct drm_plane_state *amdgpu_dm_plane_drm_plane_create_state(struct drm_plane *plane)
 {
 	struct dm_plane_state *amdgpu_state;
 
 	amdgpu_state = kzalloc_obj(*amdgpu_state);
 	if (!amdgpu_state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	if (plane->state)
-		plane->funcs->atomic_destroy_state(plane, plane->state);
-
-	__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
+	__drm_atomic_helper_plane_state_init(&amdgpu_state->base, plane);
 	amdgpu_state->degamma_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
 	amdgpu_state->hdr_mult = AMDGPU_HDR_MULT_DEFAULT;
 	amdgpu_state->shaper_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
 	amdgpu_state->blend_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
+
+	return &amdgpu_state->base;
 }
-EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_reset);
+EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_create_state);
 
 STATIC_IFN_KUNIT struct drm_plane_state *
 amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct dm_plane_state *dm_plane_state, *old_dm_plane_state;
@@ -2166,11 +2165,11 @@ dm_plane_init_colorops(struct drm_plane *plane)
 
 static const struct drm_plane_funcs dm_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
 	.destroy	= drm_plane_helper_destroy,
-	.reset = amdgpu_dm_plane_drm_plane_reset,
+	.atomic_create_state = amdgpu_dm_plane_drm_plane_create_state,
 	.atomic_duplicate_state = amdgpu_dm_plane_drm_plane_duplicate_state,
 	.atomic_destroy_state = amdgpu_dm_plane_drm_plane_destroy_state,
 	.format_mod_supported = amdgpu_dm_plane_format_mod_supported,
 	.format_mod_supported_async = amdgpu_dm_plane_format_mod_supported,
 #ifdef AMD_PRIVATE_COLOR
@@ -2276,13 +2275,20 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	res = dm_plane_init_colorops(plane);
 	if (res)
 		return res;
 #endif
 
-	/* Create (reset) the plane state */
-	if (plane->funcs->reset)
-		plane->funcs->reset(plane);
+	/* Create the plane state */
+	if (plane->funcs->atomic_create_state) {
+		struct drm_plane_state *plane_state;
+
+		plane_state = plane->funcs->atomic_create_state(plane);
+		if (IS_ERR(plane_state))
+			return PTR_ERR(plane_state);
+
+		plane->state = plane_state;
+	}
 
 	return 0;
 }
 
 bool amdgpu_dm_plane_is_video_format(uint32_t format)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 092ade738ce9..6aaea290206d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -115,11 +115,11 @@ void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
 int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
 				       struct drm_atomic_commit *state, bool flip);
 int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 				 struct drm_atomic_commit *state);
 void amdgpu_dm_plane_panic_flush(struct drm_plane *plane);
-void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane);
+struct drm_plane_state *amdgpu_dm_plane_drm_plane_create_state(struct drm_plane *plane);
 struct drm_plane_state *amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane);
 void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
 					     struct drm_plane_state *state);
 void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64_t *size,
 					uint64_t *cap, uint64_t mod);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index ba97092c7bb8..ab425ee14f30 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -2922,40 +2922,32 @@ static void dm_test_panic_flush_no_dc_state(struct kunit *test)
 static const struct drm_plane_funcs dm_test_plane_reset_funcs = {
 	.atomic_destroy_state = amdgpu_dm_plane_drm_plane_destroy_state,
 };
 
 /**
- * dm_test_plane_reset_initializes_state() - Verify reset installs default state.
+ * dm_test_plane_create_state_initializes_state() - Verify create_state allocates default state.
  * @test: KUnit test context.
  *
- * Verify amdgpu_dm_plane_drm_plane_reset() destroys the existing plane state,
- * allocates a fresh dm_plane_state, and initializes the AMD-specific transfer
- * function and HDR multiplier defaults.
+ * Verify amdgpu_dm_plane_drm_plane_create_state() allocates a fresh
+ * dm_plane_state, and initializes the AMD-specific transfer function and HDR
+ * multiplier defaults.
  */
-static void dm_test_plane_reset_initializes_state(struct kunit *test)
+static void dm_test_plane_create_state_initializes_state(struct kunit *test)
 {
-	struct dm_plane_state *old_state;
+	struct drm_plane_state *plane_state;
 	struct dm_plane_state *new_state;
 	struct drm_plane *plane;
 
 	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, plane);
 
-	/*
-	 * Provide an existing state plus a funcs table so reset exercises the
-	 * destroy-existing-state path. The destroy hook frees this state, so it
-	 * must be a plain (non-KUnit-managed) allocation.
-	 */
-	old_state = kzalloc(sizeof(*old_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, old_state);
 	plane->funcs = &dm_test_plane_reset_funcs;
-	plane->state = &old_state->base;
 
-	amdgpu_dm_plane_drm_plane_reset(plane);
+	plane_state = amdgpu_dm_plane_drm_plane_create_state(plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_state);
 
-	KUNIT_ASSERT_NOT_NULL(test, plane->state);
-	new_state = to_dm_plane_state(plane->state);
+	new_state = to_dm_plane_state(plane_state);
 	KUNIT_EXPECT_EQ(test, new_state->degamma_tf, AMDGPU_TRANSFER_FUNCTION_DEFAULT);
 	KUNIT_EXPECT_EQ(test, new_state->hdr_mult, AMDGPU_HDR_MULT_DEFAULT);
 	KUNIT_EXPECT_EQ(test, new_state->shaper_tf, AMDGPU_TRANSFER_FUNCTION_DEFAULT);
 	KUNIT_EXPECT_EQ(test, new_state->blend_tf, AMDGPU_TRANSFER_FUNCTION_DEFAULT);
 
@@ -3096,12 +3088,12 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_atomic_check_helper_failure),
 	KUNIT_CASE(dm_test_atomic_check_color_pipeline_conflict),
 	KUNIT_CASE(dm_test_atomic_check_scaling_failure),
 	/* amdgpu_dm_plane_panic_flush() */
 	KUNIT_CASE(dm_test_panic_flush_no_dc_state),
-	/* amdgpu_dm_plane_drm_plane_reset() */
-	KUNIT_CASE(dm_test_plane_reset_initializes_state),
+	/* amdgpu_dm_plane_drm_plane_create_state() */
+	KUNIT_CASE(dm_test_plane_create_state_initializes_state),
 	/* amdgpu_dm_plane_drm_plane_duplicate_state() */
 	KUNIT_CASE(dm_test_plane_duplicate_state_copies_fields),
 	/* amdgpu_dm_plane_drm_plane_destroy_state() */
 	KUNIT_CASE(dm_test_plane_destroy_state_minimal),
 	/* amdgpu_dm_plane_add_modifier() */

-- 
2.55.0

