Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481B3CD4F5E
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899A510ED3F;
	Tue, 19 May 2026 14:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VKbP3Bns";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013033.outbound.protection.outlook.com
 [40.107.162.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1D510ED1F
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYRPVqetruVnYki/ilxHhYgY/dFHs7RN8dZPeze2Lm1DqyNHe9Dc3DYlA6ogikDcxODWMfJttleKN2KD2OQb9zQ1vdmYMRO81zXZQ1fwL5rLX1Vd6itEnXf4hDJCTrmozkVklX0yTBfz9411LB7ShBT0+IB/DLsf2pltZkIZB1CfuwAw2kqR4ujCk4VwnVuzpj2WKn8FvhnBG4q+16lTQHOPZdt9OQ9BrYYpGPuPkxJlnFPDOZbOaeY9bKmlNk8Ym3dsZf3pe1N9s//6eGkZxIsz/e3TLYvL4Kg05JT8MWEBPMKf5PIC4zaDBPcwiD3t4JMRgvBEb818IkZQ/p5KnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5hlFss+43ucrnI/Dnu1At/7RnnJJ5TxXW2xcLziRjg=;
 b=ubF4hY5iAiIaYPVulgpPzV2yuuMBwyuyKGPp4aOJcUmSPG3WwcT8Rr0TwhYwd2NW1l98RB65M9jwgDfsD+NJUUlMZKRNSxsQ4rH0vS5cX21gKUcrgR7NFobUp+iVnPEc2gKZZmo31ZHc71XJhu51U2yKorDZCJ045KwsNcVp1p4OK2dFNKWtXmD6cDs9QnbzlkGrfM+dSd1i2/lGVYQxpYY/e5HQTjHsp7JfEoa4pqmtU0mFEBEhNOLtTCBTz3ekFBWfVZ8rjfk3rWgVPujNDs8lO2e0ZW7N1/hNC5SuN8zo0guDT7WhKMSdlktDLbsBRP5/ibdY2uJJxZ4TBy7lkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5hlFss+43ucrnI/Dnu1At/7RnnJJ5TxXW2xcLziRjg=;
 b=VKbP3BnsKQNpUlH8H1tSiqlwMpeXTicVUFEmwMdKJWIQkiZGAHm8QSiAKQTOS/bdSmNpHbhu7WLJnfwnJVrXbM5T+1MZ4E7T18n5vIuRp5oEBaqA9aSdVpcMOHxKoPkCh3ZkF1PsiRdydm7kEzYlDx5nxG0HbGRjUdv3kdnd/60BO1dpxdjX1ov91GiNRYI1mPbJ/Ua8n6sGW9hPa5ESi+NQK+yVOKHRv5+9Y8swOSQ1Omr2p7yN/hDGo5jUeJxapfwG50Q+9Gg7DAS3WUewtvBvchvIEtHFcIid0LepVoE9Yc/Oj106riMD/7/cM/r5ONfwILcFW9P8W/+Xmxks/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by VI1PR04MB10025.eurprd04.prod.outlook.com (2603:10a6:800:1e0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 14:43:27 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 14:43:27 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ying Liu <victor.liu@nxp.com>
Subject: [PATCH v23 7/8] arm64: dts: imx8mq: Add DCSS + HDMI/DP display
 pipeline
Date: Tue, 19 May 2026 14:42:30 +0000
Message-ID: <20260519-dcss-hdmi-upstreaming-v23-7-5615524a9c63@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519-dcss-hdmi-upstreaming-v23-0-5615524a9c63@oss.nxp.com>
References: <20260519-dcss-hdmi-upstreaming-v23-0-5615524a9c63@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::14) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|VI1PR04MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad9d533-7f17-464b-b1c5-08deb5b4fcde
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: OUH8prSuPnreWG1YqQokufryVhXnfbFj08NnVqzQrKrK5LH68vI9xjqedfse7YzSmgZAjIR0uRCP3yfDKP1fR1ObbLcv6f/pDg3v+PbrYmWq0Bt69HdyMuRUd9Go76HZ6KKJsKVjcHH6Wxs76TdlYZC/oGlpapkPzJ9K+7NY5lwIrBB7vpVZSGvbJXW/7Gk5iHWLQe6Mkf3wywSCGEIgoFB4NU3eRhItTxNj1E5K1fA5aQCcl2ZvX3hU130CdSV5JyGHThzOlwKZGAy0hv30Gmz4DcnsDVIHzZ6diJOLMnzCrgxDj3TzjjG4+gBDkU9ZHY4aU3DYbaT9AkWRSDyig4BdjhP3L383eODrag9yznDU1U9gCfx7SH80ZLUiADIvOlUSqJgokxuhXexlCrHWw/4HE7kSvVUz9rwx3hDJ7LYHAlajSGD50ijNbq86zo2BqzdUFd3c+AQvx2vi1aE2e7htQ6V8ghJJh0ztjKXIBwWiTLb0Sv8zMncjXpIdjoBBgRTy+E+EQFTL8ON5uhYHz474ktXhjgNBREtea85ApRI6TIvO/7ilbKvhg+vRZ+jN0QUypJqipxftlpTuLa16v99ckj8/LbDzf1CiJjt6nbssj8TiwcKYiy2q7op2KCX/mU0w9JCsLaykt/TsiqXrkkkrU4cw5+uw2rYwsPyo/MiAT/KKwxDMG93TzX9NvsD1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THB6SUdsLzlNNDFIUEZJSTdXaUk5Qk9RNk5lUldVQ1h5dEx6c0piU3BOTmND?=
 =?utf-8?B?Q25mMnlld0U3VkdJUzlIUnY5RlVZRnFQU2lHV0tEOFNOM1BSKzM4S2RtcU5j?=
 =?utf-8?B?ekFteDRJTE13NGVYSGVuVG9vQ29NSEQvL2FGanZNRTRIbjloZXZOeGF3MzFy?=
 =?utf-8?B?bUc0VzZ3dkJaMmdTY3VLUm92Umg2S2VqUlR5b0VDMUI2SFRBTFhMQWhVV1d0?=
 =?utf-8?B?SE12N1JqVlBaYnd6dTJlcFdiWVZtVFVHTTVtZnJ2cnhlY0R0ZG5EUHZ2QlhU?=
 =?utf-8?B?RGlHeWJUR0JvSmtIQ1dzVEU4Y3VlSWRmU1l3VUlJSkRKQlhsaFMzelhlRzRN?=
 =?utf-8?B?ZTRTWHVZOHRuQlQyNytGNXdFM0JZelZWMmFzT1RYSC9aaXZRS3NjOWlrNHpX?=
 =?utf-8?B?L1ZyQnREcklwQnBKZkQxSFpnSExNRjgyOWdUR2dpajNnTUJHNDR2S0tBVnRx?=
 =?utf-8?B?blB5elI2UEJUWERuQ2RubmZhMHdseDlkZDBjMk9GMXp5eXphM1NLOXdnUEFX?=
 =?utf-8?B?VkU2LzBvbm9DOUhGK1pldkVYaFUxTXVNeDFPVkdYdkEvL1hXek1pT0NqTGNa?=
 =?utf-8?B?aTVZZ0ZzK1RCMFdkbEw3R01ZdkRTaDNaQzVJUVpNcytNcGpadCsrMzlpdk50?=
 =?utf-8?B?cVhDclF2b2xnUS81MUVma2hyYUYrcHRtRGRiaitybytEN2Q4Znd3TDJSY3Vs?=
 =?utf-8?B?YUJXS1FtR0xBK3BDaDR5c1Q5b2VNN21BYXdtaWdRTS96QzhOaHJEdmE5MGNm?=
 =?utf-8?B?TkorVCt4aUlRYzVUSGV5MHZsMFFqcWlmZFZNL052Y1BHbTA1N0tVaSszM0px?=
 =?utf-8?B?Smw0dkZBYkFzTEthUEx0dHhqNzd3Z2c5NFBUUC9OeUJTa2JpQXN2cHZyVjNS?=
 =?utf-8?B?M3VobWhhMWFibjZRR2ROTC8yWGFuaW1QN0hsWWswc3RjV2tFRHh1UUxGQ0tm?=
 =?utf-8?B?N2lpQThDaHNkZXJhbzZlQWZVUkJOQWFKMWs5azRsQXVFNU1NVytCK3BCUHRy?=
 =?utf-8?B?MFZpd2srS0ZwczVka1h6d3FlR2VWRWpnQUZqcTNUMFltSmNrUmVrTHorajJa?=
 =?utf-8?B?QmxtWEdIOEFGdmN5TGZkTElmS0R4TWV0NEhpTEk4eXh6dDExOW5KUE5qd1Vy?=
 =?utf-8?B?eUJTdjQvWWRQdy9tNXdaOEdTZ0wvM01uNzB0Q3BlaS9ibmRlSkVNa0QvSkg0?=
 =?utf-8?B?aGpRS1FjWUFDL3ZIbFpSUmgyK1ZKajMySGU0UVlpcWhGOXRXYUs0T1VrdG5t?=
 =?utf-8?B?L3RJSWxWZHZFNlo0UWsza0RjTU5XM1dYcFNYYm5XTEQyMGJNdHlHTTZQamha?=
 =?utf-8?B?U1VlamRPdFFCS1dCb2ZBQm44SUJKM0ViWE5XT1NMNmZUeEFYQ1FwWGd0L2NT?=
 =?utf-8?B?UjdaUU5uZHpFL3o0SHZrRXY4U2MrdVJ4a2RJak0xSXRUY0ZlN3VZYVZYMnRU?=
 =?utf-8?B?V3VRamIwYnpENC9SQzJWNjhWOERZYmExTFRaaE5kNytYTGdadjZSM1VRa1Va?=
 =?utf-8?B?MFpFUGErNHNEOUVVMHhOcE83eVJ3OEhscXJZWXNkSGdGTUQ1K3ZaSTJwMzFB?=
 =?utf-8?B?U0JDSEVyeWdldllReXQrYm9iUTNldVRxWUptWVpzQ3JUd2lJb3lxaTYvUkNi?=
 =?utf-8?B?QytzZmF0RmdQeUpERFBCVXpweStudEx2MDdScG1UMnF1dDNCdnUzRkErenor?=
 =?utf-8?B?UC93ZEZ6NmJNNFlQN1BWZlJJUGJwZkFzNHJqbEgxOHFOY0Jma0ZHVEtpc2pr?=
 =?utf-8?B?eHdGNVY5NFQ1Ynh5SGlKTUxXeXQ1RkxpeXM3eU0rbE1ldUlGZFIwNE9WVDg0?=
 =?utf-8?B?M0VENmtNbHRrZzJOWmdqOVN4Mjd6eG5kaVNRc21DUWZlNFNzNFVPSllGNVpP?=
 =?utf-8?B?NVRoUW5oMXI5dC9yMW5WM2pxRFdXc0owSXlLejZGdG5lUHphdnY5b01VOEUy?=
 =?utf-8?B?c3U0RUFtaysyOWJ0cWZZZGVxZFBEMFg1NDAyVEN5QXhIbm5FK0JkcnF5ekRO?=
 =?utf-8?B?NmxOYS85ZzNISXhPa3JmeHZDdkYzYnJTeFl6SVBRdWE1SjhMWm1qYTFsRS9F?=
 =?utf-8?B?NUtrenZmRG5xd2N2R1U4WThWcTlhSE9wdmR3NUpLUStYS0xYOWw2UkVhK2lI?=
 =?utf-8?B?K0ExeXBxMHdINEpTQUJvek4rbkxaeXFZdXZyREVsVlFFRXdBYzFrVkRITGFR?=
 =?utf-8?B?UGhJSDJQTzJZL0ZKYk9YU2VxcEYwOGFtdFdxY0JPeU16ZVZpTnVYM3N6RzNN?=
 =?utf-8?B?MUpEelpVQk5PbE9MWU1pV2JzMTQwaEpoUVF3SmFBQW9wd291c3FROFJac0tY?=
 =?utf-8?B?dFlqN1JQTWY4aEpyZld1UnA0bUdRRC84R3h6OVZVa1pkeG1kQm43V2JpeitQ?=
 =?utf-8?Q?IWJvl+OyfWu7j5g0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad9d533-7f17-464b-b1c5-08deb5b4fcde
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:43:27.5463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBkNED+b5DPA6UGqeVR4UR1uG53Mgzom1VSIUE9s4Tmu89FhT43S/XoCbaNAhsyVRlgD7MVa/SDBZSoUPNFBOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10025
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

From: Alexander Stein <alexander.stein@ew.tq-group.com>

This adds DCSS + MHDP + MHDP PHY nodes. PHY mode (DP/HDMI) is selected
by the connector type connected to mhdp port@1 endpoint.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 60 +++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 6a25e219832ce..82dc75a787499 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1598,6 +1598,66 @@ aips4: bus@32c00000 { /* AIPS4 */
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
 
+			mhdp: bridge@32c00000 {
+				compatible = "fsl,imx8mq-mhdp8501-hdmi";
+				reg = <0x32c00000 0x100000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "plug_in", "plug_out";
+				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+				phys = <&mhdp_phy>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						mhdp_in: endpoint {
+							remote-endpoint = <&dcss_out>;
+						};
+					};
+				};
+
+				mhdp_phy: phy {
+					compatible = "fsl,imx8mq-hdptx-phy";
+					#phy-cells = <0>;
+					clocks = <&hdmi_phy_27m>, <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
+					clock-names = "ref", "apb";
+				};
+			};
+
+			dcss: display-controller@32e00000 {
+				compatible = "nxp,imx8mq-dcss";
+				reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
+				interrupt-parent = <&irqsteer>;
+				interrupts = <6>, <8>, <9>;
+				interrupt-names = "ctxld", "ctxld_kick", "vblank";
+				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MQ_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MQ_CLK_DISP_RTRM_ROOT>,
+					 <&clk IMX8MQ_VIDEO2_PLL_OUT>,
+					 <&clk IMX8MQ_CLK_DISP_DTRC>;
+				clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
+				assigned-clocks = <&clk IMX8MQ_CLK_DISP_AXI>,
+						  <&clk IMX8MQ_CLK_DISP_RTRM>,
+						  <&clk IMX8MQ_VIDEO2_PLL1_REF_SEL>;
+				assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_SYS1_PLL_800M>,
+							 <&clk IMX8MQ_CLK_27M>;
+				assigned-clock-rates = <800000000>,
+						       <400000000>;
+				status = "disabled";
+
+				port {
+					dcss_out: endpoint {
+						remote-endpoint = <&mhdp_in>;
+					};
+				};
+			};
+
 			irqsteer: interrupt-controller@32e2d000 {
 				compatible = "fsl,imx8m-irqsteer", "fsl,imx-irqsteer";
 				reg = <0x32e2d000 0x1000>;

-- 
2.51.0
