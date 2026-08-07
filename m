Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D788FC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BFC10F4ED;
	Fri,  7 Aug 2026 13:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PXYh6M2K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4210B10F4ED
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 13:51:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F20A043E71;
 Fri,  7 Aug 2026 13:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D01C1F00A3D;
 Fri,  7 Aug 2026 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786110671;
 bh=JsBlNoLXapzvhaOZfFVgJmB3wffwQ8ZUd0cI3plKWLk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PXYh6M2KkgQHGOcPs4VHfkvwxJyfSKuED6zAeHwMz8mmUUgtOHTbSiQM5BJieAoLO
 H/WV7XvvSbkldcw2ezKoX6DKUZtAcjDvgjCWVLh1TbnJnQlGY+u4pRC+AIJ1cr/4s+
 JByHYpe+ebHxFnreqVNPxaZ5n/PFOCKp9FCVEt1gVdNWAjj4teAKaCf/xFOIYta2uQ
 234zl/9rw3uirz1ArxlCvIIddHjOso0Sf2s3/7xSRv4/CUeZyw0WEXcN1ojHc4WL4H
 w3jDfaKIq5AcnXo1qggs2ROLMdMYAzKmTRqpoIncaxXUWYTKO89frDEQNSedcwHZs4
 lxnBzFqghs4Ig==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Fri, 07 Aug 2026 15:50:31 +0200
Subject: [PATCH RFC 5/5] sched: use kfree_nolock() instead of kfree_rcu()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-kfree_nolock_kmalloc-v1-5-ba993cbf7a60@kernel.org>
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

In set_cpus_allowed_force() we use kfree_rcu() because kfree() is unsafe
under p->pi_lock.

With kfree_nolock() now being able to free arbitrary kmalloc() objects,
we can switch to kfree_nolock() and avoid the unnecessary rcu grace
period delay. Only in some cases the freeing might be deferred to
irq_work().

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 kernel/sched/core.c  | 9 ++-------
 kernel/sched/sched.h | 7 +------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 96226707c2f6..d2929e4e23f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2807,20 +2807,15 @@ void set_cpus_allowed_force(struct task_struct *p, const struct cpumask *new_mas
 		.user_mask = NULL,
 		.flags     = SCA_USER,	/* clear the user requested mask */
 	};
-	union cpumask_rcuhead {
-		cpumask_t cpumask;
-		struct rcu_head rcu;
-	};
 
 	scoped_guard (__task_rq_lock, p)
 		do_set_cpus_allowed(p, &ac);
 
 	/*
 	 * Because this is called with p->pi_lock held, it is not possible
-	 * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
-	 * kfree_rcu().
+	 * to use kfree() here (when PREEMPT_RT=y), thus use kfree_nolock()
 	 */
-	kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
+	kfree_nolock(ac.user_mask);
 }
 
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 56acf502ba26..6a8d0578e963 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2886,12 +2886,7 @@ static inline bool task_allowed_on_cpu(struct task_struct *p, int cpu)
 
 static inline cpumask_t *alloc_user_cpus_ptr(int node)
 {
-	/*
-	 * See set_cpus_allowed_force() above for the rcu_head usage.
-	 */
-	int size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
-
-	return kmalloc_node(size, GFP_KERNEL, node);
+	return kmalloc_node(cpumask_size(), GFP_KERNEL, node);
 }
 
 static inline struct task_struct *get_push_task(struct rq *rq)

-- 
2.55.0

