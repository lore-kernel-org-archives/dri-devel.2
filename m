Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13265C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 22:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F8C10E50B;
	Wed, 22 Jul 2026 22:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NZKxokDL";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011014.outbound.protection.outlook.com
 [40.107.130.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C0210E50B
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 22:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipe8rFv4IWneCR0cMDSubHz4Y7HhdeOtzEJaX90+bus++YV831axoSHEe5Im2w4zqcjOwOhrLQ7vg+R4uwf50hqtKddCs85WVZDgZwvZd+9WM1LUYx6fwDbuITejSABlt2xMYIV4gBQtfEUgcTSR9/Z3Wtyzp+vlP7Hk8U4vCA7bJqff5Yu/Dzm5ua8ZrNZPIuTGxnkue0By1sVql0/KU1HaU96f3WiWcYG+74e3sYpkhWI5uOJ3rGifHdXsS5h0UZJ6Jgm5eDCgxiDpenSxAgSRgUoixYrfAlLz8Twnv5KJUZkPsFoDAlBqi017xXdVxOy8Nm8U1FZEcfXEjOF4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0shKYieWM1kwcO+mBa5XMM8ROOF6e2/nklXamO7cQT4=;
 b=F1xiTKZwPuwpoKt0f0gSLakjjE33geHsaxXlQjK/X1OzSK8rPHOWMRoMiE2cdZlRFA/Lm4mvDhgCRpQi5lfWK5ewICYDXuD49SkYcuTWxcPYdH4G1yJZfpVay2lJ/eNlxjwakta9ZiIVd2wZARQLvrFjg9XzLeNQwZzXLCuo6bgaQ5ppGhqWQqBH/l/KoFyHGV9plEtRMyF9rCP/OttBePjYIQpdhEo+J7czmr9d/4ZEJlzmkVp+kuDOhNFvVWrqdG38hZr6qJQMR1u1Iy+X29ZS43aAmDJNmpI8H0TdYr5KHjrAO3SfrsvymIMdiQJGeEo9RZ1UvWuZv2ZQuuo4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0shKYieWM1kwcO+mBa5XMM8ROOF6e2/nklXamO7cQT4=;
 b=NZKxokDLekKvFcrHer/qaCEawqfQgJzazsWQ4whtbjuZBjQNAkITgalIpDm0H0UMCHzBRjwr/tM6ALc4mHhOym4cwSdwGWLWNdDMeHX47e+O4ylsjnNPH2kxolEvjGFKaKULQ3DGAXuiTopLjnQNfkMsnjdXu/xlrR3uINpeHNaIeLDVOhBiXCeDPH1zBhAdlGAFgqzaK/z9zZ+0YJW+dbabgJIXnRORYlEB+/LxpgnkvMcVdOkizVI/HeYe5c+tIscZBgxRgsuyhCnyfX10gs+S6W+tIysmhTTfGyYqoPKOExckKuEciirWKy+5ZM56i0A6kts2+HQqXXU7vIVX2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10079.eurprd04.prod.outlook.com (2603:10a6:150:1ab::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 22:13:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 22:13:00 +0000
Date: Wed, 22 Jul 2026 17:12:47 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>
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
Message-ID: <amFAXwoM4j2sIENj@SMW015318>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-3-da797562636e@nxp.com>
 <alnCL7ylMyvGD-ui@raspi> <amAJL9TIcDAK7kbh@SMW015318>
 <amA8iVS4c0exg6pT@raspi> <amA_lUpWkbOFal1y@raspi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amA_lUpWkbOFal1y@raspi>
X-ClientProxiedBy: PH8PR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10079:EE_
X-MS-Office365-Filtering-Correlation-Id: dd51bd1f-97fc-42cc-ee17-08dee83e646e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LHHgsmarxxsvmPXcB2j3AjseS4Kp8zqYwD3SXo0JxmOwNmB9Nb8BgGko5oen0Ho5ZOU0bkeL+KH3+But9CcRdRU5U8w7TUsDiteEh2JqoHS3+ACJjQqUez162TrYJKsMMEtlXopVTODQiIShpKQh/eXz+MFCLCU6n25iZyVFKMtvWnN8buuFUDMzXPSP0lsnsFTjQWpDIffke6h0WlcYmgPd6baCpQ+OM8bvdWZYtQFo0WdEBC2dMirwQhNBV7FuoJwNd0KU8xKvK1+ONqJb0x/9A7bTyL9IyLMZ0F41RIjY+2Y4geE+PPo8o5IZ2GRBy3XI9nubiOUEu7QxqxTqw9+kZYZ+FRqODs7XxJH4urTD9/euqfPey8ELFxlJ1abHw4WgeOUvMnQKXfwjpvEQbk2PA+m98hiPUXD9Wl5DymcwWmmmDLC2+GX+zwNTTBUNvPqtBC2mq3ZoZphoKBs4b9gHrjQSbNJa5vK7Yxdsg0rUcjjnU8UrdGp5k8oF5gXwsniTPf9zoSaunZP2eyQ8ABSMxoDBPB4/whKfYzGR0TBKkaMcmVB0wChq56vJAK0nxfUaYyzQaZuvXpVGssSRUekrY2RuSIXrlxmy6FSGRNPoKkTImXSdvoY6iL8gjvQ0yyYdcH//3RcsAetB7k3ugCeAg42dpfijTK7T/0H3pH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XovbjLKpcf5etJXaB0bovGRaeSjchIB0TJbh1MInM9xefsO9kyYcxOA29xcM?=
 =?us-ascii?Q?1lRVr2GJsKGUbbDmb78GywACS5ae14NU+97Hu9rofEaCd6wTeyMH2hegHhTd?=
 =?us-ascii?Q?Icj+Fner+GU+tWhXuUyecEDpkzhx6gQOWUX9+guOaojAi3EpDlbwIJOw9/Cy?=
 =?us-ascii?Q?dGbwWrKDUWD/oPuX7fcLywyIT2NLa6/pixYN0AjMs/5XtJ73UggUZ8ck3UsL?=
 =?us-ascii?Q?y9dBO397SBk2VXFRwxplPUgBiTNx5n5tHJmv1m4e5JJ09mhcgTEP5hlFtPKj?=
 =?us-ascii?Q?P4sSUJ5EuAfjUpEsRCL3eWrFNjXIsQ309mTZcELTWDfDANxB0/785lqfJgrv?=
 =?us-ascii?Q?ypoLXm1wTdUO82mM4vFxMRwVsd6rGI+BmPKZ40/cNxS2OYDUDQ5PmS4CSFzw?=
 =?us-ascii?Q?XgRX95RzG/+1v/n3oL6Pi04AiBOa6ejQ3dqirTw9Pr8lYjciwGZI2m551NUe?=
 =?us-ascii?Q?593+FIjQrDT8u9C5HEVvIh3lXBbHkuHhoCOX9JcydWqq6fohGHpRR6liEW9o?=
 =?us-ascii?Q?ZH+PwgdJFT5Q7xu+ChwrxgE0oZwPMfvAvuTdeqEYKZaBHZSbtXjwFsNxrlCo?=
 =?us-ascii?Q?oxUZLxHWpYk2nJ9hH/g8f5jSq5aYZHB5BpdC9y+ZsA9/zlYv/3sqvoTyckGg?=
 =?us-ascii?Q?9lxQ5Ch/uvJt6b1WT+VyBoyontTWM/onYRYlf+aF7fLM9R+roqKZAxaVhqIL?=
 =?us-ascii?Q?Pw0wqokAcck9aV+oWkq/FXhGKmPJ1WKMgeLAtyoRPMXphY17q9Z6jKYxQ+uf?=
 =?us-ascii?Q?VijIhIxd2G+TwctxV5o1ZxTYBwAe8H69eZEbMdtsNqfZinhUjrH4fVLDpbNB?=
 =?us-ascii?Q?nU53yLAmnrTYdt+KagbxIdzrRpLin+46g5QRBUnYw6ggM/Mw4p8g2IY7r2Rs?=
 =?us-ascii?Q?fjnlV/J8Y38BDPjNtIdgTZqk/noWaUc98IGRRL/rKPHmvX51KEgbFezt51D6?=
 =?us-ascii?Q?dd5rFMM4x6lBpIDIicQX5jD9Ehffx+G4l8azfz3Qlnk7XMYKpek0N+2WPoPH?=
 =?us-ascii?Q?HSRH3giyM9jhw/FNKbrXf5y+7LlKCzvu6uIFF5xARY44h1fAAN6+gvX4FQr4?=
 =?us-ascii?Q?aDrK3+0naXKe85BrpLtZ/S969yo6dSf0uMax8k3VnFa78+1nNG62y9tmQiTJ?=
 =?us-ascii?Q?D8ENwxNTLM+lpVAuiZMH/30FGHr1E2qOB0U4V5jKPmOvr5vlm5am7FbWKoPo?=
 =?us-ascii?Q?JHZiMFCc5nTuHayObKEVTmQ85PVJdt604Cp3wydwrF8YNgxUwJ5LywhIlJRJ?=
 =?us-ascii?Q?zWkbAt8yH6CO00PNd+2QRgdnuxkuDuL+JkTNEIa1MjG2WhmLcNEbgcAL43P7?=
 =?us-ascii?Q?jZxf1xOZ1u3bal6YCIVsX9nOgoFN7pYjcwn8z5WITW7ZWXmMQ9lP76Wok8qV?=
 =?us-ascii?Q?AHOMtvup8n7Te6IyAbER99ezv6Dr+67cfYPGWzdUCVnORs+GoGMT2Jl+LVcu?=
 =?us-ascii?Q?73F5fdXGfOC0abWMp6fOLdeEizyEQBMxas+MmCEA4GsuOEkr3UBRijQ3X7pX?=
 =?us-ascii?Q?adhqJK5aNL2CfNGRSd/iXFmVM2OaSnLLtbaepGtXDNORxq4wVoYgVMrraDL6?=
 =?us-ascii?Q?vJO6UROv/v1CWPUZO+vIm86aB3m4FNLu+Mszb7Bfv9whkfo5YvBwZYkYe0uU?=
 =?us-ascii?Q?UnWDmj+R/QFgzrZMfhT4R4/8/7hi0Do0CIih+eV78Ih+agDYNu8h1aqb1q/Q?=
 =?us-ascii?Q?FS/opKlpoAR97ufu0WjXAYZd2bqwitbplOiD5ynXGeaL1SaG20acixsfG3vi?=
 =?us-ascii?Q?KSoDbmMLg9MnjrdtIFLg4+MZ/O8YHfVx3QsZfBM3R5iUrrYlIKLm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd51bd1f-97fc-42cc-ee17-08dee83e646e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 22:13:00.5939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +chhiabZd9qVE7kmNIKL9i5sQvLv4kmuXkRsEYV36Vv8rTBDktUYs8wMmWyKYGw8dDyzbOF39RT3cfuNjlgyVrv1NwBdA5qf+pqW+LzT2wDXd0lh8X/Ck9n0udimEDSn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10079
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

On Wed, Jul 22, 2026 at 11:57:09AM +0800, Liu Ying wrote:
> On Wed, Jul 22, 2026 at 11:44:09AM +0800, Liu Ying wrote:
> > On Tue, Jul 21, 2026 at 07:05:03PM -0500, Frank Li wrote:
> > > On Fri, Jul 17, 2026 at 01:48:31PM +0800, Liu Ying wrote:
> > > > On Wed, Jul 15, 2026 at 02:34:48PM -0400, Frank.Li@oss.nxp.com wrote:
> > > > > From: Frank Li <Frank.Li@nxp.com>
> > > > >
> > > > > Add support for WKS101WX001-WCT panel, which is an industrial-grade
> > > > > 10.1-inch IPS TFT LCD capacitive touch screen display module.
> > > > >
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > change in v2
> > > > > - update height to 135 from 136 (sashiko)
> > > > > ---
> > > > >  drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
> > > > >  1 file changed, 31 insertions(+)
> >
> > [...]
> >
> > > > > +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> > > >
> > > > Seems that the panel also supports LVDS input according to the specification,
> > > > since it mentions 'RGB or LVDS Interface'?
> > >
> > > Need hardware rework to use LVDS. Need remove banch of resistors. Should it
> > > be treat as difference panel by different compatible string? hardware
> > > actually changed.
> >
> > Not sure how to handle that.
>
> Wait, you probably may drop this patch, just document the compatible
> string in panel-simple.yaml and panel-lvds.yaml and use add a fallback
> compatible string "panel-dpi" or "panel-lvds" in device tree plus a
> panel-timing node.

Look like recently prefer add panel-timing informaiton into c code instead
of put it into dts file. But I am not sure about it. Just check recent's
log history.

Add Neil Armstrong for comments.

Frank

>
> --
> Regards,
> Liu Ying
