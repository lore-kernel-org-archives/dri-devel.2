Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDCDCA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377A410E272;
	Mon,  5 Oct 2026 11:04:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pZIpAmPs";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 06AC810E272
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 11:04:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32B69152B;
 Mon,  5 Oct 2026 04:04:31 -0700 (PDT)
Received: from [10.57.78.53] (unknown [10.57.78.53])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C3E03FA7A;
 Mon,  5 Oct 2026 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791198274; bh=cLnVbSzXmcf7qdo5sG4C7PT6pFLAkJEH/Z2HJd1r/QA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pZIpAmPssATGP/Dwrj5TIgau4OLpuEGhl6Q1wxJvb6AFh3UcaztvqOe1D865Gx/+C
 7j0F/eV/WHBfzRzxM8n08FjK/CChgv0j3Aop9BKziMgONjzMqsdKCoJCZlLt78gmcG
 o8mwtG5OMYAhXlVSyaMu2zeQiNyIxsaQkMIg5buw=
Message-ID: <cf996cfc-dbd4-458f-a656-d85e9014d6c5@arm.com>
Date: Mon, 5 Oct 2026 12:03:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] drm/panthor: Remove redundant
 panthor_fix_sparse_map_offset() call
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Akash Goel <akash.goel@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260924-panthor-fix-partial-unmap-v2-0-59a68a1f9e14@collabora.com>
 <20260924-panthor-fix-partial-unmap-v2-5-59a68a1f9e14@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260924-panthor-fix-partial-unmap-v2-5-59a68a1f9e14@collabora.com>
Content-Type: text/plain; charset=UTF-8
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

On 24/09/2026 12:04, Boris Brezillon wrote:
> op->remap.next->gem.offset is adjusted twice in
> panthor_gpuva_sm_step_remap() (once on the remap.next object, and once on
> the local map_op). Let's do it only once, and move this adjusment closer
> to the place it matters.
> 
> Reported-by: Akash Goel <akash.goel@arm.com>
> Closes: https://lore.kernel.org/dri-devel/b85679e3-5ca2-4d36-8675-2b968d97cb5b@arm.com/
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 01564d250adf..d8fb29ace5c4 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2397,11 +2397,6 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
>  
>  	drm_gpuva_op_remap_to_unmap_range(&op->remap, &unmap_start, &unmap_range);
>  
> -	/* op->remap.prev's BO offset is always the same as the unmap va's, but
> -	 * that of op->remap.next must be adjusted so as to remain < SZ_2M
> -	 */
> -	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
> -
>  	if (!unmap_vma->evicted) {
>  		/*
>  		 * ARM IOMMU page table management code disallows partial unmaps of huge pages,
> @@ -2447,6 +2442,12 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
>  		u64 addr = op->remap.next->va.addr;
>  		u64 size = unmap_start + unmap_range - op->remap.next->va.addr;
>  
> +		/* op->remap.prev's BO offset is always the same as the unmap
> +		 * va's, but that of op->remap.next must be adjusted so as to
> +		 * remain < SZ_2M
> +		 */
> +		panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
> +
>  		if (!unmap_vma->evicted && size > 0) {
>  			struct drm_gpuva_op_map map_op = {
>  				.va.addr = addr,
> @@ -2454,7 +2455,6 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
>  				.gem.obj = op->remap.next->gem.obj,
>  				.gem.offset = op->remap.next->gem.offset,
>  			};
> -			panthor_fix_sparse_map_offset(&map_op, unmap_vma->flags);
>  
>  			ret = panthor_vm_exec_map_op(vm, unmap_vma->flags, &map_op);
>  			if (ret)
> 

