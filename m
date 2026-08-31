Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF70C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38FA10EB8D;
	Tue,  1 Sep 2026 07:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="laLFadk+";
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DE510E9EC
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:37:59 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-46ac530b9ebso74675fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788194278; x=1788799078; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vXFNKbTdOrOMYaajm/HLCYSs/GSBNBi/73jyNLJmP+Y=;
 b=laLFadk+ZLvVJZijyae5nbUOLPhh8Td23+3WD0Xgpk/qSrxv874loMI+XxrKDWzjY4
 TWv3I6+DfE6LgCBgU5hGkT5PaT4dNLuKScv3WwgpHANtJ0Twl4rm+4j1uyLnAgStLiBE
 Aim4HCQpQejL6FoEM0cIqsDN4abdiygCxqLr/Gxku5v1OPR/Dsggvdgeb2ovaeRpuAMG
 Zq33eHdbik3QgtscBKR+wHl1BjtYcPwQixW4uCli9BLjCwipF/lw5FI61zuLm09hCWlz
 EaPKrypSUVk+eSczwbH8dD3doNi6RE38NtiTU7hPpIIJeeXnNSuzHaIkyVfQ66FRunAM
 mGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194278; x=1788799078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vXFNKbTdOrOMYaajm/HLCYSs/GSBNBi/73jyNLJmP+Y=;
 b=U4Q/OJSAITPldiWCBj+1xORrP7+BNgG7ImFoQny3F6oh47knBVdRKfKhUTmj6BdVRU
 rQvg1u2vx+q1pNmCpyUKQKaj5A38f/JuWPMEjsvNpO5hOVHV//Sl7Ex3hHZd00dSu4Rh
 LPFU/bLppa/9VISJOpJkS9u4vzJQ2Zilv5qU9DLMYQ76n84b+1k2/eqko1OJ6Hx0kN1P
 56rD3LwSByhOSpWBGomx0FsGfMDidC+lpheHDTn5DyNzujV2Xr6sOhKJVZr484fY9LVx
 cLkygheBK/+mKViI2o7BBfTBaCEHdu5gL4crWGGPmB4tVTOf+9s3TpSblT4NudDWHxe9
 6xlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RovGMYyDYphcFbCvw7CTc3uDzemvhewMIcwWFYoC9kfRX8s+rCgs64f2tfXD+BmGEUOq3kBXianUdU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l5pNXp5tk54EztL4TUILXp8kAx2ZF6SK1gl24B3fnCJYFNaWex
 jDDmmlTR2NqLehyD0WxVfe2Ufxki2jTZgE23/JPhBAAbTOue7c6J0/E0
X-Gm-Gg: AYBFou0gi9krl9CbjgpRStIg0ygCj3uAo2NgwkKHQu9HlUc/u5LiYz+0uw14NsBTbB3
 YjLJoUhchzTMaSsax21P2KfZA9Mr73rSwSZMXgwTV5H7o7cNt0RDH3RZpu6SuTdHv/guJGPwT/e
 ytiKE85M843HS4ghYvnvGby3SJvZXcenvxpOj3qWh2ny4UtuaBGchDS4TTISYU4XKY0u+twX69L
 kYAwVL33jv/w+PBzDHJEtZJxW3NID+km3BLJxGqkELpnZvLquusG7BPaj56S6Obwig5nXyaNxNp
 iAv0gg5axfjNImEzFbuzTPaML55vrofSmeb9fxGzQzxtg+zwoNpl+R/epVPAMxZBWwtAK12wISr
 gz4+r3tmZoTGfkMK6fPGpKTF+vmM35VO5DdwukVaO9jk4L8Mxth0Rx1NVCOveqLG0EeS0hqTz3g
 ZM1R4u/u7/Cl+6ceBbToGeERze4otLl1FCnXeuxN2tZhdYmhQDMkiLpPZnMYMCuv/t8+DajZOuf
 DeGrFygzSWOm3zc9ZA=
X-Received: by 2002:a05:6870:2b11:b0:456:4c6b:773a with SMTP id
 586e51a60fabf-46aca5a5f8amr7723915fac.9.1788194278410; 
 Mon, 31 Aug 2026 09:37:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:30::])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a4effb4dsm10497204fac.10.2026.08.31.09.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:37:58 -0700 (PDT)
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
Subject: [PATCH v5 4/7] mm/page_counter: use stock in page_counter_try_charge
Date: Mon, 31 Aug 2026 09:37:48 -0700
Message-ID: <20260831163752.2193337-5-joshua.hahnjy@gmail.com>
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

Transparently make page_counter_try_charge attempt to service the charge
from its stock. We preserve the same semantics as the existing stock
management in try_charge_memcg:

1. Limit-check against the stock. If there is enough, then skip the
   hierarchy walk and charge to the stock.
2. Greedily attempt to fulfill the charge request and refill the stock
   simultaneously to the hierarchy.
3. If this fails, retry the stock and charge without trying to refill
   the stock, i.e. with the number of pages requested.
4. If the greedy attempt succeeds, return excess pages to the stock.

page_counter_refill_stock() falls back to a hierarchical uncharge when
there is no stock, in NMI contexts, on lock contention, or for a refill
larger than the batch.

The greedy charge is also skipped in NMI where both stock helpers bail
out since the batch charge would be undone again.

No functional change intended, since no page_counter enables stock yet
and counter->batch is left at 0.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/page_counter.h |   2 +
 mm/page_counter.c            | 135 +++++++++++++++++++++++++++++++----
 2 files changed, 125 insertions(+), 12 deletions(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index c1fe331f34e7e..428ca8e7b2da5 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -82,6 +82,8 @@ static inline unsigned long page_counter_read(struct page_counter *counter)
 
 void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_charge(struct page_counter *counter, unsigned long nr_pages);
+unsigned long page_counter_refill_stock(struct page_counter *counter,
+					unsigned long overage);
 bool page_counter_try_charge(struct page_counter *counter,
 			     unsigned long nr_pages, struct page_counter **fail,
 			     unsigned long *nr_charged);
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 3f61eba695518..a76949abf04e7 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -113,25 +113,126 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 	}
 }
 
+static bool page_counter_consume_stock(struct page_counter *counter,
+				       unsigned long nr_pages)
+{
+	struct page_counter_stock __percpu *stock = READ_ONCE(counter->stock);
+	struct page_counter_stock *pcp_stock;
+	unsigned long flags;
+	bool charged = false;
+
+	if (!stock || nr_pages > counter->batch)
+		return false;
+
+	/* raw_spin_trylock isn't enough to protect against nested NMI in UP */
+	if (in_nmi())
+		return false;
+
+	/* It's OK to migrate here, since stock is fungible within a counter. */
+	pcp_stock = raw_cpu_ptr(stock);
+
+	if (!raw_spin_trylock_irqsave(&pcp_stock->lock, flags))
+		return false;
+
+	if (pcp_stock->nr_pages >= nr_pages) {
+		pcp_stock->nr_pages -= nr_pages;
+		charged = true;
+	}
+
+	raw_spin_unlock_irqrestore(&pcp_stock->lock, flags);
+	return charged;
+}
+
+/**
+ * page_counter_refill_stock - return pages to a page_counter's stock
+ * @counter: counter to return the pages to
+ * @overage: number of pages to return
+ *
+ * Return: how many of @overage went to the hierarchy rather than the stock.
+ * The flush itself can be larger, since it also returns what earlier callers
+ * stocked.
+ */
+unsigned long page_counter_refill_stock(struct page_counter *counter,
+					unsigned long overage)
+{
+	struct page_counter_stock __percpu *stock = READ_ONCE(counter->stock);
+	struct page_counter_stock *pcp_stock;
+	unsigned long high = counter->batch;
+	unsigned long low = high / 2;
+	unsigned long to_flush = overage;
+	unsigned long stocked;
+	unsigned long flags;
+
+	if (!stock || overage > high)
+		goto uncharge_counter;
+
+	/* See page_counter_consume_stock() for why NMI skips the stock. */
+	if (in_nmi())
+		goto uncharge_counter;
+
+	/* It's OK to migrate here, since stock is fungible within a counter. */
+	pcp_stock = raw_cpu_ptr(stock);
+	if (!raw_spin_trylock_irqsave(&pcp_stock->lock, flags))
+		goto uncharge_counter;
+
+	/*
+	 * Use a high/low watermark here, in the spirit of pcp->{batch, high}.
+	 * If the stock would exceed counter->batch, stock is trimmed to the low
+	 * watermark of counter->batch / 2 so that sequential uncharges don't
+	 * all trigger a hierarchy walk.
+	 */
+	stocked = pcp_stock->nr_pages + overage;
+	if (stocked > high) {
+		pcp_stock->nr_pages = low;
+		to_flush = stocked - low;
+	} else {
+		pcp_stock->nr_pages = stocked;
+		to_flush = 0;
+	}
+	raw_spin_unlock_irqrestore(&pcp_stock->lock, flags);
+
+	if (!to_flush)
+		return 0;
+
+uncharge_counter:
+	page_counter_uncharge(counter, to_flush);
+	return min(overage, to_flush);
+}
+
 /**
  * page_counter_try_charge - try to hierarchically charge pages
  * @counter: counter
  * @nr_pages: number of pages to charge
- * @fail: points first counter to hit its limit, if any
+ * @fail: only written on failure; the first counter to hit its limit
  * @nr_charged: optional; on success, set to the number of pages actually
- *		charged to the hierarchy
+ *		charged to the hierarchy. Set to 0 if stock was served.
+ *
+ * A successful charge may still have bumped failcnt on @counter or an
+ * ancestor, since the greedy attempt is retried at the requested size.
  *
- * Returns %true on success, or %false and @fail if the counter or one
- * of its ancestors has hit its configured limit.
+ * Returns %true on success, or %false and sets @fail if the counter or
+ * one of its ancestors has hit its configured limit.
  */
 bool page_counter_try_charge(struct page_counter *counter,
 			     unsigned long nr_pages, struct page_counter **fail,
 			     unsigned long *nr_charged)
 {
-	struct page_counter *c;
+	struct page_counter *c, *failed_at;
+	unsigned long charge = nr_pages;
 	bool protection = track_protection(counter);
 	bool track_failcnt = counter->track_failcnt;
 
+	/* The stock is skipped in NMI; a greedy charge would just be undone */
+	if (!in_nmi())
+		charge = max(counter->batch, nr_pages);
+
+retry:
+	if (page_counter_consume_stock(counter, nr_pages)) {
+		if (nr_charged)
+			*nr_charged = 0;
+		return true;
+	}
+
 	for (c = counter; c; c = c->parent) {
 		long new;
 		/*
@@ -148,9 +249,9 @@ bool page_counter_try_charge(struct page_counter *counter,
 		 * we either see the new limit or the setter sees the
 		 * counter has changed and retries.
 		 */
-		new = atomic_long_add_return(nr_pages, &c->usage);
+		new = atomic_long_add_return(charge, &c->usage);
 		if (new > c->max) {
-			atomic_long_sub(nr_pages, &c->usage);
+			atomic_long_sub(charge, &c->usage);
 			/*
 			 * This is racy, but we can live with some
 			 * inaccuracy in the failcnt which is only used
@@ -158,7 +259,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 			 */
 			if (track_failcnt)
 				data_race(c->failcnt++);
-			*fail = c;
+			failed_at = c;
 			goto failed;
 		}
 		if (protection)
@@ -172,15 +273,25 @@ bool page_counter_try_charge(struct page_counter *counter,
 		}
 	}
 
+	if (charge > nr_pages)
+		charge -= page_counter_refill_stock(counter, charge - nr_pages);
+
 	if (nr_charged)
-		*nr_charged = nr_pages;
+		*nr_charged = charge;
 
 	return true;
 
 failed:
-	for (c = counter; c != *fail; c = c->parent)
-		page_counter_cancel(c, nr_pages);
+	for (c = counter; c != failed_at; c = c->parent)
+		page_counter_cancel(c, charge);
+
+	/* Retry the stock & charge with the exact number of pages requested */
+	if (charge > nr_pages) {
+		charge = nr_pages;
+		goto retry;
+	}
 
+	*fail = failed_at;
 	return false;
 }
 
@@ -330,7 +441,7 @@ void page_counter_drain_cpu_stock(struct page_counter *counter, int cpu)
 /**
  * page_counter_alloc_stock - allocate the percpu stock for a page_counter
  * @counter: counter to allocate percpu stock for
- * @batch: maximum number of pages a CPU may cache
+ * @batch: number of pages to precharge and the stock's high watermark
  *
  * Failure to allocate is not fatal; @counter falls back to hierarchy charges.
  * The caller must not (un)charge @counter concurrently with this call, and this
-- 
2.53.0-Meta

