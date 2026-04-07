Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E1FEDB7F2
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE8F10E3CB;
	Tue,  7 Apr 2026 10:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="uQk+oE8E";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id BCEC310E3CB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 10:44:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9170A1688
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 03:44:26 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 198413F641
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 03:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775558672; bh=VBs8ChKDSp5MwFOx2pPHR2HElbB6h+20jtXC41viTQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uQk+oE8ED8gCCliY7vseTpI07TI82+axy2/uEWc3UNqvybV2Fd6lvA7wOUS6YvjP2
 cqUMgvEjfB1NcZRfmv0sr3VMNgAfTY96o1StFYSvNl2CKrsvKupYF9tuU5f+uCcQU9
 ldAjJ/cKkVWplkBOhn7VeMJP6yw5WbPxq+FPBaew=
Date: Tue, 7 Apr 2026 11:44:29 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v6 2/4] drm/panthor: Pass vm_bind_op to
 vm_prepare_map_op_ctx
Message-ID: <adTgDZyg3oJU4cHm@e142607>
References: <20260403192743.3572062-1-adrian.larumbe@collabora.com>
 <20260403192743.3572062-3-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260403192743.3572062-3-adrian.larumbe@collabora.com>
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

On Fri, Apr 03, 2026 at 08:27:27PM +0100, Adrián Larumbe wrote:
> Instead of passing its constituent elements, pass the whole struct to
> simplify the function prototype.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 29 +++++++++++++++------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 880c8c4cca17..10da2f021d9d 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1275,9 +1275,7 @@ static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
>  static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  					 struct panthor_vm *vm,
>  					 struct panthor_gem_object *bo,
> -					 u64 offset,
> -					 u64 size, u64 va,
> -					 u32 flags)
> +					 const struct drm_panthor_vm_bind_op *op)
>  {
>  	struct drm_gpuvm_bo *preallocated_vm_bo;
>  	struct sg_table *sgt = NULL;
> @@ -1286,12 +1284,12 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	if (!bo)
>  		return -EINVAL;
>  
> -	if ((flags & ~PANTHOR_VM_BIND_OP_MAP_FLAGS) ||
> -	    (flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
> +	if ((op->flags & ~PANTHOR_VM_BIND_OP_MAP_FLAGS) ||
> +	    (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
>  		return -EINVAL;
>  
>  	/* Make sure the VA and size are in-bounds. */
> -	if (size > bo->base.size || offset > bo->base.size - size)
> +	if (op->size > bo->base.size || op->bo_offset > bo->base.size - op->size)
>  		return -EINVAL;
>  
>  	/* If the BO has an exclusive VM attached, it can't be mapped to other VMs. */
> @@ -1299,7 +1297,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	    bo->exclusive_vm_root_gem != panthor_vm_root_gem(vm))
>  		return -EINVAL;
>  
> -	panthor_vm_init_op_ctx(op_ctx, size, va, flags);
> +	panthor_vm_init_op_ctx(op_ctx, op->size, op->va, op->flags);
>  
>  	ret = panthor_vm_op_ctx_prealloc_vmas(op_ctx);
>  	if (ret)
> @@ -1328,7 +1326,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	}
>  
>  	op_ctx->map.vm_bo = drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
> -	op_ctx->map.bo_offset = offset;
> +	op_ctx->map.bo_offset = op->bo_offset;
>  
>  	ret = panthor_vm_op_ctx_prealloc_pts(op_ctx);
>  	if (ret)
> @@ -2843,10 +2841,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
>  		gem = drm_gem_object_lookup(file, op->bo_handle);
>  		ret = panthor_vm_prepare_map_op_ctx(op_ctx, vm,
>  						    gem ? to_panthor_bo(gem) : NULL,
> -						    op->bo_offset,
> -						    op->size,
> -						    op->va,
> -						    op->flags);
> +						    op);
>  		drm_gem_object_put(gem);
>  		return ret;
>  
> @@ -3042,10 +3037,18 @@ int panthor_vm_bind_exec_sync_op(struct drm_file *file,
>  int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_object *bo,
>  			    u64 offset, u64 size, u64 va, u32 flags)
>  {
> +	struct drm_panthor_vm_bind_op op = {0};
>  	struct panthor_vm_op_ctx op_ctx;
>  	int ret;
>  
> -	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, offset, size, va, flags);
> +	op = (struct drm_panthor_vm_bind_op){
> +		.bo_offset = offset,
> +		.size = size,
> +		.va = va,
> +		.flags = flags,
> +	};

You can merge the assignment with the declaration, at least GCC is OK with it.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> +
> +	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, &op);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.53.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
