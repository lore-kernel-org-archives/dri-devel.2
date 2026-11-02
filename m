Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA0606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lkr6fBn4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A2410E601;
	Mon,  2 Nov 2026 10:26:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE51710E601;
 Mon,  2 Nov 2026 10:26:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 958354185C;
 Mon,  2 Nov 2026 10:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548601F000C1;
 Mon,  2 Nov 2026 10:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793615205;
 bh=2OkqBJl8JrkAYyh4foCSjtW4ZLZJdOpb+UU4zlTWHKc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Lkr6fBn4uDGCtmqXeFrf/e+76MkqbSXtrzHxmhaf4nMwc/2NraPSXnJ1JCQFpJF2R
 RDqz0eI/1F6Pb4WvNF+EB1jjNXZs9C44W+z/pWmOtpE1ZVH7GkrJPlgZeONjWS57Gy
 7g8aKkM8oNP8Vqs8hUqr5nk//aFX2oCS2BrzhpHlOLxRZOB8YBfXeWbbjSBCROSLpD
 WBzDqTqLWFkYaY/kQ/tZIZtXHsRRqXY9oZiDw7MSI7w43oCRfUZO7jh3/ty+JV50my
 YaxGQQlToWqnBWnTgqVPwkMohobFkEa37OQHfVj53Zl8NabWvJNPimPlfmp+6iUNNg
 ltiT0yAAZtEEg==
Message-ID: <sashiko-outbox-193254@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC 1/7] drm/ttm/pool: Add ttm_pool_alloc_node() for
 caller-selected NUMA node
To: "Himal Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261102101803.455921-10-himal.prasad.ghimiray@intel.com>
References: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
 <20261102101803.455921-10-himal.prasad.ghimiray@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 10:26:44 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/ttm: high-order alloc failure on memoryless nodes in ttm_poo=
l_nid()
- [Low] drm/ttm: code duplication and doc mismatch in ttm_pool_alloc_node()
--

commit 7c445098356d9efa9b5af93394f82d04655f28ad
Author: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

drm/ttm/pool: Add ttm_pool_alloc_node() for caller-selected NUMA node

This commit adds ttm_pool_alloc_node() to allow callers to specify a NUMA
node when allocating backing pages for a ttm_tt object, while rejecting
explicit NUMA node requests on pools that use dma_alloc_attrs().

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 1bf37023fed66..54d2f6b5c229c 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -158,9 +158,9 @@ static int ttm_pool_nid(struct ttm_pool *pool)
>  	return nid;
>  }
> =20
> -/* Allocate pages of size 1 << order with the given gfp_flags */
> +/* Allocate pages of size 1 << order with the given gfp_flags on node @n=
id */
>  static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp=
_flags,
> -					unsigned int order)
> +					unsigned int order, int nid)
>  {
>  	const unsigned int beneficial_order =3D ttm_pool_beneficial_order(pool);
>  	unsigned long attr =3D DMA_ATTR_FORCE_CONTIGUOUS;
> @@ -189,7 +189,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_po=
ol *pool, gfp_t gfp_flags,
>  	}
> =20
>  	if (!ttm_pool_uses_dma_alloc(pool)) {
> -		p =3D alloc_pages_node(pool->nid, gfp_flags, order);
> +		p =3D alloc_pages_node(nid, gfp_flags, order);

[Severity: Medium]
Can resolving NUMA_NO_NODE via ttm_pool_nid() before calling
alloc_pages_node() cause higher-order allocations to fail on memoryless CPU
NUMA nodes (CONFIG_HAVE_MEMORYLESS_NODES)?

Previously, ttm_pool_alloc_page() passed pool->nid directly to
alloc_pages_node(). When pool->nid was NUMA_NO_NODE,
alloc_pages_node_noprof() translated NUMA_NO_NODE to numa_mem_id() (the
nearest NUMA node with memory).

With this change, ttm_pool_alloc(), ttm_pool_alloc_node() (when nid is
NUMA_NO_NODE), and ttm_pool_restore_and_alloc() resolve nid up front via
ttm_pool_nid():

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_nid() {
	int nid =3D NUMA_NO_NODE;
	if (pool)
		nid =3D pool->nid;
	if (nid =3D=3D NUMA_NO_NODE)
		nid =3D numa_node_id();
	return nid;
}

In ttm_pool_alloc_page(), allocations with order > 0 set __GFP_THISNODE in
gfp_flags:

	if (order)
		gfp_flags |=3D __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
			__GFP_THISNODE;

Because alloc_pages_node() now receives numa_node_id() instead of
NUMA_NO_NODE, it no longer substitutes numa_mem_id(). When running on a CPU
attached to a memoryless NUMA node, ZONELIST_NOFALLBACK has no memory zones,
causing all order > 0 allocations to fail and fall back to order 0.

In addition, any order-0 WC/UC pages allocated via fallback will reside on a
memory-bearing node (page_to_nid(p) !=3D numa_node_id()), so
ttm_pool_type_give() places them on page_to_nid(p)'s list_lru while
ttm_pool_type_take(pt, nid) searches the empty list_lru of the memoryless
numa_node_id().

Should ttm_pool_nid() use numa_mem_id() instead of numa_node_id() when nid =
is
NUMA_NO_NODE?

[ ... ]

> @@ -900,10 +901,52 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct tt=
m_tt *tt,
> =20
>  	ttm_pool_alloc_state_init(tt, &alloc);
> =20
> -	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
> +	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL, ttm_pool_nid(pool)=
);
>  }
>  EXPORT_SYMBOL(ttm_pool_alloc);
> =20
> +/**
> + * ttm_pool_alloc_node - Fill a ttm_tt object, placing pages on a given =
node
> + *
> + * @pool: ttm_pool to use
> + * @tt: ttm_tt object to fill
> + * @ctx: operation context
> + * @nid: NUMA node id to allocate the backing system pages from, or
> + * NUMA_NO_NODE to use the pool's default node (@ttm_pool.nid)
> + *
> + * Like ttm_pool_alloc(), but allows the caller to override the NUMA nod=
e the
> + * backing system pages are allocated from. This only affects the
> + * non-coherent (non dma-alloc) allocation path; coherent/dma pools cont=
inue
> + * to use the device-local node. Intended for drivers that expose a
> + * user-selectable host memory NUMA placement.
> + *
> + * Returns: 0 on success, -EOPNOTSUPP if @nid is specified on a coherent=
/dma
> + * pool, negative error code otherwise.
> + */
> +int ttm_pool_alloc_node(struct ttm_pool *pool, struct ttm_tt *tt,
> +			struct ttm_operation_ctx *ctx, int nid)
> +{
> +	struct ttm_pool_alloc_state alloc;
> +
> +	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> +		return -EINVAL;
> +
> +	/*
> +	 * Coherent/dma pools allocate via dma_alloc_attrs(), which places pages
> +	 * per device DMA constraints and cannot honor a caller-requested node.
> +	 */
> +	if (nid !=3D NUMA_NO_NODE && ttm_pool_uses_dma_alloc(pool))
> +		return -EOPNOTSUPP;
> +
> +	if (nid =3D=3D NUMA_NO_NODE)
> +		nid =3D ttm_pool_nid(pool);
> +
> +	ttm_pool_alloc_state_init(tt, &alloc);
> +
> +	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL, nid);
> +}
> +EXPORT_SYMBOL(ttm_pool_alloc_node);

[Severity: Low]
This isn't a bug, but there are a couple of inconsistencies between the
documentation, the commit message, and the implementation here.

First, the kernel-doc description for ttm_pool_alloc_node() states that
"coherent/dma pools continue to use the device-local node", which contradic=
ts
both the Returns section ("-EOPNOTSUPP if @nid is specified on a coherent/d=
ma
pool") and the implementation when nid !=3D NUMA_NO_NODE.

Second, the commit message mentions that "ttm_pool_alloc() passes
NUMA_NO_NODE, keeping current behaviour" and that "__ttm_pool_alloc(),
ttm_pool_alloc_page(), ttm_pool_type_take() already take a nid", whereas th=
is
patch adds the nid parameter to __ttm_pool_alloc() and ttm_pool_alloc_page(=
),
and ttm_pool_alloc() duplicates the setup and calls __ttm_pool_alloc()
directly.

Could ttm_pool_alloc() simply call ttm_pool_alloc_node(pool, tt, ctx,
NUMA_NO_NODE), and the kernel-doc and commit message be updated to match?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102101803.4559=
21-9-himal.prasad.ghimiray@intel.com?part=3D1
