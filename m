Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C9CCD8CAE
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D65F710E0FC;
	Tue,  9 Jun 2026 06:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Lo7bWlXH";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0A210E0FC
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaSSYuxEH+bq/MAmZ9qIdrPt5Tq/5ZsWCsWK/6txY8S0QMF44A2pSTBaOVNrUSIXT4TrD9DL9dLhpGI3ab+BBsV25DBzg4jwCxsxyQiSz3TyAXJ1nWZsNZqqLjuSK1VJdNbsqk+jnqhG7QwOrZwc/y+DMwLcqtQY5E4PVPAafTbjNfjuozhh1GSjnXPCHdgENFLbVLlnUJkVeDpb0oWCNsdhjT9ZoS4yfuGJ4OdmtlHiYcER9+zmEZkiaCpyNPY+UI89kN688lIkh41YXZHwLp0aNBIXoeraYECg+00+cD/D5OxY2SNWWFCw6zT8dVxlON82s1hUQsxg8FNCiHpKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVS5oXvPoqcJTdXItjAbnJSwIXpKlGJRZbCUoHrt99Q=;
 b=XhM54CjP5M2pB5tUJEMltCMwv+50u5wEn3sPwIYaC/d+OAvjpTkl9bqIy2XSDG9tyNFs8gEfDnPuWIFojs9HEHORnVNOdWj0+t8zEfXuFGZWDR07Fi8ZPB5JSqLKy3h50o6MC4nW7DE3BmHPyh81jk2nfDQeipgipoaK1aku3+tRrUphwVuE0vxRwKX5PliDIuiRvpXG657uX0ItaDcNpXwIR++JxO9yPYVdh89JjkJXnwiQ7z7sjryTqh7ofAeJi0qIGWKquez502HQxFFWWcwMrR19trEuFaJgUjLGOiR1jIuoNQ2RI5GwwQ4Fmadkw0B/TRxy5RLb7kmfyiRhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVS5oXvPoqcJTdXItjAbnJSwIXpKlGJRZbCUoHrt99Q=;
 b=Lo7bWlXHnQszqxf2774Z3r15yQNfRtmyE3Qj7LEocKQxZPb2w0re2MqgpDvmrM6pre8Y3PB1iwsBGeAeBSkJ33YKMHUdwLxFh4HacSvMlQdQ20DQFtUhJ1Y+abJNZgrhXDdL0gmN8MgiKBF3nZM07gS/++3lf2qJipTNAP4yPA7jvGcCFYk8dV6t90hANTyZt7j3jIYHLFTvW+ndyLfvUX+YXSHjUqF3pz99GTwFVXfnvftCbmH9fRvtaTwzFHfHOZwS4/MFvX9D9Mtrb/xsO9iS275k8pAot/sEPObFL2ByRNJF7UPj+se1lH1VAzEK/VmEF3+iHfktYFaIx6rpEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 06:53:14 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 06:53:14 +0000
Date: Tue, 9 Jun 2026 14:54:42 +0800
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
Subject: Re: [PATCH v2 19/78] drm/bridge: imx8qxp-pxl2dpi: Switch to
 atomic_create_state
Message-ID: <aie4sgD6AKSwY7V3@raspi>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-19-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-19-0a91018bf886@kernel.org>
X-ClientProxiedBy: MA5PR01CA0207.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::6) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|GVXPR04MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: b725d4a4-f2be-45e6-a2e6-08dec5f3c70d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|1800799024|366016|56012099006|4143699003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2IvMrSE2cRuMHWcackV3BAHcuj2yxz1xhwHfL3KZRFpbPH1hBgGw8jp4n1n7zjCgIMviWj5K4teTu6Uz9J9RctjtJlFkRYO3PHydStmREx4m3nkc1GOk847Nr7WlR4VfUHeOmvO1W4tvNKQWrfzJcJteHNPxTGEKia2s9t0h0TaCXHpCJGJSo/TDmM2c0tqHV7AFlc4wathOXwoglyrlV5HlbkBCQ+8Qk/B9y6MI2HtUAiyqvQy+RimcXuAkBvioqO9chBM2kRH2Y3PnWpJ3jokB+6Iwy0Ap/LOAJSZOV/H4LJVmiGOCVA+bhbsZ1ZPsUCotIadIA10hjMTdZ2CUMy4EOxCpqnxC528ukXCi/ALK22AAjLHb/y153cVXAnNpIB6bgR+VqjCeDXVgUFF4K6Q2rUWEBIVxbdQS5HTvcUrLgpmhvo5CBTuEL81Qimm1o7LyCTQ7TelHziGt6tROAw801hzy/sF5UeJYB9yLO3SH5Pb18swYZOFfz3wZm4xoyzIpyU1iXbLSSzngYiS03VlC2gfbKh0mNxN0uWRCjvSduUCjy/0FlRn/zJKuv1VSdjP+W9m5aU3Fl1Q0a+2gnamiupeKKy9cCaJBu+aH9WARt6VbHIPGIaA+T4NjA8q6Paw5CJBv7PIDtP2tBnxWCc8AFytaSBQ8g0OxByLkkPlXHHevg63x9MwzqrtUQQKM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8fFvPbM/EYwaOKwrrvRMpn6aJ+MxXEFR2OMpeHEM93m9AfI+PpQuui/3gP2j?=
 =?us-ascii?Q?37+zYtMx1tR43XIohCwkMeTAQI3nEbjov5VzNYgaWLat3gI2Fe2+0+F8nqtj?=
 =?us-ascii?Q?Oh901BWlVnet1coxTBwVNm/XP1y47Q5YuhyjadZjV6oaSegJXJ9N42oQfdZF?=
 =?us-ascii?Q?B/kEnjjHPwh2nyhxT6wEnQMnjrSRHlnx2XCWqMpRGLJvMVQxR3OJOnwSrolE?=
 =?us-ascii?Q?QvtEamszb1lqwn41KQ8gPafR4ld+zKJn8CDnSjYF/guLKXip4YdFLZor9Exm?=
 =?us-ascii?Q?xPEdMmijvnrX8L5mItq3QGQR+C/YuGwSUR8UklQw8JgxOKu2i3ec5W0Txr3W?=
 =?us-ascii?Q?sVDQ5W4wX1zUDtC7x1a75Sz7gI8AMFI02PIMu5dLLScUXVhN9BLv5mMTMJdH?=
 =?us-ascii?Q?GsIg6TsvvIwd3hmVGhmGIc6IrimX2dhCpr0oZDaCj9VnMrsxtdGnn7Flmsrq?=
 =?us-ascii?Q?SkRICFqvIKyaALg/Hf09FtN1AxO0XOGB7D/HKZIFKl8XT9j0OO7lCRYnIBvI?=
 =?us-ascii?Q?5yppIuumPBa7TagCKza876WtqxmS6NYpMyHfcSPRfJ5eV49U3F+6BIyREiUu?=
 =?us-ascii?Q?jKlZKe1RpEoFNrTVhVrsZ73tfGGYAaJta3ffXbR4gf2u7WQ5s8kRBAilAZh9?=
 =?us-ascii?Q?LFsOfrcu7ihtO1jkp9Ht6f7cMo/w/q+RM5IbymGSECvVdKN74x7NZ1Ueve02?=
 =?us-ascii?Q?6JldZaEHaFkZnsdKUZWzb9zGxYw3vBZi6UTqSdKlYOSmyJutl5ivrgFjW8FD?=
 =?us-ascii?Q?AAc75R6o2nTBYbjixkvaAB+gmKdIOCMXA17H02HiE01rckEhIbW6meGsR9B9?=
 =?us-ascii?Q?Y7iDlV9XD5WKL3XNkNzHnjTR8lZXKMrCnJxXUcdQKHh9vkMDve/ELQWcy5Hw?=
 =?us-ascii?Q?Mw22lZWGO7mkBtIqGMn5Ck7hOy9/C4heFhLN1Z3c16rLRP9y2Q5m0kikjEhs?=
 =?us-ascii?Q?6Qzj1z9VrOD9ZnLe02aSy1ll357War9VF/w1KBsfSEIjdgxTgEJclWek7Khn?=
 =?us-ascii?Q?gL/tZx8jgr+I7KPLsYK4RxjPBzoBGHbN/t5EH9o7SocfNbUYpz1UXdF3VNnv?=
 =?us-ascii?Q?Ib9Qyq3dSREEyNGIvsAoaihcG6u8LqdELcNSQh07aNW2R0StMzUMqnkHcTfd?=
 =?us-ascii?Q?5Jj9Bw7EdZoerCdjNo+xzO27OPoEBA7GY3gDYLM75It2lxKyEXfePmWMlYTm?=
 =?us-ascii?Q?QQe11XQWYYJCU4QFtYzUuoUAFCyF8DFdQbML7/HmQHu1S1jZg6tVDv5hhnJI?=
 =?us-ascii?Q?jzOblqGwxbWGia955O3PJWmSO8T6vspbrA0q0ohFd4Vvg++rg3wYwV5NeETK?=
 =?us-ascii?Q?aZetTwfuH85dkpfIl2l9Um8cCypgekSgdkxvCXtVvMd4tseO/uN7BvA/IF/o?=
 =?us-ascii?Q?qr43QAQZt3XCZ5KRxmF1joudMYAh6J7fy+64we8Jx5CjYLhWSYPzE8umSzmD?=
 =?us-ascii?Q?ltti6TpQLMNY8RhLa7GOhNFl3g5otGIZL3e9/Vv3TnW6ADfxB81GR8SX0wXR?=
 =?us-ascii?Q?Y5xchu8sOLj68QOu17GFFZoV0Sb6CimYLmK2eackit60mN5A2/gBCOdX8kFk?=
 =?us-ascii?Q?0RU/H67/8l8mwD7lp2GJfkKE5dXxBbhFcPflxurI711Tgoxb2t7TjETmu+iE?=
 =?us-ascii?Q?3oKFnvF3XfjL9d8JJzUUsKAdUpCD7D6V4S3AFR6XjnsdYn5zG/oTHzTOVo8p?=
 =?us-ascii?Q?1gXYTveiwCsA0WTTjd7/HFljoP76pYci0RjYhDDc+e5nHh1Ak3KXVBwc98Sb?=
 =?us-ascii?Q?wdXwvgA4lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b725d4a4-f2be-45e6-a2e6-08dec5f3c70d
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 06:53:14.2246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9rEu5q9wtgjYCJEL1vVA+udHDZV2dUm097xBHTmd80YE5MpIbaXFVDj08j/K2+RWQcuFvzlaoohf/QxqP+Bnw==
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

On Mon, Jun 08, 2026 at 04:36:01PM +0200, Maxime Ripard wrote:
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
>  drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> index 87305d3e0c39..2fc9831f7e61 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> @@ -208,11 +208,11 @@ imx8qxp_pxl2dpi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>  }
>  
>  static const struct drm_bridge_funcs imx8qxp_pxl2dpi_bridge_funcs = {
>  	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset		= drm_atomic_helper_bridge_reset,
> +	.atomic_create_state		= drm_atomic_helper_bridge_create_state,

Nit: drop a tab after .atomic_create_state to align '=' characters vertically.

Reviewed-by: Liu Ying <victor.liu@nxp.com>

>  	.attach			= imx8qxp_pxl2dpi_bridge_attach,
>  	.destroy		= imx8qxp_pxl2dpi_bridge_destroy,
>  	.atomic_check		= imx8qxp_pxl2dpi_bridge_atomic_check,
>  	.mode_set		= imx8qxp_pxl2dpi_bridge_mode_set,
>  	.atomic_disable		= imx8qxp_pxl2dpi_bridge_atomic_disable,
> 
> -- 
> 2.54.0
> 

-- 
Regards,
Liu Ying
