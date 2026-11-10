Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C9B606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jZ3RK3Gx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9BC10E35A;
	Tue, 10 Nov 2026 08:38:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142D710E35A;
 Tue, 10 Nov 2026 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794299882; x=1825835882;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=9ikwOEdmaVdrNdGZflE+7/QL0tK6vE9e/SS4NEg6QP4=;
 b=jZ3RK3GxipHam3PtIjKoYTZAv0xUUQkBgSg3PjIN4JpYit4O/HFJnIie
 pw0NpjfnJ0IY/CGRH+8Os3TXhuVKNWcdHjVpDz63k/APD/yH9/0uyMIDW
 YHFTtsS64uVM7BoJdsXq6W/CzMP5AwTBScVyn+f8uuygicmaMo7UEYuVO
 gdMy05eOsIJsJn++3bythm3WkiABq3xceb7e7AaEz1vRhM7FgogWm7gfE
 soCmA/tt2RNvWqQ0mEFZ4440er4rlyQb1ZEee3piZYu2wht4ws1nmq4oz
 1juifCgUqRVCYTcU9Ha0w64UGmDQb29bgnnkBgUHGb9HXK+e/e1VC5fZ1 g==;
X-CSE-ConnectionGUID: F22TjFDSQQqfl53u277x7Q==
X-CSE-MsgGUID: UZR6vIwtQUuzCDCvVqJhAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2938872"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2938872"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 00:38:01 -0800
X-CSE-ConnectionGUID: HGKmS/ciRme/QccDFuOVDQ==
X-CSE-MsgGUID: zrOgLP9TT3Sz/mqmK6imYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="9960617"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.245.6])
 ([10.245.245.6])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 00:38:00 -0800
Message-ID: <98a1f790e70e3dc53503f40f93ad9204f6918637.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] drm/ttm, drm/xe: Gate reserve-dipping backup
 retries on may_writeback
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Natalie Vock <nat@pixelcluster.dev>, intel-xe@lists.freedesktop.org
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>, Matthew Auld	
 <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 dri-devel@lists.freedesktop.org
Date: Tue, 10 Nov 2026 09:37:37 +0100
In-Reply-To: <289528879.16714375.1793957492810.JavaMail.zimbra@pixelcluster.dev>
References: <20261104201331.2462-1-thomas.hellstrom@linux.intel.com>
 <20261104201331.2462-5-thomas.hellstrom@linux.intel.com>
 <UT7TwVbFQeWC9z3ZsJ5EGg@pixelcluster.dev>
 <289528879.16714375.1793957492810.JavaMail.zimbra@pixelcluster.dev>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi, Nathalie,

Thanks for reviewing.

On Fri, 2026-11-06 at 09:31 +0000, Natalie Vock wrote:
> Hi,
>=20
> the general idea of this patch looks sensible. A few naming/style
> nitpicks
> below:
>=20
> On Wednesday, 4 November 2026 21:13 Thomas Hellstr=C3=B6m wrote:
> > Backup of a page allocates the shmem destination folio with
> > __GFP_NOMEMALLOC for high-order pages, to avoid dipping into kernel
> > memory reserves, but order-0 pages were always backed up without
> > it.
> > When a high-order allocation fails mid-compound, the compound is
> > split
> > and the remaining subpages are individually retried at order 0
> > without
> > __GFP_NOMEMALLOC.
> >=20
> > That retry happened unconditionally, regardless of whether the
> > caller
> > wanted writeback or could tolerate blocking. Retrying without
> > writeback only grows dirty shmem rather than relieving the memory
> > pressure that caused the original failure, and the retry itself may
> > need to reclaim or block.
> >=20
> > Back up all pages with __GFP_NOMEMALLOC first, and add two flags,
> > may_writeback and force_writeback, to struct ttm_backup_flags,
> > replacing the single writeback flag:
> > - may_writeback governs whether a failed backup allocation is
> > retried
> > =C2=A0 without __GFP_NOMEMALLOC, splitting a high-order page if needed.
> > =C2=A0 When clear, the backup stops at the failure, keeping whatever
> > =C2=A0 progress was already made and leaving the remainder resident for
> > a
> > =C2=A0 later retry.
> > - force_writeback replaces the old writeback flag and is honoured
> > both
> > =C2=A0 for the regular backup and for any retry, so a caller that allow=
s
> > the
> > =C2=A0 retry can also choose to force it to actually complete and
> > relieve
> > =C2=A0 memory pressure instead of just relocating it.
>=20
> Can you explain why you'd call it "may_writeback"? The name implies
> that
> no writeback is ever performed when unset, which isn't really
> accurate.
> AFAICT, all this flag really does is govern how hard we try to
> allocate
> backup shmem, and force_writeback still is the only thing that
> determines
> whether to immediately do a writeback. Or am I misunderstanding?
>=20
> Maybe replace may_writeback with something like use_kernel_reserves.
> Renaming writeback to force_writeback doesn't seem necessary as the
> semantics
> are still the exact same, so that one can just stay.

It looks like I need to rework both the patch and the commit message
quite a bit. The idea for "may_writeback" is that TTM should enable
writeback when it dips in to the kernel reserves, and if it can't do
that (may_writeback =3D=3D false) it doesn't dip but returns a transient
error. That may in turn increase the number of partially backed-up bos,
hence the previous patches in the series.


>=20
> >=20
> > Thread the two new flags all the way from the xe shrinker down
> > through
> > xe_bo_shrink_flags and ttm_bo_shrink_flags to ttm_backup_flags.
> > xe_shrinker_walk() now takes an explicit allow_writeback
> > parameter (computed once from __GFP_IO and no_wait_gpu in
> > xe_shrinker_scan()) rather than carrying that gfp-context
> > permission
> > inside the per-call flags, and uses it to decide, pass by pass,
> > whether
> > the retry is allowed (may_writeback) and whether it should be
> > forced to completion (force_writeback).
> >=20
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/ttm/ttm_bo_util.c |=C2=A0 3 +-
> > =C2=A0drivers/gpu/drm/ttm/ttm_pool.c=C2=A0=C2=A0=C2=A0 | 47 +++++++++++=
++++++++++------
> > ----
> > =C2=A0drivers/gpu/drm/xe/xe_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 ++--
> > =C2=A0drivers/gpu/drm/xe/xe_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 9 ++++--
> > =C2=A0drivers/gpu/drm/xe/xe_shrinker.c=C2=A0 | 39 ++++++++++++++++++++-=
----
> > =C2=A0include/drm/ttm/ttm_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 9 ++++--
> > =C2=A0include/drm/ttm/ttm_tt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 13 +++++++--
> > =C2=A07 files changed, 93 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > index 975dea33075f..21317c212c27 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > @@ -1122,7 +1122,8 @@ long ttm_bo_shrink(struct ttm_operation_ctx
> > *ctx, struct ttm_buffer_object *bo,
> > =C2=A0
> > =C2=A0	lret =3D ttm_tt_backup(bdev, bo->ttm, (struct
> > ttm_backup_flags)
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 {.purge =3D flags.purge,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .writeback =3D flags.writeback});
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .may_writeback =3D
> > flags.may_writeback,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .force_writeback =3D
> > flags.force_writeback});
> > =C2=A0
> > =C2=A0	if (lret > 0 && !ttm_tt_is_partial(bo->ttm)) {
> > =C2=A0		spin_lock(&bdev->lru_lock);
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 8f05257e4f54..87c1ac39af94 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -1158,7 +1158,10 @@ static void ttm_pool_restore_abort(struct
> > ttm_tt *tt)
> > =C2=A0 * If backup of a page fails for whatever reason, @ttm will still
> > be
> > =C2=A0 * partially backed up, retaining those pages for which backup
> > fails.
> > =C2=A0 * In that case, this function can be retried, possibly after
> > freeing up
> > - * memory resources.
> > + * memory resources. In particular, if allocating backup memory
> > fails
> > + * without dipping into kernel reserves, and @flags->may_writeback
> > is not
> > + * set, the backup stops at that point, also leaving @ttm
> > partially backed
> > + * up.
> > =C2=A0 *
> > =C2=A0 * Return: Number of pages actually backed up or freed, or
> > negative
> > =C2=A0 * error code on error.
> > @@ -1174,6 +1177,7 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> > =C2=A0	pgoff_t shrunken =3D 0;
> > =C2=A0	pgoff_t i, j, num_pages, npages;
> > =C2=A0	pgoff_t nr_backed;
> > +	bool dip_reserves;
>=20
> It's a bit nitpicky, but I'm not sure I like the boolean here (in
> particular,
> the ternary at high levels of indentation is uncomfortable to read).
>=20
> How about removing the boolean and doing:
>=20
> > =C2=A0	bool partial =3D ttm_tt_is_partial(tt);
> > =C2=A0
> > =C2=A0	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> > @@ -1256,7 +1260,9 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> > =C2=A0	else
> > =C2=A0		gfp =3D GFP_HIGHUSER;
> > =C2=A0
> > -	alloc_gfp =3D GFP_KERNEL | __GFP_HIGH | __GFP_NOWARN |
> > __GFP_RETRY_MAYFAIL;
> > +	/* Don't dip into kernel reserves unless @flags-
> > >may_writeback is set. */
> > +	alloc_gfp =3D GFP_KERNEL | __GFP_HIGH | __GFP_NOWARN |
> > +		=C2=A0=C2=A0=C2=A0 __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC;
>=20
> 	alloc_gfp =3D GFP_KERNEL | __GFP_HIGH | __GFP_NOWARN |
> 		=C2=A0=C2=A0=C2=A0 __GFP_RETRY_MAYFAIL;
>=20
> > =C2=A0
> > =C2=A0	num_pages =3D tt->num_pages;
> > =C2=A0
> > @@ -1280,14 +1286,7 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> > =C2=A0		order =3D ttm_pool_page_order(pool, page);
> > =C2=A0		npages =3D 1UL << order;
> > =C2=A0
> > -		/*
> > -		 * We don't allow dipping kernel reserves for high
> > order backup
> > -		 */
> > -		if (order)
> > -			alloc_gfp |=3D __GFP_NOMEMALLOC;
> > -		else
> > -			alloc_gfp &=3D ~__GFP_NOMEMALLOC;
> > -
> > +		dip_reserves =3D false;
>=20
> 		alloc_gfp |=3D __GFP_NOMEMALLOC;
>=20
> > =C2=A0		/*
> > =C2=A0		 * Back up the compound atomically at its native
> > order. If
> > =C2=A0		 * fault injection truncated num_pages mid-
> > compound, skip
> > @@ -1296,10 +1295,18 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> > =C2=A0		if (unlikely(i + npages > num_pages))
> > =C2=A0			break;
> > =C2=A0
> > +retry:
> > =C2=A0		handle =3D ttm_backup_backup_folio(backup,
> > page_folio(page),
> > -						 order, flags-
> > >writeback, i,
> > -						 gfp, alloc_gfp,
> > -						 &nr_backed);
> > +						 order, flags-
> > >force_writeback, i,
> > +						 gfp, dip_reserves
> > ?
> > +						 alloc_gfp &
> > ~__GFP_NOMEMALLOC :
> > +						 alloc_gfp,
> > &nr_backed);
>=20
> 						 order, flags-
> >force_writeback, i,
> 						 gfp, alloc_gfp,
> 						 &nr_backed);
>=20
> > +		if (unlikely(handle =3D=3D -ENOMEM && !nr_backed &&
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 flags->may_writeback &&
> > !dip_reserves)) {
> > +			dip_reserves =3D true;
> > +			goto retry;
> > +		}
>=20
> 		if (unlikely(handle =3D=3D -ENOMEM && !nr_backed &&
> 			=C2=A0=C2=A0=C2=A0=C2=A0 flags->may_writeback &&
> 			=C2=A0=C2=A0=C2=A0=C2=A0 (alloc_gfp & __GFP_NOMEMALLOC))) {
> 			alloc_gfp &=3D ~__GFP_NOMEMALLOC;
> 			goto retry;
> 		}
>=20
> This is basically what the original logic already did, too. I think I
> liked that better.
>=20
> Natalie

Agree. I'll take a look at that as well.

Thanks,
Thomas

