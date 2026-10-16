Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65685CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC5511275F;
	Fri, 16 Oct 2026 10:11:03 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2412F112734
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOMgLdgAgVaD4e/cdrx0v6Vjf2hRf0mDTQJXAYZixhmS+gC85/Ub5Ce/zslcYqrb0h65n+EJ1I5hEDkeMbckTCXC0wMM42ZOV4lQDeiIreUXh8wuYfhqAxWmTL88JCaqPfcBu41I36v8l3GX27L7R9S8jWamYCUACdF0NTJP+8hKP3TM6UcThTKicsfKHdeL+hl+gccqd/fdr/bqWlEn6hYfk6cAZ8plCyM9fqgG3itPG3VicZKF76fdERG5/1jhElOR1uKVcaDEsCwLFEXC8fY3to2NtvuzmmZXldkRQIKplFalmuKmtUXAn6qOA20ymD+JcRfvQEyeABKWq0+zWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNmK3WW1lSkcbfVgEGvwGsj9SUPIW5Hee/qC35RHhbk=;
 b=wwaJmSuSAghoT3j3MHoY6Xmj7kTgxMconQ5zpeOyXzibeP3/Da1LWbnANU8xBMYAoJaWNkAmyusJuy74MpoxtJMZaAQOTmI1Ftm0eZoNJkFTvc5l0MI+0BcLgsEND6BL/tQMjK3LENgv8byhe3ZAq/SxriVDgI9VNwYQJCS8gwQSdvK5wztW3AjbhI4Pr8ZIRRRlA6eSU1roKvb+ULe/FsNxBgP3BRVNKoRiPKo0S+FK4ZDMjRQlOJLSsaohZ7LqmzaxMqlK4yNz+z6vhB9ad7dFl2iRfiwZJii2YuL4n0V+2oqS3tYHSPNjKGdT+hILBpEU2Itvhl411RtPwblEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNmK3WW1lSkcbfVgEGvwGsj9SUPIW5Hee/qC35RHhbk=;
 b=hdXftFygbi2/cRMGlF9Mv+efjHSFeFxDkw8C2M4Qll+Bm9peALD+9OpCTeiO4iI888IZIeQzapTX72s0Foo8SKuDremRCaLMO4u2HPW4BaPOfomrIndbJofBgTTr0Cu3TxGBP+zof3LzSLCT3zeA+FjUKDHTXoaTpVJ7TfvGomU7DFK0u+MXSamI5zKpDIwmruVMaVIXljR007BK+ZwogBN6o9q8E/psdjKrOuF2KUWSWgCsZw7Q1OfPYAwG8zXJlCi08bxDirA543vH2gj8op+MZbsCIXDl7D9uxG2o8YMmJi8RVKsW9yNDUuQsXexn49AlYicR7Wv9iXHZ8ptm8g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MMZPR04MB783605.eurprd04.prod.outlook.com (2603:10a6:190:45::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 10:10:52 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 10:10:52 +0000
Date: Fri, 16 Oct 2026 18:12:27 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Oliver F. Brown" <oliver.brown@oss.nxp.com>
Subject: Re: [PATCH RESEND v4 4/4] drm/bridge: nwl-dsi: Correct MIPI DSI
 horizontal sync timing
Message-ID: <atH4i_KcmccKb8Ge@raspi>
References: <20261014-nwl-dsi-fixes-v4-0-b9138ea5e12c@geanix.com>
 <20261014-nwl-dsi-fixes-v4-4-b9138ea5e12c@geanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-nwl-dsi-fixes-v4-4-b9138ea5e12c@geanix.com>
X-ClientProxiedBy: MA5P287CA0230.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::14) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MMZPR04MB783605:EE_
X-MS-Office365-Filtering-Correlation-Id: c853cbb8-5185-4236-716a-08df2b6dc22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|7416014|1800799024|366016|376014|18002099003|22082099003|10067099003|4143699003|261009223027099003|261009221227099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: CGuur9YjxRYUyxiE9nOoofRG63RDw/IIg0nANHRcGSTwZBJMOWuMivtcZI1ZUoeujYSg32LNCAy5mT0VVRbidIxUP/uUCxuQMepCmIIrfetdi2qPk+67W3CSFH4bDuc/iBEuOWQ7yOYH0W1KWv/okNoGQcjeUYcKVJBTbBQV5eIs5gNaM6nQJDsfYkWYj/d3yK0B8HRl+9u7S7lrgZ1uIFh52mIBVbJwBAIce4HOL3ZCAKA9B1WbEtSI8EXhd5bxUif6ypdQookCPjr72W1wimnZmiimahiY2WC6O6v5Q0gJjIhbIfZXyNKzz40cqyTt/6eaYy5xEcukOGYMQZPoHoLExO9LTW9Hn+kuh9kcOKSWzUpPhFY9uTy31xnq9lqADoRWRqlyDl3+Attc8mfKe7xxkpEO5stO9cFDz68SzSxgILta4zkiHPTJvW9ZvInITSTkuQrudO30JKhhrzxJF5WDyQQE0ppWOkOX79ULoNNAsM/q+NpVoYaxYTQfYaZzgy5z3ZJVsWNrefLy6hV7ksKNTfCP6N851C4sryVo1FVixbPLwA5CRBPLGOxfUxXG2Eiup+p3hcnvMFl4Tyvh4WEteKLeLxc0uU6UrdwarJpmGEea82C1PZPxTnMOBKGu1/pAKPfyfQGj2kyUOG22DNoECbX2uQT6NsYmVn+3Eec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(7416014)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(261009221227099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GTPTT/mSNXeOhtL4A5P7VewxQ0Is8wUogUBDymCwicNQgeSiJKOOdUAGGEm+?=
 =?us-ascii?Q?KCqqwTn88S91G0TxxQ5x/aia2LMp9GcJaA3RDANxQCox8lEFXgemDtUBtSnc?=
 =?us-ascii?Q?gTlwE3L9J2Tcd3l/AQFT0O+e1HWXczFhNp8RpnYwuAbEMqNML6aQVA2jSXjp?=
 =?us-ascii?Q?N5+X28EBLtQyD2a6otoGoXxnshmQa63laJzgU3zrvd/sheqBrwCD+97BOoeZ?=
 =?us-ascii?Q?ZSMk41NOvYKNrKiK3lbeCp883S7yILeWuIeQjNPc24a3Vfp+tmYr1VJqKNJf?=
 =?us-ascii?Q?4dQzp+eIsbrjasQhNOdPjJTfnJiioBpofeBhB3uxWAYOtCz0vLKgl3heN1Cs?=
 =?us-ascii?Q?/UFFGPHc8/8j7yT+F4vD+3CeekUxXnR3QEaS70ELmB+Quy2WdMXyEAiAMxuG?=
 =?us-ascii?Q?XrAh6VkdD/fSf3mocLsrGHkmxp3Bn2zV8gwY03l9vKL2ipLBofVqnDyAeYkb?=
 =?us-ascii?Q?5Em/7+N0ZOs4OBlGcKkFQUYPu0s92GIA6zkyJGQQZC0f3GTrzjHN2P+B71bM?=
 =?us-ascii?Q?0WJFxqVGwHZa9cKR8CqvZPWCijFbW8rwIiw9GnMITXjKkGx3uMHpGEnk9yeD?=
 =?us-ascii?Q?AD13+Cpv6mS/XtDbexYMF1+53kD4n3St+QiABozqTNhvkcgJbm4AxT6s6Yzv?=
 =?us-ascii?Q?p2I/CyB+eiT9YMgzS4QYoOD4REWCvSb9xmZzD4Js+imVT3O0zHlnbcThs/vN?=
 =?us-ascii?Q?eyVmbbOFRMq3GlppLJvcHvP2K+BWPjDBeLcolBxcT6+H2k9BGcpNongkdu6X?=
 =?us-ascii?Q?w7eDqX+DkcvjFjrXiCUFWBIKs/oUcNkjqvmxBpXmHbT+SpyzYby4hgZ19Eme?=
 =?us-ascii?Q?rSV/8W2OV/LNv3stSd6A2g1ZI6+wbGLLoMRBS6JcSGZ4DjOY3MLkba2dS9/9?=
 =?us-ascii?Q?OFqbgEHw+dIyTRU1kLMLOg/wbtJPyVheqNL4+iE8iW2ua9C7qRrOcl8FDDwZ?=
 =?us-ascii?Q?Dwzk8rxZko6PVundbnBDGxX+9yun/1/jQ++ckkSGnNqOGO+XrZC2bP+NR7MY?=
 =?us-ascii?Q?IogkDOD3Lji5fyZA+AtIEnStL0VyKJtiSD42zLC80Y77hPm4QCkGvkSzmZWm?=
 =?us-ascii?Q?EHWgpuaa/KmOvay5koPq7qzEdOC5xHklpTN+evZHcWXLojB/0fwqHQWxC/1z?=
 =?us-ascii?Q?MUSFAYYgzgNuRQle1zjFAGUFUwq32Mfv9mxihj5qNV4AVGLyslg5NRuGdgqr?=
 =?us-ascii?Q?gmABaJho8p0Ta2h3lv93aPtDJmx1NVVae+rJ88FuR7eV+QTuObbdK/Wezy80?=
 =?us-ascii?Q?pmjardcH5WnjaBIVcqAM7sADZjBCyoBE1mXjCEdNqELTuhf7hsDcl8r4eBo0?=
 =?us-ascii?Q?wUkozdBU5zUPjx8YMM0/LZ4+N4bMKtj46Sn7MsZAeVt5V9xsaDJhx2sCabYy?=
 =?us-ascii?Q?fkR0nMamrJW5/sWmMB1v8UogoNoR8pHCZyEQW1Mn7hbrqa908Nrj+lFgta32?=
 =?us-ascii?Q?K18pM1ruegTYqmcbco7pcjJ16gwu6Zow8rhB3Krg72QLWcU9+We2/YIqOTSJ?=
 =?us-ascii?Q?2L+kPQHIk0yKWjvKEbjkSwcFh1av5qH4SfSCfOUIkP5yc95QNR8344CEgMi2?=
 =?us-ascii?Q?g8bddZaKi2s89At5H+CLfvbN2dIVl4bCzKQ0AajWSgBfm6JDqDNzVzGUZQ2v?=
 =?us-ascii?Q?Qot6UWJpbwuAhJEqU+6PmC2X3nMzJqlYuw0wJA0iLU+/bJ8GJJxHwgiU52AL?=
 =?us-ascii?Q?APVbeiNAPwazIZTPQ3bFMg21Ditm8z7xG/A6Eh87cB9+P+CbEbcJvu5SbaCH?=
 =?us-ascii?Q?OFKaoLPyMQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c853cbb8-5185-4236-716a-08df2b6dc22f
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 10:10:52.2258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUJHjfsh5P+JU84oMqqD7AU/bXxKQGH1v0WtQKzC+kFpqnTquRx9P7mgBrM7m+jKSDiXEgi+JJ4W6B+KLhxQcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB783605
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

On Wed, Oct 14, 2026 at 09:44:45AM +0200, Esben Haabendal wrote:
> The NWL MIPI Host controller registers specifies the horizontal front
> porch, sync pulse, and back porch in DSI packet payload size in bytes (ie.
> not in pixel clocks).
> 
> The calculation for this is (mostly) described in section 13.6.3.5.1.2 of
> the i.MX 8M Dual/8M QuadLite/8M Quad Applications Processors Reference
> Manual (rev. 3.1). The formula shown there does not take packet header size
> into account though.
> 
> The formula implemented here converts the hfp, hsa, and hbp to DSI packet
> bytes and then subtracts the number of packet header bytes.
> 
> It is worth noting that these values only needs to match approximately,
> according to the reference manual.
> 
> Based on commit in NXP vendor tree
> commit f2a61699749d ("LF-7981-4: drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing")
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> Cc: Robert Chiras <robert.chiras@nxp.com>
> Cc: Oliver F. Brown <oliver.brown@oss.nxp.com>

Worth a Fixes tag?

> ---
>  drivers/gpu/drm/bridge/nwl-dsi.c | 60 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index f3f4334136c0..eb604733eea0 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -22,6 +22,7 @@
>  #include <linux/reset.h>
>  #include <linux/sys_soc.h>
>  #include <linux/time64.h>
> +#include <linux/math64.h>

Sort the header files alphabetically.

>  
>  #include <drm/drm_atomic_state_helper.h>
>  #include <drm/drm_bridge.h>
> @@ -264,6 +265,9 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
>  	bool burst_mode;
>  	int hfront_porch, hback_porch, vfront_porch, vback_porch;
>  	int hsync_len, vsync_len;
> +	int hfp, hbp, hsa;
> +	u64 hs_clk_rate, pclk_rate;
> +	int h_blank, pkt_hdr_len, pkt_len;
>  
>  	hfront_porch = dsi->mode.hsync_start - dsi->mode.hdisplay;
>  	hsync_len = dsi->mode.hsync_end - dsi->mode.hsync_start;
> @@ -317,9 +321,59 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
>  			      dsi->mode.hdisplay);
>  	}
>  
> -	nwl_dsi_write(dsi, NWL_DSI_HFP, hfront_porch);
> -	nwl_dsi_write(dsi, NWL_DSI_HBP, hback_porch);
> -	nwl_dsi_write(dsi, NWL_DSI_HSA, hsync_len);
> +	hs_clk_rate = dsi->phy_cfg.mipi_dphy.hs_clk_rate;
> +	pclk_rate = (u64)dsi->mode.clock * 1000;
> +	DRM_DEV_DEBUG_DRIVER(dsi->dev, "hs_clk_rate: %llu Hz\n", hs_clk_rate);
> +
> +	/*
> +	 * Calculate the bytes needed, according to the RM formula:
> +	 * Time of DPI event = time to transmit x number of bytes on the DSI interface
> +	 * dpi_event_size * dpi_pclk_period = dsi_bytes * 8 * hs_bit_period / num_lanes
> +	 * ===>
> +	 * dsi_bytes = dpi_event_size * dpi_pclk_period * num_lanes / (8 * hs_bit_period)
> +	 * ===> (substituting period = 1 / rate)
> +	 * dsi_bytes = dpi_event_size * num_lanes * hs_clk_rate / (8 * dpi_pclk_rate)
> +	 */
> +	hfp = DIV64_U64_ROUND_UP((u64)hfront_porch * dsi->lanes * hs_clk_rate, 8 * pclk_rate);
> +	hbp = DIV64_U64_ROUND_UP((u64)hback_porch * dsi->lanes * hs_clk_rate, 8 * pclk_rate);
> +	hsa = DIV64_U64_ROUND_UP((u64)hsync_len * dsi->lanes * hs_clk_rate, 8 * pclk_rate);
> +
> +	/* Make sure horizontal blankins are even numbers */

s/blankins/blankings/

> +	hfp = roundup(hfp, 2);
> +	hbp = roundup(hbp, 2);
> +	hsa = roundup(hsa, 2);
> +
> +	/*
> +	 * We need to subtract the packet header length: 32
> +	 * In order to make sure we don't get negative values,
> +	 * subtract a proportional value to the total length of the
> +	 * horizontal blanking duration.
> +	 */
> +	h_blank = hfp + hbp + hsa;
> +
> +	if (h_blank) {
> +		pkt_len = min(hfp, roundup(((hfp * 100 / h_blank) * 32) / 100, 2));
> +		pkt_hdr_len = pkt_len;
> +		hfp -= pkt_len;
> +
> +		pkt_len = min(hbp, roundup(((hbp * 100 / h_blank) * 32) / 100, 2));
> +		pkt_hdr_len += pkt_len;
> +		hbp -= pkt_len;
> +
> +		pkt_len = min(hsa, 32 - pkt_hdr_len);
> +		pkt_hdr_len += pkt_len;
> +		hsa -= pkt_len;
> +		if (pkt_hdr_len != 32)
> +			dev_warn(dsi->dev,
> +				 "Unable to subtract packet header length fully: %d left\n",
> +				 32 - pkt_hdr_len);
> +	}
> +
> +	DRM_DEV_DEBUG_DRIVER(dsi->dev, "Register values: hfp=%d hbp=%d hsa=%d\n", hfp, hbp, hsa);
> +
> +	nwl_dsi_write(dsi, NWL_DSI_HFP, hfp);
> +	nwl_dsi_write(dsi, NWL_DSI_HBP, hbp);
> +	nwl_dsi_write(dsi, NWL_DSI_HSA, hsa);
>  
>  	nwl_dsi_write(dsi, NWL_DSI_ENABLE_MULT_PKTS, 0x0);
>  	nwl_dsi_write(dsi, NWL_DSI_BLLP_MODE, 0x1);
> 
> -- 
> 2.56.0
> 

Not sure if the fix is 100% correct, but it is a correct direction to
change the blanking packet payload size from in pixel clocks to in bytes,
so better than no fix:
Acked-by: Liu Ying <victor.liu@nxp.com>

-- 
Regards,
Liu Ying
