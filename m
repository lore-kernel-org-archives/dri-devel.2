Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9507C4452B
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 00:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 390DD10E27C;
	Wed, 22 Jul 2026 00:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aswCAvJz";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48DC10E27C
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:05:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB7GYCR81JUjUK3m/2EQbJ+UiQ7KfmoOm9lcXIpc6njTrI4K5HvUcymNtipQcNGL1WnzO2OSlEgsv2940l6n89uGTxyC7ZCGi9LAg49czswaHdE8Y8wi3R3kqDPFCT7z7kbC5PxDInfnDHNtszAjuQiFwN85ChpOcBxjoTHL/zn5JovOnAzU7QNHUkiZ4BILSMOGbJz2cnqAhH0RFOKf4XGYtXXlKiqKJ0Jyn2QqkZokioi6vu9xkEtAl03xqy/e+7IKQryUWSVY9XhD4vfwAyXmq6RckBxolnPoP6h/qOM/2fwp6WkyTqRm7Rfsk42M4axmnj1Z1n4crcq+P8hYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toWkJN/c66avFQrKLM7pNdxfiQk8eRZ7icrlTVm/3hY=;
 b=Rbkq3Wxmz+QHPsWvCE5ITxf8TCjt6o4sHO5aWxNPh+KhJO8soBc6IRcLpMDCwqx7JkCsvr955SazCgTtJH7Q4s6fnh02IpjbGAZKkBxIqSXhszhjX9fxh5RKWm1C5kXSjCLrOVeqqCRy/iwKteJEGH96V3UGGP57QYHvievxHiVksXcqV1LOYyrZzk3BDn8ZgeG/KhI7+8MxAvlTEz8xFbFoFfMsnNGKqbtcjCB5vLT1A5SedePof49pWoMTwAcvKsrvYPygieSc+rlztMDaqo8krYiRsbmQPQvUIS21TbLytMj/DjnGCGMg5Onboj61z5rNVAXnnlSidZYNWUmWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toWkJN/c66avFQrKLM7pNdxfiQk8eRZ7icrlTVm/3hY=;
 b=aswCAvJz5WFcVb1UmLdZDZqSTyqy+402ZHa2NCeHvqYKhGMVJ5mXuGisa0urlFfiSuuYH0xMAAegpP4bH7YqTiOJMZyxVsTtOgi4OoLTKis/743wLtqIgEMiiNwimFh9KR/7SdxSaL43jMrRl/yojWqGMRwbz53qtX/GHnlQDqrlS3qTacdWEx1gVitP127C6chvCGOADaRj7ycqaiUmbXiVvPySHeAQe9mIwwRvas91tZw0cVIV6O7J2fH9mrgUoO3Gp9x1meXVFqd5h64BA8agkkWLq6SZKevONIbYr4+lp7qzOYmq0wSxRl10ylu/BaW92Ka1zRMyDtlHDiuZkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VE1PR04MB7359.eurprd04.prod.outlook.com (2603:10a6:800:1a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 00:05:17 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 00:05:16 +0000
Date: Tue, 21 Jul 2026 19:05:03 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Robert Chiras <robert.chiras@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 3/7] drm/panel: simple: Add waiken WKS101WX001-WCT
 support
Message-ID: <amAJL9TIcDAK7kbh@SMW015318>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-3-da797562636e@nxp.com>
 <alnCL7ylMyvGD-ui@raspi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alnCL7ylMyvGD-ui@raspi>
X-ClientProxiedBy: SA0PR11CA0186.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VE1PR04MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 04903307-522c-4a25-22d4-08dee784e8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|19092799006|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lNVn+atDExTHZuHHagXdFzBXLbhVPDUjs9gz2rNfE3hG0o7+nto9J+e7Ln5nfpdCbwMuvGSTsSUQ1Xwtn+d7ZTiXvmBOZJCui4DKNulbGAlkSzyZKiK/rVNVP66JG9tmFr0Qht/VRKiz/7StHlAv7S9OGnSkORT/wLeBPyvCC0NHwg4CBHetOuSCdSfiPUmGYrhFj9k2VwAyhxWBiZ2xHkwdXAZI29fDJH+kRILM86TU2QDpduWJ5NLEsmU5Gyjjhsi5/qeITDatcrGC+TI3pcyBcc2AG4wIxHxYkHrtPW+LShVT/r1Ki9VFRqePVRrX6jBbSGtvBDIyh9i/2CH93mWZiod4BxOymNzEyR+T9JAMa0xzAyKkyyHr+DQMUmt1JVMMFmpod0WzsJQNZ6S8AVd0gn3Y3vU2p5uMRvzkjwPZ4wQxysZ3Fq63NVleIO7dL4EljmE4X8HuslscvoEYK2Yg7DBfUoPe9m2fkvbweF6M/82lDk2c/Q2XXdezDjWk187tt3lPP1nm4XCg1COzb2qpbXGRSBWCvm9H5muVnECGX09Znws0oU0iFOCCrS/279M2f4Q9x2rSDNu1PZwc0UuQBZaVpeExP7IP3wLVVr36fe6ww2sMfV4aDZG5tCds4hhQygwgMJ6xC+IrUaGOA9s1EgCOea06zhhH/4RunKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(19092799006)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bmWss3XpY2BfDzKW0VfTU0c0mesPrt8Y3mw7XgP/YOTbRonDkBjvZxWtI3MZ?=
 =?us-ascii?Q?76Kej3j8Zs/IlmYsaTLRg51t6RJDfhv5FgTJhUKe6sZSSmDammpjLO3G1kKL?=
 =?us-ascii?Q?IAwl/OI10EBClB3EH09zaQSxJT/S9AxRnuZQr7y7uqA9ldux7a93H+NmxSoX?=
 =?us-ascii?Q?qov7zYtosP+m31Jjb67E4a4QRlR/NX0eQ+k/sB2V9VK3TkKrNY6zl+379il5?=
 =?us-ascii?Q?c8e+syAa/DKKB33wLIGFLtADoYG687ogrNUEi8KsYoXq/9Iien+4jn8reGKV?=
 =?us-ascii?Q?hCrYgbkO+u+WDxs9PO4MU4lqII73I1gEWs3EZCZeqHBDNPIP/tS+DPFjvpiR?=
 =?us-ascii?Q?gttWtoewvE1Knrn4130vbq5jSiBIqonkurTWo2h4u9ZhHErKhjPxhCN3Kum9?=
 =?us-ascii?Q?DIgedDDuQwUv3u/vBc95s0tEY+a6ZRWG2snYRDJLE+8qpMU/+AsdCzLiG/N1?=
 =?us-ascii?Q?wVEEnjoEiLDyDAdqb6KKc9q+n8p5fOfjAKew/Saf/d2lLBx5sJyCdKjCgopD?=
 =?us-ascii?Q?fGPY4dTx/fT8PV8Hiq1xShgSgIi2m6bUFcn5Sm6islds+khQLH7zz6RX/LgD?=
 =?us-ascii?Q?DpERI6iFZk+2N7ZGreie+F3Jg5Im3OO/a1OVii/spWYAhm+WsDvMRAyUVpej?=
 =?us-ascii?Q?ayigUcqlspBbq5IZWs7IWiQXFXDu7JBVDHBRUTfbSM07rML4WGoPJJDcBKo+?=
 =?us-ascii?Q?48NNNJLqJQ2jaZ9bk2CdxyR/88WZEAkNa8rgjCh/mslq0x+SKsLV1wMoBNDW?=
 =?us-ascii?Q?FhevoIZW/W9gGA2K7urGPAafBru9tCtOVdeBRAoNxcW9/t7qS3F+gAHZrrtb?=
 =?us-ascii?Q?yKq3p8hbgd2SgryrM8kRmTg+OmSewQMsDUGFYQI6zYE3sMCe3DvawJe/RUic?=
 =?us-ascii?Q?AU9kuDLejZvl9XqIzE3sovVfQlfGAAXvGCkD20D/KrwjoC5oZXgdEQyUiG9T?=
 =?us-ascii?Q?s2ZVaCw54KLgabEwjuzGHa14EQv4UWgeGx60XGERGKljHAu+LM+CllSf8T/Y?=
 =?us-ascii?Q?bk48xIMEJaWUHu2wMuTTjn5tzPI8fsa/dQLrhhoAXZ4DxHTscu18XB/I431G?=
 =?us-ascii?Q?9XwrmlIo3ZpO0xTxGA4jIqrb/Wh/pysToqr2ZLbLYg7bNI1pYmKvaph+JZng?=
 =?us-ascii?Q?hPAg4Wutuk41ynnQjbCkVhO4XPM44CMwafGTJjAP7wOC0IcN13Gf6l1sgIWX?=
 =?us-ascii?Q?82zGEW7n17piAiXxiArNbWZXCSIL0hhgONiTnj1N1MxHbv++USMv4c5NiI6E?=
 =?us-ascii?Q?oOMZsVSbdjbNnpl7M2/m0YcnU6C+hvtr8MGXLZrXUu5qG9zU9e7JN2d9y8tg?=
 =?us-ascii?Q?p0HDbSY3LJchnRd0gfIawT8kvC5/KOeY2oOHG5upgFGcD7KwkWjAAnn0DJHp?=
 =?us-ascii?Q?G0Re8Pd51FcCxqRJBXHv/dBCdKXpzgVQCVAZkrr/Gpp93zAbx2Ud2NN71lXp?=
 =?us-ascii?Q?PlZUA0gkzzAg6Wixnz37iV7rdwMR6Dp6L1QwaAa26KfxogymPETVfpM2FXf6?=
 =?us-ascii?Q?be/xble/2mR3j+gplqJ2bJ7qSP5IHl9RP87gd33NHWHLUAaJXZEcb16aPyet?=
 =?us-ascii?Q?UsF5P/UqDAKIKMhfP23/3016CypQ2f4KAzOOz6OjPsIf/teei4StZChEweHk?=
 =?us-ascii?Q?49d3pTK1gWR408bSdXt8qY3jrK9f1E8SpgPqeMt0rDYA/iURThBM0H9+ybop?=
 =?us-ascii?Q?DqR4nYwRLTaAMfbHvaVs8uVUMVhvV/5Clg3agGoNwTdCuEeCX8l4whVgSGIA?=
 =?us-ascii?Q?PROjarHBoCRdxXYuei0FCATK9kSQzPHxHeHH0gBhlHoH7575MUdp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04903307-522c-4a25-22d4-08dee784e8f3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 00:05:16.6125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kH835lIDn0HF7uMUqzNg1dfYOV4KGP0nD6oQhG+/hUt3GgWC+aFBovbXbryKvgZr7n+NoXsYkMOLG6BceViA6DSzMB3uRdwKilY4O7brQRJE84JjOAqIpF+uebivjwY8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7359
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

On Fri, Jul 17, 2026 at 01:48:31PM +0800, Liu Ying wrote:
> On Wed, Jul 15, 2026 at 02:34:48PM -0400, Frank.Li@oss.nxp.com wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > Add support for WKS101WX001-WCT panel, which is an industrial-grade
> > 10.1-inch IPS TFT LCD capacitive touch screen display module.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change in v2
> > - update height to 135 from 136 (sashiko)
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index c09bf3db5e78a..73a21303a612a 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -5171,6 +5171,34 @@ static const struct panel_desc vl050_8048nt_c01 = {
> >  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
> >  };
> >
> > +static const struct drm_display_mode waiken_101wx001_mode = {
> > +	.clock = 71100,
> > +	.hdisplay = 1280,
> > +	.hsync_start = 1280 + 70,
> > +	.hsync_end = 1280 + 70 + 10,
> > +	.htotal = 1280 + 70 + 10 + 80,
> > +	.vdisplay = 800,
> > +	.vsync_start = 800 + 10,
> > +	.vsync_end = 800 + 10 + 3,
> > +	.vtotal = 800 + 10 + 3 + 10,
> > +	.width_mm = 217,
> > +	.height_mm = 135,
> > +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> > +};
> > +
> > +static const struct panel_desc waiken_101wx001_panel = {
> > +	.modes = &waiken_101wx001_mode,
> > +	.num_modes = 1,
> > +	.bpc = 6,
> > +	.size = {
> > +		.width = 217,
> > +		.height = 135,
> > +	},
> > +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
>
> I find a panel specification in link [1] and guess it's for this panel.
> It indicates that each color component width is 8 in 'RGB Input Interface
> Description' table.
>
> [1] https://community.nxp.com/t5/i-MX-RT-Crossover-MCUs/Optimizing-eLCDIF-throughput/m-p/982741/highlight/true?profile.language=en#M5348
>
> > +	.connector_type = DRM_MODE_CONNECTOR_DPI,
>
> Seems that the panel also supports LVDS input according to the specification,
> since it mentions 'RGB or LVDS Interface'?

Need hardware rework to use LVDS. Need remove banch of resistors. Should it
be treat as difference panel by different compatible string? hardware
actually changed.

Frank

>
> > +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
> > +};
> > +
> >  static const struct drm_display_mode waveshare_28_lcd_mode = {
> >  	.clock = 50000,
> >  	.hdisplay = 480,
> > @@ -6155,6 +6183,9 @@ static const struct of_device_id platform_of_match[] = {
> >  	}, {
> >  		.compatible = "vxt,vl050-8048nt-c01",
> >  		.data = &vl050_8048nt_c01,
> > +	}, {
> > +		.compatible = "waiken,101wx001",
> > +		.data = &waiken_101wx001_panel,
> >  	}, {
> >  		.compatible = "waveshare,2.8inch-panel",
> >  		.data = &waveshare_28_lcd_panel
> >
> > --
> > 2.43.0
> >
>
> --
> Regards,
> Liu Ying
