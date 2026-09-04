Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB61C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED1D10F922;
	Fri,  4 Sep 2026 08:08:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="B3x4SdSP";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A257810F922
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:08:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9H5GgUrPtPdDWqQaJzdnWlBnLRLgrJpEMrci40EI/XtV5A+OMndj+vs1Lc9oTR0oMg8KuLGWPtEAbEFEAh5fFjbVSEEA+QpCLH5/n5Dw1Yb1dLOEDzgrkrthqNIyLUfv9+7MvlZqACMq/WSordVSKJ7X5zVL3dxXPaW4XrDGoKAJJpiFLy2XTik16+I6Vv22z7yvA3nBmuS9fXjnzk9FAVRSbF1lCljFIrovVF2GOJdZyHg8LYVbZ66D+0faey4Ssfv9gNe+Bgf0iseh1SgJeq2rXp/yvuB06vzD0JaXxMUAIZ6znQh3O2EO28OI6VEra1d4pJk55Hd4zQ0qX2//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUmfB/lGYn21ZaTrAnM0gsCmjjmyUgfTzpuBRVpgET0=;
 b=xcT1riX5PyNYSHlWDyshFa4wS+BlE3PG8QizN/2h29xTOyRSvx7/mh/z2LuDSjK8hNbO/vJQUWNsAlDcodXr0AtJB3lezHg8LQ7kc64iNXDosWHxFzb95p1BW22tHcuMcMHYIc994kzl1KChxCuZNEeLifny110tJ8TTnUrPVxXHdqPLBjd9aCe41V9Z0i0NP8pyCwS8ffX5AAqSxmsjRoUghwKHbd6JFmLFXR2krCPUSE3/lnQ3n2bs87CH2sku6VNE3P74yXDlz/mmRyyYzer7vubwoobARKPwePPDIoRC/ygMxjZyUsvF9+ExoL3eMDNkjpyGXhFOg3bHV5OJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUmfB/lGYn21ZaTrAnM0gsCmjjmyUgfTzpuBRVpgET0=;
 b=B3x4SdSPpO6E+Yi/0+25rkx8GPcg0J28osrtbXn9Cqft+U5EdbxcxYtIehYaiyGmtAzwfEcaxEZ5Pcwe6xI5jAJejVNSN6FQi7jL0kYbS2IqzXw6msWys1pftzV4UPlz3djIb9uCiBfxaj+fQkCPhRmN2A3z5O0AelrAU29SgMbm38iIzlXH7X1+sTjtsGwVYRM9aEiarJpSxtU6AqGLxd3YXucPH0AQ/wvgweQnp/8WLcsZSKaIii+0Wf7Hj4NG1h4Ml9xKSpXKL1fXXN3YMS0/te78aVJVNcKle2oGGrcVLo+jVwt85sTdJy8mTaVTecTJNAqhkRP37C5w440Jsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by VI1PR04MB9786.eurprd04.prod.outlook.com (2603:10a6:800:1e1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:08:37 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 08:08:37 +0000
Date: Fri, 4 Sep 2026 16:10:07 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, tglx@linutronix.de, vkoul@kernel.org,
 kishon@kernel.org, Frank.Li@nxp.com, lumag@kernel.org,
 aisheng.dong@nxp.com, agx@sigxcpu.org, u.kleine-koenig@baylibre.com,
 marek.vasut@mailbox.org
Subject: Re: [PATCH v9 00/19] Add Freescale i.MX8qxp Display Controller support
Message-ID: <app836E0_y8lG9T5@raspi>
References: <20250414035028.1561475-1-victor.liu@nxp.com>
 <20260714193627.GA9616@francesco-nb> <alh4a66fEro05ShA@raspi>
 <20260716062612.GC9973@francesco-nb> <alh-6sI4J7vq2drz@raspi>
 <apl4rkHIs9QFuUTE@houat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apl4rkHIs9QFuUTE@houat>
X-ClientProxiedBy: MA5PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::10) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|VI1PR04MB9786:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c1d246-7a5e-4d65-73b0-08df0a5bb8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|3023799007|11063799006|10067099003|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: nLujZ8Gg1GG1Rpil5P81O1cyzr5ukPs81ikDqKDWHo7hFmn9hafwguvz9lfcrA89/WboE+E9Pv+0Bd9HvH3mrzeqalU4mg617IddJyqNCjqsa/Ct2hoxp9QgcS07/bAfSDtFpYR/u9EwLjdyOOgZpesF17CuDVlMTpTIlUrefiDOzFGXM171/biHJTInrlZorxc9nn75fqGT6EDgJiSF8ln186QYirOqO+wlPJQ9DG4oSq68fuYarMKaoF1JyKbjSQ1UqIBen21hX8nvp5rezdkULL9S1Y0c358CqqEK1g7NoMjPKGtG5hGFsqOaZypwOwvisX/3XYDmYUZnebE363kK9gEABAJVoBhlScNVnPDfA+PAJvKIscTFtl471xD7KFqU+SmoTaKwtXB2mi+HI0wJTA8jqcmFZHWouE8Z/aaFsZxJM9I3/9gVUGu2Z9e46C9mCjRwg1wwkF4ZcqF0GAaj0SzYb2oo8dRb5I2jUP8rzxyxvQUo48QD1zX+eOGy5OJrGK95B/ft3BGN9CfCemlBBfuG7iAxMs/sdzncqmkdiJGCpjCWapBsvzGD8oZ+AJd24fugFBVMMF2EXyf7JPzq5Vn4MmI0zaUBGPWGf5Zuv+C3kDpqaQPQWw0r82pz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(3023799007)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bigmbTMsOlodgIbl0jHGEmQy3+5HFPhSefSMBwByhQR09HVyjLck71HRpR2w?=
 =?us-ascii?Q?AdN5KLyigJ/BjYcOYNIqqXMoLNVlEZoOUcOW61AIjcrtPpDHEkG2XEFzZb5D?=
 =?us-ascii?Q?gPW3M9PCns82/iF1oiPDXvHSQN/1mR6U+ePDdq4F1e6ZifDIuIKA490DBm6m?=
 =?us-ascii?Q?+EqGrlO8F4ThcIxWxfpjGZafqxu6lPuuisiWOHk3tTqajiJ3nr4l8VjXsGUU?=
 =?us-ascii?Q?vMa65Uoa8anG7hy0hS5NnWu9UmQelmiuAC3V1AowUSVQKCzCQGfXWdtwZVoG?=
 =?us-ascii?Q?x+Ybefc1yOYEbsXSDKh50QKwG+Un0viFZP5K1sbMnaAuvgU8udgxzqaSrKua?=
 =?us-ascii?Q?FVox/+sArNST89su1Wp+o+JEsGU1uhAqQR+MNLdnE3yYk4BYDtKzmyuyDwiX?=
 =?us-ascii?Q?QLHFUsZ+wDIRRIywVa+RLxIqjISC5N8X9QfRrg8t5mPe/fEPi4mciftEY2s0?=
 =?us-ascii?Q?hNkM8dbLgzUu2TalrLxF77iOWji4wmKfusXXoS4/2LVZMoKiGF88mLf811dO?=
 =?us-ascii?Q?uyV0sdf0WO28PRg4gH3GCTCCjuSFRX4tKse45erNRB0SrQi8BJOErdWPD8sv?=
 =?us-ascii?Q?ao/sMS49momz1mhB7DvWjrO/onY4mWwT9/eWnNhY7BkvZukS/ZEN0LInZpRg?=
 =?us-ascii?Q?IEHb8Z9lmHVhRw8uNJ2GXPfMxsn5VqvHGiAPuktgTw1VvSNEUVTJr1//bVi7?=
 =?us-ascii?Q?I7D7tnTWOcBDcpZ9fxUEOGZviPlrhj7Z+0Q5YWHBaRyJjlhmJq7MljuEklvT?=
 =?us-ascii?Q?TPuxNUlFOsaTM/MUn+u5qfd8NbKyrHUsYijuWAHZrD5l9uZVcVNrzVOwlLQz?=
 =?us-ascii?Q?cspJzYWZvxXwOrNUwrwkG81eI+TGQ/mgD9I+GhwAQDkBKTk4U42izJAFbJTZ?=
 =?us-ascii?Q?5Qw1ljn64gHAUwLmEuLbDsm2pKG7VLZYnVNK7SRDggxp78/GvQYZmT79+Bf7?=
 =?us-ascii?Q?1HqUFdOzBErmvT2lv17QAE+m7ugWAIHpORN6v922mRaLBAVwZzq99V+ggsDs?=
 =?us-ascii?Q?UA+Y8VUDY7sQq9AqVZejIuV9jemAoi+ZSpBl+g1jHiecg8Af7cbV3rw0i2M2?=
 =?us-ascii?Q?0ZkL3Pf1f8sNL7d7/yhyqpq1rqeBAbI7GwEt4gx+ZvNC9yhjSLC4tEWY189o?=
 =?us-ascii?Q?MF1omH+msdMRsHWeiIegUkt0+dkmK5jDZ3ElX2ZoXTB5zZj1b+qJJmTppLWJ?=
 =?us-ascii?Q?ibWK+0Vl237hRryglZ+H2Yh/PCC9WuGxFoqhWOx0opFUJ0aAAHRzaUSJsWIQ?=
 =?us-ascii?Q?mjfJ3aVySSVJvIxvzRuzMXmHxmV+7kwO5H0mHQiykRN1x3dJyXguIYfL2V6W?=
 =?us-ascii?Q?CDWGuu4MaLOQVHHC0wtrp6encduj66a83NvDgOsqitpseXjvFgLWSciKkSWJ?=
 =?us-ascii?Q?YWRBjzfcSTey6qkCeQSX4pZlppYaPmBgRA8DZ57z/B7sUaL+9Eyhva/ZWsu1?=
 =?us-ascii?Q?Hk78oFgCag8oIR7DQCpetMFOROzVxUCVmhhqgMP09tFnMCB5xoVIv6qu+OK1?=
 =?us-ascii?Q?dzT8muU8a5KEs/LabNwcVYvrmMwcY2yqLcXsi8Nk6+IFthB6kBJKMDX7xEU1?=
 =?us-ascii?Q?WbHa+9XZJAhMq+BxgtlUjuE8bHym0EhDmmpSajCUcvpYWAoe3YrL3CBwPmzV?=
 =?us-ascii?Q?FfMIYVtKvOtfuAhCUaeJiiA9WLqBziofnLW/dndqQF8AmBjAt6xen4MyiobT?=
 =?us-ascii?Q?PPEOOY7dEkMX/ODuSu0+nl8ykmEFpY+6M8UetE9y8+c8iNa8vK6jeknZ6krj?=
 =?us-ascii?Q?uYQYgDzlxw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c1d246-7a5e-4d65-73b0-08df0a5bb8db
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:08:37.1895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxSrIUnEd+463mo+uukvAKUeCOzMDecnOCMmpdKDc1qaHBosxOWXu48VnDq9ONoerW25L1W4F02ZOY+f9kxfKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9786
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

Hi Maxime,

On Thu, Sep 03, 2026 at 03:41:15PM +0200, Maxime Ripard wrote:
> On Thu, Jul 16, 2026 at 02:49:14PM +0800, Liu Ying wrote:
> > On Thu, Jul 16, 2026 at 08:26:12AM +0200, Francesco Dolcini wrote:
> > > On Thu, Jul 16, 2026 at 02:21:31PM +0800, Liu Ying wrote:
> > > > On Tue, Jul 14, 2026 at 09:36:27PM +0200, Francesco Dolcini wrote:
> > > > > On Mon, Apr 14, 2025 at 11:50:09AM +0800, Liu Ying wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > This patch series aims to add Freescale i.MX8qxp Display Controller support.
> > > > > > 
> > > > > > The controller is comprised of three main components that include a blit
> > > > > > engine for 2D graphics accelerations, display controller for display output
> > > > > > processing, as well as a command sequencer.
> > > > > 
> > > > > ...
> > > > > 
> > > > > > 
> > > > > > To follow up i.MX8qxp TRM, I changed the controller name to "Display Controller"
> > > > > > instead of the previous "DPU".  "DPU" is only mentioned in the SoC block
> > > > > > diagram and represents the whole display subsystem which includes the display
> > > > > > controller and prefech engines, etc.
> > > > > > 
> > > > > > With an additional patch[1] for simple-pm-bus.c, this series facilitates
> > > > > > testing a LVDS panel on i.MX8qxp MEK.
> > > > > > 
> > > > > > Please do NOT merge patch 14-19.  They are only used to facilitate testing
> > > > > > the LVDS panel.
> > > > > 
> > > > > What's the plan to conclude this work? What's the latest status?
> > > > > I am looking forward to have a way to use the i.MX8QXP display with
> > > > > mainline, but to my understanding some required changes on the SOC dtsi
> > > > > are not merged.
> > > > > 
> > > > > Can you help?
> > > > 
> > > > I planned to add display controller DT node after prefetch engine support [1]
> > > > is picked up so that the prefetch engine could be enabled together with the
> > > > display controller.  Just want to avoid a DT that only enables the display
> > > > controller or bypasses the prefetch engine.  It makes the display controller
> > > > driver simpler.
> > > > 
> > > > [1] https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com/
> > > 
> > > That series is from October 2025, is there anything blocking to move it
> > > forward?
> > 
> > It lacks a Reviewed-by tag(at least a Acked-by tag) from a drm-misc committer
> > for every driver patch in that series.  Also, it seems that Marek(Cc'ed) is
> > not a big fan of [1](See i.MX95 display support discussion[2]).
> 
> I was just pointed at this series, and I'm not sure why it's blocked. It
> looks like you were waiting for a Reviewed-by by a drm-misc maintainer,
> but I gave mine already and I'm a drm-misc maintainer, sooo... :)

Your Reviewed-by tags were on the initial i.MX8qxp Display Controller driver
patches.  And, those patches have already landed.

Now, I'm waiting for Acked-by or Reviewed-by tags on those driver patches
which add i.MX8qxp Display Controller *prefetch engines* support.
'b4 trailers -u' doesn't include any Reviewed-by from you on those patches...
I sent v6 prefetch engine patch series[1] just now.
It would be great to have your Acked-by or Reviewed-by tags on those driver
patches :)

[1] https://lore.kernel.org/all/20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com/

> 
> Maxime
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
-- 
Regards,
Liu Ying
