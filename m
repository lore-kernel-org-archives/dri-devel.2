Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D34CCD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D7A310F46F;
	Fri, 12 Jun 2026 11:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UnbBU8d+";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013000.outbound.protection.outlook.com
 [52.101.83.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D49010F477
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpHJkPOR+YxHi9C41KkLyOkumHC8NAM98ZfHaFJW7SzbWNWRvUBCpvBlwtN3EdYkgk3JIh8RV5/ZsPgsEgkY2iqXMZVDI6v6p/xW5yiVcPyh6lZWkP7JzciYj7oyukV/31f8qosquhHlF+pP77bpccyv4KJ+P8UCIF5LwGo7elvZVsLjglhJbHzsHl3Umv/POqAa1+MVqM0zl5anH5w4VZKvTEMwdfMRO3T1Im9gIFUgGO144F6Q4VyIcJqa0UGPv/oN1Ik7jKA6LGLOSw6sJi+uHQdpv0CKcHkQUQuPF417AbZ3aSuK8dRFMHqqv988ff0yPxEUo/tlUIi89j0+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZVj0AQlEPiBkg3g/g6pSQIt7y5iwujN1k0A+b3psw0=;
 b=qKlst6IKxFcIIzx6dYYxVVQ7YFNCjAnShg4XxSImeMkeVxXN4ms9N2C9XNWwYFo13O8f68MYqLomYFoVmAjpX1ua/947Jl01O3zvqRtX+pPqey3e9CFWcwKOc1bk76lfT2ECiNop+oC3gKmOXP2RlxkRfzVCcv46ATsVfKacnuc38ScH/rV6U/fJbgjKSewwtDFxEesU6MGkTYofHgdr3/gPS4fFJV9DW6lTGARckp8JuCd7YNtkgpocKhLcSkBvBXg5xqcjuylUA0oCB17l+cnBG0PGc3Yled4Nc53RAb42DMcMWUsJIFjMMR6/GadzmhkLZ641QuKEmXZMEU99tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZVj0AQlEPiBkg3g/g6pSQIt7y5iwujN1k0A+b3psw0=;
 b=UnbBU8d+w6/Yh5JMUDU4iU9vfiqQrGk238xn0i4gGXtt8ExiXWTMCum1h9N21279/ScBwTc4hIcHqfjBrsY5ZwdEGqsMwuQcOtyOMXOALOSq4EqJFaVEKlzoaBNo6/AZO86evOsQ7CO+OoEWirMoCvb5iYaOvxUnZBvWSFLR8+D4i0QaD0cLPDQsvbIKnKWHIO0BkR5KCT0kBp0KeGY9u9MzklFCOhez7QcJqRJn9x9F3yq0/3QtmWG87KX12/1qxa79qruxvSZvseB/zcZWYSqTtCmidPExjNI5THVCi59U1p7ZeOxdS4Oo5WnGOZZMNB2kA1A+D5L6pU9I8yEnRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GV2PR04MB11710.eurprd04.prod.outlook.com
 (2603:10a6:150:2d5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:59:13 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0092.010; Fri, 12 Jun 2026
 11:59:13 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v9 7/9] arm64: dts: imx94: Add display pipeline nodes
Date: Fri, 12 Jun 2026 14:58:38 +0300
Message-Id: <20260612-dcif-upstreaming-v9-7-8d0ff89aa3c5@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
References: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::10) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GV2PR04MB11710:EE_
X-MS-Office365-Filtering-Correlation-Id: e74dd978-7e21-43d7-5ed5-08dec87a04f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|1800799024|376014|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ezISH7n6HMUb4VobgiVOVW+vWYmNZDIA/R9/t/UkFMhCWBPQXfH/E8Vg4k4P7G+BMTmFsf712Fw3ED0cAu+qJV3VVUweUwPBaBqHb43L/2fd1Pn/i+emxdWxCeDOPMm8yl0quvmw+0ibmkj+m+A1nxARDkBGTdCmvXnUuE3wYL67hgHzUvTW++Yc4eVcf8RKeZ5OCZMx2wwvuvJzMp8Fa0ZOm3RzbCEm9k9O1GFxzu9VyJF5mKV6jnkRVhOUKy7xqV7BLRo09CHIeWtgNdPihx1xbHck5xHLwuk7lvw6vIFODORx7zkbJxgI7HAyH1pKL0EQ5TGRX8I+py3d5OsXMfU+iVQ9w1Ti/SnvBYS5Iz49gOWfpipejLCf/llR+npNscGjTefiRQ+NZT3UpV+t95nyQdJ12lFaDuRp1DGl+lyJ+zgZuxsuyVJZLSdrQziSxfyn8AyYkXUGrIfrS7Y1ZWGeRsn815RzP59I4Swy3HwQJ3B5SF+2+oMfGaHrJElmbwTFK84vD9M2imr9JSaW/oKpckEEjz/zSf9zfJumDAuonp3G0Fndui4T9em7YPFeqhHHqcPAnp0hMxysABP7DrTL3xgcfBARzIJOOFnidryBhkAGZXwB1ShvbsKEp7ValqjsOr4OIxaQE7PhfeqDp42gSJ1hMbQU5tCDPBVnw3MRKAVDgmnE0vHyrYLRNQ7D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2dEYi9GbGk4OEl0c2I5cjJyMjFvUUhOVGRpcGdvWEJJMXJjZG9Rai9hcTFh?=
 =?utf-8?B?bGR0bVFzdURlNXlZMnFWelhKZUM4cWFuWW1SZGEvWDVLcGdobWM5cU1KWWU4?=
 =?utf-8?B?cDB6L0ttd2ZzQ1BUNXVOcmFEQlR3aGUyNDVmWUhSTmFVQW5rVzRsZ2oxdUU1?=
 =?utf-8?B?WWgzY1lIbmdwajQ0c3hYMUlBaWJKR01CWUhPYyt2cUJOVWo2MDNHTVNxYjIv?=
 =?utf-8?B?TkJwMFRWeFVsWUgyVWNKTDVNYmVhRUxKMnRDenRBM3dwY2E3a2JxOUlKTU8r?=
 =?utf-8?B?bklXcXNJbnQvMTBjRmJpVTJlMjdPZ0lxYXA4SEQwYnNxZ2tGS1Q4K2VMUGx0?=
 =?utf-8?B?Tm1OZnRsMWR5U2gxdEdVNFRia2lUeVBYUUFPbHVEbjdnME16UUhSQzgwbmtK?=
 =?utf-8?B?ZXN2NEgwOHdjMW9CRGdOQWl3MUZ2bS9aTmJiMVBJVjhnVm5PS09ZUk4xUlJ5?=
 =?utf-8?B?T1BoNUk3S0luMHFHTlloMWFrVFJleDZLK3Rzb2pQT1B2eW1KM3puazhoTklr?=
 =?utf-8?B?WUhlWDdrUUhrMnBwZUdkYUUralU4Z1drdVJCM0daRjBJRHh0MzB4U21FTlFV?=
 =?utf-8?B?WGNxUnpUdWZNMUlrbTNyREdGMXR5dVVDeVhWS1ZrOFl6NXkvR3V6WlBBdFda?=
 =?utf-8?B?eVNHMnFXeFVrREdDa3VJbVdrV1orWXFXam9qYjh3ZEV0Rmc2cGNrN3BkQ0g5?=
 =?utf-8?B?ajdnam8zajRzSG9ibnEzSVJHVTVVeElLR2dvckVSZm5vdU5rd3JRRkk2TDFT?=
 =?utf-8?B?Z0Y4TDZ5M283WElkRDBHYmhONG5saDVvVExMRXllQ2wyVlFMQnJNVHNjTXZO?=
 =?utf-8?B?QXY5VnFVRXdwVG9LZ2FFczA3QW8vWlVCSlZtaFV4UDM3a2gzZHJYTDY2L1Fu?=
 =?utf-8?B?VU1lNXlkNjRLTWFVKzFZaWl6N1pBek1zWmZGa1dIL0Y2OWM0MmQvU0dNQjFp?=
 =?utf-8?B?VThpcHorK2REdGpHSjgvN0FxK3JybTM5RWtRWUhlM3hxZmhYRTlhMThvcWRO?=
 =?utf-8?B?WU9BN1hqcUs5V1E3OFNFbE54UmFRUmJPMEtaQ0Jsd3dYUXFNNHdWbjEyQU0y?=
 =?utf-8?B?eU5PMnhOL2g3RkxRZnE1R0RyLzdZUGtDbXNzcHdxcUR1bTVpUkxpVnhTK0lq?=
 =?utf-8?B?TlczbWhiUnE3QVl3TVdTMEJVNzV4ZGpaMDAyd1o4RHZCdk56VTZLcjdKSXhP?=
 =?utf-8?B?RGMzV2tkU001TkgzeHZEeS8wMVM0eGRmaC9kOEZYeFN6SXF4cHl4MHdaZm5S?=
 =?utf-8?B?ZGh2S3lrdG90ZE5PYmFLNXc4Z1pLWGU2enA3Tnh3elVYTGNzeDh4d2E1YUl2?=
 =?utf-8?B?VE9PbkZPY0dzeHJ4ZWxYNVMxd2EreldXUHVjTGtyVDhrNlpEcjVYOFdtSU5U?=
 =?utf-8?B?YmEvMDVRVTV0R2lvdk5IT0I1T2N6NkNrdzMrSWh4T3V0OVNydnVuMW5ZSEZV?=
 =?utf-8?B?R2xHbEVwc0I3YUd4SWZMdVBia2FpcCtYMmZFQUlIM3J3am8zaGNLZmxtbzdn?=
 =?utf-8?B?Ym5RNDQ3dGY0S2dCVGZ1QzFrZ1RGRmpldjJQeWQxSHNSY29iK3BSRlc1QW16?=
 =?utf-8?B?dU1EK0doWS95V25ENmM5MFBlMUFBMCt4MTlweGo5a3VKWFRrY3NaSlVWMVdh?=
 =?utf-8?B?RE41bHFzbW0rTlRVZnM2aldrODJ2RjBvclJDRkwyQWZGdHlBMnNPOFhwQ2U5?=
 =?utf-8?B?MFNvRUZETk5aVEFCb2Y5aThMV0tORHBESEU2NVp5V21UVzdHOERmblpZSkMr?=
 =?utf-8?B?ZThMOFFpcXZyUUlYaHhQSHRjcVVaWFdibGsrS2pVRWZEclQzRzJGbVRDQzhr?=
 =?utf-8?B?VUZ5cWhZTWtScjhWNDhncEs5eVUxTTdQOGhNclA2RGg2Mm50SFlyQkdnRUJY?=
 =?utf-8?B?RHI5UnNUMVB5T0QrMGlFWTlsLzB4OWtmcDZVMVlsZkgxTm5RMzAwK3VKT2hM?=
 =?utf-8?B?ZTQwTUNoZXZJWUxERU5XZlBEeE1yZStvWE4wL244RXc3eDgrZEcvallUU3NE?=
 =?utf-8?B?aGJDbThjWC90NFQrdGk2YUdmdkJoY0ZvRmpwelFmUzZjbDFYM2VSZC84RlFn?=
 =?utf-8?B?ZHlKV0NOUmNwb0ZnT3VWWG5zNGZFRUpXd2lhb0JWMjhONFlRWEhuWFVKUnZZ?=
 =?utf-8?B?djQ4YThWZmtVTE1DUWhuQ3U3Wkp2eTJHQWFFR1dzd2ZzUWhLOENHT1FZV2x3?=
 =?utf-8?B?RmpmVnBlV2pnNDNQMEh4MWFMMUFPR1ZDOFBMd0d1eldGTHZjWXZlcXlMNnhk?=
 =?utf-8?B?bC9ZaC81K2VoSm9QUjdDQnlVMHdCdStNRVpsVVpzR0JRM3F5d3d3cTNJMGpy?=
 =?utf-8?B?ZlQ1OGNWT0ZKSVZQQ01BcWVaaWM2R084WXFwa1FaTWxUbW1aWTdkWHltMElk?=
 =?utf-8?Q?2q33vbWVCn6UwuPo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74dd978-7e21-43d7-5ed5-08dec87a04f2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:59:12.9608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbBOeRTjU8IvOF9Qk04A5sW19lFZlNqvtKUOaqeuF4yzXNiYaIje9CqQiCSQFWg/fGk4CtC4VkxP20Jeh+Ctfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11710
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

Add the nodes necessary for the display pipeline on i.MX94:
 * LVDS/DISPLAY CSR;
 * clock-ldb-pll-div7 needed by DCIF and LDB;
 * Display controller interface (DCIF);
 * LVDS display bridge (LDB);

Co-developed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 82 ++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index a6cb5a6e848b3..95d862682703c 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -3,6 +3,7 @@
  * Copyright 2024-2025 NXP
  */
 
+#include <dt-bindings/clock/nxp,imx94-clock.h>
 #include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
@@ -39,6 +40,15 @@ clk_ext1: clock-ext1 {
 		clock-output-names = "clk_ext1";
 	};
 
+	clk_ldb_pll_div7: clock-ldb-pll-div7 {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&scmi_clk IMX94_CLK_LDBPLL>;
+		clock-div = <7>;
+		clock-mult = <1>;
+		clock-output-names = "ldb_pll_div7";
+	};
+
 	sai1_mclk: clock-sai1-mclk1 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -1305,6 +1315,78 @@ wdog4: watchdog@49230000 {
 			};
 		};
 
+		dispmix_csr: syscon@4b010000 {
+			compatible = "nxp,imx94-display-csr", "syscon";
+			reg = <0x0 0x4b010000 0x0 0x10000>;
+			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
+			#clock-cells = <1>;
+			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
+			assigned-clocks = <&scmi_clk IMX94_CLK_DISPAXI>,
+					  <&scmi_clk IMX94_CLK_DISPAPB>;
+			assigned-clock-parents = <&scmi_clk IMX94_CLK_SYSPLL1_PFD1>,
+						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
+			assigned-clock-rates = <400000000>,  <133333333>;
+		};
+
+		lvds_csr: syscon@4b0c0000 {
+			compatible = "nxp,imx94-lvds-csr", "syscon";
+			reg = <0x0 0x4b0c0000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
+			#clock-cells = <1>;
+			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
+
+			ldb: ldb@4 {
+				compatible = "fsl,imx94-ldb";
+				reg = <0x4 0x4>, <0x8 0x4>;
+				reg-names = "ldb", "lvds";
+				clocks = <&lvds_csr IMX94_CLK_DISPMIX_LVDS_CLK_GATE>;
+				clock-names = "ldb";
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						lvds_in: endpoint {
+							remote-endpoint = <&dcif_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+			};
+		};
+
+		dcif: display-controller@4b120000 {
+			compatible = "nxp,imx94-dcif";
+			reg = <0x0 0x4b120000 0x0 0x300000>;
+			interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "common", "bg_layer", "fg_layer";
+			clocks = <&scmi_clk IMX94_CLK_DISPAPB>,
+				 <&scmi_clk IMX94_CLK_DISPAXI>,
+				 <&dispmix_csr IMX94_CLK_DISPMIX_CLK_SEL>;
+			clock-names = "apb", "axi", "pix";
+			assigned-clocks = <&dispmix_csr IMX94_CLK_DISPMIX_CLK_SEL>;
+			assigned-clock-parents = <&clk_ldb_pll_div7>;
+			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
+			status = "disabled";
+
+			port {
+				dcif_out: endpoint {
+					remote-endpoint = <&lvds_in>;
+				};
+			};
+		};
+
 		hsio_blk_ctl: syscon@4c0100c0 {
 			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
 			reg = <0x0 0x4c0100c0 0x0 0x1>;

-- 
2.51.0
