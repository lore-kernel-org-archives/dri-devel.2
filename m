Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71CFCD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3CD410E1A1;
	Tue,  9 Jun 2026 08:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CYlLX6Pf";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C044110E1A1
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAJl7Vw7Cx462S+fPWjYasExg7p1i6GNkgXBOLKYiaVjH2MJ7khD0Y3Qlv8WVHZ9THa93T74R2O+Hk9jcm8sRqm8AFLTcqfB95ke1nO/06qorK1zaEbbB+vEx6EQLVujEDDQ+DjKF3H6gOtj58aBmCXludAnP53UWPtP1AhVW5P6T0rqT0eLTvjfY3ADbchcShIa7Esc0H/3CekKltkqUATmymQJqEbIaFq11DpJO3FV3qdBxOBQq7iEI+YBW/Vxald4feQl/sIOf6Wusma866YbJIds//G7ju67oQBIWx6rnwdikAbTphto0ChJzBaAw1ApXw/DiagFM1MHpdHAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJa8NwEfDvimHiVcRas3wCHw5xdKOwmGUnZDWv1rXgQ=;
 b=brAQMDba8YtA/mWNdyO2SAQILG72h7pacZezzhQCCsgkBurPsi9/B7Unka7bG+8uV8joqMiR8RssRXemzJjddpIqf+rHmYIEb8gGHr4ndBYXSS+atafFQgfAe+v3bl/yhOQgiCl3WrBZJDm3yusiY5FbuPLOyJ2G3XugYjdbWVd0J8BdMY5bSPRfkUx46aq6n9eZ9LVwwDaSYiFRbdySgoHb3lCWDWVrRzLSevHn4dSUu98RNhtyTes3AbPg3J5DpsDj3J5l9rZe6zcFRA0y0aHibukVC4+NqQthHaZb32jxUcmB1hBJrA2789EsibLLGL8K6R4QH01I16BX3im90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJa8NwEfDvimHiVcRas3wCHw5xdKOwmGUnZDWv1rXgQ=;
 b=CYlLX6PfFAo+zl5uNj6sbxEZEIgD9lqJO8an/u/3xSFwHrO0FeJz63Ams+vjSLuyOo4d6c3D4vrE47yMhFlreNsOYsxe4UHYq2ZUMUaNdY2zDYkWu7wDiZ0N+vLWbHw5p5xdbL69o5NjWKvsOVUyLXCNRDGc/0WgQ/sGljPSUg4jMJjU2RuXluPx0QScyNjMGuHGXAi5fe4Z8+Un1xQNffNsMKVTSAS4ecWFJidWgtphYX0O9RpBhYzBaXWSlk0py1I1lZqIjD9Y0hAxTi6psxUxo4SWK9ixnVpJebpfWi8+p0KAlO1+nuVkB9XsG+bB5MGnnZ7liAaE7HSf3kh4Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by GV4PR04MB11876.eurprd04.prod.outlook.com (2603:10a6:150:2ee::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Tue, 9 Jun 2026
 08:25:13 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:25:13 +0000
Date: Tue, 9 Jun 2026 16:26:42 +0800
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
Message-ID: <aifOQtaAi_7F9hXt@raspi>
References: <20251011170213.128907-1-marek.vasut@mailbox.org>
 <20260605121112.27866-1-piyushpatle228@gmail.com>
 <aiZzxhljfyYQ68Gl@raspi>
 <9ece4e08-a77f-4410-ba16-a77b9bd0aace@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ece4e08-a77f-4410-ba16-a77b9bd0aace@mailbox.org>
X-ClientProxiedBy: MA5PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::8) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|GV4PR04MB11876:EE_
X-MS-Office365-Filtering-Correlation-Id: 23549518-6c74-4459-a34d-08dec600a063
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|7416014|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: DI1faNFODX+FAanMGXVShgFyXCbRx1lAIS8PwWPQzE3dnhTx8UdgBgrq1Uew6WY2yoMrSwMOWcMbHVFS6NGflAHCjyXPFFdrE8iESlhu317YmQnZye8z2pp2weiy972A5FYY+oNxhdF/RcXB/gKYijm5XyH5b/9Y1pKkETfAeR23epmpuY0Aniv6CGSuRI36M2JLz4JbzMf/++amBf5qQxmywV1ZoAay2XqoiqlTwymucbNGp40acfx99AyvjiRIrKyrOBT2NubBXJmiBGCO2W22iPPGmiUOHqhz9D25FMoa5CBT+sfqjqqLNxCNst56EHZbsyL+oB0OGEXjmSVviRYzoKzOsf4DB1MUraQLtbimVBWa8uMJDaxERi3rU1uZZbDS1EgbPjOo0WvpDmewqTu7GMgQHYYbYwvSutIQ38+CQsvIYXUeLgZA5WMu+sF/wQLSk+k/1W0PX9PYeedulZ9UMlNGO7GkqoLV1VFlp0zsoUNpLa/nLRpSG0ZQezqixVysRPnZeRdaGySnEHlTbiwLbjFd+87Ir2YMW+9gIQ2gA46uqPwRgu4DzrP7mIYm5oakKaIo7nl/ftoyNPmOE2B7bMHs6PBTcZ+7B/4W0zC4oSRGtvZTdEtZMHkUG+YOrJNpVe94WJ+v+pg/AqhrGudDNIIr3f7pZvwYUgJNa6/IRMqPXgOE7vLK1bkNVtRx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9EBKrSTTTkMvyyku4FfUbHPdyNIrHB5S38bddHkOvfCP3bjInT06+aE+Evn3?=
 =?us-ascii?Q?jgwVOZfOPn+KU6NvcQ6v5fIlmSDLXIHzCn6Tu8079sCv5M9L8SIDOLBJk4oo?=
 =?us-ascii?Q?rQ0Xv9QeiZDEbM9GXpvtzj1nQCjaf6bQ5wH0jRqLYaelVrlYbFh2fgVB65x3?=
 =?us-ascii?Q?P2mw/xym5Jg15v5OMzCi2wxu+K4RLEn2MTRK4B0R5nelokh5YOjE0Czti61x?=
 =?us-ascii?Q?wXnHbnsKCj75+T2wYK4Kosmu7SUocLAYZV40cO5LmYfARQZ9s7kSXLf6Zyzp?=
 =?us-ascii?Q?8PRn+RWnEmSsd9w3QKfYUMNjRsa4KdjaK0UZBJpkKD5H1jMBNGDCWVWSCAnZ?=
 =?us-ascii?Q?EUZtuZeicNNcX00LCfMiuI9U7YuHa/WAEIApxlxxYd4oCbMk1xPK8wObPfxn?=
 =?us-ascii?Q?vcf8eGjmX48dyjav6KgVr9Ajt8B8/w0gRzar2pusRT1STxKfzIZQLIHW8qQi?=
 =?us-ascii?Q?tPIePB8XXUWnv4ABIRHHwDyrZs+6rHTfc6oZSns55317aHSdmjc/0xZDmcrO?=
 =?us-ascii?Q?djkLfk1wr4kG+zlLyaMti73uc99hT3lH2VXtlQm6yFuyG09zf0vQfgGZkW8e?=
 =?us-ascii?Q?5zAfhhJpbz+REH/iS0dukO7RK2fF3iDuBy2gPuh0wzfRA47jA4wm+GFLFBir?=
 =?us-ascii?Q?Hq3qvmj/zEY4SXqSOGd8owRW9j2R6pr7gzF6zCWpU/6q7WYkyzGAQwzxoBll?=
 =?us-ascii?Q?jIwcI6ujP+4tY1jAM9S4F912slr3vdEDX/cfExBxqEyLnLUM34GkOishASv8?=
 =?us-ascii?Q?mHO3X81v7fDkjy9CIXzOhuzbihip2LN7i643rR1Dfsa6j/OhIOU1g8yqvpGN?=
 =?us-ascii?Q?ZemMZz7bBzEoozUC6wVscTBrZX0trGdNvXn4blGyYNBqjtttoFwztthN1MsQ?=
 =?us-ascii?Q?xOiQn4RmBhoi/eB5k9kFSQMeJL99WytLvH2xTLY+FTQx9GxKK37kSToHGe2q?=
 =?us-ascii?Q?DeLbQ4CuKNntkfPtolVrBJWwidplZsz087asmiiQI1tjoXb8LN+byPNFnjuC?=
 =?us-ascii?Q?/ZGsSBeGeYLhJLcmz0rpwgo+g0QP847XMyCXTfQbIcXGIStaUMIvbBF2NTRm?=
 =?us-ascii?Q?ojvlUzAyCpYFruOBOwfq3DfY20bzRUOCOzyoFsUtDYhOPbLG/QakKhicj1rQ?=
 =?us-ascii?Q?zSDzEjgcPMcwjE/lUYCXSiyLeunIIjMKD8CsHnRM9XvrVQAPOv5bJYvLWIB5?=
 =?us-ascii?Q?Tej3YWHeOUnBn+1Z8EMltRoGHTxitmiIFOjk0RRLS5Ol2qjFcQDn5Jzfuk1v?=
 =?us-ascii?Q?irGclDGRBh5QI+O5h3ya6xosdewjCJaCviu3mJADNzj6amT9QxhNqibZLWGO?=
 =?us-ascii?Q?FsD1pb89cSFs0DxPA9HoBm+KMy2X/mBIVtyyu4pcX0QJli5uYS3mmAoK2s5t?=
 =?us-ascii?Q?HG+s0jYL69Jmiu4N5+24FIFSUJGZlMQtwu8gV/mdswfx5R/7GBRJMHV5ZzJW?=
 =?us-ascii?Q?UECjAULtyKM4HOL+BnFCe0vEJa5LC9Zhz98BgoptjDb+VaC7RpJQQkzNJvv+?=
 =?us-ascii?Q?PW+Xq8dbui5oFNA1jkqtVGS3RByvdil9bZnnEEifcB+rDC5EkzeY4BNovi0h?=
 =?us-ascii?Q?b66ZX0w3BppWna5sn7sJRNxlxOS2dR/pChMsdo5q1CdUj5XWS0i4MSaquAKe?=
 =?us-ascii?Q?CiXn4oKg0pOndDVQJRvmZNwTPRtWVANkU0uerPcKKR7cATNhKauL4znF8qda?=
 =?us-ascii?Q?Jr2aQRdx8XBZaivxIxcU5+xl8aIPB0bx8gzEDjuB7TAbZH95RuyDwBgjaDUi?=
 =?us-ascii?Q?ughWCLUtKg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23549518-6c74-4459-a34d-08dec600a063
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:25:13.0561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0dhSZku77Fzkkymn0xs1zN/xTOGbehfeXbxmCf8kVP9FGuVk5q8vd12V0erhN63hNc0sUAwh1s4Ao0+IKwpaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11876
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

On Mon, Jun 08, 2026 at 06:29:32PM +0200, Marek Vasut wrote:
> On 6/8/26 9:48 AM, Liu Ying wrote:
> 
> Hello everyone,
> 
> > > I brought this series up on the i.MX95 15x15 FRDM (IT6263 LVDS-to-HDMI on
> > > LVDS ch1). It mostly works, but I ran into a few issues around DI routing,
> > > LVDS format handling, and DC enable sequencing which needed rework before
> > > HDMI would come up reliably on the board.
> > > 
> > > I don't see a v2 of the series and things seem to have been quiet since
> > > November. Are you planning to post an updated version?
> > 
> > My plan was to enable prefetch engine support[1] for i.MX8QXP display
> > controller and add device tree for a whole i.MX8QXP LVDS display pipeline,
> > before adding i.MX95 display controller support.
> > 
> > Unfortunately, it seems that Marek is not a big fan of [1]
> 
> I am fine with [1] as long as it can be isolated and does not affect every
> SoC that might reuse this driver, which I think it can be done.

How can it be isolated?

> 
> > and I'm busy
> > with downstream development so the plan doesn't move forward well.  I still
> > think [1] makes sense(maybe I need to rebase it on latest drm-misc-next),
> > so I'd like to see review comments on [1] and hopefully people think that
> > the overall idea of [1] is ok.
> 
> My only concern is, to keep it isolated to MX8Q, so this driver can be
> reused by MX95.
> 
> > > I've accumulated a fair amount of rework while getting this running on the
> > > FRDM. If you're not planning a v2, I can clean things up and send one based
> > > on the current series.
> > 
> > I still think that i.MX95 display controller driver should be in a separate
> > driver, rather than sharing the same driver with i.MX8QXP display controller
> > like this patch series does, because the two display controllers are quite
> > different as I mentioned in comments on this patch series and in discussion
> > in [1].  Also, the common part between the two display controllers should
> > be extracted to a common helper library as I mentioned there too.
> Are they really? It seems this series adds support for the MX95 DC without
> that many changes, so are the DCs really that different ? It seems the MX95
> DC is simply a reuse/evolution of the MX8Q DC blocks, so duplicating the
> code seems like the wrong direction, it will only lead to disparate sets of
> bugs in two drivers, which isn't desired.

I pointed out a lot of H/W differences between the two display controllers
during the discussions for this patch series and my i.MX8QXP prefetch engine
patch series[1].  Please take a look at [1], which clearly shows that the
prefetch engine would considerably impact CRTC/plane atomic callback
implementations.  Display controller internal blocks would also impact
the implementations, e.g., DomainBlend block in i.MX95 display controller
doesn't present in i.MX8QXP display controller.  It makes sense to use
separate drivers for the two display controllers instead of adding 'if/else'
checks to a single driver's atomic callbacks or introducing two pairs of
atomic callbacks to that single driver.  I mentioned before, the code to
simply add a DRM driver(struct drm_driver) is fairly limited.

I also mentioned before that separate drivers make them easier to maintain:
we don't have to test both i.MX8QXP and i.MX95 if only one display controller
specific code is changed.

> 
> (I might not fully understand what you have in mind with the helper library
> though?)

I said this could be something like imx-ldb-helper.c and plus perhaps some
callbacks like fg->dc_fg_cfg_videomode().

-- 
Regards,
Liu Ying
