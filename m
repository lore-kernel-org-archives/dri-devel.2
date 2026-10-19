Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170BF606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UmRH/SIo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D92E10EB0F;
	Mon, 19 Oct 2026 19:51:02 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011067.outbound.protection.outlook.com
 [40.107.130.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D4910EB0F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 19:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ot4iY7VcVsnPgXGTmgQDDGohMMA2TAbtnjEDBff0+wbQAtajIFPc+jDQIqU1jd5CXm07D8WF/PbuKQbkXJMJtIJ8gtW1MllOMKEe55iL252duobhThfm1lf/xKsRt0LMX9ICyrNGZCnW6doDILWRK0Tufob+6+GfzPKcxvegC7xJ+rqbEvzAUuA9ygzeHCOaGGqNLmZ4hvloUrsUwRoVCIApHLkcN7c9bjQ6EX+ADPRcjRWn6TR6aliaSrEwL3J+UWn3/xo+n8U50lVTQNPNnk85rfsHSzfI5nWqLfgGOiKWi08cip7qPh8P+4K8G7a+jBW2jAIwt8QZyRLL+ayFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GapZnKoLYCZAPBX9r8CJxKt7GR+kj2w1VAzfY1vZNrk=;
 b=chNQNyPUCc2eTSZ62Dj3UYzrJqZCy7qhCaAAkqiFmmBwADAQvi7wd40GTSE/urXH8+8cfvT9CP2NQTUhoK3SEz08UdU8kd71y1g2zMY7pec7PanApkVpvbASHxTC9uerYe8LtzB2jsZ7vDkrQN0dEOY7t44UxBpfddMtw7DNOj07kUYjHS8U/3taJWbljZiHPH3x4d8S4b6/ZmjDeW/WPgpGoZvbtuzTmoD/42X0Qenens+pdAGBWkWmv3luPggNLDfuSz2zteEmqQZAbEBO7tfkejkjXxfQsPU49lEpVq4pLpOtmsP6R9tLzHpI3XHslkWwWFoLFTI1Kn9cstj78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GapZnKoLYCZAPBX9r8CJxKt7GR+kj2w1VAzfY1vZNrk=;
 b=UmRH/SIoOb9Usnzb2KeCdRokAOr50t4cTuKlFtMW+FO2arlCH4RqPXLDITPBvFSHiSXC8WNWYc5wMnDj+F2llJ5UuTM0DdZ2DiM4OpAf/Fxb0H976BZjPyqsnxqIu57Pte5uANM4O7gIrgW8w7FBC8rSc7P1Si09Ve0bSK4csTORWXgf7bU4koxOVFYXEBXStaJl+ajO65OW5zv6md6nPWUfa7pD9EDAvBcwIt3n1IBFeMuAldSDDYMFMAWwjulzotQFWQAOS341yFkJ8SpAQE2ReDA0Gt85Xy9/WKzPZsSCD0IC2IJcCV7h6q0PsmlEb58Pf25QICxM0tBi3jwC3g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI1PR04MB9761.eurprd04.prod.outlook.com (2603:10a6:800:1df::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 19 Oct
 2026 19:50:50 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 19:50:50 +0000
Date: Mon, 19 Oct 2026 14:50:36 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH v2 2/3] drm/bridge: simple-bridge: Support
 data-enable-active endpoint property
Message-ID: <atZ0jECm5BDeROSI@SMW015318>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
 <20261019-v2-apalis-imx6-enable-vga-v2-2-ef6a3a780472@toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-v2-apalis-imx6-enable-vga-v2-2-ef6a3a780472@toradex.com>
X-ClientProxiedBy: PH1PEPF00013303.namprd07.prod.outlook.com
 (2603:10b6:518:1::12) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI1PR04MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: a71b93f7-ea9b-4300-441f-08df2e1a46b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|19092799006|366016|376014|1800799024|18002099003|261009223027099003|11063799006|22082099003|260925021311599003|10067099003|56012099006|260925021911599003|260925022911599003|4143699003;
X-Microsoft-Antispam-Message-Info: 7juGyMbZMHovwZfxrFF9brTzi1OUT8pK33VqSQkVcB7tKCfXcmV9jL6h8EG0wFPu1AR5jHoHbbClXeFgUiqkHw5guk3xSrbVSxvFSFQY+FFPgy0nLINGzbb+ahAcicYkMEc/5NNGZE2N4TfNrhQqTnQWWGrln8IBmbB257Dian9kwNJdKkyPrQ4Fobb9J0w2hRWuQAMdI2KV3LtrhERSJd9hiGKEx7k/97BEajaq4duACXfJYXXsBK+D2v9hLPBbryhJ/af/AGvT2FcVn6hODjOqliXdu4OfMP8/p2Wg8OXB8tgC/JIP9VbEvWErBEB+ExLMzwUNrAPEOt9oKGkJ966fgOlleqcLHI0oPvpJ8rEXe1H7LEP2DzO8zfs/dLwQq84IKuBEk4d/YPr3SKVF6svwYgNpf4YLp/24sV2SKyt87EsIPHgNmotczYZ5o53Jpu/36NAtcXzoFdSKPHhpcOQE/MpzdXHN+v9IqsGv/fyfb3ORXiVTF+rR4HIDa1piBzhwKRrFglr/l3okDxgrcopNMdKlljajl/707P65A7KaXnLGfHiJsP/fmtFESOWyKAMnM+xx9/TtwmiUwxJ+IOcsSVl91nLaG8qwbll4Vx5ehVH8RUXA9KkKEj7BpPbBIkRuIMmcfzpvhpW63W9wTXPvzK6liGxvVGmTIm7zTP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(19092799006)(366016)(376014)(1800799024)(18002099003)(261009223027099003)(11063799006)(22082099003)(260925021311599003)(10067099003)(56012099006)(260925021911599003)(260925022911599003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+pCGY4s1vyYjAH86wKARZJvHj5iapYfM8MCAFaQE6nihK9zIVjZGZ8UaqA8x?=
 =?us-ascii?Q?TLmhSm5i00Tq9m673a8Snu7E1fTBwSk78CLIFMn696jqOJjFvPrhvBBNhBZa?=
 =?us-ascii?Q?sD99DFun7yrEeXul4CLpGrGxB5nNXv0u3B3FXNmskSKQmBSrHbISDyROj1IJ?=
 =?us-ascii?Q?24POst1hlg5zIz1wxaFBEfWhs98OH6hmANbBC8j8QBwdmHJ/LowkKvElgtNX?=
 =?us-ascii?Q?77Yy5+o+Lv3Md5VB3EKNQK3htelOV7J0zShIUGqwvYuXrvV7UicRQZT+Lkj3?=
 =?us-ascii?Q?gIQwll2DaJa3V5UO10QKDGvPl9zWgps5GXpS50RUaFtbEb0HHyUEoQThH7JD?=
 =?us-ascii?Q?Y15j1DyqldpZQxI9GDMSugwPjY3zj+ibsbY/uWA92PhUk8QacqjE6960oas3?=
 =?us-ascii?Q?vlA8qpB1GjbuHzWiY3IX8hucVVd7sJej+WTtdI3bI2ixsZbnyXigBJRT4vDJ?=
 =?us-ascii?Q?xv8uPjmRsJDCZjys+glr6jhoQtzhUMW3ENsbY7VW4zKdfbaaQEV+IxOO4KZC?=
 =?us-ascii?Q?vnwJWQuNZZfA019v32OTylLq+yksedxRqOmAAGqr3MX14/dH2wL+KRjcR4j5?=
 =?us-ascii?Q?8SMUsYIvujXtXlayzdHDgx+Frw5OlxLtFs4O51Ci4zx6qnlkQn0uRm87dBRr?=
 =?us-ascii?Q?g/Rlg34EY6Fry0fsKUuNL3EGHt3+tFiwiJZo7d68/1nuJF/3xFfu+B5Hsbcc?=
 =?us-ascii?Q?zaTpl0dLiKtBkzdXCwXFaixR6EbqRktnUWm6SBtF+32Bj7DpJKzii0ObPME6?=
 =?us-ascii?Q?y9HPkh4TCGa9CnA0jNAoKNKQYoA32DO+zBgUQsNQsBGEKc2lKxJQg9G3vRDb?=
 =?us-ascii?Q?DjOY1syipr0oxCKHlg6sSH4sNc9sy2m2TDYHS8aatTb/4RWCeSL8CPuSyrG3?=
 =?us-ascii?Q?uP4XQDp7NSXYF1K6MatKMONgU2dBH8Pvhl7IrWPGblccLV2k7x70bflRufpO?=
 =?us-ascii?Q?t1SiqH9jHjP16Ytre9/y4ZEON3xUg0O3A43YzJ/QZ4M40GlTTdKYmLnNywfO?=
 =?us-ascii?Q?nEa2ZzMw1a5JrYpWn0wCxgdctCq0Y5eCZryQpRsqD71JUIz68qpNGL2lJvUG?=
 =?us-ascii?Q?DTpcw410OnhIC2lzc5DzZUh7vTprcKvbBCK8SxjIDxtsqVtvkUKUu3Gm8bds?=
 =?us-ascii?Q?EV7dk0KXrS4UBW+Q4/LGr2HorLae7DbnIbiXvamfYk9Ug2HPVfQGhQkuUTqX?=
 =?us-ascii?Q?JsHZsg1ngnxaDLnAdvo7pUy6Sw+b1jo6QdadLraGOLgmZXpgTwZ/rzzXPWCS?=
 =?us-ascii?Q?0eHdbtW7Tsy9VedfmXJalMqnfPVjZ9+9EM2IDyQ9VF22RRg11MtpXcviwqcG?=
 =?us-ascii?Q?Z0SmeJ/8M8CZfir0y+kdpidLudHG+/+Eg9TfPMEQDijxnbxmjC1IWmTxlJy0?=
 =?us-ascii?Q?ZCly+vqIlhWdM6yJUfVKkpK68B4ZuRsokkS7M65CIb5bR5UwYwhzCNCdkJpU?=
 =?us-ascii?Q?VB3wsJ6KLAuo8JpOPIhKKTiPQavlLMzIbs9DE7hSTYUUg4AXQzyC/U0LQgEz?=
 =?us-ascii?Q?t1KGnHy/+sd7kUjiJxDfSlFSVbkvm3eRSKau2NBtNlH+39Vk2FgjjWPKp24X?=
 =?us-ascii?Q?KAU3JgewUd0pZUjiYCsgilTjXWkBkjQ8zDDVyq6m4C40/KyFptIOcytG6PVf?=
 =?us-ascii?Q?Z3j3HGDBhVnZMrmA9SeoX5Yvdomx4qSBA6ZCQ5hutp6DIvrSYQtrBQJx7S1T?=
 =?us-ascii?Q?PYBYWQWotPc5A/J3cq1CjAYLZSuabkuWjfSb0CLX3FALWWLQLFDBnMG7IQ5+?=
 =?us-ascii?Q?z01XqwAFUMFO/bNys4tteKGjkdwGvgK866EcdqF2g7copP9latJ8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71b93f7-ea9b-4300-441f-08df2e1a46b0
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:50:50.1923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lC3aEI3St7mBtjKLaH18EM8gNHrp9Lsi7E3AP9YFdnvOP8YAr4QhzFMe0yVlHc1eEwduP5Md4Y62F50iG7OAQhJ+NJ4yLzhAC8GtPl7z85m6lJnoujCqYq+RlyKU1Pmx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9761
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 07:17:15AM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
>
> Some simple bridges, such as a resistor ladder DAC, may include a
> data-enable input that must be driven at a specific polarity.
>
> Read the data-enable-active property from the input endpoint and fill
> the bridge's input bus flags accordingly, so the upstream encoder drives
> DE with the required polarity. The property is applied only if the
> bridge doesn't provide its own timings struct.
>
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/gpu/drm/bridge/simple-bridge.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index 848c2df2a276..c5301295658a 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -183,6 +183,9 @@ static int simple_bridge_probe(struct platform_device *pdev)
>  {
>  	struct simple_bridge *sbridge;
>  	struct device_node *remote;
> +	struct device_node *ep;
> +	bool de_present;
> +	u32 de;
>
>  	sbridge = devm_drm_bridge_alloc(&pdev->dev, struct simple_bridge,
>  					bridge, &simple_bridge_bridge_funcs);
> @@ -220,10 +223,26 @@ static int simple_bridge_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(sbridge->enable),
>  				     "Unable to retrieve enable GPIO\n");
>
> -	/* Register the bridge. */
>  	sbridge->bridge.of_node = pdev->dev.of_node;
>  	sbridge->bridge.timings = sbridge->info->timings;
>
> +	ep = of_graph_get_endpoint_by_regs(pdev->dev.of_node, 0, -1);
> +	de_present = !of_property_read_u32(ep, "data-enable-active", &de);
> +	of_node_put(ep);
> +
> +	if (de_present && !sbridge->bridge.timings) {
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
> +	/* Register the bridge. */
>  	return devm_drm_bridge_add(&pdev->dev, &sbridge->bridge);
>  }
>
>
> --
> 2.43.0
>
>
