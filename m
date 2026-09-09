Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0984C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2466A10E18D;
	Wed,  9 Sep 2026 11:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iALYLSNB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E84310E18D
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 11:57:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5B1741348;
 Wed,  9 Sep 2026 11:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0BF1F00A3D;
 Wed,  9 Sep 2026 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788955058;
 bh=Dxf3y5o5QOuW8Ywe151kZB6s60wtR8m+xXWrAVvxFcI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iALYLSNBo1UdhEOOVgk4rLCGlCrUicrulx5wAi3x9Jg8LYa7ufQpShxmyB91I4HaC
 Ixiko7ruh3N20n50Q3CquXjmY+Q8jFuJz8AXPONFYynQ5c7F/TOJuLG58V+0SYvrby
 5Pl5kwO3/N8SCAgWCEd4cg2X2c0Q3tPz3HCVID1RmKU2Dq0MG1Jm6H0kBI9eJer/ZN
 D6hjwpPTpf3yHGxmQjrgH45akCEW9XfQZp6AnvEK5TclFi7xZ60q2B4OAfZqWI+bIV
 ++iWWHlWsq8LQAhNiUUwISCpyjk9PYAdg/pVTrnJo5mRGpdGblcJiwh7TNO5haE8QD
 dwPLWxwofmh0A==
From: sashiko-bot@kernel.org
Subject: Re: Patch "drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()"
 has been added to the 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2026090937-mangle-cinema-f62f@gregkh>
References: <2026090937-mangle-cinema-f62f@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 11:57:38 +0000
Message-Id: <20260909115738.8F0BF1F00A3D@smtp.kernel.org>
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
- [High] If `drm_buddy_init()` fails, it frees its internal structures but =
leaves dangling pointers and a non-zero `mm->n_roots`. `amdgpu_vram_mgr_fin=
i()` then unconditionally calls `drm_buddy_fini()`, which dereferences thes=
e pointers, causing a Use-After-Free or NULL pointer dereference crash.
--

commit 952cbc7ae0fee615a078c5b60b31a61af5185d75
Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>

Patch "drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()" has been ad=
ded to the 6.18-stable tree

This patch fixes an initialization ordering issue in amdgpu_vram_mgr_init().
It moves drmm_cgroup_register_region() to after the list and buddy allocator
are fully initialized. This prevents the module load error path from
dereferencing uninitialized list pointers or NULL pointers.

Link: https://patch.msgid.link/20260725100036.2372-2-thomas.hellstrom@linux=
.intel.com

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 9d934c07fa6b8..2e457a0388a32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c

[ ... ]

> @@ -934,6 +931,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  	if (err)
>  		return err;

[Severity: High]
This isn't a bug introduced by this patch, but can we still encounter a
kernel panic on the error path if drm_buddy_init() fails?

If drm_buddy_init() fails, it frees mm->roots on its error path but leaves
mm->n_roots > 0:

drivers/gpu/drm/drm_buddy.c:drm_buddy_init() {
    ...
    mm->n_roots =3D hweight64(size);
    ...
    do {
        ...
        root =3D drm_block_alloc(mm, NULL, order, offset);
        if (!root)
            goto out_free_roots;
    ...
out_free_roots:
    while (i--)
        drm_block_free(mm, mm->roots[i]);
    kfree(mm->roots);
    ...
}

Because the driver teardown path calls amdgpu_vram_mgr_fini() which
unconditionally calls drm_buddy_fini(), doesn't this result in
dereferencing the freed mm->roots array since mm->n_roots is still > 0?

drivers/gpu/drm/drm_buddy.c:drm_buddy_fini() {
    ...
    for (i =3D 0; i < mm->n_roots; ++i) {
        order =3D ilog2(size) - ilog2(mm->chunk_size);
        start =3D drm_buddy_block_offset(mm->roots[i]);
    ...
}

Could the error path in drm_buddy_init() reset mm->n_roots to 0, or could
amdgpu_vram_mgr_fini() skip calling drm_buddy_fini() if initialization fail=
ed?

> +	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev=
->gmc.real_vram_size);
> +	if (IS_ERR(man->cg))
> +		return PTR_ERR(man->cg);
> +
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>  	ttm_resource_manager_set_used(man, true);
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026090937-mangle-c=
inema-f62f@gregkh?part=3D1
