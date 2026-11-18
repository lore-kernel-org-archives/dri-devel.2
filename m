Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43E606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mDBBfEnI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808D010FCD6;
	Thu, 19 Nov 2026 07:48:52 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7671C10E7FE
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3EnXgYFMZ8CSRzqmBDtnTrK/HJSL4aci41Xo4F6XqtScpy2CAV/I/3OltaOHV53DJaQU+gBF+SeawlRnSydIJxD2rUk+wXJW/2uILMmDGX3y+andt/pgivnSft7MIvUlf9mTXEY+KzQhxLB1MGO4hbgeozpXlV9FvOPBXEYOG9cx405cGU4wfbanqUleM34RzuysQ2cHODiSkS33193Iy6dSNEn9VZFuarKxxx5kMCoATYB9gvGf5NGA2yAVrqi0qQNZSthv8U8ARkStBmV0Dzy9IDY59J9wvnKcwHYhKXetJGIojXSnoWtchBl9HYraewp7MLoNRwMVgNL0qv30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eY2hHNDdt1qZV3S19uhVtiep8ZuUlQu9tochO15/uXs=;
 b=kHx0xyrbjD316E1FwydkVe/LL93FMtpxRYhg+7hJZM8XMtBE5FMzvPZqMGi9I+m/iCeEgKkaq2SQ6z3070jskSkWpxlOGTNsnaVaAST7sJ7zHFl7KtcWabfC8ewy7GKF1J6hnnTXwF3VVS1OE0kHMzUpu+sOZ4Fq0OxUd81/aF2g9VozESw6BwDifvRmtsrGAXZiS0un5+eX6jiMgwzNw7axn7zAWrpbj8nYtSrnHuaXunckwLCUpzyD1TSNgkdVcjU473Rg2ls4Vj5XHp997BmrWdW8yDWGHXl1tPv+u6cGEGegoRAp5sao1gJ8E/knGkcqgTp7VV1P1Ru9OO+P7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eY2hHNDdt1qZV3S19uhVtiep8ZuUlQu9tochO15/uXs=;
 b=mDBBfEnIdJvr+FR6hnjhgiLsYq/DP3eLxYRE5qLItKYdyLj3QDUD42i9JnaI7NVX8wXeuzahcKg+u5zx/RVJJ8GuSyWuGiJAjzZki7QAZFVQr63FRYa2mknNXXCOQrYeEwQpE1Od1+9Z4rAAfOrP+E4Po+vtLcR2db6kJe8q1mO1BlcNfEPa59Z355TWIaaGbJzVKs+Jb9oqiCnV1/LNMsD4+LETmWLgN2rPoQA5EQgZghU2Pla/qKipSgPSWOy8GsafmvWm9NU1ksJrvfv20uHd/Ui2zBCq2OG/oyhP2dHDeKofxJ/C4GrJ0VNdELqlck8hLRhqrpljP5HkKvm27Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by PAXPR04MB8974.eurprd04.prod.outlook.com
 (2603:10a6:102:20d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 18 Nov
 2026 15:27:10 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:27:10 +0000
Date: Wed, 18 Nov 2026 17:27:06 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v11 4/7] drm/imx: Add support for i.MX94 DCIF
Message-ID: <av3C0ietJXI1ax3X@vm>
References: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
 <20261110-dcif-upstreaming-v11-4-9e13c85ae0d8@oss.nxp.com>
 <179449701677.2030221.6593749298448668349.b4-review@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179449701677.2030221.6593749298448668349.b4-review@b4>
X-ClientProxiedBy: AS4P189CA0047.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::19) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|PAXPR04MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f7bb89-8be6-4f17-470c-08df458869c3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|7416014|1800799024|366016|23010399003|261009223027099003|261009221727099003|261009220027099003|4143699003|11063799006|261022105027099003|261028144727099003|261102123227099003|56012099006|261026121527099003|261009223327099003|261009221227099003|261026140227099003|261021121427099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2XMeuwlxi3I0rS4TcYTYs3FJ2SZYzUEVbcWUl3ryi80h9SIZdtTZ2mO7EusxnV4f8PlrvqqSYn1VOkryjMhXJOjjrX0+xhynHAO6iwITNmsG15l0bYwz+V2PVxf08pnYOSluG1FvcOmL3Ous6kLdMFmAfs6kOw0hZig/R60zspWVY3SdnvbpOgAOPJhNOpLop47qTz5FMivuvHC1cWp4Cfhda2I/7MzVgGWUez5sGFipfi8UbYAweuYNIlfiaMFGyQEOaucEM7oGJDOys6pE+iG13zmynXdPNOKXrJnHipWCKINSLVxpU1LOKELBi+82okAIWWP5ckVs8Xp1Fe/iQ2HhEbSgXzA6Rv6phoEvHVX/CVeU3ZnJ7d39p4C3tRxAsc58OhaPzTloMQQX4as0RZR6E39/rWnO3VF8F6T29ytQiuaHqpDr25LpBdEVh2ti3PCEm5yn74QoIP4hDwpe0nV6A8FVRymhxoHJr2jridGt1O33Vxc9qhb1CO5DjI/r+Jy0tSLGZYdRvJL6q2dTFYaL3B9Rkv+W8JeAO00r2/eMe+HBakAw3hyWr/bW2blvwWg4av3mBCYTFYhMPYsyxjSPifJH3iXvH8RmG8wThoaKEuxwCIZv5uMjm74gEkGDbB+o363XBy6HlIhXfZiEbzKw4yL0OACA7CvkuDrGGR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(7416014)(1800799024)(366016)(23010399003)(261009223027099003)(261009221727099003)(261009220027099003)(4143699003)(11063799006)(261022105027099003)(261028144727099003)(261102123227099003)(56012099006)(261026121527099003)(261009223327099003)(261009221227099003)(261026140227099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O+xQBYzhPfo2I5pjwaVBqPy3imeA9CNdNgS1IRuI/fVmJVaicUxORySfJYYI?=
 =?us-ascii?Q?urJv3Q8BFxu7apcgFDqHvqUk2dgdxbFcB4tVJ0hW8uUD1y7IqorLzNgMgxsz?=
 =?us-ascii?Q?KSLq5iIXgGe3fF6mYnws1fKjCO1L8c+PmGi8VOUVsrngHAR72mQr6Zf09q0r?=
 =?us-ascii?Q?4KTl/hBPuIX6jz9Sj5HsPHcvEJpD57jBFXC2x/0F5MOeW6hgdfWnR6p/olNu?=
 =?us-ascii?Q?Ib94P2CM1ODohL6QSAG3hJ28+Dc5jWVmfs+HPkHbChOa8CdNN8MWax9798Qm?=
 =?us-ascii?Q?AiO7xdIEZF9c7xaNeFaGjt6E4Gfdhbf46WmJJWApkOR7Uh4HUFX0ByaOnmVn?=
 =?us-ascii?Q?vP/qrTkTK7rAOLPjQrdhRwYBfHDXDGFP7jugqPKaui0L4uB99dupM+fmuOfB?=
 =?us-ascii?Q?VUhNfgRjbFIN0PaMNdukjjVA1JB5az96A4XY9MGcgE/kN6DCg3p1/G4eKGMC?=
 =?us-ascii?Q?UHMCMRaANKx5d/vq4Q1ozUQClSOhX9f7nme4aiKfp0Zfgz2A8TtDOf5+0HNQ?=
 =?us-ascii?Q?OF3wGDR+Sxr1PuD5qD0Qnf5BEeJupqkUmseYvr1kjRZxYtDtCCJ/i/oduE03?=
 =?us-ascii?Q?ql8kMJSiD1lJyj9xmFozTtM97Z2NaImdoxeuXOAVWNh1WrhGShsDyGaLc1Y9?=
 =?us-ascii?Q?SprR3P2eCkemk79NLPrZaifP48PtxrxSAG3y2EV5VtRakNh57X0+I/z+tEdV?=
 =?us-ascii?Q?DGIwdBh/t1gYoyXZ2kxc2ha3xUuYKz5vPaRKdQXHW0EO1h+Q1bBMEFasCcYH?=
 =?us-ascii?Q?RaGwQu9hid81bT/a97y68UyHb7MqrbvmeVOlfb6cyYiWtSukzhaG5pDWPpDi?=
 =?us-ascii?Q?bDefV5e4vvNEBZ0IEKFpBFxXoB3nUzOuWzTJP+ZaRsxslxHUjZNu7RnBN7km?=
 =?us-ascii?Q?ZbmRe7PB4kgOEq00NmbJxh7sBqrnDcI6XyG+4pF6UeS8r2blXnMcd1g2rXVG?=
 =?us-ascii?Q?BGOZ/rmPBMrlnYlDNDRyhL0hw/Nj47wdUw/rcnHoaQIfFBQIMStpQ+/dYOyl?=
 =?us-ascii?Q?iLcKD/5fHHTVAPX69NefbK5Z4CCmWmUOUd3/A0LVWBAlr3u0YrftiiLFXIXz?=
 =?us-ascii?Q?fTexIMpP/nTYJDGtBVJ/rARtAPlO3fqn6WX3ilFmwIQJHvWzRK+ItihIT79B?=
 =?us-ascii?Q?OjJkwIKzya+vDu8rHqQgLfFms8bxGuAByDzQBSGfhRGAHIbv5tJxza/JtRek?=
 =?us-ascii?Q?6gdVGKFAQ6x8qvh74b+Gl3KNlir7KxsRgluOX8W1/s2AFHRaG0dzUhmW29vB?=
 =?us-ascii?Q?Oue2zaJecstaduxtHXNCDWGp1DBaK1B7NPlUsTTWoZqGNlooVPSy7hX+QnQu?=
 =?us-ascii?Q?YAj4dMFqSzXLf9Y/5QWphxqfrf7pRZFYj8J/WqbKqunbazE/WFaLGP0xbfhA?=
 =?us-ascii?Q?BIC7CKTTLwKG91VPFFiO3pszS/6Kwak/PwgI95CIlZsNqJDVlxzduC6Kneni?=
 =?us-ascii?Q?suI5yzqqefj6f/bg/NGXdJ1GSvSneRJe2VREofnQ/PYei8Y3+SDX2RfWxwq5?=
 =?us-ascii?Q?/fhrLB6/+0g1H8OcAVf+CwMKo+nTfkMEysp3YX92U7KX7M5GMv36TW1siZcX?=
 =?us-ascii?Q?czk8fl529mev71XPbIHNFX392DgcScVBfx8LYq8xbc726UMRIu0g/wzl3xLF?=
 =?us-ascii?Q?4Uzd0BMkaUxO9LiL5LFnDB0LPWMHWKdDdQ2KCwxj+ojFNYz1kQERFYrqIr6g?=
 =?us-ascii?Q?T8P/JhuvUSIsq0k7nEL5GRmrNr6QchomMEDLkvsdFx9j8Webed0dCDSQO1yA?=
 =?us-ascii?Q?Zfk8gFtm79X7ACTtrlMlBJgi/qa3Auw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f7bb89-8be6-4f17-470c-08df458869c3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:27:10.3727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIU4ERWak21ngOiqd+AyCDd5V9kvaW2bq9uFaoXIcXnFpjuf7f56hGYYRRD93jATa+A8hIlfNmQov1GLxwo0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8974
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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

Hi Luca,

Thanks for the review.

On Thu, Nov 12, 2026 at 04:23:36PM +0100, Luca Ceresoli wrote:
> Hello Laurentiu,
> 
> > The i.MX94 Display Control Interface features:
> >  * Up to maximum 3 layers of alpha blending:
> >     - 1 background layer(Layer 0);
> >     - 1 foreground layer(Layer 1);
> >     - A programmable constant color behind the background layer;
> >  * Each layer supports:
> >     - programmable plane size;
> >     - programmable background color;
> >     - embedded alpha and global alpha;
> >  * Data output with CRC checksum for 4 programmable regions;
> >
> > Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # bridge refcounting
> > Signed-off-by: Sandor Yu <sandor.yu@nxp.com>
> > Co-developed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> 
> Looks OK, I just have a small remark and a few minor nitpicks, see below.
> 
> > +++ b/drivers/gpu/drm/imx/dcif/Kconfig
> > @@ -0,0 +1,16 @@
> > +config DRM_IMX_DCIF
> > +	tristate "DRM support for NXP i.MX94 DCIF"
> > +	select DRM_KMS_HELPER
> > +	select DRM_GEM_DMA_HELPER
> > +	select DRM_DISPLAY_HELPER
> > +	select DRM_PANEL_BRIDGE
> 
> This should be unneeded now. As o fnow it is basically a complicated way to
> say 'select DRM_PANEL'. And you are (rightfully) not using the panel API,
> so this line should probably just be removed. Please double check by
> building multiple configs, including an allmodconfig.

Indeed, I addressed this in v12 and compiled DCIF with allmodconfig for
i386, x86_64 and arm, 

> 
> > +++ b/drivers/gpu/drm/imx/dcif/dcif-crc.c
> > @@ -0,0 +1,221 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright 2025 NXP
> 
> 2026 I guess... v11, a long journey, hopefully it won't slip to 2027! :)

Thanks, I guess I forgot to update this. It was/is a long journey
indeed... :/ Addressed in v12.

> 
> > +++ b/drivers/gpu/drm/imx/dcif/dcif-crtc.c
> ...
> > +static int dcif_crtc_query_output_bus_format(struct drm_crtc *crtc,
> > +					     struct drm_crtc_state *crtc_state)
> > +{
> > +	struct dcif_crtc_state *dcif_state = to_dcif_crtc_state(crtc_state);
> > +	struct drm_bridge *bridge __free(drm_bridge_put) = NULL;
> 
> While this is OK, there is generally a preference to declare and assign in
> the same statement when using cleanup actions, so...
> 
> > +	struct drm_bridge_state *bridge_state;
> > +	u32 bus_format;
> > +
> > +	dcif_state->bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> > +	dcif_state->bus_flags = 0;
> > +
> > +	bridge = dcif_crtc_get_bridge(crtc, crtc_state);
> 
> ...it should all happen here, as:
> 
> 	struct drm_bridge *bridge __free(drm_bridge_put) =
> 		dcif_crtc_get_bridge(crtc, crtc_state);

Addressed in v12.

> 
> > +++ b/drivers/gpu/drm/imx/dcif/dcif-kms.c
> > @@ -0,0 +1,168 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright 2025 NXP
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <drm/drm_atomic.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_bridge_connector.h>
> > +#include <drm/drm_gem_framebuffer_helper.h>
> > +#include <drm/drm_panel.h>
> 
> Unused include?

Removed, thanks.

> 
> > +static int dcif_kms_init(struct dcif_dev *dcif)
> > +{
> > +	struct drm_device *drm = &dcif->drm;
> > +	struct device_node *np = drm->dev->of_node;
> > +	struct drm_connector *connector;
> > +	struct drm_bridge *bridge;
> > +	int ret;
> > +
> > +	ret = dcif_crtc_init(dcif);
> > +	if (ret)
> > +		return ret;
> > +
> > +	bridge = devm_drm_of_get_bridge(drm->dev, np, 0, 0);
> 
> This function is deprecated. You can use of_drm_get_bridge_by_endpoint()
> instead, which returns a refcounted bridge pointer. And since the bridge
> pointer is a local variable you can just use a cleanup action to put it
> easily:
> 
>   struct drm_bridge *bridge __free(drm_bridge_put) = of_drm_get_bridge_by_endpoint(...);

Thanks for the hint. I updated the driver to use the new function.

-- 
Thanks,
Laurentiu
