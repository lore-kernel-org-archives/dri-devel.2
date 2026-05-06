Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424A7CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 16:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A544F10E1DA;
	Wed,  6 May 2026 16:26:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZBRjfWlH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4627D10E1DA;
 Wed,  6 May 2026 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778084810; x=1809620810;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=/mDqpMIzFWzEpnLY9TglmlOA2Gp01KKDylgMxAfoYnY=;
 b=ZBRjfWlHi0NukU0pPlQ8zpSRxpGfmpziMDCn/fjjECwTD+wlGFAbi3yK
 DPEHz9fB0iWMsV770c3mmOykmnUnouSKZ0c3wXOmHCqga9gu+0t1/zYFP
 rygRq1OB5kCEmoyZpPYuZ0LcniALHpFI2yiw4CuzMFySs8wbVwNFFPdic
 8LpsrMi0EmBa0PEfvHSUROjF5CPjbKvSHDdK2RC5kWYNyGQ6wdK0HqO9B
 gWgJojvG3THY+DBhB7GclNmqVzo+Lzcm1rEcfOjsawKXMTtZF4ZyFUa8G
 f6S4pZG/BdOPTQnGfFykFjRovxbtgiKJ5VqfdljHqws0tujNgDsdgM3aE g==;
X-CSE-ConnectionGUID: L5vSQJUzQEic7KJBNsZIDg==
X-CSE-MsgGUID: QE+sdqVaQdylAxEP9gLEXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78741635"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="78741635"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 09:26:50 -0700
X-CSE-ConnectionGUID: VkPqATJHSLiyGBIGcPtdrg==
X-CSE-MsgGUID: a/z35rqlS7SqFwxXnPFDpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="240180678"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.213])
 ([10.245.244.213])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 09:26:47 -0700
Message-ID: <906de072af1f6744aed1eb914ff196f0f5e00016.camel@linux.intel.com>
Subject: Re: [PATCH v5 2/2] drm/ttm/pool: back up at native page order
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter	 <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 06 May 2026 18:26:43 +0200
In-Reply-To: <afto1UzV/yfNrv1S@gsse-cloud1.jf.intel.com>
References: <20260505200443.3300962-1-matthew.brost@intel.com>
 <20260505200443.3300962-3-matthew.brost@intel.com>
 <47256c5547c75296af32ca87161188588cacf727.camel@linux.intel.com>
 <afto1UzV/yfNrv1S@gsse-cloud1.jf.intel.com>
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

On Wed, 2026-05-06 at 09:14 -0700, Matthew Brost wrote:
> On Wed, May 06, 2026 at 04:23:29PM +0200, Thomas Hellstr=C3=B6m wrote:
> > Hi, Matt
> >=20
> > On Tue, 2026-05-05 at 13:04 -0700, Matthew Brost wrote:
> > > ttm_pool_split_for_swap() splits high-order pool pages into
> > > order-0
> > > pages during backup so each 4K page can be released to the system
> > > as
> > > soon as it has been written to shmem. While this minimizes the
> > > allocator's working set during reclaim, it actively fragments
> > > memory:
> > > every TTM-backed compound page that the shrinker touches is
> > > shattered
> > > into order-0 pages, even when the rest of the system would prefer
> > > that
> > > the high-order block stay intact. Under sustained kswapd pressure
> > > this
> > > is enough to drive other parts of MM into recovery loops from
> > > which
> > > they cannot easily escape, because the memory TTM just freed is
> > > no
> > > longer contiguous.
> > >=20
> > > Stop unconditionally splitting on the backup path and back up
> > > each
> > > compound at its native order in ttm_pool_backup():
> > >=20
> > > =C2=A0 - For each non-handle slot, read the order from the head page
> > > and
> > > =C2=A0=C2=A0=C2=A0 back up all 1<<order subpages to consecutive shmem=
 indices,
> > > =C2=A0=C2=A0=C2=A0 writing the resulting handles into tt->pages[] as =
we go.
> > > =C2=A0 - On success, the compound is freed once at its native order.
> > > No
> > > =C2=A0=C2=A0=C2=A0 split_page(), no per-4K refcount juggling, no frag=
mentation
> > > =C2=A0=C2=A0=C2=A0 introduced from this path.
> > > =C2=A0 - Slots that already hold a backup handle from a previous
> > > partial
> > > =C2=A0=C2=A0=C2=A0 attempt are skipped. A compound that would extend =
past a
> > > =C2=A0=C2=A0=C2=A0 fault-injection-truncated num_pages is skipped rat=
her than
> > > split.
> > >=20
> > > A per-subpage backup failure cannot be made fully atomic: backing
> > > up
> > > a
> > > subpage allocates a shmem folio before the source page can be
> > > released,
> > > so under true OOM any subpage in a compound (not just the first)
> > > may
> > > fail to be backed up with the rest of the source compound still
> > > live
> > > and contiguous. To make forward progress in that case, fall back
> > > to
> > > splitting the source compound and backing up its remaining
> > > subpages
> > > individually:
> > >=20
> > > =C2=A0 - On the first per-subpage failure for a compound (and only if
> > > =C2=A0=C2=A0=C2=A0 order > 0), call ttm_pool_split_for_swap() to spli=
t the
> > > source
> > > =C2=A0=C2=A0=C2=A0 compound, release the subpages whose contents alre=
ady live in
> > > =C2=A0=C2=A0=C2=A0 shmem (their handles in tt->pages stay valid), and=
 retry the
> > > =C2=A0=C2=A0=C2=A0 failing subpage at order 0.
> > > =C2=A0 - Subsequent successful subpage backups in the now-split
> > > compound
> > > =C2=A0=C2=A0=C2=A0 free their source page individually as soon as the=
 handle is
> > > =C2=A0=C2=A0=C2=A0 written.
> > > =C2=A0 - A second failure after splitting terminates the loop with
> > > partial
> > > =C2=A0=C2=A0=C2=A0 progress; the remaining order-0 subpages stay in t=
t->pages as
> > > =C2=A0=C2=A0=C2=A0 plain page pointers and are cleaned up by the norm=
al
> > > =C2=A0=C2=A0=C2=A0 ttm_pool_drop_backed_up() / ttm_pool_free_range() =
paths.
> > >=20
> > > This restores the original split-on-OOM fallback behavior while
> > > keeping the common, non-OOM case fragmentation-free. It also
> > > preserves the "partial backup is allowed" contract: shrunken is
> > > incremented per backed-up subpage so the caller still sees
> > > forward
> > > progress when a compound only partially succeeds.
> > >=20
> > > The restore-side leftover-page branch in
> > > ttm_pool_restore_commit() is
> > > left as-is for now: that path can still split a previously-
> > > retained
> > > compound, but in practice it is unreachable under realistic
> > > workloads
> > > (per profiling we have not been able to trigger it), so it is not
> > > worth complicating the restore state machine to avoid the split
> > > there.
> > > If it ever becomes a problem in practice it can be addressed
> > > independently.
> > >=20
> > > ttm_pool_split_for_swap() itself is retained both for the OOM
> > > fallback above and for the restore path's remaining caller. The
> > > DMA-mapped pre-backup unmap loop, the purge path,
> > > ttm_pool_free_*,
> > > and ttm_pool_unmap_and_free() already operate at native order and
> > > are unchanged.
> > >=20
> > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > Cc: Huang Rui <ray.huang@amd.com>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Simona Vetter <simona@ffwll.ch>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: stable@vger.kernel.org
> > > Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper
> > > to
> > > shrink pages")
> > > Suggested-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com=
>
> > > Assisted-by: Claude:claude-opus-4.6
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > >=20
> > > ---
> > >=20
> > > A follow-up should attempt writeback to shmem at folio order as
> > > well,
> > > but the API for doing so is unclear and may be incomplete.
> > >=20
> > > This patch is related to the pending series [1] and significantly
> > > reduces the likelihood of Xe entering a kswapd loop under
> > > fragmentation.
> > > The kswapd =E2=86=92 shrinker =E2=86=92 Xe shrinker =E2=86=92 TTM bac=
kup path is still
> > > exercised; however, with this change the backup path no longer
> > > worsens
> > > fragmentation, which previously amplified reclaim pressure and
> > > reinforced the kswapd loop.
> > >=20
> > > Nonetheless, the pathological case that [1] aims to address still
> > > exists
> > > and requires a proper solution. Even with this patch, a kswapd
> > > loop
> > > due
> > > to severe fragmentation can still be triggered, although it is
> > > now
> > > substantially harder to reproduce.
> > >=20
> > > v2:
> > > =C2=A0- Split pages and free immediately if backup fails are higher
> > > order
> > > =C2=A0=C2=A0 (Thomas)
> > > v3:
> > > =C2=A0- Skip handles in purge path (sashiko)
> > > v5:
> > > =C2=A0- Refactor into ttm_pool_backup_folio (Thomas)
> > >=20
> > > [1] https://patchwork.freedesktop.org/series/165330/
> > > ---
> > > =C2=A0drivers/gpu/drm/ttm/ttm_pool.c | 110
> > > ++++++++++++++++++++++++++++---
> > > --
> > > =C2=A01 file changed, 94 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > > b/drivers/gpu/drm/ttm/ttm_pool.c
> > > index d380a3c7fe40..78efc8524133 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > @@ -1019,6 +1019,70 @@ void ttm_pool_drop_backed_up(struct ttm_tt
> > > *tt)
> > > =C2=A0	ttm_pool_free_range(NULL, tt, ttm_cached, start_page,
> > > tt-
> > > > num_pages);
> > > =C2=A0}
> > > =C2=A0
> > > +static int ttm_pool_backup_folio(struct ttm_pool *pool, struct
> > > ttm_tt *tt,
> > > +				 struct file *backup, struct
> > > folio
> > > *folio,
> > > +				 unsigned int order, bool
> > > writeback,
> > > +				 pgoff_t idx, gfp_t page_gfp,
> > > gfp_t
> > > alloc_gfp)
> >=20
> > I don't really understand why we can't end up with a
> > ttm_backup_backup_folio(), which I believe is the proper layering,
> > already at this point? Please see a suggestion at=20
> >=20
> > https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/ttm_swapout?re=
f_type=3Dheads
> >=20
> > Here the splitting logic is kept in the ttm_pool, but ttm_backup
> > supports handing large folios to it.
> >=20
> > Although the cumulative diffstat becomes larger, the end code
> > becomes
> > smaller and IMO easier to read, and we don't need to introduce code
> > that we immediately have to refactor.
>=20
> That version looks fine too. If that is preference no issue.

Cool. Note that there is a bug in that we don't pass the folio order
into ttm_backup_backup_folio(). I'm force-pushing a fix for that.


>=20
> My goal with this series is get something than can reasonably be
> backported to LTS kernels so the desktop doesn't frequently enter
> kswapd
> because of fragmentation. We now have at least 3 reports of this
> being
> an issue.
>=20
> This is larger fix [1] which works in tandem but seemly unlikely to
> backportable given it add new concepts to the core MM [1].
>=20
> [1] https://patchwork.freedesktop.org/series/165329/
>=20
> >=20
> > But I'm starting to question the general approach: Even if the
> > *shrinker* can recover from a total kernel memory reserve
> > depletion, it
> > can't really be considered a reasonable practice, since if we
> > frequently deplete the reserves, *other* important allocations in
> > the
> > system like GFP_ATOMIC, PF_MEMALLOC may spuriously start to fail
> > and
> > people will have a hard time finding out why.
> >=20
>=20
> Wouldn=E2=80=99t GFP_ATOMIC enter direct reclaim, hit our shrinker, and
> eventually make progress=E2=80=94i.e., take the split path if needed? I=
=E2=80=99m not
> 100% sure, but my initial reaction is that this concern may not be
> valid; however, MM is hard to reason about.

No, GFP_ATOMIC just uses what's available without any reclaim at all.
It's more aggressive than GFP_NOWAIT in that it allows dipping into the
kernel reserves.

>=20
> Again, FWIW, I=E2=80=99ve tried a lot of things to trigger OOM=E2=80=94fo=
r example,
> running WebGL tabs and then kicking off various very memory-intensive
> workloads from the CLI=E2=80=94and I still haven=E2=80=99t hit OOM or see=
n memory
> allocation failures or warnings.
>=20
> > So I actually don't think we can be avoiding the splitting without
> > direct insertion. FWIW, up until recently when shmem started
> > supporting
>=20
> I agree direct insertion is better solution. Do you think this
> something
> we could reasonably get working and backport? I haven't done any
> research on direct insertion yet, thus why I'm asking.

Yes I think so. The problem would be to get it accepted. Looking into
that now, but hitting various kinds of subtle issues.

Thanks,
Thomas


>=20
> > huge page swapping, other GPU drivers basically also split pages at
> > swapout.
>=20
> I wonder if other drivers have the same issue? The deadly combo is
> allow
> GPUs to subscribe all of system memory, allocate THP pages (or higher
> order pages), and split them in the shrinker. Xe might be the only
> driver with right combo to hit this but not 100% sure without a deep
> dive.
>=20
> >=20
> > Another idea for improving on the compaction loop, perhaps worth
> > trying
> > is this change, shamelessly stolen from i915:
> >=20
> > https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/shrinker_batch=
?ref_type=3Dheads
> >=20
>=20
> I'd have to give this a try - I'm quickly running out of time before
> I
> leave for month though.
>=20
> Matt
>=20
> > /Thomas
> >=20
> >=20
> > > +{
> > > +	struct page *page =3D folio_page(folio, 0);
> > > +	int shrunken =3D 0, npages =3D 1UL << order, ret =3D 0, i;
> > > +	bool folio_has_been_split =3D false;
> > > +
> > > +	for (i =3D 0; i < npages; ++i) {
> > > +		s64 shandle;
> > > +
> > > +try_again_after_split:
> > > +		if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > > +		=C2=A0=C2=A0=C2=A0 should_fail(&backup_fault_inject, 1))
> > > +			shandle =3D -ENOMEM;
> > > +		else
> > > +			shandle =3D ttm_backup_backup_page(backup,
> > > page + i,
> > > +						=09
> > > writeback,
> > > idx + i,
> > > +						=09
> > > page_gfp,
> > > alloc_gfp);
> > > +
> > > +		if (shandle < 0 && !folio_has_been_split &&
> > > order) {
> > > +			pgoff_t j;
> > > +
> > > +			/*
> > > +			 * True OOM: could not allocate a shmem
> > > folio
> > > +			 * for the next subpage. Fall back to
> > > splitting
> > > +			 * the source compound and backing up
> > > subpages
> > > +			 * individually. Release the already-
> > > backed-
> > > up
> > > +			 * subpages whose contents now live in
> > > shmem;
> > > +			 * any further failure terminates the
> > > loop
> > > with
> > > +			 * partial progress (handled by the
> > > caller).
> > > +			 */
> > > +			folio_has_been_split =3D true;
> > > +			ttm_pool_split_for_swap(pool, page);
> > > +
> > > +			for (j =3D 0; j < i; ++j) {
> > > +				__free_pages_gpu_account(page +
> > > j,
> > > 0, false);
> > > +				shrunken++;
> > > +			}
> > > +
> > > +			goto try_again_after_split;
> > > +		} else if (shandle < 0) {
> > > +			ret =3D shandle;
> > > +			goto out;
> > > +		} else if (folio_has_been_split) {
> > > +			__free_pages_gpu_account(page + i, 0,
> > > false);
> > > +			shrunken++;
> > > +		}
> > > +
> > > +		tt->pages[idx + i] =3D
> > > ttm_backup_handle_to_page_ptr(shandle);
> > > +	}
> > > +
> > > +	if (!folio_has_been_split) {
> > > +		/* Compound fully backed up; free at native
> > > order.
> > > */
> > > +		page->private =3D 0;
> > > +		__free_pages_gpu_account(page, order, false);
> > > +		shrunken +=3D npages;
> > > +	}
> > > +
> > > +out:
> > > +	return shrunken ? shrunken : ret;
> > > +}
> > > +
> > > =C2=A0/**
> > > =C2=A0 * ttm_pool_backup() - Back up or purge a struct ttm_tt
> > > =C2=A0 * @pool: The pool used when allocating the struct ttm_tt.
> > > @@ -1045,12 +1109,11 @@ long ttm_pool_backup(struct ttm_pool
> > > *pool,
> > > struct ttm_tt *tt,
> > > =C2=A0{
> > > =C2=A0	struct file *backup =3D tt->backup;
> > > =C2=A0	struct page *page;
> > > -	unsigned long handle;
> > > =C2=A0	gfp_t alloc_gfp;
> > > =C2=A0	gfp_t gfp;
> > > =C2=A0	int ret =3D 0;
> > > =C2=A0	pgoff_t shrunken =3D 0;
> > > -	pgoff_t i, num_pages;
> > > +	pgoff_t i, num_pages, npages;
> > > =C2=A0
> > > =C2=A0	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> > > =C2=A0		return -EINVAL;
> > > @@ -1070,7 +1133,8 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > > struct ttm_tt *tt,
> > > =C2=A0			unsigned int order;
> > > =C2=A0
> > > =C2=A0			page =3D tt->pages[i];
> > > -			if (unlikely(!page)) {
> > > +			if (unlikely(!page ||
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0
> > > ttm_backup_page_ptr_is_handle(page))) {
> > > =C2=A0				num_pages =3D 1;
> > > =C2=A0				continue;
> > > =C2=A0			}
> > > @@ -1106,26 +1170,40 @@ long ttm_pool_backup(struct ttm_pool
> > > *pool,
> > > struct ttm_tt *tt,
> > > =C2=A0	if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > > should_fail(&backup_fault_inject, 1))
> > > =C2=A0		num_pages =3D DIV_ROUND_UP(num_pages, 2);
> > > =C2=A0
> > > -	for (i =3D 0; i < num_pages; ++i) {
> > > -		s64 shandle;
> > > +	for (i =3D 0; i < num_pages; i +=3D npages) {
> > > +		unsigned int order;
> > > =C2=A0
> > > +		npages =3D 1;
> > > =C2=A0		page =3D tt->pages[i];
> > > =C2=A0		if (unlikely(!page))
> > > =C2=A0			continue;
> > > =C2=A0
> > > -		ttm_pool_split_for_swap(pool, page);
> > > +		/* Already-handled entry from a previous
> > > attempt. */
> > > +		if
> > > (unlikely(ttm_backup_page_ptr_is_handle(page)))
> > > +			continue;
> > > =C2=A0
> > > -		shandle =3D ttm_backup_backup_page(backup, page,
> > > flags->writeback, i,
> > > -						 gfp,
> > > alloc_gfp);
> > > -		if (shandle < 0) {
> > > -			/* We allow partially shrunken tts */
> > > -			ret =3D shandle;
> > > +		order =3D ttm_pool_page_order(pool, page);
> > > +		npages =3D 1UL << order;
> > > +
> > > +		/*
> > > +		 * Back up the compound atomically at its native
> > > order. If
> > > +		 * fault injection truncated num_pages mid-
> > > compound,
> > > skip
> > > +		 * the partial tail rather than splitting.
> > > +		 */
> > > +		if (unlikely(i + npages > num_pages))
> > > +			break;
> > > +
> > > +		ret =3D ttm_pool_backup_folio(pool, tt, backup,
> > > page_folio(page),
> > > +					=C2=A0=C2=A0=C2=A0 order, flags-
> > > >writeback,
> > > i, gfp,
> > > +					=C2=A0=C2=A0=C2=A0 alloc_gfp);
> > > +		if (unlikely(ret < 0))
> > > +			break;
> > > +
> > > +		shrunken +=3D ret;
> > > +
> > > +		/* partial backup */
> > > +		if (unlikely(ret !=3D npages))
> > > =C2=A0			break;
> > > -		}
> > > -		handle =3D shandle;
> > > -		tt->pages[i] =3D
> > > ttm_backup_handle_to_page_ptr(handle);
> > > -		__free_pages_gpu_account(page, 0, false);
> > > -		shrunken++;
> > > =C2=A0	}
> > > =C2=A0
> > > =C2=A0	return shrunken ? shrunken : ret;
