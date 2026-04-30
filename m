Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6172FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D41FC10F26A;
	Thu, 30 Apr 2026 07:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Oyyf4JDS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B8810E0EF;
 Thu, 30 Apr 2026 07:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777535268; x=1809071268;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=rrjCU3x04b/m/KmStz9/897b7XAGRr3pleBMtTv//wk=;
 b=Oyyf4JDSrtsD4T+1qyOZ5uDTO6Cfadkc65h72mLn/nYGvxdWjOIjMqQE
 8Zd72Dh2iV9+0TzktsZsxm0yh4itLJ/VU+YAd9yn3sC4WW3DzMrlqpqbE
 dLdi/HLMyYCD7Qiet7/c98933P1iOgVbsAttiz5kEwN6VNh40UrfYwZIQ
 yJQ4D2k4GdpOwCMh3xKXP54IAeLFINcnKdPm6kJ8H2ApMI0e1k+FJp5zX
 Su2ERPO8OS2Ti9TfcUiIr0RnzLQYzOwcVJIXpzoeGHV/Agzo1woUXJlUm
 RzL4mgHSLDJkeHhVpjWrWoD+FxQhQVLeaiKHV/xuOMKIAaOQjY6O7Bxe+ A==;
X-CSE-ConnectionGUID: gafOSc5KRue/HJOldYrYog==
X-CSE-MsgGUID: nK1XopvsSKCKidBfMregyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78668543"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="78668543"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:47:47 -0700
X-CSE-ConnectionGUID: hK+Q8UH0ShiRZenYTP9eTQ==
X-CSE-MsgGUID: YSJGkPeBQfaiTuXiiKoUDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="238833611"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.244.73])
 ([10.245.244.73])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:47:40 -0700
Message-ID: <f4324084f3808b9a42b87ec27bef7fe920dde9ea.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/5] mm: Introduce zone_appears_fragmented()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, "David Hildenbrand (Arm)"
 <david@kernel.org>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Andrew
 Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam
 R. Howlett"	 <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport	 <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko	 <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 30 Apr 2026 09:47:37 +0200
In-Reply-To: <afLCwHaPZMu/dxqY@gsse-cloud1.jf.intel.com>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-2-matthew.brost@intel.com>
 <76191a17-18bf-4e9b-9ab5-dc9a48abfabb@kernel.org>
 <be42059924cde9bb16a087ee2a5abb0b9d850d68.camel@linux.intel.com>
 <aepuNL2fwp47P1Wi@gsse-cloud1.jf.intel.com>
 <aeqbe/9YRKNyYuWY@gsse-cloud1.jf.intel.com>
 <291406b26b8badf2e565996515931d9ebe50208f.camel@linux.intel.com>
 <a1252167-63a1-481b-9f1d-2a7bae7a3b6c@kernel.org>
 <afLCwHaPZMu/dxqY@gsse-cloud1.jf.intel.com>
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

On Wed, 2026-04-29 at 19:47 -0700, Matthew Brost wrote:
> On Fri, Apr 24, 2026 at 09:26:18AM +0200, David Hildenbrand (Arm)
> wrote:
> > On 4/24/26 09:05, Thomas Hellstr=C3=B6m wrote:
> > > On Thu, 2026-04-23 at 15:21 -0700, Matthew Brost wrote:
> > > > On Thu, Apr 23, 2026 at 12:08:36PM -0700, Matthew Brost wrote:
> > > > >=20
> > > > > If the order were included in shrink_control, there is about
> > > > > a 95%
> > > > > certain that this change would allow TTM / Xe to break the
> > > > > problematic
> > > > > kswapd feedback loop. This may also better express the intent
> > > > > of
> > > > > the
> > > > > problem we are trying to fix here.
> > > > >=20
> > > > > For reference, the cover letter [1] details the problem.
> > > > >=20
> > > > > Any guidance from the core MM folks would be
> > > > > appreciated=E2=80=94would
> > > > > adding
> > > > > the order to shrink_control be an acceptable solution?
> > > > >=20
> > > > > Matt
> > > > >=20
> > > > > [1] https://patchwork.freedesktop.org/series/165330/
> > > > >=20
> > > >=20
> > > > It doesn't look like __GFP_NORETRY, __GFP_RETRY_MAYFAIL,
> > > > __GFP_NOFAIL
> > > > make it to the sc->gfp_mask flags from the caller and get into
> > > > kswapd
> > > > loop...
> > >=20
> > > Perhaps that's because they mostly (only?) make sense from direct
> > > reclaim? Looks like the trace is from kswapd.
> >=20
> > kswap obtains the desired order through pgdat->kswapd_order, as a
> > hint from
> > allocation code (wakeup_kswapd). The order can be easily merged
> > (just use the max)
> >=20
>=20
> Yes.
>=20
> My current thinking is wire the order into shrink_control as that is
> quite straight forward + only call this helper + short circuit
> shrinker
> on higher orders.
>=20
> > We do have the gfp_flags there, but merging them from different
> > wakeups is a bit
> > more tricky (and when to reset?).
> >=20
> > Assume we have one urgent request for order-0 and one non-urgent
> > (noretry,nofail, ...) request for order-9, we'd have to figure out
> > a way how to
> > represent that. Gets more complicated for more orders.
> >=20
> > Of course, we could have some kind of array, and try to store some
> > "priority"
> > per order. But I assume plumbing that into the rest of kswapd might
> > not be that
> > easy.
>=20
> Yes, this seems non-trivial. I was also on a call with Google today
> discussing what Android (client Linux) would like from shrinking, and
> my
> initial feeling is that we will need to do some surgery to the
> shrinker
> core and GPU shrinkers to make all of this work well over the next
> year
> or so.
>=20
> So again, I think starting with wiring order into shrink_control and
> this helper is a good place to start, as it fixes an immediate issue.
>=20
> Let me know if that seems like a reasonable direction.

+1 for wiring order into shrink_control, and possibly also the priority
as mentioned in an earlier email.

However for cgroups-aware shrinkers, The number of free memory in a
zone might not be an indication of fragmentation-triggered reclaim at
all, it could be the result of the cgroup hitting its memory limits.

So I think if we can solve this with a combination of GFP flags,
plumbed-through order and plumbed-through priority, that would be
ideal.

Thanks,
Thomas

>=20
> Matt
>=20
> >=20
> >=20
> > --=20
> > Cheers,
> >=20
> > David
