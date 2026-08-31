Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA69C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B702210EB92;
	Tue,  1 Sep 2026 07:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hsntX3DJ";
	dkim-atps=neutral
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C25CA10E305
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:37:54 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-6b0fd2ddea2so1403190eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788194274; x=1788799074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jHXBYg66UBEqhTnn/X5o4cskQbf8hKecJ7lklGtPMOg=;
 b=hsntX3DJZF8VEyOCFKCu/P3eDs9XsyhhoAza6CnB3fL6y4cILVUVsoZNnr5a/wk/M2
 WKzKm3RP7h6fwYTF7LNOegnR7i2KRuFGz5tjn4rkklcY5SbEbOOwULyPSt+VnsUKCW4d
 2y1HKL1zT9Lud7+9+uxIVbuzHmcQMc+q+ggs9ZZLptBr6i/oWJNqwBhD+TSD+0+BRSNo
 SfpqnlUccqxHFBzRuX9Yip0vBMCR+sqQ369DG8MdTIkVe5zH5VtuPqRJzKsunJnH3TVu
 7jRc+0O3LhWppRrYHs8tTpl57n5dWTZCOzKZEOFGFLi0k6kwEw07dE4f88yGuQhnelDy
 KwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194274; x=1788799074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jHXBYg66UBEqhTnn/X5o4cskQbf8hKecJ7lklGtPMOg=;
 b=UjvQ2kUp5z/GsWx5V5fGQ8juuFIN3uzhxhB6azyaC01sJxhOs5Dw62Gr0Su9jOCaZM
 xjJDD556wiCiRBjBLqKG2KQKoSitmhUB5JbQZxTZ6P6DP0qWx7VDXpl8cO1S/QlU58l5
 KzTgvVU5FV5YbARn7u0aJ+V1HA7TE/WRBI5agXkUSg2TX26nmDUC9aCGLfyZ0QS/awoQ
 bsQptuIDOM1Xf7b5BAuKPyuPp+LBd1Xy0k7VBrpPJZa6S+YQAah2PVWNOO+J48yz57ly
 YVoMeRuSHtByWNIO34AdjNSGd3gxlUZHcjpVr/INhAya2QriVsinjjmD2hySWSwNdQ0F
 MWiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzEBxdgatbRTnFrD51sLqrlZ3JCrHLYsp7w695maxncEWthtsfsvPmwvfJ3vFEOJut2yfjcZIvTM4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mKyeSexvGdj2tz1iYXeL6Ikw9TXVVYDQUoghA6hQWb8gvvdhQh
 o5HLb3ZLPzBycrSsfF8o9TKdeJK4dOuHG2r0ImMYpe3nVmDCB4rdlyk7
X-Gm-Gg: AR+sD11/Aq1XkMa48c4aJWC2Mb8o2PkD0GefrWrOc0NnKnR/nIoCB92MaOTx0TBzru+
 9TjUDXgZMh+EbeQqoNnfsz7MPGkuXZ636lKt/9ghjvJpfCxex4Q656kgPK/wDtB5TPlg/QcX/T9
 NC1OXtic7Y3d6hV2BikrgxZbr7KgoCvtTv0xXmSMG/JS6KTs8wpPznkWm4HOM1Jm5Z6GcSYOizS
 VhtwEUROlP/IVf+yALZFp5iAAmTSbYLqjT6UbRQo+lbqEWCB6dcP4bpiI1BOMlX3CvrdjbEJfE9
 Vg3aXF+8WtOmRP7tXoPUCCaCXcWdc3d/4mpEPrgU0CHgUDGgaZbda46yFBKNclPnDV2h4GNjLgL
 E5Zybgm9cT1xDv17mWOb6HoEIZcNBEQOMBvd9k9dIz1ih7kzoE51WeinPTvS5+dOpZElL3YvWtB
 OTzC0VJ81LZFTdRQfUHNJme4o3gwV4p7YtbTtpKiIeUpqtZN9XI8gQI8JrVpOKoOxRvDeqb7DKL
 tgLEid3qWfTUINkrh8=
X-Received: by 2002:a05:6820:f02d:b0:6a1:77ce:1b09 with SMTP id
 006d021491bc7-6b372ca85d5mr1858404eaf.6.1788194273632; 
 Mon, 31 Aug 2026 09:37:53 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a3535e25sm10291971fac.5.2026.08.31.09.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:37:53 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org
Cc: roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, dev@lankhorst.se, mripard@kernel.org,
 nat@pixelcluster.dev, tj@kernel.org, mkoutny@suse.com, osalvador@suse.de,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel-team@meta.com
Subject: [PATCH v5 0/7] move stock from mem_cgroup to page_counter
Date: Mon, 31 Aug 2026 09:37:44 -0700
Message-ID: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

v4 --> v5
=========
- The stock is now a raw_spinlock_t and an unsigned long to more closely
  match the original semantics of the stock code.
- Draining is asynchronous again, we add a work_struct per-page_counter
  (not percpu) that walks every cpu. This eliminates the concerns
  of doing a synchronous drain.
- page_counter_try_charge transparently handles stock.
- Addressed the netperf regression by reworking the refill path to match
  the vanilla uncharge path more closely.
- Correctness fixes for the percpu pointer access usage
- More testing to demonstrate that this series achieves its goal.
- Included Shakeel's stock watermarks from [1].
- Wordsmithing

INTRO
=====
Memcg currently keeps a "stock" of 64 pages per-cpu to cache pre-charged
allocations, allowing small and frequent allocations to avoid walking
the expensive mem_cgroup hierarchy traversal each time. This fastpath
offers real improvements, but there is room for improvement:
1. Currently, each CPU tracks up to 7 (NR_MEMCG_STOCK) mem_cgroups. When
   more than 7 mem_cgroups have stock present on a single CPU, a random
   victim is evicted and its associated stock is drained.
2. When one cgroup runs out of memory and needs to drain stock across
   all CPUs it has stock cached in, those CPUs will drain all other
   memcgs' stock present in that CPU. This leads to inefficient stock
   caching and cross-memcg interference under memory pressure.
3. Stock management is tightly coupled to struct mem_cgroup, which makes
   it difficult to add a new page_counter to mem_cgroup and have
   multiple sources of stock management.

This series moves the per-cpu stock down into page_counter, so that
page_counter_try_charge() transparently serves a charge from the stock
and refills it, and each counter owns and drains its own cache. This
eliminates the 7 memcg-per-cpu slot limit, the random cross-memcg stock
drains, and the slot traversal.

In turn, we can add independent stock management for additional
page_counters in each memcg, which is used in my tiered memory limits
series to add a new page_counter to track toptier usage [2]. Patch 7
uses it to give memsw its own stock.

Because the stock is now a property of the counter rather than of the
cpu, it is also reachable remotely, so draining no longer has to run on
the cpu that owns the cache.

This series preserves as much of the old semantics as possible,
including non-spinning safety by using trylocks for stock access.
The old !allow_spinning semantics in try_charge_memcg are slightly
different now though; outside NMI, page_counter_try_charge may perform
a speculative batch charge and a refill.

TRADEOFFS
=========
These are disclosed in the individual changelogs, I've also accumulated
them here so we can discuss them in one place.
1. The bound on pre-charged-but-unused memory is raised, from
   NR_MEMCG_STOCK * 64 * nr_cpus pages system-wide to
   nr_memcgs * 64 * nr_cpus. Because a child's stock is charged all the
   way up the hierarchy, an ancestor's memory.current -- and therefore
   its limit enforcement -- includes whatever its descendants cached.
   These are not "real" allocated pages and are returned under pressure,
   but the ceiling the old 7-slot design provided is gone.
2. struct page_counter grows from 192 to 256 bytes to accommodate the
   new struct work_struct.
3. cgroup v1 only: memsw.usage - memory.usage is no longer exactly swap
   usage, since the batch charges may go out of sync.
4. The stock lock is a raw_spinlock_t taken with trylock, where the memcg
   stock used local_trylock_t. Two cpus can now contend for the same
   counter's stock.
5. drain_all_stock() now queues work per-memcg, instead of per-CPU.

TESTING
=======
We can demonstrate the effects of the finer-grained stock draining by
creating a synthetic workload which allocates a batch of pages, then
yields. This is meant to demonstrate that prior to this series, a 4 page
charge could refill 64 pages worth of stock, but have it stolen away
if it didn't use all of it before yielding.

In the table below, the "batch" parameter is how many pages a workload
allocates before yielding. The measured metric shows how many refills
are needed to fault 64 pages. A higher number indicates more work needs
to be done to fault (charge) the same number of pages.

	+-------------------+
	| refills/64 faults |
+-------+----------+--------+
| batch | baseline | series |
+-------+----------+--------+
|     4 |    14.34 |      1 |
|     8 |     7.12 |      1 |
|    16 |     3.56 |      1 |
|    32 |     1.78 |      1 |
|    64 |        1 |      1 |
+-------+----------+--------+

This is reflected in throughput in this microbenchmark:

        +---------------------+
	|      faults/s       |
+-------+----------+----------+-------+
| batch | baseline |  series  | delta |
+-------+----------+----------+-------+
|     4 | 11487696 | 23825483 | +107% |
|     8 | 18408472 | 25869537 | +41%  |
|    16 | 24882465 | 26915403 | +8.2% |
|    32 | 27987869 | 27912912 | -0.3% |
|    64 | 29096451 | 28853936 | -0.8% |
+-------+----------+----------+-------+

Throughout testing outside this edge case across 4 to 64 memcgs per-cpu
led to negligible (within 1%) performance deltas. The microbenchmarks
above are just to demonstrate that refills become more efficient as we
do round-robin evictions less often.

CHANGELOG
=========
v3 --> v4:
- Reduced memory footprint by 4x, from 16 bytes per-(cpu x memcg) to
  4 bytes per-(cpu x memcg). Each page_counter_stock is a thin wrapper
  around an atomic_t.
- Removed locking completely and uses atomic operations to use stock.
- Removed synchronous work_on_cpu. All work is done via remote
  atomic_xchgs.
- Added a patch to flatten page_counter charging in try_charge_memcg
- Split page_counter_try_charge into stocked and non-stocked variants.

v2 --> v3:
- Dropped the cgroup v2 optimization, since it could indeed lead to too
  much time held with the cgroup_mutex. Instead we let the stock
  accumulate in the parent cgroups, which is not so bad; charges can
  still land on these cgroups, and if we ever reach the mem_cgroup
  limit, we can easily return those charges.
- page_counter_disable_stock no longer drains, just prevents
  accumulating stock. The actual draining is done in the free_stock
  variant, where we know for sure there are no in-flight charges.
- Reordering the page_counter_disable_stock path to disable before
  draining as to prevent accumulating stock first.
- Skip isolated CPUs when draining synchronously
- Rebase on newest mm-new
- Wordsmithing

v1 --> v2:
- Dropped stock returning on uncharge to preserve same behavior as memcg
  stock. This resolves some race conditions present in v1.
- Fixed many race conditions between disabling page_counter_stock and
  in-flight charges
- Restructured drain_all_stock to iterate over all CPUs first before
  memcgs, to reduce the number of synchronous CPU work scheduling
- Optimized cgroup v2 further to drain only on the first child and skip
  the root mem_cgroup
- Dropped RFC
- Wordsmithing cover letter

Based on latest mm-new as of August 31, 2026: "da6c37ed8beb2
mm/swap, PM: hibernate: atomically replace hibernation pin"

[1] https://lore.kernel.org/linux-mm/20260820012010.2016086-1-shakeel.butt@linux.dev/
[2] https://lore.kernel.org/all/20260423203445.2914963-1-joshua.hahnjy@gmail.com/

Joshua Hahn (7):
  mm/memcontrol: flatten try_charge_memcg control flow
  mm/page_counter: report the number of pages charged
  mm/page_counter: introduce per-page_counter stock
  mm/page_counter: use stock in page_counter_try_charge
  mm/page_counter: introduce an asynchronous drainer
  mm/memcontrol: convert memcg to use page_counter_stock
  mm/memcontrol: add stock to the memsw page_counter

 include/linux/page_counter.h |  23 ++-
 kernel/cgroup/dmem.c         |   2 +-
 mm/hugetlb_cgroup.c          |   2 +-
 mm/memcontrol-v1.c           |   2 +-
 mm/memcontrol.c              | 308 ++++++-----------------------------
 mm/page_counter.c            | 272 +++++++++++++++++++++++++++++--
 6 files changed, 334 insertions(+), 275 deletions(-)

-- 
2.53.0-Meta
