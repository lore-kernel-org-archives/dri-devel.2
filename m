Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71B5CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84FF10E9E1;
	Wed, 14 Oct 2026 15:36:48 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D6910E9E1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBKVZo2qZ2HZvKJEHg3ahMrc7tLHmnVLFdzDnun0M27ntYSJgRgzJ/frsIwal4TP3qA1gVfzjPq+boGwH9ooMjMDWnn9W5H32YJxjy1UHw5O55zSKYosZe6aAAe+ah2X3OXoq8RIYU8KFI84Wp0eNP9+Pq4DDFG1zrQEsqarUDIwPQDjG6im3gwsDxWo9T9z9sJxh6h9F1j1tRxoyfNhtGYmiqOK59PRDsSJVHUE9UE9KKnG8oc3pzdrSoWlcX4rr7Bx23WfHCc1KiX7CAORsIX8BoAjYI5sSzkM+OjEFN77wiH44Wl3CfJOCfDs9tWF1L6sbzfRLeVYgr0lDEVD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2zCj8zlMVSrkiC/oNIwRd5jNwLN/is3/Bpmoy3C47g=;
 b=yJGURvmwegdfvoVFxC10YKrdI2khfay1o/qpYo1YS3q0AUtoDJrt8um4R7mhLmJyl8JsZXDqaKUiQSjOBfvGesuruGWI6PbzzfItui+iPY6BDQ6GkCn7OqOYmzaLiXKTqIymEIPPJgwd+WW3TePh5/iwbil8+iBkg1xIq5mGBIiApy+g7hLbAwHbINs9/aMCopgYxjxVJK+00+c3Jn7HWC4ehBMCDExyKPMx9ZL4+6Za5a/zlx5Qz/lv7lPc+aj5AnICWAinXO6mhMM0woaP3LH0cUPSedBUbryxqIveyURBT+Cb33XNdRojFuReIvyYrciJs1FCm3+JIsTqPShU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2zCj8zlMVSrkiC/oNIwRd5jNwLN/is3/Bpmoy3C47g=;
 b=OirsuTVav/Y/DGc0fOOXJk6kdSDRMRpyatBYeNlAH+r9jywBk3VGOY6yQ/ff4PTPzkMPFMpKB8dQEDSpM8p3SVuQcFeKqZo/5KLb0BysZId4F6CgF99Ha3lQ6UMdntCEsfgYpQlZZLmU3+//HbJyFtUwxqAhET+pILN7+DDIlUR9qLUzuMyUPdRMb7qbh+xp/adJMDYt0FnS02vRT3Z3+fMSZAnRCRP4CgCQ3peijJen+I8JsEzqnGzGo0Cn/wD16yAh1yiBv//2f8PHQIZ/0yNlUKk5A7AFPRho4JGzAlsB00wBZe+Z6/soU9mbdKO/dhArFlM4qMVKi5ZpC8gNKQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6932.eurprd04.prod.outlook.com (2603:10a6:208:182::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 15:36:37 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 15:36:37 +0000
Date: Wed, 14 Oct 2026 10:36:25 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
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
Subject: Re: [PATCH 0/3] Add VGA support for Apalis iMX6
Message-ID: <as-heYw7PKLPm3yH@SMW015318>
References: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
 <20261012164054.GA56180@killaraus.ideasonboard.com>
 <20261013090631.GA33628@francesco-nb>
 <20261013111158.GG56180@killaraus.ideasonboard.com>
 <druavdvcgm3rljk3mhano3o424xyelupmcz7kbzguuljdsungx@xuj2ovbvz654>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <druavdvcgm3rljk3mhano3o424xyelupmcz7kbzguuljdsungx@xuj2ovbvz654>
X-ClientProxiedBy: DM6PR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:5:337::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fcc377-c82d-411e-20b1-08df2a08ef2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|19092799006|56012099006|11063799006|4143699003|261009223027099003|22082099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: METUsq93XjYVnfaItmIrREQQwjZ5ONSBvV7WWIhaYR5iCtMedD1/FSPPgYjeocx4wdyuEoIAPiGc0WcGMr6OUktMKlb8sGSsGEFPaHDIaqeZuPLVNtGwDjaXuQDTWsrvuQ3rASGY4ER851Uz8G2BWPQlyZzHJ+MuwaJo9oc92fLg6zYgg+i36HS9tY28ZcUbK72iTESv+RarDbY7TK8N8j2gpKOuifb37syynPmJ7UEaUDuRV2gLmxu/Cq/Nt0O38catk046FPDoF47+PuCxffTqQyC6w88R0viB0fH8M9niisf73ogldOR/zZapWLP4W1pUeFvnpCGrYYkM5YCcUYj0/wdCZXH4rMyF5+SeFY4EsUwUKIU5zJidf1ipkvMU734glJl3X2u2ILrsczAZtodFUl7xF1PEK/BzlTA4GHu1px5/jFYWPrpYf753l2nNkUp2zZH9ZJrW8ODuVQBRUen0ftZCjD5aPrmul7L98NKsTbX2c93iX/L03LwIv3P2L2gt2h1qJpvZA5KbCsT6JeJS9PvL/YGQyYEpHL1puilZFnkeYYFEQ0yA2QnYlqEAHFSQRUhBHnComiBVJzb/69BK6UG3z+HlFXLAU+dx1Qw9vHFMmfaGcBBoP9mPGWuCf8CxVdYQUL3Hc/dQZKzviFSQwrmHOWAtrWg4J3DP5n0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(19092799006)(56012099006)(11063799006)(4143699003)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Cea8tcqfD1VXBaAvDCQLmaj3qMn1GfyUioxiKbLeHjdLpsXT/qEzWcPF2az?=
 =?us-ascii?Q?KbPAsunGgkcqpGjZi3SHPsncbrf9XPcojDCO5tvcNYkCgcfeIxaCprSFLgbZ?=
 =?us-ascii?Q?fnZOGPCOgpLgH9U1YzuhbEMei7IYrg5xY8vzmKY+EYECkSd9QZbYybKxY6Rc?=
 =?us-ascii?Q?audkI5nGlfx2+gDuQ7v0hnmB8aEfHzDs0I7nGVGtLXOH1C8dXhNWd6yVpPUn?=
 =?us-ascii?Q?bUOouhIZ/QLldbBQJyzXeZ7BH5WjZX0hg3xOK2ApMeF4GCGhrylwLOO36CEr?=
 =?us-ascii?Q?EU3RY0bB+7kIlmV9F83iQAHjpk0AwL87sP808knz9RHopuZkVWZDL8eerofo?=
 =?us-ascii?Q?EVn4tRNdk+ZiR7LvGnxw0iXgdF/v/6TnPE/8HI6yCeayslGo6tpoDKEvh1hd?=
 =?us-ascii?Q?vDzVzDC9xz0EG8Tz/VHDK5LbkRA/RSm3CYTEo7Oz6KEJp9YcElTZu8LdLW+E?=
 =?us-ascii?Q?PiVnk8sz0krczpSyHfUDuvCazjqn8qFdvnrDSOe63WOwNtWTM6sjR6pqKMLT?=
 =?us-ascii?Q?/Bvg5QemIhcu1anXvCSIyF3K7kjk90XBKl5928h9zToHMPmENM3/hBEcsG2G?=
 =?us-ascii?Q?jQ1Lw790AxTwT9dEcW7WArk9fbTStoZXFwbP77/THgB7kBArI8QpQXJfG2La?=
 =?us-ascii?Q?O4QnqNjHLlyN3JpmMVu/5O94uEKAt+rcQwPVavrB5jfl4FM++bx19gJMPIvL?=
 =?us-ascii?Q?4BvNZMZlkGjlwg+XazhrCUszEXf8dapzVWWFQrMtEivCkuyCpSuLTOSb5HW2?=
 =?us-ascii?Q?MT57NA7yrhB2yxLphJk3Pl6fbK89JBLA9Q6I5QwdJwUCgyWS0JrkSJ+hyTM0?=
 =?us-ascii?Q?cvMNRrAUpj3SmR5IzhR5xyr8mH7qC2EmlnoQn1WAr9YJ5A8C+Q+zfvsiR5I6?=
 =?us-ascii?Q?Vr6abtsHunxtR4a7/SEoYqv3E+zhOs4BDPacTuxhkwBBL+vE9R/FnVdogKQS?=
 =?us-ascii?Q?ZhPqXUQ94kaSy5Yam098w86rD49bCNNwZZ0D3zjzB2nrO5/wYpCJzE8qmC7n?=
 =?us-ascii?Q?ulV1ekhGev9DI9vu0tVVKODGHCASBHQB0oeAZEod2p2p7dh/TbllGa7RDOea?=
 =?us-ascii?Q?5/pLo1FBfE2Z/tOh8Rtswzn67NYEzkJkKzHfReJ5Dtu0MyRyyyHnbAtatNtM?=
 =?us-ascii?Q?RRGEFdmR3HsEVMLtGNmPPWx1Hr9s00gQldti95hto7SiZj2J9EoEBvH/R76r?=
 =?us-ascii?Q?7Cj2HBjMBoc11r/YYYcv7s7Qg89dFOX185kpbTxtV2dB5VoSXWuUmEUzkomQ?=
 =?us-ascii?Q?UAveManu0EArwGIZzMofCfmW/UFbC1Etxtbc/H4iqqXbMfC74n5ZtAojgcwQ?=
 =?us-ascii?Q?zZUl48SWtgaQiS4mABJMnnPp4a59WkxAKvDvibnnC5a9qezoRpFzSWxAd0gY?=
 =?us-ascii?Q?KZfseA+j3YtFAd610MK4Nx3IdxG0zbvPuE9J27MNX4U3UJ8vOJh9PsgGreLQ?=
 =?us-ascii?Q?iGaODZl0CTD9aYM9LSmFvYWpfHH3F7XJdbdLyUJDFI326yGlWKPjjwvB4m/T?=
 =?us-ascii?Q?xe/v9Biauf758WmAex30K0nvTJ70BX560u/8ndX/XY90rBz9nVj8kLb3O/79?=
 =?us-ascii?Q?wYzQEb3EYVjUFDyMQD1Jh/zEOqbkghhUqI01euPc6lVwEj7rHyrjtorn3x4h?=
 =?us-ascii?Q?U/JfnTFxy4q0TrEsXwiIv8avZOUXCC4LgbiPKSsIob8YPZ3/sgXym4/Wb7K9?=
 =?us-ascii?Q?jHWSj/g+x0Lqs0BrqcBBnx/Z26uqmamcp4lFK5HcpyOcaxHJPYtlPZY2kz4y?=
 =?us-ascii?Q?UZ8W6aT8y+e0QDGghNsbS/YUMNaiXfJPbhClkwjD6JbTqnanlo4R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fcc377-c82d-411e-20b1-08df2a08ef2e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:36:37.3468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8GTFSY/GQkmI5Vdfp++S/ZIQJAtDHwB/Lijm/fBU4k+YHZK9gxiISTzZsDberYi2mPV6B9MXW9MkxJgV2RI7EQhIrL8TcHsN8V3w3s41HTl4Dp1X/9/RB3tmBwx9WTC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6932
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

On Wed, Oct 14, 2026 at 10:57:40AM -0300, Leonardo Costa wrote:
> Hi Laurent,
>
> On Tue, Oct 13, 2026 at 01:11:58PM +0200, Laurent Pinchart wrote:
> > Hi Francesco,
> >
> > On Tue, Oct 13, 2026 at 11:06:31AM +0200, Francesco Dolcini wrote:
> > > On Mon, Oct 12, 2026 at 06:40:54PM +0200, Laurent Pinchart wrote:
> > > > On Mon, Oct 12, 2026 at 04:25:22AM -0300, Leonardo Costa wrote:
> > > > > This series adds a device tree overlay that enables the VGA output on Apalis
> > > > > iMX6, which is driven from a parallel RGB interface passing through a
> > > > > non-programmable video DAC.
> > > > >
> > > > > The video DAC is a simple resistor network gated by an active-low
> > > > > data-enable signal. For the bridge to work properly, this series also
> > > > > changes the following in the dt-bindings and simple-bridge driver:
> > > > >
> > > > > - dt-bindings: Add a new compatible for the bridge in the simple-bridge
> > > > >   binding. This is necessary because the existing dumb-vga-dac compatible
> > > > >   doesn't describe a data-enable signal polarity.
> > > > >
> > > > > - simple-bridge: Add the VGA bridge match-table entry and timings
> > > > >   struct, setting the DRM_BUS_FLAG_DE_LOW flag for the bridge.
> > > >
> > > > Is there schematics available anywhere ? That would help reviewing the
> > > > series ?
> > >
> > > This circuit is on the SoM, and the SoM schematics are
> > > confidential and not generally available.
> > >
> > > I tried to extract as ascii art the relevant circuit, hope it helps
> >
> > Thank you, it makes things clearer.
> >
> > The circuit seems fairly generic. Wouldn't it be better to add an
> > optional property ot the dumb-vga-dac instead of a new compatible string
> > specific to Apalis ?
>
> See the diff below, this was the initial idea we had when working on
> this. On one hand, at least to me it seems like something that other
> bridges could use, and a new property seems reasonable. On the other,
> since we don't know exactly how much configuration is expected from a
> bridge in the simple-bridge driver, we weren't sure if this would be
> accepted, and went with the simpler solution of creating a new binding
> for our bridge, which also seemed less intrusive.

Look like add data-enable-active make sense at this case. You can try it.

Frank

>
> What are your thoughts about a change like this?
>
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index 3fba7002322e..41b00a44983a 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -171,6 +171,7 @@ static int simple_bridge_probe(struct platform_device *pdev)
>  {
>  	struct simple_bridge *sbridge;
>  	struct device_node *remote;
> +	u32 de;
>
>  	sbridge = devm_drm_bridge_alloc(&pdev->dev, struct simple_bridge,
>  					bridge, &simple_bridge_bridge_funcs);
> @@ -212,6 +213,19 @@ static int simple_bridge_probe(struct platform_device *pdev)
>  	sbridge->bridge.of_node = pdev->dev.of_node;
>  	sbridge->bridge.timings = sbridge->info->timings;
>
> +	if (!sbridge->bridge.timings &&
> +	    !of_property_read_u32(pdev->dev.of_node, "data-enable-active", &de)) {
> +		struct drm_bridge_timings *timings;
> +
> +		timings = devm_kzalloc(&pdev->dev, sizeof(*timings), GFP_KERNEL);
> +		if (!timings)
> +			return -ENOMEM;
> +
> +		timings->input_bus_flags = de ? DRM_BUS_FLAG_DE_HIGH :
> +						DRM_BUS_FLAG_DE_LOW;
> +		sbridge->bridge.timings = timings;
> +	}
> +
>  	return devm_drm_bridge_add(&pdev->dev, &sbridge->bridge);
>  }
>
