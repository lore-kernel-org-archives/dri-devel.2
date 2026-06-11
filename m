Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B932DCD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7F610ED4D;
	Thu, 11 Jun 2026 08:00:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BPPGfRvx";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011036.outbound.protection.outlook.com
 [40.107.130.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA6210ED40
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 08:00:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNmKBPtIhCFDOT8sWBEK3lvrnEWlOcd2IHN4c1dG1mW8vwQf2rfRuES0W1Rmv9xO3Q09oIdTZjYl7i9fuu4JHXGmzVVjctu38VN9Zccm8iomz+30/z4tEzIqRaZp25pBgqMVUh0dHG715dZOAIkvjVJUS6eQA7peGG9/y4gHAgMuOC/Xd7CleYpNkC6u8MRfoYxOplNWS2EdJRv1clvM0K2XsJEzZAEbvv51WsWcZji0+s9qJrVOTem/OVlzjox+8GjkfIero4oEgrgifWDmbvEPQDaBotYgb/3qRE+WUBFZVooaOVN54L83qqn2GXbl9P2d61ReDN3Ch6h5AuBKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjwwLap15nb+oIU9Q5iPg4dgEgC3ToID8iuU6yVsj5M=;
 b=jYo2kC94huKHWFqSqON02E7qhH1OYF+3fmThBHuU+oiNptnJeb/IaXKngal+dlLx/ZLuTS69BZQj/aD7O9wlwpFBJxmYMl4ypNwUR8oI5Ck7Pqh/CnuMlpo2trqMxqq9U82LRG/M+CZ0qKOBd6L+6Tud9MD8XZ2cL4dGphj+IoegLPPQ382uXHMibL+rFYcTqYWjjD5BOIQRzacUAndL0+Nf7AO3vqV5GFvOBsiZZmFiOV403CdTENWuLErsbKQ/z+X1blbagAxgQMyKXQK0ziYgbyV8YEs1wSt+nzF73UN0tzkc1vaSGmMcdmvGi73h+IQJMpyVIhCPseebo/S4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjwwLap15nb+oIU9Q5iPg4dgEgC3ToID8iuU6yVsj5M=;
 b=BPPGfRvxc+NvifxnoD5pZKJj+9zWzprkaCyujV81hOcGpxBj8h5mJL54NxBafoVC7VU2jTLyRt4nsLk+pHtoUI5RQ/9lnKAamBOi11B4ngVvvs6tNNkPKcyxTyNnzZyyk0oaV6TaqhACxQSgabClyccrKpWiQGnji4ldX/3k6v1KraNqcm79MSxmw2kHVhtQmzj1JnpaHECV6urh5BbtUhCkcfzlY1hMxHmZICjmW8TGLCoXhuHE47yJCvctDLJgjI2/rVZSEHSalqiLvIuaYzaU/BTggrixjx5cpQnSSAeyxrM15cMel0RAlm19loxJgfC44joiOj0IW3G2vf2+Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by AMBPR04MB11785.eurprd04.prod.outlook.com (2603:10a6:20b:6f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 08:00:21 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 08:00:21 +0000
Date: Thu, 11 Jun 2026 16:01:50 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Piyush Patle <piyushpatle228@gmail.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Abel Vesa <abelvesa@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 00/39] Add i.MX95 DPU/DSI/LVDS support
Message-ID: <aiprbid6YkcjhO2W@raspi>
References: <20251011170213.128907-1-marek.vasut@mailbox.org>
 <20260605121112.27866-1-piyushpatle228@gmail.com>
 <aiZzxhljfyYQ68Gl@raspi>
 <9ece4e08-a77f-4410-ba16-a77b9bd0aace@mailbox.org>
 <aifOQtaAi_7F9hXt@raspi>
 <7fc8f50f-7f6d-4b45-b172-a83d97164b40@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fc8f50f-7f6d-4b45-b172-a83d97164b40@mailbox.org>
X-ClientProxiedBy: MA5P287CA0092.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::8) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|AMBPR04MB11785:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e311538-f5ce-4e3c-fa76-08dec78f7c34
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|7416014|366016|23010399003|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: bWIRPWdkgCtRDLaJCU6KQ3a2zAKFD15ZT/OD0GCbiAF9BPfvGskMr/vMWpDR+ZfyvdjfVYr13jIGll8CoEXOaRle4mlMNmD6MFfZBhEByltfMVuAXh5o2ZAVP05E5Jf2eZ1+KyvEpI7WEtORSE2PEZiT2DHggLLqLl2VNUrOZzdlaQiJhL9KRwLfhCF4uESz5wslqi7zfotp7uYki4RNNs9Xik8NG7ZpjQbSrcZirm34wDbiBXxDhssIIHo+sUcIFqKTXLhD6vhLtdQL4mNKJd9C7gXIQg8P+FzQyVvh8EWnxfmwbqHHabSsmD4UJ0rOHcCG4nbCe3mNzCsOhf7Uz85L8IIu8v8j/kyBpEvSQLDBZB4hlCTvnDZTmX3YuVsKMRAc83+rxl/zLCKZ/QCRP3102BiB7sY7fMgNAr5WYfHcr0HOUISkNY+UgRiKY1x10lhxVSR2hzPum0yStGi//rsW/XnBc+AhDQQ2sfxhiGv59grBaKMF7vHzPHsMP/Zh0EDt39KPSuXTEWD0gk5LKwDD2VZtpg7iEHWGmyKcoY3LiLm5bDxffiBcwMpAYO3Xfj0FkWG4XCZAz4lC/S3ynkgvGOHgIfOH5IXFs3r+vMZ7n+clxTCEVc7BgxaiIo3Ov6rkg+++4Y9fEwWClU8e3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(7416014)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QyawJcXg4OOFEJ/vNIl4jv1I9XHJyVqpzE5/9cI03dfcVTTVEX1csVpmtxWy?=
 =?us-ascii?Q?38duunY9v7duqcxaSR5WKVnveVXHW19meP1jyi86EZS6LdwnCezETN8ypE84?=
 =?us-ascii?Q?SLklnxWQiw6AWnqVgKdAXImmvJ1BpLVXF4yu2i4aucoe2tVV1XIbUgaTJgpU?=
 =?us-ascii?Q?c9enzMMOn4RrBupmJDfZ5344RQuq5QjQqx1KkP+qTKJ5IGVAiIRlcwAOoh/v?=
 =?us-ascii?Q?41Z6hPzrubkpSxEuJzCdfg+W9HlVFyLwpVTDvCmqyAroS+J4QICg5FPYPgIo?=
 =?us-ascii?Q?anLVKO7hel7yu5Iy6Iv2Ijj6gRogD8TILFqvF9L1ZoXd4HMHPqk/C4eGGkWL?=
 =?us-ascii?Q?beIVrydnV/T9riyCAac1sUAEx4HpYKOXyieOmiaiDlmS9mnoz+hwOZF26RGH?=
 =?us-ascii?Q?v1htrHlIvkLiEqL179y0hq2snOnD7ZrspDM9NbZNE4uHov+NSNH9t92g/iXv?=
 =?us-ascii?Q?HubkUHFqzDsaARSQJI7ooQnJF5l2imOWDUeko81m7USYh5fr7UIHjU+xKhlI?=
 =?us-ascii?Q?j/RuLGa7VdB6AZmZ22WCuN8WPU/gTmhzQXfwiqAFY06UilQmBB0zgvCXtvkW?=
 =?us-ascii?Q?jjVoMGpT60yCX8TOQB42p6cY9kUeZE8aXM2res6di1wKsvajyvG+xqZ2gqE2?=
 =?us-ascii?Q?PE4lymmoCDtJyl8OaO33bAekj4L1B285C6Zk43wGZW52PPt2uHbffrpi+Vos?=
 =?us-ascii?Q?Qnb8H9LCSnMiT2bwmq4W787rtnhO/FMLLSQVHpjlvtFKtSHUi6nLrmCkRHfQ?=
 =?us-ascii?Q?qoszECc5ng26tx+gADNN4wpRJS1NdI9vT5i7g6cwIucXDxPWqcM7OjH3Q/iI?=
 =?us-ascii?Q?i16/OQxRpBuGGSGQF7gXL1f4cXiiXvWM3HOcH2j7wctbuBy2PpPxDs5+9i91?=
 =?us-ascii?Q?S/clxBu7fh+I3IbiBXclTSaPP8T7BwsjJ8eqIEVCwXRfFHm6Pg+Tpx7wjoN4?=
 =?us-ascii?Q?OXL4wbr7AzrqbhAK/tCf1sVPG1E1HVGxACv0IG2W7JMAXdUo2Sj7M9iRhv6q?=
 =?us-ascii?Q?mkkXnCFS/mK9nAeOyGCAlqV+ujkfwrAD7T2bxwqgbcKC1xX4Stp0p+hxm206?=
 =?us-ascii?Q?5SMfL+B+1yciLFHl8cwCjo6z5DuN68bvYENQwtnvOztP2imHd+v2DZmsKZ4y?=
 =?us-ascii?Q?yTb59Rh2f1RYmnVy5VL4+Uect0LQAmGlYgqtdTJZd2sEWbKhN6EZPxP+YEaw?=
 =?us-ascii?Q?PADKIaEeY3SxLi7qFb2lKqQUdmzaQgHs8bBKlZ9oz7PxiSYj/xJEZvPANDnc?=
 =?us-ascii?Q?mQSSt1VuFs8d2A1Z1oXvhWLxJXeAPvu/ZmPjVnKFqxdOXrVDbHsUsj336Tp8?=
 =?us-ascii?Q?Yohro4nNa5GdG+Av76r04ntkXgCRg+EckMSLXVpn1f7zU2oIY3wHs5PxxcVZ?=
 =?us-ascii?Q?GA4YHMA/xy4POpUPG/jDffCC5p3Auhx8Y1tgEdTomTpNw5TGqxfXs0XbNmvN?=
 =?us-ascii?Q?C3giYmsRE4w1xFDeb+lFuo+Acs3Ju33jrTXzlKJQVziMjHoEtAQp/ZXx4SUp?=
 =?us-ascii?Q?Wupxw39+ve0Qir9ELHAp8lY+Ezre8jLKJAAZzSDFgL4j8TORYBV29LsH1jjW?=
 =?us-ascii?Q?ucx1Gqgoggq/3gpU0AITAOcdLkktySAx01jYXnoxmT74A7K+mb19po1Q63hJ?=
 =?us-ascii?Q?Tf3T8c4kzKCXFEO1S2J6puibnIWWp9pu7CNYe8So2BaVh+Ry6wLbMhgAFYmo?=
 =?us-ascii?Q?yIxX3mnfOKxkIROpTThZiaWrSJnAwEXwbeTr0Ds1EL0ojpZCdNS61CgvH8Fb?=
 =?us-ascii?Q?GiUCFzjesA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e311538-f5ce-4e3c-fa76-08dec78f7c34
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 08:00:21.3839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujZSrZp6wZ4lhthpzCQur4mGY8XEUx8OasYuYKTYZuNCiZOEfRFWP+3b3Lo5PmxAkB2+qEwkt/eznqw0NUYb6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11785
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

On Wed, Jun 10, 2026 at 06:31:02PM +0200, Marek Vasut wrote:
> On 6/9/26 10:26 AM, Liu Ying wrote:
> 
> Hello Liu,

Hello Marek,

> 
> > > > > I brought this series up on the i.MX95 15x15 FRDM (IT6263 LVDS-to-HDMI on
> > > > > LVDS ch1). It mostly works, but I ran into a few issues around DI routing,
> > > > > LVDS format handling, and DC enable sequencing which needed rework before
> > > > > HDMI would come up reliably on the board.
> > > > > 
> > > > > I don't see a v2 of the series and things seem to have been quiet since
> > > > > November. Are you planning to post an updated version?
> > > > 
> > > > My plan was to enable prefetch engine support[1] for i.MX8QXP display
> > > > controller and add device tree for a whole i.MX8QXP LVDS display pipeline,
> > > > before adding i.MX95 display controller support.
> > > > 
> > > > Unfortunately, it seems that Marek is not a big fan of [1]
> > > 
> > > I am fine with [1] as long as it can be isolated and does not affect every
> > > SoC that might reuse this driver, which I think it can be done.
> > 
> > How can it be isolated?
> 
> if (compatible("mx8q"))
>   something->prefetch_op = somefunction;

I certainly cannot add this to [1], because currently the driver only supports
i.MX8QXP display controller.

> 
> And then wherever is prefetch used, do
> 
> if (something->prefetch_op)
>   something->prefetch_op()

These 'if' checks can be avoided, if i.MX95 display controller is supported
by a separate driver.  The checks are just telling us that the i.MX8QXP and
i.MX95 display controllers are different from H/W point of view - i.MX8QXP
SoC has prefetch engines, while i.MX95 SoC has not.  Of course, there are a
lot more H/W differences, hence it's worth separate drivers.  Without
prefetch engines to do tile to linear resolving for framebuffers, i.MX95
display controller's DRM planes cannot advertise tile specific modifiers.
The separate driver's IOCTL designs for blit-engine could also be different,
because of the prefetch engine and no Linear Tile Store(LTS) [2] attached to
i.MX95 display controller Store unit's output.  Userspace could easily check
the DRM driver names to get the IOCTLS that a particular driver supports.

[2] https://elixir.bootlin.com/linux/v7.0/source/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-store.yaml#L73-L76

> 
> Or something along those lines ?
> 
> > > > and I'm busy
> > > > with downstream development so the plan doesn't move forward well.  I still
> > > > think [1] makes sense(maybe I need to rebase it on latest drm-misc-next),
> > > > so I'd like to see review comments on [1] and hopefully people think that
> > > > the overall idea of [1] is ok.
> > > 
> > > My only concern is, to keep it isolated to MX8Q, so this driver can be
> > > reused by MX95.
> > > 
> > > > > I've accumulated a fair amount of rework while getting this running on the
> > > > > FRDM. If you're not planning a v2, I can clean things up and send one based
> > > > > on the current series.
> > > > 
> > > > I still think that i.MX95 display controller driver should be in a separate
> > > > driver, rather than sharing the same driver with i.MX8QXP display controller
> > > > like this patch series does, because the two display controllers are quite
> > > > different as I mentioned in comments on this patch series and in discussion
> > > > in [1].  Also, the common part between the two display controllers should
> > > > be extracted to a common helper library as I mentioned there too.
> > > Are they really? It seems this series adds support for the MX95 DC without
> > > that many changes, so are the DCs really that different ? It seems the MX95
> > > DC is simply a reuse/evolution of the MX8Q DC blocks, so duplicating the
> > > code seems like the wrong direction, it will only lead to disparate sets of
> > > bugs in two drivers, which isn't desired.
> > 
> > I pointed out a lot of H/W differences between the two display controllers
> > during the discussions for this patch series and my i.MX8QXP prefetch engine
> > patch series[1].  Please take a look at [1], which clearly shows that the
> > prefetch engine would considerably impact CRTC/plane atomic callback
> > implementations.
> 
> Is the prefetch engine actually grown into the CRTC/DE or not ? I suspect it
> is separate and instead part of the built-in DMA, right ?

It is separate and not grown into CRTC/DE.
It sits between DRAM and pixel engine's or blit engine's fetchunit.

> 
> > Display controller internal blocks would also impact
> > the implementations, e.g., DomainBlend block in i.MX95 display controller
> > doesn't present in i.MX8QXP display controller.  It makes sense to use
> > separate drivers for the two display controllers instead of adding 'if/else'
> > checks to a single driver's atomic callbacks or introducing two pairs of
> > atomic callbacks to that single driver.  I mentioned before, the code to
> > simply add a DRM driver(struct drm_driver) is fairly limited.
> 
> Can't we simply have two sets of ops (one for mx8q and one for mx95) for
> those ops which are too complicated to implement as a single op with if/else
> statements ?

Technically, we can, but using separate drivers is a better design:
- no 'if/else' checks to advertise those tile specific modifiers or not.
- better IOCTL designs for blit-engine with different DRM driver names.
- again, the code to add a DRM driver(struct drm_driver) is fairly limited.

> 
> > I also mentioned before that separate drivers make them easier to maintain:
> > we don't have to test both i.MX8QXP and i.MX95 if only one display controller
> > specific code is changed.
> 
> The downside is lack of code reuse, which leads to disparate sets of bugs in
> these two drivers and code duplication. And it seems to me, that large parts
> of the MX8Q and MX95 DC are effectively identical.

A common helper library achieves code reuse, so that's not a downside.

I'd say a lot of display controller internal units are identical, but H/W
differences would significantly impact driver implementations:
- i.MX95-only display controller DomainBlend unit supports 4 different modes,
  which impacts plane/CRTC drivers.
- i.MX8QXP-only prefetch engine impacts plane/CRTC drivers and blit-engine
  driver/IOCTLs.
- i.MX8QXP-only LTS impacts blit-engine driver/IOCTLs.

> 
> > > (I might not fully understand what you have in mind with the helper library
> > > though?)
> > 
> > I said this could be something like imx-ldb-helper.c and plus perhaps some
> > callbacks like fg->dc_fg_cfg_videomode().
> Do you perceive that the DC driver cannot be parametrized easily enough that
> it has to be turned into a library like that ? When I look at this patchset,
> esp. the first half which updates the various blocks, it does not seem to me
> that way.

Yes, I do perceive that.  Your patchset touches mostly the identical display
controller units(DomainBlend is an exception and could impact plane/CRTC
drivers a lot) and enables kind of minimal features.  That's probaly why you
feel that way.  If think more about the different part, probably it will make
you feel the other way around.

-- 
Regards,
Liu Ying
