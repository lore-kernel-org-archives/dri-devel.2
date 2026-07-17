Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5734BC44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 05:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB5E10E2AC;
	Fri, 17 Jul 2026 05:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="EOlTkKJM";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D2F10E2AC
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 05:47:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SH+czLbb6yb8tbqyHQkc+v7eLManBkRlbfcNbPbz2gIEgpeENkbGyttBVPFGfhPg8XWQYAiJXF5VF4QSmhrVKfD+7zMP++CH5vyptjVexQ/gAtYwF/qGSPoigleqc8OFfBhLI5a+114/SAMa2PqP6Rnai+ivGw37cMqnNzzIiwqeUEaeeU65Z856NJrne5h8DxxtaQzgNRF9Mu6zfvlKEHuKC5FGg5y0HZlrpAJlj2BCGrb8TKy0909wra6lp4Ys7VoCH/t5cnKSYflQHm4QT8rddyWhZTgAQSDPHVa9JA7zXKOBRftSbt9OLNLdGarVQx9mvuUX2grMsZwPRqafkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Gv1ZF5LDI2taXwEJYc/oSMl0jZZYV+8tJv4uszM6uI=;
 b=lEYJ/AsIWwqxr6nwt77EKhR/V3nEG0KwVdU+N7rVsGyP7uIgObcaD0I4r8SYA21Yz6famViXYjjonQSOLt14lEYL0DMe8JntL7XFjfHlx5GjgQzoNV8qhIgz6WB2UZQtGNN/WWdOZi0zVdgnzDtj1tpK1AwSxPgX5cu6/3cfNOPdWwYEYvJGc2mjzCY7c8gtuDRh+hqKfgGlvIExeXXQUVi3QGiV0sKP3r8s6hBUgBAbyWkvu4sVe9/7n2isg3eX4n+AFiZgsyWFRsuo89vFwSpX9v45cHblTwLuOzrXJ6ueI+3hVx/4CUMW4NwqnHbx1/+O7k461YISnyuJxo8Y9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Gv1ZF5LDI2taXwEJYc/oSMl0jZZYV+8tJv4uszM6uI=;
 b=EOlTkKJMX49jcsaLRVm/IvVv9V0bFkSrmx3jfowEnHliKeRzWkLLr114DxTkQhPqL7IgEozGBtl+S6zEIrsPoH47m7m8PMgXr5lrgp87VGAtEr+0KBvZ9KzGYEA1b2mAcclStcyB/qca7YamU4bk9LtJSFGuprtVEXKKhage6IHcp81r/G9ojjXzjx9IZH3OLnYTJYRwwJ6L+bYIgC97A9EJcj8ZErsJn6fMRpbfbbWTCmLcZmPJH0zEYd9XmV9qGbeSm4vKvjFMKSR+umkw/I2FLqBwdr+5LBevE0U4k/mc/NcAdkNZdCwVjNDaxkiphi0/dApExyRuotMvNXUdvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by DB8PR04MB6778.eurprd04.prod.outlook.com (2603:10a6:10:111::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 05:47:05 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:47:04 +0000
Date: Fri, 17 Jul 2026 13:48:31 +0800
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
Subject: Re: [PATCH v2 3/7] drm/panel: simple: Add waiken WKS101WX001-WCT
 support
Message-ID: <alnCL7ylMyvGD-ui@raspi>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-3-da797562636e@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-dxl_lcdif-v2-3-da797562636e@nxp.com>
X-ClientProxiedBy: MA0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::8) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|DB8PR04MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e7cfbb-a6d1-4903-dd71-08dee3c6d4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|19092799006|11063799006|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: HE46VUijSE/LvzCjJrBCDu/g/Jv0Wqa39xLoXgQ6nZLbRd912d0PFVc6t4wNZ2kNkN23DxKcL+kymMnOyPJ7D9Cnpi6rI7gEzyA/plsC/V6KXoEARCU4SUwmPhjmUzFlqdVgtxwKdqcnCY7eGUQJ+woXlTzUSL4x9JXOFo65J0q0ntzpo1lffIcIz7rl4yQRInwgqU4GFFv+lpofSi5hXD6QD88l4KgHMrjzQBAUSTaPg+TbFuZpLxNUlxn7+8B7xRZnN+o4OizlA+8WAIzG5GEBDadJBF10JAna5wo7t/Q0mCc3iFm7Vgro45Ltl/2DOGGN2QXRJPK4gCkXtolPp/LNLdhSUoXRHqR4uXbWsgg8rEVBT2Gm7K6rjI5+s+oxDbCcb14oiK5GMXVhRfDWyrEGQpGUN0oGcnRG08DjID+1QDWJFMvCrX+1QrmMjvPtQo7Vc3B0jkZYnz0eZiLhHbd6hTGUgvNzKEg4DN5ecCpc+QQimuptX3EMcucykxJQeGosFpxdghptMGSsiPFsbd70lJ0G2/b30L/Gqr3nvngoXuzT3fH2UBsI1J8xUzBV0Y3ZxL3Cg6+bDvLmNtyehh9kfKXswy3AX+cat1ljaPhEKrwdW19/acOH5mSsi5TGJYCZXjG+26d3Lr9Ruw10dQfjqc5n7Tq5jTCLx29sq4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(19092799006)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K+Sux6ubARBX6vNVXcOX8tMvjuDgn6md+YgpbH20iUwUPxWh3Uu1i+sj170d?=
 =?us-ascii?Q?NyotUwstIg07gXBd7CP0m6LaRwCYGwEnEVbBtMmdRjRgjtYtlYVvguY/59JC?=
 =?us-ascii?Q?9WUMig0FizhVNdTDHl6uBcUPbuK2z+7datKamtH6djfyxiqPHzduFj++x6BP?=
 =?us-ascii?Q?wgXq9a5hqi9w5kIKZNkaO9vol2h0wd7kRodxEAcaMqXKWPI6AHUKMMFzeJ7M?=
 =?us-ascii?Q?l1zTAgYtLc/EH9BXQb1si9TC5PrPXA5oCksAxBSLsrCKkOQiOcNz6ohPYdlZ?=
 =?us-ascii?Q?yNiXD1hE6I5rj2rw93q/l/fxpftgvx9oU7XayJRG0M0oibVrm06yuoy6wyDm?=
 =?us-ascii?Q?9t8KSWfNT6lQlPrnmNZMC6Wh6upyhShopjM3DnbldM3UFyeMQlYsZL9gF/5/?=
 =?us-ascii?Q?VPK4agNaXxA576C9Ks24MoOWCsdEwXKZaGSrdOeQy9g8xRtXYiMZ7QxSL93l?=
 =?us-ascii?Q?5GvtST2yG9JwrOFyXDUa9iHEr1veLOGlGTQNbvS/dWcxSntZB+6VB8ng9WTa?=
 =?us-ascii?Q?TtDX6TMfHer75QbRVsAmsbVjDjN6WDzP3U32337hsEBmHa/vYBNmaIcLuDUN?=
 =?us-ascii?Q?v8vuefzLRGdhkPxJQ5nMA/9fB+RZxymbqea8xBIo/9rp3hyNmkHgJMbBESEm?=
 =?us-ascii?Q?ejNmTuD/rp7SkgEx1tMf3wD1RlGrTRdmCcfS6sEnjbDnkmjjVv5QY/vDIwx/?=
 =?us-ascii?Q?zfyL9WntqSIj1GbMknONKYWt1qkk8J1xO8e9Dv8eV3XA9f8buzKFaCl13coa?=
 =?us-ascii?Q?utvx4vLXGy5CH0JYO5UB5bscIyuDp332gQUxW036CZ3MvOwQXvj8xe4zSrp+?=
 =?us-ascii?Q?OKGMFQBEGD8HxbOR3R8/4lculIDtrFFvP0+ioDRLAcRQ0BpxhapBNc6jVfhT?=
 =?us-ascii?Q?zYJeI1+Mk9EWx0f/4AGPPYTV8+J2I2lat0N1zzZQp7v88lnFD0vfX0VwhrTg?=
 =?us-ascii?Q?peU6hi8HxVxMYgUMH885cu0/eRmxYjKj0lOTGH6hu1trPNk8VW6NUkDNyCvN?=
 =?us-ascii?Q?Tn+D9urEs2O79eX+uF/xF7Tp/g+RMrLHL+LUhXHqdtGnnpg9g4zR5kND39w0?=
 =?us-ascii?Q?EhLkyfNga0QrEtror5Me7pqPZ+mi1RzdMW6gG/ndiEoZWZlBUA2q4CMUj4Tk?=
 =?us-ascii?Q?3J7Dg/0/nb+zS1jQsgMxwPrdbY1r7Aoign0w0KdvFxbW5M4biSDzVVJVbs0k?=
 =?us-ascii?Q?wPLI7lknQL16A932nGJpXXz8x5l/QW6BKKXEPaqExgs9z15iMzVLNSVCD/FW?=
 =?us-ascii?Q?GwZT4fmntjXxkX/OZDp4cg8SdF9DnlFosf7qYf9cKnBJCX8V4JiWq4yP7A+M?=
 =?us-ascii?Q?VjhHSNlEzTbNZmKIyHuBNsBbjTHJ/a8vLBSxU1JTUiqObLq3/VBuCVG6ZC5W?=
 =?us-ascii?Q?Fz+2YP9EI/594/gurO/GWFlxPZ2HOR1s5w9eIOqBULiZBfvuXG9NaE+jsvf3?=
 =?us-ascii?Q?RMRy6T7H2VSJE0t9gEP0zKJ/Z2cJW88yztkeKg5wF7TyQKwmttPCtkOhqkRD?=
 =?us-ascii?Q?rhQIXgE4Ov7VQ5GxYyerEofsTJbVjtbtWj7PPO/ObQ6A83ka8JKoQ8LwPi1n?=
 =?us-ascii?Q?Y4HFqDwA23vX/yl1HUQ+6tBLKepv+8spsQQYLdzDoO1PTSrLxBHOiqNkkZeP?=
 =?us-ascii?Q?z89/tLBSQkOU0ChdbljWVsuStjyw2DK+tbQRg/tRZnYF3pQa2Vw55nxx1LMD?=
 =?us-ascii?Q?bBiYZT3dLws9XxRa/8xxbVw6/534LqlOR+XwoQpTM4LJhrt2Fovw7nuO+5nq?=
 =?us-ascii?Q?cjR1Vp7gpw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e7cfbb-a6d1-4903-dd71-08dee3c6d4b7
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:47:04.7997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKkrERdaLC56z6DVhGrXJoF+C4zHCbIwz3Jw/wCUl3jy0v7cgf8C8lTuQnh5PFjv5xShL6KcUtVHVJRMlgDtzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6778
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

On Wed, Jul 15, 2026 at 02:34:48PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add support for WKS101WX001-WCT panel, which is an industrial-grade
> 10.1-inch IPS TFT LCD capacitive touch screen display module.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - update height to 135 from 136 (sashiko)
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index c09bf3db5e78a..73a21303a612a 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -5171,6 +5171,34 @@ static const struct panel_desc vl050_8048nt_c01 = {
>  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
>  };
>  
> +static const struct drm_display_mode waiken_101wx001_mode = {
> +	.clock = 71100,
> +	.hdisplay = 1280,
> +	.hsync_start = 1280 + 70,
> +	.hsync_end = 1280 + 70 + 10,
> +	.htotal = 1280 + 70 + 10 + 80,
> +	.vdisplay = 800,
> +	.vsync_start = 800 + 10,
> +	.vsync_end = 800 + 10 + 3,
> +	.vtotal = 800 + 10 + 3 + 10,
> +	.width_mm = 217,
> +	.height_mm = 135,
> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +};
> +
> +static const struct panel_desc waiken_101wx001_panel = {
> +	.modes = &waiken_101wx001_mode,
> +	.num_modes = 1,
> +	.bpc = 6,
> +	.size = {
> +		.width = 217,
> +		.height = 135,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,

I find a panel specification in link [1] and guess it's for this panel.
It indicates that each color component width is 8 in 'RGB Input Interface
Description' table.

[1] https://community.nxp.com/t5/i-MX-RT-Crossover-MCUs/Optimizing-eLCDIF-throughput/m-p/982741/highlight/true?profile.language=en#M5348

> +	.connector_type = DRM_MODE_CONNECTOR_DPI,

Seems that the panel also supports LVDS input according to the specification,
since it mentions 'RGB or LVDS Interface'?

> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
> +};
> +
>  static const struct drm_display_mode waveshare_28_lcd_mode = {
>  	.clock = 50000,
>  	.hdisplay = 480,
> @@ -6155,6 +6183,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "vxt,vl050-8048nt-c01",
>  		.data = &vl050_8048nt_c01,
> +	}, {
> +		.compatible = "waiken,101wx001",
> +		.data = &waiken_101wx001_panel,
>  	}, {
>  		.compatible = "waveshare,2.8inch-panel",
>  		.data = &waveshare_28_lcd_panel
> 
> -- 
> 2.43.0
> 

-- 
Regards,
Liu Ying
