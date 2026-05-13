Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7EFCD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 10:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 621DC10EDE4;
	Wed, 13 May 2026 10:37:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Io6MBFJe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F0B10E4F2;
 Wed, 13 May 2026 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778668631; x=1810204631;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=BxjfMH/H3au7DOcyqElNJ36t78ne1+5k8Gh44S/bASU=;
 b=Io6MBFJeq4hG5jpAIWIIBWuBGVPkNTs0Tvcvoi15CrdVEQjn7nG6f+n/
 6W8PndAIAuWnqworsulSA0SD/QWOIRrR3jrW+781uUH1slp5Ebx4rHRqT
 fetfpWAm+CmiJYj+8brIAz8xSw6TL+KI3jMhbMkR1I8YGXZfw4O+wwSI1
 DsO7h51Pa2CoW3Nm5CKL9WORu3TvNgKgqqhwMMI9g0iul7pO01JyG4hQ2
 kXvSLz6FY/1Xw/N/pgZR+cYTRL+Mx4Rhdnjb1z2qaGX/aAB7TXjaBsB2n
 VL6qhz/RYeT+sQlX/BBIaNYo6/deIqXBZ8BsWprf6pRJy4GEToE6K7PNz Q==;
X-CSE-ConnectionGUID: Rj8XZO7uQwSgH9i4q88SrQ==
X-CSE-MsgGUID: 4MGGhPoyS7Oy4cBHxcIjiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="105051552"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="105051552"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 03:37:10 -0700
X-CSE-ConnectionGUID: tg4Gi978RJefcU6sBiWAiQ==
X-CSE-MsgGUID: 7s6mhKSbQj2Zwhr+kHYyOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="242401523"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.49])
 ([10.245.244.49])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 03:37:05 -0700
Message-ID: <c0b5b94dfb4d04a1319bfb110f326afd2c29d48b.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] mm/shmem: add shmem_insert_folio()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, intel-xe@lists.freedesktop.org
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
Date: Wed, 13 May 2026 12:37:01 +0200
In-Reply-To: <65596f86-e6a3-48b0-aa3d-2e608964e29d@kernel.org>
References: <20260512110339.6244-1-thomas.hellstrom@linux.intel.com>
 <20260512110339.6244-2-thomas.hellstrom@linux.intel.com>
 <f14d99d3-c1ff-453b-a280-17b8c4d5af94@kernel.org>
 <b4800086347aa3b27edc42b6536cb3a2b76a1aa8.camel@linux.intel.com>
 <26479389-459b-4cc4-914d-e7d29d5e5cc9@kernel.org>
 <c6b4031a-5625-4b1b-8a51-6e47241d32c9@amd.com>
 <bbde0793-fd21-4a9c-b85d-f13d8b787c50@kernel.org>
 <1ce447ceea88bbe56c7d28654a51fc2856a7f986.camel@linux.intel.com>
 <65596f86-e6a3-48b0-aa3d-2e608964e29d@kernel.org>
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

On Wed, 2026-05-13 at 12:03 +0200, David Hildenbrand (Arm) wrote:
> On 5/13/26 10:51, Thomas Hellstr=C3=B6m wrote:
> > On Wed, 2026-05-13 at 10:37 +0200, David Hildenbrand (Arm) wrote:
> > > On 5/13/26 09:47, Christian K=C3=B6nig wrote:
> > > > Hi David & Thomas,
> > > >=20
> > > > ...
> > > >=20
> > > > Exactly that is one of the major reasons why we aren't using a
> > > > shmem as backing store for TTM buffers in the first place.
> > >=20
> > > What was the problem with that the last time this was considered?
> > >=20
> > > shmem nowadays supports THP (e.g., 2M) and even mTHP (e.g., 64K).
> > >=20
> > > For internal mounts, it must be enabled accordingly
> > > (/sys/kernel/mm/transparent_hugepage/.../shmem_enabled).
> > >=20
> > > Some distributions still default to "never". I guess if an admin
> > > enables it, you
> > > would just get THPs.
> >=20
> > FWIW, the i915 driver which uses shmem "natively" uses a special
> > mount
> > here that gives back THPs.
> >=20
> > >=20
> > > If "distro default" is the only problem, I guess we could think
> > > about
> > > how to
> > > improve that. For example, just let internal GPU DRM objects
> > > allocate
> > > any folio
> > > size available and supported etc.
> > >=20
> > > Would that make it possible to just use shmem natively? (e.g.,
> > > how
> > > would this
> > > interact with shmem features like folio migration, would that be
> > > workable with
> > > DRM objects?).
> >=20
> > Currently the drivers that use shmem in this way use
> > "mapping_set_unevictable()" as long as the object is bound to the
> > GPU.
> > Then shrinkers can unbind from GPU and revert that setting.
>=20
> Right, but mapping_set_unevictable() only affects folio_evictable() -
> -reclaim
> behavior. Not other properties (such as folio migration).

Interesting. Does that imply that a shmem folio can be replaced
underneath without additional measures? It looks like most DRM
call sites imply that mapping_set_unevictable() pins underlying shmem
folios


>=20
> >=20
> > The problem, (as also stated in the cover letter of this series) is
> > for
> > drivers that need to change caching of the pages to WC or UC.
>=20
> I assume you mean "To be able to easily maintain pools of pages
> mapped uncached
> or write-combined".
>=20

Exactly.


> Can you point me at the code that changes the caching of the pages?



x86 implementation is here:
https://elixir.bootlin.com/linux/v7.1-rc3/source/arch/x86/mm/pat/set_memory=
.c#L2556

TTM calls it here:
https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/gpu/drm/ttm/ttm_po=
ol.c#L249

And there are actually shmem helpers that do this as well, without
pooling.
https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/gpu/drm/drm_gem_sh=
mem_helper.c#L212


>=20
> > That's an
> > extremely costly operation so TTM needs to pool such allocations.
> > That's where using shmem natively becomes very ugly, because you
> > can't
> > really use a 1:1 mapping between shmem objects and DRM objects
> > anymore.
>=20
> So you would require different caching attributes within a DRM
> object?

The way the TTM pools work are that there are separate pools for each
allocation order and caching modes. That would essentially mean
allocations from a single shmem object would be spread out across
different pools, and we'd loose the 1:1 mapping between DRM objects and
shmem objects.

One alternative would be a single large sparse shmem object common for
all DRM objects, with a range allocator, but that also got pretty ugly
when I tried to implement that.

Finally, (and I think that might be what Christian was getting at as
well) Without CONFIG_TRANSPARENT_HUGEPAGE, we'd only see order 0 shmem
folios, right?

Thanks,
Thomas


