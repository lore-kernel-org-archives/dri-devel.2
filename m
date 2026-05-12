Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81783CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED4510EA48;
	Tue, 12 May 2026 11:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Y4aLdGEC";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB1A10EA42
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778585862;
 bh=KO7C14/dRLa4Y8IY+shQp5tnMsgwzICsfyh3fv0hExQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Y4aLdGECYzIgw6xVx5OlIrkzybeRm68yMy1EeEV8iowZ/yPAbAS0fF7Exwul2n/Jv
 jDZHwYTggKzJhNED5CHvbBfLZzAkowDso9gHNhVYEIKs4KNs3vbHRJ98H1AxN6e2/4
 0CCqK3hQSM5iJvrvoTXwads4osROi4g/zkTMTxqAzLLxiJVgqz+k/cJ+n/9SqkA83p
 21rGZ4lH9MnE5lTxHCIdpfz4BDhcumqvZAtB4lqx/youEnzrMH5LyzcpBcOWmAWE2W
 QJBx7aBTbMa9yXslAHo+IbAaquvhyQHqPoUWCDL9lxGG2T3fSDI7We82qdcom5SglW
 O/PPuEmR+GKmA==
Received: from [192.168.1.38] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D700A17E138B;
 Tue, 12 May 2026 13:37:41 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 12 May 2026 13:37:31 +0200
Subject: [PATCH v2 01/11] drm/panthor: Make panthor_irq::state a non-atomic
 field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-panthor-signal-from-irq-v2-1-95c614a739cb@collabora.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778585861; l=4833;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=KO7C14/dRLa4Y8IY+shQp5tnMsgwzICsfyh3fv0hExQ=;
 b=JeSGlY9NOwqAHu6TrLsZA2f2lELRneBiEyzR2VtH3on3fMFEuhvLcFLNFrN8Yyt94aOZFaWU/
 Pkp8d2q7dGnDaUWILdZ/TenEZgoL1El328KTPYJVWcLdv6af7ylnYk7
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

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h | 35 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4e4607bca7cc..3f91ba73829d 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -101,8 +101,12 @@ struct panthor_irq {
 	 */
 	spinlock_t mask_lock;
 
-	/** @state: one of &enum panthor_irq_state reflecting the current state. */
-	atomic_t state;
+	/**
+	 * @state: one of &enum panthor_irq_state reflecting the current state.
+	 *
+	 * Must be accessed with mask_lock held.
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
 	guard(spinlock_irqsave)(&pirq->mask_lock);						\
-	old_state = atomic_cmpxchg(&pirq->state,						\
-				   PANTHOR_IRQ_STATE_ACTIVE,					\
-				   PANTHOR_IRQ_STATE_PROCESSING);				\
-	if (old_state != PANTHOR_IRQ_STATE_ACTIVE)						\
+	if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)						\
 		return IRQ_NONE;								\
 												\
+	pirq->state = PANTHOR_IRQ_STATE_PROCESSING;						\
 	gpu_write(pirq->iomem, INT_MASK, 0);							\
 	return IRQ_WAKE_THREAD;									\
 }												\
@@ -551,13 +552,10 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 	}											\
 												\
 	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
-		enum panthor_irq_state old_state;						\
-												\
-		old_state = atomic_cmpxchg(&pirq->state,					\
-					   PANTHOR_IRQ_STATE_PROCESSING,			\
-					   PANTHOR_IRQ_STATE_ACTIVE);				\
-		if (old_state == PANTHOR_IRQ_STATE_PROCESSING)					\
+		if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING) {				\
+			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;					\
 			gpu_write(pirq->iomem, INT_MASK, pirq->mask);				\
+		}										\
 	}											\
 												\
 	return ret;										\
@@ -566,18 +564,19 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)			\
 {												\
 	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
-		atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDING);				\
+		pirq->state = PANTHOR_IRQ_STATE_SUSPENDING;					\
 		gpu_write(pirq->iomem, INT_MASK, 0);						\
 	}											\
 	synchronize_irq(pirq->irq);								\
-	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);					\
+	scoped_guard(spinlock_irqsave, &pirq->mask_lock)					\
+		pirq->state = PANTHOR_IRQ_STATE_SUSPENDED;					\
 }												\
 												\
 static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)			\
 {												\
 	guard(spinlock_irqsave)(&pirq->mask_lock);						\
 												\
-	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_ACTIVE);					\
+	pirq->state = PANTHOR_IRQ_STATE_ACTIVE;							\
 	gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);						\
 	gpu_write(pirq->iomem, INT_MASK, pirq->mask);						\
 }												\
@@ -610,7 +609,7 @@ static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *
 	 * on the PROCESSING -> ACTIVE transition.						\
 	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
 	 */											\
-	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
+	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)						\
 		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
 }												\
 												\
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

