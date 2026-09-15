Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD848C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2CDD10F882;
	Tue, 15 Sep 2026 15:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="dS1E0sBa";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE6A10EC77
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:32:38 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260915153237euoutp021f898f945810932a29bcdaec616822bd~ViFxttyFk0389103891euoutp02W;
 Tue, 15 Sep 2026 15:32:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260915153237euoutp021f898f945810932a29bcdaec616822bd~ViFxttyFk0389103891euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789486357;
 bh=q9+/6FCnUTxlS3RGu5OA+lvly9b9O4D2U3b+XpBHAXw=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=dS1E0sBaqIkVPV0YbtY8yPaMqLqQBX0hf/UdXoLcmYzUgNwmT+VOzU0b7El72nRCW
 q1wRWGZQXJtHF/p9wkXyKXbybQm1660zOi5RLzJjsvqMHGUv7MjGg3JQXzVUzcNqpd
 uewIrUYdlQ8ej/Iv0D1qhrNfN7R9lYSo+bH1M4SU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260915153236eucas1p1712930425e569f894c870299f245e99f~ViFw6KHiz1408514085eucas1p1R;
 Tue, 15 Sep 2026 15:32:36 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260915153234eusmtip137e58b559923b6dba9493d40b872a270~ViFvSgyWa0441604416eusmtip1n;
 Tue, 15 Sep 2026 15:32:34 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 15 Sep 2026 17:32:21 +0200
Subject: [PATCH v4 13/20] soc: starfive: Add jh7110-vout-subsystem driver
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-jh7110-clean-send-v4-13-f0e4fd6f2cc8@samsung.com>
In-Reply-To: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
To: Vinod Koul <vkoul@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>,  Robert Foss <rfoss@kernel.org>,  Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>,  Philipp Zabel <p.zabel@pengutronix.de>, 
 Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>,  Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,  Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,  Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org,  Marek Szyprowski
 <m.szyprowski@samsung.com>,  Maud Spierings <maud_spierings@murena.io>, 
 Graham Markall <hello@big-grey.co.uk>,  Icenowy Zheng
 <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260915153236eucas1p1712930425e569f894c870299f245e99f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260915153236eucas1p1712930425e569f894c870299f245e99f
X-EPHeader: CA
X-CMS-RootMailID: 20260915153236eucas1p1712930425e569f894c870299f245e99f
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153236eucas1p1712930425e569f894c870299f245e99f@eucas1p1.samsung.com>
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

Nothing in the video output subsystem can reach its own registers until
the NoC display bus clock and reset are up and PD_VOUT is powered, and
those are shared by every device in the region. Leaving them to whichever
consumer probes first works by accident and stops working as soon as the
probe order changes.

Add a driver for the subsystem node that takes the bus clock and reset,
holds a runtime PM reference so genpd keeps PD_VOUT powered, and then
populates its children. All three are released only once the last child
is gone.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/soc/starfive/Kconfig                 | 15 +++++
 drivers/soc/starfive/Makefile                |  1 +
 drivers/soc/starfive/jh7110-vout-subsystem.c | 82 ++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/drivers/soc/starfive/Kconfig b/drivers/soc/starfive/Kconfig
index e738638ab0f755fbbabca259264abb56f3b6101f..cf5e626b8a39a75768917eee188a79256b36f1aa 100644
--- a/drivers/soc/starfive/Kconfig
+++ b/drivers/soc/starfive/Kconfig
@@ -6,6 +6,21 @@
 if ARCH_STARFIVE || COMPILE_TEST
 menu "Starfive SoC drivers"
 
+config SOC_STARFIVE_JH7110_VOUT_SUBSYSTEM
+	tristate "StarFive JH7110 video output subsystem driver"
+	depends on OF
+	select PM
+	help
+	  This option enables the parent driver for the StarFive JH7110
+	  video output subsystem, which the documentation calls dom_vout_top.
+
+	  The subsystem covers the DC8200 display controller, the HDMI
+	  transmitter, the video output clock generator and the video output
+	  system controller. They share one NoC port whose clock and reset
+	  gate access to the whole register region, and the region sits in
+	  the PD_VOUT power domain. This driver owns those resources and
+	  holds them for as long as any of its children exist.
+
 config SOC_STARFIVE_JH7110_HDMI_SUBSYSTEM
 	tristate "StarFive JH7110 HDMI subsystem driver"
 	depends on OF
diff --git a/drivers/soc/starfive/Makefile b/drivers/soc/starfive/Makefile
index be89d8119212b7a7038817c2f0e8eac1984ada88..6c229020c1e563b37df43f6ac1665465a11333cc 100644
--- a/drivers/soc/starfive/Makefile
+++ b/drivers/soc/starfive/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_SOC_STARFIVE_JH7110_HDMI_SUBSYSTEM) += jh7110-hdmi-subsystem.o
+obj-$(CONFIG_SOC_STARFIVE_JH7110_VOUT_SUBSYSTEM) += jh7110-vout-subsystem.o
diff --git a/drivers/soc/starfive/jh7110-vout-subsystem.c b/drivers/soc/starfive/jh7110-vout-subsystem.c
new file mode 100644
index 0000000000000000000000000000000000000000..af632692e2139d9d07edd478a299b170ad1b7104
--- /dev/null
+++ b/drivers/soc/starfive/jh7110-vout-subsystem.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the StarFive JH7110 video output subsystem
+ *
+ * Copyright (c) 2025 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * The display hardware sits behind a single NoC port whose clock and reset
+ * gate access to every register in the region, inside the PD_VOUT power
+ * domain. Nothing below this node can reach its own registers until all three
+ * are up, so bring them up here and hold them for as long as any child device
+ * exists, rather than leaving them to whichever consumer happens to probe
+ * first.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+static void jh7110_vout_subsys_pm_put(void *data)
+{
+	pm_runtime_put_sync(data);
+}
+
+static int jh7110_vout_subsys_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct reset_control *bus_rst;
+	struct clk *bus_clk;
+	int ret;
+
+	/*
+	 * Take a runtime PM reference for the lifetime of this device. genpd
+	 * only keeps PD_VOUT powered while something actually holds it, and
+	 * an unclocked or unpowered access to this region wedges the bus.
+	 */
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to power on PD_VOUT\n");
+
+	ret = devm_add_action_or_reset(dev, jh7110_vout_subsys_pm_put, dev);
+	if (ret)
+		return ret;
+
+	bus_clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(bus_clk))
+		return dev_err_probe(dev, PTR_ERR(bus_clk),
+				     "Failed to enable NoC bus clock\n");
+
+	bus_rst = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(bus_rst))
+		return dev_err_probe(dev, PTR_ERR(bus_rst),
+				     "Failed to deassert NoC bus reset\n");
+
+	return devm_of_platform_populate(dev);
+}
+
+static const struct of_device_id jh7110_vout_subsys_of_match[] = {
+	{ .compatible = "starfive,jh7110-vout-subsystem", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh7110_vout_subsys_of_match);
+
+static struct platform_driver jh7110_vout_subsys_driver = {
+	.probe = jh7110_vout_subsys_probe,
+	.driver = {
+		.name = "jh7110-vout-subsystem",
+		.of_match_table = jh7110_vout_subsys_of_match,
+	},
+};
+module_platform_driver(jh7110_vout_subsys_driver);
+
+MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
+MODULE_DESCRIPTION("StarFive JH7110 video output subsystem driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

