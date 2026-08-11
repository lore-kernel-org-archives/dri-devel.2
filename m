Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AE8C5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 11:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3355910EB4C;
	Tue, 11 Aug 2026 11:23:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="f16Sy9we";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B12BE10E2F9
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 11:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786447419;
 bh=AwbS6+2vfVG/4d48RPtiD/bosa/LCN6GhZ3XG0FQWK8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=f16Sy9we1GYG9tvxhUDo4CdclwkXFSmDPnUeNXomZ/AhX81fXaChEm1egHBk+olOR
 Ya2+o20aYUqEaN6BrEbVrHhA15Y29E9t6/arF9QoP96qzjwZbehzN/Ou4kMkANGTDA
 VXCRKBj9VdKnJK6PSZwBG3qOdmVsGteMTq075KNQ2Oe13OYJUFD64P4BLr10TyY00j
 dFQmm/1kYV3G8UwIx9BBwwdkdMqN1OGDhANMYKf8dizrltm1s0vFz+8WBGf8nKKWbU
 CB1T8D4N5xGJ8L6j2jijJ9f1Xa0H6kdsuQ972KETMJ5f8ISFmSpKm7CfLC67IjDJMw
 8dI3eUGFuCOKA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D30A217E0B39;
 Tue, 11 Aug 2026 13:23:38 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 13:23:35 +0200
Subject: [PATCH v6 1/9] drm/panthor: Make panthor_irq::state a non-atomic field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-signal-from-irq-v6-1-12f2ab53d735@collabora.com>
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
In-Reply-To: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786447418; l=7250;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=AwbS6+2vfVG/4d48RPtiD/bosa/LCN6GhZ3XG0FQWK8=;
 b=t+G6DV+B8HF/Zfa4ExIs52SACp5axmNt5WeWiW/w2N4CDbpnzdsx+XY1n12uWrApalytuiURC
 aNCl52/2H53DvQkRchXd5KyTlIr7wuyTPNHBWJw1NMY9gjxz3hCZm6e
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

The only place where panthor_irq::state is accessed without
panthor_irq::mask_lock held is in the prologue of _irq_suspend(),
which is not really a fast-path. So let's simplify things by assuming
panthor_irq::state must always be accessed with the mask_lock held,
and add a scoped_guard() in _irq_suspend().

While at it, rename the lock so it's clear it doesn't just protect
access to the panthor_irq::mask or the INT_MASK register.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h | 61 +++++++++++++++-----------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 0fda64fbe5f2..4e5f7b0fb53f 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -92,17 +92,21 @@ struct panthor_irq {
 	u32 mask;
 
 	/**
-	 * @mask_lock: protects modifications to _INT_MASK and @mask.
+	 * @lock: protects modifications to _INT_MASK, @mask and @state.
 	 *
 	 * In paths where _INT_MASK is updated based on a state
 	 * transition/check, it's crucial for the state update/check to be
 	 * inside the locked section, otherwise it introduces a race window
 	 * leading to potential _INT_MASK inconsistencies.
 	 */
-	spinlock_t mask_lock;
+	spinlock_t lock;
 
-	/** @state: one of &enum panthor_irq_state reflecting the current state. */
-	atomic_t state;
+	/**
+	 * @state: one of &enum panthor_irq_state reflecting the current state.
+	 *
+	 * Must be accessed with lock held.
+	 */
+	enum panthor_irq_state state;
 };
 
 /**
@@ -510,22 +514,15 @@ const char *panthor_exception_name(struct panthor_device *ptdev,
 static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)			\
 {												\
 	struct panthor_irq *pirq = data;							\
-	enum panthor_irq_state old_state;							\
 												\
-	guard(spinlock_irqsave)(&pirq->mask_lock);						\
-	old_state = atomic_cmpxchg(&pirq->state,						\
-				   PANTHOR_IRQ_STATE_ACTIVE,					\
-				   PANTHOR_IRQ_STATE_PROCESSING);				\
-	if (old_state != PANTHOR_IRQ_STATE_ACTIVE)						\
+	guard(spinlock_irqsave)(&pirq->lock);							\
+	if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)						\
 		return IRQ_NONE;								\
 												\
-	if (!gpu_read(pirq->iomem, INT_STAT)) {							\
-		atomic_cmpxchg(&pirq->state,							\
-			       PANTHOR_IRQ_STATE_PROCESSING,					\
-			       PANTHOR_IRQ_STATE_ACTIVE);					\
+	if (!gpu_read(pirq->iomem, INT_STAT))							\
 		return IRQ_NONE;								\
-	}											\
 												\
+	pirq->state = PANTHOR_IRQ_STATE_PROCESSING;						\
 	gpu_write(pirq->iomem, INT_MASK, 0);							\
 	return IRQ_WAKE_THREAD;									\
 }												\
@@ -554,14 +551,11 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 		ret = IRQ_HANDLED;								\
 	}											\
 												\
-	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
-		enum panthor_irq_state old_state;						\
-												\
-		old_state = atomic_cmpxchg(&pirq->state,					\
-					   PANTHOR_IRQ_STATE_PROCESSING,			\
-					   PANTHOR_IRQ_STATE_ACTIVE);				\
-		if (old_state == PANTHOR_IRQ_STATE_PROCESSING)					\
+	scoped_guard(spinlock_irqsave, &pirq->lock) {						\
+		if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING) {				\
+			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;					\
 			gpu_write(pirq->iomem, INT_MASK, pirq->mask);				\
+		}										\
 	}											\
 												\
 	return ret;										\
@@ -569,19 +563,20 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 												\
 static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)			\
 {												\
-	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
-		atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDING);				\
+	scoped_guard(spinlock_irqsave, &pirq->lock) {						\
+		pirq->state = PANTHOR_IRQ_STATE_SUSPENDING;					\
 		gpu_write(pirq->iomem, INT_MASK, 0);						\
 	}											\
 	synchronize_irq(pirq->irq);								\
-	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);					\
+	scoped_guard(spinlock_irqsave, &pirq->lock)						\
+		pirq->state = PANTHOR_IRQ_STATE_SUSPENDED;					\
 }												\
 												\
 static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)			\
 {												\
-	guard(spinlock_irqsave)(&pirq->mask_lock);						\
+	guard(spinlock_irqsave)(&pirq->lock);							\
 												\
-	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_ACTIVE);					\
+	pirq->state = PANTHOR_IRQ_STATE_ACTIVE;							\
 	gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);						\
 	gpu_write(pirq->iomem, INT_MASK, pirq->mask);						\
 }												\
@@ -594,8 +589,8 @@ static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
 	pirq->irq = irq;									\
 	pirq->mask = 0;										\
 	pirq->iomem = iomem;									\
-	spin_lock_init(&pirq->mask_lock);							\
-	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);					\
+	spin_lock_init(&pirq->lock);								\
+	pirq->state = PANTHOR_IRQ_STATE_SUSPENDED;						\
 	gpu_write(pirq->iomem, INT_MASK, 0);							\
 												\
 	return devm_request_threaded_irq(ptdev->base.dev, irq,					\
@@ -607,7 +602,7 @@ static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
 												\
 static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *pirq, u32 mask)	\
 {												\
-	guard(spinlock_irqsave)(&pirq->mask_lock);						\
+	guard(spinlock_irqsave)(&pirq->lock);							\
 	pirq->mask |= mask;									\
 												\
 	/* The only situation where we need to write the new mask is if the IRQ is active.	\
@@ -615,13 +610,13 @@ static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *
 	 * on the PROCESSING -> ACTIVE transition.						\
 	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
 	 */											\
-	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
+	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)						\
 		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
 }												\
 												\
 static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq *pirq, u32 mask)\
 {												\
-	guard(spinlock_irqsave)(&pirq->mask_lock);						\
+	guard(spinlock_irqsave)(&pirq->lock);							\
 	pirq->mask &= ~mask;									\
 												\
 	/* The only situation where we need to write the new mask is if the IRQ is active.	\
@@ -629,7 +624,7 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
 	 * on the PROCESSING -> ACTIVE transition.						\
 	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
 	 */											\
-	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
+	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)						\
 		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
 }
 

-- 
2.55.0

