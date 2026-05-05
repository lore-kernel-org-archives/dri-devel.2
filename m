Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2DCFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 11:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB08310EA4B;
	Tue,  5 May 2026 11:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m+sQf/lj";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F0B610EA4B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 11:08:31 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so9880665e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777979310; x=1778584110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OJh5/rreI+TnE1Afk0gjFXfS1bRtahc/HBf9EXQyMQA=;
 b=m+sQf/ljUn3Tw2rRiEN3sgiH3QkPQSmTnyPUSxkBQD3ReLEepfHk7NXTw316eprKFE
 oaEINFC/pw34XLXsGxCaf+3Meom2MRIMwkT7i/mDqc2T2SfP5aYbnPC6YFNmSwKKCilm
 KqfZ+BYJAyCEJanVFEB6bxXs+Goo6mlp1CKZMZZvIjNXLgEwhCCACQBm/e+uoYP0f18g
 x6qfnYJGQEfortYfLRHty4DPwwqffm+Q8jKanvB6Cl5haBFssIr9Qu3G67DDoZwVHCzl
 Qhk0OLN0MvxkPs0ZnCgsVibLiPOKPQ9AyDaCXQhCcpqMoa+QHd7oeJFuDlF2O9UAJzQJ
 n4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777979310; x=1778584110;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJh5/rreI+TnE1Afk0gjFXfS1bRtahc/HBf9EXQyMQA=;
 b=G3lZnQkwp+mdQInyUnfZgKs8dU2Ekgx2nBABnv7+eboa3cPBUvfZYzjxSm2k0qfpbr
 Ea/ngExJubMW1aHzSqQtK8LwwQ/DWv5aOUGedy9T5VfloyfMwxZ6Zteu0auFQQOD+cX2
 9wdn1il6gaBG/2lkYPwombUv56w8LA9VTw01vHacekBkHjIlLWrqbzBnDRt+qKsZuwsL
 /DQ4II6cstg03lv6cQ1JQf7be9IaX+YPm8cLUIEQ7Y9IDvuEqcdX4w53mFc3RlmqWMOC
 Kx3jwTojUmlLkIKq1PVVMG6We8HbRyvJIEsExK/Qw6mArv6jFw/097OIaZ32Y9GfZQrR
 KCxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uSXSXI1ct63dMdHc5JoNdSeQNa2AgaJbykdr776WdHXOGYZ90tnBRxhDzpUq7Cw4EWIFOHWKnVxc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQM3Xt09ATYyIdIhc04++ZCXuPUKw97VtkgWZxpu0NkXGsCrpi
 IKWsN0QZxTWU8lD2hXI3rxr3qfl8cFTs6B27nb/cb9eREFJs3hHRxjXZ
X-Gm-Gg: AeBDieuvQHs83db6iEqhj8LLc6GCIT9ztbKH3gGYY2npMN8vu8VLlusch6hs8Td3XRe
 Jks6J9MKoVomkkJbwwvcQgXan+bsQhpx4fS2sCk/O1jriATaoBiKnWToyreFp/6V49lIGvMk0n6
 CgzN/TP13zgyNMekJo5i70aKihrj4wRueQ0M/1owStTGIR9cimWuKt6/Q97pN9gPqbIMn6NNOfA
 Xir2OLRuTOhqQ7n/8nNFIfsVCVjdD6GF11oRUaS1NNXznK/yF9BsFUbfF3qKzAAA2l5doaAWmBP
 MHf3GnA4lpLtSegu4xjluE5ZWfQNjvUQZTBeN0UyP9uAX2Ht4ef0YacUS5bK+ACeeuUUOXuKoK8
 ENWDmYDVmG5Gb1dCykY8aKnbEcYcQzlplPEdrfct4INNner+jJM2yWBkcSyX0KPnCQkPmgJ+fkH
 TMo/6IeS8SBhgUkL4t85jprIL8q65B+BLxmF2yvNbhkfH0do8=
X-Received: by 2002:a05:600c:8b58:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-48d18be5b32mr41261905e9.14.1777979309457; 
 Tue, 05 May 2026 04:08:29 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1504:6f00:1b6a:5e22:9c81:d5ca])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f7csm399765765e9.12.2026.05.05.04.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 04:08:28 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, sumit.semwal@linaro.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH] dma-buf/dma_fence_array: optimize handling v2
Date: Tue,  5 May 2026 13:08:27 +0200
Message-ID: <20260505110828.1574-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Removing the signal on any feature allows to simplfy the dma_fence_array
code a lot and saves us from the need to install a callback on all fences
at the same time.

This results is less memory and CPU overhead.

v2: fix potential double locking pointed out by Tvrtko

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence-array.c | 134 +++++++++++++-----------------
 drivers/gpu/drm/xe/xe_vm.c        |   2 +-
 include/linux/dma-fence-array.h   |  22 ++---
 3 files changed, 66 insertions(+), 92 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
index 5e10e8df372f..8b94c6287482 100644
--- a/drivers/dma-buf/dma-fence-array.c
+++ b/drivers/dma-buf/dma-fence-array.c
@@ -42,97 +42,88 @@ static void dma_fence_array_clear_pending_error(struct dma_fence_array *array)
 	cmpxchg(&array->base.error, PENDING_ERROR, 0);
 }
 
-static void irq_dma_fence_array_work(struct irq_work *wrk)
+static void dma_fence_array_cb_func(struct dma_fence *f,
+				    struct dma_fence_cb *cb)
 {
-	struct dma_fence_array *array = container_of(wrk, typeof(*array), work);
-
-	dma_fence_array_clear_pending_error(array);
+	struct dma_fence_array *array =
+		container_of(cb, struct dma_fence_array, callback);
 
-	dma_fence_signal(&array->base);
-	dma_fence_put(&array->base);
+	irq_work_queue(&array->work);
 }
 
-static void dma_fence_array_cb_func(struct dma_fence *f,
-				    struct dma_fence_cb *cb)
+static bool dma_fence_array_try_add_cb(struct dma_fence_array *array)
 {
-	struct dma_fence_array_cb *array_cb =
-		container_of(cb, struct dma_fence_array_cb, cb);
-	struct dma_fence_array *array = array_cb->array;
+	while (array->num_pending) {
+		struct dma_fence *f = array->fences[array->num_pending - 1];
 
-	dma_fence_array_set_pending_error(array, f->error);
+		if (!dma_fence_add_callback(f, &array->callback,
+					    dma_fence_array_cb_func))
+			return true;
 
-	if (atomic_dec_and_test(&array->num_pending))
-		irq_work_queue(&array->work);
-	else
+		dma_fence_array_set_pending_error(array, f->error);
+		--array->num_pending;
+	}
+	return false;
+}
+
+static void dma_fence_array_irq_work(struct irq_work *wrk)
+{
+	struct dma_fence_array *array = container_of(wrk, typeof(*array), work);
+
+	--array->num_pending;
+	if (!dma_fence_array_try_add_cb(array)) {
+		dma_fence_signal(&array->base);
 		dma_fence_put(&array->base);
+	}
 }
 
 static bool dma_fence_array_enable_signaling(struct dma_fence *fence)
 {
 	struct dma_fence_array *array = to_dma_fence_array(fence);
-	struct dma_fence_array_cb *cb = array->callbacks;
-	unsigned i;
 
-	for (i = 0; i < array->num_fences; ++i) {
-		cb[i].array = array;
+	/*
+	 * As we may report that the fence is signaled before all
+	 * callbacks are complete, we need to take an additional
+	 * reference count on the array so that we do not free it too
+	 * early. The core fence handling will only hold the reference
+	 * until we signal the array as complete (but that is now
+	 * insufficient).
+	 */
+	dma_fence_get(&array->base);
+	if (!dma_fence_array_try_add_cb(array)) {
 		/*
-		 * As we may report that the fence is signaled before all
-		 * callbacks are complete, we need to take an additional
-		 * reference count on the array so that we do not free it too
-		 * early. The core fence handling will only hold the reference
-		 * until we signal the array as complete (but that is now
-		 * insufficient).
+		 * When all fences are already signaled we can drop the reference again
+		 * and report to the caller that the array can be signaled as well.
 		 */
-		dma_fence_get(&array->base);
-		if (dma_fence_add_callback(array->fences[i], &cb[i].cb,
-					   dma_fence_array_cb_func)) {
-			int error = array->fences[i]->error;
-
-			dma_fence_array_set_pending_error(array, error);
-			dma_fence_put(&array->base);
-			if (atomic_dec_and_test(&array->num_pending)) {
-				dma_fence_array_clear_pending_error(array);
-				return false;
-			}
-		}
+		dma_fence_put(&array->base);
+		return false;
 	}
-
 	return true;
 }
 
 static bool dma_fence_array_signaled(struct dma_fence *fence)
 {
 	struct dma_fence_array *array = to_dma_fence_array(fence);
-	int num_pending;
+	int num_pending, error = 0;
 	unsigned int i;
 
 	/*
-	 * We need to read num_pending before checking the enable_signal bit
-	 * to avoid racing with the enable_signaling() implementation, which
-	 * might decrement the counter, and cause a partial check.
-	 * atomic_read_acquire() pairs with atomic_dec_and_test() in
-	 * dma_fence_array_enable_signaling()
-	 *
-	 * The !--num_pending check is here to account for the any_signaled case
-	 * if we race with enable_signaling(), that means the !num_pending check
-	 * in the is_signalling_enabled branch might be outdated (num_pending
-	 * might have been decremented), but that's fine. The user will get the
-	 * right value when testing again later.
+	 * Reading num_pending without a memory barrier here is correct since
+	 * that is only for optimization, it is perfectly acceptable to have a
+	 * stale value for it. In all other cases num_pending is accessed by a
+	 * single call chain.
 	 */
-	num_pending = atomic_read_acquire(&array->num_pending);
-	if (test_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT, &array->base.flags)) {
-		if (num_pending <= 0)
-			goto signal;
-		return false;
-	}
+	num_pending = READ_ONCE(array->num_pending);
+	for (i = 0; i < num_pending; ++i) {
+		struct dma_fence *f = array->fences[i];
 
-	for (i = 0; i < array->num_fences; ++i) {
-		if (dma_fence_is_signaled(array->fences[i]) && !--num_pending)
-			goto signal;
-	}
-	return false;
+		if (!dma_fence_is_signaled(f))
+			return false;
 
-signal:
+		if (!error)
+			error = f->error;
+	}
+	dma_fence_array_set_pending_error(array, error);
 	dma_fence_array_clear_pending_error(array);
 	return true;
 }
@@ -171,15 +162,12 @@ EXPORT_SYMBOL(dma_fence_array_ops);
 
 /**
  * dma_fence_array_alloc - Allocate a custom fence array
- * @num_fences:		[in]	number of fences to add in the array
  *
  * Return dma fence array on success, NULL on failure
  */
-struct dma_fence_array *dma_fence_array_alloc(int num_fences)
+struct dma_fence_array *dma_fence_array_alloc(void)
 {
-	struct dma_fence_array *array;
-
-	return kzalloc_flex(*array, callbacks, num_fences);
+	return kzalloc_obj(struct dma_fence_array);
 }
 EXPORT_SYMBOL(dma_fence_array_alloc);
 
@@ -203,10 +191,13 @@ void dma_fence_array_init(struct dma_fence_array *array,
 	WARN_ON(!num_fences || !fences);
 
 	array->num_fences = num_fences;
+	array->num_pending = num_fences;
+	array->fences = fences;
+	array->base.error = PENDING_ERROR;
 
 	dma_fence_init(&array->base, &dma_fence_array_ops, NULL, context,
 		       seqno);
-	init_irq_work(&array->work, irq_dma_fence_array_work);
+	init_irq_work(&array->work, dma_fence_array_irq_work);
 
 	/*
 	 * dma_fence_array_enable_signaling() is invoked while holding
@@ -220,11 +211,6 @@ void dma_fence_array_init(struct dma_fence_array *array,
 	 */
 	lockdep_set_class(&array->base.inline_lock, &dma_fence_array_lock_key);
 
-	atomic_set(&array->num_pending, num_fences);
-	array->fences = fences;
-
-	array->base.error = PENDING_ERROR;
-
 	/*
 	 * dma_fence_array objects should never contain any other fence
 	 * containers or otherwise we run into recursion and potential kernel
@@ -265,7 +251,7 @@ struct dma_fence_array *dma_fence_array_create(int num_fences,
 {
 	struct dma_fence_array *array;
 
-	array = dma_fence_array_alloc(num_fences);
+	array = dma_fence_array_alloc();
 	if (!array)
 		return NULL;
 
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 62a87a051be7..8f472911469d 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3370,7 +3370,7 @@ static struct dma_fence *ops_execute(struct xe_vm *vm,
 		goto err_trace;
 	}
 
-	cf = dma_fence_array_alloc(n_fence);
+	cf = dma_fence_array_alloc();
 	if (!cf) {
 		fence = ERR_PTR(-ENOMEM);
 		goto err_out;
diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
index 1b1d87579c38..3ee55c0e2fa4 100644
--- a/include/linux/dma-fence-array.h
+++ b/include/linux/dma-fence-array.h
@@ -15,16 +15,6 @@
 #include <linux/dma-fence.h>
 #include <linux/irq_work.h>
 
-/**
- * struct dma_fence_array_cb - callback helper for fence array
- * @cb: fence callback structure for signaling
- * @array: reference to the parent fence array object
- */
-struct dma_fence_array_cb {
-	struct dma_fence_cb cb;
-	struct dma_fence_array *array;
-};
-
 /**
  * struct dma_fence_array - fence to represent an array of fences
  * @base: fence base class
@@ -33,18 +23,17 @@ struct dma_fence_array_cb {
  * @num_pending: fences in the array still pending
  * @fences: array of the fences
  * @work: internal irq_work function
- * @callbacks: array of callback helpers
+ * @callback: callback structure for signaling
  */
 struct dma_fence_array {
 	struct dma_fence base;
 
-	unsigned num_fences;
-	atomic_t num_pending;
+	unsigned int num_fences;
+	unsigned int num_pending;
 	struct dma_fence **fences;
 
 	struct irq_work work;
-
-	struct dma_fence_array_cb callbacks[] __counted_by(num_fences);
+	struct dma_fence_cb callback;
 };
 
 /**
@@ -78,11 +67,10 @@ to_dma_fence_array(struct dma_fence *fence)
 	for (index = 0, fence = dma_fence_array_first(head); fence;	\
 	     ++(index), fence = dma_fence_array_next(head, index))
 
-struct dma_fence_array *dma_fence_array_alloc(int num_fences);
+struct dma_fence_array *dma_fence_array_alloc(void);
 void dma_fence_array_init(struct dma_fence_array *array,
 			  int num_fences, struct dma_fence **fences,
 			  u64 context, unsigned seqno);
-
 struct dma_fence_array *dma_fence_array_create(int num_fences,
 					       struct dma_fence **fences,
 					       u64 context, unsigned seqno);
-- 
2.43.0

