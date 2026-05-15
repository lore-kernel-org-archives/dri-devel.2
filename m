Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6A0CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D756E10F40A;
	Fri, 15 May 2026 06:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="XXgILA+k";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4666B10F40A
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6dejEXXz2zhatnVfPfW1ZBGrdz/ob20qfsbWvwu+X3DaYnvBetuhPY7Xwsd1J4LRaeAeVrSuBLZoQmR9W3wFh56PtLToOZZLzE636hxlIhNRIMgE8ZCcG/4otFaZMkTJ5TYcREnaCYNri8+86mIGcDuCB8C9hewr2cVbkU2GxYPzpa4RHR6uWdjTW15xrBFzf2QLWuDNwRIKoWWN2zwIusWISeomHy0KQXkKTxBudTq/V/5FFo8zGAwWT2dNM8JKtB51ECDVuhj0DlHr60AlJGw9ILqXyiwomNeXVUJcJiKl3xd2Ap+g6W0SEKTtKOtNmoGBJmSeXKccnfW/QEzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI4uqTCQU7EXnZSFvfioLE0e43AK4Rvcktq9qg9WywI=;
 b=D+4ZMJAWh3M4iD23NopRqzkzHS9XPqAXPidhmXL1eZ9wOm9jEBTV7GYu1d0jeRreSWwjzIlmGIa9I/ruykz4QyGvr7N0A9KGFqBHOOWungIcywOsl45v8n1fDoB/H+A+sTp5HLELHgT5MtJxP1ZyLTt2uGiuAq+HVmBEtI2gvy1EwrGOZbCS8WBiLr2ICB5Vf4b81lM5APJAKuAypdECKdKCQpc8Nzjq1ejUsg0IgXYDsggVCE4sv/PHbmO/nqQ5NDOaK90+x7OU7KSOpWvUwH9yZYbdn+3mFxHreFBFR452IxU9YrvNdAtMhi9yAIZeYDIsGdNOF7/35fSeD/XLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI4uqTCQU7EXnZSFvfioLE0e43AK4Rvcktq9qg9WywI=;
 b=XXgILA+k5PFl3yBwirHTsXBGOPA9uoKrlgmlt/CYFxvcrMEtUqxGZ+9SRWicKi9wEWkT7NSN++Hul6fW3elsxlnm09HzYrIb39O9OkaNTqj8LMDsOnwLHh2IehjbDtc8Iwv9ljJ0V6NPvPMR7gUb7jj0iW3lGkdDJvOnUJRh1MIGQgkTwkoyqAwPkWODb3bDJHRhWj+pHNwZZpAVEF98M/A6xkqRIutLxuprUsxwdzcnYWTf2h1BONZGb/6vv6y2lzZG1jlozY4uJdlj+ctpGS7zwIea2l84WJRP0+KTPFME3QoLbcwFQIX+tgaSdwC1ZIZ51oBA+xBMMwsCH3NVUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 06:53:12 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 06:53:12 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 15 May 2026 14:54:16 +0800
Subject: [PATCH v3] drm/bridge: imx93-mipi-dsi: Fix mode validation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-imx93-mipi-dsi-fix-mode-validation-v3-1-91f7d22b2fe4@nxp.com>
X-B4-Tracking: v=1; b=H4sIABfDBmoC/5XNQQ6CMBAF0KuQrh1Dp0CpK+9hXNS2yiRCSUsaD
 OHuFjZsdfkn899fWHSBXGSXYmHBJYrkhxzEqWCm08PLAdmcGZbYlIgSqJ+VgJ5GAhsJnjRD762
 DpN9k9ZTrUGFtWokaKyVYhsbg8ts+crvn3FGcfPjsm4lv17/4xIGDVsY2UimObXkd5vFsfM82P
 OEB1hx/AjGDUjsjHq62Gs0Bruv6BYJ+bsMjAQAA
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
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8df488-606a-41dc-9d0d-08deb24ea17a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|18002099003|921020|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: 5wtqYknaPJt/enUat/Zv+oO9W9Me8Z7dpdcc6usw4FTMLO47jQ3DFPuhDbv+0HEn7QKxMC8tM0F2xuCHt8YFuw2YIhKFrekTZZy0594ZCf3g+mC8oRSoc+GZrI1tm1dLYqK3JVqDDptKUEKCeFmgpK7A1HvIeJ8FPunNmbMZXsMO9kf2FgbQixUo6PkcxJivZF+4IhYvxTQsX/+o8cKqtreY7rqY4gS564PU8u+1lGp38XLhqHphN4IahlZHafemFRxjsxj0wFh2Yc0psOhfsw7BDfRFNlE1WrCXqYgBwbtgkHzI7Wk4i943Cm1AZcKOEC8QkqUWQMqlRUv0LHE0UtGko4+u7cZPVlDY0vJIE5m7puBZsl0rxSc/49K9ffYH+x+Y+NssnqRx2EcoAuSAwdGHDnDugkf5NEXqVWhe73v9c1p8ykpkNmO5ICaPEVIgSK2m1kMfAX1Bq8HlaYf4cDWLZGGL+qdNZRaSidRqSGKzNHjgOg0IDSqjXc4VKfouGz52CwQHGLofFZaRzLydK2/C20b4Ju+PoGHlz5hdlVa6JJl999H1Cn98kWmOkRGVe3nLLO6e7ZuD8XjN94wcCOtAx/uConCXZVYp/zgwJk0mOLZR1M7aB++rDcjPTPjyhItgtJ8q/4ve1dWay5G9SfGNtRcsiipRmpl8hvKW4/X+S69Lm0wDA+EtGokH87KxFmErUehgIqqD7azbp9QwcdZb8Va7EVYiu4eTtWc502c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(18002099003)(921020)(38350700014)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFFkWExOamFIbUlteHNJZWFDNWY5cGJlNVVGdGFCbytoclVRaG81cG9ZaldP?=
 =?utf-8?B?NWw5OENsL1o1OTVFUXF2NDBKUUk2bFo5VVJlSU1kejVWbWlzS2UwQmQzSHlh?=
 =?utf-8?B?MXR3dU5wZ0w4cHpycDREZGFDWDhWakZxVGxPMEhwbHlyRU5WZ3RqbG1wKzZI?=
 =?utf-8?B?Zzcwa2RaQytldzZSeW9MYnVUSm4xcTRGclRWUTczQ29GYTdiS0R1dkJ3SmdQ?=
 =?utf-8?B?SHVpR0tPY3pvMno1TFZxY1NDZHdnWSthZDltdVFscFh0aysySm1uTlAyZms4?=
 =?utf-8?B?RmhHNXRoRHcvUXZaUG5YTGUyZjFFd25WVjhESUxNT054Sys3KzR2UEliaVBq?=
 =?utf-8?B?eWd3SHV3dis5cS9VWGFmSS94dG1YTTBBbERQRXF6R0VXU3BWcG1LQzB0TnZR?=
 =?utf-8?B?blJKN1JON3I0ZUtZM1hKVmpDR3BtQU9sVmpmc203ZHg2OTFCZy9vM1Jha3gy?=
 =?utf-8?B?VmpUWHFMcXhQczVTM291R1o1T3pKbnUvYzdVYkxDcVhhOWRCNHFlOXJvZGN5?=
 =?utf-8?B?Q2VsOUxrYU9TL2UvVElmcXk4UHZmQ2QwSm4raW8wR2pzQXdueVYvOVRtUkls?=
 =?utf-8?B?ZHpBQ0w2a3lBVFZqNkdZOFBreHhFQ3l1Y25LakZQZTFXOWRWcW9NS2tWWEtq?=
 =?utf-8?B?TFRFMHhvb1lxRmdickNGQlNQRlFSMFpORlNFaUJQd0E1czFqclBHN3ZKWEZ4?=
 =?utf-8?B?SGtYRFJNYTdxTHZhMjhNUVA1QTBsSVNncUl3NDZBUUZENm5QbUxDQWYyeExT?=
 =?utf-8?B?cVFTVVVtZXd6aUtkWkExVEF6NFRJZTNaKzAydW9YcVJUQ3pHTThkb3Btam53?=
 =?utf-8?B?dCtHUzM1bkx6dXA4eVNpQ1Z6WWY4SHVDeGdHbnNXWktVSU1HL1RUQXZKMnF0?=
 =?utf-8?B?K0E1ZDdsM2F5MWs3UUJYUU5ZTDBnVlJMb2lRZWJMS3BKYjE0QTBuZnlWZDFo?=
 =?utf-8?B?YUw2MUhZb1ROeHk1STR1WG5UYjNaT2pMY1BHZ3hSdklTZCtLdGFlSUZMZlQr?=
 =?utf-8?B?MmxvVjBlVGZmcmhDNExLK3BnVkQ3U2RVdHFaUzQzUllsZE1LUkhTUE5rYzBQ?=
 =?utf-8?B?eFE3UnR6QlFvaGM3QThhRE5CMXVRcXNicWhNY2ZlbGhNa1JjQlZZNUxPVHlE?=
 =?utf-8?B?MGF1SzJ6Qno0UGYvU1R4TTVBeC9ZSGxBMnZ6OFNQTHl1ejFwQ3A3Z3kzWmwr?=
 =?utf-8?B?SytnajZjSVFrbkRiaXUvc0FKazdyTWtRZDJVaTl0WmVlVlpTVUQ2a25lZXlO?=
 =?utf-8?B?SHNnRWRHL0g3WTMrT1dtMEhSajlGZUNidDhPZWs4YjZFS2ZlNHpscDQ5eTNv?=
 =?utf-8?B?ODJvZnl0aFZkekVmVFl0cmRNdlhwSVdGL1d3TlVNNGFyd3VONlAza0QyeG9S?=
 =?utf-8?B?TU9zVk1NMFdxVENYcG5FZ2loZ1JPK2ltaGFTZDNEY1RKMW5xamFhbmtUdkp3?=
 =?utf-8?B?Q1dKd3pCZ1ZPN3B1K0RwTDhDbkRIdEEvcVc3L2dHYXVNK1VnditLb3RaNDdF?=
 =?utf-8?B?YWRxdENUb1lDTlpHNDBTN3lvdWJ4dFpmR3BoUE5pdEZwV0FlVkFnOVZRcExO?=
 =?utf-8?B?SWJwYkhyWHAzMzRpaXl6ZnZlR0MyckhkUzR1UDdZSFh4ZjJ4RDl0cldhKzZH?=
 =?utf-8?B?TFNIR3FpbGcxZ1R1YjZZYmxWbS9tcjRtcDVFc0labWlnTkZlTmdGdFZTTnRv?=
 =?utf-8?B?K05Xb2grMzdMK200dHA0L1lQaUNuakdYcng4aWQ5d0RkaFo4YkwvM3FERnNE?=
 =?utf-8?B?WFNac2VqSkwxYTZzMUZBU1FpNk9GTDY4a2lML2hSOUV5SUhCRkh2VlFHWU5O?=
 =?utf-8?B?WjM4M3k0b3FWY1JaYjhZL2diZ0dIelpjT0R1R05pcEFQNUdWbmhSeC91TGxa?=
 =?utf-8?B?N1oxZ3IvRHIraXczZlhXUGlvUjlaUGVyZEQwa0xxSXpQL0swbHNJOFY3QUkz?=
 =?utf-8?B?QWJ2dTJGZWRFa3J2b0o1WVlnSHJRNmxRMGk2bFNYVjlQbU5MRm1BWmNPM2hT?=
 =?utf-8?B?Rlc5TlJLVXBFMHNKMSs4ZDA1b1VSN3VpUDFGQWZqdlYrL1U2TndmRUFBb1Ux?=
 =?utf-8?B?ZUJXbTMwMkhRT0UvNVVhWGFxM1Y1aEkxbnprMy82aWE3ZDZDa2VtdkdUMk1P?=
 =?utf-8?B?eUVBNkErempTQ01yKzViYlZ0ZWtuUmszeGtwZmJ6STRUc3lPREFGV0xKQnl4?=
 =?utf-8?B?SktLVmIxbS9RVTc5bjZ5UWwxTnZGYjJ5cE5tNzB0WVQwVGs1dm1JazZocW9J?=
 =?utf-8?B?Nms2VllzZytrZWE0dUc0QlRkajlRTVNITjVkZURydnp2eVhPbzlOTkdrZWg2?=
 =?utf-8?B?TFc0d3RNVXRmYmFDNVVlaE9XekVCK3M2ZEJSUGVDdEFaUDJRdnJkZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8df488-606a-41dc-9d0d-08deb24ea17a
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:53:12.1397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DubXrGPL02/psDH7sAFXD1PmaQcsJLxdCfi2TaNzUJQTtyHH9eB4gL/4xwAehCsnhR/d57skRCmK8X7jufTetQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059
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
1920x1080p@60Hz CEA/DMT display mode with a pixel clock rate running
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
Changes in v3:
- Iterate over next bridges manually instead of calling
  drm_for_each_bridge_in_chain_from() to avoid deadlock issue.  (sashiko bot)
- Fix a typo in commit message - s/modes/mode/.
- Link to v2: https://patch.msgid.link/20260512-imx93-mipi-dsi-fix-mode-validation-v2-1-7aec3be5da2c@nxp.com

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
 drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 44 ++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
index 8f312f9edf97..4a84e00ae563 100644
--- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
@@ -489,25 +489,43 @@ static int imx93_dsi_get_phy_configure_opts(struct imx93_dsi *dsi,
 	return 0;
 }
 
+static inline struct drm_bridge *
+imx93_dsi_get_next_bridge_in_chain(struct drm_bridge *bridge)
+{
+	struct drm_bridge *next = drm_bridge_get_next_bridge(bridge);
+
+	drm_bridge_put(bridge);
+
+	return next;
+}
+
 static enum drm_mode_status
 imx93_dsi_validate_mode(struct imx93_dsi *dsi, const struct drm_display_mode *mode)
 {
 	struct drm_bridge *dmd_bridge = dw_mipi_dsi_get_bridge(dsi->dmd);
-	struct drm_bridge *last_bridge __free(drm_bridge_put) =
-		drm_bridge_chain_get_last_bridge(dmd_bridge->encoder);
+	struct drm_bridge *bridge;
 
-	if ((last_bridge->ops & DRM_BRIDGE_OP_DETECT) &&
-	    (last_bridge->ops & DRM_BRIDGE_OP_EDID)) {
-		unsigned long pixel_clock_rate = mode->clock * 1000;
-		unsigned long rounded_rate;
+	for (bridge = drm_bridge_get_next_bridge(dmd_bridge);
+	     bridge;
+	     bridge = imx93_dsi_get_next_bridge_in_chain(bridge)) {
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
+				drm_bridge_put(bridge);
+				return MODE_NOCLOCK;
+			}
+
+			drm_bridge_put(bridge);
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

