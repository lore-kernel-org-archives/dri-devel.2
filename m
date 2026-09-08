Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BE5C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F6210EB13;
	Tue,  8 Sep 2026 11:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HLWafxTw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D3410EB13
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 11:00:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 33C8260AA2;
 Tue,  8 Sep 2026 11:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3361F00A3F;
 Tue,  8 Sep 2026 11:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788865255;
 bh=YUBi9cz8P5up80+XfrrGReU0+/VNjJYUMKNLQu76ATw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HLWafxTwNoUcaPxfktKqbC1ra7sh9/CWHu+D2DJTV8lZcAWyoKxwWO7A6yP8IMkA2
 AhFipwqC2X/sx3X63BxphU/0fWifll25efLNDQmGMhzZU/ciwWg6GOUl6OAQI+4N6r
 nhqqhCpcf1s5f2myySQvwhoP9l+OUvbwsnd6LpmaIgV8/oQY+YF9qX671Vmtp1X9KU
 JPsX0fr5JJPTmHCys882nX4+WhZ2fLm9ZCwrVcQLAo7Jgjo4hIhlzyDnbIBN2VX7rH
 UMsx5p9O9AkrwD0IeFL9rwkuUkwvtIAH8jz0d4OgkNYCh3nFVg57wCRhf7GUHYHP/v
 mgaph7wKPnsUA==
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
Subject: [RFC PATCH 2/2] drm/i915: Adjust to RCU-less fence
Date: Tue,  8 Sep 2026 12:59:27 +0200
Message-ID: <20260908105926.1120378-3-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908105926.1120378-2-phasta@kernel.org>
References: <20260908105926.1120378-2-phasta@kernel.org>
MIME-Version: 1.0
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

dma_fence has been reworked in a way that it allows for handling fences
without any need for RCU functionality.

Adjust i915 accordingly.

(Serves as an example to show how the situation gets easier for users)

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_gt_requests.c | 10 ++++------
 drivers/gpu/drm/i915/i915_request.c         |  6 ++----
 drivers/gpu/drm/i915/i915_sw_fence.c        | 10 ++++------
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.c b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
index 93298820bee2..724c4359f688 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_requests.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
@@ -238,6 +238,8 @@ void intel_gt_fini_requests(struct intel_gt *gt)
 
 void intel_gt_watchdog_work(struct work_struct *work)
 {
+	char driver[64] = "";
+	char timeline[64] = "";
 	struct intel_gt *gt =
 		container_of(work, typeof(*gt), watchdog.work);
 	struct i915_request *rq, *rn;
@@ -250,17 +252,13 @@ void intel_gt_watchdog_work(struct work_struct *work)
 	llist_for_each_entry_safe(rq, rn, first, watchdog.link) {
 		if (!i915_request_completed(rq)) {
 			struct dma_fence *f = &rq->fence;
-			const char __rcu *timeline;
-			const char __rcu *driver;
 
-			rcu_read_lock();
-			driver = dma_fence_driver_name(f);
-			timeline = dma_fence_timeline_name(f);
+			dma_fence_driver_name(f, driver, 64);
+			dma_fence_timeline_name(f, timeline, 64);
 			pr_notice("Fence expiration time out i915-%s:%s:%llx!\n",
 				  rcu_dereference(driver),
 				  rcu_dereference(timeline),
 				  f->seqno);
-			rcu_read_unlock();
 			i915_request_cancel(rq, -EINTR);
 		}
 		i915_request_put(rq);
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index d2c7b1090df0..2a3df13217b9 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -2185,7 +2185,7 @@ void i915_request_show(struct drm_printer *m,
 		       const char *prefix,
 		       int indent)
 {
-	const char __rcu *timeline;
+	char timeline[64] = "";
 	char buf[80] = "";
 	int x = 0;
 
@@ -2221,8 +2221,7 @@ void i915_request_show(struct drm_printer *m,
 
 	x = print_sched_attr(&rq->sched.attr, buf, x, sizeof(buf));
 
-	rcu_read_lock();
-	timeline = dma_fence_timeline_name((struct dma_fence *)&rq->fence);
+	dma_fence_timeline_name((struct dma_fence *)&rq->fence, timeline, 64);
 	drm_printf(m, "%s%.*s%c %llx:%lld%s%s %s @ %dms: %s\n",
 		   prefix, indent, "                ",
 		   queue_status(rq),
@@ -2232,7 +2231,6 @@ void i915_request_show(struct drm_printer *m,
 		   buf,
 		   jiffies_to_msecs(jiffies - rq->emitted_jiffies),
 		   rcu_dereference(timeline));
-	rcu_read_unlock();
 }
 
 static bool engine_match_ring(struct intel_engine_cs *engine, struct i915_request *rq)
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index f24f616e23ee..d0e733beff86 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -427,25 +427,23 @@ static void dma_i915_sw_fence_wake(struct dma_fence *dma,
 
 static void timer_i915_sw_fence_wake(struct timer_list *t)
 {
+	char driver[64] = "";
+	char timeline[64] = "";
 	struct i915_sw_dma_fence_cb_timer *cb = timer_container_of(cb, t,
 								   timer);
 	struct i915_sw_fence *fence;
-	const char __rcu *timeline;
-	const char __rcu *driver;
 
 	fence = xchg(&cb->base.fence, NULL);
 	if (!fence)
 		return;
 
-	rcu_read_lock();
-	driver = dma_fence_driver_name(cb->dma);
-	timeline = dma_fence_timeline_name(cb->dma);
+	dma_fence_driver_name(cb->dma, driver, 64);
+	dma_fence_timeline_name(cb->dma, timeline, 64);
 	pr_notice("Asynchronous wait on fence %s:%s:%llx timed out (hint:%ps)\n",
 		  rcu_dereference(driver),
 		  rcu_dereference(timeline),
 		  cb->dma->seqno,
 		  i915_sw_fence_debug_hint(fence));
-	rcu_read_unlock();
 
 	i915_sw_fence_set_error_once(fence, -ETIMEDOUT);
 	i915_sw_fence_complete(fence);
-- 
2.55.0

