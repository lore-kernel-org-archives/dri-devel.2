Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F11606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=w/c1l5vq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC8810E9AB;
	Fri,  6 Nov 2026 09:39:14 +0000 (UTC)
X-Greylist: delayed 450 seconds by postgrey-1.36 at gabe;
 Fri, 06 Nov 2026 09:39:07 UTC
Received: from smtpout1.mo2.mail-out.ovh.net (smtpout1.mo2.mail-out.ovh.net
 [79.137.123.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF5FB10F11D;
 Fri,  6 Nov 2026 09:39:07 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4jLYpZ1T23z43dw;
 Fri,  6 Nov 2026 09:31:34 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <arunpravin.paneerselvam@amd.com>; Fri,  6 Nov 2026 09:31:33 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.188.192])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jLYpY6HWBz6Nm6; Fri,  6 Nov 2026 09:31:33 +0000 (UTC)
Received: from mailstore88.priv.ovhmail-u1.ea.mail.ovh.net (unknown
 [10.2.8.88])
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTP id 118338E2088;
 Fri,  6 Nov 2026 09:31:33 +0000 (UTC)
Date: Fri, 6 Nov 2026 09:31:32 +0000 (UTC)
From: Natalie Vock <nat@pixelcluster.dev>
To: intel-xe@lists.freedesktop.org, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Arun Pravin <arunpravin.paneerselvam@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>, 
 dri-devel@lists.freedesktop.org
Message-ID: <289528879.16714375.1793957492810.JavaMail.zimbra@pixelcluster.dev>
In-Reply-To: <UT7TwVbFQeWC9z3ZsJ5EGg@pixelcluster.dev>
References: <20261104201331.2462-1-thomas.hellstrom@linux.intel.com>
 <20261104201331.2462-5-thomas.hellstrom@linux.intel.com>
 <UT7TwVbFQeWC9z3ZsJ5EGg@pixelcluster.dev>
Subject: Re: [PATCH 4/4] drm/ttm, drm/xe: Gate reserve-dipping backup
 retries on may_writeback
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-User: nat@pixelcluster.dev
X-Zimbra-Message-Verification: hash=SHA256;
 guid=ZjMzODRmZTUxY2Y4NjVmMzM4ZWIyMmNjNjcxMWIyMjdjNjZkZjUxODFiNzU3ZTRiNGQ2ODY2YmY5N2RhMGZhZA==
Thread-Topic: drm/ttm,
 drm/xe: Gate reserve-dipping backup retries on may_writeback
Thread-Index: 7kO8N8GFxYKS/ExEqqnG5UuuP2r3fg==
x-ovh-tracer-id: 11418032432920944919
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGleUKzJGhhheamRhdKHzhX5WmhEezG3dhR83CAF9trPeLiJR2H7d7E8EuzB0IObpQhv5Rh3WMs2aZviMl2hpyShhbrAfSCv8XKEXSjdNjfxFzsM4bOcjswQfvs36trYt6OHkj0nXv6lf7Fafgfu60z26vfC4YP1qeWI1agfocJQhpEf7cBZ2wWtrJOEniUVzJq5BAokMedPm83kCWg8dgNJ8TcoZMzBizHb3+g1JSawJt/H/tQWCiFINyU1eJRWeJTSkpTiKJY+p/p1qi3AVlEwXgYpu2kK+nOBmQAE7IcwlHaib3arzHYB4TuhnwYeJoYK+LfA4CbzoSwkqpIWV+Jau9BdwrQQSzKc1komfaiNqeOWKio/z9paDQ+wgGdIUcYKmvfXrhigG0xxMpwhNIAaFpqMkqQcBNOnRCu1BZympXquPFZmp7Q7XJEOQDGARtn9Ka8Uyil29Mf3XucBYXPbl3PDFgb1g2BPInHfl7RwqpdySeVexw0RIpL0/g9l+cRcTRNX1vmrVcCLDDNXHlk8C4evEq6sGPeelX9SxYyAhyQ9/rdMdTOfXPc6ELsy9Ze5mKsYOO4pSQElSlumsPRpPlYWUdr/A47gtHIMs7KoXDtaKvdb8q/4LbpFihk/IPqFOKn4FDWGm3A+QsDzoFAMAmyNf7dOoBruIX0hzI/YQ
DKIM-Signature: a=rsa-sha256; bh=yUuXr08L4Muu7mgvIUpR4QTj1uzbuXupMj5KHz2SALc=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1793957494; v=1;
 b=w/c1l5vqcbpJNhVaghAlK73zgzFlPIA8qnpYkGuaxcvnKSzqHtYd1xl2xJCGxs2tMD9V6qLz
 3cpYhF3TesuBMHdyw1IG34k/B/JtwoGbalxxGptVrJesy1co0f81YxbLtLi3OKQc8SnnJuX2pK5
 hHZL9tMjh69ssHuoQhKP6Tc8kne6TlxmQfobQdXhtAserv36M1A/ioU+pLIbP6Rdtag1Jo6Jm0X
 UNgqz0kvBgkMll+xXVQSddwr2TjEFeRuB5CT3wN7qgNXd2lRz8z5m9+uxJUuzJLfbdrw13prUhx
 CJ4l1oP5Uj2Hd6eezRbHjfa+5c8zH1sifbJsG4bNlgSgw==
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

the general idea of this patch looks sensible. A few naming/style nitpicks
below:

On Wednesday, 4 November 2026 21:13 Thomas Hellstr=C3=B6m wrote:
> Backup of a page allocates the shmem destination folio with
> __GFP_NOMEMALLOC for high-order pages, to avoid dipping into kernel
> memory reserves, but order-0 pages were always backed up without it.
> When a high-order allocation fails mid-compound, the compound is split
> and the remaining subpages are individually retried at order 0 without
> __GFP_NOMEMALLOC.
>=20
> That retry happened unconditionally, regardless of whether the caller
> wanted writeback or could tolerate blocking. Retrying without
> writeback only grows dirty shmem rather than relieving the memory
> pressure that caused the original failure, and the retry itself may
> need to reclaim or block.
>=20
> Back up all pages with __GFP_NOMEMALLOC first, and add two flags,
> may_writeback and force_writeback, to struct ttm_backup_flags,
> replacing the single writeback flag:
> - may_writeback governs whether a failed backup allocation is retried
>   without __GFP_NOMEMALLOC, splitting a high-order page if needed.
>   When clear, the backup stops at the failure, keeping whatever
>   progress was already made and leaving the remainder resident for a
>   later retry.
> - force_writeback replaces the old writeback flag and is honoured both
>   for the regular backup and for any retry, so a caller that allows the
>   retry can also choose to force it to actually complete and relieve
>   memory pressure instead of just relocating it.

Can you explain why you'd call it "may_writeback"? The name implies that
no writeback is ever performed when unset, which isn't really accurate.
AFAICT, all this flag really does is govern how hard we try to allocate
backup shmem, and force_writeback still is the only thing that determines
whether to immediately do a writeback. Or am I misunderstanding?

Maybe replace may_writeback with something like use_kernel_reserves.
Renaming writeback to force_writeback doesn't seem necessary as the semanti=
cs
are still the exact same, so that one can just stay.

>=20
> Thread the two new flags all the way from the xe shrinker down through
> xe_bo_shrink_flags and ttm_bo_shrink_flags to ttm_backup_flags.
> xe_shrinker_walk() now takes an explicit allow_writeback
> parameter (computed once from __GFP_IO and no_wait_gpu in
> xe_shrinker_scan()) rather than carrying that gfp-context permission
> inside the per-call flags, and uses it to decide, pass by pass, whether
> the retry is allowed (may_writeback) and whether it should be
> forced to completion (force_writeback).
>=20
> Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo_util.c |  3 +-
>  drivers/gpu/drm/ttm/ttm_pool.c    | 47 +++++++++++++++++++++----------
>  drivers/gpu/drm/xe/xe_bo.c        |  6 ++--
>  drivers/gpu/drm/xe/xe_bo.h        |  9 ++++--
>  drivers/gpu/drm/xe/xe_shrinker.c  | 39 ++++++++++++++++++++-----
>  include/drm/ttm/ttm_bo.h          |  9 ++++--
>  include/drm/ttm/ttm_tt.h          | 13 +++++++--
>  7 files changed, 93 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_=
bo_util.c
> index 975dea33075f..21317c212c27 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -1122,7 +1122,8 @@ long ttm_bo_shrink(struct ttm_operation_ctx *ctx, s=
truct ttm_buffer_object *bo,
> =20
>  =09lret =3D ttm_tt_backup(bdev, bo->ttm, (struct ttm_backup_flags)
>  =09=09=09     {.purge =3D flags.purge,
> -=09=09=09      .writeback =3D flags.writeback});
> +=09=09=09      .may_writeback =3D flags.may_writeback,
> +=09=09=09      .force_writeback =3D flags.force_writeback});
> =20
>  =09if (lret > 0 && !ttm_tt_is_partial(bo->ttm)) {
>  =09=09spin_lock(&bdev->lru_lock);
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 8f05257e4f54..87c1ac39af94 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1158,7 +1158,10 @@ static void ttm_pool_restore_abort(struct ttm_tt *=
tt)
>   * If backup of a page fails for whatever reason, @ttm will still be
>   * partially backed up, retaining those pages for which backup fails.
>   * In that case, this function can be retried, possibly after freeing up
> - * memory resources.
> + * memory resources. In particular, if allocating backup memory fails
> + * without dipping into kernel reserves, and @flags->may_writeback is no=
t
> + * set, the backup stops at that point, also leaving @ttm partially back=
ed
> + * up.
>   *
>   * Return: Number of pages actually backed up or freed, or negative
>   * error code on error.
> @@ -1174,6 +1177,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct =
ttm_tt *tt,
>  =09pgoff_t shrunken =3D 0;
>  =09pgoff_t i, j, num_pages, npages;
>  =09pgoff_t nr_backed;
> +=09bool dip_reserves;

It's a bit nitpicky, but I'm not sure I like the boolean here (in particula=
r,
the ternary at high levels of indentation is uncomfortable to read).

How about removing the boolean and doing:

>  =09bool partial =3D ttm_tt_is_partial(tt);
> =20
>  =09if (WARN_ON(ttm_tt_is_backed_up(tt)))
> @@ -1256,7 +1260,9 @@ long ttm_pool_backup(struct ttm_pool *pool, struct =
ttm_tt *tt,
>  =09else
>  =09=09gfp =3D GFP_HIGHUSER;
> =20
> -=09alloc_gfp =3D GFP_KERNEL | __GFP_HIGH | __GFP_NOWARN | __GFP_RETRY_MA=
YFAIL;
> +=09/* Don't dip into kernel reserves unless @flags->may_writeback is set=
. */
> +=09alloc_gfp =3D GFP_KERNEL | __GFP_HIGH | __GFP_NOWARN |
> +=09=09    __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC;

=09alloc_gfp =3D GFP_KERNEL | __GFP_HIGH | __GFP_NOWARN |
=09=09    __GFP_RETRY_MAYFAIL;

> =20
>  =09num_pages =3D tt->num_pages;
> =20
> @@ -1280,14 +1286,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct=
 ttm_tt *tt,
>  =09=09order =3D ttm_pool_page_order(pool, page);
>  =09=09npages =3D 1UL << order;
> =20
> -=09=09/*
> -=09=09 * We don't allow dipping kernel reserves for high order backup
> -=09=09 */
> -=09=09if (order)
> -=09=09=09alloc_gfp |=3D __GFP_NOMEMALLOC;
> -=09=09else
> -=09=09=09alloc_gfp &=3D ~__GFP_NOMEMALLOC;
> -
> +=09=09dip_reserves =3D false;

=09=09alloc_gfp |=3D __GFP_NOMEMALLOC;

>  =09=09/*
>  =09=09 * Back up the compound atomically at its native order. If
>  =09=09 * fault injection truncated num_pages mid-compound, skip
> @@ -1296,10 +1295,18 @@ long ttm_pool_backup(struct ttm_pool *pool, struc=
t ttm_tt *tt,
>  =09=09if (unlikely(i + npages > num_pages))
>  =09=09=09break;
> =20
> +retry:
>  =09=09handle =3D ttm_backup_backup_folio(backup, page_folio(page),
> -=09=09=09=09=09=09 order, flags->writeback, i,
> -=09=09=09=09=09=09 gfp, alloc_gfp,
> -=09=09=09=09=09=09 &nr_backed);
> +=09=09=09=09=09=09 order, flags->force_writeback, i,
> +=09=09=09=09=09=09 gfp, dip_reserves ?
> +=09=09=09=09=09=09 alloc_gfp & ~__GFP_NOMEMALLOC :
> +=09=09=09=09=09=09 alloc_gfp, &nr_backed);

=09=09=09=09=09=09 order, flags->force_writeback, i,
=09=09=09=09=09=09 gfp, alloc_gfp,
=09=09=09=09=09=09 &nr_backed);

> +=09=09if (unlikely(handle =3D=3D -ENOMEM && !nr_backed &&
> +=09=09=09     flags->may_writeback && !dip_reserves)) {
> +=09=09=09dip_reserves =3D true;
> +=09=09=09goto retry;
> +=09=09}

=09=09if (unlikely(handle =3D=3D -ENOMEM && !nr_backed &&
=09=09=09     flags->may_writeback &&
=09=09=09     (alloc_gfp & __GFP_NOMEMALLOC))) {
=09=09=09alloc_gfp &=3D ~__GFP_NOMEMALLOC;
=09=09=09goto retry;
=09=09}

This is basically what the original logic already did, too. I think I
liked that better.

Natalie
