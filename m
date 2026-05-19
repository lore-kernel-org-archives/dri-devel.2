Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE62CCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A6B10ED4C;
	Tue, 19 May 2026 14:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RFofw2PA";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013033.outbound.protection.outlook.com
 [40.107.162.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB68C10ED1F
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqeDIFyc61ft/fOOpkj+MOnVwOdunCOe/YfsDK7oZgiFoa/u2YfR1SEKyZLuLyGqq/I+DLdQj3Y9SnoTEW7q4AtMCeTxwL91+wbA5+6yA2nruZFfE/IXKTKpSVcGL/8S8Dymxnn48jm0GwGy/GC83vpjS+NdcgAFkM/gxcwpBepNHtXMb3ObivV4kMeHiwZoWcsDngqaz6eAKH5DfU81caTvLTDrS99Eiaou6sjUR1doAMo6ikZiYpHnvUF7MqXHmLeRgPhMi+0LJNJ1YWal5MiBjYZuXskaSQOB49k/KH/sBLZnTmew3jY2SAcT/1per+40uZgZ9hGWIvJEuPAKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vK5rmGCgOZlMyDhnZdvRZrqGqxweqQL/9cKA7vaFhok=;
 b=r9ZoRm66iHDL1H69zjJfg+4wQOJYTCyUCUw8Eg7Av2ZoQbIxa/xaELzScR+xcx+BzTnRLXux/JZEYFPEJEmt11WCbE0K5tMrgYeUcMLZkZhYkQTGTu1PEi7EtKm0aAf406tgbFFBjZ6ZmrqAISywZhKvw26Vp6Qc8w/TRrSHcxYOjKs5wxRs09+H+Jz2NZf4iOx/Rze3xlh5gMRqCp0VwS/CNpDoPkDWfnO6tVITcIrH3WkaHtESvcm/88h2xTi5a7xPVPFx+oqWXsdMcBTp3ubl/qqnyloOieykqAo5MNztTezp9+3MdYVTh+kjUn8JtvpKk8m6pI3szT8sk4I/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK5rmGCgOZlMyDhnZdvRZrqGqxweqQL/9cKA7vaFhok=;
 b=RFofw2PACczAjhOBgTLS1zn3ps2guelYnKP78awklChhHDQmSa0Xk8N8KdnHkHHeUQkLFQa5EikoXKhmVm5XR46hGg+5DX9z6k5aqTcQLOS8WsFrUU4uM4tX4hNk8vSNffNmwvVYO8XLlykzSxyBv4KXvRAlXaI5wYjfPaiQGuNXcE2qbgnnUpN+ESrkWw2zO8KVRQWu7JXWvdmPCAQSSEPfY7cvOTbJiYve2rEC2DdB6KnMowtYoK3uWcB6ZK9BnOWKwgsAgxkz/QsbFTY5LhJsxubpYowmdNP3V6sGxAXkkxBBofb0kb9UUaB+7x5ARO+ucVS1g5Uhc+OR7vmPwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by VI1PR04MB10025.eurprd04.prod.outlook.com (2603:10a6:800:1e0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 14:43:30 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 14:43:30 +0000
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
Subject: [PATCH v23 8/8] arm64: dts: imx8mq: tqma8mq-mba8mx: Enable HDMI
 support
Date: Tue, 19 May 2026 14:42:31 +0000
Message-ID: <20260519-dcss-hdmi-upstreaming-v23-8-5615524a9c63@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519-dcss-hdmi-upstreaming-v23-0-5615524a9c63@oss.nxp.com>
References: <20260519-dcss-hdmi-upstreaming-v23-0-5615524a9c63@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::10) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|VI1PR04MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd977a4-df68-4039-dbcd-08deb5b4fe4c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003|11063799006|3023799003;
X-Microsoft-Antispam-Message-Info: hvKuOHVKLrhjA4xt2bbUEffYZ6kNHwto0eJSPDXIE422VoKkAcLdFqKzzsRe4+SqbAshJDeGP15/ltlQ9ZTl7rBMZndoPtR4IJlYOEWfIY8B8i3zzMTd7UScZG1/dhjOW6BqKtsH9+QqY03d2iQscN/7x44T5Y+TZi4HXCNgteg8J7m6f5VYLJgog4F9jC4pzEqcPb2nDbfiN8hMBEvamU42AwC34C2Fnc11yvQHRx2p6FuPzD5d5v0q1wtlcqewRpIQI4QphMRx3rmtae+JZopTzJdanbT4l3eY7BSEhuG0gglPQEGIe2vasNkTApzFp596cdSfMGBh+WMVIMyj+5I7CgAxFJjhkSJvsT7ePYEU310VkBq0jMi7gdQYNNWGpN+wVucNIe3KUPsMSHxT3ZI5KGV8s1eqCkX8UM8zVObUUzesdbFkKs/4eKcLVTLckkiod9HE84K1CwEjf5zSrHOvZ5ejprVeH3Sao0P3njw56QzNVyLA8kgCwl022yQURxFbcEB3RKQYGeDvShViW4HcCJWKPf7e2Ji2j7mNw4emjlW1nW+fug8rCwhIvlv0E+cSyehD+sV6eV100xlknQXZf173vr+8LZIqx5QGTewUmZXalqgMgt3hlfWCYv0cs9gv7rSDZiqZ1qG0P6bbzHhX5/f5pq0G18Y0IYwJD8D1vEW91G3RyGYMA0MJj8kK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0RHV0tuVTBEc1hJNFc4SlRLdzV4NEVWTVAyeW1xSUt6MjUyZU9Ma2tWMkJ6?=
 =?utf-8?B?NnRrYXYydmtuSWwyL1dTc05rQVYvTHIxZFBoeDNRQ2tpNFJVK21PTmM3RDdB?=
 =?utf-8?B?bXFwVWh5REhCTksvU3Z6RHhKYWhtVUx3TFVIQW8yNGhIQks5Q3lZc3E0eUha?=
 =?utf-8?B?NzBud2ZjYW40aGlRMFZrOE5saTdHWStPbFE5N1VvM01oTVB4eWJKdTNNSERI?=
 =?utf-8?B?akFxNjhCTlZQWklQcmU4ajdsaUc4M3dHektUZTdGcFFia1U4M2RjSTNXQUto?=
 =?utf-8?B?ZEcyemtINUxVQ2Y4QXYwalp2UmZXVS9ONkJ2Mm9UYkdZWnJuVUFQek5mTDZE?=
 =?utf-8?B?dW9ZL3M1L3MzUmxJUlk3T0RwdGRrWVdwWTlDK1FVRTkwTDlXb3RDcWw2dUNs?=
 =?utf-8?B?aVlxVHE2djZlTnZUbXp6cmpBdGhmWEQrUStFMVVDZGMzb1lTeXpWVjVJY0Vp?=
 =?utf-8?B?T0RJeWZDWGdUZE9OVzN1Ym5mYjhrWkxWcU1XaWxOcDkza0VSUmxMQ29pRUd4?=
 =?utf-8?B?OXhuMjdXSEhKMi9xZWRhNDNHc21HYWpDWmx1TjN1SXNEMEV0RUFuZTY1dVND?=
 =?utf-8?B?QTVQVHczWWRCQ282eldOL3JMN0dXc3F2U3VsN1B1ZE9Eay9oRDNyOW5jQjFW?=
 =?utf-8?B?K1dWOTd2MXJ5RUZYb3RNNVRBM0dTVDI5QWZ0cDVkMWJNR2hHRWRVT25nL2d5?=
 =?utf-8?B?UndVVkxqWGEvMVFCcXk1QklPeVB0YndlMHU4U1pucFRqNzFTV1NLZGpTdnls?=
 =?utf-8?B?TUc5SkROSEM1Z1p6VkI0MzBkVDBYSkZ3eFdvTlRvSXd3RHBtaDAzSm5pdVdJ?=
 =?utf-8?B?M284ekhLZWc5RTRGeVVmWnRRVGVrdVBFZlAzOFFFVjdmZEdCaU9hVytJbkwr?=
 =?utf-8?B?b2R5VDFwdm5NaWJpZklWUUx3N1F5eEYxcmh5OGVGZnhrZ3g5cUpRdFB3Zmpo?=
 =?utf-8?B?ZVFUYXhJRDFraC8zYTI4U1VnVU1ZbHBrZEFLWkFiV2VWU1I2dmhIMlh6cTZR?=
 =?utf-8?B?QjJ2cDVRUWtldElPYlllNnozSE1IZUxQQkl6TklOYkZOcTBRcm45bDl0RUs4?=
 =?utf-8?B?a3Z5ekR6RmR0SGhlMVRGRHJXTG55QlVxSXVjZFBFSVV1b1ZJMS90amgxNFB2?=
 =?utf-8?B?QmNpMEFjUzhmUnQrU0t5RjNuR2RUalZzL0FDRWg2TlF5QW9jcDJ0QS95SHky?=
 =?utf-8?B?VlU4SUZVL0dQUkZVQXJYL3ZteDhIWHRaOXN3aXBOQjNDNnhzd2psd3cyTUZ3?=
 =?utf-8?B?K3ZoQUErM2t3Unp5RDVhOVpuTXEzamhhUmovV2xPY24xTWxXVkJlR0hPOVBY?=
 =?utf-8?B?M2QwQ25QaldBYjh6RjBVSzJUQlNhdHIza0R5ZmRpVmNjV0UwekJFZDFLSXJ1?=
 =?utf-8?B?S1FhTXRra0tqOGVEdEs3bkFBbk9qNW40a0RkVmdMZGEySDlGQkwvZUJCOWlR?=
 =?utf-8?B?TzBoM0dxbUZNNEtLTGhZelE2NWRIemg3Ni9VV3lXZHBXZGs3aDhLb3VYdmZ6?=
 =?utf-8?B?S2wzVnZGUDVWbURMNDB5dkdBRyswRm9vU0FnR2Yvc0RHT3dwMjg0UkhMTDJJ?=
 =?utf-8?B?R2ZTb1A1QzBvVEgwUlRtMExhdnczMzdKaU9DUXN3a1Z1UDZiWmJ3RHZyYWJY?=
 =?utf-8?B?ck5ISmh5V0d1Q0Vva25tdjdhWWtRcWdlNFE2aUtMeERZdTNjZElYSGdXNVBQ?=
 =?utf-8?B?ck1BaEtKeWNrQWpGd0hqejEzVkhla0l6ZFVRWWFQT2lwR1pHK0dkcFVLdVZU?=
 =?utf-8?B?U0dRZTY5bWc0SDR4RWtEdTVRbzF5cDBDbmNubGZ4VEl0TXE5RmNnSmV4OWha?=
 =?utf-8?B?bTBvYVg0RVVZMjhuSWJBZ1g2WWplRklidnFyNVhtQzhaSmF1S1ZiRHJwSCs0?=
 =?utf-8?B?YmQ4aU55OW5oMWkzaFZFR2ZrNHRzdUZBSG1rN1d0cGlPa2tCRTYxK05BSFcy?=
 =?utf-8?B?a3FyN2tGbEJyUSt3TitVQlNmVmhoQ25LTG56cEh5NG83ZGl0ek84TmsyTmY2?=
 =?utf-8?B?a1dEVlZDQVNqVGlXN2tNZnY4NWpySFZacFhHM09kbTBEcGM1ck1iU1FDckc5?=
 =?utf-8?B?NU90a0NLRG9qOVY1M1RoczFmVWd1ZlVGRGRsaUQvVkZFQng0Yit6QXVmQUYz?=
 =?utf-8?B?aFNPbG53YnpRa0IzclFHS1FDU3dydzdtT2txWGI1OGZVNUxkN3B6c1BFeFhK?=
 =?utf-8?B?eVQvdEQzejF1ZXIvNnZCYUlxQkwybjdCemg2VWQrZlJva01aUEthK29pRm9h?=
 =?utf-8?B?cC8veHg3Z0dqVXFRS2Z2bGtHaUdTT2JnVGZUUlcvSXVDbm9xYXlybXRidjF0?=
 =?utf-8?B?MlU3R2ZTMEdjN3R4U1VhZXpzNXdzdHc5RlB0Y3FvaHJSOVIyMkhqUEpZWjQ5?=
 =?utf-8?Q?IGCkccmIgAfReTbY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd977a4-df68-4039-dbcd-08deb5b4fe4c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:43:30.0349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcUwY3RuIur6hPaZGWIJU9E+6nBaoPXi+4aCDOtn4am6D6Ng2pL/8qXtle81UiiHURgm4FQPDkuE5N31rSteQg==
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

Add HDMI connector and connect it to MHDP output. Enable peripherals
for HDMI output.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 .../boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts   | 28 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/mba8mx.dtsi          |  7 ++++++
 2 files changed, 35 insertions(+)

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
index c24ae953cbc25..a723547dd71d1 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -89,6 +89,13 @@ gpio_delays: gpio-delays {
 		gpio-line-names = "LVDS_BRIDGE_EN_1V8";
 	};
 
+	hdmi_connector: connector {
+		compatible = "hdmi-connector";
+		label = "X11";
+		type = "a";
+		status = "disabled";
+	};
+
 	panel: panel-lvds {
 		/*
 		 * Display is not fixed, so compatible has to be added from

-- 
2.51.0
