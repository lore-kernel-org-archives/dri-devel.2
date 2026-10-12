Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43E7CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0567710E635;
	Mon, 12 Oct 2026 16:30:19 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4898910E635
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 16:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxuxP+NAnvAJKvVIPg9kHev/bbuzClzbyXLiTRJxHaF2SYnNCHo7WMl+FvXcVLTn0im3ZHhMyGQY5sMD5yLN71W1lMfmHjR5qZSGXQq1veWXVO/HhKUmHqRG9ospUI/Ty4GLtmZdCGaOIOdsOfEPh35QESCllB2K/7pxjAZoINNLL5wHxRyPPBuLAlxvLWFuHE7n/xFRbXEKoGzvZNZIIB7YOlhehJD4d5MGkAfvi8smzKNP+ML9NSpM7WFoWF68vOpiaaQVzhNgmFCKQ4+BRymHI20X/zbVPEXiw3rI9MrCYw26PoW0NohqIFgSBjLekGN1kp9Cnu/V8x2LyjElTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNgwyircA3f7PFdz2njO8x8rSz+LCkATQ+ndGKpSSmA=;
 b=rrV9cB0+vRNj7x290Ell4uTKPl73+XOq7qrCsng996cygDZyRTJIy/jz6KaAxCGbmc3v3v9obeHWTOjOs0XmmtutmVJwrS4ND6hOkcGFXrrlWBzhf9FvRvvxMl9xd3upPmuJxMYDDgE95KRWtyC1MTp3VccjXF+oIfzWyRP9QILawg0YEk9JAK7kuFc83LWQxkvNu4+cYV76WQCNlCYWWA9W6KaR20goc4YHy3hHAJ2gxTGNHn9EX5eIUPIGv4v9sILSb69HaDA9aWcubfpn2NSvDfrxNcH6prBuhT32jPzIG4BKYAMbBQ/fqCWgruDbpA5m76+ypQTq74ni096VMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNgwyircA3f7PFdz2njO8x8rSz+LCkATQ+ndGKpSSmA=;
 b=Z9cbE8JP+9i1nN5GrnLn0LkRpwx9YiP6KZPcy8G2tmuT6dX5ra7/fFlASW6Sf5WrRgLNfAKVpW7TPfjRKG4BA8jJNQnIm8cDgBFwOjUFsLhxqQ5nI3h4/JaLp+tnNk5Ut8K2/kKJHRG5vbFHjvHQIbzZPB38LswAgZNFbHc1l0XWKpIIOeEj0ZHfZnK5S7MwV+Cy717RfpEalym1ZKgC/tdHutzB0y4Df+Mevn/dJmXNIEA5CO0/1lmOMB3+ldAKG7g/zZwXIOF/k94ZVseb7ytc/Ji1XvajSiEeL6OKUJ0P3dSQBlWloggioZf64u0iVkoLRV7uXmWWIKHhK5MPUA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MI9PR04MB290196.eurprd04.prod.outlook.com (2603:10a6:290:86::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 16:30:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 16:30:07 +0000
Date: Mon, 12 Oct 2026 11:29:56 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Leonardo Costa <leoreis.costa@gmail.com>
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
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH 1/3] dt-bindings: display: bridge: simple: Add the
 Toradex Apalis iMX6 VGA DAC bridge
Message-ID: <as0LBIphr-rlTE4U@SMW015318>
References: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
 <20261012-v1-apalis-imx6-enable-vga-v1-1-8905d8746504@toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-v1-apalis-imx6-enable-vga-v1-1-8905d8746504@toradex.com>
X-ClientProxiedBy: CY8PR10CA0046.namprd10.prod.outlook.com
 (2603:10b6:930:4b::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MI9PR04MB290196:EE_
X-MS-Office365-Filtering-Correlation-Id: eae95202-ecbf-4fc5-9798-08df287e13f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: JXV1DeTdZy3V47Cdy9qBX394+EqphRQLWzL598V5VhPzfNd5n3BBjWPjQuaLoAOAlDX4Xqe+BvJ39tVQ6m+nWIWLNz+R33IVfEa1v9XdHLNySdYVzP/RBXfl1Ck21dF6v6qpZviR32zJFA5BBkzdhNtmk9uGc/h+CLR/0u6mU1kYBwQ8anxJnA7EC39YhWbLrMKd6iQnY03/cWo1nDKBQ7KinvVF+j52KfiCCKkc0tDsMh+qPifbUCy6xqjfv6bM41DdFfmjnozX4We2Ibu1ebaX3Cbt2x6tI5Ksnxs2xcEszELg+/38NcgrqlzTjgQgp7/qtOyys/WhsCRAdgD/S5WlgZ2c7Gy31NfWU1rtGyIxvNTy1MnqTkiX3EpwqoH5sga1mshQC7r685X9nn6bTmAeat3tpJidiFAx8MwzZ5jsH2yAqrvdI849IqdFMx0aSSqLZNyH0RofQZ17nI+tNB1c2DTWO98nQSNZla1xgTz0MgvnpPl/whai5w1yE8aAEDKMmZ9KdFAQlqzHwdNQcF8PMpHo01fV29HUcBb4KiWeVt7X5GPmpfJ1mKCVtfcLWS/6fGNtNPPSWSfMhN9ncouk1TnjPDI8vrVbw+NS08gQ0DiSlJ5Xoljwyno54DxjBgX26Rox35VH4afMGoOuB/Nd6Zo89FUs6viquXmb7is=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O/oBgiFoDeLY3nEACpJY2TqB/x3QDrDotTnIl/mAKTxx0sfHy5jIq7t1N3AX?=
 =?us-ascii?Q?UH0Q0jVGflftH5FBC190Or+wwRq/LhOxKohFv9LO6V/MVL7Crmtn0TSPks2i?=
 =?us-ascii?Q?sct1uhFQ8kbnQSM0ajShbqka1L2BJQb8lbstQ0eNS3ffmW2izAurjb6h63D/?=
 =?us-ascii?Q?Y4T2yeU/Bxwa5TEFRfPCJEOE9hM2lIC7jv2EYfL6SP9jJiahpLgRl9DBPNoz?=
 =?us-ascii?Q?e+kHwi1x2AairaaS0eIP8hnyVkEU5VjcHayJTRiawW7aozS2UybwAr7d3qUX?=
 =?us-ascii?Q?5qDsne/3cPR4rIRSbw3aZU2zjoi2hNVGuugS7RCVpgiwjnxTYeVMiWZDX0m6?=
 =?us-ascii?Q?SYwMSknAoDtl/pE3EE4jy67gDhChvm1XTgdiWkUulsJMsDcT9o/0+amNtwUs?=
 =?us-ascii?Q?gR0hAc4hdY8gaXHK+LYR0yUCAhz72/9/NRi39r/GhebK7440E6FHzy144DCn?=
 =?us-ascii?Q?gh/T1SMe8kyLT1bA6i6KgNfcqm2IsiACJVW01lLh8/ErPOa930+dQq7tWmIQ?=
 =?us-ascii?Q?2Hh41nMy/bcS9FytDCbyDvy547kgwLWeNQEuyYKhDiHdEVLEfoh2bUtq754I?=
 =?us-ascii?Q?p4IrDB15e+LY47qb6slv9e/mD/6gQ4dG7bJGweXQKEh6eCdvKJEIH+CQ3POQ?=
 =?us-ascii?Q?V2QoSmy3Fo5nW7EsfbB0IGRMhxVOXfec+/zOoUpcvV3iQjSLexLllb5Mycla?=
 =?us-ascii?Q?tTWjvIzv/228dsb7lrDxJKhavGdrGQyHTzMl4v0ggf/+1pYtTrIlmFhyjs+k?=
 =?us-ascii?Q?BwV9Xu6/tJA8Hx/LKP8T6Wpfh/d7sAssngEwJkShPsHC0p/S6hiGuHwy1VdG?=
 =?us-ascii?Q?Nd0rgMMX0auNh53D+wctXAEyTod0Q/rBbOJ50y5Cv1cwsXxRvC9mVRxMD265?=
 =?us-ascii?Q?XCY6PeKAHNqvQyPO28JWSDF3aSOjqt3rMnd8Vq+HXs7Kqkg1uM78dsRd4qDj?=
 =?us-ascii?Q?jxR2B/bDtQ+Gt5gVeLPPNFNLlYtWLsx/mBSL6uySmERSKADqFOe9EFCp9GIS?=
 =?us-ascii?Q?kmLgKfdpJ7+Gxn0KS+xrapzrBV9SKoe/M89ZE3+CY/PKG+NnvxWFsfNk7uoH?=
 =?us-ascii?Q?mFOuUH+vwtpJRseC7X8/XM3h/r3UDO5PIk1KJI+L7LLGvxaSPq3Vh9rbJCaA?=
 =?us-ascii?Q?A75gwGzPxsJhVroTGj39bdt2YQJtuI3QL9NzOti8q2+0wV8UQk7TAcc6rl8d?=
 =?us-ascii?Q?W+jVpmNZUT2lwU7+TD6DVcNKvMG7DHn0Nls5h2Erem6MdPXv4gPgoC4sbDiY?=
 =?us-ascii?Q?SwOtr0uljeogJ6JsZBpF0BcwdgD5L163LpVJjPGEcE4BwbhWBcRbASImc+Lq?=
 =?us-ascii?Q?Vr17IlnHpBuKTtDdWb0CWpx0aQcjMDa0sFM9XOY66yOYInvIU59K0npanktp?=
 =?us-ascii?Q?tXaiNCC9e51ryZBS9tPxKrAaY2YfyJPRhan4RT9uaL9rH2nJ1BEyPtRJDtud?=
 =?us-ascii?Q?2RE4TkW38aWdkWhr340tixsGmN2fQ6F8/pnEjV7Tf/BL4dMP6Pq4mTcs2M1Z?=
 =?us-ascii?Q?KyWSSHL2v89g9twwxVHlpzuA8qjCjyLLUDi2/OHLCuTz/5Nrtr6fFBd4wHOy?=
 =?us-ascii?Q?bCo1SqDaoDb8JH3wz09HUC22Y3v+xlm5tX53ghiONYuoW2bkoUJBAiLxIElj?=
 =?us-ascii?Q?Ya2jKMU7/7hjvyNXKuMNM9BSr0y4Xh8jzFohut+LvWo1G9PwZ5FVQWlNn1cd?=
 =?us-ascii?Q?Ir3duPi8IsyiGKQBWamZzPUIZctqcc7zoZHpeqViyNsWfX9zx0BKeCHWydsf?=
 =?us-ascii?Q?zHoNC5kMU+uBJUL9nwB2eclGJkHeHWX/4BdAhn7S5rp2Nqp9jrCn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae95202-ecbf-4fc5-9798-08df287e13f0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 16:30:07.8531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmNCrQovN3wqI+aNrlNb9O15h/WkrwvsuDB/3bJbfNAb5jdYLBPze1+G2MixJK3Gu5zVoVXx7l2DvjxGmRtrfSruOQISLPthZwg5k+jvjxrJtuAiqQeaC53FXeDzU3u5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB290196
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

On Mon, Oct 12, 2026 at 04:25:23AM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
>
> The VGA bridge on Apalis iMX6 consists of a simple resistor ladder that
> converts a digital 16-bit RGB signal to VGA. The VGA output is gated by
> an active-low data-enable signal.
>
> Add a dedicated compatible for the bridge, since the generic
> dumb-vga-dac doesn't describe a data-enable signal.
>
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> index 7636c24906ba..a86231a4a908 100644
> --- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> @@ -37,6 +37,7 @@ properties:
>            - ti,opa362
>            - ti,ths8134
>            - ti,ths8135
> +          - toradex,apalis-imx6-vga-dac
>
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>
> --
> 2.43.0
>
>
