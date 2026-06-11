Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F98CCD8C9D
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F8F110F0E5;
	Thu, 11 Jun 2026 18:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CQZxW/7u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0C110F0D3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 18:32:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54EDD404C4;
 Thu, 11 Jun 2026 18:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F065E1F000E9;
 Thu, 11 Jun 2026 18:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781202775;
 bh=wj07LR9OwbvYyeJXyCaTmGJwF1ISfPKiU5ozJFMFyjc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CQZxW/7uwpKAFWHIeN3vVnwE+GYpay1cigDyMah6uclp8F/xRkZDuPc+GpTowpPHj
 fCEXh/fAuOQq/jfqk55jvjdMDZNMKh/KDRyoPG0VDR08bVKLrBHge4MAXFOfZMdDEZ
 EOTGkbVQwFXj5exVXVuU2yINvu/q+kxEzXB8xTXC5v2NRjK6iDeqqR4AgyM2+kVZjk
 NtD5ha5csVfHxeeExfA+ONqSvqXBK/Y/stYCJoYb3iBqzB4oR0j0sqR1XPGrVjzNAD
 woyFDL9mymVAW9k+gEPVYopPITX7+VEDLE0QjxlEIuUbxi1jNLFxZjhiHs008on2bS
 B0NFltVGRgkGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] drm/amdgpu: Wire up dmem cgroup reclaim for VRAM
 manager
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, mkoutny@suse.com,
 hannes@cmpxchg.org
In-Reply-To: <20260611173301.17473-7-thomas.hellstrom@linux.intel.com>
References: <20260611173301.17473-7-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:32:53 +0000
Message-Id: <20260611183254.F065E1F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Early return in `amdgpu_vram_mgr_fini()` on eviction failure s=
kips `dmem_cgroup_unregister_region()`, leading to a use-after-free.
- [Medium] The cgroup region name is hardcoded to 'vram', breaking the devi=
ce-specific namespace prefix and causing collisions on multi-GPU setups.

Pre-existing issues:
- [High] Unconditional cleanup of the buddy allocator causes a UAF/NULL der=
eference if `gpu_buddy_init()` fails during initialization.
--

commit 869c423a8a9487b5c3e7321e4f9a0e14f69318b4
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

Register the VRAM manager with the dmem cgroup reclaim infrastructure
so that lowering dmem.max below current VRAM usage triggers TTM
eviction rather than failing with -EBUSY.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 08f05c3aed1d5..2250bab0970dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
[ ... ]
> @@ -933,12 +938,16 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  	if (err)
>  		return err;
> =20
> -	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram",
> -					      &(struct dmem_cgroup_init){
> -						.size =3D adev->gmc.real_vram_size,
> -					      });
> -	if (IS_ERR(man->cg))
> -		return PTR_ERR(man->cg);
> +	cg =3D dmem_cgroup_register_region(&(struct dmem_cgroup_init){
> +					     .size =3D adev->gmc.real_vram_size,
> +					     .ops =3D &amdgpu_vram_mgr_dmem_ops,
> +					     .reclaim_priv =3D man,
> +					 }, "vram");

[Severity: Medium]
Does this hardcoded "vram" string break the device-specific namespace prefi=
x?

Before this patch, drmm_cgroup_register_region() automatically prefixed the
cgroup region name with the DRM device's unique identifier. On systems with
multiple AMD GPUs, won't using just "vram" here cause all GPUs to register a
region with the exact same name, breaking userspace tools' ability to
distinguish between the GPUs' memory cgroups?

[ ... ]
> @@ -966,6 +975,16 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>  	ret =3D ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>  	if (ret)
>  		return;
> =20
> +	/*
> +	 * Drain any in-flight dmem cgroup reclaim callbacks and remove the
> +	 * region from the global list.  This must happen after evict_all()
> +	 * so that ttm_resource_free() can still uncharge via man->cg while
> +	 * BOs are being evicted.
> +	 */
> +	dmem_cgroup_unregister_region(mgr->cg_region);

[Severity: Critical]
If ttm_resource_manager_evict_all() fails (for example, due to pinned BOs)
and returns an error, the early return above skips the newly added
dmem_cgroup_unregister_region() call.

Could this permanently leak the region and leave a dangling pointer as its
reclaim callback argument? When the DRM device is eventually released and
the amdgpu_device struct is freed, any subsequent memory pressure triggering
dmem cgroup reclaim would dereference the freed man pointer, causing a
kernel use-after-free.

> +	mgr->cg_region =3D NULL;
> +	man->cg =3D NULL;
> +
>  	mutex_lock(&mgr->lock);
>  	list_for_each_entry_safe(rsv, temp, &mgr->reservations_pending, blocks)
>  		kfree(rsv);
[ ... ]
>  	list_for_each_entry_safe(rsv, temp, &mgr->reserved_pages, blocks) {
>  		gpu_buddy_free_list(&mgr->mm, &rsv->allocated, 0);
>  		kfree(rsv);
>  	}
>  	if (!adev->gmc.is_app_apu)
>  		gpu_buddy_fini(&mgr->mm);

[Severity: High]
This isn't a bug introduced by this patch, but does this unconditional
cleanup cause a use-after-free or NULL pointer dereference if
gpu_buddy_init() failed during initialization?

If gpu_buddy_init() fails, it returns an error and frees its internal arrays
without setting them to NULL. The driver error path then calls
amdgpu_device_fini_sw(), which triggers amdgpu_vram_mgr_fini().

Since mm->n_roots was populated before the allocation failure, won't
gpu_buddy_fini() iterate over mm->n_roots and dereference the uninitialized
or NULL mm->roots pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611173301.1747=
3-1-thomas.hellstrom@linux.intel.com?part=3D6
