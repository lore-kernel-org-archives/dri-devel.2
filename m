Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E902CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF63A10E362;
	Tue,  6 Oct 2026 12:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="efcA+o1K";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7326910E362
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQlGyfeI6sy6XoFJcXCkFHNd1u56+I0607O43C41WfXG0rXfDJHLDoaou1KMr9nQUyPqqfHPPPoiLDR/3UESxFYiP0Yq81d00Y81S04DCa5BmAWndUNIXmuTdlIddcG0JVDz+MuAFInnrVExLq1Q8yARmfBxoMJcQraRAJrD2XejMPugUr0inyOhhB+MatpgaCiIwcsCG972Cn5hFdrOv3OBLVs227Sl3vA20l8BLaJeFX7LMwlnP8GECqaSHEnCgqtupisMCeAUZegqEs+mmStXUKQtV0ePMSB6K7a0JB/i/P3Ewl3tRadjapbGh0OdwlpgruJRYhhXFC+Q3AWvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJjhdcQqVvSMJRFFeMHrsPmIpXEcjnn8UotKaePsxc4=;
 b=o0fsHct/qotQgHNU5SwzvgvfACPlVFhPMox5nxKOvUxDOFLyEhPG9JRt4rTpXNbmKJC2VJ1N9AQoh86m2JCVcERGCZ0b8Bial+Qbf8aKgTHej/6aciS5anbVx+LGD9omlIzKS+bfRRM6Vmcay5ZNb63ifvud2eiHY/44xrOfzQX0cGA55EC7hisOOgMWusnuuS4taYXTPE7lETcogl8Dgn93PiKvolYv4IGHl/LxfYkvOYGry1zs7AVerscA4RGGoY1azai8FXo60eXMTl3fz6TsMlsS+LmsQzei2E2oRqt4EvVUlwhUKc4LnAh7xQI7S8fNLbo3B4fUj7mvDa9Qxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJjhdcQqVvSMJRFFeMHrsPmIpXEcjnn8UotKaePsxc4=;
 b=efcA+o1K2ynZwhDXysNVkvcayVkulumtXGXCrVErc4AIBGyaRM+rSQDvqdUb1Pcwov/PmHRB0ZVu1wi7TuW/aVHmua7tOovrwSITKoOqlvUjSNzsxBEqhQl+u1Il+7UWBcvbb2rgWbZTMXyaEfTnztChiqx21+UaKFtSacnls8rYvSWiBikAQE+Xp9GpUKXSMmrTHruopMCaw0qsS9sSH0we265ZKd5ZZNwkQOIrpCT932FGBSRcbHBi4eST6NJYXAbLtziOPju8LoKXwikBW8yXL4Ew8eWgUVowU4Jbay3Lyw5PLl24wGC0735sp0oj83bc1ZW0HEwn0XHxeYJPDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AS8PR04MB9045.eurprd04.prod.outlook.com
 (2603:10a6:20b:440::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 12:23:19 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 12:23:19 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v10 4/9] dt-bindings: display: imx: Add i.MX94 DCIF
Date: Tue,  6 Oct 2026 12:21:59 +0000
Message-ID: <20261006-dcif-upstreaming-v10-4-bcfb28de0aae@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AS8PR04MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: d635491a-7039-4cc6-1aee-08df23a49aff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|7416014|376014|23010399003|921020|11063799006|3023799007|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: iGZhjntdFn6yPgz1pN7nHqkz66SafbqUw+fABDp+aWzUAn4NQaIRM2EPvjzV0TcVGFN9aztgpg/Wz1itysbuIuQBGC5Km8hWh213CA5SOSJ4vQGmnCBn0rT07xQcMZ+VmAkkq3artwly8x8lICLuvQZo03s7dfsg3+bvf5f9kZhSUZ/lFfwaQpkO4vuIMK3HDQuUI2YcwI2yyVjBvTao2tApXG8M5/ObiZ9ObcpjBH4KU+Q47iBFS4EqmsFphWwMCLA6rElDaWqPgt7R1M1M1mTYNh5AKKo5/JR8eDYyDfa6X1hY35yJ1z4IbVnW3w3Gz9O8SIZr6Ln1SFxMpOq8VKBUHnDVadNp4u1C03V8hKq2swq87l7Omu2UdOQlQ5SvRjm+b651BplxoJ1nZUQOHERPE8Kg+cSLB2AlEGZ6b0nmEDzgOHOBbjoQuxv8z49cOTFb5t7pFnUaDPJmCzw81J9+75bMofzRocCu7g3cuRrbAVjFIpUHZLOmgcgDCyVHNT884JvxFqzNXkZVqREu+ddkxXCEuCe/ERpFjfRSYaA31fVOCWhOjJU41YHfnDeWcB9dpzJMWQkrz2pT+mCH72XLt4j63XBz5GHVph6/L64JD/gcgj/1gZmETIJcrnpgVNu691SFIXbUVQ0g/s9SZ1Xn0qNEz6TwYDXBpP0fyOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(23010399003)(921020)(11063799006)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldSaWozWi94STJEL2JNR1hqbE1Fa2N5Sjl1eGtkWjF0Q09zNEZzN2pNaitu?=
 =?utf-8?B?VldmbVRZdjRpdXNHOGFnakxJSVZYcjFTQSswK0FoQlMzclJ6SDMxNVRmTSsz?=
 =?utf-8?B?VEhwMGk0KzRaazJ4ekNQUU8xOG9YcGlobUJnUStIVEhPMStGTmZvcE9lTndH?=
 =?utf-8?B?QlpCOUtna0ljcU92QVo1RVJyYlJpL0FSbnhCMmV4NVRNeTJSa04vTk9vN2RB?=
 =?utf-8?B?MHREQW12bTFGQitycUZkVHUzUGlHUWpvV3VPejN6c2VLS0JqQ1BXdUpsdGVv?=
 =?utf-8?B?a1dhRnpJMWtNVTY3aDdzWXllMGR4aURzSnRHUlJibTlCblFGQ2FYSzhrd3Qx?=
 =?utf-8?B?S0RrZ1VzYjRmdWFST0NYWnA2ZzlrNFkyQWROMTFpaGJNWDAzNncyL1FMWWgv?=
 =?utf-8?B?bXYyWStJZGVyS3g4ZGZUdTNHc3ZZQTJaL3lIK0JVTGVaUEZLTFJtRUMzN0FB?=
 =?utf-8?B?cGVqWlo0dkw2cnJVeXo3L3hNV0V3VTVlT09wSW45NkJkZVFFMnVwb1ZxOVE3?=
 =?utf-8?B?bE5XMGE4YWM2ZmlJM205akd0blpxRnVZUE9rZ05hOXZIZHdRTWpmV3RKc1VT?=
 =?utf-8?B?QVdJZzU3WGlDMFBKT25leHFjdm9GZXBpMWtvMGFOTm9LaWg4TnIzTy81UDVw?=
 =?utf-8?B?ekI5OVFVbWZkMG1US0dJcys1T08rTWtHbkhpV0pxUk9Pb2JHMWJNRi94T3Fl?=
 =?utf-8?B?U3lxSytWelplcnV1VW1SSTFLd2VGbEJWRkViVHNTcHVraDhXMjdCdmZ6NE5m?=
 =?utf-8?B?V1hKNThsMWNwRndxZURjMnhnRlJVNEdVL3diZ1FOTEplcGphWjhiMGlmY0NB?=
 =?utf-8?B?b0ZaU3BRVTM4WkFGbUV2cVZOYnhYZmt5ajl6TUN0eTYxdHFtMnpxQUtuYVFw?=
 =?utf-8?B?a2pQbGNVcXpMQk50NlROeUtEY203TDlvN2NtMVByMFA1S3hoeXM5L0ZaNWI2?=
 =?utf-8?B?OVpmYnpybTR6YWRGcGVDRzcyTWdVRWRYREp2YURXRzExR2pFbXRpa3JsbVBZ?=
 =?utf-8?B?N2wvWUVJbEw1OGdHQzByVEFZY2VBSUJ6cjRaNzh1SFd4eEJDdC9BamxDL0t6?=
 =?utf-8?B?aDE4N01uMCsydEU4QlhxVlJKUkpJU2V4SjkrMlJyVzZ6angyeVlnQXdVQVBL?=
 =?utf-8?B?S1VKZFNMTitoaWhQYlJLaFEwNEk3YlZBSVN4R2tEcjQzN3NERjVkY0dKbTli?=
 =?utf-8?B?U09YclprSzYzdWROWDdRVVhkOSt2K0VNYzFpMkUzdTcyaVFGY1RtMS82OGM5?=
 =?utf-8?B?SWNZdGVKSExOMVNLN29UdEMzbStBMzBjQWwvcElxQzdlc25MVE9iVk1xTTI1?=
 =?utf-8?B?a3lIcnRyZktrZXJRaytRRzlFdWp5YlpqWGM2cmdnSXpHTHlNU01OMXpsdzRZ?=
 =?utf-8?B?dWx5S2EzSDhLNFBNYWxIY3lZcFN4cEowVWVBdTJ1bThXUkpVRmU2UVJYZVhn?=
 =?utf-8?B?S1NiOXFMZXc4cXFNTGRGM2lTYkYyM3ZuSUtvUEQ5am5SNVcwSkVPSXpEcDBt?=
 =?utf-8?B?ejhCMEpPWVZmdCtwZlZkRlEvc1pmOWZHYy9WQWhmSzN6MElOdi84M2h2elh5?=
 =?utf-8?B?d01MTVpvTFdNR3ZORWtzeHNOWjB2VGlGcDFvYTJYTTdyS0hadCtLMmZoMFho?=
 =?utf-8?B?NUJ0K1Y3S3dZOEE5UWJ5Z3Jrem9uOW9aZXJxWUo2Y0cxVWdla3dzcG5jdVZK?=
 =?utf-8?B?SW1CdmVCb1l3eUcwazFIOC9RNnRQQWJUdURySEtTc3M4NGppd3lhZHlXNysw?=
 =?utf-8?B?bkpqYlhycmRGR1pEeGtBYXo4NXBFZ0lweUlKZ2pPOW5xVlFDVTdBWGYyaXNT?=
 =?utf-8?B?RWRsdm55WWx4ZzhtbEpUc2xiRE80bmtXMVdtcVVJdHJkR0dPV0p1VWdkOVVo?=
 =?utf-8?B?eDg3WFl1TlJjcDJOc2kvMFhZQ0t0U1VLV0dydjZnNk5DSVFaUkNjZ0hFdlJ0?=
 =?utf-8?B?S3NZUzh4QVl6RWlGNUF0V0NTRDFsZmxra3ZQMzJuRkNzMDlPTGJ6OUZuaDl4?=
 =?utf-8?B?aVJvZzc4RHJPZzlZWXMvZGZ1Z0RleGxxcEE0Q255Q1JrQVZ1NWNrOUY2Ni9H?=
 =?utf-8?B?MVJOMDY4Wm1HaFVNMlE3b1lET2o5YW44Tlp3cmVha1NPdzJacTBXdWdMN0JP?=
 =?utf-8?B?eGZxWkxYMFVDbytTbDBzK1JBS01QSnBUZDZyekZGUTRGOEJaMXN0clFvRTFZ?=
 =?utf-8?B?RkdHdjRXUmhRQldTelR1SXlqeHRKS2x4Nk9rdWt0b2g4RkFaRFBVWXU1TFhR?=
 =?utf-8?B?ZHBlcjhkYkNmd3FVdEQ3SGtveG1KYXdpMTRHRlFrNmdkYUJyckRmUktwaTBJ?=
 =?utf-8?B?MWI0YUl2OTNqTitmTEJIazNuRFR1Sm1DWGYyK0g5OXI2Ykc4MmV0ZkNWWjJj?=
 =?utf-8?Q?DYpzmOy0eVHhQpqI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d635491a-7039-4cc6-1aee-08df23a49aff
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:23:19.3784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4D5zvpTpVa8MumJxXkOMc2bF7w2y9WMUgjRkiTOSt6MdBiLKxGklddcSfrUhiGUMsGoOgle5dsP+jnCArIxFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9045
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

DCIF is the i.MX94 Display Controller Interface which is used to
drive a TFT LCD panel or connects to a display interface depending
on the chip configuration.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 .../bindings/display/imx/nxp,imx94-dcif.yaml       | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
new file mode 100644
index 0000000000000..8894e87666972
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2025 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/nxp,imx94-dcif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX94 Display Control Interface (DCIF)
+
+maintainers:
+  - Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
+
+description:
+  The Display Control Interface(DCIF) is a system master that fetches graphics
+  stored in memory and displays them on a TFT LCD panel or connects to a
+  display interface depending on the chip configuration.
+
+properties:
+  compatible:
+    const: nxp,imx94-dcif
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: CPU domain 0 (controlled by common registers group).
+      - description: CPU domain 1 (controlled by background layer registers group).
+      - description: CPU domain 2 (controlled by foreground layer registers group).
+
+  interrupt-names:
+    items:
+      - const: common
+      - const: bg_layer
+      - const: fg_layer
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: apb
+      - const: axi
+      - const: pix
+
+  power-domains:
+    maxItems: 1
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
+    description: Display Pixel Interface(DPI) output port
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - power-domains
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    display-controller@4b120000 {
+        compatible = "nxp,imx94-dcif";
+        reg = <0x4b120000 0x300000>;
+        interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "common", "bg_layer", "fg_layer";
+        clocks = <&scmi_clk 69>, <&scmi_clk 70>, <&dispmix_csr 0>;
+        clock-names = "apb", "axi", "pix";
+        assigned-clocks = <&dispmix_csr 0>;
+        assigned-clock-parents = <&ldb_pll_pixel>;
+        power-domains = <&scmi_devpd 11>;
+        port {
+            dcif_out: endpoint {
+                remote-endpoint = <&ldb_in>;
+            };
+        };
+    };

-- 
2.53.0
