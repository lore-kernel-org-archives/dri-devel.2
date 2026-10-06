Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C20ECA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9769510E1E1;
	Tue,  6 Oct 2026 07:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D+XhfEht";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7AEF10F226;
 Tue,  6 Oct 2026 07:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791272505; x=1822808505;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=Jvs7bD7PA4yEwVd5cuhIyWWuagFCWt/2y23LxYYManc=;
 b=D+XhfEht05rjtlkk3M6k8wVn1MeudWGD1X+TFgr8HlOTQgaKcFPHO/BS
 d+qSsvd5J+KCzmH2+WAJwALhOn4HKtFPU1SDhDIOOmifEuCWu9lS0rLD3
 WRiVODjiXSMmjSPU7OudrNdhffpXAk2v3XEqnt2V0oSF/x6FkH8PIJR6J
 VxkaNJsghAbJm8PtwobZhuSgVS029lc/mVsKsVpOB0gpoXupcASzzxBtq
 SSSFPju0ejdB9rD+HXEjKqyJ0UEESC5MNA68V9enp1U/VTLU3JfuWUkSi
 fqZDCxWrXL+XfrDOfeT96NaMRZqrn8rTnEj8c31VntIbopXI7LIs0Qvo9 A==;
X-CSE-ConnectionGUID: zzXQfweYQj+Y+V4OdaYiLQ==
X-CSE-MsgGUID: EdSKtirSSHWeNrYeOVW0Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="3723"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="3723"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 00:41:44 -0700
X-CSE-ConnectionGUID: NvKzBjS1SFGc6dKHvOE3lg==
X-CSE-MsgGUID: 7jEUxuY8Qsiw/5ZQ1mJDrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="285187984"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.59])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 00:41:41 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yuho Choi <oss.patchbox@gmail.com>, Zhenyu Wang
 <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Xiaolin
 Zhang <xiaolin.zhang@intel.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Yuho Choi
 <oss.patchbox@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v1] drm/i915/gvt: Don't replace a DMA mapping that is
 still in use
In-Reply-To: <20261004212403.208681-1-oss.patchbox@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261004212403.208681-1-oss.patchbox@gmail.com>
Date: Tue, 06 Oct 2026 10:41:39 +0300
Message-ID: <5e03928e7817104f062e27f0b14d180549f209c2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Sun, 04 Oct 2026, Yuho Choi <oss.patchbox@gmail.com> wrote:
> intel_gvt_dma_map_guest_page() unmaps and frees the cache entry of a
> gfn when it is requested with a different size, and maps the page again.
> The entry is still referenced: shadow GTT entries and dma-bufs keep
> using its DMA address after the page is unpinned and the DMA mapping is
> torn down. When the new mapping gets the same DMA address, their later
> intel_gvt_dma_unmap_guest_page() calls also drop the references of the
> new entry.
>
> Keep the existing entry instead. A 2M mapping covers a 4K request for
> its first page, so take a reference on it. If the entry is smaller than
> the request, fail and let the caller split the 2M entry into 4K pages,
> as it already does when a 2M mapping cannot be set up.
>
> Fixes: 7366aeb77cd8 ("drm/i915/gvt: fix incorrect cache entry for guest page mapping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Compile-tested only (x86_64 defconfig + DRM_I915_GVT_KVMGT, W=1, sparse).

IOW, you're not hitting the issue yourself? How did you find the issue?
Did you use LLM to write the patch?

BR,
Jani.

>
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
> index ec62db5cc3675..9a3e305253469 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -1626,19 +1626,15 @@ int intel_gvt_dma_map_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
>  		ret = __gvt_cache_add(vgpu, gfn, *dma_addr, size);
>  		if (ret)
>  			goto err_unmap;
> -	} else if (entry->size != size) {
> -		/* the same gfn with different size: unmap and re-map */
> -		gvt_dma_unmap_page(vgpu, gfn, entry->dma_addr, entry->size);
> -		__gvt_cache_remove_entry(vgpu, entry);
> -
> -		ret = gvt_dma_map_page(vgpu, gfn, dma_addr, size);
> -		if (ret)
> -			goto err_unlock;
> -
> -		ret = __gvt_cache_add(vgpu, gfn, *dma_addr, size);
> -		if (ret)
> -			goto err_unmap;
> +	} else if (entry->size < size) {
> +		/*
> +		 * The smaller mapping may still be in use, so don't replace
> +		 * it. Fail and let the caller map the range in smaller pages.
> +		 */
> +		ret = -EBUSY;
> +		goto err_unlock;
>  	} else {
> +		/* A mapping of the same or a larger size covers the request */
>  		kref_get(&entry->ref);
>  		*dma_addr = entry->dma_addr;
>  	}
>
> base-commit: 7704c4c5bb127673b4f0ead839919db573559e38

-- 
Jani Nikula, Intel
