Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09222606A331
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=U3nhr47H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C3710F737;
	Tue, 10 Nov 2026 14:28:53 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4954110ED0F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYAxjoHX7mXsparoJeVuSMXoJnIB1S61lHlbNRXYjbj+sa58WZqPS07dG3gUUjy+Hfeg49MdruOIQ4xlRlVHzGctjICWAjKbV3WfSqgD00qhX3im1wlEJ/2l9z39f4lbOl9HVq64SYFR0f3IySuaeIGmU4+C31veFv9icXZxYeSy1P1lQmUHds3OzoQIm8bRArVKfke2neb9EbWN5ElcFMWDJOpxlA4o2e4qVtNhhUpYoYi6gEC9uxuIEI1splNBLTm2cwcOqzlnd9UNmE8OAOPgDQ/59RXuHMPS9YEV+oOELYDxUJ21BB6FHLK589jakAzqT55c5MJdyzHkO2CMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2cLZOqdvrlt3XeVxFVBtQtt4ldeXIPxeTyOiv5FfAU=;
 b=JIkBF5QMowRrXo2ws3rZqM2q/NKSR+HGCgsn6KXRAGSMzgjhDA8wiUNIn21M3uizc/9tRYOgB4LsyOaO6/xYG+VpC2DgSQfxcU1Sgk6l6x+gR5p+pHgGfmiKrs6lpXZkHmywPRMrpeO0uXxUOP+SGK+uESs1jkJlmEqWdir9XBS9vJ397nDtLoaxQVxkSiOzEA5xOsps+U0wu9fjrBsss6I5xGUHL7KLUk9miWGDdiUdAKqqu1+0aP7Pb9JDrX8rJqN65K3TRjdEv2vEBtUrMTORxwapO3cWDegJPNJYtODj7PnLc2w1kfO2pEhkBQ7QKTLbfmX0GYgqKLjDgDtjuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2cLZOqdvrlt3XeVxFVBtQtt4ldeXIPxeTyOiv5FfAU=;
 b=U3nhr47HLiCf6qAI0dpafc8mvXWQNJ6Klz+B8hlGKcxfoypvQYW2qesBrII17ZYYS0dyxelhaYeRh3CRKn/6qGTGKCOqYHAcM2oLKvZV5et2SZBYbp3ICcusCRcDxXOWHtPZN2Yu663QJCq6yNYqgMP5mRYMGzdaNm3zIP4dUQXadzsY5ufKVF4f1vt/z+/B/iff1Rk+6Dn3PIPqlNN74JeYUzTki/tIiXjMB6NuFGbc4TamNOktR4Eg2xDcZmvZMlYE8lkCQFmap1PJhqrBmuQfU7YqaaHdR+8r1BO9lkXo49RoP3hVwLyWCyLOXdvJ8TNH8K+YL2lBiO4jrJTNWg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by VI2PR04MB11196.eurprd04.prod.outlook.com
 (2603:10a6:800:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:28:23 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:28:23 +0000
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
Subject: [PATCH v11 7/7] arm64: dts: imx943-evk: Add display support using
 IT6263
Date: Tue, 10 Nov 2026 14:27:47 +0000
Message-ID: <20261110-dcif-upstreaming-v11-7-9e13c85ae0d8@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
References: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0013.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::18) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|VI2PR04MB11196:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b55d82-1266-4db1-ace8-08df3f36dfd7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|19092799006|260925021911599003|260925021311599003|260925022911599003|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: LXRjxmW/eFYHS1FGH6g9i8NaRO3xR4jf+K6hGdsK8ueB8/eDQuhW0yXYYhitCb1WUqIWTXjCFubXznsfcseYoxGIqQWF3nla92a7prQWBli6+ppGf2O2y8P++Q6rpAS6LIZIj/Et/+Y6kxPomFCZ70pqUoLPdXcALlMlcMs4PF/2pcpPLHQiMnwOOhg32BmuRknPHK2fkAglWGBTxVYVrUYGOiNJrn43xzgBPUavgaeRZtFAtZAumE3puR+ul4qBm9XUfmNkC+3qZQAm/p4a7pbVHbr91GfCFCWbDPS/zFKrjdiJIwv3FnEVx4879vnXBH0ELEkJUGpquxKIqnYx29xYCqNQBEUpODus3qRHN1XSI9Zi/UFWLAoqf2OPe9VgCbTvC1oM6dCJu5dmxAd/Mz78Edd6a+k2abtlxP95ELfF1zl05S/4YFZ59VNoWz8uddQgpcR72FiWiGCxw0iRn/4qsQzHlWUjjMcnySmzLhDVnX4BpmRBpUuo7UUuNHgl3jg++lhRDbqYSMrqoaGgSq96KhFWYR5YqabQe6KK0ubF5FeDyDQO5BhY25t6ddamdVKaOYzVBg4SxYvUvHTlThvNnhPf0ZoXPNiXarSsOUnv7Tj4LHEoOqE3J0+XQrXRr3R++YUumuMQF9PApjPbajY89bcuUWhKNEhugQedNPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(19092799006)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2pRU0VUQ0pCWUNMZWNnV0ZwdTZBM0RTc3dWZndwQ21UQnB5L3VRT01XazlW?=
 =?utf-8?B?NGhPR0JnaUc3QkY1N1RZaURaRGZ2a0lhZVArak54SEZkVHBPeTdhZUZ2VkxY?=
 =?utf-8?B?bjg5UXFGaXJXcDU4VGdXSFZOYWg0bmlvWmR6VTVlWm1haGxZemIyby8zZURh?=
 =?utf-8?B?M2dURUkva21FY3pBT1Z5ZW8vMFpqbHJac3E5RTRWaTJ3cjY4SGROeE9kV01K?=
 =?utf-8?B?eU92cFRVOWpOSmN5RG0zWW9QOU4wdkliSk8xbGN0Nm1Ka01tV0NQNkJLY2lH?=
 =?utf-8?B?NUt6VzNQV0kzQzJmbmozNXJkaXh5ODNudE9RUlVHWi9pRzBNRjUrQVY3RFNL?=
 =?utf-8?B?RVNXUEM1TGdtZmRuSUYvcDgvOER2dFYzc1FldW42VVRvLzBsbm1pcXVvaDc4?=
 =?utf-8?B?UzY2QlFadXUwdno4M0QrNDc5OUJwa3dicExhdVJRVEtYOTRNQ0NKT3ZnZHZW?=
 =?utf-8?B?aFlZUjBBZ0hUU2ZKZVFaeWVNSFNtU1NMdW9qczhFZXp6NngyZkVJTkNiVTdW?=
 =?utf-8?B?bno4T2QvZHRzaDd3endLTDBZVjkwdTl6VGNmTHBYZkN0dWhSRDJlNXcveTd6?=
 =?utf-8?B?dGxqVXBnNFRGWGhYSEJSUG55YmNQQVpNbmRYTlJXd3Y0ZFpJNlNDd3FraVps?=
 =?utf-8?B?cTlhT252U2wvdTBhSFFSY2paOS9HS1BZRzlscU9FMWJxa2pWdi9Vdi9GaFQw?=
 =?utf-8?B?SDNrZW9KblFlYy9pL1FOZmdUNUZ3UDdqMFA5K21TTlBBelg3ckkrNjBxcEFN?=
 =?utf-8?B?WnFXTHVkdlVDTDh3SFdkZVVvSVRFem5WV0RTRlZsSHowcjY5SEtXbVQvMGk5?=
 =?utf-8?B?VFZZbncxWnRGTnh0enUzV2ZuWG1CcU5JeUd1aFN0NUJMNmt0ZlNCb1VuR1dB?=
 =?utf-8?B?TFlSSlQ2QlRNTzRyajBuUVZvZ2t6TUhLL0VydHVzMzliRGozUzJjRy9zdStH?=
 =?utf-8?B?MWxRZW5NaUFUY0xHOWFoY3ZaU3VDelQyTyt3a3QzQmZEcktCZitYTFBrQWRV?=
 =?utf-8?B?QUdBR0ppQU9pYklsTGlCQ2IyR216KzRmVEs5TktwYUxpUTR5aXVqbE5KUDRk?=
 =?utf-8?B?TVRoRUE0M1N5Mjd5NXRSZmpXTFA3Z3A2Z2x4dk1yS3BNYnJWMUIrdHY5TE5F?=
 =?utf-8?B?Mkd2Q1k0RWJwTnFOZEF4TU1mU3c5UHZzeEVOcVAraDN4TVhuYmNKY3NPN1Vj?=
 =?utf-8?B?T3lUSkNyNTRaWjZOSXZuRDdhTTRPczYrUFN3bmxiSmFqQVVONitBVC9HeHdN?=
 =?utf-8?B?REt3MlUyTnJQT042QmhXamREL1BDU2ZCbE50N3YwSHNLSFZBbTVVSG1RcFBk?=
 =?utf-8?B?OUxmelVCNHJkS2tDN0xNT29jZmpJTU8rOVcxb2RoL2l5OFJjY0ZRL0I3cEdo?=
 =?utf-8?B?VWtMT2JnWG5NZk5JTUQ1bDByanBReTR4dkh5Tkd3N0dSL2Q5aUZ3anl3Sjcr?=
 =?utf-8?B?cDFmL1hab3BIYm1BSHB2ZWtLdFMxRWp1M0szMTluSUtPbkEzVGVjSG92OEVM?=
 =?utf-8?B?cjB2aWlXdW9ZczgvUG13UUozRkZuWFV6eGJxU1VqYkxXOUZlUkxjdUtkRlRJ?=
 =?utf-8?B?Wm9LeU8xYlBoWXY4RHZZOENpQ214eDhQMUdhNmtaY2FmREREbFBlWUI2SGtI?=
 =?utf-8?B?MjRKQ2JrdXJadHN0cHpEUURCVkYrWVM2eTI4Z293OVZGSlJ3UjE5SU1NaUh6?=
 =?utf-8?B?Y2JxWVBZMjMvWEdxSnN0aFBWUVpPMlVYclF6NDM5YmtBdlZkTnY2bEFBNGpW?=
 =?utf-8?B?M3hSSktienkvRjB6L01JRXdORjlUQ24wa25TR0gyeFB6ZnNqS0VFZVIvWUVq?=
 =?utf-8?B?R2lUU1owQ3ZNS08yb09LTEZhVE11RjlOS2JlYnRlSW9ycnY1TzNCUmVBOVNR?=
 =?utf-8?B?NjBVL0orQ2t5a2dVemRiK2VoaEVXODNWem9LSjNvV0JLUFROK0pxRDR6RStI?=
 =?utf-8?B?L25HTi96MzkxZHp6RCt2MzhwYzRCSHZHZkhpbmZVZElkREFTYTJ1SHVMTFFX?=
 =?utf-8?B?UHM3aFY3MHJFWDdqbTBjZnRtQmNEcEZ5TS9XVFFTYklwZFVlMWZ4L2JmSTRp?=
 =?utf-8?B?UkpIZXVGNWpiTjFmQkJIUmNpaXZIU3kwTEdIbytDRHdwSU1tb0gvUVdUYS9O?=
 =?utf-8?B?bXJqK1JscHY4djBnb1psbkFOSVpHaFRkU05qNFNPWFNXdi94cW5paWZoVDQ3?=
 =?utf-8?B?OGRmSUZydWUyQ1dQa1FBenpzMVpxeXM5THlsNHZ4dGlsUUFHcVBteTQwQ1VG?=
 =?utf-8?B?QW1zR1B2UjltcVQzV2tCOFdaQncrLy9kNGdIRFBBMERCdUlJVldVVFVacG44?=
 =?utf-8?B?UC9ZQzk5TXJNS0dPWjlOOVcya2Q0R1hSZzFFMjN6WnlxMUllalhsZzZ2TFNt?=
 =?utf-8?Q?lY8m5z3suN611efc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b55d82-1266-4db1-ace8-08df3f36dfd7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:28:22.7624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4cLANZDlx/56Z1WU9wwa+K05WdNVczu84r5d5rvb3BrRuEnMROobEfzLmHk/gEQBGYB9wVwoziNGjjrXEBAcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11196
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
