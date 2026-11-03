Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0916606A32D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jH17li6p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E11F10F579;
	Tue,  3 Nov 2026 12:58:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E3B10F58E;
 Tue,  3 Nov 2026 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793710725; x=1825246725;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WTMMGG2Ap1YgRjbL9EB4ZZ65jzebO1CgA6BdGP8UMYw=;
 b=jH17li6p3vQklbs5WLY4pfB9v1XpQqMEzWKcoh+mV3vV6UbpS0MhqsAM
 npevMsI6LZ4LKnHyqnzbSMMcT7uhCKLVm9VXv6twANmmMswS/gZiPlzzS
 CDwr0ShWDuEXF6nTuP2hb/AIOAncMbYW5NHS9ZITHh1HWJTPunBTnK/+m
 P0WHsDciusZ7ImDi5QzOT2NXHSyqKRcYbcZ28+EJho4SefFj/I+MSAcBp
 B3Kn1VugQl38KFXfKqOfZCwbH+FQei09Mz/Cc7JF7s9D+zpFQXJy7cPbU
 zi1udmLFjCh3FwxFbq5sATYWvLkhYgpGiUQfa2xeDjgLQ1uNS2emQY5C8 A==;
X-CSE-ConnectionGUID: ctAZluanRgyhDDqT2XbLnQ==
X-CSE-MsgGUID: sOIwKKvETJ2vAGqWYA4KMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2462273"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2462273"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 04:58:44 -0800
X-CSE-ConnectionGUID: u3AZ0cr2TruyzBmJUpA2tw==
X-CSE-MsgGUID: CucWUwx/R0OUNzxUQkgnag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6438936"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.245.160])
 ([10.245.245.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 04:58:41 -0800
Message-ID: <3bc563bf-9692-4611-a85a-9e21d43373c9@intel.com>
Date: Tue, 3 Nov 2026 12:58:39 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/33] drm/xe: Add xe_migrate_copy_defrag() for on-GPU
 defrag copies
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-18-matthew.brost@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260711025619.2540575-18-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/07/2026 03:56, Matthew Brost wrote:
> Add xe_migrate_copy_defrag(), a copy helper for the upcoming page
> defragmentation path where a single BO has its backing reallocated at a
> more beneficial page order and its contents must be relocated from the
> old pages to the new ones entirely on the GPU.
> 
> The contents are relocated in up to two passes:
> 
>   - Data pass (always): copy the data pages verbatim. The pages are
>     mapped without the compression PAT, so the (possibly compressed)
>     bytes are copied as-is rather than being decompressed and
>     recompressed, and no CCS aux copy is appended.
> 
>   - CCS pass (need_ccs): copy the CCS aux (compression) state. Both the
>     old and new data pages are mapped with the compression PAT so the
>     copy engine accesses the aux state indirectly, issuing one
>     indirect -> indirect XY_CTRL_SURF_COPY_BLT; the data blit is skipped.


Just to double check, there were no issues with this flow for a 
compressed surface? Not 100% sure if reading from the src with 
uncompressed PAT will zero out the CCS state (update to uncompressed 
status), such that when you do the CCS pass it is already gone. Quite 
sure it does that for a write, but I guess not for a read, so we are 
fine here?

> 
> The two passes are issued separately because they require opposite
> compression PAT settings on the data page mappings (cleared for the
> verbatim data copy, set for the indirect CCS access), which a single
> mapping cannot satisfy. Both passes run in order on the same migrate
> queue and are captured by the returned fence.
> 
> The source pages are passed explicitly via an sg_table argument (the
> old, still populated backing) since they no longer match the BO's
> current backing. The boolean arguments to __xe_migrate_copy() are folded
> into struct xe_migrate_copy_flags to keep the growing set of copy
> variants readable.
> 
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Ryan Neph <ryanneph@google.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Assisted-by: GitHub_Copilot:claude-opus-4.8
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_migrate.c | 136 ++++++++++++++++++++++++++++----
>   drivers/gpu/drm/xe/xe_migrate.h |   8 ++
>   2 files changed, 128 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
> index 92d5e81ceac2..305c6e1942fb 100644
> --- a/drivers/gpu/drm/xe/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/xe_migrate.c
> @@ -858,13 +858,39 @@ static u32 xe_migrate_ccs_copy(struct xe_migrate *m,
>   	return flush_flags;
>   }
>   
> +/**
> + * struct xe_migrate_copy_flags - Flags for __xe_migrate_copy()
> + * @copy_only_ccs: Only copy the CCS aux state, aliasing the destination data
> + * mapping to the source (used when the data pages are shared between src/dst).
> + * @is_vram_resolve: Decompression (VRAM -> system) resolve; always uses the
> + * compression PAT index for the data copy.
> + * @defrag_ccs: Defrag move pass that migrates only the CCS aux state between
> + * two distinct page sets (old @src_sg pages -> new pages). The data blit is
> + * skipped (the data was copied by the @defrag_copy pass) and both the source
> + * and destination data pages are mapped with the compression PAT so the aux
> + * state is copied indirect -> indirect.
> + * @defrag_copy: Defrag move pass that copies the data pages between two
> + * distinct page sets (old @src_sg pages -> new pages) without touching the CCS
> + * aux state. The data pages are mapped without the compression PAT so the
> + * (possibly compressed) bytes are copied verbatim rather than being
> + * decompressed and recompressed, and no CCS aux copy is appended; the aux
> + * state is migrated separately by the @defrag_ccs pass. The two passes need
> + * opposite compression PAT settings, which is why they cannot be combined.
> + */
> +struct xe_migrate_copy_flags {
> +	u32 copy_only_ccs : 1;
> +	u32 is_vram_resolve : 1;
> +	u32 defrag_ccs : 1;
> +	u32 defrag_copy : 1;
> +};
> +
>   static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
>   					   struct xe_bo *src_bo,
>   					   struct xe_bo *dst_bo,
>   					   struct ttm_resource *src,
>   					   struct ttm_resource *dst,
> -					   bool copy_only_ccs,
> -					   bool is_vram_resolve)
> +					   struct sg_table *src_sg,
> +					   struct xe_migrate_copy_flags flags)
>   {
>   	struct xe_gt *gt = m->tile->primary_gt;
>   	struct xe_device *xe = gt_to_xe(gt);
> @@ -881,20 +907,29 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
>   	bool src_is_vram = mem_type_is_vram(src->mem_type);
>   	bool dst_is_vram = mem_type_is_vram(dst->mem_type);
>   	bool type_device = src_bo->ttm.type == ttm_bo_type_device;
> -	bool needs_ccs_emit = type_device && xe_migrate_needs_ccs_emit(xe);
> +	bool needs_ccs_emit = type_device && xe_migrate_needs_ccs_emit(xe) &&
> +		!flags.defrag_copy;
>   	bool copy_ccs = xe_device_has_flat_ccs(xe) &&
> -		xe_bo_needs_ccs_pages(src_bo) && xe_bo_needs_ccs_pages(dst_bo);
> -	bool copy_system_ccs = copy_ccs && (!src_is_vram || !dst_is_vram);
> +		xe_bo_needs_ccs_pages(src_bo) && xe_bo_needs_ccs_pages(dst_bo) &&
> +		!flags.defrag_copy;
> +	bool copy_system_ccs = copy_ccs && (!src_is_vram || !dst_is_vram) &&
> +		!flags.defrag_ccs && !flags.defrag_copy;
>   
>   	/*
>   	 * For decompression operation, always use the compression PAT index.
>   	 * Otherwise, only use the compression PAT index for device memory
>   	 * when copying from VRAM to system memory.
>   	 */
> -	bool use_comp_pat = is_vram_resolve || (type_device &&
> +	bool use_comp_pat = flags.is_vram_resolve || (type_device &&
>   			    xe_device_has_flat_ccs(xe) &&
>   			    GRAPHICS_VER(xe) >= 20 && src_is_vram && !dst_is_vram);
>   
> +	/*
> +	 * The defrag CCS pass migrates the aux state from the old pages
> +	 * (@src_sg) to the new pages with both sides accessed indirectly, so
> +	 * keep both src_is_pltt and dst_is_pltt set (no direct staging side).
> +	 */
> +
>   	/* Copying CCS between two different BOs is not supported yet. */
>   	if (XE_WARN_ON(copy_ccs && src_bo != dst_bo))
>   		return ERR_PTR(-EINVAL);
> @@ -903,7 +938,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
>   		return ERR_PTR(-EINVAL);
>   
>   	if (!src_is_vram)
> -		xe_res_first_sg(xe_bo_sg(src_bo), 0, size, &src_it);
> +		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo), 0, size, &src_it);
>   	else
>   		xe_res_first(src, 0, size, &src_it);
>   	if (!dst_is_vram)
> @@ -912,7 +947,8 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
>   		xe_res_first(dst, 0, size, &dst_it);
>   
>   	if (copy_system_ccs)
> -		xe_res_first_sg(xe_bo_sg(src_bo), xe_bo_ccs_pages_start(src_bo),
> +		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo),
> +				xe_bo_ccs_pages_start(src_bo),
>   				PAGE_ALIGN(xe_device_ccs_bytes(xe, size)),
>   				&ccs_it);
>   
> @@ -942,7 +978,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
>   		batch_size += pte_update_size(m, pte_flags, src, &src_it, &src_L0,
>   					      &src_L0_ofs, &src_L0_pt, 0, 0,
>   					      avail_pts);
> -		if (copy_only_ccs) {
> +		if (flags.copy_only_ccs) {
>   			dst_L0_ofs = src_L0_ofs;
>   		} else {
>   			pte_flags = dst_is_vram ? PTE_UPDATE_FLAG_IS_VRAM : 0;
> @@ -963,7 +999,8 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
>   		}
>   
>   		/* Add copy commands size here */
> -		batch_size += ((copy_only_ccs) ? 0 : emit_copy_cmd_len(xe)) +
> +		batch_size += ((flags.copy_only_ccs || flags.defrag_ccs) ? 0 :
> +			       emit_copy_cmd_len(xe)) +
>   			((needs_ccs_emit ? EMIT_COPY_CCS_DW : 0));
>   
>   		bb = xe_bb_new(gt, batch_size, usm);
> @@ -975,13 +1012,15 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
>   		if (src_is_vram && xe_migrate_allow_identity(src_L0, &src_it))
>   			xe_res_next(&src_it, src_L0);
>   		else
> -			emit_pte(m, bb, src_L0_pt, src_is_vram, copy_system_ccs || use_comp_pat,
> +			emit_pte(m, bb, src_L0_pt, src_is_vram,
> +				 copy_system_ccs || use_comp_pat || flags.defrag_ccs,
>   				 &src_it, src_L0, src);
>   
>   		if (dst_is_vram && xe_migrate_allow_identity(src_L0, &dst_it))
>   			xe_res_next(&dst_it, src_L0);
> -		else if (!copy_only_ccs)
> -			emit_pte(m, bb, dst_L0_pt, dst_is_vram, copy_system_ccs,
> +		else if (!flags.copy_only_ccs)
> +			emit_pte(m, bb, dst_L0_pt, dst_is_vram,
> +				 copy_system_ccs || flags.defrag_ccs,
>   				 &dst_it, src_L0, dst);
>   
>   		if (copy_system_ccs)
> @@ -990,7 +1029,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
>   		bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
>   		update_idx = bb->len;
>   
> -		if (!copy_only_ccs)
> +		if (!flags.copy_only_ccs && !flags.defrag_ccs)
>   			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
>   
>   		if (needs_ccs_emit)
> @@ -1078,7 +1117,69 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
>   				  struct ttm_resource *dst,
>   				  bool copy_only_ccs)
>   {
> -	return __xe_migrate_copy(m, src_bo, dst_bo, src, dst, copy_only_ccs, false);
> +	return __xe_migrate_copy(m, src_bo, dst_bo, src, dst, NULL,
> +				 (struct xe_migrate_copy_flags) {
> +					 .copy_only_ccs = copy_only_ccs,
> +				 });
> +}
> +
> +/**
> + * xe_migrate_copy_defrag() - Migrate a BO's backing to a reallocated page set.
> + * @m: The migration context.
> + * @bo: The buffer object being defragmented. Both @src and @dst belong to @bo.
> + * @src: The source TTM resource (the old backing).
> + * @dst: The dst TTM resource (the freshly reallocated backing).
> + * @src_sg: Scatter-gather table of the source (old) backing pages.
> + * @need_ccs: Whether the BO has CCS aux state that must be migrated too.
> + *
> + * Used by the defrag path where a single BO has its backing reallocated at a
> + * more beneficial page order. The contents are relocated from the old pages
> + * (@src_sg) to the new pages (the BO's current backing) entirely on the GPU,
> + * in up to two passes:
> + *
> + *  - Data pass (always): copy the data pages verbatim. The pages are mapped
> + *    without the compression PAT, so the (possibly compressed) bytes are copied
> + *    as-is rather than being decompressed and recompressed, and no CCS aux copy
> + *    is appended.
> + *
> + *  - CCS pass (@need_ccs): copy the CCS aux (compression) state. Both the old
> + *    and new data pages are mapped with the compression PAT so the copy engine
> + *    accesses the aux state indirectly, issuing one indirect -> indirect
> + *    XY_CTRL_SURF_COPY_BLT; the data blit is skipped.
> + *
> + * The two passes are issued separately because they require opposite
> + * compression PAT settings on the data page mappings (cleared for the verbatim
> + * data copy, set for the indirect CCS access), which a single mapping cannot
> + * satisfy. Both passes run in order on the same migrate queue.
> + *
> + * Return: Pointer to a dma_fence representing the last copy batch, or an error
> + * pointer on failure.
> + */
> +struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> +					 struct xe_bo *bo,
> +					 struct ttm_resource *src,
> +					 struct ttm_resource *dst,
> +					 struct sg_table *src_sg,
> +					 bool need_ccs)
> +{
> +	struct dma_fence *fence2, *fence =
> +		__xe_migrate_copy(m, bo, bo, src, dst, src_sg,
> +				  (struct xe_migrate_copy_flags) {
> +					 .defrag_copy = true,
> +					 });
> +
> +	if (IS_ERR(fence) || !need_ccs)
> +		return fence;
> +
> +	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_sg,
> +				   (struct xe_migrate_copy_flags) {
> +				   .defrag_ccs = true,
> +				   });
> +	if (IS_ERR(fence2))
> +		dma_fence_wait(fence, false);
> +	dma_fence_put(fence);
> +
> +	return fence2;
>   }
>   
>   /**
> @@ -1096,7 +1197,10 @@ struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
>   				     struct xe_bo *bo,
>   				     struct ttm_resource *res)
>   {
> -	return __xe_migrate_copy(m, bo, bo, res, res, false, true);
> +	return __xe_migrate_copy(m, bo, bo, res, res, NULL,
> +				 (struct xe_migrate_copy_flags) {
> +					 .is_vram_resolve = true,
> +				 });
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/xe/xe_migrate.h b/drivers/gpu/drm/xe/xe_migrate.h
> index 965c45889c72..e4f996942a6d 100644
> --- a/drivers/gpu/drm/xe/xe_migrate.h
> +++ b/drivers/gpu/drm/xe/xe_migrate.h
> @@ -11,6 +11,7 @@
>   struct dma_fence;
>   struct drm_pagemap_addr;
>   struct iosys_map;
> +struct sg_table;
>   struct ttm_resource;
>   
>   struct xe_bo;
> @@ -132,6 +133,13 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
>   				  struct ttm_resource *dst,
>   				  bool copy_only_ccs);
>   
> +struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> +					 struct xe_bo *bo,
> +					 struct ttm_resource *src,
> +					 struct ttm_resource *dst,
> +					 struct sg_table *src_sg,
> +					 bool need_ccs);
> +
>   struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
>   				     struct xe_bo *bo,
>   				     struct ttm_resource *res);

