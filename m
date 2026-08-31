Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4878C624CF
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E61E10EBA2;
	Tue,  1 Sep 2026 07:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FbfrPfGC";
	dkim-atps=neutral
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646EF10E9EC
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:37:58 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7eb61bbeb25so4054875a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788194277; x=1788799077; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UZzK6JqUVQtEF4ncuPC417FBn/U4i41SWhLzyFT/8Js=;
 b=FbfrPfGCVu/B6CmXPKzI5z4B1M9D056vW1FxT3mMuFYuMB9HsZ1y4Ik8C57Lrzn9MJ
 coswaNFtqTRgtZALpQQ1WWtXh63OxVgms8kVpWRB/NRGYLHqc1ZZc9GuK8rsnWAUQudF
 /VmTa3qK6YfNuDXtj0ydh3U/E26WHkIiQTX7nCQ9A0jMLICVLu+Wv5TuuNM+9x8YDvJz
 g69SuqxAok1m6+25/UD3l2BtB0XgGbDBYnVQElNt8+qU3ROX/LwgTiKq2HIv/283kMco
 4KiFhbxtQtLHcHUs33JOucfWuwEu1Kmbpfog0W9PTR9LPF7OtkBLpmhQbF0YNNaUre/E
 NMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194277; x=1788799077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UZzK6JqUVQtEF4ncuPC417FBn/U4i41SWhLzyFT/8Js=;
 b=ZEoNPvVCE7hmPBNVGQ0y1/9Nf100B1OeV/hsgeZk5hM2TAz8dEumk8cLLN6UKrRunV
 1+PPgtvWpTP8ZC+6E/Ap8OTIZEeKNNXwz4fcaSuDhL8MaV9luVDmaav16qCwEXFigfD+
 rPO1n2uuOuHxD0079JkqdH5FhSokpxuonTAOPrOfAWTxVn75yHRBd14rNePQCUnLg0sx
 YC2AlnAoa2kbnoeRCFoL1Eh3Yuu2xLFR/bBWMjL1bWfQ5JBIG+z8Z+QiWWQYKKECCozJ
 xKDt2hb3eKQFPz7xDxMHJxfyW7At5Moa5y67sxWirA0og+GQe4KUfFswP6F5s3iJjND/
 JaLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqpsg/lYcvWWpBRhq1BiJbZE2GmfeKOgCzBs6vJQb1EXWAr7hpl9XLuGz4EnhT4TiXooxgOjQ6HleE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kHdzsd5N0LMGuPvozpaqi6uy7w8FF++ojQIaUM/+mlJAhnxlfb
 zsPdXu9bE+/pGfZHpxbAHAfVhpsJjlLU/P4aIQPWGCdEg0wrCgVFwG2v
X-Gm-Gg: AR+sD10OJogPIgzgW0JMKOCxRJ2075NC0eVTywnEVnIchAuMcxxw6gLnrIMM6DjVoDE
 4tXSy5YIBelTZmLkUFPdStaXlfQwb1sSARKh9bShja4U3+F6XO87j4EdCh3H/R38j8BigXxTP8I
 AZZF8ta3LZUafdhg7HJZPRHfABhLwtODMZu+LuwsdpzliUOFas4+jMPzn+gC2jwaj+OY3Jv5Tlm
 /0/bWx9kasQdQgjPdkSS8AD3nOTNlbRWdICVcXsvIKr/nbdzcSvO1YDWQG2BMi1Su61FLrmKP/m
 swvxCkIfbXoAMy9OM/OJtJbs6on/vCXL9unv5PLT3lOaQTBMThokZmwwfx5x+O439APbn+bhbIL
 au7SZ/r+c3ibOhwyiip9EHU4K3dGme1r5uO6AR1nh18sWnpQ+MJTGcVZIVs+NpRe2BALNZrnDc6
 QbXCAK7S5OViY/2PxVjw3/iFnHoCtXDYuw3UwRy5qN3rBuvKtF0ngwk9juYI+kgX93QeqVAj+uk
 9uke2nOK/qHzc8BVg==
X-Received: by 2002:a05:6830:349a:b0:7e9:e288:2b60 with SMTP id
 46e09a7af769-7f4f21cb626mr27446752a34.1.1788194277265; 
 Mon, 31 Aug 2026 09:37:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa96cf17sm8719481a34.15.2026.08.31.09.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:37:56 -0700 (PDT)
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
Subject: [PATCH v5 3/7] mm/page_counter: introduce per-page_counter stock
Date: Mon, 31 Aug 2026 09:37:47 -0700
Message-ID: <20260831163752.2193337-4-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
References: <20260831163752.2193337-1-joshua.hahnjy@gmail.com>
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

In order to avoid expensive hierarchy walks on every memcg charge and
limit check, memcontrol uses per-cpu stocks (memcg_stock_pcp) to cache
pre-charged pages and introduce a fast path to try_charge_memcg.

However, there are a few quirks with the current implementation that
can be improved upon.

First, each memcg_stock_pcp can only cache the charges of 7 memcgs
(NR_MEMCG_STOCK). When an 8th memcg wants to cache its charge on a CPU,
a victim memcg is chosen among the 7 cached memcgs and is evicted,
losing all cached charges.

Second, stock draining is per-CPU rather than per-memcg. That is,
when a memcg is under pressure and must retrieve all cached charges,
it iterates through every CPU and drains the stock charges of all
present memcgs. This means that one under-pressure memcg evicts the
caches of all co-cpu-resident memcg stock caches.

Finally, stock is tightly coupled with memcg, so adding new
page_counters to memcg is an unscalable operation where only one counter
gets to use the fastpath.

We can address all of these concerns by pushing stock caches down to the
page_counter level, and making each counter responsible for its own
charge.

Introduce struct page_counter_stock along with its allocation, free, and
per-CPU drain helpers.

No functional change intended.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/page_counter.h | 16 +++++++
 mm/page_counter.c            | 90 ++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 89a083f16fbf7..c1fe331f34e7e 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -5,8 +5,11 @@
 #include <linux/atomic.h>
 #include <linux/cache.h>
 #include <linux/limits.h>
+#include <linux/workqueue_types.h>
 #include <asm/page.h>
 
+struct page_counter_stock;
+
 struct page_counter {
 	/*
 	 * Make sure 'usage' does not share cacheline with any other field in
@@ -41,6 +44,13 @@ struct page_counter {
 	unsigned long high;
 	unsigned long max;
 	struct page_counter *parent;
+	struct page_counter_stock __percpu *stock;
+	unsigned long batch;
+
+	/* make sure the work_struct is separate from the read most fields */
+	CACHELINE_PADDING(_pad3_);
+
+	struct work_struct drain_work;
 } ____cacheline_internodealigned_in_smp;
 
 #if BITS_PER_LONG == 32
@@ -61,6 +71,8 @@ static inline void page_counter_init(struct page_counter *counter,
 	counter->parent = parent;
 	counter->protection_support = protection_support;
 	counter->track_failcnt = false;
+	counter->stock = NULL;
+	counter->batch = 0;
 }
 
 static inline unsigned long page_counter_read(struct page_counter *counter)
@@ -99,6 +111,10 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 	counter->watermark = usage;
 }
 
+void page_counter_drain_cpu_stock(struct page_counter *counter, int cpu);
+void page_counter_alloc_stock(struct page_counter *counter, unsigned long batch);
+void page_counter_free_stock(struct page_counter *counter);
+
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 void page_counter_calculate_protection(struct page_counter *root,
 				       struct page_counter *counter,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index a934619cc7bf7..3f61eba695518 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -8,11 +8,18 @@
 #include <linux/page_counter.h>
 #include <linux/atomic.h>
 #include <linux/kernel.h>
+#include <linux/percpu.h>
 #include <linux/string.h>
 #include <linux/sched.h>
+#include <linux/spinlock.h>
 #include <linux/bug.h>
 #include <asm/page.h>
 
+struct page_counter_stock {
+	raw_spinlock_t lock;
+	unsigned long nr_pages;
+};
+
 static bool track_protection(struct page_counter *c)
 {
 	return c->protection_support;
@@ -295,6 +302,89 @@ int page_counter_memparse(const char *buf, const char *max,
 	return 0;
 }
 
+/**
+ * page_counter_drain_cpu_stock - release @cpu's cached charges
+ * @counter: counter whose stock to drain
+ * @cpu: CPU whose stock is drained
+ */
+void page_counter_drain_cpu_stock(struct page_counter *counter, int cpu)
+{
+	struct page_counter_stock __percpu *stock = READ_ONCE(counter->stock);
+	struct page_counter_stock *pcp_stock;
+	unsigned long nr_pages;
+	unsigned long flags;
+
+	if (!stock)
+		return;
+
+	pcp_stock = per_cpu_ptr(stock, cpu);
+	raw_spin_lock_irqsave(&pcp_stock->lock, flags);
+	nr_pages = pcp_stock->nr_pages;
+	pcp_stock->nr_pages = 0;
+	raw_spin_unlock_irqrestore(&pcp_stock->lock, flags);
+
+	if (nr_pages)
+		page_counter_uncharge(counter, nr_pages);
+}
+
+/**
+ * page_counter_alloc_stock - allocate the percpu stock for a page_counter
+ * @counter: counter to allocate percpu stock for
+ * @batch: maximum number of pages a CPU may cache
+ *
+ * Failure to allocate is not fatal; @counter falls back to hierarchy charges.
+ * The caller must not (un)charge @counter concurrently with this call, and this
+ * must not be called twice on the same counter. A concurrent drain is fine
+ * since the stock is published with a release store the drain paths pair with.
+ *
+ * Context: Process context. May sleep, the percpu alloc uses GFP_KERNEL.
+ */
+void page_counter_alloc_stock(struct page_counter *counter, unsigned long batch)
+{
+	struct page_counter_stock __percpu *stock;
+	int cpu;
+
+	if (WARN_ON_ONCE(counter->stock))
+		return;
+
+	stock = alloc_percpu_gfp(struct page_counter_stock, GFP_KERNEL_ACCOUNT);
+	if (!stock)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct page_counter_stock *pcp_stock = per_cpu_ptr(stock, cpu);
+
+		raw_spin_lock_init(&pcp_stock->lock);
+	}
+
+	counter->batch = batch;
+	/* Publish stock only after percpu allocs / inits are finished */
+	smp_store_release(&counter->stock, stock);
+}
+
+/**
+ * page_counter_free_stock - free @counter's percpu cached charge
+ * @counter: page_counter whose stock to free
+ *
+ * Caller must guarantee no (un)charge or drain of @counter is in flight or can
+ * start. memcg only calls this once the cgroup is dead and unreachable.
+ */
+void page_counter_free_stock(struct page_counter *counter)
+{
+	struct page_counter_stock __percpu *stock = counter->stock;
+	int cpu;
+
+	if (!stock)
+		return;
+
+	/* Stop greedy over-charging before the stock goes away */
+	counter->batch = 0;
+	for_each_possible_cpu(cpu)
+		page_counter_drain_cpu_stock(counter, cpu);
+
+	WRITE_ONCE(counter->stock, NULL);
+	free_percpu(stock);
+}
 
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 /*
-- 
2.53.0-Meta

