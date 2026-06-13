Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EFBCD8CA8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 06:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE12B10EC50;
	Sat, 13 Jun 2026 06:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vsusf3gC";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D15DA10EC74
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 06:58:29 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso12836945e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 23:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781333908; x=1781938708; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRmyPRAFuevqTsUvI5TWwwBpkZJdoLOQStZBNs50ckM=;
 b=Vsusf3gClrvG+v/TO9M3iVEGlT+rQeXCTSgSfz9XuP8FZYCcffWdIeFwGRZlGz/6N2
 /9o+Y0Cz5etEpIl4W057iibFciio1XHSPm6ItjFf7yEbHg8cKLvg0Zqd73QbAbahu7J7
 koqbgNIARNTABGs3R41jBkVT48mUsba2IRPH4Tsc17/V0976Y9uLcvBh0Foi4Emrj7RF
 tXdm2b6jT6I4K8j8SbG7D09LG4PslVZro2IJIujRPZsU4cora+/J+KOWE1G/xiPwiZCy
 2m2dpV38pn4GTpitGDa3PYWnV4rwYIuAt/I9FMSIZ+bYc8CB/cn/p4lB3DCkVTYPWgPr
 d+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781333908; x=1781938708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CRmyPRAFuevqTsUvI5TWwwBpkZJdoLOQStZBNs50ckM=;
 b=SLGQz7k9fRP5Gqn1ze3Vm6F3z/T66V94OKl7Lw1QF27SMaAylW71ihv5IOpTFN/PN5
 s4tgxuX+CpVlBrkLQCm2L6/d/OtFlqEFyU/umbwb8KheeB86B0KfFi20eImFHyIPJFeK
 p4Td1psNksz13ofiPaakh3hZkV7bIMBBbgR3Aw1BIlHH5g8RZwzZapvgAVft2US3XU2Y
 /DlsJHulxyAjy39DbJI6scSDvrxRI9aeACbDVBS0FypeWNZ/tCOW+NsdF0ZZpE00zerC
 6St6ir9XmJEPtaRP157GAJFOrK/Ab4HUQitM1Bas9+2hziYPrQxnm0uCS741Rzyr7PMV
 VZEA==
X-Gm-Message-State: AOJu0Yxo0+X+Hmzv7icB55UlQQ8bTBVc0lFuWiI+blfVXifx/tOp+B7R
 vxUW6XCM5j+uLnxsb9m6yj0LQSHLbjr8fYlwohgUwC43dhKVOb7H/yl7
X-Gm-Gg: Acq92OG0edTOU0mxzSCnBGcc6M9XMhxv2qmm1J9+GO/HPuZBFEeA0PNt+Xac2dPH5tD
 LCFuHd7ps5UUPITfOR13//T+OoFurBtEKDeWAsOQ20Cpt//PK8saMzWMJIfWxh4Np/zwBfKcy5r
 HjKUn1bT87Z+ou/aCkNSMUbnYN9Nwxh/iwFXvle37S25dTV9lNjcEyzK5M/a4UCIlyJIzj2A5au
 OV5Vz+h0dHuL5+Tso8Abd629DiJoB+sgmbcCH54IfmI4iWinJjIGeMSbYHJVqkWxfZ3eHwmcnhP
 6WZcerWbyJdY2h+n/p2/LMmnTA3DIuwm2kxrOAXQwdhXd7QNvU7Dsc7O/N+V5voodLQ3RmhbiTr
 3cYEeP7nViKoOk4Xa56C9FXZsW8BNDBS2X56MciojBzrj+hklxi0ZFNW/L8DjCIFYe/gL5NeHun
 JZzNQRjPCactDTNMzCI/c6viEvc6KkbgkPIE5no7FDJA==
X-Received: by 2002:a05:600d:8489:20b0:490:b724:507d with SMTP id
 5b1f17b1804b1-490ec4cec11mr54479185e9.11.1781333908035; 
 Fri, 12 Jun 2026 23:58:28 -0700 (PDT)
Received: from debian.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 23:58:27 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, xxm@rock-chips.com,
 chaoyi.chen@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, jonas@kwiboo.se, Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 2/9] accel: rocket: Derive DMA width and core count
 from match data
Date: Sat, 13 Jun 2026 09:01:09 +0200
Message-Id: <20260613070116.438906-3-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
MIME-Version: 1.0
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

From: Midgy BALON <midgy971@gmail.com>

The probe already has the per-SoC match data, which now records the core
count and DMA width.  Use it for the cores array allocation and the
device DMA mask instead of re-scanning the device tree for available core
nodes.

While at it, reject a device tree that declares more NPU core nodes than
the SoC has, so the fixed-size cores array can never be overrun.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.h   |  2 ++
 drivers/accel/rocket/rocket_device.c | 15 +++++----------
 drivers/accel/rocket/rocket_device.h |  3 ++-
 drivers/accel/rocket/rocket_drv.c    | 13 ++++++++++++-
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index 8ee105a0be40e..d6421251670dc 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -16,9 +16,11 @@ struct rocket_core;
 
 /**
  * struct rocket_soc_data - per-SoC configuration data
+ * @num_cores: Number of NPU cores in this SoC.
  * @dma_bits: Physical address width reachable by the NPU's AXI master.
  */
 struct rocket_soc_data {
+	unsigned int num_cores;
 	unsigned int dma_bits;
 };
 
diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index 46e6ee1e72c5f..6186f4faa3a2a 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -6,18 +6,16 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
-#include <linux/of.h>
 
 #include "rocket_device.h"
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
-					 const struct drm_driver *rocket_drm_driver)
+					 const struct drm_driver *rocket_drm_driver,
+					 const struct rocket_soc_data *soc_data)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *core_node;
 	struct rocket_device *rdev;
 	struct drm_device *ddev;
-	unsigned int num_cores = 0;
 	int err;
 
 	rdev = devm_drm_dev_alloc(dev, rocket_drm_driver, struct rocket_device, ddev);
@@ -27,17 +25,14 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 	ddev = &rdev->ddev;
 	dev_set_drvdata(dev, rdev);
 
-	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
-		if (of_device_is_available(core_node))
-			num_cores++;
-
-	rdev->cores = devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_KERNEL);
+	rdev->cores = devm_kcalloc(dev, soc_data->num_cores, sizeof(*rdev->cores),
+				   GFP_KERNEL);
 	if (!rdev->cores)
 		return ERR_PTR(-ENOMEM);
 
 	dma_set_max_seg_size(dev, UINT_MAX);
 
-	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(soc_data->dma_bits));
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
index ce662abc01d3d..2f74e078974e3 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -22,7 +22,8 @@ struct rocket_device {
 };
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
-					 const struct drm_driver *rocket_drm_driver);
+					 const struct drm_driver *rocket_drm_driver,
+					 const struct rocket_soc_data *soc_data);
 void rocket_device_fini(struct rocket_device *rdev);
 #define to_rocket_device(drm_dev) \
 	((struct rocket_device *)(container_of((drm_dev), struct rocket_device, ddev)))
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 384c38e13acce..f0beed2d522c7 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -159,11 +159,15 @@ static const struct drm_driver rocket_drm_driver = {
 
 static int rocket_probe(struct platform_device *pdev)
 {
+	const struct rocket_soc_data *soc_data = of_device_get_match_data(&pdev->dev);
 	int ret;
 
+	if (!soc_data)
+		return -EINVAL;
+
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
-		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
+		rdev = rocket_device_init(drm_dev, &rocket_drm_driver, soc_data);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "failed to initialize rocket device\n");
 			return PTR_ERR(rdev);
@@ -172,6 +176,12 @@ static int rocket_probe(struct platform_device *pdev)
 
 	unsigned int core = rdev->num_cores;
 
+	if (core >= soc_data->num_cores) {
+		dev_err(&pdev->dev, "too many NPU core nodes (max %u)\n",
+			soc_data->num_cores);
+		return -EINVAL;
+	}
+
 	dev_set_drvdata(&pdev->dev, rdev);
 
 	rdev->cores[core].rdev = rdev;
@@ -214,6 +224,7 @@ static void rocket_remove(struct platform_device *pdev)
 }
 
 static const struct rocket_soc_data rk3588_soc_data = {
+	.num_cores = 3,
 	.dma_bits = 40,
 };
 
-- 
2.39.5

