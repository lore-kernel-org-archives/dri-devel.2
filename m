Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BE2CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C2C11A0C8;
	Thu,  4 Jun 2026 13:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kmBtSMop";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260A611A0CD
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:53:01 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490b09e4cccso6301215e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581180; x=1781185980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Un/RS4Nm0nYyy9KkMqgz4u8u1TfsaZHefTb9UE6rtQ=;
 b=kmBtSMopRvRvh6ZueRLPvwP3h1EzeMripx3AfiU7ZxpGF8mEHowDo2stqiyPdbOQ9V
 A9ZFthCVNy9af63ZcGB6E2OyFrOo5wWg2bYsbTVUKknn/7Nk+PJ9vGE0/Kwr910YxHDy
 ZvYOZrErPvPTN0nF/jqJbUdPfCuwDAo4PdpQgYlraPyI4NR46//ZtXwiGoxDtOqRxx3j
 fNHcIGZmQytlmALUb+PfwvdMQz5EN4PpyBUheIST8+KI+mX2wrhhDH7V+0pTmOb3nKfD
 69qD19eED26iH6FJsdUDnAYNK+Vo76Z7plmKwrK3s4L4py7Tg+TkYYeoCEUT+cDzt/gQ
 yxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581180; x=1781185980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Un/RS4Nm0nYyy9KkMqgz4u8u1TfsaZHefTb9UE6rtQ=;
 b=EChRs7kQChRTZav/hueIlmaFDzZWkIzrJYQ0gXCeqswnNjW8u/346WRPqwH4qNvVV7
 7K/H9Rsz3+V9ezDSm2uuCfsHp2eE0WyOeuoJE5IF83iFnVW8n2AqobuZECxtInWP/3Bd
 ATCyaLi1q2Rnc/BJgdwxFL92rTCxIWpc7L8vkAX8F+xLSW+HRJg3oMqlJ6bJdNmUytnP
 hoKRLInnQfuZ96p4Ci3jmaaePbd6k3+mueg4LB26rnBUqCoSLKpYaNEHLrgBFCgytdEz
 J/82exxBBUKbVI0ZgB8tXUfBmUtVReINmt0b0nzDjb5AfmlwaxOAqOedG7M82gW63au3
 3jbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Hw1tu2XOBR2FkmYaEX5gpJ7R5kS3Xfqq65NzvakNIo6Z5bBOLfoEYiJCBYl9/6Jeh36hHbL3TST4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwreoiMc7uL+Y03/VfunTEdvqFoXgUS7wRIH86czU10Ul0RcVAD
 YdUCpNLfGswdmYTdhY5pOaTdF1KoRGviC9oxo0cOnIsjECHk36Hch4Ug
X-Gm-Gg: Acq92OHQTFckIF2+bffzxlciZj8cax4H3nKYhpW0EaFp+MvVdhe/mnNf6XAIfJltT3p
 oEyG0Lv3CmtJ4xI/0S8kcAdLzhePMGtMetG0R3ZoX0FEU54UIW+tdssFECMJxYbNAEjk6UnikPW
 r++JIN+rxiSF+JbO8YohIfaKBmwa1RDYHl0akp/ryuhSkAkwYwPWc0qCPWwaBdxBIko+yvpcMaA
 LainS+OpaeAprrh+u+mriQ20JEAekOCVQE3z72dMbFpZftAK5Bh3EtvrhDHQrd2B0GfrJ1HYuTN
 tDRb6wlc7eF9aamHfBYC4GTBaer0zdIZE9l3Gnj1dYr9XMzHpcPrlrpskYHlX+PcRiQsnU1PWTs
 PJBJYTX4ioeCXQi3PKxyxqTVvN+AZ/4TAqbQCtCIJ8hMWCKIil9kZKhZvyRf2yYN9t8qSgxlJUS
 HVwIyyv0JrFJaspbCu3lueRF+piOKYgCFwPORb0CT1Om+YBO+hCO6OK6gJnjf1Wo8=
X-Received: by 2002:a05:600c:1551:b0:490:5466:8576 with SMTP id
 5b1f17b1804b1-490b5e9fca9mr132980675e9.1.1780581179316; 
 Thu, 04 Jun 2026 06:52:59 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:52:58 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org
Cc: robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/9] accel: rocket: Derive DMA width and core count
 from match data
Date: Thu,  4 Jun 2026 13:52:48 +0000
Message-Id: <20260604135255.62682-3-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
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

The probe already has the per-SoC match data, which now records the core
count and DMA width.  Use it for the cores array allocation and the
device DMA mask instead of re-scanning the device tree for available core
nodes.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.h   |  2 ++
 drivers/accel/rocket/rocket_device.c | 15 +++++----------
 drivers/accel/rocket/rocket_device.h |  3 ++-
 drivers/accel/rocket/rocket_drv.c    |  7 ++++++-
 4 files changed, 15 insertions(+), 12 deletions(-)

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
index 384c38e13acce..c18840e5aff76 100644
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
@@ -214,6 +218,7 @@ static void rocket_remove(struct platform_device *pdev)
 }
 
 static const struct rocket_soc_data rk3588_soc_data = {
+	.num_cores = 3,
 	.dma_bits = 40,
 };
 
-- 
2.39.5

