Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0860A2600
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ldq84Ajb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F227A1129C5;
	Fri, 20 Nov 2026 12:51:17 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A2610E8B4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFiJf40QUNpmG4LQz+ADaOqaoeIMQrR4/T4MGDw1rviYUrjkLHbYDwceHagn8dS0TvmtvDDkCW6gOhRNr+ZyfMr/GIbdI3E+1GHgyGmRk4AWn4M0mKhaDw3y+DlOATEPF5lDMZyLSCTk0d4er3WvLzQQ2Xl41NIWmORFTU44TI0eLOEdNfbXu2C/VEKWK9HndW5/fQJk/jI08cWJ07F3gkRsdkiYBHq9OV7HwFv2S77+ca82DZmWBIDzrLzaJoZOmhfIzQ0wJgNNfexsJhnixNuf3mSYiDaykHcRisjMBWYNbPVjIESaL2RA/h9HoKo8pSKvComc5lg4fILOUThxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUvLzU2ZsDws/CWi5T0I/x9fyfJjfETIr5XKofcq2MU=;
 b=YNSJySzT5yEg0dInfn/0ZDQuq+wauKrxCReoGcVwu4uHrrVzTXbZcI8i/+fNtwzskIbGFKVHFNrQh+px3QHFdcYCWVjAHnko9m5Nxq2Hpkj8k4WnywSKsAMebc5qwItItqIaiBoocHeBrmpEBqe22Lu+m2OPwEHwdgj6rjLPfRaLptLIHMWqv085yyRBbh3trx+IOtjijQDLV8L8+xBWpmDiwunUW3uVFsR8ls+JZ7ifp7fkwNuyFSlM1RdzhgrfVgB8NgNgA/lmWgsw3PS4ST8Mj9JMekJnGIuqSmA2wzPtBDxA9a1/jNNQ7OH+WT8ZWmEjqqJ688sqzes12rFyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUvLzU2ZsDws/CWi5T0I/x9fyfJjfETIr5XKofcq2MU=;
 b=ldq84AjbD5t6DdYzHHp9DecV0b1D/9kcCbBTDSRER5Ybpy/gjNRY6dz3a1JUv5RuXHoundbBqWnYE9PmSTm1neXqpbyBIZDpPheLdKhCM8uJDHCU7YaY1tHuxXPVdxQsr/z6sC2+jCYW4JbqH/HimN2fmLkjDvq8WQcDTgtqFBcUF1QT9YMPEhB2xbcl4Shkl3l5iPDTbY5Kvb3bZSRBfX55Kh02QmMbXDgatDByxR+s0LJN31hHLL0cS85ChlgCczxX+KHL9TMTRAvvZETLP9CirKQUw7vXYwlT3BJIC/m7Ve8S8DxKhws+4h+EYiAPSwCTQgR/6OgdbjOFh83xcQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 12:51:02 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 12:51:02 +0000
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
Subject: [PATCH v13 1/5] dt-bindings: display: imx: Add i.MX94 DCIF
Date: Fri, 20 Nov 2026 12:50:36 +0000
Message-ID: <20261120-dcif-upstreaming-v13-1-966ac248773f@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::17) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AM0PR04MB12051:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7ffad7-f52c-43bd-a445-08df4704eebc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|6133799003|3023799007|921020|261028144727099003|11063799006|56012099006|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: qJmIPM8Et5YYuw4vtyRIi9ezKAkpwlhCDS7C2Zga6AHd+lvz+2zl1nb5a7EbRruyX9B/SgFZbqJkrHVa458Jk/HipBH2Lz2W0RgHbkwvBxNNLmMKlbqdZpAQ4BWIoD03BpBBlvY3/F6dyEeBsAwXTvrcLjDrbryoo/sx58WMkbTkbsV9rspxq1FH6rwHPnxAGldbdYS/c4AhXAlKAg/fuRUYsN00wHgRIZMCzJLJgdNnxWzGXz6PTkxEWo3LI7KuJd+/RicZFU597zbqK3EJCKqtd38srTzSluxnq3RULVHRKLeM5EsvPBG3DnsSHBszctU6oQgbqhw5n2SQUhydBKdtwsH2Z780NYpRZ8/78+KfWePp2J0O601kw4F/v5NKX5O0fc0VL4I2zOdMPbBHn2A5xvkMxZyh6rS+cr6DM2GjhohuLxtD8W3zD0sOUuTULTIZPo3x4ytwWWXAGljN9CJOAJ5gKB/23dXDGW6za4R3fYG0YWY+fuHMaAGy/MULU/3K1U5Kjkf550nVGc5mC1xlsSgBaSlcDORYkbTIb+2s1X5lJVQ7dziDx7q3SYMP+7PTEICiEr4obOtve2jbxgzGeKRhk5q66cLYtXAY6uFzgPlZ1RWxeD3H2aON3jZ9DI3dOvB5TUtdVe/i5SMgQSepOO/t+vkVlMoWdaKgBfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(6133799003)(3023799007)(921020)(261028144727099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1Q4SkkydUVqZFRLSGhUTWxITU40MC91akF1ZUNod2NTcW1DVk50ekhDazR2?=
 =?utf-8?B?MnlkaUkrS0RybmVHK0xnKzMyREZuUjdDR2tEdU9mc2MzSVJjNVFaT1paeUF2?=
 =?utf-8?B?aDUrN2NPZ05XN2oydko0NFBXZ3hWZms1SVpnYUpkTk85SzloZHlmK3ZCK3Vv?=
 =?utf-8?B?RDZCalhxU0xaT09SSHRYZ0l1WWNXYkRGUXlmVU5YUDRUclJQNlUydmkxVGxN?=
 =?utf-8?B?MExQYWZNOWI1a1AxR0tkRVZFUU9LTFVNWkVETUc5cGVQek5Oa2tyYW5yRFcv?=
 =?utf-8?B?M0VDZEdtTG9uNk9IMnF2OW10OGZtUVdEMDh3UHVMdjlzR0J1b1FsWWQwV2lr?=
 =?utf-8?B?N09kR0VJd2tpVEd2a1ArWDMrZlpYa3VIYktWd0NQUk9nazdnQ2x5cWN2Nmd3?=
 =?utf-8?B?cnVaaVpWb3dMa2pJcTVaTkxnazN1cCtwa3FqSjh1aTdyemQ1a2JuMThOWEI5?=
 =?utf-8?B?QWErN0RDT2JiYnFBNUlHSUp5V3I5SUN1Mm9JMkdhVVovODFiTXlqWVJQRWR6?=
 =?utf-8?B?YUd2bHNnR3UrTHFtY1NCbnNLTVJKOS9jcTZpREROWitiSmxsRGxMcE1JNGw2?=
 =?utf-8?B?dmRTV0lDdzBhTEFZYzkzOXVCWSs1RW9hSDJ0dldld0Rtd1A3cVA1aHNEK0dp?=
 =?utf-8?B?bkk1NFRyQXhRSHgzOXEvUnVKN2ZvL1lBR1lvZTBEWFVFWXE3bFAyMndxN0dX?=
 =?utf-8?B?RDdJd3FPNkxhWUJtN2NhWVduWDhhQ2dzWFd6dFR3ZjZtWjFOTkNONzRXdzJv?=
 =?utf-8?B?SHo1OFRVVVRFUThNbzc5QlhTSUo4WlVDNWdEN0JmbUVkNncwejR6SXdINFlo?=
 =?utf-8?B?cnNsdnNnbktLMXpCcVRrcWt5TGh5Y2VZTGxsdzh5YUNpSkVvVkVPaFJYMUxp?=
 =?utf-8?B?TUpZcWNJcytWeDRHcDVqazlUbW1QbGoyR3pIeDg4TGoyTThhdmdXeWUvbFha?=
 =?utf-8?B?Q05yVmhubzJaS05iTFJUT1U0NkpGRGZtRWpGNG5jQjhDS1hoN2YzblRkUTdr?=
 =?utf-8?B?ZzJFNVBna1hjY1FNVHZWcGRCNkFNMnowamJxa1U1STlSd2xxV1VESkI0U01y?=
 =?utf-8?B?Ymo5SnlvZ2NZM2kyOFpBSWkrWmE2Tzd6WXZxOUErZ3ZDN1M3UFRQTm9Bbnc1?=
 =?utf-8?B?RmJJdjRHTm5tTkZraGdvNXd0RDIzOTEyT3pBbkk5d2hhVWJrTjRBWlhSbVpO?=
 =?utf-8?B?OEpVUHA1MmRDekt4bm5scDhmV0plVFhIQno2WHlLYXhVTWQyZW45bWdGMWti?=
 =?utf-8?B?aFN6bG1pMmtpM2gramN2WnY4ck1FODliMndPM29vYXpRYWxuYytsSTdnUUd5?=
 =?utf-8?B?SEZXWXA1bnF5U0lFelgyTXVSMzBIaVF1RnJJdmw3SWtXUXFSRjlrVmMzbW9v?=
 =?utf-8?B?aFZPQXA1UjRDQU9hNzl5b1I1M3hsRGhZeFZETy8rWjZsZU1qaGZybStTSFdJ?=
 =?utf-8?B?UWpJVFpPV3lyUmt1ZkNNRlo3Ti9xTjV0Q1BFNFNSQld6QmxjanVUV09yT1BT?=
 =?utf-8?B?MlVMWEhONVlxbTRObFJsSkp1VGVnVzJjeEZiTlNBZi82QWEzYmVBdDlPSzNJ?=
 =?utf-8?B?ZGRhc1dlYzdOMzNWR1UxRkpsR3Y3QmJrVHhUTE9JWUo5b1hsZldnOEV4bFdF?=
 =?utf-8?B?L0daTExiSXQvc243VmdVUmZRTzd1dEtkK2lvT3BHcjBxMjNoa3Nnc0NVWGM4?=
 =?utf-8?B?OUI5OWc0dUlDL1Y5RmdaQWVDQmp1ZURuZ0JodlAwd3hicnY1dW1QUmVVM3l6?=
 =?utf-8?B?dnVwR2M2WW9za2FYUDhqVWpDM0RyK1JJMEt1L0lNSDd1bUV2blhFOWxmenoz?=
 =?utf-8?B?ZFhUS3FKZmJSSWZpN3o3UzR0WmovL29ZaHNYUUZjOS9WSzRpdnYxQUY5REdB?=
 =?utf-8?B?ODUrZ05ENjRVb1hOTXowMUcrR05TKzQwSHZDT1hxN0ZzRUJvaFAzS1REeDFC?=
 =?utf-8?B?MS96YjBDUTY5Y2hXYVRiTStGbnhMb29GOEw5TXFNYmZLWGR5am1iMnJDNWRK?=
 =?utf-8?B?blA5TVAvSGZWTmF6Nmw1eXNWOHZDcFF4SWEwTGlNRnNLQjZPNExCSjhlZUh3?=
 =?utf-8?B?VXVNeXVlNlFRbWg0TGRqeWY0c2Z4b05pMHRXRjRQUjZNYXRENllBdVVaKzM1?=
 =?utf-8?B?ZjhSWjBPK2xWVE5zWTN4bi9lYmZRRVFkR0piVUhkTEJHVGZoeWtZN1pvTGVR?=
 =?utf-8?B?YWk4OWhsRG5kejV6a2RteE1MRHdJY0ptMktSL3hlc1FFaGk3cWRKcEpWRUJu?=
 =?utf-8?B?R3dZdE0wdTJEVFVxSGZsTjJScWVsWWxDclJwalJFbHdWdi9tS2xOR1NPaWhr?=
 =?utf-8?B?V2V1c3FXK0x6czZSaDZzamNlcFp5eG15QU9wSWYyaEo1OWpqRTNudz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7ffad7-f52c-43bd-a445-08df4704eebc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:51:02.2682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xm2fQ5xxmHf0rUzOBbNW1QkGFqLa4pk/jOAMoj3+e97eNG39dJmHz69OelC3vR8HCULbiMFf6M459jC9XNjrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12051
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
index 9c91f45dfa7c1..b9eb9b4dcb5bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20421,6 +20421,14 @@ S:	Maintained
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
