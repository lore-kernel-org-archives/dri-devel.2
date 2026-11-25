Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3E606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nV5abIYT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E093410FA2A;
	Wed, 25 Nov 2026 09:05:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD9410FA2A
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 09:04:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFFEE43D4E;
 Wed, 25 Nov 2026 09:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546601F000C0;
 Wed, 25 Nov 2026 09:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795597496;
 bh=e2LJkKTH4YB5dKMOExAq/sB7XU9vFNHmD8NOk8FbWcs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nV5abIYT8IQjlNFCqAWmKc+CB/dgdAEQrtuSCKgWXBi7rhuEuyxxRpVgGHImfDCl5
 b+/VuhDuNIJfKKQD0M+3uBHbSG/UybjhC/vS91eP9tSablAzfgTWXVQj5FECpB+UC8
 UK2QSEc8k7egi98VLpP2QKPdgEsdBcZea+ZxiEgvw8/Co27S2zUKzrymuXOzil81qH
 yjGgRocgRXzSL/vG8Z37+0uyOwOBBuTz10m4IPoSOVUpWSpsLcmPDoq9CEzQtbGMnM
 3Xp0lfUJYYY3upxeAiAI2QszbbvRSVjOusdFBBmCtcv3WCS2WTu/X/rCIDlYNEQWTr
 5odSsEKW+Y5WQ==
Message-ID: <sashiko-outbox-232971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] drm/ttm: reclaim pooled pages after a period of
 inactivity
To: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261124222812.511867-2-eduardoprocopiogomez@gmail.com>
References: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
 <20261124222812.511867-2-eduardoprocopiogomez@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:04:55 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/ttm: race in ttm_pool_type_give() and spin in
  ttm_pool_shrink_idle()
- [High] drm/ttm: unbatched set_pages_wb() IPI storm in
  ttm_pool_shrink_idle()
--

commit be4ff4c980b2546ac4ff032bfa520f015175f024
Author: Eduardo P. Gomez <eduardoprocopiogomez@gmail.com>

drm/ttm: reclaim pooled pages after a period of inactivity

This commit adds a delayed work item to drain pooled TTM pages through
ttm_pool_shrink() after five seconds without page returns, and moves page
accounting in ttm_pool_type_give() ahead of list_lru_add().

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 1bf37023fed66..6af8a9c894b4e 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -335,14 +365,17 @@ static void ttm_pool_type_give(struct ttm_pool_type=
 *pt, struct page *p)
>  			clear_page(page_address(p + i));
>  	}
> =20
> +	/* Account for the pages before a concurrent shrinker can take them. */
> +	atomic_long_add(num_pages, &allocated_pages[nid]);
> +	mod_lruvec_page_state(p, NR_GPU_ACTIVE, -num_pages);
> +	mod_lruvec_page_state(p, NR_GPU_RECLAIM, num_pages);
> +
>  	INIT_LIST_HEAD(&p->lru);
>  	rcu_read_lock();
>  	list_lru_add(&pt->pages, &p->lru, nid, NULL);
>  	rcu_read_unlock();
> =20
> -	atomic_long_add(num_pages, &allocated_pages[nid]);
> -	mod_lruvec_page_state(p, NR_GPU_ACTIVE, -num_pages);
> -	mod_lruvec_page_state(p, NR_GPU_RECLAIM, num_pages);
> +	ttm_pool_note_return();
>  }

[Severity: High]
Can ttm_pool_shrink_idle() immediately reclaim a page that is being
returned here, or spin when allocated_pages[nid] is ahead of the LRU?

Because allocated_pages[nid] and pt->pages are updated before
ttm_pool_note_return() refreshes pool_last_return, an already-running idle
worker sees the new page while pool_last_return still holds the old
expired timestamp:

CPU0                                  CPU1 (kworker)
ttm_pool_type_give()                  ttm_pool_shrink_idle()
  atomic_long_add(...,
                  &allocated_pages[nid])
  list_lru_add(&pt->pages, ...)
                                        atomic_long_read(&allocated_pages[n=
id])
                                        expires =3D READ_ONCE(pool_last_ret=
urn)
                                                  + pool_idle_delay
                                        time_before(now, expires) =3D=3D fa=
lse
                                        ttm_pool_shrink(nid, batch)
                                          <-- reclaims just-returned page
  ttm_pool_note_return()
    WRITE_ONCE(pool_last_return, jiffies)

In addition, ttm_pool_shrink_idle() loops for as long as
atomic_long_read(&allocated_pages[nid]) > 0 without checking whether
ttm_pool_shrink() freed any pages.  allocated_pages[nid] is positive while
no pages remain on any pt->pages LRU both between atomic_long_add() and
list_lru_add() above (with preemption enabled) and while concurrent
ttm_pool_dispose_list() calls are freeing isolated pages before
decrementing allocated_pages[nid].  During those windows,
ttm_pool_shrink() returns 0 on every call and ttm_pool_shrink_idle() spins
acquiring pool_shrink_rwsem and shrinker_lock; if direct reclaim preempts
ttm_pool_type_give() between atomic_long_add() and list_lru_add(),
ttm_pool_shrinker_scan() can also spin without cond_resched().

Updating pool_last_return before publishing the page and breaking out of
the shrink loop when a full pass over shrinker_list frees no pages would
avoid both issues.

[ ... ]

> @@ -473,6 +506,30 @@ static unsigned int ttm_pool_shrink(int nid, unsigne=
d long num_to_free)
>  	return num_pages;
>  }
> =20
> +/* Return unused pool pages after the last return has aged out. */
> +static void ttm_pool_shrink_idle(struct work_struct *work)
> +{
> +	const unsigned long batch =3D 1UL << (MAX_PAGE_ORDER / 2);
> +	int nid;
> +
> +	for_each_node_state(nid, N_MEMORY) {
> +		while (atomic_long_read(&allocated_pages[nid]) > 0) {
> +			unsigned long now =3D jiffies;
> +			unsigned long expires =3D READ_ONCE(pool_last_return) +
> +						pool_idle_delay;
> +
> +			if (time_before(now, expires)) {
> +				queue_delayed_work(system_dfl_long_wq, &pool_idle_work,
> +						   expires - now);
> +				return;
> +			}
> +
> +			ttm_pool_shrink(nid, batch);
> +			cond_resched();
> +		}
> +	}
> +}

[Severity: High]
Does draining the pool through ttm_pool_shrink() trigger an IPI storm of
unbatched set_pages_wb() calls on x86?

ttm_pool_shrink() frees pages one entry at a time via
ttm_pool_dispose_list() -> ttm_pool_free_page():

drivers/gpu/drm/ttm/ttm_pool.c:ttm_pool_free_page() {
    ...
#ifdef CONFIG_X86
	/* We don't care that set_pages_wb is inefficient here. This is only
	 * used when we have to shrink and CPU overhead is irrelevant then.
	 */
	if (caching !=3D ttm_cached && !PageHighMem(p))
		set_pages_wb(p, 1 << order);
#endif
    ...
}

Unlike ttm_pool_backup(), which batches page-attribute changes with
set_pages_array_wb(), each set_pages_wb() call here issues a synchronous
cross-CPU TLB shootdown IPI to every online CPU for a single page block.
Because ttm_pool_shrink() also inspects and rotates only one ttm_pool_type
per call across the global and per-device entries on shrinker_list,
draining a single populated pool type walks dozens of empty LRUs under
pool_shrink_rwsem and shrinker_lock for every 32-entry batch.  Later
commit "drm/ttm: retain a reserve during idle pool reclaim" in this series
keeps a 128 MiB per-node reserve, but any pooled WC/UC pages above that
threshold still hit this path five seconds after the last return.

Also, pool_last_return is only updated in ttm_pool_type_give() and not in
ttm_pool_type_take(), so ttm_pool_shrink_idle() will drain the pool even
while a workload is actively taking pages via ttm_pool_alloc().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124222812.5118=
67-2-eduardoprocopiogomez@gmail.com?part=3D1
