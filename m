Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9ED1C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB4510E186;
	Thu, 20 Aug 2026 09:23:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TSvZhlWr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8406C10E186;
 Thu, 20 Aug 2026 09:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787217835; x=1818753835;
 h=message-id:date:mime-version:from:subject:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=uJiOycF+/f02bkxZz/1+Q0TVroILo+5tYPGxK0+n73Y=;
 b=TSvZhlWraYwhCiHQUWG2ECPW7FkRRawH/lGT5oT8KCLRdr/D3OC36wJd
 eQbiSFjNweviPXsROTHgBlumcI9SVqpsJbUh5VyBbKNV9t85347CwahVj
 1l7d8vmqpcZSlbNkUYzMcZiEyALWK2Q+fy8a57CJouhDLxG1Tsd7lvh4q
 EtgVcKjOC3bdeJDNJ9IfItiic3yCoh7g61jNPTtO8LzmHVZioGqxsV6Us
 t2YZtDSBmyDBAGMjARSYw1QZeZBzgL8Omadugm1hjjodYo7uGwatdmZ7p
 MU2dguSKX9vEQWo16Ctqkw37ypIn1jKigKW3sSTzWmrBG2mhXk80JjDTK A==;
X-CSE-ConnectionGUID: MdVWxFcWSiqFXFj/3tFH2A==
X-CSE-MsgGUID: XM+1juO1RHuD37hSR6BO2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="91556407"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="91556407"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 02:23:55 -0700
X-CSE-ConnectionGUID: yLUIQmMpTva4MmZ6el28Fg==
X-CSE-MsgGUID: IzFkMEFDQVOb2atYx/q8JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="259765450"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.245.75])
 ([10.245.245.75])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 02:23:53 -0700
Message-ID: <d3fa2250-3530-44d5-9661-032f195f8ad0@intel.com>
Date: Thu, 20 Aug 2026 10:23:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
To: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net,
 thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org
References: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
Content-Language: en-GB
In-Reply-To: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
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

On 16/08/2026 02:45, Prabhakaran, Krishna wrote:
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
> v2:
>   - Flush our own imported dma-bufs directly with drm_clflush_sg() instead of
>     dma_buf_vmap(), which re-entered i915_gem_object_pin_map() on the source
>     object and failed igt_dmabuf_import_same_driver_smem with -EBUSY (reported
>     by Intel CI on v1). Foreign dma-bufs still use dma_buf_vmap() +
>     drm_clflush_virt_range(); wbinvd only as fallback.
>   - Link to v1: https://patchwork.freedesktop.org/patch/744955/?series=171760
> 
>   drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 55 ++++++++++++++++++----
>   1 file changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> index b43d34c7d641..c798a90f1c0f 100644
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
> @@ -249,16 +251,53 @@ static int i915_gem_object_get_pages_dmabuf(struct drm_i915_gem_object *obj)
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

I think we can bump this now for dg2? I think we treat dgfx as always 
coherent with system memory. So maybe s/IS_DG1/IS_DGFX/ in a separate 
patch? Pretty sure the rest of the driver is the same.

> +		struct dma_buf *dma_buf = obj->base.import_attach->dmabuf;
> +
> +		if (dma_buf->ops == &i915_dmabuf_ops) {
> +			struct drm_i915_gem_object *dma_obj =
> +				dma_buf_to_obj(dma_buf);
> +
> +			/*
> +			 * We imported one of our own dma-bufs. The backing
> +			 * object is struct-page backed once migrated to SMEM,
> +			 * so flush it directly, the same way we flush our
> +			 * other objects. This also avoids re-entering the
> +			 * exporter through dma_buf_vmap(), which would recurse
> +			 * into i915_gem_object_pin_map() on the source object
> +			 * we already hold locked.
> +			 */
> +			if (i915_gem_object_has_struct_page(dma_obj))
> +				drm_clflush_sg(dma_obj->mm.pages);
> +			else
> +				wbinvd_on_all_cpus();

Do we need the flush under the else here? If it's not placed in system 
memory what is this flushing, from i915 pov?

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

