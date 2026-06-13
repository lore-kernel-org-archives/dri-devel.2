Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FF9CD8CA8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 06:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DC510EC8C;
	Sat, 13 Jun 2026 06:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mDMrAue4";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAAC310EC8C
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 06:58:33 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490aaeabdb4so11009305e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781333912; x=1781938712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9lCT5hFuQlBjQqDnDlpEFs50IBGKZjmVIr8JFjJQzU=;
 b=mDMrAue41w0afDP6q6FI9cGsyi0Oo5Xtx0vtRJrHf1iJ6Ob7sYtF60RLQcPp9XzrQF
 jbbn2w+v72BG2EOoeVlCLN92QOURXm0z8nhg25XLeMaD/W1NAeQjLhxyHbishEqMyAQ6
 EqSNGWx1/uCHX0XjVOm+uyM5R+Uzx4BrjpQOdc4U7hIiHT7miJyRx03NByTnldPEpxyS
 XpWuTQN+qYOOOCBz0aRCXGnMgF02pqtetoIiDy/A1biO9ttlyNarbphG7qfh2CZHqq8Z
 MSS7iq8FmfpWbr7FszNRd1hfwvLZfHFQNevQMvABxKjljr4R4Bzg44GhKfRUkT2QMzyM
 FuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781333912; x=1781938712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q9lCT5hFuQlBjQqDnDlpEFs50IBGKZjmVIr8JFjJQzU=;
 b=TbmkAG8WjLixePRspXebN456jpqgRpu7Dhp/ayzX3tUU3w4coO5n/5RdKHmKGzby1b
 rr8wJEBqviPGzOR7AkSxBlpgVw2BTjML8M7kyHY4IDvLDJC/sL2Cs3KpG2wbTJ6sNvsv
 kI7yU9zPFQNSS6LZM3w80zHoc0s5t9QzsTuQJOsgX19wie7gbz1NOH3B26jdEVlKAc9m
 tPyCumQZymELGYRDtNjN+n2EN8T42QPPnUig967XsV1ThPktcFXPAfXZ+hxNK/eo47S2
 85EL3thE6XURbq8uOgWq3r25AchOqu5zfOL6b7g8AGzwImvG35p13kLVdtM/zB8ZCSEz
 Qi0Q==
X-Gm-Message-State: AOJu0YxjMoZOU483q1OEoKyyj2e8EiQRwPewrsGmTHOBhYsoORRjCccV
 6bEj9HVml9REu+d2httxpCcqBw7LTekOnNl52i3gv8ZjJx7/lsEQU+wJ
X-Gm-Gg: Acq92OGZVEC2MDzCwsPHNtgXKq+2FHoQekRWjotr4wu0OyxYGmuZsTzpOpe6JVsgfM9
 M125Lz8ES1RzvVyacux9y9u9yEKE8K2JrJ3hyU5jRrwmFSPFsQopBfrjYmSG3YsQSMphaP1WHNW
 E9owX7RcTJgXQJCy99ckOvU7LzWgMJQAcmg3DGkzEMvLbqnMAGA8+4gND35N3y+G9vJVnwX7wE7
 L4XhGTWgSwmqKYlGlBnj5IHeOCaC1VUaH6lJrydCNqkgeWj0BTjmBI5qVdoH7a6168oQ2S99l/j
 w38XTZoxVzbRPS1Huq3941iTHZtKYvowj6g4dWVi4Eu3Qz/YIeXwLbj+ZQJ71VDm7f3PfRvoTGN
 Mw5OsH8sDzwp1akfE8adcE8F6SyPVR/I8EBAhCyqnERqVWkLH7Hl6t6fn9lSArLIrdu9MduRovH
 ujQ12FnpYfiTK5MRmHbPFIPLTZ575x2XcvAJeM7S19qvKJ3CFbkaTZ
X-Received: by 2002:a05:600c:4709:b0:490:5057:f5f7 with SMTP id
 5b1f17b1804b1-4922007472cmr28836405e9.11.1781333912286; 
 Fri, 12 Jun 2026 23:58:32 -0700 (PDT)
Received: from debian.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 23:58:31 -0700 (PDT)
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
Subject: [RFC PATCH v4 3/9] accel: rocket: Add RK3568 SoC support
Date: Sat, 13 Jun 2026 09:01:10 +0200
Message-Id: <20260613070116.438906-4-midgy971@gmail.com>
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

The RK3568 has a single core of the same NVDLA-derived NPU IP as the
RK3588, with a 32-bit AXI master.  Add rk3568_soc_data and its
compatible.

Unlike the RK3588, the RK3568 NPU's compute clock is a PVTPLL managed by
TF-A via SCMI; start it from an noc_init callback with a real rate change
(an intermediate rate defeats the clock framework's unchanged-rate
shortcut).  Powering on and de-idling the NPU NoC are left to the power
domain (genpd), which performs them when the IOMMU supplier is resumed,
so the driver does not poke the PMU directly.

If noc_init fails, unwind through rocket_core_fini() so the core is torn
down completely rather than leaking the runtime-PM and IOMMU state.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.c |  9 +++++++++
 drivers/accel/rocket/rocket_core.h |  3 +++
 drivers/accel/rocket/rocket_drv.c  | 31 ++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 09c445af7de73..779e951596a15 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -88,6 +88,15 @@ int rocket_core_init(struct rocket_core *core)
 		return err;
 	}
 
+	if (core->soc_data->noc_init) {
+		err = core->soc_data->noc_init(core);
+		if (err) {
+			pm_runtime_put_sync(dev);
+			rocket_core_fini(core);
+			return err;
+		}
+	}
+
 	version = rocket_pc_readl(core, VERSION);
 	version += rocket_pc_readl(core, VERSION_NUM) & 0xffff;
 
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index d6421251670dc..5a145ba8c5a92 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -18,10 +18,13 @@ struct rocket_core;
  * struct rocket_soc_data - per-SoC configuration data
  * @num_cores: Number of NPU cores in this SoC.
  * @dma_bits: Physical address width reachable by the NPU's AXI master.
+ * @noc_init: Optional callback to bring up the NPU before it is reachable.
+ *            Used on RK3568 to start the PVTPLL compute clock via SCMI.
  */
 struct rocket_soc_data {
 	unsigned int num_cores;
 	unsigned int dma_bits;
+	int (*noc_init)(struct rocket_core *core);
 };
 
 #define rocket_pc_readl(core, reg) \
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index f0beed2d522c7..86484110ad6f0 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/iommu.h>
 #include <linux/of.h>
+#include <linux/of_clk.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -223,12 +224,42 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+/*
+ * The NPU compute clock is a PVTPLL managed by TF-A via SCMI; spin it up
+ * with a real rate change (an intermediate rate defeats the clock
+ * framework's unchanged-rate shortcut).  Powering on and de-idling the NPU
+ * NoC are handled by the power domain (genpd) before the NPU is accessed.
+ */
+static int rk3568_noc_init(struct rocket_core *core)
+{
+	struct clk *npu_clk;
+
+	npu_clk = of_clk_get_by_name(core->dev->of_node, "npu");
+	if (IS_ERR(npu_clk))
+		return dev_err_probe(core->dev, PTR_ERR(npu_clk),
+				     "failed to get the NPU SCMI clock\n");
+
+	if (clk_set_rate(npu_clk, 600000000UL) ||
+	    clk_set_rate(npu_clk, 1000000000UL))
+		dev_warn(core->dev, "failed to set the NPU compute clock rate\n");
+	clk_put(npu_clk);
+
+	return 0;
+}
+
+static const struct rocket_soc_data rk3568_soc_data = {
+	.num_cores = 1,
+	.dma_bits = 32,
+	.noc_init = rk3568_noc_init,
+};
+
 static const struct rocket_soc_data rk3588_soc_data = {
 	.num_cores = 3,
 	.dma_bits = 40,
 };
 
 static const struct of_device_id dt_match[] = {
+	{ .compatible = "rockchip,rk3568-rknn-core", .data = &rk3568_soc_data },
 	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
 	{}
 };
-- 
2.39.5

