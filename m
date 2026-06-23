Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3D5CDB466
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 01:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B92610E4BA;
	Tue, 23 Jun 2026 01:42:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="jNe413wM";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF73D10E4BA
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 01:42:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ik6A9PGgCfirwBdtX6j16LySfoP4AaDgfNWUaZU4wVoCIEmgxfYVsLurxmdltf7iEOmm5QeTEa6RUY4b2XQMWbi4mfLW149wXs76ES8jp2MoXB9hXxhn2f7izPz6vw/AHEYHFuxmnSdxf74IXtNlde6IiMg745SJkHFnU4hGS0SHNQUnA91mMpssW38LATEeLd8ItTE1l+6mtg049ySkRr0cu/CUEPqGC3F9rQPSpZ0dGs7LwBYAEbFQJuHh9emgkXpwL//qGIwOMrzUH8EQiSJF4KRHa5X0GHEoAVMChUzMlPzS48xU3kdLSckDCoSQosu/sGKPJapMFNzY0/J/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PPd+7UKr8zsxnX86mHGIC69sLNuTaTcVtItn/y4pEY=;
 b=OqJRsBgiUdsIOpDq9vQ33XmWBGhL3pU/K52iIx0Nsczf4D/hcCEUqQmruhQzKKdRbPQ7AAmZbqEXcf3qSLb+Ni+dpmXn8bFau1efFN2a/a10eKNosIfWeQojKIipYHD3+GGKYqgqY6FFcPLEfhvM8bG8Qjeq1AHI1Nz1r2GurRgli/b7WAPlpjvUmUJBiyFHzTpKKhuZRUQ+pfWl+ovZE3uI5I9gGbFeuuObLjopzXehJ1euLH/xez+K0DXzGnUKpTL1L52piMT2AriTCM439quVvtLC81NMALtRyntFOZs3BZQ5lleg9wGF8Nxv2G6rs0SOoxq2BByuT26P0jJOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PPd+7UKr8zsxnX86mHGIC69sLNuTaTcVtItn/y4pEY=;
 b=jNe413wMuigAkG0x2OIAvJlbY9rDAj5y5PRwIsxUEq9OpMkyi/Of2pwW/3ha5/PxJqXICC80eD2IW7QHAAu5EhpHBtgTpOKhireNRjkK8NPT51fka+5Q54+xJrg7/YV4h/64QVOsIOBofKgRQq+LnGlLhW4w1xITEFvqmVITRxem2nsmtyRrKPHvEh5znEz8Ts7ze10Cpo4pE/r10vN4gAwlHCPBd7vWhjTeF8dm6OOWaUtUUdYeAlhepvRAy8ls63v3/Mje8sJ5jUWZ8HEFYO5Y/nEHFCA1BMZIkt7yMJHDBGt4Gnk6p1+g4TkmzEFYPTIHiBZvnDD1vf89k91awg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by DU0PR04MB9348.eurprd04.prod.outlook.com (2603:10a6:10:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 01:42:12 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 01:42:12 +0000
Date: Tue, 23 Jun 2026 09:43:41 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/bridge: imx93-mipi-dsi: Fix mode validation
Message-ID: <ajnkzWyiPprHmRmU@raspi>
References: <20260515-imx93-mipi-dsi-fix-mode-validation-v3-1-91f7d22b2fe4@nxp.com>
 <DJD6I8NMLN3W.3LVT4L17HT5TU@bootlin.com> <ajjpuroFPI_U2Fw6@raspi>
 <20260622-strong-messy-hare-2372cd@houat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-strong-messy-hare-2372cd@houat>
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|DU0PR04MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 713e25cb-d1b8-4d64-a55d-08ded0c8a51f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|19092799006|1800799024|366016|23010399003|22082099003|18002099003|3023799007|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: G+8A2RCXBMXh4yEZod8fIqyzapzgIBereleYY8juyZX+7rxJa+kkjTaypSrTdMvg111xSduESUUPhqg5GjB8Els8vkKWriyAmKbnv3EjhjIsH1J2q+G8KLxAaTxzg8X1G0z2HWK/6mhI9dU22z+7r0xefBq+FjA0+fWOOl7tyJfE1ga0iSX9KQLfvUWYmLuzQQgARtFzu17sQZG3kqCqeI2Lv81PZAWCj3ygdQXiDo9j3k9JZWm62FwpffJYiGKEa5UCRFpVW/qIA080GdIwe9FSFcobYqAN/FetWpwbyQO1HbYLby3EKe7W5vCiE9u0sa3b1d7U8LICrJRHgSEs+E1NKOzogWgifQZe7zo5FaU5bRhFLtqFJb4QKk0iVNAhQvOm5KZQd5OwFkL5XzxtfK5AGNv8Q3AvT8PHSdvPMDtBTVphFHgXQc9e2QI0zTk+gOUKlcIns3G23OcLaieF6JhKGGiCfvDFJxukKHSBye6EtKvbP8H0uGzyAF0dh9vg+XPHPtq3qWQa2lCorU7KlU7zAIYSGFwTzd9ZpR1NkTI8fRMHg1A4ONXoqgFoSzsMZa2IjWLbjrhudyOe/P0+owTsVRn7eHeuKw5OLdzuZhzjgIx69NwIpjt4iMKsulurSIiaxqFdtH5htufEfYl40u/Vota68Z0DDGLYWoFkb5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RU+shmRRMCUwIoZVYfHE1Gu2PKGbWg7gK8gQ3tVSsvbeYSIVuUc3NijyQ/iA?=
 =?us-ascii?Q?Fp7zbXn3bPAwy0FH2sLnOyAXs5+esLwgOWdmF4nxkx6LyCg22p0ELWtBT+kg?=
 =?us-ascii?Q?haZVGZQFQCkOgK7Kpuc8dYyf0vN/e5e0HTaNWSn7GABku5yo0yGAv/QxMudm?=
 =?us-ascii?Q?ooGlkY8wBcWUuv7xIiuccEUMwlodqjjzsyj6nMZcHBClG1WQ39qQO4UF8XdY?=
 =?us-ascii?Q?5b13E5dW4OS+9D5YvEZBtvqT1C8v7YAhCsj4AzqHJGDpMqmgRM+ySt19L2/W?=
 =?us-ascii?Q?n2z8ltHfUX08fmN1fQMkmS/1KSJ6NMZzkclf81vECI7hFn3WSW4RR+v+1msG?=
 =?us-ascii?Q?IBrSI4Tvu4aHDX8gWPcYiEgobWyNOVG4Sas+QWYLnn/eN5ld0r1q+B+/BRUo?=
 =?us-ascii?Q?W2tUUtrIQ+R2Fml7f4WmIFR4UsN3y2lE3XoSDWm2GhktFekd5Ufsdd4uJziD?=
 =?us-ascii?Q?VSMueOBPmfeGhWz228QG/TNhRfzqM9xVydAkr2BQFp7Jd+I/d4AmVQHUeAeg?=
 =?us-ascii?Q?ndu2ol+avxpK0Xamlbz4w7SsnCnmkxo4dVTT6rUcLynXKB91OY0o79E3VIi9?=
 =?us-ascii?Q?gXLj1+kajMEuPDAp/8Yf7fKgAORZzmwtJz2UunQEg53lHwfjhMQCQQoUtNCm?=
 =?us-ascii?Q?7EhaKPnHQXo8V8D9JV52/T6w2kPNoDTPvEaie7o5dkVDA2hsrE44b+qLl4rU?=
 =?us-ascii?Q?Mfd/JYoev/DYWdv/wxGBbvQLn2eREaCyMG6hDyhudN3lT0UeyH4wxJ0DbSLq?=
 =?us-ascii?Q?k0itzzNt4r/Gchhn+ml360x7bhcqC5Cr9mLPGgw0Qje1vIWH487ie/IkIUJV?=
 =?us-ascii?Q?H7BOrWZBwnbK3TkKzb0Q3s3uilOr4UjnXyH8tGlQxdelgWd4UBuuLXxfeFp4?=
 =?us-ascii?Q?8QwMNCVqtzhdLYG1AcTXGv7SqeDZd/ZtwtZuk6DbLwpl2Av9yUV3zh1jiZ7C?=
 =?us-ascii?Q?Cn36dApsKYca1KfelzeFmlq5ZXL+51alyJuFhJYR7VvziQBiJam/23ywG80h?=
 =?us-ascii?Q?YX2ypG7hZn76a+1aD3kNGKCvC9+6IUx+lHTQz0IWJamciOm7phuwkEMweHpn?=
 =?us-ascii?Q?AiX7uvtKKAU4Xjqyrt9bt1oz2A7dXk7Y6wbLZcziULzDey1BufgkqswUthjP?=
 =?us-ascii?Q?06pvfCXawSKoP8SYKhCBKlbXRQSrYLE4jq6HXRDjxyLGSC7jNCtQhKhSex0M?=
 =?us-ascii?Q?T3I7JIPLAmHlHPZmaRLvMKZ2tzmIxz1D8EFF1nrYsEeH31ZfnOJb/F75MdRG?=
 =?us-ascii?Q?cqYGUn4Xyg2iZP++Om7yB0058HaeC6qAGJElJI6AukomWTEVKaesqlikseDO?=
 =?us-ascii?Q?3gmR2UqJJftTdFF4sWGoTancd5Q3yryp1Rugdt+hPapINktnMX3PPWZXGpcy?=
 =?us-ascii?Q?CpLEhyB2cNXKWcXpXUu5WW9f8nW2OisRgLh/jukHtGCCHI8ec6SwBkmzoZK/?=
 =?us-ascii?Q?bi9qVBmu16HBzArzEx1KLcC7DY52p1q07Bm4C5nFjNCqzQ8Rvh0ojQ6ygtG5?=
 =?us-ascii?Q?iV1LDEICJah8cstZmQnidNBNsO4t13K9LO6GgnNIzLByeWZBUJeGCH7EcZtt?=
 =?us-ascii?Q?FF5muWCl/W8+kHs+yMzo82a5cvX8pGwkEyzC26OlTPDw27MYnt8BNsTZxlU+?=
 =?us-ascii?Q?EymcL5+Wi3XWOh+sbXBfhN+Ohvx0Za6uKpf0VtbJ/7H5hqragIVndz/NTghD?=
 =?us-ascii?Q?iQ4RjKIbLKs4THtG6Qx8y1fh6Jy+6kqoCr5Pm8otiNspX1Q2i6cDv2QQK1jX?=
 =?us-ascii?Q?IU0ro0qlzA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713e25cb-d1b8-4d64-a55d-08ded0c8a51f
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 01:42:11.9247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3o4/XmipIESFtcMblZGEdnO8GhFNBMYL+Zp7Gfb6EdB1eGCZeIVScrtKSGDjiDN/Ymmm2xmTCD2hFLI0oILzAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9348
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

On Mon, Jun 22, 2026 at 11:38:19AM +0200, Maxime Ripard wrote:
> On Mon, Jun 22, 2026 at 03:52:26PM +0800, Liu Ying wrote:
> > > Finally, out of my utter ignorance on the subject, is the VESA +/-0.5%
> > > margin generic enough that this driver can always rely on it?
> > 
> > I see several upstream drivers rely on it, see "git grep '0.5%' drivers/gpu/"
> > output.  And every display mode allows -/+ 0.5% pixel clock rate deviation
> > according to VESA Display Monitor Timing Standard [1], though [1] is a found
> > by a random Google search.
> 
> Yes, it's what we've been using for some time now. Is there any
> particular concern about it?

I have no concern about it.  Luca, do you have any concern?

> 
> Maxime

-- 
Regards,
Liu Ying
