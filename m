Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6EDC79F82
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 22:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C03910E199;
	Fri,  4 Sep 2026 22:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="mz0A7yw7";
	dkim-atps=neutral
X-Greylist: delayed 365 seconds by postgrey-1.36 at gabe;
 Fri, 04 Sep 2026 22:53:34 UTC
Received: from mta1.migadu.com (out-247.mta1.migadu.com [95.215.58.247])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B74A10E199
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 22:53:34 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=a9LWtZEwa63QJ3Ja33Gs2KV3YWbCdmNNXpX1BLghxQk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788562412; v=1; x=1789167212;
 b=mz0A7yw73Vz5bVKVk9JF+sT9vBrry/A0oN16gVpPJnKy2DHyU0n0Se7Z29nfwGMPXBXuUwfZ
 4ONc8bKsJ3Uu2C7FaJ6zlCm5y0BsabDJKbqoypSn62/oZQsxMvhMXzdCBi+Vv3tEgZlrNFbS9Ke
 N95xuMpxnlGUuiwRpgXmueXE=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 1e87ab9cb44541fb;
 Fri, 04 Sep 2026 22:47:27 +0000
X-Mizu-Trace-ID: 1e87ab9cb44541fb
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 15:47:22 -0700
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
Message-ID: <aptJ5qQfjMB-24WB@linux.dev>
References: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
 <20260831163752.2193337-4-joshua.hahnjy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

On gcc 14.2.1, I get

In file included from mm/page_counter.c:8:
./include/linux/page_counter.h:47:44: error: expected ‘:’, ‘,’, ‘;’, ‘}’ or ‘__attribute__’ before ‘*’ token
   47 |         struct page_counter_stock __percpu *stock;
      |                                            ^

I think you need an appropriate header in this file.
