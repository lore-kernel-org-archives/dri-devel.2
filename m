Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B57C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C381E10E1C5;
	Tue, 25 Aug 2026 12:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nG65fO6S";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B8410E1C5;
 Tue, 25 Aug 2026 12:17:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2985E6013A;
 Tue, 25 Aug 2026 12:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFCB1F00A3A;
 Tue, 25 Aug 2026 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787660275;
 bh=Fw/JFsPu/tqDS8fxBU9ErpZ3CvXzkQxXFxreahgSckM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nG65fO6SjwzChSKL1VO//z5G1iR5m6qj7ZntgQzQwHZFDa6OnoVuCvD3itqXZ8MFY
 1ZNrOvApaaP2V79KrTStG0kCofE3aW9W1aMMH4BITqVQqZfcASo8pB260EApHkWjMA
 DLZNeRD9lWg9rFmUIvFlHUoN5YpDsSbWh8V9MZuQWQssNGa/CN+k83IHjf0zth1TGU
 /T+a9Jdm2+tfJqqf1sZ9680tRrBQ8cGxuxxoVSfRTQQ03Ym2w5c769H62ODDtN9Kdk
 juqu0WjwZE3x5BTocnivO3ycD+aUbvBNccH51qYdHUxX4dxL30q9PDqg+LIr7KO7Ns
 +eywipvCc92jA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 25 Aug 2026 14:16:32 +0200
Subject: [PATCH 1/6] hrtimer: add expiry injecting callback variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-expires-v2-v1-1-90411c6217c7@kernel.org>
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
In-Reply-To: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14458;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=6IRy6VTJXTZZpzQD9kMW+40jR+7JQ4TMsU1d9cTazuk=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqjYe5ely4Tn49PwRtpPLjSku46WAWHq8A7XDjR
 bp8WzEzy4+JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCao2HuQAKCRD6UCkIqsW9
 0DatD/wLAPzPiS3/0DTq42/TkM14O9YkRA/5gFmIwKPFG8WIbbChJVJRBhAloCl+k9ZpSKeoDMo
 IjRLMRLD5WiaomwhhzgPqktyobanyZ202aKZzieTWipH5sSZ3R6O6P6OCWzJnngrxSC1pqnP12F
 LiWcaAXA+eFgJtoUsSLZrGh45mYgHkYmPYiSZjqlYKQRTOiiQ3UQjpSgNx1Kvd2jtjIzWMrGNd+
 zBEPXqeeoF9BQ96tfMZd7IfmSC2tZoANUDrDQYSFA1r+sDOsHxdktbLQPJAPjLrQKgQZnXEgIjm
 VT2BOAnifc319G+Od1HfoLr44K1MPnPo0qOIVqmap/k4cefwGar/6PStQOpTZTyPQJdu2Xgf7jO
 m1ODf/rh3nNqQoKu6JQGN7LAxT6bP0nFnRURPFggwfg5yU4JDtSUMr7doExu66RkWSKO4ou6Dd/
 +RpkZM5J3Adx5rCWLVATFP0hrzg/zgiAKTp3yhFYpWU/fEsQz4ONsvWXbR7gxIF8x8eI3siLJ64
 DChG5iTIJBg7uGsOgA39AFlvO5x5tibl3YYZf7z0FpRD607D8C164VBtQ28xJdaBY6R7imw55kW
 Wfb4EPTCtPqXL39MJcZlKaonP9P7MpKNnxgjssCdITY+SaK5JZs4oHt04KPtrkCcq2SZc8TbZVh
 SZg6B3wZOZ93olQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
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

A hrtimer callback may modify its own expiry with hrtimer_forward()
and read it with hrtimer_get_expires(). Both run after
__run_hrtimer() has dropped the cpu_base->lock, so they race with a
concurrent hrtimer_start_range_ns() on another CPU, which rewrites
node.expires under the base lock and requeues the timer:

- The unlocked read-modify-write of node.expires in
  hrtimer_forward() is a data race against the locked write in the
  start path.

- The is_queued check in hrtimer_forward() is racy with
  a time-of-check-time-of-use bug as well: a concurrent
  start can enqueue the timer between the check and the expiry
  update, and forwarding an already queued timer changes the expiry
  of a node inside the timerqueue without re-sorting, leaving the
  tree unordered.

Timer users which both forward in the callback and arm from other contexts
must provide their own serialization, e.g. perf's cpc->hrtimer_lock plus
hrtimer_active flag, see commit 4cfafd3082af ("sched,perf: Fix periodic
timers"). The requirement is subtle and not enforced; i915_pmu and taprio
currently get it wrong. For the Rust hrtimer abstraction it is a soundness
problem: safe code can arm a timer whose callback is running, so callback
context forward and expiry reads cannot be offered as safe API.

Add an alternative callback variant that removes the race
structurally instead of requiring serialization. An expiry injecting
callback receives the expiry snapshotted under the base lock by
value and, to restart the timer, fills a struct hrtimer_forward_args
and returns HRTIMER_RESTART. __run_hrtimer() then applies the
forward and the enqueue with the base lock held. The callback never
accesses live timer state.

If a concurrent start enqueued the timer while the callback ran, the
restart request is discarded and the start wins, matching the
existing "restart == HRTIMER_RESTART && !timer->is_queued" handling
for classic callbacks. The is_queued check is reliable here: while
base->running == timer, hrtimer_try_to_cancel() bails out before
remove_hrtimer() and the timer cannot switch bases, so only a
concurrent start can enqueue it, and the start path writes the
expiry and is_queued in the same critical section. Thus !is_queued
at requeue time guarantees the expiry still equals the snapshot
handed to the callback: the deferred hrtimer_forward() cannot hit
its concurrent start check, and an overrun count the callback
derived from the snapshot is consistent with the forward that is
applied.

The new callback pointer shares storage with the classic one in an
anonymous union, discriminated by a new is_ext flag placed in
existing padding; sizeof(struct hrtimer) is unchanged and the
classic callback path is unaffected. hrtimer_update_function()
rejects timers with an expiry injecting callback.

Link: https://lore.kernel.org/r/87h5kp88uy.fsf@kernel.org
Suggested-by: Gary Guo <gary@garyguo.net>
Assisted-by: claude-code:claude-fable-5
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 include/linux/hrtimer.h       |   7 +++
 include/linux/hrtimer_types.h |  34 ++++++++++++-
 kernel/time/hrtimer.c         | 112 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 145 insertions(+), 8 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 6862dea0acc52..a45a0677238c9 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -190,6 +190,10 @@ static inline enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)
 /* Initialize timers: */
 extern void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)(struct hrtimer *),
 			  clockid_t clock_id, enum hrtimer_mode mode);
+
+extern void hrtimer_setup_ext(struct hrtimer *timer, hrtimer_ext_func_t function_ext,
+			      clockid_t clock_id, enum hrtimer_mode mode);
+
 extern void hrtimer_setup_on_stack(struct hrtimer *timer,
 				   enum hrtimer_restart (*function)(struct hrtimer *),
 				   clockid_t clock_id, enum hrtimer_mode mode);
@@ -307,6 +311,9 @@ static inline int hrtimer_callback_running(struct hrtimer *timer)
 static inline void hrtimer_update_function(struct hrtimer *timer,
 					   enum hrtimer_restart (*function)(struct hrtimer *))
 {
+	if (WARN_ON_ONCE(timer->is_ext))
+		return;
+
 #ifdef CONFIG_PROVE_LOCKING
 	guard(raw_spinlock_irqsave)(&timer->base->cpu_base->lock);
 
diff --git a/include/linux/hrtimer_types.h b/include/linux/hrtimer_types.h
index b5dacc8271a4a..7c7e03dffcae7 100644
--- a/include/linux/hrtimer_types.h
+++ b/include/linux/hrtimer_types.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/timerqueue_types.h>
 
+struct hrtimer;
 struct hrtimer_clock_base;
 
 /*
@@ -15,6 +16,26 @@ enum hrtimer_restart {
 	HRTIMER_RESTART,	/* Timer must be restarted */
 };
 
+/**
+ * struct hrtimer_forward_args - deferred forward request of an expiry
+ *				 injecting callback
+ * @now:	forward past this time
+ * @interval:	the interval to forward by
+ *
+ * Filled in by an expiry injecting callback (see hrtimer_setup_ext())
+ * which returns HRTIMER_RESTART. The hrtimer core applies the forward
+ * with the timer base lock held before requeueing the timer, i.e.
+ * hrtimer_forward(timer, now, interval).
+ */
+struct hrtimer_forward_args {
+	ktime_t				now;
+	ktime_t				interval;
+};
+
+/* Callback function of an expiry injecting timer, see hrtimer_setup_ext() */
+typedef enum hrtimer_restart (*hrtimer_ext_func_t)(struct hrtimer *timer, ktime_t expires,
+						   struct hrtimer_forward_args *fwd);
+
 /**
  * struct hrtimer - the basic hrtimer structure
  * @node:	Linked timerqueue node, which also manages node.expires,
@@ -27,6 +48,9 @@ enum hrtimer_restart {
  *		The time which was given as expiry time when the timer
  *		was armed.
  * @function:	timer expiry callback function
+ * @function_ext: expiry injecting timer callback function, receives the
+ *		expiry snapshot and returns a forward request instead of
+ *		modifying the expiry itself. Valid if @is_ext is set.
  * @base:	pointer to the timer base (per cpu and per clock)
  * @is_queued:	Indicates whether a timer is enqueued or not
  * @is_rel:	Set if the timer was armed relative
@@ -35,8 +59,10 @@ enum hrtimer_restart {
  *		even on RT.
  * @is_lazy:	Set if the timer is frequently rearmed to avoid updates
  *		of the clock event device
+ * @is_ext:	Set if @function_ext is valid instead of @function
  *
- * The hrtimer structure must be initialized by hrtimer_setup()
+ * The hrtimer structure must be initialized by hrtimer_setup() or
+ * hrtimer_setup_ext()
  */
 struct hrtimer {
 	struct timerqueue_linked_node	node;
@@ -46,8 +72,12 @@ struct hrtimer {
 	bool				is_soft;
 	bool				is_hard;
 	bool				is_lazy;
+	bool				is_ext;
 	ktime_t				_softexpires;
-	enum hrtimer_restart		(*__private function)(struct hrtimer *);
+	union {
+		enum hrtimer_restart	(*__private function)(struct hrtimer *);
+		hrtimer_ext_func_t	__private function_ext;
+	};
 };
 
 #endif /* _LINUX_HRTIMER_TYPES_H */
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 313dcea127fe4..e718dd0e05195 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1863,8 +1863,7 @@ ktime_t hrtimer_cb_get_time(const struct hrtimer *timer)
 }
 EXPORT_SYMBOL_GPL(hrtimer_cb_get_time);
 
-static void __hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*fn)(struct hrtimer *),
-			    clockid_t clock_id, enum hrtimer_mode mode)
+static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id, enum hrtimer_mode mode)
 {
 	bool softtimer = !!(mode & HRTIMER_MODE_SOFT);
 	struct hrtimer_cpu_base *cpu_base;
@@ -1898,6 +1897,12 @@ static void __hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*fn)(st
 	timer->is_lazy = !!(mode & HRTIMER_MODE_LAZY_REARM);
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_linked_init(&timer->node);
+}
+
+static void __hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*fn)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
+{
+	__hrtimer_init(timer, clock_id, mode);
 
 	if (WARN_ON_ONCE(!fn))
 		ACCESS_PRIVATE(timer, function) = hrtimer_dummy_timeout;
@@ -1905,6 +1910,20 @@ static void __hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*fn)(st
 		ACCESS_PRIVATE(timer, function) = fn;
 }
 
+static void __hrtimer_setup_ext(struct hrtimer *timer, hrtimer_ext_func_t fn,
+				clockid_t clock_id, enum hrtimer_mode mode)
+{
+	__hrtimer_init(timer, clock_id, mode);
+
+	if (WARN_ON_ONCE(!fn)) {
+		ACCESS_PRIVATE(timer, function) = hrtimer_dummy_timeout;
+		return;
+	}
+
+	ACCESS_PRIVATE(timer, function_ext) = fn;
+	timer->is_ext = true;
+}
+
 /**
  * hrtimer_setup - initialize a timer to the given clock
  * @timer:	the timer to be initialized
@@ -1926,6 +1945,45 @@ void hrtimer_setup(struct hrtimer *timer, enum hrtimer_restart (*function)(struc
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup);
 
+/**
+ * hrtimer_setup_ext - initialize a timer with an expiry injecting callback
+ * @timer:	the timer to be initialized
+ * @function_ext: the expiry injecting callback function
+ * @clock_id:	the clock to be used
+ * @mode:       The modes which are relevant for initialization:
+ *              HRTIMER_MODE_ABS, HRTIMER_MODE_REL, HRTIMER_MODE_ABS_SOFT,
+ *              HRTIMER_MODE_REL_SOFT
+ *
+ *              The PINNED variants of the above can be handed in,
+ *              but the PINNED bit is ignored as pinning happens
+ *              when the hrtimer is started
+ *
+ * In contrast to a callback installed by hrtimer_setup(), an expiry
+ * injecting callback does not access the expiry of the timer itself.
+ * The expiry is snapshotted under the timer base lock and handed into
+ * the callback by value. To restart the timer, the callback fills @fwd
+ * and returns HRTIMER_RESTART; the core then applies
+ * hrtimer_forward(timer, fwd->now, fwd->interval) and requeues the
+ * timer, both under the timer base lock.
+ *
+ * This closes the race between hrtimer_forward()/expiry reads in
+ * callback context and a concurrent hrtimer_start() on another CPU,
+ * without requiring the timer user to provide serialization: if a
+ * concurrent start requeued the timer while the callback ran, the
+ * restart request is discarded and the concurrent start wins.
+ *
+ * The callback must not call hrtimer_forward() or modify the expiry
+ * itself, and a callback returning HRTIMER_RESTART must fill @fwd with
+ * a non zero interval.
+ */
+void hrtimer_setup_ext(struct hrtimer *timer, hrtimer_ext_func_t function_ext,
+		       clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_setup(timer, clock_id, mode);
+	__hrtimer_setup_ext(timer, function_ext, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_setup_ext);
+
 /**
  * hrtimer_setup_on_stack - initialize a timer on stack memory
  * @timer:	The timer to be initialized
@@ -1991,8 +2049,11 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base, struct hrtimer_cloc
 			  struct hrtimer *timer, ktime_t now, unsigned long flags)
 	__must_hold(&cpu_base->lock)
 {
-	enum hrtimer_restart (*fn)(struct hrtimer *);
+	enum hrtimer_restart (*fn)(struct hrtimer *) = NULL;
+	struct hrtimer_forward_args fwd = { };
+	hrtimer_ext_func_t fn_ext = NULL;
 	bool expires_in_hardirq;
+	ktime_t expires = 0;
 	int restart;
 
 	lockdep_assert_held(&cpu_base->lock);
@@ -2010,7 +2071,20 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base, struct hrtimer_cloc
 	raw_write_seqcount_barrier(&base->seq);
 
 	__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, false);
-	fn = ACCESS_PRIVATE(timer, function);
+
+	/*
+	 * Snapshot the expiry for an expiry injecting callback while the
+	 * base lock is still held. The callback gets the snapshot by
+	 * value and must not access timer->node.expires, which a
+	 * concurrent hrtimer_start_range_ns() can modify once the lock is
+	 * dropped.
+	 */
+	if (timer->is_ext) {
+		fn_ext = ACCESS_PRIVATE(timer, function_ext);
+		expires = hrtimer_get_expires(timer);
+	} else {
+		fn = ACCESS_PRIVATE(timer, function);
+	}
 
 	/*
 	 * Clear the 'is relative' flag for the TIME_LOW_RES case. If the
@@ -2029,12 +2103,19 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base, struct hrtimer_cloc
 	trace_hrtimer_expire_entry(timer, now);
 	expires_in_hardirq = lockdep_hrtimer_enter(timer);
 
-	restart = fn(timer);
+	if (fn_ext)
+		restart = fn_ext(timer, expires, &fwd);
+	else
+		restart = fn(timer);
 
 	lockdep_hrtimer_exit(expires_in_hardirq);
 	trace_hrtimer_expire_exit(timer);
 	raw_spin_lock_irq(&cpu_base->lock);
 
+	/* An expiry injecting callback requesting a restart must forward. */
+	if (fn_ext && restart == HRTIMER_RESTART && WARN_ON_ONCE(!fwd.interval))
+		restart = HRTIMER_NORESTART;
+
 	/*
 	 * Note: We clear the running state after enqueue_hrtimer and
 	 * we do not reprogram the event hardware. Happens either in
@@ -2044,8 +2125,27 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base, struct hrtimer_cloc
 	 * hrtimer_start_range_ns() can have popped in and enqueued the timer
 	 * for us already.
 	 */
-	if (restart == HRTIMER_RESTART && !timer->is_queued)
+	if (restart == HRTIMER_RESTART && !timer->is_queued) {
+		/*
+		 * Apply the deferred forward of an expiry injecting
+		 * callback with the base lock held.
+		 *
+		 * While base->running == timer, hrtimer_try_to_cancel()
+		 * bails out before remove_hrtimer() and the timer cannot
+		 * switch bases, so only a concurrent start can have
+		 * enqueued the timer and it writes the expiry and
+		 * is_queued in the same critical section. Thus !is_queued
+		 * here guarantees that the expiry is still equal to the
+		 * snapshot handed to the callback, and the concurrent
+		 * start check in hrtimer_forward() cannot trigger. If a
+		 * concurrent start enqueued the timer, is_queued is set
+		 * and the restart request is discarded - the concurrent
+		 * start expressed newer intent and wins.
+		 */
+		if (fn_ext)
+			hrtimer_forward(timer, fwd.now, fwd.interval);
 		enqueue_hrtimer(timer, base, HRTIMER_MODE_ABS, false);
+	}
 
 	/*
 	 * Separate the ->running assignment from the ->is_queued assignment.

-- 
2.51.2


