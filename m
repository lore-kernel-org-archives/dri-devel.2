Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937EA606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=N+SKx5Bw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4EBE11200E;
	Thu, 29 Oct 2026 07:55:00 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB6D910E7A6
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:54:21 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261029075420euoutp0247b5c5649f2dfd54d1d39e855fd6ad54~i8ONRPs7u1871618716euoutp02z;
 Thu, 29 Oct 2026 07:54:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261029075420euoutp0247b5c5649f2dfd54d1d39e855fd6ad54~i8ONRPs7u1871618716euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793260460;
 bh=2MNtI5LcQWip3dRXcSFWeBcfEKf2OS7roBnjVNO3Ghg=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=N+SKx5BwjunrV7kw+IhsfW8ovLcClXj2JNOdD5PyfyWnWpdhXP3I3mguKWsIMXTIU
 n4mtJNKsp0yC+wxAWZhUqWakKvquOamPl5LViedj/9EEtc/Kk+iIHdmjGJkr1fdde+
 wkTGksPgVIg8mv1A9qavQ6hSi0vb/LiHct8IhEvQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261029075420eucas1p1fd7d94e680ce387882517681fc6e0433~i8OM3pb5X1652316523eucas1p1e;
 Thu, 29 Oct 2026 07:54:20 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261029075417eusmtip1d035b14233a285bf044081cf69bb5d35~i8OKCRqt71493914939eusmtip1a;
 Thu, 29 Oct 2026 07:54:17 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 29 Oct 2026 08:53:49 +0100
Subject: [PATCH v6 15/18] soc: starfive: Add jh7110-vout-subsystem driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-jh7110-clean-send-v6-15-759594e43acf@samsung.com>
In-Reply-To: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman <jonas@kwiboo.se>,
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
 <u.kleine-koenig@baylibre.com>,  Byron Stanoszek <gandalf@winds.org>,
 OOHehir <oo.hehir@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5573;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=DsbatnDU6gGFABaruczZr34WTtjEI8r2rbI74wlszvs=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWQ9+t2jYBB47zev0cz9bVydS6y3Mc549N47QPZXqUuWT
 P0njj3yHaUsDGIcDLJiiixnN0YbSf5jeFp+/PEvmDmsTCBDGLg4BWAi290ZGbbYLL9kee11WusJ
 F3+tp3brPxnP3pLKtz7+7ofkc317E6Yz/OFub2rnEWwxbHWu1NjLNMPC4pD3M9dnJ0yLOXce/h8
 rxwEA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261029075420eucas1p1fd7d94e680ce387882517681fc6e0433
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261029075420eucas1p1fd7d94e680ce387882517681fc6e0433
X-EPHeader: CA
X-CMS-RootMailID: 20261029075420eucas1p1fd7d94e680ce387882517681fc6e0433
References: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
 <CGME20261029075420eucas1p1fd7d94e680ce387882517681fc6e0433@eucas1p1.samsung.com>
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

Nothing in the video output subsystem can reach its own registers until
the NoC display bus clock and reset are up and PD_VOUT is powered, and
those are shared by every device in the region. Leaving them to whichever
consumer probes first works by accident and stops working as soon as the
probe order changes.

Add a driver for the subsystem node that takes the bus clock and reset,
holds a runtime PM reference so genpd keeps PD_VOUT powered, and then
populates its children. All three are released only once the last child
is gone.

Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Tested-by: Byron Stanoszek <gandalf@winds.org>
Tested-by: OOHehir <oo.hehir@gmail.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/soc/starfive/Kconfig                 | 15 +++++
 drivers/soc/starfive/Makefile                |  1 +
 drivers/soc/starfive/jh7110-vout-subsystem.c | 82 ++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/drivers/soc/starfive/Kconfig b/drivers/soc/starfive/Kconfig
index 8cdcfc6f7848d2dd40b57afa101edcffc3f263a6..643d384c10b094d5633b5e31c3a67f5b9432c6d1 100644
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

