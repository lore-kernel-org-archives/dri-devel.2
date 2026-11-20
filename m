Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF43C606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kw6x10Kf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0A0C1129C7;
	Fri, 20 Nov 2026 12:51:41 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011033.outbound.protection.outlook.com
 [40.107.130.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F6010E8B4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xpq8vbq4A/o701sc5yuuedzDZi84OUFwzm1gwUs3MEdlOZNAh61jOr/pfPp47h5rueGfKxYtYm8x3esKoLZ9tSMaqEcZ5aTbJyVczhx5JmfJhGm7xfqm3J5O/9OBwEEzcnISP85qMVaKxSsWGBaK8TGW8R9Xx8StH3H9o5QvY+N5p3xUepGdl6idUh9L1mNEIbNsz5O4tW+O+eFfbFqVgC20ubvvMXN/an5ueGqjb4K1PfscKT0RZFqCLhjfgLleLd8C+LwAS/g7w6bDBafhDFTFgiy5+N1ssgjxzLtlhhYy5a9dCgMUalPD6vcDnPiWlFP/ArjSS99dTSw/wDyK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2cLZOqdvrlt3XeVxFVBtQtt4ldeXIPxeTyOiv5FfAU=;
 b=f/Z8w4Q1yBhkl54wLAXoWRSRdr0/cdBasQrADV7M61A31gqAQw4ksy/mxLl/G99/RNb+wskcqd6rwF5Zr0SDuYpUqaIRgeRucEYacPKB/dxN09fOO2Yy2oSOcWYDc2u3W0Z1VZyerlnx4NizBtnUwJ3RMrKAN+F9LW8ouVq78k6horDVvGip+NsqBsoOBkGrh7HANO3r/CrLcB9MrC0LMa6158dv9lwEura8LJn7UTyjJ1DBdj82Vsuu2LLtPCwFbxjtd4VDytywaqHhCbPK+or2UTwPRV4dptrMjxVHGYa+oZzfxznc1gwlDf5ZNdbt41W5V+JY8lExhY9/TR7tlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2cLZOqdvrlt3XeVxFVBtQtt4ldeXIPxeTyOiv5FfAU=;
 b=kw6x10KfJg0JPRfX7yk8nAweBfSjqEXMmFHDdmTH3Yu6HkyEZsKvkWPdNO7p3mumJ0GnyXNFvwwqLBtdI0geLaclRrjIEtDUvDAi0FXKcfiwjS5WGoaennf9XDrDUapzJE7O4Jf9722ePvt3AwXwqreCXW5ZBjXcgKXhIDAyHy4MYcQuy7cPt+n367cZrrLPVjjzQOc7YPlNhHmeOEx3k30/LDIB64AIBEaQI7s1k1pDcka7FkyYkUtoGCCmiHKyvVFPldNpGxrZFYI33mEPMtj+/LruwbikQU/vrZbpNB2ME5kaZAOo2l/mfP21s837KAWazp3DWoMJisbnivuQ5w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU4PR04MB12061.eurprd04.prod.outlook.com
 (2603:10a6:10:646::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 12:51:12 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 12:51:12 +0000
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
Subject: [PATCH v13 5/5] arm64: dts: imx943-evk: Add display support using
 IT6263
Date: Fri, 20 Nov 2026 12:50:40 +0000
Message-ID: <20261120-dcif-upstreaming-v13-5-966ac248773f@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::33) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU4PR04MB12061:EE_
X-MS-Office365-Filtering-Correlation-Id: f420d824-104b-42d0-ab70-08df4704f4ad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|6133799003|261009223027099003|56012099006|11063799006|260925021311599003|260925021911599003|260925022911599003|10067099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: wbPxHNIBZ3L/5OUChdqhiwFjCrGSSqM9DNLl4i+SxSYqYx5XhylnUSb2vbTpzreLjQlewON2R6MbBkjTe+zkLJfa07TXMbk5uTKkkJiKDIsNek7WX2Q/IrbVOPFar0FUy/X3O8tG4km6A79EjHrNxbWlaNWED/Evc0j15cEfn7N0fMly9Znt+NIXzAl4sw7lk3uFL6jvGdXBmDhpUvFSGuaK/D8G5b4uBjrlPu7gVutJPERFXe9Fe72iGXf2/DK6R5O73Bhnb6sXy5kSOaJYhnUK5bMKNEeioL1zTPsI7ZOnfM+N0mfW4C7moajuCZ75q6qZFMvIXWDjEA2pjMN0JO46BsLh1/AJR5KmnERthnl7DMgIS/dm4cqw0N48ECFFgTB656lI7HpWMH4PBtiHjW6JMfy/1Pt4DVhhOjSF4xa22W4ivDEyGI5V7uGOLX94b1L2DtISQTi3TklVbv40C2FrkYd/0kR4P9ckZy6UOl8oVV/01j2SO6uZkXmbmpSMwhm8XtRm2uiSONCZl2lDJYIk5ezzERGrhRZSUgcLu9KV4bXwKhd4Nupnn0Tazu3YlCPdrTVpYZ0QqO7r+Y5PcEeuyhCHvOlUxMfEz65QtRvRZkiB80D3jsysBUP7l4/iXQnlq24ofNWBziutujmr58VBCdjK72DKL9pBDE5YhS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnU2MnBOd05nU0c3MGtjUVVEMzNJSCtsQ1lBaHJta3Jta2U3Y0UvL0g1QnFy?=
 =?utf-8?B?a0dQblVpR1FQZHpFd0x5RFkzZDZScHloZUxPZml1eDRjWFllTTNSQzZWM1pj?=
 =?utf-8?B?TFhNZ0FldTVNOUlyUStPc1Zld0FyZGhRK2pjTUV6TWp2M3pvM1NpaXZETDlh?=
 =?utf-8?B?YVRFVThuUkZydUZsZURYdXVWaHZUTTZaeDVKM3V1Rk84NjJIZ1JrMlhDYlRH?=
 =?utf-8?B?UUdwNWxZM0RKWXNzWmdvQzVhaTRaMjhrcWdwQ3ZCRkY3a0VyRW4wSW5md0sy?=
 =?utf-8?B?Q0E2VnR4WDhTRlhPV3hmekp6UGhFVU1MRmFzdlQ3djVSMzh4S05zTWJoV0F5?=
 =?utf-8?B?VmtHTC95djZhYTBsUTFCbDRHT0ZtVzUrakc5US9BR1d4T1Byb3pjbmtJMFVB?=
 =?utf-8?B?bnNDYzh5STFkUVBzRHlWQXhBbklpMWM5eXVla0VCc2U4aHNvMHhSUXB4TjRQ?=
 =?utf-8?B?cUJOQi9WVTJzemgrTHhtbS9GVHovOEVEYU9UMkNSSUhUUllXLzRmL25qNGV1?=
 =?utf-8?B?UmlZaEVBN0xIZHBxTFp6WUQ4Q0U2M0F0bWJaa0Z0ZUdNM2ZSMU5MNmhaOFgv?=
 =?utf-8?B?QUR0eWZNOUlMVWMxN0t3T1hJTEViNGRpMjliT1lIUlZXaWx0bmE1K1FmdWFu?=
 =?utf-8?B?RlhhSTZTTDRzRFc1cmZJd29yRnhuUEkwbUxwVkZxWHpHU2dIUVBZNlkrVVRy?=
 =?utf-8?B?UjltdUtnOVN5QUZKQ01oK25NVTVwMEtocUdiZ0h6TCs4eHNYRkJlaHNWOVRl?=
 =?utf-8?B?RVZNQmRqUHhZZTNFN3YxTmJmR1I4TG9OOEpPODRhMmxPY1dXSnpsNHk2Zkhz?=
 =?utf-8?B?czRGcXZoaGpGZXlnenc5aE5VY1dLZFQ0TUI4MzlZaWg4c2o3ME5MMUJLSDRE?=
 =?utf-8?B?Zk5KdHdIU2gvYklzREFmTHcyTndkNkdmVjFSY21oRFdRWksvOTk5S2wzaWt4?=
 =?utf-8?B?dnJyU3NILzJPQmFVbGFndnIvZ1RXSGtibVBNMkh3M0VFN0s2b1kzNTZRS0hp?=
 =?utf-8?B?VnhyRmxzV21wNkhac1RqcW9LT3Y5Z2JoMzhPOXhlMmVoRzFuOXMvSU5KQ1N1?=
 =?utf-8?B?cldUTVkyQlExeC82VDJBS0t5R1BlKzlJdzRsM09vZTFIQ3hWQ1I1UW01dkR5?=
 =?utf-8?B?Z0M5RmczRlZ1VlNIQ21pUThMR1NkUmI0ZHl4YnZsWU1GcmFZbjVNSVNsY1NO?=
 =?utf-8?B?dmRSRHF5NFpKSEU5d0lpU2ZFNXRudSt3cmFNVEZNUGVwaVpxN1VxMWNOaUkx?=
 =?utf-8?B?RGVMSjRsSVJYd1FTeEVCWFJPOGJuaTdDRDRWeVlueGswOXIxVnFPeUJEbzJa?=
 =?utf-8?B?Z0h2REozQisyQnNmdEswa09nUUhsNk1aUGNMZnlZK25nMTJxZmNHZ1dEaEE2?=
 =?utf-8?B?dHMveStHWXVBOTN0TkNLd3FDbFE4ZER5ZW5qd0Q2UUMrSjZUbkFCeXJZNWU5?=
 =?utf-8?B?WEpCU1NKMDg0K1RPTjRUNXV5RmhCajJMdUw5ZzBrUjZIdE82bWpsdUx5Ukg1?=
 =?utf-8?B?NjFlWnoxNFplamJ5dVQ0T0Uwa2hLb3VvY0U4bWNka3BMT1k5aitxREZ1MFdI?=
 =?utf-8?B?UGVDcnlYZEZsTVdLRVUvZi9LWTFhQXdjUk9ESHZOOEZnR2JpUFFLMWpDYUpv?=
 =?utf-8?B?VXdvaGZ3UUdwais0ajBvWXpTY3N4VkhDaFF6eGVNT0o5cU5VSUJIOWpKdDJO?=
 =?utf-8?B?Y1FiRWxwanA4YThodTFYR282TWttN0x6SVpWYjBUdC9NR2VNU0pYQXg4V2Rn?=
 =?utf-8?B?MFZIenBKTGtiRGlFRjZOYzVXODV6ZkwrTlVySGphV2R5YzdScGlKaFZmbktu?=
 =?utf-8?B?L0g3b09NMDI2SGRIcjYxQmswRWUxRjRMcHN1aWtqY0ZKckYzTGxvbUVzOUhh?=
 =?utf-8?B?cTEwdk9PZDdtQU1pZCtFZS9DY21Zamd0Q3FGY25xUkptdjdpUWsybXVGeW9J?=
 =?utf-8?B?YlVnZThPaFcvU0hCT3NhSm15dnZ5WmxRV0IyakIzNExKTG11bDlyeWpaemVQ?=
 =?utf-8?B?THJrZmt6UU5sSW4xbjYwQmJvcnR6dUZPL2NySDY5bUVaaHJFQ1NZZGhRRmlz?=
 =?utf-8?B?RkcvY2M3LzFlTE9qRUxyQXpjZ3MrcTFNdm1EL3A2Z3YzZ0FMUjZjTSthci9T?=
 =?utf-8?B?b2cvWE9GZWxYckJmbkFta1dyeTJZV3ovTzJjVlRaS1NWaDM4emNNSm9GUjJy?=
 =?utf-8?B?YXlnNkt5SGV2OWNnT3NVSWFrT0NnZDMvdDJVbmVjbXRtV083T29lOXorWDI1?=
 =?utf-8?B?d2liVFlTUzI5WXVaa2djWVE5Mno1OFBsKzArLzcyU2luYnhIZmIxaks2TDJL?=
 =?utf-8?B?WnA4VUlkN3ZyZFJieG50UWdmbE42NDVsOVpMMnNTK2xYeHZCdzB1Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f420d824-104b-42d0-ab70-08df4704f4ad
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:51:12.1529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qZJE7aygVwhpEMIeLynDIbTgb4tUAn2+g0EaEsUDt+wUGe/VX1oCToI6CevJiCOr9q+NyWjDctg4y8hQqo8gQ==
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
