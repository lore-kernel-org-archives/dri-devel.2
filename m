Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D89FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 09:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB81710EF24;
	Wed, 29 Apr 2026 09:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FSVzqITs";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F5910EEFE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777455539;
 bh=wziwJjIxxAv4lvMAYsfdrTzTInL8uzMnt6s9npP1kEE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FSVzqITsq9lYLA/chq8SkZV1UDilKKuN4SpABf48/qCn1DQATva6gWmJ3mmNJ1yFz
 xDlgl0PrM/CoWqYBxyIxd9ZewtXE8u5jCgf8NF0pA84OZQxx9MF6v8GfxIlO93Rsh0
 9+/fSbJbfc39zEdFgMkpyCedcIAIdVKg5OYzMF3fRD41sJsGZh02gdOwRKSxXK6rYz
 jSyf5MdPm3iCDDJwQ1hXizJnKtpPsrmMIfAlegGscKmhBzViczae4Gt37qHiykOi2c
 peZAWQPy354Pw/fGxklTvsNdRXEVsn4qRkkB62TUL0F88EYl0KSBeTKK1Ju2H3ae7R
 BRQt5QzPeNRcQ==
Received: from [100.64.0.11] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A8A1617E1580;
 Wed, 29 Apr 2026 11:38:58 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 29 Apr 2026 11:38:35 +0200
Subject: [PATCH 08/10] drm/panthor: Automatically enable interrupts in
 panthor_fw_wait_acks()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-panthor-signal-from-irq-v1-8-4b92ae4142d2@collabora.com>
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
In-Reply-To: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777455534; l=4411;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=wziwJjIxxAv4lvMAYsfdrTzTInL8uzMnt6s9npP1kEE=;
 b=H0qk+dnvemBGiEl72kN3BDM6vDpXRu99o0FDyP2ypDgiLTaWA+mYHhzDCRKOR+Tg4ynaB1MD8
 TlKf7yQ47GuBABceoBkoICMq5U73GWibyR+pKSiFC/RzRZ5KJw99YGC
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

Rather than assuming an interrupt is always expected for request
acks, temporarily enable the relevant interrupts when the polling-wait
failed. This should hopefully reduce the number of interrupts the CPU
has to process.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c    | 34 +++++++++++++++++++--------------
 drivers/gpu/drm/panthor/panthor_sched.c |  5 +++--
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 8239a6951569..f5e0ceca4130 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1039,16 +1039,10 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
 	glb_iface->input->progress_timer = PROGRESS_TIMEOUT_CYCLES >> PROGRESS_TIMEOUT_SCALE_SHIFT;
 	glb_iface->input->idle_timer = panthor_fw_conv_timeout(ptdev, IDLE_HYSTERESIS_US);
 
-	/* Enable interrupts we care about. */
-	glb_iface->input->ack_irq_mask = GLB_CFG_ALLOC_EN |
-					 GLB_PING |
-					 GLB_CFG_PROGRESS_TIMER |
-					 GLB_CFG_POWEROFF_TIMER |
-					 GLB_IDLE_EN |
-					 GLB_IDLE;
-
-	if (panthor_fw_has_glb_state(ptdev))
-		glb_iface->input->ack_irq_mask |= GLB_STATE_MASK;
+	/* Enable interrupts for asynchronous events that are not
+	 * triggered by request acks.
+	 */
+	glb_iface->input->ack_irq_mask = GLB_IDLE;
 
 	panthor_fw_update_reqs(glb_iface, req, GLB_IDLE_EN | GLB_COUNTER_EN,
 			       GLB_IDLE_EN | GLB_COUNTER_EN);
@@ -1318,8 +1312,8 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
  * Return: 0 on success, -ETIMEDOUT otherwise.
  */
 static int panthor_fw_wait_acks(const u32 *req_ptr, const u32 *ack_ptr,
-				wait_queue_head_t *wq,
-				u32 req_mask, u32 *acked,
+				u32 *ack_irq_mask_ptr, spinlock_t *lock,
+				wait_queue_head_t *wq, u32 req_mask, u32 *acked,
 				u32 timeout_ms)
 {
 	u32 ack, req = READ_ONCE(*req_ptr) & req_mask;
@@ -1334,8 +1328,16 @@ static int panthor_fw_wait_acks(const u32 *req_ptr, const u32 *ack_ptr,
 	if (!ret)
 		return 0;
 
-	if (wait_event_timeout(*wq, (READ_ONCE(*ack_ptr) & req_mask) == req,
-			       msecs_to_jiffies(timeout_ms)))
+	scoped_guard(spinlock_irqsave, lock)
+		*ack_irq_mask_ptr |= req_mask;
+
+	ret = wait_event_timeout(*wq, (READ_ONCE(*ack_ptr) & req_mask) == req,
+				 msecs_to_jiffies(timeout_ms));
+
+	scoped_guard(spinlock_irqsave, lock)
+		*ack_irq_mask_ptr &= ~req_mask;
+
+	if (ret)
 		return 0;
 
 	/* Check one last time, in case we were not woken up for some reason. */
@@ -1369,6 +1371,8 @@ int panthor_fw_glb_wait_acks(struct panthor_device *ptdev,
 
 	return panthor_fw_wait_acks(&glb_iface->input->req,
 				    &glb_iface->output->ack,
+				    &glb_iface->input->ack_irq_mask,
+				    &glb_iface->lock,
 				    &ptdev->fw->req_waitqueue,
 				    req_mask, acked, timeout_ms);
 }
@@ -1395,6 +1399,8 @@ int panthor_fw_csg_wait_acks(struct panthor_device *ptdev, u32 csg_slot,
 
 	ret = panthor_fw_wait_acks(&csg_iface->input->req,
 				   &csg_iface->output->ack,
+				   &csg_iface->input->ack_irq_mask,
+				   &csg_iface->lock,
 				   &ptdev->fw->req_waitqueue,
 				   req_mask, acked, timeout_ms);
 
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 601a9bff1485..2edba335f22d 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1110,7 +1110,7 @@ cs_slot_prog_locked(struct panthor_device *ptdev, u32 csg_id, u32 cs_id)
 	cs_iface->input->ringbuf_output = queue->iface.output_fw_va;
 	cs_iface->input->config = CS_CONFIG_PRIORITY(queue->priority) |
 				  CS_CONFIG_DOORBELL(queue->doorbell_id);
-	cs_iface->input->ack_irq_mask = ~0;
+	cs_iface->input->ack_irq_mask = CS_FATAL | CS_FAULT | CS_TILER_OOM;
 	panthor_fw_update_reqs(cs_iface, req,
 			       CS_IDLE_SYNC_WAIT |
 			       CS_IDLE_EMPTY |
@@ -1378,7 +1378,8 @@ csg_slot_prog_locked(struct panthor_device *ptdev, u32 csg_id, u32 priority)
 		csg_iface->input->protm_suspend_buf = 0;
 	}
 
-	csg_iface->input->ack_irq_mask = ~0;
+	csg_iface->input->ack_irq_mask = CSG_SYNC_UPDATE | CSG_IDLE |
+					 CSG_PROGRESS_TIMER_EVENT;
 	panthor_fw_toggle_reqs(csg_iface, doorbell_req, doorbell_ack, queue_mask);
 	return 0;
 }

-- 
2.53.0

