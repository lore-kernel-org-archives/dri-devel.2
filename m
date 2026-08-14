Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E2FC5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3529510F5F9;
	Fri, 14 Aug 2026 14:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P1yGlzMZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F98D10F5F9;
 Fri, 14 Aug 2026 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786716009; x=1818252009;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=TQCVbJzN093KkdDUdao1srurBeR5qvLyrNvei/7fvE4=;
 b=P1yGlzMZaPM2Zw+gFrdXF6y8quTRDrOA7NkqAf5bnxInCBC7qFX8FmVV
 JHoBw4p5JFMCEZJHV9J7bwc1tQAErBNE0AEZ5W1IpmzHc1BC8uCB5bQ5Z
 3WxlkO0oDcQgwvaIVZc/yaaJu0prQ3qPuR3iog2o7VJcISGKCw0f6cDrr
 rzCFqrhyz6mOUOeE7dmxD49G15tq8U4Yf6DOI6ZhfyoGM1l79Spy9eQnb
 DLmYoOakjKEo3Nq83i3hmM3ZCxBXjsdAYfNxPKHlm4OnqSv9OGG7n7nIL
 JIO9haY5YrPKjspZc0SonWnwpSFjWTgmzSZI/xykK6cTwxM1Fiq+HSOex w==;
X-CSE-ConnectionGUID: j1/vavYDQ9esVoTj9uAMWQ==
X-CSE-MsgGUID: wFntQP+vQWuahGN7vDB1KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87316337"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="87316337"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 07:00:09 -0700
X-CSE-ConnectionGUID: J+37JIwMT1i/d5Cefxbd/A==
X-CSE-MsgGUID: tBCcGRqrRruokPPv24d6kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="269418457"
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.244.164])
 ([10.245.244.164])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 07:00:07 -0700
Message-ID: <89b0b1f748a8e971d4f066dcc51c47f167215261.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: Represent LRU bulk moves as nested sublists
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Date: Fri, 14 Aug 2026 16:00:05 +0200
In-Reply-To: <20260814134602.9AD981F000E9@smtp.kernel.org>
References: <20260814133231.3193-1-thomas.hellstrom@linux.intel.com>
 <20260814134602.9AD981F000E9@smtp.kernel.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Fri, 2026-08-14 at 13:46 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> - [High] Missing cursor adjustment in `ttm_lru_bulk_move_add` when
> re-seeding an empty bulk move anchor causes recently-used resources
> to be prematurely evicted.
> - [Medium] Computing `&man->lru[j]` when `man` is NULL in
> `ttm_bulk_move_drop_cursors` invokes Undefined Behavior and will
> trigger UBSAN panics.

Both issues verified as real and reachable. Will update for v3.

Thanks,
Thomas


> --
>=20
> --- Patch [1]: [PATCH] drm/ttm: Represent LRU bulk moves as nested
> sublists ---
> commit b97657bee6dc1cddf7841bc260d33b4b040368e4
> Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Subject: drm/ttm: Represent LRU bulk moves as nested sublists
>=20
> This patch changes the LRU bulk move mechanism to track each group as
> a
> real nested sublist instead of ranges. Each group gets a persistent
> anchor
> node linked on the manager LRU list along with a sublist holding its
> member
> resources, simplifying cursor tracking and eliminating range-
> corruption bugs.
>=20
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
>=20
> > diff --git a/drivers/gpu/drm/ttm/ttm_resource.c
> > b/drivers/gpu/drm/ttm/ttm_resource.c
> > index 4e6d3d658d858..195f960b2d738 100644
> > --- a/drivers/gpu/drm/ttm/ttm_resource.c
> > +++ b/drivers/gpu/drm/ttm/ttm_resource.c
>=20
> [ ... ]
>=20
> > +static void ttm_bulk_move_drop_cursors(struct ttm_device *bdev,
> > +					struct ttm_lru_bulk_move
> > *bulk)
> > +{
> > +	unsigned int i, j;
> > +
> > +	for (i =3D 0; i < TTM_NUM_MEM_TYPES; ++i) {
> > +		struct ttm_resource_manager *man =3D
> > ttm_manager_type(bdev, i);
> > +
> > +		for (j =3D 0; j < TTM_MAX_BO_PRIORITY; ++j) {
> > +			struct ttm_lru_bulk_move_pos *pos =3D &bulk-
> > >pos[i][j];
> > +			struct ttm_lru_item *lru, *next;
> > +
> > +			list_for_each_entry_safe(lru, next, &pos-
> > >sublist, link) {
> > +				struct ttm_resource_cursor
> > *cursor;
> > +
> > +				if (ttm_lru_item_is_res(lru)) {
> > +					WARN_ON_ONCE(1);
> > +					continue;
> > +				}
> > +				/*
> > +				 * This cursor descended here; its
> > main hitch
> > +				 * already sits on the manager
> > list, so just
> > +				 * detach it from this sublist.
> > +				 */
> > +				cursor =3D container_of(lru,
> > typeof(*cursor),
> > +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > sublist_hitch);
> > +				cursor->cur_list =3D &man->lru[j];
> > +				list_del_init(&lru->link);
> > +			}
> > +			list_splice_tail_init(&pos->sublist, &man-
> > >lru[j]);
>=20
> [Severity: Medium]
> When ttm_manager_type() returns NULL for unused memory types, doesn't
> the
> pointer arithmetic &man->lru[j] result in undefined behavior?
>=20
> If the kernel is compiled with UBSAN, this can trigger a panic even
> if the
> list operations don't actually dereference the pointer. Should there
> be a
> check like if (!man) continue; before the inner loop?
>=20
> > +			list_del_init(&pos->marker.link);
> > +		}
> > +	}
> > +}
>=20
> [ ... ]
>=20
> > +/* Add the resource to a bulk_move sublist */
> > =C2=A0static void ttm_lru_bulk_move_add(struct ttm_lru_bulk_move *bulk,
> > =C2=A0				=C2=A0 struct ttm_resource *res)
> > =C2=A0{
> > =C2=A0	struct ttm_lru_bulk_move_pos *pos =3D
> > ttm_lru_bulk_move_pos(bulk, res);
> > +	struct ttm_resource *first =3D
> > ttm_lru_first_res_or_null(&pos->sublist);
> > +	struct ttm_buffer_object *bo =3D res->bo;
> > +	struct ttm_resource_manager *man =3D
> > +		ttm_manager_type(bo->bdev, res->mem_type);
> > =C2=A0
> > -	if (!pos->first) {
> > -		pos->first =3D res;
> > -		pos->last =3D res;
> > +	if (first) {
> > -		WARN_ON(pos->first->bo->base.resv !=3D res->bo-
> > >base.resv);
> > -		ttm_lru_bulk_move_pos_tail(pos, res);
> > +		WARN_ON(first->bo->base.resv !=3D res->bo-
> > >base.resv);
> > =C2=A0	} else {
> > +		/*
> > +		 * Group empty (first activation, or all members
> > were pinned
> > +		 * or swapped out); re-seed the anchor at the tail
> > so it
> > +		 * counts as recently used.
> > +		 */
> > +		list_move_tail(&pos->marker.link, &man->lru[bo-
> > >priority]);
> > =C2=A0	}
>=20
> [Severity: High]
> If an active LRU traversal cursor has descended into this sublist and
> all
> resources are subsequently removed, the sublist becomes empty except
> for the
> cursor's hitch.
>=20
> When a new resource is added and 'first' is NULL, we re-seed the
> anchor to
> the tail of the manager's LRU list. However, could this leave the
> descended
> cursor parked in the sublist without adjusting it?
>=20
> If ttm_lru_bulk_move_pos_adjust_cursors() is not called to detach it,
> the
> resumed traversal might immediately process and evict this newly
> added
> resource, violating the LRU guarantee.
>=20
> > +	/*
> > +	 * The resource may still be on another list (manager LRU
> > or
> > +	 * bdev->unevictable); move it unconditionally to keep
> > group
> > +	 * membership consistent.
> > +	 */
> > +	list_move_tail(&res->lru.link, &pos->sublist);
> > =C2=A0}
