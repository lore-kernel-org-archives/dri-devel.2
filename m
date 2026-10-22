Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D4606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YcfnKBfh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869F810E48D;
	Thu, 22 Oct 2026 19:38:02 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013003.outbound.protection.outlook.com
 [52.101.83.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB9010E00E
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 19:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1lfJ9LpIFCw4lTX1PaJMg+3ba16WvI229Vn602HYXz3IsYxoGFQfdlBPx3G4GxlfjzhM23f/ov11yHcnOMB67M/7f123mmjkZnX+3n8C+wsNNlof9r1NfAKKi06b8pDH4nAPCR4tFwVJqnShUPgqRRkwfgg0jp5nSj5XsGG0w5ZfkwORR0zWM5JO7ryhhfF63+q9JqkcQHcjUPG2GT+sVJD4LJUOOoWsDJvA1rkczzbBTPIxWt7fuHwQHxiFt8ow1F4Wfm6SYJV44pmY0tnKUDFxdLYZRTcbSzIlKUOBkrDJHM8G8Ymk4nOEprv/HFppcpV+vgLZmZzD+ufd9vGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhXm9i+43G2ERk3dguAzdfTSsu59WvqFWKDTumQ11ZE=;
 b=sFFvhxv+Uu9Q6UzSadl3ncMd99Ffx/aMR/nseD3VsD21Ix2WuSu4WFUdIjDt4o/m9JcImOgVIQE4nF15Y+ROLruItoXWjxgb9a8zmDIF2gPl2eAGrBFXyCEJHVTstSoAAW7Bttq8GgkqQ7LPhQNNLdNrzPrj9lilQeDgVSZto/2FNgjfS5vTf9F6Rg0tzmOIK2wUGXbBJl4XwIlZqdKyU3iEjWTsOfMfWYQ70QCkSifjptdZe/6P2z2e3CmsxCj67tFBGVr+un7byMYaFcdnEeSYS31iVWlF6CWFseBJQksiqNX866s+ZkACLNdcWhybA5DnnUgYzjnn0ie5yCQjNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhXm9i+43G2ERk3dguAzdfTSsu59WvqFWKDTumQ11ZE=;
 b=YcfnKBfhqnFNnwpevRIfbQjaf9xIwcK6X3q6o85s0h8B4VcEonrsUvG/9u0FRXr0gSfLy+qFjzfmWNLhjhOBgMsZhC/ve8dd7jXxuREMWKhF+Ko1NA/mk8FlZYEdzdRfFXAi+UVjEV5/U+wvNqMboGuw/tj6uFnofPUJYCccx4vI94uL+J5iGFW2xpjsY7SOp8sdgld4u+t1w0WqR6n2Cpuv4+aqqVkyzW2rsuLEwcXld2ZzRyAHLpN8Jsly84/9/U7hFsStLfBCF3bC+juDaI3JaiIxt+sEwuqm1fX9RO/eWp1GMGCHMAFlO3GX8eWvFrvQ9oBYqb8li4Svp2MAEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU2PR04MB8679.eurprd04.prod.outlook.com (2603:10a6:10:2de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 19:37:50 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 19:37:49 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 22 Oct 2026 15:37:10 -0400
Subject: [PATCH v2 7/8] arm64: dts: imx95: rename bus@4c100000 to hsio-bus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-cleanup_dtb_warning-v2-7-e9502fafec59@nxp.com>
References: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
In-Reply-To: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792697827; l=913;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fglxZ6zvqG91r5PnieO5NP2ilfWfxhTYL1+R/OvR3Ww=;
 b=yXqs9HcbBElQNdoFfURPPjtg4fiULW/9bMDaIB9apFvynlDUJgWnWbODQJMbeZ3PpDF3gwJrT
 Y5Q0nv5lR1NDp3o+EKFjQFU1a9lPRFJ1HF1tEKuZ3G0MgXQgkZNKYDj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:510:e::33) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU2PR04MB8679:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fb35f3-8571-489a-3428-08df3073f4d1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|19092799006|366016|921020|261021121427099003|56012099006|261009223027099003|11063799006|10067099003|261021123027099003|22082099003|18002099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 9dcZUrmqa+hidCAW32w4XdBgFTN6Jl0CcRu5/qDHcGRrf+TZAl25wl5zfMCBciSGyUDyJJ7xbYwe3a38lnzWZhWzXgIB7R4KOrOScC+c0KcklFemccpUAEgWE/ztWa4G0Z29K1DkAGVYdlIXOq3A1LvSnJvZ194DqhySQ1/P3YCRjCZ69DD21y4BAa+frkU1DXUaXMbTd9BEG/DLYXejwEorRNfGe6xaVheXCDeWbg+FZ7Av1nTeHUEI3HJPLq6zjo015yWFWyQdSimhavM06NC7Es30nysu631usOV60NldkhrMfO6uns2fS32oOK+YraW/meYhZd5RTEYXMzJ6XjlM+Y4a5WsY7GRUChlxrlz6SrtTUcgKbPpQcD1ZSlqmFfhpYl/tGdAyM8crjFCp8vd6fS7YXcX/c0zwQvnPfh8flz7ttC19kF6wjceMfzBaDMtCepMOTBi93oi56o07aysUSl5Frr8GJsCXEGkzI5GJbb+2uwuv/EWTaneAZV6SXX9fgLM30+rPMx6fIggrJSZ9iSL92PylJ9ipB21hyRE+b3fA37PyYb5rJbkcMy77MucvlSyf04Eh1HCXhciP8WxRsW+A6up3cFcHIAvjY8yhL4rnHaS+IdtQTUyBEkQWfmT0BExyaCi6kp6XEf5X8zNtWkdOXcRJ/3ZboQhUj2R0TmvOn/nXNna1Yur2FR+v11tRsrL1LwyK2R4L64mfXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(19092799006)(366016)(921020)(261021121427099003)(56012099006)(261009223027099003)(11063799006)(10067099003)(261021123027099003)(22082099003)(18002099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXkxeVdOTmx6eU5KU3ZlTHRvQVlld3ZNdkFSTDBIRm5nTHlDanR5V3hlMUpV?=
 =?utf-8?B?NlgzdXBXOVhhZ0JvV2FSeWY3ODFzdUdYempiZmlHUWQyb1NnSzhBMDQ3a0FO?=
 =?utf-8?B?cWY2N2J3VWRzWTdaQ2VPa0NEQ1kySWZ5bFMwekJHU3ZYRGtONU5NZExlWURv?=
 =?utf-8?B?VnVLNHFNQXFjUkZEelY3REhENHRGMnY1RTB4ZWVhdGhGT1lNNm1qZ3NoYzNG?=
 =?utf-8?B?aXJKcmp3bFAxanhYaFh6WC9MYmRkUG5tdDBHd1JVbjhnZVU5WXNLeDliWkkw?=
 =?utf-8?B?OUJjVndCYkJOemV0OXF4OG9HT21PSlRNZGVnMHd6ZytZejBINkZGb0tndGlQ?=
 =?utf-8?B?NEozY20yWDhaWDJhUG5mY1hXSm1MYmo3Rjg0TXRNK3BVVzF6RXhLU2djcVBx?=
 =?utf-8?B?ZVZJMWxRNEJUNldaSVcwVytaMEs1MTBkTHVFdVFsYlI2M1o3Mzh5UFBrOEF5?=
 =?utf-8?B?QlRIcWovckhneUtPeEJhUEUvWVNLdFJNeFU0SDRtWEZVQ2FRVERKNzFNcG4w?=
 =?utf-8?B?dlZmbnl3V2J2T0FteWkySTBPaVpjVDRDT3UxREJyek5ZQXhEczBoVWZyU0dp?=
 =?utf-8?B?ZW14U3o0NCtMZm5McnRLR0JFMm9ZYUNVdm1hQmF6T1lVYmlqK240V0t1Vk52?=
 =?utf-8?B?bFpheEJJd0VFZnM5bGVNWUlHcSt1KzFiNGdOdVZ0dlhmRTMrUVJMVGJmS1RD?=
 =?utf-8?B?dXpCM3pWTnQ1U3psMUFNeTZIS0ZoNkdVVThsOVZKUU9wdWRENDJaR2tpOHMx?=
 =?utf-8?B?dFlaY1A0bjZtSVVBTjlXMmRxTFhhNndZV2Jia1p1YmhvOG4yNjlWZDg3MmFP?=
 =?utf-8?B?T21SUGVGTWJ1UXVlNkMrTE5Cb2krZ2FGa1hXeTlFb1ZwNWk2akNydndkSTlt?=
 =?utf-8?B?RCtndDN6L0gyM05CZklhUXFIdjlLUys0cHpZeW5VOU9Lb3dweFZjK1ljbU85?=
 =?utf-8?B?dG9KTkV4d3oya0lwcTRzSG9KcHZCM1ZCUDBnMnlaa2Jod0VEN1pDTk9PSjlY?=
 =?utf-8?B?c242dUlVdG1kYmRQTUE3aWlTQ2pwZXBwWVVSYmg1YlBDWFNOMmxEdUtuSitl?=
 =?utf-8?B?cTE3WFQrY0d3Z2s0TEs1L3g2Z2JNQUx0YmFzVDJSbHh2ZndoWjBFVHpSQStx?=
 =?utf-8?B?Rm9rZTBDOGdOaEZ6Um82MUROV00xemJPQjZGVG9vSzcxRmNkalhXekV4ZTF4?=
 =?utf-8?B?YnQwM0tYaU5KeVFySm9QOTYwRkNROXFvcktpMHQ4a0E0WFMyQ2NYUEk5d2o4?=
 =?utf-8?B?M0hXZWIxVWYxYkdzdnlxZDBrUWdRcFc0ZHNHQWV2TDZaN0YzWHVkUHpHcWVE?=
 =?utf-8?B?a3RVaDJzSm4rR0l2RXB4UXF0L2xmQlZmc0s1aVRMV3pzSUJMaGYwSGNoT3Zs?=
 =?utf-8?B?TGJWUTcvb3pzM0tkbHFpTHppM3lqaWovSGtPV0xjdTJESTZEejdidW4rOVJr?=
 =?utf-8?B?dWJaejlhWkpYQW95YkMxeWpOSUFlZmtuais0VzJhWlpKaDBaekJZbUtYbHJS?=
 =?utf-8?B?Ymk2L204NXdlK1p0VzJOUkZ0Z3J4aG1JV0RjeVZ1aXpJQ2NzS0tIcC80TGhj?=
 =?utf-8?B?V2hHT3RzbVVrZzZadTJ5aHlOcmRxeDZ6c2Y4Zko1U0RXVC9FNG1xaHhxR1VP?=
 =?utf-8?B?dGFweS9qMnZxaUxJVzl5V014UmhIeTBkWjBtTDVMWEg3T1RmRHNkWkg5c0Mx?=
 =?utf-8?B?K3BIbVdIRUdTU2FDMWk0VUNQMkxSd2Y4djZXMUZQV3J4b0drdkR5TGRpOW5k?=
 =?utf-8?B?aVEwY05ad0h2SHdQQlBXdDMyVEFaTkNmcThLaG5Lc3B2R094V0t4WmJGOHJs?=
 =?utf-8?B?OTZ3YktUd1crdHpkTTE0cjNYY0dhL21rMi84ajVyVjdxb3pWQlhNaTh0Wmhp?=
 =?utf-8?B?QTVoRWV5VmJsNmZOVE1ISFV4eTNneVY1L1MyQWN3Y1Zuc1FiL3BhMEd1OU5O?=
 =?utf-8?B?bUFoOG1pY3VUOEZyQXNzQ0o3Q29TUVBmMk8yMjlRcmdTcUhveFd5a3pUMXUx?=
 =?utf-8?B?dm8zV3RQS281RktERFdFbGdPczE1M3ppVEo2eHNjK2FsTnV4aUkxYnBZR1hr?=
 =?utf-8?B?dmVjTGR4TVZOUno1ZEY5QVZvZkVFZFBnRmZ3TWU2VUhWTkRoQ1FoSEtCUnFX?=
 =?utf-8?B?eFFBbFNUME1OelhBc3FCRUhaWGJVRllGeHRqMGNDcW44eXM2T202Z3hNcFlk?=
 =?utf-8?B?ZXA2U29RYXNtMVJoVGg0ZjRySFkrV2Z1anNWOERVc2J6L0R6Vm9vanBOUzlu?=
 =?utf-8?B?Q2lEbWlONUxpeXhTTVFHWk04T05ZcTdjdVlyY1A1NWY1Yzg1L0ZoR0I2M1Jh?=
 =?utf-8?B?NnpNK0x0c2M4ZXlXWVB2TjNjcGt6eVJVb2lib20xMGRWYUU3elp3eDMyZnVQ?=
 =?utf-8?Q?YuuB0Y+jZ4oXooBT4lDk/CHvFUhwxHtqmLxTd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fb35f3-8571-489a-3428-08df3073f4d1
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 19:37:49.8688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7VyJy0RGHZMpnSv4IwAhMxS6iCDNXEvMfyO6IDXGMPaeeuZy2bbtNhznLLYt4qcvkSX8PYBCVtbTDf1tnyrtuwY9Igjl1bzic6lQfI/1PigRbsOh4TK7EykOoPpoJey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8679
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

Rename bus@4c100000 to hsio-bus to warning (W=1).
  arch/arm64/boot/dts/freescale/imx95.dtsi:1878.16-1907.5: Warning (unit_address_vs_reg): /soc/bus@4c100000: node has a unit name, but no reg or ranges property

Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
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

