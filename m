Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BE4C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF26E10E00D;
	Fri, 25 Sep 2026 16:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BOYRbCls";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75D0A10E00D
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzwwPzC5yBWP3Q45QN2wkSBc3gjwjMJWR/uCl49TBYwztkrs4xKDVM4zbwEhOGMhmK8NSRdi0/W+UNwt+fj/8grdjzqOd8A1NhxcpXL+oneWcUCAL9nG4wZiBRBzqmd7j8hJXYcnwOTFgYZRVUurSE5iiKd2RREQzbbmaWvoWEhm8X/cnLdMkxZRDmmkypIxWOZzB6qlaTqHAHqqzR/NrNxWp+yP8Z2zYsuul+Wwx4nOxtB+Hgs1kynEdrPZ3frC398LK1nvYqhbCCten25Q4oiuWAgHccqX49YGsjOX7PoZH08T7bLVGqbcvIzb9RMijAzlROAIVLWOk75a/7rj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF3smUSuYshgd1lIBHIz1TDWOJvYPv/J9iayDMBN8A0=;
 b=NUItQ9BZJdTmmCaS79aZX9nGZo76Cj2rHiMm1EV8yUhwLyTrLD7f1+gYoWSuV7xASOXsLUpYCGs1wvVd32nAiMsUVY6EagVFN/9/bN+0SF3qVXXJ3NFLlDyZ+BrS1naf3EXx4zhjkt+we78WNkSge+J77kL3Xu0nfjSrxDz8mvGICSmByGV8GaUZ5dugjn0BS+sbb78wt8NSMOvAnPr5zfF3x4BIr5KeO/ZOWWL4PnxP7bqmWN0wLInqBgy8/sLcB8gA8UDnJOUtoePWhWUuzS0Jt7tD4nQO9DEq5CoN+sMMK/6SudyIp1jDwD6iokfVf4jLse44bh9sTufpUTRfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF3smUSuYshgd1lIBHIz1TDWOJvYPv/J9iayDMBN8A0=;
 b=BOYRbClsvd2xCpdgX71Z4P85UBVQbjFpQlXVwZVLAjvmCrWzdyZvzeMDGK9HL41IyeW/VnCMEHh7LjT5Yp+oZS2RiMLFE3JEuqK0f2zJxezqCibhzo9h2fY734mrHOc4ULBYqjGMGycsb1H87/LTq7vwKlhMPjS8GoqHfxcHheLVj7cvuUsqh13agUO7AXG6rLuR3sd4U2PB8LatDLB1u93rtQGE+ybNVTPfK++DzfPy2or+YKbhsKTHpaAdKP7gnDiGzM3IFm34TXIuFp7EQFyy6ek+/6IB4IyLo0lpm8NMt9wT94WSP2D5lYu00gju2UDmKCEPQNpdK5W4lX4UYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMDPR04MB075100.eurprd04.prod.outlook.com (2603:10a6:20b:749::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:38:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:37:59 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH 0/8] arm64: dts: imx: cleanup some warning with W=1
Date: Fri, 25 Sep 2026 12:37:49 -0400
Message-Id: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2jtmoC/yXMTQqDMBBA4avIrA3EVKX2KiKSn6kdkakkpgri3
 Y12+S3e2yGgJwzwynbw+KNAX04o8gzsR/OAglwyKKlq2ahS2Ak1x7l3i+lX7Zl4EO5RSVcZ1dT
 PAlI5e3zTdl/b7u8QzYh2uVZwHCcm+5wmdwAAAA==
X-Change-ID: 20260924-cleanup_dtb_warning-d350d5b29681
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Guido_G=C3=BAnther?= <agx@sigxcpu.org>, 
 Robert Chiras <robert.chiras@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790354274; l=2098;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=P2Ix1f4ZSFhiZj214PsGHtygGM+x6jHksRg4Kc13Ecc=;
 b=I+qgySKt9XnaNkQK6rjFpA1lVA+ExuUfdB0m+aw2fqmCyQQJteG13+2gN8ley4Xb9KCnfx7FW
 sgZgNLEMp1MCdPrHK0vr0GZxIb+sSwWOgnbY8NERBhk6wC/dLLAUXs3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CY8P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:930:6b::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMDPR04MB075100:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b0402c-8025-4bf3-bec4-08df1b235c2e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|921020|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: ROW8E5uUjMLqj0a3Uj/jgCBxHnTbeFTKbygqjRpv+vRFL+iMi7+6taQVXIZHb/tXn+VAyHUfcr3M2O4vSvn1BH9Zq/sIWrsnlKWJklFqK1VF6yKEWkwuYECOHi/ZjuQ/lhLpDJTO3+xQ2kMUp/oamURsAU+mCk+lu7qI9E198taAQEzhaERpSzIo2BTQD7+ztLHP8b8pxs94RezOmbB5LFhfIWtSIW+Xcb+s7jq8wBGzrW0Jj6dPzjgDgB1IblUYKuQBJMGNQOOODON2T1dIhnXnhZl72DXRyRQ7mp9Pa53wnydnwvkNTkbuiFTBAzbRku+wqR4Q4fRqHG8xB0eluF0iLq0BFMNXM4YNSzKp7LAL8l0mCoVXoByL+zg8SnlN9br85krp4m+upvO+/FX1qTlfmJUFSRnuzTMQvVpJNHVdXFBIrlIo9rQi/5otjULSVhATe7JnwML7tJn43tMygziR72ryWoklAoQ56nAoliiPkCVx3PHxvujZiFO1a7iOkZlChUgXbsqXOwhhkqtV4xorCdz8qyFIG16yKdVusunE8jCB7M8x83Hi/N4+TkS/pr1IlpK+d/aMD9z9FeeNx0W/CzcKDP4Vi5nivJdZopD03GTXpu/YbGYy3NGC9i7O1h1EBoTKrQg8FSMT7E3iMOW73XICv6iwQ0w0oXN7C4/7ygWbIQzJ91cV2oouJ3q9299JorsXk3Vyr+t4FAOARg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(921020)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzJMVG0ycis2SGdiMUwyT09vQ0xPWTVEUjZ2MHg2Rmc0STF6bm9yRDRQU3VL?=
 =?utf-8?B?aGZGTU1LUTQ2U2ZYcGJkRk1VWGFlS1ZSbFViS01UQS8xdGRHMCtMck5IZUs3?=
 =?utf-8?B?NWphY2UwbmNmbnN0WG55UW16WmxDQzNNUnhKVnhkQTgvYkh4UmNUcWFPampv?=
 =?utf-8?B?eEp0c1hHQ3daSGhGd0ZYMWlnWEowd3hiR254TmF3K2U3dkVqMENRZHRubXRQ?=
 =?utf-8?B?Z0VHa2xPbERDNHVsRWZOei9mTXlPNGMwc2plbDI0aE1VWjRpeDNiUSs1bEZm?=
 =?utf-8?B?bm9lMEhBakFVRVduRW5SS2cyOTZ3eWlMYWd2d1pzazlkZEdnZ0F5Qkg2RXhB?=
 =?utf-8?B?QitJc0FPWis5OUtxT3ozRGFwZ0JWbVBuazEySmVRczRHNkh6Q2hJd3ExVHVR?=
 =?utf-8?B?M1p6bEdkL2NmTnN4VkZtd0lYRmoybnN1T3dVcUpETXBQWGF0cURLSkJnNWdI?=
 =?utf-8?B?cGxXb1N3WFNrKzBKU0dtMHN0dWNTSGVPNUVRc3pOaHN6Tnd6SStqTEtXa0d6?=
 =?utf-8?B?Y2xFWXMvK2pxVUtRa2ptUHBNUWJEbzFFNmFpZ1g5UXdmaHhHSmNjMTU5WFRr?=
 =?utf-8?B?ZGIrb0YxT1Vxdk8xRHk2VVFhL0dUZzJldTVQQkpJYUdKSkRzVXRuVXBVUGtU?=
 =?utf-8?B?UDFJOHo2Zm56emtyME95bEcreCtIRVlPbDI4bW1aTXQ5WjNTTGI1OGxabG1I?=
 =?utf-8?B?V1FRQ0tDdUFXWHdGSUZZMEorWVltNG1uQVV5NGFUakRrK0xyR3oyZ1EvbU9W?=
 =?utf-8?B?Mk1TVzN6ZGdYdjYydVNKOXBJVklnWE4rUmRnLzkzODVpbnNWY1hPZ2VYKzRW?=
 =?utf-8?B?ek5XZG9EbWxOZllGVzNqVU5EUnpRcWwzViszUzQ5d2pXMDZ4cVhYVHV4bUVu?=
 =?utf-8?B?OGVFTG91ODJlMGJHS1FpVldURldmRU5oL2hsMWVoaC9MWnpFZ2FyRUZlSmlT?=
 =?utf-8?B?NTNxTjFkNTJNamlxeFdBQ2h0OEdQYmVCaFpPdUcyNU9EcmpEbGdndURkd1BB?=
 =?utf-8?B?SmZ6d3IvZlYzbVhWaWVZZDN4Y1MrY1ZGNVczM2VBc0J1Y1RGc3JPVjhwRU1w?=
 =?utf-8?B?UWpYSXNxOWU4NCtRYkt4Z1QrSjhPWUVKUG5wZXBkTEFDbnRaR2Jqd1dtM1V1?=
 =?utf-8?B?WUt0UE9iUlYvYnNZR0htb3JwSlRyMjljVzFTRC9IQnpZM29RelIwRXRnQitI?=
 =?utf-8?B?UDF6aGxxdytkenVHbG9qbW4reUJvZUt4dVNLMTBmRStTS0hMWm9ldlJwbkNy?=
 =?utf-8?B?NFR6SXdjaHlROWxhY3hhMWRxRllCN0pLOThidVhHclFROGZiYW1sQ2MzQUZN?=
 =?utf-8?B?cmNBSXVYRzNMMElOSXAxRUU0NWhsRm91eEdTSFFyWWNTc0tGT2dxdWpwZGlv?=
 =?utf-8?B?a3VDdWxvckVNQmt1QU5HZXREOEF6TlpHU29EUE1LcE9DWWtiZ0tZdWdYVzMy?=
 =?utf-8?B?ZjdKSU1JaWt5a01veFRpQTlkVHV4UDlPbUlabFZabTAzWjM2OHU0L0thU2ZP?=
 =?utf-8?B?OVBVY0IzQTRzc2FmRzdFZXlSbG5nTlYwYWJ3ak1qT0tuOVduNnk1cVMvYjln?=
 =?utf-8?B?SjdBNzFxNDRSazI3WFFEMjBDaldKZ0QrUEtuUzlRSCtwQmEycUhRZ0lrOEVX?=
 =?utf-8?B?TnN2cmMzMzh4U1FkZkthWVNjcFZlZmZoRHdvRHB6VW5lM0h2OFN4QUJqOW9H?=
 =?utf-8?B?emFsU0hGdi91UXhoQTBlR2NQaEFwK3k0elRSZjNkdHZjU1dsc1h3bWpzdi9s?=
 =?utf-8?B?RFRsYlhLNUtGTFZYZ0R4aGRQUGY3aWlVTXlXaUR6eGJrT3lZWi9pZEsrMkY0?=
 =?utf-8?B?NWtuNFpvSmQveXZXaDNIajdGRjJJcWM3aGtkbUk5dXpheXdOMFhUMTBMSjNU?=
 =?utf-8?B?RlFXekhQQkRkV0dPWmVLUllOY3dwRVh6R0FGMDMvOUgxeExNdnRsUkVCNHIz?=
 =?utf-8?B?U0FSN2JaQlkwMktOMjZuaERabGErRTVnOThENWVDb3dhQXNGUzUrNDZaZVdT?=
 =?utf-8?B?QlpoQnRqckVVajhUL1I3QXJJNXpXY3Z3M0t4T2dnQUthWFZpa0JPQ3hRYUVC?=
 =?utf-8?B?RWc2T2RXbzFRRDRvNEhSOHMrd0NlTlNxRFViVEoydmxZZmlHMnR2anhtQWdq?=
 =?utf-8?B?Q21tRlhWUG9xYnpUSTdidHB6REk3eXNIcnlyN3RMNmEzS1hnNU1rdmlVSG51?=
 =?utf-8?B?NTBlZVVyRXcvRzFHcE9CUFppeSs4L29rOHFtSjR2bWdOc0trOTJLU3VicktW?=
 =?utf-8?B?bHlyd1Z0eGNleW5rck9xTTN4aFNhN3ZIYVJGMjBIVkhBQWJ6TW1Tb3dxZlRX?=
 =?utf-8?B?b1dud0tKeWJMNkFuRG45R2c3cmtudE15NSs5T2JmT1ZYMlJaSEE2dUY0d1BJ?=
 =?utf-8?Q?+eAc8rNZ8h/cvywwe+o4zoEWr0n1xDknPXyeK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b0402c-8025-4bf3-bec4-08df1b235c2e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:37:59.6058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7/FaWgFNP2QMaauC3cy09l0ZkNRTCVFMm8QBFUngEfWj8sKGYgn4EneXPhIFPoWKU07BQAIbiyYU/LP+nvX5XHiovy6TDbX5/tOQrY38UZMsFMjnswgfj+SbI5ObNj4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB075100
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

Cleanup some warning when W=1

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (8):
      dt-bindings: display: remove #address-cells and #size-cells off requires
      dt-bindings: embedded-controller: remove #address-cells and #size-cells from required
      arm64: dts: s32n79: add @addr for *-bus node
      arm64: dts: imx8mq: remove #address-cells and #size-cells in dsi@30a00000
      arm64: dts: fsl-lx216x: remove #address-cells and #size-cells from pinctrl node
      arm64: dts: imx: remove unnecessary #address-cells and #size-cells
      arm64: dts: imx95: rename bus@4c100000 to hsio-bus
      arm64: dts: imx952: rename soc to soc@0

 Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml     | 2 --
 Documentation/devicetree/bindings/embedded-controller/gw,gsc.yaml | 2 --
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts               | 4 ----
 arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi         | 4 ----
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi                     | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts            | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts            | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts            | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts            | 2 --
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts            | 2 --
 arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts                 | 2 --
 arch/arm64/boot/dts/freescale/imx8mq.dtsi                         | 2 --
 arch/arm64/boot/dts/freescale/imx91-11x11-frdm-s.dts              | 2 --
 arch/arm64/boot/dts/freescale/imx95.dtsi                          | 2 +-
 arch/arm64/boot/dts/freescale/imx952.dtsi                         | 2 +-
 arch/arm64/boot/dts/freescale/s32n79.dtsi                         | 6 +++---
 16 files changed, 5 insertions(+), 35 deletions(-)
---
base-commit: 3d7783543c2646af69ad65825e810060494bea21
change-id: 20260924-cleanup_dtb_warning-d350d5b29681

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

