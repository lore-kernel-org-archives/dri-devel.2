Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1586F9B605
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB8310E9AA;
	Wed, 22 Apr 2026 10:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sClig9lR";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6B810E9AA
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 10:30:16 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43d73422431so4502193f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776853814; x=1777458614; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63KYhScVtjppyoQjYNb86QEpZuNNlTEDQMEwY5JRcz0=;
 b=sClig9lR6ch4aKS+AGJykwM+h27ng9XM1JHR4lvVbmUXgEMmG2QNdOWi/gWxaB0lPm
 1evPCP0oK5a7w9UZxnga8vV01hF1NfXMgNxspls9CLllhzZreKwYhCV7RwvxyUe1p91W
 T89S5vrpWUCtSPGFhXoIpl7CTaRLIjdL+DYG5gJ8nVcp3cj6i5eGYxDhn+NZamB1fwhc
 mbuLcs3p9oyq0wRxE8smR6swekBcZehzjgAzH0fcU+/RNhlI/1Mj+cFIXMI8ReWuvzKZ
 JmaGPYhavPTtVHH0pwvxd8aaw3yNVIbn6uYftJZVfGw7glBvzaAQ99eEnzGfnO0X0meS
 isXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853814; x=1777458614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=63KYhScVtjppyoQjYNb86QEpZuNNlTEDQMEwY5JRcz0=;
 b=R2LPlpHrTpIxk6PeJaeAZ1z+9QTax41zjopVBmA+JO98d9dQTefVGfXW9Mw6CBvNPm
 hSnaojOs9qG+awLuCgqAIOaBm+2GOSNYcbScnLwnqcsSYdoAYUj7VvUbtWfvY+oZYO/6
 xfXcoGucwPVmghK2sT/p+hU5WRQ6NEXDw8aiKUuViFHlnUMKwc5NH0v2rSDcffjAg64z
 SB8afrLGcpNli/CHXDkWNj1/demU2sglSYDrxprRQGNh6+4E3eNGISOMiOuL9dT7m1Yx
 dzZmcMeNBhsHeTqMklpKKCiXo+S1bHYvzBzz/kp6L76Ass4Yq9v9gntSie1mZHrioW3L
 yPpw==
X-Gm-Message-State: AOJu0Yy7ZRejUOyjq6Sh/Rss9ZkZcA7m4R397ad9WLfKTC5KY+kBr9ZX
 XKeIPYPKKujbV27UaJadzSU3f9FIuXH9JlA5+jivWwUIS7TpbeghVqem
X-Gm-Gg: AeBDiet3VUoD0XLTE657fLUEtdFImT6DW1UVfDdXdW8vOBYJmmJSEpzM75asH1x69ns
 MLwUYFF6dTiAyvznsc08a1GSfbo9PHzqUVR56KNtrdEFqdEaMiBgVdxdHnsXPpd6p5lfJjROaax
 gxCVCIUbCL58Xg2z9pdUSEpZjt7ZjtBNpuP2tFi3PiQUcIaywxmFQ7zEy0Qc5I/It00sLSjIv4r
 lAn1qkbFr4L6oZT+D0rkIYPN3Ky14BbJi/m5epDcRPADr3lh/W2nJH/IkZ7hAXtaVIVhck3WkdT
 UUfXZROG9G0tVkRMLEFaYn0NebP9xBLraTcrzTPK9zLY2cH3/77j/yj2ZVjignZnhHoCMQy/un5
 jsqwelgxBIoyyX/6UnQjcy94gm+/jfXSZ0hEBKiGYyRbGp8O0PVfWdCq31mHQWasZRHhyoyu8nH
 Mu2bxy1jWdAXFC01m8PIL4nkiG+PwH5SqsZorM7ikeJjsKpw==
X-Received: by 2002:a05:6000:2502:b0:43d:3113:6eed with SMTP id
 ffacd0b85a97d-43fe3dc84f4mr33871124f8f.4.1776853814292; 
 Wed, 22 Apr 2026 03:30:14 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15c7:5100:eecf:fda8:2b8:432b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4daf2sm43439037f8f.33.2026.04.22.03.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:30:13 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net,
	sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH 2/2] dma-buf/dma_fence_array: optimize handling
Date: Wed, 22 Apr 2026 12:30:11 +0200
Message-ID: <20260422103012.1647-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422103012.1647-1-christian.koenig@amd.com>
References: <20260422103012.1647-1-christian.koenig@amd.com>
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

Removing the signal on any feature allows to simplfy the dma_fence_array
code a lot and saves us from the need to install a callback on all fences
at the same time.

This results in less memory and CPU overhead.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence-array.c | 130 +++++++++++++-----------------
 include/linux/dma-fence-array.h   |  22 ++---
 2 files changed, 59 insertions(+), 93 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
index 5e10e8df372f..f1b4b3296c87 100644
--- a/drivers/dma-buf/dma-fence-array.c
+++ b/drivers/dma-buf/dma-fence-array.c
@@ -42,97 +42,80 @@ static void dma_fence_array_clear_pending_error(struct dma_fence_array *array)
 	cmpxchg(&array->base.error, PENDING_ERROR, 0);
 }
 
-static void irq_dma_fence_array_work(struct irq_work *wrk)
+static void dma_fence_array_cb_func(struct dma_fence *f,
+				    struct dma_fence_cb *cb)
 {
-	struct dma_fence_array *array = container_of(wrk, typeof(*array), work);
+	struct dma_fence_array *array =
+		container_of(cb, struct dma_fence_array, callback);
 
-	dma_fence_array_clear_pending_error(array);
+	irq_work_queue(&array->work);
+}
+
+static void dma_fence_array_arm_cb(struct dma_fence_array *array)
+{
+	while (array->num_pending) {
+		struct dma_fence *f = array->fences[array->num_pending - 1];
+
+		if (!dma_fence_add_callback(f, &array->callback,
+					    dma_fence_array_cb_func))
+			return;
+
+		dma_fence_array_set_pending_error(array, f->error);
+		WRITE_ONCE(array->num_pending, array->num_pending - 1);
+	}
 
 	dma_fence_signal(&array->base);
 	dma_fence_put(&array->base);
 }
 
-static void dma_fence_array_cb_func(struct dma_fence *f,
-				    struct dma_fence_cb *cb)
+static void dma_fence_array_irq_work(struct irq_work *wrk)
 {
-	struct dma_fence_array_cb *array_cb =
-		container_of(cb, struct dma_fence_array_cb, cb);
-	struct dma_fence_array *array = array_cb->array;
-
-	dma_fence_array_set_pending_error(array, f->error);
+	struct dma_fence_array *array = container_of(wrk, typeof(*array), work);
 
-	if (atomic_dec_and_test(&array->num_pending))
-		irq_work_queue(&array->work);
-	else
-		dma_fence_put(&array->base);
+	WRITE_ONCE(array->num_pending, array->num_pending - 1);
+	dma_fence_array_arm_cb(array);
 }
 
 static bool dma_fence_array_enable_signaling(struct dma_fence *fence)
 {
 	struct dma_fence_array *array = to_dma_fence_array(fence);
-	struct dma_fence_array_cb *cb = array->callbacks;
-	unsigned i;
-
-	for (i = 0; i < array->num_fences; ++i) {
-		cb[i].array = array;
-		/*
-		 * As we may report that the fence is signaled before all
-		 * callbacks are complete, we need to take an additional
-		 * reference count on the array so that we do not free it too
-		 * early. The core fence handling will only hold the reference
-		 * until we signal the array as complete (but that is now
-		 * insufficient).
-		 */
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
-	}
 
+	/*
+	 * As we may report that the fence is signaled before all
+	 * callbacks are complete, we need to take an additional
+	 * reference count on the array so that we do not free it too
+	 * early. The core fence handling will only hold the reference
+	 * until we signal the array as complete (but that is now
+	 * insufficient).
+	 */
+	dma_fence_get(&array->base);
+	dma_fence_array_arm_cb(array);
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
@@ -171,15 +154,12 @@ EXPORT_SYMBOL(dma_fence_array_ops);
 
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
 
@@ -203,10 +183,13 @@ void dma_fence_array_init(struct dma_fence_array *array,
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
@@ -220,11 +203,6 @@ void dma_fence_array_init(struct dma_fence_array *array,
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
@@ -265,7 +243,7 @@ struct dma_fence_array *dma_fence_array_create(int num_fences,
 {
 	struct dma_fence_array *array;
 
-	array = dma_fence_array_alloc(num_fences);
+	array = dma_fence_array_alloc();
 	if (!array)
 		return NULL;
 
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

