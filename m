Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64664CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B5510E298;
	Tue, 19 May 2026 14:26:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HtMd/wxG";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91F110E298
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+1MaPHbS4Ey4Cpz05KyT018y5zqkGnUFX45V9uuzzhBMPW2TkZHCzYotvqMpY8Z2GU3U22S6NoK7svLcAyOEeZQMKh0R3nzseuFuJsubLCnQAfeI8XCF0tEya5dFjxyo7lw2pKuzKl2/9ExO+QVETfXKsxfpCjIMeYeuBhZR3NogCBjK89uhd+ARH7SsU0iKPnGdnTtGv/YSoBzySQah6JoljhK7p4/YSLx1abvQ1g3IW2ypibDZCtnz/HOG5Yyyyee9fRZVAvRqJBEH54ayJu2f0Kyu37xi0LaRm3vU0TDck16ocVmB+v7bdI9V9I1IQgykR0ywe8D+6p+UMQP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0N0iV9AfWsuuaEPuiOJOOK8UNEX2u555MmO8yvCwqs=;
 b=ikf/dpnVbkowPzVt5AmIP2E4pvnnrX+PgOObN0DTOqpPqGLL1VV384aEK7yZA4znKcAc6gzXza2KilYpAcc60BXESqUrlcn5ac0yQOPiKpZvGi94VgrlI0D8UgY44QbrG4HZ/dwUkbpd/stTTcrNaW+eSVIkTTu8zo16UG+YJpmNaSjIFO/i4SihjwellUz/FmlfJUZpEv97FnnxsyCyA8Q6x9yFv8mW5r0ivrhY31vxtfjckA/U4EjBilkBrg7qqxeaQvr1YevJPascDNcz6LohkiGCub+CfPUVmjVpVSRvELMmBKBOkyWeg5EecCComdDhXxdtIz1uwigPtwM/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0N0iV9AfWsuuaEPuiOJOOK8UNEX2u555MmO8yvCwqs=;
 b=HtMd/wxG/XE8OAODcck8YVdZxstsg44jQf59OJQ4Luok0BF3B/8NUjKgR2Lu/eEiMLdtECYjQNliDt2h0x3GQbQ9yrlUNVrVsGgP53tr0E4F4V8jpJ8bWfAUCPFv40valhtp6sLBuEjmgJPrUVJ1Xf2jbu6SNk15abkBEBNTpf1ewtk5lYnlxGbEJzis4kw+UT8z1OyVzwkALFKEGFnZLg7pAXQs3N9FFCYbt/woB6rSCMKjPjRpc5axg8/xyuN0b9Ij6bbhlQkQl12JD/jyRR06VWS749uKJ4HyODvLYwcewXVXAc8p268Lxjp4gD/OL9fstDpJOrkGG6kLBoj/wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by PA2PR04MB10446.eurprd04.prod.outlook.com (2603:10a6:102:415::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 14:26:24 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 14:26:23 +0000
Date: Tue, 19 May 2026 17:26:18 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Parshuram Thombare <pthombar@cadence.com>, 
 Swapnil Jakhade <sjakhade@cadence.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Ying Liu <victor.liu@nxp.com>
Subject: Re: [PATCH v22 6/8] phy: freescale: Add DisplayPort/HDMI Combo-PHY
 driver for i.MX8MQ
Message-ID: <brv6sgyrwplbrf2hgqowvzwfxmnv7mea5jlbhyscdhyhse3nd2@mvuxnkgknmc3>
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
 <20260424-dcss-hdmi-upstreaming-v22-6-30a28f89298d@oss.nxp.com>
 <afd9juuQh8OB6SEw@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afd9juuQh8OB6SEw@vaman>
X-ClientProxiedBy: AM0PR05CA0075.eurprd05.prod.outlook.com
 (2603:10a6:208:136::15) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|PA2PR04MB10446:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbbaa63-8fe7-4a60-26b2-08deb5b29a89
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|7416014|376014|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: 3Xcp99mchCcT5a0ytck5zF1loRFAG7uH+0Ytsu1nFMak2Rb4eijsDWS5SpSexUxlVUCFCXsBepS8bbr+PoBGVKcScbBCKXiB32muNexsEQM690jSWJZtHpc+83lnOWGmV8I9bpED4dNOT+HmXX7sisXsEPjaZawIxI4R9+Hq9EksuvVIUP8u3hcybuHXEOzITf1V9+0gGs1O9wVNeP27QweIftXcfB1J0JBIoN7JMdnrkHjs6rtvkSVkhsy9RuQ31Gfg/X2Ks0Po9R4fGxAuaR/Z8ZvwDfmJrAI75We+YpUs2czQ0fOWNOyWmqgeb9uOdhb/M7+RgHm0c/6WCPjclrH8E1d+9mqN4ReplKnEUf4Uig9/8m69cFmXAqmnXC6b/FA7Dzs7BjbWLJp0Tnr4DOROfFgfdi+DminHFV+jw7iwgLYhh4XDbP4hfzqPfQZ0buLJYY41oaJU8rnAD2/xW5EOc0tizHYvjvRwxoCI2OkQ7tpqa1pC0lERHFDwdznWip2ksX3wMI4LmwXRlh/3aE49MD2TKd6QgjvmlMnsyvmVuSnIkpHXXKPk/gOuXtk0u8+hjzAgQrpTEa88V5EsNq0tZFadAnNwqemFsvhNMa9NEj/HEe6bt+vfIm+laqKI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YlzdRHxf9K6ccZGR18VGbSdemfOUi6nOSkM6VwLKjyjTT+4ixYNtVgr09BAS?=
 =?us-ascii?Q?0xFygaRz3EFBlXFTYEeckOQ8SSqOzMTii0umKAXGTcKvmfEIDpqw38/XX7d+?=
 =?us-ascii?Q?N6RMY7JvF07WLNPa7VS8XtddVHVJN20/iA/qfX7h8uXk9OSDinIGSzOSpOIQ?=
 =?us-ascii?Q?6ppuiTAvy6+DCD9jIOIBWwBYc45FqpPje3opZ3FIbZ29MIKt+uTgYj5d6wKk?=
 =?us-ascii?Q?bxMpmzEmj3GyQbAF3BnNLXJwkdmG3oqYpehcS9hE1oZ8/n01y54ZslZl+XqC?=
 =?us-ascii?Q?OYBy7VhbPAlDZrg9GmiivGcrvFg7MWNiPmeab0l9Mo7bQbCkAZm5gXJqcY7f?=
 =?us-ascii?Q?k1eW4x9P8lzOXrhh7vfpKOcnbuveWu68ioRmaZYVy44esISOct/5TkP5OBrt?=
 =?us-ascii?Q?JqTps+zMseAqVZiQ1OSZFiG7rkAlWSHebc4ueixKs0rFGoEBEEKWj/GpJZbL?=
 =?us-ascii?Q?kClS0fWrxEb0m8ytHIxgieOQlxPQUVjUSK65kayDtdlZ1ddHGwWX8MgD+cF2?=
 =?us-ascii?Q?2si+67XmtQqD0XxoCM5AVL16pyC4n0FXEeUpGNdIp0efErYLBadewrfhL5Df?=
 =?us-ascii?Q?k8SuA5gVuzuxHExmC+w4Nn9bh6CZIVFVHXKqnUUN5z5zoITEsBYgXHBYYfjI?=
 =?us-ascii?Q?kdKagnxaB6rhsYRC4SKH+9G0wQ6K0nhn7ZT2REhF/mQfZTlVONVPw7YGG9nh?=
 =?us-ascii?Q?okMLRNRFR6D0XOCoox0cWidcjjkQx5D96Oz2xu3X2AkfWMKzWU0o0LTusGLU?=
 =?us-ascii?Q?GTt/a49NpM/SFraRViGow3lbyf75vrGOUyCWDV4H4udm9PsiM6srA4VGQgZu?=
 =?us-ascii?Q?CqA/Xp3Ltyr+fEbyoQwYhnRdk/yT52tUIL4unqnDQUoWTsPvv0XpBGaJZQhp?=
 =?us-ascii?Q?C0YOa6CL4tsRDtgCHyGgupbRyHo7K59xewp0q8zDr8t3MmgFjUHDW9tY6vQp?=
 =?us-ascii?Q?QkoEOSj2NlVo88ExZv8EtUyvoLiX3+ihK5Opm9cSVB7MasIYe7Y6Hk0wkyIO?=
 =?us-ascii?Q?n96s/LugZw9VU+VvAEHw/mV0KfpbFBNJC8L1qV97Y5FO7+ie99T8YLnIm+SE?=
 =?us-ascii?Q?YJ/0WYCPGhk4DJjvGQLHXKY5dABhPZVMWlCPxm6PUaslYWTlpD4S/3M99Dry?=
 =?us-ascii?Q?ZyKGUoI3Nn+ERuDuSjnrFZ9M3GOcjYxbYpFaaf6iVZaKUkZZJDgrB8HKIEXB?=
 =?us-ascii?Q?eJYo7ofe9t7MkOEAkgVqrivw8VYC1TGf3723tuh+zIvkQwfXMCOsVciXKQYd?=
 =?us-ascii?Q?xE4XdR4rvCQYYJB3Cm8Q0mi0DlRlPED9rmc8G/G5k0Rk3nPP49tcbGVAERi3?=
 =?us-ascii?Q?WhAOxa1xDtYnCXj21Yeq5Gr8Um/xW4mkeSEPqg0Emtap+6jcXr0OL9FSdpL4?=
 =?us-ascii?Q?tYtB6iInOVNXnpH9DdJ1OTQjI3fsgbgaosPi5svmyThgTpn21TYUTbjEZD+e?=
 =?us-ascii?Q?rMCbvdaXSYs1nv9UzdY4oAHS8Z4ripGeagW0EmXlANvLdlo/uH5zK7G3Tpg/?=
 =?us-ascii?Q?BLEOdC+o43Ar116koSU/P45DiKNCU0Rz+dKfLzB7T62jNfAQ+3KPtoFpUnUx?=
 =?us-ascii?Q?xk39MocEBYCfMMahPQRp6FQDAEFJsDyQOnCKujjMRjRYL6aBxHP4wO/Pya+X?=
 =?us-ascii?Q?TnCkQ/vV/ZoZpEMEryFdL7KTTJaruEOQrKYKaiZyEbLKQAESY9tY2Ud988f5?=
 =?us-ascii?Q?+48aQX2PxVr9+vP4ZcwL2GXKq66Lwsu/+02utCm/1kivPOhsDrr9O7fJwixv?=
 =?us-ascii?Q?+EITU1CodR/+RlvMhjiixtVj1b1Qs9M=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbbaa63-8fe7-4a60-26b2-08deb5b29a89
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:26:23.7603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VV2iq5H+fk/clfZmzCJWa4wDzcthpTZh5CP62HXyDkrTG0Oz19XGsiYw/efVp6p1wjjiwGFzajLB6avQW1AXYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10446
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

Hi Vinod,

On Sun, May 03, 2026 at 10:23:34PM +0530, Vinod Koul wrote:
> On 24-04-26, 11:07, Laurentiu Palcu wrote:
> > From: Sandor Yu <Sandor.yu@nxp.com>
> > 
> > Add Cadence HDP-TX DisplayPort and HDMI PHY driver for i.MX8MQ.
> > 
> > Cadence HDP-TX PHY could be put in either DP mode or
> > HDMI mode base on the configuration chosen.
> > DisplayPort or HDMI PHY mode is configured in the driver.
> 
> Hi,
> 
> Please consider if this can be split from rest of the series and posted
> as phy driver

Unfortunately it cannot be split. It depends on mailbox helper functions
added in the first patch.

> 
> Also sasiko has flagged some issues, please take a look https://sashiko.dev/#/patchset/20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d%40oss.nxp.com

I will address them.

-- 
Thanks,
Laurentiu
