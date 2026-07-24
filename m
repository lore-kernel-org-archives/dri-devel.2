Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEDDC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D5D10E004;
	Fri, 24 Jul 2026 08:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="HIxtr9bL";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6740D10E004
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baGANeupM0I0Xqzag4eE0bhywz6SserYfynDdL+8iaAOX+iOuN24M8b4I6zlJarB9+mevmtpKNjQ6WtRGEYs7NjMM1/g7AoM7yPUoMIE89m0gGy1++ZrrGtYP8+DyR+PFXPo5qJR/mUpcLewDeWZqq4yVgs9slSLQl48Ifmcqd0lcuo5DT3xN6lBlv4otRy/Yi62DhAl+K2iz3ClXeyolOK2mtGyY36lrf1IgBfBi3/FyzdtKIQrS2b+6wvSEaFzWeMJbVTGD3euKYa0Fas6vnVGhcdDAMATtSMuyEUB1/flvBNQKeQVDgYTVT81/44g9Ai8Sn0XckmcRl/wVNQjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMgKbft/PKzhjUOJiEym5qkhMSFj6rdbnVBxSR5rHBY=;
 b=dHOB1od69E1CKM5NHwnf6j6rH6YZ1acdhP21Kdo/OnZu5OMUBUNQDNU3F+bwCByxrrXWuSOIIXhxUHAtdYyv858A3ZuWT10/LxixIiNy9SQsHdnZVLmlQSoXfZKIueDU9xz8lWwpjlgV7sOg0iVlgtMxGgIOrSOqPCW5eRUAb+zk0RW0iswgTjnsNhcpEXLZM7xzKQoVjznGHH84otnQxoVvMbPx3n3+qI1YFIxbMXBFXwqx8nJ4D7hSxXwG64D6zqrHewZTm9fXrF9Bn0HSU/Qd1B2wb6dpBTNnTRbVc2wVFplCFe4CVdjTFl3xPGT0D7uv96s2CoYFhw5iIlqp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMgKbft/PKzhjUOJiEym5qkhMSFj6rdbnVBxSR5rHBY=;
 b=HIxtr9bLv5wFF7LSK+/621igEqc/x/dgnd4uPQ+FceOzFNnv6p6eRgxFkVv3moaZDOX9nJHIgy9qBd6DA44MHh63ZfSTUBROPa0n8PdT1M84b6zlta3YPghzQorQqIVVpqDYsbjdOsrWvxs6EOvH/gaREBU7bPzM0hovnEasBYhL7qxzcAPRl/wSTLCdobDq7Hz3dwGy193nuCWamOfJqnSOkkhT4ln9SAO8rrbxYh1YJmm/SxLRwGJIlbGtMfUoQoKYG7ktsrwg1ZdTbkgXuI0u9ACy2ks2fJvWGnWGuspZ46cWFCTcm+wzC0a5mlaXnK4ys79Ad21JWL/RewJvXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by PAWPR04MB10006.eurprd04.prod.outlook.com (2603:10a6:102:380::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 08:21:50 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 08:21:50 +0000
Date: Fri, 24 Jul 2026 16:23:17 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: festevam@gmail.com, m.felsch@pengutronix.de,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13] drm/bridge: imx: Add i.MX93 parallel display format
 configuration support
Message-ID: <amMg9cOTWNzHsH35@raspi>
References: <20260723-v6-18-topic-imx93-parallel-display-v13-1-ccf3f9bbc0fc@nxp.com>
 <gvp7mfhjpgon6hju37ebswo5fjkdzio5lqgcdkhq25zfidayj5@kenuryj2sg3s>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gvp7mfhjpgon6hju37ebswo5fjkdzio5lqgcdkhq25zfidayj5@kenuryj2sg3s>
X-ClientProxiedBy: MA0PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::7) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|PAWPR04MB10006:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcf32cf-f51f-466a-d8f8-08dee95c9c36
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|366016|376014|7416014|10067099003|11063799006|3023799007|4143699003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: kPHPZ1WY3sZehgDvyUlUeVo6pQ/4Loe643+R8lzRkfUlNDbPnJw/p+4Z5mc6flPOwOnNAyuF8QaG8lXz8puGzQ6KI9/fTLpy3MUV+v1bld/xj6PZatgPNTbIdX8YsVGVXEqGwuRrumsZn0MvIFbTBYpOFpbS/kX8MNaZyls2caieiML4RF37nhyF780cMutLouycn25e1fKkszBdk66Q1iggSgThq558yHcRyzhx6vKTgL5pNu127Ibnu4V2ZWmrcyUe7xjm3PNy0hrm55lFevYW67+TqBa60OPpkp0ZBUCaVf9SGmSUGgHI1Lg24s2k/RTeDWVOIH75h1jwnCm3EyiahZ7QxBiX4CUxOYRhZpqaFNJy9pJOzLhCZxQM/qrf87b4EhmIewqFcTekAz5fanFXDNZedqZlxavKZE8+xjN3mnCoXgNIaxGR7dcRSw5crhBcGMQFfH/EF1GzPvXz7i72yhQoRwOUZGAMj/0Y+0dybR2Qd75mRE8QiP+rZ2bg3fDv486h8FOOW5VWLXxu2Tc0ArKxAu5t/2PCIacgmaEF42QUyceRRADQxu/RyURjPD6cXatzm4FfsqkttWFTbQZx67wXWzHjtb//7d5dsTOEO7+uJaIn25z0ydZ3zto0QW0DUz4CrB8e/NsNIYUNFeaIwXXQtSlGdnMMjiFscU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(7416014)(10067099003)(11063799006)(3023799007)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6QmVNpstnbZAl3Nj7d+NALSgOXwuj7WruLmdH0E0AwD4Uhr/B5zLGJEK1cv3?=
 =?us-ascii?Q?SgwuKizihed28v6fB4jDbDpL7YipG3INwnRMvc0HRrWUr45UYahTIOIw2c4n?=
 =?us-ascii?Q?OyjDWf6t8K1K2958Ld5BdSU05d0UPGjB3uf7Un/38SsJ9hE9A5Ka9hj5rD8b?=
 =?us-ascii?Q?F0naVdJlo4KU9SPSMiJAW/33WL5oyjU4FjBgvSABiJM1HDCTB3gmOwOJC1Fp?=
 =?us-ascii?Q?Ssbl5N+r4iDIJh5BzUe5ecXa8evRqukpHAxmBUAwP+DA7Oe/FXx5CA2nZH88?=
 =?us-ascii?Q?sesLgEMFDgbOn1NUlBtj0o2CjFs2JKwSQTZ3Y02UZJswSfkSoI2EkMAPf2+d?=
 =?us-ascii?Q?8tZjRO2QENmkQZ93NRf8wlEyL8l7Fw6UCSf3e1gaLysZVTuB99D1Ae/zeLNI?=
 =?us-ascii?Q?XbX4tpwcEYwPTjdK001HreOA/NGsZX2GO+Lo7oZ/aNwPLM39v0RnA+6qpwHo?=
 =?us-ascii?Q?5Suz5iA3oH0PtvGI/v6Eg51zd1GIi8KqKmsB5qKtpEQvaGUvo35NUOKz5c5c?=
 =?us-ascii?Q?HOIHKldkR9d5rF6yw7ClrRqDxk31mkKIzib+DVOyb0GgWVx5EpZ8gvnPkAVl?=
 =?us-ascii?Q?cOOOKYW2QaKpnVLOL2gapNTCuz92wotT4l008YHNIL2DLu2yosiLX2syclve?=
 =?us-ascii?Q?jFkCBnXxS+yiy8o0L1o3QQ002WU+sAYrbNS2hA7IDeoVcyynA/ivrHoJ/34M?=
 =?us-ascii?Q?XyT0n5VijClwf6idkVnUaNiIs+a1Lo2ZzdkhauOvDhUQyUqgI+w4Aone1WKX?=
 =?us-ascii?Q?Q57kivdf2waWPURkHgoSqXkLzAE1axoUCnkNm4Mei70V+jh4n3fiZ2ENHTX4?=
 =?us-ascii?Q?3djT0D6DsexzSCsQehaTvGI8PRW2YMin/1TmoyMooaScXeVxwkMR3uwx9ymT?=
 =?us-ascii?Q?Wp040bc9ZABhATaYaWAKl3NPIFI897Bcn2e/lMM+MUo2Bq3BOR4bREFUVQPP?=
 =?us-ascii?Q?yBwnpx65GPGbIET1L30afv66DdZIfSykqKGKsC0ExBUGcHFWtstWFRePvKny?=
 =?us-ascii?Q?TNLh41zhM+fwAxpsmTY9tRoPzzNClMJCdgIvtrbWUHDRVTo68Tdy8Vk2zUBF?=
 =?us-ascii?Q?U0C8qpQ1fHlLPxi6NY44PVgEsCRx6YsbVZyYEsc1ObQseYTcmUewLVpUQzoh?=
 =?us-ascii?Q?cRyPqgkSLj/Y9DTRDAQULoFSCPuFab1V+q+oERzPb1QJqsYiMMRal4NISiwp?=
 =?us-ascii?Q?P6Vr0Z9O736p1zTlMDpBMfF8Xt2/Ua/BFF1RurNQwZAy+oKFrPP4l8SH1kgD?=
 =?us-ascii?Q?PvkyJHTjqY3y7m5xdsGpAEWd1rAgKJ5dLyU5Ze060jp4UN/EFFStabYe5TaO?=
 =?us-ascii?Q?+2w4Yq2KcFaSsJCxFqsN4cs9kdH1dDzgpFR+DG5lVMhgtYFM4CDXlYLHgq1T?=
 =?us-ascii?Q?ES//XdHmpRChckYTJuPaS8LYLrI4OaZD3uSxIsDT2uxjPGIfsG+W2I1Ttma8?=
 =?us-ascii?Q?iP8sEOE8zgyU6OO4/g2/1XHSIcguzXu3y1mmE0oa4G4VMBSqycpvWC6VbfRC?=
 =?us-ascii?Q?PKgIYo3peMaK3n9tdFs1eTLi+6yiUhidzcS36jAZexZCJQUHAwoLiBtpqJf7?=
 =?us-ascii?Q?UwFoxVd9quc0xvDldgnJxs4n1zrugSeJbBtxLEVVj9aLhz+4CHmgLuDk1eE6?=
 =?us-ascii?Q?Hn0OILosiJs3DWh6emJh2NZnIxkI8cjO1lVZemVUBatrlju6SEN5iyiNXZT/?=
 =?us-ascii?Q?F/5+F/f4Xm/LiAqkAii+ChrOPhjiENt/Q048xkAzAs9zUow0xEk68h+fG+zj?=
 =?us-ascii?Q?H1hqRdo0gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcf32cf-f51f-466a-d8f8-08dee95c9c36
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 08:21:50.3070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yG1e3hlmFbD4RaUsFkOdsqkME08dKwhsh+YPHMhqr/XRDCEXTt0EOYiTKyZLJxFp1CPB0aiVJpT4AKqyNze6uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10006
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

On Fri, Jul 24, 2026 at 11:08:06AM +0300, Laurentiu Palcu wrote:
> Hi Ying,

Hi Laurentiu,

> 
> On Thu, Jul 23, 2026 at 02:37:32PM +0800, Liu Ying wrote:
> > NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
> > configures parallel display format by using the "PARALLEL_DISP_FORMAT"
> > field. Add a DRM bridge driver to support the display format configuration.
> > 
> > [m.felsch@pengutronix.de: port to v7.0-rc1]
> > [m.felsch@pengutronix.de: add review feedback (Alexander)]
> > [m.felsch@pengutronix.de: fix to short Kconfig description (checkpath)]
> > [m.felsch@pengutronix.de: use "GPL" instead of "GPL v2" (checkpatch)]
> > [m.felsch@pengutronix.de: add bus-width support]
> > [ Liu Ying: Port to drm-misc/drm-misc-next(v7.2-rc2 based) ]
> > [ Liu Ying: Add nxp,imx91-pdfc compatible string ]
> > [ Liu Ying: Call drm_bridge_get() for next_bridge ]
> > [ Liu Ying: Reject unsupported output bus fmt in .atomic_get_input_bus_fmts() ]
> > 
> > Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> 
> [...]
> 
> > +static void imx93_pdfc_bridge_atomic_enable(struct drm_bridge *bridge,
> > +					    struct drm_atomic_commit *state)
> > +{
> > +	struct imx93_pdfc *pdfc = bridge_to_imx93_pdfc(bridge);
> > +	const struct drm_bridge_state *bridge_state;
> > +	unsigned int mask = PARALLEL_DISP_FORMAT;
> > +	unsigned int val;
> > +
> > +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> > +
> > +	switch (bridge_state->output_bus_cfg.format) {
> > +	case MEDIA_BUS_FMT_RGB888_1X24:
> > +	case MEDIA_BUS_FMT_FIXED:
> > +		val = FORMAT_RGB888_TO_RGB888;
> > +		if (pdfc->phy_bus_width == 18) {
> > +			/*
> > +			 * Can be valid if physical bus limitation exists,
> > +			 * therefore use dev_dbg().
> > +			 */
> > +			dev_dbg(pdfc->dev, "Truncate two LSBs from each color\n");
> > +			val = FORMAT_RGB888_TO_RGB666;
> > +		}
> > +		break;
> > +	case MEDIA_BUS_FMT_RGB666_1X18:
> > +		val = FORMAT_RGB888_TO_RGB666;
> > +		break;
> > +	case MEDIA_BUS_FMT_RGB565_1X16:
> > +		val = FORMAT_RGB565_TO_RGB565;
> > +		break;
> > +	}
> > +
> > +	regmap_update_bits(pdfc->regmap, IMX93_DISPLAY_MUX_REG, mask, val);
> 
> Apparently, the 'mask' variable is only used in this call, nowhere else. Why
> not use PARALLEL_DISP_FORMAT macro directly here instead of declaring a
> variable just for that?

Marco introduced the mask variable to the code.  I'd say it makes the
regmap_update_bits() call fit into one line, so it doesn't look too bad
and I'm fine with it.

> 
> Otherwise,
> Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

If no objections, may I take this R-b tag as a valid one if keeping the
mask variable as-is?

> 
> -- 
> Thanks,
> Laurentiu

-- 
Regards,
Liu Ying
