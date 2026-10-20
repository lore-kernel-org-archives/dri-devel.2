Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CFC606A334
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WlMq+WT1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A07210E412;
	Tue, 20 Oct 2026 20:13:52 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F53310E412
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scszEnyy4XB/wGOZ74qmAodHFqZs+dkcOGv2FAnTjcFHc+l34NMlAp2SAFU2APOUsgvqMxmDkF/J4LumX0EW7VXLoM25SR1hpX/GNk5mm6j3deosgH08zRkv0nZS/7JUetir350uXQ9+s3x80xoV2LpwK9pUplP26wtwqM8NGPZlKSwRbUHX7upw5+95VxlzWshuow43Or/okN95VyDF2VwIb9RESME8tV9BPXunuXLDUi+faD+gaVZ5jlSbjV+7TlKFt2JhOBwgb3JPrRfmu+DC4AIk9IMSBxG1sphI1FmFAwe5f/k0GGqDICRE6Ujy7GEuaMeFKUkR2TbwPMuQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw8klTFgtTRE5lgAA0wnv6CPrkTp5P6ttjw90V76ugI=;
 b=UwDk4YK9YuesXY1i00XQH33CTloLWZPiqNjdMs1XN0jQR7Tnj9ulNs8dcz7xxtVrbd2m2w748jvETpwNahdODkcSn2IPlRztpoR5rwg0vPKpwffhZSrqk62xPiKWKxHqiq2sKckYtPjSL7sa5RroD43eWkx2+Ti71wOim9fSTvb+48FkA2dONcnl9BLRinsWoyRbruHfYwRr4VWFxowJY2Eu7EOmz9CNvwfYDhEjfQDMfgUBjJQR1rMY5TcGGoLRJ+0A1+PwWpafmrZO1d9bouqU6ui0ShxWD3lzkUVotUE3m+YeG2nLVyOjkSZ0sJ7UEF6dktNamDKkESmgeBPlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw8klTFgtTRE5lgAA0wnv6CPrkTp5P6ttjw90V76ugI=;
 b=WlMq+WT1YCzM+UZG0vxZU9LPnHXb+L1N6xV8G88lCxGF4ABwPT8xb7LPAnGWGTPcIpLXHtgBRYf9fnSzH23pNITaLeaKhIpPg/Y7gC5VTgoztRym55yTI1GQVR27YygjhfhFFooHAZcfAmVromdEpvPHIJ83KeuPc2QiF4q7JG8bQy/sTR6ohhNC2E5kvHqop8bFEJPiSrR6l+rRFCo1vZotZw1XXvXnvmOBuUNfrjFGs6Ts2Uy6bGufgO39zt7XF/LKEglR9kP4/uSj9JGhPo7B4tppPE/gMA9rD16TUCn3Cjfxw45lgr9bmhJbRkSnzplrwFFmE43SpkE+Jxgqsg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by PR3PR04MB7323.eurprd04.prod.outlook.com
 (2603:10a6:102:88::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 20:13:32 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 20:13:32 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 20 Oct 2026 16:12:54 -0400
Subject: [PATCH v3 4/7] arm64: dts: imx8-ss-dma: Add lcdif support for
 i.MX8QXP and i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-dxl_lcdif-v3-4-adc944659e14@nxp.com>
References: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
In-Reply-To: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792527183; l=3006;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ok3GRcHkMyHpRJwoEjYmCfdL9Fi7mkY1RcMaWKLwW28=;
 b=ByuiWCiHDxTyo9VyAvYwpWp/TUAUZmxjI3mrYRZzGskxq/KGw+7z55+xjugSdLOWvC9Pzu56M
 uBerwsWBZ1wCc6YKGEl6zZJ915vPPCOlXcvPAlilorz/RUR3xpQsMzX
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0093.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::16) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|PR3PR04MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: c24b8b08-af8c-4583-5f79-08df2ee69b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|23010399003|7416014|1800799024|261009223027099003|10067099003|56012099006|3023799007|18002099003|22082099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info: ete3WQ1wK/V2NIV9Ci66eVqzeVEOcDVdrQHnuGH0cRw5BAMN/y2JUnUYdEU27UVFEJWxSNqNv03+zR5enSs/pt17x/zuCyL668V9NhPSq/g3Qw8UrgDA7QQZrsaVkB/jUQxgu5vPnhuTbZozN4G0Jc/1a5AdxnPQ31K5FUQZsrFPZOHC69uSG9WEzO3ZFIEhl6lvYNf4jjddjr2qTMqlQO40DcaWwOWuTvURjCTiymfA9n7Nn9XlPQDi2tSmC0/6xlUZRrwAJ6Sa4knHFxldkO/SpqCg0f3oRN8Npnuez/e9rpEMef+BDpEPRG1OadhXqAWsTgX9gY+NFhEqUrI6I/hmadbzo5DtVbhMMZGHRV6S3vyT1mjwC1GXMNG/rUpccee6WjaSYZ9mWnXpOZ0mqbme8/7D9VrA4cGxu2dl2tBqaLNkJVZn0IjyU2QJ2MAZ6HOiB0wxEdjriz26U7d7htwWOpQr2F2+ZTHoGgAXI5z6tbHZ3Ze5gvxmC2gRrInZPiwoPw2+CcF6/l68zwVc8OHLvGZ+CgxYpnAPpGZMLBvyKMePXmCUh8iJ6LqcTDb/wBgW5sbKneRYRnWiIqEXyGFXHy0MlcbqMh1weXFl5WN0BzXnAT0y2gztvq3zuN4ZHCW+x3c6oBDigdKUH1lI5GM5/jFKqOGxmMnpX0rYpo61PiEjAv/379K/eGzFgPPrEyEHO7FQz7uPlaxa5mgFZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12445.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(23010399003)(7416014)(1800799024)(261009223027099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(921020)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE5MT0ljZjFTcHUwdEdraWFvTTNIQUVRRnpsSVFVb0pEQlU1TmpOVXhZMnM4?=
 =?utf-8?B?T2JFTEZsSHVKYnE5WFVWUnFrU0JQcE9IYTdKRy9IRXplNDBTeGJTRWNUbzRR?=
 =?utf-8?B?eFN4RTVmc2JnNnh6MkoyblZNRVJPNWpQSjhERkNjOFNoZEdHL1JDTFg2aFg2?=
 =?utf-8?B?MU40M2dMMExpSnJsaVVOSnk2WnEvUVBRcW1pWlR5UGxrS3FKOWwrZG0rMnd0?=
 =?utf-8?B?cFBQT2lHVlV3UitwSEdBNTFobm00KzdyUHhJNFZqd2xHbnN6eVRCZkxnVUNt?=
 =?utf-8?B?K3p3V2lSSUlTRmdrcHFxYjNDbmY4WDYrS3dpSHd6NU9ZSUlRQ3ZzdHdPci83?=
 =?utf-8?B?eWl6bzFoTDdsd1ZqaWFVK3lTeXhGOEpQZm1mZSt5ejBIQnNOM0hDZjF2aElt?=
 =?utf-8?B?NDM5bkQwbU9VeEZpOUdUNXVocFJJei8raFBKbk9PRW1lcHplYTFQeEVJM2tK?=
 =?utf-8?B?WmQ2YWV2TWpMblZsbDFnSEp5YS9YMzJNV1RRcXNJRy90UFpRdnNZNmJWdkc5?=
 =?utf-8?B?VDZQVGhZUTA4OTFhY2hiS0tuL2xkM3dicXkrVmFrdnJhdkoxSkpnczlBVkRL?=
 =?utf-8?B?Y3JFNWpUQTZxVjBPR1hsWUFPcCtEV053K2RnUndrTXhZcE9GdytZS2lSeGMx?=
 =?utf-8?B?TWNjeTF3RU15TDhWdndOUWtYL0RzUlhBSDc4T0h0UmY5ZVlPTXcxclV4TW1U?=
 =?utf-8?B?eVhybmpaZ25kTlREQXF5RkJWUWFTVW1LMUhZUldMVWIrZWFhWjlIdmVjekZr?=
 =?utf-8?B?eUpnVm5LQTJ0dURpNC9VY3BQOFNaMFYyK3JEOWNTeW0yb2JNVFpZZW5Gd1c5?=
 =?utf-8?B?djh3V3laOGxRMVFkWE0rQkVtejFtdE9nNy9Jc3Zrb0pQaDRYQndmanFkSE94?=
 =?utf-8?B?aGxGZVJOOC8ramNXR0dOSVN5OWhQTXBNQVVJbk5HKzBRM3BDLysxSnZGNm9m?=
 =?utf-8?B?UEJjdFo0K1RLeWhWTnZmTjlDSnMxbFdPbUxDMmtuQXBBTjZuT2MrN2U5RFRD?=
 =?utf-8?B?d0RydjNQQWtiVDRCamdwemIxRmhMc0h2SFN4ZTFyUFBSL0Nqc3VXb2lsRDYz?=
 =?utf-8?B?eXNvcGUraU0zdmNkY2RIdFJVUlZJb20zMTB2c2JOV0E2WUxRQ3NYVVdSRUpC?=
 =?utf-8?B?bUErWEJSSEwza3dNNVcreHNLQzdjMUhmcHR0L2k5WUZ6LzRNTlRRR2RrdDBK?=
 =?utf-8?B?aUxtbkRJNWJ3cFFRSUliL2xkSmxqbmZxc1QyeGtaa3V3K0J0ck0yNzVBaE0r?=
 =?utf-8?B?alREL29mVkxUK0lKdWlpei8raS8wanNVTXRRblBaSFFIaHI2VXdLRXFBekZ6?=
 =?utf-8?B?aUJ0emNwbVFwcCtNdDROVUM2ZkNHS0UvRXJDV2FJQk8vbzQwUDVxU0d1cU9U?=
 =?utf-8?B?VlFqQTdON3d6OHc5Ulc3SXVoc1RNSjUxU2MvVGszQlcrOUxlanV4clQ4Sisx?=
 =?utf-8?B?ZWRPbDBFVTMrZWRZNUtXUWZaRWt5S3ZNNFJ3Z3kxOHRac0pmeXZsUmpYb1J6?=
 =?utf-8?B?ekdlLzVURmQ3NVpldG82YkgzS2I3YTIrMHhmeXVzL2lJUWNHQnB1eU9ZOVVE?=
 =?utf-8?B?dHk2RWFjRlVadTVGK3hoTERoeXNDNzJENlU1Q2ZZS3VRQWcwRnEwMFZlRXdV?=
 =?utf-8?B?RkJReG5VbVBpVVkrOWpRMUcycU1ybjBtbmd0ek90NUVmc1I4Z29neEU3TGgx?=
 =?utf-8?B?V05RZG9XK3BzWGNwKzZGWU82RWtEU1FOd25pYzlQckM1SzB6NGRESlpPSldD?=
 =?utf-8?B?RTZLWGxOWjBwb3I2U0d6dlVEODRQdFpuVXNaNlI5NzR4Q253M0hDWkRpVkFs?=
 =?utf-8?B?TC9wL3lyUDhMbkplLzYrb0QzS0Mrb2RFendxNkxjZkZZZDZYQmxENzQyaGRO?=
 =?utf-8?B?YkNZNjFWVnl4ZE9rMWN2NUxUTEkvSlo3WmRlK090UWVJQXBFL3lkZy9kc2cx?=
 =?utf-8?B?OEZDMWVtZnlFdHVLQWU3TmFGWTZRYjJaNnJpSWROMStMMzdOQ2VmdjRsVHln?=
 =?utf-8?B?QTgwRksybiswb2xiblZrN0I5dUJrbHl6VkhsRTRDayt4eW5XeEFqa1VIVk1q?=
 =?utf-8?B?bVZuNC9CRHRsbkw2OWxIZ0ROZ0hzOGF0QkZhYys2a2lUQjdmUnJtWDA1L1FI?=
 =?utf-8?B?OVZaWlZiVGs3MWNseWxhOHVtY3RyQ2p5Vk5LV2g1QTlKQlVDZ0k5MVlkNVk3?=
 =?utf-8?B?SWhrRENOdERvV3N0aDVEQjI0eTlZMEcvcFhmOTB2RGxOaUpHTEZYRVdEdTBR?=
 =?utf-8?B?WWh0MWNJSlVjQVFvZllYQTI2bjMwOUN1TWdUN2xaNEdGeEdJZ3Q3a3BPUHIw?=
 =?utf-8?B?OHlKRlYxQU5OSWd4QklDcThocHlCVGs2R3lJd0h5bDdpOGZmU293UjAxTlhi?=
 =?utf-8?Q?GI4snlRyPVgxgp/+s4mH2jmvbV/oqFQZ+8z43?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24b8b08-af8c-4583-5f79-08df2ee69b03
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 20:13:29.1765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHL88T+jeghxw1Xg4twrPmsA8CtficiNjcZDcWmQTz3GLsHERAv+Ovr44zh8oy/U0oBqXNbQcGHGUHo58KiKPOcxmy6qwD8Oze878QIutfRHwPhMmYs3fyY4rf4TmIHd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7323
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

