Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDF2C531F7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1736F10E59F;
	Thu, 23 Jul 2026 15:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mdGD/Gm5";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4E5610E59F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 15:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPwZboxdV1SPzw2xgpAKKq57EXbXhRt7bPwQ4FFPmaUwa6jkvzsej0Ps7R1NC0YehtM0+/z2SYeVn2RvBgnKYS4po6KYXRhICH/zaFwTSyTtixt87PJUMbcd3Fg0sv8r1oh8u4REJMRqSjTYexHtPxlsYNyREF6RpFiz6w1Vrek4slAo0D1JgIxTAitRXBJqGaD/gmHqsAI+7+UU9TsiHmEM+b4z7xv+pMPPPbCab3ki/Kbn1avXN5m/VxebfcU3YyHbq/0WBJrEG4YPS+qz06FHVwrVUFeNkwcVqcc5VJrOzH9xJBxWpkPDIqUd7wTamsp4NaMhybqmBwtBGej/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=819be20x/EqzGMHq1CZyWSzhU839Pb6DXfpbLFHq5mI=;
 b=FKB3hkxBV99T4V8fhSvG/Xh0W+LUhn21BCrOqhnXmzrTfjBiBeduVbQdt4dT2vJb2PlhjZA+BN4h3UTha6RajM+XrIxo/dxPzsgC/2/CVhidhbu6BNh9NKyg0xPcevbiikbK+Qokl7liH487oDAujBOi2f4vIm3ijwMHECwfWKQiU0+s0Y36fvR5OQS7iTI7z6ZWpOlK4Y0X8v8I6JxIewsIaNT9OcjnTU5AvR9zKpPuXJP3Pp3G0ocFOwlHCjWpPJ/k+c6aqipXqVnDh4NhHLnz/r3zUPVMEUf06gf3tY3GdXkeacJWdun8dD4Yfzp5EXOxiUI491jFcKCfpLpjhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=819be20x/EqzGMHq1CZyWSzhU839Pb6DXfpbLFHq5mI=;
 b=mdGD/Gm5qQ/BjeGB4CmH/qdo3sREkKB6AMPc09F5wt50IvRmktLXKLkE+20VLtv3dXp/xH/IjCcIBGzDEKvWvbakXfY2ihZXf42GMtrkQg2nfITrtzz4/Wi7lGIZlZRivcgKyUNbUFYgPQwV+aoePHe2h8x6Pbx73EMqXezBaQE570nlmVB67iw9/6tpj4Zdo7wtpOn1JchFPJdGf+Gsy/XPp4/X/TezUk8asIp4hObFTIiPPG2Sk7KLvyMmPpvtuKft9L8URLoaM5wViXXc7jmw0huO8IiTc6/urKq+yZkuw9NB0a/FTGHNviuFMiJrDSJ5ezKY71Wh5U38+TFv9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 15:45:45 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:45:45 +0000
Date: Thu, 23 Jul 2026 10:45:32 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: lcdif: Add endpoint bus-width property
Message-ID: <amI3HKLECuZBHLs0@SMW015318>
References: <20260723093813.180089-1-francesco@dolcini.it>
 <20260723093813.180089-2-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723093813.180089-2-francesco@dolcini.it>
X-ClientProxiedBy: SA1P222CA0072.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: 4869c6ba-393e-4634-aeb5-08dee8d175bc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|19092799006|23010399003|366016|22082099003|18002099003|3023799007|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: QF3X/a23TxTbx+2CrXSihV5iBy8R7/R/mXNUpFWJ3TDpS1hQUohBChEymOwCIdlAuLKVpptkhNKgn3juIgRyBt4xBicItBp8OO8CIX0P+HxbFaoSqypktAhyvIeJteaOLw/180tlBMrO8NUVWOXRsmAHpRlCK1hYxyJty6HUWmdYkgrI+4yJfRMD1dOltKnbeT/KQ9WGFAkRhZG1bFOKeRGPSrFpRRVFdZjHIR7tDcmV/n/xw8bm88asIZByj0j1COSn1ifiWKicrAjHe8HUdxUEyYekqulBFYpPYbvb3pS9phTuittvfUxNMuWh7KVna+8CS3ihmgmZQSGkPDYGw4PXV1y5veANF7oVOqhhMoY4RjZW/Vw+ZT3NJVkklOyAkY/9/6g+4L1C1gHTJUnz/mQsjjAdyz+xsP132RE+fA19tH9glkgSMGokDFvI5IqYd8T2DeyUc7lGkC6cP3S3EiP6jmjMjKW4wr+hqlwunzAhmLMnIBGxAdgSHrrduMCzIbCdtmHIl17PapQaBaemsWsjayDXF5IcUmjQyoonw3Rb5MvbCaj+xDS7Wx0K2HDm/3ANCJskkb/ixwPn2MhqNUROZlHfAgpREZJHiiA/z1+aqaAf2nDGzCHKi8d+c9UCHwzk44cb4EK1DdHQAl1ptq89EX3ytO9TTbIWKukXz/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2/DFloXTR2okcEoCTPm4AeF2IDXM2GUUKD5y6kczQI8yNDXeU3ME7WOqSyC7?=
 =?us-ascii?Q?6v0mF+J/bkxQNBV/juBOnNlWyrkM6jY4tagMCIaUJhGUo7y8V7dYhoUh6Zh+?=
 =?us-ascii?Q?dAkkw/wxnzNq78dJ0BN4OQSscbh6tsWydcM6YA5kZ4vlhDZn1bdTGfz8G+1s?=
 =?us-ascii?Q?k27v72ipda4Scf5QerrQexeTnmLIfH/GdFvg3WcajUC7VuCpjmqjYaBUp6VQ?=
 =?us-ascii?Q?BV/nLeq3zZpBCJN21F55m6HPjLKgiHilysD7r0+tZU+Qne/VyBj13XsNbWF4?=
 =?us-ascii?Q?VAcVKU04T7l0JuEf62C95dkJNZe6Riy3sUT8naK0eZ3wzIY8UMGAvrYq1Yyy?=
 =?us-ascii?Q?eZDrExkgXUXqwMFSDA+E8Cfr1yX5wFhaLh4msh0EHvngBA/5443wQJfEfQLP?=
 =?us-ascii?Q?hJCjZQ8i2IHHGO8LortnJiiXYjxMSrjws7y+rYLK/UgAjeW/tT11stArJAyV?=
 =?us-ascii?Q?w+c0DFdb81JG6sOMplme2vGXPhUFbKKKWUZNprh5ENmBtXsPOgYTXwhPSBqJ?=
 =?us-ascii?Q?YaAXY8x0ZtnpZx4G9KFH6siwOLBgv+cmjznB4FGHJMe4FMLNrTvXt1trv002?=
 =?us-ascii?Q?dx73ptJQWYWYmXZGYFQeGoUClB09RSbFhnhTDC0CWdMmyWG+lVF7chLr2XpC?=
 =?us-ascii?Q?dv7N0LMhEUaOpgV+UasgzFs7hFWyBUqmP04eKyh7yEpw4C3LTT3CR2eZlfFD?=
 =?us-ascii?Q?xhDcbYleZIui4soNs3DgeFutGwSac/XK6E9wAtbvRnNWgb7905DJ65mCFGn4?=
 =?us-ascii?Q?yboOkN4meSrIm9yv0kbbEyXn7QEzY0t5HpN8soYsJ7ryualMzO4LeoqEy0ai?=
 =?us-ascii?Q?f+ma6ZOfjze1g9DAsGpL+N0b+hrx6a396GhUz6pTK6mg6PXm+ucjyBhnJJIM?=
 =?us-ascii?Q?VCpDJNu8tf4t62/3O5O4E+ApaCqsxQ+olhVqgyJlARhgrxTY9A4+UIsPF8jk?=
 =?us-ascii?Q?m2Dj0u2JUVrrB5m+c3UgblvbXgoCMUbdnoPqIkMba01luGdqEQ7sJ5sEgend?=
 =?us-ascii?Q?L8oHj6EMIKPYMgePSlSCxIRem4Vo4aZW9Tstyz2yhefMJ3nt8PadmPmYvwjQ?=
 =?us-ascii?Q?IVnBhSDn2iru4h0Ba9rSLn1TDHbXyK/hRB9F+szw2vnxoPQhmNSn4uhEKT19?=
 =?us-ascii?Q?NBVf+YrsDpYfovs5j83gniEPvGBltEM5imOJDP7sWM9NiX3WGEZ21+emrQ8o?=
 =?us-ascii?Q?7mdda8G+wfSBxtZ91hYxU5UxkD/s8NR3NAsHmQkZS3x+5lKDOdofdfjvNmF4?=
 =?us-ascii?Q?/T8Wffa6B7jj+Ey+zORHGMZjLP1JMbPGIbjJ5w9jpGGa8NiDyQNwRpn9V0pn?=
 =?us-ascii?Q?qJq2aiSL0ltgkVW/FLPPOhnQf/GX7zLigl53WFSQSvxczfMt6cxMON1rnsnH?=
 =?us-ascii?Q?ORJy2fFg556IDCp1WsPNYgJ4Bprsdr2a96w7TElqkpqKOfBJ+ru2mbaNOE4o?=
 =?us-ascii?Q?ZkUiIqsIENG/705bmmPkKEynvwm1BSUwYTsYh7buAN8op3UsfrCVoifDbatI?=
 =?us-ascii?Q?OGVxuqioBcTUWE2OtiaLWu+APIKqL01VfrVALHZ2P/WNwMIFFVEfcgSz1Cm0?=
 =?us-ascii?Q?uaWFEDWd6+Mk2F9cSVXp7uOsNsCBUJ3VWapYzMf31bBJc1q3DwiAwHS+fM7t?=
 =?us-ascii?Q?Y397t/QtDi+nndDWKwBp4JeXKWBPY2LXgWnRPizklLP7LYR8LHlKxr9e8/wC?=
 =?us-ascii?Q?wL9LwEDdQ15NedTdAnGOsNhn1sTx9kHMAt4sMK1ABzF6nHIKff9GJez0lTkn?=
 =?us-ascii?Q?E1kJSP3UAJwILA2PMVcxEpMncXLMTnsl2YICAIRipEwANIlmwSsi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4869c6ba-393e-4634-aeb5-08dee8d175bc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:45:45.7745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbGfh4YFoTmpPiOkquxgjhC3zibn3krpqOG7MbXhWc6IW2sFoROm6YP4ag3sJupy6iGyo85olOijxnR7HsVnRq9qP5sD+faj0j6pIyLNQrKhXs37P/oh61TD7bTM3qnh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8621
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

On Thu, Jul 23, 2026 at 11:38:08AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> The DPI output of the LCD interface can be configured with a bus width
> of 16, 18, or 24 bits. Introduce a bus-width property to the output
> endpoint, specifying the number of parallel RGB bits connected.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2: use the common bus-width property instead of the legacy interface-pix-fmt
> ---
>  Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> index 2dd0411ec651..6931f0ae3829 100644
> --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> @@ -71,6 +71,15 @@ properties:
>      $ref: /schemas/graph.yaml#/properties/port
>      description: The LCDIF output port
>
> +    properties:
> +      endpoint:
> +        $ref: /schemas/graph.yaml#/$defs/endpoint-base

Is it better by use video-interfaces.yaml# ?

Frank

> +        unevaluatedProperties: false
> +
> +        properties:
> +          bus-width:
> +            enum: [ 16, 18, 24 ]
> +
>    display:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: phandle to display panel
> --
> 2.47.3
>
>
