Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65CBCA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3880010E39F;
	Tue,  6 Oct 2026 12:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cx2CLLow";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB3A10E0D5
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Didi6XaIL2viBGQI7l0bK1QGJT4Zvi8cqDr27x/X/gVcI7us9Uvtb+OnHqJPANGCpUFfZE60D2+hAv90uPTqfH/oI+VpVO91Osuo6Tpaw1Gz83GZd82uAs7RRNsFo8tlec/+mCejBv7PWVbIenE7ShCAVSDWyOgCgKWPyEbm5Vu0SQAtFOV68HyMYFAG0Kx67DQr9RtvUG89wGs6JN9xOSIH1fmjoAto3ez/aK0bm4Q6bPOa9WirIyw5mj5SC+GQbu6JC0GSK14+fOnaULGQxUS22ldyynJscYXmUZ39W2GGoA6giPayZx1pxw1o4RD6Li4oN0HNls6IswkUHss5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1I4RQN+VhXMZ0XD1J2pWFbhmkyRqKc3GB5IPm/axVPI=;
 b=mMBlls6NAV0B7uJVVadCtfYL2MwYPtJg2w7S/bxaMhSUQOOA11/sVoRUqyndN8iwYrtOusk9vVooQtxo6+buk1+siJSJt/jwK2BV4z1/DhOJY3EK6vkf8pPNPVYzvVJL42l2Lqpta2z25esBj6bV1z0trsXixYVAPSlhgubEeDod8lAXJ3sxzmoyyC397B2Eqzog7BXI5r1CoG7wPbO/lEsHbBGIxsvG8Ah1q9Vf4NDxNQuxKjwGJiqrBXh+eYQwfs3zshxCHEZ1UcOGlx7s5FipD7JUvEnFYLz5TzF9kjhnyLjLNkCZKD715zyXNzCGUtsRLxuGAVFlGNg04GQNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1I4RQN+VhXMZ0XD1J2pWFbhmkyRqKc3GB5IPm/axVPI=;
 b=cx2CLLow8eO8TZ0Na2grVVaPToiKnlQg0T2yG1grJVB/mmmbmax70WTZ5jirWEUxgb8sM0yFYarruGeSlpUzLwV8vJjRrb8IzDwvxkBKJK3LmyyxxSZ+n9pIpGPU9MWQR1fHK51cVL+PR45PC7Dvgu1nBCekcpg+nFswqb05u5FRETDzH6tH1zhjVVhQRgp3FIdkevbiRMg2V8t8bNE8F9ITyYHzT0VZsu6b1YQXDDkPuyK+bRy7zVytRB0/Nx/0U64hRTnNUOoII9MwfYmDyq6FEmvPG1rO3vE4cX/VdkBptVghLpACfVkJ0zaFOOm8CzkCxei1jCmTNo9KrCUHyg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU4PR04MB10742.eurprd04.prod.outlook.com
 (2603:10a6:10:58c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:23:29 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 12:23:29 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v10 7/9] arm64: dts: imx94: Add display pipeline nodes
Date: Tue,  6 Oct 2026 12:22:02 +0000
Message-ID: <20261006-dcif-upstreaming-v10-7-bcfb28de0aae@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU4PR04MB10742:EE_
X-MS-Office365-Filtering-Correlation-Id: f1391bc3-ad4c-4b95-71be-08df23a4a076
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|366016|7416014|376014|18002099003|22082099003|921020|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: igN/IiEYDBZeVRjLo0MKbU3cjCy8JBzqWMNjis8ecNCAkXsdzR5U+zbBpd4BF+nNnjhPM35oALfk1efkloabHzzMG/poNXbEX3Gy5wx+JAySngk3CpBegsR/l33iLQnLOM5AFSPF6H/zAJtxO0aCWwhJNOKQ6l08NYfLxyhHwaf7rdyjzPY/xJxuLWwZTEDLrFxsyVQEr+A7WuN1OUChM7PfIBCa1TZt/DTeDr4IPIV70tldJWB6C4wBOwXTFYLzxQK7TY1g05dGPHE7KIuuKRU/TOdfJ+0awqRaRivpCrwpaRLxdN4L6GOK8tjlVCCU7p3lonRAqDUwbfw1yXcX3VpB+iqX/CqJClH+GO+DJP0aYKBcncdGWnFYFFdMYb0Z7TGjOKPQJs9UycFaSGJ6G0yz5x2UAgc4SE2R+hUqxLUINP7HFSX7cWQhpW5DY/90bdyE6dBJBSNPq+a1rDSrDGqfTkSYzkEUlsqMXeX6bGK3Dq6Dmqt5o5C3aDD14/TJZXyH1bhtig+sObJmMCY05hT0pxy59EegE2At6Yg2hHnYg4BScW4RlvNQb2Mz7TTGsorhVL4QPHRWGFXoQ10wYKF2sN2RNhFvuwzgrfK5C5eRftoJiAh1IEuZNtuzNNPzZNK7JOuGrQJ5+2BixQYFvE/iXibr1b5kI3wTTa6B6NvNfv2z+AI0eU3gVtjtN7WCy0OluVsbTH3/ZmI1f7tFrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(366016)(7416014)(376014)(18002099003)(22082099003)(921020)(10067099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alZlM2dBeWQzQTcwUitNL1ZEUXZHdEk5cXVyVms3Sit4WkJnMlZCSzJTSWFY?=
 =?utf-8?B?SEdlcmdYbkY1dkN2WmZEV25DMHlkWGZBQXVFWVd0aWhUYnVhSWROQ0NZUjBY?=
 =?utf-8?B?TEVpUWJ1RXZoVHNMYnhhWWhJZ09NelIvTEdpdFozNlN0bk9EVktFcS9ZeUt4?=
 =?utf-8?B?cUYvYlMyRDNzWGd6RkpUMkdrN1VNRWVJRXRISlJOM29DZkxXelBOZTZ0T2M4?=
 =?utf-8?B?amtBZlpMZUV6VzlKZG1JdWNWNVQ0ZDJ5QXY1SHBkdnd4YzNxdlVUSUlnMWNH?=
 =?utf-8?B?RlZhZXIxdFlHR0hqS1JlYytSM1dpQmQ5NWdkb1VMeE1oTUxXdi82SU45WDkz?=
 =?utf-8?B?T0NzQ256Z29seGswczNyVnVFT2dWS1RscEs5dTlFd20yYXJ4ZCtBemVhazZM?=
 =?utf-8?B?VHVqbitxYk1rUG5YUTY1N1hLb1ViL04wRzdKcnFYZVc3UWtpMjVUeHgzbHVR?=
 =?utf-8?B?WlJ4NTlTN2N4bFlIMzRaS3FpNE9FUjVqZ2xqbHZnaFROR09SckRWLzZldDZJ?=
 =?utf-8?B?b1p2NUJDYVNacUxILzdXSkJnR2JLdSsycE1OMDcxeE1wdWJyWHJGeE5FSVdF?=
 =?utf-8?B?Z0lGZHVPczVQSHl3QjF5M1YvL0ppQnNvUWRvejNZaXlUeWIzaVVFZ2NYQzE5?=
 =?utf-8?B?MERCSFNHSFNoZlFyR2RvS2xyZVZTNjFQSjY0c0hEZFlOc2YzbldHNFJYSGM0?=
 =?utf-8?B?dG1jOTlMYVA3Sks5ejdMZVgwbUlHOEtLelhhWmsyVlBGMjlwZ3c5bll3VGNJ?=
 =?utf-8?B?eXdIUXNWb3ZKZzZkK05TU0d4VGdsRzdVKzJYTDZXcC9naE1tNHJFNWNzUExU?=
 =?utf-8?B?NXJUOW9LNjg2MnlQcHcwY09aWjdvbFJiOVR1MW9HWUpOQVFaYmpSOGxjQ3RM?=
 =?utf-8?B?c0JpbFI2NGtKL0J2cFJsVXFkbFRJcytyQ3NDeW85dC9tRDIrQzl6dU11ekNR?=
 =?utf-8?B?RDlHOG13UHJra3hoR1dOK3ByblNrZnlSVHJXTFFnRllmL3VBTUVJdGpRMk14?=
 =?utf-8?B?K2tMNnppSENER1pENTdUODJMVlRSMHVrUFd5amN4djU5N3VnVHNMVno0TTNV?=
 =?utf-8?B?UVNpWTVDZU1lZHpYZ3Y4S2VOQ29pQmdaS29ZbDhoL0NqRVNwWW1RaThGbERD?=
 =?utf-8?B?T0VqTld4ODg2Szhoc0phMW44c2hneUYxMGRZNGRLZnZZUVBtK200UC9Vd0xj?=
 =?utf-8?B?a0NMbEc4U21CbmxsQ3Y5ZDVoNXJtbWtYQ2MwQm5kbW5LK2dhNnBzWkRUaGFm?=
 =?utf-8?B?NXV3SjJYN3RTc3duS0NLdXNEK085S2RUSDNuT05oaFZOWkZjZzZtMWxkczkr?=
 =?utf-8?B?S3dDOWJpa044MmphYkFhL0VSMGh6MkQxR1U5K2RYa1lWU2p4dEpFSEtPQXNV?=
 =?utf-8?B?c2FaankxUFpwbGZvYjlzQllnZ2RtVnlvSE5VUy9xOTAxaDRnT0JQMHU5U1Iv?=
 =?utf-8?B?UzVVajdmclk2cUh2cHlZcE5oeFh2L285TDM0S2pGTkNjMTFFSWwrdE96Q25U?=
 =?utf-8?B?cEtaNEs2bTR6d0FhVm1jbi80RDlwa0ROalk0SjI0VG9WdnhsWkpYOThrZ3NX?=
 =?utf-8?B?Z3JRaUY1ZlBkRi9PZE1DMC9XR0dLd2hLMi8rckF0L1A4cGJ2RnlMdUdwYTND?=
 =?utf-8?B?SGw1OG9sMUFTWGpDMzRnTzhIWGdjbHIybWpoQS85MjBtU3JXWmRyS3RDSkhJ?=
 =?utf-8?B?TVZ6VVRibHNuQm84c3M4VmtuaVdzSFlkVUhjclh6WkFCR0Q0QmtGSzR0VmhP?=
 =?utf-8?B?OUxzb2hOK1MwY3R0eDBqTWZuMFk1cXVXYkY4a2NCV2tjVW5EYTdBMnVLdmhG?=
 =?utf-8?B?TWIwSmZVWDB1Y0ZoL09kL2VBcVdqZkRSMjFvMzB3R215ZDJvWGEwNTFjYXJv?=
 =?utf-8?B?a3BBcW1WV1hMVi9wLzdqRWtZeTN6YVJzejVnR2ZyK0JsOGh1VmNWMmhkZFJK?=
 =?utf-8?B?MkdHcEMvd2FmSUJ5SkpEZFpBaFZQZDNCenpQVVF6bU1LR2JYcmVBUk5oWGdn?=
 =?utf-8?B?OGxwQnphVDYxZ3hJcFBpbHBLc0xHU0pVUTEvaXFmalBZenIxak5KWXd3Rmty?=
 =?utf-8?B?NTBuSjBEci9HMk5FZjBNZDBFTDZuVW5qT3FKQ3JGT3BTMWZETWc5VURhUEEw?=
 =?utf-8?B?cFBoVExnK1g5U0dvMmJWU1hZOFpaVURUWFpIZkcvNUJoTy9Ybjd3amJkMUhy?=
 =?utf-8?B?RzVrYXJOY2I1N0gwaERrT1d3Q0tQa0hTWUtuaFh6L0NqV24vS2JzRlIrakY4?=
 =?utf-8?B?RTF5ZkQzZkJoS0tMUXRtclhwOXRPbGdxcVh3YllxWXdDYzdTZDJkRkNwK1Jz?=
 =?utf-8?B?N2c4Y3dCakFydVduUDlRVTVscGFDQnU1MXdyMTZ6bGxpVGRkdVVFbkRmRVlh?=
 =?utf-8?Q?MQjUQzdKezMnTD0k=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1391bc3-ad4c-4b95-71be-08df23a4a076
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:23:28.5236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/HBM5w5/CILFkxgvcnet1stIjGid2oMvYnHhZzmsM0sqeifNyuE44oruBmMwSsarXQDaV1PZI7b3ukAc4EHQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10742
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
index 020aa1da33150..98b8cf5eb2ab3 100644
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
@@ -1312,6 +1322,78 @@ wdog4: watchdog@49230000 {
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
2.53.0
