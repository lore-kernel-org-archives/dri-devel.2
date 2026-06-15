Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B953DCD98CF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2812410E4D7;
	Mon, 15 Jun 2026 15:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XJ4o0kUA";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013060.outbound.protection.outlook.com
 [40.107.162.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2941010E4D7
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1oOt6kfXHuAn91DbVHIYeiXYybCUBRwkSU5Ylj59i3K3h3psjHrpA9CEuWdaM+hbomo/5sdDQu3kH4RZ/G13myGU26Q8RRLfeyMgFGrwCcAMxfmMyZYRL+krUFhfBKsHlgdM0aJujyMsOqSwxLmEGwZCcQYUy4lWpxJqWE9a6RzGb6INHpsPWLYpqzIAv9C0MGgg5CYEccwZfM0rQXJwH5cNi8owD2IBmD+9ftBtpJoH6rm1pvc2bSuvBQ4hMwVlFNeW1PUe4bdWiPA2VYKj4B6QBtgOZGseaRDMluXoojDvNymtliCo4bxZVlL906u0h9S/er/ABCZUDrxOHNGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5o0JDDGDO8zNU4BK8mnHq+TmHQGM9+h8mGvtSeNLJ0=;
 b=aSFsjfEDzrCBjbYj8+T6K2xRzPo4BKJI+ycGvLtqgNLpJP8Lo4aOSH4KhZNC8u4USzAJzM4CO3B2zD0CLZ+Hzk39aw0axrcvULYhCxcW9yD87aNlUD/Sb0a8vHdmXGlCbRMS2bVPcGVvXn0sv6alycqmqWg3pVUdWMME6/sXXs92FCJ4QRxGXyOoDZrLopXGG2tslo6heCktExSk6xJGRnoZwKgKdMIKRN90nt2YAWCTZbWjRp0l4l8SJPYko3yNJfKCOOugRHVaH40/5U6FqOylZxp2CBNyHs3k7X7n3F5wun0wFb6GPfbAhcnnoGjh31Ay+CVQw0t70tPs02dJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5o0JDDGDO8zNU4BK8mnHq+TmHQGM9+h8mGvtSeNLJ0=;
 b=XJ4o0kUAzYAaRVcHyE+FTPVnlkTcFh6Xv4tmlFS5R2Rga+8mixBVAtRii/C4SXg7TOu5pMUJ1Q4iXRuNHGG3E2ht+KCu4gQ8fsdRpTxKUZvyJnCiLffyQ8IhWKCTqhgMkykyTzx9ELDV1wUGOjX3kvNSXtxu1SX7Bp6HdINlJeVmEBZ+2qA8Kxdyf3UZ+2sSevdqmMltUdPRjd262M00dGa4wI6e46/jFuxdXGIJUYmEYEeJ6ycIS4WV0ggC9VV+CYWfNldiM9o5r+PHYSYhw5rDvgLvRvVh1uL+qsefshynHC43fXijpPOgjKWjLYQ7g64jbT7JagJutBBm+VjDvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB9679.eurprd04.prod.outlook.com (2603:10a6:102:23d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:02:10 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:02:10 +0000
Date: Mon, 15 Jun 2026 10:01:56 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Ying Liu <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 4/9] dt-bindings: display: imx: Add i.MX94 DCIF
Message-ID: <ajAT5PHpw3LFAGpa@SMW015318>
References: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
 <20260612-dcif-upstreaming-v9-4-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-dcif-upstreaming-v9-4-8d0ff89aa3c5@oss.nxp.com>
X-ClientProxiedBy: PH8PR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2eccc2-1913-4c0e-baef-08decaef132d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|3023799007|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: kCitlsNXP1rTI48MUu6TJCumA2Ets+j3LT7g1x/UfKhLzIJklEBcOn/CLE2BfeGdF25ifv7mgRqWA9dTBYCPIYONyANoLFHOYNDptBXwsCkXLrt8z71qNQiez7exwMna77wf/MNn2WDerQVtqEbUt9paTgSN1iNZnqoY+TlsC9616K8bGy6rcy7s3Ri2pysRTKV1hvTHe+ZFceSOiXgDOp+gAEbIimagpmlpAlv82nhHdYUbRUNFb4QyBavDQzioFBzhaVrc+6dE1Sd2IGz4XGVK0WuzWV6f3CLGp/Y3+G0Ow7vOkMIfWRJ8R5nmhzD/XXc3R2p//57mF3ILiTiWCsQqphgqAufgLS1wLIlZOJkuQ8RrT0brCkD9U1jMRBYHJZ7U6ZwvB7ig1qAYdUqZPkzsMkFG311tKYuamXwwLGNh97MhnEg6wO+QywxqTI2Ofkmcn7B4Cv0lPRxs7v5HpaWlbRB3Tcr5HCkinKzmDRHECi+vw2+q0ErLAmM+KqxhONaqVlQdzuFCchQX/YgnNHmHHlMAM6qoje8vB4CSTI3BVM49op4gf5hWxNO+g4Q3y2mB0Kym1duM7WU43LGRwlGoLaTvfNkc/jo7r5fiABZq000B4yp59FqTxsoHOKtEW241OSTYb4o3beMEu6DcWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQhpF9to3iw2CuuuBzbfbIgoPkj8uw6XxSBJFWtJbT7yQ/V4RoCOs1rilnPu?=
 =?us-ascii?Q?h6BBxBEHm5lvpRnzLtQZKgEdd/vxz1mXlnUSbTh18KqpQooQMQhfzRVWYmFP?=
 =?us-ascii?Q?HpJIBHp1alrt+xz7r2Xm98ua10b9Te1AOax1fC575476ezCjA3BxnUdkmfvo?=
 =?us-ascii?Q?lMzVUWuCvKqN/SVBYGB5X2BNV7Olitxp3DPgi+U001QwzSYCkgq+5mtAlf6a?=
 =?us-ascii?Q?tNAzovqdZyfcjwY33k65APPU4oYMKEbpHcQdszFr6Qu4LhxaPV5Fk/yxbvTD?=
 =?us-ascii?Q?mLUsaV2EraEk8W3wxhR96TXDPV3av3xAZPgdPxpWSXLzs3dqQCxxDkzIifcD?=
 =?us-ascii?Q?nVwI2T772MbobF10Acl05HtxCe4zuHUBE7rSnEPWKARpBLR/USiKn0Hx7IfA?=
 =?us-ascii?Q?BLJKPQSYVtL6Ohch1Q2PCub7tYIdKbqxKwqbZz1j7sxO5CyMxWyLfM+onpMq?=
 =?us-ascii?Q?zPtoFWbTZOknO/CgLqx7KT/+MMpTl3byDjlSQ9dllI28Jn8xc/TwQLc65/OY?=
 =?us-ascii?Q?wZwBJKx9fkWFdXjArdN4rI/pFnq7wE0wBk9wJrtSqRcWvK17KThpvUArIINH?=
 =?us-ascii?Q?BjFvcfEmZahCPybMrK7Ple+/n/7tmPicVcS3JCtmH3TkVOO5qNlzJ6jL5H0Y?=
 =?us-ascii?Q?jRKmaYjTE+0xbHw8EvB4g1uRFOy4BKIRpaKOHcrLtv1WOqHXXh332dkro2PF?=
 =?us-ascii?Q?e93ac2j5q6QmGEsVjo6WvQAeXPcoM76w8g4MvssWGoFII+L1QBg2oen6O0vQ?=
 =?us-ascii?Q?VRI9Cgv3oZygG0y3JnQi/z6KkYO/M0agOh6CtJK/yaxza2xlh4ldVl42nzmH?=
 =?us-ascii?Q?tp1a1JFyKQX51Zi3J+gxsM0AGYZeP2v6aZ/OFiZuxGEjXkkgeGLWl6tmBHe0?=
 =?us-ascii?Q?yEVwdNDqNbAdvdsxzjqrqh7DoIE/gzyOcEnBjQEYL/lKVuiJSTO9UX2/XcYq?=
 =?us-ascii?Q?e/5KDNWTpbRApVKAMKNylHOEvnatZcbe2jHGmWzGcZT9phXTpegeLBIdXsGl?=
 =?us-ascii?Q?uwOM8+ZoRuqsh/mkDdqKQ7LbLlrKsWBuCiJYpFcdTpSESneA6hQqF546lho3?=
 =?us-ascii?Q?il70X+xPDsvJ0be/JC2EvctHzUZtjGGB4612VPtQxfUr2cmkNO/ZlbOGQuc1?=
 =?us-ascii?Q?N0gU7sRt7uM595ZG0R4rWLra9nabPE45qg6P6eri3VCI/ABh+Xjy1kAI/nv0?=
 =?us-ascii?Q?4rx/iBiyLsmh7pi3w9eqx0QLxI9Dxgi6qqM96rhojl5tUtQFLcn2YqM5Gs7i?=
 =?us-ascii?Q?nERQ9WiphcW57U8MxB9g/MMvngkrrmgQUvrZJ4UjF/bJcEqdlZ8WgKY/20ZX?=
 =?us-ascii?Q?HNv0qaP3Q3FkhftMGZUu0a54s7NOyE4nsHLZ4304ndT2D0wQ8zBGoPYPmLiR?=
 =?us-ascii?Q?HMcX3WVEzN1nwxYn2yyMwTYZyO80X64edMMUvZxCHwDRkoT/cG6aKbguSmQI?=
 =?us-ascii?Q?7y4CuQ4J5/1xAHiXijA2/ixSyAZlFWazExcMWCDQWwPE8CKrcVQuueQl/P6m?=
 =?us-ascii?Q?/rs7y7p7Td+2wdYoowoKJm0CXXZxEtQNJ3Lq1kuQw9uA7X5XeLWUiPefCGPJ?=
 =?us-ascii?Q?+tF/142BGwBDAoG185X03Xuqb6wtUkHG3N/eq3rYg/wtX60Lkllbu50Dj24M?=
 =?us-ascii?Q?mR9xke+awTorLW9+PywSltxbySejtqMdjveFA+HPq+aa46oy1i9X5v0jKvjS?=
 =?us-ascii?Q?8yEz8M55DRiWj5HKlvw1FrIlmGCOAXh8/s1+yI6Bomlq8Uj0auRfXRBkuv6+?=
 =?us-ascii?Q?4e6ANdDlZPn/x1dx7qAkgn3hI0Rzy+FMNLq7mkF/UstBCK3LtRnd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2eccc2-1913-4c0e-baef-08decaef132d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:02:10.4223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PimKHWvCrPQidwl1DVT1yWbgmZxKOHOflac7aoIzvr7wjbmVx4MKUL5eMvBr9oTKrr1cwQ66LhyH76vD4uxhog0ejLl/GP6TXBtnx4jLbogkvGWI466VmkCpPeHEz6Px
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9679
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

On Fri, Jun 12, 2026 at 02:58:35PM +0300, Laurentiu Palcu wrote:
>
> DCIF is the i.MX94 Display Controller Interface which is used to
> drive a TFT LCD panel or connects to a display interface depending
> on the chip configuration.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  .../bindings/display/imx/nxp,imx94-dcif.yaml       | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
> new file mode 100644
> index 0000000000000..8894e87666972
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/nxp,imx94-dcif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX94 Display Control Interface (DCIF)
> +
> +maintainers:
> +  - Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> +
> +description:
> +  The Display Control Interface(DCIF) is a system master that fetches graphics
> +  stored in memory and displays them on a TFT LCD panel or connects to a
> +  display interface depending on the chip configuration.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx94-dcif
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: CPU domain 0 (controlled by common registers group).
> +      - description: CPU domain 1 (controlled by background layer registers group).
> +      - description: CPU domain 2 (controlled by foreground layer registers group).
> +
> +  interrupt-names:
> +    items:
> +      - const: common
> +      - const: bg_layer
> +      - const: fg_layer
> +
> +  clocks:
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +      - const: axi
> +      - const: pix
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
> +    description: Display Pixel Interface(DPI) output port
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - power-domains
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    display-controller@4b120000 {
> +        compatible = "nxp,imx94-dcif";
> +        reg = <0x4b120000 0x300000>;
> +        interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "common", "bg_layer", "fg_layer";
> +        clocks = <&scmi_clk 69>, <&scmi_clk 70>, <&dispmix_csr 0>;
> +        clock-names = "apb", "axi", "pix";
> +        assigned-clocks = <&dispmix_csr 0>;
> +        assigned-clock-parents = <&ldb_pll_pixel>;
> +        power-domains = <&scmi_devpd 11>;

Nit: need extra empty line here

> +        port {
> +            dcif_out: endpoint {

Needn't label here for example

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +                remote-endpoint = <&ldb_in>;
> +            };
> +        };
> +    };
>
> --
> 2.51.0
>
