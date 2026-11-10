Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C73606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ps3Jsxig
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4635E10F735;
	Tue, 10 Nov 2026 14:28:41 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EBD610F724
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:28:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rI1Q0hsPkGlD1f1QgMok8RknQXTkWSOXfxS7cHos5q+R1RBkhqACpXhUztgpfZwT8PrsEiCuCOgLbEsfFeiLICnKdGN7cm+fsymec6QQr9/Nv7qrvRzXoZ26nZAJX1NNPrLexd3juu8AZ23/De7IiIoNZBFdudGcagcPs8r77lwWH0poz0fPJCe19uJZmf4TJE1EJGmGX1zf/sjVjuggDzQNzFW8C5DbFGsxsOcZZRvsmzxURRxgrj04dTGxHR3Q2/4TVaLKy8pAdyOQbUYGv88U/s/eiDFuqimedafiskssM6QUq6sAbyxSpGQ2JuFlpozmpKyhuItDZXwcG+CyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geLk9yqTL6BPC1fU9rHrHg0rT70JNcIPxVSOK5QzlAs=;
 b=MlpNmh7eZJI6BkAqvSZhuwF7lBwI9h/QWPMABwVlQ099QHfFQKsB0va2lD/JcKk2XPJ8gD5V6FqsC9rwG2KJLiRNB89VQzx2W8dZeuDncTpOlTLJ0cheNEpiDyDUEQy4qAUDb/VKujrFcAq/Q91hVSWTaMDspLvr37fb0aNmdomyzkyWrN4QroW97n3f3C0C2vhvUCs43fsjUYiqiPysNCkeB8sqIAZQZcoUQhLUavQAzkxccNwa8u3RHxVYIOggoGF0933XXHNniYKJVla800PIJq2Z4m5RwbyA9BHx6v8kKGhnS6LBrtFMOI0m9VrjfaBFBHuBRrbE99mVP5pSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geLk9yqTL6BPC1fU9rHrHg0rT70JNcIPxVSOK5QzlAs=;
 b=Ps3JsxigxMzYB2s4XzO5WB055vmt5vtdb5NihHTN7CXWciSX+UsLr9ebnx+PlvKof5t1dqNBBC6J1Gd274ufJGZQgq95e0kEqxWCx6WXfV4g19e19CqzJox9mWzn+gkySkyu04Yco1vqXLPgMOrrT6zvWN2v0WNJnXFsMWkesRXpAvrv6GL7YmcvHObSn+iZatkmyZL8ZInc3hksoSUSpw2bOM70AZxRWi9tYrmq23+qq7PjsZ5udnygwcUkdpM69+KVRCLt/UyXPUcHQMab4lks8DBKWoB/q6X0ZKfC0AaS09769oYWrJ/aW439fwgvItRw7CMnYfZz5HGVwVqjuA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by VI2PR04MB11196.eurprd04.prod.outlook.com
 (2603:10a6:800:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:28:11 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:28:11 +0000
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
Subject: [PATCH v11 3/7] dt-bindings: display: imx: Add i.MX94 DCIF
Date: Tue, 10 Nov 2026 14:27:43 +0000
Message-ID: <20261110-dcif-upstreaming-v11-3-9e13c85ae0d8@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
References: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::7) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|VI2PR04MB11196:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7df8d3-553d-4266-1c3d-08df3f36d944
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|19092799006|921020|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|261028144727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: kfAWNFGNGPdsONDINnA9Mgmor5GhKXqyeCzCpWermdN2Pu1/+D/AwR2T9HUgR69WFrWb7XuKH8x2SRPZVDyLWEu/a1gm5yBhPMqS0YPqvUZ+ZcP84eST/Y5ACOSDId1gXx4t5P7wuBEMiWC2XchpkTrRPe+85N9FuBYT3IEacL95oV2KhMqK+V4DyeG1plV+hi9aY6vXpCVq09MlG30muN0tnjdim5AyDpAlI8lBtf8XpYiUFR6otkYkRaRhhzceFnAgq5K/o3blfyBPKECSwQlWb6hyycYbmbgjVhsVA4WPS/mvgDJsRd3BBufowqVlDjKKaIQhhYp6TryMNjplZ2iQMELC8wh166js6lLHQL3WcXH3T4Ew2qKX2/b9ByLh18xRAjHeDg5Coeipv2jErrHhFxOPJ6CHZM9SoJhEaeotY9APkAFu8lEGJxbOnyPDH9ChFbXU3E+YBl7qRc3uNhb+MYxO5PtSFbmh4mmkwHtLdDHJ1hqZpESpNT7BwbUFRnye4hcID5E/PSnlnHhHtaItz7XDa/VFwDxgE448kQWPDNlRsr01xd1xHDBOk2I+UmfnepPZIyK+9aR2dubP6zShAlpQs+RqwwGiPOi2Q+KD6RRRTzCK0JLCPhJp+5VNDzmfGA/VgOZyZOvWXYkdW8+mBM/bLybpdFQdtB2z7o0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(19092799006)(921020)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWk3U0NIUEZEMmFLbFZkSHhFUlJ5eTJGcEYxd0dLalpCNVlJZVgzSHg4VnMr?=
 =?utf-8?B?Z0Z4L0lVdk1xMm5RdDJFUnF4RnBJSmo4Zml0a05qMDBUd0duNjhncHVpbnZB?=
 =?utf-8?B?ZGUzOHk0anEwQ2wzU2FYNmxhZkZXV0N0d1lRd1V4RzlybjdINmdlczhqV2hL?=
 =?utf-8?B?NzlqQ1V1TDdJbjRHNUVQTlR3Q3lVbm44aWI4ejNZZkhScGV0MFdZVy9tOGZE?=
 =?utf-8?B?eUV4bXg1QW1TRmJpU2dSd2ptMnFJMHdydWZqVHhkUCs1NWlTQ1J2eVMxUzdB?=
 =?utf-8?B?ZnJuOVhGZ0k5NDdERUVtOHQvTG8yaWxyV2cvU3c2K0d0VVFJTjZJQkx1c05B?=
 =?utf-8?B?akdCL01TZm9IZDVxL1dUeklhc2dxWGZKVElkajlqUDg2YXQ4dGNGNXI5QXBQ?=
 =?utf-8?B?NUI1M0FTcDNOcjRYaW41VE5PK3B4Z1lpZVJhVUo1L25EVHlHRlFMaWRHZVk5?=
 =?utf-8?B?dFJsMG9KcVNySzRvMHV1TTF6MkxhNm81SGxhbU5SMTluSkRKYzVQN2VqN3pU?=
 =?utf-8?B?bkJHUXc5WWNJalc5YmxtNzJLRThGSTY3WGF2WW1RejFIcnNpOVdUWi9uZlpQ?=
 =?utf-8?B?UTZqeFdsRkxLQks0U0J3ejZUd2pjZ1FVdFJkNVRKZnlqT1Nkc0swNkVaNDFU?=
 =?utf-8?B?VitReWJzUnhVeGMrRkpCNWVZdzROcFZ6amt3NTRVUUtGRi9BSHV5eGFqTTVW?=
 =?utf-8?B?dXYxNHJBWTNpdHVJSm4vOGMzbTlBd2dHWE5zOWdqN0hmS3RsUXQwV1ZDVnYy?=
 =?utf-8?B?Yy9OSkZEczl1dG5yY3NkVWJkUzBtdmM5b3pwQ0VkVVVDQ1JFNTk2cWNiS2th?=
 =?utf-8?B?ZUhRanY2WmFxTkIvQXhUQ2hCamxVMUpjaEI0aGhzSUdsd3VXSHM1ZHRZNlhs?=
 =?utf-8?B?YjlJTXk1RnE5d1l2SmFhRkpyaVhITktQSjdYSm9SRHR1RW81TExlcjByaGtp?=
 =?utf-8?B?T0ZpTzVzdmtrcWRDTWMzRTY2bHFKaU50dDRRWkhxTFdRdGxXQ0tvck5pbm5Y?=
 =?utf-8?B?NG0yeEZvN3VHT0hObzIrS2cySTVpdVU3WE9BdCtFOVFsS3R1L2E1K2hDY0l1?=
 =?utf-8?B?NExoUGpWYUpWNy9rbkcwQWxnb1IzcU5UbDJqT1BxdDZSdUJBdGRsdGRNWWNy?=
 =?utf-8?B?dXpJYytwa2xwb2ppZGpoQ2R4Y0ZFNGV5TDB3bkNzZ05Qem5IbVF1aWJJSlFU?=
 =?utf-8?B?YVRUSWgzaTduVG1CdEpwaHg5MWZZWjlLQW8rc1JPK0JHbW5qVjV4SEYvb1RP?=
 =?utf-8?B?Mnc1YitSa21URklKZDNqRDNqR0k5dXBLVURBZlBxSHBwcERoMmRTblZXSk1M?=
 =?utf-8?B?S0R1OVJ1SDRvUCtHUzQrbktkUmxrWElvb25kVkxyQ3hDOXpKM0JyZWx1WStT?=
 =?utf-8?B?WnJmVzM1VjNrYjVmMFBCY0xHVUN1NWthTnFySGUyWE1RQXV4elFXaEhMbFJC?=
 =?utf-8?B?R1V5OHdwbTc5cjdhLzMycDFOMnhPQlo2NTR0enhZMjhpZWlRSGhFbEhHb2JH?=
 =?utf-8?B?SEFnSjFWQjd1MVFSU1FmcUt5SFB3cHFDY0pxR2ZOZEV5R3lPZkJ2NnVHNkRq?=
 =?utf-8?B?OUhYZVNHU3BmMFAzczVHZTJjL3Z2T1VVRnFtdGJWbGpGN3AwVi9hdUg5aXpX?=
 =?utf-8?B?QTRvYUFIZDRnSmNJZ2xiSVRlUWd4N3dXQVAwUGQ1QllzKzV3Y3NkVm0xQ1ht?=
 =?utf-8?B?T3dQOWdaUGtoVWk5UDIyNDFUc0JPelFsRk43TnlSczFaOFJhYWg3dUVQU1Bv?=
 =?utf-8?B?cFlDQWF2TUdmcHhsSWprRFBZdmNkRDh4UmxEYlJrRWsrbGhlb1ZlUEdCSGZE?=
 =?utf-8?B?dXJEMGFSTW9OaGJ0SGsxZFNYWTYrUkJ0OG9taVZTcGtQSGYxS0VnSE9xR3lM?=
 =?utf-8?B?SjhYSXVZV1g1Z2d5OGgxWVRqSjk4NEFsck1qTUU1V3c5cjRSU21kQTZ0a0RG?=
 =?utf-8?B?NmplMnM0TGN5VG1wMTk1aEl3bDJCWVhpaWhjZ0xhc3FOY09uUFk1aCs2ckp2?=
 =?utf-8?B?L0N0em11blpNQit5N29nUGI4MTJqUjdya2owOGUwTVFId1U4dURLQnI5R1NI?=
 =?utf-8?B?LzhzejFETDRiWVNsMmpsVHlHRmd2dUNmcUYrdUxIc3BYL0REVTYvQXkwc3F4?=
 =?utf-8?B?czdLbVpaVGltOExmRDMzcG9HTmcxUWhaRWduaTJuaU93TUdyOHZ0WWYxWGdQ?=
 =?utf-8?B?V3p0Q1Q1NkZxN3NlUDdBUFIzNW00QWJnSm1sKzV3WHVqOGdVNEFlckpNSTh6?=
 =?utf-8?B?a1k3MG12V1Z6TjlsZmlDd1h6RzFJRWpUWjhTOFArTHFCb1Z6NE9XekdqeVpp?=
 =?utf-8?B?aEJTWUo1b1BQcTVkWExIWXZrV05YSVFRdGJ6THZEVWcxMmQ4NDhJQlVESlRI?=
 =?utf-8?Q?mnr3XYsyAB0oU/lQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7df8d3-553d-4266-1c3d-08df3f36d944
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:28:11.6936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uurr3NGSWeA9LLpJQ9aWXXSfdmO8VCuBlDpVsYLRxIubMBUZOEM4FP5fuFopOOC1sBbcGOszA2yi/IYOMWkEDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11196
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
index c57be10c87296..2f87d0b02ccfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20313,6 +20313,14 @@ S:	Maintained
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
