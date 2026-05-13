Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9633CD4F35
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 08:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F96D10ED51;
	Wed, 13 May 2026 08:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lJP070Cl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5253610E5B6;
 Wed, 13 May 2026 08:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778662290; x=1810198290;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=Gb6cdQvgIjVHP6q1cmpqeNRXvuWiP2WWdB4XYzroKVA=;
 b=lJP070ClFHv3Bff0hiN9rjQF/4SbWIAK2vZdj764pq2TZp7Jt2Lt4DWg
 oVnASCtbfqxxhFNfCavV2T/alLeo8gDq4RSyn+umYTMMRieUBaNTmjskZ
 V+0Eg7lPOBCJjcVYGDUJ9f7q2vU7FJyY8DYL14sz/irVPOz1g0pHAF8dv
 lYjhzVhCzCsJ+Ol1Z2h9oNRrkcGtWghO09JBBYUJDgAA7sirSJsObDDWJ
 MtScwWuNNPmi6WJeb1UJy4vRl49Ht8GYZF0iJYnEITKERPFpQ3L/zYjB5
 tZWDwPcsHARHQOGDrUZg5/tpAu24j1ksLiNNkga9MusVLZCNJOkjgJy7v g==;
X-CSE-ConnectionGUID: G3EBZSgFQLqiG9EWrPODAA==
X-CSE-MsgGUID: MZRyYpkuQ0qtJeTrkJjQ3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79478891"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="79478891"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 01:51:29 -0700
X-CSE-ConnectionGUID: lxKHFfy8S8yGC7CiOwCOCw==
X-CSE-MsgGUID: hT7mcpayQQ+0Z7a3TAKHHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="261767495"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.49])
 ([10.245.244.49])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 01:51:24 -0700
Message-ID: <1ce447ceea88bbe56c7d28654a51fc2856a7f986.camel@linux.intel.com>
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
Date: Wed, 13 May 2026 10:51:21 +0200
In-Reply-To: <bbde0793-fd21-4a9c-b85d-f13d8b787c50@kernel.org>
References: <20260512110339.6244-1-thomas.hellstrom@linux.intel.com>
 <20260512110339.6244-2-thomas.hellstrom@linux.intel.com>
 <f14d99d3-c1ff-453b-a280-17b8c4d5af94@kernel.org>
 <b4800086347aa3b27edc42b6536cb3a2b76a1aa8.camel@linux.intel.com>
 <26479389-459b-4cc4-914d-e7d29d5e5cc9@kernel.org>
 <c6b4031a-5625-4b1b-8a51-6e47241d32c9@amd.com>
 <bbde0793-fd21-4a9c-b85d-f13d8b787c50@kernel.org>
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

On Wed, 2026-05-13 at 10:37 +0200, David Hildenbrand (Arm) wrote:
> On 5/13/26 09:47, Christian K=C3=B6nig wrote:
> > Hi David & Thomas,
> >=20
> > On 5/12/26 22:03, David Hildenbrand (Arm) wrote:
> > > On 5/12/26 13:31, Thomas Hellstr=C3=B6m wrote:
> > ...
> > > >=20
> > > > OK, can eliminate those. Is VM_WARN_ON_FOLIO() preferred,
> > > > or any other type of assert?
> > >=20
> > > VM_WARN_ON_FOLIO() is usually what you want, or
> > > VM_WARN_ON_ONCE().
> > >=20
> > > >=20
> > > >=20
> > > > OK, let me understand the concern. The pages are allocated as
> > > > multi-
> > > > page folios using alloc_pages(gfp, order), but typically not
> > > > promoted
> > > > to compound pages, until inserted here. Is it that promotion
> > > > that is of
> > > > concern or inserting pages of unknown origin into shmem?
> > > > Anything we
> > > > can do to alleviate that concern?
> > >=20
> > > It's all rather questionable.
> > >=20
> > > A couple of points:
> > >=20
> > > a) The pages are allocated to be unmovable, but adding them to
> > > shmem effectively
> > > =C2=A0=C2=A0 turns them movable. Now you interfere with the page allo=
cator
> > > logic of
> > > =C2=A0=C2=A0 placing movable and unmovable pages a reasonable way int=
o
> > > =C2=A0=C2=A0 pageblocks that group allocations of similar types.
> > >=20
> > > b) A driver is not supposed to decide which folio size will be
> > > allocated for
> > > =C2=A0=C2=A0 shmem.
> >=20
> > Exactly that is one of the major reasons why we aren't using a
> > shmem as backing store for TTM buffers in the first place.
>=20
> What was the problem with that the last time this was considered?
>=20
> shmem nowadays supports THP (e.g., 2M) and even mTHP (e.g., 64K).
>=20
> For internal mounts, it must be enabled accordingly
> (/sys/kernel/mm/transparent_hugepage/.../shmem_enabled).
>=20
> Some distributions still default to "never". I guess if an admin
> enables it, you
> would just get THPs.

FWIW, the i915 driver which uses shmem "natively" uses a special mount
here that gives back THPs.

>=20
> If "distro default" is the only problem, I guess we could think about
> how to
> improve that. For example, just let internal GPU DRM objects allocate
> any folio
> size available and supported etc.
>=20
> Would that make it possible to just use shmem natively? (e.g., how
> would this
> interact with shmem features like folio migration, would that be
> workable with
> DRM objects?).

Currently the drivers that use shmem in this way use
"mapping_set_unevictable()" as long as the object is bound to the GPU.
Then shrinkers can unbind from GPU and revert that setting.

The problem, (as also stated in the cover letter of this series) is for
drivers that need to change caching of the pages to WC or UC. That's an
extremely costly operation so TTM needs to pool such allocations.
That's where using shmem natively becomes very ugly, because you can't
really use a 1:1 mapping between shmem objects and DRM objects anymore.

Thanks,
Thomas


