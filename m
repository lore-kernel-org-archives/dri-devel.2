Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792C606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=keYoyFb5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F4A10FCB0;
	Thu, 19 Nov 2026 07:48:46 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC60010FDC8
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3W9Q+fpwCaEWu/i7xLgqhSsXPm56T3qic6TbVp1ld3LPiRYv//FsG7h5ynEL10gN8D+RtuKjNP2kItoRNDFpGwVOncgHIm2ZiTAhA5NjJseXfPsBkFvI/YXsH/JVWQdraPvs/30R3pDEMlI/yTfONDQ7bTwsZiYMc6cOHEiFyB43E3WGK93/XQNfRLnvKe3BNi+rpfC2i3n1oZHmbvHfbcz+pJotDl34QVxY3y2HiOtxYwLmZBI5/iCtlh9XgqJTixkPIy0YkWp7V5/g1B2ADMDzOIwIi87Hi73ltUP6Z0ChKX0uAfVzg0lF96vFPjjJucfDSK34tCZGFOGnFlYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnlzQemMYPdDE4TpeTCi4bKBa01Gzgu4cFhwcV9LMbM=;
 b=kCFd4dNiS8Ar+xWft2D378wtRr6X/Sc3L0Cz8w1afV4c8IV0FHDOhSRpMPl0ROLjdh+Bsto2nhLvP1iYq6pOIq46w9GdIo6ys7Osn50DCdOPOHevbzzHMCzPa9g8D6MJXXsbIyJO/4K7NIb0ESoCbCrI+pUaaTpah5fGuI4DAuMyAaQNdRwCT3757V8MA3WeA19CeMCsY2uI9qa0oY8RI3uV31T51hrKW/2RRDshZXWRJdaf5+enOScJFN+8fzOi2je6PGxnJ5/zDg5NvMm4gTccc7sxsVwHFGptG+tUnEBkeri2Y7vlKiC+iY8vQqSYyDgeRf7CFyQw3XMZ46/aAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnlzQemMYPdDE4TpeTCi4bKBa01Gzgu4cFhwcV9LMbM=;
 b=keYoyFb5LHaQb5DUK2tU8K54moU4/ghaO1G7RoxuQZrV5rRvTUJD82EETl4bcMDvMaQxIeBS0LCEk0cY3uzvibLCROanhjPQElypcY9d4EgU7tD0bkm3bzPq3ruj7dQk5533W73h857KXDwfs1EADhiZoYXK5icv/+UnEzuTP3Ke12kwuJGWm8bN4vcEvahWJGZjExpz8r3+8lqjDCqYp4PAlLrTtQJw7b/K2jB2ZZlQNCjhQJRYaI6i+6wpWVRWOkbZNfJMUjlC8ZzdBEFd9LzUWm0nt26w5oG0+8SLaUtW/b7HDxH33CJlNk0EElvQpRMSDKTcVxz9uyBISnsHsg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:22:10 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:22:09 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v12 1/5] dt-bindings: display: imx: Add i.MX94 DCIF
Date: Wed, 18 Nov 2026 15:21:52 +0000
Message-ID: <20261118-dcif-upstreaming-v12-1-29b35e27a1cc@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118-dcif-upstreaming-v12-0-29b35e27a1cc@oss.nxp.com>
References: <20261118-dcif-upstreaming-v12-0-29b35e27a1cc@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0018.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::23) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|VI2PR04MB11276:EE_
X-MS-Office365-Filtering-Correlation-Id: 23766ea5-2725-434f-19b2-08df4587b692
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|19092799006|366016|376014|7416014|18002099003|6133799003|22082099003|261009223027099003|3023799007|921020|11063799006|56012099006|261028144727099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261022075727099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: SW6O+mwdD3NarMmMUXaScRoTbv1gjU5A5v60bG5EKSqybwiDlGOyQCh51j5hw+ai3dwlRfCre7mGld+ufZ9TldfbIncDjXcV99RdAYC0u9zE/6JpquR8VUul4LfDMIGTy4eKXTG+8wEZqAZXlSAdSfjYoJXz5YIo4MtALKSZF/XZVb1OQNo3R6C7lAZQi5rkNdZFXkrvV4+BeG3sKRkoKJS2sMUMkc/oJrlT7qaQ9r/2vkTLas5M9COpLJBW82m2125Kh9Co2hem57Gq1Az7kFL68wQ3nnf2OxY8QjBPZo0DGyZwoGylwyrdxOLSZxnVWOsJKEiLuXGpDWaFV6hdOGiwMsg36rAhnHD0aSSBAYJUTmLLgLkiD1aD0OjJ2veQ9tm6jiSZGJ/Qv+9fv3X0Ml8K4WUgCglpFwkdIggs6c8TkJRq96SXU1Vl32DSTR6+VUMZ7+Q/cV23eQKNS4EhTyGhVlgElLZXAZmZAy9zO/PQC2my6K7vLUh5RT6iAqCNNp74blnxw+iyPUj1+yDqdmMCmnvkm0J0W/o8aORl+caqMptBXQ1RyfDgOUUtxGxaT5fDoKIJ5ojymhS/L1zk2Ch6daxSouKUeDM4nEiwCOig39qK8813o3I2GP4f0eeIGBox2qVyvi+nxb1gg446UQ3iYmaeJkaQXX9uGwKRYl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(19092799006)(366016)(376014)(7416014)(18002099003)(6133799003)(22082099003)(261009223027099003)(3023799007)(921020)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022075727099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW5UcTdQbXI3c3dpc05nK1VYMStUUGJZT09LTjJPdnc0Ukd4UE50RXpYTWV5?=
 =?utf-8?B?cEc3R2dRc3N2VEcxd25wbVRoWXhVQVRDYThvbjBsZWQwakdKaDlJWk1Xakxp?=
 =?utf-8?B?c0ttL2JodVJyQ2ZGS2ZFSEs0aDZjbzdmdmlBY0lvT0RUcDRjM29hSTVjdDkw?=
 =?utf-8?B?MVkzRkpNRzFHR1JybGl0N2RZOUNlR2NNVGxRZHJ4QkkvaFlVUGZyclY3Mk9o?=
 =?utf-8?B?d2dhdEc3bFBhRVJyd1kwOW9rREFUMms5ODZYK2ppRVZqY0ZYTXVzeVVpZm9q?=
 =?utf-8?B?ZnR1dHN6NEsxVTJvMGNqblRTODhPaU9OWVpUTU8zZS9tS2QzUHh6REZFRnBZ?=
 =?utf-8?B?Q0JGRmFENi91VVI1ck5uQXFyTkRsNXpIWUxqQ0hKWHRsUEVRQ2JpMnpTVmtk?=
 =?utf-8?B?Qzc3RzhRbGRXSlJpTVV4SE5GYnozbkZRdUZWbDVOZEQ0RWd6UW0wdlIxajYz?=
 =?utf-8?B?eUVwbk85akRCT2I2VkZxcHUzcFBJQ2tyaGhVclJuSytUbElZMkdZKzk3K0hD?=
 =?utf-8?B?YmxLZzNYRHVZMExlWVBNT3YvMmxOU1NzNkVDM05LZFlBdzUvVVNPOHZXTmRT?=
 =?utf-8?B?UE5EK3Z2ek8zUWhOcDVzTk5FWEVGOGl0bkNLOW5ESzdRL3hyaXozcEpUSmZI?=
 =?utf-8?B?VHRFc3h0a0M1R04ycHBjQVVCWTRmQ1RPaE5TZm5uWkxBQ0dQczd0WkIrREdB?=
 =?utf-8?B?ZlQ0d3FNKzVheTNObVVKU1QzTzA4Nkk1MVMvd1BGNi9CcEJMQ2dYb05FUWps?=
 =?utf-8?B?VjRYZlJBQWxpVGhFZkFRTU5FelU0SGRaRUNrbGJGN1ljeHZKbXdDdVFNM1hl?=
 =?utf-8?B?VmtIbUx6R1QwdzRiOTZyNDhHdEZLanU3dG1aSUtOc3d2RnRoZ3FSRjFYRFRm?=
 =?utf-8?B?eG1iNmo4K0E0am5SdEVJNk96U05UK0Nwb1VlZmZQZ1k5MW5ZdzgvbjROemtL?=
 =?utf-8?B?OW00ZlNnbGJYbXZyUFU4NFVzd2RScW9GLzd4a1MrY0g0QUEwQjdBRm5nK1VD?=
 =?utf-8?B?MllobWY2MUNnaW5ORUZ4dTYvVGUwRGhmYkptNXRoSndhbVRPYzV3VXJFejhH?=
 =?utf-8?B?YS9MaVRrRzdkbHVWN1MyS25aQksrM1pRTUFYK0JUWGdwam1OY25JTXRNRkph?=
 =?utf-8?B?cUVkMW85MThtVnhma2kxWXNFcGFIOGZjb1NxaVowUkxtTTFtQUgrclVIcUlw?=
 =?utf-8?B?cElXbFFXcUVoNERObUw5bVJGWjRwOUQrbVMxbUQ2YUNyV1Z6Q0VOOWJZeWlY?=
 =?utf-8?B?NUwwQmpZSlZWN2xNSFo2VGZkNUpYUkc4NXladjc5OERETHVJeWFnK3BIS0I1?=
 =?utf-8?B?THVpVTVhdkt1T0x0clJqcktpQzlNUDNzdUozY0h1OStuL1lOMDNlQWlRT1Rw?=
 =?utf-8?B?cEdSTEpWdHR3aWY0SHNwVkR0TXlYSkRUOElOSEcxR0x6S3hRQXppLzArVkJP?=
 =?utf-8?B?VEdIcHVYYTBDWTFhbm9SL0l1T0F4a2ZBUXRCaGd3dC95bng2OWM4dUFrYnB4?=
 =?utf-8?B?Qll0eGtKd3hZZXBCWVhBM1cxYnFIWjZITEdtcUQwQmwvSUJVSU5jNy92Qlps?=
 =?utf-8?B?dlFzQnNVNnVOdS91NzhDWjkwd1c5WkV1dmk0alk0Sm8zNHZJd3ZqS3JUL2Mx?=
 =?utf-8?B?UkhkdnpHZEdyc3VzdmwycEpTRnlCT3Q3bVdxUzJxUUdKU1Ewc0xsblZ6QnJY?=
 =?utf-8?B?RGFPSU1JcXhUZE1JVm03Mkg5dGdUQmVXcjY0TGd1d3czNUIrb1hBN0hZVzRr?=
 =?utf-8?B?amdxN3Z1VDFic3RtdHN5cXB2U05oT0cvbzhCQW1WdnUrYlU0U2puWHlkVG52?=
 =?utf-8?B?SEtvTFdZVEZDQzUxTXdBNXliamIybW1IYWx0NjJVYmN2WmVzVmdxK1EycWRH?=
 =?utf-8?B?Y0Z1VkZxSmUzNFF4Rmp4cWJSL0t4d2RweTdOMzd4L1FxakZ4QWNVdmdETlpK?=
 =?utf-8?B?Yi83SUdONGI3TlFEK0tYaWREdDlNUExySHF4NjNjVktYRS9JQmpVZkdVYlVV?=
 =?utf-8?B?UEVhTE5XOVVZOVlIQWdhMzNuelNHeWVvcjF4NzQxWmhQV3Q2aGJCWklkdENM?=
 =?utf-8?B?bnAyUER5cGdnTTJqR2VSR0pybGhEVURZZlpqL1RsTkw2ZjY2dnN4aUwva2cw?=
 =?utf-8?B?UTBQdzJKNGdDY2VuWTBEdk14dlRZQXl6ZzBxUzI3YzZDZG16cllnd2JycHlr?=
 =?utf-8?B?ZTlab0lnNXlqUEl4SDZuc1pyUnBzQS94UHpNODZxTmo2WnBuaDdPV2F0S012?=
 =?utf-8?B?Nkd3OUZTUWNZRWYwMVpwSUZ6WS9TL0p4QXp5bjJaT2RCUFN5d0JkZzR5Ung0?=
 =?utf-8?B?bUV4SDN0MG1ueDEyVDlzZkhDRWZwd1N5WWV6bFI5cThCUG5PMVp5K2VOdGRU?=
 =?utf-8?Q?nJwxzs7352loCR4U=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23766ea5-2725-434f-19b2-08df4587b692
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:22:09.6800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEHHNKuKrWhsAOKlGVyZuDCEH0vRDRZHG6wAlOgaNocPFwpoM1fN9UGaYHL0HQCLPsDOM/IkjQR5rhrQ6KC7Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11276
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DCIF is the i.MX94 Display Controller Interface which is used to
drive a TFT LCD panel or connects to a display interface depending
on the chip configuration.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 .../bindings/display/imx/nxp,imx94-dcif.yaml       | 90 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++
 2 files changed, 98 insertions(+)

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
diff --git a/MAINTAINERS b/MAINTAINERS
index a13f523431ce6..5ed9a87330229 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20405,6 +20405,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
 F:	drivers/media/platform/nxp/imx-jpeg
 
+NXP i.MX 94 DCIF DRIVER
+M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
+L:	dri-devel@lists.freedesktop.org
+L:	imx@lists.linux.dev
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
+
 NXP i.MX 95 CSI PIXEL FORMATTER V4L2 DRIVER
 M:	Guoniu Zhou <guoniu.zhou@nxp.com>
 L:	imx@lists.linux.dev

-- 
2.53.0
