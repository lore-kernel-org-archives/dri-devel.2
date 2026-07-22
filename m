Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5EFC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 03:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA98610E2BD;
	Wed, 22 Jul 2026 03:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="WoQUJK1v";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013024.outbound.protection.outlook.com
 [40.107.162.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98FAE10E2BD
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 03:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9TM/6zmF1r9g0vnBRstDbEmh8C94NxGwYU96F7GnsfnVXTwWcCGIZDO/oUlB5ejpKSLH/KOvH1BktJRr/UeT3hRfkooXwTCgrjJ8dV/olbONis4qZ1v/9eFWHjE1NHKL+T3qT3lpWSmn7liuriZ5R7TbhdXyfT/A1a+ToUxX/UwoRxfnABjFGwIr5xPuHYERlS4HyBUP1rB8XQw+DtCFkZ7DRaoRckND/o0jFWJQADKn3JONTZliRyIfFvI/SMFmcDvEOZ4vRuzNISJLdgZsvgdmsdE3NIX26AGEQA5OUI8LtGXfLq8B/KKrltdte+e0LkogFBOmqXvY2IYI+I57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYfHt16VRr+qcQXHAXWmIMDcdPYbR2MNfzgj3MZXoDY=;
 b=yLbvNYXOLV47lRK4mqjWQ0S4BYu6FvESckYOqsa7cDojibsdp8dtuFA+IQ6/rewlBCgNPBt3/fjiv3Y02POpOvy1TY84V+wQa3uaW3cvJKi47TdDeQAQ0R+vsaP7vXPGa1pcMEiRUFWEUn5vFM0p6q0uH4QrqWS///O6oSeZnQ9USHO92fYmwxsZ8aoCQbv6ZW0Q2Vr9g57Rj7V3tYeR5oreq4fdAztRMxe1husjz3t+g//LKk693mX3POXmPCFn+aeUnb5AfeH+PXzh7YkcB0w0dVuQYXkCXlOMXIYIHKFpLXE9pwxiA8IFZ03rIvREV3C9QKF4ZZmqVc9EY4jqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYfHt16VRr+qcQXHAXWmIMDcdPYbR2MNfzgj3MZXoDY=;
 b=WoQUJK1vW8r7Cyc+BVj6/Pfj5WFHniAM8BA3FgSkcxZY0U/TvLrwGJJR8dxIImfHB9yz/Au+gvTeI0GVE7y4hBRDjsiMuwX2ZGbsAPVlaO6c/BLWAORGmjciSwKzCf9b1iraWa+/C+C5n5hZ2eo60nxs1zoNh6cEzT9DcywfKhph2Hmc/q0FmsJwsVqFf85rE7xcglUdJo8Ad/ZRoWe3usDo8zmiqso2vKIRc4OxxHeMrpapyfACa4csRwOZYY1FjIh3jZV2eN++s5DnmcyepGEUB/XfplgTMhF/O3byiNrnEjLclBjPm7b9GzEtHFcpqTa1vVmA3m75ZGuZRZa9oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by GVXPR04MB11653.eurprd04.prod.outlook.com (2603:10a6:150:2c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:55:44 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0223.008; Wed, 22 Jul 2026
 03:55:44 +0000
Date: Wed, 22 Jul 2026 11:57:09 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Robert Chiras <robert.chiras@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 3/7] drm/panel: simple: Add waiken WKS101WX001-WCT
 support
Message-ID: <amA_lUpWkbOFal1y@raspi>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-3-da797562636e@nxp.com>
 <alnCL7ylMyvGD-ui@raspi> <amAJL9TIcDAK7kbh@SMW015318>
 <amA8iVS4c0exg6pT@raspi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amA8iVS4c0exg6pT@raspi>
X-ClientProxiedBy: MA5PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::16) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|GVXPR04MB11653:EE_
X-MS-Office365-Filtering-Correlation-Id: 6993464d-834c-4e46-5b2d-08dee7a51ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|19092799006|366016|7416014|376014|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uFQkgVTyKj2V+6KzesHkVan8DcVH49b07a1pyJYxwgRXh1R+JW4hcUX5AOV5sObbZOhKegWRWF7za1OMQfjZJnPVVRXlDFYctVeuYGFvL3F7fDPGZ5L0W15K0fbf+y75rKcnUI3tFXxeZLZHVfCAEG65PvQ3lPSMt3Jtqw00VzrE09tBb5CboIhV4PTdWJ8OBBHzwkamWcFTr0A8phaOhU7pesf4age8eRIyv/BtLpITMOgJoKK78gAR2QwazmhUwqscwaU1d0T/iBKlYbTcK76FrAqnjnv4Yzj6ZuLxkdrszeuHAw8ENyxzXDsR1FF7koWJICSQ+3fjvEG2nPhi0wkqpaBDYO87YzOxMtHMyXkAk8zuDg9iI2pRalGkrQhiEtEPPbF+xmoEhQVSB3xXQRdTFovDn5pBFs4opmQajpRDJKUyAGas10gEPemRgwdsQD7Fv8H9v/KLjuGpe+djMEDDFOVGj5o4ipFcH3Pbiu5BV+q5FaD8cP7TUvYZ4MMzSE1rFOmIsUzYwZOsK6FheFjbddDY/r6FKD6XIgTDSqaIaHeOsd6PAIV1dzgwA/ZkVM2AnQ1y0a0kAolptO8U6FRouryqechqiUkVjDp+EyitmeV6jsi82BA+pWgCJ00ewS9xkfAfkjdf0Y65GDthxbJHTCWreInKIPaIEbHag8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(19092799006)(366016)(7416014)(376014)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PyMRz93njtPzQwnJoX9+QYktzYQ36mT72euKecrH4HJG7EUUXPntd97R6zkF?=
 =?us-ascii?Q?KUs1/WM0BiE2lKqXZr6syrBVpF4xwayDoiRAnsszseXkiLCdCgZAu/ZxaRAU?=
 =?us-ascii?Q?O5uB7QL+9KGooHtgoweh6TFZTLyBeuRVEKYlIpLqQm7f+SAFJg7nurAQ4fn7?=
 =?us-ascii?Q?Xikow8sR52xHhc/Iyd5F5/6cKiZ00A00izGKUAPwNxwEXX3Z4FmEbjZfKSNN?=
 =?us-ascii?Q?r5v4hm/xSxpYIBMacLHNZ0K8toFAW5aFsQayPVTC9CXrbm18ce9595NRRlVi?=
 =?us-ascii?Q?d0oDGqPsVzSx3MIhPHulLxZu8/NXg/S600xO1ChUQhqXhdhV0pwL6jC0nDmQ?=
 =?us-ascii?Q?cUP85qbjsUQXBQdXwrTW0Hyuk5LHMV0FXeWwmQ5k/zrQs0Gmk532ZLVoxCHK?=
 =?us-ascii?Q?yan2ckpiNqE9G2nWWWVP5KQPG3UpN+/CYncetGnjFom64H5N+yopHIYqY++i?=
 =?us-ascii?Q?kw5i7TETJeaJpaWPU5EYxUuZTWWexAV2OqIuUvctu+Ixg5bXCjIAcItkBiqK?=
 =?us-ascii?Q?3wb2SeLj62brtb0kRLgmSLtnx6wZ40H5KFwd+Vcuc9tFsUd8k8GXC40XzFdY?=
 =?us-ascii?Q?TDtOZc6WVYc26nsDJYM/1OeM+AuZw+El98q9zJ3vMvwqp9jkmQZvGfJdsafU?=
 =?us-ascii?Q?Jwual0YPmbu041HavZR9JLc0NMWSQZDrkYt+lUtkSj3bkjlwAeHn79BkWTtB?=
 =?us-ascii?Q?b9s6gOSdQXgvNcZ/LITPQF/0jsVBw7TOf6OEufSpMR4Oks0mdyJBE2oLAz0n?=
 =?us-ascii?Q?yaQE2yiv7rbOepY9oE7gbyyVH6ZpjGpaSEt7htt0Skt3wWk7bsnbxibIFEeN?=
 =?us-ascii?Q?Z3mEbp0RAZYsNGwTQRPhR6fH66AbyNOE2c29amWqCT6F/cSGry1MilD2FPsk?=
 =?us-ascii?Q?4zIhXq5qxILcnoqI9R/8gdl09OQVjJq0Hh1ESuDSZa85mhQtkcEh5hEOeb3z?=
 =?us-ascii?Q?Mjl01e15Y6uSX1R0YXMCzmjV60t5LhuZToXnQiQ39zg5s0F5PmXwlKxdOdiW?=
 =?us-ascii?Q?aU/bF5wSwBs7eTrrNAQimNmrkZFTHz9PFERS3koZfNX+v8lzYlWrbFRtjnYO?=
 =?us-ascii?Q?WuITh0EeVhjezV/Fyn2YSpS0RgMOdaNfPMA04GIqQ75xebM5BuSU0DrSaYeE?=
 =?us-ascii?Q?lVNM5+xD+3L9FbVzty9YDcvP1Dtv0ilGsbWFiJT446eKWHD2UDIp1ILB1ppj?=
 =?us-ascii?Q?2j2EgjMe26frq15v4dBqqgOD+8uJ7hjOsixbalZBosxeqWeR5wzM8bTvjAKv?=
 =?us-ascii?Q?/97j30+z03KuusfrtBCkxjCQqR/imwvEnmYJ608/asull2NVhWIh9xJAg1op?=
 =?us-ascii?Q?UvaiBjU6QSJ+FOhnUtCu20xG1yCwxJ9/lG2JrE+M4olrb23It9VOkP0MSkof?=
 =?us-ascii?Q?TLUjIROBOtrkv/Zm/SxyKNOd0ZDvyh1G7Hq4TKmFNHKGOWQ3RDfQH5WCRHUa?=
 =?us-ascii?Q?7uNfhNrloDa0cjOh3GcsF5FM7IlmuzzkWsS3AujkCBHJWSKdsUKpgOpxVK74?=
 =?us-ascii?Q?pIqGqDRJpme/4QTpA9vV+EVaEm2E6LPDP09T1XiZ6QF/AHdEu+qqJi8cA9Oe?=
 =?us-ascii?Q?apFNDSqSlwixKCj0JBDmopKAMVJyE6Jz6QPsq9Duj7TlXS8xIM+Tn+RsFmP4?=
 =?us-ascii?Q?DKciN+v4d45IGKtYKCaQmsxVhEFeeAN4oGSsSDjhxsVo0/CWZ9v5pT5o5W//?=
 =?us-ascii?Q?2pZNosAyGiiRddnacnr0WdS4NGkwGou+MwEtNwcRLhtekfV73QP3HAcdCoKK?=
 =?us-ascii?Q?RAVfsuF+Vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6993464d-834c-4e46-5b2d-08dee7a51ae6
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:55:44.3040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVRBf/eFc26y8CEF9ZLtNjF0PKB700VRj4Kf6JuZKotsOkKBdkZcWsvnIdGrKQR1n2tcQ/uuYuoMF0h/yLKgDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11653
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

On Wed, Jul 22, 2026 at 11:44:09AM +0800, Liu Ying wrote:
> On Tue, Jul 21, 2026 at 07:05:03PM -0500, Frank Li wrote:
> > On Fri, Jul 17, 2026 at 01:48:31PM +0800, Liu Ying wrote:
> > > On Wed, Jul 15, 2026 at 02:34:48PM -0400, Frank.Li@oss.nxp.com wrote:
> > > > From: Frank Li <Frank.Li@nxp.com>
> > > >
> > > > Add support for WKS101WX001-WCT panel, which is an industrial-grade
> > > > 10.1-inch IPS TFT LCD capacitive touch screen display module.
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > change in v2
> > > > - update height to 135 from 136 (sashiko)
> > > > ---
> > > >  drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
> > > >  1 file changed, 31 insertions(+)
> 
> [...]
> 
> > > > +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> > >
> > > Seems that the panel also supports LVDS input according to the specification,
> > > since it mentions 'RGB or LVDS Interface'?
> > 
> > Need hardware rework to use LVDS. Need remove banch of resistors. Should it
> > be treat as difference panel by different compatible string? hardware
> > actually changed.
> 
> Not sure how to handle that.

Wait, you probably may drop this patch, just document the compatible
string in panel-simple.yaml and panel-lvds.yaml and use add a fallback
compatible string "panel-dpi" or "panel-lvds" in device tree plus a
panel-timing node.

-- 
Regards,
Liu Ying
