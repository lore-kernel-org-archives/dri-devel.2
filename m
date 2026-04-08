Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ED510F9943
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 14:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC01310E687;
	Wed,  8 Apr 2026 14:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ia3a9YU6";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 520D110E687
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 14:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ih2bMZP/MUUUEAl6tt4fdE0II9TCEkVno4N/JlwjRsQ2judaHciWnMsFZfYoNrb+wgxdweXDYis6iRxjoX9Gy6N0YfLjhlAg7QRAXhMV67Euuwu3W77pMy/fdOSHSc9dQjG2Ns9U0ZcwB6q8nTIoJ4/uAvHoe3sFKSENXOY0JmslF2VEo+HW6WRAPYpYjvzCtC4rIXnHL6EGy2scR1J9QZKMBvv2pTwZG5Vl/qTmKKVl870J5CbzSzPmP6SfTW91qpz5IU4/bAwMpyHq++UlBq4Jw4X7WuX+xz6Z7k1H/aAnVyBlcDCogKK2zofZT7vKO1Nzztd4Ju1aGG6EkAFdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=297WAgKQeW0KQQcBc68Yf3iEK3gX+VzLajW4fX7A2oE=;
 b=PLFrKwt/qKxLe+XJgMTAV5goPlFLIsnFf/7DexP0r3OYbu5eHOaZIAWojaYXX6nWu5wj5hfxtymaew/21Zti1T/9bDCJTkpInAV2cmIXuAlNvfTIdIt7eDEd6ypyPTvz+MykP/6AK1s0LsWOv/LCvz7YWspHmofB+cQAx2rYn5bQwSm4af82g3/PaFQk2CFNCAbNg2rcJZLu/XZdBj0KuhIHGHTEJJRCevlzQw/srmObodafP0CLqAUOs6YRULehaRLJGwxGBUyw2OGaMMy6AiawLxJ7mADl060eYScwedWjTdX7l91LzWZE/gctlK/luAOueNBOjkMseT7uU+0HOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=297WAgKQeW0KQQcBc68Yf3iEK3gX+VzLajW4fX7A2oE=;
 b=Ia3a9YU6HuNFfAScVynEYdhpF2oU871PlVtmSE/KquZYILNq/mVXGP6oO4YNHazyKUbdtMYLgjPgqAiHSIxKdHD/Ag+oXBWBUepYokN+8VAxXkuxKBjBfCFcPsiWr8waQO1aU+1Tr7Dm70Sy4oVsMey0X2qSJc7pwRLKA6NDI3NqVhuID744290B/laS7hVQGqkbhA1IZp8nR9BFt3wHjXGrIclmISShw3NqENnDdw4haVX4gmMnO2Qc6nsY5LOJI9ZaCmfeDFeAJmtp9XpOaG2kZEekXIP0talAP/KHEUX8wkEFntu1CEcIpcznrT2jJWu/rkl1PRjgDVSW/5iVEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by GV1PR04MB10251.eurprd04.prod.outlook.com (2603:10a6:150:1aa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 14:36:25 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 14:36:25 +0000
Date: Wed, 8 Apr 2026 17:36:20 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: imx@lists.linux.dev, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Ying Liu <victor.liu@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 3/8] dt-bindings: display: bridge: Add Cadence MHDP8501
Message-ID: <6avfg3f5djqkdvq6q6ouyvw2ms25rvixpluxqmbzey6ylnesnd@2st3tvlmxtvv>
References: <20260407-dcss-hdmi-upstreaming-v21-0-4681070ab82f@oss.nxp.com>
 <20260407-dcss-hdmi-upstreaming-v21-3-4681070ab82f@oss.nxp.com>
 <20260408-large-marigold-pheasant-bef65f@quoll>
 <wowfuuvnhnm6fjuynow4uvle7idvuyf77hct46gxakjre63y2z@xlmau2vl3lwb>
 <277cdf3b-7032-4847-9c22-bddae2a76b34@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277cdf3b-7032-4847-9c22-bddae2a76b34@kernel.org>
X-ClientProxiedBy: FR4P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::14) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|GV1PR04MB10251:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa5ec6b-e647-459d-4abe-08de957c3625
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|7416014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: wvOKoo6F9m81QTJQhL7hWhiuy6K60hNWYdtElX6sq57p+8/PppEqUv5dY8OYfSKpK5ZVUpMG5DbXffnV9nzbrbwNO3yqHRyNfXYIYFKqpoVDMUhzPYh3JILPJQNVN3Gcy5nHOJmQoAh0uj19Ko8qr43iqUg6RloMNzhMioEZcDz52dxIxYMXw8IODUeS1ymgG7tHazp2w89+I5Qqic69n+BtRg+V5vDqtFrgg04Owr+cMpnCmG1wNyYTCrkgVJx/a+YZdsj46qVc2UCXG1h5xrTQnwoci0eq3kgqsTRr91mOrVCf5ceUQ4+kAcNTRNyZXkcbYr/JNOJTb8uyj4sHZpDr7p20FWTcY5EUAQGuJcmSGbk9mUWwBm7wc7WKwx8Fl2i1n7uJ7j/PtfvTJGo/TcnH9fGzWAml3n0RC3FT4eFFMNYAVAq9ahokdDN033TSe3ME3ebyNR5QF3xyYuesuSYm30hgQCFA6XhFvB2tDWy27Ypg4DUrmySuIT537FjnuCKxBBuGPNClNMpjKIeNhqXoAKsVhexAjatf2Q2fRNFq00kguWSr0UqsyDDl5dBlcOqAhLInemE7+8eo9T+ojBQIGDRT/hYURGng7/s5sXqybweUnbHjEseQmxZ05KdvNpesw16cvJZnqxUIDl5e5v8dq+fP6q1MtLPq5udX5wVNLPeTq++gNzJg44s5kg9qUUdERCqWy1nNEZfuR5I0SLKiCuvx+NIKvSZMp0NBFmKGS/IVBarojXylOsL7xFS6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(7416014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lC5WOJuq683uoX7MkmKMoJKYFacg+A2gO80ynqg2DWgXHom4xeiGXuXQHRqA?=
 =?us-ascii?Q?vZioIo1FNctG2SmuaXCzYBZhPB6WnRlmbVn1wgT4gfuKk+3gteh8JtWJqOQw?=
 =?us-ascii?Q?ZX2puQ61RBQkv4qOBAT+4K/aTxfc9hGp3NZW2TQk5pX4tUtwYs/kX/YXMFh4?=
 =?us-ascii?Q?rZApnvgEQrdfX9G3zFs1ErJEyQKzruRYG42JgfZcvcOn6W2nOzok1rPRAOkE?=
 =?us-ascii?Q?3mreZVUzxc/KujG6b4LIOyz4Po3NHeivqDPXm2W5CZ4DXWlfcCdfbN/CMviM?=
 =?us-ascii?Q?6OV76lfgZ6Z/IDr8hgVCe+vuFNApRRdljYLoyGc1Bm/0bQn59uODcpMhxbl3?=
 =?us-ascii?Q?38fkdRZSZLeSYhKRHH81OvSi4dMMqfWrWWPjkeXtWRI1f79sbyUbYy2CDmzp?=
 =?us-ascii?Q?aGxxlIHuK+rOl73EYpcuEpcw+tMMYsB8znRAF/92G2y+INhznP+opTkp71gd?=
 =?us-ascii?Q?jZB1e7uU3S289l2QY6Yfyl5TE9MIYisF3gJsKOwWTHXMeN8vDu7o2rv1W8XG?=
 =?us-ascii?Q?HJtYTunGd6RPUEb4NHe+w6kPIpOciRSYsN4NVOBRboe/IH/9XwlLOTdjjDXE?=
 =?us-ascii?Q?cptc8oQ0/2MUFX4sM48FHVD0Au2phuYlulPBw+LMdBdpwU0UgNYoe/9PYii0?=
 =?us-ascii?Q?k6jLmT8fxl3ycGDx/JFSwAojBi2JxV79xUC8cpCTM1kvwF0QsFLwYkX9IFr3?=
 =?us-ascii?Q?/cMPDpv+lEaSf7vNUbBkxiomKs5LNW42FcsvgsN4ATsu+fMHmMf6yqT6eXDN?=
 =?us-ascii?Q?+DtE4mtHs1obLKi2QsGdlnlexwcM1LsfGD2Vo7ywUxyt6XF16Y98ZN5ULkab?=
 =?us-ascii?Q?vsZv6S5aZIDmYw3lImJ3uKtO8aA0W+IMjB/abRTYD3IyJbwwqmJG8/Sc26WB?=
 =?us-ascii?Q?/WNqYfarbZVz89SkkCPNxkTrW/aRDZAmmVNydHunc1RlmEOf4NasNvfc6kCo?=
 =?us-ascii?Q?3pce9IyrPn2JyNQenCnzsD8yaj/NJMDlhuU4jlqNBM8cHHSVLMmQuKdKh2n0?=
 =?us-ascii?Q?eljrMuApLV6VfqAvPWUdf3dz9U7y96i2Kll7r8EjyAyPe9e/t6hiiuabvehm?=
 =?us-ascii?Q?iVDvH4OCYljdlitLqa9PaYANn/dvFT323Xx9Y54wPaUdura+Kk8OnBBWnlmp?=
 =?us-ascii?Q?jNAxQK2KIj1WbFgFYsRol+7D8B9p9HcR0NZ8dR7JkMsjPqhZ2tIbDBBJtX04?=
 =?us-ascii?Q?sCFMIxLDDsbDUtyRuV0p1c9Xp4OMqYT9e7PkoRBn6ZO+CnYkRFsJIdS+MQc1?=
 =?us-ascii?Q?N/H+2SoxfT+FS2Drb+d6RIZvlpDCzHfFD788vL1dIt/JMNyKwAIz0gtONtQV?=
 =?us-ascii?Q?mM2e613/J/6yclUVhzuFXe8gVKGWBi1B8PUr/vQrke1N0sSdgc4Lc9jIY/jv?=
 =?us-ascii?Q?Sq7PgGrOXq5bvCqvb300wlJzm/a+nDrvctuPghGMhdi/It5Axyv2il3lYMyK?=
 =?us-ascii?Q?3YdU4ZdXOmBPRc9v7kqKzuAaFNST1g/0uaDRjn+G2hOMQh33LmjuXglx++lK?=
 =?us-ascii?Q?eO9e/nOkURQxJe/oXmHZi7E4xrUgrIaliCvkziEs1O347FK18JQQoIneUknE?=
 =?us-ascii?Q?5znPQrzo/lh3pM7Sc7B7lk4GL1Hh1847vpQ8HnBErwkz/65V9kMnBf/MLm1P?=
 =?us-ascii?Q?YfKvy5l4JXtqIAQX+15r2I5Jmx0MQG5q+2NBkVJMPi1yiCCXnOqwYMKwKb4B?=
 =?us-ascii?Q?GWHxlljY0BgP0bH4PEg7/f+OVu9CMvV2aOYW+D7OQhmApHEz2ozzNMprQbTN?=
 =?us-ascii?Q?z0ewJaakgUKAoRMg7Pqpxp4WNOixcC8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa5ec6b-e647-459d-4abe-08de957c3625
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 14:36:25.2619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YjRgYCVYPAxQnqnG9I7uU6sfkEBZklEY96WEkQNZxxUS7uEF7lerPoWyUZvss3lkLxlvvQ8z4f9ent+KCWsnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10251
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

On Wed, Apr 08, 2026 at 09:32:54AM +0200, Krzysztof Kozlowski wrote:
> On 08/04/2026 09:13, Laurentiu Palcu wrote:
> >>> +  phys:
> >>> +    maxItems: 1
> >>> +    description:
> >>> +      phandle to the DP/HDMI PHY
> >>> +
> >>> +  interrupts:
> >>> +    items:
> >>> +      - description: Hotplug cable plugin.
> >>> +      - description: Hotplug cable plugout.
> >>> +
> >>> +  interrupt-names:
> >>> +    items:
> >>> +      - const: plug_in
> >>> +      - const: plug_out
> >>> +
> >>> +  cdns,bridge-type:
> >>
> >> Drop property. Graph defines what is connected on the other side. And if
> >> this is for different devices then compatible tells what bridge is that.
> > 
> > Initially, Sandor did use the remote compatible to decide the bridge
> > type but he assumed the remote is always the connector. However, as
> > Dmitry pointed out [1], this is not reliable as we can have another bridge
> > in-between this one and the connector.
> > 
> > [1] https://lore.kernel.org/all/dpj333mzr5azqhrgw3cxd7x5kiwxms4iomwy74uqfhr2zu4ocr@36rkth27d2jc/
> 
> So you still know what is on the other side, e.g. second bridge for HDMI
> or DP, even if this is DP over USB-C.
> 
> I understand that Dmitry did not want to use that part of code in the
> drivers, but what is located at the end is not really a separate
> property of this bridge, because it already duplicates that information.
> The final endpoint defines the type.

Ok, I'll drop the property and add a routine to traverse the graph and
find the last endpoint.

-- 
Thanks,
Laurentiu
