Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F93C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E546510F8F1;
	Fri,  4 Sep 2026 07:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SARDnHqH";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A8B10F8F1
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:54:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1r2jlQOoYArkbJTVCs/158pFgXIm3opbYabfUTxgYSREy0n5CQG7iV3V45AqU+hYX5TBzXPdGiuoWXUHNcPeNN5k7YsKF46dlPF6KwXS+ykko1XLS9YbtfdJH3fePxMWThzG8+GRfxALv0njAtBCkakmHdcApeFxv4Fip/wEqYESXlFxH1DPUerhevB8eJpOSjhc7/5cj3FymowUw4urqCA6tmiWbvoM0Q7OrQhTuIaoO+O/fj+FH9TXzxMWSY+1DZp7nVVBVJVEZ627tGaM8fdHm+Jckv/6mC9ZF/PesX92cXLGpnlH5Rp702ZB33fCKyC9rj5QJo5RiJFMeBTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGdRkZigs6z7iSHuELNwe6katSsfkpn1eWoa9LfeY9U=;
 b=NNkM8zRzBbdUKJIC5DqMv3N0IeZ0TkM6fzG8m/GBV+PzmJg/XUCEBQmgbMgnzmLLqfyeSM9wdfzRUo1DFvsX82Onfu4fYNm5YoZsWNAICnbXNiJm07e5g9oUoTuT/g76Dxa0a7ViyRDu7byFzhX63Rcqxx27OhDdgrL3Kwh+Y+TiRJ9QHpUERbzRV7N7/nxPQ6nlEbVh3cOyEf6mL8usAx/v5aS8Uw9ZVOlgDiVHjRgH4F88AXeL4oksXc6HF0zDsbJQtxAO8uT/HK2hix5hkuaslTi3KESNfeBCoSp88JFIdGKb1V3RaTxsCewyMY3G0YYgqKvVilZ/IzXm5brtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGdRkZigs6z7iSHuELNwe6katSsfkpn1eWoa9LfeY9U=;
 b=SARDnHqHWFsEQEnqFvB6i+YIcyPlJDBz0pqSLljnryZkOg3PC1DhxmIF10Y47RyAQR3UwjhuhoB/DE4hVzPuX9nLQDR1xKokKnK98/Zo77svOM2MhAtVdKYt7I6AdV8yuLg51wfwrSXbIuXdQKwP5jGLv2sFEXlFZLr1unJiFMWrc+BUn1ly8zXWV9QqV560d0wbi8t0/kHXs3p0eLuyucr4qOkfYklps+AZWgFtFm3x+mkAwsAnwFxvwqBi4crHz8WYGNDdxIvmf5uHyLreS3eHjrVMsKku9U2p8zOi2CoZJm6WhnXPs5x/g+1MWKHpEkMebv/vHxBQZm7Z+TDbIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by DB8PR04MB7115.eurprd04.prod.outlook.com (2603:10a6:10:128::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:54:04 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:54:04 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 04 Sep 2026 15:54:55 +0800
Subject: [PATCH v6 05/13] drm/imx: dc: Add PRG support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-imx8-dc-prefetch-v6-5-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
In-Reply-To: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA0PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::19) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|DB8PR04MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf96924-71f5-4ddb-a667-08df0a59b0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|921020|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: sY37nCsici4TYGMT5pzJ7hMDRqmPBR5eZmjKQZ0H7v3oW9HVKiM7KXHWGRL4l8M9JijeZuboy+kO9lE39i0MZtKsWo9KZ+kVgDGj2E2q4orRqizw/BoDCejL5ztDYqUomp6EiW15wd97BD8jWoeanrYdoyz1YLsJjn/4AeXB1/T52XVpQLMBaFGnISEcjubf7SV/8FL0hyApYX6hvFX7JQKqjT/9feJ+jXZEM+Imk/50PSOzzKkPnYDzOOV2ARSjF/1wpFrw5W9belmGLMxS3cXj/V0YsDZbf+2P3PMwHISso5skfO9e4QSjpQoifCYJMmUx8rtOoQdkTeNyIPtIaNAk9KDAFQHaXEF+hKeu25zLLDzrfz2Bbe2W64zYMvAsXYhXE2qOfXvrA9mxBrsMWh2yYelAga2ptkOy7oDcIcI0zi2WGfzAqgUvlP+yWnoGV55RbndiUzx+XduNXi4pDMXT4bsItNOi6q1UtcdFmmKn3cEgyK34sqf02/V5N6YPOfQgKsi2mL0yHpsm69NBYCoc87uHjV106KMO4ddzHbJctNa8HcMS2kFzgcusVYzSkfa5olQFVergHIWn8PT4l1l6f9Pd5kGbvk5dna7L/uibJzLMS9wJHKJcTpAULGyKay7KP60H7nchAHYkuvbkK/OXoqDFBqsgDC0VR3nmqjNRxuQ6HsXAg9nvXvY32XPF41uX5TeK6EouP/kkypvvnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clpkSzBCTjY1eno4T1JEQWYyRHpsOC95MW9LWXBrYTE1V3labmRHcThwOG92?=
 =?utf-8?B?K1pHWjJsS1NtMkp2WXFRWnhZdGFGWG82WTEySU4ydGRmT05MVzFDQ1Jmd1k0?=
 =?utf-8?B?MkVIUDJZSVhNM1JsTTRUc2tBSFowdG5kc1NzeHBiQWNPVFVkTHBQRzVla1g3?=
 =?utf-8?B?eWVROS84WXlnTi9pSDVNTnJ6QXFwUmNSNmxTMzBObkhXSjhSdVE1MkFvOVhR?=
 =?utf-8?B?OHBFbTlVWVRrb3FpSWtwUzN5Z25sSHZQckRVZ0RmTmkySFliOHdpejlwazFl?=
 =?utf-8?B?dzlIYWxQa0FHeFVVb3lQdGs1emtKenFhTExnM2RjNWRMbVBISzZxanNZNWY1?=
 =?utf-8?B?aVQrdUVjQjhMQlp1VVU3QlNFMHpCOWsySjRZckE5NFBhS2c5RDdkaHV1WlRU?=
 =?utf-8?B?a0EvK29RKzRhamg0Nk5pNmVXYm1BeHVOYnZOVmJreitMUDE3OVREekg0NGQ2?=
 =?utf-8?B?ZnlWdjZGK205WXdKU3pxbTFBVTRQaW40Umgvb3gvUmhXVjZ6U240SXVqTnQ2?=
 =?utf-8?B?alZPa1RVU1FGWlVESVhoK1BjQlZCVXRkeGV6bktMRCt6bFlkdk50Z0JXb2xV?=
 =?utf-8?B?c1hvOHlUc1F6bDQ4b1F6VGdtWG9TVHN2c042SjhkRkFOT3BOdmZweVNaNHAx?=
 =?utf-8?B?MmVjNWFzSUV4ZTdlZytsZEUwc3V4T0Q5ck5XUDJFVzJvMWhuU0YvMzBicjJF?=
 =?utf-8?B?YXVJOSttemw2enAwRkdQWVBoNE40RTFnNzQ2dUhnbFRyNFdBNmRNT0ZhRzQz?=
 =?utf-8?B?SC9zaXJheHFyd2ZtUkRjcXRZU3dUQkhMNXpDS1plZFFOcTJqem9KcEhLZThZ?=
 =?utf-8?B?UE00dTlLZitWMUJlVTVoaXNka2pUMkdLaUx1aWJOR242dmtDR09TeTNBNkRY?=
 =?utf-8?B?UXhaSHdBRjNpdFRTb2IwYjNUckRFaEV0eGsrM3NnYVhJRFFsUGxIZ1NOUkFO?=
 =?utf-8?B?TTJUZUY2alFVK251VFlBTmhEQnRNdVNDbE96MDR2elZVUDlXYW5Bd1RSbXJn?=
 =?utf-8?B?ekJJL2wwd0RuVm82bTJpMm8yVTBmUHA0bXFRTXZYSkgzNzF1V2FGaEcraWVI?=
 =?utf-8?B?QndQNnk0cllPQTZBUnp4WUlzb3JZdWdzNHk5NENSQXBORG5CYnV1MHVqcDRr?=
 =?utf-8?B?Qjl1bWdDWlRlSEd1a2VydkE2QUxTWW1FWWluWEtMTDgvZVVRRVo2QW4vUVJ6?=
 =?utf-8?B?WWdvNnpvOWFMUGtjKzhHQ2p1U3AzZjBMZWtZMHB1VEZTckU5bmZodTBsYTdn?=
 =?utf-8?B?UytucmVvYVY4ejJHMFEzZ2pqTWZCUUo0cVZsOVFmZlg1RWV2NEZybDUrMUl4?=
 =?utf-8?B?bFF6Ulc4d0ZoM3p2cWtoV2lFQ2R0NDU1UzVlMjVyaEpxUzE2VkVMMnh4bTR0?=
 =?utf-8?B?R3lHbGFPaEtzcWl2bkw5RU1iNVJlcENIM1dHeCtGbDBGWjJLZ0kreGtQZmZR?=
 =?utf-8?B?eHpRekZmRjk1Q1NaeVAzREwzQitESUhYZkpkNzRlMmY4ZHlST08xdFZBMGZG?=
 =?utf-8?B?TWtrQkhYdWtRKzcvN2hTSjhHNStsYUQ5L1FjdWdkWkVNZXJHb1M3dVVUV0wv?=
 =?utf-8?B?V0pJa2NsMURwckQ5dVdqQ0ZBVFpEMndPc054ZGozZGpBOVZScUN6UmEvdHJJ?=
 =?utf-8?B?WXR6ZFF2U3E4d2psaUV2a0g2QkxHTGt6Wm9EU05CSHVpRnM4R0VSdldCcjFx?=
 =?utf-8?B?RzNwczhTTDl3cjVaK2JVbDFsN1FuQldOaVVMK2JYblZKUnBoa1pQQ1RBb0hj?=
 =?utf-8?B?STRGZXp5WkZxOW5XdmUvUjJMOVFTbEFaRXNNUDdTNWxiTDdYL1JyRVRNcGZm?=
 =?utf-8?B?eGNQNkRKMEtIL01RM055N0xMT282L2hkQll4aDgraDBUSEFmMWEwYjlCNUs0?=
 =?utf-8?B?NjArVlk2QTRHMzRNeUtMVTlyLytGbUsrbk9KWHl4RGRxTE1lYXUyakc0Nk1Q?=
 =?utf-8?B?NXhZWG5Zb1NaMjZtMnFubFFkdWhCM00vcFdTREx6ZVI0OUlmVmFaQllOek9R?=
 =?utf-8?B?azhmQW1FeGJ2VGZVVFI0S0tCcTZweTllVFllcVdJSUxjbmtvRVUxYW1jU2hD?=
 =?utf-8?B?Z3RqRkNvZ041MW5VODRzYkVNeUtWUXFoVXhSYWNRcUx4NDVzNExCY3lDMW53?=
 =?utf-8?B?b3ovMm43cjBLRkl0TnJ6bEgwcGFqRHZaa202SUswU2g0T1BSOTY5SHFXY3R3?=
 =?utf-8?B?bk9NSDEvVEVGZUJxNFlNTHEyalRJYzI1RmY5YTlMcVBBRUpqVDA4dEYxc3NJ?=
 =?utf-8?B?STV2SXc0Njd3aFZscGhyMHVkNEhHZ01oQ1Q5QmxmUzNxY29OMDBybEpLQnht?=
 =?utf-8?B?NTFKdnBjZWduMnEzeWdmUzJwS0wxWXhpdFNCSkRnenpqYjh1WXlxZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf96924-71f5-4ddb-a667-08df0a59b0f1
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:54:04.8922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXSoPR0wXY9rfHFNTz7lc5cr8wTmGyYUH1EOUFSt7+FAKYjX1ETipeWJyVkv7+8CDEkgQB+5A/K8/3ZSEmYisQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7115
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

Display Prefetch Resolve Gasket(PRG) is a part of a FetchUnit's
prefetch engine.  It sits between a Display Prefetch Resolve
Channel(DPRC) and a FetchUnit.  Add a platform driver to support
the PRG.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v6:
- Include "dc-drv.h" to avoid build warning with C=1.
- Fix PRG BYPASS programming.

v4:
- Sort bits and bitfields in descending order for register PRG_CTRL.

v2:
- Manage clocks with bulk interfaces.  (Frank)
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/Makefile |   2 +-
 drivers/gpu/drm/imx/dc/dc-drv.c |   1 +
 drivers/gpu/drm/imx/dc/dc-drv.h |   1 +
 drivers/gpu/drm/imx/dc/dc-prg.c | 308 ++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-prg.h |  35 +++++
 5 files changed, 346 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dc/Makefile b/drivers/gpu/drm/imx/dc/Makefile
index b9d33c074984..e3a06ee3ce1a 100644
--- a/drivers/gpu/drm/imx/dc/Makefile
+++ b/drivers/gpu/drm/imx/dc/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 imx8-dc-drm-objs := dc-cf.o dc-crtc.o dc-de.o dc-drv.o dc-ed.o dc-fg.o dc-fl.o \
-		    dc-fu.o dc-fw.o dc-ic.o dc-kms.o dc-lb.o dc-pe.o \
+		    dc-fu.o dc-fw.o dc-ic.o dc-kms.o dc-lb.o dc-pe.o dc-prg.o  \
 		    dc-plane.o dc-tc.o
 
 obj-$(CONFIG_DRM_IMX8_DC) += imx8-dc-drm.o
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
index c051a17c3643..49e18ed59d8c 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -275,6 +275,7 @@ static struct platform_driver * const dc_drivers[] = {
 	&dc_ic_driver,
 	&dc_lb_driver,
 	&dc_pe_driver,
+	&dc_prg_driver,
 	&dc_tc_driver,
 	&dc_driver,
 };
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.h b/drivers/gpu/drm/imx/dc/dc-drv.h
index 68e99ba7cedb..557e7d90e4ea 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.h
+++ b/drivers/gpu/drm/imx/dc/dc-drv.h
@@ -81,6 +81,7 @@ extern struct platform_driver dc_fw_driver;
 extern struct platform_driver dc_ic_driver;
 extern struct platform_driver dc_lb_driver;
 extern struct platform_driver dc_pe_driver;
+extern struct platform_driver dc_prg_driver;
 extern struct platform_driver dc_tc_driver;
 
 static inline int dc_subdev_get_id(const struct dc_subdev_info *info,
diff --git a/drivers/gpu/drm/imx/dc/dc-prg.c b/drivers/gpu/drm/imx/dc/dc-prg.c
new file mode 100644
index 000000000000..111ff026eec8
--- /dev/null
+++ b/drivers/gpu/drm/imx/dc/dc-prg.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include "dc-drv.h"
+#include "dc-prg.h"
+
+#define SET			0x4
+#define CLR			0x8
+#define TOG			0xc
+
+#define PRG_CTRL		0x00
+#define  SHADOW_EN		BIT(31)
+#define  SOFTRST		BIT(30)
+#define  DES_DATA_TYPE_MASK	GENMASK(17, 16)
+#define  DES_DATA_TYPE_32BPP	FIELD_PREP(DES_DATA_TYPE_MASK, 0)
+#define  DES_DATA_TYPE_24BPP	FIELD_PREP(DES_DATA_TYPE_MASK, 1)
+#define  DES_DATA_TYPE_16BPP	FIELD_PREP(DES_DATA_TYPE_MASK, 2)
+#define  DES_DATA_TYPE_8BPP	FIELD_PREP(DES_DATA_TYPE_MASK, 3)
+#define  SHADOW_LOAD_MODE	BIT(5)
+#define  HANDSHAKE_MODE_4LINES	0
+#define  SC_DATA_TYPE_8BIT	0
+#define  BYPASS			BIT(0)
+
+#define PRG_STATUS		0x10
+
+#define PRG_REG_UPDATE		0x20
+#define  REG_UPDATE		BIT(0)
+
+#define PRG_STRIDE		0x30
+#define  STRIDE(n)		FIELD_PREP(GENMASK(15, 0), (n) - 1)
+
+#define PRG_HEIGHT		0x40
+#define  HEIGHT(n)		FIELD_PREP(GENMASK(15, 0), (n) - 1)
+
+#define PRG_BADDR		0x50
+#define PRG_OFFSET		0x60
+
+#define PRG_WIDTH		0x70
+#define  WIDTH(n)		FIELD_PREP(GENMASK(15, 0), (n) - 1)
+
+#define DPU_PRG_MAX_STRIDE	0x10000
+
+struct dc_prg {
+	struct device *dev;
+	struct regmap *reg;
+	struct list_head list;
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
+static DEFINE_MUTEX(dc_prg_list_mutex);
+static LIST_HEAD(dc_prg_list);
+
+static const struct regmap_config dc_prg_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+	.max_register = PRG_WIDTH + TOG,
+};
+
+static void dc_prg_reset(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL + SET, SOFTRST);
+	fsleep(10);
+	regmap_write(prg->reg, PRG_CTRL + CLR, SOFTRST);
+	fsleep(10);
+}
+
+void dc_prg_enable(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL + CLR, BYPASS);
+}
+
+void dc_prg_disable(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL, BYPASS);
+
+	pm_runtime_put(prg->dev);
+}
+
+void dc_prg_disable_at_boot(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL, BYPASS);
+
+	clk_bulk_disable_unprepare(prg->num_clks, prg->clks);
+}
+
+static unsigned int dc_prg_burst_size_fixup(dma_addr_t baddr)
+{
+	unsigned int burst_size;
+
+	burst_size = 1 << __ffs(baddr);
+	burst_size = round_up(burst_size, 8);
+	burst_size = min(burst_size, 128U);
+
+	return burst_size;
+}
+
+static unsigned int
+dc_prg_stride_fixup(unsigned int stride, unsigned int burst_size)
+{
+	return round_up(stride, burst_size);
+}
+
+void dc_prg_configure(struct dc_prg *prg,
+		      unsigned int width, unsigned int height,
+		      unsigned int stride, unsigned int bits_per_pixel,
+		      dma_addr_t baddr, bool start)
+{
+	struct device *dev = prg->dev;
+	unsigned int burst_size;
+	u32 val;
+	int ret;
+
+	if (start) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			dev_err(dev, "failed to get RPM: %d\n", ret);
+			return;
+		}
+	}
+
+	burst_size = dc_prg_burst_size_fixup(baddr);
+
+	stride = dc_prg_stride_fixup(stride, burst_size);
+
+	regmap_write(prg->reg, PRG_STRIDE, STRIDE(stride));
+	regmap_write(prg->reg, PRG_WIDTH, WIDTH(width));
+	regmap_write(prg->reg, PRG_HEIGHT, HEIGHT(height));
+	regmap_write(prg->reg, PRG_OFFSET, 0);
+	regmap_write(prg->reg, PRG_BADDR, baddr);
+
+	val = SHADOW_LOAD_MODE | SC_DATA_TYPE_8BIT | HANDSHAKE_MODE_4LINES;
+
+	switch (bits_per_pixel) {
+	case 32:
+		val |= DES_DATA_TYPE_32BPP;
+		break;
+	case 24:
+		val |= DES_DATA_TYPE_24BPP;
+		break;
+	case 16:
+		val |= DES_DATA_TYPE_16BPP;
+		break;
+	case 8:
+		val |= DES_DATA_TYPE_8BPP;
+		break;
+	}
+
+	/* no shadow for the first frame */
+	val |= start ? BYPASS : SHADOW_EN;
+
+	regmap_write(prg->reg, PRG_CTRL, val);
+}
+
+void dc_prg_reg_update(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_REG_UPDATE, REG_UPDATE);
+}
+
+void dc_prg_shadow_enable(struct dc_prg *prg)
+{
+	regmap_write(prg->reg, PRG_CTRL + SET, SHADOW_EN);
+}
+
+bool dc_prg_stride_supported(struct dc_prg *prg,
+			     unsigned int stride, dma_addr_t baddr)
+{
+	unsigned int burst_size;
+
+	burst_size = dc_prg_burst_size_fixup(baddr);
+
+	stride = dc_prg_stride_fixup(stride, burst_size);
+
+	if (stride > DPU_PRG_MAX_STRIDE)
+		return false;
+
+	return true;
+}
+
+struct dc_prg *
+dc_prg_lookup_by_phandle(struct device *dev, const char *name, int index)
+{
+	struct device_node *prg_node __free(device_node);
+	struct dc_prg *prg;
+
+	prg_node = of_parse_phandle(dev->of_node, name, index);
+	if (!prg_node)
+		return NULL;
+
+	guard(mutex)(&dc_prg_list_mutex);
+	list_for_each_entry(prg, &dc_prg_list, list) {
+		if (prg_node == prg->dev->of_node)
+			return prg;
+	}
+
+	return NULL;
+}
+
+static int dc_prg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+	struct dc_prg *prg;
+	int ret;
+
+	prg = devm_kzalloc(dev, sizeof(*prg), GFP_KERNEL);
+	if (!prg)
+		return -ENOMEM;
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	prg->reg = devm_regmap_init_mmio(dev, base, &dc_prg_regmap_config);
+	if (IS_ERR(prg->reg))
+		return PTR_ERR(prg->reg);
+
+	prg->num_clks = devm_clk_bulk_get_all(dev, &prg->clks);
+	if (prg->num_clks < 0)
+		return dev_err_probe(dev, prg->num_clks, "failed to get clocks\n");
+
+	dev_set_drvdata(dev, prg);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable PM runtime\n");
+
+	prg->dev = dev;
+
+	guard(mutex)(&dc_prg_list_mutex);
+	list_add(&prg->list, &dc_prg_list);
+
+	return 0;
+}
+
+static void dc_prg_remove(struct platform_device *pdev)
+{
+	struct dc_prg *prg = dev_get_drvdata(&pdev->dev);
+
+	guard(mutex)(&dc_prg_list_mutex);
+	list_del(&prg->list);
+}
+
+static int dc_prg_runtime_suspend(struct device *dev)
+{
+	struct dc_prg *prg = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(prg->num_clks, prg->clks);
+
+	return 0;
+}
+
+static int dc_prg_runtime_resume(struct device *dev)
+{
+	struct dc_prg *prg = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(prg->num_clks, prg->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	dc_prg_reset(prg);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dc_prg_pm_ops = {
+	RUNTIME_PM_OPS(dc_prg_runtime_suspend, dc_prg_runtime_resume, NULL)
+};
+
+static const struct of_device_id dc_prg_dt_ids[] = {
+	{ .compatible = "fsl,imx8qxp-prg", },
+	{ /* sentinel */ }
+};
+
+struct platform_driver dc_prg_driver = {
+	.probe = dc_prg_probe,
+	.remove = dc_prg_remove,
+	.driver = {
+		.name = "imx8-dc-prg",
+		.suppress_bind_attrs = true,
+		.of_match_table = dc_prg_dt_ids,
+		.pm = pm_ptr(&dc_prg_pm_ops),
+	},
+};
diff --git a/drivers/gpu/drm/imx/dc/dc-prg.h b/drivers/gpu/drm/imx/dc/dc-prg.h
new file mode 100644
index 000000000000..6fd9b050bfa1
--- /dev/null
+++ b/drivers/gpu/drm/imx/dc/dc-prg.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __DC_PRG_H__
+#define __DC_PRG_H__
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+struct dc_prg;
+
+void dc_prg_enable(struct dc_prg *prg);
+
+void dc_prg_disable(struct dc_prg *prg);
+
+void dc_prg_disable_at_boot(struct dc_prg *prg);
+
+void dc_prg_configure(struct dc_prg *prg,
+		      unsigned int width, unsigned int height,
+		      unsigned int stride, unsigned int bits_per_pixel,
+		      dma_addr_t baddr, bool start);
+
+void dc_prg_reg_update(struct dc_prg *prg);
+
+void dc_prg_shadow_enable(struct dc_prg *prg);
+
+bool dc_prg_stride_supported(struct dc_prg *prg,
+			     unsigned int stride, dma_addr_t baddr);
+
+struct dc_prg *
+dc_prg_lookup_by_phandle(struct device *dev, const char *name, int index);
+
+#endif

-- 
2.43.0

