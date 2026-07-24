Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0968CC531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 02:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5FD10E43C;
	Fri, 24 Jul 2026 02:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="f5xAFCAz";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CF010E43C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 02:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhz22k7qc+I+tikRk0NpDWmQi0DbMT4zS9rZoIrcB4CuJ+ZEZxjkPZskwT1c+ITZISPmpBUd1+9f60Gbu8+G6KsZnnEcggKTPLV+ghLc41z7fwCSSThkrhdTWKszw+hK8KRZamGZmtisfe4aVsSzFbxq0/r6TW/S3X+nUtkCkAybMEgfwVV7ToTbSX1/qPOM2PRfe8WudvCOQAGWxL7QrflU1BqFEmOZM4wMVZm25MLhyElTdN0wOC+abIg7/OC1an4w/RtI1JjaDhMF1ZE8SfxUTZXWkaPli/TXNjakacvcfsTHe06ezOIxvPT5IvTq1Ds3HMt1XB5SBBPAR0Au4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixuvoYfoJYkUEx4+oSB66cEN5lAePAqdl2TR+wY3X2A=;
 b=xWZ9JQglLj/4KCrenLI04ttIjCMoEKhd5a600H991+HmSuH3Az248EjltPeuaAHLeaecps4HxlaxH4rCCRZM3OX9gt7Y5artQSWJiQD9QaDE8AI+bmIUU1VbCbjOzpBThNvroLHL6g42w7cJ2p/Nx4XqZr/qEDffA0JhGKyhu0GyTNT+l/NSxeJ5nwgSB5qhyOpJTIzPETjLysS1gxW1yOpAdLSAgxYEVmoK1ooWudpo7vZ9k7BZH9ykJ6FNp12bcrDLL3kmVYV36eF0ynPD7AvPhXc2RjolEvh4XDop9Vla0Ww5Xof+Zya+/eAoqNRMxyPnRTRQX+4DPA3tcACeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixuvoYfoJYkUEx4+oSB66cEN5lAePAqdl2TR+wY3X2A=;
 b=f5xAFCAzTY5dW8JBPmPKmhDaZuPRRLJsq2g2zBX6U7iXvCz/FmBf3XfUK2pfn1PZ2IppdKGjaLcyy7iUYGF09wdxRtJmrxEpg4+N5ICw5r19QMVXXCDttdreIhEui3DMKCjcT5ZIT3gSuKsp4EjVbANslWK9G5w/E8sFz8xpUL6rcJPT+ybz1BtQQgj0ZSAdB9ygVGME+EE4dhd0s6xJoOkLTEa07qPtVoDt/CWYBMlSQz9iJ0elJE1VQBwCbH7D3tDtKMIKK1c9T+a72YNjLNfHk7/sdfpht1auztOJrjMJVKyjBZcLvPd93kkfK3u2IrLF6ul70Fbmebog5WVWaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by VI2PR04MB10168.eurprd04.prod.outlook.com (2603:10a6:800:229::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 02:25:44 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 02:25:44 +0000
Date: Fri, 24 Jul 2026 10:27:13 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Robert Chiras <robert.chiras@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 3/7] drm/panel: simple: Add waiken WKS101WX001-WCT
 support
Message-ID: <amLNge6hp25xHDYc@raspi>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-3-da797562636e@nxp.com>
 <alnCL7ylMyvGD-ui@raspi> <amAJL9TIcDAK7kbh@SMW015318>
 <amA8iVS4c0exg6pT@raspi> <amA_lUpWkbOFal1y@raspi>
 <amFAXwoM4j2sIENj@SMW015318> <amF60o7yUcqAE24N@raspi>
 <amKJZ4CZJbeBw6L6@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amKJZ4CZJbeBw6L6@SMW015318>
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|VI2PR04MB10168:EE_
X-MS-Office365-Filtering-Correlation-Id: 38eddd25-bd45-4a56-df07-08dee92add4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|19092799006|376014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: cRIx+NBFcwTSNc8q63I/3k64Z/91oIvMfHPjA5UqSpGutZGrYT53l4OwTEastUx57U/trrSYXLrrG/iHoT7E/H8ImlCuSIzpkR4tzPkiVXavPEzyF8SJNcE6u0whfJRYl/fq306Bbg/x1W+duzx9S5UjWzVW2WokG5sbyugkEAD0tRjBeFTmne6VIkSZ46liqPbCpLH/LEx0sRIawBV5ho8G3xfKElWN005DuGJ0RjF6e1RO+NsnCIcpcRmKwzPhP4q4sV/zPUdpuFUhwkHpb1eIegRCQ/iILIlaTWYfP6GOGgFUl/ZL1nDIsEBq+x/EACkf8sBXMlrgbTgRNo67WmKhzXm4d6LKTNvX+JNdr5e8dOnD/3e0LdoLZI44iS0JpPHUCjTQ1LeQQQXNdggQPT8AggRmyWan+vvBs+LGRhT+bvEKQvVPknrQGVrf82U3JU80Q+hibitL2f2FfM/JBMNRRRRx+WR77toTDc/DBuwfyaoC+z/jzK6su9GadWobmRxy0AN5pO/my5rGDBQ0HcicHghxHxDZJcK7rs7c5s7FmwbZvtlaXfkP/YRmvNtzCZjDmbGrpC+WgOVsfeX87KBF121JfvNEIiQQ8yW4JxCCFwF2iND05/wdvNSE9ExD7DY5pM8xIvwQt47OmUNDBzr4v+H6ttJJbrtgTqTV+NA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(19092799006)(376014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zvv9iDLDYLo8gFsjkDGINz6ed+IMwAMVm5SBfzCDXJujEbgfkjRKx2H9g9W/?=
 =?us-ascii?Q?rWBGGHnsNsOOF3ET01H4RPv+tIH9fs0SkKTvvOU2oO/Sm/kXtzfdh+RO/J+t?=
 =?us-ascii?Q?VyyBQ5itJAUN5j9rrLRjeg9JgbeniPxX7CAVnsG/cublrXkv6kCw0b0fFUjX?=
 =?us-ascii?Q?F3s9AJSq0iSkBR4wsNlRx7rM62LfKiGoVhym7dRGQLRrPLlULARD4pPdyB98?=
 =?us-ascii?Q?gvxHHwXflX72dM5B5TqwfhpnXtfBnrB3ISYbC+NYnB584Ygnys2ufa0rKl/5?=
 =?us-ascii?Q?X0pcyitGPPQdc48J+S9x0RlyteaohmJShPa+KHt3o63ZGxKeuVsGS03L1FjS?=
 =?us-ascii?Q?g3RSomJNkSuzDv9RAkOMcI/IOC3PZTVBoKPZ7VvEI8lZcbXwi6ZLHHmCYbX/?=
 =?us-ascii?Q?WEs5lYqCy1mMtb8/xTFH4ZXbhwCYCGZoGyC/414oBSY57lijhmKTCKnUrjos?=
 =?us-ascii?Q?9UJ3wbgU0urYrXx6cht1ulZ9Ugq+Le+mGT7FuYCCpARIoTaylhDfD83OCG59?=
 =?us-ascii?Q?fOAM6Rrd0nyJkvwG6spZ/fa4j5d0v7ITAxnDYpx31/aGDYEG3QYj2MhMU281?=
 =?us-ascii?Q?uiy+3aU+kg4igeuxbGrbDnh/N+oBPxRoGIBXoLmivTGZUqG7O0CsRkcLSFd1?=
 =?us-ascii?Q?qEEUWpIEqtd2kPtl/M8ILwdCeeiZf9SNcUg51MO5wn3lappZRJNb3cJl8dgg?=
 =?us-ascii?Q?jUoJS+PdXf1YnVGAdJ4LzrB8Kw6pgv9gyO2jSEab/+QpP25HyosOJru/SeGB?=
 =?us-ascii?Q?/MJKChQaaWt1IDluYuTa3VAhdG254O2w4dzqrHONgPejEaDdIv2KueaDihjH?=
 =?us-ascii?Q?6L/OCWt60NYSJGKqhpDIyUXFyPDtCRHZ5Dovu9Cp/KbVYctZBQ55G2zsVIGn?=
 =?us-ascii?Q?QT94cM7ujmJF1q7wxNIDkeFkzk1TSIeFc342G/SJug7A6/A+bYqlTUh22a0c?=
 =?us-ascii?Q?EbJgLAxmpIqG2ZN7PufsDuza2gCE3d1PBQvhZwljjwxLsTrVX1u/P+dO4+JY?=
 =?us-ascii?Q?cWiUgUTWKXo/cX8JndNxRnoqayq1ydaC6qpMPjBv9YO7/ffHcwwkkBr38Ede?=
 =?us-ascii?Q?p6S2fsOp8YP6K/mKfmDc32cL+ESuxmdF0J9VX17nGpF6EgjMPx7qWdp/AkX8?=
 =?us-ascii?Q?GVjtSVYnSYVyiXnBPqIonhMArYxgn+u+ngdU/Q5Wve6+vu/0JWqxFdn1NdX5?=
 =?us-ascii?Q?OteM8MsA2Pn3ZIKVOhQ4uW5JMEcx0X9x/s8i5yLMYeVaH+oTEVH5AsaGYl6V?=
 =?us-ascii?Q?BcMtevfDk/pRgjK41ni6EUw2rnuN6iWQXbsull/Jo93jl44rjiGAaUFEMicN?=
 =?us-ascii?Q?INpnaGD0PW5hfRO1f/Ii9sCbkOz6tIZK7lpq+6HAPwYetg2sEWWnmI/gA/IL?=
 =?us-ascii?Q?nwpD5M9z1lOkup7VncWCxTcQV7ezFCnKxUTgTmh0WFs9Y8LOPYP5/UWnynDf?=
 =?us-ascii?Q?hY9A1BICMc/B8bZxQITzDMTDMcSD4+xf8cHACDT5UAZL7PxdcA188H1S5q4a?=
 =?us-ascii?Q?4dtishsEpURRAtJQIk/pebMZApJQxYvxd9bpBndPlWCgOrqET/MUGW3uzKIR?=
 =?us-ascii?Q?syh+QGgyIZk65oryXZd7YlOisAhdbsu5a38ByJxG48y6ePT3NefmayjW9+Gz?=
 =?us-ascii?Q?8J8jSc54Ju3da79dtPtK8AHirz8zPJeWhvGBbtS7TxNy6kzpfik/sEFKoYjJ?=
 =?us-ascii?Q?VQLHOZNDqf2FH5CBi63uJoq9JseqUmuuCaxHzPVb4Ni4UzWF5+5puCBYChbp?=
 =?us-ascii?Q?0Tgo1E/57w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38eddd25-bd45-4a56-df07-08dee92add4c
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:25:44.7088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcWvnSZVP0rNfv2ktUlc6KVH9lCPoogPRXYy6ukkUTiosEf1kB0h5AaQUgUNbBt01zU4/S2RL4c83IXeASiMOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10168
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

On Thu, Jul 23, 2026 at 04:36:39PM -0500, Frank Li wrote:
> On Thu, Jul 23, 2026 at 10:22:10AM +0800, Liu Ying wrote:
> > On Wed, Jul 22, 2026 at 05:12:47PM -0500, Frank Li wrote:
> > > On Wed, Jul 22, 2026 at 11:57:09AM +0800, Liu Ying wrote:
> > > > On Wed, Jul 22, 2026 at 11:44:09AM +0800, Liu Ying wrote:
> > > > > On Tue, Jul 21, 2026 at 07:05:03PM -0500, Frank Li wrote:
> > > > > > On Fri, Jul 17, 2026 at 01:48:31PM +0800, Liu Ying wrote:
> > > > > > > On Wed, Jul 15, 2026 at 02:34:48PM -0400, Frank.Li@oss.nxp.com wrote:
> > > > > > > > From: Frank Li <Frank.Li@nxp.com>
> > > > > > > >
> > > > > > > > Add support for WKS101WX001-WCT panel, which is an industrial-grade
> > > > > > > > 10.1-inch IPS TFT LCD capacitive touch screen display module.
> > > > > > > >
> > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > ---
> > > > > > > > change in v2
> > > > > > > > - update height to 135 from 136 (sashiko)
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
> > > > > > > >  1 file changed, 31 insertions(+)
> > > > >
> > > > > [...]
> > > > >
> > > > > > > > +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> > > > > > >
> > > > > > > Seems that the panel also supports LVDS input according to the specification,
> > > > > > > since it mentions 'RGB or LVDS Interface'?
> > > > > >
> > > > > > Need hardware rework to use LVDS. Need remove banch of resistors. Should it
> > > > > > be treat as difference panel by different compatible string? hardware
> > > > > > actually changed.
> > > > >
> > > > > Not sure how to handle that.
> > > >
> > > > Wait, you probably may drop this patch, just document the compatible
> > > > string in panel-simple.yaml and panel-lvds.yaml and use add a fallback
> 
> panel-simple.yaml don't allow fallback to panel-dpi. Need seperated yaml
> for it.

Really?  How does it disallow that?

I can see newhaven,nhd-4.3-480272ef-atxl and osddisplays,osd070t1718-19ts
are documented in panel-simple.yaml and used with the "panel-dpi" fallback
compatible string.

Documentation/devicetree/bindings/display/panel/panel-simple.yaml:244:      - newhaven,nhd-4.3-480272ef-atxl
arch/arm/boot/dts/ti/omap/am437x-sk-evm.dts:127:                compatible = "newhaven,nhd-4.3-480272ef-atxl", "panel-dpi";

Documentation/devicetree/bindings/display/panel/panel-simple.yaml:268:      - osddisplays,osd070t1718-19ts
arch/arm/boot/dts/ti/omap/am437x-gp-evm.dts:89:         compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
arch/arm/boot/dts/ti/omap/am43x-epos-evm.dts:45:                compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
arch/arm/boot/dts/ti/omap/am57xx-evm.dtso:62:           compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";

> 
> > > > compatible string "panel-dpi" or "panel-lvds" in device tree plus a
> > > > panel-timing node.
> 
> previous dt-binding discuss, don't allow failback to two compatible string
> sorry, I can't remember exactly thread.
> 
> like
> items:
>   - const: ws101w001-wct
>   - enum:
>        - panel-dpi
>        - panel-lvds

I meant just to document the panel in panel-simple.yaml and panel-lvds.yaml.
No need to add a dedicated DT binding file with such a compatible property
for this panel.

> 
> > >
> > > Look like recently prefer add panel-timing informaiton into c code instead
> > > of put it into dts file. But I am not sure about it. Just check recent's
> > > log history.
> >
> > If display timing is specified in panel-simple.c, then you have to specify
> > the connector_type there too, right?  The problem here is that you don't
> > know the connector_type, as it could be either LVDS or DPI, and I'd assume
> > that we don't want two compatible strings - one for LVDS and the other for
> > DPI.
> 
> If supported both type, generally need customer property and new panel
> driver to switch between dpi / lvds
> 
> or use
> 	ports {
> 
> 		port@0: //connect dpi
> 		port@1: //connect lvds
> 	};

I'd say a new panel driver for this panel is a bit overkill.

> 
> 
> I think we can defer this lvds work until it is actually used because
> - need a big hardware rework to support lvds, most likely it will not be

Per panel spec, just remove a few resistors, which doesn't sound like a
big rework to me.  But, perhaps, this doesn't impact SW solution a lot though.

> appeared at real productions. If it mass production, vendor most likely use
> difference module number for it.
> - it may be end of life if there are not much users.

I'd prefer a mature solution which handles both DPI and LVDS interfaces
correctly in the first place.

Anyway, just my two cents here.  "DRM PANEL DRIVERS" maintainers or DRM
subsystem maintainers may override me.

> 
> Frank
> 
> > Although display timing in panel-simple.c avoids duplicated panel-timing
> > nodes across various potential DT files, I think you have the "good" reason
> > here to use the panel-timing node + fallback compatible string with one single
> > panel specific compatible string.
> >
> > >
> > > Add Neil Armstrong for comments.
> > >
> > > Frank
> > >
> > > >
> > > > --
> > > > Regards,
> > > > Liu Ying
> >
> > --
> > Regards,
> > Liu Ying

-- 
Regards,
Liu Ying
