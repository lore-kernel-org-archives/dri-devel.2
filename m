Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478E606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dV274nEl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3ADF10FC5A;
	Wed, 21 Oct 2026 08:33:16 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D80710FC5A
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8WH2ynJuXrEvUphi18vadZQiC10R84eCLaapNi3tbI7U0rsnUpWtTvlPXp+kgbbG4yxmQO3xa8qmsLV053cCqLMDAThCSnpNDNZwZDq7uPgnNqulASvD0FK9o+olbnSrwXuIssJlb7j+28iOvbvLobrtxwXVo/7tMq8Fs7vV403nwj5SFjuvwYx4ISTJ0VjrDVp1tuhlreidqhXTdVSM+UQhY5EScQzHfW5/0n76ek7YZDAw0JIRdmP2DPefaeeN5rs9O/cofbfPwps9I+q9vUldtnJVuNZTI69+zb2PC0putDpzNuknBjZOfm2jGDp8JFmFVrcRTju8LuVLB9ItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctfaXuyqgrDhfw4QYgalVFgsb15uENE8orIVx0T2lmc=;
 b=oCGg+KHyEb2178fJYwhBbtW0SCSzkE8jc3QAwr0QJ3JRpYzRjkUe8Pq+LQppx645xpCgEOLR252kWf6Rt41XINYtlJd5H+nQd7RIRq6AIS6XtfbUOR1m/BrowhSqbbnF2GcOFW0Sm2YWdqpN2pLfNQMH4YO1JGJmhl6PbAJn91MnixHNPshtdT5H+iy+lhZfjcm+cyy06WOjIu75dpzMhUxNn42b6BVjDWKxeS9sniI6eqf8a0XAdV1k+LQSSi0OnE5alGoutt1OrBpGqctD2Qd9s75G28R6p9F4bYx2m5iybrC6zNhH0mQvkTnHSXb7+WTvhL+4NcKpjgwllKYI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctfaXuyqgrDhfw4QYgalVFgsb15uENE8orIVx0T2lmc=;
 b=dV274nElv2AFWlOpMk2MHoSVgbgFaNcJqO7zMsqsNTxScvjX5vJrate76HtcpXS9QuNAco94zcm6eOoPjtIUd5RFNtJhwbKUIMJTHoEfwF6KELJKOTve+ci96mRUtgoFwL8M6vBVt0UjN8sTEe0kymoiOiPGVrUssYK2jkL/hjVAO2IWjjc+ukziui4EXwHsq8hOn8YV49AvTwK9OQXP8Dx+UGj/yO/A8u8W5FyuR4jAvZCztNY6tToqlpnMyUeivIeTX56aFHMxt/pKOPAjjLuIAT/tlW19rTAkXMAdqxD+kc69P+e5btPyilHA1zwhgyJg88T0d5Lzm+IgPP5M+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 08:33:05 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 08:33:05 +0000
Date: Wed, 21 Oct 2026 16:34:40 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Frank.Li@oss.nxp.com
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Robert Chiras <robert.chiras@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: imx8dxl-evk: add lcdif overlay
Message-ID: <ath5IGyp8qv46GV3@raspi>
References: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
 <20261020-dxl_lcdif-v3-7-adc944659e14@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-dxl_lcdif-v3-7-adc944659e14@nxp.com>
X-ClientProxiedBy: MA5PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::16) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AS8PR04MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1bada2-d90a-4e8d-990f-08df2f4ded99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|19092799006|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: au0dtlBdVz7YZ1/pllq/p8wolb+BbksPD4qXPj1ERm69XMcT5IIUac4nkm9eRAykPQaaxAAkmhVLyQBrjN/rp1NmXFcLSb/sKrJNMY5n23uT+/5py/Z3a6PlpPkrpFq7Lz9E2XfVkD45b6LDgQkP2Km4ao4bp7FrjAWkRL26vfFxrAe+PnJ0XTQC57UEBosz1JyENyvu6agr9YiAL948zl9hyaz5gA5d7ESFEcdGIzAnK27ljobBXm/WwzWKa/1wJmzNPOGjDxRGBpAlZzVhaDffld+8pD6HZhsf5snTy4Rzp48lSbaeWR1iF+DmmT9vp6itlGw3x+MswG2rg4A3xvuK6UgB1Siq017GNuQahT8QrA6tJ1uSExiremIVOLsjt/cNlb01DWMRTxN9sYVpllf+EHvFYRC7+D7BjjCNefnmyXSmj+m1hc+63a0ajRFzljMsM4H7F1UQQccMxArjcs0nccY/C8lZytcWX1tFqWoIgUfdezMssCo9B6kp9IPPPoINR2W9UnaP3NQoWFINao3Jwmho418bMiyUO2YcHFwoW8bGQi5dVkyJS8Hh8EGZ6JigBPk+Y3uV3nIY8qP+GjEQPTcQM4IyareMGqoe2wzN4et/EDYvHtyyXlj+nPGTngkQQlyj9plNRQjZzS4bl+vduncsIx9o9J4o7Ds7YAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(19092799006)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PCKYM8x4IjoXZNjrx+H4gpROntw85KwvcKjcip+9ygSt6usP+V6FYyp2sav/?=
 =?us-ascii?Q?dY9dHRa8MEI8N+9tWfDHZF4KGYi6581XC7h+d5szkhq/xuUl9558ym+SFwMv?=
 =?us-ascii?Q?rsTjy7e5mv52kfLM82W+LneaDYr4ohmXYd2H2Dxh4qEWSvW4K7cW9We1zKJe?=
 =?us-ascii?Q?bzscRl/qt98kZ/5uA2dSIaofEd4Xjtjxq3/6O7VRI8AjQfEsKHNIZdvtOy4k?=
 =?us-ascii?Q?HhjR2Tvh/7eZDu7wNkoTXKtlWKQruSAKLWzg5K7XZ1+rFhgWayo7Omewx2bP?=
 =?us-ascii?Q?NlwvrC0Q0YO81Zchv9TTUkyboozCg1t6rMM1ThvYHshQtl4y3IZViDxCKeKr?=
 =?us-ascii?Q?p9OC17zoDYkAaY5tX3U+V0qNpqUUHkn3t4q0nabqEiB0VOOgNgOYv/ilYKvI?=
 =?us-ascii?Q?s4Fo2Jq73b1Ycx6Q4l0vjsG9GCZtskZu5Gq4kt+sy+v8nAyohzucBlu3dZTr?=
 =?us-ascii?Q?uCj3OIfKBqXHZ78G55sSyr8UUuezNJ7ZpG2d9lohIVtG1Gs5tnJF/DEi4r1y?=
 =?us-ascii?Q?JvG03Z2AgcHxJB2KH7kOdAyACJC6RRerg0aQjAAZ2LxzWIH6Tasu844mX7G1?=
 =?us-ascii?Q?NtV1bI8BivXmvg1hmSz+o4e+tfvOKPQJ1JABteG5SlO6Jgzbt7dtc1ifL/eE?=
 =?us-ascii?Q?hka9lKuV7HZ2qe+cCsJvBGoxR63Rs4KHOARtYkmJoAC+8S7Nkra708yJsxvO?=
 =?us-ascii?Q?LRWqijFeDQa6BKo4RglVv8ZKcKQDqCz7NQQ8eNjLe5Y6UcTzpnkukHCjPng1?=
 =?us-ascii?Q?lu7S5Wsyxoi8RyjqtFd5eom8lTuAJcdiAjdPvqLONiZQz8dpNHKpGm2KaTz5?=
 =?us-ascii?Q?AMV6QJ3eZ6qJiOAmcpFrScXpMN5wjS7Ue7P2UUsCVXR/ZyO74ng35xdUNo8m?=
 =?us-ascii?Q?nWmuHSvwMCwRo5gPxvjuhWSZppxY0u3Ef7h7x8lOuzsCRm90EaU5MNha0124?=
 =?us-ascii?Q?/ZvVWHkXIpuWVoPp/oxaXdxRmg5s3sPfWTEdxjaNCbZI5eMAOgpkr9snQTD2?=
 =?us-ascii?Q?fB+UDOJnMc395tW8kLaXvgqH+y7wkxthQt9PuTwDX81YqrILRE4tbf2CZ2f9?=
 =?us-ascii?Q?KCkwYFYwKe7RYxpUndEPNxkHtfSWc/iPcySonr8pRmve+Hc1jSgAiPzytpWT?=
 =?us-ascii?Q?rvKa4AQVLouuwn2RI/HOB6QXi8wypkvVpLcYVLD+uqV+Q58rOd9H+pV3yMjS?=
 =?us-ascii?Q?LaefJDQq/LLnJEaHeNjJ/gpi5nZIsWRO7DK/9ezujSL/Qs0wPmcgQupha7UU?=
 =?us-ascii?Q?8ZRZTRidU2DdmjurciiIdUz1VMO8Pxfb1RiM5JLy9MHohMeXpfridZ15k9P3?=
 =?us-ascii?Q?JHeqBF4JUjcd4mg/DGjqIZ7fnXIoaimot3pKDuYBs3MHo5mhuZJAlfPBHQdM?=
 =?us-ascii?Q?98XTd0dj5GsmmFCaz6nA+GCZj9xtRv93w5umBUvDuGWPQuiVUN4oI9eNASiX?=
 =?us-ascii?Q?e8ribecJtWRIjFAeaDTs4+yDHUHIU5js+xIftYyxh6dcqMU7UqUhCiOskulO?=
 =?us-ascii?Q?GzXuC8oVcr99hQPM2zc73oBcQf/YCGs72T5wJ0pJAqc7x7hgAA1SU3wrCrW3?=
 =?us-ascii?Q?xQi4qYesHz1XFQZkTUvJNK2Ls47Pnv/xH8+UE0gc2LIFwK4pmKn6v++3l4e0?=
 =?us-ascii?Q?aNDNG5o5YsR5v97/OlE/zZRhSWtvIySgnQIJmxw1Bzkbn4uNG7DVVNHNtfD/?=
 =?us-ascii?Q?knME2X0uQYfQHAK4Gia/rsDJiy5YLHjpdISdx9sUSBCgZgn6XlGVh68D1AfE?=
 =?us-ascii?Q?zqfy+mQQCg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1bada2-d90a-4e8d-990f-08df2f4ded99
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:33:05.5763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noBLNu+xKy89jtfaQFpvBXVfbS4g5nj2FCdBS0pui9RYDg/KnOG1sXa1h8M2fS5KAtZqoguTzgAmbUe2OJfLFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 04:12:57PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add lcd panel (waiken,101wx001-wct) support. This panel is only used at
> imx8dxl evk boards. And evk board only supports one panel.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change in v3
> - add panel info at overlay file.
> - add bus-width = <18>, which only connect 18 lines.
> - rename to waiken,101wx001-wct
> 
> change in v2
> - remove iomux hog (sashiko)
> - add power-supply
> ---
>  arch/arm64/boot/dts/freescale/Makefile             |   3 +
>  .../dts/freescale/imx8dxl-evk-lcdif-101wx001.dtso  | 119 +++++++++++++++++++++
>  2 files changed, 122 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index a80cccf34eb56..b5d5e6bd8ce06 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -113,6 +113,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris-v2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
>  
> +imx8dxl-evk-lcdif-101wx001-dtbs += imx8dxl-evk.dtb imx8dxl-evk-lcdif-101wx001.dtbo
> +dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-lcdif-101wx001.dtb

Use full panel type:
s/101wx001/101wx001_wct/

> +
>  imx8dxl-evk-pcie-ep-dtbs += imx8dxl-evk.dtb imx-pcie0-ep.dtbo
>  dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-pcie-ep.dtb
>  DTC_FLAGS_imx8dxl-hummingboard-telematics := -@
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001.dtso b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001.dtso
> new file mode 100644
> index 0000000000000..39abf9b3884ea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001.dtso
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2026 NXP.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/pads-imx8dxl.h>
> +
> +&{/} {
> +	lcd_backlight: backlight {

Nit: s/lcd_backlight/backlight/

> +		compatible = "gpio-backlight";
> +		gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	lcd-panel {

Nit: s/lcd-panel/panel/

-- 
Regards,
Liu Ying
