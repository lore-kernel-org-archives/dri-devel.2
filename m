Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B035AC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B3FC10F10C;
	Wed, 15 Jul 2026 18:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e+VbSn48";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B929B10F10C
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1d3EsAckH8QhOY3tA7xvIAHPYMDu+8okJDx82AVhmLUEXNY5zvK4eoZg9saqcsPZTRS3LgfboxSh1lwKDdFNN2NcxLcnwkJJnJZGy8uCBlhG4Z78/qo4EotPa/yI6YAU6Mk+C6LpUu3isWF0nD1N64FfOGDo3VNAvF2T7zMUIBjdgQgi/uimUm8wBwM72Rk7oD5DNXE+NAj2b/9wSIoP6+qEudYx3FLTLhy+5fmJ0geZ3JS/Sj9Rf0Cdtd8uXhzdl0zG6IeRQPGDulJnnhmeeM/uq6vrInYpfTeVvZKovipR2J/J16XJ58ZmtTE6xILP8xt4zbv0/dEH529T+qaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXpHhJk2U5s2/z6u3vhr7gLvnIMm57oCxaS/ic4ew4Y=;
 b=Ngg1hVgAooHfWTMJlX+6DnygCbuKBrs/puSWdX98VH+NbcMhjLiHC0kMkNZSLSm9GtttlJ2+XUAaPfA7LEsy/YAiRE+psT9IyBJ4ONP0PzNDp4GgiaWe4DKZWhKhakQEfC59s5j/GZS8BHLyMP96E517fQg6ITml4lkB39C2g/DO+a2mc2yHcKU80PC8HwTAA7aO7/leK1xjF/Zhlxt339t+f0weBYZp0IHE0b7ug+Z4r9aVsRGa2GMKrfNS936TF9+to3Zjr4iqeAOrCwB8hkGjXvtF2UPl9wx12tLER3MIr2iw2B1yIE89XpyO6LKGpDxK/849K/8jezmMyMBzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXpHhJk2U5s2/z6u3vhr7gLvnIMm57oCxaS/ic4ew4Y=;
 b=e+VbSn48UEJyRd5WpNuAMR2pnUrxr08l+xO1Ap9zy2+6f171s07ZYuLUClYUGbAEPsdwrbGFJFjkIJw6aVPPwZ1xt6zFHbfvTjBm1urrEufJtU/KDKSUG+uNm2xtZxiGHxnS2VUOcU9E+8PHHb4RgqiXbbl3ApbmjwSNvTtHXG3HLNgOJDt8WBYTg8pT/VJqv841S/uQ/JIHyUCj/rB/McC3rq+Nev2js6Q64tDbvqCR6V+v4/2Mf8W/3ecdOp/59UUcQKfLAGFlWmF44/7trywQBoQ6aVZI1Ey1EOKwGgOYd7hRnGz1o+DDsd8RoKYOxl9TVsKXJ/kDyZPhi7Tt+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 18:35:09 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 18:35:09 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 15 Jul 2026 14:34:48 -0400
Subject: [PATCH v2 3/7] drm/panel: simple: Add waiken WKS101WX001-WCT support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-dxl_lcdif-v2-3-da797562636e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784140492; l=1958;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hoqHcYiskvkyt2DvOtXS4Z6nhCMojnxy21ZY+ghPMCc=;
 b=oTDqwFWvDRVNacCEmEfWDdWA2pcAPasxIpTYMb6YA1Z6RBIdLne5lg54mLCz/9pXVUEaLQUqL
 hUS13eL07vAD6VxmTE1+epyCuLpz0tSq5dJPxXITX+gIcrUjC333utW
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0043.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::17) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b11daac-5c7f-4ce1-2815-08dee29fcc82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|56012099006|11063799006|18002099003|22082099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: NLx3mtZVgZDxa02d13Awnhux0MTyNG0ItNZ31hTXkoid1YO8uO2b4RnNfuEVgPplfFU/hIb4qU/r+J5GYHrTxMjxqJlkNZcRT4Q0ireb7ioI3loQUKV0YPPjaUQCecyujm5Rdwmf/ynWHv993r0mIkl9v2qUd2l8horj2W6Mi2Dwt4vUOcrB3i3DQVth96j7NpzBf1XRD/CjohymAt5miQ8+TvE2QtwMBtoEmhlJhn4fkdJGgA4VpbZA94BYBdnCcd8bTMcJjZLI4JNOtGDJcxbdE7pK44ffyis3FWFJmI2rIlyXu8Alm+Tw2hxSHp4zTyxYsSFhmn8qH6ZYV4aWL+85tM8glmod7ZbS3sGpXm7+ZOpe5rcvAvckn+/M3dZCw48jSG60o5+MTrIIRFi6w3PTtK2G/uk26WON/lgui1KbPZzach/GyvDVgjEiIcXuWRDJ+gVfphoDnBN1SOG3fTl8/DnrpGcjvmaJHFmNJcTxDt2trx3qX93OsGE6JCRHjfGw06BEiDEWJcaQOAx81qtv8AOBzHOlkW9PDweiVmrwxEoG+xZ8boS9A2YgDVYSYOu8oZhZwq0VSRQCisBThe5/V8XIx6mp52HEVbPVlBC8mLyZCVNOzaLtrhvq2wepnUrCF+KL3hXk5bF2xr7M/KIix0hnNYQoBhucE0XXe4wAcQ1TDHISeq2vAki3HEyu3zkQuI+N5gZyK54j1KNb6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB11791.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGdsUENlc1EvZ1R0R1plM1BkcVM4SGx5VlpibmZ5V3UvTEpYZnM3emkrbjJJ?=
 =?utf-8?B?bkpxZUNGdXZ2UkUvYzEwSjdHUTVHWFlwV2JBMEVScWo1eU9waVI3WnlnNlo4?=
 =?utf-8?B?TnFoK0Rxc3ZzVFNvVHZQUlhyb3lQSVcya1dRaTJvTDhORXRDejBBSURjOG80?=
 =?utf-8?B?V0NsRlN1bURoazdzTXFuMk55MlhtYzJDOVhxeHBVR2pza0FYOWMzYmZWQk9E?=
 =?utf-8?B?dXJsT1FjcmZLV2JJYUNGYlpWeEZZU3VLUHlXVmJQTC96YjgwRlc0NnlaQVpH?=
 =?utf-8?B?SVlYSENOUFlueEhLc2ZOTkxIREZKdmJ2eWx3bmRmbmk0SFRLYnBtSzA0NHc3?=
 =?utf-8?B?QVBHVmpvVmJSSmNyUnNkSXZUUzF6K0lmSjNWZXVUSU1jK05jVmZpZHVXR1dm?=
 =?utf-8?B?eXZ3TnJNcnN2YnRnZnVRQzJ6TW83cGY5K3Y1WGd3R1RSZmZ0RTd0WHl0S3FY?=
 =?utf-8?B?MFVEZ205TFBqekF0TThJbytYb0U2M0o5dXIvTHJHYU4yejBpb2tRZmJqTG9y?=
 =?utf-8?B?Y3V6bnRRTDlvckEzYXRBVEJaMXd1ZzZ6azZIS3ZBYmdOaURTWlJTYnpJK3pi?=
 =?utf-8?B?amh6cCtKVmVIcUVQRTBVZnVaMGtmVW5pV2x4d0xodGdOdHdwWHV5TXVkcEs0?=
 =?utf-8?B?S1g3bWQzR1VPKzZVYmZXVmhzRTZ3WTBNQUlwVzdIbkZJRzhQRWdlWUhYaUFV?=
 =?utf-8?B?N3lPNHIveWNYK1lySlpCR1JUdmFNbnFFSmVCTzEzRmx1Znc5N1NzWmtGVHJl?=
 =?utf-8?B?VVRvSDljeUllcGNZTWZRdTJhNnNVWGtLL2hoZzRGK3J2UWlFb3hYbXBFTk44?=
 =?utf-8?B?UU82eHZrTGd4Nmlka0JZcTMrbGN2WnEwSTZnR1RXem4vdTZ1VHAwSWhiZ1BU?=
 =?utf-8?B?elJYMGQvZlI2a25PMENHSUQzaE9odHNST0VOSXhrbmxFYjQzeTJXUGNxcWx2?=
 =?utf-8?B?L1JGSVJheUE1d0RvUlJKOGdkQWhsanhiWWpnMU9YVFZxMVJFeEFRWVlKd3Aw?=
 =?utf-8?B?R2o1VTkwaFlpYjA2TEZaNDRYM0VWc0ZQdUFDQlduVlRhN05FazAzanIxRThO?=
 =?utf-8?B?a1M4a3UxVlZiT2JQTGhFRitzY2dOMW5ZOHZ5STR0M2dUQWV4MGp3SGtlM0R6?=
 =?utf-8?B?M2hRSkZURFFXaFBScU9DeFBweVBvUjcrWWFQblBmWDNUOFlWb0dXQmJNa2Q1?=
 =?utf-8?B?b2RoL2ZSRWhsUisyZThRcmQ1eXEvUGF1RTFnbjBqaWZwZDloaS95NUlLU1VK?=
 =?utf-8?B?M08vMUp2OHh1Y2JQbmdoSFRmNE1KTmttTS9CaTlFWmlrbzFZeEpWUFQxS2hz?=
 =?utf-8?B?N1NidmF6TDlVZnlBY0NPc2V2Nmg1eDVnVWFsZ2xxakM5WjdOUkN4UzhzWGxE?=
 =?utf-8?B?ekUzNEczMm9Bbkh6WGZKaDQxV3dlaUZHcjZCVzRrc1NhQnJ3VHJWdHNRMkRI?=
 =?utf-8?B?VEszQlc3YkNLNUYxTkdid2dOVkhIc0tGMXhYOXRya1ZMSTA3ekZnTlpwZ3Bi?=
 =?utf-8?B?djJlYjJjVU40eUlBL3dJU2lPYnZzTHgvcGZVT1ZlaXpYOHQ4KytFYksvZm1D?=
 =?utf-8?B?TVArODBhK0tXTHNBQVMyUFlNUlhwZm5vajQrbFlLNVo2TE9XaE1QSzcrWFA4?=
 =?utf-8?B?TTdiSU1zMG5PUjUzT3htZFlpMlk4M2tLTjJCNXQ1ZnRvOW5sQW4xSlRnR21u?=
 =?utf-8?B?ZENZdVhxZHFmWEdRdmtxSEZ6T2NHUjBQcEp2ZllGZWwwQ0FUU0xEZ2d5NDBV?=
 =?utf-8?B?STRGLzZkeEJwT3FHSjY2WGN2UTZ5Q2FndHdjSkxUTXNoRW5nS1pXc0s4OTVj?=
 =?utf-8?B?NUI1Vm1YaFA1ZWtnRGp3Vk5EVnhlSmZpRk5kSFJDRWtiQ2grQVZJcUxQQ29w?=
 =?utf-8?B?Sm5kYVp6T1FmYUhXZlFRdUpLMWdEam5SczBCOHBPVDlNeUoyR2ZGWTlpYi9T?=
 =?utf-8?B?aXZjQTlKdWdTeG5PVDVSaTJEQzUrREQ2N0Fuc2FWK0poR3VyemVnY2tPeDlG?=
 =?utf-8?B?di9STjZqdFRKd290NXRCNE9ldG1yOW1lRlpRMTRzYWlCNmNqY2d1d3pJZUl2?=
 =?utf-8?B?bEI0cDRqM2ZXZEM2WVQ1enlZTDVmK04wZm9tSXFwb2NEdlBpZGl2b1NVdHox?=
 =?utf-8?B?ZlRFU3NTeUd5eEZaVXZFdzUxQjd4amUxTDc4SlBYN3lTbmZGQWFMYkdWZWhE?=
 =?utf-8?B?OHUrWnR1RGRVb1J6bTFSZnZUWm5yZGFYcDNsOGIyVkVNRUU3NGplMkdkVG5E?=
 =?utf-8?B?bHZMVGdoRHRBc2VkbWZlVmRCU1hPc2R1dEx6WXlVdUpvM2ZWYm50OTk1bk1h?=
 =?utf-8?B?SXRzS280dzhoNmJSdHpQUnR6SWpNUjhmNDV4dXdSU280L2UrRURqTG1JMGhM?=
 =?utf-8?Q?qgIoj6PfEkqmLY3b1BvrLefI8jGLsTFs7UEi9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b11daac-5c7f-4ce1-2815-08dee29fcc82
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:35:09.3860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIlJW/hjxdi1nLjciGsFtYc54i15IOi+lUMibI0UIhCYQcV3xQXit0p5/xaq73OWtYZfVD5b9WzDJZS1rKoRANPZy4aIgBU0IXCt0BB89MtplXDcZEXWEHgxU4HJC5vU
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

Add support for WKS101WX001-WCT panel, which is an industrial-grade
10.1-inch IPS TFT LCD capacitive touch screen display module.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- update height to 135 from 136 (sashiko)
---
 drivers/gpu/drm/panel/panel-simple.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c09bf3db5e78a..73a21303a612a 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -5171,6 +5171,34 @@ static const struct panel_desc vl050_8048nt_c01 = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
 };
 
+static const struct drm_display_mode waiken_101wx001_mode = {
+	.clock = 71100,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 70,
+	.hsync_end = 1280 + 70 + 10,
+	.htotal = 1280 + 70 + 10 + 80,
+	.vdisplay = 800,
+	.vsync_start = 800 + 10,
+	.vsync_end = 800 + 10 + 3,
+	.vtotal = 800 + 10 + 3 + 10,
+	.width_mm = 217,
+	.height_mm = 135,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc waiken_101wx001_panel = {
+	.modes = &waiken_101wx001_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 217,
+		.height = 135,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+};
+
 static const struct drm_display_mode waveshare_28_lcd_mode = {
 	.clock = 50000,
 	.hdisplay = 480,
@@ -6155,6 +6183,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "vxt,vl050-8048nt-c01",
 		.data = &vl050_8048nt_c01,
+	}, {
+		.compatible = "waiken,101wx001",
+		.data = &waiken_101wx001_panel,
 	}, {
 		.compatible = "waveshare,2.8inch-panel",
 		.data = &waveshare_28_lcd_panel

-- 
2.43.0

