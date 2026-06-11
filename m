Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BEFCD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060E210E261;
	Thu, 11 Jun 2026 17:27:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O3nDr8qC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44D910E261
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781198838; x=1812734838;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lpcTJDq2p6IGrsoF+r759oeYvPEh7M1FlOvygypj0iY=;
 b=O3nDr8qCpBH5TUFjBRVlxs7j5z3TKxJb4VlmibZKN4LtlmkNbgRpplMC
 wvfyDhy0xGHQ/wILVxi8ZkbSSa0mJnHzFzkCoHz3OaiSItKQ5mG4Vsr5v
 RrH2/RDyYS74VFnDyJ7uakg7lIvt+hODx31jJXeBzgJ7h913ZyyU4Z1Ij
 dXxwkCP+O/24qSF8vlFEQB01WGx81YoaTyMICpQW5q2+b3U+NnFqLg4hQ
 8UoNSlhLNStIYO5DJ0X+kzM/76bwhHyYtJ2izQ5awn+T3805cTG6BwYm1
 tmG4hzkYiOOBTL3xp77z5IiaCwEHIcMT30l45HwfTe+KVOusNARqyic47 Q==;
X-CSE-ConnectionGUID: Cmz4f6dgRk+EsPHD5zD8tg==
X-CSE-MsgGUID: +uqLNeHlRVCZai5MV7ri2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82212866"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="82212866"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 10:27:17 -0700
X-CSE-ConnectionGUID: MUSoQxfnQoW6sPPU6jxh3A==
X-CSE-MsgGUID: 6C9WsfZnRAmpyhSgruLmog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="270576840"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.244.169])
 ([10.245.244.169])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 10:27:16 -0700
Message-ID: <f888a852-25d3-4bbb-8675-29ed080c1bfa@linux.intel.com>
Date: Thu, 11 Jun 2026 19:27:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] drm/amdgpu: Fix init ordering in
 amdgpu_vram_mgr_init()
To: sashiko-reviews@lists.linux.dev
Cc: mkoutny@suse.com, tj@kernel.org, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org
References: <20260611142242.2529-2-thomas.hellstrom@linux.intel.com>
 <20260611143751.86DFA1F00893@smtp.kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20260611143751.86DFA1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On 6/11/26 16:37, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Incomplete Fix / Kernel panic on module load error path: If `gpu_buddy_init()` fails, it cleans up its internal allocations but leaves `mm->n_roots > 0` and `mm->free_trees` and `mm->roots` as dangling or NULL pointers. Because `adev->mman.initialized` is set to `true` prior to calling `amdgpu_vram_mgr_init()`, a failure in `gpu_buddy_init()` unconditionally triggers the driver teardown path. `amdgpu_vram_mgr_fini()` then invokes `gpu_buddy_fini()`, which dereferences the invalid pointers and causes a kernel panic.

Pre-existing issues are out of scope for this series, except when they 
are needed for the new functionality.

/Thomas



> --
>
> commit 88a159aad4fc080127cdbd3bc127dfaae0ae9c17
> Author: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>
> drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()
>
> This commit fixes kernel panics on the module load error path by moving
> drmm_cgroup_register_region() after the list and buddy allocator are fully
> initialized.
>
> Closes: https://sashiko.dev/#/patchset/20260428073116.15687-1-thomas.hellstrom@linux.intel.com?part=4
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 2a241a5b12c42..ac3f71d77140a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> [ ... ]
>> @@ -935,6 +932,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>>   	if (err)
>>   		return err;
> [Severity: High]
> This is a pre-existing issue, but if gpu_buddy_init() fails, does it still
> leave the system vulnerable to the same module load error path panic?
>
> Looking at drivers/gpu/buddy.c, if gpu_buddy_init() fails after setting
> mm->n_roots, the error path cleans up allocations but leaves mm->n_roots
> populated and mm->roots as a dangling or NULL pointer:
>
> drivers/gpu/buddy.c:gpu_buddy_init() {
>      ...
>      mm->n_roots = hweight64(size);
>      ...
> out_free_tree:
>      while (i--)
>          kfree(mm->free_trees[i]);
>      kfree(mm->free_trees);
>      return -ENOMEM;
> }
>
> Since adev->mman.initialized is set to true before amdgpu_vram_mgr_init() is
> called, returning this error will trigger the teardown path where
> amdgpu_vram_mgr_fini() unconditionally calls gpu_buddy_fini():
>
> drivers/gpu/buddy.c:gpu_buddy_fini() {
>      ...
>      for (i = 0; i < mm->n_roots; ++i) {
>          start = gpu_buddy_block_offset(mm->roots[i]);
>      ...
> }
>
> Because mm->n_roots is non-zero, will this unconditionally dereference the
> invalid mm->roots pointer and cause a panic?
>
>> +	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
>> +	if (IS_ERR(man->cg))
>> +		return PTR_ERR(man->cg);
>> +
>>   	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>>   	ttm_resource_manager_set_used(man, true);
>>   	return 0;
