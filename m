Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B48606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHrN8xQV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4C110E768;
	Tue, 24 Nov 2026 06:32:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C4610E4BC;
 Tue, 24 Nov 2026 06:32:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6193144F3A;
 Tue, 24 Nov 2026 06:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F0C1F000D0;
 Tue, 24 Nov 2026 06:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795501956;
 bh=3adqlx3v9FkV8tbFhC5m4q+toDCeS0Uxu5ZamZZ+7X8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bHrN8xQVRiZMd9pkjpYwZHtD2LMdxbC3619KDNsDCZ+COAgxckJjLBsJy5aEptoEg
 2jpXbdTmhTkpPAkd3YF/TSawiomBwHZOmKz7tEcuXPx141/gUHa3fn1rZtAwQqsK6J
 JsSv0HvsG//EMq2by8TXLH5CIuEwj+L2Si71/yZL1i+gCuFdTXfN6455MGOwE3UP8w
 RJOf/Y1TB2BQhmo8l+2U9Lj62lzq2VL0dnxNq0FayRQ4F4LyAMVKbyJZl/xjZaEvL+
 agYesMHll6GYMvBRPcx9PxNusgyCfjLD4wtrplGCJ7Wlqj8iaDT+sCN42pDCS6X9KG
 zGYot8pNxu4xQ==
Message-ID: <sashiko-outbox-230599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC v2 03/11] drm/ttm: Add TTM_NUMA_POLICY_INTERLEAVE
To: "Himal Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124062123.2431244-16-himal.prasad.ghimiray@intel.com>
References: <20261124062123.2431244-13-himal.prasad.ghimiray@intel.com>
 <20261124062123.2431244-16-himal.prasad.ghimiray@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 06:32:35 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/ttm: broken interleave node rotation on order decrease in
  __ttm_pool_alloc()
- [Medium] drm/ttm: unconstrained order-0 fallback and reclaim in
  ttm_pool_alloc_interleave()
- [Medium] drm/ttm: cross-node pool take in
  ttm_pool_type_take_interleave() before alloc
--

commit 99e6c53830405c25271c091f8f19cad519333639
Author: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

drm/ttm: Add TTM_NUMA_POLICY_INTERLEAVE

This commit adds TTM_NUMA_POLICY_INTERLEAVE to rotate TTM page allocations
and pool lookups across the NUMA nodes in ttm_operation_ctx.numa_info.nodes.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 8976de3a552d1..210d443185644 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -373,6 +373,38 @@ static struct page *ttm_pool_type_take(struct ttm_po=
ol_type *pt, int nid)
>  	return p;
>  }
> =20
> +/* Return the node in @nodes nearest to @from, lowest node id on ties */
> +static int ttm_pool_nearest_node(int from, const nodemask_t *nodes)
> +{
> +	int n, nid =3D first_node(*nodes);
> +
> +	for_each_node_mask(n, *nodes) {
> +		if (node_distance(from, n) < node_distance(from, nid))
> +			nid =3D n;
> +	}
> +
> +	return nid;
> +}
> +
> +/* Take from @nid first, then from the other nodes nearest to @nid first=
 */
> +static struct page *ttm_pool_type_take_interleave(struct ttm_pool_type *=
pt,
> +						  int nid, const nodemask_t *nodes)
> +{
> +	nodemask_t todo =3D *nodes;
> +	struct page *p;
> +
> +	p =3D ttm_pool_type_take(pt, nid);
> +	node_clear(nid, todo);
> +	while (!p && !nodes_empty(todo)) {
> +		int n =3D ttm_pool_nearest_node(nid, &todo);
> +
> +		node_clear(n, todo);
> +		p =3D ttm_pool_type_take(pt, n);
> +	}
> +
> +	return p;
> +}

[Severity: Medium]
Does ttm_pool_type_take_interleave() take cached pool pages from other nodes
in @nodes before trying a fresh page allocation on @nid?

When @nid's pool for a write-combined or uncached order is empty,
__ttm_pool_alloc() drains pooled pages from sibling policy nodes even when
@nid has free system memory.  Because ttm_pool_free() returns freed pages to
the pool of page_to_nid(p), @nid's pool remains empty and interleaved WC/UC
allocations collapse onto whichever node already had cached pool pages.

[ ... ]

> @@ -830,6 +873,31 @@ static struct page *ttm_pool_alloc_bind(struct ttm_p=
ool *pool, gfp_t gfp_flags,
>  	return p;
>  }
> =20
> +/*
> + * Allocate pages of size 1 << order for TTM_NUMA_POLICY_INTERLEAVE. Try=
 the
> + * interleaved node @nid first, then the other nodes in @nodes nearest t=
o @nid
> + * first, as the per-node zonelist fallback of core mm does, before the =
caller
> + * lowers the order.
> + */
> +static struct page *ttm_pool_alloc_interleave(struct ttm_pool *pool,
> +					      gfp_t gfp_flags, unsigned int order,
> +					      int nid, const nodemask_t *nodes)
> +{
> +	nodemask_t todo =3D *nodes;
> +	struct page *p;
> +
> +	p =3D ttm_pool_alloc_page(pool, gfp_flags, order, nid);
> +	node_clear(nid, todo);
> +	while (!p && !nodes_empty(todo)) {
> +		int n =3D ttm_pool_nearest_node(nid, &todo);
> +
> +		node_clear(n, todo);
> +		p =3D ttm_pool_alloc_page(pool, gfp_flags, order, n);
> +	}
> +
> +	return p;
> +}

[Severity: Medium]
Does ttm_pool_alloc_interleave() fall back outside @nodes on order-0
allocations and stall in reclaim before trying other policy nodes?

ttm_pool_alloc_page() only sets __GFP_THISNODE when order > 0.  At order 0,
the first ttm_pool_alloc_page() call walks @nid's unfiltered fallback
zonelist, which can allocate from a node outside @nodes before the remaining
nodes in @todo are tried, and if all zones are exhausted the while loop
repeats system-wide direct reclaim once for each remaining node in @todo.
In addition, unlike ttm_pool_alloc_bind(), ttm_pool_alloc_interleave() does
not try a non-reclaim pass across @nodes first, so a depleted @nid enters
direct reclaim and compaction even when another node in @nodes has free
pages of that order.

[ ... ]

> @@ -893,11 +961,24 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, =
struct ttm_tt *tt,
>  	     order =3D ttm_pool_alloc_find_order(order, alloc)) {
>  		struct ttm_pool_type *pt;
> =20
> +		if (policy =3D=3D TTM_NUMA_POLICY_INTERLEAVE) {
> +			unsigned int slot =3D tt->num_pages - alloc->remaining_pages;
> +
> +			alloc_nid =3D ttm_pool_policy_nth_node(ctx->numa_info.nodes,
> +							     slot >> order);
> +			take_nid =3D alloc_nid;
> +		}

[Severity: High]
Does computing the node index as slot >> order fail to rotate across
ctx->numa_info.nodes whenever the allocation order decreases?

In __ttm_pool_alloc(), order is monotonically non-increasing, and slot is t=
he
sum of 1 << prev_order for all prior chunks.  Whenever a chunk has a smaller
order than the chunks before it, every prior chunk contributed an even
multiple of 1 << order pages to slot, so slot >> order is always even.  When
nodes_weight(*ctx->numa_info.nodes) is even, such as a 2-node mask,
(slot >> order) % nodes_weight(...) is always 0 on every decreased order.
For example, a 3 MiB buffer (orders 9 and 8) or any buffer smaller than
8 MiB whose size is not a multiple of 4 MiB places all of its chunks on the
first policy node instead of interleaving them.  Counting allocated chunks
with a separate counter that increments once per allocated page would rotate
across nodes regardless of order changes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124062123.2431=
244-13-himal.prasad.ghimiray@intel.com?part=3D3
