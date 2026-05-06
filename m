Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C21ECD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 08:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB24410E151;
	Wed,  6 May 2026 08:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="oDNUNejf";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011029.outbound.protection.outlook.com
 [40.107.130.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D3810E151
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 08:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9MYbzCtQ6eJnS7XMebnncPg31RNfoxJ464CXWLob5Irk2vOzThRrRsbDFzHA6k72WG3/pJ6KDRJbk/Ppq+8pOh53w5dhAo4Ru13c6IyMBzt93kqs5Nqb/Fj+pah1aaOBSjCwdFBFN5GE3jf6fxPIknH91ZEDdHCbJCAO+pszfB0jHxG1zG62M+tjRIZ1PeIndbRPjGZJF2Js96zuesOzURY5rFAW496dWxZ7AgB+SmvR71F8Ah0xpQwCt4xJc8xdShMbQl5ccIBkTops04w3AQMXzI3lNKpYiOHWtCDvwsXLEHduHFyDkuWLJYgArYsX61u6e1SZlR03OhvyPT9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Oq1nvSBQ5WV5VwbQiKRBhF+o6GZZv+XrOzWTSzAD9c=;
 b=GuWRwlSP50Y9xt0SbGhB5r9QcuZVBE+3MZ1eMPJx3y7j/3WymbvxQ36WGNhWlqN2R1VqV1xez7/kb+hOEQrp/i+4aRevn2sWy5NvnwbvFnwGfQs6iafBjP/wwdzLTpmVrS7wJ3XQFmXXOLtrUieiELnwxNqSp/65Fn7BAhaGJW1ULggVOWxw2TQqfKX9exHy+KUQGTg8hzPztgzcMYvXfdekxzMbetq6pENOQcs+LsbfdgEHq2Jy345iA3KV9r1rAKHeCtt8z93RaWDdeFgQq2GeJlibbY3IlckrCH+qtFlemj2oFATyfEg6tLRajVrUm8EWwDcpl9r3Q3YfORjRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Oq1nvSBQ5WV5VwbQiKRBhF+o6GZZv+XrOzWTSzAD9c=;
 b=oDNUNejfBsCMQQli0kB6gLe7kGofs6jaenquieygTa2lYvlEkNLq0Rz9vFcCZmdXMRS+HsRxD4nNq+eFXs7tBDQwIUUxadukk+fvzvHjUlJuTHdp6cuJ65hGbBCmD5vTOR14bBbFmrqEt2EB/UENWF4Jk3OZomQmEsZpoTShffzyL3UC4JzLETEhaZ/DPkU3J1F10UPaRk6g3nB1wzRz9W+uHNdMhLnxsccTFICbqPjEMGMgQuPI0q7+Vkb2bUtLAyKImduZ+7pOysRpVnR0sdKT58xA4JchckSNQhnfUv6Q4Q6EoBIHj4OWK2H9NLFuJWbrSxvB38He5VWyAmJ/CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 08:07:43 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 08:07:43 +0000
Date: Wed, 6 May 2026 16:09:01 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, laurentiu.palcu@oss.nxp.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] Revert "dt-bindings: display: bridge: ldb: Fill in
 reg property"
Message-ID: <afr3HWjUr_5wVT-f@raspi>
References: <20260504-v7-1-topic-ldb-fixes-v1-0-0125d937ff7f@pengutronix.de>
 <20260504-v7-1-topic-ldb-fixes-v1-2-0125d937ff7f@pengutronix.de>
 <20260505141538.GA2547282-robh@kernel.org>
 <2bl2mwpk57xgkuye2gydliymjkzikiovnb7ovnb73olwtfkjwn@byn3732grvnh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bl2mwpk57xgkuye2gydliymjkzikiovnb7ovnb73olwtfkjwn@byn3732grvnh>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|AS8PR04MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e378ba-408d-40de-81e4-08deab468c91
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: a91OE9oIrBHo6HWSkhqJflQ2Ci/ItG3VAt2AlcHaOQ5n81nKUORhm3kK7xk+ZOJQdCnSlSwPJI9lhz2s2vKWYwjzaW0olXHO4kPAIWFVzz3MgWitrGvR3wV6SYlpafkusG3CO5mLdeqC/RdFusg+ZlvzDJzh1U47qa9NP9VIQkcSrU5JImOn5pceVyOo3iJ1vSgABwYWDjD5tC5WF8YpyzoU18qRwJNiyKmoo9I6bbxPF84JhFYCAiJwo7+IVG5GSSeJQGcUZzox5UdwsbOZfNuAW1HIUjDm2URmzpahTjSIdGnBfr1xQOjPtwMUOmBPJoxQR6wJwyP7q4wRWEMuj6upoAKgA3NIA+u1DvhKJT//WQB/fhYtVnQIeLcVVgFGYaKtXUM5G2Xky8CeUnjLB5Jokw2+oMe1ZLlyDoWAmx42m1y9o6l0dKapBdAZS5GD9yh75HWI/xb/oayhX7kb7ct+pCi3x3kzxrfA/ReEjP1t6FagklMztVSZTAK1J5SQl+FdYh/aZ2mDUkk6mzaO5oVvFkSxMiKCsNEY3u6PdWdSJivLkjLWv/wb0BjIf9cx05fv71g3nEHHOmTnmq+ob8dI9Wh91b+P8nGLy/jo9Xri/AwVh0dUrmxHfYWXk3FGVasZaOO1tg6UCQni4gk/xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JvYBodxEvnUsYixqrDsORvAIbYaR8JzKaIyRxqd8801p/s+Onl1uPk2bTFpI?=
 =?us-ascii?Q?oEMQ988bOuD5nvjt+qtOMniOrL8xAfrcLzy2gMZ3g7Uol/M1pzr/igUy+QXj?=
 =?us-ascii?Q?au+68QU5+C7bs9LySV0Wxb9YPNlehhwpe46IHBQlIxC4mMQH8BnKBWynRZAr?=
 =?us-ascii?Q?gtPnKKSV9qtPR36D9yPESnmIKnfjvl7UsxpoKEdHnHlYv1Eeb68hKAUD7fWk?=
 =?us-ascii?Q?8GHium/DAaL2SkVmR0RC7GcoOWKhyEjQFo1u5NWrj4EH51eSwBOnpfi7kXBK?=
 =?us-ascii?Q?74poNmBgcv6RHlNMIYntEvXpAGv3xXuKwFRiBmdtXqW7YYTu7puYDcA1mL0f?=
 =?us-ascii?Q?A/umeOfSZMgx2kHRbZybplbpZFkn/hGzB84lKf8lFZKVOf4GeUQGp1+l3UDs?=
 =?us-ascii?Q?l7ZypYsRZKsQPwUW5gBZlya23NrnfbCz5QtaEnlE0UbUcBrwQwh60rcNGn9i?=
 =?us-ascii?Q?81xgqI3OxQUVQc79r/yttiOJJLPUJ4yclLuPrF/yMrBXyeaQmcWkxXZNsBs5?=
 =?us-ascii?Q?SeAtA/O5H1mtLilNIHOJbETAXGAtLeXycZAV504j4ejCVJOysnvQO0OdJvt1?=
 =?us-ascii?Q?C13uOFgj+3qBk0pb7+dI7KxX87n++QaQTwn/FqZOZ9tZe35nwbIWlwe/YTZR?=
 =?us-ascii?Q?5wPs79kjiP6YvJDFdx3VFyyQS5qcCUyIb4EKG2DAlHAChaiGjirt6yyBpkK3?=
 =?us-ascii?Q?Yy0U+PuORSPKXJ0QsEnCZTOWgqZKV3awdztlARI9/0JXvOSktYISoQZHmB/W?=
 =?us-ascii?Q?to+dee3hVk8gRFOiAIhpLZjx5Sx85LwjK00v3VDWbaQt0uafK/PK9co4X2AG?=
 =?us-ascii?Q?TkRrIkPyED7q0iH9GYdCfdOsiGRfKedbCqBGZTAuDfhlR5XdTvpMq2w213+t?=
 =?us-ascii?Q?ypBkaoNspNp/BffTAX10qizEixc4A2BvJgvomfUzzHqUkedwagvMdWJ2qvw5?=
 =?us-ascii?Q?S56MbpA+54i34Ez1ZZIuPiGxmZ/9E/5P6If4lFbXFKO9pe9TM8b+yqaFPcqf?=
 =?us-ascii?Q?jNQtdPGD96i0y+L40knHeS9X9MlOwEdDEE00fsY5RKNcBx5iW147pzjWipKi?=
 =?us-ascii?Q?/tTyDbcefVDL2+zBFNrXSd0rE7cXZKXobkZ206H4Yz+dj0xALeINo/5A4TVO?=
 =?us-ascii?Q?h/Q9caf76Euerwy0A4ZVtnKUD8Wlh3KGNu0Mq+yVdXfftUlPzuijnAonwieA?=
 =?us-ascii?Q?qerFK6Zqd/QqttbsOsNhIP4PJyp59cLR8/bC0fWsls0VwIANPHdlX509hEjF?=
 =?us-ascii?Q?kp7ccjDMDEAn+XuKYOcRqsC51xilXZo9r15+FJctbEn6mhgXhOLoW+viaan1?=
 =?us-ascii?Q?HLy+SN/qn8JZqZbIn/Xa+waGM1Ih8Ow3ygiXttMDRRGgMMeVzHwXtL8TAYU/?=
 =?us-ascii?Q?mAcGo4sHJvmpIAEGmluk+vgzBDxfFKnDXsCanSQMtxuV/yvLgjxSYxFqkwJf?=
 =?us-ascii?Q?0ovmH/eNeDBvQcExYaLDXh7yUTatErCXfkLUzpGDQJfB2NkH5D02fYH2agls?=
 =?us-ascii?Q?yM6n8MDiWQdeBd+ttmeQiBmP2nktPDhUcHNxVGlQUdjAm8hKou7L+yl6Yzfe?=
 =?us-ascii?Q?OyarUjzXQrnIu7xKBgXgEVJv9ehsj0PTDb7rTvopr+5JBXMZfGxgPk259QMV?=
 =?us-ascii?Q?PwdNgSbpuiYEZICpltPbpIbh8H6GzjocW2h7Jjw2v3MYhUI0NLqDX6G228uP?=
 =?us-ascii?Q?e+Xh+5c67zQtI6F2eFfSUoiItJb/MXF77EG+Wsi7phwK5SrItU/G730LTHxb?=
 =?us-ascii?Q?paHtVJhL2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e378ba-408d-40de-81e4-08deab468c91
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 08:07:42.9447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9mZ9x+zfUfgBSDh7K4TkMglP6VGKcGSIHhFjXsdRxlrVGj80ryXU0NaNYbM1UkzEyLOdd3FB9zGdt+eBK6gNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8868
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

On Tue, May 05, 2026 at 05:45:56PM +0200, Marco Felsch wrote:
> On 26-05-05, Rob Herring wrote:
> > On Mon, May 04, 2026 at 10:21:42PM +0200, Marco Felsch wrote:
> > > This reverts commit 16c8d76abe83d75b578d72ee22d25a52c764e14a.
> > > 
> > > Remove the 'reg' and 'reg-names' property from the LDB.
> > > 
> > > The LDB is either part of the IOMUX_GPR (i.MX6SX) or the BLKCTRL
> > > (i.MX8MP, i.MX93) register space. Both IOMUX_GPR and BLKCTRL are
> > > register ranges with loose register definitions. E.g.
> > > 
> > >   - On the i.MX8MP there is one register which controls the AXI
> > >     threshold for two different IPs (BIT(31:16) - IP1, BIT(15:0) - IP2).
> > >   - On the i.MX6SX IOMUXC_GPR5 controlls: CSI2 mux, WDOG3 settings, PXP
> > >     handshake, ...
> > > 
> > > In conclusion: it can't be ensured that one register belongs to one
> > > dedicated IP and the LDB is rather an exception than the rule.
> > 
> > It is fine if there's a child node for LDB if the LDB registers are 
> > consistent, but the other misc things are represented by the parent 
> > node. It is certainly not a requirement that either everything be in 
> > child nodes or nothing be in child nodes.
> > 
> > What I don't see in this series is what problem does this fix? If you 
> > are going to break compatibility, then there had better be a good 
> > reason.
> 
> Hi Rob,
> 
> with the upcoming i.MX9x SoCs the parent syscon (BLKCTRL) controlls
> multiple other IPs, e.g. a DPI mux added by commit 3feaa4342637
> ("dt-bindings: soc: imx93-media-blk-ctrl: Add PDFC subnode to schema and
> example").
> 
> During the discussion of the above commit we agreed that the sub-devices
> of the syscon shall not use the reg property due to the fact that one
> register serves multiple purposes. In the above case the same register
> controlling the dpi-mux also controlls MIPI-DSI bits. The MIPI-DSI bits
> can be abstracted as drm-bridge as well. Two sub-devs using the same
> 'reg' property below the same parent seems odd and I don't know if this
> allowed either.

The MIPI-DSI bits are not modelled as sub-devs, but instead,
according to fsl,imx93-mipi-dsi.yaml[1], an i.MX93 MIPI DSI driver would
access the bits directly through the syscon.

Here, dpi-mux is a sub-dev while the MIPI-DSI bits are "misc things
represented by the parent node"(Rob's words).  I don't see any problem
here at least for Linux since regmap provides register access synchronization
if everyone accesses registers through parent node's regmap.

[1] https://elixir.bootlin.com/linux/v7.0/source/Documentation/devicetree/bindings/display/bridge/fsl,imx93-mipi-dsi.yaml#L43-L47

-- 
Regards,
Liu Ying
