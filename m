Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CC9CA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8302810E208;
	Wed, 30 Sep 2026 15:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lShUrDFK";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013061.outbound.protection.outlook.com
 [52.101.83.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFCC10E22F
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 15:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuSIts35AD99PLJh2f3NEg21v29WmUmTueDflI88Lz4pBHHhM3/iw6YZD8Uc7QP0Jsbzpe2IUkPVria7v9yYWfRwqjDI0aE0HCUvX9jXZC8PIYY3lj+UK3OqUG7A39lZO2dtjGrhJLiIBIYYZT9whnZ7KDzORQCZEb4B0teRZT7mnc1PM2J0NK/tID2dvokt4N3jJ8R+D5SGbFYWion2TgA+RmHavVcgA3n5qdK+rT+tP+QJ+ZUW/lCHglCAzptFoXtToV/a8/nNanrzL9CHIvU0Bky9dB+3gfcmL/9tKzPJG5eX5SRZ8STDSIl91zPgyKAUQdZYiwom1XFbGazMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wQL+r7w0PKT2kUsqlmUXa+mA8r2mIQvMJOIWzO7J8w=;
 b=R0eYFoPOugmxhC2f5+kuT0knre3xkN+kR5nUyDZvOOdYr6APq15hJPAdjjt5nQ4KTMkb8Xu5oevL8NwWHLoZd3AzoveJ5edizhy4Jcj1ppgWhtEAuUwdTVHb7LPoRUmwC4rCfedABodlGt/NXT+RVz6/on7TaimDkqr5pnjgf3B6IIwh1IBCTxvxnSaMUzvCiZ7fJWLMdQP7l/jl+73YKDxpNnjHLL2xlC65H/PlTk/q0YbYRrmkIdId7IMB3EcjsRdVJbE77F2RLWaDoou7fsivf9hJwjbhMbXTUrPVlkdxFOkV40PBfoZa15pxBALl9ha/f9BES67bVpL5N8woUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wQL+r7w0PKT2kUsqlmUXa+mA8r2mIQvMJOIWzO7J8w=;
 b=lShUrDFKUf5rrcFn2vFZQioDruYsbbsQ57okLzJUgztDWbBpcL2BUq2xxOsSSddyR0q6y8moE5P/VfOdHs5t+O7fk8Z4LdeAAbU8KVBM/ezgI7SyCKmS/9HzgKzU5Bs7kiWQcnqMI08whaFomp7AaUa0V5Qpf4qTltk4WGp1Tvjhc+WFB7J/Tz+qyfmUBZhmZW6Og2+3qTp6x6P80cQ4skXLsKPfGEIRZFXrzMdH72njJWnGl3Eca55TudYzzc/szbmKabCuahExYbD0cp4/uBZLelrJF5kWbCqQtPCizbA5kS+YUyIs3AaLz2IS17fRzx3Oy9PskE9Vk0GYtA2r2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB10356.eurprd04.prod.outlook.com (2603:10a6:150:1e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 15:56:36 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 15:56:36 +0000
Date: Wed, 30 Sep 2026 10:56:22 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Guido =?iso-8859-1?Q?G=FAnther?= <agx@sigxcpu.org>,
 Robert Chiras <robert.chiras@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 2/8] dt-bindings: embedded-controller: remove
 #address-cells and #size-cells from required
Message-ID: <ar0xJqmSOdZCIW3Y@SMW015318>
References: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
 <20260925-cleanup_dtb_warning-v1-2-f999fafbca60@nxp.com>
 <20260930-light-whippet-of-fruition-faf077@quoll>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-light-whippet-of-fruition-faf077@quoll>
X-ClientProxiedBy: PH0PR07CA0109.namprd07.prod.outlook.com
 (2603:10b6:510:4::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB10356:EE_
X-MS-Office365-Filtering-Correlation-Id: cc64dfc3-0750-4b68-f23e-08df1f0b67af
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|376014|1800799024|366016|23010399003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ++OwVAnpyZV8uyC4sKLjlGlioSJT2XCsE33K5b4moFdKq5FynXNfIfU4LcxUoT1JCruKv7QcgN93WzEPyF+teAj6u/pcl5JjzY49ZgR9akQxwfxISk8vv5LJ73ceW23JyrNWcPivG8jCsSvujG9j3ApTLJudPFieybAkNq3M0uya9zwymosdajFknLIfNPYEOBs90iQL7fjP1fyJgU/DMAZgmtMLZet6ubes15P9PPo5iSaa9Q2xf9edhKGxHXFmPhgVHn6p8zuzOGvkBzD0sGySkLDP8PvHUhVgVSHnhUPF9F5n51qJEW+VfHVOo99zP9ZVkJGfgbdUrqluJzgsZF8A397QWNR0z5p1Jtkmf0Ra+OdZyvDcfb/i4tC+2TSpxMDZG5KBAtrop8JU+kv/JvXUizAF8dCo4AxEy5V7UJVqpySVASrSOtKkfhSMjqkpHDJMYKwLSn/o5eqagikF7WhjGEDhVdNbD6rQkFzv7P6o+CmYcAyM/t+fqWvZK/UW8kr/9kxTv8m6XZtdsba1OYA17LG+xBKsbVUXoeEjaeioH+6n2SgFvmKgKo2fqyQAl8gilqAySDHrVm9vxPrm6ZKzrFtGlfk9hVIIQ31rNRRCwOHfrpSelkblcvACKiwx3e6LSP9SGzttxNmnu+HRJQz9dDUQM4Y3stAq7BFed9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ACg3hxHb2iPC5FquT5NaHCx8e9VBNvlk3oE0ePb49P0m7Y/77jTraJdCFcSi?=
 =?us-ascii?Q?bLkJsUw4gKglzpk5drwd0EwQdX/C413TlhBdvmyyx7YyBItv3IRTLHjDZg98?=
 =?us-ascii?Q?Vv/cORSCey6wvudO/SYuPjmdS8TWEkkdLSPKiqUnLq6Q4xNegaYHQYYx77uk?=
 =?us-ascii?Q?H2B1O0C/jW6+ZZ5gIWdeVdfXuq+y2z0yT0lJdLzSyfJG93erB4PP70swGCgE?=
 =?us-ascii?Q?HosFmYCfbsDSJjVjSX/3mZlx4UKisAfBZeHH0aPg2CZMxa5tK6iDBNS/P8+K?=
 =?us-ascii?Q?9RpFRZAlR0ca0+Iz4nyE0DxLhGne/9nWaZVBufD/DMpDVY2cHGRgv4NNH4eE?=
 =?us-ascii?Q?3TcBLw4dapWDqwIfhpget6i0NbT3ZwFuLgyYeA61JbTSX2fvHGajCTckuEQ5?=
 =?us-ascii?Q?I9zKti6F+wHe4XkD8ZlbtVlKfsw+3TyM7oC2uLEqlKLoaDQuQqZ5xLlwUHu2?=
 =?us-ascii?Q?CKwrKGOXpoyw/Dp4BjpPb5lYiq6HrIkwB/9OyttbEnpEyknIiz7/+uFy4wN2?=
 =?us-ascii?Q?WEeSBXscSi426p8M5JZr36dD5UVVEzm69Kxd96KWy+02ZfgmbkEuVYFjv196?=
 =?us-ascii?Q?Ff077WlbzXGsWvqdXS9jUI5YfGRNkTERgWhZpRYfjtPrJnyT/hyPKVgFPZzb?=
 =?us-ascii?Q?NXsCA6cuwRrt/yCO52PfAQEFazyj67rvFWbrLhFHdaEYoIjwB+JthwJhhIlm?=
 =?us-ascii?Q?Ukc5hpY4O1d8ZRBDzokYDA9ErixSZyAHRafzCz4+rD3tFJNJiJ4LnR0YAaqp?=
 =?us-ascii?Q?bRuMe3n/rqfVi0CmtMIAZde3mXSZ9YZ8pvCocnmAe14aToWQlKXmdJTxxgY0?=
 =?us-ascii?Q?LXi8qvI/T4716RqjOTlnQT7NuaDFrze2vJiI4tPXWwJkSCNseo4lNkw1rBsX?=
 =?us-ascii?Q?uwT7yJvJsIhwDkLJ5guIUyIJWnlXLDKWZsxHt1SjRdRtRacFqLDPwMVC1O3g?=
 =?us-ascii?Q?1iwfvMZIrhRs+i/G/gwBWbkS/HROSNj4Yy3SvrHkiWlPO5vWkgdO788txi0g?=
 =?us-ascii?Q?ZDY41/6JqZ3XCuIVIlQbQeKImaiJ/mH6POlTLbv67soAsXaKNsOUOOy5f9u7?=
 =?us-ascii?Q?UktqwSOTCrtJ13+7OCalrh8uqEvlgqYL0K12oNUP+KOt0gxkg844APSJo9Yl?=
 =?us-ascii?Q?ZIdpQqQ2vFWqUjOQ8FpsW5XRbkQM1Q++2Nw1BaSk2T/k2AaZeabLDUgm+NDo?=
 =?us-ascii?Q?pZX/v+QuT/D/2d+mFkd3wotvVfbQmMFUwwqErceH0tVerj+RdiHpimN1CN5y?=
 =?us-ascii?Q?wnEYtxS/Y82mqGsuGp+GAmOyBZK0bXkO/FkxYT6zWs8+H59QCrAkESZyfMe6?=
 =?us-ascii?Q?ZthblkAYl1XYRjOcGrv7atJqoXUUjDqfiAzxdkHXhj/cCEODsW5Lh9kQRjq8?=
 =?us-ascii?Q?Z7cVhkfZ0ZMuAtI5nS8ZxhhAatB3zD582UVCBM1r3NcJceXY4WLggi5nssdX?=
 =?us-ascii?Q?bms8e5ohyQp5aTQvR8ehR6ZkVNSs7HjHcmc+FDtA7G0NQP0DZsDDwfFdAzgn?=
 =?us-ascii?Q?V+/R2I+uGKgeEVCLAziWRqbzjT91p1TCoK8tTNe68dBZkWRrlOJ0U/Bp53vM?=
 =?us-ascii?Q?ePieuh231wGIDwTgS/Sjs4KXxeZyl+S5rSX6VeyoWL1Bq9qAuq9adVsqQekw?=
 =?us-ascii?Q?JQnFsbNCTCZBmnU/h56Ke++hdLVgdBMVK0kMg0ttdtepDwsBQcSApD/NrMv/?=
 =?us-ascii?Q?fTlvuzRJP/im+KkaGriiDhHPi52bsAH14tr6qgJSQv02CjzKAupSRZ+Lnaq5?=
 =?us-ascii?Q?wSl2jyRHfUVWQE49toJXz/YBWmAIgB5SYr0FAjKaZcdImBfa+Sjl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc64dfc3-0750-4b68-f23e-08df1f0b67af
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 15:56:35.9801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVRD6ah47HQpGKVka87aeKNA7eI+MevapBUWTfpvaqr1gjF+AMo09K6jVuiW/O3cZvG89sDBbhkRMQsGDX39q7m1qA56w2vuusZEfFSrM0LaoMPiRCPmuxktYaTxJ8jE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10356
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

On Wed, Sep 30, 2026 at 11:59:47AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Sep 25, 2026 at 12:37:51PM -0400, Frank.Li@oss.nxp.com wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > The "^fan-controller@[0-9a-f]+$" child node is optional, so it is not
>
> Why is it optional? Hardware can be fan-less? This should be the reason
> here.

binding doc said as

"refer to the board hardware user manuals to see what features are present"

fan-controller is one of features, which may not present at boards.

Frank

>
> Best regards,
> Krzysztof
>
