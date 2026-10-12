Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E70CCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4920C10F239;
	Mon, 12 Oct 2026 16:33:52 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1217310F238
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 16:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0KxI9XiCQEdYC74t4FzN0WMFJ/GvzxE4kBU/P05AriAPRT7/lsGdsD+0WmX75XAvPZVgfjI917CDSdjNvTaDpxLX7B4bvewNoPtfTlqu6OEgDmfRRhZ+sXr68HQaSYkA29qli2PDh+vPh48XATUuFL25u9UpfLWc5F7wnmjbL4TYIe2laojhou7bIkwKnH9wjbxQI/ySaswi5yuOdc+wwOJsGe+3M5tymmjdWAHFcyN1FwImae1na6OjW2EWudnP4ckciPvsk/E/w5YMTeDGl/ckbNSaHohGTkn3gk7vl03m5ThE4YPMLpacJrlbHdh1kbwtypTPlKeXrc2bA85WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfp4J3mFDRnYx5uzuQ7uEYpPVGmZ4GaWwx8K8Zq8izo=;
 b=iBYQCMZOeQRge+VWSaEpHakja7/GVufC7Glh6qgQ3KWGqwr4vybAy1RZt5cYqDFtJiR5u7r04T5u0ig32PYCAqoSRx9wtN2xJ8l/748kK++QL0GDOn5KsU5gXp9/t3nZjx1yH65ts+yVkNKXzQc8XrrZsDqSmVA44aQ1CEBdk62Om6M9t4M3wFLMjxmZyTwRxoGxtk1Z6ogYWbNiu48h+f13vS4s2SWspPNXrAdiLYr81V80Ki6M4Kk+tNX9rw3K6c8gFzsVQmP/jBmfUNbOg3T11L9qFmwmiqoiwcHCDfm07Z3TwVbZlgwuPTWvjj4sqvx2o2VbYm0HmkDbTXJZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfp4J3mFDRnYx5uzuQ7uEYpPVGmZ4GaWwx8K8Zq8izo=;
 b=ACvst0V+vDS81xGnN2qv7jJ6tRCvDQK232hXIWeMxs50lpdyAxi/cd0/6Q7XTgOGckT6Gcj/ejFQ+TZpJSWCSRKtRHFv3DRbcHzZt5r5CIxaJ6DtG7i6ZODqQXRGwiGALgVmy+6zfK/YwKkFFNxu4M6jVRBuKPEKYtNab3HPyTLyp690aHQxvPzuRuCMoOp/MuGHyO2/LZiCloyzT1fEPhsWArEtllCCsCczWwnRo4LjqWRTshwglkO3sWKZqCc7ATpg1cTrEcUCZS0CdRyn8trcJS2vd+tH4NNAK7xya3RpDdSve9u3uHOvHnLnLXqwCDjcf4iCtwWGdUMV3vSizg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MI9PR04MB290196.eurprd04.prod.outlook.com (2603:10a6:290:86::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 16:33:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 16:33:42 +0000
Date: Mon, 12 Oct 2026 11:33:30 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6q-apalis: Add VGA overlay
Message-ID: <as0L2th20tQqVpCJ@SMW015318>
References: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
 <20261012-v1-apalis-imx6-enable-vga-v1-3-8905d8746504@toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-v1-apalis-imx6-enable-vga-v1-3-8905d8746504@toradex.com>
X-ClientProxiedBy: PH3PEPF000040AE.namprd05.prod.outlook.com
 (2603:10b6:518:1::59) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MI9PR04MB290196:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fade8d-0f77-4259-9179-08df287e93d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: g7hPfbQ81xgWruHVQIsG1hgyeYDAsE4hOJxBNlMuu+O/fhAmjDSVYlDj7o68YB2A8p74T+rZFqz/4SE6ejHQtIk3IHDNJtOp9UuhrmRtzq6/fMgWpQVTkHQAnjZTKaULQ4fjHcGY1aOpqmm1z8zVaQwsow9DeTI7feR5blcBkroKXR++WE86dRWAJFNOPiatdYs/As5y2f3OZkzibv57pw01sfljAIQ3zl4mj+oC96Z+742Kye24VHJjyufrU9Re9tQeBEnG4HvTmiUEY1YIxdAPvHs1io6IBhJz33uMpP38kXjAWagb7cMbSoqg90brnhgnJEWLtROMl5xLghzvzu1tBoafPRC5pXt/3SgVL2U3ZhrhmXwhTpKxfmUjbPBU5bcmAMUILh/dL0Qvt7m1Zsbh0yBaWteUm91f631iLoevBUzmDeWX/BctXWFB3dUQx4j6hxnLKWeBe5P0sBwq6qzhpBil1fP2CWlCD7LMVJA8ihfqLN2z5GqXOthowoCXaHbmaFz/qjHDya52eJvPqsGwmEKBeoozxo9F2LwX1rKmzpPFVNNMZYjJt6JNTJVPPLn8g+3GlVGBndxoTnu7+iNF03iw0RqXv0XcdVyqxsptgPy/b2Ugl1sMtXwmQUDz9RjPLARXUq32KtaNzrblKTjelGvTnHsZO9N7Iftw5Xc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gMfhnsYPM0J9za1Q/v8yhq6Q6psxKq8pDvs6HCSXuCqClMhKeQPDjPJTcLAh?=
 =?us-ascii?Q?HfYThJItLDNA1siwG6knF7l5534pDfJx/o6Epo8piToH+zE7kRslVEy9A+sQ?=
 =?us-ascii?Q?psTwpo9uz6dBVpnodBpjvfoMpaxBa78QY3wy4i9tkgpCIL8kNBic+KY0rpSm?=
 =?us-ascii?Q?smg2vhOOlu4SR/tfRnufuUAMh8Ieht4pRKfXS53tAfzYjopKleWAAoXXxCqm?=
 =?us-ascii?Q?x9CMdAP0GDHVzfrjOtRELTWI46MQRmOoDOQ3PFQc8qtdUklBgk0vXPi326jx?=
 =?us-ascii?Q?U+gMz8yMYZy32tSc1XPe4/VpPVd1lQRL7QvTRwg0hK9ULRs5NpWSgUAzQ/4M?=
 =?us-ascii?Q?MpSzh0fMEOhSvPc980sKhJejE8JbSZNtSWxWmWT+rNoAhmFp9FrLM3jF+dKe?=
 =?us-ascii?Q?UdZ0ZBQxsOf9C0QBubR0jAVPX7UNBEMA6vQf0TLmt91qWqCfTWqqpBbsnzTW?=
 =?us-ascii?Q?e29q7NhnUwN2jU6X4krs8UdmVvoSokeFsgfIYVsw4RGgZGdklpmMUCaiZowe?=
 =?us-ascii?Q?SORdnXuushYfOdQi/kgqJTvXD/LBpfOkofFpqzaHxrWEe+UkoZgs7P8KUZzg?=
 =?us-ascii?Q?sjFkgv8xc3j1K2FgCPINYSaPyLH4bUX3e0dJ04i9ucjyO6ADyzr5QcMOOYzS?=
 =?us-ascii?Q?8IdgLibXeqwO2hdCAegYp7V2j6/AB7afC443+hcQQX5+Xy0IR/SWREDsmihy?=
 =?us-ascii?Q?tqdxiuKedD6W9cNMwgnAA07d6oO2+CaJoZZXhMDyCw3b3gyD8p7E9XarSEOy?=
 =?us-ascii?Q?dUmRVu+GJTXYWVsA3iiTb/wKOwlvFOSKeSTUDkIgOAtkrjtAcr0J7LAsNFiB?=
 =?us-ascii?Q?nR22O2iM3Z3F3eFDZiSGiALiCDOeS8MzW6rf5Z1o4lEOQC05RW4Ks7GcEzI0?=
 =?us-ascii?Q?qaUuDiIMkJ8Lp0H9K4r5MHTEN7Y4xsCOp4zguIkKOAshMapb3oksOqYE9zeB?=
 =?us-ascii?Q?+YUyUHobinuZLYI1h/46WKR8emWM8P6xas2clZf/zucWagIkngNxJwCP72lQ?=
 =?us-ascii?Q?U45b0g8N7bClO4NaCfpCWPqyRuzWCDoB7fjVT+FrS4YY5w/zXl6ObrAttQAf?=
 =?us-ascii?Q?pOne3j3onrZb28HclnQoqn56ZyEDkxiS85qXPwLQMC5tsUYCUIxIvFfgcH60?=
 =?us-ascii?Q?s5QmVFvhs/BNg+q95CgdSKwA3xOERDb2U6j5EQMvHYSpdtxQ9fL9R5Af/uk5?=
 =?us-ascii?Q?+J43/BXmllOfwo9PISL6D38bLizKeHmplrQIpTuCCfqAouHfs7h5iZKh2L7s?=
 =?us-ascii?Q?g7gMCj0ctC8k6lHcBAkbyYWLQBfXOy0i7pJyxOjukMVVZPsOJktkGSx7ZwwO?=
 =?us-ascii?Q?eT3SPILDTvlcfq6CzhVl5OKZ2XQvWUizlO6Hl8ziLUZcCLqxxCAnno/9m1jg?=
 =?us-ascii?Q?6Znhh8FuV97j8eO6cVykRVrYp5jiuFvUoJU50a2+FKWhJe0kA1lbEjK4TIS8?=
 =?us-ascii?Q?Niqd2HyMtm/V/4jIo3w8F4sF2wk3QyyU+c5waVOrYJyplQe2sA+kxN4N13JF?=
 =?us-ascii?Q?Ls8zGbqyr8yxMeuruRjCwi+kGEbgOLqmeT06k68fV8xu2EtDdbDgC18/fheQ?=
 =?us-ascii?Q?3lB1AJ1yNRUdIs5ynSBAk+DldvZhyuQ4PnikgJHiRQ7lCLxdmhmM32uA2TW6?=
 =?us-ascii?Q?2T6C4ud51YGw/ku97ducUzpJhI6XlVgMSC1lEhovU541x4vBgB6TZdaCZ/4L?=
 =?us-ascii?Q?SiPbYOlbzRRVJFoxJuesEuPhQC4Gvf5MDXT8sFkQmsnBipxQlj6aM5/v0NrI?=
 =?us-ascii?Q?7yDXQ8xKAxSmJHCYtFho85WAW1WgLnHHiKbhxjjRANvtrAoRN4+J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fade8d-0f77-4259-9179-08df287e93d7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 16:33:42.5546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTbpZc5QWU3M4zaFFtDniUu0IMy1A6PEtSF8/K2QpbApXKAI0aiQheqfyQQ+K22YU/zY8YJqgOhsmzObVEoVf9SAF+LTep9GlmQ3msHub7O3C48jXabenOONm74qj1NX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB290196
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

On Mon, Oct 12, 2026 at 04:25:25AM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
>
> Add a device tree overlay for the VGA output available on the Apalis
> Evaluation Board, which is driven from a parallel RGB interface passing
> through a non-programmable video DAC to a VGA connector, without VESA
> DDC I2C signals.
>
> The overlay is also combined with the various Apalis Evaluation Board
> device trees to provide ready-to-use DTBs.
>
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---
>  arch/arm/boot/dts/nxp/imx/Makefile                 | 21 ++++++
>  .../boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso    | 79 ++++++++++++++++++++++
>  2 files changed, 100 insertions(+)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
> index c5caca92ea10..b5ad9172e1f4 100644
> --- a/arch/arm/boot/dts/nxp/imx/Makefile
> +++ b/arch/arm/boot/dts/nxp/imx/Makefile
> @@ -59,6 +59,22 @@ dtb-$(CONFIG_SOC_IMX53) += \
>  imx53-qsb-hdmi-dtbs := imx53-qsb.dtb imx53-qsb-hdmi.dtbo
>  imx53-qsrb-hdmi-dtbs := imx53-qsrb.dtb imx53-qsb-hdmi.dtbo
>
> +imx6q-apalis-eval-v1.2-vga-dtbs := \
> +	imx6q-apalis-eval-v1.2.dtb \
> +	imx6q-apalis-eval-vga.dtbo
> +
> +imx6q-apalis-eval-vga-dtbs := \
> +	imx6q-apalis-eval.dtb \
> +	imx6q-apalis-eval-vga.dtbo
> +
> +imx6q-apalis-v1.2-eval-v1.2-vga-dtbs := \
> +	imx6q-apalis-v1.2-eval-v1.2.dtb \
> +	imx6q-apalis-eval-vga.dtbo
> +
> +imx6q-apalis-v1.2-eval-vga-dtbs := \
> +	imx6q-apalis-v1.2-eval.dtb \
> +	imx6q-apalis-eval-vga.dtbo
> +

Thank you using one overlay cover difference boards

Frank
