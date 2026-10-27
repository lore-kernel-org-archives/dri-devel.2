Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE2606BA9B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QSbqoEJ5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EAC110F607;
	Tue, 27 Oct 2026 15:01:42 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10FED10F624
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBUOU6dinxoAHsh4lNlrvZzsJ7fZgGzCFxEvlcRMFFR+8qRUbhPndofhkPf7ORbY0hAIowJJAqln9lr9AWMAATgsiugznQ2v6xCQ2F/8RjTpOnNek+4xZZCEo0mJTdtUCZbPJUAgET+x+pRYE0HgskdoWA92+PClkD2AuxOjxB1p+chIWiRSxjzvBI5KZD6q+L+CWIIOcUcPAHD6HzLTJOaVnwN2JX/we1Tgn49unaW0KoA4L5pgtOk1Iz3u6k47FeorLZKt4W5vRNJP1PO+FWCmncKxh1GDk61mdWz7EvPOPYW3r5OCUg5pz8h7ppWzR0PH881wR6wzYTkPBEdNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g8Bcj18zlI58vEZwJSPF+R7x8gDnbHp1lnY5DKTFew=;
 b=R+NC2tblcwipsEna9QMWfyDhxg28wPCIiJ/suiQMkrUcQGBW/zQ+V1ce0lPnmHjCXhh/vz+YLo8S7PR0cKTe7McA5yhzkOQ4Ul/0GGuVNoYapjpjApBfpiBPXm11z3KkGBxDHDXgVFOzP+7LM5YnsirEjl+XQa5R9QK5hb1KgzSBsun1gyRD86vPh63ZzOh9sU1DixeYJw9+IQ28gu+JDfML6VUCzATRsR1FEzCqKQT2PCuluFMJMJZLxmlyB7jmu0XtQUxQ5LJKgaXbEIS+VEh/Ti1+mDb16ru/3wxLxteApL7WOYJUM4EDIdjSRDDJhKeBpc0yZeW+CeWZsxm+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0g8Bcj18zlI58vEZwJSPF+R7x8gDnbHp1lnY5DKTFew=;
 b=QSbqoEJ55jYIhpRpihiF0FeXp1T9IKeJpLGn7DQTlqbK3efM1NS/UTxKX0+NdET6T5kR3WshqelP/i1PO3PUXqkpvkxjOCYcgz2+MMTSemDrLZGATGOXfh4fv6dbZO4ssxvCKkX8oPn1FpU+BHPn32cDGmc7PPO/AW31QTqzJUVBA6EvmiYNPCxNsadtdWne1c2uUoDqhVc7zr0KflRsonIP1TXD0QGdwsUwMhPX4bdyqgODdgzwD3vfPv0bKtADNIVKXtew0w/82rxDmXS9Ko+M9NpyhhFEG3LLN8Fd2T2ucHwPzckp2ro3bJDyrmB1OiRyVrkhj4us/f29Jd9tvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB9PR04MB8445.eurprd04.prod.outlook.com (2603:10a6:10:2cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:01:27 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:01:26 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 27 Oct 2026 11:00:57 -0400
Subject: [PATCH v5 5/7] arm64: dts: imx8dxl-evk: Add onboard GPIO mux
 controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-dxl_lcdif-v5-5-3a974e4b94b2@nxp.com>
References: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
In-Reply-To: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793113256; l=3938;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=U1cJbnWybUl096dQp+JhQ6XBKsomk3UldC4uV4i5qVc=;
 b=YWAaymgpnP/ftu430irKBdGv8nt+egsdsE07CnJwvlPw03hs5KegthnA3x74cuXQlGE6Xz8jq
 BbMBaraNlkwAM2EZQMoKd8Y2h8CPk5K2++/Eoeq2RuRW2gz4+/0ARsX
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DS7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::31)
 To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DB9PR04MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c5a224-f23b-4755-96d6-08df343b2c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|19092799006|1800799024|7416014|376014|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|10067099003|56012099006|6133799003|22082099003|18002099003|921020|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info: Csyo8qyF/1/NLbsi7MYRV6ETt29rB+bePhTpOWrlkQ7KOodGy/KnsIbNjz0QkozGyY6yqRvdyK57+2WwQpBcd8V1xQn4i0GEfvPT/gGMqNIGXcBN76Hln6jMb4e1twbJUs4ZaqH8mr9/iDQz0aIKSj0K0HFLQHV2TNe84sBRNB82iRP4WaEuiePxg4vnIVARCebiCP7c7M8M1CqbkyiaxPW2o75SX66l+zEdSJLxruHmJhTut2rW53u58jDHkhZsNd2pJCTp0fNZyG/2Z6OPgsQgMyM4ROIFqlRMHUbcz5C9ZwqE7cbzVSrvZefUggWQt2o9A7iVnGotLcsOdAZ9R+GTbU/GFa9RQR2bwIA67SyBeaCQ6YfKIAsmvfetP/g6p684pWEvshXxKwy63ruffyncLUsyexyyJ+nbZqZffPt9MJbaN0JiTMondvoOcsxfMkOpNVmJEfgk9PYsG4Qm+s50Z0J+FVsDxYaDo+Vo3qSe3RNdUlNpQPkefg0jOztgOkZvSqjw1wq+0hSNcuuQ3HNlSEJ3Jj5+yx8m78kj2+UaVuHH9MpuDPTNTRDIRErFtsug1EyOILx9n/o9YIYNUKvxtwbYskyyHJJx7/OlLZMn60SXQEAFItZg1GYpjGwRyf+tVPuwL1bVilmj2UfZSGw97g+xnXNMz6PewPZ+pYBNKRks6I4lV1G6oQyfM/yutilGQquwNDH/he3021ll8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(7416014)(376014)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(921020)(261026140227099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZkam40eUFYcW9NTGg3YUdWbXRFbVVwR0krREFMQjc2OU5CWUQ5WXltNG9a?=
 =?utf-8?B?ejJ5VEY1Uk9SQTdsTEFUL0tMM1VXaUhPR1FySitPT1lrMVluaEVUMkxpQUQ3?=
 =?utf-8?B?R3NJN0VQdXdtVTdEOFlDWHBlVmFRSVI4WGNkVUtQa0dwd25PeVg2MC9jYSs5?=
 =?utf-8?B?VU94STZ0SDYzSzNDWkJTNWxxcWlHak1Gc0gxWlJveno5YmczSlFHWVl6ZWta?=
 =?utf-8?B?dHBLcGVNc1QzSTl3SmNkNWZYM3dqNHJVNWo5aU83NWNtbERDQlNVaTdpRFIy?=
 =?utf-8?B?emUycE9LK21NSVdoQ2s0UFRSWGFQK1Rhc3o5L09EZzYzWGNFTG5oNkFld2dk?=
 =?utf-8?B?aGU0bFlCc2xKcThjeFh0S1FWc0dKUE1OWXZORGR3amx3bUdtTm9UUjQrSzhW?=
 =?utf-8?B?Zlk1SkdRdjN6bWVqWkNUYzJncEQzditmc04xUG1GU1FXeGJLMXlUQ3drZEFI?=
 =?utf-8?B?M3dCL3hrZ0xWSi91QktwT0ZscXkxKzZ3VzhyL2N5d09TMWVZdjJvOTBHU25a?=
 =?utf-8?B?NG9jbzEvZTkvU0V3ZysrN1VHRjB5cHRqbk5UYUpVOCszYkNSUWRVbGZxaUVj?=
 =?utf-8?B?SlNRakR1a0RmQlRQWDdlTVdyTFNabVR0aUxIMnp1cDFnYkpGcERmZkphdDN5?=
 =?utf-8?B?RTV6NW84YmpzUkJaU0xJV0FJL25hSUZLNXhMajBWNkZIWWFwbEZzNm1aWEtN?=
 =?utf-8?B?RVpZbm53VU00ZmloejlMSmtROXo5SG1rVTVMc1BqbVRrWHVwOVR4SnB4b25w?=
 =?utf-8?B?bERPNzJtRG9lS2NyejBNTTl2M3EwNG10TTZhRTN5OFlnT1lKakQrb2dLU0NN?=
 =?utf-8?B?WFRVbDB0TFl0Nm5hejlUMWUreXNnY0prWGFlMXVCMGk3K2hxbENjWXVCVlcr?=
 =?utf-8?B?LzhjWlFxd2tvdXBxbkhuSklxb0sycXBoL0lydjNjWUJReENFVTk3TGtieVlj?=
 =?utf-8?B?Q05zdWVFWkpSRnJsb2duc0lYSCsvYUNvc2dSVnZXaldTNlBhbGcxN1VTWjMz?=
 =?utf-8?B?Y2d5ekc0R2w0eHVTdHNwQnlJUVBBeXF3TFFMVDZDbklDUC91aUZRSHMwOFhB?=
 =?utf-8?B?b2VWN1lYYyt3VXBPcWt6dlNBUjJ4alpweDFhVjlybm8xdWFHKzZKQWtpemtG?=
 =?utf-8?B?MFdKZTVFYVg1djhGYmtzVVBEWjFrbnZ5ZFVWQXMvQ29SZzBsLzQrRm1KRHk1?=
 =?utf-8?B?NFloMHdVdDJoVy9YOUxxTDdIeTVveWdGNjN0U0htQVlUblhpaHV6cnRUeGh1?=
 =?utf-8?B?bnVPSS9rTklLYitwSThGTXkzMmtLUFRwU2JucWRqRUJxTDVLbmdwNTl1b1ps?=
 =?utf-8?B?VTR2OEwxYUkwSGtyRU5pN1psc2gzYTdvbWtoVS9rOHNlWGdJWUxRbEV6YWMz?=
 =?utf-8?B?MVdFa212ZUdVTlM3NDU0ei80UTRzMWl6MmRYaEM4RzY4dGh1ck5jWVpGSEEy?=
 =?utf-8?B?ZXZMaXFwdEtpc3lqMzhJUW9OeVJZMlkxcW9xMi9WaEdtTzYvZE5PMDZBZ3RF?=
 =?utf-8?B?MVI3NUZIMk5pSDA4aHppa3J5MmQzREp5UEtXenRKQk9FdzFSTTFML2RzQmhu?=
 =?utf-8?B?akQzelJaS1JJalh1TGhtZjAzU1BDNlV1NGc1Nk5lajNvZ3czaXlac2hzeVFT?=
 =?utf-8?B?bDBEam5kakRQSEUrN0xkajZja2FMM2xTVUcvZWtCYVQ1RGtXenlDalEvYUpE?=
 =?utf-8?B?TGZOblFnb1JySnd2bHVzQ0taWXNEeHk2aWh0QnVJbzJWd2NKaTNzejNxcFB6?=
 =?utf-8?B?RkdMU2RnR2VoS2MwdExhUHRaUWdBV3lZeGJGb2NxRlVhSDZVVVN4bS85V2g0?=
 =?utf-8?B?L0gwMmwzZjYzcXlaeUgwM0g1NWRJdm5CZ2xmajNNVy9MMzRqTHovanBMUFFB?=
 =?utf-8?B?Y3BSVm15NHNva1g1bmVsMHNFUzd6Y3pyRXR0VVdwckxqbWs1MU1zYkhQQ1Vi?=
 =?utf-8?B?SFhOMmk3ZGVuV09ZSmhOVTBDZkM2OXl4WHJwRFo3Ymc0cHpCN1ZiVzd1bU1M?=
 =?utf-8?B?TlpNbWpOQjNUQ0IxNDNDQmFQM0paUHRhRzJZS0MvQVA4bklabFFrYUpqcUFz?=
 =?utf-8?B?aGxnd1dhTnRlUFpJa2Z3ZWdOZWdZSG8vMlhwT1o3TG9vQTRTa1MxMG1aZ2Zu?=
 =?utf-8?B?QzlabTZDdVY2cDF2NjR4TE9WWkNFYk5SMUJ0M3R3QUQ1bmxvakJwQ1J1blNL?=
 =?utf-8?B?aG43aVQ4Z1UwQ3d6U1hNLzZsMy9vRC90R2RBUkFkWnN4bjJaaVpMSVB1Zk44?=
 =?utf-8?B?UTdDZGRvMkt4cENlaG5aNVBiV1E2a3IvR2tMN21Fa1h6aEpUSEpSWjQ5TWVU?=
 =?utf-8?B?VkVZL0dNNkVNRE9MdTcwQkxQUEEwdURhUzNOWE95ckhPYWZvY3g3V3RudThP?=
 =?utf-8?Q?lKGT0T4+TX8RadQZKO+VnFssDMeP7NflUCdpN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c5a224-f23b-4755-96d6-08df343b2c45
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:01:26.1123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLhzsk6ePA12xqmg54jXplFmaI4MMUjrXuPW0jOSIRAgbxO4Ttwim4yH8/KGxSrKLL1vc0TGkvcwKjGDKvewQerDgYYVvwzbNqE4bO6IaycddQKiRiBrIsXHC644xzx9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8445
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

From: Frank Li <Frank.Li@nxp.com>

Add a GPIO mux controller to describe the onboard signal multiplexer.
Previously, the device tree relied on the hardware reset defaults to
select the mux state. Now that the kernel supports the pinctrl-multiplexer
framework, describe the onboard mux explicitly and let the kernel configure
the required routing.

Prepare for additional device tree overlays that require different mux
configurations.

Remove the regulator-m2uart1sel node, which incorrectly modeled the board
mux as a regulator.

There are no backward compatibility concerns, as the affected functions
(lpuart1 for Bluetooth, spi3, and m4_lpuart) are not used by existing other
users such as U-Boot.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- add idle-state = <1> (sashiko AI)
- ref to spi0_fun for sai0
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 80 +++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 71eff3efa6d32..f21ac208bf00e 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -97,14 +97,70 @@ vdev0buffer: vdev0buffer@90400000 {
 		};
 	};
 
-	m2_uart1_sel: regulator-m2uart1sel {
-		compatible = "regulator-fixed";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-name = "m2_uart1_sel";
-		gpio = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
+	m4_debug_mux: mux-controller-0 {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		#mux-state-cells = <1>;
+		idle-state = <1>;
+		mux-gpios = <&pca6416_1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	spi3_mux: mux-controller-1 {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		#mux-state-cells = <1>;
+		idle-state = <1>;
+		mux-gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
+	};
+
+	uart1_mux: mux-controller-2 {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		#mux-state-cells = <1>;
+		mux-gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
+	};
+
+	spi0_mux: mux-controller-3 {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+		#mux-state-cells = <1>;
+		mux-gpios = <&pca6416_1 7 GPIO_ACTIVE_HIGH>;
+	};
+
+	pinctrl-gpiomux {
+		compatible = "pinctrl-multiplexer";
+
+		m4_debug_fun: cm4-uart-grp {
+			mux-states = <&m4_debug_mux 1>;
+		};
+
+		spi0_fun: spi0-grp {
+			mux-states = <&spi0_mux 1>;
+		};
+
+		spi3_fun: spi3-grp {
+			mux-states = <&spi3_mux 1>;
+		};
+
+		uart1_fun: uart1-grp {
+			mux-states = <&uart1_mux 1>;
+		};
+
+		lcd_0_fun: lcd0-grp {
+			mux-states = <&spi0_mux 0>;
+		};
+
+		lcd_1_fun: lcd1-grp {
+			mux-states = <&spi3_mux 0>;
+		};
+
+		lcd_2_fun: lcd2-grp {
+			mux-states = <&uart1_mux 0>;
+		};
+
+		lcd_3_fun: lcd3-grp {
+			mux-states = <&m4_debug_mux 0>;
+		};
 	};
 
 	mux3_en: regulator-0 {
@@ -620,7 +676,7 @@ &lpuart0 {
 
 &lpuart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpuart1>;
+	pinctrl-0 = <&pinctrl_lpuart1>, <&uart1_fun>;
 	status = "okay";
 
 	bluetooth {
@@ -658,7 +714,7 @@ &cm40_intmux {
 
 &cm40_lpuart {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_cm40_lpuart>;
+	pinctrl-0 = <&pinctrl_cm40_lpuart>, <&m4_debug_fun>;
 	status = "disabled";
 };
 
@@ -699,7 +755,7 @@ &pcieb_port0 {
 
 &sai0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai0>;
+	pinctrl-0 = <&pinctrl_sai0>, <&spi0_fun>;
 	#sound-dai-cells = <0>;
 	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
 			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
@@ -879,7 +935,7 @@ &usdhc2 {
 &lpspi3 {
 	fsl,spi-only-use-cs1-sel;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpspi3>;
+	pinctrl-0 = <&pinctrl_lpspi3>, <&spi3_fun>;
 	status = "okay";
 };
 

-- 
2.43.0

