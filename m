Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE20C44508
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0CC110ED63;
	Tue, 14 Jul 2026 13:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BWG/J13q";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A542310ED63
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOlc1sbTuXQyFIvZUKulo3938L3CyhUF7uoZOsg/2q7W3PKNTLl0407Q8cN54NJwPmR8NtjRNFFu8Zst20ONVShvDXVJKlx6cI1G0uMv1HyReSWLGg+0ObpfRxP/Sfp+Boi9y6Gox9Acu1/9nZYc/UlBwazmuxYyblTY04jlgmyoKTQ6TzbgxaIP+Shp55TxyBZuJYWhSRx0TImtFHxWkbkHXU3Cln6EntER5wCjLAjClaBZGWHhJ/6zgIYhOM+78PSO6j7QHv9EaUE9HfzBh1ILRLKVCcAL/4fHwFqixpBNheW1s1KMA5MBPveElmkYJslbsu2eqwj+9X52053yOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ+5pQhnBKbHVANGZfyDqBAKELXmyLjv6fszVEDUawE=;
 b=OK3Zh1mIDwj7JkiHHv5t+osLvYuEzOSJf49Ww2cJPvlCBvcQTGb1773ebFEOsS45FqzzW6xRC2lJ43mhyuMtV8UA5fYkC4ZblmhpEBhkoTEhaQNLLSRs70VBNPgDBP+WG+PNZNaqeAKmoqRg19Kwrp1IW+NUgTkE/bsgcsXRmzKMa45CNPxm3eQhSRIJoTKUq7ELs4QRXBF/Bvh9CdqeDqkpHb0Oq4BTlxmvFvxELJDRRQtwOrFqPg2Y+I1ocpyC+LnP/k9k5vJkmHhvDt+va2QPvvQBkR9G+QAL0NjQoq/MfnAjiWMYlNt9zY90sSKENG68NUBMcoC/jz7dyV7InQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ+5pQhnBKbHVANGZfyDqBAKELXmyLjv6fszVEDUawE=;
 b=BWG/J13qKDEvFZsbEpcr6kYlg+K+wT+ufaw7Ndcd7sxDjYU6VrEdIiVxSo/kbQkEV8HHMqpAQlpquhCeaTCmkX4/fJRTYxpSDKOHbo+7xvM0mG9Q4g/XmOZWO0zlxyZV5w4UDFUW3hA7PegnsvmVDR4pnMcXNAoJsMiKKIuJe/A1fJh26J8zB069aEaAGIbuILfVHJ/ZE1gySa4CRz2m2a4psonJ2KNEoii37mTgwkLVZhCCqKjm2C6wIIPSS8Z4eJXVHUBRGxafoX4iVoEK3zu9Y9V/C8NEf6ewQfX8WRW8h3ypAGFr2DiCMsAepLplRbVPCPtZcQomQl5w3kVuPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVUPR04MB12193.eurprd04.prod.outlook.com (2603:10a6:150:33e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 13:59:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 13:59:15 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 14 Jul 2026 09:58:47 -0400
Subject: [PATCH 5/6] arm64: dts: imx8dxl-evk: Add onboard GPIO mux controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-dxl_lcdif-v1-5-6761a8a6592b@nxp.com>
References: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
In-Reply-To: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037527; l=3506;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=g/LH0jN9w8YEfRAQ/MJZibHScmWP7vdejTR4RMpSpc4=;
 b=cxuQhsNvIC9m0OwKtWSXloXDqXYKZjOtTCiznnV8aVN2/UEalKTeoIvBHRqElVZZ4kaNc2tEo
 n+Y5Biiq5X5AEREOdg2DAnwY4OpepfLZ4H+CPMZD33rykqcaIcAqIzu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0129.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVUPR04MB12193:EE_
X-MS-Office365-Filtering-Correlation-Id: 207ac844-1c88-4523-407c-08dee1b016ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|7416014|1800799024|376014|366016|921020|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: h6ERjG6kkmOVURsWtusJ4pZsRzPQKa0ewpR24h+xCci8sC/3JZqtLkp/loeIEZ8lrjQBYAydwKsnmqgx27BagXNo/zgR7ngtoQUx92ZeADwuR7UTvohRp86BGYjJhyWe7XEO2/7vEk3zEOlNt0LN26DoHcDFBsa4XpzT7ygHy0MphFiXyfPEiLpquk1ACWNufyJx457Wr9vY5dtFkpDTOPEPhtM+yVvHWzC4F1gaua6X09JyUr17cZFD9x3YiigpKgW3zQSWmGwNelP12ltrEeqEozqSwC2XZ3N86Kx7sdLFSZoys6seQnuImrOup/Wxc8r1mHNXYMVxaM5sj+8XNsk9ZK+WD0V6CWm6zz3XX2IW7eXmQBRo4MN0pZly99O8eD92dg2GSEdv6A7qrV4PqWvuwWnvd+AIf/RhBDLMFFu/mRrkl8IMQ/wnAnzvCgCeU6gyEIw6knTUogjgVI+jPZaa4J9752bxGLFcZTNgMWo4CXqZIoEqPdLrnhGjs/kWsXyAKjzlrsv3TyWQBvtRHfYOgOBWA9ySaYK+j/sFRCXZFghCWaN2JqYXESV2jPsyh72+z4W+4nK8GADHOHrOLCtTmRVXUQeHuOLC/Ijzn0bK1Yv4LXEil7xG/sfcTpxPnya0Cz/3Gk+fi0JYrWkF39xRxAtCW3sVhe8LGmDnpAS6aj96f4kP6kMY9rpxr/bVC2volz6pCDJ7tm3ilORCzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVZrdmlaeHp5bmF4MTZ3VEpzSTRjcFZuVEZmNjBSUmFUTTB4UnpWODVPaVVO?=
 =?utf-8?B?V3d4SUdxS0M1YU9NMG9ubCtSVHRzZmdxa05ja1Yra2NGejBSRHVQTUtkcHBG?=
 =?utf-8?B?UklpdzB2UDBFQ056L0NkYUNNMjcyWFVmV09xclE0S0QrQzU1SUQvN0wzR0tH?=
 =?utf-8?B?THdhOUxKMlJ0dGtSbjB4ZmRZMERtZWhuN1MvV2VvU3NhVUZ5Nm9pcHZCZm55?=
 =?utf-8?B?akE5M0xRZnVBVnMzZVJieEw4SWFiY084R09HaStuWnJsM1VTcUFtY0ZML3pv?=
 =?utf-8?B?M3RxUllsTWM2N2RQOUNiemlZQzY5a1NDQWk3TWhvZVRqWWZtanRSWmU2U3RQ?=
 =?utf-8?B?VVJxQVNXQUJFZmhBM1RoZU5Pa0h4NXVMYTF3U1NQeG0zZ3Z1amV6eGxHU2Ji?=
 =?utf-8?B?RHhsdlZ0b0FHZTVXdys2SEF0aU1Jbnk2dllLMzEzYVRaaXlXWTIvdFBFenM0?=
 =?utf-8?B?U3JlaUlUQWJpNDAvNDNVbG9nbm8yUGdkM1hMRlF5VTV5cHlCcWtUMW1FUVlm?=
 =?utf-8?B?My9hcWhkRS9DMHdETk9FblhYV1BjNTdzV3A1bWVtSU9jMnd4RkhreExEYi9V?=
 =?utf-8?B?SHFlaVkxaXdXVk9SRGtRL1BuMS9aZ0toVWtRZ1ZzNjIyTmJReWdqbmdRUERk?=
 =?utf-8?B?bytiaHkzcVVyUWJsaXBGeFZNSGtQaDF2aWxnRlYzTmJhQnBheXF3MFhnWG5U?=
 =?utf-8?B?akxMV2EydDIwUzJTUHMzaWM1eXZUTjF3MjdHbi83UkNOTngxeVBaam5Pd2NC?=
 =?utf-8?B?bUpQZFp4QVpHRDA5RjJQQlJjOThuMllhQXhXNUd6TEtjeld0RnBwYTQyT1Vn?=
 =?utf-8?B?M2tJZmVBb0xoeEE4Yk5CbVM2UkgzaU15L1MxWVQxQ1R2eTl4a1NyeXJlMUpl?=
 =?utf-8?B?T0NLM1ZiOERXcGJ1c2VzZlBOWUd4M25TbVErMWtnMGN0MHlMOEQ2RUpzZWtD?=
 =?utf-8?B?RzVHV2pqSkMxbUsreGJVMEIzT3lsL3dJSWdMNzVZQXZDL0JOckNTdUttS0VV?=
 =?utf-8?B?NjN6MkYvdTUreVNQamJpeDRySVVFdkxHVmI3WXpMREtueUdUQ2hTdmlOZWtI?=
 =?utf-8?B?ejlkWm9qYWQzQkU0YlFVeFVRQjJ5eUlaTmkyMHlnQ0c2OFIvc01YdWtOcm9H?=
 =?utf-8?B?TElxZmVXcUtPYVZJbmlEbFVySWZsZkFkbXVzR0p1R1Mza2NOVGVGdVJYa2dL?=
 =?utf-8?B?aS9NTnRYSWcwNzNnYWJHNFBWd2ViT0dvTnVJOGRNWEh6QzZXTjU0bXErZ2lk?=
 =?utf-8?B?eVpRY2toSVBKTjM3dVg5RWFOZ0lNY1VwbDYxZm9IeVkraE1LV0xJdVBxanNj?=
 =?utf-8?B?SHBwSkZXOXR5RmI1cjJEb0ZaSEFkd0tkVDBTZzVGcFRjWFk2YzFyUTBwQ3gy?=
 =?utf-8?B?amFlbDBiaVVyL09ob3h3OW1pdlNZMG1XUnFHSmxrdWowWXA3U2luRUdnaTVl?=
 =?utf-8?B?ZXQyRlkwTEp1Zyt4U0MzT0ZNSEFsVVBBaDRYdk1ENy8zU1NyWWZPQmVGWWJX?=
 =?utf-8?B?RCtWZDJ0em5HK0dBbGQ3YjhBM01kS3FpNDdRYjYzQVBIRElWZzE1UUtiYlFq?=
 =?utf-8?B?MDBLV3NtVkZyZ05KU3ltTzcyVFQ1S3c3N1MvU2dOZHpLTFVBbDY3eDhxaWkv?=
 =?utf-8?B?ckk0SUt0YnZmdWJSMmpHWmROaWNpWDMzcHJ4VkJqWHBaN2orTCtrNytxQkNm?=
 =?utf-8?B?SEhNMGRSRmhJZk1YTEhDaTAyTEJDdnBxdW52SmlaUGU3SUtEUnhDV1ZIMkdn?=
 =?utf-8?B?a3EwUllrdFAwVnJMLzQzNnBzKzFCc2lnQVpXdTZnR1FNeGo5R0ZWWUhLbm1t?=
 =?utf-8?B?MmVVdk5FdlBYSk45RjIwQTVIb2hJampPMEZPTlQ4RGI4UEhaQXAzU252eFZL?=
 =?utf-8?B?bkNwQkt5U0dTczRUMmNqRzZmSTZLM3B0VklobW9ad0sybmJxKzRrSWVIYTA0?=
 =?utf-8?B?d2F1QitaaTJqZXZITWdMQUVnMUJ2dzFkZE91akRCdzFsWnhCT3A1Rkp2SnVu?=
 =?utf-8?B?enFHai9YbWcxNHBpSUo5Q2pDeWJXc0dRek1uTzF1TU10Ynl6NjlqQ1lNbEJr?=
 =?utf-8?B?aC9hTmZ0akV2eE1lWTBVVXNXMzVJUmcvb3BsdTQyUUpxenRZdUIvbjd0Qkdt?=
 =?utf-8?B?Qkl0WlZETDVDaFQ2REJQUkdwUUk0cUREeDJiMzZoQVZML3NEK3Z3TWY3MTB5?=
 =?utf-8?B?TEVxUDByYUxraUFsR29jUTlVdzFoSTRPY3praVFSemFRd2p4T3doMzQzVnhv?=
 =?utf-8?B?QUZhOUE5VC9NR0NUNzZLeG5nRFAwRmIwdGUzOUJ2ZlRCUldncXNLa2w2VXdu?=
 =?utf-8?B?Y3l2ODhxSUk4eVhjRzQ5SnREcklSa0xIRmtoa2FQOFh6ZXdUdHZ2RERsbVlC?=
 =?utf-8?Q?8nxhy8LkKHIcB3Pf5lyA35Z6K18YE5tbv78Oj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207ac844-1c88-4523-407c-08dee1b016ed
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:59:15.0216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ooe7I0/JVKFGHYdRcWMCr5eBcc3+IlQnGnmSVtL0J6U6O/moytlOL0PivIopwfUv7HuFEfGGEYbo3S7KWjiLbqX/LXUtLZuBjuYETbSn1M2PpqQei03+M2GhStI/iM8g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12193
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

From: Frank Li <Frank.Li@nxp.com>

Add a GPIO mux controller to describe the onboard signal multiplexer.
Previously, the device tree relied on the hardware reset defaults to
select the mux state. Now that the kernel supports the pinctrl-multiplexer
framework, describe the onboard mux explicitly and let the kernel configure
the required routing.

Prepare for additional device tree overlays that require different mux
configurations.

Remove the regulator-m2uart1sel node, which incorrectly modeled the board
mux as a regulator.

There are no backward compatibility concerns, as the affected functions
(lpuart1 for Bluetooth, spi3, and m4_lpuart) are not used by existing other
users such as U-Boot.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 76 +++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 78e8d41e67916..33941645641f5 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -97,14 +97,68 @@ vdevbuffer: memory-vdevbuffer@90400000 {
 		};
 	};
 
-	m2_uart1_sel: regulator-m2uart1sel {
-		compatible = "regulator-fixed";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-name = "m2_uart1_sel";
-		gpio = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
+	m4_debug_mux: mux-controller-0 {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		#mux-state-cells = <1>;
+		mux-gpios = <&pca6416_1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	spi3_mux: mux-controller-1 {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		#mux-state-cells = <1>;
+		mux-gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
+	};
+
+	uart1_mux: mux-controller-2 {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		#mux-state-cells = <1>;
+		mux-gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
+	};
+
+	spi0_mux: mux-controller-3 {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		#mux-state-cells = <1>;
+		mux-gpios = <&pca6416_1 7 GPIO_ACTIVE_HIGH>;
+	};
+
+	pinctrl-gpiomux {
+		compatible = "pinctrl-multiplexer";
+
+		m4_debug_fun: cm4-uart-grp {
+			mux-states = <&m4_debug_mux 1>;
+		};
+
+		spi0_fun: spi0-grp {
+			mux-states = <&spi0_mux 1>;
+		};
+
+		spi3_fun: spi3-grp {
+			mux-states = <&spi3_mux 1>;
+		};
+
+		uart1_fun: uart1-grp {
+			mux-states = <&uart1_mux 1>;
+		};
+
+		lcd_0_fun: lcd0-grp {
+			mux-states = <&spi0_mux 0>;
+		};
+
+		lcd_1_fun: lcd1-grp {
+			mux-states = <&spi3_mux 0>;
+		};
+
+		lcd_2_fun: lcd2-grp {
+			mux-states = <&uart1_mux 0>;
+		};
+
+		lcd_3_fun: lcd3-grp {
+			mux-states = <&m4_debug_mux 0>;
+		};
 	};
 
 	mux3_en: regulator-0 {
@@ -620,7 +674,7 @@ &lpuart0 {
 
 &lpuart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpuart1>;
+	pinctrl-0 = <&pinctrl_lpuart1>, <&uart1_fun>;
 	status = "okay";
 
 	bluetooth {
@@ -658,7 +712,7 @@ &cm40_intmux {
 
 &cm40_lpuart {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_cm40_lpuart>;
+	pinctrl-0 = <&pinctrl_cm40_lpuart>, <&m4_debug_fun>;
 	status = "disabled";
 };
 
@@ -876,7 +930,7 @@ &usdhc2 {
 &lpspi3 {
 	fsl,spi-only-use-cs1-sel;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpspi3>;
+	pinctrl-0 = <&pinctrl_lpspi3>, <&spi3_fun>;
 	status = "okay";
 };
 

-- 
2.43.0

