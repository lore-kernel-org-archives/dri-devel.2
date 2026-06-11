Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D526ACD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E6A10EF82;
	Thu, 11 Jun 2026 14:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="krQhDF56";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 128A710EF7F
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 14:35:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3FFD436C5;
 Thu, 11 Jun 2026 14:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB471F00893;
 Thu, 11 Jun 2026 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781188527;
 bh=hbX3wU/cZBNonlh8L9nLp+jaYgxOUrV+gqiEyxADzBs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=krQhDF56fZ1LXpZpK6y4MI8SnIXL56D/K7hbCinVo0S72PBpYBH63IHa5RLzdEJjx
 /XxdXp8NdV8/zvGAE67UB0e0VuRzwhJglnyoX0c5X4OQxhAmDsYl6IqYD2ORwJKH0G
 HC3+cD2hf+Uiz/PKF+4aEyhPXMZSAifYIFBnETZzkE1JhatIaLTYcnVyiFg4qxMWtf
 ZiX7S8q5xxnQW20+pue2ImH2QHLAzOMPNRmtaD39IfPfsEul9ZRORabHFhxkKfcSd9
 yYLfLauRGqUe3WuOODI5kVA+dNVNrNPO9hn13M0Nw68G1dHziqp2sXbG0NsL33dHtb
 Mv2it2+iB4R1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] drm/amdgpu: Wire up dmem cgroup reclaim for VRAM
 manager
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, mkoutny@suse.com, hannes@cmpxchg.org,
 tj@kernel.org
In-Reply-To: <20260611142242.2529-7-thomas.hellstrom@linux.intel.com>
References: <20260611142242.2529-7-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 14:35:26 +0000
Message-Id: <20260611143527.6EB471F00893@smtp.kernel.org>
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
- [Critical] The newly registered dmem cgroup region is never assigned to `=
mgr->cg_region`, causing a memory leak and leaving dangling reclaim callbac=
ks that lead to a Use-After-Free.
- [High] Calling `dmem_cgroup_unregister_region()` before `ttm_resource_man=
ager_set_used(man, false)` creates a race window where concurrent allocatio=
ns can dereference a freed cgroup region.
--

commit 02aedad5c82131466a2fb9b6bba851f053487de8
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

Register the VRAM manager with the dmem cgroup reclaim infrastructure
so that lowering dmem.max below current VRAM usage triggers TTM
eviction rather than failing with -EBUSY.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 08f05c3aed1d5..ee98b963e84a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -933,12 +938,15 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
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
> +	if (IS_ERR(cg))
> +		return PTR_ERR(cg);
> +
> +	ttm_resource_manager_set_dmem_region(man, cg);

[Severity: Critical]
Is cg missing an assignment to mgr->cg_region here?

Because mgr->cg_region is zero-initialized and never updated,
amdgpu_vram_mgr_fini() will later pass NULL to dmem_cgroup_unregister_regio=
n().
This causes the cgroup region to leak and remain on the global list.

If cgroup reclaim is triggered after the driver unbinds and the man pointer
is freed, will the callback execute and dereference reclaim_priv, resulting
in a use-after-free?

>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>  	ttm_resource_manager_set_used(man, true);

[ ... ]

> @@ -960,6 +968,15 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>  	int ret;
>  	struct amdgpu_vram_reservation *rsv, *temp;
> =20
> +	/*
> +	 * Drain any in-flight dmem cgroup reclaim callbacks and remove the
> +	 * region from the global list before tearing down the manager.
> +	 * This must happen first so no reclaim callback can access the
> +	 * manager after this point.
> +	 */
> +	dmem_cgroup_unregister_region(mgr->cg_region);
> +	mgr->cg_region =3D NULL;
> +
>  	ttm_resource_manager_set_used(man, false);

[Severity: High]
Does unregistering the cgroup region before calling
ttm_resource_manager_set_used(man, false) create a race condition with
concurrent BO allocations?

Assuming mgr->cg_region was properly set, dmem_cgroup_unregister_region()
will remove the region from global lists and drop its references. Meanwhile,
the manager remains active (man->use_type =3D=3D true).

Because amdgpu_vram_mgr_fini() runs during driver unbind where concurrent
ioctls may still be executing, could a concurrent BO allocation pass the ch=
eck
in ttm_bo_mem_space() and call dmem_cgroup_try_charge(man->cg, ...)?

This would access the unregistered region and cause a use-after-free. Should
ttm_resource_manager_set_used(man, false) be executed before unregistering
the region?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611142242.2529=
-1-thomas.hellstrom@linux.intel.com?part=3D6
