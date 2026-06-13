Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78404CD98D2
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 06:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B1410EC4D;
	Sat, 13 Jun 2026 06:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OQIdRfRN";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC6F610EC4D
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 06:58:25 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490aebf33e9so7629645e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781333904; x=1781938704; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eG0rTodn0DU81UbM7Y7nOdcQ/eVn9TOf7zlRSmencCY=;
 b=OQIdRfRNh7FddLN5ee/ssBcRcAlYXfKZp7djY7jgw1qdjcW2Vwi+RHwfvWM5jFzt5h
 UbucWSSBhJEVTunE+1rPAafoDxH2tpJ200Slcdz/5ayj0j9jJNkDNBh+dx00qJYDChyu
 zmfHjfKvwxB0CNdgC3NuQwAu5xnAchTB0SOAMKliih6z4+rXOWlRgDVuDTp4sj24xshn
 SPbOcwKBFmQnzfluc0xqR+CBSz+aYZIsw9qOdwW3FfH3CtDe3tdn1PZ8XBodL+JMvz4s
 rU2wYP9pg2cAh8VpCkJMuIiMq/ls/nENKqWnJ5sC5jxD8WxdMhwyeqGP/Qiu4ZaRPP1E
 0mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781333904; x=1781938704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eG0rTodn0DU81UbM7Y7nOdcQ/eVn9TOf7zlRSmencCY=;
 b=nh65jBu+sQd2twUWGRzEACWYUUVjSUBqSm4QQdsmi0QALKb0PlNjQmm31RKEnHyj+/
 HCVqUX6ZX3HtAIXZG3cjtRi4og6ZW+pBuv+GxIn7QXq89UfJufmPyICf/+DQ7M+VxqDk
 AGHxYOJl23BiTB39vIByzoTLTBbXyFEX5X1YWALVfr1M9cqJJFpKO+fQqMlSQC8MpIs6
 zLNPCg0mHZFIskJR0e4QZSLDM4hcvMQbp/LP4pV8pDvu8QRq+UrlHUO+eGoIh30ga1Xb
 VXqX8j5IgqDOEnCTaAbgL04ITtb90sN3iigYzBjnPBw5hD/Pu5Yt8C481U+gAcvEEDBt
 4nKA==
X-Gm-Message-State: AOJu0Yx6C0PkB03HgaXQf1lh8pukftd9Kgx+GKqVwkhmkHuGUrEkQsY7
 FhkUg674P9WAMekf6j2IENYuqSAVMtOzJ35eC7ukGvr4tTk978+WlR5G
X-Gm-Gg: Acq92OEjHCUyQjqJuGXJ6bb5ewJWNG0s0LZGDh6Wjm/sbCrVxplcbZhDaypeTlJ4czP
 mx5bDuJS4sSeVU/hfALbKC7wR1VMbeJyf2YQlXh5xFb8guaG89VQAQTEsb455JZX6zqcTRimqZc
 C+ueDQaMYN1uQn3OEu8BdpVH5cXWjjCDj4vN0rwV8EQTmpowsd1KF6oAjkXMFYiwEhWbItsHs5y
 rQlZaF8b/q8J1WqoIbhZ2sWVWNzdjImREAbm89MpcblqtqzdUbM+h6rY9JyIrd9uQyfMFpTBH9E
 R2CV5WdO0hb1Tw0hd0GrBFBYy4uN5fx9M4FDXRhpM4bzkMEzvvjGq9b6MaiQhvNMW/8Dvt6rTrC
 uRwSUthHdIDx/yusUE2gilTS8rWsfECjjkNx9TWzMsIdbG2xnYg+VfJwUvJSJQzsSXwQ9P/dBl/
 1YAWuXyOLmZ1xcpLGRW9jlRDCXsakvMrpySv8K/BjnYg==
X-Received: by 2002:a05:600c:820c:b0:490:45bb:8dd9 with SMTP id
 5b1f17b1804b1-490ec4cde5bmr72801305e9.8.1781333904245; 
 Fri, 12 Jun 2026 23:58:24 -0700 (PDT)
Received: from debian.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 23:58:23 -0700 (PDT)
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
Subject: [RFC PATCH v4 1/9] accel: rocket: Introduce per-SoC rocket_soc_data
Date: Sat, 13 Jun 2026 09:01:08 +0200
Message-Id: <20260613070116.438906-2-midgy971@gmail.com>
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

Add a per-SoC data structure carried in the OF match table, currently
holding only the NPU AXI address width, and use it for the per-core DMA
mask instead of a hardcoded 40-bit value.  No functional change: the
RK3588 AXI master is 40-bit.  This prepares for SoCs with a narrower
address width.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.c |  7 ++++++-
 drivers/accel/rocket/rocket_core.h | 11 +++++++++++
 drivers/accel/rocket/rocket_drv.c  |  6 +++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b3b2fa9ba645a..09c445af7de73 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/iommu.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -21,6 +22,10 @@ int rocket_core_init(struct rocket_core *core)
 	u32 version;
 	int err = 0;
 
+	core->soc_data = of_device_get_match_data(dev);
+	if (!core->soc_data)
+		return dev_err_probe(dev, -EINVAL, "missing SoC match data\n");
+
 	core->resets[0].id = "srst_a";
 	core->resets[1].id = "srst_h";
 	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(core->resets),
@@ -52,7 +57,7 @@ int rocket_core_init(struct rocket_core *core)
 
 	dma_set_max_seg_size(dev, UINT_MAX);
 
-	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(core->soc_data->dma_bits));
 	if (err)
 		return err;
 
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d7382854ca9..8ee105a0be40e 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -12,6 +12,16 @@
 
 #include "rocket_registers.h"
 
+struct rocket_core;
+
+/**
+ * struct rocket_soc_data - per-SoC configuration data
+ * @dma_bits: Physical address width reachable by the NPU's AXI master.
+ */
+struct rocket_soc_data {
+	unsigned int dma_bits;
+};
+
 #define rocket_pc_readl(core, reg) \
 	readl((core)->pc_iomem + (REG_PC_##reg))
 #define rocket_pc_writel(core, reg, value) \
@@ -31,6 +41,7 @@ struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
 	unsigned int index;
+	const struct rocket_soc_data *soc_data;
 
 	int irq;
 	void __iomem *pc_iomem;
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594883e..384c38e13acce 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -213,8 +213,12 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+static const struct rocket_soc_data rk3588_soc_data = {
+	.dma_bits = 40,
+};
+
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "rockchip,rk3588-rknn-core" },
+	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.39.5

