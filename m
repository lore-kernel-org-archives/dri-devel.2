Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038D9CD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FCF810E0ED;
	Tue,  9 Jun 2026 06:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="IA5RHVD6";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BECFA10E0ED
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nkz5rz8TDxEFeEOTyWjrf7NvOGmCNrSbn6Jw6cXbXHj1QQxvI74O36AvX6hMtcBGW1YtLfHr4gEZymiiUvqaVIC3R+PjNXvFSxdmY8o3nH1MhjD8glocX/MgVfk0E1wstJ4IRcBgtQ1ayJv+52hFZj7zbUtbtnWEiC7JuUpJokRZB/k/n98yeaVPD1pg1OeYHDav7uOmolk3e7ikEJ4fkhD+OEShHcUBbTm2fMmG1DnPqvjDNU7xT+jdrZ/TEccVOO+QwAzsT4RcAfaiVgdrAmY/oNfCpJlubrwJSBDaYiCfmZ2qXSs+TIFQL1GRLF36mPyerPGwTDaUJ3QaJuvgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrMh+ls70qSGt5XlDlf+FnH8Nmg88W6gaTOr1LalHZY=;
 b=PJvAZprHxsz2hO6Mnbv2FMl7dVY5wX9hXX2p/gf434cs8D1ROEuuyzkNAF5CiDNtlFWu/BQ3RWf+RQtdklGG6R47Zmvd6O5Ctrafsd2CdiFBrIqnVRX1XdkEqfeP3RPMzBh2Y/eMtru3kd1pLZaY3wVEvpRlobF3bLyhGg6w2A4fOLSMuWIDoGdpp3029K67VqpikbW6MumCED1PlKfxUVsUaCorFLuKDZCo+Xj4LPQinCv5be7yW5oN848EIydj7D+rTNutYW/n1x2IEwIRJzkH6ikPJGwosuNTTXgTpv+xm8+Ci8KhpUQXDAwo2nBO0YTzoKsULKywKey6qcBpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrMh+ls70qSGt5XlDlf+FnH8Nmg88W6gaTOr1LalHZY=;
 b=IA5RHVD6uh61mouM8XsUm7tuaV9mrI/MsZTBAjL4monLxo/qw2Xopf648YnaeAFxgmLtAPu+QkiK0A48r40bl5S4BeoKzlDQeBCZICWgN02lUxtf9Vbzlykk3bJ5cITaKxonNdIs4Dj3dfmq2zyAcXafL1e6kRdDOXHlo6uiqlqgWm0xZ0oh6KJUNL7rlGPJy4AKBh/3vaj05IpNpXU3fPKlH+iI8tIR4kA04y0Vi2MKZI4uxE3+gdp/C4aVHMNU+pEzcfYermb8UxtQwaA0KNyswx8CiU0DeFl9tNIbUXM9ndlSyPwwdwZyE4Oy6SN4317N/qLLXJ/Z3fSnUlDGTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 06:51:05 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 06:51:05 +0000
Date: Tue, 9 Jun 2026 14:52:35 +0800
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
 Dmitry Baryshkov <lumag@kernel.org>,
 dri-devel@lists.freedesktop.org, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 16/78] drm/bridge: imx8qxp-ldb: Switch to
 atomic_create_state
Message-ID: <aie4M--Gp6Tgnpn2@raspi>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-16-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-16-0a91018bf886@kernel.org>
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|GVXPR04MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: 118557d9-b13f-4d32-dea2-08dec5f37a2b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|1800799024|366016|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: T6J0X/rY7G0NdKDWH7mZDKPjWAELuDiY+E2CQvIGyiMhD90jugUhTlJAmATsGCC49tTcWtsyP+U5vb7fBlpReXzIKeJaPiBMVoaRubYL4GIyVKjRO29PqcFcwCZ5LNvJlQz7yYx9tu8vZf0VzpQUfQ0cpo5/tI1cIBVb0TKhxmYNwVJ+exIklFdD+CXrJYq8PDUYs3CwTo8cUqUvWCFH1nH4v99UW6Uj/RgMbLxn2+f1xgQg6zsKg+BMqBHNCVbbyxyZpXG8YJwp6J9eShALcWLLA6XmSxjgG99n5/f8CDfpnZ7P78vjVrOVFjZjhBbRRh/4sdgF/H7+hA5EGnQF/rozbhztf5oKo7F43uLYuilO7ZVVcATs5DwN+xgGZhQBqH//cu0sjOvYf/441E4pQcnPjAcGRX6faRcCcD5vUH0pYVeIazvpVXM4NWH0xdeGn0ZzusPahrI1XElGJoI9tvaQyfAUEQyxdn6b6c571xeh1fcgpB55AAAfMD6vGGjIz4yk/HBbbQfMuAAlDC7OIN+5ScGV4imBqUaLC1horx823V3Mqt4RMID9FkVz1X7hxhAHcnxG0p+d+lJ9W8o/00QuD9bIIU4bFF5lIZTEq5zVz/jW8ybWGs8Q03Qx25As6eHxscbp5dh9+uCkaY4DzYz1bVEV31+BArJq26DTemL3gXfbnEJiB1mGQtZaC26/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c1YCPbbOCbzMmmHpPkMkEhxFD7GP74X+JFdqT1APs03FXK/hMLamPsrqtgIi?=
 =?us-ascii?Q?KlXku715bdV9C/eFelDK2igUtTequLtL0CjF9ZI7NOZyc8qdvGwJ/qdcJwhV?=
 =?us-ascii?Q?SuZGQcphno8hNa5RVqTooKow9QCa0GBIFEdaoiapDlxE4midvQ2zeBhHvK7Y?=
 =?us-ascii?Q?Dk/QRQ4FE9jm9QZ/p9dVDVy1ZvPNRnQ6N7V7H4xKxAOPTWegfF8iRriEVXvu?=
 =?us-ascii?Q?ieEYa1vQzwIOCvXtap+zyL8FFw65vjGMiIyYVBPLMV5gXUb9s+pLkOQ+42jU?=
 =?us-ascii?Q?C8SAYBqTzKupy9cpXaMgYHrnJPuOdusaTb4J6lh8a8qiZ77LDV2IE9DCK99O?=
 =?us-ascii?Q?GPxfaQgus2E1YNIyw0NC901evyDTddQQGUkT+UzR1vjSWB0CaS6ecvOUyB6F?=
 =?us-ascii?Q?mgOjoT0mQ1IYGE43pV98Mg6rbcp/n+TPOL+bIxjgz9rPPlcFQMv7HYTcUXRG?=
 =?us-ascii?Q?JG85RevDI8yl7FD2I7KAZFSDgWZ+h/wE+juFMrtcR8PzELfRyzgKqUA2WuzP?=
 =?us-ascii?Q?UNAoWH6N0EC4hy+N7+yhS5fWkwd50ks2eS9498VQRBmsFoPNTT8sS/vdR3Pe?=
 =?us-ascii?Q?Vg19NBng4TESnpwiywtvuPIiRNEbmbFpulIZNPu4+6Klx8eCMZS5WgCNEvjQ?=
 =?us-ascii?Q?8+z51S5UmA0icPkL/B+DFB0tb8YPn4q3F28OxEiY9XsL94oQnpnIPcghJBlb?=
 =?us-ascii?Q?Q6ORQzVL62VwsdYbY5mIVSJCcE3objhu8KjShxvwJBSPhiBu0ZYLKp9GFU0y?=
 =?us-ascii?Q?Cm1zJKTIyYkgywY4146yIX+GTCFY3D/+h2+kMi/mF7I6S7+0qphxzqBWQ1Sr?=
 =?us-ascii?Q?Tgf43WpJ+mM2CH/7ycmop6DugfzQHBo0SCfTjPRkeRyaTG7fH1c7Jza3d8EU?=
 =?us-ascii?Q?6JpwyNc491ywUMJko82Rxi5xgXmH5iOXPwsPTZ6BCVuTxBe6FB5e1wOcrbMM?=
 =?us-ascii?Q?aEMwr61/EJzC3wr3/Y+TU8FFVzxEBv4rSGppy3+LlaD4dW2OykwSUpbt6kgN?=
 =?us-ascii?Q?sJobBxex+ZGbcN1bISpzxSJL+He4Pkfk7FyZYPn9/NuGTQBgRMUB320U0HlD?=
 =?us-ascii?Q?oYES8HR3skhbKT2o6uHAoP8FbnEAogwcnSqhhlezIKayHLHi5TJmGnQJIM+L?=
 =?us-ascii?Q?e3Kd86sD7o3Avl5jzzv6jEpL6tKO7U/LJBulKnmQ3SvNSXo1MxuhGy6twPr9?=
 =?us-ascii?Q?5eSGR47kSB239LQHLK8dGoKsrT8mvAKXt3ZoqbuYwHwnIdk6E3BbJKknQGyz?=
 =?us-ascii?Q?rxTRvNazw0Ik6fkEGBMJIYTGXJb8pt1gsUqtyyqisjLqqvOcz1uGK8G+Xfst?=
 =?us-ascii?Q?iF6z84rtvIjtGMeUSX6B0mNxrrXp/Fvx+LYTUJUnBXcxtVFfEBIhW/WfkqYD?=
 =?us-ascii?Q?ETLcwPW2xrVjISchIU711fMfYAIcQ3L6oM4feXdpTnU3VAgVMZGppBQJMTrL?=
 =?us-ascii?Q?bocAlTOiGc+gu+/u7aSk/esC2gVqL1dzzgrbTUnoEgN52gqm80Bu4+k9UGZQ?=
 =?us-ascii?Q?4CLCUoGj/R4NZKHeBfjAwQ/oL1S0wyV9HSUhKffx6vemzG9J+jVKht4cAd4/?=
 =?us-ascii?Q?tdCn3wQab26go4sUCAYdhMLDfJ/NXIw82OBRE3Z4JBxQ9F1F9NgW/XGlnuJs?=
 =?us-ascii?Q?qj5hl7AQ3hYVmDCHq9Bi+YuhxJvqtiEdiW8VJQFNr33kQpwiLT0QOa6tqlu3?=
 =?us-ascii?Q?2TyUz03usw9WI+fI/xp8jtyR9EiYkWetLWN029zpZx1OwC+eVFjF/ifMve6i?=
 =?us-ascii?Q?MJrhcMOdvg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118557d9-b13f-4d32-dea2-08dec5f37a2b
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 06:51:05.3788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ilh5/Ltmdta4vn6NQh6qxi1JaNSJM5qUh07+DkfWGtzwHu58nXHqm5q7lJb/IQBYUfC46fhDjOeD9MgJnTxmvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9952
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

On Mon, Jun 08, 2026 at 04:35:58PM +0200, Maxime Ripard wrote:
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
> To: Frank Li <Frank.Li@nxp.com>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> index a7906314ade1..1c71697a2083 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> @@ -402,11 +402,11 @@ imx8qxp_ldb_bridge_mode_valid(struct drm_bridge *bridge,
>  
>  static const struct drm_bridge_funcs imx8qxp_ldb_bridge_funcs = {
>  	.destroy		= imx8qxp_ldb_bridge_destroy,
>  	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset		= drm_atomic_helper_bridge_reset,
> +	.atomic_create_state		= drm_atomic_helper_bridge_create_state,

Nit: drop a tab after .atomic_create_state to align '=' characters vertically.

Reviewed-by: Liu Ying <victor.liu@nxp.com>

>  	.mode_valid		= imx8qxp_ldb_bridge_mode_valid,
>  	.attach			= ldb_bridge_attach_helper,
>  	.atomic_check		= imx8qxp_ldb_bridge_atomic_check,
>  	.mode_set		= imx8qxp_ldb_bridge_mode_set,
>  	.atomic_pre_enable	= imx8qxp_ldb_bridge_atomic_pre_enable,
> 
> -- 
> 2.54.0
> 

-- 
Regards,
Liu Ying
