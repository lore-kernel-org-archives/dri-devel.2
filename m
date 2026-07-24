Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75444C4453D
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 04:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903D710E204;
	Fri, 24 Jul 2026 04:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="DM1k3Qc7";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D2A10E204
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 04:12:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrnRrtBUHbr/0AifhOZ0AcA2OxJ2fjkS3bSub9EqKtxu2L6QjSkUyzplQ9Lf3PFDQhlNCV9JyO3w9FLnxxac+iUW4f0kBndFKYaZ1Zi1YaQTBYss33fDyk9sUBWnN2+lQyn3WZ9P4Ewo1noUvs1KcCfs+bKJj9smN6dtiX+gTXTEiwNrY47OUAqkB5Do41vtFvPFvJhYfUdyzkEx8WolbJai8ifoIIVOWPyOyieLhONjHjOjqoDDmwTt7hwDqk9E0Al3hB0TJ3iLW9+E/0u5X11WUTS+lTy38mmxIHDOmSP2tLv7lLQ36PPpMib4osnru6Va6+P4jDgspXgTj5mIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKx8j17VfXteH3cvoFAZazFKVUiyNadP4JgkdAICPV4=;
 b=G1cPYLsx/3hN8WjlwGx0Uh7UVYVXKeLUIekWBx5I4GezgiyIPsgCeWvXRLW9luliUsMRsij4PCF/wB86eLJKl57lAeQgYdIlYYUEIKkjivIPFI0pf/8loKwrxScZJr49cHpf9GQ3RMwEUbWywX+sSHu2UpPj8bJJbCr+w73qPAjMWfG9m3UGwGYAjecOiWc36jn1TYDqx1zQ5+YT1SzfwDvnBwKf1dJC/wX6F5HAqdi25aiCII5hCX0bNHjNCYdsvfbUWRtbARInAmV6zoNwHQxK5GOWcFHcENq0Ks5bNuKNAV+upO06nen6m9B+LEQNz/rE0szLLzdA248Ps3nrPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKx8j17VfXteH3cvoFAZazFKVUiyNadP4JgkdAICPV4=;
 b=DM1k3Qc7UTjLEmRB0Vlh4OvJqArunUIUjG3vhjrDq99Z1UIpVsz9X+b48JuCmLkokBjR2Luqc+WVGz8Hp7JVKEOcjF8L9PaORSS1CVSVvO4wu13fxdxzA9+xBbxK+xBTs1ctJJVKZHjki55vpZGJzOuO39YciFJ+7mAY9Q6icg+ZBcCTkdMEf+HFVjF0kltb0Q4odShtPfEqVdTeT/6xNI7X70GIs0VuOOJYOO+Ka6uO3w4fQl0TMa4SVGp/ypaB7NwSfYAlxNqYeoLU9SUXmzIVPbUWknBOfGZcVp5UR5somiEvAANQNqAthDj1eYSnGsa4AnLVmGc81cSRrSxOyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by AM9PR04MB9002.eurprd04.prod.outlook.com (2603:10a6:20b:409::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 04:12:29 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 04:12:29 +0000
Date: Fri, 24 Jul 2026 12:13:54 +0800
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
Message-ID: <amLmgrfQVrYo3knq@raspi>
References: <alnCL7ylMyvGD-ui@raspi> <amAJL9TIcDAK7kbh@SMW015318>
 <amA8iVS4c0exg6pT@raspi> <amA_lUpWkbOFal1y@raspi>
 <amFAXwoM4j2sIENj@SMW015318> <amF60o7yUcqAE24N@raspi>
 <amKJZ4CZJbeBw6L6@SMW015318> <amLNge6hp25xHDYc@raspi>
 <amLZAu2RQXORogoG@SMW015318> <amLibmRsBY8lgj2K@raspi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amLibmRsBY8lgj2K@raspi>
X-ClientProxiedBy: MA5PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::16) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|AM9PR04MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d43ee81-f1cb-4dca-c9fc-08dee939c6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|23010399003|7416014|376014|56012099006|10067099003|11063799006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Fid8l4iW0eyCZxYbW6hlh3pPAEvzaEYyLn69hoDxbsT81dT+GVtqgZLJjsxA1rkLcqKycAxZyphHohvuM0QSKuE7Ua9IywXEWqGQGwf3X7+1TwxUr9INRlZXEkDby7T9UGbejqsQYCmRAqfruTZQ1FxLUn+eEg+XsYKwhRYeAeeQ2xjacyA/RLtk7Z+ztuWu8MAUF9s7MSw+bScJZyLCBrzqLKJ0ivCIl4CgFhz1S9fZzba3CYITGRl68DAJrqhmOPk4BUuPlZhI2r8fyudiAdfyTg0wMXhxdkQweyczFb64MJTUyF6ASWiDNoU7feUZz1G1pN5MBpRztGAmIB5gQiDl6xFJiBMFR8KfpKqcIYebTtcYXETg+nE6qyfA5VHYvO1RcMNzzqyqvKrDmd+XKBlzwsJLRJs6mK54/egPhJ4+ZkYGkqvGA9mMfDzs8tfZsWY8i4sMIOyT+AziQpswTuh2FZBPII69GaFNiHs0cgaxwSCRhiebJwEr62GHJgNXiuJjRBckOFdUsFx3uI/+BX//g582uUjmzIxEBqli9VvkmChOR4qwj8LQhfvTcW/87FCraH2z9IOG8tprRDHGjppRmCU0O8Cw3UBl6h4vE9ZmeULGnW4p3KaiqODyr4E6btryCVKpTOZKNKRtjIo566Daj/tNBDauE84jwwgNeyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(23010399003)(7416014)(376014)(56012099006)(10067099003)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mK4h0/bJISodVHhyegrbWNp6qY3hhy9IUd3bBk0yzBXHPyZFlDZeogSY4YTw?=
 =?us-ascii?Q?HD6kzd3Fpgw6YjfKoYuHCw44Xw/4bOdHhJTRmU/C1hdRtvH3sUklSfhy/7UP?=
 =?us-ascii?Q?2UjG/Z57cMdQvixyovI4al9J4vA3wFRkeNnCjEY9viFeFsj1khmSNIg3FBzX?=
 =?us-ascii?Q?KqOz8EEj1Dq2xU6gtkAJBt2G2h1ppOSde+IVNFP1TuUcBLgJ+6oFqhMWvcQ7?=
 =?us-ascii?Q?yNt5ddK6WvICILbT9cyi11RS7wBOoZ17UumK4GsIh7jv9OrBlmF3IT0mD9ri?=
 =?us-ascii?Q?HWemh3gN7imznCwc5gW3x9geQRn7roRjQHbeLqn3McqJQAYjvqn15skSIeiL?=
 =?us-ascii?Q?86rZVwrhsdsGBDnrEv93/B+f9CWt2vPlH1QNSBKY6xGMiHWC43p6Laq6BeRY?=
 =?us-ascii?Q?0EOKyW+SSZEFkGr+jbe0sgZsnZ32AIGCvOLF6v7iXTGKE/fcl6R8HYDEOLpg?=
 =?us-ascii?Q?b/0vaYkJNj84dGFj9PSvBwryD2LgOdQJCapc6UAMS0xPbX+Mwp1mUOAruqSd?=
 =?us-ascii?Q?SNFS+ObmQ5XZgstcy//3rPfB3JUwSe+vVRHjk9XkoWljgp6VYuknyWm9iEc5?=
 =?us-ascii?Q?AEU0T2VrpSUPrFT+1yv+7clDhzpwgigQo4pjmHhQVJK+pMo7bgn2i+g2KsXC?=
 =?us-ascii?Q?fR7GeIRgkUbkQXQojmupAbth4BY8XhK9F3Uc4IOvSkIg5sprQ0DIIy4rVXXy?=
 =?us-ascii?Q?J2rFUKbExiFXxeL9kLzoBTU8dTh8zFq4sbxk4ihgG+hZGTbpsMJdgvw5Jemj?=
 =?us-ascii?Q?fLnTASpCIK085/UPUVAb5kM0TOoRcaXHmBqUYm+//IevoJqsLz685Wn2rW4A?=
 =?us-ascii?Q?1kBnp6MTy4LRDonyyn6s2BX6+lxFOgpoFTK72QkHH2tHcZGNLbfpq0fWEAdP?=
 =?us-ascii?Q?0zdxytOj3e0x8u6gnt/DBtK1eMQfnXAM18R0zKrIEfm0CWxWhOZ1XFHwSh8Q?=
 =?us-ascii?Q?1wj7Unphe4nvAs818pxUv4Ju1zoISmYP/fixq/Ha3eQEatBHAp68mkwH75t9?=
 =?us-ascii?Q?cNmUL6Bu/Bd/lJAHmN+QzaMGmeXcSbBSoh9eRS9KDWZ9cnUfGA1TCxYtSdQi?=
 =?us-ascii?Q?UAhhnHdk95182Nf7r718WmE4Awjt8iUBnIh3sayOZ/wK1jiCbT+bodCPPGFj?=
 =?us-ascii?Q?FE/JrtldOKAX26U5eYBTT5ycpyLCmP06UJa2OAcopB4NXQ3N29/HXvO++3g6?=
 =?us-ascii?Q?ExJr8YND5bhYjkD0s6ZnMifimJc2uV0TmcvAI+nk9nut3eZkdx1GXIMM2GPk?=
 =?us-ascii?Q?lJC3eKR5nNzGky+Kwctd2uvRKLhTE7OGnK1Jz3+Ha498uTkw/83neKmvr100?=
 =?us-ascii?Q?XkogvvevPJ7u5BAd/FS9AogNf/XCOOJEaA0l3/7nemI0K9dxX++q2LTUmEwU?=
 =?us-ascii?Q?g5idF1rVgxSzqKPpdfnjEJMieMrtuSD/02dyDCQx2auRyng3VkiZJuegjRzO?=
 =?us-ascii?Q?jcM41SzLoTPcJGN5TOeYuWabkDAGQxqouuhk3mXNYSq5ew5D9cAe6fN4Ag3M?=
 =?us-ascii?Q?PvXOXt3Ur5I8zr+pyifJKFElGU/7d2/RVlRkkRMRDQUV6Poq9ywTe3Nop3Ss?=
 =?us-ascii?Q?DdwYkYWpKm8ICoKtET6FgFjGtIzOEXO0/ke9kGrsA4mEyT+94lwvDeNiuk5a?=
 =?us-ascii?Q?km01E6xTwEx/vk7KqZyD96LaBTNwHLz399vqIb8JPWPESYJAMZzh0qy79h7n?=
 =?us-ascii?Q?O6bp4Y7vJNwwcxhx4sL/oF2W+a/dYHAMVMD+doket8hB9ipBhr4IiIyFh5xj?=
 =?us-ascii?Q?h7CtCY1YAg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d43ee81-f1cb-4dca-c9fc-08dee939c6a3
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 04:12:29.0628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scLdCXkuq9asa9N8fZtzk6LPESt+3uyR7EkX5ePWJQNSinQd7J+86fUwSR2BeDc0Kb2JojhMayuYHEW9zhJu8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9002
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

On Fri, Jul 24, 2026 at 11:56:30AM +0800, Liu Ying wrote:
> On Thu, Jul 23, 2026 at 10:16:18PM -0500, Frank Li wrote:
> > On Fri, Jul 24, 2026 at 10:27:13AM +0800, Liu Ying wrote:
> > > On Thu, Jul 23, 2026 at 04:36:39PM -0500, Frank Li wrote:
> > > > On Thu, Jul 23, 2026 at 10:22:10AM +0800, Liu Ying wrote:
> > > > > On Wed, Jul 22, 2026 at 05:12:47PM -0500, Frank Li wrote:
> > > > > > On Wed, Jul 22, 2026 at 11:57:09AM +0800, Liu Ying wrote:
> > > > > > > On Wed, Jul 22, 2026 at 11:44:09AM +0800, Liu Ying wrote:
> > > > > > > > On Tue, Jul 21, 2026 at 07:05:03PM -0500, Frank Li wrote:
> > > > > > > > > On Fri, Jul 17, 2026 at 01:48:31PM +0800, Liu Ying wrote:
> > > > > > > > > > On Wed, Jul 15, 2026 at 02:34:48PM -0400, Frank.Li@oss.nxp.com wrote:
> > > > > > > > > > > From: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > > >
> > > > > > > > > > > Add support for WKS101WX001-WCT panel, which is an industrial-grade
> > > > > > > > > > > 10.1-inch IPS TFT LCD capacitive touch screen display module.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > > > ---
> > > > > > > > > > > change in v2
> > > > > > > > > > > - update height to 135 from 136 (sashiko)
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
> > > > > > > > > > >  1 file changed, 31 insertions(+)
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > > > > +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> > > > > > > > > >
> > > > > > > > > > Seems that the panel also supports LVDS input according to the specification,
> > > > > > > > > > since it mentions 'RGB or LVDS Interface'?
> > > > > > > > >
> > > > > > > > > Need hardware rework to use LVDS. Need remove banch of resistors. Should it
> > > > > > > > > be treat as difference panel by different compatible string? hardware
> > > > > > > > > actually changed.
> > > > > > > >
> > > > > > > > Not sure how to handle that.
> > > > > > >
> > > > > > > Wait, you probably may drop this patch, just document the compatible
> > > > > > > string in panel-simple.yaml and panel-lvds.yaml and use add a fallback
> > > >
> > > > panel-simple.yaml don't allow fallback to panel-dpi. Need seperated yaml
> > > > for it.
> > >
> > > Really?  How does it disallow that?
> > >
> > > I can see newhaven,nhd-4.3-480272ef-atxl and osddisplays,osd070t1718-19ts
> > > are documented in panel-simple.yaml and used with the "panel-dpi" fallback
> > > compatible string.
> > >
> > > Documentation/devicetree/bindings/display/panel/panel-simple.yaml:244:      - newhaven,nhd-4.3-480272ef-atxl
> > > arch/arm/boot/dts/ti/omap/am437x-sk-evm.dts:127:                compatible = "newhaven,nhd-4.3-480272ef-atxl", "panel-dpi";
> > >
> > > Documentation/devicetree/bindings/display/panel/panel-simple.yaml:268:      - osddisplays,osd070t1718-19ts
> > > arch/arm/boot/dts/ti/omap/am437x-gp-evm.dts:89:         compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
> > > arch/arm/boot/dts/ti/omap/am43x-epos-evm.dts:45:                compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
> > > arch/arm/boot/dts/ti/omap/am57xx-evm.dtso:62:           compatible = "osddisplays,osd070t1718-19ts", "panel-dpi";
> > 
> > It can't pass DTB_CHECK. it may add at earily time. panel-simple.yaml
> > have not fallback compatible string. I tried it. DTB_CHECK will complain
> > too long compatible string if add "panel-dpi".
> 
> Yeah, I missed testing panel-simple.yaml with DTB_CHECK.
> 
> So, just don't document the panel compatible string in panel-simple.yaml
> and only document it in panel-lvds.yaml(not today, but until someone really
> uses it).  Then, I'd assume that the "fallback compatible" solution still
> works.

I need to correct here that if we follow the "fallback compatible" solution,
then we need to document the panel compatible string in panel-lvds.yaml today
otherwise there would be the below error:

failed to match any schema with compatible: ['waiken,101wx001', 'panel-dpi']

> 
> > 
> > >
> > > >
> > > > > > > compatible string "panel-dpi" or "panel-lvds" in device tree plus a
> > > > > > > panel-timing node.
> > > >
> > > > previous dt-binding discuss, don't allow failback to two compatible string
> > > > sorry, I can't remember exactly thread.
> > > >
> > > > like
> > > > items:
> > > >   - const: ws101w001-wct
> > > >   - enum:
> > > >        - panel-dpi
> > > >        - panel-lvds
> > >
> > > I meant just to document the panel in panel-simple.yaml and panel-lvds.yaml.
> > > No need to add a dedicated DT binding file with such a compatible property
> > > for this panel.
> > 
> > panel-lvds.yaml allow fallback to panel-lvds, but panel-simple.yaml not.
> > all binding which allow fallback to panel-dpi, there are seperate yaml file
> > for it.
> > 
> > of course TI or old platform, especially arm32 platform wrongly use it
> > regardless DTB check warning. But for new platform, we can't do that as it.
> > 
> > Frank
> > >
> > > >
> > > > > >
> > > > > > Look like recently prefer add panel-timing informaiton into c code instead
> > > > > > of put it into dts file. But I am not sure about it. Just check recent's
> > > > > > log history.
> > > > >
> > > > > If display timing is specified in panel-simple.c, then you have to specify
> > > > > the connector_type there too, right?  The problem here is that you don't
> > > > > know the connector_type, as it could be either LVDS or DPI, and I'd assume
> > > > > that we don't want two compatible strings - one for LVDS and the other for
> > > > > DPI.
> > > >
> > > > If supported both type, generally need customer property and new panel
> > > > driver to switch between dpi / lvds
> > > >
> > > > or use
> > > > 	ports {
> > > >
> > > > 		port@0: //connect dpi
> > > > 		port@1: //connect lvds
> > > > 	};
> > >
> > > I'd say a new panel driver for this panel is a bit overkill.
> > >
> > > >
> > > >
> > > > I think we can defer this lvds work until it is actually used because
> > > > - need a big hardware rework to support lvds, most likely it will not be
> > >
> > > Per panel spec, just remove a few resistors, which doesn't sound like a
> > > big rework to me.  But, perhaps, this doesn't impact SW solution a lot though.
> > >
> > > > appeared at real productions. If it mass production, vendor most likely use
> > > > difference module number for it.
> > > > - it may be end of life if there are not much users.
> > >
> > > I'd prefer a mature solution which handles both DPI and LVDS interfaces
> > > correctly in the first place.
> > >
> > > Anyway, just my two cents here.  "DRM PANEL DRIVERS" maintainers or DRM
> > > subsystem maintainers may override me.
> > >
> > > >
> > > > Frank
> > > >
> > > > > Although display timing in panel-simple.c avoids duplicated panel-timing
> > > > > nodes across various potential DT files, I think you have the "good" reason
> > > > > here to use the panel-timing node + fallback compatible string with one single
> > > > > panel specific compatible string.
> > > > >
> > > > > >
> > > > > > Add Neil Armstrong for comments.
> > > > > >
> > > > > > Frank
> > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Regards,
> > > > > > > Liu Ying
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

-- 
Regards,
Liu Ying
