Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10853C79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 22:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B9A10E027;
	Mon,  7 Sep 2026 22:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="mSoAlIS3";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-163.mta1.migadu.com [95.215.58.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C75A110E027
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 22:26:49 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=n3D7ZA7tkZ34E7YU+SP+fSBY+j1Hn81BCAIxM2KVTtg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788820008; v=1; x=1789424808;
 b=mSoAlIS3lmPaqKECE5dcB3jWtUTgVjOrTof2gedhm4N7EtwK7k0Y5VZLGHEyzOo+8sEn3AD7
 yvvn/w5ljm4LSnSKGmwHAW1zV4RRiPB6NaS1fqbxJVOaCRtwG9ue62P92j4SjaTMQbvE38RBXW7
 cgUL9pJHhl5JjJgs/OfowRp4=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id ed8fd13ac114cfd0;
 Mon, 07 Sep 2026 22:25:45 +0000
X-Mizu-Trace-ID: ed8fd13ac114cfd0
X-Migadu-Flow: FLOW_OUT
Date: Mon, 7 Sep 2026 15:25:44 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
 muchun.song@linux.dev, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, 
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
 dev@lankhorst.se, mripard@kernel.org, nat@pixelcluster.dev, tj@kernel.org, 
 mkoutny@suse.com, osalvador@suse.de, cgroups@vger.kernel.org,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-team@meta.com
Subject: Re: [PATCH v5 3/7] mm/page_counter: introduce per-page_counter stock
Message-ID: <ap845AEpX0ceqCjr@linux.dev>
References: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
 <20260831163752.2193337-4-joshua.hahnjy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831163752.2193337-4-joshua.hahnjy@gmail.com>
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

On Mon, Aug 31, 2026 at 09:37:47AM -0700, Joshua Hahn wrote:
> In order to avoid expensive hierarchy walks on every memcg charge and
> limit check, memcontrol uses per-cpu stocks (memcg_stock_pcp) to cache
> pre-charged pages and introduce a fast path to try_charge_memcg.
> 
> However, there are a few quirks with the current implementation that
> can be improved upon.
> 
> First, each memcg_stock_pcp can only cache the charges of 7 memcgs
> (NR_MEMCG_STOCK). When an 8th memcg wants to cache its charge on a CPU,
> a victim memcg is chosen among the 7 cached memcgs and is evicted,
> losing all cached charges.
> 
> Second, stock draining is per-CPU rather than per-memcg. That is,
> when a memcg is under pressure and must retrieve all cached charges,
> it iterates through every CPU and drains the stock charges of all
> present memcgs. This means that one under-pressure memcg evicts the
> caches of all co-cpu-resident memcg stock caches.
> 
> Finally, stock is tightly coupled with memcg, so adding new
> page_counters to memcg is an unscalable operation where only one counter
> gets to use the fastpath.
> 
> We can address all of these concerns by pushing stock caches down to the
> page_counter level, and making each counter responsible for its own
> charge.
> 
> Introduce struct page_counter_stock along with its allocation, free, and
> per-CPU drain helpers.
> 
> No functional change intended.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  include/linux/page_counter.h | 16 +++++++
>  mm/page_counter.c            | 90 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index 89a083f16fbf7..c1fe331f34e7e 100644
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -5,8 +5,11 @@
>  #include <linux/atomic.h>
>  #include <linux/cache.h>
>  #include <linux/limits.h>
> +#include <linux/workqueue_types.h>
>  #include <asm/page.h>
>  
> +struct page_counter_stock;
> +
>  struct page_counter {
>  	/*
>  	 * Make sure 'usage' does not share cacheline with any other field in
> @@ -41,6 +44,13 @@ struct page_counter {
>  	unsigned long high;
>  	unsigned long max;
>  	struct page_counter *parent;
> +	struct page_counter_stock __percpu *stock;
> +	unsigned long batch;
> +
> +	/* make sure the work_struct is separate from the read most fields */
> +	CACHELINE_PADDING(_pad3_);
> +
> +	struct work_struct drain_work;

Introduce this field where you are going to use it.

>  } ____cacheline_internodealigned_in_smp;
>  
>  #if BITS_PER_LONG == 32
> @@ -61,6 +71,8 @@ static inline void page_counter_init(struct page_counter *counter,
>  	counter->parent = parent;
>  	counter->protection_support = protection_support;
>  	counter->track_failcnt = false;
> +	counter->stock = NULL;
> +	counter->batch = 0;
>  }
>  
>  static inline unsigned long page_counter_read(struct page_counter *counter)
> @@ -99,6 +111,10 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
>  	counter->watermark = usage;
>  }
>  
> +void page_counter_drain_cpu_stock(struct page_counter *counter, int cpu);
> +void page_counter_alloc_stock(struct page_counter *counter, unsigned long batch);
> +void page_counter_free_stock(struct page_counter *counter);
> +
>  #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
>  void page_counter_calculate_protection(struct page_counter *root,
>  				       struct page_counter *counter,
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index a934619cc7bf7..3f61eba695518 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -8,11 +8,18 @@
>  #include <linux/page_counter.h>
>  #include <linux/atomic.h>
>  #include <linux/kernel.h>
> +#include <linux/percpu.h>
>  #include <linux/string.h>
>  #include <linux/sched.h>
> +#include <linux/spinlock.h>
>  #include <linux/bug.h>
>  #include <asm/page.h>
>  
> +struct page_counter_stock {
> +	raw_spinlock_t lock;

Please explain why you need raw_spinlock_t?

> +	unsigned long nr_pages;
> +};
> +
>  static bool track_protection(struct page_counter *c)
>  {
>  	return c->protection_support;
> @@ -295,6 +302,89 @@ int page_counter_memparse(const char *buf, const char *max,
>  	return 0;
>  }
>  
> +/**
> + * page_counter_drain_cpu_stock - release @cpu's cached charges
> + * @counter: counter whose stock to drain
> + * @cpu: CPU whose stock is drained
> + */
> +void page_counter_drain_cpu_stock(struct page_counter *counter, int cpu)
> +{
> +	struct page_counter_stock __percpu *stock = READ_ONCE(counter->stock);
> +	struct page_counter_stock *pcp_stock;
> +	unsigned long nr_pages;
> +	unsigned long flags;
> +
> +	if (!stock)
> +		return;
> +
> +	pcp_stock = per_cpu_ptr(stock, cpu);
> +	raw_spin_lock_irqsave(&pcp_stock->lock, flags);
> +	nr_pages = pcp_stock->nr_pages;
> +	pcp_stock->nr_pages = 0;
> +	raw_spin_unlock_irqrestore(&pcp_stock->lock, flags);
> +
> +	if (nr_pages)
> +		page_counter_uncharge(counter, nr_pages);
> +}
> +
> +/**
> + * page_counter_alloc_stock - allocate the percpu stock for a page_counter
> + * @counter: counter to allocate percpu stock for
> + * @batch: maximum number of pages a CPU may cache
> + *
> + * Failure to allocate is not fatal; @counter falls back to hierarchy charges.
> + * The caller must not (un)charge @counter concurrently with this call, and this
> + * must not be called twice on the same counter. A concurrent drain is fine
> + * since the stock is published with a release store the drain paths pair with.
> + *
> + * Context: Process context. May sleep, the percpu alloc uses GFP_KERNEL.
> + */
> +void page_counter_alloc_stock(struct page_counter *counter, unsigned long batch)
> +{
> +	struct page_counter_stock __percpu *stock;
> +	int cpu;
> +
> +	if (WARN_ON_ONCE(counter->stock))
> +		return;
> +
> +	stock = alloc_percpu_gfp(struct page_counter_stock, GFP_KERNEL_ACCOUNT);

Let's add gfp param to the function and use that here. Also if you want to use
__GFP_ACCOUNT then you should use set_active_memcg() at the caller, so you don't
charge the one creating the memcg but the parent similar to what
mem_cgroup_css_alloc() does.

