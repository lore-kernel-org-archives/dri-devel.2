Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059B2C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52DF910F343;
	Fri, 24 Jul 2026 08:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sS1EoKlG";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4CCF10F343
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:28:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNA8yfKednr6ls6DXjDKX5Cu3Bgphw4ND8IwDrehqZ5au9XmWcgBfcncm89Tvg/3KnF39lcAxHBO7mMIoldE6DqbDTCoAEyy/TfDHoukea3qYhYz++1YCNclUxQ7xrVPg9YGpcvgFWiWpCCXJZajMyuPq4Xdi3OU2p/JNwDb0PzrkcEwvuU2rplabksq0H/YfJXxAVxRiP9FFNtJj6UEHkZTooSrf5ZfWiPKh8g08rMu30vOnazntL7EuvrRjmvun3W/zGr6iuJ5Mo3jLhS+GAsXstPzmmUOzDSaLXH7VF/03si5aK53nLHLgruxoUESOWaqkBaXYnaV/02fNwr3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DJFF9FH3iniYoHoKXNcBfeY6CFfhujls+8wWOhTmPQ=;
 b=N/zB7az68Cf4kUk7Myho5075cRHndIZ57+wTQyiS3N9raf8IfyCTmx7SJc82PJ6iiN6HLX+/34edcTbiPOm1mIkq9uX35oHKBb96wN/bftN6PmsDiqnAo39ZcQ2vLpM/VBSfPRNDH1F0n/tL0Dj1iZ1kyj3DxgUBhoZzr6ytrjAar8vrzhQ8AVH3dYdLhMEvlHVKNz9dzac9e/McYrUc+//1PszY69Ng6Z5My5gOFeNOm+mATU9wq5OqtABYbrgWQKzhDI9XasTTPb7FwrUqG2Dm2qIej1XRGf5/wgeHEfRTRS9UupPQRS8kioLy7mJtAhCg+E6wdHh5x0IyI/z+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DJFF9FH3iniYoHoKXNcBfeY6CFfhujls+8wWOhTmPQ=;
 b=sS1EoKlGV8wRdc8NuBBsb9V4s0RfDR7gboySOfVL+sUKcGGCFxFrAKmSaM+FiDzYwOnnscNxUm69anIuBXWququ2PWbfYJwrqC0iIGFQZUm6p+tO/QKEPvAezVkGVI61aIX118pdeBmRNnvUW7pAg+rASG1ymq8VIsO7QjL+P60eh66/gptwvhxQhHlLZq408mrsQl1V9Tch9VrHS8KdxQNkOGf3nQCzW/J/us5qlNFKkL6klvRXdkgtzPabxSA5aRxS3O0S68p2Ik0vyycG1+kxzVZrVu+0CqamPhzd+G32dYE6d2Mk6dFSkvCn/2iJ7vojqIN5Oz3UrEUJct/bdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 08:28:34 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 08:28:34 +0000
Date: Fri, 24 Jul 2026 11:28:29 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: festevam@gmail.com, m.felsch@pengutronix.de, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13] drm/bridge: imx: Add i.MX93 parallel display format
 configuration support
Message-ID: <yu2tu5oa25hwfisrqrlnkonmeulz7mmrdunmsg3dgzulkw3gbb@uq277wwirdae>
References: <20260723-v6-18-topic-imx93-parallel-display-v13-1-ccf3f9bbc0fc@nxp.com>
 <gvp7mfhjpgon6hju37ebswo5fjkdzio5lqgcdkhq25zfidayj5@kenuryj2sg3s>
 <amMg9cOTWNzHsH35@raspi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amMg9cOTWNzHsH35@raspi>
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|MRWPR04MB12330:EE_
X-MS-Office365-Filtering-Correlation-Id: c5cc1c58-e6a1-4b43-4d10-08dee95d8d17
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|19092799006|1800799024|23010399003|366016|10067099003|11063799006|4143699003|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g2Gu3RmusL1/K0moWhm0HUZ7eUutg1jWLa7S4F3Ii/g9X9svjhBfgWG1UyYx71GUgsK+KkbrNL7/G6vuqs6K9D+YcpAa2mTlSwEhA5bgQXsuWjbUdcWtPGpWFGLZ+S3UrDM0pw9ayF0vb9FmFg4vKd7m1oMoSL6MMpCUwPEAc8XXl7zyApEpO5l3dc1O5uPT4+2dbSI4qZyJxlx6Ox1vS8JRntbil1ClcuSiy+g1O18tKgemIo4b3VdOy21AeASZu2swnl7HVax8cy3pGzxQ2UMOdzVxnvG/fvzxcDTA9S0U+LyfRPrhZ55NvLK7VKl6cphQ7QdiKRWv7TglC88pwiHic3fOqUGGwQMuOAqSqTDSuaAeb++BCt/jLZ327tZvaG/9G8HQEHeztJR5ykvH56lRS+nzveQOSjm+ZaDnVA/VEzBUhEUUHJaWF2Wk2I6HnNPaYlWZjcwepZ0DqP5sJJ2RP2fozItdiMYkqiPWGtL+46tIp+8+nWcpfj5A6deARI6qIeEEfyqghUCgqkSKRzTp0X6QFwaBXbMQGGku0ufXrxOh2CLEPPGeJJz3B2j/+u1LXV0rFrC/iprlgAkiyAAb3UrqH5yky0VnQEMrGn4Z+oU3wJc5DxWr5HNjCT+Fju/JmELh26ulkaSfflqvT1IpwXFFB/gMojx5QVjkqcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wxrHusEqHnGq98DtW3UkE682skysTkEhCtzfNUvwc3qS3Z8bRgPlFJZrd9j/?=
 =?us-ascii?Q?rMaFAzhNqG/dGz//V8LgAJdC9w9v4ZKoFOv6XNKAUjIVg0LE2oy54W12zO74?=
 =?us-ascii?Q?v7zHUS7Z4MkRuZaDrI90ChjEJLRZ711tu5+Jl4N45K8Ir4XwtNbVet5O125U?=
 =?us-ascii?Q?BXHtOGRTVW2IxuOVNI1yr/Fl4VpYyvHmt0s0U5TwBTIJOQpDbbUtTrvluu8z?=
 =?us-ascii?Q?rq/f2N3ulFQCPWqJ0lQem9ss1bSvRAr+jAB7uP/++TWL6LyAGgA8MJkcmR3s?=
 =?us-ascii?Q?2D4QmwDWVLcZ02CGN5ya6ziQ2x7QxeCbBLNeZqPOojo6oFy4cY0P5o4ArFmn?=
 =?us-ascii?Q?fOtyjb215ZpAw2EdyTADW66CcPEO5jgkgFHy4DlDlYKaMasAZVBpph5330qX?=
 =?us-ascii?Q?5Uyp0pPUKUG5R32fzdIuaAakYIfVmFJRhcSz/E8DvHr9nN25Z/TqymjtyPcB?=
 =?us-ascii?Q?PTq2U2VhD50riQKTk99dMNXdODpTQMWxggo09voknOASHjobEXgAaXp/2xWp?=
 =?us-ascii?Q?vOrr7m7umMjAzxYswO73UsHKGzBqMjhwMK6khLkXuCAxuzarTxb0xD8ok94a?=
 =?us-ascii?Q?DbNxxvsyBIJwxxcNzB5PjVh0zaTgUiYNJi55U4hrGhn3Lk6l5BipqMoiAcOV?=
 =?us-ascii?Q?LXLuXTXO5smskfmvot14UQQhaqhmecUSBsUvGTQRS160bruw7UXwCfrkbpu0?=
 =?us-ascii?Q?Hhxrhy0GrkYG4HixzlCfGPifDCtKXef1J9HCOOJn4AZ4nwQZtQ2LXEn5cEbN?=
 =?us-ascii?Q?qepGOG7TYPBIhKaJEJQWCfYwOjNo4IywMUJTvmqb8HPS50WuwBBJDpAkmC7a?=
 =?us-ascii?Q?OLTq0aqPyB7afOj7tSOpc+/nrLiTPW/Mv6VwUbu9475+S5YSTj9CMP+jVLZD?=
 =?us-ascii?Q?0z5PnmNl0krNfetGrNXbFimYMK9MT/CMik3HJSKQlA9Tk+d8C1gIvYet5q5r?=
 =?us-ascii?Q?ZDA/4OH+K6hSUXFBOPtXHZu0VVHJdNhbx/GYEn3PiQ4gPRmkLj4aLImWpUwT?=
 =?us-ascii?Q?7oIOSTwY2bM6et21hi0UMo8fRhxPiWntnIVuuf1e0QOl4OVqSSakm5X0qtuv?=
 =?us-ascii?Q?939ISoBRa6fzKFZcTxSB5IdcXJAJftOXW/LkM6s/AHnOvnSDAglZhkvBQrgC?=
 =?us-ascii?Q?6TVe6U78QSsm2pLFHakU/60iu/hdcsvOVPDUV0A9fy1uwFuyc0u1Cd+TyaCa?=
 =?us-ascii?Q?bQn4Z23McITs6/7QAqDg/ctuWIfN8JVRygn7iTT9TdT1ckxYnx96wsBrK2UL?=
 =?us-ascii?Q?7JMdNzllbXDRCRlVVMX4hgAdPssQz9+Ugx/lQ2CpeAPXFCcVLEf84pzFJFQk?=
 =?us-ascii?Q?qbMtcmRyYtw8w72NDu1YnzCA+4u7kLBjv5/73Yar/CkNbVNr6W5qekiRxh8j?=
 =?us-ascii?Q?hCitHtjbOtmR75dyhM54d1SY0jPPb3hA6uTXMPDVuvbGUpqSGQV0XGhPKSVI?=
 =?us-ascii?Q?MzKZAi/fQYf4CnIIHoiZZpujBx92hbKSo+kL167FxvhDixkEpU39UIB1WY15?=
 =?us-ascii?Q?rMlbafLCkQSV9CpD5Ms7Uzc9QAWpKZoCPmwFz80IRMf/FhcNXoe2BaaEVkcP?=
 =?us-ascii?Q?QMoCNmzqWhe7qruq6G591Mtxa6E4Yq5oOw7mfGEwnVVKrRjxxkOg0P8h4NF2?=
 =?us-ascii?Q?nwuK6MNlE9yFUHP0DH8u7WkcLZN9k7qR1UjSzSpUFf1A50El1g8Be0nRItGM?=
 =?us-ascii?Q?KjH9+1YPRMKPnXhRCxWE9g/cRQdHaHBawzy2wI5pVyP/MZz9JJN/HWajQmje?=
 =?us-ascii?Q?ombOZoJjomrMy1nf3QI7iONxyvpKBsY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cc1c58-e6a1-4b43-4d10-08dee95d8d17
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 08:28:34.3589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04nUd4JjgZ+CVNrTYfcRueavBuDcU2h4yPX2CerHIWu/2EyREtPfnMgl+9TflLLtdekJhJdJ7rPQ28Ci85XH5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12330
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

On Fri, Jul 24, 2026 at 04:23:17PM +0800, Liu Ying wrote:
> On Fri, Jul 24, 2026 at 11:08:06AM +0300, Laurentiu Palcu wrote:
> > Hi Ying,
> 
> Hi Laurentiu,
> 
> > 
> > On Thu, Jul 23, 2026 at 02:37:32PM +0800, Liu Ying wrote:
> > > NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
> > > configures parallel display format by using the "PARALLEL_DISP_FORMAT"
> > > field. Add a DRM bridge driver to support the display format configuration.
> > > 
> > > [m.felsch@pengutronix.de: port to v7.0-rc1]
> > > [m.felsch@pengutronix.de: add review feedback (Alexander)]
> > > [m.felsch@pengutronix.de: fix to short Kconfig description (checkpath)]
> > > [m.felsch@pengutronix.de: use "GPL" instead of "GPL v2" (checkpatch)]
> > > [m.felsch@pengutronix.de: add bus-width support]
> > > [ Liu Ying: Port to drm-misc/drm-misc-next(v7.2-rc2 based) ]
> > > [ Liu Ying: Add nxp,imx91-pdfc compatible string ]
> > > [ Liu Ying: Call drm_bridge_get() for next_bridge ]
> > > [ Liu Ying: Reject unsupported output bus fmt in .atomic_get_input_bus_fmts() ]
> > > 
> > > Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > ---
> > 
> > [...]
> > 
> > > +static void imx93_pdfc_bridge_atomic_enable(struct drm_bridge *bridge,
> > > +					    struct drm_atomic_commit *state)
> > > +{
> > > +	struct imx93_pdfc *pdfc = bridge_to_imx93_pdfc(bridge);
> > > +	const struct drm_bridge_state *bridge_state;
> > > +	unsigned int mask = PARALLEL_DISP_FORMAT;
> > > +	unsigned int val;
> > > +
> > > +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> > > +
> > > +	switch (bridge_state->output_bus_cfg.format) {
> > > +	case MEDIA_BUS_FMT_RGB888_1X24:
> > > +	case MEDIA_BUS_FMT_FIXED:
> > > +		val = FORMAT_RGB888_TO_RGB888;
> > > +		if (pdfc->phy_bus_width == 18) {
> > > +			/*
> > > +			 * Can be valid if physical bus limitation exists,
> > > +			 * therefore use dev_dbg().
> > > +			 */
> > > +			dev_dbg(pdfc->dev, "Truncate two LSBs from each color\n");
> > > +			val = FORMAT_RGB888_TO_RGB666;
> > > +		}
> > > +		break;
> > > +	case MEDIA_BUS_FMT_RGB666_1X18:
> > > +		val = FORMAT_RGB888_TO_RGB666;
> > > +		break;
> > > +	case MEDIA_BUS_FMT_RGB565_1X16:
> > > +		val = FORMAT_RGB565_TO_RGB565;
> > > +		break;
> > > +	}
> > > +
> > > +	regmap_update_bits(pdfc->regmap, IMX93_DISPLAY_MUX_REG, mask, val);
> > 
> > Apparently, the 'mask' variable is only used in this call, nowhere else. Why
> > not use PARALLEL_DISP_FORMAT macro directly here instead of declaring a
> > variable just for that?
> 
> Marco introduced the mask variable to the code.  I'd say it makes the
> regmap_update_bits() call fit into one line, so it doesn't look too bad
> and I'm fine with it.
> 
> > 
> > Otherwise,
> > Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> 
> If no objections, may I take this R-b tag as a valid one if keeping the
> mask variable as-is?

ok

-- 
Thanks,
Laurentiu
