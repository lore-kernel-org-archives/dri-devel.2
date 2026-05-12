Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0176DCD4855
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 09:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6073210E9F2;
	Tue, 12 May 2026 09:17:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="UKefvGu7";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1545510E9F2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq/zBKMW1zYoeV83QZcHo5ze6GvRpU7vMAHk0fXz/hgN/ay72Sl02ePeH4aiQ2PidcFLX2B/RInFzWlngvwTHdi21ZarsOWsiHH/+77SfFxPNRQ+ye3UXYyA1Iw+FpRl3NQOZwaTvNNS1Xxlft374r1g8GKLWc5tKQxvj0XPPPPbxMzdiXmmPAeYV2qeOHOPZWTtn/oqpAxEel/nZ2FGZbpXxOqztfPT7bEG11P+C8Mf1xprKepEYu6sZkDy4SpEzr2dPD+KNNuZxl3lHK2Hnw6JCpQyWlqdnmZCLHVW4E+G/Bn+NN5oBSz83FKjEzxeeigRnxXAy/59zfq4TOM/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18Vr+HYQqU1x0d3zcxMR3wjgCPa9yyH37iJ2bUgZJpk=;
 b=QDzQYbhtjkHk12EXWOqfk28ZOQD5vsrtp86oGfkiUpAVvQZUi3hWcsJcrVUKLLtaCk5sG6vuRjV9jw65bYGwzmN9vYNMw3kGZsjLL8H2tNx7IOnF4oF+Qw666SyA2hsMXkh6EelFQwCdHHF5LgOQDKn8uadVpmuRLzg+yP9y6L/bak9El52ZRpgm1Q8cRFOqoE5upQEgTvXNpDzzpDdEK+YYD8tK0mibZaFhIgnHEP0mBGHZ19b+xu18WOeEdSPlnG+hn7T+nYZ+Xb1tblsLfraEuyamwQSaEpJyE34bCqz7PQjmcVvprae/q0JcUXkjfAcR0UPU6ueL5/mPcyzlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18Vr+HYQqU1x0d3zcxMR3wjgCPa9yyH37iJ2bUgZJpk=;
 b=UKefvGu7oy0gSXBmrfyFB7SZpHRiyVg93rzeg4/028ISwrIZGZqjXR/oPXZ1yvN5ELE5ToUY7t1F5iXnLvp/ILy1JSIsHkQdx17Rq/N17lzdisEqANdB1dxI5LP0+ZZLWK7m2Wv42mUt2RdIjqX9OiWFgB3DR010qwM4ayyFGYmWKhT730Dvvef7NYSulEXOh2ZNrN/p6IHR+r1pynQXHibH7lsTcQSAX7JHh67TcQdgE4Jkpab1jLCMCCDWkBYdknBithQQAhC6b3F0ped7PwE/tcVTyb5X3GMAvFaiyNvfJVZNbMHZ+U7q8R5ZhvbvPjRaeOtTSvMopTKRx32e7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by AS5PR04MB9997.eurprd04.prod.outlook.com (2603:10a6:20b:67c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 09:17:42 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 09:17:42 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 12 May 2026 17:18:49 +0800
Subject: [PATCH v2] drm/bridge: imx93-mipi-dsi: Fix mode validation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-imx93-mipi-dsi-fix-mode-validation-v2-1-7aec3be5da2c@nxp.com>
X-B4-Tracking: v=1; b=H4sIAHjwAmoC/5WNQQ6DIBBFr2Jm3WlktCqueo/GBQFaJylCwBAb4
 91LvUGX7+f/93dINrJNMFY7RJs5sV8K0KUCPavlZZFNYaCaupqoR3abbNBxYDSJ8ckbOm8sZvV
 mo9Yyx5ZueuhJUSsbKKIQbamdJ4+p8Mxp9fFzfmbxS//SZ4ECldSm66UUNNT3ZQtX7R1Mx3F8A
 aQcEILSAAAA
X-Change-ID: 20260227-imx93-mipi-dsi-fix-mode-validation-425c872a2493
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::10) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|AS5PR04MB9997:EE_
X-MS-Office365-Filtering-Correlation-Id: 20965aae-e1ec-4f4e-2c4a-08deb00751e0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|921020|38350700014|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: WodZeaDVjtdiJjS/aZwJoe0cfHdQBNzgo8D8Q9UrkVYUju9FJjQOPlYUgFHw2GmAfHrcOt9MOpvuat1BhowdWERNSWlokI5DZ/Ru4DO/68vqJLJy3ZoQueFmMXRe1gmF6bO90NjzqBk+z+wWu+70QmuMFTjxaRhKv5KBWi3kI+hi2M++yUlRwXrNUFxgTF7SlNQFMm/v6hNfG/GsyfyrN4ulXxM1ASWht8Fyp4N0e3BVQkZdXtyxrb/7c60yMCf+S47QRuGkM7lpN6ysmF4yEcc4XqyDONr5CqeKxUWqQ3fdNmXMYTORz/LwYN4GsjS8djTLEwMGVGoobPBj/Pu4Yg3Uk3Mg76HbDJ3vqHYjyrLL9oY5Lfr5KSVOh+yUuE+HscIgF39YO+CQVIubYFZOdS5cazIpjtomSqXp1XHgFfXqREQxR0b3RrspazD4Ik1dib7E5huf5RmTIy5rLQlLL9wlBfGQ2XF/2h/vW59e/tBYinHOlBVk85w16giUf0qUziYYOqnZyoAFj9MEz65932X4kD1yodjYWzoEWiLIPv23m1rGBeAW/0WWYniVWve8Q1A7kyv57QOMiqzGVII6+H7teHmXCreN7ykw2nNhIXnJHSHr0gmZMNqjgwtm18On6P8+krs/Keo/DtgJ5/H2BOcOtC5+mTmlNQHn4p27yzDFlO9rvU8uNRcR162fnWgN/9eGo5o8srAYV7FGx3IKpysKQfUj8AchZDGp9pKA0Rzg4FZ7/xepCWf1bmo+pgFDLvMdDgZnSgW+OAaRoAKDCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDR0SzBXMENyMGhKbFQ1QnRUSDJDRWtRNnNzbGlpZ2luYW5RZzl3bWsvVFpZ?=
 =?utf-8?B?TzV1QXNMQllOQllJN2RSOWVLQStsalhsT2phd04vZDdNek15NWVCVVVmNDli?=
 =?utf-8?B?ZHg5MDRhT1piZTEreGJ2b0ZWVmFEODlmdEpuZDJ0VThoK2sxeFBWOE1HRVQ1?=
 =?utf-8?B?alZZd1ZOZmhtS0xhSGFhdmFhVm8vWDB3K004OWdnaXFMTVhVcWV4ajlmT0pw?=
 =?utf-8?B?L05VQWlucXRscnFaZ0NHY1Bjd01qSTlMWUp0SHoxMlVIWDlyK0ZkdGM1L1Fp?=
 =?utf-8?B?bWRCV0duekNUQk9WeUpLTjBjMzNYNXB0RkdtRk9oRGluL0NnR2RuSmpKZmNQ?=
 =?utf-8?B?dFRBb0dsQmJQOFJKbXlZK0l6WWFvT29YYmJhcDUrOThHU290eE1oUld1OEYz?=
 =?utf-8?B?TXkzVkZPd0s3TlBFTzZqQ0UxdnZVdkxFQzhCL0FDd2VzeFlpakFaZVQ0U2gr?=
 =?utf-8?B?MldNVTZmdlNlTm9mMmlTRWZyZGgrYkVqa0RIMW9sNlhKckUrc0VsZXFrRDhX?=
 =?utf-8?B?MnF2QzFvaEgwaTEzTy9FM256WkcvOHJBQUE3RmhyU0dmbjMxN3hmUmJiQUJl?=
 =?utf-8?B?c2VSbGMwcGVYKzJaZHg4eEhDUzNNRVJFVERmM2o3dk1wdGo1bitUT0RXc1BE?=
 =?utf-8?B?VHMzTEhDZkpHT280cTRCUXFlNXNXMWcxQW9CMzczMEJ0NDFZUndKbVQwYXlJ?=
 =?utf-8?B?dk5mUDVuaERpOTZYMmxVY0VsWG1WaEVaSHA0cy9aNUNnZmFSRU83NGtGbm80?=
 =?utf-8?B?eGRZM1JIS2FoSVZpQnh6NUpFclBXSDh4ZzFRdjBzdmozVWVDQ3dET3k1bXAv?=
 =?utf-8?B?MDg1bXZqcThSbmdnTW90cFpVR3Fja3UzNkVrc29FZUxiR1NsZHNnOHVPTXFq?=
 =?utf-8?B?TGVpd0VMMzJKYTk5YkxJNnZsemJ3WUo0ZEc0cDdmb0ZtMUlFQXBFUGJ2STlY?=
 =?utf-8?B?Szg1U3lad1RsUFFWdE9xTVgweWFRakdjMmtGSWI3U1NhT2ZLbFNGeFFiV1Bz?=
 =?utf-8?B?OVNya2Rqb0tmbWVPV0RxSTNyaFFSVUtqMW9vaUhkR20rMHg3dmV2WG1sRlda?=
 =?utf-8?B?STR5UnQ1UGdmbGVjbDJISytTUWJaVWNvQWJzelN4Wm85eUw3ZzZ4d2RlS2J6?=
 =?utf-8?B?ME9INlpqRkRDVjdXVmUyTjRFSGQ4WEFOWWZqb3piS0l1Wk1vcWhCZVp6bU5h?=
 =?utf-8?B?SnFaREtWRVoyZ05WeWhjMUUxcnhIOGdNK3p4ZjEyRnBibUpHTXZnY29vOUpG?=
 =?utf-8?B?UklvWjlOOWdtMjR6bU9TU3VEc0Rnd01WWEZ0WDBaaEx1U0crL250V01veU42?=
 =?utf-8?B?S3BXR1VZR3BSYXVWSGZwUEpDTlhVaUxCV25zb0JYNzNvazRpWWpyblBodUg2?=
 =?utf-8?B?dytaYkhmQzU1d3ZPd2ZaK3RSaHRPOFQ3ZjB4bExhR09VdVZpOXQzQjNSL0Za?=
 =?utf-8?B?Vi9BUlp3Y0Y2WWdJSjZYYUUza0F3RnBlTzQ0RDFyb1ZYZjhuaE9oOVcwUW5y?=
 =?utf-8?B?Z3FBV3Y1NnFhVkhreUwrQzhRTnBMUmdweGFDU1Nuck5oK0hwR1ZsOCsyb3M2?=
 =?utf-8?B?aFZQSldlODZURW1TQnREQ0xFa2ZaNko5bk1QU2J5eVVJRTNobm8vVzNhVnU1?=
 =?utf-8?B?cWlpSUJsR1RTVFdUdVJqSnFadXkxdHJEZDhRNVgrb0pMWFZHYms2QVFjNlB2?=
 =?utf-8?B?NkhCYzN5K2pobTc3WlloWUVBUU1GQndaZzdmUFpsYkx6Ky95dzlWTmovVSs5?=
 =?utf-8?B?Zm02SUNIMVM2c0QrVjlKQkZRaFU5SXYvak9peHdaaEFuL3ZzcDFpQThvU0Ro?=
 =?utf-8?B?TEVXVWpVRGx0YzlTNmdHOGNSVm9hNFV4cjE5Wjhkdy9TNmhOMGxjdlBtVnFX?=
 =?utf-8?B?bUY1QU02bmlkdzB5VThxNHBmVmNvdTU2QTNVWmJpY0dnMnd3dWcyRjRnR0Np?=
 =?utf-8?B?K3NiZXcrbFIrMnlmSkNNTVB5Q0hnZ2h5aVVmK2pMK2cyeXRpU1VoY0lwczc4?=
 =?utf-8?B?eWhicmtIV0ZMcDN2QVhmTDNsblUrWnlzbXZIRG5SU2NNWnA1NTkxaWVQdFlh?=
 =?utf-8?B?V2ZLQ0dlQ0F5MEdvdk1CZUl6WVhHNnA0UTA2cUtYaWpmTnpaMEJNWVlqTmd3?=
 =?utf-8?B?RnVGTkQxeHdyaG5BQ1lVNmNEeTVxTWdyWUVxLytTQUN3VXZ0Z1VJRXd2K2NH?=
 =?utf-8?B?N3NtUEZSR2toem83R29VSHRsYUxqa2I4L2Q2L3Frb3RoUDFuZmlHaXlCSnVN?=
 =?utf-8?B?bWllZ3BscWNOUWIwUHdFZnBoTUt4ZVY1anlQOGl1ZWdra3NhQ3dWbnVVbzFY?=
 =?utf-8?B?MUdBdHhmUWFTMlVDK1lYT0UwME5LOVhDc0o1ZXNjTDNZMTlRWkkxdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20965aae-e1ec-4f4e-2c4a-08deb00751e0
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:17:41.9910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aPsA3cvwBc1aHgAinsNKtx6BpMu6xhlwjJ+6jRbR5Rjd8IkFS6ovJDwPCwXkOUpQKp+yM8Z/L2Bm/erHyvsmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9997
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

i.MX93 MIPI DPHY PLL has limitation for matching with some pixel clock
rates, e.g., the best DPHY PLL frequency is 445.333333MHz for a typical
1920x1080p@60Hz CEA/DMT display modes with a pixel clock rate running
at 148.5MHz with 4 data lanes + RGB888 pixel in MIPI DSI sync pulse mode,
while the expected PLL frequency is (148.5 * 24) / 4 / 2 MHz = 445.5MHz.
Fortunately, VESA Display Monitor Timing Standard allows +/-0.5% pixel
clock rate deviation for timings.  So, for those display modes read
from EDID through a bridge with DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID
operation bit masks set, pixel clock rate could be adjusted to match
with the PLL frequency(for the above example, the pixel clock rate is
adjusted to be 148.444444MHz with about -0.03% deviation from the 148.5MHz
nominal rate so that the adjusted rate matches with the 445.333333MHz PLL
frequency).

Instead of checking the last bridge's operation bit masks against
DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID to determine if allowing
+/-0.5% pixel clock rate deviation, check any bridge after this bridge,
because the last bridge is usually a display connector bridge without
any operation bit mask when the clock rate deviation is allowed.

Fixes: ce62f8ea7e3f ("drm/bridge: imx: Add i.MX93 MIPI DSI support")
Fixes: 5849eff7f067 ("drm/bridge: imx93-mipi-dsi: use drm_bridge_chain_get_last_bridge()")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Changes in v2:
- Collect Frank's R-b tag.
- Add an explanation to commit message about the reason why mode validation
  checks bridge's operation bit masks.  (Dmitry)
- Copy Dmitry.
- Link to v1: https://lore.kernel.org/r/20260227-imx93-mipi-dsi-fix-mode-validation-v1-1-a9cd67991280@nxp.com

To: Liu Ying <victor.liu@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
index 8f312f9edf97..6d65df9ed970 100644
--- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
@@ -493,21 +493,24 @@ static enum drm_mode_status
 imx93_dsi_validate_mode(struct imx93_dsi *dsi, const struct drm_display_mode *mode)
 {
 	struct drm_bridge *dmd_bridge = dw_mipi_dsi_get_bridge(dsi->dmd);
-	struct drm_bridge *last_bridge __free(drm_bridge_put) =
-		drm_bridge_chain_get_last_bridge(dmd_bridge->encoder);
 
-	if ((last_bridge->ops & DRM_BRIDGE_OP_DETECT) &&
-	    (last_bridge->ops & DRM_BRIDGE_OP_EDID)) {
-		unsigned long pixel_clock_rate = mode->clock * 1000;
-		unsigned long rounded_rate;
+	drm_for_each_bridge_in_chain_from(dmd_bridge, bridge) {
+		if ((bridge->ops & DRM_BRIDGE_OP_DETECT) &&
+		    (bridge->ops & DRM_BRIDGE_OP_EDID)) {
+			unsigned long pixel_clock_rate = mode->clock * 1000;
+			unsigned long rounded_rate;
 
-		/* Allow +/-0.5% pixel clock rate deviation */
-		rounded_rate = clk_round_rate(dsi->clk_pixel, pixel_clock_rate);
-		if (rounded_rate < pixel_clock_rate * 995 / 1000 ||
-		    rounded_rate > pixel_clock_rate * 1005 / 1000) {
-			dev_dbg(dsi->dev, "failed to round clock for mode " DRM_MODE_FMT "\n",
-				DRM_MODE_ARG(mode));
-			return MODE_NOCLOCK;
+			/* Allow +/-0.5% pixel clock rate deviation */
+			rounded_rate = clk_round_rate(dsi->clk_pixel, pixel_clock_rate);
+			if (rounded_rate < pixel_clock_rate * 995 / 1000 ||
+			    rounded_rate > pixel_clock_rate * 1005 / 1000) {
+				dev_dbg(dsi->dev,
+					"failed to round clock for mode " DRM_MODE_FMT "\n",
+					DRM_MODE_ARG(mode));
+				return MODE_NOCLOCK;
+			}
+
+			break;
 		}
 	}
 

---
base-commit: 877552aa875839314afad7154b5a561889e87ea9
change-id: 20260227-imx93-mipi-dsi-fix-mode-validation-425c872a2493

Best regards,
--  
Regards,
Liu Ying

