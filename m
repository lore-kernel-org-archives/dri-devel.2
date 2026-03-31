Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B60AE7E345
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D4010F410;
	Fri,  3 Apr 2026 08:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GejdybBY";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011011.outbound.protection.outlook.com
 [40.107.130.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2825A10E19F
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjNnMaFiKssF+tYNCR4U8Wi2hMm0qUt87Y/k7fxfrAZ9YUvnU3YltoV/kKETjQiMCTFlTo3u6O8HX7zxEBS3t07BkQiP+QpMJzier553gmmjgtLXDCcjqkuEUVVS6kfC23oAQ0enXXSUXB2Xv7i3APHPTL84unO4Y3OVLLxbuCLWRiGuxt3RFRUcvXTlNuGvb8JreA5P08ze83BxCUhsKiO2DBWjoqGR3TVJRdCFh5wmZWX2dImiaToJZxI7WqPyWKWP1AdDB5BgXdDM1eTNUxZKuBETu2lTpfI/pIVLnYVFytc4D5NzFMTx4B3eBnJBMQ6dE2WI4jy8dvk2jVOZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEvjpS6UPBfktZ/1tRgSyrvAfADprBii2uGYFu8MfX8=;
 b=L/eiUTbyzLt7oE8uSs9gS/FbBrN3YuJsJZXf9JNw5/FoU+nNiT5m9KLQho/Qc8fjCdf7ZcNCwfogiQTkFxCr3APKL0XFfC16zUbzt99LvFlslqZDtU7rdXWSrB66kQU21ziQxyshzmhOXJ4GS6/qqcDhPj1EFuaj879N6XskKRROxw6958FXlwjWRwGeGiURTSZD4XWSLul2jrMDlSKroqraBXwIxoicT32XS0fT7wTxoFJyrSlfzLWS4wZBZwhioYbi+jZVwGNyHc9yxqDh8tNHzbGRotls4xzYH99Foq4eGLydmW98Q8Emt3TLj9krBw619yjbMXNF0l82cZxZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEvjpS6UPBfktZ/1tRgSyrvAfADprBii2uGYFu8MfX8=;
 b=GejdybBYjBC+oeNxEorEBf8LzvMWL0cI4W06HMchbhP86kUrHrtcJEoyA4ECLK452na95EDDszso2jG6xg5I0ZIamMz5hqm2IV6iwsQOvG4VxfVliAm5RlFQG5gbqlvtdklw5qQMvU0fp0xB9IDiUbcG9QAUm7w0YA5Wc1QrlIhoQgCcz0taLBiTIoR8twf73eFNXGb867frqiYDsuV1iM5ItTRvk5blnaJvUKLLEWQ7mKdt0qRMLU7RtnC56ylEtfFW+0HIOn7lvRdvAimwsBt8RzPMJLqdVyNoBZLaRXE2+f8vIc8AYAov7pEzkVqydtZhfe9TXMDEJLyn3aHj1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by AS8PR04MB8309.eurprd04.prod.outlook.com (2603:10a6:20b:3fe::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 10:04:23 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Tue, 31 Mar 2026
 10:04:23 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
Date: Tue, 31 Mar 2026 18:12:39 +0800
Subject: [PATCH 2/2] arm64: dts: imx952: Describe Mali G310 GPU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-master-v1-2-65c8e318d462@nxp.com>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
In-Reply-To: <20260331-master-v1-0-65c8e318d462@nxp.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Guangliu Ding <guangliu.ding@nxp.com>, 
 Jiyu Yang <jiyu.yang@nxp.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774951984; l=1928;
 i=guangliu.ding@nxp.com; s=20260331; h=from:subject:message-id;
 bh=thkFkag55OK6rhNhz9WUUkmf0JKTjNO2q/irVhMiMh4=;
 b=+L0HfmjEBM/t2IFC4vV/G+i+t66C6YEWij8iGc2uE91L6RGZpjWGamfrvR/1+s5ObvRwpXCl6
 u/b6X0QLM0/CZahUnYOHaMmvk3QYm5lFMd5G7SS+UNtnPjyPuOl/1Wi
X-Developer-Key: i=guangliu.ding@nxp.com; a=ed25519;
 pk=Ozo8o/sk09NyO6URvn0eD0v0uVHduT/yJzVGTAJ9gxw=
X-ClientProxiedBy: MA5PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::17) To AM0PR04MB4707.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4707:EE_|AS8PR04MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcd6a4f-0f75-477d-805b-08de8f0ce237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|19092799006|366016|38350700014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: oGngS9L8jUGkFnY9VheQsGbiIg1wDbdoCY0Cna0XRNZ2/5qLqLThI6k82U8JzTsNKwI1jG3+J6lq/DNlxpADNIdgQL1LdcD8sPYEGcGAMEwaO8+IEPk3yOgyl+rNtcqi3RLxQzjv/YnGq3HMsLBOmFns5k1ML9Jn/WFDsKgU8qiI7GdjDA2Mh5ryVpj/YdMDHmTDEbAs3lhu9s4Ex7sKWm82gy454cZh/ehvdoORZxdCN1gM0vKdc1FobxpWnbuJymJPtv8lT2lFHplWIa1NU7hlxbhDkhEc6y1fOD0RblkAV1HNkwee5MKZWxpkUMK3e0PqoPnWB4/aWNZABRiIbeWIFFCiDjYk5NJEEDyOND2DqDoimjCRYknwGIxlBLQv1gL2YQEJt03YHPQMyFoJ3PbpBnBf476aV6QSqwpaYBqIvikTEma6LRH83uS2ECobkZzikYPtRaNa6iMHJ0q7waMiQHFngVbBgRtHIPuMxZviYxAE2b/X4EWrL4joqOr0BowfbLo1xqZHNFuZ8/vqJMmrZXAvglTj542UDcgjtm0jIvcG093FOuZHO7udMhUQDKDHy4jZ3h4yGUahoAb+4UimneGECr1m6PpmSOlDSYVwNEtxJ+8vdwzJycl2uKGxNip74YtrMps88yOAFsEGJQ4GEhw+a/5YC5C28f9LgNROQ/2AWqHbVx6kvODPZIV+ZWtlmTbiKRXhnfYryK1whZxeS8C2AiFbyCyxEWc1kYx7ntU18Jx8x7GCypz+EttX5Ud6trl3uzXbL5AYLSY/sTt80J4ziQ+8rZpslg3cIS++fht6xLNqsP9whtAMWqcv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(19092799006)(366016)(38350700014)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDMxTHV2T3Jwb3hvb24ycFcyRm1HTmVlMnRLK3JKOEdEdEszUGhWYy8weUs1?=
 =?utf-8?B?RHFmUEpOamF1bzdjSGd0d25nazdVTzlFYisxRzBESSs0Z21BMC9CU25LNFl4?=
 =?utf-8?B?YW5tNXRQcVNKc1BHSWRndUxEZG1velE0VVZlUHZIQWtjeDV6Snl3MmFiVVZI?=
 =?utf-8?B?T2UrbnFvMmlmRHRCUXpIN2huQXFuZ1lMWjN4YTBRSHVlSjBJV0dsL1Jxckcy?=
 =?utf-8?B?OXh6SkVseHdkOFlIcW9RT0UvK3A4UEtTbzR0WVBqV0I1aEpGb1dnOHJ4NTBt?=
 =?utf-8?B?dkwySCtVaE9YTi84eTljSURRTkk5b2wrTi9ZYzFySU5yVlFiTzBsUFlTR0to?=
 =?utf-8?B?ZjgvaHRoRVdBMDBFcGxDcnJxSWJOaU56OUNLUm9MNWpXMzFyZXZldkszSDhz?=
 =?utf-8?B?NTEvbHcrRHU1dzU5amlJb2phYVFqS0lsQUxHa1E5VXZ3dWFuRHJva1VmdkNC?=
 =?utf-8?B?ZDRtcWYxeHk3bkNxNXkwVXkwL1k2YWI2alpFYkxzM3FKY0U1aUV2bWV5NExv?=
 =?utf-8?B?a1hwTktiUkRLTzdIdFNkZEVDQWI5YmR1VzZxMkFxLzdubk9CekV6eVhHZ3RP?=
 =?utf-8?B?YVh2VDBseC9WL0xLT3EweDl2cGpac250TGJySkFXVlpxa3Y0eTVEYWI0M0VV?=
 =?utf-8?B?Q0hrS0pvbzg1L20wQVc4Ky9iMHUwOEZhNXVjMTJJZ2U1K1Z3YnJhblZRdGRT?=
 =?utf-8?B?UkRudU1ZdVl0czA0a1piK3lMUVIwMUZvS0pjcmYydVVWUHhVcU1hTS9ReWNU?=
 =?utf-8?B?Tk9RSFk2RGUzcHUwbHVieWhhOU1HYXMzT2dYeTRBZjFXbG5hT1RHYXpwcm5j?=
 =?utf-8?B?RTF1Ny9ja1RKV0xIakd3KzIzOXRubUVDbzNBcERkZVR2YThUZXNtNVg2bzZG?=
 =?utf-8?B?MTNyMWtXd2N4TC9jSzZXT0RiSXF5a1lvTnRJRDgvT1RwKzdneHpxcG1hcGt3?=
 =?utf-8?B?RHBhMDU5RkNUOTVlTWdGblhVNFZTNCtJQ2pMZ0lVeXpnVmlkcC9tbCtUcnNn?=
 =?utf-8?B?Q0VJSkVxck9WYzFzZWoyK202c0JZQTg3SVp0Q3M1T0Ezd0Q2KzlTNnhRMnZN?=
 =?utf-8?B?Yy9sTkpGRnM5RkR6a0ZMaG9PSkg5VUVIdk9lcHo4YUwvVmd5WGszd3ZmRk9D?=
 =?utf-8?B?NC9OenJiVDIrOHljRUozdU5WYStHQ1RIdGtiOFlYOVFqWHZyc1Q4MTQyYnhY?=
 =?utf-8?B?akFSZnptczc5L1YzcWRLMFVJSjhTTEZBa2ZvcFBVRnhjVFJ3b3Y3WWhqNEtj?=
 =?utf-8?B?Q3VMY3VSUUcrc3k5Wk1HdUl1Y2t0MFpKSXBHQ0RrNGhUNG1obnRYVlhxS3ly?=
 =?utf-8?B?OFcrRmRZeGYvcTdRNGR4RXZsOXplNC9UcXRMdlRpeXF1b0lMQUpCeVZtTXhi?=
 =?utf-8?B?U0VpT0NhbTh3ZTRrM0daQVM4STJ0MlkxRkx3U2ticTN2YUE0c1ByYkMzNEJV?=
 =?utf-8?B?eDZQZGZhTnloNithaWJ4czBpVDhNczNKR1l5akxIeGl4a1hpZTlvTCtFckx2?=
 =?utf-8?B?OXh6YlQrMWhhTGMyWGZ5ZStPVFJCc2RBTm8wZkExcEVuS1dBZGVnb1pXdndi?=
 =?utf-8?B?ZStWUVV6TmxRVXV3b0UySjBWcVhQVERwRzExaElQZGwzQUdHdXZhQWFlMVl3?=
 =?utf-8?B?b3NGMTJPTG1ZUk5NTFU1OFVqKy9rT2ROQWNaRnMyZnhJZTQ5enpMS1VwYi9h?=
 =?utf-8?B?Y2p2UEp6WHovUTdDQ1RDZkdqZVIrUnl0Nis2Uzd0bTcrTnVZRE9yQnZoZnhV?=
 =?utf-8?B?V2g4UGFibWtDU2RFcjJqUlFVNmVRWVpidE5PaDFXMTVyNThKRFZON2RJRm5z?=
 =?utf-8?B?cnJsdXNjR1RnVUF6VWpCZkFzSms4bDhNUG4vUFNRZTBkaWFVRjZUZHROVmx3?=
 =?utf-8?B?ZXZQcDNDQktkblIyWTA0WWdDQ0VnRENrK0VRV2lFYjBja0s5Qi91bzA5VnE3?=
 =?utf-8?B?QzVNZk1CbUhBUlhlb1RtTjhVUFlGeUFmb1Y3T2NpUEJJcE41SUlBT0twa3dJ?=
 =?utf-8?B?WjJMOHpYTlJxV2NsYlpUaHJ6RS9FY01JS0VhZ1BSZzQvOEhRVGZSdGpGVTFz?=
 =?utf-8?B?Q1RzM09TVU5ZOXcyUkhvb3BXdGlTd25xS0hMZWJSUFpsYWNjZVRDcEMyeXlP?=
 =?utf-8?B?ZDZ0WCsrUjJyaTBDZ2M1YmNVY1FYa3NBL2VhdGlOSEx6cmljZjdyaHNZK256?=
 =?utf-8?B?T0c0aDJCckorQUcwL2NVU0huTURjQjBCdmN4S0hFYm52dVNKczE0bFpzMXRO?=
 =?utf-8?B?S3Y2N3R2K3dMNHpJd2Y4NVRidE5OOTZpR0xrTm1SNC9pMXNDSlVEWmlDQ3dh?=
 =?utf-8?B?bmYrblB1cml2OFY5enBUT285N3pSYUQ3dUJud0VZeXIya2I4UG1FQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcd6a4f-0f75-477d-805b-08de8f0ce237
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:04:23.1962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDw7VfGnvcQjLoTe19Eqz488qykHmLUjJHCW/RtuaceXwFX3+NRVnypRaeiWeI7VAW+hEGUq1uc0gKjzhZn7Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8309
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

Support Mali G310 GPU on i.MX952 board. Describe this GPU in the DT.
Include dummy GPU voltage regulator and OPP tables.

Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
Reviewed-by: Jiyu Yang <jiyu.yang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx952.dtsi | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx952.dtsi b/arch/arm64/boot/dts/freescale/imx952.dtsi
index 91fe4916ac04..0bd3e7fc0674 100644
--- a/arch/arm64/boot/dts/freescale/imx952.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx952.dtsi
@@ -318,6 +318,28 @@ usbphynop2: usbphynop2 {
 		clock-names = "main_clk";
 	};
 
+	gpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-hz-real = /bits/ 64 <500000000>;
+			opp-microvolt = <920000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-hz-real = /bits/ 64 <800000000>;
+			opp-microvolt = <920000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-hz-real = /bits/ 64 <1000000000>;
+			opp-microvolt = <920000>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -1262,5 +1284,19 @@ usbmisc2: usbmisc@4c200200 {
 			reg = <0x0 0x4c200200 0x0 0x200>,
 			      <0x0 0x4c010014 0x0 0x4>;
 		};
+
+		gpu: gpu@4d900000 {
+			compatible = "nxp,imx952-mali", "arm,mali-valhall-csf";
+			reg = <0 0x4d900000 0 0x480000>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gpu", "job", "mmu";
+			clocks = <&scmi_clk IMX952_CLK_GPU>;
+			clock-names = "core";
+			power-domains = <&scmi_devpd IMX952_PD_GPU>;
+			operating-points-v2 = <&gpu_opp_table>;
+			dynamic-power-coefficient = <1013>;
+		};
 	};
 };

-- 
2.34.1

