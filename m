Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89FDC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAF1910E2D4;
	Thu, 16 Jul 2026 06:47:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JAHj2y0j";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013048.outbound.protection.outlook.com
 [40.107.162.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3213810E2D4
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 06:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u108f1N/8HqliQ9rXwVjG5bvW85K+B6Huxi0hQ3/LIm0a+EqnymcJ96HAnoG3hnRo/Wk5M5JpeetLpFJ4VsIqCfn3lzMiuz99fYuSSIEuiplPtCO//tYeAEGAzJLP9knOjDDm3SMxfj6Utrwom9WkYIZG4PDMlRXH+ciL/rne+lne5C02ixkJWtjHPajmrkTqfNMn8nmaTJTn+tInzcxeSfkkAVgCXPZ1ozPr9LYCwSVeLZgNPJt051TjEJ06j+KSkr1675feaipLAe/8ZlDzW08H6c1DuzBoPYU5gEkhBbBPiWYERxA/0mpe9WsnludOHq1b3BHVl2gzAplMwdP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hb8ujkKNmLMS6DUcb8LWEka1QX1Hu4x7yARFIs8nkQ0=;
 b=eLdoa8YjJ7dm+6aaEhZq2hLCbKrMKhhNl0DPVAXUOjPkOPuOGqJu42+hwtTSL0r+9Du6vbLZH2zYzYmojwuWkx/IOrPdaeZNDOTaZE5OXaAS8wkpdEO9bKGSj9rDGvMTVzSIhYvFxgK/DpEejvAvcceVZ5QrpU/2px6MEOanTAjwbgxJfevacL+Z9LidwMNPW1VizWKbH38zhOuSr03k19JJBtqTWhqaJQfUDpTWdG0HjOPbuV1+kT2jjiRy0AgVco2Hr6BoozQYiTUXamG4/i3f6191Ux1neIBoUPFbipa4mdI/1fbWxkjVin+Wl4MPu6oe6PeLij5CPfnx+yiyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hb8ujkKNmLMS6DUcb8LWEka1QX1Hu4x7yARFIs8nkQ0=;
 b=JAHj2y0jLgyLMnSJQ9QKWMkZqd1z2AoK++kB2rX9eWAAx19im8vXY1Gt3vcVt0LO7Cwtl0rjTxtmJzJ6C6XaFm1ozKhkq3oUjRGL1jXvW2WrqkV9YJ1n1lYkegSkgeQZkcMG6VaqpPfNfh7tsvkknYzqUvI/+xGS1uvY8kfnv7r8TZCTXX/1YiC5KK0LQWqc1B0LsvsxUWZGKg/Z9gzngafr/qq1VHk1X4bfoqjjKHukqXBArF2ksO0dkr0oj9VHqV6cQcgI3JSmdAqpcBRS6+sYLKaa+GkbQIsMgg5PzVV61lvsVXkU5B7ZGjbIH0pzbBOaqEyuDSYJeLXD0HuDcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:47:46 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 06:47:46 +0000
Date: Thu, 16 Jul 2026 14:49:14 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de,
 vkoul@kernel.org, kishon@kernel.org, Frank.Li@nxp.com,
 lumag@kernel.org, aisheng.dong@nxp.com, agx@sigxcpu.org,
 u.kleine-koenig@baylibre.com, marek.vasut@mailbox.org
Subject: Re: [PATCH v9 00/19] Add Freescale i.MX8qxp Display Controller support
Message-ID: <alh-6sI4J7vq2drz@raspi>
References: <20250414035028.1561475-1-victor.liu@nxp.com>
 <20260714193627.GA9616@francesco-nb> <alh4a66fEro05ShA@raspi>
 <20260716062612.GC9973@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716062612.GC9973@francesco-nb>
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a124c8-2533-461d-c887-08dee30624ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|11063799006|56012099006|4143699003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: gQbzj12p5cIWd+YECzJY6KA1dl1gz24aGk8mw8GtVT0hkOYAaKi6Xu6/0oHs3QdIE1NLz9IPAYIQ4930kVB7RNB6oTEhbpZJMdsTnHbMS3bcmjtUXcjpJB2ZECj7rGuuoPz6KtYeEJrQSBcvehkUuGTIKd8PQG67TVM3ytadJw/l6pSOi6RJkh0wIpvWMtqL6j4HYzd9xRLvO/56BFzHNrw2k2d+bXhOsJmzRC6XgCkg+HIt+xiUlQKCwmA1MD7tdi4f2kQixf86jTPiZJuRv4lmvm47MtwfG3n6emC0A04eqL7QvOtbniQfYS/RZO+7ryAibN4nL2S+Lp8Tmp8hNU+Psrz2qBihTmf8o8ylbPNbYxj4SKPPcyh9QQLf6whsHyCV4n9LtkgSWrKiI6Bl5hpmO3vgLlD4sc6aJXjtE9H9HNAv/E17BunMoHmTQv3B9LTcbOhjBdmxADFMSIU7rWC/1GvoLrKtxojtsi7Y0jhqHBp/5Vt0dJQKqnlFoCk19VSeRaz48c04x28s7R5PAjQHuPdCx+gFGgJ45ozLGxZrBoNWBo5KdtcDuIGWow/SXvRpzPF8LoRnCqZFfSJarTupcLbknghv/phHta1SufHXtdJdbAV5WYyU7VwEQFlU+kJ5so4kCopUNcoO3iHsORms+gfmn3BkwNdVm5WDl84=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikUGTUMfr4+Nu51LQcYrm3TobJyOHPjx3LPNHrKO/n6KHKdWzvx57qiMBNlg?=
 =?us-ascii?Q?yMqhPSnVKUmgojEuvPGMatOq1aLiiV22rMyvuGTbO6o4ZmKsDXd+isUkH+fB?=
 =?us-ascii?Q?qZtFv1LeVCysYTWQcuElpLaA0uVXTrT6uadjQF59pV1Rn/An1GWXracODe9J?=
 =?us-ascii?Q?5LQBPZ/18W7oul60gQEQ3eJr+OeELvKXVP1YSiwWwWA3IWdDxqoapQjAyMR1?=
 =?us-ascii?Q?aOLzZlsJiv9ilR8kHSZNtsOV+bUMUB4hX2rYlnJ5qVqaqqPUVeA3UhjfLsHg?=
 =?us-ascii?Q?ZfBfH9zx+EIIY1OWlgTkAxa9aZjnIAUqRJmZKiF23Y4Cy8qR2EsEb888H6/e?=
 =?us-ascii?Q?HEKNyoNJUjC+XQNcAPqmTTGJMu8ucTElTbWSd093dHDj6vVG8fBv9NXYlyVs?=
 =?us-ascii?Q?hGl8GH3QIh9xCdt5degOEka9OBtRYWsVnOJ5SEYFHnzS6xP9gPprSgd32yeY?=
 =?us-ascii?Q?zueBduif4QeR/5BdbBN14RhuRWMQf3CrqUfc/A66nNf38u4lu7gOvCeXmci7?=
 =?us-ascii?Q?4URgTmMO6z7qGeINFlG9I18xAyVadlj5kTkUqVUt5x8zQnOSkXS40ul0F3R6?=
 =?us-ascii?Q?Ty4eZhAAwqdzvHEbFDDQLajr0+pNod9FR1eQ/mVH9IukisoCLAGfCAHZw4b8?=
 =?us-ascii?Q?72Hhwojfm2Ezpdit4/ImDVR9WjbRBcW1+vBFGlhawg1aSmSyS5FDV/QG+oMQ?=
 =?us-ascii?Q?YTPBf9nsNciV+AWJvHo3cfDvH+T8mjVnuLTv8zAPHvn0prYC/tHTKhOmlmzd?=
 =?us-ascii?Q?ULMWZFRYPAx02mAtypDy+7z/HaG1cxaR6YMGOF3xtqeOEQ7oDxbqfFE8S0uQ?=
 =?us-ascii?Q?ujUetJ2YZcyaHsDkEP+kNnhv4oiXISfbxi6Iv5vqAQ5B3O6DtZnGpScg8Iui?=
 =?us-ascii?Q?U6q5eo2UXJVfG8tq4r8dBthH4WEsv/+pbiKAu4dH5RwKxwmhVLXQ0oiNDSmy?=
 =?us-ascii?Q?QnBNqt3f0/zhhwW98+aztnUoFDaiJqO+pYjUslw1sTO6krqP0syyPNxX0A7V?=
 =?us-ascii?Q?RFD1m5fhnO2keWw6Wtz02V4ex2Hqje2qmeATKVRa4F++hHqw9qcXmrMqa8PM?=
 =?us-ascii?Q?nsyUqwUzqfnf77LVMnlc6j3laOsVrU+Y4Rxm1XPJdfylpJNK3l4fUx9dGos7?=
 =?us-ascii?Q?UtdR6FgzHvCC5HfUFxUmWOK7NoVfESjVM7o77n/pVbgiMXih6ik6A8zV2H/b?=
 =?us-ascii?Q?aBWyjL3bPgfX8o7FEva+Qg0peSBsum77P9wb3exOmu3wz70F8elpgYrP9Kxj?=
 =?us-ascii?Q?QQ02PMJnzezm5cYISTjRocQqcluFJzE6nAc9G4hRoriNuQgfjgRd2zeQ5tLw?=
 =?us-ascii?Q?irXex1dtNKrbBVdcQCVBxAqkhFwREI85QQirq3iZJWnD1eUVgBqbDqq5kx7u?=
 =?us-ascii?Q?365kgbvkxK5u3ZoVzqDprg/3HkwlwGVOauQU9bnZKFwERg3P7ScpV1O4134P?=
 =?us-ascii?Q?TBqaU43EMAU+sSGGLG1aP95udwILB9OE9Ofy3ziEUV2kfMOUVa5U3GEJLBfC?=
 =?us-ascii?Q?qU8CqTB+G6rkdtNp6P3dyirkwOkHbz4UCCXK+e671nfG19+JBSGO0zliBWH0?=
 =?us-ascii?Q?ZFqqs9PUtf1BnfeyeyALDCFEY6aWmDGOY0jwHsAxST1U9H6ylSC5LfMuluuY?=
 =?us-ascii?Q?Qhutp9V9KK3ytmQRsogc8CYxIKdVxBI3QZqiu6350kuXw23SRmCfZUhKIBSB?=
 =?us-ascii?Q?NfaFQ0cX57lh+ruC11ctrzhR8XiQPT3OO9C2DZqMVrS8WlvZ7vBF/h0/o72K?=
 =?us-ascii?Q?0pe3PHMTOA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a124c8-2533-461d-c887-08dee30624ab
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:47:46.0902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6FCEcHSnDPH60GDtz9mLwo9HmvVO9K2+I6hxZ/II1QcmsxwkI8kyrXkaij2zdQH9owrZ9sdKtxmkv+2pnIb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568
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

On Thu, Jul 16, 2026 at 08:26:12AM +0200, Francesco Dolcini wrote:
> On Thu, Jul 16, 2026 at 02:21:31PM +0800, Liu Ying wrote:
> > On Tue, Jul 14, 2026 at 09:36:27PM +0200, Francesco Dolcini wrote:
> > > On Mon, Apr 14, 2025 at 11:50:09AM +0800, Liu Ying wrote:
> > > > Hi,
> > > > 
> > > > This patch series aims to add Freescale i.MX8qxp Display Controller support.
> > > > 
> > > > The controller is comprised of three main components that include a blit
> > > > engine for 2D graphics accelerations, display controller for display output
> > > > processing, as well as a command sequencer.
> > > 
> > > ...
> > > 
> > > > 
> > > > To follow up i.MX8qxp TRM, I changed the controller name to "Display Controller"
> > > > instead of the previous "DPU".  "DPU" is only mentioned in the SoC block
> > > > diagram and represents the whole display subsystem which includes the display
> > > > controller and prefech engines, etc.
> > > > 
> > > > With an additional patch[1] for simple-pm-bus.c, this series facilitates
> > > > testing a LVDS panel on i.MX8qxp MEK.
> > > > 
> > > > Please do NOT merge patch 14-19.  They are only used to facilitate testing
> > > > the LVDS panel.
> > > 
> > > What's the plan to conclude this work? What's the latest status?
> > > I am looking forward to have a way to use the i.MX8QXP display with
> > > mainline, but to my understanding some required changes on the SOC dtsi
> > > are not merged.
> > > 
> > > Can you help?
> > 
> > I planned to add display controller DT node after prefetch engine support [1]
> > is picked up so that the prefetch engine could be enabled together with the
> > display controller.  Just want to avoid a DT that only enables the display
> > controller or bypasses the prefetch engine.  It makes the display controller
> > driver simpler.
> > 
> > [1] https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com/
> 
> That series is from October 2025, is there anything blocking to move it
> forward?

It lacks a Reviewed-by tag(at least a Acked-by tag) from a drm-misc committer
for every driver patch in that series.  Also, it seems that Marek(Cc'ed) is
not a big fan of [1](See i.MX95 display support discussion[2]).

[2] https://lore.kernel.org/dri-devel/aiZzxhljfyYQ68Gl@raspi/

> 
> Francesco
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
Regards,
Liu Ying
