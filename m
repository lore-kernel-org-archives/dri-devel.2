Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE916C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F7088DA9;
	Tue,  8 Sep 2026 11:00:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aHw7QSn3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309E510EB13
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 11:00:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0AFD5402A8;
 Tue,  8 Sep 2026 11:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BE81F00A3A;
 Tue,  8 Sep 2026 11:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788865251;
 bh=VV0KWSFYOBK12xPMfbOhOETePxI2M8SE33LNJodwghY=;
 h=From:To:Cc:Subject:Date;
 b=aHw7QSn3xXUyIIUyNgVwMVSisvxCY6CjOohjWfyQSrerqh3uTEoIE6xfP+mxoFYDM
 +7/jucHbE+dEDq1RpLAY8v/EOrkSP7IEqsjWkVJh6fTs/XcZXz0WRY3DbYasnXg5om
 ocX6fyZycn/QA5Z4uWJEtS6GNPlOsCNmMtnOu0YG7y8kCjj+cMOPQeXNko+alFDIRR
 JDYPdefqCmUvL5O2WoxnME5aAa2+iuUMoKcPibdEt63uIQi1TU8lgVW02mSd7/SzeT
 vUelSmFHlyD72zMDIjh3fx+96yJu/zABtUnP8Ya4UTPuR/PjH905Y+kml6R5kf6PML
 kjpHM4iAlTTxw==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, dakr@kernel.org,
 Marco Pagani <marco.pagani@linux.dev>, Alice Ryhl <aliceryhl@google.com>,
 Gary Guo <gary@garyguo.net>, Jonghyuk Kim <malhyuk97@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [RFC PATCH 1/2] dma-fence: Solve dma_fence's problems with additional
 spinlock
Date: Tue,  8 Sep 2026 12:59:26 +0200
Message-ID: <20260908105926.1120378-2-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

dma_fence's life time is solved already through refcounting. What breaks
the implementation's neck are
 a) shared spinlocks via a pointer, so usage of a dma_fence lock can cause UAF
    if the driver unloaded, although the user still holds a reference.
 b) callbacks which can run into the driver after unload.

These problems have been worked around by introducing RCU grace periods
into the implementation, with the rule of drivers only being allowed to
free resources and / or unload after waiting for a grace period. This is
fragile.

The right solution to address these problems is:
  1. Give fences a spinlock which is always theirs and, thus, respects
     their life time.
  2. Use this lock to guard all fence data, i.e. especially the fence
     state, to synchronize the signaled state.
  3. Enabled by the previous point, the signaled-bit of a fence can be
     used as a hard decoupling point after which the driver is free to
     do what it prefers.
  4. Do not run into any callbacks after a fence is signaled, since
     after this point the driver might have been unloaded.

This new, additional lock, is an internal component which must never be
taken by users manually. All locking must be handled through API
functions which have a well-defined contract.

This, in the long run, will reduce the fragility and even complexity of
dma_fence greatly, since all need for RCU falls away.

One way to address the get_timeline_name() and get_driver_name()
callbacks is presented here: the callbacks are called under lock
protection if the fence is not signaled yet, and the returned strings
are just copied into new buffers.

The callbacks which cannot be fully solved yet are ops->release() and
ops->wait. The former because they always need to be called when the
refcount drops to 0, the latter because it might sleep and cannot be
guarded by a spinlock.

Possible solutions for these callbacks could be to keep the RCU-handling
of the ops pointer for now, or to work towards removing the callbacks'
users – or maybe to go back to the old broken state where these drivers
were on their own.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Just a quickly scetched out idea. Untested; also needs some twirks to
make the tracepoint compile.

I think this is what dma_fence should have been from the beginning, but
here we are.

If we can get to a solution with ops->release and ops->wait, we could
phase out the external_lock in the long run.
---
 drivers/dma-buf/dma-fence.c | 220 +++++++++++++++++++++---------------
 drivers/dma-buf/sync_file.c |  31 +++--
 include/linux/dma-fence.h   | 102 ++++++++++++-----
 3 files changed, 217 insertions(+), 136 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 05090fb0fd5a..cb85811381a1 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -26,6 +26,9 @@ EXPORT_TRACEPOINT_SYMBOL(dma_fence_signaled);
 
 static struct dma_fence dma_fence_stub;
 
+void dma_fence_driver_name_locked(struct dma_fence *fence, char *buff, unsigned short len);
+void dma_fence_timeline_name_locked(struct dma_fence *fence, char *buff, unsigned short len);
+
 /*
  * fence context counter: each execution context should have its own
  * fence context, this allows checking if fences belong to the same
@@ -336,7 +339,7 @@ void __dma_fence_might_wait(void)
 #endif
 
 /**
- * dma_fence_signal_timestamp_locked - signal completion of a fence
+ * dma_fence_signal_timestamp_locked_full - signal completion of a fence
  * @fence: the fence to signal
  * @timestamp: fence signal timestamp in kernel's CLOCK_MONOTONIC time domain
  *
@@ -350,10 +353,9 @@ void __dma_fence_might_wait(void)
  * Unlike dma_fence_signal_timestamp(), this function must be called with
  * &dma_fence.lock held.
  */
-void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
+void dma_fence_signal_timestamp_locked_full(struct dma_fence *fence,
 				      ktime_t timestamp)
 {
-	const struct dma_fence_ops *ops;
 	struct dma_fence_cb *cur, *tmp;
 	struct list_head cb_list;
 
@@ -365,15 +367,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 
 	trace_dma_fence_signaled(fence);
 
-	/*
-	 * When neither a release nor a wait operation is specified set the ops
-	 * pointer to NULL to allow the fence structure to become independent
-	 * from who originally issued it.
-	 */
-	ops = rcu_dereference_protected(fence->ops, true);
-	if (!ops->release && !ops->wait)
-		RCU_INIT_POINTER(fence->ops, NULL);
-
 	/* Stash the cb_list before replacing it with the timestamp */
 	list_replace(&fence->cb_list, &cb_list);
 
@@ -385,7 +378,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 		cur->func(fence, cur);
 	}
 }
-EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
 
 /**
  * dma_fence_signal_timestamp - signal completion of a fence
@@ -401,17 +393,26 @@ EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
  */
 void dma_fence_signal_timestamp(struct dma_fence *fence, ktime_t timestamp)
 {
-	unsigned long flags;
+	unsigned long flags, flags_full;
 
 	if (WARN_ON(!fence))
 		return;
 
+	dma_fence_lock_full(fence, &flags_full);
 	dma_fence_lock_irqsave(fence, flags);
-	dma_fence_signal_timestamp_locked(fence, timestamp);
+
+	dma_fence_signal_timestamp_locked_full(fence, timestamp);
+
 	dma_fence_unlock_irqrestore(fence, flags);
+	dma_fence_unlock_full(fence, &flags_full);
 }
 EXPORT_SYMBOL(dma_fence_signal_timestamp);
 
+void dma_fence_signal_locked_full(struct dma_fence *fence)
+{
+	dma_fence_signal_timestamp_locked_full(fence, ktime_get());
+}
+
 /**
  * dma_fence_signal_locked - signal completion of a fence
  * @fence: the fence to signal
@@ -427,7 +428,11 @@ EXPORT_SYMBOL(dma_fence_signal_timestamp);
  */
 void dma_fence_signal_locked(struct dma_fence *fence)
 {
-	dma_fence_signal_timestamp_locked(fence, ktime_get());
+	unsigned long flags;
+
+	dma_fence_lock_full(fence, &flags);
+	dma_fence_signal_locked_full(fence);
+	dma_fence_unlock_full(fence, &flags);
 }
 EXPORT_SYMBOL(dma_fence_signal_locked);
 
@@ -487,7 +492,7 @@ EXPORT_SYMBOL(dma_fence_check_and_signal);
  */
 void dma_fence_signal(struct dma_fence *fence)
 {
-	unsigned long flags;
+	unsigned long flags, flags_full;
 	bool tmp;
 
 	if (WARN_ON(!fence))
@@ -495,9 +500,13 @@ void dma_fence_signal(struct dma_fence *fence)
 
 	tmp = dma_fence_begin_signalling();
 
+	dma_fence_lock_full(fence, &flags_full);
 	dma_fence_lock_irqsave(fence, flags);
-	dma_fence_signal_timestamp_locked(fence, ktime_get());
+
+	dma_fence_signal_timestamp_locked_full(fence, ktime_get());
+
 	dma_fence_unlock_irqrestore(fence, flags);
+	dma_fence_unlock_full(fence, &flags_full);
 
 	dma_fence_end_signalling(tmp);
 }
@@ -524,7 +533,6 @@ EXPORT_SYMBOL(dma_fence_signal);
 signed long
 dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 {
-	const struct dma_fence_ops *ops;
 	signed long ret;
 
 	if (WARN_ON(timeout < 0))
@@ -532,24 +540,16 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 
 	might_sleep();
 
+	// TODO: what could we do about wait_timeout?
+
 	__dma_fence_might_wait();
 
 	dma_fence_enable_signaling(fence);
 
-	rcu_read_lock();
-	ops = rcu_dereference(fence->ops);
 	trace_dma_fence_wait_start(fence);
-	if (ops && ops->wait) {
-		/*
-		 * Implementing the wait ops is deprecated and not supported for
-		 * issuers of fences who need their lifetime to be independent
-		 * of their module after they signal, so it is ok to use the
-		 * ops outside the RCU protected section.
-		 */
-		rcu_read_unlock();
-		ret = ops->wait(fence, intr, timeout);
+	if (fence->ops->wait) {
+		ret = fence->ops->wait(fence, intr, timeout);
 	} else {
-		rcu_read_unlock();
 		ret = dma_fence_default_wait(fence, intr, timeout);
 	}
 	if (trace_dma_fence_wait_end_enabled()) {
@@ -570,26 +570,26 @@ EXPORT_SYMBOL(dma_fence_wait_timeout);
  */
 void dma_fence_release(struct kref *kref)
 {
+	unsigned long flags;
+	char driver[64] = "";
+	char timeline[64] = "";
 	struct dma_fence *fence =
 		container_of(kref, struct dma_fence, refcount);
-	const struct dma_fence_ops *ops;
 
-	rcu_read_lock();
 	trace_dma_fence_destroy(fence);
 
+	dma_fence_lock_full(fence, &flags);
+
 	if (!list_empty(&fence->cb_list) &&
 	    !dma_fence_test_signaled_flag(fence)) {
-		const char __rcu *timeline;
-		const char __rcu *driver;
 		unsigned long flags;
 
-		driver = dma_fence_driver_name(fence);
-		timeline = dma_fence_timeline_name(fence);
+		dma_fence_driver_name_locked(fence, driver, 64);
+		dma_fence_timeline_name_locked(fence, timeline, 64);
 
 		WARN(1,
 		     "Fence %s:%s:%llx:%llx released with pending signals!\n",
-		     rcu_dereference(driver), rcu_dereference(timeline),
-		     fence->context, fence->seqno);
+		     driver, timeline, fence->context, fence->seqno);
 
 		/*
 		 * Failed to signal before release, likely a refcounting issue.
@@ -600,16 +600,19 @@ void dma_fence_release(struct kref *kref)
 		 */
 		dma_fence_lock_irqsave(fence, flags);
 		fence->error = -EDEADLK;
-		dma_fence_signal_locked(fence);
+		dma_fence_signal_locked_full(fence);
 		dma_fence_unlock_irqrestore(fence, flags);
 	}
 
-	ops = rcu_dereference(fence->ops);
-	if (ops && ops->release)
-		ops->release(fence);
+	dma_fence_unlock_full(fence, &flags);
+
+	// TODO: could then run into unloaded driver. Do we want to keep RCU
+	// just for the two deprecated callbacks?
+
+	if (fence->ops->release)
+		fence->ops->release(fence);
 	else
 		dma_fence_free(fence);
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL(dma_fence_release);
 
@@ -622,13 +625,12 @@ EXPORT_SYMBOL(dma_fence_release);
  */
 void dma_fence_free(struct dma_fence *fence)
 {
-	kfree_rcu(fence, rcu);
+	kfree(fence);
 }
 EXPORT_SYMBOL(dma_fence_free);
 
 static bool __dma_fence_enable_signaling(struct dma_fence *fence)
 {
-	const struct dma_fence_ops *ops;
 	bool was_set;
 
 	dma_fence_assert_held(fence);
@@ -639,18 +641,14 @@ static bool __dma_fence_enable_signaling(struct dma_fence *fence)
 	if (dma_fence_test_signaled_flag(fence))
 		return false;
 
-	rcu_read_lock();
-	ops = rcu_dereference(fence->ops);
-	if (!was_set && ops && ops->enable_signaling) {
+	if (!was_set && fence->ops->enable_signaling) {
 		trace_dma_fence_enable_signal(fence);
 
-		if (!ops->enable_signaling(fence)) {
-			rcu_read_unlock();
-			dma_fence_signal_locked(fence);
+		if (!fence->ops->enable_signaling(fence)) {
+			dma_fence_signal_locked_full(fence);
 			return false;
 		}
 	}
-	rcu_read_unlock();
 
 	return true;
 }
@@ -665,11 +663,15 @@ static bool __dma_fence_enable_signaling(struct dma_fence *fence)
  */
 void dma_fence_enable_signaling(struct dma_fence *fence)
 {
-	unsigned long flags;
+	unsigned long flags, flags_full;
 
+	dma_fence_lock_full(fence, &flags_full);
 	dma_fence_lock_irqsave(fence, flags);
+
 	__dma_fence_enable_signaling(fence);
+
 	dma_fence_unlock_irqrestore(fence, flags);
+	dma_fence_unlock_full(fence, &flags_full);
 }
 EXPORT_SYMBOL(dma_fence_enable_signaling);
 
@@ -698,15 +700,18 @@ EXPORT_SYMBOL(dma_fence_enable_signaling);
 int dma_fence_add_callback(struct dma_fence *fence, struct dma_fence_cb *cb,
 			   dma_fence_func_t func)
 {
-	unsigned long flags;
+	unsigned long flags, flags_full;
 	int ret = 0;
 
 	if (WARN_ON(!fence || !func))
 		return -EINVAL;
 
+	dma_fence_lock_full(fence, &flags_full);
+
 	if (dma_fence_test_signaled_flag(fence)) {
 		INIT_LIST_HEAD(&cb->node);
-		return -ENOENT;
+		ret = -ENOENT;
+		goto out;
 	}
 
 	dma_fence_lock_irqsave(fence, flags);
@@ -718,6 +723,8 @@ int dma_fence_add_callback(struct dma_fence *fence, struct dma_fence_cb *cb,
 		ret = -ENOENT;
 	}
 	dma_fence_unlock_irqrestore(fence, flags);
+out:
+	dma_fence_unlock_full(fence, &flags_full);
 
 	return ret;
 }
@@ -737,12 +744,16 @@ EXPORT_SYMBOL(dma_fence_add_callback);
  */
 int dma_fence_get_status(struct dma_fence *fence)
 {
-	unsigned long flags;
+	unsigned long flags, flags_full;
 	int status;
 
+	dma_fence_lock_full(fence, &flags_full);
 	dma_fence_lock_irqsave(fence, flags);
-	status = dma_fence_get_status_locked(fence);
+
+	status = dma_fence_get_status_locked_full(fence);
+
 	dma_fence_unlock_irqrestore(fence, flags);
+	dma_fence_unlock_full(fence, &flags_full);
 
 	return status;
 }
@@ -769,14 +780,18 @@ EXPORT_SYMBOL(dma_fence_get_status);
 bool
 dma_fence_remove_callback(struct dma_fence *fence, struct dma_fence_cb *cb)
 {
-	unsigned long flags;
+	unsigned long flags, flags_full;
 	bool ret;
 
+	dma_fence_lock_full(fence, &flags_full);
 	dma_fence_lock_irqsave(fence, flags);
+
 	ret = !list_empty(&cb->node);
 	if (ret)
 		list_del_init(&cb->node);
+
 	dma_fence_unlock_irqrestore(fence, flags);
+	dma_fence_unlock_full(fence, &flags_full);
 
 	return ret;
 }
@@ -1019,13 +1034,17 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
  */
 void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
 {
-	const struct dma_fence_ops *ops;
+	unsigned long flags;
 
-	rcu_read_lock();
-	ops = rcu_dereference(fence->ops);
-	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
-		ops->set_deadline(fence, deadline);
-	rcu_read_unlock();
+	dma_fence_lock_full(fence, &flags);
+	if (dma_fence_is_signaled_locked_full(fence))
+		goto out;
+
+	if (fence->ops->set_deadline && !dma_fence_is_signaled_locked_full(fence))
+		fence->ops->set_deadline(fence, deadline);
+
+out:
+	dma_fence_unlock_full(fence, &flags);
 }
 EXPORT_SYMBOL(dma_fence_set_deadline);
 
@@ -1038,23 +1057,24 @@ EXPORT_SYMBOL(dma_fence_set_deadline);
  */
 void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq)
 {
-	const char __rcu *timeline = (const char __rcu *)"";
-	const char __rcu *driver = (const char __rcu *)"";
+	unsigned long flags;
+	char timeline[64] = "";
+	char driver[64] = "";
 	const char *signaled = "";
 
-	rcu_read_lock();
+	dma_fence_lock_full(fence, &flags);
 
-	if (!dma_fence_is_signaled(fence)) {
-		timeline = dma_fence_timeline_name(fence);
-		driver = dma_fence_driver_name(fence);
+	if (!dma_fence_is_signaled_locked_full(fence)) {
+		dma_fence_timeline_name_locked(fence, timeline, 64);
+		dma_fence_driver_name_locked(fence, driver, 64);
 		signaled = "un";
 	}
 
+	dma_fence_unlock_full(fence, &flags);
+
 	seq_printf(seq, "%llu:%llu %s %s %ssignalled\n",
 		   fence->context, fence->seqno, timeline, driver,
 		   signaled);
-
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL(dma_fence_describe);
 
@@ -1064,6 +1084,7 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
 {
 	BUG_ON(!ops || !ops->get_driver_name || !ops->get_timeline_name);
 
+	spin_lock_init(&fence->full_lock);
 	kref_init(&fence->refcount);
 	/*
 	 * While it is counter intuitive to protect a constant function pointer
@@ -1144,6 +1165,16 @@ dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
 }
 EXPORT_SYMBOL(dma_fence_init64);
 
+void dma_fence_driver_name_locked(struct dma_fence *fence, char *buff, unsigned short len)
+{
+	if (dma_fence_test_signaled_flag(fence)) {
+		strscpy(buff, "detached-driver", len);
+	} else {
+		strscpy(buff, fence->ops->get_driver_name(fence), len);
+	}
+}
+
+
 /**
  * dma_fence_driver_name - Access the driver name
  * @fence: the fence to query
@@ -1164,19 +1195,30 @@ EXPORT_SYMBOL(dma_fence_init64);
  * The pointer MUST be both queried and USED ONLY WITHIN a SINGLE block guarded
  * by the &rcu_read_lock and &rcu_read_unlock pair.
  */
-const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
+void dma_fence_driver_name(struct dma_fence *fence, char *buff, unsigned short len)
 {
-	const struct dma_fence_ops *ops;
+	unsigned long flags;
 
-	/* RCU protection is required for safe access to returned string */
-	ops = rcu_dereference(fence->ops);
-	if (ops)
-		return (const char __rcu *)ops->get_driver_name(fence);
-	else
-		return (const char __rcu *)"detached-driver";
+	if (len == 0)
+		return;
+
+	dma_fence_lock_full(fence, &flags);
+	dma_fence_driver_name_locked(fence, buff, len);
+	dma_fence_unlock_full(fence, &flags);
 }
 EXPORT_SYMBOL(dma_fence_driver_name);
 
+void dma_fence_timeline_name_locked(struct dma_fence *fence, char *buff, unsigned short len)
+{
+	if (dma_fence_test_signaled_flag(fence)) {
+		strscpy(buff, "detached-drivers-timeline", len);
+	} else {
+		strscpy(buff, fence->ops->get_timeline_name(fence), len);
+	}
+}
+
+
+
 /**
  * dma_fence_timeline_name - Access the timeline name
  * @fence: the fence to query
@@ -1197,15 +1239,15 @@ EXPORT_SYMBOL(dma_fence_driver_name);
  * The pointer MUST be both queried and USED ONLY WITHIN a SINGLE block guarded
  * by the &rcu_read_lock and &rcu_read_unlock pair.
  */
-const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
+void dma_fence_timeline_name(struct dma_fence *fence, char *buff, unsigned short len)
 {
-	const struct dma_fence_ops *ops;
+	unsigned long flags;
 
-	/* RCU protection is required for safe access to returned string */
-	ops = rcu_dereference(fence->ops);
-	if (ops)
-		return (const char __rcu *)ops->get_timeline_name(fence);
-	else
-		return (const char __rcu *)"signaled-timeline";
+	if (len == 0)
+		return;
+
+	dma_fence_lock_full(fence, &flags);
+	dma_fence_timeline_name_locked(fence, buff, len);
+	dma_fence_unlock_full(fence, &flags);
 }
 EXPORT_SYMBOL(dma_fence_timeline_name);
diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index 2166bbdf7e4a..9d791e00f4d9 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -131,22 +131,21 @@ EXPORT_SYMBOL(sync_file_get_fence);
  */
 char *sync_file_get_name(struct sync_file *sync_file, char *buf, int len)
 {
+	char driver[64] = "";
+	char timeline[64] = "";
+
 	if (sync_file->user_name[0]) {
 		strscpy(buf, sync_file->user_name, len);
 	} else {
 		struct dma_fence *fence = sync_file->fence;
-		const char __rcu *timeline;
-		const char __rcu *driver;
 
-		rcu_read_lock();
-		driver = dma_fence_driver_name(fence);
-		timeline = dma_fence_timeline_name(fence);
+		dma_fence_driver_name(fence, driver, 64);
+		dma_fence_timeline_name(fence, timeline, 64);
 		snprintf(buf, len, "%s-%s%llu-%lld",
-			 rcu_dereference(driver),
-			 rcu_dereference(timeline),
+			 driver,
+			 timeline,
 			 fence->context,
 			 fence->seqno);
-		rcu_read_unlock();
 	}
 
 	return buf;
@@ -268,17 +267,15 @@ static long sync_file_ioctl_merge(struct sync_file *sync_file,
 static int sync_fill_fence_info(struct dma_fence *fence,
 				 struct sync_fence_info *info)
 {
-	const char __rcu *timeline;
-	const char __rcu *driver;
+	char timeline[64];
+	char driver[64];
 
-	rcu_read_lock();
+	dma_fence_driver_name(fence, driver, 64);
+	dma_fence_timeline_name(fence, timeline, 64);
 
-	driver = dma_fence_driver_name(fence);
-	timeline = dma_fence_timeline_name(fence);
-
-	strscpy(info->obj_name, rcu_dereference(timeline),
+	strscpy(info->obj_name, timeline,
 		sizeof(info->obj_name));
-	strscpy(info->driver_name, rcu_dereference(driver),
+	strscpy(info->driver_name, driver,
 		sizeof(info->driver_name));
 
 	info->status = dma_fence_get_status(fence);
@@ -287,8 +284,6 @@ static int sync_fill_fence_info(struct dma_fence *fence,
 			ktime_to_ns(dma_fence_timestamp(fence)) :
 			ktime_set(0, 0);
 
-	rcu_read_unlock();
-
 	return info->status;
 }
 
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 158cd609f103..f22bc8783340 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -30,9 +30,9 @@ struct seq_file;
 
 /**
  * struct dma_fence - software synchronization primitive
+ * @full_lock: INTERNAL lock which must never be taken manually by API users!
  * @refcount: refcount for this fence
  * @ops: dma_fence_ops associated with this fence
- * @rcu: used for releasing fence with kfree_rcu
  * @cb_list: list of all callbacks to call
  * @extern_lock: external spin_lock_irqsave used for locking (deprecated)
  * @inline_lock: alternative internal spin_lock_irqsave used for locking
@@ -68,11 +68,12 @@ struct seq_file;
  * been completed, or never called at all.
  */
 struct dma_fence {
+	spinlock_t full_lock;
 	union {
 		spinlock_t *extern_lock;
 		spinlock_t inline_lock;
 	};
-	const struct dma_fence_ops __rcu *ops;
+	const struct dma_fence_ops *ops;
 	/*
 	 * We clear the callback list on kref_put so that by the time we
 	 * release the fence it is unused. No one should be adding to the
@@ -93,8 +94,6 @@ struct dma_fence {
 		struct list_head cb_list;
 		/* @cb_list replaced by @timestamp on dma_fence_signal() */
 		ktime_t timestamp;
-		/* @timestamp replaced by @rcu on dma_fence_release() */
-		struct rcu_head rcu;
 	};
 	u64 context;
 	u64 seqno;
@@ -415,6 +414,16 @@ static inline spinlock_t *dma_fence_spinlock(struct dma_fence *fence)
 #define dma_fence_unlock_irqrestore(fence, flags)	\
 	spin_unlock_irqrestore(dma_fence_spinlock(fence), flags)
 
+static void dma_fence_lock_full(struct dma_fence *fence, unsigned long *flags)
+{
+	spin_lock_irqsave(&fence->full_lock, *flags);
+}
+
+static void dma_fence_unlock_full(struct dma_fence *fence, unsigned long *flags)
+{
+	spin_unlock_irqrestore(&fence->full_lock, *flags);
+}
+
 /**
  * dma_fence_assert_held - lockdep assertion that fence is locked
  * @fence: the fence which should be locked
@@ -439,8 +448,9 @@ void dma_fence_signal(struct dma_fence *fence);
 bool dma_fence_check_and_signal(struct dma_fence *fence);
 bool dma_fence_check_and_signal_locked(struct dma_fence *fence);
 void dma_fence_signal_locked(struct dma_fence *fence);
+void dma_fence_signal_locked_full(struct dma_fence *fence);
 void dma_fence_signal_timestamp(struct dma_fence *fence, ktime_t timestamp);
-void dma_fence_signal_timestamp_locked(struct dma_fence *fence, ktime_t timestamp);
+void dma_fence_signal_timestamp_locked_full(struct dma_fence *fence, ktime_t timestamp);
 signed long dma_fence_default_wait(struct dma_fence *fence,
 				   bool intr, signed long timeout);
 int dma_fence_add_callback(struct dma_fence *fence,
@@ -470,8 +480,9 @@ void dma_fence_enable_signaling(struct dma_fence *fence);
  * between signalling the fence and freeing the said data.
  *
  */
-const char __rcu *dma_fence_driver_name(struct dma_fence *fence);
-const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
+void dma_fence_driver_name(struct dma_fence *fence, char *buff, unsigned short len);
+void dma_fence_timeline_name(struct dma_fence *fence, char *buff, unsigned short len);
+;
 
 /*
  * dma_fence_test_signaled_flag - Only check whether a fence is signaled yet.
@@ -510,19 +521,36 @@ dma_fence_test_signaled_flag(struct dma_fence *fence)
 static inline bool
 dma_fence_is_signaled_locked(struct dma_fence *fence)
 {
-	const struct dma_fence_ops *ops;
+	unsigned long flags;
+	bool ret = false;
 
+	dma_fence_lock_full(fence, &flags);
+
+	if (dma_fence_test_signaled_flag(fence)) {
+		ret = true;
+		goto out;
+	}
+
+	if (fence->ops->signaled && fence->ops->signaled(fence)) {
+		dma_fence_signal_locked(fence);
+		ret = true;
+	}
+
+out:
+	dma_fence_unlock_full(fence, &flags);
+	return ret;
+}
+
+static inline bool
+dma_fence_is_signaled_locked_full(struct dma_fence *fence)
+{
 	if (dma_fence_test_signaled_flag(fence))
 		return true;
 
-	rcu_read_lock();
-	ops = rcu_dereference(fence->ops);
-	if (ops && ops->signaled && ops->signaled(fence)) {
-		rcu_read_unlock();
-		dma_fence_signal_locked(fence);
+	if (fence->ops->signaled && fence->ops->signaled(fence)) {
+		dma_fence_signal_locked_full(fence);
 		return true;
 	}
-	rcu_read_unlock();
 
 	return false;
 }
@@ -546,21 +574,24 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
 static inline bool
 dma_fence_is_signaled(struct dma_fence *fence)
 {
-	const struct dma_fence_ops *ops;
+	unsigned long flags;
+	bool ret = false;
 
-	if (dma_fence_test_signaled_flag(fence))
-		return true;
+	dma_fence_lock_full(fence, &flags);
 
-	rcu_read_lock();
-	ops = rcu_dereference(fence->ops);
-	if (ops && ops->signaled && ops->signaled(fence)) {
-		rcu_read_unlock();
-		dma_fence_signal(fence);
-		return true;
+	if (dma_fence_test_signaled_flag(fence)) {
+		ret = true;
+		goto out;
 	}
-	rcu_read_unlock();
 
-	return false;
+	if (fence->ops->signaled && fence->ops->signaled(fence)) {
+		dma_fence_signal(fence);
+		ret = true;
+	}
+
+out:
+	dma_fence_unlock_full(fence, &flags);
+	return ret;
 }
 
 /**
@@ -656,14 +687,27 @@ static inline struct dma_fence *dma_fence_later(struct dma_fence *f1,
  * been signaled without an error condition, or a negative error code
  * if the fence has been completed in err.
  */
-static inline int dma_fence_get_status_locked(struct dma_fence *fence)
+static inline int dma_fence_get_status_locked_full(struct dma_fence *fence)
 {
-	if (dma_fence_is_signaled_locked(fence))
+	if (dma_fence_is_signaled_locked_full(fence))
 		return fence->error ?: 1;
 	else
 		return 0;
 }
 
+static inline int dma_fence_get_status_locked(struct dma_fence *fence)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	dma_fence_lock_full(fence, &flags);
+	if (dma_fence_is_signaled_locked_full(fence))
+		ret = fence->error ?: 1;
+	dma_fence_unlock_full(fence, &flags);
+
+	return ret;
+}
+
 int dma_fence_get_status(struct dma_fence *fence);
 
 /**
@@ -763,7 +807,7 @@ extern const struct dma_fence_ops dma_fence_chain_ops;
  */
 static inline bool dma_fence_is_array(struct dma_fence *fence)
 {
-	return rcu_access_pointer(fence->ops) == &dma_fence_array_ops;
+	return fence->ops == &dma_fence_array_ops;
 }
 
 /**
@@ -774,7 +818,7 @@ static inline bool dma_fence_is_array(struct dma_fence *fence)
  */
 static inline bool dma_fence_is_chain(struct dma_fence *fence)
 {
-	return rcu_access_pointer(fence->ops) == &dma_fence_chain_ops;
+	return fence->ops == &dma_fence_chain_ops;
 }
 
 /**
-- 
2.55.0

