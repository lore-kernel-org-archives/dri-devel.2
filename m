Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CB5C61DBC
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DE710E942;
	Tue, 25 Aug 2026 08:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PnuhYEex";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA13A10E93F
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787644894;
 bh=ZOzLnpEc74qf635B40vazgd019LdXi45edpX3TzczUI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PnuhYEexhlIq6nmil8N9oaD/CM2tJ0zPBqPwABN7sMofvul22X4JzpegNkfXk/3Kk
 uF8BuhPnLorhrbvshZNCW+9BHWvph6If0RGeBflBVcj69bwPBET+/uOQ941fOonmWE
 8XHOeT8UB8+auAHd0uQD5CRxyfJMZ0I5xB2MjRRsswxnPAl3X2OmEOVDG1C0QRtTE9
 qKIHAryjyaKPRABHxLtBtQQo5Y4pnEIrqRhN9W3/+bG0RE+vyAVv6QI9+eS0ATG/dA
 C1vL5hf1OeqVLuD1XeH24Q9zsrngbHE6G6P3U8swNQ1HY9qFz1kZIIHNxENzXDUsni
 pdOS9sivhFnfQ==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3327A17E0D48;
 Tue, 25 Aug 2026 10:01:34 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 25 Aug 2026 10:01:29 +0200
Subject: [PATCH v7 8/9] drm/panthor: Don't defer FW event processing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-panthor-signal-from-irq-v7-8-ebb5b4c891a4@collabora.com>
References: <20260825-panthor-signal-from-irq-v7-0-ebb5b4c891a4@collabora.com>
In-Reply-To: <20260825-panthor-signal-from-irq-v7-0-ebb5b4c891a4@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787644889; l=3573;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=ZOzLnpEc74qf635B40vazgd019LdXi45edpX3TzczUI=;
 b=NJ7rZTr5SWXXPkHXGgAmwm2JAShHnuciu2C4RubLPOhCR6nyVteZFdupFFYVFLAOoLI2T8PbC
 nXuAeNbItNLDFC1261NjoW27uvn9fL+AeE0r5AFSOJ28BKY+9BuaJ93
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 48 +++++++--------------------------
 1 file changed, 9 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 64b5fc1a0984..7f99745ff404 100644
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
@@ -4083,7 +4055,6 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
 	struct panthor_scheduler *sched = ptdev->scheduler;
 
 	disable_delayed_work_sync(&sched->tick_work);
-	disable_work_sync(&sched->fw_events_work);
 	disable_work_sync(&sched->sync_upd_work);
 
 	mutex_lock(&sched->lock);
@@ -4168,7 +4139,6 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	sched->tick_period = msecs_to_jiffies(10);
 	INIT_DELAYED_WORK(&sched->tick_work, tick_work);
 	INIT_WORK(&sched->sync_upd_work, sync_upd_work);
-	INIT_WORK(&sched->fw_events_work, process_fw_events_work);
 
 	spin_lock_init(&sched->events_lock);
 

-- 
2.55.0

