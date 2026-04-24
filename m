Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7DEFE5206
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B76110F507;
	Fri, 24 Apr 2026 11:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="u/BwPYVP";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011066.outbound.protection.outlook.com
 [40.107.130.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E19210F4F6
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erxDaT7krAurDd8IJPDkD6oH7sM8w6fmXYsPYv8pLv2xlQOQpEOvRbafkrmXwXzFssOgSFZJBYamrBVqk+GLXDn0djh3NxpoK/z+uSmI1bni9NatfEqpDL37ieQPIQ0q792iPxEnjlcqD/JDXRLobgKZFXVPJkVjGdBVC5MDNPe9rng8PdROjijQ90Zs+jKIkGh6qul7q4X2rvrZ8qAOxvjuG8bXbE3r6K0TVfOUeB92GLXN15zA/n7JOlqfeqhYBWFzxW4O8W5D6ae9RgvdrVt79UDAfvI26vy4lmV4h+HMra7bM9i0dYkkzhJPvUsUsHOiDao6w4HqnTCWJ+L6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERrSUyngIRa2kpQaZaX4+UJXznOXEnmiiedoavNVXfY=;
 b=UCL/QwcOAayDTK1QCnPCEmI8cFJRah17UC8KOFn5nUjgGIVUP7eOqSj7orhswOA2bZzRF7ARRL0S2LexTi5pQBUW0jY0XJ7C0PXO6RX6bHsyIKl8Z+911RQkCFSiBUn6zSW5ZuE3A5NYXHZLhKFgLzIFwRkZ6Zd2QJmubY8IekDR762bRUBop/T+ci2cSMCXF2u3GcFgUYDfg0ewcXg9FImZbVnLIk3Vz2KjKs88DNKrmN2NwZBCg3a5NJNB3Wdo4Eml1v1ofRILumipoNngTnWWxcJ/A07ULDX4sSETxZfE1IWqeOt6kxQFZoPkPtlynZTC2OxgFMM4mOKAgH4dUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERrSUyngIRa2kpQaZaX4+UJXznOXEnmiiedoavNVXfY=;
 b=u/BwPYVP8AkEDFRyezRP8mZ0SQJ8XTxnbC8NfIyJfdi9PNdq3afflvJ+Tm2/p6++pjafFhPcxuD2v6so5TXInnpUJD7bKsT42+WrbnEyFawWC3tRKBJOwVd553EtNABjMjm2i8cYLLnorcWFUef2vRcM/t+SqYnoOelHjmcQFzXSpStMi7C417ukKNyQtuoZAiPySY+g0XpvRVL8AxUjA8ogdjc5J+uvj33cvxcdq/Qr71aTRUb2t2QfOK23HmRtQuSE8ZJudHT1zzKnqYkndRHelV2cRct30YeWa8aTFtJi4jAsuCsSQ5xXT47s5NMFnrEdoDxS6P3MzgYd/GvMXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:08:09 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 11:08:09 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ying Liu <victor.liu@nxp.com>
Subject: [PATCH v22 5/8] dt-bindings: phy: Add Freescale iMX8MQ DP and HDMI PHY
Date: Fri, 24 Apr 2026 11:07:18 +0000
Message-ID: <20260424-dcss-hdmi-upstreaming-v22-5-30a28f89298d@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::21) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9913a1-38fd-4810-7a5e-08dea1f1c4a9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|19092799006|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0X5CGGn/s+/hE0eBVnRrx++ZwnRtYmftJ9/Go5TIuDceITz+fX0yWg/eEf1VV+uAeO/2w/gBuXP739cQiqyeVivKvBz7+5Ienw8O1DSFRqMSsHqrL642LhdixOE9foBnuYV7erS73ymCtfK8dRWegQHWWBnKmIu2bx+MmbPQGtHbcEEqMZTVhSUJA80jNAe4XJmGgImUU4PT23oKidOvmYjoTU8MELdwMsi4C0elLtaVmv6ypMZYJ0i+WsrS8n6hAKLQmHdXyXDRGgRzRc69NaeUl5sZ1ECgyb7Q2EXUJ9IvkEWW9iwMGrEZe/mtb+anjmDLjj7F9ESBMXxbhS1dB/As8+Q14GrcTVa0fa2isXr/SXtkH+5E8b1SE6uBwjA7JtmJtmzocq9fyCH/NsiaKK3OyvlM/damd/6g3KwopR+gggqlMx10Loyajsa/nRJCles3RIa9g4QBPsIbb+kz4++IneszbFH/SfXeeyNtfD9sfONcCb4BM6EEWIXwrzOXI8KX0vooMlkfpjE9OCWsQge+kwzCs4mmDLwEYpsh5BcDhSz9PuPAvYDTIh77bxaM1t3WaN+Mh48mx8pJcarOJyI1G0mcopZi23pFRRdDca09yRH6HiB+a/B1eUg6JTO+262JWRCC0xUUgvz6VGaQfiHZ3hlDXQHY4Mp+zqtcRg+3wc7QFqiT+6Fi46m+Riqt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1A5VWNnRmJ2Qzk5UU1DNFcrd2o3SmxEQ214UjFneGJXSUNYUzE4S2NlOGhQ?=
 =?utf-8?B?QWQyZHB2ZVRjU0J1ZFBGcmF3L2ZJVlZrVWpKVFhFbm5KU1krQURoUnlxb2tD?=
 =?utf-8?B?MDg4N3JrY3RmU0lrcm00Q2phODBlQWRjdndIemlKbndBZWJzWmtuQ1VGSmho?=
 =?utf-8?B?SHdscUNkRVZ3dU9BeXVrL1kzSUcvbFFmdUZCamhBaUZOYUNJaFRUMXhNUkw3?=
 =?utf-8?B?bW5BTm1od3BDb0V0NWhVRlpGSjVNQU1lbEEvc05NOFNYV1F1QlZ6a2F0VTlu?=
 =?utf-8?B?MnhVRXZQS1ZJVHAxYU1jZnFSbmxjekRaR3FscHBwaTJBS0hIM0MyOXMwbEh4?=
 =?utf-8?B?RlowL2kvNGRFaHNYc1NJNU5RUWlnbUNzZDdWaXdobmpzWFc3cFBQNHk5azVD?=
 =?utf-8?B?VDFDTUZ1NnhrU09VNW1TWUN2RGJoektoQVpKSnR6T0RLZnVKb3ozOU1yNUNV?=
 =?utf-8?B?eG9qakY1bFFjaTN5NE5SMk1rTWRtVEtTNVVJdU1oTE1Mc3ZaNjBCQWQ1QzJp?=
 =?utf-8?B?ZjlIVVRxUjg4VkpXYVh3RU5Ca2RjYkx1WGN2WC90QnR5Rm9QblkrM0ZxMlFn?=
 =?utf-8?B?YUFGb1RnYVZSTHgvTDZUQVBjUXo2LzVVcTdYN212VEJNWk1Hb3ByUWRNN3hX?=
 =?utf-8?B?Q3pCS3JQTm9QdFdQS2VNd0pJR0tHOFdNWjJuY3RrbUcxMUdNbk04REd2MTNt?=
 =?utf-8?B?SDdoZXFnai9vSXBzWk50c2xmQStMMHd0cUkxYURhSDY3NnIrRlhZRVUyYUVF?=
 =?utf-8?B?YUUydzIvdFZsUFN5ekhsSUwxV0VLOE1rMVc2LzhONVI2OXlqYnk1VnNaNTNj?=
 =?utf-8?B?NUFqMmZ2WlRRYW80MUxld3dUMzRwWit2QnlHWjJjbEoyKytxN090cHA1M1ZX?=
 =?utf-8?B?RTEwOWd2UEZBUVl6S2RHK3gwMzMxL2ZIa1ZoVXNBNm9WQit0WVJaWmU5TWVW?=
 =?utf-8?B?UUlpYWd3bE5NTW1mcWhpc240N21Wdng2YXAzR3gwQ1dxb2ZpbGhENGcwb2lO?=
 =?utf-8?B?cDNlSE1hNGkzTzVxcndIS2J2VTBhSEtwNVdwTC9OMFlGSzl0U2pmSjFoODlw?=
 =?utf-8?B?MFhTR3ZwSXBJcU5ibGQwaUVmNzM0VjNHeVRPN3IwY1dIM0RFSHRiamNhNlBP?=
 =?utf-8?B?emxEYTQyakdmdEs2cDVmMkN4Njlmc0wrTFZwZXh5MlBkR1EwSEpweHk5MnFU?=
 =?utf-8?B?ZjVMenNFSk84L3cvdmNiT2tPRU41bEh3UGlNeG5pcnZSb2g2NERHcHM2MDNr?=
 =?utf-8?B?OXpLSVRxb20wUStKUzk5WUN2VzJpbThtTHJkazZTdUR2UFg4KzFKaXBmK3M3?=
 =?utf-8?B?TnNnc0QrbXVsdlB3T0NadHZucVlsWkxEZXNpT0lPYkJVQVdXc0RJNVh6Vk0v?=
 =?utf-8?B?azhiL0NCZ0NsZW1HbXJMR0lMNTJGTlFxQ0hEZVB2VUVYUlFpVjBVdXZFUHpI?=
 =?utf-8?B?amxPUVZhNEg3WjhQYWdxTmcwQklZV1BzZW5YWnRKTE55eGRNZ2VkQzk4UWNL?=
 =?utf-8?B?Zi9uQXRUU3hpYklkSjc4cXl0Q3dUb0FJZjBSTkNBQkY3eWpCcmUrcjhvN0lz?=
 =?utf-8?B?TFhHUjJRYWlhU0lpOTNOY1pQaXY3Q3NBM2hOcEZEL0tqUlhDQlczbklWcUZp?=
 =?utf-8?B?ZDgxSDdTU2FMMmZ6dVk3UDZvY3NUZndjb21qZUJ4TlVQcENPUWxVTlY4Vit2?=
 =?utf-8?B?NU1JZzNTYlk5RGVETU5FMmoyN0Z0RzFDS1BXS1BHNmlaWDIwaTVEdlUyVEYy?=
 =?utf-8?B?eWxmdXZPeENhaFlDV1R3aWdQM1ZSYUhNN3VRSHJyQUFTd3p5ditqZ1lQdllP?=
 =?utf-8?B?RHdkdkFsMWdzSVRNUDRGcjNvTzF0V0tmTUIwUGE1QkV3aGpjaVFrQlNvZHR1?=
 =?utf-8?B?TDdPRDI3VXJCVVc2V1NGRlFHbkZPMkVSTXIvSVhWNjBReVRuejRNb1NyRytp?=
 =?utf-8?B?NUNkaDVISVdIbEtQSkVIelpSUTZGZVRBM21XaUNLdis5WnJCMklLeEh1Q0hM?=
 =?utf-8?B?WkMrTUovZ2QyNk1WYW9VaDZHSWN4ZGFCd1AvbXBaY2xSNVpQejJtNmt2VWl6?=
 =?utf-8?B?dHFobUkrSXhMOHh3czY4RGl0RkJGTE1nb3dKcCtEblRLOWg1VDNwSy9TNUlG?=
 =?utf-8?B?NTVxdXJHV1YyQ3FKSGhGSEdPanNnSzFhTlRpM3lURSt1OW9GV1hlWGl3L0dS?=
 =?utf-8?B?emdPU3hZNVdjLzZjWjZYNGxDL1NHZXlYN1craEpMZ3RDN2hhVzdGNG5FVC9U?=
 =?utf-8?B?eE9NYk5iN0x3RkU1YkUrajl4M2dYMnhQdzFPTkcvTHRMbXRpVDUxdWltalpO?=
 =?utf-8?B?SUVhRzREQWxuT1A2YmNUMGwrdTl1VGJBTm1aQWkwaGxrQk5uMjcvejc0b2Z5?=
 =?utf-8?Q?Sna3T7l+HV+fgk7E=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9913a1-38fd-4810-7a5e-08dea1f1c4a9
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:08:09.3135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLCyfDAK6oWIyaGTpQZp7FeOGhjaz/F65GxB3CJsgDUy2+qjW3Q5WvrP4KESM10uldeDHtzcW7lR2Ojy5P3Txg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270
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

From: Sandor Yu <Sandor.yu@nxp.com>

Add bindings for Freescale iMX8MQ DP and HDMI PHY.

Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 .../bindings/phy/fsl,imx8mq-hdptx-phy.yaml         | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-hdptx-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-hdptx-phy.yaml
new file mode 100644
index 0000000000000..a24435139b8b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-hdptx-phy.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/fsl,imx8mq-hdptx-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence HDP-TX DP/HDMI PHY for Freescale i.MX8MQ SoC
+
+maintainers:
+  - Sandor Yu <sandor.yu@nxp.com>
+
+description:
+  The Cadence HDP-TX DP/HDMI PHY is a child node of the MHDP8501 bridge,
+  sharing the same MMIO region as the parent bridge node.
+
+properties:
+  compatible:
+    const: fsl,imx8mq-hdptx-phy
+
+  clocks:
+    items:
+      - description: PHY reference clock.
+      - description: APB clock.
+
+  clock-names:
+    items:
+      - const: ref
+      - const: apb
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mq-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    display-bridge@32c00000 {
+        compatible = "fsl,imx8mq-mhdp8501";
+        reg = <0x32c00000 0x100000>;
+        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "plug_in", "plug_out";
+        clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+        phys = <&dp_phy>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                endpoint {
+                    remote-endpoint = <&dcss_out>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                endpoint {
+                    data-lanes = <2 1 0 3>;
+                };
+            };
+        };
+
+        dp_phy: phy {
+            compatible = "fsl,imx8mq-hdptx-phy";
+            #phy-cells = <0>;
+            clocks = <&hdmi_phy_27m>, <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+            clock-names = "ref", "apb";
+        };
+    };

-- 
2.51.0
