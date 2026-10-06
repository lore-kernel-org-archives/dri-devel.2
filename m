Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C62CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9A410E0D5;
	Tue,  6 Oct 2026 12:23:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QV351Jet";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC7D10E0D5
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:23:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCoxzM5bIg4T2iDoxxu7QV1UWUfmUb1Lz08D7FKo2llElgGAWOTTXeNkB6vo9pGo0x/dBzSbw8o63bkre222/2sGG5A8zXY6SNkAtcYgnJmNZPZlMejtttQ+R4104CFKfisgj2peExF/cx38q7BFGgNofjSPIrP5MKmr2WXRkDukRUoC0FM9EAff7ZFKInZRKrCi7wgZluU1g+RPelcu+nUb1ve+k3d1QivmYy6eyTLCflnGnvQfy3fYSnT+H/XoFlkcD1uh092pm33Vt7TmysXGpY5kiXwItK9tU4ItqmuLbjVNGjlrVUh2WcfX4/o6kzVk/BWgrNxsBVqzOOD5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2cLZOqdvrlt3XeVxFVBtQtt4ldeXIPxeTyOiv5FfAU=;
 b=kb2aDnElLctPHiVduwiMJhQ9wufHssrHQ+pm04Ji5qISZhoSvVGa8KoVkr0HBglfDhCiBxb84jxGdhB5vdd+tmxqiuMveFP9JlJcf872R0dsxtORqo1+VFYtvzy+27GKq392vH+E63rV61FY4d/bfN71JLwoebs524f1Z+2zXDpzW1+/U6Vn7GTskLrEzStXyEcx3KEvwVMcDIimzZzyJiwlYv8+LI//hblQhCUmGcEnXLrCg0gCxoVXMQa1foQKYGfgb/Fm4bExSfD/d/DSKsKtBvcbndGN76qlIVVRtNLHMEfBvhCiUJfg8gEMehRK8HVTtvuNeiT/KCroHC4qDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2cLZOqdvrlt3XeVxFVBtQtt4ldeXIPxeTyOiv5FfAU=;
 b=QV351JetnJ2RBJ5uCRsFPt66c7Huq8wdV5tjVHjfjBJM13PYpk7MmcSL1Pu7I51NqyO5GeO9mDi+wqgzFrnnxTQjOCXBpeKd/54uriXtGOOHGKfPqejAgImtT6IkUYMSwq8ENnqluY73eogvxGxQRWMIDskefjTCdMhWQdwgGr4h7vhQs6jtq6MpTjXBTJtQIXk2vyBjF6k3Rc5/u6TxfNCmSHuh2uNs31YWoz4IrltOM/j+x2o4FjFPwbxu0XHR0l4stilPXG1nbKb2cx2SmoSXEfIzetMVUh/1kzZUe/aPcXvGdLzEBhv0Z7v2+V+vW+cs5KnQnZ5sZqWwDTLQHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU4PR04MB10742.eurprd04.prod.outlook.com
 (2603:10a6:10:58c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:23:31 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 12:23:31 +0000
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
Subject: [PATCH v10 8/9] arm64: dts: imx943-evk: Add display support using
 IT6263
Date: Tue,  6 Oct 2026 12:22:03 +0000
Message-ID: <20261006-dcif-upstreaming-v10-8-bcfb28de0aae@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU4PR04MB10742:EE_
X-MS-Office365-Filtering-Correlation-Id: 998e8674-f571-4094-a6e2-08df23a4a1ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|366016|7416014|376014|18002099003|22082099003|921020|6133799003|10067099003|260925021311599003|260925021911599003|260925022911599003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: D3Np/76mKblap+QfHYfUGvltSwsTI1YO5skypniamukY/v0RB7zS9Qo/KM9Ft7ixlLqaxXw409k58KUIKogVmRXYb8lmHK4OYIaHfJFHIQf/OKyKtsGF+hqgQ7xdXKAbbbcxcJmi4wTkimmRXJFTPDkJn8f4byzfm/3sMEH2/S4f26+/KRglJBp4jiXxjEq0nmBc5lF7bG3Wri/wImCx3DCNdKvZGyOYf0wpZwy87ryCum+kYaT/WEGd0pkpyro4dT2GBE+P42G8Jvv7f225UFEdCs5aMO9ZdhQLPsg6V35a9h2IMmaJehvRI5ph6YGbn5OFwdiKtsPrisOvYh7wCawNi4ITCJnF/ApPWGp0fYdpSheSle4NxFhwCIAESOzpyuCB6kKqiF8JqaqUPab4lNvyyFs74Gp1Nm/3ri5mgQEUxAGny7o+Iz+yOXMogiLAOamN/4YdTY86XIwmTacvdNkgNnLUSfCvQgptUDY6FV0sLE33ZQ+2ca7cWoeUN+48LtGKEGBfXpR6DoMZcogb6PfXliy0JzgggTdSa5izCqpHXy/42VMdsOWQ8vXCxSgCZFknyWSh8D/wyxouhpxz6ToicxeZqDUAFKYvP6AMNOQIhQIoI1w/UIr2Bd03FS32Oe45qh0EWMb7M1eAOlgbzvVDtFlpWghk9IqwHcez3wNQoiBlwW75/1oqvDWutNuc1fJd13AEdR5LQY2jn9kuPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(366016)(7416014)(376014)(18002099003)(22082099003)(921020)(6133799003)(10067099003)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zi9JR3NuT1RqV3ZaQWRrTzU5L1JtbjhHWVEwYnovRjY0c2lHTHlNQm9HSzEv?=
 =?utf-8?B?aFZWa1M2cmpJYjNjazZOL09GVElXVmRhcjY2a29FV2JpYWhUNmxRbzhHOW5V?=
 =?utf-8?B?TUV6b29YQ3BTMjlDemtya0xxNEFNeThNZS9WeGhGS1RkcjVad24xNlVLVFNW?=
 =?utf-8?B?NVRocVpWYzhJTjV6UG5RK2Y0U09mempVTmM2WHBFQVgzRVR5L2o1WlZNZHdR?=
 =?utf-8?B?Vi95SHRIMGluSDNZRDA2NVNKQ1BmaHp6VzBGWnRvMEY0VzI4Uk1xeGx6ZjRM?=
 =?utf-8?B?SHN3UWYvdEZoZy9BOFFnZHAyRVhBN0ZUWURjMVBWSUpPcnhmWmw1N2tsRDFK?=
 =?utf-8?B?WUJHdnFlQi9mMFVpaVhGdGdKcUN5cERSRDhtYmRORDg0WExWa0srckFvMFMx?=
 =?utf-8?B?OUg2ZWh6SHZ3MHoyam04bVpqQmRYdGQvRUhyQmFGM2dNUm01Ri9adEd1ODdR?=
 =?utf-8?B?SS9BQ0NWZHY0Tzh4MUkvK3NXVnJwdEIxZ1hhT1lVcEplN25Xc0NHSkV2V3lN?=
 =?utf-8?B?cG10MXBHT3daUmhIQklYTk1Td1VldFRDd01mOW0zYm1tb0FtNVZFOWJySVlp?=
 =?utf-8?B?SWZ2QXl1Y2tpelRDUkJFRUNYL21GUVJHcDhmRTE2ZjFSSmFBSndVa3ZuVWFX?=
 =?utf-8?B?aDF5b0Y3Wm1ZMGViRGM2dGZDdTRlMUVldjNlNXByQ2VRc0VVUnJrQy8wUWlD?=
 =?utf-8?B?Ukt0N0ZHQWFWNmNtWXRZWUdPS0F5YXY1dkRSU3UwU0RvcWRwQjhsd0x4NUtS?=
 =?utf-8?B?dU5hc1ZxZEdHQjJ0Z0lvZVZWTWxnMDVZaVY3MC8xSGJlWE5aVTlGSEhQVW5V?=
 =?utf-8?B?VTFpUmYxNXh5SHgvbmNIZHRIN1JrRjVvUTk5aEtka0Vhd0J4WmloajVUQnVq?=
 =?utf-8?B?UzY5ZWkyR3ErU1ZTbEtFR0JVUktxQjN2STZMbWNlbWtuUXdxcGwxT0JtVzlx?=
 =?utf-8?B?cmZQSDRqQ2lPUzE1bTdIc2VybUJvVjBINE1PVTdWNjAwWlBBQnEvOXk5U1My?=
 =?utf-8?B?a1NLSmIzSXMzdU51ZCsrNUFKKytnM3FubUxkWGttUFM2TVlyMTZGbGlBd3Yx?=
 =?utf-8?B?WFdlelc0b0IzRXp1VStXdFNKRmcwWUNWTWt2bm4rOFNRWlJBTUtndk1oYVZO?=
 =?utf-8?B?ZHE5bnYzT0szbFgwcFJPY05UK1NnRDN1VUxaTTBISVJzSmNDMVBiSWc3c0pz?=
 =?utf-8?B?bTQ4N3pWcUZuTGZqRjVNWHJtWU5rUjBKMmhPdGJQTHZwV2V0YkYyUFpweUdo?=
 =?utf-8?B?SlhjOUlzNmJ2WW9ORW5iRGhqRUk1T1ZVc2V6b0xTZEJpb1JZQ2ZzZzBkVjBs?=
 =?utf-8?B?Mm55amNLdUdITmUxQUkyTWVGTkJXOFlXV01tb1ZYOTZrUnZjY1VWeUMwMUJT?=
 =?utf-8?B?WTNkbUZkN3M5V2F0U3pwWEk2RnNvalQwZU9PUEEvRDA4NU9GeWdJMVpZenpj?=
 =?utf-8?B?UlRiNG1pRzZGZDJkVlVEMktJbitpOGJwQm5hRzdqWXYxeWpxNDJ4MG0yeWRz?=
 =?utf-8?B?UFVuaHBlcU40bzIwRWlkaTY0QnV6OVpMdTB0TkJRVjg1NzlkUm1EQXRyWjZB?=
 =?utf-8?B?cktXdnpZY3lYUVA3NDFCUjJOYVFWOWJkMlJVMUthQkQ3ekVIVEFjRGZGWFlp?=
 =?utf-8?B?Qlp5Wnc4QWRsYzdPdHo0d2VBem9TMFlOMVZkbUFHWVBHNXVnd0p3bWNrNmJu?=
 =?utf-8?B?MnFYNVRXWkJtZllBcndPWmFzazhodGFKRkQvSzFZdzcxdzFtQ1o1N2d0b1Ba?=
 =?utf-8?B?VS9XZ1MrYk5yVnUvWG1jMktObDN1K28ydUcyblRqYk9zNHozU2xLQU1Ma01W?=
 =?utf-8?B?SlBQS0Fha3VvV3NjbDMzbGlFZWY4N2h0Q1dmeXNsdE0wbmRIOG9RV3VnUVFS?=
 =?utf-8?B?VzRjbExKQ3J2dXppYU5CSnNmeTIwWjlqK3Qyald2Z1A4Q2Mxei9ibUwzSi9s?=
 =?utf-8?B?c29SdDdvWmMyNG1GRTdDNlMyOWJxUjdmYSs4Wit4ek9GdDJrbTdqR3J4aTVq?=
 =?utf-8?B?Wm9nMFg4amRmK2pKZTVwOFd4RlF2VjdLdUZTSHBLME81VFdLYjNmN2tJNWZ5?=
 =?utf-8?B?djJLMlpObCs2Q2lxOUxsR0dYY051cVRBc3lqMFFHWFQ5VE1EN1hBN2R6VmdQ?=
 =?utf-8?B?V3JWNGdXcW1HVHEyTWxtS0psdWJ0Q3pyMlV0TGRRMjhhT1NSbFB4UG9sdk9r?=
 =?utf-8?B?NVV6eXNJdmFJNDhBTGg4QlowWDk5bm1hdkRTVmZpaFBqTG5QOGh5YldqbFZn?=
 =?utf-8?B?MjA3QnY1bkJVWEtaQzdSN1hCUGY0M2RwOXJCVW93TWsyUjNJR1c0Smk5ZC9W?=
 =?utf-8?B?U0h0bGEvMDFGSW0vL3YySU54M1VTMnY4VndiQ1I0ZGFuUGJ6cWdpdUZwbkRj?=
 =?utf-8?Q?OKwjPk3/Z63PtsRU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998e8674-f571-4094-a6e2-08df23a4a1ec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:23:30.9242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQ4lROgUZf/xNXL5ax5anv+RCJCy8anOzzEWUXtuo1/THwDM5Ti18DVA1Kd36Yfd4a7EtSawZ6hp3kzJgXTIEw==
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

The ITE IT6263 based NXP LVDS to HDMI converter can be attached to the
i.MX943 EVK board LVDS port using the mini-SAS connector. Since this is
the default configuration for the EVK, add support for it here.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/imx943-evk.dts | 86 ++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx943-evk.dts b/arch/arm64/boot/dts/freescale/imx943-evk.dts
index 39e819c536cc8..36b1d42a44454 100644
--- a/arch/arm64/boot/dts/freescale/imx943-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx943-evk.dts
@@ -117,6 +117,18 @@ dmic: dmic {
 		#sound-dai-cells = <0>;
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&it6263_out>;
+			};
+		};
+	};
+
 	m2_connector: m2-connector {
 		compatible = "pcie-m2-e-connector";
 		vpcie3v3-supply = <&reg_m2_pwr>;
@@ -148,6 +160,15 @@ m2_e_uart_ep: endpoint@0 {
 		};
 	};
 
+	reg_1p8v_ext: regulator-1p8v-ext {
+		compatible = "regulator-fixed";
+		regulator-name = "+V1.8_EXT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-max-microvolt = <3300000>;
@@ -155,6 +176,15 @@ reg_3p3v: regulator-3p3v {
 		regulator-name = "+V3.3_SW";
 	};
 
+	reg_3p3v_ext: regulator-3p3v-ext {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3_EXT";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	reg_m2_pwr: regulator-m2-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "M.2-power";
@@ -401,6 +431,10 @@ memory@80000000 {
 	};
 };
 
+&dcif {
+	status = "okay";
+};
+
 &enetc1 {
 	clocks = <&scmi_clk IMX94_CLK_MAC4>;
 	clock-names = "ref";
@@ -439,6 +473,21 @@ &flexcan4 {
 	status = "okay";
 };
 
+&ldb {
+	assigned-clocks = <&scmi_clk IMX94_CLK_LDBPLL_VCO>,
+			  <&scmi_clk IMX94_CLK_LDBPLL>;
+	assigned-clock-rates = <4158000000>, <1039500000>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			lvds_out: endpoint {
+				remote-endpoint = <&it6263_in>;
+			};
+		};
+	};
+};
+
 &lpi2c3 {
 	clock-frequency = <400000>;
 	pinctrl-0 = <&pinctrl_lpi2c3>;
@@ -522,6 +571,43 @@ i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			hdmi@4c {
+				compatible = "ite,it6263";
+				reg = <0x4c>;
+				data-mapping = "jeida-24";
+				reset-gpios = <&pcal6416_i2c3_u171 8 GPIO_ACTIVE_LOW>;
+				ivdd-supply = <&reg_1p8v_ext>;
+				ovdd-supply = <&reg_3p3v_ext>;
+				txavcc18-supply = <&reg_1p8v_ext>;
+				txavcc33-supply = <&reg_3p3v_ext>;
+				pvcc1-supply = <&reg_1p8v_ext>;
+				pvcc2-supply = <&reg_1p8v_ext>;
+				avcc-supply = <&reg_3p3v_ext>;
+				anvdd-supply = <&reg_1p8v_ext>;
+				apvdd-supply = <&reg_1p8v_ext>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						it6263_in: endpoint {
+							remote-endpoint = <&lvds_out>;
+						};
+					};
+
+					port@2 {
+						reg = <2>;
+
+						it6263_out: endpoint {
+							remote-endpoint = <&hdmi_connector_in>;
+						};
+					};
+				};
+			};
 		};
 
 		i2c@4 {

-- 
2.53.0
