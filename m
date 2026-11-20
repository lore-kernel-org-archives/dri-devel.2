Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8960A261C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rxXXOD2n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA791129C3;
	Fri, 20 Nov 2026 12:51:24 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011033.outbound.protection.outlook.com
 [40.107.130.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30AAA1129C3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1Ujx9GH1E5epvSlpw6/+/CGevw3EHVS/ReYnnGpvL+WlJcHfRY/77WYgiia6R0KqrhxQHgLdOOiiYKD3W0oUvEG+EZ7Dcxpjjo2OV943bJjGhO14CIFGsFjwBAt/bWt4+/JFW0ClWufht2OFk4ax+9t2BBpcEpwrWGALXQQ0NtJBSrnlpYWDJ7kkzpOX1tgEFmD8VMhBPwe1rPF/IufZ+WuczwdwqgKuDlwzATht7G+sdp0AFd6JqOyNAMdspMU/N306bA0t7hoFBpsCuyN/4AX0mHhBLVDp3/4AJ1uBTaLvM9e8ybfxW9xKQ148Sdr/eqTQBVtCEdJV0VKhbj2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUgr7JDjtfbnrZX1gEKKmFNim0P0c/da/aH75q1XKww=;
 b=iT83nfxaH/dNB1QuiGWKDhNu2XI3MlihE1dlu6vAUcBqZoxwj6hVmGvwFXZTFocYJQc/r4TWuV9HEPP1/e/1naIlcT6gr3oUtLakk9iZO1WnK/5U0c+6hmsI/kvRfkuNxTY8iRWN1QmHyPHxsZTbjbWDu1mvvohGedsdgPXqGll+OvHlSkkGFXXfVxHhIAiM0r06RoljGWbXL3u4FcxCuJ1/qcDOgN7euVd6x3iLCegQzjwB9Ej7NOeJiFBMTsyfHuawBCHdSkcoxIqH7ZqCHgzeJDBrLmU6Mbw2neOBpr/uXuNADlOKtahIi9MejzIMRe802E0IS1YxRgXtoNZzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUgr7JDjtfbnrZX1gEKKmFNim0P0c/da/aH75q1XKww=;
 b=rxXXOD2n+KWncHimYmiNnDedrlvZnWYDuCJWw2JEexqebKgW0CYqVuxqO+uFZWMku6ElbwqAQMsO/OCi5CEkKcplKVv0lfCgodwweG/cP8zOoKkkLntRw4RrGTqmOAH0uGqF8nidxYB7XkRbp/D7ZUhXPbhULclwSO2B7BycixO5KLaSqBF3Z0aYNUQn2WF/gXeu042EuDckBLpf0jz+Jgs8ZZlrT1O4w7WYFdextmmRClXlBwPq9W7i3Ob9D8m/Myf7xdpDEbEGVPErc3zY83IUaNGG1e14NHPaAI5nFGaCCUVSnh3fm33gC7V+T182Le0+3As/IiHbUyfPHwxyyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU4PR04MB12061.eurprd04.prod.outlook.com
 (2603:10a6:10:646::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 12:51:10 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 12:51:10 +0000
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
Subject: [PATCH v13 4/5] arm64: dts: imx94: Add display pipeline nodes
Date: Fri, 20 Nov 2026 12:50:39 +0000
Message-ID: <20261120-dcif-upstreaming-v13-4-966ac248773f@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0042.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::22) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU4PR04MB12061:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a6ca04-96ab-43ad-feec-08df4704f378
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|261009223027099003|3023799007|56012099006|11063799006|10067099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: sv7Nb1V+tKiXcBQRiRvM2VLPcprrgNtMNt62YrkvUroAbox9FK2U08Ahl9CxY6LAsKrjSyj9b090/ms/h+OuYuriKet8fBjU0Of+3WhjFE+lzwWWq+VsvT6DejSKFJq7f+9JZ5QnUBK42Fje5bpB29Esp/WRD0VLc+uwVavs6S+X27vVdIBA0U6PPyDqGdffM63t4xBeEXBxiCJpEZaKz89K/4I0yFuG6FSF4xXTTpz8AahG5PWdG1JOkl0P9Ab3NbY0oa0pEUbG4FSvSRFdBPxj3y1J9Khql/NOtY0KQ1wab9pZDY3xf15waRWU80L7GSuQ+2VqV14ba0X0zcQLPfvBk3Q1iShtijviKUqOXlFMCEvgh81dUL17T2UctOYtANwdF/qNTMsVHngTuX9MuB//B7PV+ranYgk0dyvPcSSHWRYJB5FBc/gAbCxAH539/5bGoLHvWPoh7XKDEOXtY+DXxIlTlhHB1zhcmAZO9+tUV6InYCglC/vD+wvBULUKV0ZdKxZu1lxmwBRbsxrtdG0F14pKfJLgqCtfzW0Y8UQwvFbmPafbdtAi+1edx+0xh5sYJecEC7kzXXbPxCocvJQUtgkruUiN/IsRZQExaE2KF9CKIba/lB5dCptmYp8q7zQKWzJuJOkyQ16VW9zjP6+MHeFcbpjikM55BMvDBZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(261009223027099003)(3023799007)(56012099006)(11063799006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFXZlQ0TUdkYXFSSmxROG5pR01jUGpaWTFTY2hrVml4Sk5RZGZrMUlnaEcy?=
 =?utf-8?B?STRxdEFpV1JaajFZSGNnYmNTYzJ0czNITnVPOEJ3UnB5QUdra094WXRBUWt1?=
 =?utf-8?B?OGhlQXFZVzFLNTdnQ2IrN1hRaHFkalpFTFlnSEJTTVJqOVJ6UmoraEZsNm12?=
 =?utf-8?B?MjRGcmNadER2YUtpaXVENGxYdmptM00rOFl1VVhuR3N4eDNvWENiV3VDejdV?=
 =?utf-8?B?TFBUTHpraG5EaDh1RDZnN1g0YWdBQmRrUW5CWTJIZXhLaDdYZEdaUkh1RlY0?=
 =?utf-8?B?L2wvS3JkckRWem9qYVVySktkYWJpM1R3M1htZ1A2NkVTTk5vTk92ZGlSUjZs?=
 =?utf-8?B?TE1ac2ZIT3ZXeTAvZGQxMFdvY3hLU09TSEhBYy9nb1hlQklWM0pvWHhydHZI?=
 =?utf-8?B?eG5tYW5QN3dPN0tPN3JjOXNRNStLYkZsQjJGNk8wdGZuNkZXSU5heHFtQ0ph?=
 =?utf-8?B?WWRUMS80TWlhMHppTHZWRjJhMjVqQXJycE1Wblg0TkhpRkxZNTU1MGo5Rm42?=
 =?utf-8?B?a1R2MGtndG9uYVJhdENxZVNTL1RFalFWclhnMnhWck1GTXo1dndZMTZhbDYx?=
 =?utf-8?B?eTBqdG5hazVNWlcxS1pUQ0FFT2NVVzhQSC9TU0xjeThQUlJlek1rWFhHcCs0?=
 =?utf-8?B?TmliNS9qYnVnbzYvWjF6RHJKMjQvNmdPVDcrbHkrUUlxWEU1UjZzeUc3d3Na?=
 =?utf-8?B?NlBtcUtkT21mNVNLNjVGRGVTWkNUVTlzREJyeU85ZmFCR1hhM2hBN2NYVnNT?=
 =?utf-8?B?VzlvcEJNdjFTU0E0Z0lmUFhQNEgyR3hQMEpWbzZ2cHR3aGVSNDByZmhQeVlz?=
 =?utf-8?B?OHJ0TWx5aEp2akV5dEhrUDlRV0l2U21uOEZBT1c4cm9KSXcvZXhqY2NYU0tE?=
 =?utf-8?B?Q1ZBRWhqY0hPWmQwNHhIK1hyb3IrbUIwMG1HTjd3NmtjNnJoOXFoelFGamU4?=
 =?utf-8?B?ZCs4VWZFb0pFcDNSNU15UlpPTk1NdGkzVjdNdTdTT1RyS2lFWUxTZVZtSUkr?=
 =?utf-8?B?YzcwNTBXOVdNNzJHRVhKVU5wYkcrVXl0aWh5S2pwdzdkQWVDTXpxNmZIQWRW?=
 =?utf-8?B?eXE3MmNMU0VWSU1jWTZLczJ5cXpHay9HbE4zUGxlWTU0QzBKeWkzZCtVNkl1?=
 =?utf-8?B?eC9LRkZpMVpiYS8rbFhVd2Q0RFEvZnJEUWpvQkg1Szl3Q29keURiKzBhd25a?=
 =?utf-8?B?dEw5ODZKWHcvaUtIOGttelM1bGNKWGY1RmQ1dlJJbFdGMVpJTkZRWU4vNFpz?=
 =?utf-8?B?YmVxdmU1eE9KdkNjb09sK083NVluOGkvVFlLM09YSzh4OVlNdUovQjBXcGpp?=
 =?utf-8?B?S1JQTlJEZHBZQ0dRQ0FoTm0zQTd2SnZYM3VGdlZ6V3ZEMU9SWGlxWkhNQWE0?=
 =?utf-8?B?UnFsRi9aaTFsb3IwdisvcWpXRHRIdlE1Qzc1UnBDbXhnWTBhMHBQdThSTzJP?=
 =?utf-8?B?NUt0ejdrNm5OUGhJTzNsMlN6UzJzZzRHWWpqRzJDbG9SRWxFUmg3V0Q0ZDJ1?=
 =?utf-8?B?N0hObGs2K0hRT0VTd0xyc3JybjRDdE1QUlpKQTlzVDVmMWpVTUhOMXJ6R1Rh?=
 =?utf-8?B?SUh6ell4bjVKN0NaVU85WTBNalNQL01zMGZ5UTFBUDY0WTY0c3pKdkcyejJG?=
 =?utf-8?B?bUNYL0JxZjg1cEo0eG8xS2VNb0c3UjlaVWxxN1pkTVl1VE5VS3RwRUo1aFJz?=
 =?utf-8?B?cEJYMzNEQksxclpJUG93aUs0UjJoSlRMUzU1dXJ4STRqUzNuL0M5ODBzZldq?=
 =?utf-8?B?a2FqdjIvT0kyQXkxSnJ6MXh3RmZab29wcHRoYXdrWlZMYjZJK0xWTEZGWEsy?=
 =?utf-8?B?Z1owaFpLV0Y2dHkyQTZyQjU2NnNJdzFvTHh0U09tOTE3UEx1TDRrYTl2a3Qy?=
 =?utf-8?B?YXRuQm53STBOWDdJY04yOGVvQ0wyZUdwYjA1WFJHOTZkU1B1Ti9VYm5sY0Y1?=
 =?utf-8?B?SXdBVkNkOEVzMk1OVVpaVVRmVDdlNFkyYzhsTXBQNjE4NU9ETEEvWDR4eUgz?=
 =?utf-8?B?VmtsdmFlcTZnQ296RzczT0VEN2lXYlBUc1lYSi9qd3ZDZWI2eGhyUUpXTlJw?=
 =?utf-8?B?Z20wZjdwS3VOejc3WXVkbE56R3U2KzRoR2psZVNyaWY1K1p0Z3l3SEkrRFFJ?=
 =?utf-8?B?eTJxQlliTVEwbEs3NDM2NHJ4MXkyYUZpTjRLQ0lTWDFpVmc5ZHoyWkRydnF3?=
 =?utf-8?B?aks0WHJZQVhVbEdld2V6akVSVjVmWllJWE9zMzFhdnNESU53UXJIeW1XQmRX?=
 =?utf-8?B?ZUdicTF2UGhBZWlzNUVVNEp3azZBNW9KZGNpWEZDMlEyZXpNeFRHeVJGVW5N?=
 =?utf-8?B?amR2T3NQM21Fd2ZPclNxUWI2Zk4zWDJzWHRVOVdJaUlSZ2NvYTFOUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a6ca04-96ab-43ad-feec-08df4704f378
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:51:10.1420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhEPikqqZwtl+AZuExcWkwcZDukz8mt61z1ZX0Lkmj51UC2YXZdkur93FI6y7wiSBzFajY15pG8hbSJfW8+eHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12061
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
