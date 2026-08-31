Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7F0C624CF
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A556310EBAD;
	Tue,  1 Sep 2026 07:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BxCsg8G0";
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 667AB10E305
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:38:00 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-6aa9606ddadso1310363eaf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788194279; x=1788799079; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tZLPtkE4K+x7inkg5AOVUnb1Simer6GkDXLFxdMoHE0=;
 b=BxCsg8G05yTPduppJjZ7Uv6jG91+3KBj+E1M2Kyq8YXiqTSh1gaimSdmojqtuX9KE3
 WyTtl0QRGoKFTheFYnWeZ86nzW4sS0JOO/2urFJjp7CLkTkDbVX2Jcb4YPZqz0n0owzA
 NyLVKcZFUKXNpEyJMvtfQ/0jM+uI2QVQAHkUGWQ+Bh0yaLnvrsSGG1WVT7mBkbglAyPP
 tuzoQpRrKz8zBrAEWTRpwlUhCAvGOwvkUqJMXO//aMV7TrYWSb2BF8eLRnHjtJaLJAeB
 MzOXpjgSc+yJtPs7dR9Pjw+mrk5hQ/3pwmwUK+4P3bFU0r1cIMlVjvgfO7WM9tHAfRXz
 idBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194279; x=1788799079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tZLPtkE4K+x7inkg5AOVUnb1Simer6GkDXLFxdMoHE0=;
 b=aiiXJY9oaLOEGbev6ue0MeRuQB2Xj7S5r21nPD3AnRwotQoEBVaUTBx8ajxo37a9ct
 U74UFs1CywCLgy13QuFpd16m2H9ptu11dtwm1ASYkyJeC+pk/dNHe2OEEuOnf6Da7DxC
 eyazJMRKoj2+PxZ0XZkMwSmCk80T1T9S1mB4f6LipheOB9mn1ifeCGQt41eJDvndpvZf
 NZCTWu4hGelOv51pLrMjjI8BMoKKJ5J3ZXZhVeJtz+Za6oR/3SW6Dr8g+KhIDkoBA9QO
 V8JHx72BV+I6o5s0dH+kG9agy2kM/O1/+yLyoqByBGxyHug2aBJ6H+rC8gwEIgqVxWth
 stLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXvCq9EzWDrTo7Kg1awhUD8z6A6w3VDvsJDZ5uwlJ83fXaB9FPVbU9o5+u+V/Jx+IC1ofIZW1fP2g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mtglbs2LTtAHuVRSahSrNkiN3Np4PZL+meIe+2d9tF79gnaQTp
 wHcLlGBoJWFhEv9oUkX6NjU1TcHRMB+J70s/CQIwlu6U/yG02SgRifVQ2dQxBA==
X-Gm-Gg: AR+sD13Oo6QvkSNf4MF1jGBNRk2laAaTDxEZ+6UNMbSyC2bhY+5d6OUpuwY8VpKHSHY
 jYgFgRzD9c8JSZ2tvF5xftM0ehBrTDCDGBe8yRCqNiJJJapeHEmfACrL3pRKbIQndtnPTRDxAt7
 LQbFax1mnKDJgwO+UKb+y+iLwsLV9C0GoTlMFD9U7JlTtEVO3cKSRv3fGiZ9OFRFqNh7kOWAKW3
 r6kDI1EvUSDIFKIv5WIQO+pFHozZsgsByqqQAdkva1GjL8acc2L40UvhFmSKdfjf0ucx8CTWsGK
 ViPNmvsNaTtJ9llrhPBjUPorfDhygITvxZL1JuaIy0/gMjSDiw5KAjFjRE6bEGeS6mBhZTKaD7s
 SXpdbJBOZaEveX9an6ne+ta+TwzO0LG3xVVjeWtXuyr2bFqKCkcUAq1SFlS3gkkiMe63rynzrSx
 VeXPRv03KtU9LrTAYCA/PmA4YWnKh3iZhUIjre0LVA3ja8P6QAtO5ku9wr5LaeCOYbljQB+8+1o
 ZkMFGb3asm71ITC3Mys
X-Received: by 2002:a05:6820:4d02:b0:6b1:afc8:3162 with SMTP id
 006d021491bc7-6b1c6642c52mr23408705eaf.7.1788194279553; 
 Mon, 31 Aug 2026 09:37:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:2b::])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a2fedbcasm10399867fac.2.2026.08.31.09.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:37:59 -0700 (PDT)
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
Subject: [PATCH v5 5/7] mm/page_counter: introduce an asynchronous drainer
Date: Mon, 31 Aug 2026 09:37:49 -0700
Message-ID: <20260831163752.2193337-6-joshua.hahnjy@gmail.com>
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

The existing percpu memcg stock drainer schedules a stock drain worker
per-cpu, one for every CPU containing the target memcg's stock.

One issue with this design is the coarseness of the drain; when a worker
runs on a CPU, it drains not only the target memcg's stock, but all
other (up to 6) memcgs who are stocked on that CPU.

Instead, use a per-page_counter drainer that iterates through each CPU
and flushes any existing charges, leaving other unrelated memcgs' stock
alone. Since that walks every possible CPU, the per-cpu helper now skips
the remote lock when a stock looks empty.

One benefit of having one worker flush through all CPUs is that
duplicate drain requests when a worker is already queued are coalesced,
since the asynchronous drainer takes no arguments and flushes all CPUs.

We use the system_dfl_wq for this asynchronous drain worker, since
memcg_wq is a percpu workqueue. Note that neither workqueue has
WQ_MEM_RECLAIM.

Previously the local CPU was drained inline because local_lock made it
the only reachable stock. The lock is now a per-cpu raw_spinlock_t that
any CPU can take, so drain any CPU's stock to return pages immediately.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/page_counter.h |  1 +
 mm/page_counter.c            | 55 ++++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 428ca8e7b2da5..b10ef785f06de 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -114,6 +114,7 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 }
 
 void page_counter_drain_cpu_stock(struct page_counter *counter, int cpu);
+void page_counter_drain_stock_async(struct page_counter *counter);
 void page_counter_alloc_stock(struct page_counter *counter, unsigned long batch);
 void page_counter_free_stock(struct page_counter *counter);
 
diff --git a/mm/page_counter.c b/mm/page_counter.c
index a76949abf04e7..e6cfb5865ba75 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 #include <linux/bug.h>
 #include <asm/page.h>
 
@@ -135,7 +136,7 @@ static bool page_counter_consume_stock(struct page_counter *counter,
 		return false;
 
 	if (pcp_stock->nr_pages >= nr_pages) {
-		pcp_stock->nr_pages -= nr_pages;
+		WRITE_ONCE(pcp_stock->nr_pages, pcp_stock->nr_pages - nr_pages);
 		charged = true;
 	}
 
@@ -183,10 +184,10 @@ unsigned long page_counter_refill_stock(struct page_counter *counter,
 	 */
 	stocked = pcp_stock->nr_pages + overage;
 	if (stocked > high) {
-		pcp_stock->nr_pages = low;
+		WRITE_ONCE(pcp_stock->nr_pages, low);
 		to_flush = stocked - low;
 	} else {
-		pcp_stock->nr_pages = stocked;
+		WRITE_ONCE(pcp_stock->nr_pages, stocked);
 		to_flush = 0;
 	}
 	raw_spin_unlock_irqrestore(&pcp_stock->lock, flags);
@@ -429,15 +430,53 @@ void page_counter_drain_cpu_stock(struct page_counter *counter, int cpu)
 		return;
 
 	pcp_stock = per_cpu_ptr(stock, cpu);
+
+	/*
+	 * Skip the remote lock when empty. Racing with the charge path is why
+	 * nr_pages uses WRITE_ONCE(); a stale read defers to the next drain.
+	 */
+	if (!READ_ONCE(pcp_stock->nr_pages))
+		return;
+
 	raw_spin_lock_irqsave(&pcp_stock->lock, flags);
 	nr_pages = pcp_stock->nr_pages;
-	pcp_stock->nr_pages = 0;
+	WRITE_ONCE(pcp_stock->nr_pages, 0);
 	raw_spin_unlock_irqrestore(&pcp_stock->lock, flags);
 
 	if (nr_pages)
 		page_counter_uncharge(counter, nr_pages);
 }
 
+static void page_counter_drain_work_fn(struct work_struct *work)
+{
+	struct page_counter *counter = container_of(work, struct page_counter,
+						    drain_work);
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		page_counter_drain_cpu_stock(counter, cpu);
+}
+
+/**
+ * page_counter_drain_stock_async - schedule a page_counter stock drain
+ * @counter: page_counter to drain
+ *
+ * Drains any CPU's stock inline, then schedules a drain over every CPU and
+ * returns. Concurrent requests coalesce onto the same queued work. @counter
+ * must outlive that work, which page_counter_free_stock() cancels.
+ * Must not be called from NMI context.
+ */
+void page_counter_drain_stock_async(struct page_counter *counter)
+{
+	/* Pairs with the smp_store_release() in page_counter_alloc_stock() */
+	if (!smp_load_acquire(&counter->stock))
+		return;
+
+	/* Drain any CPU's stock to immediately return pages; migrating is OK */
+	page_counter_drain_cpu_stock(counter, raw_smp_processor_id());
+	queue_work(system_dfl_wq, &counter->drain_work);
+}
+
 /**
  * page_counter_alloc_stock - allocate the percpu stock for a page_counter
  * @counter: counter to allocate percpu stock for
@@ -469,6 +508,7 @@ void page_counter_alloc_stock(struct page_counter *counter, unsigned long batch)
 	}
 
 	counter->batch = batch;
+	INIT_WORK(&counter->drain_work, page_counter_drain_work_fn);
 	/* Publish stock only after percpu allocs / inits are finished */
 	smp_store_release(&counter->stock, stock);
 }
@@ -477,8 +517,9 @@ void page_counter_alloc_stock(struct page_counter *counter, unsigned long batch)
  * page_counter_free_stock - free @counter's percpu cached charge
  * @counter: page_counter whose stock to free
  *
- * Caller must guarantee no (un)charge or drain of @counter is in flight or can
- * start. memcg only calls this once the cgroup is dead and unreachable.
+ * Caller must guarantee no (un)charge or drain of @counter can start, and must
+ * be ordered against the last CPU to touch the stock, since the drain peeks at
+ * nr_pages unlocked. memcg's RCU grace period before css_free provides both.
  */
 void page_counter_free_stock(struct page_counter *counter)
 {
@@ -490,6 +531,8 @@ void page_counter_free_stock(struct page_counter *counter)
 
 	/* Stop greedy over-charging before the stock goes away */
 	counter->batch = 0;
+	/* Make sure pending drainers don't run on freed page_counters */
+	cancel_work_sync(&counter->drain_work);
 	for_each_possible_cpu(cpu)
 		page_counter_drain_cpu_stock(counter, cpu);
 
-- 
2.53.0-Meta

