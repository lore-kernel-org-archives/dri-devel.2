Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F5606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jjOQxnt6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CEA010FB13;
	Wed, 28 Oct 2026 09:59:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D6110FB18;
 Wed, 28 Oct 2026 09:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793181569; x=1824717569;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=0vHXV9ObKhX13afcYiPJkTqBcSHLibfB6zlngUh0HlI=;
 b=jjOQxnt6wy5LE27P70HYZxSIk8JNjVsea7DtWAUH5D9FOrKmGWLvyTgk
 oi7nBX5CiQc9ZQ1P7Pu9xCLftmG83B6Kzcag/BDUS1CfoJMNm4MiopgIS
 U+QDCSDhNBjN4pWnrAbB1Za4MOMcZ6R73xbhIE2u4qaSnIsIn/vBpkrAn
 PHH+dzp+WrrQFYaQ4XkmyQjMTGvDDYoPNupFjfBVh3DSRdCynb0tZEgah
 Qib9nn/PeBkzKfXrbC0+OV7Jgk1pa/zh469PJxq3i7MEhsyXQqP3H1/ag
 h80NKhQwMiVb/ap3lFiGl/iX86ROB8dKoBU+tEcuYOp/AFGJgM/tRz+ZU Q==;
X-CSE-ConnectionGUID: 5EyyqE9pSJW7k8Ku+qjofw==
X-CSE-MsgGUID: TqvSK/iZR06ZJXFzYSZHkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1909797"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1909797"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 02:59:29 -0700
X-CSE-ConnectionGUID: iYC4SpshRwSCKVdOQ4dA2w==
X-CSE-MsgGUID: QynQGQqPSBW8zIriNKoSAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4810184"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.244.196])
 ([10.245.244.196])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 02:59:28 -0700
Message-ID: <dcbb570b-0f53-4df2-9d17-62c66a80a8c4@intel.com>
Date: Wed, 28 Oct 2026 09:59:26 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] drm/xe: Bump the LRU on a successful page fault
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20261027224902.1085762-1-matthew.brost@intel.com>
 <20261027224902.1085762-2-matthew.brost@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20261027224902.1085762-2-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/10/2026 22:49, Matthew Brost wrote:
> Servicing a page fault validates the VMA's backing store and binds it,
> making the BO part of the VM's active working set, but unlike exec it
> never moves anything on the TTM LRU. In fault mode, where a VM may run
> for a long time without a single exec, the BOs the GPU actually touches
> therefore drift towards the LRU head and are picked by eviction and by
> the shrinker ahead of genuinely cold BOs.
> 
> Bump the BO's LRU on a successful page fault.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_pagefault.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> index 5247321c805e..6828f81df50e 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> @@ -201,6 +201,8 @@ static int xe_pagefault_handle_vma(struct xe_gt *gt, struct xe_vma *vma,
>   		xe_validation_ctx_init(&ctx, &vm->xe->val, &exec,
>   				       (struct xe_val_flags) {});
>   		drm_exec_until_all_locked(&exec) {
> +			struct xe_bo *bo = xe_vma_bo(vma);
> +
>   			err = xe_pagefault_begin(&exec, vma, tile->mem.vram,
>   						 needs_vram == 1);
>   			drm_exec_retry_on_contention(&exec);
> @@ -221,6 +223,11 @@ static int xe_pagefault_handle_vma(struct xe_gt *gt, struct xe_vma *vma,
>   				xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_VMA_REBIND);
>   				break;
>   			}
> +
> +			if (bo) {
> +				scoped_guard(spinlock, &vm->xe->ttm.lru_lock)
> +					ttm_bo_move_to_lru_tail(&bo->ttm);

Would it be cleaner to just use ttm_bo_move_to_lru_tail_unlocked() 
without the scoped guard stuff?

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> +			}
>   		}
>   		xe_validation_ctx_fini(&ctx);
>   	} while (err == -EAGAIN);

