Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2472EC531F7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56CFB10E5B5;
	Thu, 23 Jul 2026 15:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NwQocpuJ";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF2210E5B5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 15:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozvDhHT9MGHlQqhYqgGFaBfB0uYvDNorvLqNvvSfo/l1I9ajhahFpdUwPwwhCBLCUgrIvf8M/Rz/0Uua0GpGIX1liYhqnEyVOyH2IaQ+U0Jor9UW4hYswot5IIFN/yc/EoVe/QpG9ktLx+NlS6qyymPuILTdt0eBU3PRiAdL1aJUZvGznVShGbrhh/NyTBkgu7x8S65H9S7rL9KOFKbE2poXC/idk807q88wJ2lS+4ZM2ZeGjnbShjgRu2HNhM5lcXdxxuahUV8saXdsqU/cCaHu1teWwH2Zw+M1N/bsKecc9S9N5ggOIM9E2a4cJ7YXn9T6EeIXGC539qHMel5y8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8ecDcUAHro2xqgEEzO1jOFitqzlrIVuC8O2K+3CQlY=;
 b=w8CWtRmyTgIbq+o21g5kYg29jm7yQz5HNZhBsz8h0IQ603cdD2SOH+d1Q6MdzG7loLmbxhYZ+srWDjFsk9LK5u9wS5dnIM/ELP9k3rf6KzU9gIcofEaxEA4CE1+DSAXS0IBGLH/vItTNnavRETNCZxtPV0tKpGM8raL3PX9vhfvYF2+UTRZHif8pxVfeoiAKMQrRqzuRxABbqJl3OzO0YSkWCiq/tPxEw+quzWZrN80yUH1z98TEx2Ev27rpED7r6CDcBQJLMbg/wr68/JOogrbkFd1HTw7AQmR0bmoxEcb0BirPKIV8UV2yaWwIYDhX5Q0/F5PwOAdOjoP6q7qSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8ecDcUAHro2xqgEEzO1jOFitqzlrIVuC8O2K+3CQlY=;
 b=NwQocpuJ2zieka9zSwQ/NBqJ9x2FnOSKcNXtKVEaWZPPzyxv74zOsuN4ly5G6pabpYuXI8OlhLdb9zcWwhDXi2wUC2MZ8PcJozTGKmJR1vNoF2nlMyDohE6IVQxwNGwuS2VqzLyz+iEaGDQHI+WOTfFbdOOgu6U4MXDmIDPV0l0IFEXGAXYY+TnhEDJwROnoA/fLTa/Pv1nssSXEJZ1Llo4zzpPcQxvndzi7ReEWShDvtrKoCvRkEtx40Q5uZX7cZVIb/ojPcNXsvpZdVXJFfzoIC5EaskDT2JSe5UerYC33cMvHqSv5FgOu9bHglnIzwCgwKDKUDEhzyJ1UMcn8lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10456.eurprd04.prod.outlook.com (2603:10a6:150:1cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:47:52 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:47:50 +0000
Date: Thu, 23 Jul 2026 10:47:36 -0500
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
Subject: Re: [PATCH v2 2/4] drm: mxsfb: Add optional DPI output bus-width
 configuration
Message-ID: <amI3mPBVXe0zj_tC@SMW015318>
References: <20260723093813.180089-1-francesco@dolcini.it>
 <20260723093813.180089-3-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723093813.180089-3-francesco@dolcini.it>
X-ClientProxiedBy: PH8P220CA0043.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10456:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a44849c-25b3-4750-2aa6-08dee8d1c008
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|23010399003|7416014|3023799007|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ihJc9vDWckRKuFzJvic2suEeWXHEvTz3Mz3gsv9o7Kro4TR1UAB5tB9pmSfNJXogz/epIak9C8VVVQvmxhCBBMZ4TDjJHUn5a9Bi5q1I1U0VPQwraf0gSDh5L38DiADCjhqq9oU70jLwkxJkoMZu61+be+w4ZTo8HFcLxVgfLetGdiyGIxVa7GhXgrKhbi3TI5taPfzwdvptMVlwNt0AbNRD0RSJzYpC2gqW7bje/ApOld8G52NdE/N64nQjK1Y1SWxXilqRWy2dzpRIXJl/W99NJnPXONOftO1UwG6PUtqOf6Fc92olpMNE5K/BgdhwxxaQQd4u+6n+H/KLnnCrXB7A4d5VHLMj+q7a8vJeTXGRvcurkOZjTohtWXeoWCfjwkz83mrSpkoUkoaViT01K8Z4RKdNjmBOAV0rs9WbtkhVnM5PhoR2NjGg4Yc4FTnw09G1NpUY1inqNSgf94bSu5JVPxOPN2aDVYGKAY+zvh0cnpsMujIZ9a0focarArMnMGNPsKBp+HwOqV6yupWO2+1hd9KNpqiI/Vp9gGNmlH5IqHLCVisEX6gNQM7hC/vPk8pQxOqS/ZsavS0rsXMVpNWNiCM6i4szkH86VhHm3tHBsn6UCM5eKOvttQLaqyViRb2u9qguTzE/NX+jO54JZOPY/pNL1dgBdAP3MPdCYA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(23010399003)(7416014)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?isGzWbSvU6pc8VDhKicMf9yMgcSx2NJHhZ+p9iJv6ag0Y1aw/iCl48D5sKzp?=
 =?us-ascii?Q?dw4qJbb8jf0Qzzp2vSfN8YTXAsvWV/NvJYLPXWNwna8kZceemd6pnYHiQ33q?=
 =?us-ascii?Q?+fFOlsEOsxSdf45QrYpd74A+dlSThJk0cNza7tPqHskU190mThDkA9MFuWT7?=
 =?us-ascii?Q?dV20JKXuhqgp6LYjA+RgLbr/H8mBi+xXYrlJ8ku7LRb7uzRzDTv4V5orJYxi?=
 =?us-ascii?Q?TMpDD5mGSgYtxLlHmQ9IgdZvhtDe7lqAAQXRV2XdpFcm2piGUtUYGg9aGhL5?=
 =?us-ascii?Q?u3pKyLg7ytfvGL4UFg4WXw3hSkzB3Zd7IqqB8GaW/hM+kjZ+ui0vQIQ9WFAp?=
 =?us-ascii?Q?7yfS/FXef3EBnhXpJjRrdg4m19V7VSsK1uC6VZRHviL2BTzDPNSF6j1YzAnW?=
 =?us-ascii?Q?kT6F3E0oXz6ERs8IkH6rbmE8ERLwQ/1/C6WUEQ6WhgeYMmxmo19XBLUr8RZ/?=
 =?us-ascii?Q?6kAmFF3cx7CyYkNO9kvuee6Zn8R85fa0TjlQ6a+FS+Ybk1xyjUGWpfBl4ri2?=
 =?us-ascii?Q?aYgY8ej/Z3QwNIYFzv9zk7+R0xJZ2LLii8RSx/LWNpv/FAHS2T+LgOsF+vul?=
 =?us-ascii?Q?mshbwdnWdgvBxrFSzthk3a886Rlkuglat4lgKnIJJkpTGcAfhTTc6dlv3loe?=
 =?us-ascii?Q?LC5Kzz+3AzlMKAIIGVAHopvjVQ+Q86kp5h1pTG4EKnyYuL+fdNQwUdtZY354?=
 =?us-ascii?Q?46uuyUn0+ZkAK9rLGHkbjsSH/vMcoC1d6Ja3JnUC9e0e8PkXSYS0raAMYPV5?=
 =?us-ascii?Q?IEkHmh0q2ude7Snh/zK8I/mrKRcnlsCz1C9X/iGfJ07uA7so2fLPr4SxFYP5?=
 =?us-ascii?Q?NdAm62no6C2FxfwzC/49+ripHWGlQ4uVC+u2FGld8qq2BGXNvoyjZ0keZnkX?=
 =?us-ascii?Q?jtq/IyY6RBmtN7BoSKGq47xv6wjlEQhgbecH7LkB8bMALmzrjRlLjDwvixDD?=
 =?us-ascii?Q?HUEaXqYA9hITfy+mG+zMxrQSoV0dt4+kBKbqGR8ZVPAYZnuh0qlEh/52JQIt?=
 =?us-ascii?Q?4UxeejsCjozv2xUutKvG589V9ilYhDQj7HORMjLGce9TWIOSakzyV5MNUo35?=
 =?us-ascii?Q?yjiMSjMBOAqXCCmITFZVkHXf6TWDsTiFnW673Zmrpso+apzuPFvJUbTXX33j?=
 =?us-ascii?Q?RXLvouYXrtzIcwL0X7Yq3FGmn9LGsSpk6jSCJMXFuMRuaaBGvBbvqRX7KqEY?=
 =?us-ascii?Q?e2dLKOpLC0Rww4GfJfVvoez8oZJgs/gEj/hGAaJ7+H7Ljs3eFZsBgddXHDIz?=
 =?us-ascii?Q?MOFqrtLq9SvBHbpBx6hU37Eaq2EU+5z6JQBId6m6BFtGWT6Dn28lj9z+FA/Q?=
 =?us-ascii?Q?8ZgzwgRnOxeGNZ+WG1q3CvW1nKjc5fGldGGB4sn/rTbMOArnTA0UUisnU2x1?=
 =?us-ascii?Q?WdKtegvAjAiLps62PgVFXwe9TYKOZhawIr3aW2byYUttur80AtKtyokPVkoI?=
 =?us-ascii?Q?AGmrAx2bnbrmYu+RAYHMtNkC29d+9cE6CKjaZwA0LaE7iMSDclxrb1i/POnl?=
 =?us-ascii?Q?8sRddV9VGww//+GQylyjUy8TTyC6hXe5b2oPaXWVaP8uK0aqq+h4xR27UQk+?=
 =?us-ascii?Q?hZLY846Asgu1NYWlIiu8QZf6LXvH/Q9GmsQPbOYnq8hR8vHk3SzkDzBW6Zk5?=
 =?us-ascii?Q?C42+i7WBi3m7t7H11TS9Sb3YYNKz/WCFgQ4noI6TbPlMHCFab2NDdOKdcGcs?=
 =?us-ascii?Q?iqIFhYuoqAlQKdBXXmOxbxIrm/zm0H0sYjGe0zTN9MvjGQNqjGjAZ6K5iu6H?=
 =?us-ascii?Q?vcM1O2pdCglKumVxr6t4Ch90GhPeiVt42knTXm+uOwd5ZtqiReVF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a44849c-25b3-4750-2aa6-08dee8d1c008
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:47:50.4370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwvMCeD7vNzELMUU9xoNGY5EdGEadv+nGftmn232wE8uPtNompbbWonUxuC9sA3gXRMktznkL+cxvRONQeS/Tjeiee1WENqlgo3o/dhLSDPDFwBg23ARLrHqCtSsIoRe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10456
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

On Thu, Jul 23, 2026 at 11:38:09AM +0200, Francesco Dolcini wrote:
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
> When the optional property is absent, continue using the format reported
> by the downstream display device, preserving the existing behavior.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2: use the common bus-width property instead of the legacy interface-pix-fmt
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h |  2 ++
>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 12 ++++++++++++
>  3 files changed, 38 insertions(+)
>
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 9b8fbda85d28..0545718a4b65 100644
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
> @@ -209,7 +212,10 @@ static int mxsfb_load(struct drm_device *drm,
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
> @@ -236,6 +242,24 @@ static int mxsfb_load(struct drm_device *drm,
>  	if (IS_ERR(mxsfb->clk_disp_axi))
>  		mxsfb->clk_disp_axi = NULL;
>
> +	ep = of_graph_get_next_endpoint(np, NULL);

use auto cleanup

	struct device_node *ep __free(device_node) = of_graph_get_next_endpoint(np, NULL);

Frank

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
