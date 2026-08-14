Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A1CC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88FEC10E148;
	Fri, 14 Aug 2026 13:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H+KsKiRi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5217310E140;
 Fri, 14 Aug 2026 13:46:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E3E4F40382;
 Fri, 14 Aug 2026 13:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD981F000E9;
 Fri, 14 Aug 2026 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786715162;
 bh=Fg7YqNAyJQPDcv5gbTFUjJjUoUNYFMuNtxPHV7pwwCs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H+KsKiRif0ig9BwZKtsx5MjCS+mU65+6XSzDFjq1F8j0tFXIbdrFwIsIqZnmJg29p
 iC3Mc93XXUREc8THINex98Jlzw9xvsTNI5zW+SbD8/pbhPdLb0Q8YQn+pDNpmgPy80
 mOyBhUZyBjeSTfw45VifASMoGSwID3nWU5nhhnfzzi0V0aVV52uaOuG1+WDO+Hg8nt
 JjYBTG/ZXmGcKXuOni07mp/RIDKUkAFVwAUqKOez+B+V73VtUGJSvQ3V699FJ3HiZl
 HQXBeqboj70AwaPNVOPpYV9+2Cq+AnvaLFqSxWC4ktYoJhQBzq/OQrpkX94ttosZNg
 k7M725usVc0RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/ttm: Represent LRU bulk moves as nested sublists
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260814133231.3193-1-thomas.hellstrom@linux.intel.com>
References: <20260814133231.3193-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 13:46:02 +0000
Message-Id: <20260814134602.9AD981F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing cursor adjustment in `ttm_lru_bulk_move_add` when re-seedi=
ng an empty bulk move anchor causes recently-used resources to be premature=
ly evicted.
- [Medium] Computing `&man->lru[j]` when `man` is NULL in `ttm_bulk_move_dr=
op_cursors` invokes Undefined Behavior and will trigger UBSAN panics.
--

--- Patch [1]: [PATCH] drm/ttm: Represent LRU bulk moves as nested sublists=
 ---
commit b97657bee6dc1cddf7841bc260d33b4b040368e4
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Subject: drm/ttm: Represent LRU bulk moves as nested sublists

This patch changes the LRU bulk move mechanism to track each group as a
real nested sublist instead of ranges. Each group gets a persistent anchor
node linked on the manager LRU list along with a sublist holding its member
resources, simplifying cursor tracking and eliminating range-corruption bug=
s.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5387

> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm=
_resource.c
> index 4e6d3d658d858..195f960b2d738 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c

[ ... ]

> +static void ttm_bulk_move_drop_cursors(struct ttm_device *bdev,
> +					struct ttm_lru_bulk_move *bulk)
> +{
> +	unsigned int i, j;
> +
> +	for (i =3D 0; i < TTM_NUM_MEM_TYPES; ++i) {
> +		struct ttm_resource_manager *man =3D ttm_manager_type(bdev, i);
> +
> +		for (j =3D 0; j < TTM_MAX_BO_PRIORITY; ++j) {
> +			struct ttm_lru_bulk_move_pos *pos =3D &bulk->pos[i][j];
> +			struct ttm_lru_item *lru, *next;
> +
> +			list_for_each_entry_safe(lru, next, &pos->sublist, link) {
> +				struct ttm_resource_cursor *cursor;
> +
> +				if (ttm_lru_item_is_res(lru)) {
> +					WARN_ON_ONCE(1);
> +					continue;
> +				}
> +				/*
> +				 * This cursor descended here; its main hitch
> +				 * already sits on the manager list, so just
> +				 * detach it from this sublist.
> +				 */
> +				cursor =3D container_of(lru, typeof(*cursor),
> +						      sublist_hitch);
> +				cursor->cur_list =3D &man->lru[j];
> +				list_del_init(&lru->link);
> +			}
> +			list_splice_tail_init(&pos->sublist, &man->lru[j]);

[Severity: Medium]
When ttm_manager_type() returns NULL for unused memory types, doesn't the
pointer arithmetic &man->lru[j] result in undefined behavior?

If the kernel is compiled with UBSAN, this can trigger a panic even if the
list operations don't actually dereference the pointer. Should there be a
check like if (!man) continue; before the inner loop?

> +			list_del_init(&pos->marker.link);
> +		}
> +	}
> +}

[ ... ]

> +/* Add the resource to a bulk_move sublist */
>  static void ttm_lru_bulk_move_add(struct ttm_lru_bulk_move *bulk,
>  				  struct ttm_resource *res)
>  {
>  	struct ttm_lru_bulk_move_pos *pos =3D ttm_lru_bulk_move_pos(bulk, res);
> +	struct ttm_resource *first =3D ttm_lru_first_res_or_null(&pos->sublist);
> +	struct ttm_buffer_object *bo =3D res->bo;
> +	struct ttm_resource_manager *man =3D
> +		ttm_manager_type(bo->bdev, res->mem_type);
> =20
> -	if (!pos->first) {
> -		pos->first =3D res;
> -		pos->last =3D res;
> +	if (first) {
> -		WARN_ON(pos->first->bo->base.resv !=3D res->bo->base.resv);
> -		ttm_lru_bulk_move_pos_tail(pos, res);
> +		WARN_ON(first->bo->base.resv !=3D res->bo->base.resv);
>  	} else {
> +		/*
> +		 * Group empty (first activation, or all members were pinned
> +		 * or swapped out); re-seed the anchor at the tail so it
> +		 * counts as recently used.
> +		 */
> +		list_move_tail(&pos->marker.link, &man->lru[bo->priority]);
>  	}

[Severity: High]
If an active LRU traversal cursor has descended into this sublist and all
resources are subsequently removed, the sublist becomes empty except for the
cursor's hitch.

When a new resource is added and 'first' is NULL, we re-seed the anchor to
the tail of the manager's LRU list. However, could this leave the descended
cursor parked in the sublist without adjusting it?

If ttm_lru_bulk_move_pos_adjust_cursors() is not called to detach it, the
resumed traversal might immediately process and evict this newly added
resource, violating the LRU guarantee.

> +	/*
> +	 * The resource may still be on another list (manager LRU or
> +	 * bdev->unevictable); move it unconditionally to keep group
> +	 * membership consistent.
> +	 */
> +	list_move_tail(&res->lru.link, &pos->sublist);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814133231.3193=
-1-thomas.hellstrom@linux.intel.com?part=3D1
