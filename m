Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C890C5DF8E
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E318E10F276;
	Fri, 21 Aug 2026 09:09:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YRN3yd6F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C3510E297;
 Fri, 21 Aug 2026 09:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787303379; x=1818839379;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=d986WdqhlagJUjtBnRxf/TrT6JGOX87qNB56dhaCxCU=;
 b=YRN3yd6FsNRfqPAUvPnxnVhUnq6EeYOlh3sXjIo0Tq5F53JWXZAjT1PN
 uXS0UEDoc4oh7Qzr7sj1U0uwCGWRiK5UoXH9d92V6eL92uACtal/jxqRV
 BuXW8asdkrT7g2QhOk8OJ2fq8qq+tBLDwLaJiXJTEO5CTN6f4krsEV2r+
 8kHs90plaiyWFJOrePLmo9QPn3M0Zx+u2hhZOnM942ucyk5SaNU/brLlK
 nd/Efd8zI2qVp+EvZWq+x5SYtm3w2erHjXojCOpa8VBny0HB5+84urFbq
 V+0Cxoq1KGOYLexo3rDVR0TRn1pmj5hWkYcLprbw2TXSWzRlKqoeycWPz Q==;
X-CSE-ConnectionGUID: M2i5f4EsQ4GSZ7gWlr7y1w==
X-CSE-MsgGUID: osk+iDStQg2t+AtSjofU9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="99004734"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="99004734"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 02:09:39 -0700
X-CSE-ConnectionGUID: yij2+kLOTsaQfFKHHyZZrg==
X-CSE-MsgGUID: p69U9p4HShyuHfxJDT+PdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="289808769"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.237])
 ([10.245.245.237])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 02:09:37 -0700
Message-ID: <50981231-a975-4ca9-8ad3-df2a34588b06@intel.com>
Date: Fri, 21 Aug 2026 10:09:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
To: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: thomas.hellstrom@linux.intel.com, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, dri-devel@lists.freedesktop.org
References: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
 <20260820205031.344338-1-krishna.prabhakaran@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260820205031.344338-1-krishna.prabhakaran@intel.com>
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

On 20/08/2026 21:50, Prabhakaran, Krishna wrote:
> From: Krishna Prabhakaran <krishna.prabhakaran@intel.com>
> 
> When i915 needs to make an imported dma-buf coherent for GPU access on
> non-LLC platforms, or for objects that bypass LLC, it currently calls
> wbinvd_on_all_cpus(). get_pages() runs whenever an imported buffer is
> pinned, so this triggers a whole-cache write-back and invalidate,
> broadcast by IPI to every CPU, on every execbuf submission involving an
> imported dma-buf. That stalls the entire machine for milliseconds and
> starves latency-sensitive work on unrelated cores (e.g. USB isochronous
> audio serviced on the VMM's main thread).
> 
> Flush only the pages that actually need it instead:
> 
>   - If we imported one of our own dma-bufs, the backing object is
>     struct-page backed once migrated to SMEM, so flush it directly with
>     drm_clflush_sg(), exactly as we flush our other objects. This also
>     avoids re-entering the exporter through dma_buf_vmap(), which would
>     recurse into i915_gem_object_pin_map() on the source object we
>     already hold locked (and fails the igt_dmabuf_import_same_driver
>     selftest with -EBUSY).
> 
>   - For a foreign dma-buf the sg_table is not guaranteed to be backed by
>     struct pages, and the importer has no way to tell, so drm_clflush_sg()
>     cannot be used. vmap the buffer and flush that virtual range with
>     drm_clflush_virt_range() instead: x86 uses PIPT caches, so flushing
>     one virtual alias evicts the cache lines for every alias of the same
>     physical pages. The dma_resv lock required by dma_buf_vmap() is
>     already held here via the imported object.
> 
> Fall back to wbinvd only when the buffer cannot be vmapped or is backed
> by I/O memory, where there is no CPU-side range to clflush.
> 
> Fixes: a035154da45d ("drm/i915/dmabuf: add paranoid flush-on-acquire")
> Signed-off-by: Krishna Prabhakaran <krishna.prabhakaran@intel.com>
> ---
> v3:
>   - Drop the wbinvd fallback in the own-dma-buf branch: the exporter is
>     migrated to SMEM on attach, so it is always struct-page backed here;
>     flushing device memory made no sense from i915's point of view
>     (Matthew Auld).
> 
> v2:
>   - Flush our own imported dma-bufs directly with drm_clflush_sg() instead of
>     dma_buf_vmap(), which re-entered i915_gem_object_pin_map() on the source
>     object and failed igt_dmabuf_import_same_driver_smem with -EBUSY (reported
>     by Intel CI on v1). Foreign dma-bufs still use dma_buf_vmap() +
>     drm_clflush_virt_range(); wbinvd only as fallback.
>   - Link to v1: https://patchwork.freedesktop.org/patch/744955/?series=171760
> 
>   drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 52 ++++++++++++++++++----
>   1 file changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> index b43d34c7d641..fbf0e0d4b026 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> @@ -10,6 +10,8 @@
>   
>   #include <asm/smp.h>
>   
> +#include <drm/drm_cache.h>
> +
>   #include "gem/i915_gem_dmabuf.h"
>   #include "i915_drv.h"
>   #include "i915_gem_object.h"
> @@ -249,16 +251,50 @@ static int i915_gem_object_get_pages_dmabuf(struct drm_i915_gem_object *obj)
>   	 * DG1 is special here since it still snoops transactions even with
>   	 * CACHE_NONE. This is not the case with other HAS_SNOOP platforms. We
>   	 * might need to revisit this as we add new discrete platforms.
> -	 *
> -	 * XXX: Consider doing a vmap flush or something, where possible.
> -	 * Currently we just do a heavy handed wbinvd_on_all_cpus() here since
> -	 * the underlying sg_table might not even point to struct pages, so we
> -	 * can't just call drm_clflush_sg or similar, like we do elsewhere in
> -	 * the driver.
>   	 */
>   	if (i915_gem_object_can_bypass_llc(obj) ||
> -	    (!HAS_LLC(i915) && !IS_DG1(i915)))
> -		wbinvd_on_all_cpus();
> +	    (!HAS_LLC(i915) && !IS_DG1(i915))) {
> +		struct dma_buf *dma_buf = obj->base.import_attach->dmabuf;
> +
> +		if (dma_buf->ops == &i915_dmabuf_ops) {
> +			struct drm_i915_gem_object *dma_obj =
> +				dma_buf_to_obj(dma_buf);
> +
> +			/*
> +			 * We imported one of our own dma-bufs. The exporter is
> +			 * migrated to SMEM on attach, so it is struct-page
> +			 * backed and we can flush it directly, the same way we
> +			 * flush our other objects. This also avoids re-entering
> +			 * the exporter through dma_buf_vmap(), which would
> +			 * recurse into i915_gem_object_pin_map() on the source
> +			 * object we already hold locked.
> +			 */
> +			drm_clflush_sg(dma_obj->mm.pages);

I think we still need to wrap this with has_struct_page()?

> +		} else {
> +			struct iosys_map map;
> +
> +			/*
> +			 * A foreign sg_table is not guaranteed to be backed by
> +			 * struct pages, so we cannot use drm_clflush_sg(). vmap
> +			 * the buffer and flush the virtual range instead; x86
> +			 * uses PIPT caches, so flushing one alias evicts the
> +			 * lines for every alias of the same physical pages.
> +			 *
> +			 * We already hold the dma_resv lock via the imported
> +			 * obj, so use the locked dma_buf_vmap() variant.
> +			 */
> +			if (!dma_buf_vmap(dma_buf, &map)) {
> +				if (!map.is_iomem)
> +					drm_clflush_virt_range(map.vaddr,
> +							       obj->base.size);
> +				else
> +					wbinvd_on_all_cpus();
> +				dma_buf_vunmap(dma_buf, &map);
> +			} else {
> +				wbinvd_on_all_cpus();
> +			}
> +		}
> +	}
>   
>   	__i915_gem_object_set_pages(obj, sgt);
>   
> 
> base-commit: 682ea2d28d18bb06f9fc663cb5ab7e80dc0e606a

