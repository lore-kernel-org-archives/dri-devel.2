Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EA2C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E923510F0D9;
	Wed,  9 Sep 2026 12:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X+8w40zG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB96210F0D9
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 12:04:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF96360207;
 Wed,  9 Sep 2026 12:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9811F00A3A;
 Wed,  9 Sep 2026 12:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788955481;
 bh=9rYxiJZq9jRLTihWKw9Y5pcuS+v/rfGDs1KFvYOo6iQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X+8w40zGNJPwZ41f7ZG17nsX0CjDrv7l2+3rnRnuv5pwCvGaaNqFiXlYIXkh1/oAg
 NFtS+ABaNe0hSHR6Stp0Bgt6vulcNCLN1f3SYN8C438N6l5bVWb8MA4aJM4mWv6F+H
 WXD7ZuPNvp8AqlggjGuqYahPlFSzAezIYAc7JlhuvBuPO/ASU1ak5w30W0lhesuAkm
 PAfARCKfhSXztYGSLkVM4ZeULlwrBNhka78ZC/b9Pogm4ZFO0IU0+bPS9hmt67suzD
 +Jqz6smafkEJ/dTjpIbq9iT83cOgHFAkkr78hp2sguOED+LKQn7iaKj6vPPPTj/5ez
 CSvIi07IYHUdQ==
From: sashiko-bot@kernel.org
Subject: Re: Patch "drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()"
 has been added to the 7.2-stable tree
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2026090939-sarcasm-demeaning-4889@gregkh>
References: <2026090939-sarcasm-demeaning-4889@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 12:04:40 +0000
Message-Id: <20260909120441.6B9811F00A3A@smtp.kernel.org>
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
- [High] Unfixed teardown kernel panic when gpu_buddy_init() fails
--

commit 96e42e3ef488e9ad28452efe2bd6b23f7a53c47b
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()

The commit moves drmm_cgroup_register_region() to after the list and
buddy allocator are fully initialized to fix a teardown kernel panic.
When drmm_cgroup_register_region() fails, it triggers the teardown path
which used to crash because the buddy allocator and lists weren't
initialized.

Link: https://patch.msgid.link/20260725100036.2372-2-thomas.hellstrom@linux=
.intel.com

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
This is a pre-existing issue, but does this still lead to a kernel panic
during teardown if gpu_buddy_init() fails?

Because adev->mman.initialized is set to true earlier in amdgpu_ttm_init(),
a failure from gpu_buddy_init() triggers the teardown path in
amdgpu_ttm_fini(), which calls amdgpu_vram_mgr_fini().

amdgpu_vram_mgr_fini() unconditionally calls gpu_buddy_fini():

drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:amdgpu_vram_mgr_fini() {
    ...
	if (!adev->gmc.is_app_apu)
		gpu_buddy_fini(&mgr->mm);
    ...
}

However, if gpu_buddy_init() fails, it cleans up internally and leaves
mm->free_trees as a NULL or dangling pointer:

drivers/gpu/buddy.c:gpu_buddy_init() {
    ...
out_free_tree:
	while (i--)
		kfree(mm->free_trees[i]);
	kfree(mm->free_trees);
	return -ENOMEM;
}

Then gpu_buddy_fini() blindly iterates over these pointers:

drivers/gpu/buddy.c:gpu_buddy_fini() {
    ...
	for_each_free_tree(i)
		kfree(mm->free_trees[i]);

	kfree(mm->free_trees);
	kfree(mm->roots);
}

Could this crash during module load under memory pressure when the
allocation in gpu_buddy_init() fails?

> =20
> +	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev=
->gmc.real_vram_size);
> +	if (IS_ERR(man->cg))
> +		return PTR_ERR(man->cg);
> +
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>  	ttm_resource_manager_set_used(man, true);
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026090939-sarcasm-=
demeaning-4889@gregkh?part=3D1
