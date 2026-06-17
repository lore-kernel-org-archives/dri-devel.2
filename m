Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA1ECD98E1
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 03:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD1410E0CA;
	Wed, 17 Jun 2026 03:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G8cTAj1z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4BF710E0CA
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 03:38:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9606740C55;
 Wed, 17 Jun 2026 03:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6221F000E9;
 Wed, 17 Jun 2026 03:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781667503;
 bh=yOTa0xtWG9ghYf8qYCny062+L5PrgCYjZ4ltzHFZG9s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G8cTAj1z8oUnoCbdJZs+KVKstsJUs0+B3QxuikpNYVTgXPzrqm2hSlhM9DZOzAhZw
 DHMIgk+cEKUyggjRwv00///tpau0izVK7fzb9vucS5jcfBl39IBLW5cCtwUvNV5WRG
 8Wq6VRH+XgQ9qrchUV6+lkM+YSA6LXqh4G1ISUtdJr/NwqMzZwyQKC4hprxEoz525Z
 FdF13MUNX8ftnc5XDGN7a2KZv71q2bzL8JQzdEZjJeA1xo4Bvv2+xoBrcJal8INejF
 L018h3M5Vgwd9eneYyxxORNB+3ID9i4emwhFVSUjRIhv4zDSVV3nczX4kkOiLrW3kb
 c7wuA+NlhH68w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] mm: Introduce opportunistic_compaction concept
 to vmscan and shrinkers
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617032218.1165929-2-matthew.brost@intel.com>
References: <20260617032218.1165929-1-matthew.brost@intel.com>
 <20260617032218.1165929-2-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 03:38:22 +0000
Message-Id: <20260617033823.5A6221F000E9@smtp.kernel.org>
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
- [High] Concurrent order-0 wakers cause opportunistic high-order kswapd re=
claims to become destructive, defeating the patch's purpose.
- [High] The opportunistic compaction hint decays to UNSET on retries and p=
remature wakeups, silently converting opportunistic reclaim into destructiv=
e reclaim.
- [Medium] The `order` field referenced in `struct shrink_control`'s docume=
ntation is missing from the struct, rendering the API incomplete.
--

commit 458389aa250d63553aa4e2e1f9e0c39d7fbae43e
Author: Matthew Brost <matthew.brost@intel.com>
Subject: mm: Introduce opportunistic_compaction concept to vmscan and shrin=
kers

This commit introduces an opportunistic compaction hint for kswapd and
shrinkers. It aims to prevent aggressive reclaim of working sets during
fragmentation-sensitive high-order allocations. Shrinkers can use this
hint to skip destructive work when reclaim is unlikely to produce a
contiguous high-order block.

> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 1a00be90d93a9..5f3e8dc981296 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -37,6 +37,26 @@ struct shrink_control {
>  	/* current node being shrunk (for NUMA aware shrinkers) */
>  	int nid;
> =20
> +	/*
> +	 * Opportunistic compaction hint.
> +	 *
> +	 * Set by the reclaim path to tell shrinkers that this pass is
> +	 * driven by an order > 0 allocation that the caller is willing to
> +	 * have fail (e.g., __GFP_NORETRY / __GFP_RETRY_MAYFAIL without
> +	 * __GFP_NOFAIL). Such allocations only really benefit from
> +	 * shrinking when doing so frees up a contiguous, high-order block;
> +	 * thrashing working sets in the hope of producing one is typically
> +	 * counter-productive.
> +	 *
> +	 * Shrinkers that can produce naturally-aligned high-order folios
> +	 * (see shrink_control::order) should treat this as a hint to skip
> +	 * costly work that is unlikely to help compaction (for example,
> +	 * evicting hot/working-set pages just to free single pages).
> +	 *
> +	 * Only meaningful when @order > 0; ignored otherwise.
> +	 */
> +	bool opportunistic_compaction;

[Severity: Medium]
The comment references a shrink_control::order field, but does this field
actually exist in struct shrink_control?

Without passing the target allocation order from scan_control through
shrink_slab(), it seems shrinker implementations won't be able to determine
the requested block size to conditionally skip work.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bd1b1aa125819..c40bc3f9ddd43 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c

[ ... ]

> @@ -7385,6 +7428,11 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, =
int alloc_order, int reclaim_o
> =20
>  			if (READ_ONCE(pgdat->kswapd_order) < reclaim_order)
>  				WRITE_ONCE(pgdat->kswapd_order, reclaim_order);
> +
> +			if (kswapd_opportunistic_compaction =3D=3D
> +			    KSWAPD_NO_OPPORTUNISTIC_COMPACTION)
> +				atomic_set(&pgdat->kswapd_opportunistic_compaction,
> +					   KSWAPD_NO_OPPORTUNISTIC_COMPACTION);
>  		}
> =20
>  		finish_wait(&pgdat->kswapd_wait, &wait);

[Severity: High]
Does this conditional block inadvertently allow the opportunistic hint to
decay on retries?

In kswapd(), the hint is extracted and reset to
KSWAPD_UNSET_OPPORTUNISTIC_COMPACTION before calling balance_pgdat().

If the first reclaim pass fails and kswapd goes back to sleep, this code
only restores the hint if it was KSWAPD_NO_OPPORTUNISTIC_COMPACTION.=20
If it was KSWAPD_OPPORTUNISTIC_COMPACTION, the state decays to UNSET.

On the subsequent retry, sc_opportunistic_compaction() will evaluate
UNSET as false, meaning a multi-pass reclaim or premature wakeup will
cause kswapd to resume full destructive reclaim for the high-order
allocation.

[ ... ]

> @@ -7537,6 +7594,28 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_fl=
ags, int order,
>  	if (READ_ONCE(pgdat->kswapd_order) < order)
>  		WRITE_ONCE(pgdat->kswapd_order, order);
> =20
> +	/*
> +	 * Fold this waker into the per-pgdat opportunistic-compaction hint
> +	 * that kswapd will pick up at the start of its next run.
> +	 *
> +	 * The state is sticky in the "NO" direction: once any waker in this
> +	 * batch is order-0 or a non-failable high-order allocation, the hint
> +	 * stays cleared until kswapd consumes it. Only when every waker so
> +	 * far is a failable high-order allocation do we set
> +	 * KSWAPD_OPPORTUNISTIC_COMPACTION, asking shrinkers to skip work
> +	 * that won't realistically help compaction.
> +	 */
> +	if (atomic_read(&pgdat->kswapd_opportunistic_compaction) !=3D
> +	    KSWAPD_NO_OPPORTUNISTIC_COMPACTION) {
> +		if (!order || !gfp_opportunistic_compaction(gfp_flags))
> +			atomic_set(&pgdat->kswapd_opportunistic_compaction,
> +				   KSWAPD_NO_OPPORTUNISTIC_COMPACTION);
> +		else if (order && gfp_opportunistic_compaction(gfp_flags))
> +			atomic_cmpxchg(&pgdat->kswapd_opportunistic_compaction,
> +				       KSWAPD_UNSET_OPPORTUNISTIC_COMPACTION,
> +				       KSWAPD_OPPORTUNISTIC_COMPACTION);
> +	}

[Severity: High]
Can concurrent order-0 wakers cause opportunistic high-order kswapd
reclaims to become destructive here?

Since pgdat->kswapd_order tracks the maximum requested allocation order
while the hint independently aggregates with a sticky-NO approach, what
happens if an opportunistic high-order allocation (e.g., order 9) and a
normal order-0 allocation concurrently wake kswapd?

It appears the aggregated state becomes order=3D9 with
KSWAPD_NO_OPPORTUNISTIC_COMPACTION. This would cause kswapd to execute
balance_pgdat() for order 9 with the non-opportunistic hint, meaning
shrinkers receive opportunistic_compaction =3D false and aggressively destr=
oy
the working set to satisfy the order-9 allocation.

Because order-0 allocations (like page cache faults) are common, does this
guarantee the opportunistic compaction heuristic will be routinely bypassed
under normal memory pressure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617032218.1165=
929-1-matthew.brost@intel.com?part=3D1
