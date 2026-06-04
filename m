Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4336FCD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C73911A0CD;
	Thu,  4 Jun 2026 13:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ortzyeqv";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A8011A0C8
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:52:59 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45fe59255beso375000f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581178; x=1781185978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoHc1Zlbr3pNOE70Y4k5QiMyrmoz//QwwHMvtTDGYPc=;
 b=ortzyeqvkWH8oTMLJR2xb7sdZZ/1LD5IR1ewjQTD3KUrmT8KhRoL1pVLYK+3YUHXFZ
 P1vVJRykeoDG1WZV2XB+Q5jSfPOdBmitijGNO6vfzSrvDG7qK/LY4F4CMFO0IM8Xqgp0
 c5V5YfgRFqwtVkP8+5Auq1he/34R+9QvRXuhFCncTtqjRrHrZgmHj2ovgYhU0Aa4VhzU
 B0PKsUW1ALCefhodn2lMC+EHsL8dtP2E1VcnRWRFvq2yIxubpXwSb5lfvx55GrJF8aM1
 anfhbuMMD1+8y70f6GtFkdZxfBidLDb+NzTR3OKQ2MenEQ34rtC4jLQqvtm2AaeAsEb5
 6BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581178; x=1781185978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CoHc1Zlbr3pNOE70Y4k5QiMyrmoz//QwwHMvtTDGYPc=;
 b=D3c5JLY24Yq/69BseWRFB7U2OUZ2TD649w5mwlWcXbVD7BMNtFMZxCq/EowfcecsJy
 4PZer8oq+a0Bddk9yLk8BaQdNwr074Zqz0Nu0Jnz7K8BhIAMBCMLEz3DubshpptjMKU3
 YFEwFY2me9tr7ydawdZi6FDy/9mkc5IzfjZ2nlz7FaDfWbSKGQvPprh/tHp2pkcDViIl
 Asc8TmXNNmluWS02dm62AalFLDhyefajiQNTy22YEyIJLtwUzH0KGsAj0H+zvlXbjcRR
 xSHkxf0Ax9pqUFh+AwNCfqO5UtkZRyGfLb5RJRhpvVeFAYyRBraNqz3OwjUWzSDhWn5Y
 Pdag==
X-Forwarded-Encrypted: i=1;
 AFNElJ95Ar+jD0MZvhMFcsBLHm2wAhtBEyJwrxxO6J+yQxUovUn3+J2CRfpiml++ipwU5c9YxiynUZXP/yk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxa9LoTBpYcFdX7njiQsDoZVTzzBp03SSDOIGlTXIo00oLXVBN9
 2i1FScu9b1/XBrpoYmiEeePh8YQnQp/MgZSSLngtF5DclvYh+Ss76JQ1
X-Gm-Gg: Acq92OEU5BLzdiFt1Cr/UWIwJyOs+P93Xk/x2z7qv/QWVmUur0zaX4IDct/YqURIjPZ
 GKA2fgSD7jD4ZLHMBL3bP+M+mktSjQXla4dBU99DngagK9JNMlc9jF6UA6aWLpF1IWQjdftoK4n
 vKkoTSMVj9zxha7bWds6y34NhkgagTVVOyyoB4lIZBFPj90Eu0zSBf8CjR/1s7doPRf9tQFhyTl
 IuYHe+weMjFn2ggLYbHnbM4YYyc/SZwIqpnCCbvo5dOW4DT51yU0K7Be2glBNipyCZOdWX9lIxv
 ema81RSp+KJHPpdMWc5ZVD4ifSYf9fSJDZ59UboPtFaWvn/YasKTuW6osJWMSy1T9PPykxXH4aV
 gDP1UckmYu/MJIAO2+DJGFJdVITrMSP5WB6NEtHwQzlsH7zXkg9fDxilapH6iawzdd6zwjRFwv6
 80asIYn8WO7YXA7vpZe2sSWi4HQ7TGeIivJK5pJVGHqYbyCEWOEa/X5ZVDwqGN/xk=
X-Received: by 2002:adf:f8c4:0:b0:460:e0f:8d19 with SMTP id
 ffacd0b85a97d-4602179121cmr10232727f8f.9.1780581177846; 
 Thu, 04 Jun 2026 06:52:57 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:52:57 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org
Cc: robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/9] accel: rocket: Introduce per-SoC rocket_soc_data
Date: Thu,  4 Jun 2026 13:52:47 +0000
Message-Id: <20260604135255.62682-2-midgy971@gmail.com>
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

