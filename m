Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573A2C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7AC910F806;
	Fri,  3 Jul 2026 13:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mefv0Xbx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCF410F806
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 13:26:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA4D3600B0;
 Fri,  3 Jul 2026 13:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3801F000E9;
 Fri,  3 Jul 2026 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783085201;
 bh=I5iJR0ZAulXIwXQuJjzS0xJ98CzV5b7tdj3MXn3AYtQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mefv0XbxVuEJHdijKv7y+rcomWqyNozmWC9XLduwTd8Ca1Whp33X7shF2pF0iUGOM
 YZgYZcuCJ2NGCx8jKuZqtUN+05E9ldIlJ62a3i3Kc6Swm2+2dj+w8MVsa8xTM0v8cD
 fOldZNTaylqLCXSbpqa8MLk3PXItzLcVymBBPa1aZK6svSzeedxSHpXlTKeenY2Aea
 TnHRAOs+bcuvAKIgh2aRaJOhhew6G9yeqMwGwYZNxO9+BdE19r+giip0IXaw48FSku
 6/jBnGcDUxAYBkldrtS5M1FDtOBR/yMiFCJbsAyil6CSPi5LNVnXVELyhlCgw50BoX
 AwMZYN77VICgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] drm/amdgpu: Fix init ordering in
 amdgpu_vram_mgr_init()
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: hannes@cmpxchg.org, dri-devel@lists.freedesktop.org, tj@kernel.org,
 mkoutny@suse.com
In-Reply-To: <20260703130541.2686-2-thomas.hellstrom@linux.intel.com>
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
 <20260703130541.2686-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 13:26:40 +0000
Message-Id: <20260703132641.2F3801F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch resolves a panic when `drmm_cgroup_register_region()` fa=
ils, but leaves an identical teardown vulnerability if `gpu_buddy_init()` f=
ails.
--

commit 3650035d068659ae5cf730d3debae46e3ebe9589
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()

This commit fixes a kernel panic on the module load error path by moving
drmm_cgroup_register_region() after the list and buddy allocator are fully
initialized. This prevents the teardown path from dereferencing uninitializ=
ed
pointers if the cgroup registration fails.

Closes: https://sashiko.dev/#/patchset/20260428073116.15687-1-thomas.hellst=
rom@linux.intel.com?part=3D4

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c

[ ... ]

> @@ -935,6 +932,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  	err =3D gpu_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
>  	if (err)
>  		return err;

[Severity: High]
This isn't a bug introduced by this patch, but while fixing the teardown
vulnerability for the cgroup registration, does this leave an identical
teardown vulnerability if gpu_buddy_init() fails?

If gpu_buddy_init() fails, it frees the memory but leaves dangling pointers
and a non-zero mm->n_roots:

drivers/gpu/buddy.c:gpu_buddy_init() {
    ...
out_free_roots:
    while (root_count--)
        gpu_block_free(mm, mm->roots[root_count]);
    kfree(mm->roots);
out_free_tree:
    while (i--)
        kfree(mm->free_trees[i]);
    kfree(mm->free_trees);
    return -ENOMEM;
}

Since adev->mman.initialized is already set to true by the caller
(amdgpu_ttm_init()), returning this error triggers the driver's teardown pa=
th
which unconditionally calls gpu_buddy_fini():

drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:amdgpu_vram_mgr_fini() {
    ...
    if (!adev->gmc.is_app_apu)
        gpu_buddy_fini(&mgr->mm);
    ...
}

This would lead to a use-after-free, NULL pointer dereference, and
double-free when gpu_buddy_fini() iterates up to the non-zero mm->n_roots:

drivers/gpu/buddy.c:gpu_buddy_fini() {
    ...
    for (i =3D 0; i < mm->n_roots; ++i) {
        order =3D ilog2(size) - ilog2(mm->chunk_size);
        start =3D gpu_buddy_block_offset(mm->roots[i]);
    ...
}

Should gpu_buddy_init() clear mm->n_roots and zero the pointers on error,
or should amdgpu_vram_mgr_init() clear its state upon this failure?

> +	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev=
->gmc.real_vram_size);
> +	if (IS_ERR(man->cg))
> +		return PTR_ERR(man->cg);
> +
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>  	ttm_resource_manager_set_used(man, true);
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703130541.2686=
-1-thomas.hellstrom@linux.intel.com?part=3D1
