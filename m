Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADF9C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D11D10F4F1;
	Fri,  7 Aug 2026 13:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e4VSmJSt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FFF810F4ED
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 13:51:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB57C43DFA;
 Fri,  7 Aug 2026 13:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7291F00ACF;
 Fri,  7 Aug 2026 13:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786110664;
 bh=UGBELfa0PNJRa3PvbOBLlp8SGyFGd7t+kM65vGIAZwc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=e4VSmJSt73tA02FcE2cwM/eyfhDNj1IybKNAoQq4cuYxrXygc2XXmaK6ICGsSOOuU
 XmsxUDzNigL3kFl+StJRA1b/0LqYThJmhrHZJYv0q+HgjLVDqkaqaOnqt2eEV3kHAH
 eS53QQHpPBkK2d5djTzlbNJOR6puKjMDn3qplP1y5aX0E7LA5p/yt3AsewlXAoE+gi
 0NAmhX9xVb6MpvGI8dK5dxg4I/Vnyr9RRkEgxqW8IOHCUgQL72FE88sJU+4wEbiZDp
 VMBnUWwtd+bbroav/X3QGzfJXLxMuZKj05+itt98UINUISZpJ6fHQZO4VXRWTIX8zv
 N0Ng6BuX6uueQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Fri, 07 Aug 2026 15:50:30 +0200
Subject: [PATCH RFC 4/5] mm/slab: handle large_kmalloc objects in
 kfree_nolock()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-kfree_nolock_kmalloc-v1-4-ba993cbf7a60@kernel.org>
References: <20260807-kfree_nolock_kmalloc-v1-0-ba993cbf7a60@kernel.org>
In-Reply-To: <20260807-kfree_nolock_kmalloc-v1-0-ba993cbf7a60@kernel.org>
To: Harry Yoo <harry@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, bpf@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Dmitry Vyukov <dvyukov@google.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 kasan-dev@googlegroups.com, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
 Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-rt-devel@lists.linux.dev, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.15.2
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

Large kmalloc objects is the only remaining case that kfree_nolock()
cannot handle from kmalloc() allocations. Note kmalloc_nolock() does not
return large kmalloc objects.

Supporting them is however mostly straigtforward. free_large_kmalloc()
calls kmsan and kasan hooks that should be safe and similar to those
called in kfree_nolock(). Freeing the pages can be handled by
free_frozen_pages_nolock().

The only obstacle is kmemleak_free(), which we can solve by deferring
when necessary, the same way as done for small kmalloc objects.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 423b5bdb910b..3be98faa9f0d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4051,6 +4051,7 @@ static void flush_all(struct kmem_cache *s)
 struct deferred_percpu_work {
 	struct llist_head objects;
 	struct llist_head objects_kfence;
+	struct llist_head objects_large_kmalloc;
 	struct llist_head objects_by_rcu;
 	struct llist_head rcu_sheaves;
 	struct irq_work work;
@@ -4061,6 +4062,7 @@ static void deferred_percpu_work_fn(struct irq_work *work);
 static DEFINE_PER_CPU(struct deferred_percpu_work, deferred_percpu_work) = {
 	.objects = LLIST_HEAD_INIT(objects),
 	.objects_kfence = LLIST_HEAD_INIT(objects_kfence),
+	.objects_large_kmalloc = LLIST_HEAD_INIT(objects_large_kmalloc),
 	.objects_by_rcu = LLIST_HEAD_INIT(objects_by_rcu),
 	.rcu_sheaves = LLIST_HEAD_INIT(rcu_sheaves),
 	.work = IRQ_WORK_INIT(deferred_percpu_work_fn),
@@ -6365,6 +6367,21 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	}
 }
 
+static inline void
+__free_large_kmalloc_page(struct page *page, unsigned int free_flags)
+{
+	unsigned int order = compound_order(page);
+
+	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
+			      -(PAGE_SIZE << order));
+	__ClearPageLargeKmalloc(page);
+
+	if (free_flags & SLAB_FREE_NOLOCK)
+		free_frozen_pages_nolock(page, order);
+	else
+		free_frozen_pages(page, order);
+}
+
 /*
  * In PREEMPT_RT irq_work runs in per-cpu kthread, so it's safe
  * to take sleeping spin_locks from __slab_free().
@@ -6417,6 +6434,15 @@ static void deferred_percpu_work_fn(struct irq_work *work)
 		__kfence_free(obj);
 	}
 
+	llnode = llist_del_all(&dpw->objects_large_kmalloc);
+	llist_for_each_safe(pos, t, llnode) {
+		struct page *page = virt_to_page(pos);
+
+		kmemleak_free(pos);
+
+		__free_large_kmalloc_page(page, SLAB_FREE_DEFAULT);
+	}
+
 	llnode = llist_del_all(&dpw->objects_by_rcu);
 	llist_for_each_safe(pos, t, llnode) {
 		void *head = pos;
@@ -6464,6 +6490,24 @@ static void defer_free_kfence(void *obj)
 		irq_work_queue(&dpw->work);
 }
 
+static void defer_free_large_kmalloc(void *obj)
+{
+	struct deferred_percpu_work *dpw;
+	struct llist_node *llnode;
+
+	/*
+	 * we can simply use the first word of the large kmalloc object
+	 * for the llnode, as there's no ctor or TYPESAFE_BY_RCU
+	 */
+	llnode = kasan_reset_tag(obj);
+
+	guard(preempt)();
+
+	dpw = this_cpu_ptr(&deferred_percpu_work);
+	if (llist_add(llnode, &dpw->objects_large_kmalloc))
+		irq_work_queue(&dpw->work);
+}
+
 void defer_kfree_rcu(struct kvfree_rcu_head *head)
 {
 	struct deferred_percpu_work *dpw;
@@ -6712,9 +6756,11 @@ size_t ksize(const void *objp)
 }
 EXPORT_SYMBOL(ksize);
 
-static void free_large_kmalloc(struct page *page, void *object)
+static void free_large_kmalloc(struct page *page, void *object,
+			       unsigned int free_flags)
 {
 	unsigned int order = compound_order(page);
+	bool nolock = free_flags & SLAB_FREE_NOLOCK;
 
 	if (WARN_ON_ONCE(!PageLargeKmalloc(page))) {
 		dump_page(page, "Not a kmalloc allocation");
@@ -6724,14 +6770,16 @@ static void free_large_kmalloc(struct page *page, void *object)
 	if (WARN_ON_ONCE(order == 0))
 		pr_warn_once("object pointer: 0x%p\n", object);
 
-	kmemleak_free(object);
+	if (!nolock)
+		kmemleak_free(object);
+
 	kasan_kfree_large(object);
 	kmsan_kfree_large(object);
 
-	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
-			      -(PAGE_SIZE << order));
-	__ClearPageLargeKmalloc(page);
-	free_frozen_pages(page, order);
+	if (unlikely(nolock && kmemleak_may_need_free(object)))
+		defer_free_large_kmalloc(object);
+	else
+		__free_large_kmalloc_page(page, free_flags);
 }
 
 /*
@@ -6753,7 +6801,7 @@ void kvfree_rcu_cb(struct rcu_head *head)
 		if (slab)
 			slab_free(slab->slab_cache, slab, obj, _RET_IP_);
 		else
-			free_large_kmalloc(page, obj);
+			free_large_kmalloc(page, obj, SLAB_FREE_DEFAULT);
 	}
 }
 
@@ -6779,7 +6827,7 @@ void kfree(const void *object)
 	slab = page_slab(page);
 	if (!slab) {
 		/* kmalloc_nolock() doesn't support large kmalloc */
-		free_large_kmalloc(page, (void *)object);
+		free_large_kmalloc(page, (void *)object, SLAB_FREE_DEFAULT);
 		return;
 	}
 
@@ -6793,10 +6841,11 @@ EXPORT_SYMBOL(kfree);
  * but may defer freeing to irq_work() in some cases.
  *
  * Intended mainly for objects allocated from kmalloc_nolock(), but can handle
- * also kmem_cache_alloc() and kmalloc() objects, except large_kmalloc.
+ * also kmem_cache_alloc() and kmalloc() objects, including large_kmalloc.
  */
 void kfree_nolock(const void *object)
 {
+	struct page *page;
 	struct slab *slab;
 	struct kmem_cache *s;
 	void *x = (void *)object;
@@ -6804,9 +6853,10 @@ void kfree_nolock(const void *object)
 	if (unlikely(ZERO_OR_NULL_PTR(object)))
 		return;
 
-	slab = virt_to_slab(object);
+	page = virt_to_page(object);
+	slab = page_slab(page);
 	if (unlikely(!slab)) {
-		WARN_ONCE(1, "large_kmalloc is not supported by kfree_nolock()");
+		free_large_kmalloc(page, (void *)object, SLAB_FREE_NOLOCK);
 		return;
 	}
 
@@ -7167,7 +7217,7 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 	if (!s) {
 		/* Handle kalloc'ed objects */
 		if (!slab) {
-			free_large_kmalloc(page, object);
+			free_large_kmalloc(page, object, SLAB_FREE_DEFAULT);
 			df->slab = NULL;
 			return size;
 		}

-- 
2.55.0

