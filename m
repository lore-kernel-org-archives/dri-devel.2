Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AA9C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE4210F113;
	Wed, 15 Jul 2026 18:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vX+XYZvI";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48BA510F113
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQpjsxGwFiAs6BrYB1ARXmC6EN9By1Dbou5JLEzIODDb/nnjtDGYm9uVR5fyUwSjTjInCNiAE6zyLcwMcHamFlO3w8B1EElNV2HYSJqOnf1Gt5JzXresQ1reqagp6rrHwoGC4fd5dH5H5dDtPF00sotkSSD7zgRQHr6CaIdtjXQYsr7EWpdZvBSeG4R2+udN0L9sw+uWBj4dyDlUUyhvKAIeN4B24YcOQvgQf7fQfKukO6bw6EVZNIN0P6DbvfLPJTKKjePgaY/C5nUXvaLPJkx2ZDbcRY0F/fFfK7y0GHly4bTYGamEUZAxcUIH01DHxksj9R3r+A2IQ41/LUROeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw8klTFgtTRE5lgAA0wnv6CPrkTp5P6ttjw90V76ugI=;
 b=cMox8G3b7n17kIUdFI5AwFw+lNTUQ3BF9VUPNSUcronbqi6HHmidk6iMVgMrzSGG84KwMJF0mQyC5CBaz7YAQcYyROk8uEGKcak9KoJu8beS8PMGBye7VmEcZojJMF1PMRIJNOUjI+kyHosLGYGZtIOnhazATUZ96P8MzkH1xYoXgytgVS99WiiWZQeOYNZalJTYwxCrF/f5L/oQBLdl6WyJeyGPw89DAUsch+TPcAURZdIkrsz5xDC8590/fLCNfi18M2VuF2v1D1+s+5yOjeYAnFBLy1flvVNPOCoB7TXuup5xHtbk7TxpAeWPOo7aqU8fsf9YCroYI7utmckqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw8klTFgtTRE5lgAA0wnv6CPrkTp5P6ttjw90V76ugI=;
 b=vX+XYZvI66fdRnVUjdcK3eg9mAOJ1NrWNqdrrpvfHV5gBNHI2HaP7m7ToL9ggXFVp5EcP9ZKSHbCAqKDNh2PpOlW2yAKEBsFRuxKl/rz//b0HoaNlewaq4aA658Rc0sqowKY92Jp9zrChZRemvwkquZdt2rZzW6yMQu1PGdNzQ66J6f6T/O4ukyN3i209CzzZu4T0oyBdicAUBexUG1S2AY+MypgEZ9bw23SecAOyoXYZKjy2GUolBea14kbnosg70sXu19AU5s7SgYlJawC0ERCh1wBLnm5X3LBUtwP/hrjraRLb6ylHAUHWb3WwuUrese5axkA07ul9TPFD2BEKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 18:35:14 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 18:35:14 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 15 Jul 2026 14:34:49 -0400
Subject: [PATCH v2 4/7] arm64: dts: imx8-ss-dma: Add lcdif support for
 i.MX8QXP and i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-dxl_lcdif-v2-4-da797562636e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784140492; l=3006;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ok3GRcHkMyHpRJwoEjYmCfdL9Fi7mkY1RcMaWKLwW28=;
 b=MtY/1RTXGItPx+TOKGFoXK++qJxI0wULyaajx18xsrl7KBXe1fLRZQc67edzGQRwLusJHtUcK
 606UWr+jk4SAP8vmVrqyAW/4vIPshCADCEVv5Jkm6UIHoM78lj9iboR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:806:28::22) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e67531b-e89f-499a-dc07-08dee29fcf44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|56012099006|11063799006|3023799007|18002099003|22082099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: 9KKnYf0I63DeqyjEy3CLiKmcHzNo3yvAAarUBJI3/12z9RUZdziMMcgcmgYdzGlMhPHyW9LxUHQ0TD00pT3IrClPyKdEHnEkGp059bn6axGhhftGMuUYi11OSVncymlWL66D6oTtLsCfYW8uGdKXfNcgFr7wpMb7NS2tlakHCpT2am+wgGacTM6I+gC6JFz5kUpdRWtOkFqJe/sgIZPocKr7f+3ppNfmDVxVJeJn7785EYxNKy2GEgLnrUBiedlPlXVMZmJzTmVBQpmhHlqkmN7WO0Me0sL/3Q6ZYuDQsj24r50EQsmqyb5jKz5FE+avWpa9Ybf/C8NPC59c+RLYuw/SeInSx33UykaGaubAIMaDNfb+N71clRIXe35m8m/e4LiTGz3EJPVkEFLZZ7Zgtn4BqDLdgK6oUCrla7SgxUs31YumKPyxEg5jo5uHDNYpN+NwWzrEcPzlOfFQKt6theKulduxstQ0MhF363leMZZ68o7cPP+8FVdbEIkzqyO1Ur1EHDS6bMWvqNdYMs/1krGDW+RS4CojQNuM6h3J6r6qTDut3PWKuBgK1daDg5BwshfB87cIF5kbuw3gA9cuFv0cUqIruhCPOAkfI5SfRN9n9F7PdVOK+j+hprq7VHGI25Xu63vhwBfKqkz+DL8ON7eWFJB/6tSilxO0xvHSZOnrQj/ayO/dixUdLvPQvXzajAbMNvPmDtqx8L0PbE6WBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB11791.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzdnSnlocjlhay9WbXo4TlQra01rdDRxNDMxZXVpbkJxYUoxcGVLTllEeGZO?=
 =?utf-8?B?Q3EvdXlFU2JLTXVzR3ZTWERFWU80YmxUQ0hiRU5LWURxdWJ5cTdkVWM1d1Rt?=
 =?utf-8?B?NWUwM28yeVdRVnBTOGJLVEJEWlVHamxuWGVnMFcvV2YxTnp1eW9XMmUybVd4?=
 =?utf-8?B?cGZEU2VncVVvVm1TaFZOYlNwRjNUZ2NYYmhLVGZEYlBsUnhaNUZ3Q2tYQUxv?=
 =?utf-8?B?SUtQVU1HVU02YmtPZHhQeHFKSEFZMDIvejdTTWVZd1dTTndTc09saWRJalVR?=
 =?utf-8?B?MDc5dnBCSXpUL2ZMSkZtRWFDcGh4UGNaMzhXSGF6dUNwd0d3OFRuR3p4b2lx?=
 =?utf-8?B?L2FkTmdkSVUrZENCU0JJZXdqLzE4cS9KV3VHSDR0dDZjMUJXeU5kbkhSOG9Q?=
 =?utf-8?B?dy9pWmlKN2htT0lReklLM3dnM29hQ0RkLzh4dWxMLzdrc0tZUmcyV1lpUVJo?=
 =?utf-8?B?REdTbTFVb3RMa1pqRnBtZ0F5c1o1ZU0ycUFvS0dEbko4SlR0SHVHSDAwRm1q?=
 =?utf-8?B?QllmeCtXZHhFdmlSR1djYlVwbEF2STQxNUZkUjN4NXRKM0Y2N2MzY0dsYzVo?=
 =?utf-8?B?dFdYalA0U2l2TkVTT0dpRVF5RmpPaVRXdXdSM25qb05EK3Bob0krdlF1RzhZ?=
 =?utf-8?B?bmdTb0tPU2VJOWhxZGdFdGpEM29aUktIUVMxU3U5WGE3aFkrSFEwNnRpenBF?=
 =?utf-8?B?eGhWR1gzVWdtTS9ZeEdVTlFNM1FsVko4elM1b1BrNU1uQmdLakhDUEtiamFs?=
 =?utf-8?B?MzlLTDJzSlAyWVJ2ZmRCTElISU94RVNHcFk0TkFzcWFUeENSOU4yZTVhSFZZ?=
 =?utf-8?B?aE0rMGc4Wm9aaE1qSVJncisrYnZvUElJTGlJaHRJNCtGcFJaeU10NDBQNjJu?=
 =?utf-8?B?ZW9DZkhicGUwcDA5MVJyS1NDZytPNkZLNEZMckNXTlFRQVVTa1ZvVXVCcVJV?=
 =?utf-8?B?RkFXbkRNUW9EaDBLOWJlTzM4QysrTE5iNGRBa3RmZDVVVFZrcXlPTXpiTlhL?=
 =?utf-8?B?VW1OVkZoeWUxaWFJTWhlaDlmUWl6bW1pcHJIRGMxaVNDdmsyUlZSY0pQcUY1?=
 =?utf-8?B?VzhLMW5YUWRWMDBMaEpCSGVVcXNURURBZTA0ZDBJK082R0NsYVVNVk9BNzFy?=
 =?utf-8?B?cUlQK0FRMy9tYlVUTWU1NFJxcmMyUWNhZWNuNk1UT3lweG9xZDBTaU53NVp6?=
 =?utf-8?B?amp4WkUrSDRwTUZVOUl5R2ZYbTBkaWlTWVQ0c0JsVUsyZVk4VWN1Z0FrbzdT?=
 =?utf-8?B?YlZRWStla2RnRVdHbXRZVHhLeDk3ZnczVHl2OHpKVTZDekRnRmNsRWFZT3F2?=
 =?utf-8?B?R2U5bDNKU3hzWWZyU2UxMnFxaU12cXpkVUQwSVFjdURoZTB4c3oxY2pqMkpr?=
 =?utf-8?B?Z0dXSVd1ZHB5K2hpMUlldlFDaXRjNy9ZWDVSbmpGc3BCVlJ0TytqcVdKL3lF?=
 =?utf-8?B?aFZzNXU1WHFTZUxPUTZCeXUrN05rdkdGa1RucVB2RlhEWnJQdmFQa2ZoZ0tY?=
 =?utf-8?B?U3dwWTI1Z0NEVGIvblpWTWY1bkw1MUJtbkowY2pEMG0zWUU4cE1MWDRYV0tC?=
 =?utf-8?B?OW1VWlc4VStJMlBkOHY1R1JWSTNoamFlVHIwd1FKY25MWktKZXNaWVRUSVhG?=
 =?utf-8?B?eEgzK3Z2K2VVYzJWNUJRczBscFVSandiOWtHTFV5WkhRZm1wbXd4b2h2TVdX?=
 =?utf-8?B?YmRpRDlWRkJNWWlXUFNScjNKcWI4M2lwU2pUeWlUSlUyemtLc2hYUXZLczVr?=
 =?utf-8?B?NjllRjFrOXNMdzJGeW9hY3B3akpLTktjNUtwOVllWGlHYzI4M2dBL2Y0SmJ5?=
 =?utf-8?B?ZlRvUXhYYnJnNC93bDlGdTVtWjJWOGVSR0dZd0hqYSt4dnRWZTQ4WWd5OHYr?=
 =?utf-8?B?NVA5Q0t6S1dKM3ZpV2pYQUVnZzUwOWVlTlJFWnBrS05XektQM2Z1dG9YZlo2?=
 =?utf-8?B?OUUvanpMeThBZmMzRFBpUHpMTFhDRFZGcEtoOXcxSXg3OEFNL2N4Q2ZwdnpL?=
 =?utf-8?B?d3Y5QzMrbW95NUQ1S3NYb3hOamxCSEhrTU1NaUxTaUN5MUgrUUJyOFJmRnYr?=
 =?utf-8?B?UStMOU5SeDZnc1JKMStJcXo3Rk9LUHpMR0pkYU1NNHUzc2pML3hIdTVGVk1P?=
 =?utf-8?B?dS94Z0pqcHpNL3lXR0dScjRndEVlbUJPRXR0TTE4dzNZeDBiemhjdGVYaWtW?=
 =?utf-8?B?dlIwSEpCQ2ZTUm5ROE1rUHUvS2t5eFJnbWh3UVVXNkdxRFEvWW1CVjhIbTRT?=
 =?utf-8?B?aHkwd1Y4MFhmTVZMU0dHUlJEOHZpdnJLcFdSOTRqUEp0Nng1WXF0K1pBTXlz?=
 =?utf-8?B?bmY1dWhKeW5jY2JCNS9IbS9rL29XM2FUWXl6VHBQQ3U0bSs3TVlvWHQvNWpY?=
 =?utf-8?Q?Wy9dRoACW1yZL2KIWxkWuNMOXzot2HewoLAYC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e67531b-e89f-499a-dc07-08dee29fcf44
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:35:13.9822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrjF0dZKvIz4el94Rz5RZV2wLWxwvCSIRd32FjiHIuPpCHdghfV6BqwXn0d3cp9sjyTyQJZn1Gfd3lWY2g+/SM7K3dw/qAIAW9M2MwAGgdXJSzIaeObyvcsPq6SORgEN
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

Add lcdif support for i.MX8QXP and i.MX8DXL.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     | 29 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 11 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 4de78f870c05c..87082c3fa9338 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -149,6 +149,24 @@ lpuart3: serial@5a090000 {
 		status = "disabled";
 	};
 
+	adma_lcdif: lcdif@5a180000 {
+		compatible = "fsl,imx8qxp-lcdif", "fsl,imx6sx-lcdif";
+		reg = <0x5a180000 0x10000>;
+		clocks = <&lcd_clk_lpcg IMX_LPCG_CLK_0>,
+			 <&lcd_clk_lpcg IMX_LPCG_CLK_4>,
+			 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>;
+		clock-names = "pix", "axi", "disp_axi";
+		assigned-clocks = <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_PER>,
+				  <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>,
+				  <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>;
+		assigned-clock-parents = <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>,
+					 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_BYPASS>;
+		assigned-clock-rates = <0>, <24000000>, <804000000>;
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd IMX_SC_R_LCD_0>;
+		status = "disabled";
+	};
+
 	adma_pwm: pwm@5a190000 {
 		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
 		reg = <0x5a190000 0x1000>;
@@ -298,6 +316,17 @@ uart3_lpcg: clock-controller@5a490000 {
 		power-domains = <&pd IMX_SC_R_UART_3>;
 	};
 
+	lcd_clk_lpcg: clock-controller@5a580000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a580000 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lcd_clk_lpcg", "lcd_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LCD_0>;
+	};
+
 	adma_pwm_lpcg: clock-controller@5a590000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5a590000 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 7a191195dbd97..febf5f8b54ac4 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -60,6 +60,17 @@ &acm {
 		      "sai3_rx_bclk";
 };
 
+&adma_lcdif {
+	compatible = "fsl,imx8dxl-lcdif", "fsl,imx6sx-lcdif";
+	assigned-clocks = <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_PER>,
+			  <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_MISC0>,
+			  <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>;
+	assigned-clock-parents = <&clk IMX_SC_R_ELCDIF_PLL IMX_SC_PM_CLK_PLL>,
+				 <&clk IMX_SC_R_LCD_0 IMX_SC_PM_CLK_BYPASS>;
+	assigned-clock-rates = <0>, <24000000>, <711000000>;
+	interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &audio_ipg_clk {
 	clock-frequency = <160000000>;
 };

-- 
2.43.0

