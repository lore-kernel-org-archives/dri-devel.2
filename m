Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315B6C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FEE910F08C;
	Thu, 23 Jul 2026 10:50:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B5EfCG0z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A84DD10F08C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:50:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEAA6600AD;
 Thu, 23 Jul 2026 10:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441ED1F000E9;
 Thu, 23 Jul 2026 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784803813;
 bh=an3fyo+Jgpa6lgSwnYVCBRIBeqMUqUq8W47KlbqG11w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B5EfCG0z9oeEJqvg1m+9hyCRRPoNu7U/+stP24MbgVnAe4U8YuRhQ3WpErkQK819v
 LkjFzE0TlemCvxVI0FdCF7jGIF1p2TIYNqFwVd4QSvYTx2Y8U5NPt4H+fEc4Xo6YNC
 u/lheFolpTEgTGK+KiRcm2zjYjcMqHOWFlJ+oYpyOu0mz4WJxnLYesksLECbj/zsZI
 yLFLFix8N33hvm+iFMTE3hdtvjhrjsut1sHcEohqIbP9ao05upEeIXKdq9nUfHz0Bc
 Oy4/qyf0FE7apRnZNMuLrshMIqIzStGsRXZa+kN5GY3KT/jsjMtQAX7rP1mv4JXzib
 Wi+QHIfYfcqhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/6] drm/amdgpu: Wire up dmem cgroup reclaim for VRAM
 manager
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, dri-devel@lists.freedesktop.org,
 mkoutny@suse.com
In-Reply-To: <20260723100350.16895-7-thomas.hellstrom@linux.intel.com>
References: <20260723100350.16895-1-thomas.hellstrom@linux.intel.com>
 <20260723100350.16895-7-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:50:12 +0000
Message-Id: <20260723105013.441ED1F000E9@smtp.kernel.org>
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
- [High] Memory Leak and Use-After-Free of cgroup region and gpu_buddy on p=
robe failure
- [High] Permanent memory charge leak on VRAM eviction failure
- [Medium] Commit Message and Implementation Mismatch regarding cgroup regi=
on registration
--

--- Patch [6]: [PATCH v8 6/6] drm/amdgpu: Wire up dmem cgroup reclaim for V=
RAM manager ---
commit 9102e928a842cf958ce390fd437331e21fe61836
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

Register the VRAM manager with the dmem cgroup reclaim infrastructure
so that lowering dmem.max below current VRAM usage triggers TTM
eviction rather than failing with -EBUSY.

> Use drmm_cgroup_register_region() so that the region is automatically
> unregistered at DRM device release, after drm_dev_unplug() has already
> made drm_dev_enter() return false.

[Severity: Medium]
Is this description still accurate? The commit message claims that
drmm_cgroup_register_region() is used to automatically tie the cgroup
region's lifecycle to the DRM device release, but the code implements
manual registration using dmem_cgroup_register_region().

The v8 changelog at the bottom accurately describes why this manual approach
was chosen, but the main body of the commit message appears to still have
the older description.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c

[ ... ]

> @@ -917,6 +939,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_vram_mgr *mgr =3D &adev->mman.vram_mgr;
>  	struct ttm_resource_manager *man =3D &mgr->manager;
> +	struct dmem_cgroup_region *cg;
>  	int err;
> =20
>  	ttm_resource_manager_init(man, &adev->mman.bdev,
> @@ -933,12 +956,17 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  	if (err)
>  		return err;
> =20
> -	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram",
> -					      &(struct dmem_cgroup_init){
> +	cg =3D dmem_cgroup_register_region(&(struct dmem_cgroup_init){
>  						.size =3D adev->gmc.real_vram_size,
> -					      });
> -	if (IS_ERR(man->cg))
> -		return PTR_ERR(man->cg);
> +						.ops =3D &amdgpu_vram_mgr_dmem_ops,
> +						.reclaim_priv =3D man,
> +					 },
> +					 "drm/%s/vram", adev_to_drm(adev)->unique);
> +	if (IS_ERR(cg))
> +		return PTR_ERR(cg);

[Severity: High]
Does this early return leak the gpu_buddy allocator? It looks like
gpu_buddy_init() succeeds just before this, but gpu_buddy_fini() is not
called if dmem_cgroup_register_region() fails.

Also, if amdgpu_vram_mgr_init() succeeds but a subsequent step in the GMC
block's sw_init fails:

amdgpu_device_ip_init() {
    r =3D adev->ip_blocks[i].version->funcs->sw_init(&adev->ip_blocks[i]);
    if (r) {
        goto init_failed;
    }
    adev->ip_blocks[i].status.sw =3D true;
}

The status.sw flag is not set, causing amdgpu_device_ip_fini() to skip
sw_fini and bypass all cleanup. This would permanently leak the gpu_buddy
structures and the registered cgroup region.

Because the cgroup region remains active and its reclaim_priv points to the
manager inside the freed amdgpu_device structure, could a subsequent cgroup
memory pressure event trigger a use-after-free on the dangling pointer?

> +
> +	mgr->cg_region =3D cg;
> +	ttm_resource_manager_set_dmem_region(man, cg);
> =20
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>  	ttm_resource_manager_set_used(man, true);

[ ... ]

> @@ -963,6 +991,19 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>  	ttm_resource_manager_set_used(man, false);
> =20
>  	ret =3D ttm_resource_manager_evict_all(&adev->mman.bdev, man);
> +
> +	/*
> +	 * Unregister the dmem cgroup region regardless of the evict_all()
> +	 * result and before any further teardown.  This drains in-flight
> +	 * reclaim callbacks and blocks new ones, so no reclaim can reference
> +	 * the manager once we start freeing it.  It must run after evict_all()
> +	 * so that ttm_resource_free() can still uncharge via man->cg during
> +	 * eviction.  Clear man->cg afterwards.
> +	 */
> +	dmem_cgroup_unregister_region(mgr->cg_region);
> +	mgr->cg_region =3D NULL;
> +	ttm_resource_manager_set_dmem_region(man, NULL);
> +
>  	if (ret)
>  		return;

[Severity: High]
Does this cause a permanent memory charge leak if eviction fails?

The unregistration happens and man->cg is cleared before returning early
on eviction failure. If eviction fails, buffer objects are left alive in
VRAM.

When these buffer objects are eventually freed, ttm_resource_free() relies
on man->cg being non-NULL to know whether it should call
dmem_cgroup_uncharge():

ttm_resource_free() {
    if (man->cg)
        dmem_cgroup_uncharge(pool, bo->base.size);
}

Since man->cg was already cleared, the uncharge is skipped, which appears
to leak the cgroup charge and its css reference permanently.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723100350.1689=
5-1-thomas.hellstrom@linux.intel.com?part=3D6
