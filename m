Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1050FC5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E4CE10F296;
	Fri, 21 Aug 2026 09:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fNy0LUBL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68A1010F296
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787305642; x=1818841642;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IadjFUy4h8h9QtYK5SBavvUUGpvA0kBWUTh/umE+qqo=;
 b=fNy0LUBLMjLcMiZiEaShSGGWTbUq8/PRJR4/8eocAp84hDL2wVmfjsKF
 k94k6KkbrcCjYbtVPqCLIg7F4NA1EAGSwESjbIfwvFHnP5ksZ0MnSJX6y
 y8xonzHh2hYqQyoFBgVx2qkjK1w0r6FNfuSkQv8AKNEM4/XrMRRStLXNn
 qQfsCpdYub0I9e1VCdUmqo5R5PqCqEa3iejep2CobwuzY/RTdTGnoV6ae
 vemG3VRygSX8kG2S++iGT/epR3UDKrd7rh0DRAELM7BeLVd9OnkHFjklk
 rAGK3vUzltzJtZOhvl1eFVdl4AQgKIs+XbvZmgh5liC1CphnyJQZeXgE6 Q==;
X-CSE-ConnectionGUID: OhuM9Kt4Rt2pMk7oA2sPSw==
X-CSE-MsgGUID: VMWRE3csTf2GF05ESVf25A==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="113391099"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="113391099"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 02:47:22 -0700
X-CSE-ConnectionGUID: NtUuOaHvQ1O/D4XhTHWuFg==
X-CSE-MsgGUID: Y64nB0LNQreerI/W71XfJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="271523484"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.237])
 ([10.245.245.237])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 02:47:20 -0700
Message-ID: <87ec838b-c73f-45d2-b90b-c696aa6017cc@intel.com>
Date: Fri, 21 Aug 2026 10:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm_buddy: fix power-of-2 rounding errs
To: David Gow <david@ingeniumdigital.com>, Jim Cromie <jim.cromie@gmail.com>, 
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 David Gow <david@davidgow.net>
References: <20260821091918.1902032-1-david@ingeniumdigital.com>
 <20260821091918.1902032-2-david@ingeniumdigital.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260821091918.1902032-2-david@ingeniumdigital.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 21/08/2026 10:19, David Gow wrote:
> From: Jim Cromie <jim.cromie@gmail.com>
> 
> The standard roundup_pow_of_two() and rounddown_pow_of_two() macros use
> unsigned long internally, which on 32-bit architectures (like arm32) is
> a 32-bit type.
> 
> drm_test_buddy_alloc_exceeds_max_order() uses these on a u64 value,
> where they silently truncate the 10GB allocation, giving unexpected
> success in DRM-CI.  (see below the snip).
> 
> Fix this by replacing the those macros with the safe 64-bit power-of-two
> equivalents added in the previous patch.

Do we also need something like is_power_of_2_u64() ? I think we could 
then remove that from i915_utils.h

> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: David Gow <david@davidgow.net>
> ---
> 
> This should actually be version 13, I think, as it's just a rebase of v12
> here, where it was part of a large series of fixups:
> https://lore.kernel.org/all/20260326185413.1205870-40-jim.cromie@gmail.com/
> 
> The major changes since that version are:
> - Add the helper functions rounddown_pow_of_two64() and
>    roundup_pow_of_two64() (see patch 1) instead of open-coding them
> - Rebase now that the buddy allocator lives in drivers/gpu/buddy.c
>    instead of drivers/gpu/drm/drm_buddy.c
> 
> This is still breaking the gpu_test_buddy_alloc_exceeds_max_order
> KUnit test on 32-bit systems:
> [09:01:26]     # gpu_test_buddy_alloc_exceeds_max_order: EXPECTATION FAILED at drivers/gpu/tests/gpu_buddy_test.c:1429
> [09:01:26]     Expected err == -22, but
> [09:01:26]         err == 0 (0x0)
> [09:01:26] WARNING: drivers/gpu/buddy.c:508 at gpu_buddy_fini+0x244/0x2e0, CPU#0: kunit_try_catch/1595
> [09:01:26]     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:508: gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i]))
> [09:01:26] WARNING: drivers/gpu/buddy.c:516 at gpu_buddy_fini+0x284/0x2e0, CPU#0: kunit_try_catch/1595
> [09:01:26]     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:508: gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i]))
> [09:01:26] WARNING: drivers/gpu/buddy.c:516 at gpu_buddy_fini+0x284/0x2e0, CPU#0: kunit_try_catch/1595
> [09:01:26]     # gpu_test_buddy_alloc_exceeds_max_order: drivers/gpu/buddy.c:519: gpu_buddy_assert(!mm->used_scoreboard[i])
> [09:01:26] [FAILED] gpu_test_buddy_alloc_exceeds_max_order
> 
> Cheers,
> -- David
> 
> ---
>   drivers/gpu/buddy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index a5553fcec28c..64f41f1fe908 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1193,7 +1193,7 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>   	u64 modify_size;
>   	int err;
>   
> -	modify_size = rounddown_pow_of_two(size);
> +	modify_size = rounddown_pow_of_two64(size);
>   	order = ilog2(modify_size) - ilog2(mm->chunk_size);
>   	if (order == 0)
>   		return -ENOSPC;
> @@ -1440,7 +1440,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>   
>   	/* Roundup the size to power of 2 */
>   	if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
> -		size = roundup_pow_of_two(size);
> +		size = roundup_pow_of_two64(size);
>   		min_block_size = size;
>   		/*
>   		 * Normalize the requested size to min_block_size for regular allocations.

