Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F3606A69F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JPZ84jOg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF0910FE2F;
	Wed, 25 Nov 2026 19:24:15 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011038.outbound.protection.outlook.com
 [40.107.130.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A97710FE2F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 19:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDm1nBZCFVkz6gCtbck7G1d8RH9FInt9MhGPavItnKJOIG7Rp5k+n0YtcNpj9A+VaD/nEKI6yj/bqJUgGX7idm3iPESxQKREATl8ZrSuQw7mKUQWSy69a1mZ3n0NX4/lMwFlgTOcg+KH+jNZCmQjgwruh8OV7AyP4oZfry3MmrE33pA39x8F0DIHhJXNAl9+RbrNKK2Vi6PI8g53MX2fS8sCmG9bloFrguoGXSsHQaJNLyBsxHVgsAetdWC67XS5xq40t1rR0mPeSorvewaR1o9B+jNP1FEBCwUtSJcEMAXeCzkNy30n22DRqEo69aegPMpaU9JUtYhi+nz59Ps39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8HWk0+uDlYxGRKmF3p0qeKY84bq46EodGMUkVVZSFo=;
 b=PdQbrwnnfbl+a6Ttb74Mny1qcmdd2IYoER0q+h8xPv023cRCmBO8fP5J4sUihODX97ZJFg5M/YEiV6v/35RLSZc/L1e2jDoKN4CW/9flSa8WM/5jxdSdMsQVszE7sCfegaGe6vBGCNiwsnH95plKuExjg8V6FCbfFk6ki+eH5e41E6hhDuBE89uOCLseZBQ12/fC+3SS0AcD3EUVSPYykBHVP1RBRuPIlYRJUkVvc/o02QGmkXOCcjFm6vnKWxee31oP8yVt2P7UuIzA9At1a532eDeaILKyiSg9uzuw/aorrW580hZdzQv+bwJxUylQufQZRb/1fH7RfUteBC9gBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8HWk0+uDlYxGRKmF3p0qeKY84bq46EodGMUkVVZSFo=;
 b=JPZ84jOgnfGs3KWX40hnGmLShouBFKHM3aKNo+3Z41lb8dQbhMegaqyq+hz+npc22c4LBiBGKSN5emqY+TEmyq4ro/tC8pbEtgh5pW+rfQsfDpWXxf4Y4U5HT4ft4NvBsnyssHwpQcothEgYEko6eV7cLPAvyfXqDFfWX5OK7wkEqCMQvQVrsEzp6b1kLin7FaGKfkKf9YVU1o3ar6FuCaUzpClnpExGyr1UMBgyfBxJIYONrO5YPj8stN5YZ3RDbLidU8Uo3mPck6mmk8B9wZl0fjRaQdRGYZQw/OxSNapYkZk80vQK5AsOkDEoh1n9z9Jo0SZ0aUs5cyTtlJjXvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV2PR04MB11959.eurprd04.prod.outlook.com (2603:10a6:150:2f1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 19:24:04 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 19:24:04 +0000
Date: Wed, 25 Nov 2026 13:23:51 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-clk@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v13 4/5] arm64: dts: imx94: Add display pipeline nodes
Message-ID: <awc1x1TmWcCL1EcD@SMW015318>
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
 <20261120-dcif-upstreaming-v13-4-966ac248773f@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-dcif-upstreaming-v13-4-966ac248773f@oss.nxp.com>
X-ClientProxiedBy: PH7PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:510:33d::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV2PR04MB11959:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbbfbf1-1400-40c9-56fb-08df4b29aabe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|10067099003|56012099006|11063799006|4143699003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: TCOj9ucE27MT0QHHioq4Zk3dGD2cCpDQg/kxQtePIPOTv8Hyn9cVpXDHZGdKj70nQGYNh59UOyVCxiE0ogEcK6QILjl7g4jzMIPrIAT3jiwMUzGQ38wO2gd7kp6qqy8yFmJ1PGq/Pr3IG/seXWttlX1NV/KLaf7gmW6Hsu8szpfFXNwPqW1rwGkAboqIys4PgYXradguun2+SfdrtHsc3McMa/g57tW2g5YB4/xWCzRxDBz/HX5Oj85aOjUBExBVVIVul9Hnn5L/ETDNxNTPM4CRAKiL+k+Y2nTELERtAPrz3mAADVl1AxNqbXVhKN+IIoGd34peXLbmWJbBWWjSb+ZxH202o78/4DfbpG3h1Xa92ngopIaaZh4aXXec4N8mtPkQBWoUYr+OkQYX28n6c/43zQt76oIog5oDbt52NmEkQM2tKgDISjVY8GhwT/7h/isCnLPJfW1224u4DHScCxw2JjJ187gEXXR8dnB2tkrR0lotfeNbFlP/c2DXvk6LRqWj955gN9QWQ2/l5foNhkr0CAUQXejHc3nYk1fG+piQCG44Pc8osjyhBbTHNuxBRBAOBsdi+sa4WTxTzbAqpCir2uhMSjtOENIOc1OGFYKfrc3fjukn9DliI59Fol2xaWffy/DCAGJcVlsHZrnqGxnvjHgXK44OdJyinNts2cU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ASt1KIdbQSoBdqaOlvpt4jr0ejqSzRXAZmeATK9p21PzQdtLdD6ZcBIqflDk?=
 =?us-ascii?Q?s6sijEAv7g80QblePa9iUvvulUfd3g5I9/kjhFMIKDVjLJ/xGxtiRDTfaf9l?=
 =?us-ascii?Q?1HQ7XeIn6AnObCaoiyb2tJ09PnveJWjdYCSFngokRgOMH92EgIKYfkZGkClX?=
 =?us-ascii?Q?JK+uz3znwTvLfEp2z13pMlx5m3W7cwrgL7webAWia8UlWxbrQmJWFXQ2PXrK?=
 =?us-ascii?Q?NPYp9unk3HeGLonQC4gw6N4NNkUQZBG9Fyo43+R/WIIR1/ittkSVlyAy182D?=
 =?us-ascii?Q?fNnsRpjyiNZaBRiAOWd6k7pr+6RgYUotOdXO/BfLJeTCyBheRN21u31cpN2c?=
 =?us-ascii?Q?PiS6ZCstMrHFiTMAUjLTk7Z1IiBVcQKZzgdT+HgNTjfV+W9gdftukl+Jj0gX?=
 =?us-ascii?Q?c8Z8IlEzXhrDuun+qyR+xnqdh9cgbL79P+HvqQS7b43SzqxIuvFOgXP6RMyx?=
 =?us-ascii?Q?tohWLe29TanPBMWuLRY8CUU+A/dgz1K/5Pf5UGn3vq35oKwrx7S3b5qhSlrm?=
 =?us-ascii?Q?6AaFuP3lGwrc4wzV0o3ZpTb/HBZSQ7m6QaSYhK3P0d7VwHEfW9lulBZ2L+w3?=
 =?us-ascii?Q?x+HBc/8jZwk36nLkqDmFn94AzH0jPtiBomdUP1z9F1mgWgVreL9SKTX1OW5U?=
 =?us-ascii?Q?/t6nJX0MzZH2BbeREp53hY6YlZHUP3gayqxknr0Vsl5+axNi94JoHpnWbplp?=
 =?us-ascii?Q?vTjfeiCXY0PrZluCblMtjQAfeW8t6MhABadgHvOAqcMJgZcgYgsf5ufvvhOj?=
 =?us-ascii?Q?FsiAlB99NQgmp/9SJTpQp4kUEHPbjhPqF/R1zQBR2tOn5M2lo0UYLy/mcpSK?=
 =?us-ascii?Q?/pKDXlG0+HEoh5qY4zdK3oilLzZ58p0II3keW4Dh4Gl9R26BdM9WlQCghMYv?=
 =?us-ascii?Q?sS0yobvTaRDS2R/rijfg1JTdlFpNoxb3NH9MgaHksceZTd5I1rqKnn6/Oj+W?=
 =?us-ascii?Q?6JaT3WzwWs65l5jpQRY0ofg2DNVONfq+CV0ASGR8jBIK6IluhQix/WCx2y6e?=
 =?us-ascii?Q?I4q4BZENRpDnRuVWd8oMYNcz8taP7iyBoMLKkWAka7sqoLL5jM9DITkpKRjf?=
 =?us-ascii?Q?JxOmWrfLtbhT3x6A6ayHTwVCQHMELrWi3gMMwjdLpAv7Ma8/8dZo3rC3wKiW?=
 =?us-ascii?Q?axKuRINx7xmjgZlwpHn0vJvj6sJsSDzKmh6di+ejiUMa5gQ2ooUjaTEybsY+?=
 =?us-ascii?Q?l24uS6i3SmVqPNIvG0wsUx7CNMMdtuHc0P3nfIVPChhjWlrpQUzbOV1m6lhL?=
 =?us-ascii?Q?5m/XgcLRe8KTfmd1Rr7p3E+U5Is57qZka58YptkaGQK0ntgAD3s8zyKfAbCE?=
 =?us-ascii?Q?YD3nfzAxSbs3Pjlvc3APwE4c2D3gQvy4EuNHj//vYgEXrpx2B/erAzjZUjBI?=
 =?us-ascii?Q?IfWbTvyMiFFzStU9R20F6myj9GDY1SmHU+ZGk66HicZuNpdFHSxK1icD49bM?=
 =?us-ascii?Q?O2+Jh7Scnkfy5w28RhPVZBlh0shYwIZzvfLnshmZvF91Sq0KRl6yVw7Va5eP?=
 =?us-ascii?Q?5BOIp6t9voixy8bexArFA0Rpzo+G5VBMN18JzOJTvvwUvsn/Dtlj/707q6/M?=
 =?us-ascii?Q?rJdludYaF0CimcOElZRCEMdxe91YQpVVWTrI+WlWd8MYe+wdJ5TDSEKtljK7?=
 =?us-ascii?Q?oOdBd8RQ1gVyaJa9C86sOwkGWJJrn+FE7yWdyTKBX434F3+IOVX+OkXqM8VP?=
 =?us-ascii?Q?DTOyhsfJ8Cehps33f75JRIa5kYeqVkN55+BWXEz2grGpMEqA28N9CEieKKBl?=
 =?us-ascii?Q?cJFv+tjXkIlGvWRzlj7/UIsnD3TPl3kFJ9t0cqImm50V740cqO6k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbbfbf1-1400-40c9-56fb-08df4b29aabe
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 19:24:04.2686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsfozaiAUcfqA9WeeYBpegMnF71MOsxcPqPuGHrGPtI0shzwxwaCrr1TM6n1/vOJ9a8Tz8vlWpRFTlSAafVcBvqo+w3yWw1iDxJ2KdrQnrc/SLlFCtrUiAzf7LXoCx32
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11959
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

On Fri, Nov 20, 2026 at 12:50:39PM +0000, Laurentiu Palcu wrote:
> Add the nodes necessary for the display pipeline on i.MX94:
>  * LVDS/DISPLAY CSR;
>  * clock-ldb-pll-div7 needed by DCIF and LDB;
>  * Display controller interface (DCIF);
>  * LVDS display bridge (LDB);
>
> Co-developed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx94.dtsi | 82 ++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
> index 90925d48daad4..7f87f82607abe 100644
> --- a/arch/arm64/boot/dts/freescale/imx94.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
> @@ -3,6 +3,7 @@
>   * Copyright 2024-2025 NXP
>   */
>
> +#include <dt-bindings/clock/nxp,imx94-clock.h>
>  #include <dt-bindings/dma/fsl-edma.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> @@ -39,6 +40,15 @@ clk_ext1: clock-ext1 {
>  		clock-output-names = "clk_ext1";
>  	};
>
> +	clk_ldb_pll_div7: clock-ldb-pll-div7 {
> +		compatible = "fixed-factor-clock";
> +		#clock-cells = <0>;
> +		clocks = <&scmi_clk IMX94_CLK_LDBPLL>;
> +		clock-div = <7>;
> +		clock-mult = <1>;
> +		clock-output-names = "ldb_pll_div7";
> +	};
> +
>  	sai1_mclk: clock-sai1-mclk1 {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> @@ -1324,6 +1334,78 @@ wdog4: watchdog@49230000 {
>  			};
>  		};
>
> +		dispmix_csr: syscon@4b010000 {
> +			compatible = "nxp,imx94-display-csr", "syscon";
> +			reg = <0x0 0x4b010000 0x0 0x10000>;
> +			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
> +			#clock-cells = <1>;
> +			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
> +			assigned-clocks = <&scmi_clk IMX94_CLK_DISPAXI>,
> +					  <&scmi_clk IMX94_CLK_DISPAPB>;
> +			assigned-clock-parents = <&scmi_clk IMX94_CLK_SYSPLL1_PFD1>,
> +						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
> +			assigned-clock-rates = <400000000>,  <133333333>;
> +		};
> +
> +		lvds_csr: syscon@4b0c0000 {
> +			compatible = "nxp,imx94-lvds-csr", "syscon";
> +			reg = <0x0 0x4b0c0000 0x0 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
> +			#clock-cells = <1>;
> +			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
> +
> +			ldb: bridge@4 {
> +				compatible = "fsl,imx94-ldb";
> +				reg = <0x4 0x4>, <0x8 0x4>;
> +				reg-names = "ldb", "lvds";
> +				clocks = <&lvds_csr IMX94_CLK_DISPMIX_LVDS_CLK_GATE>;
> +				clock-names = "ldb";
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						lvds_in: endpoint {
> +							remote-endpoint = <&dcif_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		dcif: display-controller@4b120000 {
> +			compatible = "nxp,imx94-dcif";
> +			reg = <0x0 0x4b120000 0x0 0x300000>;
> +			interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "common", "bg_layer", "fg_layer";
> +			clocks = <&scmi_clk IMX94_CLK_DISPAPB>,
> +				 <&scmi_clk IMX94_CLK_DISPAXI>,
> +				 <&dispmix_csr IMX94_CLK_DISPMIX_CLK_SEL>;
> +			clock-names = "apb", "axi", "pix";
> +			assigned-clocks = <&dispmix_csr IMX94_CLK_DISPMIX_CLK_SEL>;
> +			assigned-clock-parents = <&clk_ldb_pll_div7>;
> +			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
> +			status = "disabled";
> +
> +			port {
> +				dcif_out: endpoint {
> +					remote-endpoint = <&lvds_in>;
> +				};
> +			};
> +		};
> +
>  		hsio_blk_ctl: syscon@4c0100c0 {
>  			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
>  			reg = <0x0 0x4c0100c0 0x0 0x1>;
>
> --
> 2.53.0
>
