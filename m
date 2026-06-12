Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F019DCD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5425610F469;
	Fri, 12 Jun 2026 11:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R2gZDuQ9";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F287B10F469
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:59:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8XzN9IzejiTpz0ZMq5V17EnZUjUxPLyPki/9EBJ+zp+zw0vsFaZwveiqeOLJKcJZXv/FeEZDLr/STLRk6137efO3jUtVZoGC9sDM9KD79qQIfG1fauwXUEIIvYUk8vCUsJzrD7Ecqa27UrbOsT3xon9nOWa02YcHmAJsf1tkviQAzZkm+iWfKg9mVuJSd0XBQ1jPbsSfgZIZequg4MwhKlnbXUzJBAM0rjOr+LAT6APNRwSBQA4AvWoP/ePp8GO74CaJb4mhUgNsrgYccy/2BUlPd9iBqYRXsg71sCTfBMdeqwYmyGS7RkJGUk/QzV46T3/5hP4jeShyIWyglYkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSn3txY5Z6Jpx6tefrFF8VqHR3CjRNIQrj7Qr11jb9I=;
 b=KG3tyH+fdGBoQPKI9pBxXIdxt9b34LCgw3vpJu5q07xpw4ykclgBMeSLVPu+bHwlvOtIFkQRET5gh2ESVsPXnOTFSkEYmcN/XZ5f1wWR+V7dtjxiXSE8H0uqu0WZ2nQ1QCVRODyjD8mB1yM2gOumz2YcIqm/E/EuaIsKxRXMj2Km8zaGh9hbvjlWnfH0aN+zAq0Ws8NADoc3ctkYH4yvJebqAg8L8HsENUHLeN0++TPwpHNrjmCpMbTuwH2y672BdmrGvXcjxAAY/ynmeCfdS49mMPm465yXAXxdSD6Wrcu40UYZ5TjEcYiRRUyzDKhILXpWCTecyeUoy1Rdbpo21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSn3txY5Z6Jpx6tefrFF8VqHR3CjRNIQrj7Qr11jb9I=;
 b=R2gZDuQ9LthwOouXCnS5T6dv6mmXNgtUtEd9taQaKSv2Xx9ppciA+t/kiCPgXQblN8AJ4ny2j8RfHNHmjjUVCFdPj5wdN2Y3f3yVh3jEQwvd0h/LZj6emvP2slB8Aept8SCPqKA8vf/TleDjJTzmp0PdzxkL1fFTrdYm934jaBoLZc+jMfCUIeaf9kMFFtV8SRc5W+r5dr7N6lsk3hgNaZMB0tGpTIFNeGQgbW13taBptqIy7a7K0Ejch30Nrzx22/CelK556Wy0s7LOmBilunXJstAo+9C+PECntoPmWitzYK37xIIIYhpbaMMRtR5X5uD28r9He7Bgvwu8EOt/Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AM9PR04MB8273.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Fri, 12 Jun
 2026 11:59:03 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0092.010; Fri, 12 Jun 2026
 11:59:00 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
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
Subject: [PATCH v9 4/9] dt-bindings: display: imx: Add i.MX94 DCIF
Date: Fri, 12 Jun 2026 14:58:35 +0300
Message-Id: <20260612-dcif-upstreaming-v9-4-8d0ff89aa3c5@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
References: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::7) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AM9PR04MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: d12c17b0-82f5-4278-0db7-08dec879fdc3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|7416014|23010399003|366016|22082099003|18002099003|921020|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: tl1luNFyAjqc2Eqnj0GG7c+DrARL2EyRN2LoKT31owMH/Xtluon1Jxj4tnM3GpUNfzCd+gu3I7q56nC+NT87XUzdEOC/VJKUxQNDCB+LWGiXFYY7JZBIi+SROk9VKosdmq8/cokjKzMs8DUguUOp6Mi7EjzC2SIM7H5h1co4ugsGJrRcyj8rX2bO+kx6PZ8LOk6CceEtmcuOiakSuzGa+UQUuSAJf8lsCNfq72S+tzySCbgDGNueYBp3BhAwXkOj0rvIzfZ3z4pNv2Tplr/GwQpYtOQk1xxDtPEY1CIDhmT0ybcBRb8uhQiZsqSqg9ZXVUZN1IGydb1AmN3/KuNgrvGiFYTjl+DcCFh8YO7rijXOKend2dT7gXAl+TXY/wgCp6/rDYyyALd31pRSZzSsiNw7MtXiqF6mryRkUi8OlyAIgB3/0eRIyRGgPugHloT+Hkt2vbV5XgHf2l3nFrYmZRuldVQHzZFiSLjnM2MpXoXw2RgGNCRhu+rEUVm0vi/5xThZeLGdtuAZs0yqxAG3829A3Q7EytpDhnsUh0pLWg+2H1Q3hgMMGt8RfWLuu7VZq0Mkb2KeBQrwNb0tiUFX26qMcMhglIqKkkdMC32F7TNDGCyWvP6XUPxt01P7TLt8QQN9olu5eHK1Uxhyj7K3W+2wr75OalpJxHGChniKH28CbG3e2u1i2jvcygQyDicY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(921020)(3023799007)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVFVkJmaTBGa3BxTFFQdE1abEoxc21QVSs5S3REYU9NUjJ0RTVLNVBBZnl6?=
 =?utf-8?B?RXNUNFVvS3J5L2hqRXhXMWhOcm5zbmpXTjZNWVZHWjNOR2dyTjltekJOeTZR?=
 =?utf-8?B?c2d4MUw5R2I4QWhSbFl2WlZGQnBjME1VUVR5WUNyd3o1cE11V0NnMnp5bHow?=
 =?utf-8?B?QVB2OXFiWm91ZGFBUUhFOVlRdkp0R3hJTjA0djRHRkhRdWJZWGJxZHp0SmxP?=
 =?utf-8?B?WHVOOVNTdkR0RmlvUTlOVk1CeVpYeVdyUk10M0VGWVhka0YrV3JNQ3ZzWXpW?=
 =?utf-8?B?TFBYMXd3ZEhYZGllbjRIdTA4azdLYUs3NmUxQWJpR3loZ0g1N1B2WHVrdFND?=
 =?utf-8?B?V2wyd3pzMDlydlZQSkQxTkhaZTdoTzVpalU4c2pMankyTHRpRTFjK3JwenFu?=
 =?utf-8?B?SUJGck16TlQyY1NqQmsxYlBVaVF0TGdEQ01xNDd0ZGxxMWtEYVRZUk5aN1Zt?=
 =?utf-8?B?SEVlSGV2eWcxalk2R0F4MzNuMGYrek4zem9wS0RzYU5CYldPMkt3dU5TaDBi?=
 =?utf-8?B?bXRHcmZHNnowbS8zZDF1clIzdnAwY3J5VXoycitteHJQUitjL3BxaHN1cDE3?=
 =?utf-8?B?dDlrWTAzT1NqT2JQTlBoUkpxWExIQ2Y0RjB1WHJpMzdJK0U4R21FdDM2ZmJ4?=
 =?utf-8?B?VHBaZkZmSXU3dVFNL2hQZ1p3SUZHOFRaSy94eDdqQThKS01hVG8vMS94VFp6?=
 =?utf-8?B?ZjM5NGhrTmZPek5DNDZzRytjTTZzWXNxak5ML0UrRFVjNmllc2hvekdpSjhl?=
 =?utf-8?B?RXZvT2RPc1hQTm10MkRHZzJKRVhmVEZYOTZGL1phaWFxbEduRnMrTk9FV0pG?=
 =?utf-8?B?R1BUUHkxYzJHMUZnUEdBeHl0VTYyY0dkNXVXUHVWSE5FbFBQUXFNd2MrTU5q?=
 =?utf-8?B?VktnY1AxcVlMZXN3ZWZtbUhNNFBXYjdpU0hBS0ZGZ3pTUEgzYkg1N0FIbHRh?=
 =?utf-8?B?bk9LTytpaDlqdUE5eGRyL2pDNUJWOTlZNDZWWXl1TnhsNFM3bXhrQWQzenpz?=
 =?utf-8?B?UjFMTVVSdVc4NjUybGh4QUl6bmpjMlZEc3lOc0VwM0JNeW9KelFsejBmTm8z?=
 =?utf-8?B?TlBLWk5oQWJYZW52ZUU1YVpxeDVhLzIwQkE1Unl5Lzl4SndXUjI4N0NPeVI3?=
 =?utf-8?B?ZTdIQllXdWpOelhVWTVrK255dDJnekRwUU5XM2t4REhsUWFIN3gzOGFXajA3?=
 =?utf-8?B?dTgvdERielVKK09Sc1d3TllnOFZ1UXdrc0c1bTdxdTAxeVFNRUsrMVlRUVY5?=
 =?utf-8?B?anNISFBvY1BQU1AyZEFzd25sM1krOHU1aWRDbURuMk1sNE1mMUl6Rlp1REkx?=
 =?utf-8?B?WHpJYXBoWVExVXJWVTBuNEtEK3ZROTJpeWtwZi9RNTdFNWpxeGpnbjBzTW9N?=
 =?utf-8?B?QlBjbnFOcW5qcG5QbVRhdjBnNmhBSWtKUU5vZTkyOEg2aU9Zd3FHaGV6NnRl?=
 =?utf-8?B?QnBXYlpZTGpVRUloODBMbFl1aEl4TnQ2ODg3M205VXprTkFaWWVrdG1pMUJG?=
 =?utf-8?B?b2N5b2VSbTNFeUt6YTlYK0FjQUNmRjd2cTB2SEZETWphYnl4aUN2VjVYbzJM?=
 =?utf-8?B?T3k2Y1R4TjdPVjgxTWhQbHRZeERCYWZ0bmVoMUFIbTlBdXNoRmM5R1VpQ1Jv?=
 =?utf-8?B?bXpibGxZWHJKZDBDR1Z5bkRsS0I2dnYwL092VG5oK2h3QW93YWV4aHVPWWtC?=
 =?utf-8?B?WjVaT2t4MktNSWlWWnA5bzcwWFJIVUNJWjltdFo0WldlZVZnM0xleVdoOXJ5?=
 =?utf-8?B?Uk9MSVJHdXkraG9rZm9oVmRoR1laSHVSd2NOSHZCRWdneHlkN01VSEdFWlU3?=
 =?utf-8?B?QW1aRWUrQ2tMTEtFZFNoQzRNM3Y0VzFudmNqSVcwZWZCS0UrbVJzL0J2Tmxk?=
 =?utf-8?B?b1FPV3MrNVF5TEl1SGd4UVFablp6QXU3L1JsdEdVb2NoYzlBRFowNy9VV0hN?=
 =?utf-8?B?RzRDS3oxSXhXUHB3SW9jdnA4Y3NXNW1KeGRzeVl6U281TmVRaEd5S2UwVkI5?=
 =?utf-8?B?a2xZZ1NpL3JoL01RV3lUMWxBKyt2Szkra3AxTng5bXdhdWVQNUYvRU82bTNE?=
 =?utf-8?B?RzQ2ZURGbkVveDd1ZjVIYnlNYkk1ekpja0R3S1pDVksyenQwdzhxbGhtUnRV?=
 =?utf-8?B?cjZ6U2M1RVJDUVJ3LzVoVWdkTFNlQkdQVDdRYnRoVnRuek1TQW1ZQ3R4QlBF?=
 =?utf-8?B?b2lzcDIzeEtVR09YSmJpV0VFM0FlUXlZb3piMWNJOEw1RDEzK1ozQXpkbEZQ?=
 =?utf-8?B?UDQ1L25wR1NJV3p1ck9VODBZRHY5Z2xlNXBiSXo4SEtUSitSTzB6OU1OT1dp?=
 =?utf-8?B?ZlpseFU4eW9tK1RYYjd0Vkx5SzRJbFlYcW5vNktWVEpKcURpbEpJbzd0OFJO?=
 =?utf-8?Q?xeeJNF8P8m2/OFf4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12c17b0-82f5-4278-0db7-08dec879fdc3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:59:00.7947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10F8RrOYPBEDr7htpSe60kiY8MkXrAy/X9a+K+DUOpnhRQ763Hf/1FpSomT/GzanJPQpLxSE5jYS1peFBChyiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8273
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
2.51.0
