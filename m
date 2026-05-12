Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC1DCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3663210EA41;
	Tue, 12 May 2026 11:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="G8B63169";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3CF10EA41
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778585863;
 bh=c5drgRJmcNadBj1Gh5/hJRtpgpyvGiN5RCRMXRPeB3M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=G8B63169nljK71rZmpn/JeBna30hIhOE4VsIbBlSxnIo/n5EW9Xv70dypNHLqm91A
 zi1HkRtiM1e89qd/sqPdD3ZJJTWpplJAIhF1g4P3RWc2DkpB2j35dtqb1qgiVuNLkh
 DzvRTpvxgm1JMJsvkLgXfSJyx+YlNHK/IZzXrgir3F3lwSZg3Lb+9eppiXSN/zSiaP
 uHpzo4QT1fbgtu5oeXd/9EYM5rdMdb0DBESmprJyIhJPU1oKt2hM/VbQL7qtvUMyjP
 RCEvRCql8iDqQoFtOxVdhkQ7ORMmn7UgPQV9GJAHOK9n8tMHXNeNbqfssIpnfOzJak
 aEAqVlrUTr0Dg==
Received: from [192.168.1.38] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7D6C017E15E3;
 Tue, 12 May 2026 13:37:43 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 12 May 2026 13:37:34 +0200
Subject: [PATCH v2 04/11] drm/panthor: Extend the IRQ logic to allow
 fast/hard IRQ handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-panthor-signal-from-irq-v2-4-95c614a739cb@collabora.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778585861; l=4171;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=c5drgRJmcNadBj1Gh5/hJRtpgpyvGiN5RCRMXRPeB3M=;
 b=ndjXoRNvq6rohBXbGncM3L21vBkNitjoximoTcXHEncPnQ1Ds6dd7Y+2xbKKINfEQFPegMko5
 vpl52vod6NAAkLBxH9xB1VZpda2HdYjZaQIeT8SHVzsInlI5WOMIx5E
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

All drivers except panthor signal their fences from their interrupt
handler to minimize latency. We could do the same from the threaded
handler, but the latency is still quite high in that case, so let's
allow components to choose the context they want their IRQ handler
to run in by exposing support for custom hard handlers.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.h | 11 ++++++++---
 drivers/gpu/drm/panthor/panthor_fw.c     |  1 +
 drivers/gpu/drm/panthor/panthor_gpu.c    |  1 +
 drivers/gpu/drm/panthor/panthor_mmu.c    |  1 +
 drivers/gpu/drm/panthor/panthor_pwr.c    |  1 +
 5 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 393fcda73d88..1aaf06df875b 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -672,6 +672,7 @@ static inline void panthor_irq_disable_events(struct panthor_irq *pirq, u32 mask
 static inline int
 panthor_irq_request(struct panthor_device *ptdev, struct panthor_irq *pirq,
 		    int irq, u32 mask, void __iomem *iomem, const char *name,
+		    irqreturn_t (*raw_handler)(int, void *data),
 		    irqreturn_t (*threaded_handler)(int, void *data))
 {
 	const char *full_name;
@@ -687,9 +688,13 @@ panthor_irq_request(struct panthor_device *ptdev, struct panthor_irq *pirq,
 		return -ENOMEM;
 
 	panthor_irq_resume(pirq);
-	return devm_request_threaded_irq(ptdev->base.dev, irq,
-					 panthor_irq_default_raw_handler,
-					 threaded_handler,
+
+	if (!threaded_handler) {
+		return devm_request_irq(ptdev->base.dev, irq, raw_handler,
+					IRQF_SHARED, full_name, pirq);
+	}
+
+	return devm_request_threaded_irq(ptdev->base.dev, irq, raw_handler, threaded_handler,
 					 IRQF_SHARED, full_name, pirq);
 }
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index eaf599b0a887..8239a6951569 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1483,6 +1483,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
 
 	ret = panthor_irq_request(ptdev, &fw->irq, irq, 0,
 				  ptdev->iomem + JOB_INT_BASE, "job",
+				  panthor_irq_default_raw_handler,
 				  panthor_job_irq_threaded_handler);
 	if (ret) {
 		drm_err(&ptdev->base, "failed to request job irq");
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index ce208e384762..d0be758ea3e1 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -177,6 +177,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	ret = panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
 				  GPU_INTERRUPTS_MASK,
 				  ptdev->iomem + GPU_INT_BASE, "gpu",
+				  panthor_irq_default_raw_handler,
 				  panthor_gpu_irq_threaded_handler);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 375022fb3fd8..2955b8baa2e2 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -3266,6 +3266,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	ret = panthor_irq_request(ptdev, &mmu->irq, irq,
 				  panthor_mmu_fault_mask(ptdev, ~0),
 				  ptdev->iomem + MMU_INT_BASE, "mmu",
+				  panthor_irq_default_raw_handler,
 				  panthor_mmu_irq_threaded_handler);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 80cf78007896..1efb7f3482ba 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -491,6 +491,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 	err = panthor_irq_request(
 		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
 		pwr->iomem + PWR_INT_BASE, "pwr",
+		panthor_irq_default_raw_handler,
 		panthor_pwr_irq_threaded_handler);
 	if (err)
 		return err;

-- 
2.54.0

