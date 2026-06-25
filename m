Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812E9CDE002
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612F810F1F8;
	Thu, 25 Jun 2026 09:37:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="aU62iK35";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0340210F1F8
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782380196;
 bh=6VcJm57uvAYL/E78fxLO5afvFR0x39zRGx6pkGseE9s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=aU62iK35JXDAwBXWmUyEszM+Mj32PxZN+yW+5GUow8Ps54/CPV0BsnWDmZpQo7+1h
 +S/kVYxT+WTbEzeY/NbG4dSfM/W5LzknoPXANTtrovw3wTuJWOKl3cF/qweJQTvB8V
 09YxcZ2MITrSjLqrxGUMTkrxli5D8bUPYyDbh5LNt0JLZ2ei6X1otVJUk1N+U+QUJC
 av4+wN6nq0N2b7Df1pxzAf9Swuf8wwWbk9EckY3hiRl6BNth7dsH5kDh+8F1w1qfj/
 XiY41ySoh4L5onGKM99XcXFHuhr5RnWl7axxpHZlkuwD80eNO1x2M2eNvGnBxkc3/e
 LWI9P2Zy15dvg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 515A317E1562;
 Thu, 25 Jun 2026 11:36:36 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 11:36:30 +0200
Subject: [PATCH v5 15/16] drm/panthor: Don't defer FW event processing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-signal-from-irq-v5-15-8836a74e0ef9@collabora.com>
References: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
In-Reply-To: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782380187; l=3475;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=6VcJm57uvAYL/E78fxLO5afvFR0x39zRGx6pkGseE9s=;
 b=/DY40WrOi2KaZbQB65zvP7iTBvj5eNI1WSy6Hu7hXtdYNzGUIOkV/4yonoRMWnB3LV4Eind5W
 +5s/VG7U0qDDu81oz1Ytc7LzuHHr5zQv4J1FIkzECeLtp7zFl+OUMt6
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
index eea80121212f..2a7cd88d012a 100644
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
@@ -1972,14 +1955,17 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
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
@@ -1994,20 +1980,6 @@ static void process_fw_events_work(struct work_struct *work)
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
@@ -4085,7 +4057,6 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
 	struct panthor_scheduler *sched = ptdev->scheduler;
 
 	disable_delayed_work_sync(&sched->tick_work);
-	disable_work_sync(&sched->fw_events_work);
 	disable_work_sync(&sched->sync_upd_work);
 
 	mutex_lock(&sched->lock);
@@ -4170,7 +4141,6 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	sched->tick_period = msecs_to_jiffies(10);
 	INIT_DELAYED_WORK(&sched->tick_work, tick_work);
 	INIT_WORK(&sched->sync_upd_work, sync_upd_work);
-	INIT_WORK(&sched->fw_events_work, process_fw_events_work);
 
 	spin_lock_init(&sched->events_lock);
 

-- 
2.54.0

