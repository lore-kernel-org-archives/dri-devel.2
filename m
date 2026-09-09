Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B971C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 19:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D546610E1F0;
	Wed,  9 Sep 2026 19:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iONPoCdh";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011041.outbound.protection.outlook.com [52.101.70.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E4A710E1F0
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 19:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7bcSyFDYBxgX4ifNu3BJAEBfksXJhwmLvjfGbKjnh0gXfd3x+tYmTQMro2ECJ22mPOnf6SNtCqQvq8NKPtAENscPbm2TlTdTK16hMAjekLMM51B1p7fc8mRvYDKfOX2v5NY+lZswH74RiryPelaTU/MHjFCAwiCGFt/0ooD8Z4wUezmp2/C1zTmTnSXNFuuLvMAVudpx0WW7Er/qSHW/XH/uqvo9Nd/RFmSIiStjP1Gim7GEBImWR6AHkzg+KUUUn94rU51SP6M8R3gnwPP1uGo5XLFeUBdW5MTc/x+dXtEkPFS4KsSRpRz7VzI1d/VJtPBNduY+o4Nv4e42o0H4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExRYy5OujWimq9Ood5ruXduIunOMnQ17vRXuaLhUZ0c=;
 b=KzBknluCwo6Wix3+3vFE6WRjXXjOH3JCN24Auk1gba1g8UhFHHesUGWBkglVCHE4/8imSGf2z0XUwkXQoBlW3zAw5iQ0NTvtgRT3Rb9hhplKYojyJUoQQkoNURVflStTTvREAX3xdFq3pshlPax5GZhxTbQXbL6QqsLeXq3apxFTmOWirRY8oJSmB2CW5Xj4TSHygIdZTrB6caPPWEwwjVbs/Xgg4ZCxlrTBYvWGTEOn8NaFZhs4WGFCbHXALcWOc/Wj6alj2ZuzZ+H6GJE+NpXAyDuXiq5SrmcKjBBu7K4wip6bqsCZocUyWPSzdOBDgcF+rG+jz7ccgVtSTFWngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExRYy5OujWimq9Ood5ruXduIunOMnQ17vRXuaLhUZ0c=;
 b=iONPoCdh8m+ZVdIEdKO6KEDaDNZzfNpbfPYykspz10qh+myQp7JkgZODy2Q8Sc5NrcUk12M9TuWFAqFNn62BZwnPTURn0USn870x4Sp5EgA6asVqtXY/Jn+2yEqZWrK5pA9u2Wm38s7Q3GyQj/GqZs3inzDO+jEKuymkNU2nXJJV0F+5WCc4Hrv1+0RLWsOE88yj0FdlchDnlmWxRptHKjqtHAkVt/21uM0MtFgj12FyS8073M0FR+4ITciHaSovgqQ+UxCBo9OGYyAshgJ/pvAFFu4gjzjy8qj44d7xw+kRkjtucJvNDtUfjOR91Q8et6+ZRedAhQT0hPnGw8w3og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8342.eurprd04.prod.outlook.com (2603:10a6:20b:3fe::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 19:18:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 19:18:53 +0000
Date: Wed, 9 Sep 2026 14:18:40 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/3] dt-bindings: display: bridge: Add THine THC63LVD827
Message-ID: <aqGxEDHZjgYrrOgE@SMW015318>
References: <20260908100230.83796-1-francesco@dolcini.it>
 <20260908100230.83796-2-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908100230.83796-2-francesco@dolcini.it>
X-ClientProxiedBy: CY5PR18CA0032.namprd18.prod.outlook.com
 (2603:10b6:930:13::35) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: daccbd1b-0605-4570-8993-08df0ea72f7f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|366016|7416014|376014|10067099003|11063799006|4143699003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iQsddF8G9es0Iit4bAqG1DYCzHLdsPt523iJC621e9u73LkQGnCXP88LaO/dvKw2YrKak7YSuYv+IQ6rSP1Y7unKMSiuEMRnC+m9Ll8ZHamWxdrYVnCGBniBoH05+0qHbnlPoiJTWfQBd4cgjRfHmq6BUz760Hyl9ncO3DmqOuHVYK4VmhK8Zd7OO+04JwQhcI5pHEK5cPq0OG8HjMLehU71tIFogBzZBNJDss9vv42cLuBFhyQSM48du3VyG/vEB+VoDOJGRoPIFPNOSjoS46xXDVtxuvxLhxEzBwjKQeV5U5oFU7lxepfOp1ljmsCr/ahW72XtFIlffIrXAK6DiGE8MwoJo8phhk0gF8ONZzSY5pB/SKMeV+eO7EjxqsFCPFK0bIWWoWV86HmsnlWV016IkV64fYZX1/GzXH5v2jCRyr3ui8NHASWMwu6HLajkVHBpTCYdDVn8SyMg6x5/K4MIws7AzQfBgMe5wblknMHIQqfybFqpwOaoe7WJE50foYGpHrcRQumDIcFsEb+RtrckFCvAhIyG292FDUdC1pYW0K2afAo2X4x35Kz1gNKwearSysKEbxixbQvxNpixlNj6LqWcqfXB6OXIXIS2LZDpMaMVrDk34Vks/3pDKvUf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(366016)(7416014)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3zdh0xWuitTKpxO0Q53cpiS15XOIx/OQy7iPFlY90HKxWry8lrAR4bKwS4wg?=
 =?us-ascii?Q?nyDsegrcLmQNxGCmaCE0/Y7CkWmxTS6IJ3e6gCXtocHnHkDQuiY9Ds1A34/9?=
 =?us-ascii?Q?Jy2p8ZbvhyDanZTsU2HOSqvRwqfYdwKJa6ex1ke13407ob1YD9mGi5fTNXEv?=
 =?us-ascii?Q?I73GzmS9Jj2lM9H3t2f8LgEaxPuBDkwQkffUJOzqBT5X0Bd3j4dLyZWNUno5?=
 =?us-ascii?Q?7tLu4lnvoiP5SH8MmHzR6m4XWTX9KJg4CRen2ZnyaRU9c5TebGJt1k509BvU?=
 =?us-ascii?Q?vdVAb/uhOvdY0Y/20rfJjtE3+5O5GbXj40EfqeVYY3CqabgRHgg/ANhxPAgD?=
 =?us-ascii?Q?OWBGSaJ0q9fe3AU21tnkZBJcp3EJ9intyFsF8M2pxlNbUAHGv1qK0zEe5Oo5?=
 =?us-ascii?Q?9Bp3NFS4sFf8DjtC2VGebpX4tznYBjgzP+JhRUqvhBGzMITzyQDaKiqPeDRD?=
 =?us-ascii?Q?4x0aWyU4M843tUlYOw8jh+pBJy+bPF0pjbjt259h4UqtrU4MnK9lcLQhdeaU?=
 =?us-ascii?Q?eCeemyqXW9ymzMJBEOJ1WZYLoyU22fprdOo6vUmDmmaHY0kZD4DxhlrIPNmz?=
 =?us-ascii?Q?uIQ3kusLdvo9RPBXzlXlxeD6MytDrPUMM1QE4xK0vIbkdZnEFOoluaSvuLw/?=
 =?us-ascii?Q?a/uoxbSr7zVjqCiEMQddiU1SJmZyil8Oo2NP4Ysx2WPAyTtLAo1hsAT0606b?=
 =?us-ascii?Q?BLaporW2f5SIMoLhFagVmFwtt9nmK9oH4qFLJvIVcS4boINA9rOe4cADBTKW?=
 =?us-ascii?Q?V49rqewRPj7dRA21xZzxQq7PRcnaw5UjXUDb/AqebMV001mwMS4V9AoXKvp4?=
 =?us-ascii?Q?KJ/OlnTM0oZHeM7pjWeDLJk/LTLIeo7W21XjlE/QX63Ob98FQCual1jFdgA+?=
 =?us-ascii?Q?SwqW3jie3itTpnVMc+YPmLJ6lo2ev5h50BC98rufKQDu8u3Ec7+thxqfFSZi?=
 =?us-ascii?Q?M4UGLtdea68iVqRESUOVHL0rpF5bom0xfP0CbNHhkfImCcGLD+DLuaLacsN4?=
 =?us-ascii?Q?DMtnBeXb6FWu/7b/2KssCH/KYeKWTPEzN5iyEZGhMp2BJcxD15N5P0ZYQ5zH?=
 =?us-ascii?Q?1B4n3TNP4Ld7dlUIgs7iCZf62Zp0XEYbtLSdczOKcsced+XSBMOm5mneGzc8?=
 =?us-ascii?Q?1JmcPUmJqrtyv3g464CYS1ZKkV3yRVseMfbd/MkvERrW0iE/RninNe7jWnIu?=
 =?us-ascii?Q?lxolrwmidSugQFEBT+zWv6SQngEgjX0mCq8KCfRnVeByrdfHLs/yWwl3gcAf?=
 =?us-ascii?Q?r8m/QM11mGnlIpqd7yYTsvjokwgwGhlrYuALlK3AvMYO4UUN9Mes2pvhAvKq?=
 =?us-ascii?Q?X0K7L7Qdqt64WeYFr9xtQwPmmpUV5dCi5vsCqpaiYj117YOKsheh4dGVOCTY?=
 =?us-ascii?Q?yHCuuyhXUr1K4wijQU58LZZtq/o4E6ZcEpb4Qecw3Wobw6aQ9gpjnvA6P4tc?=
 =?us-ascii?Q?hyLp0hvG2jIUQkrtHKiA53Kll76lUjPrRyYIIlPiLSJnTQ/e7vtowepVcW24?=
 =?us-ascii?Q?yw3jCRyVrcwGTGfmIF0/NK+jfETYX5lcCjW36qH0E+lUSxHXAdnPJGqOcfTW?=
 =?us-ascii?Q?AS063sjfSCJwIPk9bYnAegpQfyWVGQOoQJmqUT0awSCjHNeC9fvnWQ6E9zHQ?=
 =?us-ascii?Q?bVoVaBMU6pCQVMgfujNSwMDnTPK4yCS7Hmn1AbPjEk1gEGK7t6Mu8XgSDEUq?=
 =?us-ascii?Q?S7FbrZWRO7WMkZG7a3uGnp3NEaHGPwgSGtRh/PghRmo21zeIgz5cekJ3/XMI?=
 =?us-ascii?Q?u8cscWoBuCrKvcFWrA25daa6IfIwIpI0L8NpIfq7owP9qx8GwvTh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daccbd1b-0605-4570-8993-08df0ea72f7f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 19:18:53.2545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2JjU+jtBnLSYJmfOIvUYDIvNfYQXI5nl525oqekMnOwYTBlKHxnS4yIJf6PVCe8uEsWNxZO+yyudnekNDbROgst4N7b/3Cv8JuYmOmQ1GPDGqwTHpkGYo1cYG0a+lMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8342
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

On Tue, Sep 08, 2026 at 12:02:25PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Add THine THC63LVD827 DPI to LVDS encoder.
>
> The THC63LVD827 is a simple DPI to LVDS encoder that can be configured
> with input pins.
>
> Link: https://www.thine.co.jp/en/products/detail/THC63LVD827.html
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../display/bridge/thine,thc63lvd827.yaml     | 126 ++++++++++++++++++
>  MAINTAINERS                                   |   5 +
>  2 files changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd827.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd827.yaml b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd827.yaml
> new file mode 100644
> index 000000000000..ead50802e11e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd827.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/thine,thc63lvd827.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: THine THC63LVD827 DPI to LVDS encoder
> +
> +maintainers:
> +  - Francesco Dolcini <francesco.dolcini@toradex.com>
> +
> +description: |

Nit: Needn't "|"  should be ">" here

Frank

> +  The THC63LVD827 converts a 24-bit parallel RGB interface plus HSYNC,
> +  VSYNC and data-enable to single-link or dual-link LVDS.
> +
> +  The LVDS output data mapping is configured using the MAP and 6B/8B inputs,
> +  that can be controlled by GPIOs.
> +
> +  The LVDS output link mode (single/dual) is configured using the MODE input.
> +
> +  The parallel interface pixel clock sample polarity is configurable with the
> +  R/F input strap option.
> +
> +properties:
> +  compatible:
> +    const: thine,thc63lvd827
> +
> +  map-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the MAP input. A high level selects Mapping Mode 1
> +      and a low level selects Mapping Mode 2.
> +
> +  mode-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the MODE input. A high level selects single-link
> +      LVDS output and a low level selects dual-link LVDS output.
> +
> +  b6b8-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the 6B/8B input. A high level selects 6-bit (21-bit)
> +      mode and a low level selects 8-bit (27-bit) mode.
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the active-low /PDWN input. A high level selects
> +      normal operation and a low level power down the chip.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Parallel RGB input
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml
> +            unevaluatedProperties: false
> +
> +            properties:
> +              pclk-sample:
> +                description:
> +                  Sample data on falling (0) or rising (1) edges of the pixel
> +                  clock signal.
> +                enum: [ 0, 1 ]
> +                default: 0
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: LVDS output 1st link, used in single- and dual-link mode.
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Optional LVDS output 2nd link, for dual-link mode.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    lvds-encoder {
> +        compatible = "thine,thc63lvd827";
> +
> +        map-gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>;
> +        mode-gpios = <&gpio4 11 GPIO_ACTIVE_HIGH>;
> +        powerdown-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                endpoint {
> +                    pclk-sample = <1>;
> +                    remote-endpoint = <&dpi_out>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +
> +                endpoint {
> +                    remote-endpoint = <&lvds_display_in>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6215fcb07770..0b5a25a35367 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8580,6 +8580,11 @@ F:	Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
>  F:	drivers/gpu/drm/bridge/synopsys/dw-dp.c
>  F:	include/drm/bridge/dw_dp.h
>
> +DRM DRIVER FOR THINE THC63LVD827 DPI TO LVDS BRIDGE
> +M:	Francesco Dolcini <francesco@dolcini.it>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/bridge/thine,thc63lvd827.yaml
> +
>  DRM DRIVER FOR TI DLPC3433 MIPI DSI TO DMD BRIDGE
>  M:	Jagan Teki <jagan@amarulasolutions.com>
>  S:	Maintained
> --
> 2.47.3
>
>
