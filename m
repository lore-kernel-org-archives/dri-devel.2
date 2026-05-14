Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35170CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 05:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B99010E0C8;
	Thu, 14 May 2026 05:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="cmwWdQd8";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013063.outbound.protection.outlook.com
 [40.107.162.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D828B10E0C8
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 05:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+SXuW9+rYMsmKiUa5GlPvS76YQ+tOtPlLbkvHcC2UzOmxr/HR0Maib32qedqdKfI4v4NFxKAAqiCmbrzECrjOvM+ShVszSuwChfor1BM4MOJHuzn02c9S/PuxZMWAKSLQj4OU9GXfoDVP9Xt3dkZL+SFA2f7BIv4tStBUx2176oYWu3x+54rFp4b7OjAQtBsLJHN1oYODnSnwhVFspH0VxyGTu1ZpapedA8OlZPR0gsfsQWavoTLHSElAlZfitJ4OHF4STmwnLGYfE2MSuLbEJQhcZugcWi7Tmn8BxCll518tjyMcq7n6bo3DPWYTsNq2Ns8RDqB1d2d1DC7S0jTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exC92pacHHKUmLH24pPJWiQchoFNs4dLYvgVc97wZvs=;
 b=VD1mANCSyNF/5jvXfu8XiOADTmowyZWBHRlkTrhNJTkaj5s5v2Z1YbJLLuZ343GQze1W3ZQPDxgsEIed/y2jQJSt1hUehbuR2xPd7TDCFHvvALqqtnlN5wx4iP4AUkTxFcMuWKwu+zbYVAXe1/KaldFKMIzlQe1z5gzthHY2U3ThpwmXjc6kOTiZgz80Uu1E7FnjmX5iNdC6nWVAwhJZqNZpf9n1jMBtx056DrRgHqO9M7sbopJGW2eNs0N4xg2bRCw8cYh4Ww/wPHsx/PoT9b26Ne9MIQSX44cL3wl77ZGl9qb5nTrb7dXKmQgHjk1Jdz7b17J4ljkyaRXEwYGfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exC92pacHHKUmLH24pPJWiQchoFNs4dLYvgVc97wZvs=;
 b=cmwWdQd8Mjz5WeVLyNC40QK3LKZewshhbmlqunESLfH7BYM3kvwI5qvX5J0ZAAlDCsV29uPYYvGwCWzG/Ep18qlg4Hrlz1inmiD56U6Mokr1VtQF8Q/XOdd24kXnUlZfe1yEPKn0ys1TLRFCTszjh2FFUMOWAgNHfhhJFPvq0WJlXDYGazWTo+Jw3+1DR/aJMc+k6vAs9EKGDQ/lY+DJ7HF+8yMBh+eyVYkCNDn+zjtrDPWJNYmm9LixjOWpwEw1RPMAR6bZzPJhU/+BNWRC+dIPxNa8t+Ea5qGpF2RS9DWT7o1w4yvJOum21Z5fF/eu24Ni3HxhJNhVnKo3R+0GZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by VI2PR04MB10884.eurprd04.prod.outlook.com (2603:10a6:800:270::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 05:54:03 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 05:54:03 +0000
Date: Thu, 14 May 2026 13:55:24 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/bridge: imx93-mipi-dsi: Fix mode validation
Message-ID: <agVjzAaLQpDLgX3Q@raspi>
References: <20260512-imx93-mipi-dsi-fix-mode-validation-v2-1-7aec3be5da2c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-imx93-mipi-dsi-fix-mode-validation-v2-1-7aec3be5da2c@nxp.com>
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|VI2PR04MB10884:EE_
X-MS-Office365-Filtering-Correlation-Id: 47825225-1e7d-4d79-909b-08deb17d33c2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|19092799006|56012099003|18002099003|22082099003|11063799003|921020;
X-Microsoft-Antispam-Message-Info: m27TSOo43Mit+xBi/YiT2ikZsgmvriFefeworecDMLYT6GEq/mfxbutfL82Ct+y2Ov2udj34b+CQigrtiHgL+umf6sJ14O3SdEJJDDK7qzR9fm+cMh2Jra+irzkYuwqBKngxMvDLx1/TYvQDxD6CP+IefcuKG6zODnocBKnA6885wVi8URZL17SY0Qv6EAiNH3nvVbTSXczoTiBBn3soG7ySVsSD9bnsMjUavyNUDtlk5J4XYQfvbku6OnCRkQ2dzJmu8+byDR0BwqEnwLGuWSV1qMV2JI8D5HiQVxyyT7aMY0x8V8fp1vJ/KmncDM1DQZQ/iNUefyL5pvDVxncHiCHlxJTcArRgpkw9l/veu0aFkRgx2pGpw4pzNt3VAJdlF6jWH7cORN1c0ROwjHiEa+2ffpOXW9LElV3rO7Bq5YW3fWqfxAwcr5M1A9EFLmBHoHMYbH7xFv0p7egGCpSbn5Rf1qOwolT7P9mJ6PRRlxmGQ7LJaZzDZvML3Y3M7i4h5MExqHNamj4rGXzQyCG3A7FGiUtxZDv0vkm0vPokirLAdWhuqDQKN8ZDeuPltOkzdwwY18hPVEKlnvOB3Glk42IvJfTflm/Ig5HNgBlQj4F7M/A4jsd6rA9SysgLYjgf7Gj8dCztaV8DmD+/opPZ7XRIHM5x8JHjPLvrVRDQQDp2zPwZaPB0vKbw8JFRs2kB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(11063799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qz0inavgja6CwAyUxChqm/8aMYLzyZXvqpILM6QRqFwcLxmLIcoIEqy4fneh?=
 =?us-ascii?Q?NLs1rYxDGrovA3+/ARUX2HOYMYRctebfm8wGn4Dau2gz1Zw70SZdrjimdtH0?=
 =?us-ascii?Q?sAYRxULADA1FXjyLYFUK3ub5FfzNttXlmRN3gg+70/4rXubg4xyhOMymWuLZ?=
 =?us-ascii?Q?XQArQMWetDqSkpa+mMCOdiXKh+hNgFRR/KLyC3rXucuIgmG0PsTrFPEYeEyu?=
 =?us-ascii?Q?8b5FZA24Bhl1O8OXx9Jkg07kl6m2v1H+Ke1Fk+f8m7hXTekb+uPddn0wjmhU?=
 =?us-ascii?Q?MXkHLNk1VWkh5FBcYq9YRMHQbgkG/0opQdLD/Uru1XeIzBtvk3AZO4dLBkpM?=
 =?us-ascii?Q?oH+4HDyuxvb11h3pfg4B70eRr2NlGDVo5SCNM74inOWwGz5Nj9UkLRV+2v15?=
 =?us-ascii?Q?y5BwPVI5NaaGaZtmkmOQ+fHxeNX4zLlH+7mG8b48MawlXTHXuEanQ+ekBqlo?=
 =?us-ascii?Q?Nq+bd0f2Iz3CNCQsuMQMvfvPvbD20piAcj03Kh9yL7ihYuTRQR8lJQMjvjt9?=
 =?us-ascii?Q?RhTlbaWVC+iDIR4/NsjAByKvui9nNndE4VNE125afShv7uhVItnSbmOIdlpE?=
 =?us-ascii?Q?ApT5QQD6LyrmWa0lfJtLVUHTFnVPiASsauMA33k1yflzn1cH7Qo+adI5ZZDH?=
 =?us-ascii?Q?kGd0/WY2h9BSG2D44Yu26zOIFDawjbzz1M/190ZgQ58M69ryDUBTwQBRIpNP?=
 =?us-ascii?Q?hgv9SS1Ak+JSDDvrWBBwXpRH4kQxjbqnleF5aKi76js82fbcfdAQhmugaDy5?=
 =?us-ascii?Q?aZ0CNhfJgmQ+pPKEZD8ispGBu6zr6ETQwGakluisUIvjDu8ky2iO9vxOQB+K?=
 =?us-ascii?Q?9yvpSTlzV53ANXR0pSpDMbJZqxPGwWgfwPCEDB+k0K2/LJuO9MxdNSMKCOTX?=
 =?us-ascii?Q?REWod8s0RYelTy5WqKeKr+Cm3/Br6Pf9f7Nn1bryRRVWlGjc30SOx2rwCvP0?=
 =?us-ascii?Q?rRjdEOlLV1QhBXTkTpzQzo9MdtHFI9y0qlCqrBMWfCNS9I1jCAugJgeqZSby?=
 =?us-ascii?Q?Rb2T9wZoGC77oZztqyJktppNwhqIz+hqCZG0F2w0xMR1y/P1q/jAdIht8xdL?=
 =?us-ascii?Q?sjQ+RGpiYEp1RAvv7RSjSIscR0WPHkeqgQGh5o5f8EGKH76VuI3FxziApvJo?=
 =?us-ascii?Q?n2PZJjSw9V4aajLkUUNnO8WXNnbsTuFVNrATHjKhW2AaWkv91mSrjORRV8wu?=
 =?us-ascii?Q?5c0g1PqjCRlYpR8wjhw6FG8IokVUhf5wp139soZockUCZERF8eP+UY1YRorm?=
 =?us-ascii?Q?7CtkmZpAZUCaY2OxsPimnpm7iZ6lORV9xSqaC+FLKolFJ57i9luoXBjaeOhz?=
 =?us-ascii?Q?QzboR4PMBaFNcVA96aSkLQqy/HE6AOm1DN0/1rZSW1KdxMbAOdHCZxhtkTud?=
 =?us-ascii?Q?XYIN2ZWKw0HzvLCg5+RGDNtmamL7yEFGYJTUV4a91xoqLH3PSLBGAGWKUmoU?=
 =?us-ascii?Q?ZIGLyrjtNpDzGDqdNFEiN0Vze+dk5tVrxFih+fQ6aaszpoNJ0v8BI5zHDuPZ?=
 =?us-ascii?Q?w2cBV3OiVgy73bOhlCLgt7P6XlVqEsWAOVnR12KnVfSpolZkJKCmqIVpErY1?=
 =?us-ascii?Q?q0v5AWOlFYqQJUwwU3Ky7yJ7zwUVWCOG9z95AuFJ1xe7HI+drGEHEHUGo3rG?=
 =?us-ascii?Q?pXTf1pS+TJVvzrX+YqBanq9c4QqEhVwtmhn1S0apWRLlr4a8EJq3zV1fSZ0y?=
 =?us-ascii?Q?wDmfku2MVSuya1DIYpK3kuKTkCCdfvphZTDDz/ukYuZa4oOkI0vRHvHC3VtU?=
 =?us-ascii?Q?iPv+RVWfBg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47825225-1e7d-4d79-909b-08deb17d33c2
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 05:54:03.2368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBWRGIgoO6Cxtzd9bXR82u5D+0s7JggCeIbDuKj/brFs9Y1VUdwrxalWlJ88JMoO9RQ/j+w2etEWgxHFKDGw4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10884
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

On Tue, May 12, 2026 at 05:18:49PM +0800, Liu Ying wrote:
> i.MX93 MIPI DPHY PLL has limitation for matching with some pixel clock
> rates, e.g., the best DPHY PLL frequency is 445.333333MHz for a typical
> 1920x1080p@60Hz CEA/DMT display modes with a pixel clock rate running
> at 148.5MHz with 4 data lanes + RGB888 pixel in MIPI DSI sync pulse mode,
> while the expected PLL frequency is (148.5 * 24) / 4 / 2 MHz = 445.5MHz.
> Fortunately, VESA Display Monitor Timing Standard allows +/-0.5% pixel
> clock rate deviation for timings.  So, for those display modes read
> from EDID through a bridge with DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID
> operation bit masks set, pixel clock rate could be adjusted to match
> with the PLL frequency(for the above example, the pixel clock rate is
> adjusted to be 148.444444MHz with about -0.03% deviation from the 148.5MHz
> nominal rate so that the adjusted rate matches with the 445.333333MHz PLL
> frequency).
> 
> Instead of checking the last bridge's operation bit masks against
> DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID to determine if allowing
> +/-0.5% pixel clock rate deviation, check any bridge after this bridge,
> because the last bridge is usually a display connector bridge without
> any operation bit mask when the clock rate deviation is allowed.
> 
> Fixes: ce62f8ea7e3f ("drm/bridge: imx: Add i.MX93 MIPI DSI support")
> Fixes: 5849eff7f067 ("drm/bridge: imx93-mipi-dsi: use drm_bridge_chain_get_last_bridge()")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> Changes in v2:
> - Collect Frank's R-b tag.
> - Add an explanation to commit message about the reason why mode validation
>   checks bridge's operation bit masks.  (Dmitry)
> - Copy Dmitry.
> - Link to v1: https://lore.kernel.org/r/20260227-imx93-mipi-dsi-fix-mode-validation-v1-1-a9cd67991280@nxp.com
> 
> To: Liu Ying <victor.liu@nxp.com>
> To: Andrzej Hajda <andrzej.hajda@intel.com>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Robert Foss <rfoss@kernel.org>
> To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> To: Jonas Karlman <jonas@kwiboo.se>
> To: Jernej Skrabec <jernej.skrabec@gmail.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Frank Li <Frank.Li@nxp.com>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Just for the record, sashiko bot reported a deadlock issue[1], but didn't copy
all receivers.  I think that's a real issue, so would fix it.

[1] https://lore.kernel.org/all/20260513201715.AACA2C19425@smtp.kernel.org/

-- 
Regards,
Liu Ying
