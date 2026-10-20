Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6D2606A32D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c03e0rOO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC40010F45D;
	Tue, 20 Oct 2026 10:02:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC7310F479;
 Tue, 20 Oct 2026 10:01:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 55DE443F20;
 Tue, 20 Oct 2026 10:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F3B1F000C8;
 Tue, 20 Oct 2026 10:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792490515;
 bh=6q8wiBkHoiL/KGYdZsxjGwRTuXA7qaumt7yvL4z0Drc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=c03e0rOONVKauuCZcof5oyBlChrq0q5SZ8Oppn1MU/MTb6Ti6tOaODLOGLscNVWCv
 TZz5ZTMLiff8MSa50ikjR+OvnJ7RiXIcO0QMVxaAKwqQVZzPyJ+qY7nCJQX8izE8aC
 gooND2yxrdV1ZovcyrH6ilskuJP0w+yDeaKI1JAlJ2mcvOmkasOqzP0tkxkz3l9ujB
 RZOkq0DnDWJpniJD9Ajnl7x1YWQ+Y4q8wFcJ66b3zN3HXbjWURqF7pc9R3KoLW+Lfv
 ejqveuO4n58X5coYMsjzBlNE8G7OIQBUdn9+BARpIC1zk56A/hR/1SGxxJDONadQAA
 uAYj1pgTKR3og==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [RFC PATCH v2 3/3] dma-fence: Support unload for ops->get_XXX_name()
Date: Tue, 20 Oct 2026 12:00:34 +0200
Message-ID: <20261020100034.759183-5-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020100034.759183-2-phasta@kernel.org>
References: <20261020100034.759183-2-phasta@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dma_fence's backend_ops get_driver_name() and get_timeline_name() have
an unnecessary and complicated RCU requirement.

Usage in sync_file, however, already shows how it can be done
significantly simpler: Copy the name strings to the user.

All that needs to be ensured for that is that the signaled-state is
checked and that it cannot change while the callback runs, i.e., the
lock must be held.

Adjust the two callbacks so that they deep-copy name parameters under
lock-protection.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c                 | 73 ++++++++++-----------
 drivers/dma-buf/sync_file.c                 | 29 ++++----
 drivers/gpu/drm/i915/gt/intel_gt_requests.c | 16 ++---
 drivers/gpu/drm/i915/i915_request.c         |  9 ++-
 drivers/gpu/drm/i915/i915_sw_fence.c        | 15 ++---
 include/linux/dma-fence.h                   | 22 ++-----
 include/trace/events/dma_fence.h            | 12 ++--
 7 files changed, 77 insertions(+), 99 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index e4350bce9cf9..d473d4ea601a 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -555,23 +555,22 @@ void dma_fence_release(struct kref *kref)
 	struct dma_fence *fence =
 		container_of(kref, struct dma_fence, refcount);
 	const struct dma_fence_ops *ops = fence->ops;
+	const unsigned short len = 64;
+	char timeline[len];
+	char driver[len];
 
-	rcu_read_lock();
 	trace_dma_fence_destroy(fence);
 
 	if (!list_empty(&fence->cb_list) &&
 	    !dma_fence_test_signaled_flag(fence)) {
-		const char __rcu *timeline;
-		const char __rcu *driver;
 		unsigned long flags;
 
-		driver = dma_fence_driver_name(fence);
-		timeline = dma_fence_timeline_name(fence);
+		dma_fence_driver_name(fence, driver, len);
+		dma_fence_timeline_name(fence, timeline, len);
 
 		WARN(1,
 		     "Fence %s:%s:%llx:%llx released with pending signals!\n",
-		     rcu_dereference(driver), rcu_dereference(timeline),
-		     fence->context, fence->seqno);
+		     driver, timeline, fence->context, fence->seqno);
 
 		/*
 		 * Failed to signal before release, likely a refcounting issue.
@@ -590,7 +589,6 @@ void dma_fence_release(struct kref *kref)
 		ops->release(fence);
 	else
 		dma_fence_free(fence);
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL(dma_fence_release);
 
@@ -1017,23 +1015,20 @@ EXPORT_SYMBOL(dma_fence_set_deadline);
  */
 void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq)
 {
-	const char __rcu *timeline = (const char __rcu *)"";
-	const char __rcu *driver = (const char __rcu *)"";
-	const char *signaled = "";
-
-	rcu_read_lock();
+	const unsigned short len = 64;
+	char timeline[len];
+	char driver[len];
+	char *signaled;
 
 	if (!dma_fence_is_signaled(fence)) {
-		timeline = dma_fence_timeline_name(fence);
-		driver = dma_fence_driver_name(fence);
+		dma_fence_timeline_name(fence, timeline, len);
+		dma_fence_driver_name(fence, driver, len);
 		signaled = "un";
 	}
 
 	seq_printf(seq, "%llu:%llu %s %s %ssignalled\n",
 		   fence->context, fence->seqno, timeline, driver,
 		   signaled);
-
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL(dma_fence_describe);
 
@@ -1129,20 +1124,22 @@ EXPORT_SYMBOL(dma_fence_init64);
  * memory potentially accessed by the &dma_fence.ops functions, is forbidden
  * after the fence has been signalled. Drivers are allowed to free that data,
  * and some do.
- *
- * To allow safe access drivers are mandated to guarantee a RCU grace period
- * between signalling the fence and freeing said data.
- *
- * As such access to the driver name is only valid inside a RCU locked section.
- * The pointer MUST be both queried and USED ONLY WITHIN a SINGLE block guarded
- * by the &rcu_read_lock and &rcu_read_unlock pair.
  */
-const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
+void dma_fence_driver_name(struct dma_fence *fence, char *s, unsigned short len)
 {
+	unsigned long flags;
+	const char *tmp;
+
+	dma_fence_lock_irqsave(fence, flags);
+
 	if (!dma_fence_test_signaled_flag(fence))
-		return (const char __rcu *)fence->ops->get_driver_name(fence);
+		tmp = fence->ops->get_driver_name(fence);
 	else
-		return (const char __rcu *)"detached-driver";
+		tmp = "detached-driver";
+
+	strscpy(s, tmp, len);
+
+	dma_fence_unlock_irqrestore(fence, flags);
 }
 EXPORT_SYMBOL(dma_fence_driver_name);
 
@@ -1158,19 +1155,21 @@ EXPORT_SYMBOL(dma_fence_driver_name);
  * memory potentially accessed by the &dma_fence.ops functions, is forbidden
  * after the fence has been signalled. Drivers are allowed to free that data,
  * and some do.
- *
- * To allow safe access drivers are mandated to guarantee a RCU grace period
- * between signalling the fence and freeing said data.
- *
- * As such access to the driver name is only valid inside a RCU locked section.
- * The pointer MUST be both queried and USED ONLY WITHIN a SINGLE block guarded
- * by the &rcu_read_lock and &rcu_read_unlock pair.
  */
-const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
+void dma_fence_timeline_name(struct dma_fence *fence, char *s, unsigned short len)
 {
+	unsigned long flags;
+	const char *tmp;
+
+	dma_fence_lock_irqsave(fence, flags);
+
 	if (!dma_fence_test_signaled_flag(fence))
-		return (const char __rcu *)fence->ops->get_timeline_name(fence);
+		tmp = fence->ops->get_timeline_name(fence);
 	else
-		return (const char __rcu *)"signaled-timeline";
+		tmp = "signaled-timeline";
+
+	strscpy(s, tmp, len);
+
+	dma_fence_unlock_irqrestore(fence, flags);
 }
 EXPORT_SYMBOL(dma_fence_timeline_name);
diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index 2166bbdf7e4a..0f08713b3b5e 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -18,6 +18,8 @@
 #include <linux/sync_file.h>
 #include <uapi/linux/sync_file.h>
 
+#define FENCE_NAME_LEN 64
+
 static const struct file_operations sync_file_fops;
 
 static struct sync_file *sync_file_alloc(void)
@@ -131,22 +133,21 @@ EXPORT_SYMBOL(sync_file_get_fence);
  */
 char *sync_file_get_name(struct sync_file *sync_file, char *buf, int len)
 {
+	char timeline[FENCE_NAME_LEN];
+	char driver[FENCE_NAME_LEN];
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
+		dma_fence_driver_name(fence, driver, FENCE_NAME_LEN);
+		dma_fence_timeline_name(fence, timeline, FENCE_NAME_LEN);
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
@@ -268,19 +269,11 @@ static long sync_file_ioctl_merge(struct sync_file *sync_file,
 static int sync_fill_fence_info(struct dma_fence *fence,
 				 struct sync_fence_info *info)
 {
-	const char __rcu *timeline;
-	const char __rcu *driver;
+	dma_fence_timeline_name(fence, info->obj_name, sizeof(info->obj_name));
+	dma_fence_driver_name(fence, info->driver_name, sizeof(info->driver_name));
 
 	rcu_read_lock();
 
-	driver = dma_fence_driver_name(fence);
-	timeline = dma_fence_timeline_name(fence);
-
-	strscpy(info->obj_name, rcu_dereference(timeline),
-		sizeof(info->obj_name));
-	strscpy(info->driver_name, rcu_dereference(driver),
-		sizeof(info->driver_name));
-
 	info->status = dma_fence_get_status(fence);
 	info->timestamp_ns =
 		dma_fence_is_signaled(fence) ?
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.c b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
index 93298820bee2..a37069ca6d2a 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_requests.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
@@ -240,8 +240,12 @@ void intel_gt_watchdog_work(struct work_struct *work)
 {
 	struct intel_gt *gt =
 		container_of(work, typeof(*gt), watchdog.work);
+	const unsigned short len = 64;
 	struct i915_request *rq, *rn;
 	struct llist_node *first;
+	char timeline[len];
+	char driver[len];
+
 
 	first = llist_del_all(&gt->watchdog.list);
 	if (!first)
@@ -250,17 +254,13 @@ void intel_gt_watchdog_work(struct work_struct *work)
 	llist_for_each_entry_safe(rq, rn, first, watchdog.link) {
 		if (!i915_request_completed(rq)) {
 			struct dma_fence *f = &rq->fence;
-			const char __rcu *timeline;
-			const char __rcu *driver;
 
-			rcu_read_lock();
-			driver = dma_fence_driver_name(f);
-			timeline = dma_fence_timeline_name(f);
+			dma_fence_driver_name(f, driver, len);
+			dma_fence_timeline_name(f, timeline, len);
 			pr_notice("Fence expiration time out i915-%s:%s:%llx!\n",
-				  rcu_dereference(driver),
-				  rcu_dereference(timeline),
+				  driver,
+				  timeline,
 				  f->seqno);
-			rcu_read_unlock();
 			i915_request_cancel(rq, -EINTR);
 		}
 		i915_request_put(rq);
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index d2c7b1090df0..c81902d8a89a 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -2185,7 +2185,8 @@ void i915_request_show(struct drm_printer *m,
 		       const char *prefix,
 		       int indent)
 {
-	const char __rcu *timeline;
+	const unsigned short len = 64;
+	char timeline[len];
 	char buf[80] = "";
 	int x = 0;
 
@@ -2221,8 +2222,7 @@ void i915_request_show(struct drm_printer *m,
 
 	x = print_sched_attr(&rq->sched.attr, buf, x, sizeof(buf));
 
-	rcu_read_lock();
-	timeline = dma_fence_timeline_name((struct dma_fence *)&rq->fence);
+	dma_fence_timeline_name((struct dma_fence *)&rq->fence, timeline, len);
 	drm_printf(m, "%s%.*s%c %llx:%lld%s%s %s @ %dms: %s\n",
 		   prefix, indent, "                ",
 		   queue_status(rq),
@@ -2231,8 +2231,7 @@ void i915_request_show(struct drm_printer *m,
 		   fence_status(rq),
 		   buf,
 		   jiffies_to_msecs(jiffies - rq->emitted_jiffies),
-		   rcu_dereference(timeline));
-	rcu_read_unlock();
+		   timeline);
 }
 
 static bool engine_match_ring(struct intel_engine_cs *engine, struct i915_request *rq)
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index f24f616e23ee..08b5f96ae2a5 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -429,23 +429,22 @@ static void timer_i915_sw_fence_wake(struct timer_list *t)
 {
 	struct i915_sw_dma_fence_cb_timer *cb = timer_container_of(cb, t,
 								   timer);
+	const unsigned short len = 64;
 	struct i915_sw_fence *fence;
-	const char __rcu *timeline;
-	const char __rcu *driver;
+	char timeline[len];
+	char driver[len];
 
 	fence = xchg(&cb->base.fence, NULL);
 	if (!fence)
 		return;
 
-	rcu_read_lock();
-	driver = dma_fence_driver_name(cb->dma);
-	timeline = dma_fence_timeline_name(cb->dma);
+	dma_fence_driver_name(cb->dma, driver, len);
+	dma_fence_timeline_name(cb->dma, timeline, len);
 	pr_notice("Asynchronous wait on fence %s:%s:%llx timed out (hint:%ps)\n",
-		  rcu_dereference(driver),
-		  rcu_dereference(timeline),
+		  driver,
+		  timeline,
 		  cb->dma->seqno,
 		  i915_sw_fence_debug_hint(fence));
-	rcu_read_unlock();
 
 	i915_sw_fence_set_error_once(fence, -ETIMEDOUT);
 	i915_sw_fence_complete(fence);
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 2223d75c5a49..08ecbc101f4c 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -459,25 +459,11 @@ void dma_fence_enable_signaling(struct dma_fence *fence);
 /**
  * DOC: Safe external access to driver provided object members
  *
- * All data not stored directly in the dma-fence object, such as the
- * &dma_fence.lock and memory potentially accessed by functions in the
- * &dma_fence.ops table, MUST NOT be accessed after the fence has been signalled
- * because after that point drivers are allowed to free it.
- *
- * All code accessing that data via the dma-fence API (or directly, which is
- * discouraged), MUST make sure to contain the complete access within a
- * &rcu_read_lock and &rcu_read_unlock pair.
- *
- * Some dma-fence API handles this automatically, while other, as for example
- * &dma_fence_driver_name and &dma_fence_timeline_name, leave that
- * responsibility to the caller.
- *
- * To enable this scheme to work drivers MUST ensure a RCU grace period elapses
- * between signalling the fence and freeing the said data.
- *
+ * Provides naming information strings about the fence if it is not yet signaled.
+ * Otherwise, provides default strings.
  */
-const char __rcu *dma_fence_driver_name(struct dma_fence *fence);
-const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
+void dma_fence_driver_name(struct dma_fence *fence, char *s, unsigned short len);
+void dma_fence_timeline_name(struct dma_fence *fence, char *s, unsigned short len);
 
 /*
  * dma_fence_test_signaled_flag - Only check whether a fence is signaled yet.
diff --git a/include/trace/events/dma_fence.h b/include/trace/events/dma_fence.h
index 5b10a9e06fb4..f3b929b98cf4 100644
--- a/include/trace/events/dma_fence.h
+++ b/include/trace/events/dma_fence.h
@@ -9,6 +9,8 @@
 
 struct dma_fence;
 
+#define FENCE_NAME_LEN 64
+
 DECLARE_EVENT_CLASS(dma_fence,
 
 	TP_PROTO(struct dma_fence *fence),
@@ -16,21 +18,21 @@ DECLARE_EVENT_CLASS(dma_fence,
 	TP_ARGS(fence),
 
 	TP_STRUCT__entry(
-		__string(driver, dma_fence_driver_name(fence))
-		__string(timeline, dma_fence_timeline_name(fence))
+		__array(char, driver, FENCE_NAME_LEN)
+		__array(char, timeline, FENCE_NAME_LEN)
 		__field(unsigned int, context)
 		__field(unsigned int, seqno)
 	),
 
 	TP_fast_assign(
-		__assign_str(driver);
-		__assign_str(timeline);
+		dma_fence_driver_name(fence, __entry->driver, FENCE_NAME_LEN);
+		dma_fence_timeline_name(fence, __entry->timeline, FENCE_NAME_LEN);
 		__entry->context = fence->context;
 		__entry->seqno = fence->seqno;
 	),
 
 	TP_printk("driver=%s timeline=%s context=%u seqno=%u",
-		  __get_str(driver), __get_str(timeline), __entry->context,
+		  __entry->driver, __entry->timeline, __entry->context,
 		  __entry->seqno)
 );
 
-- 
2.56.0

