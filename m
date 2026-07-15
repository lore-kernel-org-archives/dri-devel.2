Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089E3C4450F
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B8210F115;
	Wed, 15 Jul 2026 18:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bZfwhNlV";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013000.outbound.protection.outlook.com
 [52.101.83.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E24C110F115
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqcl/1E9frSjzcTfx2tXm3xMPRMuc9dlil5tjGlJcpBaShKoldIElyCbxHSIJ0A9CbWB7VUYkRXZi7UXKv53oYLXIeoMgeWMApojwAcuyWAStPQyHO5x47Lpj94gU8plns41qzzegf/VkMkgAG15i+1WQscFR4EaCuuOKJ0p0f/AZo5uzL9E/Imfpg+bCKQutmj+oxk+US5nc3NrGQ/Hn4icwa42A8urd/c7U7pNVE0IwNo14tjxI6PKsC3egzurEHvCHJV9iNCr+SUXe+TzizKpdYO4iLi/3OAHP1dd+LMrnUlczXQyFZHQ+4LIThWBiQO33MEaImiCR+BD0Jokvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ+5pQhnBKbHVANGZfyDqBAKELXmyLjv6fszVEDUawE=;
 b=OspI3kp41d6f1tTT2ogIzBYMlPSYyl4XCPtkfZXoRyAIRyfmOoHgJNnm6AcYvWaNuwug7I/OmOsUNuukL4f6VGBKvgAsBKn86B2++CaR8JalDPIlPig6rCW6cEV6xTeohwk4plmEHQ/b+QCGBj9vUggX5WrBaTi3yZEGmQUBx8kqlVHlOUIKhnqGw81/Rxzr6SehQlFT+/i1hYieozK5/86s5zVME9+goAS+kkz43SkLkN18DzwamFjzxeePiU/HkY3YRZe4HyhBPKH9i31Uyxp75OsocsaQZ280S65xWNFlAeC7KGIl4chg4mjGGXywZ9BZheAylh54y4zbRT64xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ+5pQhnBKbHVANGZfyDqBAKELXmyLjv6fszVEDUawE=;
 b=bZfwhNlV6ZEpe0/gLvBzUC8KXxvwY5to3Eoldd0yDjneDzzFT/eXpVtPpofWGA1VnD29Fs5QMRrdm8gIVTNTXcnLsM3ki0Tpj0QvHxQjDNJn80HICDrtF+ZG/zEyInWx9wW7GkVAlbwWO+O5k7i6qxFL+CmLIkBVyxCDWBsamv2SbMxrevMVDPcM2VX/36KJBgG54RF5eOtxjCWl4gXbSC/0Txt67LnU3pMoPkz5lj4aQAOY4jnhWo8KCS+ANW/rvekr6FLZlzUDL75eFD6j/5R9laSlYszDIfgW7ApJBFpW1py2jGjZdupaKKxZJ24QgmKwGOm2sfw2jjxWa0to3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 18:35:18 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 18:35:18 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 15 Jul 2026 14:34:50 -0400
Subject: [PATCH v2 5/7] arm64: dts: imx8dxl-evk: Add onboard GPIO mux
 controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-dxl_lcdif-v2-5-da797562636e@nxp.com>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
In-Reply-To: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784140492; l=3506;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=g/LH0jN9w8YEfRAQ/MJZibHScmWP7vdejTR4RMpSpc4=;
 b=MkDrK0wqgTUu0aGUh3Ytjc2RHqcqM+NrI40au9fmP0nDzpbsw/Z1wIJc8AgeEIj/VhwzuDaQH
 n7Wa+zRlV/CBBHb5lvmCJJqhRW7d30sVTdbBPhbosC7oraSZNdZ0CIv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:806:21::24) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c839991-3de5-4abc-7061-08dee29fd205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|56012099006|11063799006|6133799003|18002099003|22082099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: +XijqOQqHACZBSKQOC+lCzZecb2+cXKF+yh7jBcP5qkacZ0ntSJjsAdu/E627oWh8lPIRxiQWsHCL9Br+quMKJd9waau6z4XzZexBKC5lgDZA9ywFLU3lybd6vsdKZTqMKC88lnAI/s85LcfFP9cmIrszTvSx5nm0ApZZQhQmGhqY0MqrlCvN/b66iH3RqNNynq3AboFN3EFhYQd4H/XNQBcfhPBM8W/iFq77pND3jTvGlhnoTBJnFLML2IA5MhiwjZdLksWooQQcyLQYteuT3EEzoW3WJYfmQalsPVCqK0+W3wa1yAgtjoz4GlYOuhgJCZYtqHzCfOPWW4IEHXNXzoLxOzHnisWzDyMkSkhKRwTdv4aWjlOsV1b4VKXk03afzKGwUL76y883cMuU7jFzcwSKHUD1uoR34m2RjL1tZpV5TEY+Zp0zrPC1caaKoE6OXUO1Q7tJmQOzKKGfqw4guDXWT23GJhXT3IDW5Hu4lUaJJo79OzPoA1ffWRmRrSncMExUXupVMYAQFlsOriCmifMcEnXKE6ASX1t/NqhuORQ4D7X85kUF0toBvp5yBJc+tiHIgnNWnwkt2b6xV03gNxkGdc/aDQroNpD/hNTr0786lnd/YWs3dyo0epEVT2WpV9XA/epov7dsb7PL6+2dHNZdB1CkEcBbK2tVC7ZUypkxuKpD+gVH+eW3Ou96aNqIYpDDqdsVXPlWpnpPhNGGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB11791.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE1uNk9MeUlxZE5tOHJEZzVYMk13UUwzNEx0bFZWNytmRG95eDZIa3BWMk51?=
 =?utf-8?B?QVprVW5JdG5hL1hmUjM5dExMZjlMTUtzb2Zqa3JRa214QkVxMWJCd0lmWE9J?=
 =?utf-8?B?WVc4Qkh6OGIwWWlVL3dCT2tidTdWb1RWY1JyK2RZZEx3QkdZM3ZSQWtBVUxh?=
 =?utf-8?B?M0YrMmZZbEZsV1ovRW1SdEd3eGMvaUVDaXBHdEh3bnd5VUVxbGFHbFZxNlhB?=
 =?utf-8?B?UU1KTXlSMWZPY3dKbzJRa1U1ZjFodU9RQ0RZQXJpMkQwWkZqZ3haV2g5aHVS?=
 =?utf-8?B?R284UXFRc3BXVzhnelZ2aWgyRjYycnVzSm1JemdMOXZPQUdVbXJqTTlXbk9y?=
 =?utf-8?B?OHcwNUpTMTdIUzM1OVNvZDlVZzJ3ZHJ1YlRKMGd6dWU1bFhsVGhlN2tFVTI4?=
 =?utf-8?B?UTFYQUNGSVFleFNUUDlwNzRERVFXNHdwQkgvNWI0cis0ekVYUldWYVdQVFV6?=
 =?utf-8?B?a0VheU1lRGNXcHFnem5wN1JjK0ZZR211cXppdkhkUmpTMVJGOE4wbUpNRjhE?=
 =?utf-8?B?K1Noeml1TlRIZTdwd3V5ckRyZ080QmI2bUlJT0szYUZvSkxOMVRrZUoxamlU?=
 =?utf-8?B?VEZ3SGw5em5ybTdyYUEwaTZOdVFMTDJJeGNPc285N0JvVWFUMzZIc2xZUUZR?=
 =?utf-8?B?Mll4cEltNklLMlAySzd6TytlaGdIdERrNjFhajVhdFdnNW9CWVg5TWpEclRz?=
 =?utf-8?B?STZ0OHhtWWQvN2h6b0sveUVXYVkzK1B1RDJGNHRpY0QweDR3Zk9xZkltb0xs?=
 =?utf-8?B?SUhzQ2NuUlV2N0xvVDluR1RwMysyOEl0NEdHbTRIMVhSdzZ4eUJXbnF4cEtX?=
 =?utf-8?B?SEY0YkNIcU1EWlVvWFNodDkzeU50VFJPcTZNL2FIb1hJaUtRYytKVDJ2cFEz?=
 =?utf-8?B?YWhjWkJ0aVZoN0RIQVgwcVA5bmJPSS9tUEZGL2JPTjhLYmlCdmljSzUrOUFt?=
 =?utf-8?B?UUFDRzVWL2FEcVJJOEZubW50QUUySi9WMzlOL3dlclUvdDI0MzVOaXFlNmds?=
 =?utf-8?B?SmRvUlRPUnFhM3NYckVrb0tvc2tOM0RmeXdkMVJGS0tQU3hPWlZ0VU5uZ0lR?=
 =?utf-8?B?MzhORlBTRTIxeFBORDkxMlFFcCtSR2JCVVFKT0JkUkc5bXVwdVllblRyYVBa?=
 =?utf-8?B?QUZRSXBtOW9kN01INzlpQmoza2FjT1Y4M2RFdThzK3hORkVXM2ZYNXJseFIv?=
 =?utf-8?B?eVNCQVRPT2dOSG9LTTlESnU4QXRIYXZGMXNta0dPdWREUmtqb0hrZmxJWFhL?=
 =?utf-8?B?cUFwTXJaTkM1aGlDV3Y5V2ZhcFB2bDFicW9kNldTQXQvOUNrRE9IN3ZOdlk0?=
 =?utf-8?B?eGRCaXdpTFFzVHRjdUJpVWZxalZTWk00bERYenZvWGxOc0owWm5jeG11QVRS?=
 =?utf-8?B?OEtFV0FKVmVTM3RRUTZyb3VORS9DTExTR2x4TWM1WS8yT2g1akY5OFUwakV0?=
 =?utf-8?B?YjFtR0xHd1hORFd4UWlPdy9xaE1pM2Q1dGFtNlNHdjhkNE1QTWtmM0Y0dUZS?=
 =?utf-8?B?K0xZLzV4M3UvZXQxYVozTDBOUGI1YzNMcUQ5T3BzK1RZRlA3a0F2OTh0M3lj?=
 =?utf-8?B?MlRjTko4TVNkelJ6ZnBBRUo0Wi9uLzBWN0hXN1ZGMTdIcHF4UUprcjl0NTlL?=
 =?utf-8?B?UFVTR2RXWVJnL25BTTRORnBKK2NOU1pWWkVyZDhEbWVSMkhHQVR0c0pmRCtR?=
 =?utf-8?B?VkFMb0s2azBrWE1sY2RDVURDb3pZMFhhS2t6ODJUTFFoczV0Ym10YmNZQSth?=
 =?utf-8?B?K0UvRXd3R2FZZGJhQ0Q5MDBheFFxeUVSZDdON0p1Q2RnY2dKVUxVNlJhMjF4?=
 =?utf-8?B?M05WN2MyMU9CazJEcTVuZElja1IycGFZREcxd2dIaHVJZG56eENQNnFGYXdH?=
 =?utf-8?B?aWtINFh1NTJNNnRDcU14ZkppVW8zSDdWaGJ3RmptdFBhakJxMjBnZlhtRHJW?=
 =?utf-8?B?cVMrWEJTWlhGNXNTbkZReWF0NmpTVkpUcDI0Ulk0eHdvdGFickRoMjBNcTNy?=
 =?utf-8?B?M3Q0WVc2UUNxQk9xZHRic1ZNNys5bk5hWW1tWThDblIyMG92LzdPeUh5UFcy?=
 =?utf-8?B?NjVRVndPb3hKL1NhRVVlNDRuQU9EVUNWZUYxdUR2SHMrZmMyMDZ4cHMvdk5x?=
 =?utf-8?B?N2FtcnZEWk84aWdCVHVXWTVlWGZzL0pvR1JyOThCU1V1SmJqemsvSGJ4NlNj?=
 =?utf-8?B?aGNVSzI4MnJub2VOZHBwNXFrcTUzc3p4dHVVbGhYWWp4SjNiaTg0VzhHTjZH?=
 =?utf-8?B?RmtYR29YVEc1TEg5aVcvNiswdG9LZDRPT1A4UmdVckltOGM0SXd3TnJhdzFU?=
 =?utf-8?B?dE9jOHdZTmZyanNTWjU5a0RoTUtBUUZGT1hNR2cwNFYxRnU4M0d6WFc4YW51?=
 =?utf-8?Q?b7lOpB4Ms3BCeqnzGhNc7h5Bvxn0iog0+LxJf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c839991-3de5-4abc-7061-08dee29fd205
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:35:18.5444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kY1YjISMu8G4J+6GXnvU/BFt9RaWELtPVwPUUh3evHLHOkbKo5Z3XeKSB9yUDXn9iOl6xDC3ZrQYsglZlrX7ZevsUd2TXDSHrqaVuMmprlEicK/5N3/OCl/dofMVaQHB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8359
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

