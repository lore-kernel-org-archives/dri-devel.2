Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CDBC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0FC10E227;
	Fri, 25 Sep 2026 19:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="h1QC0TgO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675FD10E227
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 19:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=c4OnYyrg/6ipIFcS+STLfZ7aLL0txTlidY0zKWFMnM0=; b=h1QC0TgOsBIhayk7Shx2xMjXpR
 oZ4tEqy+DZWGw307sn3eeL3mrDXnlIq838l2F40XUV5quMGJOAnQWvPdp+cCqQFzoso6+x/mZre2s
 jUcBf90atimG64Q/PbVMEIeTJ1klJ7PQiT3FmbvC1tyjiAlRadJ+/B7P8dX7FRiHU1GbNQtnuZjmy
 U3y873JCxgefQuUlL+6XkvvuvAgfcYverVZ9fx8EkKtM3zCEXl2n07FldYSA7LY7FB12/5PPmsOyW
 ZBw+kcahTRxSvOdiLf2OhjZgQHUJKuPhUzWxXC041ox7mKnCiW7XfdEoyvT/35pxOgdQQKjTyPTH7
 BIGwO8cA==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xABMZ-007Ie7-LU; Fri, 25 Sep 2026 21:13:39 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH] drm/vc4: Disable the V3D interrupt across runtime suspend
Date: Fri, 25 Sep 2026 16:10:19 -0300
Message-ID: <20260925191318.541938-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.55.0
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

vc4_irq_disable() masks the V3D interrupt sources and then calls
synchronize_irq() before the V3D is powered down. However, by itself,
this is not enough to quiesce the interrupt handler.

synchronize_irq() waits for handlers that have already set
IRQD_IRQ_INPROGRESS, and for irqchips reporting IRQCHIP_STATE_ACTIVE.
A GIC interrupt chip is able to mark an interrupt active as soon as a
CPU acknowledges it, so there these checks cover the whole dispatch path.
On RPi 0-3, however, the interrupt controller is ARMCTRL, which has no
active state. A CPU that has read the hwirq out of the pending register
but has not yet reached handle_level_irq() stays invisible to
synchronize_irq().

During a power transition, vc4_irq() may therefore run after the power
domain is off, where every V3D register read will return 0xdeadbeef.
0xdeadbeef has FLDONE, FRDONE and OUTOMEM set. This problem doesn't
trigger NULL pointer dereference issues only because the functions
vc4_irq_finish_bin_job() and vc4_irq_finish_render_job() return early
when there is no job pointer, but OUTOMEM is still able to schedule
vc4_overflow_mem_work() after vc4_irq_disable() has already cancelled it.

Therefore, fix the spurious interrupts by disabling the interrupt line
across the PM transition. To preserve the enable/disable balance, move
vc4_irq_install() and request the IRQ line disabled before the first
runtime resume.

Fixes: 9b6f461582e6 ("drm/vc4: v3d: Stop disabling interrupts")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_irq.c | 18 +++---------------
 drivers/gpu/drm/vc4/vc4_v3d.c | 13 +++++++------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 7877d493d80e..98a8db720091 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -276,7 +276,7 @@ vc4_irq_disable(struct drm_device *dev)
 	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
 
 	/* Finish any interrupt handler still in flight. */
-	synchronize_irq(vc4->irq);
+	disable_irq(vc4->irq);
 
 	cancel_work_sync(&vc4->overflow_mem_work);
 }
@@ -284,7 +284,6 @@ vc4_irq_disable(struct drm_device *dev)
 int vc4_irq_install(struct drm_device *dev, int irq)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	int ret;
 
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return -ENODEV;
@@ -298,19 +297,8 @@ int vc4_irq_install(struct drm_device *dev, int irq)
 	init_waitqueue_head(&vc4->job_wait_queue);
 	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
 
-	/* Clear any pending interrupts someone might have left around
-	 * for us.
-	 */
-	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
-
-	ret = devm_request_irq(dev->dev, irq, vc4_irq, 0,
-			       dev_name(dev->dev), dev);
-	if (ret)
-		return ret;
-
-	vc4_irq_enable(dev);
-
-	return 0;
+	return devm_request_irq(dev->dev, irq, vc4_irq, IRQF_NO_AUTOEN,
+				dev_name(dev->dev), dev);
 }
 
 void vc4_irq_uninstall(struct drm_device *dev)
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index f32410420d3e..ca4b9d1a0e80 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -396,6 +396,7 @@ static int vc4_v3d_runtime_resume(struct device *dev)
 	vc4_v3d_init_hw(&vc4->base);
 
 	vc4_irq_enable(&vc4->base);
+	enable_irq(vc4->irq);
 
 	return 0;
 }
@@ -452,6 +453,12 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	vc4->irq = ret;
 
+	ret = vc4_irq_install(drm, vc4->irq);
+	if (ret) {
+		drm_err(drm, "Failed to install IRQ handler\n");
+		return ret;
+	}
+
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
@@ -473,12 +480,6 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	V3D_WRITE(V3D_BPOA, 0);
 	V3D_WRITE(V3D_BPOS, 0);
 
-	ret = vc4_irq_install(drm, vc4->irq);
-	if (ret) {
-		drm_err(drm, "Failed to install IRQ handler\n");
-		goto err_put_runtime_pm;
-	}
-
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, 40); /* a little over 2 frames. */
 	pm_runtime_put_autosuspend(dev);
-- 
2.55.0

