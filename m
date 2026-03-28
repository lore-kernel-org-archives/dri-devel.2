Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D849A10BA423
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 18:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4432210E537;
	Sat, 28 Mar 2026 18:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BgHq0ekC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1772210E10B
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 18:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2vSiofseJQritJoo/kYMQf2WWbljZf1+ansnduhvt6I=; b=BgHq0ekCWARS4UWqbmyuIW+pXQ
 gVokiZNjgow+2iBxu8slg/MSQdWPS3HvFRTiwm7iP4BhVKhpKHaT24xOkIgGjJbE4xOYOLpIRKY7v
 BYm3IiWsOqcEcKRvK/QzIwyRVAkjei/uwtsTdEASKdoul+Y5AyANihYQSbKsayoZdsWa75X3lPU6J
 sRG05kw9/XOPFj8TodccRVbeCZmdXV1CxGeXMq6Xwt+vydOwagGtOdqNX+Z6qDW3tWzuJ+KKeJxNx
 UbHbwAFzaCcpSAEu3F1JVHbyE0EjHrBC1TtdDV1sz0Uyc4fyIlzALlZdUn/ADz4L991426rDI/x4u
 HJSWmTpw==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w6Yma-007f3o-IG; Sat, 28 Mar 2026 19:53:16 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 28 Mar 2026 15:52:48 -0300
Subject: [PATCH v8 2/3] drm/v3d: Allocate all resources before enabling the
 clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260328-v3d-power-management-v8-2-94336830df5f@igalia.com>
References: <20260328-v3d-power-management-v8-0-94336830df5f@igalia.com>
In-Reply-To: <20260328-v3d-power-management-v8-0-94336830df5f@igalia.com>
To: Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 kernel-dev@igalia.com, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7563; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=+zjomnaO0OzS3lQEQceIVi2rjWwjOF5edG9LH0KBlvI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpyCORZO1yuw4U5BwNrVMy1Cb/uFjHrOp7RoIq7
 /wtAVfJwouJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCacgjkQAKCRA/8w6Kdoj6
 qondB/4qSE07S1f82TMMDCVt0BxMJQRPRNr/xOQc4A2PGOSr/2PB/h003ON3OZZ4zYAxbpIoVZp
 cEX8xPuHaFWJSbO/WhmpP2oeWm8fNB5PK4b3959hMycp0DSfzEr51r+416S5e+NijrT4mGQu0lD
 Iodc3+wbNb0wjmEe7u3BXUrB9JeKIL8BBO5PGHM6HcNCU434YyoxIZNqMiCHmFKtA2ob1t17W1w
 4ULYLLYMEt7IX/1FAzOCiWQbNhTVrBDWsKJ2couUNu9JJS2hkGy6c/hEbgVllME4SHA5FShGwxt
 XH/zCUW5iRtfeUol0W6hJOyPrKZJ2MBf3TytEAn0h6TiIRkW
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

Move all resource allocation operations before actually enabling the
clock, as those operations don't require the GPU to be powered on.

This is a preparation for runtime PM support. The next commit will
move all code related to powering on and initiating the GPU into the
runtime PM resume callback and all resource allocation will happen
before resume().

Reviewed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 93 ++++++++++++++++++++++---------------------
 drivers/gpu/drm/v3d/v3d_drv.h |  1 +
 drivers/gpu/drm/v3d/v3d_gem.c | 18 ++++-----
 drivers/gpu/drm/v3d/v3d_irq.c | 15 +++----
 4 files changed, 62 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index c5e7c778ec7a1a39d81155f7ed2a7ba811b5e3aa..e57b36f4d81a59d15a223afdc4078ae6456de9a9 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -363,14 +363,50 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	if (v3d->ver < V3D_GEN_41) {
+		ret = map_regs(v3d, &v3d->gca_regs, "gca");
+		if (ret)
+			return ret;
+	}
+
+	v3d->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(v3d->reset))
+		return dev_err_probe(dev, PTR_ERR(v3d->reset),
+				     "Failed to get reset control\n");
+
+	if (!v3d->reset) {
+		ret = map_regs(v3d, &v3d->bridge_regs, "bridge");
+		if (ret) {
+			dev_err(dev, "Failed to get bridge registers\n");
+			return ret;
+		}
+	}
+
 	v3d->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(v3d->clk))
 		return dev_err_probe(dev, PTR_ERR(v3d->clk), "Failed to get V3D clock\n");
 
+	ret = v3d_irq_init(v3d);
+	if (ret)
+		return ret;
+
+	v3d_perfmon_init(v3d);
+
+	v3d->mmu_scratch = dma_alloc_wc(dev, 4096, &v3d->mmu_scratch_paddr,
+					GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
+	if (!v3d->mmu_scratch) {
+		dev_err(dev, "Failed to allocate MMU scratch page\n");
+		return -ENOMEM;
+	}
+
+	ret = v3d_gem_init(drm);
+	if (ret)
+		goto dma_free;
+
 	ret = clk_prepare_enable(v3d->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't enable the V3D clock\n");
-		return ret;
+		goto gem_destroy;
 	}
 
 	v3d_idle_sms(v3d);
@@ -399,44 +435,9 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	ident3 = V3D_READ(V3D_HUB_IDENT3);
 	v3d->rev = V3D_GET_FIELD(ident3, V3D_HUB_IDENT3_IPREV);
 
-	v3d_perfmon_init(v3d);
-
-	v3d->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
-	if (IS_ERR(v3d->reset)) {
-		ret = dev_err_probe(dev, PTR_ERR(v3d->reset),
-				    "Failed to get reset control\n");
-		goto clk_disable;
-	}
-
-	if (!v3d->reset) {
-		ret = map_regs(v3d, &v3d->bridge_regs, "bridge");
-		if (ret) {
-			dev_err(dev, "Failed to get bridge registers\n");
-			goto clk_disable;
-		}
-	}
-
-	if (v3d->ver < V3D_GEN_41) {
-		ret = map_regs(v3d, &v3d->gca_regs, "gca");
-		if (ret)
-			goto clk_disable;
-	}
-
-	v3d->mmu_scratch = dma_alloc_wc(dev, 4096, &v3d->mmu_scratch_paddr,
-					GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
-	if (!v3d->mmu_scratch) {
-		dev_err(dev, "Failed to allocate MMU scratch page\n");
-		ret = -ENOMEM;
-		goto clk_disable;
-	}
-
-	ret = v3d_gem_init(drm);
-	if (ret)
-		goto dma_free;
-
-	ret = v3d_irq_init(v3d);
-	if (ret)
-		goto gem_destroy;
+	v3d_init_hw_state(v3d);
+	v3d_mmu_set_page_table(v3d);
+	v3d_irq_enable(v3d);
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
@@ -452,12 +453,13 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	drm_dev_unregister(drm);
 irq_disable:
 	v3d_irq_disable(v3d);
+clk_disable:
+	v3d_power_off_sms(v3d);
+	clk_disable_unprepare(v3d->clk);
 gem_destroy:
 	v3d_gem_destroy(drm);
 dma_free:
 	dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
-clk_disable:
-	clk_disable_unprepare(v3d->clk);
 	return ret;
 }
 
@@ -471,14 +473,13 @@ static void v3d_platform_drm_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(drm);
 
-	v3d_gem_destroy(drm);
-
-	dma_free_wc(v3d->drm.dev, 4096, v3d->mmu_scratch,
-		    v3d->mmu_scratch_paddr);
-
 	v3d_power_off_sms(v3d);
 
 	clk_disable_unprepare(v3d->clk);
+
+	v3d_gem_destroy(drm);
+
+	dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
 }
 
 static struct platform_driver v3d_platform_driver = {
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 6a3cad933439812d78da5797749c020a9bf46402..ebf406b615bb52de9cb98ea8efe941a5787fb4bd 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -565,6 +565,7 @@ struct dma_fence *v3d_fence_create(struct v3d_dev *v3d, enum v3d_queue q);
 
 /* v3d_gem.c */
 extern bool super_pages;
+void v3d_init_hw_state(struct v3d_dev *v3d);
 int v3d_gem_init(struct drm_device *dev);
 void v3d_gem_destroy(struct drm_device *dev);
 void v3d_reset_sms(struct v3d_dev *v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 75d9eccd796664e67277c1f83ad59063f164d1da..def6a9612b857a241f6b2e1f601509928e3f9f8b 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -36,13 +36,6 @@ v3d_init_core(struct v3d_dev *v3d, int core)
 	V3D_CORE_WRITE(core, V3D_CTL_L2TFLEND, ~0);
 }
 
-/* Sets invariant state for the HW. */
-static void
-v3d_init_hw_state(struct v3d_dev *v3d)
-{
-	v3d_init_core(v3d, 0);
-}
-
 static void
 v3d_idle_axi(struct v3d_dev *v3d, int core)
 {
@@ -259,6 +252,14 @@ v3d_invalidate_caches(struct v3d_dev *v3d)
 	v3d_invalidate_slices(v3d, 0);
 }
 
+/* Sets invariant state for the HW. */
+void
+v3d_init_hw_state(struct v3d_dev *v3d)
+{
+	v3d_init_core(v3d, 0);
+}
+
+
 static void
 v3d_huge_mnt_init(struct v3d_dev *v3d)
 {
@@ -328,9 +329,6 @@ v3d_gem_init(struct drm_device *dev)
 		goto err_dma_alloc;
 	}
 
-	v3d_init_hw_state(v3d);
-	v3d_mmu_set_page_table(v3d);
-
 	v3d_huge_mnt_init(v3d);
 
 	ret = v3d_sched_init(v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index c28e74ab5442857031b48bcbd4e43eb48c1e0f07..86efaef2722c3602346b037ba536228b2f368a81 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -248,17 +248,10 @@ v3d_hub_irq(int irq, void *arg)
 int
 v3d_irq_init(struct v3d_dev *v3d)
 {
-	int irq, ret, core;
+	int irq, ret;
 
 	INIT_WORK(&v3d->overflow_mem_work, v3d_overflow_mem_work);
 
-	/* Clear any pending interrupts someone might have left around
-	 * for us.
-	 */
-	for (core = 0; core < v3d->cores; core++)
-		V3D_CORE_WRITE(core, V3D_CTL_INT_CLR, V3D_CORE_IRQS(v3d->ver));
-	V3D_WRITE(V3D_HUB_INT_CLR, V3D_HUB_IRQS(v3d->ver));
-
 	irq = platform_get_irq_optional(v3d_to_pdev(v3d), 1);
 	if (irq == -EPROBE_DEFER)
 		return irq;
@@ -296,7 +289,6 @@ v3d_irq_init(struct v3d_dev *v3d)
 			goto fail;
 	}
 
-	v3d_irq_enable(v3d);
 	return 0;
 
 fail:
@@ -310,6 +302,11 @@ v3d_irq_enable(struct v3d_dev *v3d)
 {
 	int core;
 
+	/* Clear any pending interrupts someone might have left around for us. */
+	for (core = 0; core < v3d->cores; core++)
+		V3D_CORE_WRITE(core, V3D_CTL_INT_CLR, V3D_CORE_IRQS(v3d->ver));
+	V3D_WRITE(V3D_HUB_INT_CLR, V3D_HUB_IRQS(v3d->ver));
+
 	/* Enable our set of interrupts, masking out any others. */
 	for (core = 0; core < v3d->cores; core++) {
 		V3D_CORE_WRITE(core, V3D_CTL_INT_MSK_SET, ~V3D_CORE_IRQS(v3d->ver));

-- 
2.53.0

