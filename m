Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6921DC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 03:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A481610E2B6;
	Mon,  6 Jul 2026 03:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VXq/2fk/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A692D10E2B6
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 03:18:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C9DC4139C;
 Mon,  6 Jul 2026 03:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF491F000E9;
 Mon,  6 Jul 2026 03:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783307912;
 bh=FarSbiZ5xotTU7fPxdwXfG9oQ33D23q0KqJwP5kDxvY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VXq/2fk/ZXll1lbViAWDocPouU3xT+MYq2qjtoj5gNydK/0m2jVW2BudqasYw53fD
 ohP16yk1v4cHvCP2tcDF7MK7C8nQ6wZT7HcfDWV3fnYSlBnCCLwqW3DehGc9AqziWs
 NZ1Oe+H1U/SkAwljnpBkP9aL8bsA8ZCbqeHR4jcCxEpl0BENyRJfSJyEs4K3M/ekbR
 p/YFoOEf1GE0mdYNZG0HqbIQs+Z4Dieygbq3e/r1PNOHIHuln+kYe+8p/yCXFnO2bs
 gU/ACYoI59FgfPin0F0wAneA9+EXhdpzBs4DzlwOkn0apaSpEc86Es8yS4Be0muL96
 eK+cgYlzITPXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] xe: create a flag to enable memcg accounting for
 XE as well.
To: "Dave Airlie" <airlied@gmail.com>
Cc: tj@kernel.org, mkoutny@suse.com, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org
In-Reply-To: <20260706024122.853329-11-airlied@gmail.com>
References: <20260706024122.853329-1-airlied@gmail.com>
 <20260706024122.853329-11-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 03:18:31 +0000
Message-Id: <20260706031832.2CF491F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing memcg accounting for userspace dumb buffers created via xe=
_bo_dumb_create.
- [High] Page tables created asynchronously via workqueues are charged to t=
he kworker's root memcg instead of the user's memcg.
- [High] BOs created with deferred backing bypass memcg accounting upon CPU=
 page fault.
--

commit ebf9090c8281d875d2f980bb34d324c88a8b277f
Author: Maarten Lankhorst <dev@lankhorst.se>

xe: create a flag to enable memcg accounting for XE as well.

This adds support for memcg accounting to ttm object used by xe driver.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -56,6 +56,7 @@ static const struct ttm_place sys_placement_flags =3D {
>  	.flags =3D 0,
>  };
> =20
> +/* TTM_PL_FLAG_MEMCG is not set, those placements are used for eviction =
*/
>  static struct ttm_placement sys_placement =3D {

[Severity: High]
If userspace creates a buffer object with the deferred backing flag, mmaps
it, and accesses it via the CPU before the GPU validates it,
xe_bo_init_locked() assigns sys_placement as the initial placement.=20
Since sys_placement lacks TTM_PL_FLAG_MEMCG, will a CPU page fault
(which calls xe_bo_fault_migrate() and ttm_bo_populate()) allocate memory
without charging the memcg? Does this allow userspace to bypass memcg
limits for deferred backing buffers?

>  	.num_placement =3D 1,
>  	.placement =3D &sys_placement_flags,
>  };

[ ... ]

> @@ -2384,6 +2385,9 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *x=
e, struct xe_bo *bo,
>  	placement =3D (type =3D=3D ttm_bo_type_sg ||
>  		     bo->flags & XE_BO_FLAG_DEFER_BACKING) ? &sys_placement :
>  		&bo->placement;
> +
> +	if (bo->flags & XE_BO_FLAG_ACCOUNTED)
> +		ttm_bo_set_cgroup(&bo->ttm, get_obj_cgroup_from_current());

[Severity: High]
When page tables are created asynchronously, such as from GPU page fault
handlers or rebinding operations executing in workqueues via
xe_pt_create(), get_obj_cgroup_from_current() will resolve to the
kworker's context. Does this cause these allocations to be incorrectly
charged to the root memcg instead of the user's memcg?

>  	err =3D ttm_bo_init_reserved(&xe->ttm, &bo->ttm, type,
>  				   placement, alignment,

[ ... ]

> @@ -3361,7 +3365,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, voi=
d *data,
>  	if (XE_IOCTL_DBG(xe, args->size & ~PAGE_MASK))
>  		return -EINVAL;
> =20
> -	bo_flags =3D 0;
> +	bo_flags =3D XE_BO_FLAG_ACCOUNTED;
>  	if (args->flags & DRM_XE_GEM_CREATE_FLAG_DEFER_BACKING)
>  		bo_flags |=3D XE_BO_FLAG_DEFER_BACKING;

[Severity: High]
This correctly adds the accounting flag for standard GEM object creation, b=
ut
are dumb buffers created via xe_bo_dumb_create() missing this flag?

Dumb buffers are also allocated on behalf of userspace via
DRM_IOCTL_MODE_CREATE_DUMB:

xe_bo_dumb_create() {
    ...
    bo =3D xe_bo_create_user(xe, NULL, args->size,
                           DRM_XE_GEM_CPU_CACHING_WC,
                           XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(=
xe)) |
                           XE_BO_FLAG_FORCE_WC |
                           XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
}

Do these also need XE_BO_FLAG_ACCOUNTED to prevent a malicious or buggy
userspace application from bypassing memcg limits to exhaust host memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706024122.8533=
29-1-airlied@gmail.com?part=3D10
