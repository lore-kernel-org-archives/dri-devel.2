Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE79FE5202
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AB210F4ED;
	Fri, 24 Apr 2026 11:08:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HSLpwIml";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013070.outbound.protection.outlook.com
 [52.101.83.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE5610F4ED
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqiRw/IifPLAxq9/HAhNmVUKLtaBK/OmwzqVCvfZZiv8PloDiVGcRNSHvQljURLFH/buE1Vd63j6fl20Q+B42xr3py4Q2033/XNyaYhI+QkA7h5Q5+v5j0iEFek5V7ksWnWbnooqDuemeh6H/NWT4OqhCaLwkjj3WB3jl8fsc+Q3pd7W5bqrKg0yiDCNU68/k0BgnF0WdLFfjaC8pRuKfznmIs59fLLxWRAX2ZUN/Eb/g2ZiZDLdLbTbJoOQy/rOyqmVQ1+fqXzW1s2bhj6ovH5kP8CSGC30RuaDBMkYgm0xKKrULOvi+FrvAzhgdukGOonJC6TL4K1dTFhtk7Ceyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U59wKJnT4e3MqG+XXWwpatRqWkGCLspkjjZwAGE6BA=;
 b=yXl+oB3F4EkLbfgXGlK0kIutnZ2z2CxPJhep9947lumzRLCuGo3SBbA1jJdaajocyqSjmcGdP+VEs815/EghmkpOKb0gNDbvcw+/R54tdMdvOpR9R2Rp9Aw+aT41SCTGopv6fH6T9TCvMOA1r0cwOtPxp4mabhh02r13vhYldIUmIzhqBzc9yOeG/pPfc9uG4n9AEjmmU3toNT9mvPfR/4ScUwZB3qqOrWWU8hRPSEa6nv8bqvPbCYy5XcXItLND3XVga6tVmZ4GID2xtyFxMsvrFJ14VfwWZDjO3VdWxBS1nILUJ/xOuiNB4P0JZSLsJeo2u5G54/+wDix9OePeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U59wKJnT4e3MqG+XXWwpatRqWkGCLspkjjZwAGE6BA=;
 b=HSLpwImlAQj6vdSzaPQZkh7mesPon0UU3BpOJUxBKNlWamPEF+4I2FDcB/vBEaV9ThzKQP4DVa2khBevdGjFo1xjnltjIjp27r+YqaNnYuMngHQjaZMBYSm7geSGrSOy2mNcDyygzVbnsCt2mxuQtRf1h5UmBGZxiEtEJscvvzGP5ZEa4n1zE+olKbPrGoPqemUpbOuGQzWGkiw5u4O89q0zJG4GCdx+AdsehDJ7eSb1m3j5daF2DugESeSFwQqBFy5bY0bVwUsI1Jccp7Guu6O4DZlgWURZwzxc5MqIgGKYCdgIxg4fb+1oEyfvYM6UgbRgRTvnoEkaiIF3ttYVWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DBAPR04MB7270.eurprd04.prod.outlook.com (2603:10a6:10:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:08:17 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 11:08:17 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ying Liu <victor.liu@nxp.com>
Subject: [PATCH v22 8/8] arm64: dts: imx8mq: tqma8mq-mba8mx: Enable HDMI
 support
Date: Fri, 24 Apr 2026 11:07:21 +0000
Message-ID: <20260424-dcss-hdmi-upstreaming-v22-8-30a28f89298d@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0004.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::10) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DBAPR04MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: f199eeab-0d4e-4471-0a36-08dea1f1c92c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|19092799006|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: b2T2IiZMQW3zbj3sqbIraYhrwmRap0DKDzOjjgY34DTqHN9ZPwdTmDq7hrsIGy5G8Dum+FtuOAimi3LIE/zSqkEyIHI+BofWrFE+hWUkhWYxSzFPWCYRkXVyJmh6URlQPEA35qXbpZiyfsOS1NV0u6FAZKM8H42dVgK2Jdj01b3l8+4TL15uJjYoG88+vCp7kkQDeSDFqMSVL9rV3H+j85Tn/m0viD9aaOp0t0zJ+ubdF0nLG6/poLkgrr0xDkEjqaOq5m9r6jv3P+YCN3RfEYWcWFNxDAtDlYb8vujb3QYL4TqndNMNzuAIJwX2F6Ug+oUYePZc1ml0OoQ7WgGy6xWOFE6Me01NS6JCo5d53pZLdVZQwdO/QyT/OrWQBQef5+Xcx0KXadfCQbSFzrB1BEOP+8Lc/SRqSE97wFFRaSE+Pu++Zqmk7xbOxKRdctvO1+g0PfXq2uk+9jKwcrjG0AO6uOxYlVU9u5HQfVSvGdgOnBSc05EKVoVjF65deW5f5Gdx4+l+FbaGapkye8B8nK97sz5aV0joqTRG1puV+FIZgXVtcp+Fl7E8Jz2GUnoKPj/4ATiegUj0HRiZ1n51a73dnPxlRLACSt5SfFO1QlXwy/Nd3YNROML4PQwnfQLnLEMyNiZOuKmMNyZ5ppx+bd8hyxsmrLLI0GOkA5i3pEHkEwa2EVr3uVvmMZSvA4bJn7o7dcNozx/UjfmUr8pJZPjsWbOMqOAfIw8ftKK+nD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHE1bjhxcko2L08xeXd2UHdvUlk3QXZtdjZhTEVjeUNOQkd3RUY0SkczWUdn?=
 =?utf-8?B?a2FZVEVURUdIMXJxbmhwSVlvZUJHc2lTS20wdi91Q0c5MjZmMjkwNTU4ZHZQ?=
 =?utf-8?B?VFVGTzYyOWxUaXVnNzhBK3VZU1J6RzNpbTRhSjBHTzZ3R3R0RjJ1ei9HbWNU?=
 =?utf-8?B?YURjVUxMOVZwUDhrREwzbWNWYVZ3SzFaV004bHFPTTlGOTRuWElLSGF5b2t2?=
 =?utf-8?B?V2VTNG5ZZnNKeFRLdU5MeXh5VWpVUHV5dDlrR1FqdWZraDVZbGZCNEtGZlVu?=
 =?utf-8?B?a01jdjI2Rmk2dkd6ai9jYVh5RXo0MEV3WnZDYWRRNGtTLy9xcmgzK0ZrRzVq?=
 =?utf-8?B?aENNNHdDWWVkbUFQVUpJdUN5eS9maTI3ZHY2eWJ6TzNGOCticVhzdjViVGJH?=
 =?utf-8?B?aU5sU3EyQTIveXQ4a2dWU1puVEdjMHVVcnlpQ2VvTEJFQXVtOHg4dnhWejh4?=
 =?utf-8?B?aXZJdURWa3FOaTkzKzVvR05oMXJWWnJyY285R1M2akZBeVNpWE9TbmJkamRH?=
 =?utf-8?B?Qys0Ny85bHBubWc3Qi9uTHlhSE9OMVV4WDRuOTRRbnBad1hYTW1CZ2NBU3pk?=
 =?utf-8?B?RU05alI4NFNWbWh3NXhzVHYwWWprUXkvamh1QjFsZS9mendXait4ejM4OWtD?=
 =?utf-8?B?eGZGSFEwTmNzSDBUeC9oMWtpYnhDN0UvQUsxRGEzTVBiNHlTR1EvUDF4OThw?=
 =?utf-8?B?TGVGWm1OY3hwVU16NzdScVBkRDVWYWpqOUtJVTVUcmpVT1FlczlsWEw5b1Nh?=
 =?utf-8?B?ZEp3Z1l5NlV0eUFzRlg0Z3h4cXdja2ltVGJOOUxOU01RMlYwVUZ6SEpJcE9K?=
 =?utf-8?B?WWdBWi9sRUxGTytEUC92RkJvVjlrcUdmV0JualRLbXViNEg2UVFBQlprZHFp?=
 =?utf-8?B?dEVlWXVFaS9sOUwwZStxNS9IZk1BSi9rZW8wb3ZWaXl5VU5XN3V1dWpZM1RP?=
 =?utf-8?B?Q2dISFlYaVhBQ1pnRytJZmtjTGpuNDZ4ODhzM1M3WVJlMXNsVzRtR0p1QnRH?=
 =?utf-8?B?SjdLNUJWbDVETTkxY29DZFYvdW5pRW5XTjFmVjlrYWRHM1Zaa3VxR1pJeTFK?=
 =?utf-8?B?WWFTNFBvcVYrOGl0ZU83SjBlb2p6K09rMGJuUE5ZNDRlemt3WEYyUmtDeWZ5?=
 =?utf-8?B?YTN6L2pjd1IzYnd5c2JKZkw3dzM5UnRkQTU5ajBNTHJGWFd3ODdpMnJVdzB4?=
 =?utf-8?B?ZmdRUzI1UE8vSnQ5WHVoYlZjSUVvcmZqMFdzbitoL2x6S3BmOE13cG14ZVFm?=
 =?utf-8?B?bVFGTDRuZHVPOTFYRVQranFnRFI1cVVsRXVxZkFOTVF0QVdtSmYwS2pHNDhT?=
 =?utf-8?B?UklEaHJNL0FManZWa1pLb21XbENoQ1EwSDBxZVV3NDJORk93SkdCYXd4TGN2?=
 =?utf-8?B?aHgrV1lmR1gwTlE4NWJoVlRQNlM4SUtpc0NmV3NkUWhrd0xYeGdpNDNDOUl5?=
 =?utf-8?B?cm5sQ216RVhndzdTdHdkV09CbDN1MnVZclRsRThPZzNUZEtGM3JyUHlpL1Mr?=
 =?utf-8?B?V0liYmpxeC9wQ0drRTcrSXp2WGlHaGpqeTFXZFcvbFgydTEwK0N4UGZrYmph?=
 =?utf-8?B?TzZ6THZLaGtzd2x6RFczSzRDUzFqZE4wSnVhbmNCT2k3Y29CSkVhVVRXTEFN?=
 =?utf-8?B?bkNNWC9VRlU0cVhyS2tZb1JTZlE3cVpKS3J6M2FZUnVNRjhxc2dsRWJWU2Ez?=
 =?utf-8?B?WWVKYkd3SzNXQUxOcU9tR3ByVTVaZHg4T0xMd1NRb2NyamlIS3ZGaWVqbHNl?=
 =?utf-8?B?SFo5bWNscUU5V1oxYjNqNHQ2L0JQUkJDWnRpYTNLM1dSbEhqSGo5MW1UODVE?=
 =?utf-8?B?Z0JpcitSeHBadGJtang4QWpxVkF3amF0S1kwSlJZY1FtN2FMcUpVdk9GV3E3?=
 =?utf-8?B?Q01KcnFkOHg3UGFNeUFhVzFldEF5ZGQveTIxYThBSmRDQmhFbkV5QTJDYnRk?=
 =?utf-8?B?SUl6Q1Q2RW5LclhBRUxTcElwQmU3cjZuQjF0cUwwTlFBV0xybHJJaVkyeVdp?=
 =?utf-8?B?c0hOWjN0WWFhQkpJOVBYNXJaZHU4Q2NTaUVGVmtQUmxDMVNkSHZuV04wdmVC?=
 =?utf-8?B?TXJiRkNQanl6eENZSHcwWjhhUU9qNjBpa0c3a3VXVFQzVlczTG9CWU55dmk0?=
 =?utf-8?B?WW4ySFFlSXYwKzVCNm9BendwVzFlWTAyM0VrQUkvQWRyN3hacTdUMWxCTXpz?=
 =?utf-8?B?NWd3THdXWDAvNGlJUnowaDZyZ012dmM4Rmp6alk0enZaM3pFNGtWNE1UaVBN?=
 =?utf-8?B?dm45SjhaVjJyK1ZtTzQvQTFTR3JjV1gxNm1JN0FERWtIWWQyUWg0cUxYaGM2?=
 =?utf-8?B?R1k4UndEelNqb2xSa3pOYUVUeCtPZTViZnRpMVRERzlmUnp1dW5DMjNmYWM5?=
 =?utf-8?Q?yn1QijJ80Bd3DA3g=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f199eeab-0d4e-4471-0a36-08dea1f1c92c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:08:16.9362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFjGZepaOWE+k5m9r8sU0yeZv+5KYYw+kk/BnPOzUXbXFUc+L6plZVpm0tqOztoH6OXsu6rObYG4y/jwe/S8KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7270
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

Add HDMI connector and connect it to MHDP output. Enable peripherals
for HDMI output.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 .../boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts   | 28 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/mba8mx.dtsi          | 12 ++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
index 0165f3a259853..4ea1c790bae46 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
@@ -53,6 +53,10 @@ &btn2 {
 	gpios = <&gpio3 17 GPIO_ACTIVE_LOW>;
 };
 
+&dcss {
+	status = "okay";
+};
+
 &gpio_leds {
 	led3 {
 		label = "led3";
@@ -60,6 +64,16 @@ led3 {
 	};
 };
 
+&hdmi_connector {
+	status = "okay";
+
+	port {
+		hdmi_connector_in: endpoint {
+			remote-endpoint = <&mhdp_out>;
+		};
+	};
+};
+
 &i2c1 {
 	expander2: gpio@25 {
 		compatible = "nxp,pca9555";
@@ -91,6 +105,20 @@ &led2 {
 	gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
 };
 
+&mhdp {
+	status = "okay";
+	ports {
+		port@1 {
+			reg = <1>;
+
+			mhdp_out: endpoint {
+				remote-endpoint = <&hdmi_connector_in>;
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+};
+
 /* PCIe slot on X36 */
 &pcie0 {
 	reset-gpio = <&expander0 14 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
index c24ae953cbc25..0dc591dfbc140 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -89,6 +89,18 @@ gpio_delays: gpio-delays {
 		gpio-line-names = "LVDS_BRIDGE_EN_1V8";
 	};
 
+	hdmi_connector: connector {
+		compatible = "hdmi-connector";
+		label = "X11";
+		type = "a";
+		status = "disabled";
+
+		port {
+			hdmi_connector_in: endpoint {
+			};
+		};
+	};
+
 	panel: panel-lvds {
 		/*
 		 * Display is not fixed, so compatible has to be added from

-- 
2.51.0
