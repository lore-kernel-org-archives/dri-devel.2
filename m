Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382F5CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967A010EF93;
	Thu, 11 Jun 2026 14:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gbyEDz+i";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E42B010EF93
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 14:37:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 21B8E600AA;
 Thu, 11 Jun 2026 14:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DFA1F00893;
 Thu, 11 Jun 2026 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781188671;
 bh=fqGr3cu2RGJI68UHtKwcJ+hMcsaT9BkGtwcU5OEsKh4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gbyEDz+iW1ugUjbuOUfymTZcO4n/1hN/eXT39I9Nvn6tPA4HHS6IPtsGgOURkcY8p
 18DJfp8b8xJqVx35Ah7yq2huB4tqvVnvfEcbYjX1rFZaqYmVNuBz6ZRlSWbP1QSV8x
 OYuPeAQaRMp4Qy0W0I9p3mUMWF4xqWAADaJPiS3pWmRI92QljVs1+GxD673/PtE3Oi
 1C9n6DA4daCauJxI2G4ykxOeLq4aOriq8slMx/STrk/7zPbLNL7mMm/rjjh+gAvLfP
 U1pEgPL7wya2tpCYK7nF5bIUp3+vONIB8JaRGi11QZapc7/c/mTG3UeHEXuOMWdzsa
 UvDVKzCSeSj8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] drm/amdgpu: Fix init ordering in
 amdgpu_vram_mgr_init()
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: mkoutny@suse.com, tj@kernel.org, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org
In-Reply-To: <20260611142242.2529-2-thomas.hellstrom@linux.intel.com>
References: <20260611142242.2529-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 14:37:51 +0000
Message-Id: <20260611143751.86DFA1F00893@smtp.kernel.org>
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
- [High] Incomplete Fix / Kernel panic on module load error path: If `gpu_b=
uddy_init()` fails, it cleans up its internal allocations but leaves `mm->n=
_roots > 0` and `mm->free_trees` and `mm->roots` as dangling or NULL pointe=
rs. Because `adev->mman.initialized` is set to `true` prior to calling `amd=
gpu_vram_mgr_init()`, a failure in `gpu_buddy_init()` unconditionally trigg=
ers the driver teardown path. `amdgpu_vram_mgr_fini()` then invokes `gpu_bu=
ddy_fini()`, which dereferences the invalid pointers and causes a kernel pa=
nic.
--

commit 88a159aad4fc080127cdbd3bc127dfaae0ae9c17
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()

This commit fixes kernel panics on the module load error path by moving
drmm_cgroup_register_region() after the list and buddy allocator are fully
initialized.

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

[Severity: High]
This is a pre-existing issue, but if gpu_buddy_init() fails, does it still
leave the system vulnerable to the same module load error path panic?

Looking at drivers/gpu/buddy.c, if gpu_buddy_init() fails after setting
mm->n_roots, the error path cleans up allocations but leaves mm->n_roots
populated and mm->roots as a dangling or NULL pointer:

drivers/gpu/buddy.c:gpu_buddy_init() {
    ...
    mm->n_roots =3D hweight64(size);
    ...
out_free_tree:
    while (i--)
        kfree(mm->free_trees[i]);
    kfree(mm->free_trees);
    return -ENOMEM;
}

Since adev->mman.initialized is set to true before amdgpu_vram_mgr_init() is
called, returning this error will trigger the teardown path where
amdgpu_vram_mgr_fini() unconditionally calls gpu_buddy_fini():

drivers/gpu/buddy.c:gpu_buddy_fini() {
    ...
    for (i =3D 0; i < mm->n_roots; ++i) {
        start =3D gpu_buddy_block_offset(mm->roots[i]);
    ...
}

Because mm->n_roots is non-zero, will this unconditionally dereference the
invalid mm->roots pointer and cause a panic?

> +	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev=
->gmc.real_vram_size);
> +	if (IS_ERR(man->cg))
> +		return PTR_ERR(man->cg);
> +
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>  	ttm_resource_manager_set_used(man, true);
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611142242.2529=
-1-thomas.hellstrom@linux.intel.com?part=3D1
