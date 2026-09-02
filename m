Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48E3C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E90510F3E1;
	Thu,  3 Sep 2026 07:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iQFnXnFQ";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345B110F112
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:58:19 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so1097751a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788346699; x=1788951499; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cKOzquW3shhpHe9E1Zxbxrv1dgTm0ijUX8KBrUVXtfI=;
 b=iQFnXnFQBi+QvMmFUM2t/C+NqrJxLhcCVYRxHvijEE0L4u4X2fx+qaCH1yr/ngEnE2
 PKGny5ZoO1/gjGCrQPl/YDqIeGXpTB7QQeXDACVNzORKhzKRUiSd/t5meRAV/orXgeKn
 sTUFlxf+raxRc3ygB7fB/tezvdmzs9mFaI6+3gOR3ot45J7D4RZUPNdkrjTnSLozjGVh
 7KpjgCzrwcylogbvQ/y25+U3OAiStr4u7xbaoHc+ZgZ9ODO0ZI6lqJW50MF2vs7xcb/X
 orRfQbqVb+CwASToCqYhvar/ai8ssf6jrVCxLqGgqQcOEaH4YoX3uKD4oLnZCYYth92D
 V4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788346699; x=1788951499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cKOzquW3shhpHe9E1Zxbxrv1dgTm0ijUX8KBrUVXtfI=;
 b=PafcFoG0w5if93Yw9Bceqvbdn+kkRSz6SvLWs7NdgP81x9Eq1dGy/ZQPH/4glP0wRa
 h2NnDPkKjFma49GD9uL9lAyBhFkHtWa5F1C2mhPJ8IltQ8Ym8vZe2FUMhywYyj+vmzWt
 r2w3ImJ3nI4b7s16qVs6GLNh5aCIz4LpMj+4AIjewLN18pabfXcX3ZSDcMXWIEx17Vsn
 LFj+akRdgjpLP1DLpZdXgGx1HHlzmd6RWsbXvS+VCRgHASxL1gUjNP5nSpM2yJCmQLtk
 fhr2gjJR7hSzr/yvtl8bRs3OsYVUlrvdDXVjEql1/+GHNrV9WmJnBqG3CWaYvvhlMHzR
 vCsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWzPbBubL+wNIbn0t8qymYyDAfTZCXQzFVqEpxZ5IGEbkRvtYyzyAmC49IcbWaH9CK4UcNrgzDRWo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m460HHPuZCYsihCof0Bs6PxqXdetfSjiv5jYlu/tMv8AXlQCU6
 NBpPX7MSzrRDuyZguORIV3S1b5CHdzTNr1QfWLdO8rhCCm1HUM3guDuXxeygV2LADTBk
X-Gm-Gg: AYBFou2qzNZBgLyQWaGhEOjrjsHy8kENIIcTSsXeS0VCVOi+C3T+ppmp+gNR76xqI8K
 ANCtycUNMvTfVzsU6r5cBkl4Usa11Y/qXYKp5yrD6PTXYxf+PCboRdcOmj8d7j+e0kdfd744zb+
 qT40dkQ2WkeY22JJO2ibwuJI8w4IzdfDKDIkX6b5GR6WC069g3smFGhAOd1xGqgf2PoY+3XRJMe
 tSNI5rd8VysONVtWqcZ7k6wrfIYo9/mDmFJfgie3u2y+qgljDAN4IxnnQx//JrJBCj76G6hBboS
 4DR9y8D0cFkR2j7fUhr94Q+7Tev0PiRAnhMTDZMJq8kK96bhucAIzHz+LxJdGAigOUB/pZ7GCR7
 MP2WtXwgQgbtXNdoZ8V5G0KFivFTrwHW0vIB/tF2SZ5i8m1g6VuSNPNFKKkV6bsrA+2BgIACSSw
 yXqT8+wiTI85A3hXZE1go/Ku0/JDD5pkE2syy4zjI9RsTfjUP3kw5NZ0r1mnyXRVDLCP2rvk4xv
 BbEgiGnyh+7wzX9pAitxnj3F28=
X-Received: by 2002:a17:90b:4d82:b0:398:9be8:ea65 with SMTP id
 98e67ed59e1d1-39aee1ab4c4mr5010188a91.18.1788346698548; 
 Wed, 02 Sep 2026 03:58:18 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae0dfcd65sm4963143a91.3.2026.09.02.03.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 03:58:17 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: tursulin@ursulin.net, phasta@kernel.org, matthew.brost@intel.com,
 dakr@kernel.org
Cc: christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/sched: cache the timeline name to fix a
 use-after-free
Date: Wed,  2 Sep 2026 19:58:07 +0900
Message-ID: <20260902105808.1541063-2-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902105808.1541063-1-malhyuk97@gmail.com>
References: <20260902105808.1541063-1-malhyuk97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

drm_sched_fence_get_timeline_name() returns fence->sched->name, and the
drm_sched_fence ops keep a .release callback, so the fence is not
ops-detached on signalling (dma_fence_signal_timestamp_locked() only clears
->ops for fences without .release/.wait). The callback therefore stays
reachable on a long-signalled, userspace-held finished fence and
unconditionally dereferences fence->sched.

A driver that allocates a drm_gpu_scheduler at per-context/per-queue/per-VM
granularity and frees it on an unprivileged context/fd close, while
exporting the resulting finished fence to userspace (drm_syncobj /
sync_file / dma_resv), leaves fence->sched dangling after the free. A
subsequent SYNC_IOC_FILE_INFO ioctl (which calls get_timeline_name()) then
reads the freed scheduler:

  BUG: KASAN: slab-use-after-free in drm_sched_fence_get_timeline_name

This is the same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
(drm/panthor), which were fixed per-driver. amdxdna, nouveau and msm
(VM_BIND) are still affected in mainline, so fix it in the core to cover any
per-context-scheduler driver at once.

Cache the scheduler's name pointer in the fence at init time, while the
scheduler is guaranteed alive, and return the cached value from
get_timeline_name() without dereferencing fence->sched. The timeline name is
not guaranteed by the contract to outlive the scheduler, so document in
struct drm_sched_init_args that the @name passed to drm_sched_init() must
follow the dma-fence safe access rules and outlive any exported fence. Every
in-tree driver passes a string literal, which satisfies this; drm/xe's
299bc6d50b1b keeps its dynamically-allocated name alive across the RCU grace
and can be simplified on top of this.

Fixes: 506aa8b02a8d ("dma-fence: Add safe access helpers and document the rules")
Cc: stable@vger.kernel.org
Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_fence.c | 16 +++++++++++++++-
 include/drm/gpu_scheduler.h             | 18 +++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 096fe28aa9c9..a944eeeb25bd 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -92,7 +92,13 @@ static const char *drm_sched_fence_get_driver_name(struct dma_fence *fence)
 static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct drm_sched_fence *fence = to_drm_sched_fence(f);
-	return (const char *)fence->sched->name;
+
+	/*
+	 * Do not dereference fence->sched here: a userspace-held finished
+	 * fence can outlive a per-context scheduler. Return the name cached
+	 * in drm_sched_fence_init() instead.
+	 */
+	return fence->sched_name;
 }
 
 static void drm_sched_fence_free_rcu(struct rcu_head *rcu)
@@ -228,6 +234,14 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
 	unsigned seq;
 
 	fence->sched = entity->rq->sched;
+	/*
+	 * Cache the scheduler's timeline name. The finished fence may be
+	 * exported to userspace and outlive @sched (per-context schedulers are
+	 * freed on context teardown), so get_timeline_name() must not
+	 * dereference @sched. The name is required to outlive any exported
+	 * fence (see @name in struct drm_sched_init_args).
+	 */
+	fence->sched_name = fence->sched->name;
 	seq = atomic_inc_return(&entity->fence_seq);
 	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
 		       &fence->lock, entity->fence_context, seq);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 7a64cc11de08..412b8c4643f1 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -322,6 +322,17 @@ struct drm_sched_fence {
          * belongs to.
          */
 	struct drm_gpu_scheduler	*sched;
+	/**
+	 * @sched_name: the timeline name of @sched, cached at init time.
+	 *
+	 * &drm_sched_fence.finished may be exported to userspace (via a
+	 * sync_file or drm_syncobj) and can outlive @sched: a driver using a
+	 * per-context scheduler frees it on context teardown while a
+	 * userspace-held finished fence still references it. The
+	 * get_timeline_name() callback must therefore not dereference @sched;
+	 * it returns this cached name instead.
+	 */
+	const char			*sched_name;
         /**
          * @lock: the lock used by the scheduled and the finished fences.
          */
@@ -646,7 +657,12 @@ struct drm_gpu_scheduler {
  * @timeout: timeout value in jiffies for submitted jobs.
  * @timeout_wq: workqueue to use for timeout work. If NULL, the system_wq is used.
  * @score: score atomic shared with other schedulers. May be NULL.
- * @name: name (typically the driver's name). Used for debugging
+ * @name: name (typically the driver's name). Used for debugging, and as the
+ *	dma-fence timeline name of the scheduler's fences. It must follow the
+ *	dma-fence safe access rules: a &drm_sched_fence.finished exported to
+ *	userspace can outlive the scheduler, so @name has to outlive any such
+ *	fence - use a string literal, or free it only after an RCU grace period
+ *	past the last exported fence. See drm_sched_fence_get_timeline_name().
  * @dev: associated device. Used for debugging
  */
 struct drm_sched_init_args {
-- 
2.43.0

