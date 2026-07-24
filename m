Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2564C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA4410F443;
	Fri, 24 Jul 2026 17:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iztIZmg5";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E80910F443
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 17:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkYcUzp3wwkk4IxIBaO611igGUjS/arjBKVXNF7XST20erZ7KdrUmFZXN8EUH+zTDOjpQexv0XCUSlEemY+P7CidTWpvrtP7qo9gABezwm9K965ryr6g5D+TOA23p2xkuhM9wWLQFWXwwIXeyCO15bCMhEzw6BOA8ImzjLj0z2bnoPc0ss+M/+9V3M0lBP8VHYv14gVa1hoPThhq0KzM9gsSAfcZTnDp1w/dy7R2vBs6XBkW22uE4LyEshVnHwfQZoHFsJtziWCzOrYTmj5J5SWzAccepxkDPslgJ96iIx2WqtkG/7QB6gh8OJABon3CqI4+YSViwdaDd5QR23wnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+JvtQWFeUfdhPiG5CAfpYlJXUbzdSRsyJMa/rk8u2c=;
 b=h9TIvV7qKPuhpsjOtoqlxTTlhGoOVg+nDLx2adfYMWECU2l5ODKTrq2ikrS/7gVooq/1ahgVaXw3lLmcD3IH89MIPQCAgFG6iqa3WpgaksAVcY6Lz3EF5GFVuf9fYlOXX0JOE0PLp/p16hNK5+ZEDAxA4TLyzVrdKH1oXCHFyvULUdmOzp2EpHc9m9ygZEzbA5rjhZLD/LcP0GF9foE/rud9Ou/YDLBH86UkObLZf9qIpZF9upnD/CuqWrS2X5tHKtEt23a41YhqDGA5RuOAxNkVfkwZ+ocgCWaZcGlqNg6+3u0I+6P/jcuU0aA+hsQ0rDlGe0cvf6o+wgSfmeOpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+JvtQWFeUfdhPiG5CAfpYlJXUbzdSRsyJMa/rk8u2c=;
 b=iztIZmg5/Yw1XjlM0LsIhbjzH/2HAvICTVYBYRShcdeJ+wNdrTXTTYfTbPwS3k29FnbsAwc1B5b8AvhYbXqmRmjWykzzigai20yCEqR4/5dIqJzUnh+CkSNncUQH1u0GnLyKDsE7imn9KutHQATEZaaKWXa+lfjFF/QNqrJ9yJGK7F/OpEHsB+lgb/EKBpF4cRuziDXigpGQtSHg7DPBIkLOYFwk46PldX3G76vJgDCqWnW5+Uv9/owv2Fuu8V8xdRHnkEdsuZxhExKqMlkaM8vDvJ6Ivm17kzy2ZpfnacJNtvnYSTuSD/p3gfdeuNYddn8RtnO9NVXQTIfCzz5z9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by BESPR04MB12610.eurprd04.prod.outlook.com (2603:10a6:b10:ff::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 17:02:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 17:02:11 +0000
Date: Fri, 24 Jul 2026 12:01:59 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] drm: mxsfb: Add optional DPI output bus-width
 configuration
Message-ID: <amOah-mILi_y32rB@SMW015318>
References: <20260723093813.180089-1-francesco@dolcini.it>
 <20260723093813.180089-3-francesco@dolcini.it>
 <amI3mPBVXe0zj_tC@SMW015318> <20260723155332.GB4453@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723155332.GB4453@francesco-nb>
X-ClientProxiedBy: PH7PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:510:324::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|BESPR04MB12610:EE_
X-MS-Office365-Filtering-Correlation-Id: aeac41c0-4727-47b7-c926-08dee9a54dc0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|19092799006|1800799024|23010399003|18002099003|22082099003|3023799007|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 5PL100StD+mbGaRPZuSqeRW39CBVsFGP4cJQi9LJrPxDQTXCTAzqvgKMcwL72D3nJyXpXUvqk3D2vruy17y7qXqR58lm9YDs6QlHdj3k/AkyKBRB5fJAIHQ03neFV58lP1poAF9OFr4/ZXFBN/8pKEbkDYEErr94+27aZ5qtPeORxEymIixo0s1QYTAhEWJZ8fvggUOboFjFjOdhYxdjn6dPiWH7PA30Rxk66zzFHbkPOgkW8VaJEUqhsePEMRuoF9ewTmb29VwNNND0Tlv4pZKJ0YjBOz2W2VRoni+XuCjh+zcw+GgvppNTvQ2wxQdTZNdp/srRIUcc8JL16aqY5qmJ3wE1IqqTVQ138Iru+sdUuBeclrSQjm1rX63s/OBug5lHOuLjccgtF3vVb632hsIAiFA3hqAvIxUlzh2b24jXSNR0jRuF6iw/Pp0i4Dr/TWfFVmV1bFJUso/wI/bKjNrfl+BDpjrhaOkFl7P8u1IeXSGNT3GfYoZVUs8O/+Uo2dRCpsDrddy/ol5oVm16c8g4CTAkdwWi9ikbvTavwvRDKfa9XgXWTB7ULTqUA88pkmZ1uubYIfvQ+vrSKSbtd72ClkOyHOt9Ee0DLExlwMqdc/XLqI7Pzx/SqqLVb6K6BZi4527yI/txE4rxFg6VAyuiDRoLTfOjewLbbNCIvcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(23010399003)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wC59Ex0z5901i8xoRmKqsvuPGPnNv1b/+HZMMNAxroATZLPUHuK/cNMmHm87?=
 =?us-ascii?Q?wnBYVT/zL3WqabpFuAbvl9GvCM3d0wvC07DR/jTwYpnVCmtLYkjug5YUSMo/?=
 =?us-ascii?Q?1hOzPVuf8A1IH0uJNnabytdJyUEI6/UfzdmfdEi8jbgLkhyxTWuoysq38tee?=
 =?us-ascii?Q?9ag+wa0fZpu/8gZqTfWp6W+RSz2Q2ivLPv5Modu8ltoWKVW2GsLiEQIeqXMu?=
 =?us-ascii?Q?7P0Hxu3ZuG4HoH2+LFcbwoDhtR/f+vDHN5DEY2xqEpuxXF2oFM6D6mvcLME8?=
 =?us-ascii?Q?H/GFpqHyyg7C5qP3XV/+EvEWgaAHiH45Pd//28zKgi9ebkh+URbFbr2Z5eru?=
 =?us-ascii?Q?BFVLeqSji4CLHFtjsalm6C7XzSV3RGFSXkis03K86U8nm4hzuLdB+NBZxz/L?=
 =?us-ascii?Q?MKVhgKmZrXy2h2Zn8j0RaBrAng1FYupk9Rs6lhbSOjk4HWmZYKoCQcR8v76g?=
 =?us-ascii?Q?0o4NiTBAW/d7IpO3x0K5iG9TFoc24qcedOZ2zeTqa2sPynjA8mDjz6DrifW0?=
 =?us-ascii?Q?KoCJm98fT+21lDK392h0vMZS8MkRtn/I6IUC/jbLWhXATiK7C2kp0/RaKjhc?=
 =?us-ascii?Q?ZJpW0ZnucVcSojLU/Ls1mcdQmUfkMIeIRBO+hC7cYwBx17AE0MRDp2L97opx?=
 =?us-ascii?Q?YGx1IidyULmfQOc23A9yZF/olwEKlOEaIniz/fBs/aTZaS49xIUPlIWmO18q?=
 =?us-ascii?Q?ivMFfaDzjbzc8auVtsRkzHQThhZ3oioBhMUb2xDrTKwI+4ccacYwLo0t5PZ2?=
 =?us-ascii?Q?8M0AyJIRD5mhvrN0H5f2+D/DYd1EGnLnPIVg+jVdwCclYckC4jdsU1E6ba3S?=
 =?us-ascii?Q?gnqvCbiki+i2b18H5d/r7lFSooN+xIG7iz6qRw9c7C0bwSAOWVvXCDKIkaE+?=
 =?us-ascii?Q?X9fzBLqc27Gty2Bov8sK11Zro1iVgO+Jv/7yKSK7S/WSLrGyvPIIsV6Joosx?=
 =?us-ascii?Q?ZCH8xCMCbJ6liJfKT5hKo7kN7Szs9l701hj/+kiAPxY14401WeLHv6HOA+dU?=
 =?us-ascii?Q?kn6/4d4Hr8enn12IrrCNYI2DffBNLW9OUuFuuUrL5fK3xsIj3oRmGuQPEgG7?=
 =?us-ascii?Q?sYQlzAZInOty7DON4JUccqQBfpNCaBab079+P9oyPuSusgOhSnzmntmXfLfh?=
 =?us-ascii?Q?YWbHU2PtGy22kE6ooua6EnNaYXjADJ7/weEBCWtaqfl4tdb+DNeys9SWUVkx?=
 =?us-ascii?Q?QYXyCRER1nNj/Q11PvI0Wi7zWMWBeaa1tJ5dllR1qclZ+w5i0TsEVsB7vcKF?=
 =?us-ascii?Q?oq11GB0UD6MCL65I1CftZmZ/UOPq5jyhtoRKfGPkiSmavE215wD9uP6tuS8A?=
 =?us-ascii?Q?wYG5ZXmHuvP2J4W69QY+UxsmHqIrUdQH/mZwf2+ClECW2znJ0bpRewCMm2s3?=
 =?us-ascii?Q?LgHVte5X4ygs/OUffx7PvKlXdqAM2JdYniKlfVvprnFa8emOdMmNzHfyeODf?=
 =?us-ascii?Q?QQGY8M1ZE8PeDVLfgD3HVLagfQj2AXgA7MlDweFcOMIaZB1Yyo8qe3Al/e+Y?=
 =?us-ascii?Q?smDfB2Lir9TsuC8pcwaZF7mvj0GV+7TR9vpcq2nkcZ10tZkFxmup4O7z2WG2?=
 =?us-ascii?Q?NeMY/QccF7z4l4AHywsLBHvRNjthy3VIuJ+oNd/FGZXdX2mFBlpQxExZ+4Rc?=
 =?us-ascii?Q?Nm5RUhxcEqGNyqZ5nC7qdEibPJMwAc3X8Gl2zG30Xgg1lLksHL9Sl0bQ4Awt?=
 =?us-ascii?Q?uYMgge1MsN4L7LP5QmVMpSH03Y9hHmA+5G0zJEKvAQMz/zrhKAPEMN5yKYLF?=
 =?us-ascii?Q?EloK3uhgnZHxEuDKmxiZ11+bZyduR90p8GLMSHcaLGvgklfGoIhH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeac41c0-4727-47b7-c926-08dee9a54dc0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 17:02:11.9050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvgNDF+DTtDeoVKACXWn0sujvc8oO3Xh63o1Kt6A1bidp1LiyoJNIMgkn+Uz6gT24+q5WNTIIJC6337Hf3AAi0QyZStVSYbcgupMJ7GH4AgYZ0wqoN320C3Tt5KMr9jS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12610
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

On Thu, Jul 23, 2026 at 05:53:32PM +0200, Francesco Dolcini wrote:
> On Thu, Jul 23, 2026 at 10:47:36AM -0500, Frank Li wrote:
> > On Thu, Jul 23, 2026 at 11:38:09AM +0200, Francesco Dolcini wrote:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > >
> > > LCDIF programs LCD_DATABUS_WIDTH from the selected media bus format. The
> > > format reported by the downstream panel or bridge describes the display
> > > input, but it does not describe how the LCDIF data pins are physically
> > > wired on the board.
> > >
> > > These can differ. For example, a 16-bit LCDIF bus can be connected to a
> > > 24-bit display by wiring the available color bits to the corresponding
> > > display inputs. In that case, using the display's 24-bit format to
> > > configure LCDIF selects the wrong data-bus mode and changes the assignment
> > > of color bits on the LCD_DATA pins.
> > >
> > > Read the optional bus-width endpoint property from the LCDIF output port
> > > and use it to select the media bus format used to configure LCDIF. This
> > > allows the LCDIF bus mode to describe the physical interface
> > > independently of the downstream display format.
> > >
> > > When the optional property is absent, continue using the format reported
> > > by the downstream display device, preserving the existing behavior.
> > >
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > > v2: use the common bus-width property instead of the legacy interface-pix-fmt
> > > ---
> > >  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 24 ++++++++++++++++++++++++
> > >  drivers/gpu/drm/mxsfb/mxsfb_drv.h |  2 ++
> > >  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 12 ++++++++++++
> > >  3 files changed, 38 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> > > index 9b8fbda85d28..0545718a4b65 100644
> > > --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> > > +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> > > @@ -12,7 +12,10 @@
> > >  #include <linux/clk.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/io.h>
> > > +#include <linux/media-bus-format.h>
> > >  #include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_graph.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/property.h>
> > >  #include <linux/pm_runtime.h>
> > > @@ -209,7 +212,10 @@ static int mxsfb_load(struct drm_device *drm,
> > >  		      const struct mxsfb_devdata *devdata)
> > >  {
> > >  	struct platform_device *pdev = to_platform_device(drm->dev);
> > > +	struct device_node *np = pdev->dev.of_node;
> > >  	struct mxsfb_drm_private *mxsfb;
> > > +	struct device_node *ep;
> > > +	u32 bus_width = 0;
> > >  	int ret;
> > >
> > >  	mxsfb = devm_kzalloc(&pdev->dev, sizeof(*mxsfb), GFP_KERNEL);
> > > @@ -236,6 +242,24 @@ static int mxsfb_load(struct drm_device *drm,
> > >  	if (IS_ERR(mxsfb->clk_disp_axi))
> > >  		mxsfb->clk_disp_axi = NULL;
> > >
> > > +	ep = of_graph_get_next_endpoint(np, NULL);
> >
> > use auto cleanup
> >
> > 	struct device_node *ep __free(device_node) = of_graph_get_next_endpoint(np, NULL);
>
> Does it makes the code more read-able or better in this specific case? I
> would say no, to me it is more compact and clear the way it is.

Recently there are bunch of patch to fix miss of_put_node(). auto cleanup
help avoid manual to manage it and let us to force key part.

recently, perfer use fwnode_graph_get_next_endpoint() and other fwnode_xxx
node function.

it is also okay to keep use of_xxx() to align existing code.

Frank

>
>
