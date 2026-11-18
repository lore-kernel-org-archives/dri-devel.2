Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183B1606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YFxbepJ5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2AF610FCAA;
	Thu, 19 Nov 2026 07:48:47 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011027.outbound.protection.outlook.com
 [40.107.130.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984A510E807
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTmMCJVFoJTa/d1/SmHOAQmHiIHTe4A4UsyJDD8i/E2r0Xak5J/wYfwhaJIOtTPGq9QWSdZumDsrQlxxfneYoFRbSHlUqspA0TlQUtSDZ9kESwQreXW6Ftrk7jeEnq6nEKZGggcZCgRkmY0rG8GSWEp9p/M7u3qAR+mclsPOyccfgC0rztYH8FuMZLmgVB2FVTpLK5zygQyx5mj9QNsITbuQB7hfsNIrLm3esebQ5Jz9WClBuMOWoTjPBxpa16XJqTSX5t8+65uB+zDmJeIRySPbDWH+JDKjW/oL3lcWx8VijONdCvYqYPbxnMhVfTHyzoRQvutfzkzlXJPquAgm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2cLZOqdvrlt3XeVxFVBtQtt4ldeXIPxeTyOiv5FfAU=;
 b=gwcxI9h5a7ZDSlH0ttnqoOVJOxMHc4KLkp/wdTBQGAsM6UMgfk+uMd49yvexZNaSb142AniJ6+arW6VKe6F8cLFHu3tK89e9j3LlCjpmV2DPjqdUG+FF7/MFkhdOichfsUgoaaV/N4Dye7yhsaCq+6s77hANAfIqvmYv+d6YcJluS5tLVFnxFDCSVOZ+thTvchiShAJJ2Taxlwn/Hkiaj7iw5jl2EwF0de0eDtjNQMZ4+9VT9jc3qaUtfhtXNxNxybZS010WOIt0/+uBOIfhC8c6OTyJuXpREQSV/sPRdMxM0pazmhhcZvi1Mtp//YjAhZM5Lo+KY4f5Cu1mP9iwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2cLZOqdvrlt3XeVxFVBtQtt4ldeXIPxeTyOiv5FfAU=;
 b=YFxbepJ5/f8iQdxbviwa49vBaftcFopcbW8hzjInqo0DahlAhJzwpOne2DSEo2md12+C6o6O+MtCrmZYPXuFDeKEjw3AH2WIqi8V99KTxu5ovmcE3G35eMU07Y+Y9AqQQeQmXjUO6yw5wm6qvJ+gBXAokYPJYAQnDJOOt0kEsTlx62VajjchayrEGLLDnCT+8h1JOQ/YuEt3uLQqXFUuToWdqT6mtN7/j4cz/mt1Xq87fJVIiUuWm1b1yg5WNZTx0JEZG7IPsQm3yZkpSVUfCOz4sJkHR7Cg8nZ2MM5oLeomZwoGUXQ2f9znoGQbmU4IbkSz7E7FSnqNJ+Yk+Op4Uw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AM0PR04MB6977.eurprd04.prod.outlook.com
 (2603:10a6:208:189::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 15:22:20 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:22:20 +0000
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
Subject: [PATCH v12 5/5] arm64: dts: imx943-evk: Add display support using
 IT6263
Date: Wed, 18 Nov 2026 15:21:56 +0000
Message-ID: <20261118-dcif-upstreaming-v12-5-29b35e27a1cc@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118-dcif-upstreaming-v12-0-29b35e27a1cc@oss.nxp.com>
References: <20261118-dcif-upstreaming-v12-0-29b35e27a1cc@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0045.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::17) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AM0PR04MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7a0a44-8a45-401c-a7e2-08df4587bcff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|11063799006|261026140227099003|260925022911599003|260925021911599003|260925021311599003|56012099006|10067099003|261021121427099003|261028144727099003|261022105027099003|261022075727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: UXW2gyXsSksxYUssKSmKq9MQZk0iBfVmNmzoUgIMu1VnlMmHPkhMo8SwBXTbgMfeTZsBjYuX0Njr9ABjFSd6bur4xLnq4KIr8x4ORYNU1y/nsN2HY1/F1fUHpGYwpVoTXKi+HgQE/zrtjuNVbdVmukB3pyHbyejjrO0aPS/9GD8vdw/TaI5Jy9cZiiG5jxd5v/SaVoBlK5ArKhNTOs0HybbFltot4fNQIJcE2C6xZl7x9DfysEWQVQLCtJQFBz5erZaJYR4yQ4YzlMcHaxP6MRfLzaavr8bAWLv7aVg8E9OcPW7yDoF4P4NaJp9Cnupe8rc/H/A7h9U39TYX1jJ7bOu4sZR5SHseug4pQG3+CHHkK0xzqk4fr5RKKTHukZpzWGgzECSDbRTnEUex8wRHLikgsfpmvaK2Oaj/KKap73UOOul6DHyln4CaguvIUgn/ZJ6N+avCNvqGBUqe+QIQrfSxcTPLYDdRs8Ay05kBsl6yVEC+ZWW6xlINdA+mZ+iaicdz0pT/WkilnwPPM5XF2E4rwka/2cJydBr6cb9xmU7+zqGc5FehPx278XH4E4G6bouRYM2SikwpobBiC23WzMY5FOuo8JeKcrTVSHQtWpFU0xhzVdafRF9vvXtFh9xh2gEFmigsA/+QGAhd8V/YEjdyJCXKkQ+O1yUnY96jn1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(261026140227099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(10067099003)(261021121427099003)(261028144727099003)(261022105027099003)(261022075727099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THVKWmlYc2hYY3hQbWNUWkpHeFNtcVpkUGJjUStDaEx4SHZEWllQTmU4ZGp6?=
 =?utf-8?B?QXZBT0Z1S2szY0lVbS9aWlR1WEE2RUoxcllaTGZGaytuT2M5R3ArOGI1OFNv?=
 =?utf-8?B?aG9XSUMvdkV4QTE5R2VIZ3JSQ3BMSkMvbUl2VFFlb2xWck9VTDZ5VEkvTFhN?=
 =?utf-8?B?VThzcUVTa0pNRysrY2RGZWthS2J6bFZHTFZQNXpLNlpWVWx0TUhLZHU3Tm42?=
 =?utf-8?B?cjJGN21icWU3TlRNaHFGdXd6L2pGcFVxby9oU3Nqc25mZzNIb1l2Z3ZFOXlY?=
 =?utf-8?B?eXFNWVFud2ZKSjlEeWJRS2lzelhqVzFWazBMNFBXMTVVMDNTOXJhRDVERGE0?=
 =?utf-8?B?V05rbVZrQnhMYXZjNkZNUmxjcGN6MjNUODRqSGF1VGFKY3RNZ3lmZDNPVzZt?=
 =?utf-8?B?Q0Fwb3c3TTUxQWx1MDA3d1BIZ2JxYXdpaEJkcTZ4REpDVU96cFRpZVRhemFH?=
 =?utf-8?B?T3Mwem16LzJLZ0xXWXpkU2xhcWp4MDcwZmt1YjJYY3dkUzdsQnVVWnpqZ09Y?=
 =?utf-8?B?cG5SZVlkdXlYM1BlUy9wNUU4alptZWxRakY4Y0JNZDVXQkM3NVA3Zzc2Tnhi?=
 =?utf-8?B?V3NMb3VEa2JiQjd5RjUrTkdhdUpxVUh5Q01wYTdjU2cxRUwzam1qMXI3TytO?=
 =?utf-8?B?VTd1TWZzcGhZVjZXYkpGbTVkTnJzU0FTS2paRzBIcW1Ta3VJUG9YY242ZWNE?=
 =?utf-8?B?aVBuWUNqbWQxbGxtbTB4bkhuWjVGNllzQlI3Z0NxUk93QXpuZDkrSVBSQVNq?=
 =?utf-8?B?MkdKTE9DdTBqSUZyY3Q4NVduanEvYWc5VjF6dHY0ZDFrdEt0cTdCSDRCMzhF?=
 =?utf-8?B?NkM0eFRsbSt0bjlLRU9xMlgvUzdZTGVqNUhMMit3RUhxMkZHVDVlK3hqQ1Jx?=
 =?utf-8?B?bUV2clpLNjlDOWFiQzcwTnd2RU1DQ1VkanJhK0JkQVBOTjNjNEx2YlBJVGZD?=
 =?utf-8?B?amJyT1piMVVacU16YndHajhkRURYbE5SamFkVkpTZkp2TTJzZjNSUkFkWHoy?=
 =?utf-8?B?dEhUc2o1VnIyKzU0N2lVaVNVVWRsRUxiT2NOWjdSOElaNmRwK21BWFAwOG1r?=
 =?utf-8?B?ZFN5eGFGclMvTGNlSElubXJSTDE1Uk5LNVpuNENOZEE5ZWJSUVd0aXh3V0hF?=
 =?utf-8?B?TWR5Z29MMEkwZ3F4Zk02bmd6eUQrTmludzJTU1o1dFhlQk5HMlNXYktrK1Jt?=
 =?utf-8?B?MjhHY09jRDI1QnBXakowM3k2bGpKQnNEcjRXZEhHbkxJZXc2QmJ1dmJnMUtq?=
 =?utf-8?B?K3VHMTZqQS9JVUhFbWJKTCtBa3lpSW96VkNkWkZQWnhGRXBQaEIrQmlvd3k1?=
 =?utf-8?B?SG0xbDk2WExFYlRZT0dNR2hRT3dsdnZraENFaG9FVnpmR1BzNVE5TEFtTXpW?=
 =?utf-8?B?aWh1ZE5sZE12VkwwYnVLenpNOFppTDlCd2NEckJXdWQvYWdRODcrTmNGdG9T?=
 =?utf-8?B?d0QzZUFIUUxJekxENTJmeXZKNnVaMnFYNXhYLytOMkU4N3o5anVkZUJXK2Y5?=
 =?utf-8?B?V1BDY1htNldXcEk3UHJ2WXMzMTdtRnhJRkJ2SjQ5WmVleFMvejZSc05KL0wv?=
 =?utf-8?B?eVQ2UXZtamtvWkpXWjlDWE5yYnRMMHRoRjFQdDJzUWt3TzlHNGRlUHYrcW8x?=
 =?utf-8?B?SkYyMmVqTjlsRTNTWFdzZzBpdlVjcnllWXBlbGVMS3BHemRIU1hOR3J4Zlk3?=
 =?utf-8?B?QjU1c0tRdU9SZEhPZDVGSW9LWS9CVmorZWk1QXN4VzBJWkt5cjhxK0pURVNX?=
 =?utf-8?B?NCt6RFNSVFNnbTFLRGRuZmRYcmJqUkJxSEhGKzBRTENCVVYySFhqODIvVGt2?=
 =?utf-8?B?Q2FFMS81RjJSUlJZZmRHa1JxQks2Sk5SeDgrT0lhcmNsRTdIMmFOWVNmcXJs?=
 =?utf-8?B?WHVhVmx2SDEya25sS3ZMRlh1OVJFL1p1WWdzeDFvUVhQMnRzbHV4ZWZvR3J4?=
 =?utf-8?B?NzNCT1FtOXVSVnZsOGM5YkNHTFdvelZ6RytnT0M3MWk3c3JJU1dPTFp6K2F6?=
 =?utf-8?B?dE04NUhRWU15UkdaLzJZU3VFdnM3ai9vVW55ZmpmZnJudFlDRlVpZkcrY2dw?=
 =?utf-8?B?UFZvMTlDZXJTNjNXWWwweE95TllFQzh6U0tvK3NoNVM3Nk56M3kraHpCK3FB?=
 =?utf-8?B?aEhOd29kc0JJdzBSY0V6YmFMSjR4clRIbUhrcTdnZnFMano1Y1U3MEwzQmsv?=
 =?utf-8?B?TWtqT3ZoYjY0VVVDMk1NbUNmT3I5VmFlOVJDV0lPNWJJaGtvemJCR2k2ZlVB?=
 =?utf-8?B?dXRxUmpQcHY3VU1tbnR4UWFxVy90RmJ5NHNUS2JFdkNZU0RSbWxza0pVUjNE?=
 =?utf-8?B?ZFQvcTh4VWV6Nnh3aUlwWE4vUk5mK2l0S01uUjBsMmtpY3JSRnJ3a3ZPRjhM?=
 =?utf-8?Q?HCxq0XRj40IVrDX8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7a0a44-8a45-401c-a7e2-08df4587bcff
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:22:20.5162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6YpTBZUr75nJnJkIlgHR9pjAi4F19CmMGg2hdYGotE0OIbfFq0qAqqBcYSUzXbRAoh0mfshaMHqGkrX8xrSTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6977
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
