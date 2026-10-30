Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBA4606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=MZsbQLTh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E3810E82D;
	Fri, 30 Oct 2026 06:58:24 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B2A10E82D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 06:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/Sj1p5yzZLixY+eAT5IuJdxJPEYq1fYvAqlZiGcWX+vEuB5WCp65caV66Bi/K68IKH89fPNq1VSPL5rVFSpi8wlJTFw+p+56d3yOZI/oxXZO4xq9h+2R8qClRs25vZAJmBl6txwCy5kZDQFWNisIfIPBO7zZTQ0b2NF67y1S20eiGq0IFN8L0U4RKat2+1/tsXG0GmDcbeOPNf+rR9KCod3k7V6YQctOsA/9wAzlRyCO3lzYVB8IYL6Aq7mFJVG+3ElUO3XdK5SGdeW496WeHGp0lXVqOSzxPGRbNRrl2lP5Geg2cc8nlf4FsDvyz4PsSsh51GsLfEsvOcpNh674w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46KkF95ARg9+0q7VyKlB4phSTV9gNnQHmF2TNXbAazI=;
 b=b6Z3cyEUTCcz/5l7e9vohFk0y3SIozy9hJG6iryoEbhwUQ25s2hTR2XjNBUKxmDT0tcrscwVeM38Arxq5UGs25ygAxgZCZjZG7n+0Mw8UgjSYzi3d13i5WU/O0qtXFUr0boHQgKsznPm48FsKMGESw/FsfRszNibnHdCH62FRx2+94qs0563yZYIqtRhBBSnOKDOWoEzrflXKbaZqh2icoqADuA/XQ2WhPObKIcLHqRPP+diE5w+JTxbxfI9HSiDmd8jGA6RLyQWmZViBERcn8tZu1TmOkYhfPS27ZdFBS2bsvy/kkZtJAADAbwUUpG2sKXNunRABR68YVUc7hwkdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46KkF95ARg9+0q7VyKlB4phSTV9gNnQHmF2TNXbAazI=;
 b=MZsbQLThSNtBig8NEqVMcirY0IbTiXUKeLSftn6xhkXBL3i6GWRocXlHnMfjBFuublWH/c9m29jwXP94UELaGfzGq6xP/CQihtnnpf0rB0YD+XkWgy2MK94mrix3JXEW8HDUlIeHoWQjEFtwSjxa0WBAaShe1w9bXYGtsWTj4BB5E0VF8aWTX9OyyQq2BqsFCY47y2G73WdnLHtgY/4X0cnz18n8cSsmlTHOrAEgeaiWWnJ5cUPygouAt78WY20aR6P3VJW/QhW7r49CpZF1Y1+1B7Tp+di+EcJAMmac/VQ8iv22wW2+CjMOk6jvIx1Ocx3k/dtvSedJ8vEM8ukCHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AS8PR04MB8561.eurprd04.prod.outlook.com (2603:10a6:20b:420::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 06:58:12 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 06:58:12 +0000
Date: Fri, 30 Oct 2026 14:59:50 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v7 05/15] drm/imx: dc: Flag CRTC status in
 GERNERALPURPOSE register
Message-ID: <auRAZiHCO79e0dHB@raspi>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
 <20261026-imx8-dc-prefetch-v7-5-a0b50cc4fc65@nxp.com>
 <auH5iQyk6HBDvxiP@vm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auH5iQyk6HBDvxiP@vm>
X-ClientProxiedBy: MA5PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::8) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AS8PR04MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8c1f85-6473-4304-ff4a-08df365329e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|19092799006|4143699003|11063799006|56012099006|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: K5CtLur8fxHFC9t9Wfq2ESU8lz61GoZpDuX5kZOZFrL/eQ/F+Pkf8wgqBv6H90M9lNc+OsdBcfTJkrtA01++70xx3F5WvyRN8pxXCqcPWzhKfGPZisdQdOMxH6SbYnV1syJ9r5uH0uAgmXDlm/GimlplTBBStH6azrQ5B8JIsHvCNWiAm5YBAIhq5ZeLJcb3yGsSZzYI4JdsJ8QQpyfsNqxdpyS2tCWzMLwhmpOGYRonssK+iXP2vDu1o8YILN2s0m2cFhWnQfqKx276LIWSJ8kqr66aOk3yEIgRkklnYxYT2S46vcsjVOi4uGwGJqCnVUsAD/pF9IBOyUViTrnmtNEAhayfHmC6kjrgsQooAtJ29/yJCmoGUvJ3TT0xOplznowaLEOZxB06HQp7bQJsTgQy/4YfSJYCw6AQmSAF6HS9OxY2vkwcJBPev8tIIcpH7KtkuNnAok6ugTS+AdbKl/wTS2yO1We+fk94PqToZ+qIG46oj7O2cqJ5AJbdG2+D4edttij5fc8l2lgIuZVHk3nyaZnJuL8BTHAurQL5BxtNTu+zs9B7TuN8zJ4fyZlrKc7E3MOj/FMKIcIuL2zTgPLOkaCQINVoFUgZSy5nGJUQlf58QCvpzkH9KVCDED+d2AG6NijAqRDKED4LT5t+xzRDGNEDk07tp3jnqNwZAGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(19092799006)(4143699003)(11063799006)(56012099006)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FIBY/KHD1IdaeoWpCLcLeLQkYXDw1ZI9AmmfBpXu4ewLpeSFq+O2ZFMKqZAh?=
 =?us-ascii?Q?kLNg0dko7kVNco/EpOK7q+7SCaGX9LaWb0vmL2MrXPrCwUy5J6WtkTlWjBmA?=
 =?us-ascii?Q?exIPCBeonfouquGrOkQxeEKo9hTTVbhsy26v2Im9b4SVlThy4gWJNvT/3pS7?=
 =?us-ascii?Q?OoXmYwab4GrHdESf+4Ui+Pjmrdo2MnBs21MlSES5nIbUg0SefdIl1UI44xOc?=
 =?us-ascii?Q?lUud+Cz9zm4sPLTvU65U23fl9FtaMrx0HseDJ2aFHrpCq1Ne7Z2J/GH7pUEk?=
 =?us-ascii?Q?k0bLWqTEsGdbSJHrVfkvzQExqVpGGDRWWozeZiAMmEOI8AyZonfB0LnNQ5cL?=
 =?us-ascii?Q?RIIERZvbrSeiVnvaxk5oLfM0JVBZkzKA1QpM0FN/r+vGXWYh1I6moN/O55Ge?=
 =?us-ascii?Q?Gc/q5dThNp+alXtP0gNwisVqauEjCmh6PvuPY8xqr8qj4p6q5IpWFP7kfrfV?=
 =?us-ascii?Q?2+xIA6wYLZ5OzKsflAySRzwmk760TydjfGomu2LqN0JCKEdxSRD/Jav6xnR9?=
 =?us-ascii?Q?mIPzeL4W4tRLNfXukrf+yWvqneoVcfojgbqomdAEEKV1XClNvivBW4Ln+IMJ?=
 =?us-ascii?Q?JLpqKQc5tNRVyV9xsfo1DTUupXVrFsHFtPf12Tc45MZjWAPNIOSN/tvgiz/r?=
 =?us-ascii?Q?h245qruMKn1Weq2hBEl/yDAKLFLn0jk9NiCZDtxTgHYL6BhFo26CyAaMv0BB?=
 =?us-ascii?Q?ZOgbcu/SEq789J20XgNWq0Cwn4OUazUBYnG4EHLIwsOb1GPIJvc4lVy2q8wV?=
 =?us-ascii?Q?UE104xPM4uLEG7a7/aWWJcmdC74E3qNjNhrAVC24JfI0iZzEa16pXnB/69k2?=
 =?us-ascii?Q?r6/CMiy+USB4D2bQTT/Dtm4S5esuLSbb7NTRXGG2OaP++iGfSnXmSetyZE+3?=
 =?us-ascii?Q?zLTvG7XxbUbYKwo1hduSxKjUPoK5OEi+aqDAaNMG/XTv+7Y0sR/b2/cp2Dhh?=
 =?us-ascii?Q?38oTszNg+W9yS0duc+Vtt2gTI0y/t/8C68e+zQwzzjjBbg9bWwBwsb+D647r?=
 =?us-ascii?Q?675hOfLxJ1CkGfkq94zXVS5fwSuj0Ot/2xH7ZpbPtcMHt8PjUzBVIGNfajhn?=
 =?us-ascii?Q?8gYWpoq4Yv6CUPjtN3jGgCmk0reRtyTF3rFbrPor9ubXd5/vqGzSJ/HfOva+?=
 =?us-ascii?Q?H+phUFfd2ZDPp9BTlUm13dYklBaG5lLjZaYOsuM5p614UuKOof4qyC6RjPhj?=
 =?us-ascii?Q?cOXGOR7b2d9E8j5H5f65s0roo1ELrAc/hdQJsLDTr7vf4xFTfs+tPETI8blF?=
 =?us-ascii?Q?1+5IWVXWdfCzuHqxRcsj61YZ4D+xZy6zddiDdcFNzuyNseE8k8BFmNDP3mje?=
 =?us-ascii?Q?Z+lVUzY7HXEnHj0N6avVf7k7XgC2yg1jdse0wJbivU5LMTtnofMtDriHTGeJ?=
 =?us-ascii?Q?9Sqt9g5U6RmSEM/bhHpAU11mFZERreLbZ5rirhB9MSYuV+HLzU47wbOb6Rqd?=
 =?us-ascii?Q?ENfuvYFoBymE1DoHBNghOKbxvi9BOpAkdBsQYmUoZuf/fmodYpt9FwJr13/1?=
 =?us-ascii?Q?vHwoFiHvOIy978mAzTymFCHy0dVnPu8p+6qD7MUnh/p8PFg0UlwYsdPXpDVq?=
 =?us-ascii?Q?W410aYJxluZtH1Mmm5ZvMHo17S/pLjoSl5mVIUjTpNM7N0rVTnDcKDTia1vK?=
 =?us-ascii?Q?fUGfuVOgeCNUwY2J56kTw42jOgBGfFWtL+Xxw65IgC3tjNLxlq/ziTX8oh+y?=
 =?us-ascii?Q?7rYdEwz8pAnK95xi9mWi4QXduBpJVBNFBPX2DUqQjxnQNkC+5x1/7ysZ6TqL?=
 =?us-ascii?Q?LpfpkR3LUg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8c1f85-6473-4304-ff4a-08df365329e3
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:58:12.4604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyenGoo8a9hCbZkV9TJDM0ad0Go6TglT72D7nepW4DIPPqrZhy1Ginn6aq34eW5PxCLRzbNaZqLZH/M6+diHsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8561
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:28:37AM +0200, Laurentiu Palcu wrote:
> On Mon, Oct 26, 2026 at 06:05:10PM +0800, Liu Ying wrote:
> > Map Display Controller's register GERNERALPURPOSE at offset 0x100 and
> > create an MMIO regmap to access the register.  Create helpers
> > dc_drv_flag_crtc_{enable,disable}() with the 2 LSB bits in the register
> > to flag the CRTC enablement/disablement status.  Also, create a helper
> > dc_drv_crtc_was_enabled() so that the CRTC driver can use it to check
> > if the CRTC was enabled by a previous boot or not.  This is a preparation
> > for an upcoming patch to disable display controller at boot if the CRTC
> > was enabled by the driver during a previous boot instead of a bootloader.
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > --
> > v7:
> > - Newly introduced in v7 as a preparation for fixing Sashiko AI bot's
> >   comment on an upcoming patch.  (Sashiko AI bot)
> > ---
> >  drivers/gpu/drm/imx/dc/dc-drv.c | 76 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/imx/dc/dc-drv.h |  7 ++++
> >  2 files changed, 83 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
> > index 13795a2ad735..ac1321adf1c8 100644
> > --- a/drivers/gpu/drm/imx/dc/dc-drv.c
> > +++ b/drivers/gpu/drm/imx/dc/dc-drv.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pm.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> >  
> >  #include <drm/clients/drm_client_setup.h>
> >  #include <drm/drm_atomic_helper.h>
> > @@ -28,9 +29,21 @@
> >  #include "dc-drv.h"
> >  #include "dc-pe.h"
> >  
> > +/* General Purpose register offset used to flag driver usage. */
> > +#define GENERALPURPOSE		0x100
> > +#define  CRTC_ENABLED(x)	BIT(x)
> > +
> >  struct dc_priv {
> >  	struct drm_device *drm;
> >  	struct clk *clk_cfg;
> > +	struct regmap *gp_regmap;
> > +};
> > +
> > +static const struct regmap_config dc_gp_regmap_config = {
> > +	.reg_bits = 32,
> > +	.reg_stride = 4,
> > +	.val_bits = 32,
> > +	.max_register = 0,
> >  };
> >  
> >  DEFINE_DRM_GEM_DMA_FOPS(dc_drm_driver_fops);
> > @@ -156,6 +169,8 @@ static int dc_probe(struct platform_device *pdev)
> >  {
> >  	struct component_match *match = NULL;
> >  	struct dc_priv *priv;
> > +	struct resource *r;
> > +	void __iomem *base;
> >  	int ret;
> >  
> >  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > @@ -167,6 +182,28 @@ static int dc_probe(struct platform_device *pdev)
> >  		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cfg),
> >  				     "failed to get cfg clock\n");
> >  
> > +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!r)
> > +		return -EINVAL;
> > +
> > +	if (!devm_request_mem_region(&pdev->dev, r->start + GENERALPURPOSE, 4,
> > +				     dev_name(&pdev->dev))) {
> > +		dev_err(&pdev->dev, "failed to request memory region\n");
> > +		return -EBUSY;
> 
> Use 'return dev_err_probe()'.

Will do.  Also, will use dev_err_probe() in case platform_get_resource() fails.

> 
> > +	}
> > +
> > +	base = devm_ioremap(&pdev->dev, r->start + GENERALPURPOSE, 4);
> > +	if (!base) {
> > +		dev_err(&pdev->dev, "failed to do ioremap\n");
> > +		return -ENOMEM;
> 
> Use 'return dev_err_probe()'.

Will do.

> 
> > +	}
> > +
> > +	priv->gp_regmap = devm_regmap_init_mmio(&pdev->dev, base,
> > +						&dc_gp_regmap_config);
> > +	if (IS_ERR(priv->gp_regmap))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->gp_regmap),
> > +				     "failed to init General Purpose regmap\n");
> > +
> >  	dev_set_drvdata(&pdev->dev, priv);
> >  
> >  	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > @@ -196,6 +233,45 @@ static void dc_remove(struct platform_device *pdev)
> >  	component_master_del(&pdev->dev, &dc_drm_ops);
> >  }
> >  
> > +void dc_drv_set_crtc_enable(struct dc_drm_device *dc_drm,
> > +			    unsigned int crtc_index)
> > +{
> > +	struct dc_priv *priv = dev_get_drvdata(dc_drm->base.dev);
> > +
> > +	if (WARN_ON(crtc_index > 1))
> > +		return;
> > +
> > +	regmap_set_bits(priv->gp_regmap, 0, CRTC_ENABLED(crtc_index));
> > +}
> > +
> > +void dc_drv_set_crtc_disable(struct dc_drm_device *dc_drm,
> > +			     unsigned int crtc_index)
> > +{
> > +	struct dc_priv *priv = dev_get_drvdata(dc_drm->base.dev);
> > +
> > +	if (WARN_ON(crtc_index > 1))
> > +		return;
> > +
> > +	regmap_clear_bits(priv->gp_regmap, 0, CRTC_ENABLED(crtc_index));
> > +}
> > +
> > +bool dc_drv_crtc_was_enabled(struct dc_drm_device *dc_drm,
> 
> I believe it would be better to rename this one to 'dc_drv_crtc_is_enabled'.
> After all, you're checking whether the crtc is enabled *now*. Reading those
> bits in GENERALPURPOSE show the current status, not a past one.

Will rename it.

> 
> With the above addressed:
> Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> 
> -- 
> Thanks,
> Laurentiu

-- 
Regards,
Liu Ying
