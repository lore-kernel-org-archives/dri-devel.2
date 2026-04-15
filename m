Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2344F43832
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189D110E6F8;
	Wed, 15 Apr 2026 15:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="gU+P/0jj";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 346EE10E6F8
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:19:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F09946FC;
 Wed, 15 Apr 2026 08:19:52 -0700 (PDT)
Received: from [10.57.61.136] (unknown [10.57.61.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D85C3F7B4;
 Wed, 15 Apr 2026 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776266397; bh=AdbTV1pG9AL9qK3gDEXNSoyju+pkuKYNWeKt1GebMSM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gU+P/0jjO3XETCfGyNWZyWKaycMpxKZtxaJpOBsN2m/piZbZs54Xe3G50lNUDaG2r
 BnpB42sB7OAYRv5iaZc0AZ+4nyd5LpOj6gJ4FwAyj+vD5Zuk4lxKZ+7jmCJ5Iz4MmJ
 XXU9MsgUT4UJky1PBKGqzKPXbWRw/xhlnuSdVd60=
Message-ID: <ec4309f7-75ff-4fb9-b4cd-2c0a9776bebd@arm.com>
Date: Wed, 15 Apr 2026 16:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] drm/panthor: Pass vm_bind_op to
 vm_prepare_map_op_ctx
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-3-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260415112900.681834-3-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
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

On 15/04/2026 12:28, Adrián Larumbe wrote:
> Instead of passing its constituent elements, pass the whole struct to
> simplify the function prototype.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

It's a little ugly the hack in panthor_vm_map_bo_range(), but I can't
immediately see a neater solution, so:

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 01577be88933..d9e2f8afb8fb 100644
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
> @@ -2849,10 +2847,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
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
> @@ -3048,10 +3043,16 @@ int panthor_vm_bind_exec_sync_op(struct drm_file *file,
>  int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_object *bo,
>  			    u64 offset, u64 size, u64 va, u32 flags)
>  {
> +	struct drm_panthor_vm_bind_op op = {
> +		.bo_offset = offset,
> +		.size = size,
> +		.va = va,
> +		.flags = flags,
> +	};
>  	struct panthor_vm_op_ctx op_ctx;
>  	int ret;
>  
> -	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, offset, size, va, flags);
> +	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, &op);
>  	if (ret)
>  		return ret;
>  

