Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D652CD8C85
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1457710E0F7;
	Tue,  9 Jun 2026 06:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GV23b7ym";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013043.outbound.protection.outlook.com [52.101.72.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504D110E0F7
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/YAQGJw+kaYssGM5DOd/1bNMaC4p5zqMGvCbVAbuElPetZqw+Y5jG7vriF89yUOTv2RjocR7PRyBlY2LqwJMubr5RYMhqtq0PR0klBXHpWUe634dwBt7zj5eHGccwYiSv9DimEdEm6OA5suT8x7WiuKwCfrkXW5PsjfRZ85vPBt3zwI6i9WRU+EI9/RJI/6Kj2+jyr+gdq63+G0LKgebNDvXw4Rkc2ye6dliDj6LyvhyI/+8III7H5YdQYcg0fxzDDr24+h19mwmViT9aUus+8jmyalCawsH6W8UDhtFWQ4zKGDDlnfH0oWk0AtgklIWSGhyBu14GmRrYFeKbg5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rhpb3Jqf5s8qtNZBx27OPA5Z/Fkb6qeUyKTKEM9wNig=;
 b=ZA8HSn+8EvswX6+DHIOngzo6QZe1VXhqa8Rdp56N3LgacGbiah2Y739/bDJjXR51uD8cnw0ZfCKL9vuT8qcF3wYqv829KruXU0prb6wqyJbb0Ph6M3QcSlaG07dtQsEuWHw4tNil9pQP3JhXzXGDIXe6IwhgKRWK9Vl5Bk8aZD5UR4QL/ZCbyj7EgFFax8SLO4cMwpV4GGI10NrOv0DiWQIz/FWFyeyTywYlriGQKOIwnsWkH9DeiBmCpOwXkyYTHys/1y3W1FtfiRbAjCOIY/P0Nm4Ipnxi0E5zDTNhzlxhy7Xpmi6hFcWkR6xd7yWNyzvC9pSeNVqpHlLetWavNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rhpb3Jqf5s8qtNZBx27OPA5Z/Fkb6qeUyKTKEM9wNig=;
 b=GV23b7ymikaiLF0wBKlAoBe3MPABkpAhqmyiRqqoIl+fzpwoRYp+JTJitMrEwhPw19Gv8OGSURJxh0rZqKauZGnSUuAoZA9Z1nI2e8VpzF04ExTfeeUIEtf2YD19RVgd8wRyOk/qKEMzbQ4W93uNVJd5rxRvR/yImtx+xiqiOSWgnzVXfGO2SU6xMwXDX9jIOnWtrvppXFl0olociXFmriF9loXtkXsxbTc6GlQSSiUfJo/QwS5r1jF5ar2Cf27Ezg4it/GZR5T4HapxziGXhXKpHEFPvdqorD1aIbVJgQRNsrBetV0HTb6rI7pCc1SFM7XpChmK/lf9Y5je9Mu5eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 06:52:34 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 06:52:34 +0000
Date: Tue, 9 Jun 2026 14:54:03 +0800
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
Subject: Re: [PATCH v2 18/78] drm/bridge: imx8qxp-pixel-link: Switch to
 atomic_create_state
Message-ID: <aie4i7LQg5CU4V20@raspi>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-18-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-18-0a91018bf886@kernel.org>
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|GVXPR04MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: 565947d0-ed7e-4197-632c-08dec5f3af25
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|1800799024|366016|56012099006|4143699003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1nrUje41qjJFXOz0crKUTLATEhflpfN/PhDAghGFcspR8nf0tYlIhZy+l6z6Pi18hIbOM9d+6f452pfSpprcCo1DNovcVlRQ7/CPT81ePgqxOnguMrcrrs0bWm8OvU/gmK6o9dcd4cKqz/Xl3YfhudUFl6OLDORUOFFSWRojuyjvcoKHY8soYNPOgnQ7GKT19roq2RzN8RILzamjtXDtGrkXZ3CaZgYBu959ZBrSsU4+MUMUOvSOiPqtisnOwc2+XJ3TqHYmYxl7JOY2qHbjYCeSWgFKV0xU+pPFoZza/xmKAPOWn7DVXomWsYnUj3lUY6gIfnqjMk4uJMpzkQ8jp704vaLavT881y3/QTPLJm2RfNU7FbhhofJoA7l0BI2HsoYXFpvbzxc1yznK+NxIDP80QLzvXLQxJtoiv6/MDsgVZK2JNlAO3HL6eFV0enb6/uQd1E1Gjv2A3rFlJ6eauVbqICPu2H/rvpz4bSL9NF2CR4LnnttHe1BYLsKsVKj4Q7bE9URMCBWAOlnuRQNKdFx6vrajAvcLcrd1S+gmfddFZJNPjP+WVjwRa/eJP0wy6R4srcjw0Oi4v3ia9yABmZg+A2z3b6aHR9W5VH7oGSvUlHgaaI5ECT8spDZ0LvbJugvtGtK53dGfB+XjDJ53ufbw+0cCgfeNU2ZJrgWS7UNV6xSXsyYKDsjhMPgsDT+e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B1xwYhdFdu2B6nWMqQIF+iE3fFqcyW+UaRkCkoPfpiO82unvT5b1sD0NHa1c?=
 =?us-ascii?Q?BIfZtxr2131URbuckYi14JePRuUD12IKFHCBm1LzO1XGR0Fyp4g1vRpidyg1?=
 =?us-ascii?Q?x1d/jZ61/zFhdNLDE6wfu7v2ONBf+lGxOxqbZxpha7mMMq3mfxrr8N9vAaMe?=
 =?us-ascii?Q?E34wxdiRpjMCdDdQl4h6ole97OwyjVb8nKSXmL0UE8Zp6TRqH41o1PhLDT9G?=
 =?us-ascii?Q?ikZKrVg6Ic3Oia21RqR+8TsyDSgXBZ0fEylLquBp1zBxAKYoI79dnvarhY8Y?=
 =?us-ascii?Q?1d9FaZWKMR9qdTAcJBRiF1UnbraJz6bM0BukAai+7zyyaoVNwcluG3aMHJn0?=
 =?us-ascii?Q?xXSN19X+rVmSwLQwp1QkaVRMb11SdpiZks3nHh07iDshJhpFdeKYarw390pG?=
 =?us-ascii?Q?qJmbPLF985i3seaht6CZUrvCWOE8reS3Yrv8p+L324gooN6Gq8d1ztGEJFHp?=
 =?us-ascii?Q?twiYBovXgiKFe/hIqSW4lCjPyTZ9wbjkaUYG76gDqOweg2EerHkpgsA0uKN/?=
 =?us-ascii?Q?bLgwrp+ZKAiXgk3UxHOni464FxAmfhUEzdTA3sa1Gogs8BTodGjssRh2sk8h?=
 =?us-ascii?Q?BrftyIaVPNum/NZuSVc/tjC1TERLqxNTW36fQp5sGmPWKSoTUVTOnEupp5rL?=
 =?us-ascii?Q?CYRx0Ux+eISjSr96cyAMZnfkYqJuMZIBa/V7weLYCcyS6GMZ28QiRZrym6Da?=
 =?us-ascii?Q?9timtSdm7IlA/HbDwbM45ZQdV4VGYPwgc/ihPQpN01uFGTJaamfMM0bfTJBE?=
 =?us-ascii?Q?b5fL1tH4ZfXJjSY6AeK8qH1FQHSq1xLFtdL9UQATzp1tqTJlKThI4EDr2ewV?=
 =?us-ascii?Q?r2OgLt8dDx2rwjG4ZjzKsIp0zelV24mJHaWZwHdBAdRzoRCA3xbTgsTQMRTq?=
 =?us-ascii?Q?9qbh4xBu9UYSFjQnd99VcPT0hEUQwtW8bxZDTWbDTYa7PZQSOXxa14TK6hze?=
 =?us-ascii?Q?32zMz3MlY7Pn1X/YegwA863O89lFcIs/BNy6Thc0fZnp1jayAj8PDISryYHc?=
 =?us-ascii?Q?GPsaB2pj4hc+v79mZQzOQeCksZsZHa8kmEuxGprgnOvZjQZ5FAIJujRFzsqO?=
 =?us-ascii?Q?hL0vLlsvTsi69Q7KvtfWmMaw1IT+1/qZ6YA6kkgo0zezxWMKm9vm29SxDOOL?=
 =?us-ascii?Q?Vn5qQOuyOskX4M2H7oSd1D3WQynF/aRgBtJ9CdsvVTFDI9x34X89JOwBpanG?=
 =?us-ascii?Q?XYQCloklOkziGSyPrV93RvdtHL1f72i3nZnD7OFH0V1rhmOd01TAvUpTWSr1?=
 =?us-ascii?Q?WL2VKGm0lNBxVWPrBRbyT7LC64TylOoJNh68bjQF+LHH8zQVIB9T6O/YoxSk?=
 =?us-ascii?Q?ngEUVXw5zrKTJPGQrPgNdCxr0eaWXfztudjuixtoHtRJt73/Zx3cGfGIoSiQ?=
 =?us-ascii?Q?GnjhdtQphuUxJ2i7cZ782441ns7re6KhwJooCxtLdv8eWBywIZmmD7gzpqkY?=
 =?us-ascii?Q?BZeNmy1Nq2VIH1necey02l5yMja6pDC+Dh7+Jl0CHfQH3d0ed/nfgi2eFPr4?=
 =?us-ascii?Q?gYLY8PTpOrahe6DKIImtDfAolUG10Bta0iw2RbIUixLteoAq51Ql2FM3U2qW?=
 =?us-ascii?Q?qhAF6pSjZzUhNYMTLwKtfmwQwMITHN5lvXvZrIU3mE/BoIqRmGVkWht9Z0YP?=
 =?us-ascii?Q?iOaNcdKoX5KM8Oxox51lE7QQHZu097qc0DV/VkwU1/gsINiIQY0OK3a5bAhG?=
 =?us-ascii?Q?zCqXzEvMSt4H08MMuPD8GW4noNHU3I1ZaykgTD5YOYsMYqsZOVid41Gx8pOb?=
 =?us-ascii?Q?nrQsXAB24w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565947d0-ed7e-4197-632c-08dec5f3af25
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 06:52:34.4273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUfVIyGed+8B7OZKMC2yumsOw9PEPEnZacNrQ8P2BfuHwAICa0/0BZe77hVVwAWyKnkq+8L2y9vp6Tj9gn86EQ==
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

On Mon, Jun 08, 2026 at 04:36:00PM +0200, Maxime Ripard wrote:
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
>  drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
> index ee6b6dbbe952..92b8b1ac35d0 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
> @@ -227,11 +227,11 @@ imx8qxp_pixel_link_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>  }
>  
>  static const struct drm_bridge_funcs imx8qxp_pixel_link_bridge_funcs = {
>  	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset		= drm_atomic_helper_bridge_reset,
> +	.atomic_create_state		= drm_atomic_helper_bridge_create_state,

Nit: drop a tab after .atomic_create_state to align '=' characters vertically.

Reviewed-by: Liu Ying <victor.liu@nxp.com>

>  	.attach			= imx8qxp_pixel_link_bridge_attach,
>  	.mode_set		= imx8qxp_pixel_link_bridge_mode_set,
>  	.atomic_enable		= imx8qxp_pixel_link_bridge_atomic_enable,
>  	.atomic_disable		= imx8qxp_pixel_link_bridge_atomic_disable,
>  	.atomic_get_input_bus_fmts =
> 
> -- 
> 2.54.0
> 

-- 
Regards,
Liu Ying
