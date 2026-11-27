Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDDF606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CeiOKUj3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E30112C12;
	Fri, 27 Nov 2026 16:20:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id EBB9B112C12
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:20:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D2C41570;
 Fri, 27 Nov 2026 08:20:44 -0800 (PST)
Received: from [10.0.129.128] (e122027.cambridge.arm.com [10.0.129.128])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E60123F632;
 Fri, 27 Nov 2026 08:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795796447; bh=YWYVJy6Zcj9T84QCaab6JYnUa5XB+sHSowf3FjvcGBM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CeiOKUj33P9EF1X+JNoBQhYtrJosCaT77qK+d0WZVUgKQm79E9K4QNYhMDqRs0pCE
 LFfyZOHUVxsM6YfM/Q/0lyxyw0INTOo7YgBb/eAATimHahf1DvcGcMsCdjJdg64GWy
 eQ6oyfgP0NxgCIK/Sh9UANOqD1az5Wfbl/zeRzxs=
Message-ID: <819cab19-0756-4ba2-806a-dbeb7c5c2474@arm.com>
Date: Fri, 27 Nov 2026 16:20:40 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Don't access gpu_contexts of a destroyed
 heap pool
To: Jiwoo Kim <arpe1618@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261113162648.110226253-1-arpe1618@gmail.com_quarantine>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261113162648.110226253-1-arpe1618@gmail.com_quarantine>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13/11/2026 16:26, Jiwoo Kim wrote:
> panthor_heap_grow() and panthor_heap_return_chunk() compute the heap
> context offset from pool->gpu_contexts before taking pool->lock.
> 
> The tiler OOM work holds references on the group, its VM and the heap
> pool when it calls these functions, but nothing stops
> panthor_vm_destroy() from destroying the pool in the meantime.
> panthor_heap_pool_destroy() frees the gpu_contexts BO under pool->lock
> and marks the pool as destroyed by clearing pool->vm, but leaves
> pool->gpu_contexts pointing to the freed BO. VM destruction doesn't
> wait for the work either: panthor_sched_prepare_for_vm_destruction()
> only flushes the scheduler tick work, and only when the VM is active,
> and evicting the group doesn't help, as group_unbind_locked() uses
> cancel_work(), which doesn't wait for a tiler OOM work that is already
> running. Such a work can then read the freed BO.
> 
> Take pool->lock before dereferencing pool->gpu_contexts, and return
> -EINVAL if the pool has been destroyed, as panthor_heap_create()
> already does.
> 
> The problem was found through AI-assisted source code review. The fix
> is compile-tested only and there is no reproducer, as I don't have
> Mali CSF hardware.

This does look plausible, and doesn't break my hardware ;) I'm not sure
how to actually test the described issue, so I haven't been able to test
that.

> Fixes: 9cca48fa4f89 ("drm/panthor: Add the heap logical block")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5

Note that the requirement to include "Assisted-by" for LLM patches was
dropped (and checkpatch now complains about these tags).

> Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> ---
> 
> Notes:
>     This conflicts trivially with Osama Abdelkader's pending "drm/panthor:
>     Fix race when retrieving the new chunk in panthor_heap_grow()", as both
>     change the local variables at the top of panthor_heap_grow(). I can
>     rebase on top of it if it lands first.
>     
>     While looking at this, I also noticed that panthor_heap_create() reads
>     pool->vm without pool->lock when allocating the initial chunks, in
>     panthor_alloc_heap_chunk(), so a concurrent VM destroy can make
>     panthor_kernel_bo_create() hit its drm_WARN_ON(!vm). That doesn't touch
>     freed memory and is left for a separate patch.
> 
>  drivers/gpu/drm/panthor/panthor_heap.c | 44 +++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
> index 99311abdf1..e55f7e648d 100644
> --- a/drivers/gpu/drm/panthor/panthor_heap.c
> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> @@ -90,7 +90,7 @@ struct panthor_heap_pool {
>  	/** @vm: VM this pool is bound to. */
>  	struct panthor_vm *vm;
>  
> -	/** @lock: Lock protecting access to @xa. */
> +	/** @lock: Lock protecting access to @xa, @vm and @gpu_contexts. */
>  	struct rw_semaphore lock;
>  
>  	/** @xa: Array storing panthor_heap objects. */
> @@ -371,16 +371,27 @@ int panthor_heap_return_chunk(struct panthor_heap_pool *pool,
>  			      u64 heap_gpu_va,
>  			      u64 chunk_gpu_va)
>  {
> -	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
> -	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
>  	struct panthor_heap_chunk *chunk, *tmp, *removed = NULL;
>  	struct panthor_heap *heap;
> +	u32 heap_id;
> +	u64 offset;
>  	int ret;
>  
> -	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
> -		return -EINVAL;
> -
>  	down_read(&pool->lock);
> +
> +	/* The heap contexts are gone if the pool has been destroyed. */
> +	if (!pool->vm) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
> +	heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
> +	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
>  	heap = xa_load(&pool->xa, heap_id);
>  	if (!heap) {
>  		ret = -EINVAL;
> @@ -435,16 +446,27 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
>  		      u32 pending_frag_count,
>  		      u64 *new_chunk_gpu_va)
>  {
> -	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
> -	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
>  	struct panthor_heap_chunk *chunk;
>  	struct panthor_heap *heap;
> +	u32 heap_id;
> +	u64 offset;
>  	int ret;
>  
> -	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
> -		return -EINVAL;
> -
>  	down_read(&pool->lock);
> +
> +	/* The heap contexts are gone if the pool has been destroyed. */
> +	if (!pool->vm) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
> +	heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
> +	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
>  	heap = xa_load(&pool->xa, heap_id);
>  	if (!heap) {
>  		ret = -EINVAL;
> 
> base-commit: bafda823590ddf7031ecb765d673572fae7ab44a

