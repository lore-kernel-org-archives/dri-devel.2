Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18B9C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB2F10FB90;
	Fri, 25 Sep 2026 16:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ws04nd3N";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013013.outbound.protection.outlook.com
 [40.107.162.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B929910FB90
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rb6ARCMaVxRI9703pDC4K0aWbTN2IOIfjIsvTPJ1GhwbLz7OkMhMWDZBmRKrSHYZ46j4JgwW5KBLnaEwR8/easIqDcWGYSD3EyTYQ0U75StAHUD8DFUxOH5cABvF+hpRHDVNTyTulgqFiJmW7PzkXaKaqBN+IdU9VlqBiEnTFKD/zHOSLgjV5klsUAoY12Q0R+dKq6nuGeH0yRheh+NLGm+0RaycuIEwvm1Xi8Yd2Wui7aV8Fi5yo8qaKhltI60OAvaJUg0i3PcgyLgWltBVbzPoStmBddkJxxR7pwsy7fxcZKFIizHBqbFwEtSv5SjPmMju/gnTNfRPMwkO4ddKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN3kpYhSZ1OIEJUvrXpsrzWNrstw2PDBT2mD0eSk2ak=;
 b=VbDwhhBbgphLQbPH2bLfY1W/NSLZUG9kh5SxMGEwYXNDk284dy70jZf1WOzrlt6jHX/Nq34LTXID1Tm/0JacJrZawYZVYljEoJOCVjCkF9Dl7UXAGWEo2jrRzCSukisruQCIOXjpfgkFlXK2vyrhF/RHCE3WcDlzSs+kYqh9qYTS8Qg97pc0nHykuMHMK7q/Ju4qfJnRapWO0NNUP68V+R1/uWj9hsyo72AM7+cMTbI2amI6AjXDSZ2g4YhYMDoDjqIfMykNAWBZ0q44LimmBtY0j396nbaTwkOi/wVHQO4qjMRDJF1JVzro1XXV7hoRxX1xKCKXBDj0AK85zqFoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN3kpYhSZ1OIEJUvrXpsrzWNrstw2PDBT2mD0eSk2ak=;
 b=Ws04nd3NQuoeryf46grkpt5JXNaWFIRJMYZgb3F/V5k0bi3tOdmWia0KwgvnA+hj5LvAQNjP21m2aaWTZleN0NAYAsGXsL8DwtmyGE+rAsXK0VEj8IVHJYRq56Yn+UFhEnWUmhcLpajdOXeCBDsiCWKxwyqlE2zEN3OF6gZzNNQnJIb5GaOVj6bS9TtL+9XqiQyBQipAoXSVEcEqdM0Zgi6BPml8F1JTZbzkrB0TXIljkDrrT6X0+7YxkcKhCfDVOK5NitQIQEZCXKb9PwJ+8uqED0IYpoA+LoILbXqLZxXHbibE4vtgu+3HZkWtaDm1ZV0vqW6BQQ3ufqqJowKrXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMDPR04MB075100.eurprd04.prod.outlook.com (2603:10a6:20b:749::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:38:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:38:33 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 25 Sep 2026 12:37:56 -0400
Subject: [PATCH 7/8] arm64: dts: imx95: rename bus@4c100000 to hsio-bus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-cleanup_dtb_warning-v1-7-f999fafbca60@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790354274; l=852;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pMmnAKhchVf/8+2UC8kKWbEnKfE3mfd2UHpfq9bXELY=;
 b=IHIfaFTjvdIOA7mowFUzFEhbsG0ALQFPMfK6DprLsQCspc+rzMOkbjw00B4c5kULKz1jzflXN
 Nev7zPXoTlOBwGR/HHi6+rdoO+Co7XvZofjg0CPENzlb+WkIBc0as+p
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CYXPR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:930:d3::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMDPR04MB075100:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c50a931-3f96-4a1c-3578-08df1b237079
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|921020|10067099003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: JSnpeuNbKHTycrUHxbHlFLfr7nAXZGvATAX7mdNwmbspL0TTNGkz0XbMazrVsY5WTDbk2BSGptvG31LxM5V89NcKEuxn3m3oZBzhZ27Tw0iaJzphVdc0U4bGEvO27N5oGazcsbIZ6r1C3VuAGZrHw8nH4GzFrB0W1wQuwSF2CupUx6ciFIlYeO0NUG7DDLSkjUY0xU19g1sWZKuIxz7LPA/AN+Y+BvDGAsBjgR/wwlPX3cboBN+Gc75h9YyCZ+lqXemW0S9ezmKM1FS1a4o/bxWrMvKXYKYjKyYRjp/ear+XfYftzmA06vhpUEkp+l1Mfi9PpZIvlGm/ola63LpCiHJfQK/Munxm30/ehYIJzuoY5/9SQ/2xhaUg1EHeNXy4GtoP93ePayZlEgsYNhUkH7G/B4CF04fQYPLMgQbofSRya6zDabgEvCiQFWaA+IN6dGc06dckUZz63JYBR0cUDiD1NRwOQeyKwqKFssrL3v2YopmL1y8FC9Xx4ddFIwncKToGH7gDtUf0ldjqQynNPjot71tR+MWyXM2RqrTELw121uCI08somR+FpIiBLm1Pi+HVqNj9Cx6ybN2wCGZwCOsoUVeyz7cUi+F6DCKI2GGR5POJQ0BUdKBNWlh+KQe6fL47UmXr1bEW9Z0sRYymuhfYMBn+hYwt6Fq2V99koNafYLswxuuIyF47f3ca+z7r4bp8xX5OGjihXRkiPO2+7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(921020)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzlhNzdSY0pESHYxVXNaeGVoMHJyOUdhZU4vUUNGQUhSclRqR25xaDRHdjZu?=
 =?utf-8?B?UzNNbEpNV2Q4bzgzT0drVTAxWU1sdlpZSFBuQkp1S2d2WFgyY3NYZmhLdzh4?=
 =?utf-8?B?WkxENEtmSWhsZFhjd2lPSmNDTXFZSEZGUDNZbElVejlqcWN1TVJ4UTlRZGp5?=
 =?utf-8?B?cmtZVXV2dkp1dVAvUTYxci9ja1crTW9ZcGo0Mmd2YzdGUjBiRXNBKzg5SzhT?=
 =?utf-8?B?M3RUNTR2SHdiMG95dmYzOEFLY3ZjdloxTno2NGdDN0dxS3BNOEp5a2RpQ1J4?=
 =?utf-8?B?a2VEbXFjS2ZXQjg0U1dwOFZUU2VwLzQxR1RIYmtDdGVGRDkzaXdSOTQ1MFFL?=
 =?utf-8?B?NXgxM2lDbFBqVGdMdkp5cllDeDZNTlpiWXQ3b0duV2lqazRWcnRVQzNJZ3M2?=
 =?utf-8?B?MUtMREt4MHVMMHJVMTJGUHB1cC9IM25pRUVOdlJEMVdHV0t3VUliYnMxNlZt?=
 =?utf-8?B?V2FQNlRXa3Y4ODJ3WUpHbnd4dTZLcXJqMVpCUFhYK01mUURJMnh5WFVOb2dx?=
 =?utf-8?B?TU5UT2V3bWR5YmFVZ0szODIwN2xWOG83YzJMVE9TbWRyOXk2Y2RhZ2h5aGdj?=
 =?utf-8?B?YmtNYTdFSmhhMWd3RVJFdUpHN0dheEtLVktlaVd0eXR2TzNRNjFaZnlyelhY?=
 =?utf-8?B?Nit5clVHVzJaOWU2ekZaQ1V4dFdQSFpLVmdnbkp2S1BnWXlIQnFwa1IyRkov?=
 =?utf-8?B?RDNKaVRha29ZVks0eFdHellaak1ERkpmVHQ4TW1mZHdPTjJkNmxkSFZiZjZ4?=
 =?utf-8?B?OHVoRlpSWFowRkczZWdIQzR6MU9nczl0MzRUQ2RMVUxwaVQ0eGx6WkVobktV?=
 =?utf-8?B?TW9ZbEhEeXJJVU1rWW50UnZZRlNGMlEweVRwSUVmTFlOZm9RRFFFYXNHTnFv?=
 =?utf-8?B?NHhtYVVLSCtpQ2p3dUt0OGFadGhZS29ZaGtZT3hyUWQ1TytZdHNRUGc1Nlh0?=
 =?utf-8?B?N2pqOWNuVTJoTGF2a0FWdkNhdVphNkN6UnA0RWtOeFVKdUhMaWhEVHB4RndX?=
 =?utf-8?B?dWxBR0huNXE5cnpqSDZCdml6Qy9iQTNJU01SYjIwZ1puWStCUTZCSTJIQ0Vl?=
 =?utf-8?B?ZUlHMVJiNEN4NFdJSERqWUp2dUx3Zm1mL0YxdmR4SVRxVE0vMmgxS2k1WTVQ?=
 =?utf-8?B?RFgzdXdqWXVpNWZsbkFlRDhoTHl0ajQySm55eEhzdSs1M0JMcCsySnpscmtm?=
 =?utf-8?B?QklKSnJoNndyY0c4YkNzdHN1UVBaNDR5M01WbmsvWVI3RkN3Y3lJaWpBZkI4?=
 =?utf-8?B?Uk52dDQ0TGIzOXdVYWErLysyd0d5ZXdHMUVMZVd6RkhoMmRNcFppN3dScGdM?=
 =?utf-8?B?VFRZTVI2RG5wN0M1eUlYR2ovVHdIZVRxT2dSejJnVnljUzlEM283NGNlWHND?=
 =?utf-8?B?eElueVh5YXZXK2hSV2dmeDF5L0tVeWxLUVkyakpjY0ZMeG9oajZzUUJrRkh2?=
 =?utf-8?B?ZU5ZbU13cU03UkRVQU0xSlJLeStmdk1wUlowMllhb0p1WHAvS0xybUNGN05n?=
 =?utf-8?B?Y0hkVDFJQmx1T1ZsL1JadzlyZ2QyWXFYK0NLbVZ0cEpBUWlpa2RiciszaGpm?=
 =?utf-8?B?blozQTZmM2dqbFZHdERFMUtLdk1kdytPQmdIUnozNUEyNy9xelJ0T2duRzE4?=
 =?utf-8?B?YjF3UGcra0ZJWTdLZGMyTEg1QUhjZnF5WU1sRWVhY09WcExaSDcxUm9ZRDQw?=
 =?utf-8?B?SVZ3aWg1RGNRYkxOck96QUE0Sm9KOHlFVDNucVpFNTB6dE5BTEV3aEN2M2Zn?=
 =?utf-8?B?c2E0TEp6aWQ2VEhhVkFWdEoxT0JTUTBrUjdaN3I2RDczc1pHQkpCbmFadHcz?=
 =?utf-8?B?RUoxMkhqRy91eER0elpsM2Q1WTdnK3Y4dDU2SHNpSU9QdW85L2xDMU51dWZK?=
 =?utf-8?B?N0F1d005SnRmWmFCS2k3Z2FZQm15OXA4YUZjcndRTEhZL3ZSdlV3b0QyTUg3?=
 =?utf-8?B?SmlLWFVOTVhydThyZ1JGVXNIc0FQM1l6RUhFSnNNVVYyeWhkdXh5N0ZFaW40?=
 =?utf-8?B?d0JadXplSTVjbmtuVWlXZDA0cEx3WmdCUWIxQmdodVVGbDlJKy9rNnV4ZWcw?=
 =?utf-8?B?VnlJenRJRkhzVjk2ZWE1cnR0cmR2dVlJMktqcWxzU2ZVNkhmRXlNTWd2TjFW?=
 =?utf-8?B?NmVzdnZEbFNVbVpuVnJ0NmRMV0NuYXlaelhNMk1YK1VWSWdoTEIwYWJPWTky?=
 =?utf-8?B?TE9kRHJ3VjZ4Q0xaNHpDNEx4aTJCUVBQTXZqQTJjQTFZdkhoUXF5Zkh4NzlM?=
 =?utf-8?B?ODF1NmFPUW1FSllwNUl2UVVSemNzOE9xdDVhL1UwK2hMdlAyM0lFZS96UHdF?=
 =?utf-8?B?YlNWM3hGSzhqREpqc2tPalh4aXliRTBFRVRVaFNWSkhvMjB1SmtqWlhVTEJM?=
 =?utf-8?Q?lrqIB23NTgns6qINtQAgxGnpnzGSQQ169OEol?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c50a931-3f96-4a1c-3578-08df1b237079
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:38:33.6247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JnStfilXaghe2dsSc6t0PaZEpbXWiZ/OwOfH4HmK8q1SGOLEFiASjO/ihS/MDa6iw2DN7ogQtoWtSizNdYirnqhKoEwundhKKbXSuzC65u8L7CCWJlz7glECwg2H2WM
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

Rename bus@4c100000 to hsio-bus to warning (W=1).
  arch/arm64/boot/dts/freescale/imx95.dtsi:1878.16-1907.5: Warning (unit_address_vs_reg): /soc/bus@4c100000: node has a unit name, but no reg or ranges property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index d20c2498b9aa2..b8711f9f846ce 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1875,7 +1875,7 @@ hsio_blk_ctl: syscon@4c0100c0 {
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 		};
 
-		bus@4c100000 {
+		hsio-bus {
 			compatible = "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <2>;

-- 
2.43.0

