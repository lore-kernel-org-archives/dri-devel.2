Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE19BC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 144C510FB79;
	Fri, 25 Sep 2026 16:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j5omKsii";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D56210FB83
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JI/pz3dE8e57kt2qFCaV6Rf6g/0eYQurtrbceLaTsWSUM0h6TzlUknYKRkN6e/4aFF3KgXerSGpg3mzDlO08A8ddPXjortOVRsVBFb5joe24Q9lwIUjdyZ/L8p8VXgs1n0bPxbCBevUsuMD7XUZZAe7zOVSEEwc1XF/wOs5oB440mQnt+DIX3JwsMMsfs9Y8BjwFAlJGQx9K/ywadndUHvDnZU5rURgklYss+FWK2QKIHl9j8j4lavdhOaQF3aRAYLt86CAUKXCFzcKUhQsUesIF8shFqqDJ2AmyYo2g6TEuVMvqNkb/zNGBnfWX9vJvpBDuYAiHycyX0bwWS4UY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7jCIE7s49HSZSrIcK596jkzqRpqjDRp/sgbvh9meN0=;
 b=kONK72vC6nAq1gPNVv6c+N6GoJRyDw29bqUbWVYq343BQUgciBc4xaukascpOneDdlOL6y4BKwdYA2YEpNZpH+sthuJPMnvLHoQyq5ePLOUVu/cG9MqAQz9E8/sPBwA087cJMWTIiztfClSoHdlED2c6UGBIp2O5wM65BXwXQLDsxz0fosY3h/R2o/SIIdHAG8n9WHCuV2v9OPXZuT8ip8hIS2Rq+CrtjaCT6qzXe32afN3HcLEuyt2bunpIqcgL7hiMdEhdlmCmZ2heFrc3lKGQafZMgbCtT7Dz/f1OjmcwAivJbAJaKC6k858SK0Jeb2xZHkle2enuQovHf/hbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7jCIE7s49HSZSrIcK596jkzqRpqjDRp/sgbvh9meN0=;
 b=j5omKsiijYrCSi7Gr2f8CoPkOc49LgxXmkjpTmZDArbbkjMCsLgYo0xgt2jsdMTiAdsgdCo4vJHpgsakye+rx3G5ayIMlqjVJA2GtWChHHwGd8Uvh6KNrpdxkOMYmAKF0VjmoQ4meTwt+Q1A6dR3HXcv3F/sA1ePZQ4xHBcwpsjGV/M9mxy8an9mjVfinLUVI+zLCMLaMaKmDuRO33SV2xrXbE/QTXbHdMIbBd67ejVERt4G1e7odotWpZGtTJrhxy2mnctCHGSSWyJerH2R0BnIRl4F5pbL6yyYKAfrOfuiwEMpbfzHHvN+fR/Y1LmGCuvNE8foEUnTkeEzLIlMNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMDPR04MB075100.eurprd04.prod.outlook.com (2603:10a6:20b:749::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:38:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:38:19 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 25 Sep 2026 12:37:53 -0400
Subject: [PATCH 4/8] arm64: dts: imx8mq: remove #address-cells and
 #size-cells in dsi@30a00000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-cleanup_dtb_warning-v1-4-f999fafbca60@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790354274; l=1131;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=T3t+GWq4MQw69zRHEG44E/Fx0XLSGRNOz8Kd6HtEDNs=;
 b=P4GhcOMILD8sJurKPvVnLeIZsPCnB+k9CmeWu9NIj3PZv4rrpeqs2+/WxfsDgMI3KM+IahoBx
 FtNTHlXMW/UCn/IB5IvRL9HrX9uvhQh4JOpwDcoUiVcbNHt/5ESZpSW
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CYXPR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:930:cf::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMDPR04MB075100:EE_
X-MS-Office365-Filtering-Correlation-Id: e26a6ca4-23e8-4d23-52e6-08df1b23680a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|921020|10067099003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: ZIvdSoirHBA8VUC5CdXpXIWmUwaUGajxl01XtaW6Lp5LWC8yp+wGLAIwxxxa0kEnxqvTnaw5EplEauxgw2XyWwj1OvTXZJfP/glTWjiNn9wafqlFwVwXK74jlR6cqlAlNFyWeGbx3hbbi2DjR9BEx/Z1w3fb6PM34ROVTGI+hB2e8neQD8IoHEcXIOl6/BJkE10XyDWpqT1XgpOCl8dmJOJtVBuk42q9QalRD7gO56x8Ge5tg7WzANRYnoB+ehprh4FNf1ho2/11lBMG4oShyLaLv3+MkYIk54a6gL4ickYdsICUoziDm2Vifaa5DwQ8IPiWLb+st+h0wX/CwT156FmkLLGICHFLtRZDVdnL+CqGyPB9lzSHa82536Dc96VQqrU+W+hsRd61YStO8O3dJR2h+A5Yzz4dRFydYcOQgHK9S1+4a5Eo69TEWf7HCMTI6big44eYAcUhTbdDx829gR0sY7i+FyZtxDXoGU3GZYP8U23nhXn6iJTmyUaA03TPWGXKi+7Pj2Xc9HuL0II6MNTjHzW8JX82qFfWFygxSXLiJnmhRWvewhZmp4HkaikGb3MeV6z6NvkYpcz5oHvDxJuP12DPQOWAJaeaQdvOXCzm2uA57M1aXoH6cwYnMWqJ7BqX4tXqYBnLWR1v2G+g6VaZHEnSwi27N9DhWOnDy43f0tre5+kzpR7DNM9y71EFvRqsWwds+65l2RcD4TIO3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(921020)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGJaaVgvd2t3VS9OaDFaaHJjOGtwaTIrWVpjYlpuRHpYYkpzM1dPZnJQN0Rv?=
 =?utf-8?B?NGJhNGhaWGRvN3c2QVlBSldtUnZHNkhtZjJ2YzZwcnZLSW8wWU9uLzd3b2dq?=
 =?utf-8?B?ZndKTHk4bk56R3Q5VmRSajhJYWVrSnVaczdtMlRMd2w0eDVqMW1zeDhkaHhs?=
 =?utf-8?B?Rk1NYkQ4WHJVVC93QmxHRnFvVmhLR2hxVmNWdUQ1dVFDWk42L3JpY0Y2UlJ5?=
 =?utf-8?B?cUdOajY1SVJ4VzNidnB0TDJMZklwN2x3Nno5SkhyNG9jZE9GTUtnTkxYR1Fl?=
 =?utf-8?B?UzFLVlhkV2gwOU5IRW9EOUFWQkpGb1dIUmdMeUI2L0JIdzFJeWFhSVRZbGlS?=
 =?utf-8?B?L1A3MWxaNUwzWmlRVjdnZFJubjNqbGVJcHhwalltNkt5RUo4NkxlOHR2WUor?=
 =?utf-8?B?RVJrenFlS08xMCtjdWMxRWY0b0ZMbzBXei94UzU3UmJUdWZZSkc5SWpNN3My?=
 =?utf-8?B?T3JWSUFGY2J4d09YUmNCZGRUN1ZBSmRsTXV6Rzk5TGlDNkFQMUV1cEtMK2Fn?=
 =?utf-8?B?dm1PVzBjWDFWZGt3a2IzQldKdFo0OC9WOWpuRTVmeWlyeXJvRlFQTkJOQ2to?=
 =?utf-8?B?MTZ3ZlNGNituS3VOdUdoWGNjV2tCSzdLcUt0QWQ3cDBKVk1QT1RSQ0orb25T?=
 =?utf-8?B?L1FwZjl3aUYxRE4xd3dBbW9wZkRPZ0s5M1hra2t3SkZpdVJudFRZYkJXWWJX?=
 =?utf-8?B?aTZPSHhhazVBcGdiSzhlL3JYSkkvNi9VcWhua01vamN3VE5jd2NBa1hXYzFy?=
 =?utf-8?B?eE0zYnpFanh4Rkl1MUluQjFGSkVhN0JEVldXNFNtMFdOZXhJcDJYZUhWUm10?=
 =?utf-8?B?eXVaTldqU1VDQnhnSEZOeHRJNXR5TTh0Q2hscWFJdmVFeFdNTFc4TzhEWmgx?=
 =?utf-8?B?ei9oUWdCOVNUVjZwUHRidVkwY3hWSmxvd0ZFdkFiL3hBZjlUUW9wZlZESjlo?=
 =?utf-8?B?Z2pXMW9SNXM2SkJoQnB0bWt4UWIrNzlMR2NQdk1VbE4zV3FYVmM4SjJFL2d5?=
 =?utf-8?B?Z1oxK3NSVHN3TlZUYUMwSXA0TzdIUlNXbitQQ3FOOFVtdkxhVElEcjkwKzlr?=
 =?utf-8?B?TEZpdEdKNVVnSWxid3VxRllJVHlTbXdxb1dJckVHWEI1akEzQmVrUjdsdHl3?=
 =?utf-8?B?TitETzRsWVZNbE8ra2wrZlRJKzNNZFg5akpOR0dqODQ4Q3VKeTZDWExnQWtk?=
 =?utf-8?B?cHRmVWFqbDFESlBMSnlPZUpYSFpMNUpTeVRZbHNOeEJvZ1BsZnVSS2c0aXp6?=
 =?utf-8?B?Z2wvcTdsT1RPeTBhb0VMbUdGZ0JJK3loS3ZQZWVCYVlZSlZSWC9yR2VqVW0v?=
 =?utf-8?B?N3kwWHNXL1NzYUREZi9mc3VyVnE0eHNpcGpOQXlYY0Rna2JtT3J4T0Z5M0Zt?=
 =?utf-8?B?WnYvYks1MDcvdW02ak1Cb2pQa1JkRWovNWtjK0lCYWw5d3ByUG10d1RqYlc1?=
 =?utf-8?B?MDJlWjZlSTZHZkhQZ0hnTFJKejR0WWRncXlQRTV2eUtobUltZi9GYUJXUCsz?=
 =?utf-8?B?WnFWSEl5dytYWTRadUVFWEE0RlRtYWI4aGx6UEZ2UFRBQmJzdlQvMFU3cDh2?=
 =?utf-8?B?RjlaZXBqbG01ZHdOc2dhMGx6NlV1S3ZMeXhORlF6ME1obkZyK3hSTTNzMjIy?=
 =?utf-8?B?WnhpVHpXQWNDQjNQRnhMQytyQnhFOC9hTWlwcVZhc0hIVjFud0kzaEpvZDM1?=
 =?utf-8?B?dU5XTG90Rk1MckhhYWtFN3lDTTZ2SHVjUk9DMi9MZ2ZBU2RiV2JJZlBuNDRR?=
 =?utf-8?B?UHFCdUppd3dGOXp1V2RzcUdDVkE1NXpmWWRGdmEwSFVDcFBEUlp2bERxUW5t?=
 =?utf-8?B?VzQ1S0JlYlZzZ25HTVFacXN0ejZlTkk4dzlwQmxKMUwzZVNXaUlMQmpmQSs1?=
 =?utf-8?B?M3d3aXE4bTBGelRTYVVWTVR2aFJYbTlpbS9HRkhMY2ZjbTMydW1CY2F4eDBr?=
 =?utf-8?B?QzA1L3hBclFwZzJOY2Z2RTZoUFNuaXlNZ2VueFMycWJvdmNkSFBzZUVrNmhN?=
 =?utf-8?B?UHErbW9CZHd5OFVGRU45Rkd5Y2VXcWZnWkRsZ1JmcUMyaUNST08xQkNaWFVC?=
 =?utf-8?B?ZzNHSEV2TzNMYXE4SG42NGNoT1lrYlBTa3h6OWxON1N2eUh3NlA1NXVrbTBH?=
 =?utf-8?B?ZmxadlNRMjh2TGFGRXoxMkhBUDNackpIWnNaS1lzblIzd2NYclQ3NHdOMTdi?=
 =?utf-8?B?eXUzMG0zOXJZUUFCT2tzUjJobkl0REZ0NVdsdW85a1RVc1hsV0Z3TXVTOTBV?=
 =?utf-8?B?V3NGS0pFZklOZkJoT0dPalN5NWYxU0hzeDZPaGNUY3laWVdSMHQvaXdWTHVo?=
 =?utf-8?B?UmVMbjRFa3ZSQWlpSU03UXRIUEY3cUhWU3J1cmwwRXRDNEVCNUl1T1BMZEtv?=
 =?utf-8?Q?/J+KOVozViYNQ0I+QuyxNk5srrWMVyGKqGtZK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26a6ca4-23e8-4d23-52e6-08df1b23680a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:38:19.6370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kU4sBNBzpWaVhQO9Izq9KPIS3fIAoIf5QcqmDfyBDx8hedOMHW5mMor8qq6SQwBmBqUEaeaFyKel3rw81Vukikd/aS+upABMDC8iRA6P/kJOvT+SFViCqL22OMHTrtru
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

No children nodes under dsi@30a00000, so remove '#address-cells' and
'#size-cells' to fix warning with (W=1):

arch/arm64/boot/dts/freescale/imx8mq.dtsi:1247.27-1297.6: Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/dsi@30a00000: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" or "ranges" property
  DTC [C] arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 5545b5b20ab2e..8d53df2be2280 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1247,8 +1247,6 @@ sec_jr2: jr@3000 {
 			mipi_dsi: dsi@30a00000 {
 				compatible = "fsl,imx8mq-nwl-dsi";
 				reg = <0x30a00000 0x300>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				clocks = <&clk IMX8MQ_CLK_DSI_CORE>,
 					 <&clk IMX8MQ_CLK_DSI_AHB>,
 					 <&clk IMX8MQ_CLK_DSI_IPG_DIV>,

-- 
2.43.0

