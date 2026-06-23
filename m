Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F523CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6464C10EB14;
	Tue, 23 Jun 2026 12:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PmyARBU3";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD2B10EB1E
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782219067;
 bh=fuqwg9vwlhj+6W7jac57A/SVDqnaM2H/gQsyMSi59Hk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PmyARBU3Fbbtq1Yg4WF0pkA6DiMRnVgAEcN2iSghvqAvZ52YDbX5Ls80TuAhEmPN7
 rUySzy2GQ+9aA54nQGP+x5j2M/OOjPMnXq9b+366JNxHzxJnXjx/MjgEipZ2jNPplb
 T+FZ8+frlFMKzOIpttqupSArr6QD7B+3Q55fPADplk1mqKcseB921vvXi+onP4tkuZ
 RyRkAl6fUFFpWV/BFC+V7wHX8mG9k2PJ8v1MtRF090qxY9dQIN0RgexM1oFw8bNncm
 yGzEbV6DbL1Muu2UZ7m5oyhTpUWnoOhpXvRVbFgEtEarO9BxLEg2uM0AaIJzXE6N7S
 ZjaphiDYdzDWw==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 671C317E0C54;
 Tue, 23 Jun 2026 14:51:07 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 23 Jun 2026 14:51:03 +0200
Subject: [PATCH v3 1/7] drm/panthor: Make panthor_irq::state a non-atomic field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-panthor-signal-from-irq-v3-1-2ece396f8ee0@collabora.com>
References: <20260623-panthor-signal-from-irq-v3-0-2ece396f8ee0@collabora.com>
In-Reply-To: <20260623-panthor-signal-from-irq-v3-0-2ece396f8ee0@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782219066; l=6936;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=fuqwg9vwlhj+6W7jac57A/SVDqnaM2H/gQsyMSi59Hk=;
 b=q69u9EJxlnae2V28Dwq84v2GhSuwQPAV1sPa16wI0fLx5tJQmetsWUOKUWgTzIc/tfgsm2nHY
 FWiO3dv10pKBpmAggUgGWxuqBkXF2oCOvyQHuJaorUZQq4wrQBQ315i
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
 drivers/gpu/drm/panthor/panthor_device.h | 53 ++++++++++++++++----------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 35679bfa1f3a..c4a03ac0812e 100644
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
@@ -510,18 +514,15 @@ const char *panthor_exception_name(struct panthor_device *ptdev,
 static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)			\
 {												\
 	struct panthor_irq *pirq = data;							\
-	enum panthor_irq_state old_state;							\
 												\
 	if (!gpu_read(pirq->iomem, INT_STAT))							\
 		return IRQ_NONE;								\
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
+	pirq->state = PANTHOR_IRQ_STATE_PROCESSING;						\
 	gpu_write(pirq->iomem, INT_MASK, 0);							\
 	return IRQ_WAKE_THREAD;									\
 }												\
@@ -550,14 +551,11 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
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
@@ -565,19 +563,20 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
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
@@ -590,7 +589,7 @@ static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
 	pirq->irq = irq;									\
 	pirq->mask = mask;									\
 	pirq->iomem = iomem;									\
-	spin_lock_init(&pirq->mask_lock);							\
+	spin_lock_init(&pirq->lock);								\
 	panthor_ ## __name ## _irq_resume(pirq);						\
 												\
 	return devm_request_threaded_irq(ptdev->base.dev, irq,					\
@@ -602,7 +601,7 @@ static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
 												\
 static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *pirq, u32 mask)	\
 {												\
-	guard(spinlock_irqsave)(&pirq->mask_lock);						\
+	guard(spinlock_irqsave)(&pirq->lock);							\
 	pirq->mask |= mask;									\
 												\
 	/* The only situation where we need to write the new mask is if the IRQ is active.	\
@@ -610,13 +609,13 @@ static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *
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
@@ -624,7 +623,7 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
 	 * on the PROCESSING -> ACTIVE transition.						\
 	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
 	 */											\
-	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
+	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)						\
 		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
 }
 

-- 
2.54.0

