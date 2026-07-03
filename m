Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8450BC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD79710F805;
	Fri,  3 Jul 2026 13:25:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YTSoJJZV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF5E10F809
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 13:25:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7D6D429EF;
 Fri,  3 Jul 2026 13:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5604A1F000E9;
 Fri,  3 Jul 2026 13:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783085101;
 bh=Q0Cl3f5la33oNmJkld279f8lczGVVcLCcgPebGKjBGg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YTSoJJZVk1RdYY5O405y616WVubMPr9Jx60cSM6m22pjS0UXGae2gMPOijRu7WR/6
 CQotBVMDNq1qLSOCP0OL0Voxoerr3MkzmtVljSaygRTihKGspKDwlGfX5kvSab/Y17
 sk01brIsZyTGzMdY0bqnTcwGS+tOAhCM1wi3Fp+qXhJ2k5SkAzc/WLtouv1RZeOq8M
 YVv5P6kDKBMLv7SFiD7vq82/wXsa3KMA+xppLEDFaQYQDH3M6oUnrCoGM8H9DhnxZp
 HrP+bZS1GEOzurvs8LbBwbffQkepAx7ko5fIhXXat41UB1GqNg7baMFCNT/+qr7nZJ
 UwHIJhp5mnpyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] drm/amdgpu: Wire up dmem cgroup reclaim for VRAM
 manager
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: mkoutny@suse.com, dri-devel@lists.freedesktop.org, tj@kernel.org,
 hannes@cmpxchg.org
In-Reply-To: <20260703130541.2686-7-thomas.hellstrom@linux.intel.com>
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
 <20260703130541.2686-7-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 13:25:00 +0000
Message-Id: <20260703132501.5604A1F000E9@smtp.kernel.org>
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
- [High] Use-After-Free due to concurrent cgroup reclaim during probe error=
 teardown.
- [Medium] Memory leak of VRAM manager buddy allocator on cgroup region reg=
istration failure.
--

commit 7beb8b077a31ff08f80ed7810a3913fd3a463579
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager
   =20
Register the VRAM manager with the dmem cgroup reclaim infrastructure
so that lowering dmem.max below current VRAM usage triggers TTM
eviction rather than failing with -EBUSY.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 08f05c3aed1d5..9b9d738ba7941 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c

[ ... ]

> @@ -906,6 +906,28 @@ static const struct ttm_resource_manager_func amdgpu=
_vram_mgr_func =3D {
>  	.debug	=3D amdgpu_vram_mgr_debug
>  };
> =20
> +static const struct dmem_cgroup_ops amdgpu_vram_mgr_dmem_ops;
> +
> +static int amdgpu_vram_mgr_dmem_reclaim(struct dmem_cgroup_pool_state *p=
ool,
> +					u64 target_bytes, void *priv)
> +{
> +	struct ttm_resource_manager *man =3D priv;
> +	struct amdgpu_device *adev =3D amdgpu_ttm_adev(man->bdev);
> +	int ret, idx;
> +
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return -ENODEV;

[Severity: High]
Does this drm_dev_enter() check adequately protect against teardown during a
probe error?

If a failure occurs during amdgpu_pci_probe() (for instance in
amdgpu_driver_load_kms()), drm_dev_unplug() is never called, so
dev->unplugged remains false. The teardown path then proceeds to
drm_dev_release() which does:

drm_dev_release(dev) {
    if (dev->driver->release)
        dev->driver->release(dev);

    drm_managed_release(dev);
    ...
}

The driver release callback will destroy the VRAM manager and TTM structure=
s.
Only after this does drm_managed_release() unregister the cgroup region. If=
 a
cgroup memory reclaim occurs during this window, drm_dev_enter() will allow
execution to proceed, and ttm_resource_manager_dmem_reclaim() will
dereference the destroyed VRAM manager. Is there a way to prevent reclaim f=
rom
accessing the manager during probe failure teardown?

> +
> +	ret =3D ttm_resource_manager_dmem_reclaim(pool, target_bytes, priv);
> +
> +	drm_dev_exit(idx);
> +	return ret;
> +}

[ ... ]

> @@ -933,12 +956,16 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  	if (err)
>  		return err;
> =20
> -	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram",
> -					      &(struct dmem_cgroup_init){
> +	cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram",
> +					 &(struct dmem_cgroup_init){
>  						.size =3D adev->gmc.real_vram_size,
> -					      });
> -	if (IS_ERR(man->cg))
> -		return PTR_ERR(man->cg);
> +						.ops =3D &amdgpu_vram_mgr_dmem_ops,
> +						.reclaim_priv =3D man,
> +					 });
> +	if (IS_ERR(cg))
> +		return PTR_ERR(cg);

[Severity: Medium]
Does returning here leak the buddy allocator initialized earlier in this
function via gpu_buddy_init()?

If drmm_cgroup_register_region() fails, the error propagates out of
amdgpu_ttm_init(), causing the GMC IP block's sw_init to fail. During driver
teardown, amdgpu_device_ip_fini() skips calling sw_fini for IP blocks where
status.sw is false. Since amdgpu_vram_mgr_fini() is skipped, it seems the
buddy allocator memory allocated by gpu_buddy_init() will never be freed.

Should this error path call gpu_buddy_fini() before returning?

> +
> +	ttm_resource_manager_set_dmem_region(man, cg);
> =20
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>  	ttm_resource_manager_set_used(man, true);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703130541.2686=
-1-thomas.hellstrom@linux.intel.com?part=3D6
