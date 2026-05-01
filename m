Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09268FF886F
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 01:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CB610E4D1;
	Fri,  1 May 2026 01:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DeR2BoTw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F8510E4D1;
 Fri,  1 May 2026 01:42:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AD4DF6015B;
 Fri,  1 May 2026 01:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC5FC2BCB3;
 Fri,  1 May 2026 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777599758;
 bh=s5Avm2OmpzdNLOwnBT2sIFLcF3ONT0lruv1PFQd8FBA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DeR2BoTwVYKieU0M5pjmAwUb/bVDgXlJr4hntEgrSPcBlfF+LITJrVSOc2N9+VRmS
 ekYnQf+bCmDnsULRliNU29pq8gypvns0TPs06Vh5mnnkUcrtfzxhA8GcBhJV4pIxIC
 bGC/E4sOA9Rmf3sALlgnTRrMM79+cnjJuhiotZxPE53FEvdyHycwOGPwMAW9sHzdKq
 88GinW/iJhP6YB6ZFqZQudA6uurILRnAf++59hKcxbNcWrGMQnXTRWbZQQigi4/DAC
 vZwW2RSR6Pv/Y/1Ct1hJooxdh69EwpD1d9gzzaEy9r08P8mMJm/Wq6hzhqGDyQIaKt
 gQEkmpv574rQw==
Date: Fri, 1 May 2026 11:42:19 +1000
From: Dave Chinner <dgc@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Colascione <dancol@dancol.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] mm, drm/ttm, drm/xe: Avoid reclaim/eviction loops
 under fragmentation
Message-ID: <afQE-2JOzfOm8enM@dread>
References: <20260430191809.2142544-1-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430191809.2142544-1-matthew.brost@intel.com>
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

On Thu, Apr 30, 2026 at 12:18:03PM -0700, Matthew Brost wrote:
> TTM allocations at higher orders can drive Xe into a pathological
> reclaim loop when memory is fragmented:
> 
> kswapd → shrinker → eviction → rebind (exec ioctl) → repeat
> 
> In this state, reclaim is triggered despite substantial free memory,
> but fails to produce contiguous higher-order pages. The Xe shrinker then
> evicts active buffer objects, increasing faulting and rebind activity
> and further feeding the loop. The result is high CPU overhead and poor
> GPU forward progress.
> 
> This issue was first reported in [1] and independently observed
> internally and by Google.
> 
> A simple reproducer is:
> 
> - Boot an iGPU system with mem=8G
> - Launch 10 Chrome tabs running the WebGL aquarium demo
> - Configure each tab with ~5k fish
> 
> Under this workload, ftrace shows a continuous loop of:
> 
> xe_shrinker_scan (kswapd)
> xe_vma_rebind_exec
> 
> Performance degrades significantly, with each tab dropping to ~2 FPS on
> PTL (Ubuntu 24.04).
> 
> At the same time, /proc/buddyinfo shows substantial free memory but no
> higher-order availability. For example, the Normal zone:
> 
> Count: 4063 4595 3455 3400 3139 2762 2293 1655 643 0 0
> 
> This corresponds to ~2.8GB free memory, but no order-9 (2MB) blocks,
> indicating severe fragmentation.
> 
> This series addresses the issue in two ways:
> 
> TTM: Restrict direct reclaim to beneficial_order. Larger allocations
> use __GFP_NORETRY to fail quickly rather than triggering reclaim.

NACK.

As I have said to the people trying to hack around direct reclaim
for high order allocations being costly for the page cache, fix the
problem with direct reclaim. (e.g.
https://lore.kernel.org/linux-xfs/adLlrSZ5oRAa_Hfd@dread/)

We should not be hacking around a problem in the mm infrastructure
by changing allocation context flags every high order allocation 
call site that needs high order allocations. Understand and fix the
infrastructure problem once and for all.

> Xe: Introduce a heuristic in the shrinker to avoid eviction when
> running under kswapd and the system appears memory-rich but
> fragmented.

NACK on architectural grounds.

Custom heuristics in individual shrinkers to decide whether the
should do what the mm subsystem has asked them to do has -always-
been a mistake to allow. The mm subsystem makes the decision on how
much cache shrinkage needs to occur, the shrinkers just do what they
are told to do.

If we have a problem where a workload causes excessive shrinker
reclaim, then we need to address the problem in the infrastructure
because excessive reclaim affects the performance of -all-
subsystems with shrinkable caches, not just the TTM subsystem.

As it is, I can't review what you've actually implemented because
you only cc'd me on a single patch in the series. In future, please
cc me on the whole patchset because shrinkers need to work as a
coherent whole, not just in isolation....

-Dave.
-- 
Dave Chinner
dgc@kernel.org
