Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19133C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F7FA10E146;
	Fri,  4 Sep 2026 08:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="hge4u+oo";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EEED10E146
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxt4TGSULqmWxhExe1+uJRLrSFrVkT9M0ypalSr54D4HXO1J315ORWqoSV1LdAieRJq15ztFmD6rh+qJOCukLp20Zm5iVUZuubYl6NOimMoN6QPggy+Ao10ivHHqIPn2MsWhkazKJmcBZk+7l9fOQv30uqOApgE0zyuILJIZB/7OPFJdhoxUAa/mf1A6iJNspfaU75NMkkS1NDZ16FzFn0bVZXS2S0ppCVhH7/y7zbKbzUC/qok02MaZv7K0/B6MWZ9EjXQ5jcuBHu1S8rriwo+Ea1U0Bj0tzB6tqrQm/vdBXXTpODV7Li+oSX5HvBmI57LpHkbeDkif7lcRtYugTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9tJtPh/cky4vVh8httgw2j8iLB3ARmyTX+ZpD7HjOY=;
 b=vRLj2/+Pkwh5SQwm950g2Ujo4t0sWFIEHfSHIcfwLVgy2q8yk1pm7KWfY0BOrLqQYJURKSzOEKtAx55A8DptNhm4rkOF5Acmup4JY1wsxaBUOR/ZdYBkJDi5LPWhQgP54cy6YfpoP7YTXRFjEe5In0XAE2vb6p2OqcieOledpgtB0NyyDh4ZdecFiH+mBA/DPlr81ukYECv0Oi/3A27+X95BWFV/h7npDd7ek6qqNVH1W49GP72bXPlB4FJmZDcL4C09FNZHCw2ICnrmS9Ie1whSDiHjhIASCnyqrZiCLsD11vHdKlPCKcK+k7GFq8F1nYWfCiHHTxKIynhiad/6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9tJtPh/cky4vVh8httgw2j8iLB3ARmyTX+ZpD7HjOY=;
 b=hge4u+ooLAHEgMfVYVZyNDYMZVshVgJVkyU3dEi2miaDVaoSpWlYoQeTr/21rV04r4yIXGgI+PB1mMh6Ov9SnggDK6oU5x7Yd13xFtJiLvIhTCHSJYdbc46mp4j0f6I0kgE9Zjf2VS0fGMY6bxaiIs7W29cykGb8gD8tjzgHS5pdQxsZMMTgKHI4em5gr3PNMboBJWudbNb1Gq9cgQ1nV0CnzU6lLkkmHFCkVaTUXIvUh+sRSae2ZvClFoOxj9MFkMk6NvSfhW+d08z/xsvJz1DjFfGOUetlzBCfl3LWIESy1X8KOmQmOkYNJ3NIKssxM5TmYBq7YklWwBJ+nUQfqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by PA1PR04MB11454.eurprd04.prod.outlook.com (2603:10a6:102:4ef::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:47:51 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 08:47:51 +0000
Date: Fri, 4 Sep 2026 16:49:19 +0800
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
Message-ID: <apqGD7wxP0ZiLzfF@raspi>
References: <20250414035028.1561475-1-victor.liu@nxp.com>
 <20260714193627.GA9616@francesco-nb> <alh4a66fEro05ShA@raspi>
 <20260716062612.GC9973@francesco-nb> <alh-6sI4J7vq2drz@raspi>
 <apl4rkHIs9QFuUTE@houat> <app836E0_y8lG9T5@raspi>
 <apqDKdcQrizwAv6U@houat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apqDKdcQrizwAv6U@houat>
X-ClientProxiedBy: MA5P287CA0302.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::19) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|PA1PR04MB11454:EE_
X-MS-Office365-Filtering-Correlation-Id: 8506ef91-8dcb-4cff-53ca-08df0a6133e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|11063799006|6133799003|10067099003|5023799004|4143699003|22082099003|18002099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: YIkOvp54OqdlbTTWzYJdepQ2OnoV+Qc+To4JxJW+s1hLyj9FttokNaJk4+NfcuXaYHP9WYqKh5C60VVYkigHKtis0HaWHFlpQ4gl6i9Gqp5GLRlWp32nPdkbOOKAcYePGp88Czz1Ttv9gWfawocTsTze/Q5I1SXqO7ptcmzG1H39bIiNtqy92PtCY3apFxSluWEynYIWb2fxoGZD6eZBHclu/yIFfTzIpKfnzoKjfTIibm9ysT6nAKzQYnDqEjP4M3om+NsaGw+c4yfGg+Hzyi9SD13xzHL7VHvVVYgyVp+MDsw9mLlX3IgM6mayQ/uKuTZVZbLbYp5ey7YrZjyXpjjzBpGS43yb803zVFKx9NSS3GyNUGugnIouGWAyuFFbb6QT9xAQWkJgLUWNK25hhqJiHU9RSBid4JxzJE2ZRaKeYTI2Q51fk6QT518AjxC8uxkjr+1fTZyrem10JDR03/iFFj6tUK6hjb//xXYJqBoUCDv08feXU4ltAtGIXWLCzjNANeny+i4q/YmC6zf+kn5bgfpuPH8HdGA5WfZLF9pQp+44dy/Ronr+epA19gd2Fo+asRFzgf0Q0m8uZaifE7dWDzXKevRePqaZOHUEoFXlNDQUDdJGsQcQwsHhMX7L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(11063799006)(6133799003)(10067099003)(5023799004)(4143699003)(22082099003)(18002099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aTHVsPPLJK1hkgpB5C7zJ/a8fpmx3BqY4BUpNR+CRUP7o5VnvwFy6++4rdHe?=
 =?us-ascii?Q?+2nz79XO9ao7SeWd9owU1bLHkGEKrb1Lh4WIBLR9Q8cADU6U9AtFabXX3UJa?=
 =?us-ascii?Q?zPhVQJefhKm57vlsqrZ4R13hy8dr+ojc1mTJ81bVpDzU1o+Iml+HP2Z1A0oK?=
 =?us-ascii?Q?o4z95W1L04UFxgNOoDc8Azs7huiwPazBGygoAVWmF8yZTx7k9jxKiuu2BpYX?=
 =?us-ascii?Q?xftlUjgBIYZrArrTebJ/JJGV1FahnLQLwp6o+w1s3L/OewJCo6XOZVwWQ65G?=
 =?us-ascii?Q?7cqyKEVzq4ZFztoVNfZNum7+9kWPMA8oL4bLl4UdmZmZtiDfvGMPkGlnAwkJ?=
 =?us-ascii?Q?mJICas0aQz//1BPwNsGhQysn0PF5cS1Ci0/xMFPPBLVD64dZJrKAOH5c1esq?=
 =?us-ascii?Q?NgBR803oPltaO4q07TPej4C5P9crWeikhcjcOugrQxChVbZpXN7PYxmzoASj?=
 =?us-ascii?Q?mxEGDQ4obzlMzfpD+UuL9fm7b7zQHzCVM8CE8DGeF+VT7wwJK2TfRwx+GfDl?=
 =?us-ascii?Q?hvNu4cuQIFCZE9zoN7Exr12SAzbXL7GVeZ7ZJYqn8r/qYSRslQjtswUMxfxw?=
 =?us-ascii?Q?OPDSFa0J6uCt18Jr7KQvhtUtErFrMb0a6SRgrB3jnB+jXlt+ivMJQUovE7Ak?=
 =?us-ascii?Q?GC89oP5K3gxaDuogqaU7rUzXCsCtRUTy/mupGUOtdpUYZlt5ZZVToP3nxNA2?=
 =?us-ascii?Q?4lekZ9xsf2RIggQwEwpVPX/qIRSMATvAo4QbAIpV+Xl6XoSiGPKjj3degChO?=
 =?us-ascii?Q?83hD4gANreNFVkvQaEivWTTdhz8nJoKLKx9goV2DfQ8vgXUe3HY0L/gBV0iC?=
 =?us-ascii?Q?fyNOMeW5Pabw8WZDagqnW2uQmlpihCQ0+rbWkQ7FpqRMbxkz84gGJOuPRl5l?=
 =?us-ascii?Q?j3zbdQLAUfKnett9u2j2FVL/VkrHipwvGVgMhuKX5JuFdnUyfxfSETYNS9V3?=
 =?us-ascii?Q?ZQ/3seKBPUCqoVPshZj9A229LyZzM/Fu6pohy5hURxlgfz3pbDlUBZnm4+61?=
 =?us-ascii?Q?w0jz/O+lEcw3vdrIRafhNNGKGdK+iXMz84BuSZg3RNO4TUyeggj29eXvUfxY?=
 =?us-ascii?Q?+q/7CIEwvcU0B31WW52UW1EkqVSuiYE/Ki+/mtBN94CedX2Ql0PVsXzy+xJI?=
 =?us-ascii?Q?BsqqKh8+k3hPCimI128yQBzD1KY6I7GoblDHBzFcA/e+ii7mQbnIg8cSIAfS?=
 =?us-ascii?Q?PT668EdC6dubDRtnUMjuvo7UXGRebSufBs22J/j8gVorP+0LS5lHtBd/ekXF?=
 =?us-ascii?Q?Sg1Q/RgEf63YfTUQvzvTQ1ejUXzE85Cq0Gevduc8kXpmQo7127ZvfCl47yzc?=
 =?us-ascii?Q?jLDLsDx3mjjr+9m/CNi3WieaNW7O83WDL3i42YNwDOqiNzumfzJCD1qvGVRB?=
 =?us-ascii?Q?5aGb/mocA4GKD1fpV4k3i2A5aID3DgpMq8tUAFQkUzQI9Gc/jO0kxN+JeWa+?=
 =?us-ascii?Q?zF9laWeFFmFZPxtZl8tQps2ZFoDtDl84RBwElOpXmBfMpqLoaLKWqn6IWd06?=
 =?us-ascii?Q?LevUNEySQsdgMxC/zAqDIWWO5Gcp0UWKBox+qY40YhdeBgvzTE9huKC3j1zE?=
 =?us-ascii?Q?vA+6pAqasdDCZgWUmCW/3cTi4bdAcbZK32hwtae6NUISviRDO8wefXNW/YXQ?=
 =?us-ascii?Q?Cw+6MVOyHZU5qSc38tE4OA/gHhAObCjBTSyCidF6IrtzwoM5Rp4mX2k9twTD?=
 =?us-ascii?Q?T8NuAQ7OGYP5s8OsTRJN5RF6X5tS42MJDMUkDy+ZQUaUGWSSp0lHkofDF/4X?=
 =?us-ascii?Q?dyvDA6t6zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8506ef91-8dcb-4cff-53ca-08df0a6133e1
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:47:51.0426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IatgsGjVfcSCiUQFkVscy8qu4zA657Haq5lRs7na/9x5ktNMqimQ+nhko4nCZrE01DV1kh9otDelGVtXcoTQGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11454
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

On Fri, Sep 04, 2026 at 10:38:08AM +0200, Maxime Ripard wrote:
> On Fri, Sep 04, 2026 at 04:10:07PM +0800, Liu Ying wrote:
> > Hi Maxime,
> > 
> > On Thu, Sep 03, 2026 at 03:41:15PM +0200, Maxime Ripard wrote:
> > > On Thu, Jul 16, 2026 at 02:49:14PM +0800, Liu Ying wrote:
> > > > On Thu, Jul 16, 2026 at 08:26:12AM +0200, Francesco Dolcini wrote:
> > > > > On Thu, Jul 16, 2026 at 02:21:31PM +0800, Liu Ying wrote:
> > > > > > On Tue, Jul 14, 2026 at 09:36:27PM +0200, Francesco Dolcini wrote:
> > > > > > > On Mon, Apr 14, 2025 at 11:50:09AM +0800, Liu Ying wrote:
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > This patch series aims to add Freescale i.MX8qxp Display Controller support.
> > > > > > > > 
> > > > > > > > The controller is comprised of three main components that include a blit
> > > > > > > > engine for 2D graphics accelerations, display controller for display output
> > > > > > > > processing, as well as a command sequencer.
> > > > > > > 
> > > > > > > ...
> > > > > > > 
> > > > > > > > 
> > > > > > > > To follow up i.MX8qxp TRM, I changed the controller name to "Display Controller"
> > > > > > > > instead of the previous "DPU".  "DPU" is only mentioned in the SoC block
> > > > > > > > diagram and represents the whole display subsystem which includes the display
> > > > > > > > controller and prefech engines, etc.
> > > > > > > > 
> > > > > > > > With an additional patch[1] for simple-pm-bus.c, this series facilitates
> > > > > > > > testing a LVDS panel on i.MX8qxp MEK.
> > > > > > > > 
> > > > > > > > Please do NOT merge patch 14-19.  They are only used to facilitate testing
> > > > > > > > the LVDS panel.
> > > > > > > 
> > > > > > > What's the plan to conclude this work? What's the latest status?
> > > > > > > I am looking forward to have a way to use the i.MX8QXP display with
> > > > > > > mainline, but to my understanding some required changes on the SOC dtsi
> > > > > > > are not merged.
> > > > > > > 
> > > > > > > Can you help?
> > > > > > 
> > > > > > I planned to add display controller DT node after prefetch engine support [1]
> > > > > > is picked up so that the prefetch engine could be enabled together with the
> > > > > > display controller.  Just want to avoid a DT that only enables the display
> > > > > > controller or bypasses the prefetch engine.  It makes the display controller
> > > > > > driver simpler.
> > > > > > 
> > > > > > [1] https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com/
> > > > > 
> > > > > That series is from October 2025, is there anything blocking to move it
> > > > > forward?
> > > > 
> > > > It lacks a Reviewed-by tag(at least a Acked-by tag) from a drm-misc committer
> > > > for every driver patch in that series.  Also, it seems that Marek(Cc'ed) is
> > > > not a big fan of [1](See i.MX95 display support discussion[2]).
> > > 
> > > I was just pointed at this series, and I'm not sure why it's blocked. It
> > > looks like you were waiting for a Reviewed-by by a drm-misc maintainer,
> > > but I gave mine already and I'm a drm-misc maintainer, sooo... :)
> > 
> > Your Reviewed-by tags were on the initial i.MX8qxp Display Controller driver
> > patches.  And, those patches have already landed.
> > 
> > Now, I'm waiting for Acked-by or Reviewed-by tags on those driver patches
> > which add i.MX8qxp Display Controller *prefetch engines* support.
> > 'b4 trailers -u' doesn't include any Reviewed-by from you on those patches...
> > I sent v6 prefetch engine patch series[1] just now.
> > It would be great to have your Acked-by or Reviewed-by tags on those driver
> > patches :)
> 
> It looks like you had a reviewed-by by someone on all these patches
> already, so you could have merged them.

Oh, okay.  I *thought* one merge criteria is at least one Acked-by from a
drm-misc committer on each driver patch by reading the guildlines[1].
But now I've got the idea.  Thanks.

[1] https://drm.pages.freedesktop.org/maintainer-tools/committer/committer-drm-misc.html

> 
> I do have comments on the series though, see them on your latest
> version.

Thanks.

> 
> Maxime
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
-- 
Regards,
Liu Ying
