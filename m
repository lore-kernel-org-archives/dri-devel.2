Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DBF606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cTvACD61
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C7110FCFE;
	Thu, 19 Nov 2026 07:49:06 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63D310FDCE
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOfbD6XPsv0cCkYogxjZsOe6gmzeAObyOAnXtVsLEeitB8VuEBIBq/Jwp7fHhoBu7fBYPQfJmVo96CCs/sX3FqsmYf229ArfAHC9JNVsxU2uqmg+4IXNDCcnVwbGYoo3Rk/EdnU8LNulQc3p9UAvkWvhJBXxTXEs1QajVecKYIItQbQhevwyBw6p3CVRtWT9ffn11uUuulXKblVK7du1/uPwad4xb9iTiDXEmK3XBG3pgrRtL7melUMbwTMrYU7b9nan0pLcWidEYOWn+i1OuREPAK9qAuWWHAj1/VOMqz+rnRLTxQjLGkG7IeFJQ/9Dvxe43TuOnLyKgmbrvDUQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUgr7JDjtfbnrZX1gEKKmFNim0P0c/da/aH75q1XKww=;
 b=fcAZZAc1syo3N4Q9cSvtaBUuIpjdJTOjYPqPXpC3ySFR+819o3KLYpoKvBC8I2e0S4dzwqki891Khs57lNBfFzBGId7uMmdlEYWz/LhiZPy9MrL6mHlmkfWZ6Jac9edVPkiKvXPfxklfP0rc+elZC4NHKuzqgAQR76VfgIW89j2xjB0dDXKuo00wnPgI7VUf7ccINgA/tKsKj/0a9I3YXzxg7j4ffx+cbdT+Ry0c1VNCRVDNyRGQyqf6cN2Ft3QvQ2MVFUC23G5V80Aqw4cd9fa4iIiXnVZJVU9pGT2Da43tKw8XRKlb3sjSNOYo7tNdYt33DIC5sFOvh5f82KZWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUgr7JDjtfbnrZX1gEKKmFNim0P0c/da/aH75q1XKww=;
 b=cTvACD619fc9e3W3p8jJ45dqtmsr1jTzHcW1PrkCAhJvG+E96wOF0DM9VG4AbeKOlj5o9kjVtJS4QoqY5BaBm4svhEnYFboG9+wRdlxwqPDg0lgw1opnjIHpig9jJyZ1q72LTCRD3+NxhX7DWvemuOQW5RxcZsecxwu4glt3drdet8Fmgl5vYyrVnW1sBkGnsdjLFTN2kBvrpIw3xtIPaNOPAc6WCDGdRQoXaIV5JD8F4PtC00yvTXtjmYtDojAGxK/AMq9A4GTT3ZzYqJ3StiaiHs/ZqJH7KtfiJynYQhxOgKopc9nPnGRNKgIvyEB+Mom64Q6F8Yf9jfloBODkHw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:22:18 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:22:18 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v12 4/5] arm64: dts: imx94: Add display pipeline nodes
Date: Wed, 18 Nov 2026 15:21:55 +0000
Message-ID: <20261118-dcif-upstreaming-v12-4-29b35e27a1cc@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118-dcif-upstreaming-v12-0-29b35e27a1cc@oss.nxp.com>
References: <20261118-dcif-upstreaming-v12-0-29b35e27a1cc@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::35) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|VI2PR04MB11276:EE_
X-MS-Office365-Filtering-Correlation-Id: 680b3567-3d50-4b50-9cd3-08df4587bb9d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|19092799006|366016|376014|7416014|18002099003|22082099003|261009223027099003|3023799007|11063799006|56012099006|261028144727099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: r38+NZL4gFvAvy1TaPwQ7uRZ68SuUblR6k62JpkLHQ3zYVw3cVKj74PX/U7Ycq3xIqoe39vMnKGSf9kThCbd9YKazkNabajT0uzY/F71Wy2J+mq18UlQMymJl/NKra2M6BV08XRAaozIeCNuQQ6Chlz+ei/gl2J9nYS5WZtdHurxMMdklbzLmpLVFjQTW4m+yykwXahxBtwoDVglivglaRGCGRoDvzhZiDTTDRAXqLEK5gzdVHei0ndQibnaKGYFRRCNg6ckUThpNaSxOi5Uk2yOkMyQnWADV7vz+0AppElgEZFucx47kCty6pWezAPlDBxfQuHIKlSzb6Jd8k/g4MndYKxyG9wIzRacHaRDqF5WTbEutA6ouFGhr0unmeRiga/jfOAs9Npff7qIwU8bNLh3rrjqIm1TqtQFCf9K/tjIW1nbfC0Nvc+7DACwBRptULkfG0dHmCq0XfuNvxm/RfP3U3RxinXwkrfcGWK90oeGS1y0qehYZaG0xyWdw0x6+4I9a7DLeoE+nNlarJorc31LioqWMPF3PuX+ItJpXUQfM/LblT9Ypid3ZZrodG5it79ouR9q9RafCqf6xXWSPEhac5YYOcuhU+d1JF9oYMAHTrnt81uix5JY4RstqaZDxaMKzZtVhq0SaIrbgdXqyJj2A331JHpNvFRF2o8oR2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(19092799006)(366016)(376014)(7416014)(18002099003)(22082099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elF3NW1TS3hPTm5Pd004cmZFZGVxY3hIVjhnUVI2cE01aHBUM2EzOXRpaU9k?=
 =?utf-8?B?dVdvaFNnWnRzVmp3ZTEzQVlUOUdkSGRBeUduYmpiVEwrbWl1NnVwbmlHSjh3?=
 =?utf-8?B?K2hkellvTkJ1QkhpUGhMejVUMVo4Z1kvZzRuTVFGSWFMVEF6UGM2Y1lhdmxL?=
 =?utf-8?B?Q3V6UWhacFhPd28xRFk1dnNpY1Ewby9OWGxRbEUwaHk2SHBtNFRVTHk2NzdN?=
 =?utf-8?B?WERIMzNXU1N1T0drSzkwNENxT2hYOEZ5MHdmaFYwR01peUJ0WENLam1LcVIv?=
 =?utf-8?B?dDJiMGpkZld6ekRFMllTTXdUd3ZjaE42UWc1dytZcW1zbXA5dUpJSnNXalBP?=
 =?utf-8?B?ejljSndYUyt3MEhZSkFEWGE5cmMrQTJzWVRTWkdqTDR4dmxwYjl4SmxIU2Vj?=
 =?utf-8?B?bzIwNVplTEZCc2V3OGNrRjBkT2FsZmxteTlKZ284K1JTNzhtOXczZkozT2pt?=
 =?utf-8?B?dklTbjRxL2JkaDNTNnlGZ2hEOTB5NUlISDA5c2k0aHZsc0pHeVdGVktUYlFu?=
 =?utf-8?B?THJHSXNsNGY4N3dPZU4zeVhDVmlFWnAwU0crTTR6alVKbUlKQldQRVNpM1h6?=
 =?utf-8?B?Ykw5dFFZSnVpYkE0S3pRc1I5TEp3TmR2TUxzb1lJcjZRYUpUTk01cDJvQURP?=
 =?utf-8?B?RHl3KzVNeDYzSndWSms5dkhnZ3dWeHdtcU1SWkk2bS9OemxrNkVCQWVLSGl6?=
 =?utf-8?B?em1QUXRva0pBZ3pZZHBTNGhMci8rbnIvN2lHR0dIbjNGT20raTZxbmpwSTlD?=
 =?utf-8?B?WEpYb284cFNMR3F4T2IvblFTb3pGNUZJZlBIMndqVnQwN1U3eWFPb2ZxQmZL?=
 =?utf-8?B?dTdjVDZvTW4zNjlWSVRQTmtzSGNlNGZJZkwvNWZrNW95SUc3Q0ZJUnYwcDlx?=
 =?utf-8?B?VkVGWTNNbHhEc0dacklZV3REblZxaERqdjNVNk5iU3N6Szc1cWR2ckpyRE8w?=
 =?utf-8?B?eVZiRDNTZE5ERy9XNDNDN01DWi9zQ0VJYU5qeEFsY2NZcy9uSWx5NTRXcy9U?=
 =?utf-8?B?dTlZbDJhVnducGJIUy9JL1JlcUlKRTZwaytrdVJyVFlmU0lVeFZoWG96RXZB?=
 =?utf-8?B?RTRXZjhMcE5vWVlQTWtybEExaVFBdjcrSjZNNlVnc2lwK2krakNoSnJvamNn?=
 =?utf-8?B?dmhKWHNLdWdvWXRDVmRULzFrNVFadVFVNklqbG9uanVBU1lRSkRySGlTQmJ4?=
 =?utf-8?B?MGZjc0w4Zm56eGNVQmt6U3lHTWVVZjRFV252L3VSand5R2E0bHdSTkNFcUdt?=
 =?utf-8?B?eWNDalJYc0NyWnE0NnpzYTQ2QVRTWDcrSHZMMDlTd1ZEcXBmWkM3TUV6dC85?=
 =?utf-8?B?ZGUvRGdla25LRWJOakU2a1czU0FJU1ZiUW1WaWFBa2dwK0pjOUFPT0JjR3Fa?=
 =?utf-8?B?aUFmMWNiSjJoSEFIZ2wwR1RuMGlxd3p6WEpIa3N3amRxWnpTTWZKYU1reU9u?=
 =?utf-8?B?OUhYNEpnb0pxUjVsK2h3dHBCTGk4bWtsbGZ0TUowSUVZSlJaTWsvdG81NkNF?=
 =?utf-8?B?QnBLaExrMTQvVjFNS2VZMGdLbmYzMFhjREowTkNCSjB2N2FPeXF3MkZPSHph?=
 =?utf-8?B?bi9MbFVzWVQxKytwQnJrTGRzNHhKQ0s1REZZcnkzM2o5eHRxTkdWQWd4V3c2?=
 =?utf-8?B?MElxUi9KaVdjOEhYNFBncmVvcHlDTkF0UkhTNnJjNGhDOWdwZXJyc1lTVXUz?=
 =?utf-8?B?R3phRUsyK3R6QkQ1Rm1McnA4K3dsQ1FDSlBJT3A2b3RSTy9DT0swdm9zcWJE?=
 =?utf-8?B?NVRjWEdqazhHVmpyQ2ptb1laZTlmVS9pZXM3bmhvZ1UybFkxTGVXM1ZwVVRB?=
 =?utf-8?B?Vm1QQmtuUHJZcHZzbTU0NTg0NEp1QjJwZUpWTkx5RjhEaEZhUml6Q05odmFU?=
 =?utf-8?B?bFBDUkFWTEdUcG9DMWJyS1ZTVStBdFVaQnkvaEpsckVLcHZZcjFCMGVteEYx?=
 =?utf-8?B?WlM5RFozTU1sNGNqb3U2S2JZdTZRSGxKYVRmRVlGN01WdU9FRHVHaXBaaWVL?=
 =?utf-8?B?ajRLYWZPcXlqS0liQ2kyekRrNTNkMlpSZDl5bDczVFRhL3hIZ2FVcnNkWUk1?=
 =?utf-8?B?WmhVblJiZTVXUlR6SFRZYnBiSzZna0F3M3BpYWt1QmlpeWlEeWU0L3FneXUy?=
 =?utf-8?B?NlpueDlScElmaUhyM2RnU1JwZDl6a2YyQ3dVWWpNb2YvdDc1TFFxdzhuWTkx?=
 =?utf-8?B?d2dFUTd4ZmJXYzJ0YzluWm4vU0hsUXBkMW1jSDUvVFpTUmpkMmdrbXB3VDND?=
 =?utf-8?B?UDVIRUpNQjNBZU42RkRXR2d6d21IZ1o4TjBJZjVPd0RuaFd4dDErUUNpUjlm?=
 =?utf-8?B?bVNIdEIxaHBGeldaY0M5bmxObXpuMFZGdzByYWJWV1BnVXFzcWw3YXc5ZUVL?=
 =?utf-8?Q?4vlAhZrIdZ/zl3wg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680b3567-3d50-4b50-9cd3-08df4587bb9d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:22:18.2438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ANG175NiICoCz2/o5oWra29MK+04vqFQVAbvZMztoNIebV8LHIppO+ErizG9v5qXRqlhO0JDGnmGL3NG5t/dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11276
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 90925d48daad4..7f87f82607abe 100644
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
@@ -1324,6 +1334,78 @@ wdog4: watchdog@49230000 {
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
+			ldb: bridge@4 {
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
