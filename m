Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FC2C5DF77
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23A310E84A;
	Mon, 17 Aug 2026 15:15:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="l8KN3Qli";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF1810E83B
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=4g6HBxsN8h+FDW5Ik0e00KHHFJ5VsPbCBZwyVHmf/so=; b=l8KN3Qli39Luu2MpVDpdCrAtRM
 Y6LszgqkYbeRzXW8/i8UQKaHWOnicn6IPKuH4X7M0EYC7KXXvnfQeRxBmZs9zCPOvEt/tUTfPyG+E
 7qDoLg4grQjAmuSUL8FD5hwehk93KADlLTm4rs6cS0mGdTgSbhb12x4wLf3yY0bxoUuJalOs+V+H4
 AwyUkggJmrCqgaqMe0BU5/Z7l2l5n+vFc88bv38j4P8s+VzksieVuzjFIOiwTmk8O9BWSBF5Dl+cA
 VWyqueuNh2wwHFA4f1iphJiSAooJkTfNJcC2i7VeR5ZaVOf5gSxHxXY9YXoDY4QC/NvtH183AUo/E
 sOs9bcRA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wvz46-004eWD-Dy; Mon, 17 Aug 2026 17:15:54 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 17 Aug 2026 12:15:34 -0300
Subject: [PATCH 4/6] drm/vc4: Rebuild the V3D interrupt mask on every power
 transition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-vc4-irq-cleanup-v1-4-ee6c592b3836@igalia.com>
References: <20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igalia.com>
In-Reply-To: <20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Iago Toral <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4051; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=eTFvZpEiluwb3pdIJq+88P72lfMaVlw1wy/CGN7DCIE=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqgyWd3OPv2b3QbzqAacq5jXaBwQE3xfZgWq1bA
 jS5q77xjf+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoMlnQAKCRA/8w6Kdoj6
 qrauB/0REGK1JUAEbJ/S17oAhc25hOEaH8Nva2UEXptRYE5Tfn0E5bpIqYBJiXAvO1OunKAL7c1
 kb2Sdu8ZLP8ywzTOjlnvMpTDlhY0/QzrAaxD0WsM2d5z6wVqWzhn1vkgQSUTYDjVM55tIBe2GSM
 9k360H6GXzrnwjeJOzFN8TvkwTAQeqE7Lq6TW1cFeuiOR6OE77ZEM3Q1nAUwOi91IiIxCXOJUaM
 dmnpwJhPWrojV6erRqRMSSmCM3PM9sSJ4ZxQlU4j/RIrbQ0HiXVQbIvS4Kigbhu4gW2RuOAqqzK
 /SYBtxUNEP+kxOH9q9XHzBbogV8EemUH1vNz0qDACbIB7BnP
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The out-of-memory interrupt is armed once, by bin_bo_alloc(), when the
binner BO is allocated. vc4_irq_disable() masks it on the way down,
vc4_irq_enable() brings back only the render bits, and bin_bo_alloc() does
not run again for a binner BO that is still referenced. An overflow after
an autosuspend therefore raises nothing and the binner stalls, until the
hangcheck resets the GPU and arms the interrupt again.

Therefore, derive the out-of-memory bit in vc4_irq_enable() from whether a
binner BO exists, which is the condition bin_bo_alloc() was standing in
for.

While here, clear the complement of the wanted mask while enabling.
V3D_INTENA and V3D_INTDIS are set/clear registers and the driver only ever
set bits, so a source left enabled will stay enabled and can reach
vc4_irq(), which returns IRQ_NONE for anything outside the three bits it
handles.

Fixes: 35c8b4b2c0fe ("drm/vc4: Allocate binner bo when starting to use the V3D")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_irq.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index a1004c64e71b..2efed552c08a 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -53,10 +53,6 @@
 #include "vc4_regs.h"
 #include "vc4_trace.h"
 
-#define V3D_DRIVER_IRQS (V3D_INT_OUTOMEM | \
-			 V3D_INT_FLDONE | \
-			 V3D_INT_FRDONE)
-
 #define VC4_OVERFLOW_SLOT_TIMEOUT_NS	NSEC_PER_SEC
 
 static void
@@ -247,6 +243,7 @@ void
 vc4_irq_enable(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	u32 mask = V3D_INT_FLDONE | V3D_INT_FRDONE;
 
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return;
@@ -254,10 +251,18 @@ vc4_irq_enable(struct drm_device *dev)
 	if (!vc4->v3d)
 		return;
 
-	/* Enable the render done interrupts. The out-of-memory interrupt is
-	 * enabled as soon as we have a binner BO allocated.
+	/* Arming the OOM interrupt before there is a binner BO would raise an
+	 * interrupt nothing can clear.
 	 */
-	V3D_WRITE(V3D_INTENA, V3D_INT_FLDONE | V3D_INT_FRDONE);
+	if (vc4->bin_bo)
+		mask |= V3D_INT_OUTOMEM;
+
+	/* Clear any pending interrupts someone might have left around for us. */
+	V3D_WRITE(V3D_INTCTL, mask);
+
+	/* Enable our set of interrupts, masking out any others. */
+	V3D_WRITE(V3D_INTDIS, ~mask);
+	V3D_WRITE(V3D_INTENA, mask);
 }
 
 void
@@ -272,14 +277,14 @@ vc4_irq_disable(struct drm_device *dev)
 		return;
 
 	/* Disable sending interrupts for our driver's IRQs. */
-	V3D_WRITE(V3D_INTDIS, V3D_DRIVER_IRQS);
-
-	/* Clear any pending interrupts we might have left. */
-	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
+	V3D_WRITE(V3D_INTDIS, ~0);
 
 	/* Finish any interrupt handler still in flight. */
 	synchronize_irq(vc4->irq);
 
+	/* Clear any pending interrupts we might have left. */
+	V3D_WRITE(V3D_INTCTL, ~0);
+
 	cancel_work_sync(&vc4->overflow_mem_work);
 }
 
@@ -297,11 +302,6 @@ int vc4_irq_install(struct drm_device *dev)
 	init_waitqueue_head(&vc4->job_wait_queue);
 	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
 
-	/* Clear any pending interrupts someone might have left around
-	 * for us.
-	 */
-	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
-
 	ret = devm_request_irq(dev->dev, vc4->irq, vc4_irq, 0,
 			       dev_name(dev->dev), dev);
 	if (ret)
@@ -331,15 +331,7 @@ void vc4_irq_reset(struct drm_device *dev)
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return;
 
-	/* Acknowledge any stale IRQs. */
-	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
-
-	/*
-	 * Turn all our interrupts on. Binner out of memory is the only
-	 * one we expect to trigger at this point, since the reset cleared
-	 * the overflow memory address and none has been supplied yet.
-	 */
-	V3D_WRITE(V3D_INTENA, V3D_DRIVER_IRQS);
+	vc4_irq_enable(dev);
 
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
 	vc4_cancel_bin_job(dev);

-- 
2.55.0

