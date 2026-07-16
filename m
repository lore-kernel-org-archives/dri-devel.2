Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9046C43458
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 05:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF7410E296;
	Thu, 16 Jul 2026 05:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="S2SK0+Yk";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D3310E296
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 05:55:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TevZIkh742poxHbfM4mFRCbTaQiJ1iMUMQKX1aqUjdAIupiwMAlaR7akcesjnboHRmfb5Y1RlmxEJnglUy6Q1PGx7WIhnVOooRxqU6hgcC9dxM4uEXCgRt7iB8xyM/xg1YxdDgjcaiPHDf7dnQK/4PatIfjnYtlJtaXrtdmgqpc13skqe/boWGBtvqxeYUlPWH/QGarSwao8SlH2T8dRrBYf8z0udmrMXYuGLA8SoA/m7YydP7a2v/a5hThlI/bODRsmjjijtc3z9UHJr793aZV2L0FuLHqpqREioxr0rOq+oN6vk2odP+nlDIgoZFOZIgJgjbiWmeYvXnk9Zvb2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=verBriGhwe7eyfyBUEt7vn5G31kfVQw/wFF6n8edzQM=;
 b=nzehxff1Fu2HaBxwHmTjWNtj6mmmTWbXtDHP3Kg05mYm6CyxWpgSNDNEHBGLG7IiCfyH0EkjvU+dfInijJtaXuGLvPsyb1j1SRvzyOqglBoZojab0kzUstKIIzqLPNbjZmPbvHEpPynYUZT4DHYnsxD1HQwNrSt4kSgAfDZAOCpak8Pte20tw1LUdPQJ5s7ryenOZT0YmUpWyxYuNpAr3R6GU25M5G972MSYUzeh1kS5Hq0Le2c42vy4wM1z+PBKC1HDie0BmFIhkIJzdTrq0p/VMnXTSQ8mYx44BforgM6R28benTiokfRwLUBEvsN4hyLhYhY87qG06KH/QOG2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=verBriGhwe7eyfyBUEt7vn5G31kfVQw/wFF6n8edzQM=;
 b=S2SK0+YkQy8X6tmLkeiad0EpZprOATj2SFzNB9IhBMTknowLA44sH+xRPe9ONrX3JqHLo3V9KUn3FOfGQBey470/FLCiijkKXfirVe7S9g/uQLIyc+L2FBcatgokfnc2+ld3zB7jewt1pOCSEUXiGA5nj+/slu6lWXk4gclvKd5pifOa+/xc3a5iZMMSWcPAutm3BU6j8CoIqgFA8WgcksH+HAfCn0FEnzygN9HV+SaCE012JaUWkXBdBxPzvmsT0KhdMbmbOjRwCTYMw9+A1nANZTsK7a5BHdSPmWISX1mk7WvaAHk7rrEc9a1PxSGwOl4L3Od+RzZXnu2e62iSQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by GVXPR04MB10235.eurprd04.prod.outlook.com (2603:10a6:150:1be::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 05:55:49 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 05:55:49 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Thu, 16 Jul 2026 13:57:12 +0800
Subject: [PATCH v4] drm/bridge: imx93-mipi-dsi: Fix mode validation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-imx93-mipi-dsi-fix-mode-validation-v4-1-411db05bf1ec@nxp.com>
X-B4-Tracking: v=1; b=H4sIALdyWGoC/5XNTQ6CMBAF4KuYrh1Dp0CtK+9hXJR20EnkJ9Q0G
 MPdLWzQHS7fZN733iLQwBTEafcWA0UO3LUp5PudcHfb3gjYpywwwzJD1MDNaBQ03DP4wFDzCE3
 nCaJ9sLfPVIccC3fUaDE3SiSoHyi9LSOXa8p3Ds9ueC2bUc7Xv/goQYI1zpfaGInH7NyO/cF1j
 ZjxiCtYSNwEYgK1JacqKrxF9wuqb7DYBKoEGllrj1hhTfkKTtP0AZTTuLB0AQAA
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
X-ClientProxiedBy: MA5PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::9) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|GVXPR04MB10235:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c0e95d-8764-43e8-64f5-08dee2fee2e4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|366016|376014|7416014|921020|56012099006|5023799004|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: m/COj0+mkGtc0+7BrC1I227ZfDJrG+lmSESr56fyAvakOu/BitIRn+sahlwrw/T18r0xvJ8RJzP5uLvxbVwKnuhYxPQI1qcPeMX9hiN/KcTXMh0Wx5mdk1F+UFMPgINi4V0MGrnJ1cvRUioNEQ+xPoFRTFjwKAgqoI8LETJdObryvJT7VO/XuqA4eGZ/4DUaTyqqVO0xjtUWO+9NrgP4MhHxUbsgZntii94ytojJpqbNgunLQcqpmQmA6HUyi0sMVzMqukB9pf0RapmUBVkcLjekkafxlQLtBMtWu0TZS2ETj5xohEJ8jA0+6Wcx6MvsJ8B+c7stKt9CbKM7LuS+ih8zEpK70CR3Pa7EH3YzMC4EKjnUG8Y8MENJgZHWwSAuxGOIK3SCadAAx2krvhMMDWDntk/iwE09FIENqVB/ELaH0kHTfa5H/vi+Vrbf5lr1U+30JnUg/3eLDk4wSZ9b1tFsUUF6SOYWXOHxLFPU/9OA08PRgowETLd8S62lvX8v+EEk8vVejanp8aunrqSNSJIJIcqI9lsomUxY0YwpaWYVCGPfMmiakh8jVg67WP+B0wF+eQXzMBLrFOhqEg9IfFm1CxG2NYob2a3US2aDBT3dufqjJ6fI5jyCZDrHlLZOJz6jsugSqma2+8OsNUPykQ0yygR8pRbIT+DtbMJnGR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(366016)(376014)(7416014)(921020)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGNyL3lTQ2hNVFVGMXBvWTVxMUxzVDN4K2U4ZFlKMmZia2FhZjB4eDhmeEto?=
 =?utf-8?B?VitQTWY5cXVMSUdERG1aTzNaSFFDUEtiTFBiOVpyRkMrQStaKyt3blFPOUdY?=
 =?utf-8?B?Y3hldXlPR2hoNFdIYU1qM3hRUENDbzlCZ0VvZDFQL0o0UU9IakczTzdkRmZw?=
 =?utf-8?B?aWdUVEVYcG5YNmpoVnVjUkl4QzZQTkllMjk0ZDBWZld0aXRLb0lGaEFSY2lM?=
 =?utf-8?B?RTFIU2lORUNSNkdIY3g0a3oyQWY5TDFIWUlLclUvVnI2RUJGUHg1UTdyRzZj?=
 =?utf-8?B?NFlhdnNtL0ZZQVBiZUdSY2hGUWNnSUhvYTE3YUNQNG1JaEVYZCtWc3Qzd2xn?=
 =?utf-8?B?Tjk3UUFjdmF5V1VDNU9rRmlWQnVvY0ZiczZ0cUF0dDNOWlUyZ09jekRWSWVy?=
 =?utf-8?B?MC9XWkVYZHBRSGFhSURNVGwrS3NDZW1Iam8vUkhSMjJXRVR2T1J0NjZvT29s?=
 =?utf-8?B?UHlQaWpiSExUaE51eGF5RGM1aVZ5a0t5K1BLSlAzZTZtazFJQ0RHOWE1a0lm?=
 =?utf-8?B?K3B0aVBkMVVvMDJHMXBlVEU4MTI3RW9aQVBiVThyWFAyTUh6TEwxUmJkQStZ?=
 =?utf-8?B?U0lRdGtLdGpYT0NVS0dqL1ZpNXlrZ20vVVBjR3k2b2NlTkVjb2Y5Wm1oN3NY?=
 =?utf-8?B?REtZcmUyMHd4aDZ0c2FDdXlTLzRRTW5hbXA5MFg4ZFRCanRPRHVOeW14dW1G?=
 =?utf-8?B?OEltRHkrbkdnbFBuZUlKNERmbUZHeUVSS1YveWNzbGNyRitDb3VZTnBCUVNB?=
 =?utf-8?B?SzlFQk5XZlBKOXdkQUdsMERkRU1JL3JlSkI2M0RuczV5Q2FJK3V6MWROOWFs?=
 =?utf-8?B?d2RMaitjYXgwMVZCOFRFN0U4dFplNXJLemZOQ0tEM2pGSUh6RlBCVGVZcmtM?=
 =?utf-8?B?K1VXSnRPQldUSlFoeGRuZlZMRkUvYVNGcUpFa25CTDNCeGtFKzk2WmJUdE1R?=
 =?utf-8?B?cW9ISGVRMUJhOXNRVThYR21Zd1dyNExPUlgvVXMzM1ZvS0Z2Z05DU0l3S1dB?=
 =?utf-8?B?MUdpcVc4ajhEQkJYWVRhckttbUlnSlIxWnFYREpGWWlEVzZ1STQvWllxU0Na?=
 =?utf-8?B?ZndpaCtYMW9CSUZ1a04xa3p5ZDhEZ0pPMmxlRDc2dVNBYXlleWY0ZVpXNk11?=
 =?utf-8?B?UmpkODlWcC9xTUREY3ZZb0MzVkhicXo3eUc4RXFmZXhYOEdmSXhWcmZoOVR0?=
 =?utf-8?B?Nmd2bSsxcUlzWmR3dlBQL0VxREd3ajI3anU3TXZLdlhEb2Y1Nnl0Y243MDB5?=
 =?utf-8?B?YWNnWG9vNy9zaSsvNmpkeEpqMTh3TGl3RjIxTTQwYW1ORmZVM214N3E1TEhm?=
 =?utf-8?B?UGhFVFFYZVpEWCtoSGNsR2FqSXc1SVJpMUFoUU8zaDNWclhSbVU3bWUzM1pm?=
 =?utf-8?B?cWd6R0R0UDZVRTM0MjZqQnh6cGRBb0ZIN0trMVhxNVdnZmw2NE5iWGFQcnMr?=
 =?utf-8?B?R3prSWNIajgrQTJjdmYxc21KZFhnWjRNZFl2WXI0OEFPMnFOd3Bjd2JqYTlp?=
 =?utf-8?B?ekcrYUg4MHJhMS9ZVXhpMWtlSHdNQjVwWnNUaDByRFpjdzN2UWVzLzRFeEFs?=
 =?utf-8?B?eFI4ZVZKY3psS1JSdHAvZTZqbjRqSkhpQ3ZnamMzVU04Y20vUmxLS1BhbXZj?=
 =?utf-8?B?NkxaQXdNYXVTcXhrTFdxa2Nwa3k0WnI5WHdqcHhkVjhHMGdWSDdDcEFmZGF3?=
 =?utf-8?B?bkZPaGxTelRTQXFnZFEwSm4waTZRL3RTM0R1WVkwZk1Za05LRkovL282QjF6?=
 =?utf-8?B?RkFhYXowS2JuNWY1S3pndnFRNitoaUZWelAwRnZMRms5YlVJbmhhY0dqeHJa?=
 =?utf-8?B?akRmKzRYaU1sbGdKRlJaUVVZa216WEs3Z1p6WTcxSDQzNU9MTnNmd1RQK2Fl?=
 =?utf-8?B?SlIwWmdwK0NrOE1Xb1YrWWNNczJuSi9lRTBLUmxwNCtqRzhMWW5lWExrUERT?=
 =?utf-8?B?dkFSODZrcy90VnZDaGs1aDBPeCtBUDA4OHY5M3NKRytHRHFPY0pSSlEwbXgw?=
 =?utf-8?B?UUFxTDJXZnV5WkFCbjZMVDJqcVZnd0RHWGJLdEJwdGU1Ri9OK3BQSXl0RFp0?=
 =?utf-8?B?NDJpL1VTZ2dLOHVOQyt4enRveHphVXRNZ2kyYVRTOGpjUktFVjZza2FTcGZO?=
 =?utf-8?B?bWlFQjZIalEwZ3h6UTRSdWFzL0JES0VtLy9ZREtuOTdLc0RENmJKR0NCYTlz?=
 =?utf-8?B?TVFZTENudDIxZHlWb3hEd05nSE91aUZnWVNzallxck1pdDdYOEFJR0twQ3Ns?=
 =?utf-8?B?K0ZLWDBRd2pyWUZ6bytHYVBBUnNZYm1Gc2JoYnZVL2MvYnBQeldRTTUwQTZ4?=
 =?utf-8?B?S2dpQW1JWWNQeWwwRnFucFd4NFo1c0VmR1QxRG1MdHU1QjdsUk1lZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c0e95d-8764-43e8-64f5-08dee2fee2e4
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 05:55:49.2587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uw1UxPIRigh5WKf/RGRikMdYrQHT3x/wza9hnJhUb9MVDLe9tnrHvr6QlACYM8aNaVxfUcDvBXwaRcbtnbxZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10235
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
Changes in v4:
- Add a comment to imx93_dsi_validate_mode() to tell readers that it assumes
  locking for the encoder chain is already in place.  (Luca)
- Link to v3: https://patch.msgid.link/20260515-imx93-mipi-dsi-fix-mode-validation-v3-1-91f7d22b2fe4@nxp.com

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
 drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 50 +++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
index 8f312f9edf97..64beedde7c46 100644
--- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
@@ -489,25 +489,49 @@ static int imx93_dsi_get_phy_configure_opts(struct imx93_dsi *dsi,
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
+	/*
+	 * This function is called by DRM bridge infrastructure core code
+	 * when validating a mode against all bridges in the encoder chain,
+	 * so it assumes that the locking for the encoder chain is already
+	 * in place and handled by the core code.
+	 */
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

