Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37548CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42AEF10EC62;
	Mon,  5 Oct 2026 09:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="JfnLoGeM";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F0710E23E
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 09:50:19 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 9648F1FCA1;
 Mon,  5 Oct 2026 11:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1791193818;
 bh=+IYBqhtydsDlF5JgGl22OMMegDbu5n9n8HJ3dPJL0pQ=; h=From:To:Subject;
 b=JfnLoGeMAABtQTCmLQgXwQwJ1UiViky1a+I7jm4T5+y4F8auNx80hE9Z6VwC7ZRS4
 6X9MmtSOzbLbDIeBejnJGCZireEtsvSCWYRHSghWDXzwavijUhKS0725jLV8Rt1Ck0
 0Nd/K+r4US1TcI3ufPYlKSxT0Os8fslJkVBUDedKBr+3JdmcWQ69KWSfC16tA7Ad2X
 rIaXOqyVIhIrbYI2ElV9LzYEsRZ/+bmacBlR/yT9CyVuqhbDNeiHIlYgFoG7sOHkR8
 TaaPv5kT2JQheyZZ+bFdLMEIYlortkr1lBNsNYNZBvbWqkx2RgClkJB51e2RKKcCuy
 iQWfM0Zu/rwcw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] ARM: dts: imx7d-colibri-emmc: Add Toradex Capacitive
 Touch Display 10" LVDS
Date: Mon,  5 Oct 2026 11:50:03 +0200
Message-ID: <20261005095006.20290-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005095006.20290-1-francesco@dolcini.it>
References: <20261005095006.20290-1-francesco@dolcini.it>
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add a device tree overlay for the Toradex Capacitive Touch Display 10.1"
LVDS connected through the DPI to LVDS transmitter on the Iris v2 carrier
board. The panel is a LogicTechno LT170410-2WHC 10.1" WXGA IPS LCD and
the touch input is provided by an Atmel MaxTouch capacitive touch
controller.

The LVDS transmitter, panel, backlight and LCDIF description is kept in
a separate dtsi shared between the Colibri iMX6ULL and Colibri iMX7
modules, so that it can be reused by the Colibri iMX6ULL overlay. Only
the LVDS transmitter control GPIOs and the Atmel MaxTouch controller
wiring are SoC specific and are described in the overlay itself.

The overlay is also combined with the Iris v2 carrier board device tree
to provide a ready-to-use DTB.

Link: https://developer.toradex.com/hardware/accessories/displays/capacitive-touch-display-101inch-lvds
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2:
 - move the LVDS transmitter, panel, backlight and LCDIF description to
   a dtsi shared with the Colibri iMX6ULL overlay
 - override the lcdif_out endpoint by label instead of redefining it
 - rename the panel node to panel-lvds, add SODIMM comments to the
   LVDS transmitter control GPIOs
 - keep the Makefile dtbs rule separate from the 7" overlays group
---
 arch/arm/boot/dts/nxp/imx/Makefile            |  6 ++
 ...ibri-iris-panel-cap-touch-10inch-lvds.dtsi | 70 +++++++++++++++++++
 ...emmc-iris-panel-cap-touch-10inch-lvds.dtso | 47 +++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-iris-panel-cap-touch-10inch-lvds.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-iris-panel-cap-touch-10inch-lvds.dtso

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index c5caca92ea10..dac2e146ed75 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -420,6 +420,10 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ulz-14x14-evk.dtb \
 	imx6ulz-bsh-smm-m2.dtb
 
+imx7d-colibri-emmc-iris-v2-panel-cap-touch-10inch-lvds-dtbs := \
+	imx7d-colibri-emmc-iris-v2.dtb \
+	imx7d-colibri-emmc-iris-panel-cap-touch-10inch-lvds.dtbo
+
 imx7d-colibri-emmc-aster-panel-cap-touch-7inch-parallel-dtbs := \
 	imx7d-colibri-emmc-aster.dtb \
 	imx7d-colibri-emmc-panel-cap-touch-7inch-parallel.dtbo
@@ -459,8 +463,10 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-colibri-emmc-aster-panel-cap-touch-7inch-parallel.dtb \
 	imx7d-colibri-emmc-aster-vga.dtb \
 	imx7d-colibri-emmc-iris.dtb \
+	imx7d-colibri-emmc-iris-panel-cap-touch-10inch-lvds.dtbo \
 	imx7d-colibri-emmc-iris-vga.dtb \
 	imx7d-colibri-emmc-iris-v2.dtb \
+	imx7d-colibri-emmc-iris-v2-panel-cap-touch-10inch-lvds.dtb \
 	imx7d-colibri-emmc-iris-v2-panel-cap-touch-7inch-parallel.dtb \
 	imx7d-colibri-emmc-iris-v2-vga.dtb \
 	imx7d-colibri-emmc-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-iris-panel-cap-touch-10inch-lvds.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-iris-panel-cap-touch-10inch-lvds.dtsi
new file mode 100644
index 000000000000..e4ea149da9ad
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-imx7-colibri-iris-panel-cap-touch-10inch-lvds.dtsi
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * LVDS transmitter, panel, backlight and LCDIF part of the Toradex Capacitive
+ * Touch Display 10.1" LVDS overlays, connected through the Iris v2 carrier
+ * board X7 / X5 connectors and the on-carrier LVDS transmitter, shared by the
+ * Colibri iMX6ULL eMMC and Colibri iMX7 eMMC overlays.
+ *
+ * The LVDS transmitter control GPIOs and the Atmel MaxTouch controller wiring
+ * are SoC specific and are described by the overlay including this file.
+ *
+ * https://developer.toradex.com/hardware/accessories/displays/capacitive-touch-display-101inch-lvds
+ * https://www.toradex.com/accessories/capacitive-touch-display-10.1-inch-lvds
+ * https://developer.toradex.com/hardware/colibri-som-family/carrier-boards/iris-carrier-board/
+ * https://www.toradex.com/products/carrier-board/iris-carrier-board
+ * https://docs.toradex.com/108421-colibri_arm_iris_carrier_board_datasheet.pdf
+ */
+
+&{/} {
+	lvds_encoder: lvds-encoder {
+		compatible = "thine,thc63lvd827";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lvds_bridge_in: endpoint {
+					pclk-sample = <1>;
+					remote-endpoint = <&lcdif_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				lvds_bridge_out: endpoint {
+					remote-endpoint = <&lvds_panel_in>;
+				};
+			};
+		};
+	};
+
+	panel-lvds {
+		compatible = "logictechno,lt170410-2whc";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			lvds_panel_in: endpoint {
+				remote-endpoint = <&lvds_bridge_out>;
+			};
+		};
+	};
+};
+
+&backlight {
+	status = "okay";
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&lcdif_out {
+	remote-endpoint = <&lvds_bridge_in>;
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-iris-panel-cap-touch-10inch-lvds.dtso b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-iris-panel-cap-touch-10inch-lvds.dtso
new file mode 100644
index 000000000000..3d90c0ec8db9
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-iris-panel-cap-touch-10inch-lvds.dtso
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Toradex Capacitive Touch Display 10.1" LVDS
+ *
+ * Toradex Capacitive Touch Display 10.1" on Iris v2 carrier board X7 / X5
+ * connectors through on-carrier LVDS transmitter
+ *
+ * https://developer.toradex.com/hardware/accessories/displays/capacitive-touch-display-101inch-lvds
+ * https://www.toradex.com/accessories/capacitive-touch-display-10.1-inch-lvds
+ * https://developer.toradex.com/hardware/colibri-som-family/carrier-boards/iris-carrier-board/
+ * https://www.toradex.com/products/carrier-board/iris-carrier-board
+ * https://docs.toradex.com/108421-colibri_arm_iris_carrier_board_datasheet.pdf
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#include "imx6ull-imx7-colibri-iris-panel-cap-touch-10inch-lvds.dtsi"
+
+&atmel_mxt_ts {
+	pinctrl-0 = <&pinctrl_atmel_connector>;
+	/* SODIMM 107 / TOUCH_INT# */
+	interrupt-parent = <&gpio2>;
+	interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+	/* SODIMM 106 / TOUCH_RST# */
+	reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
+&lvds_encoder {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds_transceiver>;
+	/* SODIMM 63 / LVDS_RGB_MODE */
+	b6b8-gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
+	/* SODIMM 95 / LVDS_COLOR_MAP */
+	map-gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+	/* SODIMM 55 / LVDS_CH_MODE */
+	mode-gpios = <&gpio7 3 GPIO_ACTIVE_HIGH>;
+	/* SODIMM 99 / LVDS_PWRON */
+	powerdown-gpios = <&gpio7 11 GPIO_ACTIVE_LOW>;
+};
-- 
2.47.3

