Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F18C44511
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41BEC10F119;
	Wed, 15 Jul 2026 18:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y8NX8Da0";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013000.outbound.protection.outlook.com
 [52.101.83.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544B610F10E
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzbiWAF/+Fz132vkK7rT/MOddehLVH7L2aozrvSQZDsKU7LOfsN0JlYJWdN9OxpZHoBmXwtvI0zPufVyjjdCsD/TYVVJOpOQiI1PsQwC9hIhcS8ZSXw4C/TR3HyiOXw8h4tn3q4YuCCM/jF+Fh1abLpbyeY6BNmB89lqgdiABATn2Q+ALbVGw0n2PShu324S6V4axvuf4s8O4WFAYyfkUno4WmbLPwkiBeP1ohhGCDLGjR6u2OeD3XNQ/S/mMVcndu54iArYyoSCKOw02Wzk0ZMxTH1tUisFXNYr2mubVbg6S/8fCmq0WQeeNITeJWlcozpDcPRMTYElpCbdPLHiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SpIh9irytBHxxSQ9ZR4XBRNPdH/W1pB9PiuqBYqrXg=;
 b=lnnV9Uw9zX9DlnNqPvTgf7uQyhIlcLZ4X0VaWBcxwMOSKyZ7PIhdk1TQ2/qHCXzvlNMCCJ42STdmbNbBKXJb7HXh2DaC9q0lXVSXDyzp2XwmhfIq3b6AORHzRZEjv2/TzUfx4SVRXLY+zHAOD4pJyv2USkTyK2buI2MqM8nft/ILAlZWgE25QX3dwigiRFUyZmAvbsofl5clw7rO1Jm8z60sd8x8Ug8tKK7QNnGxttmfTgf1/TxJems3wG4nID9/6KjOkJncqqaNbygrj+buirjQ5KHRLwjhKL//yWcv+TPPtMYKmwq4oeJT+AEboPdNEK630MopsUkehHobzb+vAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SpIh9irytBHxxSQ9ZR4XBRNPdH/W1pB9PiuqBYqrXg=;
 b=Y8NX8Da087+6fwggEWEheWioPLFoHB9FYoW7t6HioFHWvMswAqM8yEL/MGzcRhHbsJWiTKqxMWDOkLXeJLLMVKZTrpqasrVl2E1WEukxGNHT9uLHrr2lTSmmpNfsP5lCo1hJiHlFieypjOQj8ZzUuLLtKSTRabhJGRhYv4MEkDnxI2sB8JUDziqMj0eMGTWiQkUySvm/DXc0XLJ+Wx5209NSEUqFtKaKIbJnMdKBkDRFNV9Alm9G1ttw8+eQClT66a3YpFq0uwHShB4jiOJUNJ2Q/qNU6O7oV6V9d6TC3GIEAX2+MfII48ORsDWDxJTlENycmgxObBxEdhNfSdHw+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 18:35:22 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 18:35:22 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 15 Jul 2026 14:34:51 -0400
Subject: [PATCH v2 6/7] arm64: dts: imx8dxl-evk: Move ACM MCLK pin to ACM
 pinctrl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-dxl_lcdif-v2-6-da797562636e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784140492; l=1534;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=w5T3M+BeVkwBPZ/AVeijAJC5g6CDIKUMjB+8Z/3ut8s=;
 b=cRNG+D1M8grDLsuDr1LfTlV4qPMk9nYhIm4wnj3fhhyEruBmSSErhWkRutM73cJ+DkI+6obmC
 1KjMLrpLkdpBg7ZJG1jHqoI7tVPFg9+4ccSJXT1OsowG93jcXs8H8Kx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:806:27::7) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 98586665-c20e-4ae5-b8c4-08dee29fd48b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|56012099006|11063799006|3023799007|18002099003|22082099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: lu7HmFLkP5JQAd70y+GA16jgysvt/eL1JIBLBHtdMjYMCY5Wk5cBm+5rKhTjy7/H1ZYP3OKxEbhlPIXciYgokBgafpVrIDGgq7zLdSqU9mAeEkkT/5MvaxpxAmeKnPUN2ogc+ZlY5xVimeYb3dhj/w4Fnl3aosbI9eRsfnp+J66IfAMDh613XpTKJlYqJRgqqRRyLQcgd8wZkTf1oHfo5tb4SUGGSiuMQPrHzH2IFmhUBsFGNWqoNltGCIuPrAAdSPQv9xM7Z76Ol3euYZ07fPaEQw5xFfx4aG34phB9d8VUlvA9tJbhIYjzd7q5SKKc8KeU7pE0xbp1Rf8JlQZZy5iIHUtWXtaweHHq5YScT8ZlA19lP+keJbfGVxa8m88GIc10rqYTyXeJlNa3nMmRCc3Q3cG6VjN6wXbAdi330N9Taoqr07ABa+A9gK2hBz/DLt6mCUv8IPGVyaxzDK8GkZdah1bjfjDexYPvaFFSKa7dspj0xAMCBAHhIYkTlzt8GFlCOm1z0/VX7HECwZQDtwzGHaZTFmRsLPCiyoSczYVlAF85LMdOo+MrMoDdXtV5AwmEjtLeMTxJ9fxDDA7DUqKVRtJz19pzUHtTUllocWCJCnkLlfbgjpasYdgkw3K6yrgqJyTMiE30XRWCGIYiZGunmDMV23Bd+yW6oO2tD/k9jHOFBMDXNw77VC6zup/KlA7RLic/WGYHZXd+KtktTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB11791.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE1GbzNrWi9mclA1M0w0UUhlU2tFcjl0TllKV0MwaTNGNGJRU0dKOEd3b2F2?=
 =?utf-8?B?Z3gzU0ZRd21KdDh1R0IwZ1lRTmxhdCtEOGhnV05JakdTN0RYRmpqUGdTSkZY?=
 =?utf-8?B?SFpXTVNHcDJ2U2FjVzFIbFIrZU1rYUhIbU5vVml0ZGVxWHBXQnBGc3hhclRT?=
 =?utf-8?B?V3V0NzA5VzlaK3JVRGlObmkrSm1EU1BJR2JGWUcvNTZ4VjVGVTJQOUwwWkQ0?=
 =?utf-8?B?czVydjBUVkc4dStvR0t5UzRpZThaaXV2SkRVQ0FpYXZxTkdPWDc5NDY0VlJ6?=
 =?utf-8?B?MTFpRnZLTmtnNEhvbFBGYmlZbnl0MW10UTFLUGJrbEhsWDJ3ZWJCSEpEZkxB?=
 =?utf-8?B?ZlE1d0NHd2llY3Y4NjJiQWVrTCtEL2dOMzUxbjRQT1VubXBzYU9hK2VQbVFU?=
 =?utf-8?B?VVl5OWRDdi9UR3VJZmJrSmJlV2ZhWEJ0M2RmOHozMDRVcFErakNKcldnQTFj?=
 =?utf-8?B?Rm5RblhPUDFPUWk3dk9ya3REL3RmaVErOE5kT0t6dmZUYUZ1NlpNdS82MDl0?=
 =?utf-8?B?MVl2VnlDdVhESWhkMTVFT1pZUllWWnZHWHppYnJEdVNTQkN1dTV5ZldyTm01?=
 =?utf-8?B?WkNJR1dpSkJNUG0yTnhGSlF6WVc1amkzOXQrc2xzSElrYko1WWRjazlVeHpv?=
 =?utf-8?B?VDhUSlBGUVpwUjZ6OXFTak9XblVCNXJDc2ljNmorak5DYWkyTmhhVHJyYjZk?=
 =?utf-8?B?dXZpT0FtMlA4N0J4dkxOOWhBeGd4RXNLSmNKa0V6Y0ZzN1N1YmdsNk5pU0RC?=
 =?utf-8?B?eXY3NDFMcEthSWpaOTM1d2RhcFY4MWp0NVo4N0hFdWt4eUluY3U2R0VYYjVJ?=
 =?utf-8?B?NTBtdytLYjhzZ3hVMTBIVHljWTRubUg3aE5TSFN1a1QyQUlnQVllT3N1eWpH?=
 =?utf-8?B?ZTFBZG1aM2o4NVZEN3ZwVXB1aEZVWTJJMEVyTWdST1ZSUkZhbkdjUGhhZ2Fu?=
 =?utf-8?B?TzFuaUd0dTNiemk1NEpESCtwb0N5bFlMUHlwWGZtTHNPYWVrdmp0NVVVT1NM?=
 =?utf-8?B?dFQvam5yaXh6U012aWZOVHdmemI1Sy82dWgxQ282c2wwcExCcU1kZ2VJLytN?=
 =?utf-8?B?ZzNDcUhuSHhmVWtkOEZ5Q2V6L1EydTNKZVBtODdjUnE5aGJybko1UFBMT09P?=
 =?utf-8?B?TXRTMEJtRGlXMEJQa1JpVEtZYVVjSTdTamdHUHRjTEVvYWxTT2FCRHBuc01w?=
 =?utf-8?B?cStORThZQk5tUXlNRGh2VmVSY2Z3WFRON2xld0MvZXp5VzM1RTFPZWkrYkVs?=
 =?utf-8?B?SWxKaDFxUk1qeU5HWVhUYzhzSTRBTm5ESS9UNXZrc2RqQ2Y3aktFVjlGOEI1?=
 =?utf-8?B?TjhOMWRUOGRXVTl1Y0JIMVNNcFVZVjdLVFpvY0pIRVVzelB4RGljUUk4SW9T?=
 =?utf-8?B?TjJTSVBuSnN3MzFrZEVabTBycW5mRWtMNFVPZFVEbTJEempQZzBRUzBwOWxG?=
 =?utf-8?B?aFduZE5wcHR3R1JWRElOejgwVXd1UkZXMHpraDJWY2lvUEdhRWFSbTdQcGJt?=
 =?utf-8?B?cGFkdTNTTzlINjJWOWhwNDZMU1MxTFdlNzFvSnFHb3RTVDF2NTBKKzU0YU5D?=
 =?utf-8?B?MWUxVENnOUZPRmZpQ2F4c1lmbGpuUlZ5RkFJb0JWY1o0UHlQS25pTUZPYXl2?=
 =?utf-8?B?TmN6cEZoZHlIREhib1RRMVdGNTBJNDhVSGM1MVpkOW1pd08ycXRqT2NHRDhw?=
 =?utf-8?B?bDdpYXJ4NmpUOWtjMlBHK3pERmNBcEpOOW1aZW03MzErblM3MWJ5aGxSNm9l?=
 =?utf-8?B?akwrRjU1YXYwY2tSLzBnbGxwK1dqVVZ1cVBRVk9rMnFkVXpqamRRTEtJQkdC?=
 =?utf-8?B?ajVBYXZLd2JyZVBRTW5aVVdxb3J4Zk9oMTNVbmFKY2NjcXJNY255TVZNSmNO?=
 =?utf-8?B?ZEV3dUtLU1NqSUdjekdjNFlpbEdNR0dTT1hXOEt4N00rWWF2YU9kSm1WNy9p?=
 =?utf-8?B?YStNTFJaTDhkTHpGVlhpZFJoNk83QkRjRjUxclI4bTZsUmM0OFRoOTBWcjUx?=
 =?utf-8?B?QTJqQ1B1LzJRckZhUHRsL3NSSG1kbDdTcGQ4cjRaeTB3TmNzbnZDYjFTMHdy?=
 =?utf-8?B?Vk5QUkhGTmV6Z2owYUNkUmN4dkJnNmNjMHhoVVlPeTdiODI3NVcxQjhtcGp3?=
 =?utf-8?B?czJSdklVOW84d2F2V0FTZFM2OXhFSlBxWkpzaW1QMUIyaG90SVBVTmlySVFw?=
 =?utf-8?B?UW9DQ3dRcWhMUUVNYWVaSUtJZDEzM0I5Q1Ixek1DdGdxeGJQOUxjNkNQQ2RR?=
 =?utf-8?B?TnJ6alovN25VaDJlUWYyaHJiSTg3dHdwamRON1BCcXN1M2hRVnNjTjBpcHZN?=
 =?utf-8?B?S1ZkaG41TWEzVXJsUWJEbU1YZXpGbCtScmw4aXFneUlja1RXVk5hV0UrNnJM?=
 =?utf-8?Q?/mRgc6DpQkrpnoUy7PaH7sLbrwV6Optnwd+Ab?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98586665-c20e-4ae5-b8c4-08dee29fd48b
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:35:22.7899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vfQqU7NBF3sci8YIT4hAzYqWKIUL8iU3KmTXeTEqlpv3ueqqGPDN7nXREQc36ICD9eH9AfmXueQZt10IfGSaYYAmeDriH4Q7NmE3bk1daOlnqjHnDiksCcalk5zxRS9
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
index 33941645641f5..3b96bab6aec80 100644
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
@@ -942,7 +947,6 @@ pinctrl_hog: hoggrp {
 		fsl,pins = <
 			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHB_PAD	0x000514a0
 			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHK_PAD	0x000014a0
-			IMX8DXL_SPI3_CS0_ADMA_ACM_MCLK_OUT1		0x0600004c
 			IMX8DXL_SNVS_TAMPER_OUT1_LSIO_GPIO2_IO05_IN	0x0600004c
 		>;
 	};
@@ -1062,6 +1066,12 @@ IMX8DXL_SPI1_SDI_ADMA_I2C3_SCL		0x06000021
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

