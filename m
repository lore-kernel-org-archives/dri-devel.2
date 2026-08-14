Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836A5C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE4410F651;
	Fri, 14 Aug 2026 14:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aMONCvjw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1689410F645;
 Fri, 14 Aug 2026 14:59:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 901BF60254;
 Fri, 14 Aug 2026 14:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C183B1F00A3A;
 Fri, 14 Aug 2026 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786719554;
 bh=2qvaCgXg/1ESFTjykFHs8AqcS7bHPQFr+TF3lg7jZtM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=aMONCvjwZJlZC0OL0pexlUui/8wgzRhieS6TJ3jUzlYcm1TcbOeEb7eWM6iWLH9rO
 Q0TbB/tl+3y6Ddr7XWGfmZV5DfEN/pudpVhvGGbmPoe682R+IllH7FGXPZtm2S1Ng+
 J90Nfjo5oSpOfUa5ZtoTI29YFPwSjwG4/Q0Tdi974c+1keEbptRIOys2UpgE0ituI/
 qdgnd4NGkPOKQe11oXYm/Bqzrbr2n829waiDUMaHMgsDJ7WQSG9jhi7kWlK69KeTxc
 eC4/uvOUX7MuJwhgD8+8yQ2B18ZQUVi6ShFQUoixJamcFE5uC0GpnWXJjRhL85FpOq
 qZrobujtcW0Bg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 14 Aug 2026 16:57:29 +0200
Subject: [PATCH v2 40/61] drm/amdgpu_dm: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-drm-no-more-plane-reset-v2-40-82d2963dd134@kernel.org>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, harry.wentland@amd.com, siqueira@igalia.com, 
 sunpeng.li@amd.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8225; i=mripard@kernel.org;
 h=from:subject:message-id; bh=YeZ8j9dHLQaWjbJNXuKDoClX3tRjYgwTRQvDsVIxYcU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1Otd6H1mk7fywcuP2RTG/3r7/lfvphFWPdYpG5PwpV
 efjvzKKdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJLL3B2PDi7y371cX9emdW
 NaxoCeg/21Uj7OHWxKfh2J0edFzi55KKzfqdjx/f0V7PmmitE3+ijbHeyfVaYGNP35OlK+T2yie
 0Nn4L3ytt+3WW/v+YB/ODb2Q/LYi/Ovvi9vV29blnrmz+8qASAA==
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
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 26 +++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 1b564cfe2120..ebd8bb90a345 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1513,26 +1513,25 @@ static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
 	.atomic_async_update = amdgpu_dm_plane_atomic_async_update,
 	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
 	.panic_flush = amdgpu_dm_plane_panic_flush,
 };
 
-static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
+static struct drm_plane_state *amdgpu_dm_plane_drm_plane_create_state(struct drm_plane *plane)
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
 
 static struct drm_plane_state *amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct dm_plane_state *dm_plane_state, *old_dm_plane_state;
@@ -1881,11 +1880,11 @@ dm_plane_init_colorops(struct drm_plane *plane)
 
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
@@ -1991,13 +1990,20 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
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

-- 
2.55.0

