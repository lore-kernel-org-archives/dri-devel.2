Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017A7CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C2910E63A;
	Mon, 12 Oct 2026 16:30:44 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF99F10E63A
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 16:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMj44Cnm/8bnm6s5GG/3AGlnJeqXLXT64pcBMWYtL7n1PnfARFkGhw/1nF8lIAut0sVEYMg5N0EkyV+raV5+3meCD31Ix+B7ZAHZoh+NtZsNdCXqZy3ostn4gcJJ+bKFdMWTSAsqfE2oZkwAYiyvcvnyVbh+q66zhLQVpMyFe7w+W5hE1HyTmKg5/Ic+O98z3U2oRlZ+HgeWRmZ3F4k6RMFKnmes2T7jy1+KZ5r+yoX6PCg2q9VQ1FBI2zVWEDMa+HmSZ1xaVu+/sJN/54j7/LIjvLYq6bLT0Hcmk546ayttdSnGxVaba4TlMLAw8ohJtFjKMcoGl8a5Fe7YXlGv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruTppP+7W98tqZGMvNAcc100aWQHlxE2OBWHYch/vlc=;
 b=f/k5j+M9kkL4MSvZwyV7cO7o2ZEWocJ2KYEefSpEh8Ba+DdJHAmaOu7wqghQHrANjavRbzHTnljeNxXOS0H1jz/KgstqIm61h9LDlW4g+hkyMS8Asj9WmV0LSTUwmXKDRmECj8MCu7NO7pwHyMZmTBQAB+VkILzOTFfLjcrjzqAvvB+c8cdsox/gPBG61SbIepXXxTRN90YS++LCgi78NnY4dWaCfJgGDKll4YEb5o1gkUcjOtMqGNipRcQbBq6b34TYBf+JDs95TPHXoN5HKNNMyahx0wVRyP5xoiKA6vWczsnEfPhSiugdskAAidskCFoch+MJ9rHQw7e62GZlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruTppP+7W98tqZGMvNAcc100aWQHlxE2OBWHYch/vlc=;
 b=wgJjCX+Xuenc6MRQ97NAdMcG5e4iK63OMYGTdx8zAGkKSq2wjcHFGGghXzBxGoCwhhCO6SjWFTT3Ng2OqwOIeNzuRJgY+P1R2praihV3j0jxzRhaeeYsms2vr3uSzYuFvjXTXepIF3oJLwYnodKIklx9mEik4yS149s3rQX+TRmDFQgDxMxSjlNeXxzBUFDq6zGtK6geZ8YwH/F9PPFeowtU/VqH+8G3Ow8+dw034e6pF269b+AahjU2Ud6FHNXxDWyk9iFw67hIkt1cWpRlc+ytk0ncBp5SOPxQflobHwX/z+FrmjyfA2Ob+rCoSf0GTcvop9aNj4absx4Z6V4lVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MI9PR04MB290196.eurprd04.prod.outlook.com (2603:10a6:290:86::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 16:30:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 16:30:34 +0000
Date: Mon, 12 Oct 2026 11:30:22 -0500
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
Subject: Re: [PATCH 2/3] drm/bridge: simple-bridge: Add Toradex RGB to VGA
 DAC bridge
Message-ID: <as0LHvZdqhl4HOup@SMW015318>
References: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
 <20261012-v1-apalis-imx6-enable-vga-v1-2-8905d8746504@toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-v1-apalis-imx6-enable-vga-v1-2-8905d8746504@toradex.com>
X-ClientProxiedBy: CY5PR22CA0090.namprd22.prod.outlook.com
 (2603:10b6:930:65::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MI9PR04MB290196:EE_
X-MS-Office365-Filtering-Correlation-Id: b4405117-5f6b-4e01-f370-08df287e23b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: e39gFeiPpdbbsDAgQiHjQcPXf1uJsBiDqSNXkS2qa8wvbln7QsYnQiaLLujMsqUwQV8krt9dwgMHhXLOEdOgDeF9fYHdXmVlVHVTiVGqSOrm53H7qvROFAdh2rAUkd7oUU0JMb40h38buIzRa05bjySyOGtnoYDsuX7CD+NBmS9giih0Qz7GcLCqaMtIIgRuuGhXR9goKkifpE1HFymwMP3l4ef9KpdEl6GuAeNj15b/MhTHyXMH8Iw0dblcZkpUUJ9maC0FZTW1SMHYdt6RNsjI6ueNApCpnSC2Wm4fsE2llBU2/zrEq0+raUk/wbpJ7Q7gfjKeY7hGXtKySFL/GZLA9DwIJqM3fogQZPQ7epJRDI1RpDtRe+NmC4yttkZnP0UrbKkfHKhtFSfOksOxODTnx9ZNTjB2FHmrEwvkf1N7kplF2nd3yi9a/qXxsGn676la7mesHZqIPkbDGWa4c4ZREyAgP8kfl5nihBVMAeDpUUaKFUxFW+l4APNE9V/dOoNdH4AhknrlWIM1A1/Nx9CiclLEljEntGxcQhKOjtKvZlDQ4ynbrBweFjnyvine4i051gmOPI/p+dbZpR4kAGiSOFLw0y/SPSD65IEWFjr4QWFsWTTdniWw9Pcu+pExPbQfGXAufq5vlkbjXbe+NQ3yAda8ESjvVjF1aafjy0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?667PUoKW9oka/GDM/rMlid8vdxgLO8+iomuZScRxCDV0mZ93gBZ7kVtvAHkU?=
 =?us-ascii?Q?NeSvVfxTa4jM9m6j6Ai66sD0zr/TyuF8a+9JFm6UVS5M/9wTALSGSbt4/PGe?=
 =?us-ascii?Q?12NPyVT7p3MY7+8nJsa7n8TUmrwf2x64w8sqgG9ouA2YhnWsi/K1BM2SSQj1?=
 =?us-ascii?Q?Dav1cKFSi8BA3v4VpcX9KtUzqp2fS82IniJ/r8D84ydYXIsQTf1cB3qfdnQW?=
 =?us-ascii?Q?e51HiMpyatEW+2QI80u/WA3nDsCXrhLm8hbfltXsqE+7ZNOYU/KHRDYudYJg?=
 =?us-ascii?Q?AoaoARc8Oi+77mqfgQ8rkm/0+R/89oTNrurPOkJByPQc9raDa+2hBYLoO1sA?=
 =?us-ascii?Q?78WlMizsAck0gHdB16JbXi5xjCFmlksr9vrkQsD1Z0uXc4kp4ZMk6rvg9qfw?=
 =?us-ascii?Q?0OmbzIvGZD5n8ojKt7zi8JOkAoNB6kfqgWYlUmRTL0CwrFftd6QGpfNjkQ5G?=
 =?us-ascii?Q?fPewATc4zBD56P1AZqSuC2dvn0oBNBxWyNY62kUzuSFqmxRAU2aUwz3WsvRE?=
 =?us-ascii?Q?ycN8KK+/fq5eaJGQ5FlcKjDA/XInj8zb8YwmSz3N46ozMTniy+xr6NPffUfC?=
 =?us-ascii?Q?q4bzUbUeYZgRh4W1+E5dJtb5QMdXxGN+OGD9jon+ekpselsGKsJojVb1DSBw?=
 =?us-ascii?Q?bAe4IcHailSJp/G3cC2m1mAudpohmj7APjQzP/QiWoeaqHMShZRtsstHad/5?=
 =?us-ascii?Q?Rov9a8/w9TUzbsQRJXLaYp6HocEyo5YWrLppzjRHYIWeXSmJGOaGMdOgTxvM?=
 =?us-ascii?Q?i/a/6IO69mim5K3JGmrjWebGRFP/fDLYEoN/xqkN87C0wymTAj0IvPWsTDWM?=
 =?us-ascii?Q?XtdvEZIVUQxJsvsDSEXjGICUTB7qrbt2j7/6NYnge8BUsy96IW4pnrQ3qOb7?=
 =?us-ascii?Q?c2b1E/wrtGaSoTcSAxTsubmQZuZWQW69zy+U7HlzcUeCVCWJPizggKMO6uVe?=
 =?us-ascii?Q?dAj8FA7EaEJ5uGttzbKMtgTv12il49lArAh2jlmsNjELlkcQbbwpHEBFX9yk?=
 =?us-ascii?Q?2itf31YE1Uf94B98GRy4BzuRKs88N4tfmm94djAmsPpzzbdLB11K1DPBjsV/?=
 =?us-ascii?Q?7FOBvrcPanDdEgAmPdFpxPAk/V2mZaSUaBTnhE962WJgvSllsr6bjr7yihmK?=
 =?us-ascii?Q?TNj/zD3+fuIbxshwd3KKS3HY3UCw7h0ApCRyXcRx6Q7skYKGLGtyVSh0lM8c?=
 =?us-ascii?Q?9erPqbMI5CcdEENIGQ3leToSvXPGUVPVkpVZ3raL9k+bBOEUhr40JTz0xJuI?=
 =?us-ascii?Q?e9oDJu9vdqhY03CBW6cwuDllGELJEGihK58TNFeJ92y3V6kThzuJZlq4qTS3?=
 =?us-ascii?Q?ck5zHVF1YG8oSK4LZfQaWue56wwK8xqsihR8TyoC2Z0+6l96Nd06j4la4a26?=
 =?us-ascii?Q?iO0UoVx1T9aQbVwhWgFCu4gN+NUqTGN6I2At2GpVlG0cyE9hOBZrrse3QdaH?=
 =?us-ascii?Q?QzX3GjBOai9pnd7UVenwasc+biDiwdNVQPnO875ia99PtlF/S5GMH+MyTvwS?=
 =?us-ascii?Q?TfMQSvsouo7KBobwl2GkZ0C2Q77CnbCtf4D++UFKJemPQeWzD8ecbr1JRSV6?=
 =?us-ascii?Q?C2k96lAU1lhQA+zdKBxmU0vZJsDSHHO3gO1bTCPb1Ere1DPBmc/nq0mZzE2g?=
 =?us-ascii?Q?Np+MU+YEscii+eXxBHoBvf5djrC+i+awvrde1kjlOpITNThBRTibiaMr6SWv?=
 =?us-ascii?Q?GJIvwWnWY8pUZMFKTjqZOugEZBtLh+zN/VMD1GRc9eN4sbaG3zLSagKG3Lff?=
 =?us-ascii?Q?76dhP8edFPUSfwZAy6tN41C5maYw/K+p1F7nuB9x95xu0KOvqgZt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4405117-5f6b-4e01-f370-08df287e23b1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 16:30:34.2793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7Kc5D62k7ofC86sfyzox/q4hzJcHnyQhRdjR2RdEOcEAsEdpahM6EPfCaxkxLS+ZS2qmEdy5n1CLacDCPvhjEpFBNMkspgsLk8DoWQ16Trsp+Uc0PuyDS6w0AacFBaT
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

On Mon, Oct 12, 2026 at 04:25:24AM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
>
> The VGA bridge on Apalis iMX6 consists of a simple resistor ladder that
> converts a digital 16-bit RGB signal to VGA. The VGA output is gated by
> an active-low data-enable signal.
>
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/gpu/drm/bridge/simple-bridge.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index 3fba7002322e..3f88fcdfa214 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -253,6 +253,10 @@ static const struct drm_bridge_timings ti_ths8135_bridge_timings = {
>  	.hold_time_ps = 500,
>  };
>
> +static const struct drm_bridge_timings toradex_apalis_imx6_vga_dac_timings = {
> +	.input_bus_flags = DRM_BUS_FLAG_DE_LOW,
> +};
> +
>  static const struct of_device_id simple_bridge_match[] = {
>  	{
>  		.compatible = "dumb-vga-dac",
> @@ -312,6 +316,12 @@ static const struct of_device_id simple_bridge_match[] = {
>  			.timings = &ti_ths8134_bridge_timings,
>  			.connector_type = DRM_MODE_CONNECTOR_VGA,
>  		},
> +	}, {
> +		.compatible = "toradex,apalis-imx6-vga-dac",
> +		.data = &(const struct simple_bridge_info) {
> +			.timings = &toradex_apalis_imx6_vga_dac_timings,
> +			.connector_type = DRM_MODE_CONNECTOR_VGA,
> +		},
>  	},
>  	{},
>  };
>
> --
> 2.43.0
>
>
