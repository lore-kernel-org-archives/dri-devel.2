Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBE0C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2002D10FB83;
	Fri, 25 Sep 2026 16:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ahBibtx6";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A426510FB83
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E41VaCdpsspUlSJ2pc/1XOhrVeyB208nqwuzpntkHcmupX9WTBJeRzCZzKpc0vkqDfmTvxtYEZw9BnlxCOl4UyIz8SytCA0Et/JM2hkp/JuyFNb3lNXzsW4eyZw1ARnk3C7oKsgTD/O+vKKmENejvzqpJ9WXC9sVfMUXWucEYyEmvwVqMd3SuppLIGObLTroxCf7x9c7lLNRmZKGfWdl5pyAHRpRO+BRnMcQRYTtvnCwGVkV/7dI9S3gAQLvZuDKgL7ntbbB1T7wBLTjiPh4EUBAIzMi3A7XeELwLsEJ2DUw5fx6P4pkaz51X38bJh8/MClNTKBtdR7A6wouqmoWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uSE3PIasmRmcsSz3TdF7eGvKdirpZ4KvtL5LyRQoTo=;
 b=iChlCMNhB7yhqGyBpsHoo8GIiIENJ86FFjs5JqsAO+fsun6jW0OlkEduRQyNZwMjTgpLNBVYc9NP5c6MkbQ0SVetraWUKy3a9RxLtiYv7RhjcvNYauTP2GVghucwjJCbfC53ppYGT44CaUYSdpXqISi6WE4c5xX/s1DT8QVUNr2wrTV0QxiWIuwCeBOA6oWYCkXmq+VRoXxqWckDNTK/Aaolz8Z45yrhdH19J3XDHOy4dNJbLNMYByKPrN2H56+bZ+pytzA4a3t1yCAL2/fYphQRZbQPFZVSS8jvqOX0NQNIZnc2MgdjAIv4SvvYz6BQfuvgPfNQUpMlfsV8MOFoKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uSE3PIasmRmcsSz3TdF7eGvKdirpZ4KvtL5LyRQoTo=;
 b=ahBibtx6vC1UO2qHPucQwXlBWGpbY19WVQFFnann9vKucLPbR9VUnca+N1FzfvY4oLjYT0ctpTt0myMIRDhL5itIc/+BSRkR1L+hpjD9kRXR4ntw1y+n2mibeOOUC/FExvZMzvPhL8kbl4RmfVCxN9MxnOcIvvEGCLbTvYxxEpdNuisBdUOJ4xq0zrT/GzzADa7pmDwTEf0yk+nTAbiHPelNP189vhiAovVHKMzIAW9DTL0VCsy8/3VOhldIH78OtiEHIfxyUUZRnFJGKJaA9UdrSL5A7s0FGGISc+ladvGyhCqhPT6OBSJO2AsbsUGX5NAqHbtDMf05ykWjigfxJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMDPR04MB075100.eurprd04.prod.outlook.com (2603:10a6:20b:749::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:38:14 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:38:14 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 25 Sep 2026 12:37:52 -0400
Subject: [PATCH 3/8] arm64: dts: s32n79: add @addr for *-bus node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-cleanup_dtb_warning-v1-3-f999fafbca60@nxp.com>
References: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
In-Reply-To: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Guido_G=C3=BAnther?= <agx@sigxcpu.org>, 
 Robert Chiras <robert.chiras@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790354274; l=1254;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nB7faaEbs5kmM9kgbX8hNbBBTX3zCIZUqlHBBHvU2WA=;
 b=Xfp/r4ulcaz/H3lyXPQG4X6SCrE2mOLSGbrfFtRsHBGXClnaVmxQAQawKIEfV+blscxDYWob+
 CfmaLEm/G3CAcH7KC240hvrvUNrT3KNJ7vFlzfAeyp62Lxd8SwVsNqm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CY8PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:930:48::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMDPR04MB075100:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e931624-d073-4752-26a9-08df1b23650a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|921020|3023799007|10067099003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: xpLQuw5wuFb51R0sk/cR9NQOVOKvcfiC/rBkCe+uvFLFeZbsWEnKXGDfpT/XJlzq2uo/EVlAik6PyZPeV+6wtdlvDGbxNzxh/LZyirNadvUeHrmfDuStoutba43khRNeMvhTLQKMCf7DuUjzEYtI2VDyWWLh1tFXnND2QtWIbRVfsG9iMkgQ2Jny8IIvPSGRNr1bbOwnyjvohBXEDHTE/9m3phrbIEwX8aZGakxPNaUIS/MPLKbrLy7qkEthrJ44HfhSjhMzCithc5FW/eiRWjIliIO4QEh8oveQjBozsT/TI53R/5wdhdhXyi811f/W3I9W6Wc9kKxnvnlXOhSSrst96TvHrkvSMgi0bv7JwFHAv6aSHtLZj2CpJHSoFA2HvE40Z45uPBmW6GF706i1AI2j2XSfbEnfuOFSoNOoUVOgddtbFpJ0h7ZpcIXpT4FPtz1l2mqypgr88fawz7vV4z0morxUbP3RBjecXzAZaWLAJQuC3NvI9B/qweOydKaFvBSHLUsH6hRZJpHCipLUFvBrWOP26TFb0UtwyoUjFVT1nVQzR9/mNmOg18BW+NfreL7RF0h9UvLSPCR7jFTY4FFxwoW9SfJhquoLrnSPSfFv5nJTU9F4TVf4R/1jF8MCU/N+gIO94Xl+2Qwem0G7apSGfazv2DAEYjIIOOpoy9cGxla+U9L/cSxEAuSyr/qGsPGen5w6Z6O8nSseujb1UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(921020)(3023799007)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M09PWkg2RnZPZVJOc2drYVd0SzEvbW5rWDlZYlhsMGNOQzZnQVZhZnl2VUpz?=
 =?utf-8?B?SW5jb2UyYnprRGFZcjRJTGZWdWZPMnBTbmZTWk81UFkxQ2p4R0ZhT0xxOG5H?=
 =?utf-8?B?RU1TKzFwazdjbDZLcFN2M1lFcnNCdlhITkJSWTRDMXdnQmNFc2pHbHRKZlZ2?=
 =?utf-8?B?Rmk2OW8zMFVJeklqTXh1OGs0Um5EdGtRbjhpL2N5M3VZejg5ODRnU0RpM1Fs?=
 =?utf-8?B?eGdvRm9scWdGNVR2aDBVMk45aVVUQnM5WEJhcy9LOWpkSUpzSDlIT3k1cnp0?=
 =?utf-8?B?bE51Qk1ISVpCSk0rMytlaXVnK1B0bUlROXFsLzJybno3WFYrSGRaSk1yOFZU?=
 =?utf-8?B?M0JYWGZEK2hGaEI1VTUvaFUyd0JoT1lCOEpVRm5aWFJHd2pickd4ajNxNnda?=
 =?utf-8?B?T0dhR3pvTnhjQ1h6ZkRQQkFaMmFSdGpBSkhYWmpLSnZIaWFhWlpHOTdMbTVu?=
 =?utf-8?B?TldxT0FIZkVDa2xpUW9DOGVvSDFJdVhQYVVwVmpXY0h6aDEya0ozWHVFK2ty?=
 =?utf-8?B?RzQvaVZjeEV6NlVVb0pKaS9Jd2ZvMEhSZ1lYd1o5dlNOcWtrVU5Jb2NMQUtv?=
 =?utf-8?B?YndrNE1sYmpTckJzaE1mVTBFaXhjZmdRTDB2RWNybVc2bFA5a0JhU2hLYUNW?=
 =?utf-8?B?ampJT014OXIya0tVa1Nhd29LQU93RnNFSFlSNzUrbnh3cmcwaU12YWgzY3Ju?=
 =?utf-8?B?dEJPbkc2OE56RldOM1Vab05VS1I4c3VvZVVQSEs2b0NBN2hQZlQ2eE8wNUZ2?=
 =?utf-8?B?eXV5dk4vNnBXVEdwNDdKb2wzcEVFbGxmOFBRZEJlOFF0SjhpU0dzRTVYUlZ3?=
 =?utf-8?B?cjdha2I3UjA3bzFUUE14emJiSHMvMm5MUVNpcTd1MDNEWm5oVmc4Ynd5d1Bw?=
 =?utf-8?B?NHREbkE2Q2Nia0ljeHJBV0F4djlHMGdILzYzVVJ2YTVkMUh6bjBUa1NIbHBp?=
 =?utf-8?B?SmNId3Y4b0lTWHNlbVRjNytqWWtYZElaR2FuZE5MWHNlWithRWFWejdzdTND?=
 =?utf-8?B?R24yeUh3MXhvT0czY3l0N01FSFliR21wazBINllMc0QzMlFld3lJTnovYjgx?=
 =?utf-8?B?NFhTeVRMR0xaRmlXMVVhUStJLzFVbVpIU3VqT2RYbzlaUXJ4RWJ0alZIT2VM?=
 =?utf-8?B?aTk4SzFQQVRpU0JyRFdsSmZITVhQR3J6U3ZJNllyS29kN3poVzdEb04wcys4?=
 =?utf-8?B?bEl3TEJ6dW00Q2t1d1g4NFJ4RXpIbnFnUWFDVDVrMFVSbXFOZWUrcDlJSTVa?=
 =?utf-8?B?cU8xbU96d3F5VUk3Q0U4L1A4M09zMllkbWxFenJTc3FLY3k2ZzF2enFQYUZk?=
 =?utf-8?B?L1o1ZnNlSFJYUDFVOThXMXE2QjZDRXM0T3hURUVmcVRNakdJSEdPQ01WVXZ4?=
 =?utf-8?B?NXVOMFJkdVBkVm91ZVZBMGtlQWhXaUNzbERXeUtsOTNEcGVKbGJXRlJlOVFw?=
 =?utf-8?B?UnZyQVRFUlpoOGtKZUFsS2lzQ09uZWhEOFFhVzlGTUUvUmhDZFdtd3NNRFVX?=
 =?utf-8?B?VitKZHVqbFBzMDQzZm0zcDFEQUVNT3UxdHM2eFVkcVVMMmtDUU9aT3o4SDV4?=
 =?utf-8?B?NExFdnRJVmR1cUhYWHc5dTE0bklLeVR5aEtkdFZaTWRPSXNwL2V6NHQ3M1ll?=
 =?utf-8?B?TEUrRUk5NjhkZGpwc1hWKzFlMDVuODJoS3J4TUpvZStJbGIyU1MxZHZRTzJX?=
 =?utf-8?B?aGVNalB1ZVNYZmdHb3k5b3czeW1ZM214Ni9mYUkwakNubEFTTXBsYm5UQmtB?=
 =?utf-8?B?ckdWY2dpZEc4TjU3WUNHR0Y4bUlOZnY0R0drd0JXU01xTUptaTBPRVBtaVNa?=
 =?utf-8?B?clFmV2p5dnBzV2JUajJ2OGoyUC8vOGdPU2RlZUh4M2pNWnNyYkdJRjZWWmNB?=
 =?utf-8?B?VTNRU1NYbEU2T0M5RTBBenBJQUFqLytSb2xUWkJpUVF5Z2VOcHJjUzhaU2sr?=
 =?utf-8?B?bGVNRDJlbXB3ZkhPZHJpZmY1TDhvQWkxTWMvVlZnVmNWdGhyUHFibGt5aC9s?=
 =?utf-8?B?dmw3cEhhUElXNTRwam5yR3NtWXJHQXp1QWZUYlpSUFRMMmhzVTJvWi91SExW?=
 =?utf-8?B?cUxBSFNLM2dra2FzK2xCeGRnRjlnRVpIK0tlVGpWUEloOGJKbkl4MENvczJk?=
 =?utf-8?B?S3BIYVpWNE5KcDdQTTZEZVJqL00xRTdnSVE3Ukt2UmQ5alNrL0FjYWJLekxu?=
 =?utf-8?B?eGtFZ3ZpT1NGWXhWSFdWUzRrOTYzMVltd05SanhvRnhFd3hGWC9xdU5wMytI?=
 =?utf-8?B?NjlKMmozU25vMUFMeEQyUm12NTlzVXFNMGNmaFRFUVV6L2N3ODZVVkJ3cTN5?=
 =?utf-8?B?WlIvaGVQVGZaNGhjQ1FZNEZOejJ6TjJmblJISjd3TlhHY01ueEc1a25DTUZt?=
 =?utf-8?Q?9WhPhKW1JNwBXHIVm3EHnW7GqKgZanWRgAF0R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e931624-d073-4752-26a9-08df1b23650a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:38:14.5805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEhOknJmIf5kA2VsyUU/76ra7UUWOeuJ81LSHgrPxGugae2nzjJeviaFjSAXrihaCipvYUnEpRTJSQwgteVdQjNn4ZL3WqhSHevO0EXdQPWD/BpaJvW8tP3VkkbUi82r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB075100
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

From: Frank Li <Frank.Li@nxp.com>

Add address suffix for bus node to fix warning (W=1)
  arch/arm64/boot/dts/freescale/s32n79.dtsi:15.10-54.4: Warning (unit_address_vs_reg): /cis-bus: node has a reg or ranges property, but no unit name

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/s32n79.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
index 94ab58783fdc8..cbb43df8e1bc5 100644
--- a/arch/arm64/boot/dts/freescale/s32n79.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -12,7 +12,7 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	cis-bus {
+	cis-bus@4f200000 {
 		compatible = "simple-bus";
 		ranges = <0x4f200000 0x0 0x4f200000 0xc00000>;
 		#address-cells = <1>;
@@ -53,7 +53,7 @@ smmu: iommu@4fc00000 {
 		};
 	};
 
-	coss-bus {
+	coss-bus@4a000000 {
 		compatible = "simple-bus";
 		ranges = <0x4a000000 0x0 0x4a000000 0xff0000>,
 			 <0x4e000000 0x0 0x4e000000 0x1000000>;
@@ -330,7 +330,7 @@ clks: protocol@14 {
 		};
 	};
 
-	fss-bus {
+	fss-bus@5b490000 {
 		compatible = "simple-bus";
 		ranges = <0x5b490000 0x0 0x5b490000 0x1000>;
 		#address-cells = <1>;

-- 
2.43.0

