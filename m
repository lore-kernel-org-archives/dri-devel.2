Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D53C4453D
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF79110E1CC;
	Fri, 24 Jul 2026 03:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="FOqItMDB";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011052.outbound.protection.outlook.com
 [40.107.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65E310E1CC
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 03:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwTRXCofdKn5FxguH/20VvnQd9NrsdqKjZyX8cawt6V5jf/eQRX5Vt7hXlo/OUbrbYbOdjIIeRYWBTSa2KRF5iQKxnvZjs5gI0GeIyyz6/q6JK7Z9JqGXicYKkl9QAago1VGCHKqrbNHqDMhHgFsHtAJlGa+nQ92s1aYoDnBMXB9fHll3UHvJ4fBjlwBp9RxJMYx+ojP8XB/7GvgBtlFShregzRNZ2AMznCgHhvXZs23E8cIqhxaonZd8Eax12aKBzMO2Mjxk9oUIViNPl5A2vGHw62KaVIioB6X34w7KO5vN1qPPgkZIjIVF5PXAel+GKeTA9FzGsVsJBJQ/KJZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTgO+TczUD6iDW5U0DxuSV94nQQE/E47iHzVkNjSaFI=;
 b=hwH2/G+2DsI2uFa+2cC+H7Z0INdAXtwo72VTX9ZfzYrZbX6W1H8jHBg4ancW4bguebImU7EKDjzAUlIUkFPvXgNAadm2gbtmR/86813s/aNhpYBtMO5f5wrIy/FxR1XEEzVs0YXi+RCG5M7Wq6phpWxKMuTX5cJfNCNLKqLQ06m3MCQ6DC4H+di9Pl9/vmrRRx5r/zXWhIv3NvCBwQzd3SgWSqx99Lfos9x+86G9glYEVoPwTo5Vicv161eu3fwCRFWMrywwyyVs8lWvpXM9Ek8+pp5MM/miusxvbjGSNeZIuk0hxWWK2XfEKapo2rLSkS5q+RzHIS8hNC6XETGxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTgO+TczUD6iDW5U0DxuSV94nQQE/E47iHzVkNjSaFI=;
 b=FOqItMDB+r3Mvymw5witj7L17XwFlrw28MlH+VHLT0en+RlALbvtH3icXkTSlQxPA4IOGFlfPrFFbtnjdQ4O/6h5NaJ+TrIun/K8uMCuJ9kpBrpLMeQt7uiSXbLg8Ju9ckaNI0toBJjVtqeXLIzj2RD90y6fq7cNnr3Gap6sDx92QZD4mk62974Sfx9g3ShSE9r2Wmci5uMYrr64k7mVDWboMdp107rZ8cKE5CiETK3bjNFXCRjme4t0zmNT5PL4lhMdWYgWIIc+awoXXHIuHE4AeJAN4C3egovldQsMFZ+1wJn6HCeyQtg8oEl1qWYVGcaeGgC/ZrMou1thB17LMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by DUZPR04MB10015.eurprd04.prod.outlook.com (2603:10a6:10:4d9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 03:55:03 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:55:03 +0000
Date: Fri, 24 Jul 2026 11:56:30 +0800
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
Message-ID: <amLibmRsBY8lgj2K@raspi>
References: <20260715-dxl_lcdif-v2-3-da797562636e@nxp.com>
 <alnCL7ylMyvGD-ui@raspi> <amAJL9TIcDAK7kbh@SMW015318>
 <amA8iVS4c0exg6pT@raspi> <amA_lUpWkbOFal1y@raspi>
 <amFAXwoM4j2sIENj@SMW015318> <amF60o7yUcqAE24N@raspi>
 <amKJZ4CZJbeBw6L6@SMW015318> <amLNge6hp25xHDYc@raspi>
 <amLZAu2RQXORogoG@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amLZAu2RQXORogoG@SMW015318>
X-ClientProxiedBy: MA5PR01CA0250.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::11) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|DUZPR04MB10015:EE_
X-MS-Office365-Filtering-Correlation-Id: 3322e5de-145c-4d2f-ad72-08dee9375785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|19092799006|366016|7416014|376014|10067099003|56012099006|11063799006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vAIlOaFxe6P9zeES3iLcCOp/K8+9SpTAv9a28n1Qvsb0GOinwO19vZjtBefXYe1x02+vzLyTNwXSAR6gj1w9WFxxJE5jgYJxBJXeEP8PvJX+3SGZhGxtQgsAt8tjKBjWBZUoHRZUz8GIFkpNyn238LU7kk7VzVU2TzPrlphIuDGZNBkkbjN0N2q/6TJm+0K4Gs+4KGgLmqD3mtptLOssPFhPXePib0T9p2ngOp3f9vGl0bWhWaipHnNZRLKKu7zH97S+9EBBUnWXO8hbVEgPAZd8BP8RglveVFgvTTjNG0GdAYl+smK8AndNL4IemYPoAUTIKiK+GItpr7Yun36gmU1ssT8hwzFNw7JRGJ9UrBkD328BYiBcY0ODi2G0iCZadjzksJefhmqeaP5lThhqIa/0nJhww1BaYIj1WaMjPJuz/Emm/T8iJEf4Voz6Mtjknc6WREIlncSW+dvNeepr2iFed1aALA6VPrQgNzRFKruaeauwPv4xsR6XWgzDuvp6qnygLTiS5CuQPuL14FHTJczfRp6ps4be9oGvFBDcKMswVgE8yCFnjVEBLzQt5MoG9uY1ZFaEZ26tPqkeEa2FczL6aAirTuGBEr/gqFoPeli98aAp0a9WcMFr+Fw66JSwFyPyaJoSHaoAMoumndTsM+tPoM2WPN6wQHzpQml8Pio=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(19092799006)(366016)(7416014)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lzroPxel3qkjs32PUhqVX5N9+p2Yem7MKLnF7kxU9mcf4zoH1pCnUNChlkv+?=
 =?us-ascii?Q?AmgznDhAcu3alEljtUaNQACXYoElniZ4JIeizfx1qOCy7WNneMO7+iGQ/UcR?=
 =?us-ascii?Q?84ZHTSBPGwpLJi360FkpiGkaXFwsMkitKxczr6T3SbFsahnH1uc8JSQQpNnc?=
 =?us-ascii?Q?/LOLzU+oQIMdtu0+AiTKOgEGORalQPPVQdRvnY36eQnHA7mYcZXQx80/0Ad3?=
 =?us-ascii?Q?EtJQwpmtYjtYJBlKMagzURSRcth7uAGPtA7QeCd2NBcVTaNJO1FilctY/t72?=
 =?us-ascii?Q?ERseeDU+VXJtAWD4BFVCReVhZiYkUaxFK17s8LJJOv0n6/oHhz0cGdV9mujl?=
 =?us-ascii?Q?AtSW9d3MbaMf68LJPOti8UgB492JBzs7iolnTNIV3jt7E7vnsXEP5AW2LJHR?=
 =?us-ascii?Q?nPBd5XPQE7S0VyIW/Uwcy9BH5F0+rLncogF/WykxImy+dh7IfIiziMOAWqdk?=
 =?us-ascii?Q?oR9/MQxkddsCKHDQdckTtUnEGpBzjFcGozK0J3LjpDkX0SimvG21seWbiS5F?=
 =?us-ascii?Q?Y75Rmh7EXVdILesh+UzFS+HzmW778IGzOkD4dbpWWgujxAKyM4IW5bj5wrad?=
 =?us-ascii?Q?Dg8GeWi6m/65fozhdZVHLlpNrIG9sDj44ofbfvkZErti6CBA9kebDn8UB7o8?=
 =?us-ascii?Q?Er9UgtYMI8+zYc81KQn2Jrv8icmTNmz2iqBKXIOIdY/gW+XVYbTYM7sVPyoY?=
 =?us-ascii?Q?AAsHzjBTUnfvyn4J/gwkND9XNj7hdkb6aaxuJSXHl9unPrZ3rT2p5M5v5nQ7?=
 =?us-ascii?Q?aQb4j+U/wfkCGjK8uf74dDUO4PcehaWX0pIGVNCh/XQY8Egk4+e5hNxMGHi7?=
 =?us-ascii?Q?8EW6JaPTgstSgyOvWBoDIf2TiuGht1BWk+17FEA6PnqVT19FXOHgyfz39SWf?=
 =?us-ascii?Q?fOAE2s1t4PAzq3ssKt94+4zZjX3RQHVjDAKI4t8EP1EsrLwb1g7pis6vFdYI?=
 =?us-ascii?Q?iwNgj7DfT1GUyGDeb+zMIDjv2qUYqGmDHgcy6wKTrXidK2XmmrWlZIaTlXNc?=
 =?us-ascii?Q?WqMFL3gi5cfZZ5WnBKOxtZZP/9w0jaM/E0FKcbfTvI6YBFDQEHOXmKbfV3ky?=
 =?us-ascii?Q?lV727L/eWw8IV6zji3e1Tws3Zc7Zf8MUgnvxNVyJL8V6PUufpQqTLOEME6qy?=
 =?us-ascii?Q?Pha4HhF2Sm/PM+fHFB7vX/vKPwLIi/fmHji/9z3s6BGya1KtDXqQEKahgsl8?=
 =?us-ascii?Q?suTeWJuLb5DG/IXEJ0wpzCrGxX/5Ctx3YuCgxlsU1otvVl2gY3+ZTSrsCKSs?=
 =?us-ascii?Q?9MSZCJQMonZK4HngeiS8akhEttusBvIV37/Wr0efFqZf9gQzid3DYAp90z3v?=
 =?us-ascii?Q?5/OfXuLr0+5iu6ePqlxae5uBuf8o6qlppIjY+0etfX86RhOQOl8srbDiTUoc?=
 =?us-ascii?Q?7z6yKBnQMe2VtAafqJI/VCEUBYAeM6THw7dkhEPCdXW9PNGzC88HKLj2JPyr?=
 =?us-ascii?Q?C6JgKvEA4aebSC/oPHK7pKeLulPeAZBumeGREPyHKJ/80W7oZPWDiVCZZZsL?=
 =?us-ascii?Q?KmOSP1YFYy/ApQ2aDEE9yjV/bUp2jmwEYIGiU0EuaaCAWYnEnH9nAfh/EDM9?=
 =?us-ascii?Q?CTHMvxc8icDiKKvDkHc9vIQEcvm5/FSc/1L0VWBooABNUZZiVlBOCrBsZaj0?=
 =?us-ascii?Q?gCezbMoI2X3s4Bh3NZFRt7vjJxCSXxMHFxGTnXSGIKgI7hgLvJBzXSCf66pJ?=
 =?us-ascii?Q?8B+DH5xfavKpD4JMbPBwv1/M32mjvNNY2Aqdr6Gg7+gKFrqXB6sqjcPHSqVJ?=
 =?us-ascii?Q?fi9qxe8jvQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3322e5de-145c-4d2f-ad72-08dee9375785
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:55:03.6734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CddfnP3Kax70WyfWQhq4mUj/tnykz/1q6HotqMcrp/SWurikZEs8mQmA/DwTcExNoli50VIG2U7G1YqdBmr31A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10015
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

On Thu, Jul 23, 2026 at 10:16:18PM -0500, Frank Li wrote:
> On Fri, Jul 24, 2026 at 10:27:13AM +0800, Liu Ying wrote:
> > On Thu, Jul 23, 2026 at 04:36:39PM -0500, Frank Li wrote:
> > > On Thu, Jul 23, 2026 at 10:22:10AM +0800, Liu Ying wrote:
> > > > On Wed, Jul 22, 2026 at 05:12:47PM -0500, Frank Li wrote:
> > > > > On Wed, Jul 22, 2026 at 11:57:09AM +0800, Liu Ying wrote:
> > > > > > On Wed, Jul 22, 2026 at 11:44:09AM +0800, Liu Ying wrote:
> > > > > > > On Tue, Jul 21, 2026 at 07:05:03PM -0500, Frank Li wrote:
> > > > > > > > On Fri, Jul 17, 2026 at 01:48:31PM +0800, Liu Ying wrote:
> > > > > > > > > On Wed, Jul 15, 2026 at 02:34:48PM -0400, Frank.Li@oss.nxp.com wrote:
> > > > > > > > > > From: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > >
> > > > > > > > > > Add support for WKS101WX001-WCT panel, which is an industrial-grade
> > > > > > > > > > 10.1-inch IPS TFT LCD capacitive touch screen display module.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > > ---
> > > > > > > > > > change in v2
> > > > > > > > > > - update height to 135 from 136 (sashiko)
> > > > > > > > > > ---
> > > > > > > > > >  drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
> > > > > > > > > >  1 file changed, 31 insertions(+)
> > > > > > >
> > > > > > > [...]
> > > > > > >
> > > > > > > > > > +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> > > > > > > > >
> > > > > > > > > Seems that the panel also supports LVDS input according to the specification,
> > > > > > > > > since it mentions 'RGB or LVDS Interface'?
> > > > > > > >
> > > > > > > > Need hardware rework to use LVDS. Need remove banch of resistors. Should it
> > > > > > > > be treat as difference panel by different compatible string? hardware
> > > > > > > > actually changed.
> > > > > > >
> > > > > > > Not sure how to handle that.
> > > > > >
> > > > > > Wait, you probably may drop this patch, just document the compatible
> > > > > > string in panel-simple.yaml and panel-lvds.yaml and use add a fallback
> > >
> > > panel-simple.yaml don't allow fallback to panel-dpi. Need seperated yaml
> > > for it.
> >
> > Really?  How does it disallow that?
> >
> > I can see newhaven,nhd-4.3-480272ef-atxl and osddisplays,osd070t1718-19ts
> > are documented in panel-simple.yaml and used with the "panel-dpi" fallback
> > compatible string.
> >
> > Documentation/devicetree/bindings/display/panel/panel-simple.yaml:244:      - newhaven,nhd-4.3-480272ef-atxl
> > arch/arm/boot/dts/ti/omap/am437x-sk-evm.dts:127:                compatible = "newhaven,nhd-4.3-480272ef-atxl", "panel-dpi";
> >
> > Documentation/devicetree/bindings/display/panel/panel-simple.yaml:268:      - osddisplays,osd070t1718-19ts
> > arch/arm/boot/dts/ti/omap/am437x-gp-evm.dts:89:         compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
> > arch/arm/boot/dts/ti/omap/am43x-epos-evm.dts:45:                compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
> > arch/arm/boot/dts/ti/omap/am57xx-evm.dtso:62:           compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
> 
> It can't pass DTB_CHECK. it may add at earily time. panel-simple.yaml
> have not fallback compatible string. I tried it. DTB_CHECK will complain
> too long compatible string if add "panel-dpi".

Yeah, I missed testing panel-simple.yaml with DTB_CHECK.

So, just don't document the panel compatible string in panel-simple.yaml
and only document it in panel-lvds.yaml(not today, but until someone really
uses it).  Then, I'd assume that the "fallback compatible" solution still
works.

> 
> >
> > >
> > > > > > compatible string "panel-dpi" or "panel-lvds" in device tree plus a
> > > > > > panel-timing node.
> > >
> > > previous dt-binding discuss, don't allow failback to two compatible string
> > > sorry, I can't remember exactly thread.
> > >
> > > like
> > > items:
> > >   - const: ws101w001-wct
> > >   - enum:
> > >        - panel-dpi
> > >        - panel-lvds
> >
> > I meant just to document the panel in panel-simple.yaml and panel-lvds.yaml.
> > No need to add a dedicated DT binding file with such a compatible property
> > for this panel.
> 
> panel-lvds.yaml allow fallback to panel-lvds, but panel-simple.yaml not.
> all binding which allow fallback to panel-dpi, there are seperate yaml file
> for it.
> 
> of course TI or old platform, especially arm32 platform wrongly use it
> regardless DTB check warning. But for new platform, we can't do that as it.
> 
> Frank
> >
> > >
> > > > >
> > > > > Look like recently prefer add panel-timing informaiton into c code instead
> > > > > of put it into dts file. But I am not sure about it. Just check recent's
> > > > > log history.
> > > >
> > > > If display timing is specified in panel-simple.c, then you have to specify
> > > > the connector_type there too, right?  The problem here is that you don't
> > > > know the connector_type, as it could be either LVDS or DPI, and I'd assume
> > > > that we don't want two compatible strings - one for LVDS and the other for
> > > > DPI.
> > >
> > > If supported both type, generally need customer property and new panel
> > > driver to switch between dpi / lvds
> > >
> > > or use
> > > 	ports {
> > >
> > > 		port@0: //connect dpi
> > > 		port@1: //connect lvds
> > > 	};
> >
> > I'd say a new panel driver for this panel is a bit overkill.
> >
> > >
> > >
> > > I think we can defer this lvds work until it is actually used because
> > > - need a big hardware rework to support lvds, most likely it will not be
> >
> > Per panel spec, just remove a few resistors, which doesn't sound like a
> > big rework to me.  But, perhaps, this doesn't impact SW solution a lot though.
> >
> > > appeared at real productions. If it mass production, vendor most likely use
> > > difference module number for it.
> > > - it may be end of life if there are not much users.
> >
> > I'd prefer a mature solution which handles both DPI and LVDS interfaces
> > correctly in the first place.
> >
> > Anyway, just my two cents here.  "DRM PANEL DRIVERS" maintainers or DRM
> > subsystem maintainers may override me.
> >
> > >
> > > Frank
> > >
> > > > Although display timing in panel-simple.c avoids duplicated panel-timing
> > > > nodes across various potential DT files, I think you have the "good" reason
> > > > here to use the panel-timing node + fallback compatible string with one single
> > > > panel specific compatible string.
> > > >
> > > > >
> > > > > Add Neil Armstrong for comments.
> > > > >
> > > > > Frank
> > > > >
> > > > > >
> > > > > > --
> > > > > > Regards,
> > > > > > Liu Ying
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
