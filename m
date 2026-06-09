Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76B2CD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ABC510E0E2;
	Tue,  9 Jun 2026 06:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NPkRAgES";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F5710E0E2
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDGx04GhJRrfu/79DtXQZTZyisFYkVXmCalmtRnlWxKuMjChADCJz3Wwy8/fFCjhBzRmoWHrsI6M45QpfGoov86Ip+9gx6fVYEV9uYluKlFcee39jeSgkuaFTs/XLsMc83zBVuaYCwxusmDS3EiS2bJxT0AaFz2PF8HyCEck2LPo7pgUhU8qxVlwPr7QCEk/KRlckhYSaYySBz41iexPuxBXPoDh4mJxqtTNiXCWXfWlqLuTWLfLkNlr8/bXZVUehVOIHwYrR7QKKLpAyeSuOKWIK3xeAU67BRKS5AKFT0CJxxGHPrJ6rRYEw2TKIs+Ka3Q003f98K37PfQuzWDQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvHEXq3TVOA025s6I6DXc9YRvOqaulg283EnbdQZ9y8=;
 b=ufu7XqQkA9QUhdnbfK6SIsxUPXF1UDjxh880V1YD3XC4r0wci6FDmR9ImLJzvsyAasXcMDGtd//T/i7Pq/2o+jl8EKt13u5O3Dg6ClLe4F2B9BZAKFvuNjpt6IPDsY2oNTMLtNZU4uXdB28ZF0G2BNTdC8hBcDo3/f1ewnSsXfAM3H9ibhcvl5M9yL0l9R8JlU8z8GsstyPtP9hBmhAkKaoeEdfEQMUJub56RtVj7WBD2mB05AfPwL4f9lfLdUDLPVINt91V9TGqMRSGdcZq1OML9KsUx1jFocjk8CJIcGvmyfq69MH0JUcvTg6IYH97RF/P7iiMmjssFBeh5VkK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvHEXq3TVOA025s6I6DXc9YRvOqaulg283EnbdQZ9y8=;
 b=NPkRAgESoUrl1qT25+HOopIR7OjRcp3zz4VUNRp6fXt4EI4urMdXGlkSX/Ujp+R1UnHeQI4+nift/KSv0VPE8YQ/KblNmeLQ2eL7wVJw5QSDe7W/EbZZs9SVXr/Fe4c0lABT2zNCiYIFpTYnjtqldpMJvL2/VjyXgukqpx3pNx1fPeYzsJvW3miz/zaAzkXqC1QUS2VWgQPkArMWh+F3iDl/pHSlsUrgXcuI0FOb5xb6IFgwMK4ZnshtnwmfPEuMWghQlqnUhDNOQyAzDYG1XZtPgsNAQ66gnZhLz73PN/5syZgHyPHvI30up0QwUUYl/FxlIMW+4uLnMGXYvPfjbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by VI1PR04MB7022.eurprd04.prod.outlook.com (2603:10a6:800:126::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 06:44:03 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 06:44:03 +0000
Date: Tue, 9 Jun 2026 14:45:32 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 21/78] drm/bridge: ite-it6263: Switch to
 atomic_create_state
Message-ID: <aie2jDdGq_qe_x7S@raspi>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-21-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-21-0a91018bf886@kernel.org>
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|VI1PR04MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e032476-7b85-435c-9883-08dec5f27e53
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|7416014|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LkepVvEUtTkohixibsrKm8jWuMoWNFWEkbCP7FAgLA6kjqwLaFnnAvOpne6cRUhPNzDtK/706xvTGFAh2cObOumm5iLwvFLDNDYLfn9RrGyCFuAvFaJIV2qf8AoTRg5zbugI3zksCkEPBcKgNASaj5YsDDLMSmZw66P6VyFUkH72UJ+RigArF7iSezipY1+aMJMcR01GkvELQ6vo00ZPmrOWKZgk0N0Bl5WCJut1R8rquNk1caCwT5UMD1iQpmiAAtp4EVLZuddiRgBkneX4uDuPPAd8b5W3GRs51E0PoMaSrw4FphJ/MP2SF70XHzH4/Gth1KOHKzplF2Xx1liYP17nfPx23OovU2KPjIY8exa4t7O27ihklqfXRjLk+EKzYcglShLEq2/gM2xiu9n7HrYCG0VXZN3JXzK8UQMGRb+WTT+/mTclsByBkthHD5H2Okhn1UYNTTiJA6EgFGoWBMamw2B34kmttkc+87LN/firEkEE3DtmztkZDw57FCliQePUmLL6K0hoExsnBNDvP7OvX2Nv+HMZrlEXPswOoqCt5ppsEAPWg5sdzDDlvwFNme3+V/iMWM4RD1zCluSNbva5bxlUqQNZ2pXNsCNVeGlWwELmBfqnxTpabEYrOpxyQaMbyofdbfEDWikaJyl5hOKqEfxCFqeOLtxX1+GFcXPJuNKR6h27pnqGH9pelHY4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ddv3KWslaRTmBan+By7wdvjC6hjkPX8sKqHbHaolzH8WQofTPWJ6qlNRcE7w?=
 =?us-ascii?Q?ZzcSLXxzwSHgwQyilpR7MN+mX5APq/r/kFxs9gGCTSUPImJtWJNT2ezBWTW7?=
 =?us-ascii?Q?zM6GIQr/QWPHCA/JaxpG5g+0S8k3yyJamGqTbkkE/vpO0UuWyZ/xhH50ghbi?=
 =?us-ascii?Q?/1pQzvw1aZLarEfrhinYNXACiLLQEa+9KZNP5VPYfxfUNuP8wIjcE6M3XTyR?=
 =?us-ascii?Q?wFLvVCk0/oZm+eZTg1pQ1D0gTtq0V6FQn4yyvJhuZqQx79uW5CPyThBiOhvM?=
 =?us-ascii?Q?AaEkLHnR3cG8nUVHBHkscIpuk3glb/t73L1hH4/5cOy4O8jJhZWkHiS17aX7?=
 =?us-ascii?Q?A8zXMnmz+1aCJeT8PsNeUt4CqkMT7XGUjJuLyRQZbga1oMDoeGh2RAp6WVzm?=
 =?us-ascii?Q?5h6O9b8sfopynHhPqGJAQcYb42iO7BWZQ2Z5kIYlhBkmTkO7zLGql7CUovGO?=
 =?us-ascii?Q?7ZN0DVs4f0XeoKbhmjPXe6YajrGhuaio+y859GWqyx8GhW7ZtcBn1Mcbkebq?=
 =?us-ascii?Q?Qo4Oo6MiZeS98o/QBGKvc73SIffPieMcd4OwXLQwY5OE8w1VuN4/nyI32IjW?=
 =?us-ascii?Q?kvLCtPh9QL0mkR/HnbEhqhe1MJUhuGlue3VI52tR3mNI+Pkqh0XfCBDx4eXv?=
 =?us-ascii?Q?LVEy1TOF1z8z8cOJ7LCZ88iCJbKHoIYu8O1o4iUUaVqz+RwkCQ/hAZYCX1G+?=
 =?us-ascii?Q?lqF94bD1gQotdTyCvErqPLkdxRwYYHk9sCSv6OVYxvO1OtkC8kNQ5x0UJlIl?=
 =?us-ascii?Q?ibp77MtGt06CkjQFado3sOVBxmjFEKISYVrELEmSJnG3MyAby4/VcIlsQiO0?=
 =?us-ascii?Q?ftPnKIGMi+Cb7r2oRgscJomtOVIQWJ4l11NyCMLvB1haTnI/wWzKQZNzQuhO?=
 =?us-ascii?Q?rU6T7ElRhXOuoA/qs7Q/ypLPfBGo6/vImXtU7BQvog5pUhBCuZlHMdQ1JObd?=
 =?us-ascii?Q?vHNCG9g6Dp6OVcqm2mRs0ApHO6diyVaEbj8eDDYWuR4Rg8BMBYfK8RnSQ1QW?=
 =?us-ascii?Q?BKXs7pCCU6vF0vL3fJ15h0SPny8C8czVlfobG+smPmsAo3B5voMXhGiQnZar?=
 =?us-ascii?Q?fztDuJlqtXXhw/ujGE6DVuOLIXb1h5v0KihEllJBHP+hOG026Lot2h/9QyvD?=
 =?us-ascii?Q?Ped9RRsBnMselYaSAgjvRCZ6wTZsg26q6ojx04zs006ZAox73/uhhTPgD3yM?=
 =?us-ascii?Q?lY6mgQWFxwyuRYRwBYJzj+W6kndppodNMHhQJ2hrcgfqqUBFYlnrrmx3JrdG?=
 =?us-ascii?Q?RvQIZuR8fs1dGgVXL7Y2UKMOhRHf5RCGXYZTsrkXAowgGET6k0OIr9PBzbZk?=
 =?us-ascii?Q?r/zytcmh3LmI6ipsIXLMJ4z2OvNJ4pcrDsrrhOWXGkxHN631xlMebiggTooX?=
 =?us-ascii?Q?d9QinUbm5u9H36HMaZPgBIq9hL1DTG72bZMYCLJ5zOjXFoyUG7VWpficbyxO?=
 =?us-ascii?Q?QQS/SPlM1Tj5OKYByf5bDy/miFNzFq5ilh/Saa5dUATArKO+4tRQqd7dpj8y?=
 =?us-ascii?Q?9Uv+tpCWqHlDXY6i0OZP6ztWoy0yPAJJ2gDz7APo335UetQo8uv9YZv8BqXA?=
 =?us-ascii?Q?hxBJS9HOTKLuiYynEtZjQ5XKKArsLnPf45Ut+IzGzrhFtCz1zzpXu8YLFsNT?=
 =?us-ascii?Q?BN4AatFlqrulGf1x4jZbpl+gPTlwIRQkqUIzjWZt/dxDszMMgxl+QIZATVi2?=
 =?us-ascii?Q?8ZJI699aSqvoXCGh+2wGMTYLKY5ulhp3qWKx4opgNrJ3vExRoi1BAl2Xish3?=
 =?us-ascii?Q?mzKXxx6o1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e032476-7b85-435c-9883-08dec5f27e53
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 06:44:02.8364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdEUaQXRtssZKp51wnL27WcMWL5ciqaR1eo3WY6LPKz01wp6lbPoV07RnaQ2ap0jxRviMiCbOpo8lKasOVtylQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022
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

On Mon, Jun 08, 2026 at 04:36:03PM +0200, Maxime Ripard wrote:
> The drm_bridge_funcs.atomic_reset callback and its
> drm_atomic_helper_bridge_reset() helper are deprecated.
> 
> Switch to the atomic_create_state callback and its
> drm_atomic_helper_bridge_create_state() counterpart.
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> To: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/ite-it6263.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Liu Ying <victor.liu@nxp.com>

-- 
Regards,
Liu Ying
