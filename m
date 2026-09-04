Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26BDC79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F4F10F8EA;
	Fri,  4 Sep 2026 07:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="XarL2iiV";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010007.outbound.protection.outlook.com [52.101.69.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE8310F8EA
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bI44ERyVAQiuaHkmUn4Po/RD/iEFmqSiqB2woHqRsJKWJBC9mfLO8zkM02JBY3ns7m44xSVGDaW2lIu7/iz+aLgNFAvDMJaZptdtQ+DceJLn2QcvwbGCP1jE7VYhkI49RFYR+73CU1ULltfyLAWcsAcIs0mGF07qOqPVZjqKWPxFDXONnAgBIadUPnT4lG3fM3TQEc/rS9nghEG/UtjOtRTycMyAoG4OclhyohAKKQbOZvZZCvvjzf7IyoinVINh8T4HNTsILqQ7W+A/UnduQ4Cf4BXV69jbLifiLGnOBwjQvOR5orvpXZW8H1899sigr1aklpZogoBodNaLGSc6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YvI4RqWyUvyMuZQPYn66/KmCb3CrJ1pQZO0Q4h2j4M=;
 b=VhkHgZhyXhbIA/cjQiZb2OE6cPnVeSIHEp3kEuxJgFsNL6RGVZyy2zAw09jgG0I1nSRcmH/S89T3re7APDGPanGbMXouDE48pWomj65/HRTDw/CAGCeYoE8EEEvIaZaJ9eSiN1/+bCn7ljaI6pmUXrQliPUkhP4PhIg9QgkaMKvcYQgN/PnnDnf1V7OkDW7TfPeTTkTPDc+5rWCM/d4kTUzzlut+uC1ZkWBG/UqGY3I5d1vSAvDUIvEcCq+2weeW9mayxoSoibGfSzZQnxkIW442CCK6sKHkzqr2Ri6hyMoZJQSo7nk7W/0uxpnpfseLLc6PGjcuBJbuO+jKpb0SBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YvI4RqWyUvyMuZQPYn66/KmCb3CrJ1pQZO0Q4h2j4M=;
 b=XarL2iiVKSHm9TnXuHvi9+cbW7xkcMGeS+HhREZhsnOF76l7SFefy7bapDm1irNBHMW9F2dh4EII/etwIGQ9hG4JzLVkBLZj0vh0EaFA05qXfmFa+iRpgxp3pLBhujA0mU6Y0VIhAlSipUPjoFgUvGQQVjTVN8RvHI5oVYKAfI3ZswP6nHKmB3BVS0Q7z4Qa+1cOKICpVOlx2jmhzm4o9kzgaV3as5As9WeUgotZfBM/HsSzHkbElH2OY6NIqimrqCX+EjdPhXsar2dxHg7wLDuKacssNwLvFDmZXcrVs6Ayfm5QbjTS3LdCBWbjNxGeqtuo/H8FBFVTLiN1HXP9pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AMDPR04MB11702.eurprd04.prod.outlook.com (2603:10a6:20b:719::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:53:46 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:53:46 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 04 Sep 2026 15:54:52 +0800
Subject: [PATCH v6 02/13] dt-bindings: display: imx: Add i.MX8qxp/qm DPR
 channel binding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-imx8-dc-prefetch-v6-2-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
In-Reply-To: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI3PR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:4:297::11) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AMDPR04MB11702:EE_
X-MS-Office365-Filtering-Correlation-Id: 750f0c5e-eccf-4717-453e-08df0a59a5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|10067099003|3023799007|18002099003|56012099006|11063799006|22082099003|921020;
X-Microsoft-Antispam-Message-Info: tmt2p0nRBFnnYakBwnafMdMn3dSDFxsAZ3/Sd2c4FqQdCNgloShnLfFKgtAgpqPjM8AI4wHBHBlvbD867B0V+WiSC3TJSTaMwIJx4Qp95P2sz7XzkpAW2RArO+fgbyHQSQ4xM4mpGh+YqA7BCcoMhvlcd7I2RsXPAlI9YY+H+ShlHWEyCJOnjSD0Ncpiy+ZjmBxf6QYXcuakiRRhj4dUeSfeTCrThsyGawV+b/OsBoKKt+ArI2O4UuQBzrht/XXs+Wwnsmo7o6Bi4KFmilLfKdzTaVyUhpt/OthtkiueIAFL+EJnNtr2X/UcRIqLxuufm0+bCrw+VSVO6ffSldXitEFpHLETmJz6QiM2J+kH5w2Z3EPihMGt2rtYyFJwpdATRO1Gj49DQuTYXhiiTMpRamRoRzStz9lDS92AeHFhfDREX9vsmohHQMSPdv+R3TxGm6Ey0/A5yk+6g28em48xkp9Kp+YexK+5OPHSd8pRfRxjEffajvarIQJF8tbUTIt7tFvRp8QpYZ9I/jfkEi8HaDbbnbj8y13InemkqRlcPSy1MG1uCXxTRVvirOBrhJVWrQIuwmvLoF+OAG077GlYFwfsTmEN+sPS9RtsvE3gSsCNgv8HFGOiGODQMxyW803QONvGyAPma60uAzjN/ZM5a0Mp8GTRCXBBIspUNxf2dYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(10067099003)(3023799007)(18002099003)(56012099006)(11063799006)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkZlYktOcEN3VUppd1dianpDZjVsQk1VSCtUOUkvbjRGUWQ1aEdqK2E2NkpM?=
 =?utf-8?B?Yk4yV1M2M3VtejIzU2JYeTRQWmRpMThmUTI1ZGtyS0VsQklTMjYrRG1OMFlJ?=
 =?utf-8?B?MDlLQ055bGdRaW53L0JSMm93bVdZUnp2RS9jM1RERFp5eE9mMVRQZ0MrZDd0?=
 =?utf-8?B?MGhteTRoVjhxbXNsOWlWQS9jdUMrci9yeTBCb3F2MUtjUEE3Y250SS9zSHpx?=
 =?utf-8?B?YUZ3MFBHMDhQYnBMQlR2L2s5ZHFOK1grWWt4NGI1cnF2QXhlRXQ4VmZSUGJV?=
 =?utf-8?B?ZWRNWHRvWDlsdktJaXF6cTBoc1lublIvWVU0enhDK3diSkV1bkQvUnZ2cE9T?=
 =?utf-8?B?OUw0MEN4SGcraWZWaWZ4bGt1bVo1WDA4TUR3RG1JVlhFeUFXOUplYVVocGl6?=
 =?utf-8?B?OUxyd2ZKOTN4RXBIUHdFN3IzamNYNXQ3MEhrR3p3NWVseE5ZODU0QkRNYm1w?=
 =?utf-8?B?a1Vwbm9IUkVtcC9NaHprMFpReEh5dHVOeGljckE3Q0pvUmNuS0RZS0N2aDJF?=
 =?utf-8?B?MjVMNHNUcldDNjF6MSs4b3ZwNGFiQStjLzBCa096UUhpN3prT29MTnZDWElO?=
 =?utf-8?B?aHJqNFNjc2ZVaUwrVnpBUG80dlVsV05xNVFra3RCU2hzTkFubzVIR1BHS1Fz?=
 =?utf-8?B?aG9DTEZta1BZK29RUGtmVUNHSUtnbmd5aXpSL3dTeWl5VGVlN29RMlZTenF2?=
 =?utf-8?B?dGNiRnVXLzU4aWR2T3N4Zy9ZSFU4bnBIcjVQK21OWWlsMWNncWdiMkFmTlJu?=
 =?utf-8?B?alZxMmVXTVlVMlk1eUVqQ0pOKzhkRU14ai9uL2ZtcEV4WlZlVjFDNW9Xa0lx?=
 =?utf-8?B?dE4yU25wajhmTFdrZGJrekpIVEZpN0V4aTlYaE95dU4vTWpxejk1a1RQL2RP?=
 =?utf-8?B?RFl3M0tRSFBGUS9DakxDQmp1MHZYZHpXUHpMWVJrajF4azhZd2lxNGpCZlQw?=
 =?utf-8?B?bVIxM1hCbmVKYzZwLzdpYjliY3NuSG1vdlhTWENsUldRL3ZYbmk4Umx3aUxo?=
 =?utf-8?B?MUhNMGNYVE9jVS9uZk12Vi9FNS9DTDNkRWt0dE5SdGhpYUp0OHh5VHJBMVdR?=
 =?utf-8?B?T0loV1I3bUgzYngzQU9hL0FBSFRRRUZhWFNIVXRCbXRJTmhiRFBPQWFKR3Rt?=
 =?utf-8?B?ODU1dzJMYzczNTNSTThZQWxiTm5mS3didGdtQjh1UmM3WTVuQ1pueEE4WnFF?=
 =?utf-8?B?VWZxZjlSMVVSWmdCQ3dhNWlXMnE4KzRYQjQ0ajFzSkVLaU9ZVmZuelRFNjA2?=
 =?utf-8?B?dkU1REhMcUR2dkF4bldGVGFrTFk3NWZnd2V3TE4xTDNuZlpCNk1MekI0dDhT?=
 =?utf-8?B?dW10ZzdNZDQ5L21XRTE5cjEyNHgyMEJ4K0ozYnM5SjlTOXVidVlDbjl3QnRq?=
 =?utf-8?B?Z0VGMHZSRVcwUWpMdms2MTVBcVRkN3JkSzluOFQ3NURkcmszY0VIb3QrN1p0?=
 =?utf-8?B?Y0lhVnpTQVE0bGdUQkNZTWlJQTVPQ0JLOTJVRU9jTEM4RGNFUTVMU1Y3MDhN?=
 =?utf-8?B?cGFudjlCZUJ2WlRxdmxUQjdtV1c3V05LYVpkbWdxUEdtaExxQWRkVHJVaWow?=
 =?utf-8?B?c3AveFFIZDFIRHFFSDF3Sm1Majd2ZElIcVFIQzBiRzR5SXNiMkF3ZVJDYUNq?=
 =?utf-8?B?d0hpQkFieElKanRldk5tUDJqUjBEb3dvWGVLc0ZoaXFPY0FYRWs0V3B2Smth?=
 =?utf-8?B?czFzd3JCV0ZYOG5DZk52enkvQThYbURQT1FrTi9TZS9rWjF0RW5Sd0NJWXU3?=
 =?utf-8?B?TnBoMmlvemtmK0h0REVnM1l4MktpYTJkUytBN0Jlb21EOVZrVkU0WldrMTlZ?=
 =?utf-8?B?RzJrc3czN3RocHFiVGVxZk9WWWNwTUtMVVFRZDZiWDJHdHJyQnRaaHVjKzBl?=
 =?utf-8?B?WEt6OE1hUksyMG9nZGlNRUt1TjZNMTBOOXAzWGIzNjVwbWg2RXR6NFhnSjdQ?=
 =?utf-8?B?SXBER3NDU1VBNytJUm9qamUrYVQrZ1BiUE0rM25HODV6aSt0ZGQyU3F5TnVZ?=
 =?utf-8?B?ZWIyUWtOa25kejhtZjR4c25LditXVk42d2RDUWxleWpveW5nVEpoOXJjSVk4?=
 =?utf-8?B?aVplbXR4VFlYbTlocHN2eHYrV3diQ20zcUF5R0dBUmh3bE1HVjRXRVpEU2lP?=
 =?utf-8?B?bkZGblE4bGlrM3JjcjZGeXBvMGVlZTBlNWlzMnc5RWV3dWF1dEdVNnVQbUJ1?=
 =?utf-8?B?VUZ0aW1Ta2diMkp6amNveW1JaXdjNFAzUjY4Q25GUE9SeE80T05YN1NPZHhS?=
 =?utf-8?B?YUJTeW1yR25ycVJLSDJrWFpUZExtb2oybVllSXQwajQyKzM4SlVnVzFZUWFt?=
 =?utf-8?B?UHZsamw0dEk2dy8rUXMvbjhJMnloQ0Rxbmc4YUhvbXEydWxOZ3c4UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750f0c5e-eccf-4717-453e-08df0a59a5ee
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:53:46.4667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsXO8PNuDjnbWUG0AGxc1e3pYPAvpG5Qos42MaD5lj9CYPCjBp6uXwfu1/m2fcPFLnFdCGCDugyk5vZO2ruMgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11702
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

Add bindings for i.MX8qxp/qm Display Prefetch Resolve Channel.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Changed commit message to use imperative mood.

v5:
- Add the DT binding file in MAINTAINERS.  (Krzysztof)
---
 .../bindings/display/imx/fsl,imx8qxp-dprc.yaml     | 100 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 101 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml
new file mode 100644
index 000000000000..bd94254c1288
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dprc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qm/qxp Display Prefetch Resolve Channel
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: |
+  The i.MX8qm/qxp Display Prefetch Resolve Channel(DPRC) is an engine which
+  fetches display data before the display pipeline needs the data to drive
+  pixels in the active display region.  This data is transformed, or resolved,
+  from a variety of tiled buffer formats into linear format, if needed.
+  The DPR works with a double bank memory structure.  This memory structure is
+  implemented in the Resolve Tile Memory(RTRAM) and the banks are referred to
+  as A and B.  Each bank is either 4 or 8 lines high depending on the source
+  frame buffer format.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qxp-dpr-channel
+      - fsl,imx8qm-dpr-channel
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    items:
+      - description: DPR wrap interrupt
+      - description: |
+          'r_rtram_stall' interrupt which indicates relevant i.MX8qm/qxp
+          Prefetch Resolve Gasket(PRG) or PRGs are forcing an underflow
+          condition in the RTRAM.
+
+  interrupt-names:
+    items:
+      - const: dpr_wrap
+      - const: r_rtram_stall
+
+  clocks:
+    items:
+      - description: apb clock
+      - description: b clock
+      - description: rtram clock
+
+  clock-names:
+    items:
+      - const: apb
+      - const: b
+      - const: rtram
+
+  fsl,sc-resource:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The SCU resource ID associated with this DPRC instance.
+
+  fsl,prgs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      List of phandle which points to PRG or PRGs associated with
+      this DPRC instance.
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+  - interrupt-names
+  - clocks
+  - clock-names
+  - fsl,sc-resource
+  - fsl,prgs
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    dpr-channel@56100000 {
+        compatible = "fsl,imx8qxp-dpr-channel";
+        reg = <0x56100000 0x10000>;
+        interrupts-extended = <&gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+                              <&dc0_irqsteer 324>;
+        interrupt-names = "dpr_wrap", "r_rtram_stall";
+        clocks = <&dc0_dpr1_lpcg IMX_LPCG_CLK_4>,
+                 <&dc0_dpr1_lpcg IMX_LPCG_CLK_5>,
+                 <&dc0_rtram1_lpcg IMX_LPCG_CLK_0>;
+        clock-names = "apb", "b", "rtram";
+        fsl,sc-resource = <IMX_SC_R_DC_0_VIDEO0>;
+        fsl,prgs = <&dc0_prg4>, <&dc0_prg5>;
+        power-domains = <&pd IMX_SC_R_DC_0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 62cf71b3cf4d..2a13221db132 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8793,6 +8793,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc*.yaml
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml
 F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
 F:	drivers/gpu/drm/imx/dc/
 

-- 
2.43.0

