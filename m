Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8787CD98D9
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0574B10F478;
	Fri, 12 Jun 2026 11:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="M9y7kg0d";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE11910F46F
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHFTJaR/iRy/RRZ1Nm9Vz26k/d20RzyzvpeXwYWAzP4nMA/dsY9vWYX22ApQrYYr1u9slSfEOQ569nUZAhGvJr819iutTa/TjsjiD4VXXOH5nhtKsC7IgkqW0hSaIFAmYp4wCy++akEREaANrOKdxAwmqq38ws9wMpft9o+1tDkuOtk6ZuB8TtIbPIjrsejjIZ2WW+j7I+jmUMNVzFPq6aQV8wEMouteydwaskbnIGKpaXHngrEh3nupe64Mw70MOHCaCY+8zfYEmoVjSOOmXyaAfWV8Mn32sBFaXCdzdOwQtBASKIcgw5Cg9vw5c6aDK5ntFvLRHTzSptgOzNLmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obSXXgOHgQtNi40F6ebpI7qmREJdWM/dy7defPYda08=;
 b=BKuSwGy7PmVPI9RgEBWi5P8dxShFer8oqo+6b8eSbekw7pc3gGEzLUouJ0lHzt3a3V6bKXzaqnTXaCAu/aJW5Ag1/MAfpPhBBqrq2DUT334t9vWYuPB7arW7J8DhePaFIq5radtKEY40Zs/QGLdyPT1eqahk0rRiS9AO2IKwej4HlN3pVMPbSCcmBTiHEdv0GqzTTSQZ3IGkr4MRTCnmY2VFOszcEiAhqTxVjZ7Hw0aN0N0gvcwgibDwSiHp2IJKHr+Sq1DszOTPky7hajc6T7PGjYKE6wiJsUmcAYWzDIovf/2hc4RAtF/tVdjabvRq3HgyENteRY0cUcVYgl2vsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obSXXgOHgQtNi40F6ebpI7qmREJdWM/dy7defPYda08=;
 b=M9y7kg0dQUo5QBmINl0UTRP3rTrKLzCb6EUa4ffESdXi9VVbFTJIIL07wfUCG22RDyItowqptHSOqud/pmI21r4pNp09eEJom2GrU9eU0WYnlYl5RRLdhUKK+C5A9sz0cz0C8zTjktQyGCKJtx9b7tMDfaluhQxt8Qf2DIo27i7ABTL+jhfDzkh+O/hzxX8A/e0+iWwxb5Sahg6O5RORygkE8062SwuAATd5ytsZIqPZgmNomqNqx1rzjTisgvEjWaZvO5Hf5QMTSFKrbgAXwwnF6JYbHY/qA8IQnRftT40n+MEwSh44VpEyfyFS8kv5KydOyDeLuyrJOXnoJRKn4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GV2PR04MB11710.eurprd04.prod.outlook.com
 (2603:10a6:150:2d5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:59:16 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0092.010; Fri, 12 Jun 2026
 11:59:16 +0000
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
Subject: [PATCH v9 8/9] arm64: dts: imx943-evk: Add display support using
 IT6263
Date: Fri, 12 Jun 2026 14:58:39 +0300
Message-Id: <20260612-dcif-upstreaming-v9-8-8d0ff89aa3c5@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
References: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0019.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::10) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GV2PR04MB11710:EE_
X-MS-Office365-Filtering-Correlation-Id: 8493e8d3-3fa6-4654-1cb1-08dec87a06c6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|1800799024|376014|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: lk5e3dshTCPp4UbS9TTQ/HNQANCO/Bo6JQOwMH/lJuDEXo6YE6F1XgQAP6PCaDi+CIP3iLOBtj88EAp9lhe9UCqc8wssEfK8R8LV9H4eASozP9wRWiRxeRPGgok302l5lCoTMnAeFWVLwDj0dDBen0b4a8sKn95c0EKflvuiDTayvPAmTKu15qCtGy/3fJc8LAwAerYEExio39BZNWqhiwEmxWXqOs4OVL83WKwxTjBfk9UqRPD2VpgL94kH30yotVjUPzJUxMFyZggrHoPp3fUeAxAn7C6TiA+I1mSQqQ21Lu5G5/mNIor8Qa1gl8+ddp+JXOlP5GlolLp/tYyWMuWPBn54n1um9IZUhkV3GzzcSRh0Z5c6vWff31+ZI0aET46mzwsw5BVDLSSZ34nEqDKQo3VeXCDAuZrM3hiMthHav2qU2SsLpJoC6HaQFnTKJFIMnHtSjsTReUqMiFY82wk6JdH2SSD0kBiQDemJQwA01afu3AX2YpGyypIUFO9dCLw+wWhSFrSS4ujE1ZuzLA3JJ/+0uem5WUJE510JijpnV+zfJ38xVlAxPUqSl+PS2ytvpySEqcBmopTh7ZOd6ilwnFWrwdmNc0Cl9OLnZ8vINTb+2Is7FWNYUBVxoG22t8VKEN797dx2DTmmscOdfyHHsj/fA8+c+I1Oa6/qzP/3hYX/l3mnMxlsMmQVE8RO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUJqQUt5S0REUEhQWkJhQXJOU2t4TWUrRlRQQjRqTHJ1UUtmUE1ZQkkvSzlQ?=
 =?utf-8?B?dTNwNUVLeEFGN0V4YThQZmp2TGRWMEcvT2JIVHVJTDNPSEtsYm1hZktmMkNj?=
 =?utf-8?B?dEhHRWwrRFZsWXI4S3lKRndHQmpWNCtsV3p2bWFLQkF0UHBVRGdlV2k4OGMx?=
 =?utf-8?B?MnNFSTVlZHV2UGJNeisvdG44R0dnWjRaanB5akhJcWc4TEdoMERJVFQvQmVt?=
 =?utf-8?B?dHA0WVc5RnNhZGtCWUdTVTBNQ20wbThDRUlRYjlmR0FmOTZoK2U5QlFpWFVw?=
 =?utf-8?B?T2ZMMTBISVo1WWx6eW9IWTBXeitKcURNdzNST0lXYW1rdnBzMnZtaTdnakVN?=
 =?utf-8?B?QjlSUVB6ampGRXZpcGkvN3ZCOFJseTNVSnhVNFJSKysxMmVRRFc2cE5pWEhm?=
 =?utf-8?B?ODU1MEZOckhhakZYZmxjWUxCdFVUZXNKNkpoOHYzUzZTblJJMSswWXBRdEl5?=
 =?utf-8?B?Y2VrR0N4YU5KZ01EZlpCa3VEcEZ5WTVqTnVJb2x6Z2IyVzBwVWNYSlRzNDRT?=
 =?utf-8?B?aGhJeHcyRnRWaUNqYmZhdnh3WkxvV3NpRmo0Nk82dE1IS1JxRmR5RXFSSmd3?=
 =?utf-8?B?eGttUUFxR1NNVDhZcGVEYXN1b0lmMzY3K3FjNkxncW8yMTlINElPcVY5YVQv?=
 =?utf-8?B?ancrZGI1YXlGU05jU2xQekpvV0pzNVZ1NlpkbWZSMmhCZGhNejNWTkpzWnRI?=
 =?utf-8?B?akhFZXAyeVY0Rk9iVlFZcTk5djBVbDIrN0MxRlZmR01oSWpZd2R3cWRGRXdM?=
 =?utf-8?B?VDdJZFFUbTI5WEQwNmYyWUJEZWIzQjZnU2JvNUE3K3g3cVhzY2RwVERRVUk0?=
 =?utf-8?B?TFlnbHdPWVFORmpraFV1MzNQQWEzMzdYSElsdWpVN3hqbWV3RWY0cmp5dkxV?=
 =?utf-8?B?UENRQmN4Ty9IK2tGUWkzQWYxZlhxYloyWGhxdXNVcFNJMnBFUlVYaUtNZWVF?=
 =?utf-8?B?MW5jRk1JcEpnc3NqZDFHUytkRDBrVjNRRzJxaUxkOFROS01iT3ZPR201R3E3?=
 =?utf-8?B?RGkxOEJXeGYremFhWGZZaEhTUHRUU2NQT1Z2SXc0KzlGbGU0VExCOVRpcWhJ?=
 =?utf-8?B?YU03N1Y3Z2tqUzhjYVp6TS9Qa2Fzbmxtc25YbDRiamFFQ3RBQWh3TUZieWky?=
 =?utf-8?B?eTl2NWpYT3RHMTA5dVlpVTNNMHBSVURRaHJrWmpKMzdmMFZQcEwyeFRtM1RZ?=
 =?utf-8?B?ekxYVEEzK1pRUmVkSG9wU2xydkRFVHpNY2RHVExPQlJ0bmxRWi9NZUNjeXQ3?=
 =?utf-8?B?SGhvemxPenQ5MFFQTXNzaFJlc1FqZEE4Mk53cm1GbnNyd0M5WG5kUDNtRjhX?=
 =?utf-8?B?QldURU0vOGllYzlhb2YwTWo5eWdwOERVUGJubUxEN2QvaitGRVppYUhuMFVC?=
 =?utf-8?B?SkhUazlrZW41MHdET2FydVJCZzFzOWpwSHRSd2RzS2ZoT2VPbE11Vkc2YTJu?=
 =?utf-8?B?OXZiNDBvbzdCcjNlSU10aXpKMU5hdWVXVmdiSCswMVRONW04bEJhQWZGbjkx?=
 =?utf-8?B?Mk9qSThrWEZxMlA2bzBQQW80cXdzUWFRKzJkbjVzNW8yOEJQWlhVR0h1VmI1?=
 =?utf-8?B?aVUweHQ5R2RjYTdGdW1DTTN1Z2hXeHdtNGcrM3dLOGRSdmh1ZDhZR3o3dXpF?=
 =?utf-8?B?MlJqY2p0OU51aXhNR3N5dGFiWGhoOEFndXVYbjdOdUJ6Snc3dnAyM2x6clY2?=
 =?utf-8?B?bEU3VmdGTFNzKzEzSFdmelFZb3ozRlNIMGxuWkVrcG5SbUhmaERjWFNRMEVt?=
 =?utf-8?B?L1FPNzBBb1BwTE5IWWtSdE9KYjFuZWxWUnpHSzJqSzZpQUNueTIzMDRKNFQv?=
 =?utf-8?B?c0JDNzdTN05QNE9PN05teWltMnlyeFpwejFjZnU3WjREZ0M5cThablkvZnV5?=
 =?utf-8?B?dkIrMzZSMUphZUtLdjdEcHBvTzUxY1BvcnR1Tm5hTitadkJzMTBhRVpYRXhy?=
 =?utf-8?B?cXZsMFpvUko5dTlXT1dBc1VUc3UzUkRlb2FVK3dXOUFhMjRQVVhSSHNyQmdz?=
 =?utf-8?B?ZGZPQTl0NFFwbS9zMkNrNm0vSGFaZHhaU1JZLzFCNFBMMSs1UXhKTXlNRURa?=
 =?utf-8?B?blZrcFNiNUM4WncwRHg1OGF3QUxaenExb2VwVWc3ZkxLeWU1KzR6clJhOWty?=
 =?utf-8?B?OG9MMFVzaGVCa2k5MzZoWFkwaFh6WkkydHBXKzd2SjRVcHFWcGJLNWJvQTVx?=
 =?utf-8?B?Mjgxa2cwdTJuV05UdGNCYU05ZzFTQUtKUEZLalRVY1drQ1JsOHlsbU93SU82?=
 =?utf-8?B?WVkzVmV6Y2NjUVRlb1NCeUlPdmw4NEo5Uk1adHRwbEZmMlJDdU9BZFRnMHQ1?=
 =?utf-8?B?MTlnVnVmNmFSSWdZZVhsc0E4ZngxRVpjVjlJaEFmTi9VRThIeEZRWis1Q0lN?=
 =?utf-8?Q?fNNAep2UeuvQ/fYA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8493e8d3-3fa6-4654-1cb1-08dec87a06c6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:59:16.0002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJT0/NinA6RuaUdfazvXPSfNyY68sy2A8EVrjDbS5Ixtk6MteomPDbqiQ6XAEgwoYFrkjD6VZd2f1P9I863BiQ==
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

The ITE IT6263 based NXP LVDS to HDMI converter can be attached to the
i.MX943 EVK board LVDS port using the mini-SAS connector. Since this is
the default configuration for the EVK, add support for it here.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/imx943-evk.dts | 86 ++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx943-evk.dts b/arch/arm64/boot/dts/freescale/imx943-evk.dts
index 7cfd424689507..41a2a700a86a5 100644
--- a/arch/arm64/boot/dts/freescale/imx943-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx943-evk.dts
@@ -77,6 +77,36 @@ dmic: dmic {
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
+	reg_1v8_ext: regulator-1v8-ext {
+		compatible = "regulator-fixed";
+		regulator-name = "1V8_EXT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3v3_ext: regulator-3v3-ext {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3_EXT";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	reg_m2_pwr: regulator-m2-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "M.2-power";
@@ -210,6 +240,10 @@ memory@80000000 {
 	};
 };
 
+&dcif {
+	status = "okay";
+};
+
 &enetc1 {
 	clocks = <&scmi_clk IMX94_CLK_MAC4>;
 	clock-names = "ref";
@@ -248,6 +282,21 @@ &flexcan4 {
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
@@ -331,6 +380,43 @@ i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			hdmi@4c {
+				compatible = "ite,it6263";
+				reg = <0x4c>;
+				data-mapping = "jeida-24";
+				reset-gpios = <&pcal6416_i2c3_u171 8 GPIO_ACTIVE_LOW>;
+				ivdd-supply = <&reg_1v8_ext>;
+				ovdd-supply = <&reg_3v3_ext>;
+				txavcc18-supply = <&reg_1v8_ext>;
+				txavcc33-supply = <&reg_3v3_ext>;
+				pvcc1-supply = <&reg_1v8_ext>;
+				pvcc2-supply = <&reg_1v8_ext>;
+				avcc-supply = <&reg_3v3_ext>;
+				anvdd-supply = <&reg_1v8_ext>;
+				apvdd-supply = <&reg_1v8_ext>;
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
2.51.0
