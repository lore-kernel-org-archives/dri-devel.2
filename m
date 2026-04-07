Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCB4FEEF55
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81BB110E438;
	Tue,  7 Apr 2026 14:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QgwzP1Z9";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013056.outbound.protection.outlook.com
 [52.101.83.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1196010E438
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 14:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyOZ5rEWY/ceqCTXvqTeYELkhL5yL5baCZZX6A/a78z4h0rVUIP4lAlIS+UD+X1jT/eH66oDH1tCyKwrTpKUDHrMJrFhy07X8QURGMAEfvj1Nr7DyVR5KQNiJQwXBBXlXhZNuFqoSM1HiWiMaaSlaAZAFfXbXss04z18zsHSvtFONzYAangO1MN+OMHLWAoHrgMjWolhHVi9rCBlknJKCdNcfUP3qB7qKPNgxCHUVvmffcGoupeHQ4n+my43R24/maM0XkClSpTR4U0AVvn7WeySorCAZM7miQ2+9nkReees8pqWCn3Hb4MlMmysT78E5mULmPwc7EsZqd2p5WRKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqOFfUBAbU0XipK0VR6f3N/98VKDGhbbFSgjN5xHC0A=;
 b=CWMp82Erl7JqxzjqhWeYsiQxPaExUfbeBRxptG9uTeM8aECeSXCXHoCAED7hL4ZHHxbEiaJJjL7qtx27FvzCOb9xtGzD+gsSPAOsgjWhr0a+rQMqoERIh22H6tTinNKzb3dARO+0hyTRenwIDVfnX/DHhVV2+b4rChibdKYTP7VqNTy6uzvGl1RmM5js2lNFvteAMbn82CtR9rbf9XGxRv7W4nXQZnQ5XbZ/ArwKyXECqIjfVWesETkDcYJqjEIYdJd6UeNEroB1Fraqrbt+9GZFotItZrHe6XOMBRW0rQZDqofDJYPgFzchXKyV88waY14F3JlSQkc1Smy9gQ5kWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqOFfUBAbU0XipK0VR6f3N/98VKDGhbbFSgjN5xHC0A=;
 b=QgwzP1Z9mBkIp0E8UC4yOWPUA6DrznYMQt/HgvJHzWbEYopfY1wGvRxQ/FyYY39fWlcc2klDENF4vSsB1sS+2vZ2VaL8uh0d2zS/yEIAaUofa1z2WU9x0MVAI+zW6RVjGygcPOTTUrYAGe1ZldmfV9K2E4r2V+sB/KThDidwh1m4CCDdVCzR984lZlR7qQzRc44ptimJbcA781oHuYDGjSyPEHKzHkrdT2RlVw78Lgk0DKnGidaTbh/eyRAoqdBGUR/in4FC1V7sIDBPXWBfeWe9KOo6caDxSI9S2Hi9qoCXxZtHQPDYM4/QXDvwN42hMYBOOAs9zJ51CqMnKy2TIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DB9PR04MB9500.eurprd04.prod.outlook.com (2603:10a6:10:361::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 14:32:34 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 14:32:34 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Ying Liu <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux@ew.tq-group.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v21 8/8] arm64: dts: imx8mq: tqma8mq-mba8mx: Enable HDMI
 support
Date: Tue,  7 Apr 2026 14:31:32 +0000
Message-ID: <20260407-dcss-hdmi-upstreaming-v21-8-4681070ab82f@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260407-dcss-hdmi-upstreaming-v21-0-4681070ab82f@oss.nxp.com>
References: <20260407-dcss-hdmi-upstreaming-v21-0-4681070ab82f@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DB9PR04MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: 024ea392-39a2-450f-9055-08de94b28245
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kIzSCXjJQeAr/m1MGqTf7v3WpOGMKeSWYvmb6CABpc8uKJAefttPIUsviFQe/MFCbdFyid80Vm5OA7QX5jB2/ZqNUzmpreYszwqH+JgQyJrAP36eEnJJwjwfHMAe8DYimJM9K3LIHqh2jUOTvBcNsnPgTVer4JZmqHnGouy8VbcPFOnHg+18u8/asBEHCIoNmphgoVA9QwNZisphxbowwp++MGbIJl4G2bhx4gXXwr5qK8lyHYC9mGBgEH+3cx5+ZP4t2N/QHc8KkDNJ7zRtCytFPfF5yX4mjp12XtJsm9bWWVzHQKj0IS4vtnZ156eBcDEJirprYDfOL528kVAYWFhgA/0nTMU0ul4o6P0+9VbFTBtlFYfnEWqIvodmr0yMF2p7/Qy8eWKch6G76HqgTycOZphf0jgTRK7MMRhIBeghH4Qg5cy3tA3X8RIW2aMj+EhP2Pij84xrMh+C2MeIAqM9vU6mFH+i7v0MPKu7+BaenkBTHYMlKAXI3cGkSmD9v1uvEsFYPIKJ0nnV1gmgbtmfTKg9JI0pYGY2LoaMuf7pShUSw+LwiY392Fj84Nu27zBNYGJ3qVvFr6WF3CSeWp+vgGjQh1i+HBonTmJpSk7PyiJnRum6xQZcBM/YEJustbk4ZuvXtupAtl/Vka2FFd+w2RlZ0JDKSwoTuGdjYjRA/RV2q33Feif2oigqKMZek+4/BJFrBQDS+7bE/89KC22b0D4L6+4LnOe7AdFJd+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzhUU2g2Zmp3U3lTZEZhUkxmY3dqUkJRV1NBeTFTZGw2bE9EcGhieFplSDhh?=
 =?utf-8?B?ZjE5T1FFLzUxdld1RTdsZFpxRWcrcXpVRWFMYkJMSHVaaTZ6Uk5RMXpDUzdY?=
 =?utf-8?B?eEc5emhHYnlwV2diMUJQVTZPU3M2cUdOOHdRWW1YOEpUWUpJK3QvdGRQOVFx?=
 =?utf-8?B?cGo0SUloMmsyeHpLMU5KRjl5WDFKUTBsQlNSNXRIL1hac1R2bFJxSjcxVnlQ?=
 =?utf-8?B?RWk5bFVWeldaNjQvODdwN0pnNnhwcXFCajdRSWJTSFZYTkdOa1Z3U29EY0Nk?=
 =?utf-8?B?c2lCK3EyOXVQQk9RSER6NCt0SndkZUc3K3hIMVM0c1lPS0djRk1xZ3BrNzlI?=
 =?utf-8?B?OE9iL2RYREdtQVhMT201bHNxNlkwTFpNdW8yMVJkVXdFWjNCRVFzVEs5Qmc1?=
 =?utf-8?B?bHIwcUNsK0MzUUpSMXR3WVhMcTlSdHlZN1A2UnZGN0plT0cweXh0U01UQklH?=
 =?utf-8?B?R04xQkgzTDMwTGNPaTNCTG5wSGxVK2pDbjdjaC9hL0FtZE5SS3dyVjRqVlNu?=
 =?utf-8?B?a00wUWhvc1VWZnB2SjFkRytaVzg5MnY5K1NLc1Q3MzJ0WnYyTWlXUFlTbk9E?=
 =?utf-8?B?Y3dUM2svN09JaXhqTis4LzAxdnZ0OWVqbmFOZkFBVWJ0dDNaa2JUbHoybyt3?=
 =?utf-8?B?VXJRNG1TYmd0VDEvbDNsR2lpdzRIRGpWZnRIQjdQS2hCZ0xPU2MzS0xnSWdz?=
 =?utf-8?B?alZIbm1FK2VwRE9UTTJlN0tXZjV3M2laK1UwbncxUWJkaGdoRU0rVDVaeTY3?=
 =?utf-8?B?ZmVHTEp1VHBaNktHQVlIVW5xV1A5MElOWk41SVlvV3d0Qk94UnQ0NnBmZzNr?=
 =?utf-8?B?bnk0U1BlS3VrOUZFTjdjNDFHTStJUFA0OTA2cmdQbXUrZXRLU01KVytaYU04?=
 =?utf-8?B?eENwdlRLTTRJdUdCSEdsVTNMbVUxZnE2MzBOendTL3VJVVBOWjZESUw0OFdh?=
 =?utf-8?B?OU9pejltbWlaRVlZSDFJQ2d2RC9QWjBXZ29yZDZhNXQxVGNrZ0gyUHNBUElT?=
 =?utf-8?B?Y056clZSd2hTd1BEamlLTENqVFVuVUFJWHcrUmxhbVlHK1BTSmxlZStwRTNu?=
 =?utf-8?B?ckg3NmpPa2RsV3pWenJuaStRbzZwU2hlU0FzMEVDZTJGdXNQdzZjNU9CL1FJ?=
 =?utf-8?B?c1d4ZGYrUGtqSVVxQlpDdFNYSC9oVnMvSUVTK2JIYnpoVUxtcWZBejllK0I3?=
 =?utf-8?B?QnMzSTQ2dmpMejg2S3QvbHR4d3pqUWhKdVkyZVdnVlZENkJqS0VhN0NOWDFI?=
 =?utf-8?B?YmE1TXdjZUtwMmxYT1VIaTVZWUYxYXFLb2drTmF2WmtWU1M4bXFWSzNyYnN4?=
 =?utf-8?B?NHlIOGRsanhHZlZRQnR5QktZc0Y3Rmt3Z2hjU0JkMERoZTdZNjY1bkpXeGF1?=
 =?utf-8?B?a2hNWjlGR3FVbEZlcXpNUThpamZhak44OEh3ZlFlSWF1YmJ3QjYxWXhqeEc3?=
 =?utf-8?B?am1lMWpVZTFDWTY5RW1Ba0lhdndRekw3cXNQTWoxeXEvVlVkZ1FBMS8wZDdJ?=
 =?utf-8?B?N0JkT2lXb0U0aXdXMWkxcXpuY3BzMmxRM0hxYk9Vc01KUUx3VUpFM0NoUHMx?=
 =?utf-8?B?VzFjVThLVmRIb000OVpvMmtST3Vpd1NDZVR5MkFtVGdXa2NCeHdGaHB1TVlm?=
 =?utf-8?B?NGFKMFlmVSs0VjFGWFIralFVT2FMakI0SkMyS1NOMmlmbFcrQ0U4azlxTkx6?=
 =?utf-8?B?enl6bTE5S1lVb2F3M1JnemkrdFZVQjZlZXJSTEdYQ3REdXllNGlRa3RhVGVy?=
 =?utf-8?B?YWsvcnUzNGo5ZVhOWGpmOHdYZEptVUs0V1FMTjN6dkNUU3MrdnArTU02cm9h?=
 =?utf-8?B?QjJvNXRzQWhaQjZhTU5WU3c0Ynl0Q2RpMytWbHpwQlpyNTM1UFFVemQyZml5?=
 =?utf-8?B?QmJrbFJtbTAzZDlPaC8xMFAvTzZ0TXFaQnFKU0dTOXBkWVJDMmRBQmpxSzVO?=
 =?utf-8?B?aVNCWWxac1BsbVFRelZkcHJvanNtZ0hEUjBFWWpWbllCbWtUMkQ3NHFmMjc3?=
 =?utf-8?B?OHVYaHlqKy9FSWk1dldJUzA5ZEFIYksybnIyZzFGc1hUM2NGMEdOR3dzVFRE?=
 =?utf-8?B?U3Z2NCsybTVnVzJOeTZnTGo0ckNVdUJjSGlBUmRwNG14dGlaeVBjVEZYMkps?=
 =?utf-8?B?QnFkc05HMFJObC9SdEYvUkdFbFZvbldLMmFuTzhoQzNoR0crbS9lM1hETGVS?=
 =?utf-8?B?MDI4OTRTdy9vVHRMMXhURThRYUFWMm1SNGpLYnpkMk44b1lzeWZDT0NrUzlw?=
 =?utf-8?B?aDQzUVg0aHRyOWtWTDFpZFF4RVBhZVgyalk0dDhlRC8xMDlJalFtcmxvRUFa?=
 =?utf-8?B?dGUrM21TNnFValppNFBWODlnRkhtNTVKQUMyaVh3OEs4VXRZSFpjRXBqUG1F?=
 =?utf-8?Q?RbTE3PZPaJXPL0GU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024ea392-39a2-450f-9055-08de94b28245
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:32:34.5561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vz20m1t9LHrslmuMdkUU20/uqv39x+4Q9atKW233qhB8Aib0+N2pz0SKOgjzDhjT6k7pxiVDVpO8JtfleXmVlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9500
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
 .../boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts   | 27 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/mba8mx.dtsi          | 11 +++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
index 0165f3a259853..4b9521bf014cd 100644
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
@@ -60,6 +64,14 @@ led3 {
 	};
 };
 
+&hdmi_connector {
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
@@ -91,6 +103,21 @@ &led2 {
 	gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
 };
 
+&mhdp {
+	status = "okay";
+	cdns,bridge-type = <1>;
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
index c24ae953cbc25..35155c04c122e 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -89,6 +89,17 @@ gpio_delays: gpio-delays {
 		gpio-line-names = "LVDS_BRIDGE_EN_1V8";
 	};
 
+	hdmi_connector: connector {
+		compatible = "hdmi-connector";
+		label = "X11";
+		type = "a";
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
