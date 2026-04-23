Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699BAF99377
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C1710EC06;
	Thu, 23 Apr 2026 11:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PM4OBKgx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC34D10E865;
 Thu, 23 Apr 2026 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776943637; x=1808479637;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=5YI735XPEJkCgWEsucBd5PrMiYz/IupiNSJb7R/0oJ4=;
 b=PM4OBKgxPq9xOPoGvGQMWZSVU9jimqGlZ39UYsoAKbvLWxM9eoPQ1hvG
 pWXZse9dCv1yeIXZ5+s1RmKVWydvbvBPOcgrf2SkGkGbkJdpHuqjAlFP9
 sRbHluHiLJv3b7L5e1B2J/3aE2g0PnCej2L6CWabWu7jl0ChntRV6Slrt
 2/mSUM7bfBOq1ASCHtUnrA0/PzHdTGvg4QqWtxd3e5McXSXMg633Z6V7Q
 XMoplaIJUERaOTeqckzI5G3+QjnQfzfKvjIg/2djRMeUTyj7mrUa4P5Ky
 n7GL3U+niLW4+Fv6wI1u49rmDZyHRtLWA7wouvY+vJTDL2MHNziIWHCTL A==;
X-CSE-ConnectionGUID: PYeNhem4QZGhv7MrSp/mPQ==
X-CSE-MsgGUID: eT5jcWK5SzCZH//Ul1H5Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="80495789"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="80495789"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 04:27:17 -0700
X-CSE-ConnectionGUID: ZEX+4CaZQgClv5j6ht9r2g==
X-CSE-MsgGUID: 9rckGPeQRxCBLBGfWmbzJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="232538257"
Received: from zzombora-mobl1 (HELO [10.245.244.147]) ([10.245.244.147])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 04:27:14 -0700
Message-ID: <be42059924cde9bb16a087ee2a5abb0b9d850d68.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/5] mm: Introduce zone_appears_fragmented()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
 <ljs@kernel.org>,  "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,  Suren
 Baghdasaryan	 <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, 	linux-kernel@vger.kernel.org, Johannes Weiner
 <hannes@cmpxchg.org>
Date: Thu, 23 Apr 2026 13:27:11 +0200
In-Reply-To: <76191a17-18bf-4e9b-9ab5-dc9a48abfabb@kernel.org>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-2-matthew.brost@intel.com>
 <76191a17-18bf-4e9b-9ab5-dc9a48abfabb@kernel.org>
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

On Thu, 2026-04-23 at 12:27 +0200, David Hildenbrand (Arm) wrote:
> On 4/23/26 07:56, Matthew Brost wrote:
> > Introduce zone_appears_fragmented() as a lightweight helper to
> > allow
> > subsystems to make coarse decisions about reclaim behavior in the
> > presence of likely fragmentation.
> >=20
> > The helper implements a simple heuristic: if the number of free
> > pages
> > in a zone exceeds twice the high watermark, the zone is considered
> > to
> > have ample free memory and allocation failures are more likely due
> > to
> > fragmentation than overall memory pressure.
> >=20
> > This is intentionally imprecise and is not meant to replace the
> > core
> > MM compaction or fragmentation accounting logic. Instead, it
> > provides
> > a cheap signal for callers (e.g., shrinkers) that wish to avoid
> > overly aggressive reclaim when sufficient free memory exists but
> > high-order allocations may still fail.
> >=20
> > No functional changes; this is a preparatory helper for future
> > users.
> >=20
> > Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> > =C2=A0include/linux/vmstat.h | 13 +++++++++++++
> > =C2=A01 file changed, 13 insertions(+)
> >=20
> > diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> > index 3c9c266cf782..568d9f4f1a1f 100644
> > --- a/include/linux/vmstat.h
> > +++ b/include/linux/vmstat.h
> > @@ -483,6 +483,19 @@ static inline const char *zone_stat_name(enum
> > zone_stat_item item)
> > =C2=A0	return vmstat_text[item];
> > =C2=A0}
> > =C2=A0
> > +static inline bool zone_appears_fragmented(struct zone *zone)
> > +{
>=20
> "zone_likely_fragmented" or "zone_maybe_fragmented" might be clearer,
> depending
> on the actual semantics.
>=20
> > +	/*
> > +	 * Simple heuristic: if the number of free pages is more
> > than twice the
> > +	 * high watermark, this strongly suggests that the zone is
> > heavily
> > +	 * fragmented when called from a shrinker.
> > +	 */
>=20
> I'll cc some more people. But the "when called from a shrinker" bit
> is
> concerning. Are there additional semantics that should be expressed
> in the
> function name, for example?
>=20
> Something that implies that this function only gives you a reasonable
> answer in
> a certain context.

I think that test would not be relevant for cgroup-aware shrinking.

What about trying to pass something in the struct shrink_control? Like
if we pass the struct scan_control's order field also in struct
shrink_control, really expensive shrinkers could duck reclaim attempts
from higher-order allocations that may fail anyway:

      if (sc->order > PAGE_ALLOC_COSTLY_ORDER &&
           (sc->gfp_mask & (__GFP_NORETRY | __GFP_RETRY_MAYFAIL)) &&
           !(sc->gfp_mask & __GFP_NOFAIL))
           return SHRINK_STOP;

Possibly exposed as an inline helper in the shrinker interface?

/Thomas




