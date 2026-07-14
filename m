Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AC2C44508
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 844A810ED6E;
	Tue, 14 Jul 2026 13:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AFeRcIRf";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB20A10ED73
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdROQijhPcZMJzZTvOdqNkJ2N3OiHnRnxRVeB9C44Lqv1gOTeNPyV+WWZwe9ZT3KuO64hQtTMGc2H2pfPxDMyB5kJ4KzyZ7hbjT0vA1adcTDTksm9uJlx+5XEcNSlxaFNNdnwOT75q2IOfx1BiyKDp3pQvrCJlFA9eg2dTrofORR4H4aOXvmrOprIZlUPzu+CHMk95HqHzhDWUKMnk2yWlM/CYm2j4XrYAv9e4jMKizhhrCYiivkZiZD74ZJqiFbqdOmlL/bCEhwD25Dfb73RyKklI/gzNivIKX7EyTq1FRGcgmFcdwS5joR35V6MyS5yGApCLa6rNnFivxbFuF6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw8klTFgtTRE5lgAA0wnv6CPrkTp5P6ttjw90V76ugI=;
 b=CnZvM/kvlxg2sOLzsvX9Sf24L86IBiZEvu8RuYkO7nP1nbBtvy+UphE1rGhsRUocinutxgoxXiqnpRJ/OpKCVGwICKWGv5yhHKghVoO1fMgKSHKwFEtak3F5I3qO/jp0qs4kFc9UZ+ZR/pbRHYIDFo58hrcx+yaPvXqBZa6Kso0iqkM1hMRvcNX1jXP40hkV8JZwhaTdvpVq80qa0dfLmkk4pMONxxvCYPfrSYJe8Sdd6DY363VUPsM6MSBWN4UrYsizxRZvIODhlgJZfoQwNfs9X7OL65YOnORLi+IFdOKUwqGaxLYnIzwVRpDJYekhrEA98y5n8Qp43LPWHLbYMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw8klTFgtTRE5lgAA0wnv6CPrkTp5P6ttjw90V76ugI=;
 b=AFeRcIRfgcq7Rh/Qeb5XOONLl2/OGokeytrjbfoyJOr4aS1IY612EI5dyDtbXZUTXVHGhQJjGyOjc31xGU0+iWChV6iFN65fjIAac3DuVDSRKK+gUeO9jrU4YhO2zChNykcvNAL3FndVSHhNNf9VQCGQxjaKeqpL9bvwO0SdPDRjWOoosk1jg3sao0t6D0HxE+kLFdaTi2gp1dORFYddKyQHvQd/s0X82yVOcV6B4bAzV7Uk1koWkC1HGt7aob4Xchx7cSNSEHT2E2nkS+dgz+2rO2iasl73VrA5nHaz2ti11tSow+qj7wmg5wKONn6r/oNj8g8c3kfgvnWK9PCxAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVUPR04MB12193.eurprd04.prod.outlook.com (2603:10a6:150:33e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 13:59:10 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 13:59:10 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 14 Jul 2026 09:58:46 -0400
Subject: [PATCH 4/6] arm64: dts: imx8-ss-dma: Add lcdif support for
 i.MX8QXP and i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-dxl_lcdif-v1-4-6761a8a6592b@nxp.com>
References: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
In-Reply-To: <20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037527; l=3006;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ok3GRcHkMyHpRJwoEjYmCfdL9Fi7mkY1RcMaWKLwW28=;
 b=BokiKBO4T/jdSy3flet3HXxsFIdElHHSoqWY0Rr0wyq+cFQk4iTpfMQZgT83YEpFl6WyU9Xzk
 5Yn/9XOQd2yCYvSaYX8OZglXw4ypYsdAF3I4+F9GhmwfBB7xLFcjQdd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0197.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVUPR04MB12193:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6f5868-fb57-419e-05a9-08dee1b01427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|7416014|1800799024|376014|366016|921020|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GtUWv8DxttUSj/nvQovIVZ1tmxPRVV7QITo0IG1qh1ePDHpx1XLeY11TOQ/xCGQ1xMBZLjTxCQY5hWT84lZ43sKXCZyhXq/6vmZGjGAGUZb/ZSgkvHxJmuvlDOhVACLhg/9Q3PxGODAuXhezmUKRX7um5Cg/PCykGrNsrbp1egKubBzUXWsJD5bwMlWu9yUlGNACn9LnjX/w3+Mcd/qpYPc2SgRTvpepT7jb1BTg8TIZOuAqipVjT9Uo2Uyezl4o2ooZ4dlMh2FfYtqhxq27E+ki4yQW1FAyhE9j1fIELVDRlk99ACQBy5lHyZBXf9qK5jQ4qtuv3J46pZnDlQw7dwBvLi4+Kf7IksRX6Tp7R4Oy7G41Gpzf//cTA8FSAm01Dmd42d1p/CAp/JL5DK2XxKOWG9U83cFws7wtEo6ONrQesjqEJhNxoxY3+FT+6eg+LuQEcyBwagWqyZpn4fm7VgEbGJ5zrmv+uYSxDH4HzZWUQ6gC1KFEpeZUPwPWyZYKB12ieKFnLWbueIcyER3G91mCsOkjXIPt3YMH610qun/V9jJF0VWJWJSLxpmTTKA0Hp7BmVUy05h89galZOPdIPUYZUOjsXBcsjdkrBWGS2P9UooLGhEXv1XqgHFXiH9B7wC/nuYJ/6v8mQmgC/YD6toKli2VclKYhqC6DvdurHZJkkpdVmflUUVfV2w3Hi+ca76ixvyDkbnlGb9qijkLIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWg3MzdEMFJ4dis4T3Fad09pWG5Yc2FDWTNDajVWQlA5Y2IxSHNRMjBOT01K?=
 =?utf-8?B?MGVhT1RQOFhxcGpSOGMrS3lBbHdYcFI5S2RsaVN0V2tSanpONUlGZFp6czQr?=
 =?utf-8?B?MC8zU3NZUEVVSVNNN2FBUlF1OXE2ZFdlQ2lGMzkzRHFzOEFFbmJJUStLSGRT?=
 =?utf-8?B?Um5IbHNjQVRRWlBPNWFQblFUSHB1WUQxZEo1eXBlNnh2YXVaNTFVOXJYVmlq?=
 =?utf-8?B?dC9EN1hNeHhTa0JjdlZZYm9KY3RCWGdyMFRmQUdzSCswd0ZuTXZpNy9SZ0NL?=
 =?utf-8?B?Nk0xTDZiMTFsNUhwb2QyaW9ERGY4dXlnVHpCVlZBUnJ5UVczWENiQmN4a3NI?=
 =?utf-8?B?eTc5UTFHZTFUSW9DWlZsaFpjTDVMeHRrT0ZhYTlKYmpEY1RYWHVEN3plSkk1?=
 =?utf-8?B?RWd1R0x1Y0hWSU1JU0R5WURndS8rZHBMU0d1bU80MkxQc3ozWHBnWi94dzlO?=
 =?utf-8?B?dGFoRGxKcXREcTZrTDF6YnRZMG1sWGNHa2JhSGlJWWdjTjJsbG5pM3ozOWZZ?=
 =?utf-8?B?dEI4WW82KzZNUXF4clZYNkl5aTdxc3NUdllCQ29ydExnRExSRnYzeUxmb0N3?=
 =?utf-8?B?M3MxUFl0K2ErVWpjRG5HOEt3QmMrU0NIbzJjS3l4K2NWUFZacmRhT2tsS3dh?=
 =?utf-8?B?OTN6MGlsRkFvQlF3SWFqQmtKK1VaNms1TGdCQXp5Qy9jZWpreXRGRUxlSlNX?=
 =?utf-8?B?Yks4a1RlbE0wNmhObVA2Mm5GZG1mQjJSRlNTYlhPQk5ld242akRnQmttblF3?=
 =?utf-8?B?cEhlWjY2dzBhWmVGR25ab1ZwVVBoR1BQNnRUN01tQTdpeDNTQnluZnUrOUVX?=
 =?utf-8?B?V1pHNU92M2xMUjFYekRNdHlPbGpjUDNiUFhLUzdaZ2NSbkVibmtKZncxMUZn?=
 =?utf-8?B?RGFhMlBwYW1yWFhQbXo5R2FrVjcxZ213c3RJKzlyVnNLR213eDFiZGxTTXhQ?=
 =?utf-8?B?RUIwdTdDZWs3ZDgvbHl3ampVR3FTdURJSTFDdWNQS2lDZU5iVXduMEZvY05S?=
 =?utf-8?B?eWdXam9JT25TSU5tVjFIVVJMT2p3b0xxZ3dOUFNzNjdZWjYveS9jVDBSWVl0?=
 =?utf-8?B?QWcrYlBkOEMrU0xNOXJWeW1Zc20rWC9pbTAxbnYvdWNlWGl0Yk9pdlhWdFNW?=
 =?utf-8?B?czF3azBlU3BKT0ZtT0E5OVpIU1d0ZTYyODVLdG9Udk52ZVA5RFVkdFA3M0JJ?=
 =?utf-8?B?TDlDUCtpZFFHbEJlcWlRbkgyT3g4citwUFR3R0pYMGcxMGRQWlA4OTljK3Zu?=
 =?utf-8?B?blRnSEpWRHpDYkUyK2ZOVU1TbUhabStkZTJLNmVTaEpCOTlndDlTcjdnNUhW?=
 =?utf-8?B?RlhTSmNDUWlSMXNEUC9Hbk5RWklSQklkeE1ycjNlWXJ1SkRmbUJWaUlGZGpJ?=
 =?utf-8?B?VVN5aXUwa0JXclhMOUFwdG5hRE5iWXFndTU2Ym5KVGJpWCthUzhPcktIRG1o?=
 =?utf-8?B?VTZMRkJYMGxNdE1rM044OFFTNG9SYlY4ZTUxMEozN1NTNGVMM0p1eW9KcE9U?=
 =?utf-8?B?R1R4MU5rMmlicm5QbUxOb1lKRFJ6V0xLNTRtM054OWdSWmZUaW5OTGRIbEJK?=
 =?utf-8?B?RER1N0E5Z2VnZDl1OFBDWVNpNmJsQW5pbzA0Uld0QTRXMVZpZjFHVURWdlZV?=
 =?utf-8?B?MzVKM093LzBSUUVFUlQyVlNsZzNrVXpIeTVyTjNCLzVBY01QNVZaK1RrMUxX?=
 =?utf-8?B?TDJrMWcxcU5xWjF2Z2FGVjVFMlFMaTJFaERtK0xEMjZOZ3FNVDZqVDVIRzNP?=
 =?utf-8?B?Zm5IMmVYZ3oyZnUxVTF4eHFVemFaMDB5OWtUbk14NU9OeHRwR2o0R3EyTVcv?=
 =?utf-8?B?R1ZxR0d4S0p4ZVVsSzBzVmFMZk01N0NVN3lETk1vZ2hiTUhMMndkWUZYbzhk?=
 =?utf-8?B?R3ZwSWVPNmRYVzVwQTZIWnBidWpxbDBBNGMrV3VDalAzUVJOdDc1MWpRR0ZJ?=
 =?utf-8?B?dlp6TGFPRnRuRFJ3M2t3NXJDdU5tNEhrY2hjeVZORk41bmFoRy9GNnhUNjBN?=
 =?utf-8?B?VWtiNlI2c05rSTBqWGN1TVNMVVBtMHExMURuYXpkMGV3SkVOOUVmbC8rZ2Nn?=
 =?utf-8?B?MVdRM0d0ODlmK3ZDL2NJMGZaNDROd29IMm5JcE5yZVovTmt2WFlvb3BpR2t0?=
 =?utf-8?B?T09kT2M5Vm9iV0padWtZT1lVZFlna29jY0NiZ21OcnFaZmdGV2ZjNm9HQlhC?=
 =?utf-8?B?UXlpazhEalJXb2s3MHQ1c0drb0xTZDlkV1c3YlFEY3l0emxsL2xuVUh3bC9O?=
 =?utf-8?B?ckxFMXc3d2xCVHZmUWthOXpWQlRHdlZMMmxDRWJaNWNXeWU1N2RjaTZmTDZw?=
 =?utf-8?B?UU5yNGY1akZpa0d3ZUxDcVY5QWpvYUYwRHdLRE5ka2l0WUVkUUI2YlNKb3d0?=
 =?utf-8?Q?ekyhZfSz8657SDTWo7FWlhr2JEF1uLDIi+oWE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6f5868-fb57-419e-05a9-08dee1b01427
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:59:10.3327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RyoUE+hzoyqofDYQtL6lwtAZ5HMkKpf4kzoILPgafbGytsFfPGcSwiiHNo0AXyPeQW+xmIoG3MGQe8qKY+S2koO62oY3JUW6sYjNVFVR8Tvpz3f6OpNwE9opL+8NIFL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12193
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

From: Frank Li <Frank.Li@nxp.com>

Add lcdif support for i.MX8QXP and i.MX8DXL.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     | 29 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 11 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 4de78f870c05c..87082c3fa9338 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -149,6 +149,24 @@ lpuart3: serial@5a090000 {
 		status = "disabled";
 	};
 
+	adma_lcdif: lcdif@5a180000 {
+		compatible = "fsl,imx8qxp-lcdif", "fsl,imx6sx-lcdif";
+		reg = <0x5a180000 0x10000>;
+		clocks = <&lcd_clk_lpcg IMX_LPCG_CLK_0>,
+			 <&lcd_clk_lpcg IMX_LPCG_CLK_4>,
+			 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>;
+		clock-names = "pix", "axi", "disp_axi";
+		assigned-clocks = <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_PER>,
+				  <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>,
+				  <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>;
+		assigned-clock-parents = <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>,
+					 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_BYPASS>;
+		assigned-clock-rates = <0>, <24000000>, <804000000>;
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd IMX_SC_R_LCD_0>;
+		status = "disabled";
+	};
+
 	adma_pwm: pwm@5a190000 {
 		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
 		reg = <0x5a190000 0x1000>;
@@ -298,6 +316,17 @@ uart3_lpcg: clock-controller@5a490000 {
 		power-domains = <&pd IMX_SC_R_UART_3>;
 	};
 
+	lcd_clk_lpcg: clock-controller@5a580000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a580000 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lcd_clk_lpcg", "lcd_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LCD_0>;
+	};
+
 	adma_pwm_lpcg: clock-controller@5a590000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5a590000 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 7a191195dbd97..febf5f8b54ac4 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -60,6 +60,17 @@ &acm {
 		      "sai3_rx_bclk";
 };
 
+&adma_lcdif {
+	compatible = "fsl,imx8dxl-lcdif", "fsl,imx6sx-lcdif";
+	assigned-clocks = <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_PER>,
+			  <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>,
+			  <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>;
+	assigned-clock-parents = <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>,
+				 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_BYPASS>;
+	assigned-clock-rates = <0>, <24000000>, <711000000>;
+	interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &audio_ipg_clk {
 	clock-frequency = <160000000>;
 };

-- 
2.43.0

