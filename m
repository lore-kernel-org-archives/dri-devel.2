Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46883CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 22:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F54810E08A;
	Tue, 12 May 2026 22:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="kEuwSJr8";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F21A910E08A
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 22:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1tKvflWpNeuWv5eB1JNEK9vBHM617PTsQXYY//e4BMlicE6GeK7MFMbp3hhXtHO+ON9k47H/H4UYLBUb9eaQBMN0WWvCw7X8Q1H3f6pMHIj15OxU7FIOWXdpK9p2Ys35+8SjC6ShcS6phOxZNnj0bCrhQJLA8u41FQVNHgr0zTKkwWfG3gFf/zmyB46YgsapLfgAFrDHJywCGfBktqIy609UtIE82uupnNX64ykOQNnPjw6Pa7aoUxrSTDiA5eHmVJxj/4ahyTcS8D1r4V8ZB2X8vtNnymc2c+RBktKmHdEB85R52H0j10mKotBubqhXfbNiGpyQgOdVOtzTZsFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3imlcggKl0MMTERSCowpEOjuDFafiQdvbdJV6tWYJqA=;
 b=M1xfSdhVwCD+LZZGpwDg5QPiAyFhOU3atFae3DPtzEy+N6UKXedA/sRa8wDR/0EP+7+5u73L9GijgWXluupTNHzTpqZ0NMI43xWdPeitUZAopbyR7ui85cKayXP+GnLfonCffr/7NHyrlxAXX0gQ+toMTNG2JX4ZYlqSJLU7Ea7OlG/WsyUlIx5pa9zaLCoHr2SK6Luw0gLDJMydiqLAHwLMQWv/a7zo5nJxxabbChWyWMSmwIG1gIEFMZn7O+tqlm0qQE13T8ah8LL0qBzI0IKzIbIsmz0l3C3HZiR4VWSA+qcUL3sVppBBdHGqQQifSiqRJY24fTmotz4sYFqP2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3imlcggKl0MMTERSCowpEOjuDFafiQdvbdJV6tWYJqA=;
 b=kEuwSJr8lBxymyBuUyq4JHT4vj91BV1xyrCVH8iFgKQsncEPYCT8P4FqfFB61En4pR2J6TG6zVtz7PppiTmKZlOEeddBu4QEWYzuUbpkYs+Gb7m13BF04ypHF/Xpv7k/uWhOtpkZkG4r4Oxha49aP3i99DfTRsd4x49pG9IuMeghFW6N2VDCHGrFN2HosbrrCfiT/qQ/A8L2k7vf79VbU2U9MSEOu2RJ7z/yKS2pUzyE4Qba77JO46afTmeQ5aeu/KxtZwSfLJfF5BggR1qo4Tr3q6/fk/zE05YlvgJveFtkI9LR/MlRVo0sqHM+BMQpqIFQFTxcNZP+g/JE0iv+Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10125.eurprd04.prod.outlook.com (2603:10a6:150:1ac::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 22:32:06 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 22:32:06 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE IMX 5/6), 
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS), 
 imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: display: imx: Add television encoder (TVE)
 for imx53
Date: Tue, 12 May 2026 18:31:35 -0400
Message-ID: <20260512223137.1190096-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10125:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9cdf29-c4dc-40eb-232c-08deb0764be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014|921020|18002099003|56012099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info: VdD8Qj0flG1w81MUILO7ok4fUJfFB0PUzN/RnocVZliS+AFmpKn9FEuXxvb+u94GSy+i+H1yLU+79ELaRJ+yLUkhCRnw8ThxBGkWD9JhrlQOUYKA2edJ3sSSWfm51MCgGfGUNhOWWugs+7QYxzIZIxphuEQ6+xnT2L1QT+H1bzb8ZEt3LdhJOD4LWCLQZcaDqItaa+g9wSTo6+VffpvrVfJGVDvQffPOJWbayM4J/HQ8xmWME+4KfkTL0teIqALuS0qFaEAtHz9LMMJc+4iSeaatjZQ/RE+gwpk9GbLUgmuIpJRnppxEdbSYkimQic87TCRwV/oHerRKMY8NALxIICUdgN3huLOnuRKK/iOFCAHhWEft12k6IXVzYXTR5t3X+eq/ephrOYe8RzRFvp4Wrf6AJKkvQNV/rz4qKhW6QG0oB+yGYuIMrU6hEX39O3HPs/XBDt+i5P72Sm9M0gklQ8e1cLiuB8dhRgrfMEnAduh7Tg/Btk1VTeLjM3oCRS3cE5tgJD6Rf2NuMd2yS3KDS6Mcj/se1hgi7rc9/APGZipSpwpZ86ibBq8kYdQBt06NcIgyjrxJlIa51tMFOyC8NmU6f+vQGxDUPCe9NeMx0/jdHKqYRpBlA0s2RDnXdaUsoqLvaXZDy5LoTSt2Dd8z7g1CrndO1bMFjyw2fB/y/th02xah4P3D6pngvBsaLuOQMRO/jRhWBOzVupeL+RkM1IIybvEyTNn78s24NwX5gLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9366.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(18002099003)(56012099003)(11063799003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9a+paHraas2ZRiiT1A8zwQ91UlzuWiol68IRpZXPcnS5KnN3jt/iQuCOq6aB?=
 =?us-ascii?Q?svJmv17YaqrMlweYDbzJyuZTxcbUzvR0N5swrRqcOP9iN3Pm45/E5qTb28v8?=
 =?us-ascii?Q?q0VsBLA+7sAbWF4HmNSbMhP9sOFUIItvsyJw31OzB59EFhpUw+nQOZkVCGMG?=
 =?us-ascii?Q?+otyRYtX8keRAaMfHTv7U/hckc/rovs54MkiiN1f3MBPrk8a8fKGAOXzyebL?=
 =?us-ascii?Q?poxVcyx8L94w8+SdZgCy/wqpxQmD9+DfI2K13xZEPsrEgKBGeOHYJGp82Fcu?=
 =?us-ascii?Q?lsW45n2cIkpz2WWtr6VtBwy7yr+/p2QmiCraAIq40Moy0zVms0pyPgat8qdt?=
 =?us-ascii?Q?QK2qMOBZkwCHqpteArmOcFPkHyiZondyA+KDswM5Xzcwa4gneF957ZhDMs/0?=
 =?us-ascii?Q?QhONcAiKpUm22ChBn0Um4De3x1fXLs0HAhmwq+FiEOFf/cYX+XQNqrWSqWK+?=
 =?us-ascii?Q?8xPbFqfCPVny+Koxf/l2dJZNs/pX7uLEu7adkx/a2oGQwbreKBAjGXbYmg4h?=
 =?us-ascii?Q?iFkcmwX7Q9ejI9NCi0P7XHmjgvWH+zuFc1PCDjYJg/HIhnnIkedvlgRkvfST?=
 =?us-ascii?Q?3fP8ZqU0iTWO601YCZH0GzhipxDOPfKmWlL8HBkftfYZ0mOij7I8NapapPeq?=
 =?us-ascii?Q?7mLSQQUSN5SknZC0yfO6rAGyoyS7t+rrq2YwiA4/kaQFh+MlQUHx5kUPsSyj?=
 =?us-ascii?Q?UzGCVVHTH4IZxqreff/ItoJS0DA2d9qsLEh++W1zRSIt3aVUkwlkLwBviyF0?=
 =?us-ascii?Q?3ejnWipiDgqU67ZKepYlZTIv4KXaNTncbUCw/5+SqwVN6P6LW4Ep5KIiUT2z?=
 =?us-ascii?Q?crgVSFuke2oFvzRJF7Edtj43M1OakW1QVQIbP2rfEqySy+EKKMoycG6ovIVo?=
 =?us-ascii?Q?BF4hMrO0Xt1HZnxejq3jkNYmbeV5Nz0cCYKtVHk7hCyts8SmbYJQv7Dp+lP/?=
 =?us-ascii?Q?ImbY39+0FycMIYMEciOZ+oTY3n/8p5ZW/9Y0aWprSoDLO5X4tR8YEt3roB0U?=
 =?us-ascii?Q?5hypNxKF26/1LDWBtrj7XzZq1cKW8lF3A4AsS25mLymVaZWgbkGxhdH7Ztxj?=
 =?us-ascii?Q?yNxlMHcUHR2qStpzut5jHAKOp4dB73qU9MKVyhb+lFXRO0W64roNKzfJPOaB?=
 =?us-ascii?Q?b8p7X15uUTtMTJBeIPJ9SKeOXkPIMqozUCYjcH5aoYvMbx+JlV1UUN3iDQhD?=
 =?us-ascii?Q?Ln2TsvXIYa11o70amyzw9lWkJwAJOGKBn51goWugT5O8fs2qyOgHVtcumn0j?=
 =?us-ascii?Q?QimGCsx5Wi/UjRMuQ3167eqIm6Cllx58yXZGkyaZN6Vsrop9Ref+KqBNnkCH?=
 =?us-ascii?Q?97IWSEmGswPNpdapv70KL+GSRRkmiFJv1Q/fHSADFuCD7JEohFxUeUPSUY1/?=
 =?us-ascii?Q?WCQWANgpOYURk6UfetUyErhdGg6tkaHAgX5y/VBkxEY812yl8XYObXoErsRK?=
 =?us-ascii?Q?A6WIiojS6qVGbzI/qqODH1b1f4mw5xdvnWAsgsVPjdTh2SAcBfLVeeg0L7Lo?=
 =?us-ascii?Q?s6yYHO/Nd882plQNg5uo1pHwafvMu4dGeblMLOCqQdz7p2YrdQXYeUgK1dkg?=
 =?us-ascii?Q?WXQvcTTD7JulVPLF9Z1JlZ5MF73OalTmPwffbTJ+ugveVvwfC3uVwmEKgmII?=
 =?us-ascii?Q?Z0XMVMS/EBnO2/Gx2z8QhxqsEJYSWOlhuGlHTddscymYlP78tNbu88hYBLvw?=
 =?us-ascii?Q?VR+ZVE/KeymSN/cPHBvtsaX7xn7ifPq9PCtz9tkTHE6fAh6J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9cdf29-c4dc-40eb-232c-08deb0764be6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 22:32:06.1316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZe4v4/LcVZfzNQjqG7AIHkC+WG7Orhx+UGLq+Box9K1vl/24Zd/S+3TLvsSKkSExzgCFVaaKat2k17klwt4Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10125
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

Add television encoder (TVE) for legacy i.MX53 (over 15 years) to fix below
DTB_CHECK warnings:
  arch/arm/boot/dts/nxp/imx/imx53-ard.dtb: /soc/bus@60000000/tve@63ff0000: failed to match any schema with compatible: ['fsl,imx53-tve']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
About cleanup 300 lines warnings for i.MX ARM platform
---
 .../bindings/display/imx/fsl,imx53-tve.yaml   | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx53-tve.yaml

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx53-tve.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx53-tve.yaml
new file mode 100644
index 0000000000000..a7c971be1959b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx53-tve.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/fsl,imx53-tve.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX53 Television Encoder (TVE)
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  The Television Encoder (TVE) is a hardware block in the i.MX53 SoC that
+  converts digital video data into analog TV signals (NTSC/PAL).
+
+properties:
+  compatible:
+    const: fsl,imx53-tve
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: TVE gate clock
+      - description: Display interface selector clock
+
+  clock-names:
+    items:
+      - const: tve
+      - const: di_sel
+
+  ddc-i2c-bus:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the I2C bus used for DDC (Display Data Channel) communication
+      to read EDID information from the connected display.
+
+  dac-supply:
+    description:
+      Regulator supply for the TVE DAC (Digital-to-Analog Converter).
+
+  fsl,tve-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      TVE output mode selection.
+    enum:
+      - ntsc
+      - pal
+      - vga
+
+  fsl,hsync-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Pin number for horizontal sync signal in VGA mode.
+    minimum: 0
+    maximum: 8
+
+  fsl,vsync-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Pin number for vertical sync signal in VGA mode.
+    minimum: 0
+    maximum: 8
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      Port node with one endpoint connected to the IPU display interface.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx5-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    tve@63ff0000 {
+        compatible = "fsl,imx53-tve";
+        reg = <0x63ff0000 0x1000>;
+        interrupts = <92>;
+        clocks = <&clks IMX5_CLK_TVE_GATE>,
+                 <&clks IMX5_CLK_IPU_DI1_SEL>;
+        clock-names = "tve", "di_sel";
+
+        port {
+            endpoint {
+                remote-endpoint = <&ipu_di1_tve>;
+            };
+        };
+    };
+
-- 
2.43.0

