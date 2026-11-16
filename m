Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF26C606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cy/yVrIV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2466410E9BE;
	Mon, 16 Nov 2026 13:04:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8D39610E9BE
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:04:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 046831A25
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:04:46 -0800 (PST)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 B2AE33F632
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794834288; bh=sLJkYT+jK0R1uMOruWdRoY7YCqhcUnkEqFSDjvSeAC0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cy/yVrIVgOf/oFZRjkkTBbcxCg95hc9r7V6YVVSwHaT7CgPtGwwoHveSBksn64iSZ
 9dj4KwSxNKRvGkoqIEAAezA3KRijgvMW+Cc3fZb8O587aY12gxLE3gLuzMzHEcqIhf
 kh6TuB2/xfy6hwK7k4NRrqGOeGsB5jHdZgQ0vKZY=
Date: Mon, 16 Nov 2026 13:04:36 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Akash Goel <akash.goel@arm.com>,
 Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: Fix race when retrieving the new chunk
 in panthor_heap_grow()
Message-ID: <avr_ZM6cR9jr7qxl@e142607>
References: <20261113110217.6c1513be@fedora1.home>
 <20261113204717.35195-1-osama.abdelkader@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113204717.35195-1-osama.abdelkader@gmail.com>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 09:47:16PM +0100, Osama Abdelkader wrote:
> panthor_heap_grow() allocates a new chunk with panthor_alloc_heap_chunk(),
> which adds the chunk at the head of heap->chunks under heap->lock, and
> then drops the lock. panthor_heap_grow() then assumes the head of the
> list is the chunk it just added, and reads its GPU VA through
> list_first_entry() without holding heap->lock.
> 
> panthor_heap_grow() and panthor_heap_return_chunk() only take pool->lock
> in read mode, and tiler OOM events of different groups are processed in
> parallel on the unbound heap_alloc_wq. If two groups use the same heap
> context, they can modify the chunk list concurrently:
> 
>   group A OOM work                     group B OOM work
>   alloc C_A, list_add()
>                                        alloc C_B, list_add()
>   list_first_entry() -> C_B
>                                        group scheduled out:
>                                        panthor_heap_return_chunk(C_B)
>                                          list_del(), destroy BO, kfree()
>   C_B->bo                              <- use-after-free
> 
> Even without the free, both groups end up being handed the same chunk,
> and the chunk allocated by group A is never linked to the heap context.
> 
> Fix this by having panthor_alloc_heap_chunk() return the GPU VA of the
> chunk it allocated, retrieved before the chunk is published in the list,
> instead of looking it up afterwards. Do the same for the initial chunks
> allocated by panthor_heap_create(), so the first chunk GPU VA is
> returned by panthor_alloc_heap_chunks() rather than retrieved from the
> list.
> 
> Fixes: 9cca48fa4f89 ("drm/panthor: Add the heap logical block")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5.5
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> v2:
> - Always write chunk_gpu_va in panthor_alloc_heap_chunk().
> - Have panthor_alloc_heap_chunks() return the first chunk GPU VA, and drop
>   the list_first_entry() lookup in panthor_heap_create().
> 
>  drivers/gpu/drm/panthor/panthor_heap.c | 39 +++++++++++++++-----------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
> index 99311abdf1e9..febc18b43af8 100644
> --- a/drivers/gpu/drm/panthor/panthor_heap.c
> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> @@ -139,7 +139,8 @@ static void panthor_free_heap_chunk(struct panthor_heap_pool *pool,
>  
>  static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
>  				    struct panthor_heap *heap,
> -				    bool initial_chunk)
> +				    bool initial_chunk,
> +				    u64 *chunk_gpu_va)
>  {
>  	struct panthor_heap_chunk *chunk;
>  	struct panthor_heap_chunk_header *hdr;
> @@ -181,6 +182,14 @@ static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
>  
>  	panthor_kernel_bo_vunmap(chunk->bo);
>  
> +	/*
> +	 * Retrieve the GPU VA before the chunk becomes visible in the heap
> +	 * chunk list: once heap->lock is released, a concurrent grow or
> +	 * return_chunk on the same heap can modify the list, and the chunk
> +	 * can be freed.
> +	 */
> +	*chunk_gpu_va = panthor_kernel_bo_gpuva(chunk->bo);
> +
>  	mutex_lock(&heap->lock);
>  	list_add(&chunk->node, &heap->chunks);
>  	heap->chunk_count++;
> @@ -210,13 +219,19 @@ static void panthor_free_heap_chunks(struct panthor_heap_pool *pool,
>  
>  static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,
>  				     struct panthor_heap *heap,
> -				     u32 chunk_count)
> +				     u32 chunk_count,
> +				     u64 *first_chunk_gpu_va)
>  {
>  	int ret;
>  	u32 i;
>  
> +	/*
> +	 * Chunks are inserted at the head of the list, so the last chunk
> +	 * allocated is the first chunk of the heap.
> +	 */
>  	for (i = 0; i < chunk_count; i++) {
> -		ret = panthor_alloc_heap_chunk(pool, heap, true);
> +		ret = panthor_alloc_heap_chunk(pool, heap, true,
> +					       first_chunk_gpu_va);
>  		if (ret)
>  			return ret;
>  	}
> @@ -280,7 +295,6 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
>  			u64 *first_chunk_gpu_va)
>  {
>  	struct panthor_heap *heap;
> -	struct panthor_heap_chunk *first_chunk;
>  	struct panthor_vm *vm;
>  	int ret = 0;
>  	u32 id;
> @@ -315,15 +329,11 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
>  	heap->max_chunks = max_chunks;
>  	heap->target_in_flight = target_in_flight;
>  
> -	ret = panthor_alloc_heap_chunks(pool, heap, initial_chunk_count);
> +	ret = panthor_alloc_heap_chunks(pool, heap, initial_chunk_count,
> +					first_chunk_gpu_va);
>  	if (ret)
>  		goto err_free_heap;
>  
> -	first_chunk = list_first_entry(&heap->chunks,
> -				       struct panthor_heap_chunk,
> -				       node);
> -	*first_chunk_gpu_va = panthor_kernel_bo_gpuva(first_chunk->bo);
> -
>  	down_write(&pool->lock);
>  	/* The pool has been destroyed, we can't create a new heap. */
>  	if (!pool->vm) {
> @@ -437,8 +447,8 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
>  {
>  	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
>  	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
> -	struct panthor_heap_chunk *chunk;
>  	struct panthor_heap *heap;
> +	u64 chunk_gpu_va;
>  	int ret;
>  
>  	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
> @@ -473,14 +483,11 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
>  	 * further jobs in this queue fail immediately instead of having to
>  	 * wait for the job timeout.
>  	 */
> -	ret = panthor_alloc_heap_chunk(pool, heap, false);
> +	ret = panthor_alloc_heap_chunk(pool, heap, false, &chunk_gpu_va);
>  	if (ret)
>  		goto out_unlock;
>  
> -	chunk = list_first_entry(&heap->chunks,
> -				 struct panthor_heap_chunk,
> -				 node);
> -	*new_chunk_gpu_va = (panthor_kernel_bo_gpuva(chunk->bo) & GENMASK_ULL(63, 12)) |
> +	*new_chunk_gpu_va = (chunk_gpu_va & GENMASK_ULL(63, 12)) |
>  			    (heap->chunk_size >> 12);
>  	ret = 0;
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
