Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F91C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2BA10F117;
	Wed, 15 Jul 2026 18:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CBqf8mQu";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF5A610F10E
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:35:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZkcITV0gsQPNLIxDStyEjF0oCW8YQXrtsXib6zajijPBB7EKaor8W1W2GxCt0D9tWCFKFE0+xm7PoJCzZrJrAe1iPTrWReLBAO0tjMd9L/0px1hgt8NxqRPe/BVcvoSJPakid54ulOjBOiBvG6WAwLrMNAEIXax0yzbs7ucjyQzTO+cjQFBY2CDbPwhW3DtjBFEHe1hyTS0ZP/lDKE0U0NLoN0hzw/WiX/Us1F8+kFN7egg7VhUCQ5EFQNUFK3epjwzMZSR96xY3leQm+ALHPM7xmriPkqif6wMOO4181RwNuGHas29fntXA8ZqDmr0cOmWLBnS2KNGzlIZwGOSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYn6BaPAi66udsly+ZRI6r04ffBKviXcPoTeQnpc/xs=;
 b=fg6ek2nYboCy8wNR1FvVw2h3E96oVwcxPhLKi/vkcch1/hb690ZvjWnVujQrbW2COhJlsOf6yOii953ZufdKOsa5ugpfGo3AabVZN0VeAAIkq3baMihRC4jT8EzEYdYz2pYWAfpDOktBlT/znCfcDyiDnqtTY4KzYd533vIKtXG/WT/1zEqpEUYFHDiM07PL+51ChWtdu2A+/y/DfGDyk1wjrrSyKvj7pNndAOgY4sX1ydxRDExf0FAhULI4Z6T/BBF0h29hbeX27URQxSK40XDWslBHLfCQ3EW/xYAb2TZjHrxgir0gOrcz++2XQSHTWrZpv34Eta4quEv3kJy4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYn6BaPAi66udsly+ZRI6r04ffBKviXcPoTeQnpc/xs=;
 b=CBqf8mQu71vT/RMskjh1UdADWjcK+LAfZwNaHuqNH/4bnzITTMz0qcnuz/iVFHbmeEV7VhjcjetJOrDpij7asjxG8XcQyczry80tRWaWWREgBzwyDl7BCayOsOrdkMr5NOnQPtvzeW3dysvf9olyzaKSgvIgOWTyxtptJO2wfPU7KqUx1M2DN5BCwtIAkvLZR+bzdUprjBRkniaR9q0RsJSpR+T4/ypre5eK5/avtQMATBok3BzlBNbnDuPyFKkgQztoRg+SmR2wmKjTv2hkAOHsvLiWsm3OR2cXAPRDlsqSLDZH+75Lof21WOeObFiGZ90CqDPOT7WHgslqamVp2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 18:35:27 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 18:35:27 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 15 Jul 2026 14:34:52 -0400
Subject: [PATCH v2 7/7] arm64: dts: imx8dxl-evk: add lcdif overlay
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-dxl_lcdif-v2-7-da797562636e@nxp.com>
References: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
In-Reply-To: <20260715-dxl_lcdif-v2-0-da797562636e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784140492; l=3999;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mwk1STOmIBJQmiztlVyzaZbrqVbYSJsLatIfoe/P18U=;
 b=Ww9X1+HrREQJRHiNktscoQzCp2rzo9TNlE4mu76w1WRfaSNT/EGops/BMz/FfJt6ZHm/AOxrI
 8CqK7MoqB5DD1esVGA1pUMAmjEeZ1hgfz2mnBazL8J8OA02d9dExBP4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::15) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8f9658-b3f7-478f-6f41-08dee29fd72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|56012099006|11063799006|18002099003|22082099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: e8tTm4jr0cwss3fojmds4s7/k/gKPmRKI8rqSi5G6sAEJ/XjIUSpZTLjlgSFtO6eXfqwdEkCwtkF4tRngDH73pzXWwxWeJjXAm42FkK4/by3KgesskqWi485cMurkeIfAesmxC3u7EP/3rDH5ZcmNe4VDYelu77w4t+eahKSjOXI4vnKHSiDm2/bvi/WY8d/XZf1AK2aQoJIgqSQ3ksdDvY8cm3fxVCIZBqCbUcoTNaQpAlCZTJWHBu3cj/1QkRsu6EH7pPAIU4AzDtq32FqY3BNzcrw+F56EaI4OELAMNkUBwuKBplmS8VbRpha2X5LvooGKxUGqAOWMfwomgJuKp9OCBg4ZpVDJk2AMHMWjynKYCKraiLyxb8MWOQAGpGmKpVZiuiKPE6/y4MZkOyG3lfeVI0i6WRhydjkEjFvK7Uzl5TLwl8wnPiaNuoaRZNUXKfqpB/QRtsa2vjM0ehQmTmliLcos3WPmjsC3mRDYvB0ia2rNBTaMUC5X6kNHAqNJy2pXfxC+xzNjV9PFvTyIC8elAFHn+CBx5Nt409XdLN/B8yH5WWv+4au1IPtEdz8CQPLo2OfvQFIOIoyAUVeH/Pq1zWT6Qw49SiZ9z7Ni0kokU8Q+rqUZz/S2AFB3y9w0DyLZ52hLioUl09N7EplyHoBMtplyuyKT6ycrOsc+3aJkgPfv44S8gSo4rjRFSzdmFhDP81RMcA0a3XYQef4Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB11791.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEJtN1k4aDhDTW51NkdlMktteFYrRDFCbVhLb2xCUzVIWWxZdk41R2dxdFA2?=
 =?utf-8?B?Um9tWjhDUjRKQXFpMy8rNFIrUXo1M2JjWXVhbVROU2xIWit5bk1qZWpUSVJ1?=
 =?utf-8?B?MyswMHVXRmNHVm0rOVRLTTBkNGhXcGZyQnVPRjdEMW1leXhDMFpybnMrVHFv?=
 =?utf-8?B?SmhRTHhSUVpYSkZsdFIzbEQ5Z2VqaEZjUlVhdldub3N0ZktDSWI2RnE2djhH?=
 =?utf-8?B?eUEyRHJtQlZzamFCOTdmdXNWY1czU2t2d0g2alBPN1crd3IxZG5kRmxXQ3dH?=
 =?utf-8?B?cVk5Z1Fja0hZVS9KYk05N1VFVUQwSWRCamJ6Q3dITjcwbGkzN0NxZlJ2RlZD?=
 =?utf-8?B?M1ZFUTIvQVVoL1h5OEN2Q25iU3hXdk5MZHYzTTlyMlBCWWtwMW5McHhRanM4?=
 =?utf-8?B?enVTeVBqaE5qZHExNHdGdWNTdVozNEh3Q3JUWTZITmJPWkU4ZVdvOG0venI5?=
 =?utf-8?B?VC9xZkp2bXBuMlFSaDAxTXpXcGFqd2Qzc1NWS0VWRlVBWG9qMllPNmdIa0xD?=
 =?utf-8?B?VGZpZTAyTjQ1U2w1RGZGWUxwcDJVd1pxR2tDY0pYb1JudXkwSUtQNndQRTFN?=
 =?utf-8?B?TjRvakc5RXJ1Z3ZiRjNNZnExTU9Sd1Z6SGM4aWwrdXc1RHF0MGVsU1VjTVJv?=
 =?utf-8?B?cHExVXVROGo4TFJ5QnczdmI3U21NK2NEVm50RFBRdDVmakY5alFpYVZIekZa?=
 =?utf-8?B?eFRHWElTZEs4MkRYS3hYWHZvSGRZbkdJSXRLNmRFaCtpQmhycHJybTI1eGN6?=
 =?utf-8?B?SUdjZ3hBQ2VQMlVxbEVpYmwrTHpFY1gySUdXRUtOOGNZQnp5NE1hUExhbzJz?=
 =?utf-8?B?T1FQcmU3bGp3SEpBQjQzU1J4WUZYdC9KZUlHaGtTVkV3ZVdxb0tGWFJjMmNK?=
 =?utf-8?B?N04vZE5qb3kwZXlyWWo2QnNLK1N5RzBOeElRMlNBM1MrMU9GZkZXdS92SXNG?=
 =?utf-8?B?WEtRTFI4TWhEeDJXUDB4dlAvUVRxUDRqY2oxT3J3TTAxRzFNZ3Y3aWtYVEZK?=
 =?utf-8?B?b3NlY1g0NzByK3VaTWJkbjF1TUdWWEtWQUptbDhYaWxPbEFQamNGa3Bhdzhm?=
 =?utf-8?B?Skk4NEVoMHcyUzhSSlJnVHhMc2NBRnBvZWc3UmV2SCtTcGFnSCtYbUhlSFVh?=
 =?utf-8?B?ZVdGZkNKWXpEbDBIc0FEMU5xbDJjcmZjbGorZVhhekRXNjVZYVMxWURmMTB6?=
 =?utf-8?B?YzVLUjFwS2xCUXpOdWFWTnFiUG5xQUE4bGE4NmxyWUsxaHdGWFBnVndGcklS?=
 =?utf-8?B?RUxhdlAwT2xJeGordGZyUC94VzRFb3ZBeVhOWVNuMGM5c2htSTYxa0U0OVlj?=
 =?utf-8?B?TWx3QXVzSGQ4cVViVEtibEduanMvL3RuWkhqVVdsaVV5blVQNStGRW4yWlQr?=
 =?utf-8?B?b01GTDRMb0M1a1JoZ3NCczlEQ3ZTUG1ld3ZhYTJuZkxla1djZ2lGUGl2TXQ5?=
 =?utf-8?B?MTA4bU9HZWdsRVZIS3BkeWxTbU41cDBtUU5lbEpBMzZMMExnc29zUzE5aGhW?=
 =?utf-8?B?YXdKUngwK3ZRMFBzaUlKd2w3ZlJMRjJibFlRS1dlQjFOeGswWWpBc0JzNTll?=
 =?utf-8?B?RSswVk5KeHRJYnIxeDllclFSMHh2MDZEZzJjSXR6b3RaeDFUaGdzSWhPVUJF?=
 =?utf-8?B?ZzA5QUFhYy9HTkg5WmNKRzE1ZlhHVHNTZlJkNW43ems3OG4wTWVubU8wai85?=
 =?utf-8?B?b1ZXU0lpcytSR2habTkydTVUL29HY09tQzRCNnhtWVZ2UlJaR0VKeFRyU0RZ?=
 =?utf-8?B?ZU0zYlF1RThhUGZ5ZmI1Q0tsckkxa2dIOHRseHlUVHhvKzZKL0FwanFVTU4z?=
 =?utf-8?B?T1pLckVENGNuZ01tQkFrOXVNYU12UmtpU3I2UFFSeXlYSlZNUjdhUStsbXBq?=
 =?utf-8?B?a3ZIckdKaUJDTnlwOHExZHFkazNLMThoY21Tb1dSQ2pxSzRPNm5VdXpHRGxZ?=
 =?utf-8?B?R2lqK3hvNGIxZWdtRVJ1cnZabW05YmFFOWhSRkVBRlUvUlRGVVVuZldMS2pY?=
 =?utf-8?B?Q3B0Y29nNFZTT29vZ1NhT3JnTE1QbWVjb2NoMDZabEZFTFZmRVNOeGtJZ2tP?=
 =?utf-8?B?aTNJMU42QUsxTGRaRElCT2ZSUHBlUWtYY25RNXE1dHpRZ1Z0b2YvUjdDeE4v?=
 =?utf-8?B?UDhJUS9OZmFSa3hkcThVaXpDejdRRUpiWENra2FYM1BuK3pxb1ZTYng2ZUQ0?=
 =?utf-8?B?a2VZQ285TksrblBRNnpreWVMK0VUd3BUaXRneU0rVElhNHA2NnVjU1hVVVJs?=
 =?utf-8?B?dUlwdUxEUXhzanZNb1pDMHdyWVl1OGpCOW9DMUNhMWQzdGdRNmNlVDRPaGx6?=
 =?utf-8?B?bEVpdmFzZHRFNm1BQWVnS2VWazZYa2JiRTY2S2JGNGhoY1RXclRqNUxBaDJl?=
 =?utf-8?Q?gqKvz7TaytaZ283+ck4OF5trW0Y6ZpaT7VgTV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8f9658-b3f7-478f-6f41-08dee29fd72a
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:35:27.2032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/5daQg+9dKIvP/Fpgn3HReBfbHxOJEoW58Ce71B/VQ0OwXjn4zsyuVvt5UQoHMKA/xh/CgAfx2KA/NLsC25rl6Tq9AgVQNomdyUtJ+MmZQeV3IN4cwECZsOkNYlc77U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8359
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

Add lcd panel (waiken,101wx001) support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- remove iomux hog (sashiko)
- add power-supply
---
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../boot/dts/freescale/imx8dxl-evk-lcdif.dtso      | 118 +++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 8ddaab127ab9c..aef7bc3292484 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -111,6 +111,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
 
+imx8dxl-evk-lcdif-dtbs += imx8dxl-evk.dtb imx8dxl-evk-lcdif.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-lcdif.dtb
+
 imx8dxl-evk-pcie-ep-dtbs += imx8dxl-evk.dtb imx-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-pcie-ep.dtb
 DTC_FLAGS_imx8dxl-hummingboard-telematics := -@
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif.dtso b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif.dtso
new file mode 100644
index 0000000000000..080a3f5108a22
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif.dtso
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2026 NXP.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pads-imx8dxl.h>
+
+&{/} {
+	lcd_backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
+	};
+
+	lcd-panel {
+		compatible = "waiken,101wx001";
+		backlight = <&lcd_backlight>;
+		power-supply = <&reg_lcd_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lcdif_out>;
+			};
+		};
+	};
+
+	reg_lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&acm {
+	status = "disabled";
+};
+
+&adma_lcdif {
+	pinctrl-0 = <&pinctrl_lcdif>, <&lcd_0_fun>, <&lcd_1_fun>, <&lcd_2_fun>, <&lcd_3_fun>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	port {
+		lcdif_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&cm40_lpuart {
+	status = "disabled";
+};
+
+&eqos {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			IMX8DXL_SPI3_SCK_ADMA_LCDIF_D00			0xe8000023
+			IMX8DXL_SPI3_SDO_ADMA_LCDIF_D01			0xe8000023
+			IMX8DXL_SPI3_SDI_ADMA_LCDIF_D02			0xe8000023
+			IMX8DXL_ENET1_RGMII_TXD3_ADMA_LCDIF_D03		0xd0000023
+			IMX8DXL_UART1_TX_ADMA_LCDIF_D04			0xe8000023
+			IMX8DXL_UART1_RX_ADMA_LCDIF_D05			0xe8000023
+			IMX8DXL_UART1_RTS_B_ADMA_LCDIF_D06		0xe8000023
+			IMX8DXL_UART1_CTS_B_ADMA_LCDIF_D07		0xe8000023
+			IMX8DXL_SPI0_SCK_ADMA_LCDIF_D08			0xe8000023
+			IMX8DXL_SPI0_SDI_ADMA_LCDIF_D09			0xe8000023
+			IMX8DXL_SPI0_SDO_ADMA_LCDIF_D10			0xe8000023
+			IMX8DXL_SPI0_CS1_ADMA_LCDIF_D11			0xe8000023
+			IMX8DXL_SPI0_CS0_ADMA_LCDIF_D12			0xe8000023
+			IMX8DXL_ADC_IN1_ADMA_LCDIF_D13			0xe8200003
+			IMX8DXL_ADC_IN0_ADMA_LCDIF_D14			0xe8200003
+			IMX8DXL_ADC_IN3_ADMA_LCDIF_D15			0xe8200003
+			IMX8DXL_ADC_IN2_ADMA_LCDIF_D16			0xe8200003
+			IMX8DXL_ADC_IN5_ADMA_LCDIF_D17			0xe8200003
+			IMX8DXL_SPI3_CS0_ADMA_LCDIF_HSYNC		0xd0000023
+			IMX8DXL_SPI3_CS1_ADMA_LCDIF_RESET		0xd0000023
+			IMX8DXL_MCLK_IN1_ADMA_LCDIF_EN			0xd0000023
+			IMX8DXL_MCLK_IN0_ADMA_LCDIF_VSYNC		0xd0000023
+			IMX8DXL_MCLK_OUT0_ADMA_LCDIF_CLK		0xd0000023
+		>;
+	};
+};
+
+&lpspi3 {
+	status = "disabled";
+};
+
+&lpuart1 {
+	status = "disabled";
+};
+
+&sai0 {
+	status = "disabled";
+};
+
+&sai1 {
+	status = "disabled";
+};
+
+&wm8960_1 {
+	status = "disabled";
+};
+
+&wm8960_2 {
+	status = "disabled";
+};
+
+&wm8960_3 {
+	status = "disabled";
+};

-- 
2.43.0

