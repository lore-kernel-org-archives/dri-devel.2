Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8CEC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FCF310E033;
	Tue, 21 Jul 2026 07:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EGAUK/BQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFE010E033
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:17:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4241660A92;
 Tue, 21 Jul 2026 07:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBE41F000E9;
 Tue, 21 Jul 2026 07:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784618274;
 bh=WXvbCde+8EP/jwspcQ1jgB8S+be0mtvvnkjMY82g7q4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EGAUK/BQq+O0D2uHqofYOXa8h3o0oK7049q5r9R0uhNTxnUZdYxWsH9c0vUhXRinW
 tvtu6wc7MUV3fLEGoOwIGlyg+Q0L/UG340x4vTaqpQcWRNaSgZZY3f67rCGR1KnJPD
 aYikX+niasYTKuc3n1pHHKO+rGJZbjWt1KP7h6OXL1IO+2lz/lcOV95q1MsDVfz7tV
 OcFd14AuDydZm9oXaA9gKsCrGGimsE4QUYfkxPVJmDD5sOg6JTn0hArvYUia2ebCGO
 ZwxnsJpI46i1SgZAB7mbCdsEr2o8aNnJB/jMae/HJBIsAjB5jmrbefeDl+JeeMQVsE
 tBJ5bD9TK2Qgw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 02/13] net: devmem: extend memory provider
 for knod
To: "Taehee Yoo" <ap420073@gmail.com>
Cc: dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20260719175857.4071636-3-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-3-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:17:53 +0000
Message-Id: <20260721071753.ABBE41F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The patch silently increases PP_ALLOC_CACHE_REFILL from 64 to up t=
o 4096 (for 4K pages), severely bloating struct page_pool and causing order=
-5 page allocation failures.
- [High] Ignored error return value of page_pool_set_dma_addr_netmem can le=
ad to silent DMA address truncation and memory corruption on 32-bit archite=
ctures with 64-bit DMA.
- [Medium] The is_kernel_rodata check in page_pool_init prevents loadable d=
river modules from utilizing the new PP_FLAG_CUSTOM_MEMORY_PROVIDER feature.
--

--- Patch [2]: [RFC PATCH net-next 02/13] net: devmem: extend memory provid=
er for knod ---
commit 685f164a3b04db75b3dba6257fd2806218155a24
Author: Taehee Yoo <ap420073@gmail.com>

net: devmem: extend memory provider for knod

This commit extends the devmem memory-provider path so a knod accelerator
can back a NIC page_pool with accelerator-exported memory. This lets the
NIC DMA received packets directly into accelerator memory.

> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 03da138722f58..3e866f249768e 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
[ ... ]
> @@ -54,11 +62,11 @@
>   * would have to take a slower code path.
>   */
>  #if PAGE_SIZE >=3D SZ_64K
> -#define PP_ALLOC_CACHE_REFILL	4
> +#define PP_ALLOC_CACHE_REFILL	256
>  #elif PAGE_SIZE >=3D SZ_16K
> -#define PP_ALLOC_CACHE_REFILL	16
> +#define PP_ALLOC_CACHE_REFILL	1024
>  #else
> -#define PP_ALLOC_CACHE_REFILL	64
> +#define PP_ALLOC_CACHE_REFILL	4096
>  #endif

[Severity: High]
Will this increase to PP_ALLOC_CACHE_REFILL cause page_pool_create() to
fail unpredictably under memory fragmentation?

Since PP_ALLOC_CACHE_SIZE is defined as PP_ALLOC_CACHE_REFILL * 2, the
inline cache array inside struct page_pool grows to 8,192 entries for 4K
pages. At 8 bytes per pointer, this array alone consumes ~65.5KB.

This forces an order-5 kzalloc_node allocation for the page_pool struct,
which is highly prone to failure under fragmentation and drastically bloats
the memory footprint per RX queue.

[ ... ]
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 21dc4a9c8714d..fd7444943b9f5 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -272,7 +272,17 @@ static int page_pool_init(struct page_pool *pool,
> =20
>  	xa_init_flags(&pool->dma_mapped, XA_FLAGS_ALLOC1);
> =20
> -	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
> +	if (pool->slow.flags & PP_FLAG_CUSTOM_MEMORY_PROVIDER) {
> +		/* Driver-managed pool with a directly-supplied memory
> +		 * provider, not bound to a netdev rx queue.
> +		 */
> +		if (WARN_ON(!pool->slow.mp_ops || !pool->slow.mp_priv)) {
> +			err =3D -EINVAL;
> +			goto free_ptr_ring;
> +		}
> +		pool->mp_priv =3D pool->slow.mp_priv;
> +		pool->mp_ops =3D pool->slow.mp_ops;

[Severity: Medium]
Will this new flag work for loadable driver modules?

When PP_FLAG_CUSTOM_MEMORY_PROVIDER is used, pool->mp_ops is populated here.
Later in page_pool_init(), there is a preexisting check:

    if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops))) {
        err =3D -EFAULT;
        goto free_ptr_ring;
    }

Because is_kernel_rodata() only checks against the core kernel's
__start_rodata and __end_rodata boundaries, any memory provider ops struct
allocated in a loadable module's .rodata section will fail this check.
This renders the new feature unusable for modular drivers.

> +	} else if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
>  		netdev_assert_locked(pool->slow.netdev);
>  		rxq =3D __netif_get_rx_queue(pool->slow.netdev,
>  					   pool->slow.queue_idx);
[ ... ]
> @@ -725,6 +735,16 @@ void page_pool_clear_pp_info(netmem_ref netmem)
>  	netmem_set_pp(netmem, NULL);
>  }
> =20
> +void page_pool_provider_set_netmem(struct page_pool *pool, netmem_ref ne=
tmem,
> +				   dma_addr_t addr)
> +{
> +	netmem_to_nmdesc(netmem)->pp_magic =3D 0;
> +	netmem_to_nmdesc(netmem)->pp =3D NULL;
> +	atomic_long_set(&netmem_to_nmdesc(netmem)->pp_ref_count, 0);
> +	page_pool_set_pp_info(pool, netmem);
> +	page_pool_set_dma_addr_netmem(netmem, addr);

[Severity: High]
Does this silently ignore DMA address truncation?

page_pool_set_dma_addr_netmem() returns a boolean indicating whether the
DMA address exceeded the capacity of the storage representation (such as
on 32-bit architectures with 64-bit DMA support).

Because page_pool_provider_set_netmem() returns void and discards this
boolean, memory providers will be unaware if their DMA address was
truncated. This could lead to silent data corruption or IOMMU faults
when the hardware uses the truncated address.

> +}
> +
>  static __always_inline void __page_pool_release_netmem_dma(struct page_p=
ool *pool,
>  							   netmem_ref netmem)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719175857.4071=
636-1-ap420073@gmail.com?part=3D2
