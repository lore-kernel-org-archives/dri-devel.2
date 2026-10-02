Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A5DCA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1AC10E579;
	Fri,  2 Oct 2026 09:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GCICvzDJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B7110E579;
 Fri,  2 Oct 2026 09:14:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC62C41FB1;
 Fri,  2 Oct 2026 09:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C611F00899;
 Fri,  2 Oct 2026 09:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790932479;
 bh=RTxxqsKUPiaSlwtwX86o8zFLZcYkmN/awyVKx0TsUQs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GCICvzDJvIymBDEtB1O65e0/v+Xq0zQFcU7OWdnOy0SUqni8tXnJutHNqickyvyHO
 kvHEvaY2cYUXHAYn0wfK943aGPyxy3EMnOJ2GhphLfd3Q2TZF1e/r0c2jVyjtVtRwb
 RYdHPOlbM6kS+t7u7nCq96DHQyYkqX0bOCeoa9qmt1qD+6xz9RdAqy+QzaDYyvIp47
 QAGfdqHnVHoFMT/JN838ygXn0kt5JY23Nidc5FoGAcDVv+m/qWV3sMHTfNsQZpX9j9
 7G+KNHiqqPhnmdSTtQ7vARiSsntSPXaJ5iartlthMkAYE4xRxsqDkbq8c4hxkZSV2u
 R/7avxwjKTzMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915: look up shmem folios by index for writeback
To: "Matthias Goergens" <matthias.goergens@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20261002073107.2209644-1-matthias.goergens@gmail.com>
References: <20261002073107.2209644-1-matthias.goergens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:38 +0000
Message-Id: <20261002091439.59C611F00899@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] i915: soft lockup in __shmem_writeback() on large sparse objects
--

commit 13d0555b9d9183775f7e6a194865fdfde399b137
Author: Matthias Goergens <matthias.goergens@gmail.com>

drm/i915: look up shmem folios by index for writeback

This commit reverts to walking the object by index using the folio API
instead of using writeback_iter(), because writeback_iter() misses
shmem folios that do not set PAGECACHE_TAG_DIRTY. It introduces a
manual loop in __shmem_writeback() to find folios by index.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index ef94401662955..54424e434f3b3 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c

[ ... ]

>  void __shmem_writeback(size_t size, struct address_space *mapping)
>  {
> -	struct writeback_control wbc =3D {
> -		.sync_mode =3D WB_SYNC_NONE,
> -		.nr_to_write =3D SWAP_CLUSTER_MAX,
> -		.range_start =3D 0,
> -		.range_end =3D LLONG_MAX,
> -	};
> -	struct folio *folio =3D NULL;
> -	int error =3D 0;
> +	pgoff_t nr_pages =3D size >> PAGE_SHIFT;
> +	pgoff_t index =3D 0;
> =20
>  	/*
> +	 * shmem marks folios dirty with noop_dirty_folio(), which does not
> +	 * set PAGECACHE_TAG_DIRTY, so writeback_iter() would find none of
> +	 * them.  Look up each folio of the object by index and test its
> +	 * dirty flag.
> +	 *
>  	 * Leave mmapings intact (GTT will have been revoked on unbinding,
>  	 * leaving only CPU mmapings around) and add those folios to the LRU
>  	 * instead of invoking writeback so they are aged and paged out
>  	 * as normal.
>  	 */
> -	while ((folio =3D writeback_iter(mapping, &wbc, folio, &error))) {
> -		if (folio_mapped(folio))
> -			folio_redirty_for_writepage(&wbc, folio);
> +	while (index < nr_pages) {
> +		struct folio *folio;
> +
> +		/*
> +		 * Skip folios that are absent or locked: this runs from the
> +		 * shrinker and the OOM notifier, so do not wait for a lock.
> +		 */
> +		folio =3D __filemap_get_folio(mapping, index,
> +					    FGP_LOCK | FGP_NOWAIT, 0);
> +		if (IS_ERR(folio)) {
> +			index++;
> +			continue;
> +		}
                 ^^^^

[Severity: High]
Can this loop cause a soft lockup for large sparse objects?

If the object has a large hole, __filemap_get_folio() will return -ENOENT f=
or
missing folios. The loop then handles this error by stepping forward only 1
page at a time.

For extremely large sparse objects under memory pressure, could this result=
 in
an unbounded CPU stall without yielding, blocking kswapd or direct reclaim,
since there is no cond_resched() in the loop?

> +
> +		index =3D folio->index;
> +		if (!folio_mapped(folio) && folio_clear_dirty_for_io(folio))
> +			shmem_writeback_folio(folio);
>  		else
> -			error =3D shmem_write_folio(folio);
> +			folio_unlock(folio);
> +
> +		/* Writing may have split the folio, so read its size only now. */
> +		index +=3D folio_nr_pages(folio);
> +		folio_put(folio);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002073107.2209=
644-1-matthias.goergens@gmail.com?part=3D1
