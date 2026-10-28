Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752DC606A31F
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oJgYfFk9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D487910E597;
	Wed, 28 Oct 2026 08:38:10 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B16610E597
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGFCk3vTEvk7e81rXTcJUTIC0KsRgI2HW4S0TwpFCUcl0/Je2N8G+oNsMtsC9UX3XMr4h6hunT4BFBo30uOkTffnYIpJNY9nBE3mxn1rXeH5PEpI5n5NSno3C5z46kS4nUx/zO9A8fUfcePpqMbto9g2lLRq00Iu+NU6RYLBUb8+AB/swYHl7B6ejcmwP0kU3+l/3PxQOS5+Cxn1MMU/Pqd6C29bR6TAmJxX6XPbl7ouJIsPlS3x6mDRtwwDhyUKY+BZKiF+XTHpJI1WRLRl6au9FWkfBLMsyR/twmoZkZzgiFTdgCgD/Fm2S/Pe/3nZ+XwhWeIqqbelikfPDivv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IX28gJlwhXJCn51gMU7oNP6y6BbpxrWocTDxICay0Ys=;
 b=tOMPp4kRsjUCQO17f6tslFq9PPhNEaCwcwrk+aagMQ3pc1ktZi/29memCEZkXLx1d4RnS7WSvhkVJx+xvKamC4slcK+hzzC6yCOov21Nn8BWqJsh4vimU+ePj3ejMixPNz49b8Thh5lyoM7E8J+A0WLDsJsd+kknJw9QZfevgb7moCr77B5wdttWE/pEuJQyESSbiWaVQvu+EVy635NJdX0cSTegjqNV66ricXQ6SfZoHEKMAZJ84jZvvTeVOvWNiOrdZD0/cZWzMPefxzJ8pW+nk/21KkE0ykKXpBUE/gNoFaFojf5aBNplfz8RHeETY7ndLIjqDL9izEFV7yYvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX28gJlwhXJCn51gMU7oNP6y6BbpxrWocTDxICay0Ys=;
 b=oJgYfFk9RX33WeANOiryzcVbVAxX83bJVFsURPp/9gm5/DT2mNEyvGxJC+xt5k1Nv3yHNBMVqv4HvDdSlsQBy5iVqFC0v8Wq+Yy3oi6X/jRu6NIZ4cVnSFHn/16bWKSny7/C9WEfhLGqrGGqt6I7z4qyameSW2gfpAuFwYKjdvsMH6W0jiSOnM6yvBPYeM3ckto/gi90QvO4ktzpyPqyTvA8bx6P3knHhMceQxkabS1sVHUxdbOD+E782EHCEZKovEufx8uPv38EwiPiaf8Gzk7oOF9v/hg+IqSGwNKyelnJNe1PCQqkxi/Tvsp0cvFzVRz+PO3YCAM7/1fD+gc+4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by MA9PR04MB215426.eurprd04.prod.outlook.com
 (2603:10a6:250:106::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 08:37:59 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 08:37:58 +0000
Date: Wed, 28 Oct 2026 10:37:52 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Frank.Li@oss.nxp.com
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 
 Robert Chiras <robert.chiras@nxp.com>, Liu Ying <victor.liu@nxp.com>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v5 4/7] arm64: dts: imx8-ss-dma: Add lcdif support for
 i.MX8QXP and i.MX8DXL
Message-ID: <auGvm5WQfyNL-To0@vm>
References: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
 <20261027-dxl_lcdif-v5-4-3a974e4b94b2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-dxl_lcdif-v5-4-3a974e4b94b2@nxp.com>
X-ClientProxiedBy: AS9PR06CA0442.eurprd06.prod.outlook.com
 (2603:10a6:20b:49e::30) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|MA9PR04MB215426:EE_
X-MS-Office365-Filtering-Correlation-Id: be11ec1b-35fb-4aac-747c-08df34cec4fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|19092799006|4143699003|11063799006|56012099006|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7ulO5AhDDDDDGuKbsqK7Fu3Z4+ZGQieITfCNdi3Yue0+zUO5kbxDWSY5ULI5OyrVokvzGhNQRoV1J5+tV36UIE9V4tYH9gtA6hrZehHimRAQiWoCyz3u7d1iHQCF824i6/mhqt2SS/uqWwC2tC4yGfOG1XZFP9wMJhUvqcw6jTVrX9dQjAPykZeriVaa4oNwxXwx4642QYbMAg4xF6qdWvw8qUUnh7Z/hT2K15wgSqBaf5vBIx7qY+Lt3aMyyUcYO+ct9uTBx2LK2pOpZDqjO4nG3mb7eUAUU1b5dRTNiOpNucdbLgDqt6xounaApwhfUvnLA4zwblox50S3Hcg3ltbBm09IeqBBvcTyqTfKOE0vOP3Ek9LmJExa6zWUepKuOa4F4GCN13jjfJIq5xpd+dzu/RfTus3sX7ijKjz3H50LtuJozLO+XSd4E0l551v6LHDJkgosceNkapkeIK7yjtSolfhtbeMr4tjVpz9G3EDHCUu2W8dlY/Zd1CD1kLcZ4hGAai1aOB1eIMaKPMISPWNh8Gn/RlzQpcP7KkiIeBPpkDl0k8Z48bn+GuGlF978t9RbKzJ+FrRnkGHIVE+kHSCHXh4xrF7mrA7+mmcdF7/Xm8Rbp4socVxXHbmKlqRwW/xvBrjMhufCcHYESTfXifmKfkon8SEbb+S/e8hr/l4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(19092799006)(4143699003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JhdQQ8DVFcO57hi52OU59/JBUlSVe/GSqy96S7woQQSOl22DJ9EmoV17LmF/?=
 =?us-ascii?Q?CTZPalEzfRlVS+xTHGro6Mq+RPYQiyRe04uxzTG6SuLUyW3kJNHP8OeT5HPz?=
 =?us-ascii?Q?BX5CKgEmkMZaMNZ2jxw2EbIZ5h36Y340oJcFpG/FZim5Qmy5yN/NutpaOj97?=
 =?us-ascii?Q?rs9X9xivxL0pennbtZ6Lgi5I+TOHNuiOmmvnUS4bx/AaUHNVsyb7JVzUw8G1?=
 =?us-ascii?Q?3MKQkgwOreV7L04AKCRKiT2znYFRdKRooUmhFRtbf6K24SQq9qV9H0zV9eu+?=
 =?us-ascii?Q?zWFtc+8NzNC4yjim1ZMT/YKsfNjIXN+SIpCG5bwikwhdDDpORsXmTlHq4Sff?=
 =?us-ascii?Q?vSMgbLFzaI4Zcni5ndtc51bZYyO1SbreuCDGa1u13bQVG7kiZKIZPSw8Y/Hg?=
 =?us-ascii?Q?Cd+3o/vAlRogV7ZWexrGLiIeeJnfi0lAj3dhqQV+zLNKcA6Iws02aWh3rGNR?=
 =?us-ascii?Q?eLxKnfPb1Bkg582QDomzuM0ET5OT38S2wMAl8azwAt7+G9prLFznySgmsb+7?=
 =?us-ascii?Q?sd3dUGgUH1gvm8uXwHYQCt+IK/iB9ULvS517bmv0WU72nK4e+Uq0siZXm79Z?=
 =?us-ascii?Q?iXmDWIdvYHH+pNjxmncoqHc3CCZmx0kkDyVEGMLQ1w7JHdP68huqiZeqPrne?=
 =?us-ascii?Q?g6s6C2dttQI39Hxe8P3CditG9vp9qYty8ftQI91q0+ILQLU0Y4bs9g3QlYMB?=
 =?us-ascii?Q?/I8I0kEYVEXyc+sPyIAMPZ353xelIzFQ7HV7TFjsnmhSubUoTwKyNKhR54SL?=
 =?us-ascii?Q?h2IPFVLM3tjxb/pI3ZSHOvkKbNyfxH2FVNWOzef89qRCTcJrATelPMacPY1m?=
 =?us-ascii?Q?dU++15+vr31y3N9fITGrlChSSq9fbaLenBcSLBFr0dVVPHWq03UEs343hHxh?=
 =?us-ascii?Q?eVNQVaB87u/OtxEtgaMW6WtO4W1Wu40LBKt6eUiPIC4bS5/bLNLMOsnMtxwx?=
 =?us-ascii?Q?NY2CAu9Q4+OcOvoOnFVOkLjRkMvmohfB3tc7bLhjVMwBb/QXA4xA8aOl9mBA?=
 =?us-ascii?Q?g30KuUBfiAKdlwFcgamqbCF/NcaFPlNMK2mbBf5Iu2AT1jciuOnt19h3ZFj2?=
 =?us-ascii?Q?6btzI08txicS5Et916F/YaedyKR594JslYOUg9DVyamBaqZQje/qRdW7j69A?=
 =?us-ascii?Q?fkhPxF+CdDZLZxsc69AjohG/vm9LbfKrcx3pa7iT0rnCrgoCyd6shF1qXsU7?=
 =?us-ascii?Q?xT41cM0t9Wb2KTni+o5lCsx+tLuHbj7E/hXfw7vtBqje3b4TsFtrUZko62kq?=
 =?us-ascii?Q?m853/wX4K2ENiWpCKdrQbsO5buR7viN5nzUNB2jjexVFAbv0Ediq3XhhiS3c?=
 =?us-ascii?Q?kzIn25wrrjJGzV8bZfXMS8IJMjSad1IZ22OW4UuvPzF5Hq/L5m1WXKEdtdyC?=
 =?us-ascii?Q?MWo3rMXK06nG0KqMbkLYLYBsOoWwaWdqwITTxA9XS3NdABGgi++MEYQayAxg?=
 =?us-ascii?Q?/vdDEKtIh3OqzR6yTdtTvO/Z0itdUFF4ZZ7gp+OSsJqbgtjcCsVv4wG27DL1?=
 =?us-ascii?Q?FDrhh94S/6lEOYrNvPMpnh5TGasw8Ja9vqXEOZfWlbHVxLblS3r4Cbt3PWsF?=
 =?us-ascii?Q?xzAxhK4U2UTNajdJAS6JeW43cSxC63quaeK6vKEbo3ZkY3eEDxTCA+qFEHot?=
 =?us-ascii?Q?gUfvZKPWBHZWuNXzko1537Uby/0a/IwAn8k1R30oWuUjayC9tTOPGlAt45+l?=
 =?us-ascii?Q?iR23QytlNqwIhNA6AEfKpIfTBnuAixs8+IgT6/Pw/IrDxrGCZ/R74cOdXj/6?=
 =?us-ascii?Q?8iwYhqY9uLnD2l80rnABYbWAXu4QEAM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be11ec1b-35fb-4aac-747c-08df34cec4fb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:37:58.5735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcQk6v+EBtY8YuuDyTzDVZ8sV8eZmN3Gh2rrkDBjZU93OO+V3H8C53on327icZZ5/qdYXmlHEVOKrP1pHFs5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB215426
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

On Tue, Oct 27, 2026 at 11:00:56AM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add lcdif support for i.MX8QXP and i.MX8DXL.

The commit message is incomplete. It doesn't mention why you needed to delete
the nodes in imx8qm-ss-dma.dtsi. I see you deleted those because Sahiko
suggested but it would be worth adding the reason in the commit message as
well.

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v4
> - delete adma_lcdif and lcd_clk_lpcg (sashiko AI)
> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     | 29 ++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 11 ++++++++
>  arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi   |  2 ++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> index 4de78f870c05c..87082c3fa9338 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> @@ -149,6 +149,24 @@ lpuart3: serial@5a090000 {
>  		status = "disabled";
>  	};
>  
> +	adma_lcdif: lcdif@5a180000 {
> +		compatible = "fsl,imx8qxp-lcdif", "fsl,imx6sx-lcdif";
> +		reg = <0x5a180000 0x10000>;
> +		clocks = <&lcd_clk_lpcg IMX_LPCG_CLK_0>,
> +			 <&lcd_clk_lpcg IMX_LPCG_CLK_4>,
> +			 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>;
> +		clock-names = "pix", "axi", "disp_axi";
> +		assigned-clocks = <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_PER>,
> +				  <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>,
> +				  <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>;
> +		assigned-clock-parents = <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>,
> +					 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_BYPASS>;
> +		assigned-clock-rates = <0>, <24000000>, <804000000>;
> +		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&pd IMX_SC_R_LCD_0>;
> +		status = "disabled";

According to the DTS coding style you should add a blank line before 'status'
line if there is content above it.

With the above issues addressed:
Acked-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
