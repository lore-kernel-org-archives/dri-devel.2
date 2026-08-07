Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20875C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B67F10F4EC;
	Fri,  7 Aug 2026 13:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bftfFwcV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025A710F4EC
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 13:50:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DCD1643F53;
 Fri,  7 Aug 2026 13:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343681F00A3A;
 Fri,  7 Aug 2026 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786110657;
 bh=Qw5EXLRgG7MVbyyzo5Hfu/12GgcU/fQ9naW0jlMMCd0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=bftfFwcV3aDHjtMAwILI5O79RrtunZvph2GfZ9MMZn6kCchr0mEVG/ybaswejvRLv
 zlukEzJFtGZZeEBuRq2bouOGb9Md9UY4OzBhzrlTHCeJ8hnJZUHx31OveMSFd0WEo8
 rytPjymjr0QPgGh7kEBi40uKhi3kytwMtwq4QfMFB1uMw+YtlNdyy3fb5bKX0u+u+A
 SfIie0u/oyt6/TO3TDYcftfy7mMve8wXr9GFyWhWakLhp9E4HgylEkZK+glgFSYYJq
 gytQRdLKrenFLW6NRiZI69kZ6tKkt0gh9M16PQvzC3cd40dRpfFij+/C6fgbpCIkSK
 LPNLY9CjGjJqQ==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Fri, 07 Aug 2026 15:50:29 +0200
Subject: [PATCH RFC 3/5] mm/slab, kmemleak: handle kmemleak freeing in
 kfree_nolock()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-kfree_nolock_kmalloc-v1-3-ba993cbf7a60@kernel.org>
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

Kmemleak handling is one of the reasons why kfree_nolock() cannot
currently handle kmalloc() objects, because calling kmemleak_free()
would involve spinning on its internal raw spinlocks.

Kmemleak is a debugging mechanism so we could simply defer all
kfree_nolock() to irq_work if it's enabled, and eat the extra cost. But
that would be unnecessary pessimistic. We expect kfree_nolock() will be
still mostly called on objects from kmalloc_nolock() that are not
registered in kmemleak so they still don't need any deferred freeing.

Thus introduce kmemleak_may_need_free() that can check if the object is
registered. This is done using __lookup_object() performed under a
raw_spin_trylock_irqsave(), which is safe to attempt from kfree_nolock()
(except from a NMI on a !CONFIG_SMP system). When that trylock fails or
can't be attempted, we however must assume the object might be
registered, and defer the freeing.

The ordering of kmsan/kasan handling and kmemleak is also different from
what kfree() is doing, but as explained in the comment, it should be OK.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 include/linux/kmemleak.h | 17 +++++++++++++++++
 mm/kmemleak.c            | 42 ++++++++++++++++++++++++++++++++++++++++++
 mm/slub.c                | 34 ++++++++++++++++++++++++++--------
 3 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index fbd424b2abb1..52f75f10a9ce 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -22,6 +22,7 @@ extern void kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 extern void kmemleak_vmalloc(const struct vm_struct *area, size_t size,
 			     gfp_t gfp) __ref;
 extern void kmemleak_free(const void *ptr) __ref;
+bool kmemleak_may_need_free(const void *ptr) __ref;
 extern void kmemleak_free_part(const void *ptr, size_t size) __ref;
 extern void kmemleak_free_percpu(const void __percpu *ptr) __ref;
 extern void kmemleak_update_trace(const void *ptr) __ref;
@@ -50,6 +51,14 @@ static inline void kmemleak_free_recursive(const void *ptr, slab_flags_t flags)
 		kmemleak_free(ptr);
 }
 
+static inline bool kmemleak_may_need_free_recursive(const void *ptr, slab_flags_t flags)
+{
+	if (!(flags & SLAB_NOLEAKTRACE))
+		return kmemleak_may_need_free(ptr);
+
+	return false;
+}
+
 static inline void kmemleak_erase(void **ptr)
 {
 	*ptr = NULL;
@@ -86,6 +95,14 @@ static inline void kmemleak_free_part(const void *ptr, size_t size)
 static inline void kmemleak_free_recursive(const void *ptr, slab_flags_t flags)
 {
 }
+static inline bool kmemleak_may_need_free(const void *ptr)
+{
+	return false;
+}
+static inline bool kmemleak_may_need_free_recursive(const void *ptr, slab_flags_t flags)
+{
+	return false;
+}
 static inline void kmemleak_free_percpu(const void __percpu *ptr)
 {
 }
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 7c7ba17ce7af..e3560ce82632 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1168,6 +1168,48 @@ void __ref kmemleak_free(const void *ptr)
 }
 EXPORT_SYMBOL_GPL(kmemleak_free);
 
+/**
+ * kmemleak_may_need_free - check if object is registered
+ * @ptr:	pointer to beginning of the object
+ *
+ * This function is called from the kernel allocator when an object should be
+ * freed but the caller context might be unsafe to spin on the internal locks.
+ *
+ * It will therefore only use trylock and thus might return a false positive
+ * if the trylock fails and the status cannot be determined.
+ *
+ * For objects that (might) need free, the allocator has to defer the actual
+ * freeing to a safe context.
+ *
+ * The assumption is that most objects freed from the unsafe context are also
+ * allocated in such context and thus are not registered in kmemleak, so it's
+ * unlikely the defered freeing will be necessary just because kmemleak is
+ * enabled.
+ */
+bool __ref kmemleak_may_need_free(const void *ptr)
+{
+	unsigned long flags;
+	struct kmemleak_object *object;
+
+	pr_debug("%s(0x%px)\n", __func__, ptr);
+
+	if (!kmemleak_free_enabled || !ptr || IS_ERR(ptr))
+		return false;
+
+	/* On UP, raw_spin_trylock() always succeeds even when it is locked */
+	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
+		return true;
+
+	if (!raw_spin_trylock_irqsave(&kmemleak_lock, flags))
+		return true;
+
+	object = __lookup_object((unsigned long)ptr, 0, 0);
+
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
+
+	return !!object;
+}
+
 /**
  * kmemleak_free_part - partially unregister a previously registered object
  * @ptr:	pointer to the beginning or inside the object. This also
diff --git a/mm/slub.c b/mm/slub.c
index 2d7648b96bfa..423b5bdb910b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6390,6 +6390,8 @@ static void deferred_percpu_work_fn(struct irq_work *work)
 		/* Point 'x' back to the beginning of allocated object */
 		x -= s->offset;
 
+		kmemleak_free_recursive(x, s->flags);
+
 		/*
 		 * We used freepointer in 'x' to link 'x' into df->objects.
 		 * Clear it to NULL to avoid false positive detection
@@ -6403,8 +6405,15 @@ static void deferred_percpu_work_fn(struct irq_work *work)
 
 	llnode = llist_del_all(&dpw->objects_kfence);
 	llist_for_each_safe(pos, t, llnode) {
+		struct kmem_cache *s;
+		struct slab *slab;
 		void *obj = kfence_llnode_to_obj(pos);
 
+		slab = virt_to_slab(obj);
+		s = slab->slab_cache;
+
+		kmemleak_free_recursive(obj, s->flags);
+
 		__kfence_free(obj);
 	}
 
@@ -6781,15 +6790,10 @@ EXPORT_SYMBOL(kfree);
 
 /*
  * Can be called while holding raw_spinlock_t or from IRQ and NMI,
- * but ONLY for objects allocated by kmalloc_nolock().
- *
- * In case kmemleak is enabled,
+ * but may defer freeing to irq_work() in some cases.
  *
- * obj = kmalloc(); kfree_nolock(obj);
- *
- * will miss kmemleak book keeping and will cause false positives.
- *
- * large_kmalloc is not supported either.
+ * Intended mainly for objects allocated from kmalloc_nolock(), but can handle
+ * also kmem_cache_alloc() and kmalloc() objects, except large_kmalloc.
  */
 void kfree_nolock(const void *object)
 {
@@ -6844,9 +6848,23 @@ void kfree_nolock(const void *object)
 	 */
 	kasan_slab_free(s, x, false, false, /* skip quarantine */true);
 
+	/*
+	 * with kfree() the kmemleak handling happens much sooner, but for
+	 * defering we need to write llnode to the object's freepointer so
+	 * we should have it in the state when it's no longer treated as
+	 * allocated by kasan etc.
+	 *
+	 * defer_free will also reset the pointer tag, but it's ok to do a
+	 * deferred kmemleak_free() using the untagged pointer, because
+	 * __lookup_object() resets the tag anyway
+	 */
+	if (unlikely(kmemleak_may_need_free_recursive(x, s->flags)))
+		goto defer;
+
 	if (likely(can_free_to_pcs(slab)) && likely(free_to_pcs(s, x, false)))
 		return;
 
+defer:
 	/*
 	 * __slab_free() can locklessly cmpxchg16 into a slab, but then it might
 	 * need to take spin_lock for further processing.

-- 
2.55.0

