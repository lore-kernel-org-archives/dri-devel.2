Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F7606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tXyu99QL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE45D10FE9F;
	Thu, 19 Nov 2026 07:54:16 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3536710FE9F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:54:11 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8c6c06b3321so994332b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795074851; x=1795679651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ru+zngfgoDECA/tIfj0+4KukrDwr8BnCsZQt6lEWRQc=;
 b=tXyu99QLeaKs9G7Qz6Fs0ULAUJKSqaEeK8wJca9jzaLFSIYbpJaxK3cELzhjCFTHKt
 xkwv3F15SGGimK/KP6EL0L+E/HkyZMZf+f/ZBxfYG05xHELk+qRASNhxInu3IVvZhv8a
 mbVhsXsL1oderBRDEXTcwNdGlimVHjWLgZCaj+DWNbhyij91PMI4w6joqx0Q7rmnjl/p
 GCZyXcOpbyLVusJm1rAtZSj+c6JGcdK2tshU5GHBcglg9B+/moo2pqY7/sNaal6rlm11
 XA6BgAMGEvqq/oEDqNa/fWUuLhqoeOREX3K/fHM5ZBJdOJ6clA2pQiQ8uMYuUOYPtH9I
 Yy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795074851; x=1795679651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ru+zngfgoDECA/tIfj0+4KukrDwr8BnCsZQt6lEWRQc=;
 b=Q5dwgLLWjFi+XBGN0tF7d8JSPk8D/tQOyPj9Smieq8J8MbzLZCyR5XCHzKObo5hu6Z
 ImQmx9YSWhjY4slmdfsGV9G1nUTTFnUEaTudTqzfrmEk7s/e4HrgR3vCiV++CZxgTgM9
 tLt8FR+cv6E8bN8LtEsRPfb8RlP2mXV817zjRGG9OAuPEZ2N0IWFV7VWzC+OnT7EvjEp
 c+vbY2RMuOu/9DaqQ7+9KUxT5FgqiPgtbrWGswz2vYmmAPncwIouAr+3q5Fhc+FU7TAm
 7YEu7vkGbAUKe9xuZ+7vG11k3Vc+r2JLiQPVG3gpKRVUbu9GEbcdeOUhKvM1a8d+cn1Z
 5CAw==
X-Gm-Message-State: APuU4Z+psTC7T+yNdSxVgDyVwcmeMn/YH1t17Ir1m/PH4vH4S0+8OyIr
 WflHTN3m4UDq9v8LT2MqJ0n6XE+5MdJb2dWvpvd9sfT7IDRKK8EhvTxAiP+HO7Rjaj7Adw==
X-Gm-Gg: AYBFou0goOpjWMlBfc3mVHclvCFveteCs38E6zThN7oYvv6X1Xgxlmx4sWxBDCzfT1b
 0kN34qS26nu+kF7kJnhRZjbENMmr1TEOK6TbAyeG4pK34LE5JG/rzxPgpTtD26St3ufQVbvwRAp
 NjfQg39XRft/bLef3lWD74TdeBxW97B92ztykhyscSqBJBZRfyUNJsXFzlu88WLEU5z6KGvEd1L
 FLAwoRt5WESxeqeGHQKmVExT/ApcgX2lJisQxMQwj2tvOkqrkIvuu9pv3FqxqKXF603kHWUkgqZ
 lJtJKWjnaz2vB8qaB5SSr2DSMxuZwLOVfTfIHwFMzZ7HgKtglTqZzliNoGKHeZqCiSyqrl+5nn/
 fTqn6ugIrElx2Ykt+ZXkANIv7hnpMcKkljj06JvJ3qMlow1zK7TRzQ6hZJLWADZ1AohYtrMzdyl
 cWPmD4gZisVOd3bl2yS+KA84S0lIGsWD5Buhgbnup98PEAF65mIiXSV+xLhRgJlVQCiiJMelJou
 Y+p8DdGsv55nSWt+75ARXxJapFhKCRDgDZZGNzDGwt9qjzOEDTrjQfwLu/E/uScSVIhwPbTbD6L
 rPbhiYt137pJMcpKtNX8Y85bcKNMnE7o3QO7VDyShUSf2NSKTuibVAFSgswLcakxOyHZhLu7LOe
 p1OKHdudIzRNgz8CA3ILKaKI30UG28pGwsmU3EWdI0qHGPw==
X-Received: by 2002:a05:6a00:4390:b0:886:31d3:51a2 with SMTP id
 d2e1a72fcca58-8c5d47e2215mr5130363b3a.39.1795074850480; 
 Wed, 18 Nov 2026 23:54:10 -0800 (PST)
Received: from lwq-server.tail118c18.ts.net ([74.176.208.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5ca7aa75esm2373707b3a.15.2026.11.18.23.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 23:54:10 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: dri-devel@lists.freedesktop.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] drm/exynos: publish the IPP task completion after the
 last task access
Date: Thu, 19 Nov 2026 15:54:02 +0800
Message-Id: <20261119075402.3397371-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119023550.1495565-1-shunsheng1218@gmail.com>
References: <20261119023550.1495565-1-shunsheng1218@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

exynos_drm_ipp_task_done() sets DRM_EXYNOS_IPP_TASK_DONE before it
writes task->ret and reads DRM_EXYNOS_IPP_TASK_ASYNC.  A commit ioctl
that waits for the task evaluates the DONE flag in
wait_event_interruptible() without taking ipp->lock, and
exynos_drm_ipp_task_cleanup() frees the task as soon as it observes it,
so the completion path can still be writing and reading a task that the
waiter has already released.

Settle task->ret and the asynchronous ownership first, and publish DONE
last with release semantics; read the flag with acquire semantics in the
waiter.  The flag is the publication point: a waiter that observes it on
another CPU also observes everything written before it.

The completion path does not touch the task after the flag is visible
any more, except for the hand-over to the cleanup work, which only runs
for tasks no synchronous caller can release: DRM_EXYNOS_IPP_TASK_ASYNC
was sampled before the publication and is set either for a non-blocking
commit, whose ioctl does not wait, or by exynos_drm_ipp_task_abort()
under ipp->lock.

The previous comment claimed that queueing the cleanup work before the
wakeup is what makes the wakeup safe.  That is not the ordering that
matters: wait_event_interruptible() evaluates its condition without this
wakeup as well, for instance when another task on the shared ipp->done_wq
wakes the waiter, so what orders the two sides is the publication of
DONE.

Fixes: 9913f74fe157 ("drm/exynos: ipp: Add IPP v2 framework")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Changes in v2:
  - Publish DRM_EXYNOS_IPP_TASK_DONE last, after task->ret is written and
    after DRM_EXYNOS_IPP_TASK_ASYNC has been sampled, and do it with
    smp_store_release(); the waiter reads the flag with smp_load_acquire().
    A synchronous waiter evaluates the condition without ipp->lock, so
    moving the wakeup alone does not order the two sides.  Reported by
    Sashiko.
  - Rewrite the comment and the commit message: what orders the waiters is
    the publication of DONE, not the wake_up() call.
  - Add the Fixes: tag for the IPP v2 framework.
  - Exercise the publication order and the signal-abort path with a
    controlled test; the outcome is in the note below.
Prepared against v7.4-rc1-1969-g666539eecdf4.

Compile tested: arm64 with aarch64-linux-gnu-gcc 11.4 and
CONFIG_DRM_EXYNOS=m with the IPP drivers.

The publication order and its interaction with the abort path were
exercised by a controlled test on a KASAN kernel built from this tree
(x86_64, QEMU/KVM; 12 checks, all passing).  The test transcribes
exynos_drm_ipp_task_done() before and after the change and the wait/abort
part of the commit ioctl, and runs them on the real workqueue, wait and
signal machinery:

 - pre-patch order: the woken waiter releases the task and the completion
   path then reads task->flags - a KASAN slab-use-after-free;
 - patched order, same window: the completion path does not touch the task
   after the wakeup, and the waiter reads the result it stored;
 - a wait interrupted by a signal (-ERESTARTSYS) enters the abort path, the
   task is handed to the cleanup work and released exactly once;
 - a signal that arrives after the completion does not turn the wait into
   an abort: the waiter takes the success path and releases the task
   inline, exactly once.

The test does not compile the driver itself, which would need the whole DRM
device, so no Exynos hardware and no DRM teardown path was exercised, and
the store-store half of the ordering can only be observed on a weakly
ordered architecture.

AI assistance: the analysis, the change and its review notes were
prepared with Claude (Anthropic) as a coding assistant.  The author
reviewed the reasoning and takes responsibility for the content.
---
 drivers/gpu/drm/exynos/exynos_drm_ipp.c | 30 +++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index 43bc4f63bb84..20d3c10872d8 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -764,6 +764,7 @@ void exynos_drm_ipp_task_done(struct exynos_drm_ipp_task *task, int ret)
 {
 	struct exynos_drm_ipp *ipp = task->ipp;
 	unsigned long flags;
+	bool async;
 
 	DRM_DEV_DEBUG_DRIVER(task->dev, "ipp: %d, task %p done: %d\n",
 			     ipp->id, task, ret);
@@ -771,17 +772,36 @@ void exynos_drm_ipp_task_done(struct exynos_drm_ipp_task *task, int ret)
 	spin_lock_irqsave(&ipp->lock, flags);
 	if (ipp->task == task)
 		ipp->task = NULL;
-	task->flags |= DRM_EXYNOS_IPP_TASK_DONE;
+
+	/*
+	 * A synchronous waiter evaluates DRM_EXYNOS_IPP_TASK_DONE without
+	 * taking @ipp->lock and frees the task as soon as it observes the
+	 * flag, so @ret and the decision whether the cleanup work takes the
+	 * task over have to be settled before it becomes visible.
+	 */
 	task->ret = ret;
+	async = task->flags & DRM_EXYNOS_IPP_TASK_ASYNC;
+
+	/* Publish the completion last; the waiter pairs with an acquire. */
+	smp_store_release(&task->flags,
+			  task->flags | DRM_EXYNOS_IPP_TASK_DONE);
 	spin_unlock_irqrestore(&ipp->lock, flags);
 
 	exynos_drm_ipp_next_task(ipp);
-	wake_up(&ipp->done_wq);
 
-	if (task->flags & DRM_EXYNOS_IPP_TASK_ASYNC) {
+	/*
+	 * The task is not touched after the flag became visible, except for
+	 * this hand-over, which only runs for tasks no synchronous caller can
+	 * release: @async was sampled before the publication, and it is set
+	 * either for a non-blocking commit, whose ioctl does not wait, or by
+	 * exynos_drm_ipp_task_abort() under @ipp->lock.
+	 */
+	if (async) {
 		INIT_WORK(&task->cleanup_work, exynos_drm_ipp_cleanup_work);
 		schedule_work(&task->cleanup_work);
 	}
+
+	wake_up(&ipp->done_wq);
 }
 
 static void exynos_drm_ipp_next_task(struct exynos_drm_ipp *ipp)
@@ -929,7 +949,9 @@ int exynos_drm_ipp_commit_ioctl(struct drm_device *dev, void *data,
 				     ipp->id, task);
 		exynos_drm_ipp_schedule_task(ipp, task);
 		ret = wait_event_interruptible(ipp->done_wq,
-					task->flags & DRM_EXYNOS_IPP_TASK_DONE);
+					/* pairs with the release above */
+					smp_load_acquire(&task->flags) &
+					DRM_EXYNOS_IPP_TASK_DONE);
 		if (ret)
 			exynos_drm_ipp_task_abort(ipp, task);
 		else
-- 
2.34.1

