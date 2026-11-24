Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA7606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=SA9jgAhb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567DA10F763;
	Tue, 24 Nov 2026 15:55:10 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 191EC10F73D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:54:27 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261124155425euoutp029b1878de339f7089cbd4ab51f252cb92~rBizMiaVQ0854408544euoutp02R;
 Tue, 24 Nov 2026 15:54:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261124155425euoutp029b1878de339f7089cbd4ab51f252cb92~rBizMiaVQ0854408544euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795535665;
 bh=wxVxwW4jdJzT4Te1OnLBfSa/dsaxGf7BeuuwkSIg51g=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=SA9jgAhbaPcB3tmDwdcjaeIBjp7ZsdiDdx8T2hBJ1xe9yMvxacs67WoBj1/1XCvKF
 8IuTtDF08bi7eBDT4LeKEDaR3ZR2Jqee7BtUIeaxsg3sxSeVc5xRSeTj5FFCAQ2pJz
 UoUi8YgxDOl5Qlrx0i9itIymELsE+ULwfsH2JTps=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261124155425eucas1p2035620902a47a26cb56909c0afda250f~rBiy1PKgi0860908609eucas1p2H;
 Tue, 24 Nov 2026 15:54:25 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261124155423eusmtip197a3bda077f39cf190a2c55cf4457ba9~rBixEvKqb0174001740eusmtip1d;
 Tue, 24 Nov 2026 15:54:23 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 24 Nov 2026 16:52:50 +0100
Subject: [PATCH v8 14/18] soc: starfive: Add jh7110-hdmi-subsystem driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-jh7110-clean-send-v8-14-de92635dd857@samsung.com>
In-Reply-To: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Robert Foss
 <rfoss@kernel.org>,  Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Philipp Zabel
 <p.zabel@pengutronix.de>,  Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>, Heiko Stuebner <heiko@sntech.de>,  Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Andy Yan <andyshrk@163.com>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Yakir Yang
 <kuankuan.y@gmail.com>,  Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>,  Conor Dooley <conor@kernel.org>, William Qiu
 <william.qiu@starfivetech.com>,  Xingyu Wu <xingyu.wu@starfivetech.com>,
 Sandy Huang <hjc@rock-chips.com>,  Manivannan Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,  Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Graham Markall <hello@big-grey.co.uk>,  Icenowy
 Zheng <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>,  Byron Stanoszek <gandalf@winds.org>,
 Owen O'Hehir <oo.hehir@gmail.com>,  Conor Dooley
 <conor.dooley@microchip.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5258;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=Ke3a7wjCklbHNml6Zuxu85Xl5Ets0x2bOrRzbU3YliI=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWSzbha9/2DXh6YFaaFJsQ8Y7dZscN050eNQ3eeVV0M4q
 5cF5XJ96ihlYRDjYJAVU2Q5uzHaSPIfw9Py449/wcxhZQIZwsDFKQATec/P8E/JdUvcfXcWLjeG
 7LlKXEnb7sk8XW81I7uxvW9KhnygeivD/7B6p+/f4xIsf3Dc2bZVs19ypWtxTYiI9rdvenuushl
 6MQAA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261124155425eucas1p2035620902a47a26cb56909c0afda250f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261124155425eucas1p2035620902a47a26cb56909c0afda250f
X-EPHeader: CA
X-CMS-RootMailID: 20261124155425eucas1p2035620902a47a26cb56909c0afda250f
References: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
 <CGME20261124155425eucas1p2035620902a47a26cb56909c0afda250f@eucas1p2.samsung.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the parent driver for the monolithic JH7110 HDMI IP block.

This driver binds to the starfive,jh7110-hdmi-subsystem node. It maps the
shared register block, creates a regmap, and calls
devm_of_platform_populate() to create its hdmi_phy and hdmi_controller
child devices, which retrieve the shared regmap from this parent.

The NoC display bus clock and reset that gate access to this region, and
the PD_VOUT power domain it sits in, are held by the video output
subsystem parent for as long as this device exists, so there is nothing
for this driver to bring up itself.

Co-developed-by: Dominique Belhachemi <db@domibel.de>
Signed-off-by: Dominique Belhachemi <db@domibel.de>
Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Tested-by: Byron Stanoszek <gandalf@winds.org>
Tested-by: Owen O'Hehir <oo.hehir@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/soc/starfive/Kconfig                 | 18 +++++++
 drivers/soc/starfive/Makefile                |  1 +
 drivers/soc/starfive/jh7110-hdmi-subsystem.c | 72 ++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/drivers/soc/starfive/Kconfig b/drivers/soc/starfive/Kconfig
index 04b020083d3eecd7754bb2e2ec1b4fc8f525a344..e19994a212d4af49eaed595bab6fecc19677b2b3 100644
--- a/drivers/soc/starfive/Kconfig
+++ b/drivers/soc/starfive/Kconfig
@@ -3,4 +3,22 @@ menu "StarFive SoC (System On Chip) specific Drivers"
 
 source "drivers/soc/starfive/socinfo/Kconfig"
 
+config SOC_STARFIVE_JH7110_HDMI_SUBSYSTEM
+	tristate "StarFive JH7110 HDMI subsystem driver"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	depends on OF
+	select REGMAP_MMIO
+	help
+	  This option enables the parent driver
+	  for the monolithic StarFive JH7110 HDMI peripheral.
+
+	  The JH7110 HDMI IP block contains both the digital controller
+	  (DRM bridge) and the analog PHY (clock/phy provider) logic within
+	  a single shared register space.
+
+	  This driver acts as a wrapper. Its only job is to map the
+	  shared registers and create separate logical child devices
+	  for the "PHY" and the "controller", which have their own clocks
+	  and roles but share the register space.
+
 endmenu
diff --git a/drivers/soc/starfive/Makefile b/drivers/soc/starfive/Makefile
index ca1e609b81045f5e11daf249c116b22c8dc0e4d0..36fbb6f984986e4794ffb2c6c1485b6644efc4eb 100644
--- a/drivers/soc/starfive/Makefile
+++ b/drivers/soc/starfive/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += socinfo/
+obj-$(CONFIG_SOC_STARFIVE_JH7110_HDMI_SUBSYSTEM) += jh7110-hdmi-subsystem.o
diff --git a/drivers/soc/starfive/jh7110-hdmi-subsystem.c b/drivers/soc/starfive/jh7110-hdmi-subsystem.c
new file mode 100644
index 0000000000000000000000000000000000000000..b01dc66450f516599c013df0383e6fde987f390e
--- /dev/null
+++ b/drivers/soc/starfive/jh7110-hdmi-subsystem.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the StarFive JH7110 HDMI subsystem
+ *
+ * Copyright (c) 2025 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * This driver binds to the monolithic HDMI block and creates separate
+ * logical platform devices for the HDMI Controller (bridge) and the
+ * HDMI PHY (clock/phy provider), allowing them to share a single regmap.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+static const struct regmap_config starfive_hdmi_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.max_register = 0x3fff,
+};
+
+static int starfive_hdmi_subsys_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	void __iomem *regs;
+	int ret;
+
+	/*
+	 * The NoC display bus clock and reset that gate access to this region,
+	 * and the PD_VOUT power domain it sits in, are held by the video
+	 * output subsystem parent for as long as this device exists.
+	 */
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	regmap = devm_regmap_init_mmio(dev, regs,
+				       &starfive_hdmi_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to init shared regmap\n");
+
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to populate child devices\n");
+
+	return 0;
+}
+
+static const struct of_device_id starfive_hdmi_subsys_of_match[] = {
+	{ .compatible = "starfive,jh7110-hdmi-subsystem", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, starfive_hdmi_subsys_of_match);
+
+static struct platform_driver starfive_hdmi_subsys_driver = {
+	.probe = starfive_hdmi_subsys_probe,
+	.driver = {
+		.name = "starfive-hdmi-subsystem",
+		.of_match_table = starfive_hdmi_subsys_of_match,
+	},
+};
+module_platform_driver(starfive_hdmi_subsys_driver);
+
+MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
+MODULE_DESCRIPTION("StarFive JH7110 HDMI subsystem Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

