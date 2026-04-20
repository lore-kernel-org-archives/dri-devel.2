Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949F6F588C5
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DF110E5B4;
	Mon, 20 Apr 2026 12:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="t5PONHYH";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 546FC10E5A3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:54:51 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F2F63822;
 Mon, 20 Apr 2026 14:53:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776689593;
 bh=EtZwEJhnqhS33Hdc1vqD0fodBP7aap1bbkWrIwxEwcw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=t5PONHYH+1TNCv4vstrCXyYry9/suK+3U9AH2lEl7vehnWPyiFEQik9G95TAx/N13
 3uAJPtww/mjt5S+mbm+KdrCnK4utoJ+i/UzD39ecOAbI5AdMvRs3uNx4ek/UxBRM8F
 8ER4v6uasHb4garwhHNer3GY2sGnJ3lVZtMvZRPA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 20 Apr 2026 15:54:21 +0300
Subject: [PATCH 14/15] arm64: dts: ti: k3-am62p-j722s-common-main: Add
 support for DSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-beagley-ai-display-v1-14-f628543dfd14@ideasonboard.com>
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
In-Reply-To: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9010;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=1+Gvn5gy5gbErdQrLPnwnfaAKo3ehAEenxp0QEjeS58=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp5iIIVQHtEq567/w1DZZAP6YW8ZuB2sAvDqptF
 ZKSoaaNKc+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeYiCAAKCRD6PaqMvJYe
 9SfGD/44ye6cJ6TufWsDvFudbxLWCRYd8Zn1bWaj8X3ELifaQ5Pn0HSY0S/OVh6WCNpHuFSResP
 EwHF92wcEFmKDiqzqDeFY6N/ub2Iy79LoddVm9gSxjLF52F7YadT4QcavbANAnB7n+hWWcIJtos
 4tNntHgEZs3LsJeafnJ5xbtL8qaDgfxCo38x2sxp3UeBnyqQFS1ejs5FnJeIAhFnwrE0prCaX1o
 pxJVkL5KVR3bzAOCv5NERApWUCbQLtXKE/Nes0SweRwV5SJusvAgTnc1HYqkYqtwaD/N4WMZxY9
 twfrIbCOHzV6zkzTjr+Bkpnm1xCIVPH8P+LDYRGp2geWAJxwsaYVPPIv7hi8VV1AFFNwfNb4Juf
 607tjy+lokh5mzVzttRq/BH3oZ/iIhx2zvM0Spi4lAeUMF2XagZ48uTkSO7eP1IjERcgr1JDgIO
 mOv7SKdTYcs6+2qnI876CalP7d8ecNWNZGt4iPvasCoFOUnv64Z/h/e5vkufgyd4Lt44cj+ewnK
 /AF6DtdH6jy1WqeqpSzqHx7U1r/mTREq8ywM+DsoZkAmk3tzAE2YNWlxLWT2CJFqgcp2FPMBbxM
 joKUMeSR/CCdfPMml0VHqSq9ctiRIPDwgRAY/5xkWlbjv9HVmZN49XhyUudBvQj6h2r2f2zQuRW
 p+n2/4c9v4bgEHw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

From: Jayesh Choudhary <j-choudhary@ti.com>

TI's AM62P and J722S SoCs support 2 display subsystems (DSS), DSS0 and
DSS1, each with two video ports (VP) and two video planes. The outputs
from the DSS VPs can be routed to two OLDI TXes (OLDI0, OLDI1), a DSI
TX, or parallel DPI output.

DSS0 supports:
- VP0: OLDI0 in single-link mode or OLDI0 and OLDI1 in dual-link or
  clone mode.
- VP1: DPI

DSS1 supports:
- VP0: OLDI1 in single-link mode, or DPI
- VP1: DPI or DSI

The DSI is only connected to VP1 of DSS1, but OLDI and DPI are shared
between the DSS instances. Thus only a single VP can output to DPI, and
a single VP can use an OLDI block. Note that in single-link
configuration OLDI0 can be used by DSS0, and at the same time OLDI1 can
be used by DSS1.

Add the necessary nodes to k3-am62p-j722s-common-main.dtsi, including
DSS0, DSS1, OLDI0, OLDI1, DPHY and DSI.

An important note about OLDIs:

We have two OLDI hardware blocks. Each OLDI has certain configuration
that has to be done before it can be used. The OLDI blocks get this
configuration directly from the DSS block, via DSS registers. However,
as a single OLDI block can be used either with DSS0 or DSS1, the
source for the configuration changes according to (probably, this is
unclear) a DSS related clock mux.

So, afaics, when thinking about Linux device hierarchy wrt. control
busses, OLDI blocks are children of DSS blocks, and they reside in a
special DSS bus. And the OLDI parent changes according to the mux. As
far as I know, there is no way we can represent this in the DT.

Thus the solution used here (and in the driver) is that each DSS node
contains the OLDI nodes that can be used with that DSS. Thus the DSS0
node has two child nodes, OLDI0 and OLDI1, and the DSS1 node has one
child node, OLDI1. The OLDI1 nodes thus refer to the same piece of
hardware, and they cannot be used at the same time. The selection which
OLDI nodes to use are chosen in the board dts files, so assuming the dts
files are correct, no resource conflict can happen.

This is not a very nice solution, but the hardware doesn't make it easy
to have a clean solution, and, most importantly, this works.

A note about DPI0_CLK_CTRL:

The SoCs also have a separate quirk/fix register for DPI data/sync edge.
See commit "dt-bindings: display: ti,am65x-dss: Add dpi-io-ctrl property
for data/sync edge synchronization" for details.

Here we add that quirk register, with the dss_dpi0_clk_ctrl node, and
refer to it from the DSS nodes.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
[j-choudhary@ti.com: Refactor changes for k3-am62p-j722s-common-main.dtsi
 and add changes for new OLDI driver support]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
[tomi.valkeinen: various fixes and improvements]
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi    | 112 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi               |  16 +++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi               |  16 +++
 3 files changed, 144 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 0e1af2a69ca2..263bab009021 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -64,6 +64,16 @@ audio_refclk1: clock-controller@82e4 {
 			#clock-cells = <0>;
 		};
 
+		dss_dpi0_clk_ctrl: dss-dpi0-clk-ctrl@8300 {
+			compatible = "ti,am625-dss-dpi0-clk-ctrl", "syscon";
+			reg = <0x8300 0x4>;
+		};
+
+		dss_oldi_io_ctrl: dss-oldi-io-ctrl@8600 {
+			compatible = "ti,am625-dss-oldi-io-ctrl", "syscon";
+			reg = <0x8600 0x200>;
+		};
+
 		phy_gmii_sel: phy@4044 {
 			compatible = "ti,am654-phy-gmii-sel";
 			reg = <0x4044 0x8>;
@@ -1110,6 +1120,108 @@ dphy0: phy@30110000 {
 		status = "disabled";
 	};
 
+	dss0: dss@30200000 {
+		compatible = "ti,am62p-dss";
+		reg = <0x00 0x30200000 0x00 0x1000>, /* common */
+		      <0x00 0x30202000 0x00 0x1000>, /* vidl1 */
+		      <0x00 0x30206000 0x00 0x1000>, /* vid */
+		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
+		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
+		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Used for OLDI */
+		      <0x00 0x3020b000 0x00 0x1000>, /* vp2: Used as DPI */
+		      <0x00 0x30201000 0x00 0x1000>; /* common1 */
+		reg-names = "common", "vidl1", "vid",
+			    "ovr1", "ovr2", "vp1", "vp2", "common1";
+		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;	/* DSS0 */
+		clocks = <&k3_clks 186 6>,
+			 <&dss0_vp1_clk>,
+			 <&k3_clks 186 2>;
+		clock-names = "fck", "vp1", "vp2";
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		oldi-transmitters {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dss0_oldi0: oldi@0 {
+				reg = <0>;
+				clocks = <&k3_clks 186 0>;
+				clock-names = "serial";
+				ti,oldi-io-ctrl = <&dss_oldi_io_ctrl>;
+				status = "disabled";
+				power-domains = <&k3_pds 243 TI_SCI_PD_EXCLUSIVE>; /* OLDI0_VD */
+			};
+
+			dss0_oldi1: oldi@1 {
+				reg = <1>;
+				status = "disabled";
+				power-domains = <&k3_pds 244 TI_SCI_PD_EXCLUSIVE>; /* OLDI1_VD */
+			};
+		};
+	};
+
+	dss1: dss@30220000 {
+		compatible = "ti,am62p-dss";
+		reg = <0x00 0x30220000 0x00 0x1000>, /* common */
+		      <0x00 0x30222000 0x00 0x1000>, /* vidl1 */
+		      <0x00 0x30226000 0x00 0x1000>, /* vid */
+		      <0x00 0x30227000 0x00 0x1000>, /* ovr1 */
+		      <0x00 0x30228000 0x00 0x1000>, /* ovr2 */
+		      <0x00 0x3022a000 0x00 0x1000>, /* vp1: Used for DPI/OLDI */
+		      <0x00 0x3022b000 0x00 0x1000>, /* vp2: Used DPI/DSI */
+		      <0x00 0x30221000 0x00 0x1000>; /* common1 */
+		reg-names = "common", "vidl1", "vid",
+			    "ovr1", "ovr2", "vp1", "vp2", "common1";
+		power-domains = <&k3_pds 232 TI_SCI_PD_EXCLUSIVE>;	/* DSS1 */
+		clocks = <&k3_clks 232 8>,
+			 <&dss1_vp1_clk>,
+			 <&k3_clks 232 4>;
+		clock-names = "fck", "vp1", "vp2";
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		oldi-transmitters {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dss1_oldi1: oldi@1 {
+				reg = <1>;
+				clocks = <&k3_clks 232 0>;
+				clock-names = "serial";
+				ti,oldi-io-ctrl = <&dss_oldi_io_ctrl>;
+				status = "disabled";
+				power-domains = <&k3_pds 244 TI_SCI_PD_EXCLUSIVE>; /* OLDI1_VD */
+			};
+		};
+	};
+
+	dphy_tx0: phy@301c0000 {
+		compatible = "ti,j721e-dphy";
+		reg = <0x0 0x301c0000 0x0 0x1000>;
+		clocks = <&k3_clks 238 16>, <&k3_clks 238 1>;
+		clock-names = "psm", "pll_ref";
+		#phy-cells = <0>;
+		power-domains = <&k3_pds 238 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 238 1>;
+		assigned-clock-parents = <&k3_clks 238 2>;
+		assigned-clock-rates = <25000000>;
+		status = "disabled";
+	};
+
+	dsi0: dsi@30500000 {
+		compatible = "ti,j721e-dsi";
+		reg = <0x0 0x30500000 0x0 0x100000>, <0x0 0x30270000 0x0 0x100>;
+		clocks = <&k3_clks 231 2>, <&k3_clks 231 5>;
+		clock-names = "dsi_p_clk", "dsi_sys_clk";
+		power-domains = <&k3_pds 231 TI_SCI_PD_EXCLUSIVE>;
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+		phys = <&dphy_tx0>;
+		phy-names = "dphy";
+		status = "disabled";
+	};
+
 	vpu: video-codec@30210000 {
 		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
 		reg = <0x00 0x30210000 0x00 0x10000>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 9d6266d6ddb8..074dc44ec049 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -144,6 +144,22 @@ cbass_wakeup: bus@b00000 {
 		};
 	};
 
+	dss0_vp1_clk: clock-divider-oldi-dss0 {
+		compatible = "fixed-factor-clock";
+		clocks = <&k3_clks 186 0>;
+		#clock-cells = <0>;
+		clock-div = <7>;
+		clock-mult = <1>;
+	};
+
+	dss1_vp1_clk: clock-divider-oldi-dss1 {
+		compatible = "fixed-factor-clock";
+		clocks = <&k3_clks 232 0>;
+		#clock-cells = <0>;
+		clock-div = <7>;
+		clock-mult = <1>;
+	};
+
 	#include "k3-am62p-j722s-common-thermal.dtsi"
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index 059c65ece183..f5b74281ab3d 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -227,6 +227,22 @@ cbass_wakeup: bus@b00000 {
 		};
 	};
 
+	dss0_vp1_clk: clock-divider-oldi-dss0 {
+		compatible = "fixed-factor-clock";
+		clocks = <&k3_clks 186 0>;
+		#clock-cells = <0>;
+		clock-div = <7>;
+		clock-mult = <1>;
+	};
+
+	dss1_vp1_clk: clock-divider-oldi-dss1 {
+		compatible = "fixed-factor-clock";
+		clocks = <&k3_clks 232 0>;
+		#clock-cells = <0>;
+		clock-div = <7>;
+		clock-mult = <1>;
+	};
+
 	#include "k3-am62p-j722s-common-thermal.dtsi"
 };
 

-- 
2.43.0

