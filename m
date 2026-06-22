Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25BFCDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E4910E8CB;
	Mon, 22 Jun 2026 23:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VRz5Bnu/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0624E10E2A4;
 Mon, 22 Jun 2026 23:11:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C1510402FC;
 Mon, 22 Jun 2026 23:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A757A1F000E9;
 Mon, 22 Jun 2026 23:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782169865;
 bh=f0wc83EHX9hwGpiBEnxrlHQclPhLLkIjvr7ldgETsdI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VRz5Bnu/i5DdnCarRhQRtGxey4tME8/VThBkSf9rhsVKWNja3FrbkfeKJkJJSjz9L
 vda0mKbt9jAnrgSpgIioUQ5hOYpnKWrfj3ybWJWxMaoUq0Y4CY+FTAf6lyWi2e4Xk6
 aQ8TFNCZfktQG3cTtqiz1p3TsPtS8z0cWZWq9L+PFTEW0Pxy/wIprVFqPFDdyljUks
 t9i6iBUerUZcIpwt2IlV6qtBM4+TeMz9DJyoo6akH3NhX4ps3OPTSl4He04Z9c54u/
 MWDcftnL8XHD31qyt0IuVirGHq/39n0SnZrc0ZYIeAH4OVbjD75rpqCqv/Q33IUC6d
 oRIcrgLxh/4dQ==
Date: Tue, 23 Jun 2026 09:10:43 +1000
From: Dave Chinner <dgc@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH v6 1/2] mm: Introduce opportunistic_compaction concept to
 vmscan and shrinkers
Message-ID: <ajnA83DxAFqeJ-sv@dread>
References: <20260617032218.1165929-1-matthew.brost@intel.com>
 <20260617032218.1165929-2-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617032218.1165929-2-matthew.brost@intel.com>
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

On Tue, Jun 16, 2026 at 08:22:17PM -0700, Matthew Brost wrote:
> High-order allocations using __GFP_NORETRY or __GFP_RETRY_MAYFAIL
> are often opportunistic attempts to satisfy fragmentation-sensitive
> allocations rather than indications of severe memory pressure. In these
> cases, reclaim may invoke shrinkers that aggressively destroy working
> sets even though reclaim is unlikely to materially improve the
> allocation outcome.
> 
> Some shrinkers manage expensive backing or migration operations where
> reclaim can result in substantial working set disruption despite the
> system having sufficient free memory overall. This is particularly
> visible in fragmentation-heavy workloads where reclaim repeatedly tears
> down active state while kswapd attempts to satisfy higher-order
> allocations.
> 
> Introduce an opportunistic_compaction hint in shrink_control that allows
> kswapd to communicate when reclaim originates from a high-order
> allocation context that may be fragmentation driven rather than true
> memory pressure. Shrinkers may use this hint to avoid destructive
> working set reclaim while still participating normally during order-0
> or stronger reclaim conditions.

To be honest, this seems like another "push a hint through to the XE
shrinker" mechanism under a different name. You seem so focused on
fixing the XE reproducer that the -systemic problem- that -any-
high-order folio demand causes is not being acknowleged.

e.g. we use high-order folios extensively in the page cache these
days, and there are -many- cases where memory compaction driven by
high-order demand cause significant performance regressions for page
cache performance. To date, every single person who has wanted to
fix the problem they are seeing has effectively attempted to -turn
off compaction- via GFP flags.

I've even done that myself inside XFS to work around kvmalloc()
issues with a lack of GFP_NOFAIL support and doing costly high order
allocations that fail and trigger compaction before falling back to
vmalloc().  However, these issues have since been fixed in the
kvmalloc() code, such that it now does the right thing for most
calling contexts (i.e. tries high-order kmalloc() without triggering
compaction, then fall back to GFP_NOFAIL vmalloc()). This has made
kvmalloc() more performant and better behaved for -all users-, not
just XFS.

This is not sustainable - we need compaction to be robust and
performant in the face of high-order folio demands, regardless of
what subsystem is generating the demand.

So with that in mind, let me paraphrase the comment in the second
patch in the Xe shrinker implementation:

"Shrinker reclaim is based on implementation specific object sizes
so it is unlikely to ever acheive contiguous page reclaim in a
manner that will measurably improve compaction rates."

You also say:

> No functional changes are introduced for existing shrinkers.

Consider how many shrinkable caches the general statement above
applies to, and then think about the fundamental impedence mismatch
between the affected shrinkable caches and what this patch actually
fixes.

For example, what happens to slab-based caches if the XE cache is being
excessively reclaimed under high-order page demand? e.g. the slab-based
cache may have tens of objects per page and holds a system-level
performance critical working set of objects. How do these caches
handle the excessive reclaim demand being generated by compaction
thrashing?

Yup, they don't.

In the case of filesystem caches, the "reclaim and repopulate"
pattern you describe causing the XE perf problems causes internal
slab cache fragmentation. Not only does this not improve compaction
rates, it also results in more memory fragmentation because slab
pages get pinned by a small number of long lived objects and they
won't get freed until the cache is largely emptied.  IOWs, things
get -even worse- from a memory fragmentation POV when compaction
thrashing causes the working set of a high-object-count-per-page
slab cache to thrash....

This isn't isolated to individual subsystem thrashing.  If we run a
file-based workload that generates high-order folio demand and hence
compaction (e.g copy tens of GB of files between two XFS, ext4 or
btrfs filesystems), that will -also- trash the Xe working set via
the shrinker being hammered by memory compaction try to free up
contiguous pages for the page cache.

Similarly, if we run a Xe workload that generates sustained high
order folio demand, that will trash the working set in the dentry
and inode caches and any other shrinkable slab-based cache.

Hence the abstracted case of the problem we need to solve is this:
shrinker reclaim is based on x-byte objects is extremely unlikely to
acheive contiguous page reclaim in a manner that will measurably
improve compaction rates.

This is a problem that has to be addresses by the high level
infrastructure level, not worked around by individual shrinkers.

IMO, compaction shouldn't trigger shrinkers unless the shrinkers are
specifically flagged as being able to release contiguous pages of
memory in short order. I don't think there's very many shrinkable
caches that even hold a significant quantity of objects larger than
a single page, so it's clearly questionable as to whether compaction
based reclaim should run shrinker reclaim to begin with.

i.e. a subsystem that can track high order folios in a shrinkable
cache should probably have a "->compaction_scan()" method that is
run directly from compaction context to try to free high order
folios. This provides a direct opt-in mechanism for a subsystem, and
it allows subsystems that can track low- and high- order objects
independently to efficiently free objects in a way that will help
improve compaction rates without impacting the entire working set of
objects in the cache.

IOWs, this patch to inform kswapd about it's trigger (doesn't it
already have a "reason" parameter, though?) is likely a necessary
part of the solution - we don't want kswapd running shrinkers if it
has been triggered to reclaim pages for compaction. This patch would
allows kswapd to elide normal shrinker passes when it has been woken
purely for compaction purposes. Given that the compaction code would
be running the high-order reclaim capable shrinkers itself, this
would avoid trashing the working set of most shrinkable caches -by
default- under high order allocation demand....

-Dave.
-- 
Dave Chinner
dgc@kernel.org
