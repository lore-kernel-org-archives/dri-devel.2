Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC91606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMPJ5lDH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4734010F983;
	Wed, 25 Nov 2026 02:10:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E713B10F968
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:10:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 703E743506;
 Wed, 25 Nov 2026 02:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380721F000C0;
 Wed, 25 Nov 2026 02:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795572615;
 bh=dPuuSVMD/cCxQHd+LDsv0nJStalPoX/AFEjPFfdYT4A=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=RMPJ5lDHYn7URIUfEuwOKxye1fU+JWT4JZIJBXXkquFxag4NFYsbiwhpwYy2RYYeL
 69lD1+BVWdgWalpVAUKoHw24QGfFBmZcgk/JZ+fOhHx+dfpvGdD7wagoHSEv+bYsuM
 v84InBblMRLgaRX1HNy8U7xwVOG4uN3jXCFQrqayKL07KlULsWVWITdSOC+QBU+vhB
 muKEKB3Yy3qhxU/bgidqytDUINSQFAOf6Vst/50reaGQ/rlP5i64Bu/mw+zbqNVUhJ
 5jihdF1AN3YDXW4FaBGTgSO2/EIcIrSdHOX682taF9GzciZswJyT9bQbruTrUPKSW7
 NadBoHReqi3wg==
Message-ID: <sashiko-outbox-232393@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2] drm/ttm: reclaim excess pooled pages after a
 fixed delay
To: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261125015613.127297-1-eduardoprocopiogomez@gmail.com>
References: <20261125015613.127297-1-eduardoprocopiogomez@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:10:14 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/ttm: unbatched set_pages_wb() IPI storm in
  ttm_pool_shrink_idle()
--

commit e91f541d87136a66bf36718752a8777d95e748f4
Author: Eduardo P. Gomez <eduardoprocopiogomez@gmail.com>

drm/ttm: reclaim excess pooled pages after a fixed delay

This commit schedules delayed work to reclaim pooled TTM pages above a
per-node reserve after a fixed five-second window and uses a single
counter read in ttm_pool_free() when checking the node limit.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 1bf37023fed66..09766496d8810 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -473,6 +511,46 @@ static unsigned int ttm_pool_shrink(int nid, unsigne=
d long num_to_free)
>  	return num_pages;
>  }
> =20
> +/* Trim excess pooled pages when the fixed reclaim window expires. */
> +static void ttm_pool_shrink_idle(struct work_struct *work)
> +{
> +	const unsigned long batch =3D 1UL << (MAX_PAGE_ORDER / 2);
> +	size_t nr_types;
> +	int nid;
> +
> +	spin_lock(&shrinker_lock);
> +	nr_types =3D list_count_nodes(&shrinker_list);
> +	spin_unlock(&shrinker_lock);
> +
> +	for_each_node_state(nid, N_MEMORY) {
> +		unsigned long reserve =3D min(page_pool_idle_reserve,
> +					    pool_node_limit[nid]);
> +		long pages =3D atomic_long_read(&allocated_pages[nid]);
> +		unsigned long budget;
> +		size_t empty =3D 0;
> +
> +		if (pages <=3D 0 || pages <=3D reserve)
> +			continue;
> +
> +		/* Bound freed pages and scans that make no progress. */
> +		budget =3D pages - reserve;
> +		while (budget && empty < nr_types && pages > 0 && pages > reserve) {
> +			unsigned long freed;
> +
> +			freed =3D ttm_pool_shrink(nid, batch, min(budget, pages - reserve));
> +			budget -=3D min(budget, freed);
> +			empty =3D freed ? 0 : empty + 1;
> +			cond_resched();
> +			pages =3D atomic_long_read(&allocated_pages[nid]);
> +		}

[Severity: Medium]
Can draining the entire excess in one ttm_pool_shrink_idle() pass cause an
unbatched set_pages_wb() TLB shootdown storm on x86?

ttm_pool_shrink() -> ttm_pool_dispose_list() calls ttm_pool_free_page()
once per isolated entry, which restores write-back caching individually:

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

Each set_pages_wb() call takes cpa_lock and broadcasts a synchronous
cross-CPU TLB shootdown IPI, so reclaiming 1 GiB of order-0 write-combined
pages in one pass issues 262,144 individual set_pages_wb() calls while also
rotating through all empty shrinker_list entries after every 32-entry
batch.  Because ttm_pool_note_return() uses a fixed five-second timer that
is not deferred by ongoing pool activity, an active GPU workload cycling
more than 128 MiB of WC/UC buffers will repeatedly pay this unbatched
set_pages_wb() shootdown storm and subsequent set_pages_array_wc() or
set_pages_array_uc() allocation shootdowns every five seconds.

Batching the caching transition across dispose list entries with
set_pages_array_wb() (as ttm_pool_backup() does) would avoid per-page CPA
shootdowns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125015613.1272=
97-1-eduardoprocopiogomez@gmail.com?part=3D1
