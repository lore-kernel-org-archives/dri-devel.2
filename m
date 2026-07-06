Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B312C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C1110E273;
	Mon,  6 Jul 2026 14:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IiEjoMl/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA8610E273;
 Mon,  6 Jul 2026 14:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783348108; x=1814884108;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=vZWrmCgooqGaeLMQA0CJMhP9+N3djHYev7afW/QNC5s=;
 b=IiEjoMl/bwXTQUJUe12HovqzwD7Kxq63mWfl11hE1B2QAauQzJqJnpOq
 44ariqOKeKujwN2iRu5cjt192KfaQO9tBH+Z7E2nw/F66c3EGSjlHF7zE
 MRBSlgnJY9G7vD7aOhJSQH0rROQdJclrsDHHFT1QTPAGUK329lDHU/cL/
 G6HXmB4IRy3wgVN+/oIkxozFVp2GzNAu4kRpoQKFownASxKzu2424SPf7
 3dWRodUOZhyJrEyArUGRfCeBM2uKPCwE4UhU0kT5yxBzeJXQOWNfoQhhz
 01Iot8mWfF8Jkv/pFymmfWTnXYrE0GGYjwSFTqoZQhIbsseSeCM0mgtGG w==;
X-CSE-ConnectionGUID: 8ooMJLFwQKCF2ZT9JBejGA==
X-CSE-MsgGUID: nA1wfQ98QF29iaCTlLcf8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="87662090"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="87662090"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 07:28:27 -0700
X-CSE-ConnectionGUID: Zf/XojuVTFmI51ZpegllVg==
X-CSE-MsgGUID: 7fDr0dcwSFqbvx5P0d3NwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="251049438"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.132])
 ([10.245.244.132])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 07:28:24 -0700
Message-ID: <c5f38603809c5385d2eb8937762b92c4f56c18f9.camel@linux.intel.com>
Subject: Re: drm/ttm/memcg/lru: enable memcg tracking for ttm, xe and amdgpu
 driver (part 2) (v2).
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
 tj@kernel.org, christian.koenig@amd.com, Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt	 <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>,
 simona@ffwll.ch, 	intel-xe@lists.freedesktop.org
Date: Mon, 06 Jul 2026 16:28:22 +0200
In-Reply-To: <CAPM=9txKzx6qji23YpY=d6Wrd-se-abZoOmDUW32HCx5YsL0tA@mail.gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
 <CAPM=9txKzx6qji23YpY=d6Wrd-se-abZoOmDUW32HCx5YsL0tA@mail.gmail.com>
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

On Mon, 2026-07-06 at 17:55 +1000, Dave Airlie wrote:
> On Mon, 6 Jul 2026 at 15:23, Dave Airlie <airlied@gmail.com> wrote:
> >=20
> > This is just a repost with a number of sashiko identified problems
> > that I fixed.
> >=20
> > I committed the vmstat counters and list lru changes, and they are
> > now in tree.
> >=20
> > This is the remainder of this series. Intel have expressed interest
> > in getting
> > this landed for xe, we can drop the amdgpu changes for now if they
> > can't get
> > across the line.
>=20
> I've put the latest code at
> https://github.com/airlied/linux/tree/ttm-memcg-objcg
>=20
> I've been fixing more sashiko found issues in there before I repost
> in
> a few days.
>=20
> I've reordered things a little in the branch but mostly the same
> code.
>=20
> Dave.

I have a couple of additional patches to this series to ensure shmem
memory allocated as part of shrinking or swapout ends up accounted to
the same cgroup that allocated the TTM memory. It looks like recursive
per-cgroup shrinking is not an issue, since somebody thought about that
already.

>=20
> >=20
> > I've dropped all previous acks/reviews.
> >=20
> > This series adds the memcg counters for GPU active and GPU reclaim
> > to align
> > with the two global vmstats. It adds an accounting flag to TTM
> > alloc/populate,
> > and enables memcg tracking and shrinker support in TTM.
> >=20
> > Then it adds amdgpu and xe support.
> >=20
> > I think for this to land, Christian holds the main objection which
> > I still fail
> > to fully understand beyond it doesn't solve all the problems we
> > ever have had
> > with cgroups and drm, so we shouldn't even bother, and maybe we
> > could do it at
> > the object level, and integrated with dmem, and android cross
> > process accounting,
> > but I still feel this is a good baseline.
> >=20
> > I think this is the right layer to hook this into TTM, where we
> > allocate memory
> > and I think accounting for this memory in a proper way should be
> > done.
> >=20
> > Intel folks (Thomas/Maarten) please review and express concerns as
> > well.

The initial use-case for us is being able to pin rather substantial
amounts of system memory due to potential upcoming hardware features.
While RDMA is using RLIMIT_MEMLOCK for this, that is per process and an
attacker could easily launch a number of processes and pin all of
system memory, so the thing optionally protecting from the DoS is the
memcg limit. So regardless of whether we also account against
RLIMIT_MEMLOCK or not, we need an additional cgroups limit.

Moving forward, there also a need of limiting the amount of allocated
graphics memory only, due to the way certain apps behave when probing
for available memory. :/.

I have unfortunately missed large parts of the memcg vs dmemcg
discussion, but I asked Claude to fish out as much of the essentials as
possible from the mailing lists so I can read up.

Thanks,
Thomas


> >=20
> > Regards,
> > Dave.
> >=20
