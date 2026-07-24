Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB501C531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3738610F29D;
	Fri, 24 Jul 2026 03:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EKKJezni";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F4810F29D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 03:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCvB4bPRma6G1Q27lnmut0xJAYyIUk4xwIDRx76e/YqMkNFC4FQ8777OtKnW/Gmm28x0wtsndd7qmWDali4pIS2Imtda8EI7aUJ7ZSXGn++OC/NiTUVyulKkB0vNJ3WHXMmPy2mD4z1uN5tIYAEFHCgmNzdvRKzist4wv0WUneSbVkL4t2S7ViEEv96zeeybz6gLCD5uD7P9gg/YyJP+SnX8VrOqzx1EQe0gT37nHRnSValDp+GSNLoLz0D38+yx6haTaAd/di18o/Xmh1tjrIGZfUcfyDFOPJqWuOPmTM+hdYo08r/oANJIIk+nDzN2Z5F3qz8IZ3jM0aK4V9RP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PReVExVUFS054Msy1lzepp249G4YHQR2yUilqIYlGJ8=;
 b=Lm5UAAbaa0S+2tHg3AUI5xYwErnjPWXX2AvNdil0bKuF9yyaSCYGELYozQkKfCc7khoXxrTLT4FWpBksV6NiAwtpdu1mGRDimC0HefXoX+Kx+Z2uUpp3bafcia5CtNNAOMmHBFmAkwzeBZnDN3EspJBv5EUzYUCe0xSQ1J1DevbYtOJxLap0CfhY/7EJ/TI8/4wyisqplINrBNl1bdUuORsfNCsC7gC98/N4IulqCgOkPuzeSGN40h3YdvIBm9gQUb+gNXA+HekfeJZTX90TSlZVO612+HvPd9SkV1VXqL5F0wgcSGv72cfcWePYrnJ9rxNGfDs4t4UkwBmisragMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PReVExVUFS054Msy1lzepp249G4YHQR2yUilqIYlGJ8=;
 b=EKKJezniRM0/1EQyk4zZ58/69eKmBefct0kR/s/ZpYn487IChPZWAtnGohb5fl3H8N0Od+XSrpdGsOaw8Xyb8HITVvkAl1R0QVoyepTfvDdMv0pX1Etu/z0Dp9H+lnHMORBUyk4m5cdIJ6J6KX9t1aN2ZThqwTqhHmquuJ+8jFDo9e1/CRVjIU5boPbFjvrmFn3ZBhXAKkHNFXmXLsqJk8YZes2j6hlfQMEUrtRhmYn2A8HrgypXDEZfaqEQ4yHwIgmsxYlmSMRMetTtBIz1y4Cf1RshzON7+gA2DB2wDxrUY/7+0OSoqZTwtmYXLwVsvdFDH9yYKfHQKUZU9Xybww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9648.eurprd04.prod.outlook.com (2603:10a6:10:30c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:16:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:16:32 +0000
Date: Thu, 23 Jul 2026 22:16:18 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>
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
Message-ID: <amLZAu2RQXORogoG@SMW015318>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
 <20260715-dxl_lcdif-v2-3-da797562636e@nxp.com>
 <alnCL7ylMyvGD-ui@raspi> <amAJL9TIcDAK7kbh@SMW015318>
 <amA8iVS4c0exg6pT@raspi> <amA_lUpWkbOFal1y@raspi>
 <amFAXwoM4j2sIENj@SMW015318> <amF60o7yUcqAE24N@raspi>
 <amKJZ4CZJbeBw6L6@SMW015318> <amLNge6hp25xHDYc@raspi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amLNge6hp25xHDYc@raspi>
X-ClientProxiedBy: SA1P222CA0120.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9648:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f63160-fb1a-42d5-0496-08dee931f598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|19092799006|22082099003|18002099003|3023799007|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: NBA9eiFej7zl8zaAxsXPF7JZb5vyWzYhwnoWcaZ5otcGvg8VeR5As2MzV1XYGKZXqYp9y4gu2H+/tYANktTvCcAt7KFdqzE/OMazHcwU8apfIs54xtzmMk8+1dnGm9WiCICHHpZKD0+tTMTxN9a6ljtRYBKmVuWXxhJLnZEivbEpuSO8RbHqv9ItlHxfp3y8rnGW2jV/BVBp1LGafW64aEeWwKwSNNmo4JY5bQwHAsjgyv7Y5PtmLfVsm1zBXLUtf8e/W82IHIkjjVn5LnwtT7nRL9UJmbncbI8C+0da6m13ctQyQ82625p2mX4aGdWMwtmzMxqjpE7Dy/4cEFTLFgn2U0hBhrrlxp0q60bHxY+O1iO5y4V4O8KbPsSm52ej+pv9FykfE363XDa91ESDLVjJiupNZnX0OCm6Uz8ZDJC0ufwzal3gW3lrnXiMo+X0CfdgMaE3Jj98nh+fj7u/VAlk9gDMqfJYDQMD6qILlzyH9ZDJDVk+E/rexsI81wb4abDt1XfrtaKul2ONd3dw6WAF+bjz8yTkWP4aywbco4Dr6stJxzNGOmmCzvSK2Oc6SAHUEntguGcEOOeLo6jylCATVGJrqOskJaGk4Q/sIHB1FfAXyZuf7Fp4IEhZjmq+58XylVEh+ibZp/n7WThPQKIbvoRUh4ugFLuUbFIeiHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(19092799006)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?flkQhMxViO4vpXFAo3n1kBUVpRM93GbIuYw76lkQpFuAtbCqt6vM708I1eKW?=
 =?us-ascii?Q?zu0R0mvHKKvRkgF44BvkeXquekZmGKwx6dyrP0mgAM7p4sWMbrNSgBBmjYgs?=
 =?us-ascii?Q?ga+JMl6XZQKzZrAldWOsUqxKlCQ+PxyY62lGUe73tT5+72OdbVZMpP4m7/Yi?=
 =?us-ascii?Q?1ILS2iRq//8aH3DXtqBpQVdrp9kuQ8zExtoMpbCo60gE9BvzQhXWfzfZRckk?=
 =?us-ascii?Q?EFkxLWWcVEgSwHKrE4tUAXdxK54X3sSsVy2tVh+q7rtqQIlSr5ShE2tAn2nm?=
 =?us-ascii?Q?W2R/XhMEbYywBtpNtBN7NJw46i/7g03tSdNlyq9AS6yUc4QMObjojXEyPGc+?=
 =?us-ascii?Q?vLkAvgXr0q/owKNpHC+FbORI92BTi9HB4bsWOk6C3hXxf9C4Fkm7gLaXsNyQ?=
 =?us-ascii?Q?2tY+aMc6SR2KZYl6KSNUSfPOrTTIRwIgTRWTudd5Er6Pq86TBNzJZBzrOM8T?=
 =?us-ascii?Q?wBAgVHika3hn9k70gsVglGY88OMdGe5mCWVS4yizVdQj0ZD83fDs45uVnTEH?=
 =?us-ascii?Q?xGYBoGPgsJuR4LMs7x7h3K7XAFDabxLdDvvI8CsKAodm+VtoMk4+ODaP4gb3?=
 =?us-ascii?Q?RFA3J05w0g8kWQcas+6cF/CDItXmzuHE8d24jXHmbD3SaT/rHJGJzoZgQ+F0?=
 =?us-ascii?Q?QQZQaenrGr0RLFQ93gMaSPO3pXDxlTf6AEO4rY+DrphhlR6G6geh/t28jegC?=
 =?us-ascii?Q?LUsFutteJxrdPymj7fMTz+IwP5D3PG5WbKtptud2hq1X1EqagU1NEjPQpXEc?=
 =?us-ascii?Q?YR7OnsoaEm3TS2j92s8fl9VBdeL4fBehQ4GDeVl+nad6KQxnl12pD9ffe4cp?=
 =?us-ascii?Q?VIcCRBEDclkagVDfojqfhbLjgRvyN3z0SDNBuorB/id8c1bwbmdut9hylI2c?=
 =?us-ascii?Q?kMVCoivWcYKOC/zzDu5wu0g+E0GhxJbN0qczHyKWTKsfnA3CvvJCfSiH9NAa?=
 =?us-ascii?Q?36nl0/MKtgLeYZ4lJca7ZxAhP0NgThtmDD1cYafT1MSfIVSVoj6Eh8zZoTdl?=
 =?us-ascii?Q?7rFpEZZmJ5kOgYR09ZHQxUrKmAFa/yb+jnCME6idepaT3E/vbH43zRPWmiuM?=
 =?us-ascii?Q?OKEivGt/CfAw/neuDpcrsxSeo8bGHRkFUtjh8Po+7vRFlnuCVGYBsgZr7Iqz?=
 =?us-ascii?Q?FOWlqZCi3aKNQhyzD96PoCHSG6wobkUW7pLLRwa1YT1tTFSqGl7U7apR10dQ?=
 =?us-ascii?Q?w2ZVxvRLLKENyIvOKlvJ9WozZ9FRur3cvTxY9p3xJAmEWy1++w29doNJuTvX?=
 =?us-ascii?Q?o2leqcJu1UtXaC1vRTqAam30Mk5/wZUN6Rl31219P+W7rgeUEunNCcJRSiKf?=
 =?us-ascii?Q?PsfGL3kLreJ1AMhG2O0wPAEYhdOcbNH7DlKqvpYQ40gi43a4rxfi0BwKq+AG?=
 =?us-ascii?Q?tM9aLaoDb5KRIAfzO4xOZ/+iuN6JuxP0IXqSFuOTP1+CZtoGfjkdpAkNRgV6?=
 =?us-ascii?Q?0JQiasOIqKOUGn91a13Iik443qx3Gpr6l7GztcNPQr6i4Tj+RhbT9ZpSALzE?=
 =?us-ascii?Q?2jKo4FnasH2Mszd8l33TSwdy4RR/0ZXlWeaapfYzqL6b6My+4qCTgJ/myhdL?=
 =?us-ascii?Q?KDryHFlBGrwQzIfhAhfd3+K9JsnZWI35xZ1OUzclpu2cdaQOMdHs2sTLni3t?=
 =?us-ascii?Q?PYKf5RA9qlUr7IwvSWHWCL19DfZ0z4UtFdXISHxg5AIRUHmKGWYDkb1XJ2Z4?=
 =?us-ascii?Q?3yoQ+f6wrCPhHejAv8tAgE8bt9xoyx+WIIF/gIAVTvI/QW47gCsnvflGk+Jl?=
 =?us-ascii?Q?ZX1NwpbmcVvJpK9oNFiaHW8UbVg8e9PEbcg5D5n9DCWpWpKMHzfv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f63160-fb1a-42d5-0496-08dee931f598
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:16:31.9709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V006yibAnIvE/V8tIBQZYOTxfMT970zSAVceAshmlX8wAeTX6U+Y9noamfkXSWnZA47HaKAH+tk7YD/Qq3QVS42QBnUF1db7ViFEy/sh8HsgzoEsU+4G7SwIvYVrDTwQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9648
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

On Fri, Jul 24, 2026 at 10:27:13AM +0800, Liu Ying wrote:
> On Thu, Jul 23, 2026 at 04:36:39PM -0500, Frank Li wrote:
> > On Thu, Jul 23, 2026 at 10:22:10AM +0800, Liu Ying wrote:
> > > On Wed, Jul 22, 2026 at 05:12:47PM -0500, Frank Li wrote:
> > > > On Wed, Jul 22, 2026 at 11:57:09AM +0800, Liu Ying wrote:
> > > > > On Wed, Jul 22, 2026 at 11:44:09AM +0800, Liu Ying wrote:
> > > > > > On Tue, Jul 21, 2026 at 07:05:03PM -0500, Frank Li wrote:
> > > > > > > On Fri, Jul 17, 2026 at 01:48:31PM +0800, Liu Ying wrote:
> > > > > > > > On Wed, Jul 15, 2026 at 02:34:48PM -0400, Frank.Li@oss.nxp.com wrote:
> > > > > > > > > From: Frank Li <Frank.Li@nxp.com>
> > > > > > > > >
> > > > > > > > > Add support for WKS101WX001-WCT panel, which is an industrial-grade
> > > > > > > > > 10.1-inch IPS TFT LCD capacitive touch screen display module.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > ---
> > > > > > > > > change in v2
> > > > > > > > > - update height to 135 from 136 (sashiko)
> > > > > > > > > ---
> > > > > > > > >  drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
> > > > > > > > >  1 file changed, 31 insertions(+)
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > > > +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> > > > > > > >
> > > > > > > > Seems that the panel also supports LVDS input according to the specification,
> > > > > > > > since it mentions 'RGB or LVDS Interface'?
> > > > > > >
> > > > > > > Need hardware rework to use LVDS. Need remove banch of resistors. Should it
> > > > > > > be treat as difference panel by different compatible string? hardware
> > > > > > > actually changed.
> > > > > >
> > > > > > Not sure how to handle that.
> > > > >
> > > > > Wait, you probably may drop this patch, just document the compatible
> > > > > string in panel-simple.yaml and panel-lvds.yaml and use add a fallback
> >
> > panel-simple.yaml don't allow fallback to panel-dpi. Need seperated yaml
> > for it.
>
> Really?  How does it disallow that?
>
> I can see newhaven,nhd-4.3-480272ef-atxl and osddisplays,osd070t1718-19ts
> are documented in panel-simple.yaml and used with the "panel-dpi" fallback
> compatible string.
>
> Documentation/devicetree/bindings/display/panel/panel-simple.yaml:244:      - newhaven,nhd-4.3-480272ef-atxl
> arch/arm/boot/dts/ti/omap/am437x-sk-evm.dts:127:                compatible = "newhaven,nhd-4.3-480272ef-atxl", "panel-dpi";
>
> Documentation/devicetree/bindings/display/panel/panel-simple.yaml:268:      - osddisplays,osd070t1718-19ts
> arch/arm/boot/dts/ti/omap/am437x-gp-evm.dts:89:         compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
> arch/arm/boot/dts/ti/omap/am43x-epos-evm.dts:45:                compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
> arch/arm/boot/dts/ti/omap/am57xx-evm.dtso:62:           compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";

It can't pass DTB_CHECK. it may add at earily time. panel-simple.yaml
have not fallback compatible string. I tried it. DTB_CHECK will complain
too long compatible string if add "panel-dpi".

>
> >
> > > > > compatible string "panel-dpi" or "panel-lvds" in device tree plus a
> > > > > panel-timing node.
> >
> > previous dt-binding discuss, don't allow failback to two compatible string
> > sorry, I can't remember exactly thread.
> >
> > like
> > items:
> >   - const: ws101w001-wct
> >   - enum:
> >        - panel-dpi
> >        - panel-lvds
>
> I meant just to document the panel in panel-simple.yaml and panel-lvds.yaml.
> No need to add a dedicated DT binding file with such a compatible property
> for this panel.

panel-lvds.yaml allow fallback to panel-lvds, but panel-simple.yaml not.
all binding which allow fallback to panel-dpi, there are seperate yaml file
for it.

of course TI or old platform, especially arm32 platform wrongly use it
regardless DTB check warning. But for new platform, we can't do that as it.

Frank
>
> >
> > > >
> > > > Look like recently prefer add panel-timing informaiton into c code instead
> > > > of put it into dts file. But I am not sure about it. Just check recent's
> > > > log history.
> > >
> > > If display timing is specified in panel-simple.c, then you have to specify
> > > the connector_type there too, right?  The problem here is that you don't
> > > know the connector_type, as it could be either LVDS or DPI, and I'd assume
> > > that we don't want two compatible strings - one for LVDS and the other for
> > > DPI.
> >
> > If supported both type, generally need customer property and new panel
> > driver to switch between dpi / lvds
> >
> > or use
> > 	ports {
> >
> > 		port@0: //connect dpi
> > 		port@1: //connect lvds
> > 	};
>
> I'd say a new panel driver for this panel is a bit overkill.
>
> >
> >
> > I think we can defer this lvds work until it is actually used because
> > - need a big hardware rework to support lvds, most likely it will not be
>
> Per panel spec, just remove a few resistors, which doesn't sound like a
> big rework to me.  But, perhaps, this doesn't impact SW solution a lot though.
>
> > appeared at real productions. If it mass production, vendor most likely use
> > difference module number for it.
> > - it may be end of life if there are not much users.
>
> I'd prefer a mature solution which handles both DPI and LVDS interfaces
> correctly in the first place.
>
> Anyway, just my two cents here.  "DRM PANEL DRIVERS" maintainers or DRM
> subsystem maintainers may override me.
>
> >
> > Frank
> >
> > > Although display timing in panel-simple.c avoids duplicated panel-timing
> > > nodes across various potential DT files, I think you have the "good" reason
> > > here to use the panel-timing node + fallback compatible string with one single
> > > panel specific compatible string.
> > >
> > > >
> > > > Add Neil Armstrong for comments.
> > > >
> > > > Frank
> > > >
> > > > >
> > > > > --
> > > > > Regards,
> > > > > Liu Ying
> > >
> > > --
> > > Regards,
> > > Liu Ying
>
> --
> Regards,
> Liu Ying
