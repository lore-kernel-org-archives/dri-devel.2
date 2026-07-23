Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D6CC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7925110F081;
	Thu, 23 Jul 2026 10:23:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gKAR7E6z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53E610F082
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:23:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99EB641684;
 Thu, 23 Jul 2026 10:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA281F00A3A;
 Thu, 23 Jul 2026 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784802200;
 bh=8ZofaLmGhAtpx+zF7ZEVXU/TMIAfxauZc2UGBTcmN8w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gKAR7E6zfuyXFrVvhuq1coR9CEjNYfC9kO/L0yER6ahRzikeG8gXq46mddWRU/8Dx
 nnHu8d2Sz4TWWnL1FqV920lw/0spdGUkLlLZrfcrurNM3srnOiJiYz53H+3D6+AwPS
 3C3pZIEvuvXMA1ezfKwNcZFRwAo27HehwG9ssl7eV9pd+Gm99W1iEdHaK/zD6KGqOU
 2LCyKh+AogXT5krsbl9+6QyzaoJibr7lN3R8OdlFlqN1FLiAddbboXi/PUs1Fkviru
 SLD2UpzcWxPtgjMQLAkWBq0Xw9teTVAo6cu26kn2bNH2PL0hfP/k5bfeKb0VBZ/WLh
 WigGXnBz4HvrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/6] drm/amdgpu: Fix init ordering in
 amdgpu_vram_mgr_init()
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: mkoutny@suse.com, hannes@cmpxchg.org, tj@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260723100350.16895-2-thomas.hellstrom@linux.intel.com>
References: <20260723100350.16895-1-thomas.hellstrom@linux.intel.com>
 <20260723100350.16895-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:23:19 +0000
Message-Id: <20260723102320.2AA281F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix: Teardown path still crashes on VRAM init failure (=
Null Pointer Dereference)
- [High] Use-After-Free due to skipped `ttm_device_fini` on `amdgpu_ttm_poo=
ls_init` failure
--

--- Patch [1]: [PATCH v8 1/6] drm/amdgpu: Fix init ordering in amdgpu_vram_=
mgr_init() ---
commit b8b31530c66aa0b0a491f59f8e3765cadbed921e
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()

The commit moves drmm_cgroup_register_region() after the initialization of
the resource manager and buddy allocator in amdgpu_vram_mgr_init(). This
prevents NULL pointer dereferences in amdgpu_vram_mgr_fini() when teardown
is triggered following an initialization failure.

Closes: https://sashiko.dev/#/patchset/20260428073116.15687-1-thomas.hellst=
rom@linux.intel.com?part=3D4

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 2a241a5b12c42..ac3f71d77140a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
[ ... ]
> @@ -935,6 +932,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  	if (err)
>  		return err;
> =20
> +	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev=
->gmc.real_vram_size);
> +	if (IS_ERR(man->cg))
> +		return PTR_ERR(man->cg);

[Severity: High]
This isn't a bug introduced by this patch, but it looks like the teardown
path will still crash if drmm_cgroup_register_region() or gpu_buddy_init()
fails.

Because adev->mman.initialized is set to true before amdgpu_vram_mgr_init()
is called, an error here propagates up and triggers amdgpu_ttm_fini() during
device teardown.

amdgpu_ttm_fini() unconditionally calls teardown for managers that were nev=
er
initialized:

drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:amdgpu_ttm_fini() {
    ...
    amdgpu_gtt_mgr_fini(adev);
    amdgpu_preempt_mgr_fini(adev);
    ...
}

Because these managers were never initialized, man->lru is zeroed out. When
ttm_resource_manager_evict_all() calls ttm_bo_evict_first(), it leads to
ttm_resource_manager_first() executing:

drivers/gpu/drm/ttm/ttm_resource.c:ttm_resource_manager_first() {
    ...
    list_move(&cursor->hitch.link, &man->lru[cursor->priority]);
    ...
}

Since man->lru[0] is zero-initialized, man->lru[0].next is NULL, which caus=
es
list_move() to dereference NULL and crash the kernel.

Furthermore, if gpu_buddy_init() itself fails, it leaves mm->n_roots set to=
 a
non-zero value but frees or zeroes mm->roots:

drivers/gpu/buddy.c:gpu_buddy_init() {
    ...
    mm->n_roots =3D hweight64(size);
    mm->roots =3D kmalloc_array(mm->n_roots, ...);
    if (!mm->roots)
        goto out_free_tree;
    ...
}

When amdgpu_vram_mgr_fini() then calls gpu_buddy_fini(), will it dereference
the dangling or NULL mm->roots array?

Could amdgpu_ttm_fini() be updated with additional guards to prevent cleani=
ng
up uninitialized managers?

[Severity: High]
This is a pre-existing issue, but I noticed another problem in the
amdgpu_ttm_init() failure path that might be worth addressing.

If amdgpu_ttm_pools_init() fails early in amdgpu_ttm_init(), it returns
immediately:

drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:amdgpu_ttm_init() {
    ...
    r =3D amdgpu_ttm_pools_init(adev);
    if (r) {
        ...
        return r;
    }
    adev->mman.initialized =3D true;
    ...
}

This means adev->mman.initialized remains false. However, ttm_device_init()
was already called and successfully linked the device into the global list:

drivers/gpu/drm/ttm/ttm_device.c:ttm_device_init() {
    ...
    list_add_tail(&bdev->device_list, &glob->device_list);
    ...
}

When amdgpu_ttm_fini() runs during teardown, it skips ttm_device_fini()
because initialized is false:

drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:amdgpu_ttm_fini() {
    ...
    if (!adev->mman.initialized)
        return;
    ...
    ttm_device_fini(&adev->mman.bdev);
    ...
}

This leaves a dangling list entry in ttm_glob.device_list. When
ttm_global_swapout() is later triggered by memory pressure, will it traverse
the list and dereference the freed amdgpu_device memory, causing a
use-after-free?

> +
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>  	ttm_resource_manager_set_used(man, true);
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723100350.1689=
5-1-thomas.hellstrom@linux.intel.com?part=3D1
