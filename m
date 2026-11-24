Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7A606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDcykiAB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8825110E6F6;
	Tue, 24 Nov 2026 06:29:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EBDA10E110;
 Tue, 24 Nov 2026 06:29:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 35D4243F3E;
 Tue, 24 Nov 2026 06:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503221F000CA;
 Tue, 24 Nov 2026 06:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795501751;
 bh=t0ieiTumL+Z3OIf/RxHy8CryWSv7AOYH9xutAxDF7Yw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fDcykiAB8HezdsfL5xHxhwjecABzgACfTlV30x5VVRPGs8D4cZlET2aBgN+N/4g86
 qkzqypDhQVjpHkCybAWxD3XndcHufN51hof/xrkqe6E7P7hWNwDBR23m97OIbz6CjZ
 38Y2Z4lgjiQvU3VNTji3OTZMT/oPbQeWwQKRZ3nYQc/HBCDEXQN+btfhNL14Qx9X8A
 6yvO9LjeAtcLwqcMYbBX01D4DDfUSR9Fv+KHSqhbddD3uozu3Y51JnXmIiBUrAsbXA
 +IijOzJYfsnQXLgViCBPr5gluD7OkewojtD1iSBPmRcdGyCYYrkJNwVhDI9DqBd9n3
 oHnhxfshlK6AQ==
Message-ID: <sashiko-outbox-230596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC v2 02/11] drm/ttm: Add TTM_NUMA_POLICY_BIND
To: "Himal Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124062123.2431244-15-himal.prasad.ghimiray@intel.com>
References: <20261124062123.2431244-13-himal.prasad.ghimiray@intel.com>
 <20261124062123.2431244-15-himal.prasad.ghimiray@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 06:29:10 +0000
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
- [High] drm/ttm: __ttm_pool_alloc() only checks first_node() in pool
  for BIND policy
- [Medium] drm/ttm: ttm_pool_alloc_bind_pass() omits __GFP_NOWARN on
  non-final nodes
- [Low] drm/ttm: inaccurate node order in TTM_NUMA_POLICY_BIND
  kernel-doc comment
--

commit a807e823bf27ab4c849adb0b91f8553524818abe
Author: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

drm/ttm: Add TTM_NUMA_POLICY_BIND

This commit adds TTM_NUMA_POLICY_BIND to enum ttm_numa_policy to restrict
system page allocations to the nodes in ttm_operation_ctx.numa_info.nodes,
trying them in nearest-first order from the pool's local node.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index e9e6ee266c2ff..8976de3a552d1 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -780,6 +780,56 @@ static unsigned int ttm_pool_alloc_find_order(unsign=
ed int highest,
>  	return min_t(unsigned int, highest, __fls(alloc->remaining_pages));
>  }
> =20
> +/*
> + * Try the nodes in @nodes once each, nearest first from the local node.
> + * __GFP_THISNODE prevents fallback to nodes outside the policy.
> + */
> +static struct page *ttm_pool_alloc_bind_pass(struct ttm_pool *pool,
> +					     gfp_t gfp_flags, unsigned int order,
> +					     const nodemask_t *nodes)
> +{
> +	int local =3D ttm_pool_nid(pool);
> +	nodemask_t todo =3D *nodes;
> +	struct page *p =3D NULL;
> +
> +	while (!nodes_empty(todo)) {
> +		int nid =3D first_node(todo), n;
> +
> +		for_each_node_mask(n, todo) {
> +			if (node_distance(local, n) < node_distance(local, nid))
> +				nid =3D n;
> +		}
> +		node_clear(nid, todo);
> +
> +		p =3D ttm_pool_alloc_page(pool, gfp_flags | __GFP_THISNODE, order,
> +					nid);
> +		if (p)
> +			break;
> +	}
> +
> +	return p;
> +}

[Severity: Medium]
Can ttm_pool_alloc_bind_pass() emit a spurious warn_alloc() splat when
direct reclaim fails on an earlier node in todo even though a later node in
the bind mask succeeds?

In the second pass of ttm_pool_alloc_bind(), gfp_flags lacks __GFP_NOWARN
for order-0 allocations when !ctx->gfp_retry_mayfail, and
ttm_pool_alloc_page() only adds __GFP_NOWARN when order !=3D 0.  Passing
__GFP_NOWARN while !nodes_empty(todo) would avoid warning before all bound
nodes have been tried.

[ ... ]

> @@ -858,8 +908,12 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, s=
truct ttm_tt *tt,
>  		if (!p) {
>  			page_caching =3D ttm_cached;
>  			allow_pools =3D false;
> -			p =3D ttm_pool_alloc_page(pool, gfp_flags, order,
> -						alloc_nid);
> +			if (policy =3D=3D TTM_NUMA_POLICY_BIND)
> +				p =3D ttm_pool_alloc_bind(pool, gfp_flags, order,
> +							ctx->numa_info.nodes);
> +			else
> +				p =3D ttm_pool_alloc_page(pool, gfp_flags, order,
> +							alloc_nid);
>  		}
>  		/* If that fails, lower the order if possible and retry. */
>  		if (!p) {

[Severity: High]
Does the TTM pool lookup above this fallback only check
first_node(*ctx->numa_info.nodes) for TTM_NUMA_POLICY_BIND instead of
trying the bound nodes in nearest-first order?

drivers/gpu/drm/ttm/ttm_pool.c:__ttm_pool_alloc() {
	...
	if (policy !=3D TTM_NUMA_POLICY_NONE) {
		/* Start at the single node of the policy */
		alloc_nid =3D first_node(*ctx->numa_info.nodes);
		take_nid =3D alloc_nid;
	}
	...
		pt =3D ttm_pool_select_type(pool, page_caching, order);
		if (pt && allow_pools)
			p =3D ttm_pool_type_take(pt, take_nid);
	...
}

For ttm_write_combined or ttm_uncached allocations with a multi-node bind
mask (for example {0, 1} when ttm_pool_nid(pool) is node 1),
ttm_pool_type_take() takes pooled pages from remote node 0 ahead of local
node 1.

When node 0's pool is empty, ttm_pool_type_take(pt, 0) fails without
checking node 1's pool, disables pool usage for the order, allocates fresh
write-back pages on nearest node 1 via ttm_pool_alloc_bind(), and pays for
cross-CPU set_pages_array_wc() or set_pages_array_uc() TLB shootdowns.
When those pages are later freed, ttm_pool_type_give() returns them to node
1's LRU, where subsequent BIND allocations with mask {0, 1} never check.

> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index 5289c17cd4496..e7605e7e97ecc 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -58,10 +58,14 @@ struct ttm_tt;
>   * @TTM_NUMA_POLICY_NONE: No policy. Use the pool default node.
>   * @TTM_NUMA_POLICY_PREFERRED: Prefer the single node in
>   *	ttm_operation_ctx.numa_info.nodes. Falls back to other nodes.
> + * @TTM_NUMA_POLICY_BIND: Allocate only from the nodes in
> + *	ttm_operation_ctx.numa_info.nodes, in ascending node order. Never fal=
ls
> + *	back to other nodes.
>   */
>  enum ttm_numa_policy {
>  	TTM_NUMA_POLICY_NONE =3D 0,
>  	TTM_NUMA_POLICY_PREFERRED,
> +	TTM_NUMA_POLICY_BIND,
>  };

[Severity: Low]
This comment says nodes are tried "in ascending node order", whereas
ttm_pool_alloc_bind_pass() orders nodes nearest-first from ttm_pool_nid()
by node_distance() and only uses ascending node ID to break ties.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124062123.2431=
244-13-himal.prasad.ghimiray@intel.com?part=3D2
