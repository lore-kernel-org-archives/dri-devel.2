Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4EFC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB9D10F023;
	Wed, 12 Aug 2026 14:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gVmwqn/m";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013041.outbound.protection.outlook.com
 [40.107.162.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4E410F023
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdMFGXYaeMiz54Lkc8/G7pmRFgOp6YPoqG4hkd3X8wNiSb8boKveCGrbfaXiWd+kMZC/CSny0snGp7ta8V7ulUgmdavuelMcfeYIr8d3m0fU0pW2UGpX/yfDSm1/23fDCce8vOUwyXMLh9Rt6i4GDugXebWWHLtYG66hhnP8u9kJRMBVWBJejwE2eP1y3Cp0FOKv/lsM2n25RQPN7BvV/n12/2XNxX8fD1BH2zFa6IIo5iwwF5Oj2OBXdy0PAnIUHk5Jgki5Yzu4wmRuJ9ui1DAKUpKgxzv3P6s9CVupgJtM8nHxnz+AxKgOu0WmEZ6WVn4f4RwLjy21UD0QnWjvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An4zeuydARqKnZALFmdBlJulO67EiBLBol4gK5VRiKg=;
 b=tDNIpEz59RiXB49be+mek9roPtpCgPxNJ51cY6Ah/cUmJrQUMUYadepoYniYR9mkkXdax2W4TlPNBIyBDtgbUcffNm7y6Mc4rTj/Cy3osW8XlI9Te+h9ZbEhZD+TR8Z+506/eir+uQjfsMQdzaBbjIYE2qdda5f3pyoXR15x3Xxm31rrYrOv4h9nUiBJqk5fxmTTndhOT0Vp0SuLzN7lT+WMpMBxfWMfoTNMuSiS/rC9/2fhe0EvB7fM3+zgBdJJ9W4ok949X0X5Jc22yWT6UKzvgX9ZcdK4mFmDwK9Z6QRmnVlGIPf1I+GcStesNO0xJ9I9E6bwuqBvx6hlMfkiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An4zeuydARqKnZALFmdBlJulO67EiBLBol4gK5VRiKg=;
 b=gVmwqn/msOikpfTwSCso/stG4wbLmLvnPwgoV0R5HfIXtfnMUvo2nFNEFfk46+U9ldHfsafUPPkwapwD/8Q9ue0JKH0xaYm7crETZb1jmZrGuxQekZPXAcD+CxEYdKlIPWN9H+ij7O8qlUWD6QRuy1TrmwlIue3prQAtE6r2XDreqB3R4Pt1ATVrwHaVoi2HMIGomD8+F1eYeEgOV3mhHFKrPUEp7gFUxQ0LdAWfj8Aoz0NBmICneWsHGSje9oKNHP8S1R/eB6VCSsrIRc7fyQqKYmQTmUfj2naLGXPvw9nQO8jL2oBtw8MVA2P8izKpqOdQziUYA6M5f4/SJzpSqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6978.eurprd04.prod.outlook.com (2603:10a6:208:17d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 14:20:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 14:20:31 +0000
Date: Wed, 12 Aug 2026 09:20:20 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] drm: mxsfb: Add optional DPI output bus-width
 configuration
Message-ID: <anyBJMt6U2zXKlCh@SMW015318>
References: <20260812132954.148571-1-francesco@dolcini.it>
 <20260812132954.148571-3-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812132954.148571-3-francesco@dolcini.it>
X-ClientProxiedBy: PH7PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:510:23d::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b74a6d-892b-4640-7183-08def87cddb8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|23010399003|376014|1800799024|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: oA56ete6xLyhz9RXXKEm3LJSk6rv+IywT7Q8+0pk3dUZ7ANTc5FFU/HtYM14S1wqq8SNOa8BLg09P0plSifpaa0KZnnYEMzG+FgmeaionX7FpT3jl9YpVBqayoRqG1T7AGmZ131Y/FBS/QmnfLa+63wJNXbCyad/sojMpqxwEud29QtRL6L6GZ18cseTxAyoDIGGwllEMyiAgnWsg9t1/jNkRFixlOemf3AumQCHWf32DQuPALl7OXJKnYojyZKy++tylTUBjIccXtHeJQle3EYDn8l73VXCKUaccIJ/WeGQeARigA23yWxmooOztGCUtSd7cW6/aTBNnxjkqkB7XtTs3wWgXVqc5R9nbxaoNwVjrMrY1r1peqQ5STGXOsnhVIULFo5XSZjg0o2PwegoRqxP0GP++/85MT4eKKSxH82RSXmnw+euFRPmmBKY8UhQX2MR1wQPmqn+wQ58EQprSfCWxq/023kz2BdXEDWGARxhlotSq+parWaxBS6DOgw0/l5/Kzit9uo0qu2WDmh8I4ws4ooiaJftZnxahBse7gdhBy9UXNUHJnzbdOWbs6PqWDiguc3eD2It64Ca/05s10dpBjtl54sFwmwGE8s0P9EgMpa8j4GrSonOA1YGfx7Pt/dF0ouZ+GJGsrLJNKcqpdYDUjiyHQGcYPNEuJvb1Gw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZLvgR4RgqAB2Bkf4O6inC4uRbfrGE5kd9UP9Fwtp2U3xr2e7Il10Ckop8XzK?=
 =?us-ascii?Q?o9pGq30y2XLAbVfN7s5eNawOTcd5ykY8dqkbx7imlMbbeAEWJavTzWQtL7aN?=
 =?us-ascii?Q?SctEOnSvyWMujCaDVs33P+YDhPqIgnPX37OginC/fgCazmHjlYJmoNx9b5vE?=
 =?us-ascii?Q?lXc1F+qj4oS6lB8j9SQtPjbgBT4gBlgQ2YygtsILfoQ/VTxhyTTVM9CZ2rG6?=
 =?us-ascii?Q?uRCaRMlBUNFefVk48sccgtJZsLZhfJhcqWQAYahjTe1igenP2CSLFj+5uD8T?=
 =?us-ascii?Q?7SQBOoG4C6TNLk+RHGQkDB+yxCu2uoRRPq3QwLpK+O53NatvtqaLwthdIDSm?=
 =?us-ascii?Q?aU67CPTZgyd7G1KaPxDuiubKRu+YEbgEW47/kQkxlgjbzZDtdjPkgZvbS0Fn?=
 =?us-ascii?Q?xrSPH3u4BjhAHHwswwPLE8pFv7gTCirIVS7qybGtYZf7SeETweOcZY1s8NkI?=
 =?us-ascii?Q?mDaGielD3YfbMUxbP1EfnAr/3DV5rGpiab3KwKdHpmY0lGSdOJnF21e2rRKV?=
 =?us-ascii?Q?GLIBOZ6aQq/JQPTEBgvEXnl58HKf/teqfSBrLVqY74GCFbq2cOfJLdC6uqCT?=
 =?us-ascii?Q?WOIkS5u+Rdy0hg4wyGSIfySFr3z0Z7WdOuH3Ig4m+wyQeppXFkjU/df8DpHh?=
 =?us-ascii?Q?tukwboLTyFI9UWqhk3TSUAJbmVM4Is7pFtni1e8i/oeC9T6vL9xtGWKtwtQo?=
 =?us-ascii?Q?f0v1X1rRf2GRFAEsbJIuQxXB3H8fGubrbWl8G8h3midpkiK9ZEVNMa+lsUm7?=
 =?us-ascii?Q?1iwJQEl+FI+Jc7PlbZPnM+iGG2PnGiFHm9s807VnUcxrTkzH7fshWngrpqwv?=
 =?us-ascii?Q?IX+nRjqnl7wi/SfFPYywEJzImPEjP/Hnjby6TsTSCThEAcPqKu4WlKrD4AnK?=
 =?us-ascii?Q?wPryiUPCoyngBw+DzP6LqzCZPh5siPWk1aaIbPES2LmgQVTGn9NzB2go8R+V?=
 =?us-ascii?Q?tc6vUPGsvXBvsJd0DkyAp3m+9IhkE5Gv2tiy1L+BfGn2bnNms7N2W6xBqfQx?=
 =?us-ascii?Q?t+Vrr9SZIgzSsyWxjOc49x+z5SYZpuAaIjWnGabQaL8tj0ckzQYomjcUupqd?=
 =?us-ascii?Q?dPz6yaF+tE+XHMMyfDu2tWlSBFJT31dLKtGDh6QmqeYrvIreEFERygQESw83?=
 =?us-ascii?Q?I8fsBswKZICLIumVIRL1eF9IwWAHa94ax2PzWVR8JiYtEykLZXT0Boq7uQuW?=
 =?us-ascii?Q?5uvK7kjnK0W8Mj/I48Xi6lhQJJ3E2G1r09B9ie54BsoNZiczraxJTroq+ZDN?=
 =?us-ascii?Q?JLCqmcEAI+8Vnm0Zd2jBUkQAl+Ql6z7MHZviAOf/75miYuTDkVJ0FXfr80d1?=
 =?us-ascii?Q?CDs78ObV17duaxB49m1N9YBOhB6tmzuIqOTg8v1yv1ks+F+UM6AMBW2PLB9A?=
 =?us-ascii?Q?U0UwYqwHUUq2iDzYBTLN0mMC1TsvMVkF6wMqzHX3LdM5XQs3M9yeIXEu8KSC?=
 =?us-ascii?Q?aX/PxLaWsR+rM8eYuU8YG9fGAX+Wvlk2LqeB9WjhVw7GqtdEb9YI27Fmpyeo?=
 =?us-ascii?Q?8dnqjbz1dia8Cym4EHjlKhx9egyr4DXlUHyqogvFvfYwTyqYgYV/k2thGVR1?=
 =?us-ascii?Q?MILbHspsVGu1Btk74Wg730qPoDHkfZHDOwIpeEifnzFD/0lvj8ZiL2TgY4mu?=
 =?us-ascii?Q?nyDJ7V1nJxYAbhzGsp7vuZa3pFbLmEWDa+aPD3YtByPpBBb0iF0XPSljJRqW?=
 =?us-ascii?Q?PdEMTfrq8ERwBHqazMlMSeXcy7VX1Rvjj8CxXMTlp5xwDpEaCjNmA30/nPzA?=
 =?us-ascii?Q?UhiqXMLmWZmVZT9Npsr1ZUcL0F45n1K0uN9tStesgy4hYamFBrma?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b74a6d-892b-4640-7183-08def87cddb8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 14:20:31.5845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44WUBCeUJNrRwfQ9aMEf0K/agW4SfbA/PQK/lt2QBg+ES6+QLU1ZdhaiA4D2TFACjiGOU1yOA0Ay7NNlAXgxyRyD3oDAbYymG+7jWUQErNphTXTONgxe4/T/pGUuqEqQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6978
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

On Wed, Aug 12, 2026 at 03:29:50PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> LCDIF programs LCD_DATABUS_WIDTH from the selected media bus format. The
> format reported by the downstream panel or bridge describes the display
> input, but it does not describe how the LCDIF data pins are physically
> wired on the board.
>
> These can differ. For example, a 16-bit LCDIF bus can be connected to a
> 24-bit display by wiring the available color bits to the corresponding
> display inputs. In that case, using the display's 24-bit format to
> configure LCDIF selects the wrong data-bus mode and changes the assignment
> of color bits on the LCD_DATA pins.
>
> Read the optional bus-width endpoint property from the LCDIF output port
> and use it to select the media bus format used to configure LCDIF. This
> allows the LCDIF bus mode to describe the physical interface
> independently of the downstream display format.
>
> When the optional property is absent, or it has an invalid value, continue
> using the format reported by the downstream display device, preserving
> the existing behavior. The code is not validating the DT for
> correctness and just fall back to the previous behavior in case of
> errors.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v3: improve commit message and make it clear that the code assumes that
>     the DT is correct, when the DT contains an invalid property value,
>     the code safely fall-back to the previous behavior
> v2: use the common bus-width property instead of the legacy interface-pix-fmt
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h |  2 ++
>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 12 ++++++++++++
>  3 files changed, 38 insertions(+)
>
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 8b4a500347fb..f8ecc8bbd63c 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -12,7 +12,10 @@
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
> +#include <linux/media-bus-format.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/pm_runtime.h>
> @@ -211,7 +214,10 @@ static int mxsfb_load(struct drm_device *drm,
>  		      const struct mxsfb_devdata *devdata)
>  {
>  	struct platform_device *pdev = to_platform_device(drm->dev);
> +	struct device_node *np = pdev->dev.of_node;
>  	struct mxsfb_drm_private *mxsfb;
> +	struct device_node *ep;
> +	u32 bus_width = 0;
>  	int ret;
>
>  	mxsfb = devm_kzalloc(&pdev->dev, sizeof(*mxsfb), GFP_KERNEL);
> @@ -238,6 +244,24 @@ static int mxsfb_load(struct drm_device *drm,
>  	if (IS_ERR(mxsfb->clk_disp_axi))
>  		mxsfb->clk_disp_axi = NULL;
>
> +	ep = of_graph_get_next_endpoint(np, NULL);
> +	if (ep) {
> +		of_property_read_u32(ep, "bus-width", &bus_width);
> +		of_node_put(ep);
> +	}
> +
> +	switch (bus_width) {
> +	case 16:
> +		mxsfb->bus_format = MEDIA_BUS_FMT_RGB565_1X16;
> +		break;
> +	case 18:
> +		mxsfb->bus_format = MEDIA_BUS_FMT_RGB666_1X18;
> +		break;
> +	case 24:
> +		mxsfb->bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> +		break;
> +	}
> +
>  	ret = dma_set_mask_and_coherent(drm->dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> index d160d921b25f..bdc47ce5be79 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> @@ -46,6 +46,8 @@ struct mxsfb_drm_private {
>  	struct drm_connector		*connector;
>  	struct drm_bridge		*bridge;
>
> +	u32				bus_format;
> +
>  	bool				crc_active;
>  };
>
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> index d8ebebc5314b..1d78c486d147 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -386,6 +386,18 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
>  	if (!bus_format)
>  		bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>
> +	/*
> +	 * Prefer the bus format derived from the OF graph endpoint "bus-width"
> +	 * property when available. Otherwise, use the bus format reported by
> +	 * the downstream bridge or panel.
> +	 *
> +	 * This supports mismatched display and interface bus widths, such as
> +	 * a 24-bit panel connected through an 18-bit interface or an 18-bit
> +	 * panel connected through a 24-bit interface.
> +	 */
> +	if (mxsfb->bus_format)
> +		bus_format = mxsfb->bus_format;
> +
>  	mxsfb_crtc_mode_set_nofb(mxsfb, bridge_state, bus_format);
>
>  	/* Write cur_buf as well to avoid an initial corrupt frame */
> --
> 2.47.3
>
>
