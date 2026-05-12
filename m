Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC143CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E4610EA3F;
	Tue, 12 May 2026 11:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jyU+gTot";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A371B10EA3F;
 Tue, 12 May 2026 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778585480; x=1810121480;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=V6Uv9TsQGyM3BpUljm+Hu+p0og4dIdrPBdVttzvu94U=;
 b=jyU+gToth8R0k1a48azdXi4zo54mFjr3movVbAj0JKZcBfOETj07+APQ
 tyuUvVE5Gt3xbbpx3lIxnK7JUqnBQugMC/tsH+Tt0A3HdzTcweV9H0iC0
 j0cXqv4r32d/PWsPrnpYAL7y3UMITs6QbMe0WKZoyC+AxO+Fkf0kh4weQ
 1jbrNyK4JB45veuTfZDXuNtVm82SN5jOW7ThK2GD9tanOJUA/Cn9R3eBC
 C8y7wTE0PlQaa12beG47A8xwr6js8I2Cwg3VGALM/1HiwAwI+NGUTH4E7
 vfz0qABqaAdvWuOaOYJeHln4B0ynaUH1CIDlvBw0Cm7zF7b7G4ggO7mwC Q==;
X-CSE-ConnectionGUID: AhbwN4oVR3Ow8EDpSn9mEw==
X-CSE-MsgGUID: QCKSpkctS46E8n4ca25QCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83106069"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="83106069"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 04:31:18 -0700
X-CSE-ConnectionGUID: QPACu6dxSXW/7GV7ONnHHQ==
X-CSE-MsgGUID: 1AekJlt5QxutbES8KnsWgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="236760144"
Received: from vpanait-mobl.ger.corp.intel.com (HELO [10.245.245.172])
 ([10.245.245.172])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 04:31:13 -0700
Message-ID: <b4800086347aa3b27edc42b6536cb3a2b76a1aa8.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] mm/shmem: add shmem_insert_folio()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, 
 intel-xe@lists.freedesktop.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
 <ljs@kernel.org>,  "Liam R. Howlett"	 <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport	 <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko	 <mhocko@suse.com>, Hugh Dickins
 <hughd@google.com>, Baolin Wang	 <baolin.wang@linux.alibaba.com>, Brendan
 Jackman <jackmanb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>, Zi
 Yan <ziy@nvidia.com>, Christian Koenig <christian.koenig@amd.com>,  Huang
 Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, Matthew
 Brost	 <matthew.brost@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, 	linux-kernel@vger.kernel.org
Date: Tue, 12 May 2026 13:31:09 +0200
In-Reply-To: <f14d99d3-c1ff-453b-a280-17b8c4d5af94@kernel.org>
References: <20260512110339.6244-1-thomas.hellstrom@linux.intel.com>
 <20260512110339.6244-2-thomas.hellstrom@linux.intel.com>
 <f14d99d3-c1ff-453b-a280-17b8c4d5af94@kernel.org>
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

Hi David,

Thanks for having a look.

On Tue, 2026-05-12 at 13:07 +0200, David Hildenbrand (Arm) wrote:
>=20
> > =C2=A0
> > +/**
> > + * undo_compound_page() - Reverse the effect of
> > prep_compound_page().
> > + * @page: The head page of a compound page to demote.
> > + *
> > + * Returns the pages to non-compound state as if
> > prep_compound_page()
> > + * had never been called.=C2=A0 split_page() must NOT have been called
> > on
> > + * the compound page; tail refcounts must be 0.=C2=A0 The caller must
> > ensure
> > + * no other users hold references to the compound page.
> > + */
> > +void undo_compound_page(struct page *page)
> > +{
> > +	unsigned int i, nr =3D 1U << compound_order(page);
> > +
> > +	page[1].flags.f &=3D ~PAGE_FLAGS_SECOND;
> > +	for (i =3D 1; i < nr; i++) {
> > +		page[i].mapping =3D NULL;
> > +		clear_compound_head(&page[i]);
> > +	}
> > +	ClearPageHead(page);
> > +}
> > +
> > =C2=A0static inline void set_buddy_order(struct page *page, unsigned in=
t
> > order)
> > =C2=A0{
> > =C2=A0	set_page_private(page, order);
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 3b5dc21b323c..45e80a74f77c 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -937,6 +937,111 @@ int shmem_add_to_page_cache(struct folio
> > *folio,
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * shmem_insert_folio() - Insert an isolated folio into a shmem
> > file.
> > + * @file: The shmem file created with shmem_file_setup().
> > + * @folio: The folio to insert. Must be isolated (not on LRU),
> > unlocked,
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 have exactly one re=
ference (the caller's), have no
> > page-table
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mappings, and have =
folio->mapping =3D=3D NULL.
> > + * @order: The allocation order of @folio.=C2=A0 If @order > 0 and
> > @folio is
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not already a large=
 (compound) folio, it will be
> > promoted to a
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compound folio of t=
his order inside this function.=C2=A0
> > This requires
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the standard post-a=
lloc state: head refcount =3D=3D 1, tail
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcounts =3D=3D 0 =
(i.e. split_page() must NOT have been
> > called).
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 On failure the prom=
otion is reversed and the folio is
> > returned
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to its original non=
-compound state.
> > + * @index: Page-cache index at which to insert. Must be aligned to
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << @order) and w=
ithin the file's size.
> > + * @writeback: If true, attempt immediate writeback to swap after
> > insertion.
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Best-effort; failure is silently ignored.
> > + * @folio_gfp: The GFP flags to use for memory-cgroup charging.
> > + *
> > + * The folio is inserted zero-copy into the shmem page cache and
> > placed on
> > + * the anon LRU, where it participates in normal kernel reclaim
> > (written to
> > + * swap under memory pressure).=C2=A0 Any previous content at @index i=
s
> > discarded.
> > + * On success the caller should release their reference with
> > folio_put() and
> > + * track the (@file, @index) pair for later recovery via
> > shmem_read_folio()
> > + * and release via shmem_truncate_range().
> > + *
> > + * Return: 0 on success.=C2=A0 On failure the folio is returned to its
> > original
> > + * state and the caller retains ownership.
> > + */
> > +int shmem_insert_folio(struct file *file, struct folio *folio,
> > unsigned int order,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pgoff_t index, bool writeback, =
gfp_t
> > folio_gfp)
> > +{
> > +	struct address_space *mapping =3D file->f_mapping;
> > +	struct inode *inode =3D mapping->host;
> > +	bool promoted;
> > +	long nr_pages;
> > +	int ret;
> > +
> > +	promoted =3D order > 0 && !folio_test_large(folio);
> > +	if (promoted)
> > +		prep_compound_page(&folio->page, order);
> > +	nr_pages =3D folio_nr_pages(folio);
> > +
> > +	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> > +	VM_BUG_ON_FOLIO(folio_mapped(folio), folio);
> > +	VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
> > +	VM_BUG_ON_FOLIO(folio->mapping, folio);
> > +	VM_BUG_ON(index !=3D round_down(index, nr_pages));
>=20
> No new VM_BUG_ON_FOLIO etc.

OK, can eliminate those. Is VM_WARN_ON_FOLIO() preferred,
or any other type of assert?

>=20
> But in general, pushing in random allocated pages into shmem,
> converting them to
> folios is not something I particularly enjoy seeing.
>=20

OK, let me understand the concern. The pages are allocated as multi-
page folios using alloc_pages(gfp, order), but typically not promoted
to compound pages, until inserted here. Is it that promotion that is of
concern or inserting pages of unknown origin into shmem? Anything we
can do to alleviate that concern?

Given the problem statement in the cover-letter, would there be a
better direction to take here? We could, for example, bypass shmem and
insert the folios directly into the swap-cache, (although there is an
issue with the swap-cache when the number of swap_entries are close to
being depleted).

https://patchwork.freedesktop.org/series/165518/

Thanks,
Thomas


