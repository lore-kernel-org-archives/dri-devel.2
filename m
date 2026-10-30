Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEED606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QUnMuPco
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8704B10E8B0;
	Fri, 30 Oct 2026 13:05:31 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1154010E8B0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2X1UxbE46uEkH6WvodROYXztBT2Tq1HNWXmyRPOORvoMKTRMd1U8NqW/WahJUhgKf9XXbKNUWurFOwFbSF3+vEaOAnMmLS6mrnKxkD/JzHCvVi1+1Pw1XpygjziU5Lg/w0Zx/Y5efP7i/zvr75G+jHatXUlDylhO/x9TUMY3+HHJv3HEY9p41dkhBgkglYItTFWB/rcEi3NccOu73WTldgvZzpeC2hRNPriA+YreqemGCl/4/ZwfqUODzrBc40CEe/MFAEwNC0m2Hfj5TxI8Igaq1Zkye/0qp2wBBnYGv2zSMiuI+ftBXVUUhvvfauKFrMmSv/yFh2vIikMRt7quQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SobvcukIqIXz1CAHzfV0hRyTUwt8MNi05qv6gAf3iqA=;
 b=X778J5w1Ej/49TSQKJ1s8tvITheLsL+OLJnYy9HPrHBoyedeZJ7Vu7ScIKFJXvHgskrMKItIU3lMk/GPa0OfG8hCa26ah43u0Z2jbmGGITnaRhSEWY/nx/ejltKbjeMMkScjMhDaUDhepBBBZnYQCRde4CF8DHu0tpH4XBl8ujKNtmnBL2ookBXWY2qjc1FePVxOqOT7ggAZIswt1UdPO60yrNPc9iuc7/tmwmIbv/Q5ynIDj59/KkxE2F+0VUGRGuStYYfJPMQioWjFrT8A9tL78Cj2E2nU0z/ZQ8mFIBMgK2pZK3WgboSHzFZxYXZgNM5CNC1IYwfEI25lGf3rZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SobvcukIqIXz1CAHzfV0hRyTUwt8MNi05qv6gAf3iqA=;
 b=QUnMuPcoJPl3ZkESuzTEFQcUfHmtEcpP7w2YFBoPTE1g17LPb5EDRhCZdZIUAqRhw5A+eJkEKBr5U9rWMbtMC1BVAxM1O2DSqkMFrFv3ltuVQQyNqu7N8yjNahY30KPx9QTMZwZ6qIzPurV+FUO45d7kskiXHiO+ON3zmWvgk91una8M/NeNuevyhitrIgqy1ol6YVnaJJxk1WFUVjNL7Pe6U77UQapESqOFzC3Lou1oW7f9O9F5VsBj/32Nv+VN5N2L2jFFAorf2O+r5scwNc4ku6E+N0RZZFvkx//9dYsh1ZHQ85SSB6l0LJSgGEIOxOBS+WeIS/SX3Ii/nE8YHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by PA1PR04MB11453.eurprd04.prod.outlook.com
 (2603:10a6:102:4f4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 13:05:20 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 13:05:19 +0000
Date: Fri, 30 Oct 2026 15:05:14 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v8 06/15] drm/imx: dc-crtc: Disable at boot
Message-ID: <auR3zOdTi93AhWSS@vm>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
 <20261030-imx8-dc-prefetch-v8-6-c4f81afd4533@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-imx8-dc-prefetch-v8-6-c4f81afd4533@nxp.com>
X-ClientProxiedBy: AS4P251CA0016.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::8) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|PA1PR04MB11453:EE_
X-MS-Office365-Filtering-Correlation-Id: 87172f27-3ad1-4713-a7df-08df368672b1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: mjsdCO8p+ziv3iUqZG/UKHgXLn1PqnMK4l/Wmw/ivGIVxlhuzFAljl3LUgmoy18Lxy4U6zeK16EVX+/ZFDP7v7G1YbO4sfaXRfjtUj1KcSmFHbk3bF8Q3FiuiQFoEyurxWn2v4NT9YSWT9/BNCDa9Gl+BPYk30fqouVJ/vrWZgfyqizIsCgnS+jfSqRU/e9GtM+TjY8YPnoOLm2B3Xl86kV4JHZA1LO74QmTkSeZt8+aHyp/KsZH/CEM4RIyVQalHpkRWM/V/zw6B3PhSBzTZcvln1voU1AgIMjeoj5ioHu8cq3WUoEQw9r943Zuhq70Es0oAIdMjMAzgIow9vLbuV82Y5S97MRsyxsLv8ncOyigAmd/cfrrEp/8v8d9aX72+k9g4jOtv0l3QkiKzPiLPFb71CyEApHC+OJXLccYo4eijLlNcCYFc8cfaD1yTjdiVg+ljHw9r2CY6Uc/p3Hms9C3K7BtYUzJHOY3XHyUFvkrZVAdC9/wZBmgmPAYDs1LZATb9Uy7t7Z2ahvsKE1HKrWe0HDf0AJp6krtm/7T4tLtSOtxmT8Cr5x3btyM2KwQQ/rcP9Qvjm2XypqTi8VglFn43h1Iq0Vm6Xl1rLcmsGYjXkskbHhwubZUA/hrri1xXiO/h/ReRdj4z3IKb0x90b0RcEUoifHP9RF0ksjQ2Mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iue2vocBtpZRjoXr6Q+h+Bjdp6oXF/k5dUBcEeJAbdIm6aI4Y8jDbPvgsbID?=
 =?us-ascii?Q?5Gqy7UQQqTIB36OTvoDpjs94jnN5pHtgXEpIZCgFrJY3Wf5un75ubgVlS1Ig?=
 =?us-ascii?Q?i9UkaC3DT3UOBLUR8yzsgh+0OCLP19tkTuaNPJwReGVFY1+tgykZSr1NkPmQ?=
 =?us-ascii?Q?OSyEA7QGqbq93VSZvPQwGV3+++BDr6NrRWwVjPr1Sfk6ZWFawaZCUCIEzT3K?=
 =?us-ascii?Q?ylz/HuHsa2OpEcVyEJPp80/R8G4K1aRH/iO9VK9ZlFfllg6/rKX4Dosdo5jJ?=
 =?us-ascii?Q?INvsFezkEvRsFQfvsWPicQRugMNvFg3oqSMHFhJxq8EQq30FacGQvCcsw6qw?=
 =?us-ascii?Q?BIFFU4Ku9tJYLWV1x/z9uoVboITYHVMCfbU3QMNf1lMGZ5LchyKNPIMMzMZk?=
 =?us-ascii?Q?ctThIbPtopgi6XJhU4Fos68C9oBH0RTmmbnGUe18RzccE+sseqFF3Ndo22fN?=
 =?us-ascii?Q?ER8GztqlyydaxGaDfqV4DcTSLRuHi2WkfAvL7dgPYy8OndY+fOlech3iJmFv?=
 =?us-ascii?Q?PasPvn5uSUBYTgz7V2WqnzD+0PvZ1ifx5Izn7TfxKOJ+zS8Ol7Aijc+s5Lb2?=
 =?us-ascii?Q?0EH3irjxYMVmcw2gN3mpKCUvDhfVZJ97cCK/6khPu+djGNVZpencJEa9hVQM?=
 =?us-ascii?Q?z6jUvrDal4UatMqY38emQW9lmkRnkjrDVlCzn0e8tveC9c8y8PAXP3paoo34?=
 =?us-ascii?Q?PI+Dx6dbWzO/yLSa60vHDZf6rgpnRhBB7FPAH8lsfTgjOoY9S1wWcTcLWKfQ?=
 =?us-ascii?Q?+ugEj7LjbGxlGYXLeLVniKavI8qeCa/eTEllH62TLa9JYPJvBhQKnle3pzm6?=
 =?us-ascii?Q?vfnFzGI45YcakWDoLo7KZuoFIlxQrUzO4TuHPlUtCT9f8z9eal5IoH/TQ6yC?=
 =?us-ascii?Q?hKY5oA6e3xJZ9lxfPRWYTpqnsa9J+l8x5Y6pDRB9eOhOK23n2Q/kZbMFrgCR?=
 =?us-ascii?Q?xeuUXW3U8uyEMgjg5HStWpGYdNIK+qJyofoQVGaAnwDyMw5VdpKmcP1NKSTZ?=
 =?us-ascii?Q?/TqQkJp+hcYZLYSw2uLHq43/yBaqI/RurDcGcqjnhNrdhae3dVKpQpId9zAp?=
 =?us-ascii?Q?6jqNOQxHEa4ZsG2+lIL4MkeOAvWcurvAj6Dxr2qGEKgWg3eTjxzMygehSbkh?=
 =?us-ascii?Q?EJZaWA4WhTbc3etQQ21lQ1kDowM09t6XqA6FubbGXaCAW5vkj/YRirqJCgaN?=
 =?us-ascii?Q?DxA3JY4Q+zl61tuQJry60KMTYkDLSt1kENJIT0vplBGWyFcFDLYZPMGgLeu8?=
 =?us-ascii?Q?a+EF5iVMDgx3fIJOsh1Yj/zDlPNpGBFiYJrxgteFtqiiiKslBzLR3APkwbZr?=
 =?us-ascii?Q?S0nb/X/+C+tgj51qlU3KO9utReano4XtE5mXkC0DdO1qS48cfHa9KUyfr4iZ?=
 =?us-ascii?Q?tENpqYIzXba7POACYk4aET5Zlo+q6fvR3O0Gi67Y8sxw5Js9N7Nc5ZcKJmD2?=
 =?us-ascii?Q?qxiM7J9VLdwJS22hg60JpblYbIAFkfCuNuhpRJyruksL4xIjtSdzC0e0EMYD?=
 =?us-ascii?Q?7PkeCzcpcxyY4N+qvicI/5/MHQS2GBeicPFaj+/XR/04kKMPf261482+f8O+?=
 =?us-ascii?Q?USWtmHQ/+bsBBAx9l5s5hAa4XIfP0vTtlC4wW9VN8FDT4jSyRsIist9Yh/f/?=
 =?us-ascii?Q?uSbfQoBMtkR+bQFMNcwx8HPZ8RE7b8nYBtDaZPpnehB+wT/jc1W3l2xLQhNJ?=
 =?us-ascii?Q?yLscT3+iCzWumE+6Chjrzdld6w3o/nt8MOLBTFF+CrQ/7ww6zo/6NuigE/jj?=
 =?us-ascii?Q?x1t1beI6QA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87172f27-3ad1-4713-a7df-08df368672b1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 13:05:19.0568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtdZI8Yz70j4ogPfVeW6CHMdKV2typF4C5qD+SX2dWqdaLeNnGGaOI1fLnu2Ph3QYMAprh+zF2I1Dja6H6TNiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11453
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 05:54:30PM +0800, Liu Ying wrote:
> CRTC(s) could still be running after the DRM device is unplugged by
> calling drm_dev_unplug(), because the CRTC disablement logic is
> protected and bypassed by the drm_dev_enter()/drm_dev_exit() pair.
> Hence, Pixel Engine's AXI clock use count(managed by Pixel Engine
> driver's runtime PM) and pixel clock use count could be inbalanced
> after removing and re-installing the driver module.  To fix this,
> add a helper dc_crtc_disable_at_boot() and call it to properly
> disable all CRTCs before advertising DRM device to user-space by
> calling drm_dev_register().
> 
> Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v8:
> - Call dc_drv_set_crtc_disable() in dc_crtc_disable_at_boot() after CRTC
>   is disabled.  (Sashiko AI bot)
> - Make dc_crtc_disable_at_boot() return an integer instead of void.
>   (Laurentiu)
> - Postpone Pixel Engine AXI clock disablement at boot to the time point
>   where CRTC1(with index == 1) is being disabled at boot.
> 
> v7:
> - Check CRTC status to ensure that clocks were enabled by a previous boot
>   before disabling them in dc_crtc_disable_at_boot().  (Sashiko AI bot)
> - Modify debug message in dc_crtc_disable_at_boot().
> 
> v6:
> - Rebase onto the latest drm-misc-next and resolve conflicts.
> 
> v3:
> - Collect Frank's R-b tag.
> ---
>  drivers/gpu/drm/imx/dc/dc-crtc.c | 72 ++++++++++++++++++++++++++++++++++------
>  drivers/gpu/drm/imx/dc/dc-drv.c  | 11 ++++++
>  drivers/gpu/drm/imx/dc/dc-drv.h  |  3 ++
>  3 files changed, 76 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
> index 0d64186a9901..5bc952d6883e 100644
> --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
> @@ -227,6 +227,7 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>  	struct drm_crtc_state *new_crtc_state =
>  				drm_atomic_get_new_crtc_state(state, crtc);
>  	struct drm_display_mode *adj = &new_crtc_state->adjusted_mode;
> +	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
>  	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
>  	enum dc_link_id cf_link;
>  	int idx, ret;
> @@ -287,29 +288,37 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>  
>  	DC_CRTC_CHECK_FRAMEGEN_FIFO(dc_crtc->fg);
>  
> +	dc_drv_set_crtc_enable(dc_drm, drm_crtc_index(crtc));
> +
>  	drm_dev_exit(idx);
>  
>  out:
>  	dc_crtc_queue_state_event(new_crtc_state);
>  }
>  
> -static void
> -dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> +static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
>  {
> -	struct drm_crtc_state *new_crtc_state =
> -				drm_atomic_get_new_crtc_state(state, crtc);
> -	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
>  	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> -	int idx;
> -
> -	if (!drm_dev_enter(crtc->dev, &idx))
> -		goto out;
>  
>  	enable_irq(dc_crtc->irq_dec_seqcomplete);
>  	dc_fg_disable(dc_crtc->fg);
>  	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
>  	disable_irq(dc_crtc->irq_dec_seqcomplete);
> +}
>  
> +static void
> +dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *new_crtc_state =
> +				drm_atomic_get_new_crtc_state(state, crtc);
> +	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
> +	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> +	int idx;
> +
> +	if (!drm_dev_enter(crtc->dev, &idx))
> +		goto out;
> +
> +	__dc_crtc_disable_fg(crtc);
>  	dc_fg_disable_clock(dc_crtc->fg);
>  
>  	/* request pixel engine power-off as plane is off too */
> @@ -318,8 +327,9 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>  	/* request display engine power-off when CRTC is disabled */
>  	pm_runtime_put(dc_crtc->de->dev);
>  
> -	drm_dev_exit(idx);
> +	dc_drv_set_crtc_disable(dc_drm, drm_crtc_index(crtc));
>  
> +	drm_dev_exit(idx);
>  out:
>  	drm_crtc_vblank_off(crtc);
>  
> @@ -331,6 +341,48 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>  	spin_unlock_irq(&crtc->dev->event_lock);
>  }
>  
> +int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
> +{
> +	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
> +	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(dc_crtc->de->dev);
> +	if (ret < 0) {
> +		dc_crtc_err(crtc, "failed to get DC display engine RPM: %d\n",
> +			    ret);
> +		goto out1;
> +	}
> +
> +	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
> +		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");

Shouldn't you set 'ret' to something here? Otherwise you'd return the previous
ret value, which would be 0.

-- 
Thanks,
Laurentiu
