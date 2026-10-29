Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55093606A324
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QARfb+7T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CDB910E7C1;
	Thu, 29 Oct 2026 09:28:53 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C9410E7C1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZr03pmr5yLMVtW8/fwL8zSlNreu49zHS3S8d+4t548DLeGsmsSfJrjCrQNWVwJEX2o+9Eczy8urDj17I5K5RwRSP8h/u/nkpu7QbRs/rsPYKHWL2wKHmCGVCxnpv0Kk3gV/tR2Y8c9I50G2P/5EdtiEushg1hNSSpI2FUYtzcSc2cTJdgvXrJy/fBXstG55/k6dLxBFKpUZYlFqBkjKNQDOrtXtTXep1eFtp5r5sB60FTrhTPuy5tQV0doMRDz30LKrmWG8AyNfwtgvCkzT5U9hiCj+4TxUvTmqvGI8cqd0pIdNI+55Htgrb4VTYk/hoWn9DETg18tTMk2wzTXN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huDiPeXuLYclu6b5diw/uWzYjoD1pbCq8RTMXuT7a/g=;
 b=QvsjX7yspaNZb4tbGGerUbfQ7rtVZ+rSP8WxrMpltnLbhsaI+Fh7tySsmQqWSwiP1HTh5Rcu2tuuBJ5vG4OSe5+4zO7sO0BlkXc7FeSnXVx4hkbCR03We2GP/1shQE2qyS1oL8V7Xrb3VHlKPZ4suuNzjrrO/OGzEJTnmD5FmOTVuN/MMubH7ACin1WfwkO670AcaS4tiIxRej8qNREC+IoWPicc0nvVG/mpgoPqysBDFd3zwfYNL5o1DRQhtq0gn7IzqVeMZ/2qfhCHdyYhCzWBqpA692mIOfBs6WPkfIoIMGrNV5E+p9O8GwbihZPXOumXx0O2koFLJYNXc5BAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huDiPeXuLYclu6b5diw/uWzYjoD1pbCq8RTMXuT7a/g=;
 b=QARfb+7ToBDWeSxJlz86VzD34sO4BpQB7af67x8uo8POOQ2/k3KzUeaNgIVzK8HfW9BG5uGaPafntRiNXUzKBBPigXHbAxTVeuI1Hnro0WZGLxwCMPeWgnHEeapau20sBIzJhQnXXGHKJeeZtQMK7AkB2FK2x5J7TyYhixnF9/gU3sRomuAh8afU9dUyMwOxWy2WPXZYXq1PAumxcFSpBqZP+p75ZGvHyPVMbn9edxSVj0YVNS5DhZpwOBdIf/64bBpT/z0iCeJNzIYkrT00V+grFNh/wcId4NnBKIhSAhDFdDmjTovzclWMjyp9oKSp+6EOJdR8jv3uC/xTtfrHyQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by BR0PR04MB935173.eurprd04.prod.outlook.com
 (2603:10a6:2c8:4d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 09:28:43 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 09:28:43 +0000
Date: Thu, 29 Oct 2026 11:28:37 +0200
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
 Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v7 05/15] drm/imx: dc: Flag CRTC status in
 GERNERALPURPOSE register
Message-ID: <auH5iQyk6HBDvxiP@vm>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
 <20261026-imx8-dc-prefetch-v7-5-a0b50cc4fc65@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-imx8-dc-prefetch-v7-5-a0b50cc4fc65@nxp.com>
X-ClientProxiedBy: AS4P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::6) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|BR0PR04MB935173:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b450fa-6d4c-4849-addb-08df359f062b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|19092799006|366016|4143699003|11063799006|56012099006|261009223327099003|261009220027099003|261026140227099003|261009223027099003|261009221227099003|261009221727099003|261026121527099003|261028144727099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iDUAHBrIiQPMgW4+Z2+IFF1L4QAE6aaqxHHJy+ePkFGkkwud1wRF+nT0hreHSV+/77YILqxdnz08gq9ycPOuiQxJwbEueqp11F5zPan9Wn9b9ylZGzE3Xcmia7ntpaNAzDSiQmlA21L6ecMBkHqvwOb59hz1hMzgS0ciE6NUgYbZn+vttO2cUA5ub587TeQrcVUBLAhAfymzPsT1flGuc/uEBorCjWdXGUh4ULm6vhBkMq1EP5duL/IzNlpM3avJq0bmZJGUlo8c+O7QTsMOD4cLEconC3q4e5XCNEOjJjDV+CpnyVa+28C8MMCbKhFpJ6NhGlA+Dhdal5Oo9Zi8kZi4JZoFojoNiewh1zdoJFM1vE3Iep4tzSZjNnlnabBJxPEEtZKVXkcl1ZYVn8ye0DM+DSBW9wXRKX9F7ZrtBljwOg89AxxBevbTazYxaWN4sLkMO5ukKWb0gfdG7WmqwBzsIfTiWJ3l8EqIqaTBrmYwApGt2PL6Mj4tGQb6G5H6idf6UBtTTvEYaqQWzpI+Ocd0Z6uEbkZidAfmkStnOZIoI/sf90Ax4Cfqw4DwrijI0ESseT0wC1AWQ12Pg1d9X2BkGSKwq5yTwHoHBJEjGpuReyIa3foNUsXy6Jf+7VuNGGErQLQsz9GEgtXzFT2M7WYFVCgevVnrl63aGfqT0wg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(19092799006)(366016)(4143699003)(11063799006)(56012099006)(261009223327099003)(261009220027099003)(261026140227099003)(261009223027099003)(261009221227099003)(261009221727099003)(261026121527099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tP44GNQdrBWCNMuE0zoyOw9Zl+Qj2ZDzhH1jUSfFtc6Im41Y5b7jHb5LsgQE?=
 =?us-ascii?Q?8hhRwpVJ+m8KBMaPint23+Yu5cE7fyzpdwQXyXVYbFTqtKZKKcep+6D/3ikr?=
 =?us-ascii?Q?DbdK7I8vEaLuIkxKNpZ4rL9o5kDJ3buMif0F0+WWboOkNdTSUD4pyNOLfqSp?=
 =?us-ascii?Q?9FyOmVnLlE/26AGfICgx0M6CfhFwG/hc0Vyk99tqWYNctcCQr9m/livmGn9p?=
 =?us-ascii?Q?grDFPp53A81UZKe6795OOj6kOIN2xGe2UMqY5FbVcyH0FaQ8Nl171mib/A5O?=
 =?us-ascii?Q?JDsMQ76Vp8lo0OCI1oBSsFWapySzMJZBuuHwHErLI1CrgD/P1gNnw2L5QlAf?=
 =?us-ascii?Q?CRNBZuUjCPdqM/wnUwCztD8ObiXpJQBT08V5gunranaBaYIBIOgNAciNa1/p?=
 =?us-ascii?Q?1vq2jLaWcbmOriBbcqgyYw7xOGEdFX1peU07cNoZKR5VM/wJRDMZNUThh3bc?=
 =?us-ascii?Q?vpFcBg/ov5aPjSHSFjqlV/46YMWVIqKtKH8piTjOlOp45nDd71hPf+L2QzUN?=
 =?us-ascii?Q?9Dh2hNV5jjyoMC9FEVC5VW63/RACjmo4NByuyEd5s7K+oLExPNHUP+86Shx9?=
 =?us-ascii?Q?HGCQ3EKHBreyDhJpjVkgT9MWxb8BZH9W6TP4JO/DrskQWiFM0KJlHCx6Lcqm?=
 =?us-ascii?Q?IAmZ3Rad8E6PfWPKQzywsuUjtheSTYJCO+yy35zsJGVNXz1AISP7qlLgEs/v?=
 =?us-ascii?Q?7+nyIQ1mbXP524BqopoCijd6pENaGjZ0j2332TUMBTyLqcbHqP6SrfkfuW+5?=
 =?us-ascii?Q?vM9awO381i87GfNusjzZGrR68z1LcvxF2c4kB257oxZEZHpcoIryu/gWR/uQ?=
 =?us-ascii?Q?I9hG2Uw0/hBrF/YM7Hi+kqop7QNzuSwzNwsMG87I9jztw067FbdXsXo9d3Tb?=
 =?us-ascii?Q?2N7Ryj3tDHU2LQY8kIJ1rmUhRuZ9CawJYfeHImCjSk7364GdTZHKwy244eis?=
 =?us-ascii?Q?t4Rh9AelBCecBYQ9bqKYbTp5JRGlibXF406xLaATNgY6xwLKAx/DaO31aooj?=
 =?us-ascii?Q?0o9Cma8kC4bq8X8cbe2ehoT6/5wWfHUutIxVtggDO+/07f5kLtPAogFEbWGI?=
 =?us-ascii?Q?Cqhm/bUNW/6xchSWk5kzqOjqly2nekb7nF/8MAXudA9qgg71CSZylHRAA2or?=
 =?us-ascii?Q?8uweavAeFIySrymkUy39u5jCbsycpkDrTkQf42jsYEYmvR5wClXDQgvlnFcg?=
 =?us-ascii?Q?qPp13G0ICuz5SfHuGgLU5xpzyhlKUrIgdvEAuDlyI73jTV8cVlxYbkqDZ7OI?=
 =?us-ascii?Q?vrcO7fupHaem9MIQpXGPUk9V4hHgSJf8a5QMTKXj80q1lVDg0+fD3myCOMbx?=
 =?us-ascii?Q?HFGcbB4P+Z/YG54wtdnskiINo49scZulDMAk8Q2eKhbYGrqfRHDyiEytLJzb?=
 =?us-ascii?Q?TTWjcIsv4a20sbplFsP6TnMjor4AAONItNT0jsk3EVxV5yU7BAVp9ysE6D6e?=
 =?us-ascii?Q?Pcopx/R3xyJGwY22vehiuqkxmEDGp4Hy6wzBU7URx1LRdm4Jrsx89L/Lwx81?=
 =?us-ascii?Q?XGWn3oWKgWAHz1VzbG8PYLIUz3RFGi9XZ/Dga0SIsuXSxp6DX/s8oB4bsF/h?=
 =?us-ascii?Q?MW/PUwWqfZ2G7Tl4A9Sx0o3wXaPLN8evu0mN0GePbjyswBPcMtde1EIM51Lm?=
 =?us-ascii?Q?X56C1NisoPL5vGIWd4slpJwwBDq+qyP3xPclgsC6CtTfIFJMdbO8N2ph8lp/?=
 =?us-ascii?Q?NYVC/x5lKlXvtzaBavSDKfxXYwunwb8yNKTu9+Hfnll6Jrzt6034jN5ekUz2?=
 =?us-ascii?Q?QtePQ36ZR3SjjD5R5roLDUKO8K8KinA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b450fa-6d4c-4849-addb-08df359f062b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 09:28:43.0873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e97aJSrxizXPxQ6mXnFihKhJaslmnuVlxz+nIMXn79DWKS3CWLu5oNsF9YFchEXcN2lzNi3S3TWMd7N/zxZeQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB935173
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

On Mon, Oct 26, 2026 at 06:05:10PM +0800, Liu Ying wrote:
> Map Display Controller's register GERNERALPURPOSE at offset 0x100 and
> create an MMIO regmap to access the register.  Create helpers
> dc_drv_flag_crtc_{enable,disable}() with the 2 LSB bits in the register
> to flag the CRTC enablement/disablement status.  Also, create a helper
> dc_drv_crtc_was_enabled() so that the CRTC driver can use it to check
> if the CRTC was enabled by a previous boot or not.  This is a preparation
> for an upcoming patch to disable display controller at boot if the CRTC
> was enabled by the driver during a previous boot instead of a bootloader.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> --
> v7:
> - Newly introduced in v7 as a preparation for fixing Sashiko AI bot's
>   comment on an upcoming patch.  (Sashiko AI bot)
> ---
>  drivers/gpu/drm/imx/dc/dc-drv.c | 76 +++++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/imx/dc/dc-drv.h |  7 ++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
> index 13795a2ad735..ac1321adf1c8 100644
> --- a/drivers/gpu/drm/imx/dc/dc-drv.c
> +++ b/drivers/gpu/drm/imx/dc/dc-drv.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>  
>  #include <drm/clients/drm_client_setup.h>
>  #include <drm/drm_atomic_helper.h>
> @@ -28,9 +29,21 @@
>  #include "dc-drv.h"
>  #include "dc-pe.h"
>  
> +/* General Purpose register offset used to flag driver usage. */
> +#define GENERALPURPOSE		0x100
> +#define  CRTC_ENABLED(x)	BIT(x)
> +
>  struct dc_priv {
>  	struct drm_device *drm;
>  	struct clk *clk_cfg;
> +	struct regmap *gp_regmap;
> +};
> +
> +static const struct regmap_config dc_gp_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = 0,
>  };
>  
>  DEFINE_DRM_GEM_DMA_FOPS(dc_drm_driver_fops);
> @@ -156,6 +169,8 @@ static int dc_probe(struct platform_device *pdev)
>  {
>  	struct component_match *match = NULL;
>  	struct dc_priv *priv;
> +	struct resource *r;
> +	void __iomem *base;
>  	int ret;
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> @@ -167,6 +182,28 @@ static int dc_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cfg),
>  				     "failed to get cfg clock\n");
>  
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r)
> +		return -EINVAL;
> +
> +	if (!devm_request_mem_region(&pdev->dev, r->start + GENERALPURPOSE, 4,
> +				     dev_name(&pdev->dev))) {
> +		dev_err(&pdev->dev, "failed to request memory region\n");
> +		return -EBUSY;

Use 'return dev_err_probe()'.

> +	}
> +
> +	base = devm_ioremap(&pdev->dev, r->start + GENERALPURPOSE, 4);
> +	if (!base) {
> +		dev_err(&pdev->dev, "failed to do ioremap\n");
> +		return -ENOMEM;

Use 'return dev_err_probe()'.

> +	}
> +
> +	priv->gp_regmap = devm_regmap_init_mmio(&pdev->dev, base,
> +						&dc_gp_regmap_config);
> +	if (IS_ERR(priv->gp_regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->gp_regmap),
> +				     "failed to init General Purpose regmap\n");
> +
>  	dev_set_drvdata(&pdev->dev, priv);
>  
>  	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> @@ -196,6 +233,45 @@ static void dc_remove(struct platform_device *pdev)
>  	component_master_del(&pdev->dev, &dc_drm_ops);
>  }
>  
> +void dc_drv_set_crtc_enable(struct dc_drm_device *dc_drm,
> +			    unsigned int crtc_index)
> +{
> +	struct dc_priv *priv = dev_get_drvdata(dc_drm->base.dev);
> +
> +	if (WARN_ON(crtc_index > 1))
> +		return;
> +
> +	regmap_set_bits(priv->gp_regmap, 0, CRTC_ENABLED(crtc_index));
> +}
> +
> +void dc_drv_set_crtc_disable(struct dc_drm_device *dc_drm,
> +			     unsigned int crtc_index)
> +{
> +	struct dc_priv *priv = dev_get_drvdata(dc_drm->base.dev);
> +
> +	if (WARN_ON(crtc_index > 1))
> +		return;
> +
> +	regmap_clear_bits(priv->gp_regmap, 0, CRTC_ENABLED(crtc_index));
> +}
> +
> +bool dc_drv_crtc_was_enabled(struct dc_drm_device *dc_drm,

I believe it would be better to rename this one to 'dc_drv_crtc_is_enabled'.
After all, you're checking whether the crtc is enabled *now*. Reading those
bits in GENERALPURPOSE show the current status, not a past one.

With the above addressed:
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
