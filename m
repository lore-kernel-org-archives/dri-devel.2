Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91C5C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3F110EFBC;
	Thu, 23 Jul 2026 07:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oPm/Bedy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NV96MHVG";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15FB410E415
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:14:58 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h4qr01wH0z8tx7;
 Wed, 22 Jul 2026 12:14:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784715296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oUVGFSfgae8I/vHiNB3JYuYYHtz3ffWiRX8LsNpmNyM=;
 b=oPm/BedyHMHnxQPT1f9aQ+Qq0dDXP2UZ2DRV2xvUusASEJEoEfJlYRROuikvs6npaPpk25
 PkvwjweNREaMTUl11oX1murb1hvVJoVKLhfZ/Sm3hhzq0aagU1/Wu/FjmN8XBYMzTbr4F+
 7uUsDK8W/f2voyqDQqxx9ODr79SMNd+tYICh+eXjGw9wXZj2vXRsMxznzqMJf63QXxfLrW
 7mfo5GAiFBb4u8msef+C04aKyu5y1duBjWoMQY6Hfve3SzyETp4+Frde0oHG9OQyojESfs
 2R9KyhuoOHKyx4IW+ijjxgpq/Yf8uXxMiDwLHQ0tg/tnRCgpno9ozpVUWVNyRg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=NV96MHVG;
 spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784715294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oUVGFSfgae8I/vHiNB3JYuYYHtz3ffWiRX8LsNpmNyM=;
 b=NV96MHVGs1cPIF3/U7qf1rftSzAndrpSrie2oC1L2Fa1FeZWHGfTpJLCmas2rUn4S5GDMJ
 qDV+TA4IdMG64EBauO52RwfVHVvcfhJYr+avMU8UW/h4lrRphTmIIwXTqOUhJImydkp7Yv
 zpe3QbMKR1EYl98ncNYVDERjBetD7fHqSg8dbjpqz+aGH80q+uvKL84yUNScHQt5Nse/XZ
 +yxiYZ+SiKB+m3DdB3LsfAGezBu2T3+/xOE8vWGAXGjtJrF4s7WmisBJJYIJvUOpXWVPdP
 32ktPk8X5vaNkU3WiUAkt+sS4UJ1LdIajgk6K3GRGK4kZk3DdwyHbOkZfh3z8Q==
To: krzk@kernel.org
Cc: conor+dt@kernel.org, danielt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, jingoohan1@gmail.com, krzk+dt@kernel.org,
 lee@kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 pavel@kernel.org, robh@kernel.org, manuelebner@mailbox.org,
 Manuel Ebner <manuelebnerli@mailbox.org>
Subject: [PATCH v2] dt-bindings: fix typos and brackets
Date: Wed, 22 Jul 2026 12:12:47 +0200
Message-ID: <20260722101246.3113818-2-manuelebnerli@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ac203eba58c9d61047b
X-MBO-RS-META: 536gcdwj8ycmyr4tn4bpizd1xd17q4ae
X-Rspamd-Queue-Id: 4h4qr01wH0z8tx7
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

Add missing '(', ')', '}'
Remove needless '(', ')', '{', '}'
'lover voltage' -> 'lower voltage'

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
[v2]
 rebased

[v1]
 https://lore.kernel.org/all/20260713134751.498891-2-manuelebner@mailbox.org/

I changed to my new address, manuelebner +LI @mailbox.org to
reduce the mail to my main address.
---
 Documentation/devicetree/bindings/arm/mediatek.yaml           | 2 +-
 .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml          | 2 +-
 .../bindings/clock/renesas,rcar-usb2-clock-sel.yaml           | 4 ++--
 .../devicetree/bindings/memory-controllers/renesas,dbsc.yaml  | 2 +-
 .../devicetree/bindings/memory-controllers/ti-aemif.txt       | 4 ++--
 Documentation/devicetree/bindings/mips/brcm/soc.txt           | 2 +-
 Documentation/devicetree/bindings/phy/phy-miphy365x.txt       | 2 +-
 Documentation/devicetree/bindings/powerpc/ibm,vas.txt         | 2 +-
 Documentation/devicetree/bindings/regulator/max8907.txt       | 1 -
 .../bindings/regulator/mediatek,mt6358-regulator.yaml         | 2 +-
 .../devicetree/bindings/regulator/pbias-regulator.txt         | 1 +
 .../devicetree/bindings/regulator/rohm,bd71837-regulator.yaml | 4 ++--
 .../devicetree/bindings/regulator/rohm,bd71847-regulator.yaml | 4 ++--
 .../devicetree/bindings/sound/mikroe,mikroe-proto.txt         | 1 -
 Documentation/devicetree/bindings/usb/iproc-udc.txt           | 1 +
 15 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 382d0eb4d..cd4040ad3 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -314,7 +314,7 @@ properties:
           - const: google,steelix-sku196608
           - const: google,steelix
           - const: mediatek,mt8186
-      - description: Google Squirtle (Acer Chromebook Spin 311 (R724T)
+      - description: Google Squirtle (Acer Chromebook Spin 311 (R724T))
         items:
           - const: google,squirtle
           - const: mediatek,mt8186
diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 152403f54..c7301f1b2 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -9,7 +9,7 @@ title: Trace, Profiling and Diagnostics Monitor - TPDM
 
 description: |
   The TPDM or Monitor serves as data collection component for various dataset
-  types specified in the QPMDA spec. It covers Implementation defined ((ImplDef),
+  types specified in the QPMDA spec. It covers Implementation defined (ImplDef),
   Basic Counts (BC), Tenure Counts (TC), Continuous Multi-Bit (CMB), and Discrete
   Single Bit (DSB). It performs data collection in the data producing clock
   domain and transfers it to the data collection time domain, generally ATB
diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.yaml b/Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.yaml
index c84f29f18..a14be249f 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.yaml
@@ -13,8 +13,8 @@ description: |
   If you connect an external clock to the USB_EXTAL pin only, you should set
   the clock rate to "usb_extal" node only.
   If you connect an oscillator to both the USB_XTAL and USB_EXTAL, this module
-  is not needed because this is default setting. (Of course, you can set the
-  clock rates to both "usb_extal" and "usb_xtal" nodes.
+  is not needed because this is default setting (Of course, you can set the
+  clock rates to both "usb_extal" and "usb_xtal" nodes).
 
   Case 1: An external clock connects to R-Car SoC
     +----------+   +--- R-Car ---------------------+
diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,dbsc.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,dbsc.yaml
index 8e3822314..30ad2a858 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,dbsc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,dbsc.yaml
@@ -13,7 +13,7 @@ description: |
   Renesas SoCs contain one or more memory controllers.  These memory
   controllers differ from one SoC variant to another, and are called by
   different names, e.g. "DDR Bus Controller (DBSC)", "DDR3 Bus State Controller
-  (DBSC3)", or "SDRAM Bus State Controller (SBSC)").
+  (DBSC3)", or "SDRAM Bus State Controller (SBSC)".
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt b/Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt
index 190437a0c..3ec0a43d4 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt
@@ -111,7 +111,7 @@ Optional child cs node properties:
 
 - ti,cs-read-hold-ns:		read hold width, ns
 				Time between the deactivation of the read
-				strobe and the end of the cycle (which may be
+				strobe and the end of the cycle which may be
 				either an address change or the deactivation of
 				the chip select signal.
 				Minimum value is 1 (0 treated as 1).
@@ -128,7 +128,7 @@ Optional child cs node properties:
 
 - ti,cs-write-hold-ns:		write hold width, ns
 				Time between the deactivation of the write
-				strobe and the end of the cycle (which may be
+				strobe and the end of the cycle which may be
 				either an address change or the deactivation of
 				the chip select signal.
 				Minimum value is 1 (0 treated as 1).
diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
index 3a66d3c48..70cd69a4f 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -45,7 +45,7 @@ each of which may have several associated hardware blocks, which are versioned
 independently (control registers, DDR PHYs, etc.). One might consider
 describing these controllers as a parent "memory controllers" block, which
 contains N sub-nodes (one for each controller in the system), each of which is
-associated with a number of hardware register resources (e.g., its PHY.
+associated with a number of hardware register resources (e.g., its PHY).
 
 == MEMC (MEMory Controller)
 
diff --git a/Documentation/devicetree/bindings/phy/phy-miphy365x.txt b/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
index 8772900e0..e36fac92f 100644
--- a/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
+++ b/Documentation/devicetree/bindings/phy/phy-miphy365x.txt
@@ -31,7 +31,7 @@ Required properties (port (child) node):
 
 Optional properties (port (child) node):
 - st,sata-gen	     :	Generation of locally attached SATA IP. Expected values
-			are {1,2,3). If not supplied generation 1 hardware will
+			are (1,2,3). If not supplied generation 1 hardware will
 			be expected
 - st,pcie-tx-pol-inv :	Bool property to invert the polarity PCIe Tx (Txn/Txp)
 - st,sata-tx-pol-inv :	Bool property to invert the polarity SATA Tx (Txn/Txp)
diff --git a/Documentation/devicetree/bindings/powerpc/ibm,vas.txt b/Documentation/devicetree/bindings/powerpc/ibm,vas.txt
index bf11d2faf..80ea97569 100644
--- a/Documentation/devicetree/bindings/powerpc/ibm,vas.txt
+++ b/Documentation/devicetree/bindings/powerpc/ibm,vas.txt
@@ -10,7 +10,7 @@ Required properties:
 - reg : Should contain 4 pairs of 64-bit fields specifying the Hypervisor
   window context start and length, OS/User window context start and length,
   "Paste address" start and length, "Paste window id" start bit and number
-  of bits)
+  of bits
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/regulator/max8907.txt b/Documentation/devicetree/bindings/regulator/max8907.txt
index 371eccd1c..b04c9edd3 100644
--- a/Documentation/devicetree/bindings/regulator/max8907.txt
+++ b/Documentation/devicetree/bindings/regulator/max8907.txt
@@ -66,4 +66,3 @@ Example:
 ...
 			};
 		};
-	};
diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
index c50402fcb..4eb635179 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
@@ -145,7 +145,7 @@ allOf:
     then:
       patternProperties:
         # Old regulator node name scheme (with prefix and underscores) only
-        # ([^y-] is used to avoid matching -supply
+        # ([^y-]) is used to avoid matching -supply
         "^(?<!buck_)(?<!ldo_)v.*[^y-](?!-supply)$": false
         "^ldo_vsram-": false
         # vsram_core regulator doesn't exist on MT6358
diff --git a/Documentation/devicetree/bindings/regulator/pbias-regulator.txt b/Documentation/devicetree/bindings/regulator/pbias-regulator.txt
index acbcb452a..09b07f7ab 100644
--- a/Documentation/devicetree/bindings/regulator/pbias-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/pbias-regulator.txt
@@ -30,3 +30,4 @@ Example:
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3000000>;
 			};
+		};
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
index efb38dd15..b886cb6d2 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
@@ -98,8 +98,8 @@ patternProperties:
       # Setups where regulator (especially the buck8) output voltage is scaled
       # by adding external connection where some other regulator output is
       # connected to feedback-pin (over suitable resistors) is getting popular
-      # amongst users of BD71837. (This allows for example scaling down the
-      # buck8 voltages to suit lover GPU voltages for projects where buck8 is
+      # amongst users of BD71837. This allows for example scaling down the
+      # buck8 voltages to suit lower GPU voltages for projects where buck8 is
       # (ab)used to supply power for GPU.
       #
       # So we allow describing this external connection from DT and scale the
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
index ef6f69be2..f0846983f 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
@@ -93,8 +93,8 @@ patternProperties:
       # Setups where regulator (especially the buck8) output voltage is scaled
       # by adding external connection where some other regulator output is
       # connected to feedback-pin (over suitable resistors) is getting popular
-      # amongst users of BD71837. (This allows for example scaling down the
-      # buck8 voltages to suit lover GPU voltages for projects where buck8 is
+      # amongst users of BD71837. This allows for example scaling down the
+      # buck8 voltages to suit lower GPU voltages for projects where buck8 is
       # (ab)used to supply power for GPU.
       #
       # So we allow describing this external connection from DT and scale the
diff --git a/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt b/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
index 912f8fae1..d6fdcf457 100644
--- a/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
+++ b/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
@@ -20,4 +20,3 @@ Example:
 		audio-codec = <&wm8731>;
 		dai-format = "i2s";
         };
-};
diff --git a/Documentation/devicetree/bindings/usb/iproc-udc.txt b/Documentation/devicetree/bindings/usb/iproc-udc.txt
index 272d7faf1..6a701ce29 100644
--- a/Documentation/devicetree/bindings/usb/iproc-udc.txt
+++ b/Documentation/devicetree/bindings/usb/iproc-udc.txt
@@ -19,3 +19,4 @@ Example:
 		reg = <0x664e0000 0x2000>;
 		interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>;
 		phys = <&usbdrd_phy>;
+	};
-- 
2.54.0

