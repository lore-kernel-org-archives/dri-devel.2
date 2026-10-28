Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FA9606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hz2SpUDM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A676710E5C1;
	Wed, 28 Oct 2026 08:50:03 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013021.outbound.protection.outlook.com
 [40.107.162.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A37F110E5C1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCt7atnGE8ZpE4JN/xBXyU0kiBeRTL/9F3cm5CJKW8G+Kbow8h9+5IGrb0rNYlqMwYWfaszenjEHI/EHPGCWIoRxmrutwKF0G90OoH02Mhl+EUpMhB9zChRMV1O1m/D4QnmAw4ILmlaenJAiXv3rtWAyaeMF1CQ6GIKNdiIV6gW9jU2/cQ665UIzdQT5fvfzgyV1p22Tc4tjsJLEAUgm++NncR7qn5N9mJwa2IqluOIQB2lc7gXd2GsWOm7RZtOZRzz69rRv7yq/N37NVsPKm5B+lS+OPRajLFyPRKw4nRU06ngs3IEM+YOtp0djvvKb0wxUCeYYIq7SDOCH7FRR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MGvXSXbpCjZ2LJJCfzgKocecungLghm1VuD7v3RxTc=;
 b=o6jNIU1gIDBHGb06h/v1aQ7Qx3eCxQAUrzY2DJmPD+okkie0Vmv3884Um7Nt9IMX5nAXvxl4xOFpebsbjjb8Xp4ERBnEvjF/rhlrRGGhf/AjFryLv6Ua/HXEjTE4sNTMRRixZEcHZn9PM8y/JYHbdGSayB1VY07aELlrsjzwFZ1l7tASn5JZFG4FIb06vL4HNDTeBuN8B7qEh7+3ab8XJLp+lXYYYnFLK4m7wYVLs586kw+S6qvce21jTIqvu6VhIKQ3F92N5R9pwUzfoDcbTGDOWBjct0GabvuyKK6Dkuehz9xlGp01vLPJSSvVcGZobaftq6o2TCYluX7gcn/CWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MGvXSXbpCjZ2LJJCfzgKocecungLghm1VuD7v3RxTc=;
 b=hz2SpUDMwAacLEzA+av16tECvHWC8q1k8oBxUp6VeT9f+vHX+r01WPTvwYxEsDnV5XaIWIZvmuLMwJSuQjkZyuRed6Igs/yCgu3MkB/g1E7CCJYyzj2DOu9+FRdED4Qe9vneT6kvTGwlrI8KAOSRBYojQAca9nc5m3c6ncwuWyFkRq1G8Nw0KIFkixUw1QyT5ra0FTWAER0/7kmbX66beqRJWUVEX/8ZrYMoagif/1OT1kSOGUuSXSqOqaWpnYZj1iYfX39XYxxxGbLKKzJl7MkGHuUGWm7AIK1OGrDNQG5ok029DlKZYNW9Rvl6J6TakazLY0MVKcD3Y3fKgWC6oQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DB9PR04MB8364.eurprd04.prod.outlook.com
 (2603:10a6:10:24c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:49:53 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 08:49:53 +0000
Date: Wed, 28 Oct 2026 10:49:48 +0200
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
Subject: Re: [PATCH v5 5/7] arm64: dts: imx8dxl-evk: Add onboard GPIO mux
 controller
Message-ID: <auG12nh5bsNQZzyW@vm>
References: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
 <20261027-dxl_lcdif-v5-5-3a974e4b94b2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-dxl_lcdif-v5-5-3a974e4b94b2@nxp.com>
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DB9PR04MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 00aab431-e421-4b73-150c-08df34d06f2f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|19092799006|261026140227099003|4143699003|10067099003|261009223027099003|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261022075727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: VaX/Lg3WgRabxgEANrfnbLEpDWZNzJSUpHFjJ42WIqVo/D7edWwyzYEleC+GcwrcmziY1l51LnVgueGaD9wm9op1wn72+jxj3J17zARQodesPTizlLS0LPzHlDmtvwQl18czQDf72+vsxO6HRvK/JU2+4TjDQGM81EJtjhBIZ2GhlcbuUntwY0w/XSnoqUCi6kkulyTrsequUZq0uVYDMrgaq/NQEu6R054dfaC/xyIzsWy8yz12+BrF3JeJLLwOzgClxDZTtMja0iuGCuzx9FevIXmYdaLCkgiRAg3KlY8L16+FcD+y0WusU8BNLrl20hPbAFhDYSzAedNhePuXNqnaGEM4hbX08mXoI3pMko48NgTyO0l31CIuXcQ6mxrcH40boe6iUeKymCgbMANXXYmsZWHAtWsqpVx1zqTOlfwGCHOTR6L6ZIwaGNXKHlYeW1oPDbSlPtdRXqWz5JZwlMUtdIpN7cM2mrar8zfG2rhyWrGGOlZAYVKxsiHSA6QiBB0yLvUXTaZSC76xn+qvrruZGMHNlgVlyRsoiJINbgvrye/qZykWMlta2d2+WNj6/EDlPXOjq6zqClwtXyYZcRH4Y1nHnOEjdJB/gQhwakm9R4mHEkGJYhYil5LTR8PVQ5cAPsPRkEJp2XABAOvmGwu7fAebXiJDUbYWhN9hr3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(19092799006)(261026140227099003)(4143699003)(10067099003)(261009223027099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7NiBu5tB5PTm4HfDTU/F/MzfQyBN9h4UTE9mVrx6CLXdIfmplTYPPmYj84aq?=
 =?us-ascii?Q?5MHvwtwXtO4IlB35+G2p3fAt2EyovU6TNeqNGFTr7EeuFpSAbc9ilM/n7qse?=
 =?us-ascii?Q?AsNlB/uuwGHlLNygPsYm/7CNtllynB4DxgwB6XAFMhQZmEZxsDsmHo5B/AOW?=
 =?us-ascii?Q?AvbDbfCPU9iQc7o27PWyH01x2PRbzr3tVYKTI0Ne1MDczWJSDq8n+vHO+6D3?=
 =?us-ascii?Q?YjxWOf+3QiGR5Sn6z/lHHvBxiURCbhtFsQ/1+r4dqgv9Gw2v2kcd18oZKEgA?=
 =?us-ascii?Q?RZ27Xgr7PrjS3L7Vvi80QuSUfeLRbF+mbiH8I3biisIqSCKgeR+fl09fu8Pk?=
 =?us-ascii?Q?pVVEuh1fDDNCErStZoZT8gQ7WYpPaCq/fSlqKoTqwnMrbp04oGJqi2gjgtk+?=
 =?us-ascii?Q?xaf/W6O+1p5yLB4dysBOBm0k049110sQzTxqmWH+WhrtCfjZQzok741D9/YX?=
 =?us-ascii?Q?9pFc3nvLg73+1AdS9UUztxgzKQ6hPfe/kwLRkHauVbgIphdXBkTirmSnVyv2?=
 =?us-ascii?Q?LXb78SM9bMfOEmAcvBmdAWRGjVm84RUOpkiDRWGNBuWskH4PwwspeOURsguY?=
 =?us-ascii?Q?Xi5L+wB//SXyYLjTgUtADm7n0eeQrCm9rmGfynuJjOFyI4dHUsByaKcKO4z9?=
 =?us-ascii?Q?WLUjIQWutkQlADlWuj/83lyQp3JenXBq7oImdWlg9enmeuKT3lQzNDiMQjBa?=
 =?us-ascii?Q?HXPoaaH3AN8SrGLe1HacE+Uv5G4slx1hAnAofe/ppm45MptW8BSXkoSdneFA?=
 =?us-ascii?Q?/IYFhBDLV3Y0PYPpDVFxRh9e5i218xnyfMLK3tTh5mSZVK3s1xZid5fg6Z8/?=
 =?us-ascii?Q?w48+s6sghIcrSktHxQdwwcgD7+SJmVMk2LnvcgLD74Eevd+5ipf6T/KtOGPH?=
 =?us-ascii?Q?ZWax51P7jdJVlF2I7HuADYSmuLWLNJ4b4Q4PzOaiYO6JXf2P6geW4+Fg0DR4?=
 =?us-ascii?Q?KczpAgmDoqzceD7aGKJgzHD5JL70Fd0DMnEODEZ8NYXIjuzw8sj12PBDpp+5?=
 =?us-ascii?Q?6G/E5AUSVpFPx82/XatapzFc/zJZXN8DaoWGlpQD4I8p8VSp2OI+DWkdjX5A?=
 =?us-ascii?Q?WYWdTu9tpWBl0BGd0mRIEhqsWPCcfIZocnE2FK+MBzOIfxiGRi2tOl2lY1bo?=
 =?us-ascii?Q?jkxS9OAesmPzpHqj666OMWltcRkb2LGbLlGOijdetjVfYOX70ZpOmYCmrCwb?=
 =?us-ascii?Q?GLveJvVt/8g4q7ryA5iM/why1n8MabC/Wg0O89IYTpATgTkA2Mlq25MUvJlB?=
 =?us-ascii?Q?27ODh4ET1BxGdgoiXGkePsHwDmcbd02r83eUU8gE7HUYq3nGSGzobfkifpc8?=
 =?us-ascii?Q?oLqBeZMhoGS8PzKBxsLv7cqmzCbCBZs3tWosYLl+Z5WScEke8qBMn+M+1SwF?=
 =?us-ascii?Q?FOesbxK3PP3bQa0VFEfrpl3j4zGKzw7ugKkkxtthGfBCUS+T/vAOcFvMNtRG?=
 =?us-ascii?Q?V0zIvATw8bRv71seeyeeexkhmcJ05KJJejakKFvjBEhZ/35cQfZ0Yi9dN837?=
 =?us-ascii?Q?YqTLzjYgrEKr3aNvmzzdDsdMv7xmOwSLvt2YCOZo4m+YC0u967eAfc4VpfD+?=
 =?us-ascii?Q?J6e0ZPSzW/n0s0opourtrrO7RycYmjL8+t2V3fSfBrcctuNBPEmo+t2bc4Cy?=
 =?us-ascii?Q?9A+lQ5tH7Z08ratF/xA5eld9657DofrLcpSK1lRpvOOvgfy4kiBIWlxI3POA?=
 =?us-ascii?Q?6rWfLm+qaij1adRqo28+8IULiwn3k/md9DNVkT1QXDyYhUCHBxRcA0+Fe/1B?=
 =?us-ascii?Q?QTSk6u6oQ9XIp1X7IB3vIzsgp4RNQzU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00aab431-e421-4b73-150c-08df34d06f2f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:49:53.5263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cqd/ngDz4Fa8dsSfutKvwoSK3TKvwwfJP8waY2pBrhYowEFrDXB2njJFqeqnWtRPd0KpQV33oGYqXgye69JTQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8364
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

On Tue, Oct 27, 2026 at 11:00:57AM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add a GPIO mux controller to describe the onboard signal multiplexer.
> Previously, the device tree relied on the hardware reset defaults to
> select the mux state. Now that the kernel supports the pinctrl-multiplexer
> framework, describe the onboard mux explicitly and let the kernel configure
> the required routing.
> 
> Prepare for additional device tree overlays that require different mux
> configurations.
> 
> Remove the regulator-m2uart1sel node, which incorrectly modeled the board
> mux as a regulator.
> 
> There are no backward compatibility concerns, as the affected functions
> (lpuart1 for Bluetooth, spi3, and m4_lpuart) are not used by existing other
> users such as U-Boot.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v4
> - add idle-state = <1> (sashiko AI)
> - ref to spi0_fun for sai0
> ---
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 80 +++++++++++++++++++++++----
>  1 file changed, 68 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> index 71eff3efa6d32..f21ac208bf00e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -97,14 +97,70 @@ vdev0buffer: vdev0buffer@90400000 {
>  		};
>  	};
>  
> -	m2_uart1_sel: regulator-m2uart1sel {
> -		compatible = "regulator-fixed";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		regulator-name = "m2_uart1_sel";
> -		gpio = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -		regulator-always-on;
> +	m4_debug_mux: mux-controller-0 {
> +		compatible = "gpio-mux";
> +		#mux-control-cells = <0>;
> +		#mux-state-cells = <1>;
> +		idle-state = <1>;
> +		mux-gpios = <&pca6416_1 3 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	spi3_mux: mux-controller-1 {
> +		compatible = "gpio-mux";
> +		#mux-control-cells = <0>;
> +		#mux-state-cells = <1>;
> +		idle-state = <1>;
> +		mux-gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	uart1_mux: mux-controller-2 {
> +		compatible = "gpio-mux";
> +		#mux-control-cells = <0>;
> +		#mux-state-cells = <1>;
> +		mux-gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	spi0_mux: mux-controller-3 {
> +		compatible = "gpio-mux";
> +		#mux-control-cells = <0>;
> +		#mux-state-cells = <1>;
> +		mux-gpios = <&pca6416_1 7 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	pinctrl-gpiomux {
> +		compatible = "pinctrl-multiplexer";
> +
> +		m4_debug_fun: cm4-uart-grp {
> +			mux-states = <&m4_debug_mux 1>;
> +		};
> +
> +		spi0_fun: spi0-grp {
> +			mux-states = <&spi0_mux 1>;
> +		};
> +
> +		spi3_fun: spi3-grp {
> +			mux-states = <&spi3_mux 1>;
> +		};
> +
> +		uart1_fun: uart1-grp {
> +			mux-states = <&uart1_mux 1>;
> +		};
> +
> +		lcd_0_fun: lcd0-grp {
> +			mux-states = <&spi0_mux 0>;
> +		};
> +
> +		lcd_1_fun: lcd1-grp {
> +			mux-states = <&spi3_mux 0>;
> +		};
> +
> +		lcd_2_fun: lcd2-grp {
> +			mux-states = <&uart1_mux 0>;
> +		};
> +
> +		lcd_3_fun: lcd3-grp {
> +			mux-states = <&m4_debug_mux 0>;
> +		};

A lot of fun above! :) Joke aside, wouldn't it be more appropriate to replace
'fun' with 'func' in those label suffixes above? 

Otherwise:
Acked-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
