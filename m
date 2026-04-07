Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E1DFB5184
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C336910E312;
	Tue,  7 Apr 2026 02:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="YgAU5k/T";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A37C710E312
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 02:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNTDy7A3ZXZO2uH/9a0Se1ZZFJl41Lt6QQzbBulc82UjIG46WNWZfdaqS5FQ608izX4s/BKZmpjBZcMUJpMD/EmG4ZsPN4zdh1QADC2WB6ycWCbIfGUn2i28uHFvcshwK8CsiGlupbOID9VPFyBS1mvw7gY+TTcQwgCY6OybUZauGXo3NifL19C+ZCttRkinrBf5VcglvxDi0B6kwkwg9bQq1D67Yvw76Z02R1uAxo3AiS78wFseUfQ3sHs6+Y/h3BDQCcEcp55xccw5MEjghgL+Slgby1X83cM/QwsEzPqnsW2r/meTPxwN7ijWFOo+ULwa2jpnHSooNyi7j3Hx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SySb8nK1HAxGRC5lKmxGE4dT5A6tIPQOuEK8jcrLag8=;
 b=TQeQ0H1uDlsYTNzlrX64IeBxMQE2mxVh4R0DRRE69WI1ytr2szrHREdMVawdQd8SEP1ZlDm1gtLGrnoTEg9BedWskqbQwKoveXaIk8E3tmRQoM5Ei9HmMArs1YYnmitsIKp6QXmBJmIqtrvnApO1dc2+dDvZp0jgoSUIg4XzE5i6cY5eBq01cLnNsKF4+c+CUIiLqZlmzIn6FO/j0rOz62EE0OCdJaywU/81IncWFienrygzILeqAQukF8jOVVLT1C0gJX4sODB8Q27yK5i3bfHJjifUlMX/ANWDBEduMGTXmaJLPRVUA3Di5i6ZJLiFxI1TSdbsptrFS2yrB047vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SySb8nK1HAxGRC5lKmxGE4dT5A6tIPQOuEK8jcrLag8=;
 b=YgAU5k/TuZOgEGaaKOPia4hvp1Eal2jVT4eeQpz9DYPNjRjSTrQyy97+/JfrJWqFP6Yu85d7tft0CgH80cLBzoV87neZ9TrxwaUe7e5BWPYxaqlI9XVdtmCJd3sgk1duQm7cuIPloess0Q8ZLB6b9UwwhZv+oPIR6hANCu28TObl+I4NXk8rpb2EGBSyqrlWqxdHRqWPjrjkMLa3WlKFFQIwGpYe3wQCwzFffrxx88d1+5tRVERyL8jUConz/qXbWGgoEOjK/AZRKxwBXhOKg49oCWL6lRKT+UfwpKAu2bJf0cLZz11+jFMeA9uiKSd/mk2m7rRb9M1Jfk2ZOqkBFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8246.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 02:50:27 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 02:50:27 +0000
Date: Mon, 6 Apr 2026 22:50:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: Dominik Haller <D.Haller@phytec.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "sam@ravnborg.org" <sam@ravnborg.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "upstream@phytec.de" <upstream@phytec.de>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add EDT ETML1010G0DKA panel
Message-ID: <adRw6sNItxMNEfK6@lizhi-Precision-Tower-5810>
References: <20220818124518.42080-1-d.haller@phytec.de>
 <20220818124518.42080-2-d.haller@phytec.de>
 <ba13246c-3838-4993-12ef-420d82730b28@phytec.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba13246c-3838-4993-12ef-420d82730b28@phytec.de>
X-ClientProxiedBy: BYAPR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::41) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c733353-7d1d-4e8b-c21a-08de94506c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|52116014|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: XOtyxc9oxuz1p2r/qJkMWpxp1POo0TrekLDGNcEes75Txh5R0+x0wp8IvY2KOhLhcqn+VP4E96EsBY5ezJkibqOlFTOyaetOVouaaO+ltz5MZEzN09U6RDnWR8gI7ONjYJ7FP3oDwQM8Vhj18qNJATmi4qvfFX3/Dazz4vHyfAvCHV7wawi6qm/iaqwraUYGKALo702kYaImvkP8kYJSbTFwHSy07u5R9XhwlV0BDUWsMzGndBmGw4VH/hDAJBse19xDy6xMTi8/HqVhR5vuoRccl6533zgtaUZnw8a2Hy2iXzEtFTD095XcR3z1blXY6RIHSOTUtJFAsTq5FVG4hmBnwfNO0CXc/ZbH7K5WbQujHobGJwlL87awH5rsO4OSJ/alFdy8u42hE+o2WiAYcLJOUJaBLhY36I3LLjYj3GQYY04GdzwXDsKZeHJpohdP/g0S2zAsrNuV9EeVNkDsI34F8xHyM8EOwZ1kYz0mrRaTTnjgsYOXu/AoRrnQVPtvpAVZj+BYtFZRLDnaUS3E6HpWyXT1fpGRxebLzFXbBCI2ROCjC3+O6xil9GDZIPKYiZTwI6JGi1CiGJZBv8UN13zrSBDVqmIr6BZffl6Mw7EJvG0RQNPWOOBTSQJEAQEwtFEZI/v5gn6fUNTjuKVa+TqQj0Nre4Ww2UOxCj7B+Bvr4rRzAz/ZIxdbmmDOCdee/dZ7eU95Og4/6sHVHN1kmrsu/J2lxoFwl8oftPW4I4fCuAqBpiH40+//n1L9OaLY2dqk2Nokv4tPPIV3MhlzgrTe8WCPafq8mMFR6bS6vzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9366.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(52116014)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QxTiV9YqCYpbZHa3Ii0XagA+I3MBjkZ7e1G/6tE/wIhCkpUGz1X+uemM/S?=
 =?iso-8859-1?Q?+MHPyJ1CC99sSQBLQcnqYos5IzoER5/FcUdgDEZciMRte1AsjwkuJiN3R5?=
 =?iso-8859-1?Q?cXRo1hpKYlJkxi2bBg1l642gZF2EgazL9wMZr/P1FHPl7x3NpXIp/dX9yP?=
 =?iso-8859-1?Q?FeLYa4netQlY6RFCSZ6q7pvcDHcZicgHrrtQhbm0owda8SJF+JODz67Wbs?=
 =?iso-8859-1?Q?tikrSOW1c3wU6hEi8JtRWu7VyHlRCWpk0noXwmKHD6euRPQleeXgayybgY?=
 =?iso-8859-1?Q?G4lG4ZJqdDgZ1bKZ2bupdjFn6gc5ial5sFNq2LURExcXpsSuGvVGFHXQUw?=
 =?iso-8859-1?Q?PyE798vo356iRn4v2oqxuTR3a0TndF1GxkGKUGd4qRAnoGC68POtYwfgIV?=
 =?iso-8859-1?Q?tcWGOXt3jj3u61XwW73fWkBE5gFy9Ic9YHrg1Yygu8rbRp4hYdAE7/xkn7?=
 =?iso-8859-1?Q?Xr3caJwxdtfKenbhw/WRYVqEin5Lw+YGsfDkWp0ixLxnFMKQ658CzQzBNd?=
 =?iso-8859-1?Q?EtjKbgbOvWXeALrB1bmA5lsrwk/xMpCe16KbhpNKmD72euiOxKXBLYV5c6?=
 =?iso-8859-1?Q?I92wsIeKwmwtAaEK4XTU4zj61nb2byhmfKlbTOi59t0stfC/A/kSGBXmxA?=
 =?iso-8859-1?Q?ozVJ3Bzw5w67iWjDHS4jl+orxphge9xBNzBm1ou2CPHwRrt9NXPocNy8ZO?=
 =?iso-8859-1?Q?Uh2nuaMlsSkoJZ7kN7WvyCqxHq8N5kNBo4MrEb87tvpSEBpzIN0mmgUXxw?=
 =?iso-8859-1?Q?m6AjjCgvZdIaPf+otONjdUMaeyQ4TFW12OcS27pGNIMstJZpOaYInR5rZR?=
 =?iso-8859-1?Q?eQu0vZn4v4elfIPqV6Fn2YVDS6Yc5pEcIa/XLvfet1YaOatTt2XMzmP9q6?=
 =?iso-8859-1?Q?vIjtqEjefQP2cdBPEYTatH69f7rQEI7H0FsqgK16swN7MqXBnoGJadKGZe?=
 =?iso-8859-1?Q?l6SMB/0atPxW3hk5pDCEk9rAgzyOhMPkQwSHwe9CRLlW7hIFTo9SFeRvua?=
 =?iso-8859-1?Q?HDyAcdEQ7uVFBBpvyyudx2MkuYssR5ah0qJIue8vvCYmD9/XfuMAx7lzF/?=
 =?iso-8859-1?Q?gUc1nbB8/ggeQw2X4T+20NCuYtXUA6nu+SjJFDEy47y8iUCVMOp7+1lPRD?=
 =?iso-8859-1?Q?/Yxmf0XxpMnSiofugeiwNz9V+7HSvYfE9fagcjFUKTwMFp6O7iMATsDcLQ?=
 =?iso-8859-1?Q?OmL4WlxEVsKgucgpbgKaQBN23NHHuFQN2pKqaGFjWYANjXcRMm9AiZjzqP?=
 =?iso-8859-1?Q?NJz9mqOIWyDaN5ssvz2y6frWR/jUs/mWJOq/6RF6EFI1R1aJgPylu9EwZN?=
 =?iso-8859-1?Q?brJka1RBc6hQ8zgkKVuwUPsJcwG2VCp0I0klvz45mLdqRjcCfGwcLzQR8s?=
 =?iso-8859-1?Q?xeCufJHJDT0utWVRtdyDk1WnuJcE64Zsp7UNMmo5KAS8ck5nnXCWaK8XTX?=
 =?iso-8859-1?Q?GqY2uFdSFhEoaiPZwhtlo4lyK/vJ45Vx+d2VoeZhtMsjABpFOmS072GMBV?=
 =?iso-8859-1?Q?Wa4fuNA8qETC6GYX19vLwbskmv1XHWIl8jUOM/4Ku1UUCn0Omo3png/ZtK?=
 =?iso-8859-1?Q?benAAiEW/7xwzABtT/4UWic/1qN9ftqC6kG7eHMAg3MS4KceouEO7BJTXL?=
 =?iso-8859-1?Q?1sHlyZgRt7Uu9KJHIkXqZcQziI8efbiRTlwOPjXy9DoaTMUjhqKFsr/eYx?=
 =?iso-8859-1?Q?KCAA41A0QJdcP+q6n5r42fI0Dl0D/UOtqLH2fc3LukZ8o/7fNOnygBdF85?=
 =?iso-8859-1?Q?kutvYkP7qfeOC2qyjMFpxkK4HIepquvMHeguBh+X3p0cLL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c733353-7d1d-4e8b-c21a-08de94506c57
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 02:50:27.0701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWoMxEci+bqNdmEATtnRtxUoNpZsZ3I3irZmuT/BrMRTWnn4FtDhEe8X1cU+i4AOXs7+OZr0edcgYkA1LtYUSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8246
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

On Mon, Feb 06, 2023 at 02:20:31PM +0000, Dominik Haller wrote:
> Hello,

Neil Armstrong:

It is quite old. Any reason why not pick this patch?

Frank
>
> ping here, this one got forgotten.
> It still applies on drm-misc-next and v6.2-rc7
>
>
> On 18.08.22 14:45, Dominik Haller wrote:
> > Add support for the EDT ETML1010G0DKA 10.1" 1280x800 LVDS panel.
> >
> > Signed-off-by: Dominik Haller <d.haller@phytec.de>
> > ---
> >   drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
> >   1 file changed, 29 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index f9e1f85daef7..9314db24ab51 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -1779,6 +1779,32 @@ static const struct panel_desc edt_etml0700y5dha = {
> >   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> >   };
> >
> > +static const struct drm_display_mode edt_etml1010g0dka_mode = {
> > +	.clock = 70000,
> > +	.hdisplay = 1280,
> > +	.hsync_start = 1280 + 100,
> > +	.hsync_end = 1280 + 100 + 19,
> > +	.htotal = 1280 + 100 + 19 + 41,
> > +	.vdisplay = 800,
> > +	.vsync_start = 800 + 4,
> > +	.vsync_end = 800 + 4 + 4,
> > +	.vtotal = 800 + 4 + 4 + 15,
> > +	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
> > +};
> > +
> > +static const struct panel_desc edt_etml1010g0dka = {
> > +	.modes = &edt_etml1010g0dka_mode,
> > +	.num_modes = 1,
> > +	.bpc = 8,
> > +	.size = {
> > +		.width = 216,
> > +		.height = 135,
> > +	},
> > +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> > +	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
> > +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> > +};
> > +
> >   static const struct drm_display_mode edt_etmv570g2dhu_mode = {
> >   	.clock = 25175,
> >   	.hdisplay = 640,
> > @@ -4057,6 +4083,9 @@ static const struct of_device_id platform_of_match[] = {
> >   	}, {
> >   		.compatible = "edt,etml0700y5dha",
> >   		.data = &edt_etml0700y5dha,
> > +	}, {
> > +		.compatible = "edt,etml1010g0dka",
> > +		.data = &edt_etml1010g0dka,
> >   	}, {
> >   		.compatible = "edt,etmv570g2dhu",
> >   		.data = &edt_etmv570g2dhu,
>
>
> --
> PHYTEC Messtechnik GmbH | Barcelona-Allee 1 | 55129 Mainz, Germany
>
> Geschäftsführer: Dipl.-Ing. Michael Mitezki, Dipl.-Ing. Bodo Huber |
> Handelsregister Mainz HRB 4656 | Finanzamt Mainz-Mitte | St.Nr.
> 266500608, DE 149059855
>
