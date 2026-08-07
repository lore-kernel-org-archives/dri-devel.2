Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95137C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C2F10F4E8;
	Fri,  7 Aug 2026 13:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MRqvRaU0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDD810F4EC
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 13:50:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C89DA41435;
 Fri,  7 Aug 2026 13:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9781F00A3E;
 Fri,  7 Aug 2026 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786110643;
 bh=EwPefllU6d1ZOhpuz2HmPQx5BKCFxUJHa6Nznn6LyRE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MRqvRaU0RAWLPqYnu2hVF4J5A/YLaMcCc9zGyL2HSxIqa/Mj0SL0oKlKbwt3k85om
 /K+mY2Imhr15J0MQpohqmZx3hyI5PEo905yB/Iz/8GW23+RGf0MgL09nPRi/ZX4aCQ
 Trxl3o2SIdim/srZsS61ZsLQcc67m5Oe8hHOAwiSkt02Ou6uM8FsSASn+yez70ZATR
 N6FQ3VtTRJea/r6sSGDDFMCUJz76Mt6lR4H0cJeQq3OMQkbhrzJLLKULVBoysbLf+c
 9kP9g90IN29MxfINOrWOUfpOVoqKYxH2oqKURDtpC+GxAE3HGVlr6SDAen7o2JOfdv
 8v2yKob6okQxw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Fri, 07 Aug 2026 15:50:27 +0200
Subject: [PATCH RFC 1/5] mm/slab: cleanup deferred free handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-kfree_nolock_kmalloc-v1-1-ba993cbf7a60@kernel.org>
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

In deferred_percpu_work_fn() we have a bunch of single-use local
variables for the various llists. Remove them and access the lists
directly.

In defer_free() make it more obvious and documented what we are doing.
Also restrict guard(preempt) to only the necessary part.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b9aeb02a880f..044db93d64a0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6371,16 +6371,12 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 static void deferred_percpu_work_fn(struct irq_work *work)
 {
 	struct deferred_percpu_work *dpw;
-	struct llist_head *objs, *objs_by_rcu, *rcu_sheaves;
 	struct llist_node *llnode, *pos, *t;
 	struct slab_sheaf *sheaf, *next;
 
 	dpw = container_of(work, struct deferred_percpu_work, work);
-	rcu_sheaves = &dpw->rcu_sheaves;
-	objs = &dpw->objects;
-	objs_by_rcu = &dpw->objects_by_rcu;
 
-	llnode = llist_del_all(objs);
+	llnode = llist_del_all(&dpw->objects);
 	llist_for_each_safe(pos, t, llnode) {
 		struct kmem_cache *s;
 		struct slab *slab;
@@ -6403,7 +6399,7 @@ static void deferred_percpu_work_fn(struct irq_work *work)
 		stat(s, FREE_SLOWPATH);
 	}
 
-	llnode = llist_del_all(objs_by_rcu);
+	llnode = llist_del_all(&dpw->objects_by_rcu);
 	llist_for_each_safe(pos, t, llnode) {
 		void *head = pos;
 		void *objp = kvmalloc_obj_start_addr(head);
@@ -6411,21 +6407,27 @@ static void deferred_percpu_work_fn(struct irq_work *work)
 		kvfree_call_rcu(head, objp);
 	}
 
-	llnode = llist_del_all(rcu_sheaves);
+	llnode = llist_del_all(&dpw->rcu_sheaves);
 	llist_for_each_entry_safe(sheaf, next, llnode, llnode)
 		call_rcu(&sheaf->rcu_head, rcu_free_sheaf);
 }
 
-static void defer_free(struct kmem_cache *s, void *head)
+static void defer_free(struct kmem_cache *s, void *obj)
 {
 	struct deferred_percpu_work *dpw;
+	struct llist_node *llnode;
 
-	guard(preempt)();
+	/*
+	 * Place the llist node where the freepointer would be if we freed the
+	 * object immediately. That means we can write there safely, only need
+	 * to remove kasan tag first.
+	 */
+	llnode = kasan_reset_tag(obj) + s->offset;
 
-	head = kasan_reset_tag(head);
+	guard(preempt)();
 
 	dpw = this_cpu_ptr(&deferred_percpu_work);
-	if (llist_add(head + s->offset, &dpw->objects))
+	if (llist_add(llnode, &dpw->objects))
 		irq_work_queue(&dpw->work);
 }
 

-- 
2.55.0

