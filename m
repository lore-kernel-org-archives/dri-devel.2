Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F1ECD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3502C10F09F;
	Thu, 11 Jun 2026 17:45:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WQ/DlkrP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C62110F088
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:45:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 898CE60129;
 Thu, 11 Jun 2026 17:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03BB1F00893;
 Thu, 11 Jun 2026 17:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781199914;
 bh=Qs3mBOxq0NSnEwaa/zT+TfPMQLlOfigD2IL0WgU2P0Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WQ/DlkrPSMc8gab6f+gaOlFyguYTlj04ncqpwiZLQ005Bk6vpg1JooU9iATVKo6Q5
 3flh2VA/wFk3CwBHx+uaHfu5Rjb6M3qOocrnS7c/ZA+OEHGWeDql8gW67zBMHXJNfA
 6dYQFdqdxfMtd93JaQGacC738ICD+1FGuPxTHkND4sQA+aUDfoqraZzcmKmHmjubmJ
 mGUSFi+mHCPmw9U/OPuztW3GjGV06Te3DPfqz5GOj3S/vBq2Ch2eMv+g+QKPFAuUY2
 XBZpQN3/v/5fxRy40DaAB0xZ1L87ZK4zrtmJHXRDwN36/4ZJboTphmGmpW/U5Q9PC9
 L+Z9QO2vH2L4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] drm/amdgpu: Fix init ordering in
 amdgpu_vram_mgr_init()
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260611173301.17473-2-thomas.hellstrom@linux.intel.com>
References: <20260611173301.17473-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:45:13 +0000
Message-Id: <20260611174513.F03BB1F00893@smtp.kernel.org>
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
- [High] Incomplete Fix / NULL Pointer Dereference or Use-After-Free on Err=
or Path
--

commit 2ee86f69ec7f41352206d6f701597e5f22e81241
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()

drmm_cgroup_register_region() is called before INIT_LIST_HEAD() and
gpu_buddy_init() in amdgpu_vram_mgr_init(). If it fails, the function
returns early and bypasses those initializations.

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
This isn't a bug introduced by this patch, but does this still leave a
use-after-free or NULL pointer dereference on the error path if
gpu_buddy_init() fails?

If gpu_buddy_init() fails, it cleans up its partial allocations but leaves
mgr->mm.free_trees as a dangling pointer or NULL.

Because adev->mman.initialized is set to true before amdgpu_vram_mgr_init()
is called, the error teardown path unconditionally calls amdgpu_ttm_fini(),
which calls amdgpu_vram_mgr_fini():

drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:amdgpu_vram_mgr_fini() {
    ...
	if (!adev->gmc.is_app_apu)
		gpu_buddy_fini(&mgr->mm);
    ...
}

This calls gpu_buddy_fini() which accesses mm->free_trees:

drivers/gpu/buddy.c:gpu_buddy_fini() {
    ...
	for_each_free_tree(i)
		kfree(mm->free_trees[i]);
    ...
}

Could this dereference the uninitialized or dangling mm->free_trees pointer
and cause a kernel panic during module load error handling?

> +	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev=
->gmc.real_vram_size);
> +	if (IS_ERR(man->cg))
> +		return PTR_ERR(man->cg);
> +
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>  	ttm_resource_manager_set_used(man, true);
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611173301.1747=
3-1-thomas.hellstrom@linux.intel.com?part=3D1
