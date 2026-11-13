Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F567606A333
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=jZic3ilP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C5A10E3F5;
	Fri, 13 Nov 2026 10:02:28 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 575E510E3F5
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794564140;
 bh=X1jLNoDnjVgubMenvrcefOxSRaNk8escCylD62v2PbU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jZic3ilPtAE7ff/SF1XrbewKiLagOOuvHNJs+2SHa7/LBcokuCDwPex7rbv6pXr8d
 gk356trxUyyGPqFPgbvIpc0Qj2x0k1A2wEcIPt94Cbeztmriquyvmcsp/Yfqeb5qsQ
 KJAYRNTvDkXwLLBxpSuZUyraF+qKwXRfxeTgIqJXhckEIt7/h4nnyRFIFCoFtIs1Qj
 mko06yp2b7iRT1IjEo2AwxDEkdrABhFM5NcVh0ykjSF/sRk1dNBSg/WpYSKndxvVRX
 inaIxEMRt/yRHhm4nTmexgPjjvqoxu4wohGFyb5HiICNLIZ8uB01UmQ5M0Q8archyW
 T/47QOroubjzw==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5113417E09C6;
 Fri, 13 Nov 2026 11:02:20 +0100 (CET)
Date: Fri, 13 Nov 2026 11:02:17 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>, Chris Diamand
 <chris.diamand@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix race when retrieving the new chunk in
 panthor_heap_grow()
Message-ID: <20261113110217.6c1513be@fedora1.home>
In-Reply-To: <20261112191650.735850-1-osama.abdelkader@gmail.com>
References: <20261112191650.735850-1-osama.abdelkader@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Osama,

On Thu, 12 Nov 2026 20:16:50 +0100
Osama Abdelkader <osama.abdelkader@gmail.com> wrote:

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
> instead of looking it up afterwards.
> 
> Fixes: 9cca48fa4f89 ("drm/panthor: Add the heap logical block")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5.5
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_heap.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
> index 99311abdf1e9..d80f514366fd 100644
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
> @@ -181,6 +182,15 @@ static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
>  
>  	panthor_kernel_bo_vunmap(chunk->bo);
>  
> +	/*
> +	 * Retrieve the GPU VA before the chunk becomes visible in the heap
> +	 * chunk list: once heap->lock is released, a concurrent grow or
> +	 * return_chunk on the same heap can modify the list, and the chunk
> +	 * can be freed.
> +	 */
> +	if (chunk_gpu_va)
> +		*chunk_gpu_va = panthor_kernel_bo_gpuva(chunk->bo);

Let's make this unconditional and force the user to pass a non-NULL
chunk_gpu_va.

> +
>  	mutex_lock(&heap->lock);
>  	list_add(&chunk->node, &heap->chunks);
>  	heap->chunk_count++;
> @@ -216,7 +226,7 @@ static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,

Let's have panthor_alloc_heap_chunks() retrieve the first chunk GPU VA
to simplify panthor_heap_create(). The first_chunk_gpu_va pointer can
be passed directly to panthor_alloc_heap_chunk().

The rest looks good to me.

Thanks,

Boris
