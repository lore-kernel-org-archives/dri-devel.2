Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7853FCD6E6D
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B993F11A0C1;
	Thu,  4 Jun 2026 13:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lZ5CMOi8";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8523B11A0C8
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:53:01 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-45ef372c58aso457932f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581180; x=1781185980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvTkXFm0z4CjuuOw/gsrhETvrrwMcV/B+e1Vnh/OZd8=;
 b=lZ5CMOi8SvpTBDk1J4+/azWj5KqDfWFB7+8yfTrdffrumItKPI1p2dLa/wBkT5RjCn
 wjETaZonLjBYOvuqnzELT5+y2SWjTU6j/4MSm2gAzsK5lMqj25ZrPAMFppNxmI+jlFWT
 MicYBm8FmBMyUxtNp4CxDYw47IGe5H0ivJRsxxS4tsHLbVYOTIDHf1GmHtNaC+yaChUK
 fxCRjM9g3oiMsFjCS8SMLuRxskItf9mzLvz//2Y2ON5MuAxACb2WQK+zFOW8UJ7mN5wW
 Wj+Y3YiP1g6BbLp8BA++gf1VsnNVVyaO0NDXM0FfHcL0UJLC4nXGA71GUFAOW+tXRH70
 2GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581180; x=1781185980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fvTkXFm0z4CjuuOw/gsrhETvrrwMcV/B+e1Vnh/OZd8=;
 b=UyNJAoDoWi6WSgLuq7/Ps/jIL95qjw73uYTPFtXxmRAyp1vxAwH8l1OgQtsKnzTwU1
 PsE9eqZC4Ys3FbMBaVmzGvdri50pStiwckVU5Am2qLy1Ed2pbxWNlJu7jUfKwIA+sidQ
 qWzwv9cLiktWXU74Lwzmj/Fqu7EvEQHUOYj3/9RcT8+OYqEdyK+gj1VVq3FwNbI3kcbW
 OWKyIYlwMbaqkZl28k1cPCgHHzLWs2ON3DLd1rGbVt73BoE6lMT0j1kcpTgrTnK8Sret
 MQgOl4idAZGVc1oLghVX9mY+1p3Ri7AK8OaswEcri9hsXvAfYL5QEpjrnvctn+ibz13Z
 o9ng==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MbilgV2MMVlR96DMqvvndskPwuaeegxRLX2sS9DKCUaF+OYFWxgbWhi+BwQvVcxNwSs3xwtmMTiw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyn1DOBRg4gLFGUIUo9uZ7TfmC3ZFC00DsMTJeDHYaMmWqVOd1F
 ZDDak4Ae48lrOaresMkCE9bNU68UYslc2sYOL9Ou/z4z1GXStskOaKU4
X-Gm-Gg: Acq92OEoxzwiJCPJTXJvrBqVPwgZY1C4KV6XVPLuhzcLjluzwOXT9bkB61qJfaF4vHu
 YqiXyaUGNWQgBGdXhXp+q6NtZn2mcWAF+CwWFxr7TdOzVsz2ntE02bA7jNIvN6zqy0W8U0UPzhf
 qMMwhHqvlRMJM3bX+61pg8XRrnnE+af+jTLnv4Fphpb4TNeyaDAQo5wzvggmbPs327MtsnUyIya
 VSWFLE0c12OnSjeN0KtyMYyjtret9vGSDGjxy3Orx7CDQEci0oZgV3L1naNRNZg/6ZZSVOjEyKW
 Fd/Z3cdjREjeG9W/WyART0B9dSj/iOUYUGcunhnSfNT4fKkDMBkFFtLoEEmG27vJ4wYsHRPJ238
 LjHmPnvAWpQ4sgI+fKT+RoLLRYQwF15RrbRrhTyBLRz6/QVEcxxinJP+OcfiK8Oy/fNVM0zz5XQ
 Vsawpm07tdwCPJzXmK2NR2RG+w8lLVaWvCs+Zg2N1rcLtYWgfiomkynce0cfO3B5c=
X-Received: by 2002:a05:6000:180a:b0:45e:d6b2:e6a5 with SMTP id
 ffacd0b85a97d-460218654afmr9596752f8f.34.1780581180021; 
 Thu, 04 Jun 2026 06:53:00 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:52:59 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org
Cc: robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 3/9] accel: rocket: Add RK3568 SoC support
Date: Thu,  4 Jun 2026 13:52:49 +0000
Message-Id: <20260604135255.62682-4-midgy971@gmail.com>
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

The RK3568 has a single core of the same NVDLA-derived NPU IP as the
RK3588, with a 32-bit AXI master.  Unlike the RK3588 it must be powered
on and de-idled through the PMU, and its PVTPLL clock started via SCMI,
before the NPU is reachable.  Add rk3568_soc_data with an noc_init
callback performing this bring-up.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.c |  9 +++++
 drivers/accel/rocket/rocket_core.h |  3 ++
 drivers/accel/rocket/rocket_drv.c  | 53 ++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 09c445af7de73..a8de876365873 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -88,6 +88,15 @@ int rocket_core_init(struct rocket_core *core)
 		return err;
 	}
 
+	if (core->soc_data->noc_init) {
+		err = core->soc_data->noc_init(core);
+		if (err) {
+			pm_runtime_put_sync(dev);
+			rocket_job_fini(core);
+			return err;
+		}
+	}
+
 	version = rocket_pc_readl(core, VERSION);
 	version += rocket_pc_readl(core, VERSION_NUM) & 0xffff;
 
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index d6421251670dc..66d138a8ed773 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -18,10 +18,13 @@ struct rocket_core;
  * struct rocket_soc_data - per-SoC configuration data
  * @num_cores: Number of NPU cores in this SoC.
  * @dma_bits: Physical address width reachable by the NPU's AXI master.
+ * @noc_init: Optional callback to power on and de-idle the NPU NOC bus.
+ *            Required on RK3568, where this is done through the PMU.
  */
 struct rocket_soc_data {
 	unsigned int num_cores;
 	unsigned int dma_bits;
+	int (*noc_init)(struct rocket_core *core);
 };
 
 #define rocket_pc_readl(core, reg) \
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index c18840e5aff76..5a72d0b5f4dff 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -9,9 +9,11 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/iommu.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 
 #include "rocket_device.h"
 #include "rocket_drv.h"
@@ -217,12 +219,63 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+/*
+ * On RK3568 the NPU NOC bus is gated and idle out of reset and must be
+ * powered on and de-idled through the PMU before the NPU is reachable.  PMU
+ * registers use a write-mask protocol: the upper 16 bits enable writes to the
+ * matching lower 16 bits.
+ *
+ * The NPU's high-speed clock is a PVTPLL managed by TF-A via SCMI and must be
+ * running before the NOC acknowledges the de-idle request.  Force a real SCMI
+ * rate change (an intermediate rate defeats the clock framework's
+ * unchanged-rate shortcut) now that the power domain is on and clocks enabled.
+ */
+#define ROCKET_RK3568_SCMI_CLK	2
+
+static int rk3568_noc_init(struct rocket_core *core)
+{
+	struct regmap *pmu;
+	unsigned int val;
+	int ret;
+
+	clk_set_rate(core->clks[ROCKET_RK3568_SCMI_CLK].clk, 600000000UL);
+	clk_set_rate(core->clks[ROCKET_RK3568_SCMI_CLK].clk, 1000000000UL);
+
+	pmu = syscon_regmap_lookup_by_phandle(core->dev->of_node, "rockchip,pmu");
+	if (IS_ERR(pmu))
+		return dev_err_probe(core->dev, PTR_ERR(pmu),
+				     "failed to get PMU regmap\n");
+
+	/* Power on the NPU power domain (PWR_GATE_SFTCON bit 1 = 0). */
+	regmap_write(pmu, 0xa0, BIT(1 + 16));
+
+	/* Disable NPU NOC auto-idle (NOC_AUTO_CON0 bit 2). */
+	regmap_write(pmu, 0x70, BIT(2 + 16));
+
+	/* Request NPU bus de-idle (BUS_IDLE_SFTCON0 bit 2 = 0). */
+	regmap_write(pmu, 0x50, BIT(2 + 16));
+
+	/* Wait for the bus to report active (BUS_IDLE_ST bit 2 = 0). */
+	ret = regmap_read_poll_timeout(pmu, 0x68, val, !(val & BIT(2)), 10, 1000);
+	if (ret)
+		dev_err(core->dev, "timed out waiting for NPU bus de-idle\n");
+
+	return ret;
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

