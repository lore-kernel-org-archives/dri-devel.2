Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B67CC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964FA10E93C;
	Tue, 28 Jul 2026 14:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q01HJXvn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D61410E942;
 Tue, 28 Jul 2026 14:45:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 51F5D60A92;
 Tue, 28 Jul 2026 14:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8801F000E9;
 Tue, 28 Jul 2026 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785249917;
 bh=6ofsQVz/jTvgeGCIAkpQYaoUd8Kbuw12sUGv5gvYdZc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q01HJXvnu0p0t8rJUJJ4tRfPHsJl0WDOCtNch9zqMCFMp/rmrkK8eVsgY7aLp68Gp
 6RsunsJBN7wPqHdjHOvZelLNvs6MSi+1SUdfiKmZrnFKyxACIJe+tC7SlU8uMec5tA
 qL5dsIz8lj1K6A5I0Iie+Vd+JiBBuL6JsmFtNo5e1KY0BXL5Z5jaQcpsw6fVq2wXgM
 BdFtpeZojuU+mEfldcT2mkbYFh6BWESVwLNpvQMjiBDIxuJynezWaSbB1COQigS9/e
 fA2qkj+zUZD/DkFRTOh9wgjVBAVe16pb6ApEVDAjCPnadrXv3ttc4sIPeMEa5WvPx4
 uJBPlSAmB+p/w==
Date: Tue, 28 Jul 2026 15:44:57 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, 
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Dave Airlie <airlied@redhat.com>, 
 Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] mm/huge_memory: add folio_split_driver_managed()
Message-ID: <ami_wF2QhQ1ZM6-f@lucifer>
References: <20260722044220.1110278-1-matthew.brost@intel.com>
 <DK564OOZ3JUK.292JORO9KGKEV@nvidia.com>
 <DK57FVTRTLR2.1A906PYJ2TCE4@nvidia.com>
 <a0c06d8c-fc3a-4ede-8aba-8c7430027a35@kernel.org>
 <2FD2B991-09B3-40EE-8230-49BE3A239EEC@nvidia.com>
 <603ef1ec-bccc-4fe4-9523-e8b8a731be63@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <603ef1ec-bccc-4fe4-9523-e8b8a731be63@kernel.org>
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

On Tue, Jul 28, 2026 at 02:58:39PM +0200, David Hildenbrand (Arm) wrote:
> On 7/27/26 20:23, Zi Yan wrote:
> > On 27 Jul 2026, at 13:33, David Hildenbrand (Arm) wrote:
> >
> >> On 7/22/26 17:28, Zi Yan wrote:
> >>>
> >>> Strickly speaking, these vm_insert*() compound pages are not folios,
> >>> since folios are supposed to be rmappable and they are either anonymous
> >>> memory or file-backed memory. I am working on separating them from
> >>> rmappable folios by replacing PG_private with PG_folio and marking all
> >>> pages in a folio with PG_folio in page_rmappable_folio().
> >>>
> >>> Hopefully, we can find a better name, like refcounted_folio, later for
> >>> these non-rmappable compound pages.
> >>
> >> They wouldn't really be folios, I guess. They would likely be a simple
> >> "refcounted" memtype that allows for compound pages.
> >
> > Yes, they are not folios. But “folio” was started to replace “compound page”
> > and slowly becomes rmappable anon and file-backed. People outside MM still
> > thinks “folio” == “compound page”.
>
> Yes, it's a bit of a mess now.
>
> > But once I manage to remove PG_private
> > and get us PG_folio, page_folio() will return NULL for non-folio compound
> > pages and we will need a new type for them, “refcounted_XXX”. We can decide
> > XXX when I get there. :)
>
> So far willy did not document a type that just has a refcount.
>
> https://kernelnewbies.org/MatthewWilcox/Memdescs

I was going to say.

It seems a bit specific, because different things might have a different use for
'pages with refcounts that shouldn't be touched by core mm' and different
semantics perhaps.

Obviously if it was a different memdesc type then it'd not be a folio.

>
> Maybe "Managed memory" (struct mgdesc) could be the right thing for some memory
> with a refcount.
>
> The question is, if the use case at hand would even require a refcount, of if
> frozen pages would be good enough.
>
> >
> >>
> >> But what is the conclusion here? It sounds like "folio_split_" is the entirely
> >> wrong interface for these compound pages.

Yeah the thing is we need some clarification on what is a folio exactly.

	A folio is a physically, virtually and logically contiguous set of
	bytes.  It is a power-of-two in size, and it is aligned to that same
	power-of-two.  It is at least as large as %PAGE_SIZE.  If it is in the
	page cache, it is at a file offset which is a multiple of that
	power-of-two.  It may be mapped into userspace at an address which is at
	an arbitrary page offset, but its kernel virtual address is aligned to
	its size.

By that definition a compound page _is_ a folio. And anything that _could_ be
mapped into userland.

But if we are going to say folio == rmappable then can we actually update the
description of folio to say so?

Or perhaps reference the fact that 'transitionally' it is as above, but in
future will mean only rmappable.

> >
> > We probably would allow folio_split() to be used on compound pages now
> > until we can make a clean distinction, e.g., using PG_folio, between them.
> >
> > Yes, folio_split() and its helper functions are meant for rmappable anon and
> > file-backed folios. But currently “folio” is de facto “compound page”, since
> > for example prep_compound_head() initializes folio fields even if it is meant
> > only for compound pages.
>
> If we can stop more abuse right from the start, that would be nice.

Yes.

>
> We do have split_page() that splits a non-compound higher-order page. Maybe we
> want a split_compound_page(), or allow for split_page() to accept compound pages.

Ha! I read this after making this very same suggestion. High.. 5?

But yeah obviously agree.

>
> Because splitting a folio is really something different than splitting just some
> compound page (no mapping/pagecache/whatever involved).

Yup.

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
