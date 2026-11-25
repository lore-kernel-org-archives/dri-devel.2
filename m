Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19AB606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=D8dWXzM/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1301710FF46;
	Wed, 25 Nov 2026 19:25:02 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78E2610FF46
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 19:24:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzRhi4zolU+WK394R9a0npKxIXEejMrrxKtI/NrJrcxyNBPfsGa9LSU1hDByD3uQI19bmaG+ScGMD11cqQ0psY1T/hWkjHNHdaTHLXze75Fp9cRZRNlDsuTUAGehy9gdioRjZDjIJ5SL7BCbgRyMAEn4wR6uLlOBDMsMXghegaXzVkSSUQ2T7XHjMJygSrznELMXpGGuyAu54rbwG5HNFN8pQ8d5m29VdKtegV5V0D30bOhtd9lKhxUQsiGGpekungz+6ieWxNYa2IVLrpLYa6ozEM+9PeRsvTwE3U0ua37wwTwetj82Ya+uGLXOg94CaMRS64Z806Kfkw7VvPLyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxfTDPpCeEgx5MNJbmiIuYKi9PAi79g/f4dqs+EVUyQ=;
 b=tKQkbcQvKxSPkWfx1g3rz/HcAfXb7pzSt6Tm0GGz0qhVdSWW7m6JHJd/v281ulMkK/m2/JY4uIJ/DvP01XojXooVTqPK+opVYtzR0t/fFRtaLkTHbI3xNJ+OF+MBgKU1R9MkEh27ZR2h+6/VhtTvo4ERSnLX9CKm+8uOAWrEL5pzOvgVnGIl/PPQaQfis80skgQ5evJ6dNs7cjYT9RUSNLqTAYlRnPpvyipwAAPmlMCOHdjsyfZYzuxvjhZ0VgY1ii3hTsKRjcAuZi/16XnVY/vtustZGP3kUEk7gqCoNmDs2/cpKMz9Nm0l+XgrcZ4qPVa8hz+7JAF3m+hj7/zfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxfTDPpCeEgx5MNJbmiIuYKi9PAi79g/f4dqs+EVUyQ=;
 b=D8dWXzM/3AwM298i7xrrPaSW7UbHN/mH+Rvt/RhpPgTGKvAdZ+lVPMFRkpOD+89qtTue8h3ohsE82aCvKmyBOmuLIV32RrxQsnG4G0kmf3ty1UNWKv4bJsuJSoPWQ7IdYRRgRT8yuYfOJEG6mlSz8lMxoldADvD1SCSfSdxPnVlVp9R8o8wwhEN4Zfmn7K33/EJU1g5v9QcXUPX2xQV3J+sfdowKAHIAyJtGt8jjFLami9JWyWhcsXef/q3JREXrEoppOi0hlEV0d4TVMffe6+buiz/NccpCjVlT3dVMEwGuVG8mWLGCW+abvK6O93EePQyKUbJBDbxbhh5jEw7pOg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DBBPR04MB7770.eurprd04.prod.outlook.com (2603:10a6:10:1ed::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 19:24:51 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 19:24:51 +0000
Date: Wed, 25 Nov 2026 13:24:41 -0600
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
Subject: Re: [PATCH v13 5/5] arm64: dts: imx943-evk: Add display support
 using IT6263
Message-ID: <awc1-Yk9_sXpx9ki@SMW015318>
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
 <20261120-dcif-upstreaming-v13-5-966ac248773f@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-dcif-upstreaming-v13-5-966ac248773f@oss.nxp.com>
X-ClientProxiedBy: CPCP307CA0004.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::17)
 To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DBBPR04MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b76db39-006a-47d3-8ad5-08df4b29c69a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|19092799006|10067099003|260925021911599003|260925022911599003|11063799006|56012099006|260925021311599003|4143699003|261021121427099003|261102123227099003|261009223027099003|261028144727099003|261022105027099003|261022075727099003|261026140227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: QSqq0G3bvgtGvATpLHvnFomrZFM6+nQoQW9f5vKNBizym66TcXb3JQ6bYQhhIXWqYkAAI+AS5Oq958W3OuInXyo4l1E+ZSGIaIPRSh+aJ8hgPH8UV8W0ZKh4R2rZT2eRX0Mmf50HmM5LdCHQGmudhZWdoxOCXYswI3nKmFxiwClJ4GuiW0FvJESy+4+WupS1DIahjQqxkSuTit9gWOHT4Hk4IvqAhvajPsQR8+NZtwnXOEjchpfRd3oMBGkmfgaDeSGXchzFcBOXtQI2UQuqIPhFjFTIoTrHOzC0MJJCDwXpVdVI/lFeouC4RxTJ1DTuulYZd9cHmtDPvDOyqikkiMwYwTcV4MpFTxcf75Ri3n0480ZRhBJMAgZC5rRxDo1mysnOg331llXr8DZMHtGsklsVjL3mKO/nNxPK9cvU5mVkicx7VC7r+GxMtbsNsdMwtPCMBimAVix6Ehl+Np5dO4d+t3QXgRtMA2b2a0rFtQT87+3UQZlYqIcTVuz3lTHL7uX6+0Cxqq7T9thpnn50gswGqNnuvL2opB9blDmbK+Gj/2BnlTnqJFG1a2RYo75gja2YydyhriSQrSIoDNAirDWhFNFYmwWKes9C8n/iNKY+Pne2C/ncTtGdwdPdrD4nDI1xFiJxKgnXFPoP53WMbV604vmJBLBvqORsBhbYpaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(19092799006)(10067099003)(260925021911599003)(260925022911599003)(11063799006)(56012099006)(260925021311599003)(4143699003)(261021121427099003)(261102123227099003)(261009223027099003)(261028144727099003)(261022105027099003)(261022075727099003)(261026140227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EGr0YDfIByvu+MjTuqaHbyBHni+VVPsa+mw9vuRnYBk3H1Ip/Kmpcln9mXzH?=
 =?us-ascii?Q?K+n9oEFXvqvKfH5hoZn7iNXFbrTwLS4gWbE9tfpmI9uYjtR0JwZ4UEhKKa0F?=
 =?us-ascii?Q?twJLKFQxF06cYNq1P21ZlEv1u9iH3K/crjjuruscPkUc3ttIs2QpmuN48ZpU?=
 =?us-ascii?Q?kse+q7LNYZMOVcAS0/6gQRzRJcB7JJOulitQ+OmgtJbIVWkRquamehcE3g5y?=
 =?us-ascii?Q?q0EZUfiJRPHHiSZzn7H8XQLy6Nd9/5NUJrHKfL4wXQjy5Td6L2CLw73Rqfjf?=
 =?us-ascii?Q?95XXgZbqO75hQH7kaDJRkuzThHXuLOzF/Q6oC/bjjVOwdJE+Ksa0Cm17+lzR?=
 =?us-ascii?Q?TAC0SgC5n9X/yuM4eYRduO9up8iMPn7xiwgnr2SSaO0MJykI8pTK9LzAbX7W?=
 =?us-ascii?Q?7RMOf7plND3TnMLGbk0LjjeR5cvDFwUWUzLluyou5xIoHU5bTNJfrTAs8SsA?=
 =?us-ascii?Q?chG+wQAi6FuF4dj+B5KnEdhcE32sY+E9hrp2c0K4MKXncQu1X9sETK5XUy5l?=
 =?us-ascii?Q?5S7m89THwhlBpGLQHPr17TJKHBx2yy9EgVB+k3K7GqR4p7aGXZMhI//0EBQA?=
 =?us-ascii?Q?UVy0V+qo5P0Jco3H8KmWC0t1EkBBLgc/PLom4C8ab/8gEAlSmrpcW6S0S6qf?=
 =?us-ascii?Q?dMTYRgecPNAC+pt0I6HVN18wSQXp4uPttwy4cMYdpA13rqxjwvxftYO5efKE?=
 =?us-ascii?Q?W49N9Zrzf6AQeO/nwx4mEsax+Z1egWFmQBcnBTm4NIjPNv85s7EihNnjc5IZ?=
 =?us-ascii?Q?godbX8gtjNuKIp9bQLCxyqvk1RJLPdqMnhydbRMdvQsnTukplgioj4YEitOK?=
 =?us-ascii?Q?rQ3uMSLNb0W+STRn+u+RFx4RRxXPsDdD3LrVbdJqMnAQZb7WKckpGmGOuFc+?=
 =?us-ascii?Q?SEBSFZSE9j1zsQCv/WMcy1HMNkDeqhoURRs2vJ1W8bEzYILfJGkoEMyaIXcy?=
 =?us-ascii?Q?DQ/5A5Of3oncULAxBshdaIMBSYNMqwJSrAbLE2+8XevQ8yZTLd7OufpcidOe?=
 =?us-ascii?Q?7exYooZkdeeYsHvUeRsDoyl4J95IjLTjNUdtJp9M3kTaxNILGN3GCUMLOs/p?=
 =?us-ascii?Q?FnRbnnxYbJec9FxAmB2h088vEuSPoWyU8Ky4NZ4F2j+WaPF3paLKjI/qSmIW?=
 =?us-ascii?Q?+AzmIVa/X31tCSxjDDGAmqWMDEbLAsf86FAdIxysqkLQuJiqdqvLiH+47fTG?=
 =?us-ascii?Q?o+wd94IxqxUAp/MCwDUvo3ij3cwRWhM0ONwkG9FLovUmvL4Ku0P0tlnSpI8r?=
 =?us-ascii?Q?pLDUhJy1DemzHrXRvBGbSjeCfmr0bT5fCZ37t/jRaClOYmPFYNc3vPjwN9ge?=
 =?us-ascii?Q?eNs+jB+IFbD3VigQo/28/4viO/ShSMY+aw4+hRhTxgcKDbTc6J6sVCf/wRUC?=
 =?us-ascii?Q?qrO9MJwlqj4sZwBDH/1E8gjNfymV7S4KBZvKN2XMRyMvx2WpzMb6k292UV8m?=
 =?us-ascii?Q?kaUMbYB1os4Y+9yeIEpCOFiiZYm5W8TtXIox1jE47B2489I42bhdYEem9v7L?=
 =?us-ascii?Q?vJalt7NovET3DPcYr4F9fLuKBlJmfx5f0VobWaI3h/9mCxrh3CX+B05LQXmD?=
 =?us-ascii?Q?/KMtfEnzV4dj69zlDZQhCtq9wufIqtnc6t3FON28FrJiRuoiMsInDgm9vmfM?=
 =?us-ascii?Q?dV+hs/HLTXdA/zEeALP55Et+gY01UbjeM2D97Kpe33hmuGVRXhMc7nMM0U/x?=
 =?us-ascii?Q?ssTRt0U5JLZsgbqsqIYshSCYbtpYPwwRSC81jFAGE3KLGg3EHgOhVf3Ch+WA?=
 =?us-ascii?Q?jWxjvftY+kP/iMEvGYnQTQtOjTSHZid5it9LY1YMZzq81HJ2IFG0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b76db39-006a-47d3-8ad5-08df4b29c69a
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 19:24:50.9913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gkgWxZSXRv62U41bkK0DeCQEHpiZ7ClddXDeH6BuzDvYsGGOZBwUQY2ziUopqjH6IgAxGgDQwkgEQl5x7JPjoKlEYNCu9Y7apTWj327LAaQZ3jpzC9FiNRvDEwiZgtd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7770
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

On Fri, Nov 20, 2026 at 12:50:40PM +0000, Laurentiu Palcu wrote:
> The ITE IT6263 based NXP LVDS to HDMI converter can be attached to the
> i.MX943 EVK board LVDS port using the mini-SAS connector. Since this is
> the default configuration for the EVK, add support for it here.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx943-evk.dts | 86 ++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx943-evk.dts b/arch/arm64/boot/dts/freescale/imx943-evk.dts
> index 39e819c536cc8..36b1d42a44454 100644
> --- a/arch/arm64/boot/dts/freescale/imx943-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx943-evk.dts
> @@ -117,6 +117,18 @@ dmic: dmic {
>  		#sound-dai-cells = <0>;
>  	};
>
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&it6263_out>;
> +			};
> +		};
> +	};
> +
>  	m2_connector: m2-connector {
>  		compatible = "pcie-m2-e-connector";
>  		vpcie3v3-supply = <&reg_m2_pwr>;
> @@ -148,6 +160,15 @@ m2_e_uart_ep: endpoint@0 {
>  		};
>  	};
>
> +	reg_1p8v_ext: regulator-1p8v-ext {
> +		compatible = "regulator-fixed";
> +		regulator-name = "+V1.8_EXT";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>  	reg_3p3v: regulator-3p3v {
>  		compatible = "regulator-fixed";
>  		regulator-max-microvolt = <3300000>;
> @@ -155,6 +176,15 @@ reg_3p3v: regulator-3p3v {
>  		regulator-name = "+V3.3_SW";
>  	};
>
> +	reg_3p3v_ext: regulator-3p3v-ext {
> +		compatible = "regulator-fixed";
> +		regulator-name = "+V3.3_EXT";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>  	reg_m2_pwr: regulator-m2-pwr {
>  		compatible = "regulator-fixed";
>  		regulator-name = "M.2-power";
> @@ -401,6 +431,10 @@ memory@80000000 {
>  	};
>  };
>
> +&dcif {
> +	status = "okay";
> +};
> +
>  &enetc1 {
>  	clocks = <&scmi_clk IMX94_CLK_MAC4>;
>  	clock-names = "ref";
> @@ -439,6 +473,21 @@ &flexcan4 {
>  	status = "okay";
>  };
>
> +&ldb {
> +	assigned-clocks = <&scmi_clk IMX94_CLK_LDBPLL_VCO>,
> +			  <&scmi_clk IMX94_CLK_LDBPLL>;
> +	assigned-clock-rates = <4158000000>, <1039500000>;
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			lvds_out: endpoint {
> +				remote-endpoint = <&it6263_in>;
> +			};
> +		};
> +	};
> +};
> +
>  &lpi2c3 {
>  	clock-frequency = <400000>;
>  	pinctrl-0 = <&pinctrl_lpi2c3>;
> @@ -522,6 +571,43 @@ i2c@3 {
>  			reg = <3>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +
> +			hdmi@4c {
> +				compatible = "ite,it6263";
> +				reg = <0x4c>;
> +				data-mapping = "jeida-24";
> +				reset-gpios = <&pcal6416_i2c3_u171 8 GPIO_ACTIVE_LOW>;
> +				ivdd-supply = <&reg_1p8v_ext>;
> +				ovdd-supply = <&reg_3p3v_ext>;
> +				txavcc18-supply = <&reg_1p8v_ext>;
> +				txavcc33-supply = <&reg_3p3v_ext>;
> +				pvcc1-supply = <&reg_1p8v_ext>;
> +				pvcc2-supply = <&reg_1p8v_ext>;
> +				avcc-supply = <&reg_3p3v_ext>;
> +				anvdd-supply = <&reg_1p8v_ext>;
> +				apvdd-supply = <&reg_1p8v_ext>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						it6263_in: endpoint {
> +							remote-endpoint = <&lvds_out>;
> +						};
> +					};
> +
> +					port@2 {
> +						reg = <2>;
> +
> +						it6263_out: endpoint {
> +							remote-endpoint = <&hdmi_connector_in>;
> +						};
> +					};
> +				};
> +			};
>  		};
>
>  		i2c@4 {
>
> --
> 2.53.0
>
