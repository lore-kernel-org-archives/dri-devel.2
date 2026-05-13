Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A09FCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 08:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD9910ED40;
	Wed, 13 May 2026 08:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="V4gt8IOd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E89110E4CB;
 Wed, 13 May 2026 08:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778661117; x=1810197117;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=w3N7ovtfdrXvSPC3SyFkABxeYzl70HsVKnN1MgRa4Is=;
 b=V4gt8IOdzu+MvGxDzgxW1aC0W7e6NS1gYHIiZucdMKuSZQezbAfP9twR
 mzIhYnPVEtgR/shufdXRIccwu2cvYNCqb98UCxEpn7XhGkx33HKi0LxdN
 v2XNMWvnjfnUCIV2YGJxysuhQMlJQoMRRjzk3bUFaujkAPqKks5JcrQQm
 rQb71MGEXi5sR5cIQ+sajoHzY2ED4Tycdg5d3c+UsJ4MVGRjICv0a2Sdj
 K7zCOzav10LYg1XoSgRQpBWDy3fxdOS4JVL4MkyyYGQxRJ5cYF61ajmNf
 CLnU7y+yCds45T7UDn7U48xo0bSMKwRuzMZ68AcVpgIU19978hrDHBfM4 g==;
X-CSE-ConnectionGUID: nsd8djcbSCSyXGu3zZGmqQ==
X-CSE-MsgGUID: 593v/eH6RCqnYVxMAYZ2aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79477230"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="79477230"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 01:31:56 -0700
X-CSE-ConnectionGUID: wn1YwuwwQrqVza82LHbydQ==
X-CSE-MsgGUID: noPPLi1GSd63I02KpUCjFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="261764851"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.49])
 ([10.245.244.49])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 01:31:50 -0700
Message-ID: <68705cec43ab43088327b21c9d9318036fb2a255.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] mm/shmem: add shmem_insert_folio()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David
 Hildenbrand (Arm)" <david@kernel.org>, intel-xe@lists.freedesktop.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
 <ljs@kernel.org>,  "Liam R. Howlett"	 <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport	 <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko	 <mhocko@suse.com>, Hugh Dickins
 <hughd@google.com>, Baolin Wang	 <baolin.wang@linux.alibaba.com>, Brendan
 Jackman <jackmanb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>, Zi
 Yan <ziy@nvidia.com>, Huang Rui <ray.huang@amd.com>, Matthew Auld	
 <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 10:31:47 +0200
In-Reply-To: <c6b4031a-5625-4b1b-8a51-6e47241d32c9@amd.com>
References: <20260512110339.6244-1-thomas.hellstrom@linux.intel.com>
 <20260512110339.6244-2-thomas.hellstrom@linux.intel.com>
 <f14d99d3-c1ff-453b-a280-17b8c4d5af94@kernel.org>
 <b4800086347aa3b27edc42b6536cb3a2b76a1aa8.camel@linux.intel.com>
 <26479389-459b-4cc4-914d-e7d29d5e5cc9@kernel.org>
 <c6b4031a-5625-4b1b-8a51-6e47241d32c9@amd.com>
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

Hi, David & Christian,

Thanks for the feedback. I'll respin this to see if I can come up with
something that is more acceptable given the comments.

A couple of questions and comments below.

On Wed, 2026-05-13 at 09:47 +0200, Christian K=C3=B6nig wrote:
> Hi David & Thomas,
>=20
> On 5/12/26 22:03, David Hildenbrand (Arm) wrote:
> > On 5/12/26 13:31, Thomas Hellstr=C3=B6m wrote:
> ...
> > > > > +int shmem_insert_folio(struct file *file, struct folio
> > > > > *folio,
> > > > > unsigned int order,
> > > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pgoff_t index, bool write=
back, gfp_t
> > > > > folio_gfp)
> > > > > +{
> > > > > +	struct address_space *mapping =3D file->f_mapping;
> > > > > +	struct inode *inode =3D mapping->host;
> > > > > +	bool promoted;
> > > > > +	long nr_pages;
> > > > > +	int ret;
> > > > > +
> > > > > +	promoted =3D order > 0 && !folio_test_large(folio);
> > > > > +	if (promoted)
> > > > > +		prep_compound_page(&folio->page, order);
> > > > > +	nr_pages =3D folio_nr_pages(folio);
> > > > > +
> > > > > +	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> > > > > +	VM_BUG_ON_FOLIO(folio_mapped(folio), folio);
> > > > > +	VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
> > > > > +	VM_BUG_ON_FOLIO(folio->mapping, folio);
> > > > > +	VM_BUG_ON(index !=3D round_down(index, nr_pages));
> > > >=20
> > > > No new VM_BUG_ON_FOLIO etc.
> > >=20
> > > OK, can eliminate those. Is VM_WARN_ON_FOLIO() preferred,
> > > or any other type of assert?
> >=20
> > VM_WARN_ON_FOLIO() is usually what you want, or VM_WARN_ON_ONCE().
> >=20
> > >=20
> > > >=20
> > > > But in general, pushing in random allocated pages into shmem,
> > > > converting them to
> > > > folios is not something I particularly enjoy seeing.
> > > >=20
> > >=20
> > > OK, let me understand the concern. The pages are allocated as
> > > multi-
> > > page folios using alloc_pages(gfp, order), but typically not
> > > promoted
> > > to compound pages, until inserted here. Is it that promotion that
> > > is of
> > > concern or inserting pages of unknown origin into shmem? Anything
> > > we
> > > can do to alleviate that concern?
> >=20
> > It's all rather questionable.
> >=20
> > A couple of points:
> >=20
> > a) The pages are allocated to be unmovable, but adding them to
> > shmem effectively
> > =C2=A0=C2=A0 turns them movable. Now you interfere with the page alloca=
tor
> > logic of
> > =C2=A0=C2=A0 placing movable and unmovable pages a reasonable way into
> > =C2=A0=C2=A0 pageblocks that group allocations of similar types.
> >=20
> > b) A driver is not supposed to decide which folio size will be
> > allocated for
> > =C2=A0=C2=A0 shmem.
>=20
> Exactly that is one of the major reasons why we aren't using a shmem
> as backing store for TTM buffers in the first place.
>=20
> While HW today can usually work with everything down to 4k it needs
> higher order pages for optimal performance.
>=20
> So for example for AMD GPUs you need 2M pages or otherwise the
> performance goes down by ~30% in quite a number of use cases.
>=20
> Everything between 4k and 2M and above 2M is still preferred because
> it results in better L0/L1 reach, but if you can't get 2M the L2
> reach goes down so rapidly that people start to complain immediately.
>=20
> And that stuff is very specific for each vendor and HW generation.
> Some have the sweet spot at 64k, some at 256k, most at 2M.
>=20
> > =C2=A0=C2=A0 I am not even sure if there is a fencing on
> > =C2=A0=C2=A0 CONFIG_TRANSPARENT_HUGEPAGE somewhere when ending up with =
large
> > folios. order
> > =C2=A0=C2=A0 > PMD_ORDER is currently essentially unsupported, and I su=
spect
> > your code
> > =C2=A0=C2=A0 would=C2=A0 even allow for that (looking at
> > ttm_pool_alloc_find_order).
> >=20
> > =C2=A0=C2=A0 We also have some problems with the pagecache not actually
> > supporting all
> > =C2=A0=C2=A0 MAX_PAGE_ORDER orders (see MAX_PAGECACHE_ORDER).
> >=20
> > =C2=A0=C2=A0 You are bypassing shmem logic to decide on that completely=
.
> >=20
> > =C2=A0=C2=A0 While these things might not actually cause harm for you t=
oday
> > (although I
> > =C2=A0=C2=A0 suspect some of them might in shmem swapout code), we don'=
t want
> > drivers to
> > =C2=A0=C2=A0 make our life harder by doing completely unexpected things=
.
>=20
> Yeah but that is the requirement the HW has.
>=20
> I mean we can keep torturing the buddy allocator to give us 2M pages,
> but essentially we want to get away from those specialized solutions
> and has more of the functionality necessary to driver the HW in the
> common Linux memory management code because that prevents vendors
> from re-implementing that stuff in their specific driver over and
> over again.

For the code at hand, if we insert an order 10 folio shmem will split
it at writeout time but spit out a warning (if enabled) at the same
time. For this particular use-case, I think it might make sense for the
drivers that use direct insertion to cap the page-allocator orders to
THP size (2M).

>=20
> Regards,
> Christian.
>=20
> > c) You pass folio + order, which is just the red flag that you are
> > doing
> > =C2=A0=C2=A0 something extremely dodgy.
> >=20
> > =C2=A0=C2=A0 You just cast something that is not a folio, and was not
> > allocated to be a
> > =C2=A0=C2=A0 folio to a folio through page_folio(page). That will stop
> > working completely
> > =C2=A0=C2=A0 in the future once we decouple struct page from struct fol=
io.
> >=20
> > =C2=A0=C2=A0 If it's not a folio with a proper set order, you should be
> > passing page +
> > =C2=A0=C2=A0 order.
> >=20
> > d) We are once more open-coding creation of a folio, by hand-
> > crafting it
> > =C2=A0=C2=A0 ourselves.
> >=20
> > =C2=A0=C2=A0 We have folio_alloc() and friends for a reason. Where we, =
for
> > example, do a
> > =C2=A0=C2=A0 page_rmappable_folio().
> >=20
> > =C2=A0=C2=A0 I am pretty sure that you are missing a call to
> > page_rmappable_folio(),
> > =C2=A0=C2=A0 resulting in the large folios not getting
> > folio_set_large_rmappable() set.
> >=20
> > e) undo_compound_page(). No words.
> >=20
> >=20
> >=20
> > *maybe* it would be a little less bad if you would just allocate a
> > compound page
> > in your driver and use page_rmappable_folio() in there.

OK, yes it sounds like a prereq for this is that the driver actually
allocates compound pages. It might be that the TTM comment about *not*
doing that is stale, but need to check.

Would it be acceptable to export a function from core mm to split an
isolated folio?

> >=20
> > That wouldn't change a) or b), though.
> >=20
> >=20
> > >=20
> > > Given the problem statement in the cover-letter, would there be a
> > > better direction to take here? We could, for example, bypass
> > > shmem and
> > > insert the folios directly into the swap-cache, (although there
> > > is an
> > > issue with the swap-cache when the number of swap_entries are
> > > close to
> > > being depleted).
> >=20
> > Good question.
> > We'd have to keep swapoff and all of that working. For example, in
> > try_to_unuse(), we special-case shmem_unuse() to handle non-
> > anonymous pages.
> >=20
> > But then, the whole swapcache operates on folios ... so I am not
> > sure if there
> > is a lot to be won by re-implementing what shmem already does?
> >=20

Still that would alleviate a) and b), right? At least as long as we
keep folio sizes within the swap cache limits?

Thanks,
Thomas

