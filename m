Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D180606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=t5zA9XcG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C893010F2FE;
	Tue, 20 Oct 2026 20:14:04 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120FF10F2FE
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tT8B7688wQm4uheGatD7omEfPDuUrtuE9ISoj8HEcbzDm6hpZOX4CBFkaZLNgjJrfv29f5eLvC4U+FrP4lxJlydWuc5mL2+fJbenLrBErinVbAMQF1f3ZezIKc5zhvN9HM2pSdFD1kdTW/Zkge6gKcoPcKd8iP9tW89lBCfkFOTb+bSB3RR1J8dRF+g5W9c65X9efIU6fr7QaY7QiMfy3EH0dFvDg66/g1+g0Sr5ZnUZYtaC6227adbznaxSfVleF0FPZNYGHzafowfBTidNCjdL+DKNOUN7jtJ6RWRDkjeAXss21XGO6f4KeTHiWhzyRmQxfmpziMY44VfCkoWBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bvfQ5OnjcbEe8xarIjr70Njy2rDzJ7Qt21qYIz0rZ8=;
 b=combCTPjEyTGvnhMXp0IaVe6ToObpiOK7ZFB35tokI95BNraer38gC6MfkRLNbmw6RylZhDVAvDcVNt4L/0TZj6k7bRtb0RpF2PRw6QV9dwYuDBKlwVMyS8C99Ng/mIienVJOMmI3qgK7MLCYAm4xDF3/bBiEf1SSb7rQLwW7earRcogcBC7d5LzcexZgROjM3PzAXzt6V3Xji81FBbZ2mMvRQInRstCPdnNO4OFK7LfyKH+UQEI6if4v+NndVaL/9DmXrHVERbwNizEc2uSH0DfZCi+8x6Ay10HbZzmyEI4DuQh3L6X5QYv+/tb+yBcQzZQt46t8KW+Wq1Cw9oSXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bvfQ5OnjcbEe8xarIjr70Njy2rDzJ7Qt21qYIz0rZ8=;
 b=t5zA9XcG3vATNwMpUjCQOLaT3ij2PoiCWZr5/Sv9266zKaYIhTEz2XBcWxwNkORdixlLbSIRYNuKyVZimvtCxaSKuB70C78TyD5uI5W24LQP8Xm/aHBJk/wv4AEFktt6HYm3KE85nDb5H9bmpeL1/kynN7iLaO5XBkHRci1IPcAneGATXGMZpEN2EnYGMQSMQ0oPphzTXsLJ+5dHvIAJDouO5gZiQmz/u/NpVx45GbhZIrUzQlzqU2tA59ymZxKZQH9p6wsAHJqDdIgqKlretIFv8FGxQYC0bC9wSgZKXBRlprqrDk0Sh3oBaXMTIliIV4e34KX/7YRvp8EhzEuQgg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by PR3PR04MB7323.eurprd04.prod.outlook.com
 (2603:10a6:102:88::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 20:13:40 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 20:13:40 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 20 Oct 2026 16:12:56 -0400
Subject: [PATCH v3 6/7] arm64: dts: imx8dxl-evk: Move ACM MCLK pin to ACM
 pinctrl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-dxl_lcdif-v3-6-adc944659e14@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792527183; l=1534;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8NR2Z2VJobThkg8e1kNwKrRNXJoYFVaIIyppUs6orLQ=;
 b=cmBN6ZaYKbtfOBKqFb8xPKNCtOjKdooTPbE4idUVRBybRoaNudvEHQxEWLhMvn5Yzuf19cOnk
 GcvfHP13bgfCnRtYEOF5hmJ97dgNPiIg4bvMxeCLTGiCM7ylZPXhrC9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P221CA0077.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::12) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|PR3PR04MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb80f1a-1e9b-4d05-84bf-08df2ee6a196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|23010399003|7416014|1800799024|261009223027099003|10067099003|56012099006|3023799007|18002099003|22082099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info: H43DPBlfIl/Wizg4r29M8BS0J+lxVfB9754gqls2qkM72wEOl3gHmKwzPLqdoAdfC8TA+ouM4XNkKMOXKDifPo7KiMn0ss8MukVBGbFgyNogba8kLypn0CpuqufOSQFUoUrVraewlzj7AirLCyGZ7GDsdaA5JgveDyNmcQ7mtk9697uHkpiynYSJnNjwhYHaywj89pXd4oGbjvztBoWxsg/ANjFML3gCPsry2iTe+NJkFcoKqJdZlH7y0fQQvrqlSdzUd5D4OXqw8jYvsKDTIa7lRav+yuNVblAUAJ7UDcBr7Ba2TJx6c4gexe42VcqCAQQQbJe7SNzg60dTMAchOTA3Pi/P+c21i7lmbe5Y4zzfS9BuZDnXolrgzygE1I7wHgCXWyhFdUM8f/DLS/BcYb9kWrcm2Zzq4sFJRmTxK59KrP2Z+3LgU1TKoB+7KVq7XVGtpJFx3WwS8OGN9Ji4cneqQS7ZahydKrgJBIyCqe1AjKjRuCfh2Vlc2Ctg6Rh1fXPqvpjGsCNxLQ5a3DpMfwJisCtye33SQxbQthGYhHhB/t7ykqPC7RuJvbfz3XqjLS5FTrb/Iwb/ziqnPbcLRxxWrFZnmsASV8n68dJFu2AN5ursK852WB0zW12gGY2Jb9w3Tl1SHqKEIomnPAj9cwWcvprNWHUZRKVXJFOtTJecGIIX7BhAzh6AdiYjVzxYRSRAcU8NAzff9VujBrtZzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12445.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(23010399003)(7416014)(1800799024)(261009223027099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(921020)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjA1ZEhGYXBJaEJBWW13a2NxL1laRDNscjlVQndlZmVnOXcwQWtOcVRXOWtx?=
 =?utf-8?B?MnlHYk04MEo4SGsyWUM4MjhVSVR6dndKUXUyUENzVnJmUVNlUXVoTWVHYnlo?=
 =?utf-8?B?ZTJybWpGVFJPS0RjcEhTY09CMmRzbENZRWtaZnlzbW1nZXN4MTczUGN4M1VS?=
 =?utf-8?B?dUU3SlRrYllGclVxS2NmeGVJcDUyWFI0N01PRlJsZnJhS25kS0VDZ1Y3MEl0?=
 =?utf-8?B?cGI1dTBaQjRSRDcyeWdBbEJWWDZrV1FSWHFpREZVTnhxMDdqTXowWGVTNllk?=
 =?utf-8?B?S0tIN0R6NjV6L1dMaWM3MUN4T0FVdmVGQU45MHN0RzdCQVBpRkYyNmVYN1k0?=
 =?utf-8?B?aWUwS3g5bTZlcmQ4ZlRpOEJFMkFhRkNWWllnemN6U1VxZXVVREc4Mlcrell2?=
 =?utf-8?B?Wmo4YXVyTWdWSSs5N2d0NjQrR0c1aHdxcUZGaEN0RVRWTFB6Q0RwWnRQMzFZ?=
 =?utf-8?B?b1lsSDNpTUFZd3V4Ump3dEVKVlR0L1RFYTdleDUrM3I5WlRSd0hSOEpqMGdi?=
 =?utf-8?B?blNHQmV1QzhRWGdKMEN6RkFiVEtVZzdOM0lMQzNlSTdkbGlMVEZ5Y3ZXVVk4?=
 =?utf-8?B?cVlWeDZZd1ZvT1hrRDRJbk1paUpZSlB5VVJCbmYrSGZEeUVTMS9lc2ViQzdP?=
 =?utf-8?B?ZDkzMm5kdEdiWDNCS3BLbG9jaGhFeURNU1hFSGF1Yk1jNTk3MFpobmtta0VP?=
 =?utf-8?B?SE1lOCtHb3JQYVVKOHNKdWdTM3pGakxqa2toNkVYV013aUZxVnd0OUtiOUlp?=
 =?utf-8?B?NHcydVJVT2hCbndqZWFZN3hpYzk5MnRJQ2M1dmlEQ0RnQ1hsZEp1OVdtcHBZ?=
 =?utf-8?B?THk0bFpZTDRvcmY5eFBscUdNMGVjN2drVUlEcnhMZnMwNDVjU2oxa25vdys0?=
 =?utf-8?B?UlhsSFhKNnlVeDN1b0Ura1dzNnR2TzVsSHBhTnNSRVFyZ2pWSjNMK1VGTm8r?=
 =?utf-8?B?U0pPSnVCQ3FRSnd1dGdHUFFTaENsWk54ZVkzL1FYSzJmQnBHcmwrR0lYTmVU?=
 =?utf-8?B?TitRSFdZazhSQnlWYk9NMEk5V05aWldYR01yNEE4a3RyL0VkSEN4RWRrRG5U?=
 =?utf-8?B?SlQxMWRZNDk1dlc5MS9iRHQwQzJkdWI2YStCTmtsQVRMc0s1S01SZGhjQXIr?=
 =?utf-8?B?RmtlemFZSk9MWFlna3p3U2d6QnpvWlAwMmhZeG1SSS9uRitQYmpKTnJpcG5n?=
 =?utf-8?B?SS8yZkJwNElCNTBoTUpPT2pHbERhZlJNSUtrdkRCdVBZMnFCdk53ZlBTQlRP?=
 =?utf-8?B?TGVaUlB5RVVOOGFKOGdWdFJEY0haVjBLMXlLWVdhTk51N0pmbXJCNVZoNkkv?=
 =?utf-8?B?bEN0OHRnZzJVYTRwNklMb2NldHVXTngzcE5YZGZLSkZaNlRScy9TL2FrM0tz?=
 =?utf-8?B?OGVzN1RWNEtGTmFLN3Ezd3NRR05CSC92N3ZnY3ZsSUNzbXBzWjBKM3hWWHFW?=
 =?utf-8?B?anpub0doQy9CUE4wRUJjM2FhNGd1NEl6bWlHZXpxSWRoakt5b0ZLR2pnaUZ5?=
 =?utf-8?B?NGZBRG5xZTNINnRWM0dibDRhZ2x4aEs4RG50MVBneDk2U0U0NlQzK1BKd1N6?=
 =?utf-8?B?bktpNW5wQzRxZmliVW1kc241eEpSTi9SZ2hlckd6VjJ5S25la3VpeldyVlRL?=
 =?utf-8?B?SWJKaGVqTHd6TmIzZTlWRjkzUVIvYS9pRHE1MmJiaXlTcWxvVTR2WUVNYmNl?=
 =?utf-8?B?OG16aTBKUFdkN2Vqbm1lZm96MDFHL1NHQmQ3eHh4dEpmMGJ2YW14V2xRQklP?=
 =?utf-8?B?Wlc3QnFXUzBKZGxvSDVKM01sb1h0MlFPMmI5K1hjd1d0UlhVbXNZdGpab0lX?=
 =?utf-8?B?YlU3UlNHQTVud2RtTVlwbVk4WkNoOVlhb2MzeVRQSllFWFFYeXpqM0VPWldE?=
 =?utf-8?B?alYxV3pBeGp0NFZSRHFzVmJMWmdTbnRYS3RVVUxVOW4veGRBUE5vYTlad3Nk?=
 =?utf-8?B?MEhyMDhxNElJRTV0MGRaYVFGWFVYZEtyMnhJZk1HWEp6T0pBcTMralZNMDlk?=
 =?utf-8?B?dkFCNDEwTlBCdTlnaGtpcXlBanl5YWQxbGswcEVyckNmTFFxTUpKdzNRNFNI?=
 =?utf-8?B?L1FSdHhuSGZtSjVFS3gxRVZvSlRhQ3pwNEcwTUw0ZGpSMnc3MjBhQ1g5WDgy?=
 =?utf-8?B?b0VGVkFaVUFhZ2FUbVJyRmtEUk1UY01HT2JWaThvK0RpRzlSUmx3TnRmT1dt?=
 =?utf-8?B?ZURtcjU1RlJPVzAwNjgxMU4yZzBqTnNhYUdpZXd4YThBekQzS2tVNUtxT2Nj?=
 =?utf-8?B?Yis5eXE1NWw3UlBucm9KT3NmM2t1WXFDUE1kcEJzdndxVzFHRmFnWGp5MTlG?=
 =?utf-8?B?aThlNTdzcVNxNVJFOHVMaU4ydDhFa1RjKzFQZ2NqUzhpWXBxU3NvQSt2T1l1?=
 =?utf-8?Q?uatAupbmeP/bw5t7zQHrIltH/C7kPYOA2jBUR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb80f1a-1e9b-4d05-84bf-08df2ee6a196
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 20:13:40.1982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FqAfDxmL9RktCY8ar6n+GsylJcPefCisqb6XBUZWEvGVJzc2Yh08GUa/c1zuNdWvqj86feQ5VDIZ3rJjTWaM9CZ/qcdTOsh/qRUL1DhVVTAIOuntG59+rCiCpIRbqwm
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

Move the IMX8DXL_SPI3_CS0_ADMA_ACM_MCLK_OUT1 pin from the iomuxc hog
group to the ACM pinctrl state.

The pin is used as the ACM MCLK output and should be configured by its
actual consumer rather than unconditionally claimed by a pinctrl hog.
Prepare for LCDIF support, which uses the same pin.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 312e4ef3a6760..1ffc6047c1480 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -347,6 +347,11 @@ sound-wm8960-3 {
 	};
 };
 
+&acm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mclk>;
+};
+
 &adc0 {
 	vref-supply = <&reg_vref_1v8>;
 	status = "okay";
@@ -945,7 +950,6 @@ pinctrl_hog: hoggrp {
 		fsl,pins = <
 			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHB_PAD	0x000514a0
 			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHK_PAD	0x000014a0
-			IMX8DXL_SPI3_CS0_ADMA_ACM_MCLK_OUT1		0x0600004c
 			IMX8DXL_SNVS_TAMPER_OUT1_LSIO_GPIO2_IO05_IN	0x0600004c
 		>;
 	};
@@ -1065,6 +1069,12 @@ IMX8DXL_SPI1_SDI_ADMA_I2C3_SCL		0x06000021
 		>;
 	};
 
+	pinctrl_mclk: mclkgrp {
+		fsl,pins = <
+			 IMX8DXL_SPI3_CS0_ADMA_ACM_MCLK_OUT1	0x0600004c
+		>;
+	};
+
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <
 			IMX8DXL_UART0_RX_ADMA_UART0_RX		0x06000020

-- 
2.43.0

