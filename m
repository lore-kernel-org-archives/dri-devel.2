Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB32C5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 11:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C3E610EB5E;
	Tue, 11 Aug 2026 11:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="mtA1F6Bi";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7699B10EB4D
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786447423;
 bh=uYLup99cnNiZiVfM/azyFrqCCYE+R/lI/+jegXfQNh4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mtA1F6BiBD4absVHnYdG7O5z6Tx7eeQ/W+L5cb6ybVuGHL1KlBjBVFLGWe4uUTIqw
 2vDJCrd1C954ygaDRhKxOyrPyzXYFSCfvOnNNzkZGMFs16DKYJbATWffCIshs2mSh8
 +vaoNRnxkkjxGDatXT8RJKbcVgvBN9YBAk8fqcWwMioFoQtSUsdtH8Dj/b2Hz2YP/V
 0Zjp+0T90NChCqSpm9qy4M1dP09qwEmqbeYINOhDZoLjIfGr4/sF3FWuRrC3HwPDxl
 N4yzqmjzL4dm4CQIgGJNt4wIlxzFG6wJwUspCYdhDW0YPrhiOjik45aCTrPKvrYndy
 2oP4ijz+h9bCw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CFC4A17E0FB1;
 Tue, 11 Aug 2026 13:23:42 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 13:23:42 +0200
Subject: [PATCH v6 8/9] drm/panthor: Don't defer FW event processing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-signal-from-irq-v6-8-12f2ab53d735@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786447418; l=3475;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=uYLup99cnNiZiVfM/azyFrqCCYE+R/lI/+jegXfQNh4=;
 b=GhNnEUzGhzkGsuNVtJmgyzq8u7oYNcPW1lBo65LCsb0k53o1nFP65iSUGGuseh88PodWk7ih4
 KBTxRE8xzJ3A2WqS1ujRIJ/asrB9OMZnHseb//2slMpvEJe+HrpGKuZ
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

Avoid a workqueue roundtrip and process things immediately from
panthor_sched_report_fw_events().

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 48 +++++++--------------------------
 1 file changed, 9 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 1ef9da55030c..8016b0a55173 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -177,23 +177,6 @@ struct panthor_scheduler {
 	 */
 	struct work_struct sync_upd_work;
 
-	/**
-	 * @fw_events_work: Work used to process FW events outside the interrupt path.
-	 *
-	 * Even if the interrupt is threaded, we need any event processing
-	 * that require taking the panthor_scheduler::lock to be processed
-	 * outside the interrupt path so we don't block the tick logic when
-	 * it calls panthor_fw_{csg,wait}_wait_acks(). Since most of the
-	 * event processing requires taking this lock, we just delegate all
-	 * FW event processing to the scheduler workqueue.
-	 */
-	struct work_struct fw_events_work;
-
-	/**
-	 * @fw_events: Bitmask encoding pending FW events.
-	 */
-	atomic_t fw_events;
-
 	/**
 	 * @resched_target: When the next tick should occur.
 	 *
@@ -1971,14 +1954,17 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
 		sched_process_idle_event_locked(ptdev);
 }
 
-static void process_fw_events_work(struct work_struct *work)
+/**
+ * panthor_sched_report_fw_events() - Report FW events to the scheduler.
+ * @ptdev: Device.
+ * @events: Bitmask of pending FW events to report.
+ */
+void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
 {
-	struct panthor_scheduler *sched = container_of(work, struct panthor_scheduler,
-						      fw_events_work);
-	u32 events = atomic_xchg(&sched->fw_events, 0);
-	struct panthor_device *ptdev = sched->ptdev;
+	if (!ptdev->scheduler)
+		return;
 
-	guard(spinlock)(&sched->events_lock);
+	guard(spinlock)(&ptdev->scheduler->events_lock);
 
 	if (events & JOB_INT_GLOBAL_IF) {
 		sched_process_global_irq_locked(ptdev);
@@ -1993,20 +1979,6 @@ static void process_fw_events_work(struct work_struct *work)
 	}
 }
 
-/**
- * panthor_sched_report_fw_events() - Report FW events to the scheduler.
- * @ptdev: Device.
- * @events: Bitmask of pending FW events to report.
- */
-void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
-{
-	if (!ptdev->scheduler)
-		return;
-
-	atomic_or(events, &ptdev->scheduler->fw_events);
-	sched_queue_work(ptdev->scheduler, fw_events);
-}
-
 static const char *fence_get_driver_name(struct dma_fence *fence)
 {
 	return "panthor";
@@ -4082,7 +4054,6 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
 	struct panthor_scheduler *sched = ptdev->scheduler;
 
 	disable_delayed_work_sync(&sched->tick_work);
-	disable_work_sync(&sched->fw_events_work);
 	disable_work_sync(&sched->sync_upd_work);
 
 	mutex_lock(&sched->lock);
@@ -4167,7 +4138,6 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	sched->tick_period = msecs_to_jiffies(10);
 	INIT_DELAYED_WORK(&sched->tick_work, tick_work);
 	INIT_WORK(&sched->sync_upd_work, sync_upd_work);
-	INIT_WORK(&sched->fw_events_work, process_fw_events_work);
 
 	spin_lock_init(&sched->events_lock);
 

-- 
2.55.0

