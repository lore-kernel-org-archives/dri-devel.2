Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B270C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6299110E0F0;
	Thu, 30 Jul 2026 04:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="L1XJt9Oc";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F2C910E0F0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaB40Pl/G5dqq0R2E/qDMCK4vim+F6SbAxfkcEVKpdDCQ4c71vEGpPFSLdCQRUm980xPQd/1AhU4t/tijQM1I9p8Eyeb2EuIGU7lXMWiJGfsTSQE+A+uuczvJXbNb8vw64iQiwGOBKikgPsc39SC/bdqnwZ/NCtJGsNo8lF+GUV2FOcr6gb+TDemeD6EO1q64ZWx4fhLbhsXAzz1bepXx/G8zPqnqhtvWdisUsyP88SjHropuDMo4O79cbSCFFunhaA8TX4WIjtyOkPC9FCpn6xijs+7EVIyK9q6Fkh0aV8RHvXxjoSWzgyrrdKymT5WsWTOL1lLJzVwzPL6jFozMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5OBW6scSfi7FRg9ZgCb7YaHK5v5VKF9KcaKK0HMjZs=;
 b=ZNhuA6Y4mYiedpNPDCxMNQ/cMVKMbU3sXF8tMS6xfgBhMU9Hg45eAYe4vxIXagvcSU0mnr5S3T0EkNDiOanOWQXuvmKaa8o5XrPLcWzRqgdzPmXkGJvYuWjXjownuTzBG0p9TGmIrDgn8pQWhSbvl4P//Z+fvtRsVt9PhfF5mMWs5R+0knj1GoP12mesTz5BVNP4yTCaAobl44wFvwR58F1oDBi1H+eDGFNegq/wVNi+LNhXuH/Uf3OHm96jaoz/y012sWaUgmLBKqViDEenB3EOjzK3v9RJOEMDYga/oeLuTMxGNudYQO7GZ6cpiyWIJnkTga8Zgf/6cQhsbckNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5OBW6scSfi7FRg9ZgCb7YaHK5v5VKF9KcaKK0HMjZs=;
 b=L1XJt9Oc9/f6lfmt9B6LGdzYmDhI3vzNwhfoa6k4NbbkY5xjvDHFDrF6mMpArqlbw1AWklpDpPaHoTRVD7g1v/Yk4lQiBfK+oW5Dd6daRf6+W7ggG3aFQnptXsDmQ4gPQ+IL5r0AHZwsm79f9c/2qWqpcHUzgcwYIErC/VHzYpXVA5uN97OExdA/nIbWjww8sQXB3GPgR5+Dr8sUMdTdx7IjlwyPJIJOI8HxII8nyNZUX7qUKd0xxxy3t+Lo4gBpSAR8VslZA9ScNjuDwlR8TplsSx4xkMz0bmPrJZSqsSFw9nLk7sO8YC+uQGEmBRKdflGBn5R+TAY+8phqKyTC/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 04:45:59 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 04:45:59 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 0/6] Fixes and improvements to syncobj handling in TegraDRM
 submit path
Date: Thu, 30 Jul 2026 13:44:40 +0900
Message-Id: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ7CMAxA0atUnrHUmohGXAUxJMZQd0hQHKCo6
 t0JML7h/xVMiorBsVuhyFNNc2oYdh3wFNJNUC/NQD0d+pFGjA6nbHVY0N6Jc5zxFbSid+RdYPJ
 7z9Die5GrLr/x6fy3PeIsXL832LYPnfNusXoAAAA=
X-Change-ID: 20260727-b4-host1x-syncobj-wait-84284ac2838c
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb"
 <linux-media@vger.kernel.org>, 
 "moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb"
 <linaro-mm-sig@lists.linaro.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Dan Carpenter <error27@gmail.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: a0afc71e-b7fa-43c6-5232-08deedf57375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|18002099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 4Jz6e12ey0QNNEVLhN8eTqQyfW0ofYtmFiL2sz6cfFDFBT09qIFoT7gxjd01teRPwEjHabiUwM0pnTn6U3asAyg3sSUOMnAqVX7DfoZYoq3+YkpRxS2OJHFQFmPfS7Xw1gP2VJaWOWkDNU0QMi+KKtfGP5nu6REPTjVSDtEu9K0p3SbU/bVuCnnYaz41Cie9p8E9CwdzHBLmVV/qXT5jgntkTxJanH8qbDkm1uvRWJzkWUa+1yH1/VbTvikDZCq0rcaffS+JmYLF/SEb+Nijd4oiw31Z4I3kvBKdgsRsOnh0yS6FAtj4LHOxMgJ+YRleeDoAfa7hoIb8XLO2HvhnYLeAYrZDFOkAYgO/xwzxGTYJLAciGt5LI5+tVv7M+4+sfujLjubV/FIzUuAFwPcAhy4W0cXJXCCbZPf73rrhjges567RP3rUTaJ07qu2IJMkRNoLfqKpPavUsZo39TbksGXynQMYmPFazIL3AYVYtjaDEmIGC1EbYQgc4sfBJljzhaI3ofmz3Mc6zmMEftrfeR71Bb07Y5CUUWGDQor9jOW/jYdumf/vx/+g5dtYj7BhgeRvDrTQ1dNgizkqXO5qTMNTi27G0PHkxSENuGuMQZtB2hX/ZlslOwKILLPv1/TzWk0dCEcka3d/+XY30sq8RRmJKK7fPmWVk4SRSin5bzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(18002099003)(3023799007)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTJabW1nN2JwdFlObldHU3Rob2d5Tk04N25GTlV5Y2xsSHc1UmpjTjFhS0F5?=
 =?utf-8?B?Rm9wUVNMV3ZSakxHQk5wblBjYXJpTFV4UnRxRVR1d2VkWEVmTURXNlNDNnU1?=
 =?utf-8?B?ZWJDR21LS1ZyUy9tZldHdWl3aTUzbCswaDZEZDVVRmZPRmhxTXN5Y1RBVWJv?=
 =?utf-8?B?eFFscWU3YVR3RGFOT1VTMkxGcTkvSHdoUENwLzh0ZUh3c0RXYmppcVNDamxQ?=
 =?utf-8?B?WDR3M3l5QzdxM21CZUNuREFzYWhRMUtFbTJVUnArRmp4ek1YMzl2TnkxdkJM?=
 =?utf-8?B?czdlTFJCcUtXeUxlTm4xVHdDNGliNi9nZWJrWEt2Slk4Nlp1N1ByT3ZURXlE?=
 =?utf-8?B?ajhMaEo1NnNacmJDN05lR2o0TmNYbjBwckM5eWd3bHpsdlRpc0pWcEFTUzk5?=
 =?utf-8?B?SVlMTTBhalltckF1dXNqcTRxeTlVbjdUbjN6YkxWb1RKa0x5VHhGQjJ3S21u?=
 =?utf-8?B?NHZ3TEt6VkxtNkZJVWRJaFJFT2RBS0FCUVR6OGowK1M4c3JjdWVWenhGcDFj?=
 =?utf-8?B?QmpzQlJyeFdiSWZSM0Z4bWhRdWlPRXNoZHlNaEFkVVNqbnNYUmNYOXgvRUtq?=
 =?utf-8?B?ZmlzWWJybWxrRjhMcFd3WThwdElJYWpJWnMyRWZrTjFOY0w4VGlaa1pUcXdn?=
 =?utf-8?B?djZZOUxDTUZiOGtqRC9ER1U4SGp4VGdsNDNIUU1zcGNqcFdoT2FESWxEZDht?=
 =?utf-8?B?aWY0RTNUNTFQS2xuSGJYdHZIRW9kT2VscGNsVW0yOTQ2Y2swRnBiMThZRFIx?=
 =?utf-8?B?UFd4dG9vL1lXR1ByUytoTW1FUTd4YnBhY3RHUzVnOFlPOGt2Vy9OTEVldnFT?=
 =?utf-8?B?MXBoTit2NDIzaEpwTWRhNFcxeHU0cjllbWZieXJEM01YVEJrcUlyQ2hEMlRD?=
 =?utf-8?B?ZEJBQzQweW0vK2wvYTBnN1RNYXVPeTVDcTdOZDcyTlpRRzhiczlaeWZMZ3R1?=
 =?utf-8?B?VllXRTAxcUx4dlZ4aDZ4dUJBWnBrdk5Ta0c1cEFqSEZoZStEQXR6Z00xZjFM?=
 =?utf-8?B?ZVc4cE5mRHpvYUZpb2cvbzM5cksyYTlLVWpQVVQ0bXBXdVJZVjZRQkh4L2tI?=
 =?utf-8?B?aVc5V1MwNXBWNFNTRXZGQ1JuSWNVTS9ZOWpZUEE5QjFOYmxSWTRIS0xuRTZK?=
 =?utf-8?B?VUUrVy9HSEdCTkZyMUVKUWRiQllJOCt1SWtJb2xlZS9aNTdoUzFOOXprRnVE?=
 =?utf-8?B?UlFpTzJ6T2lBSXBIT1AwYUNHNmhLKzl6SUZMODdORm1BNFVaNnQrS09JajdC?=
 =?utf-8?B?STc3S2E4VGJBSlNKd1o3T1NFV2tORFl4cFkwKzBVVXRkTnBZR2RkSXhFcHBW?=
 =?utf-8?B?TkxWUEpWNTFaNTdCUmJqdzFDTzRFdDIwTjdGUUNLZCtiZ1pGZVc4VUNZeDMz?=
 =?utf-8?B?R0xBU3MxdWdCZW45a3Z0a3VaazhDNms0UWVnOXB5eGxRNDc3dnF0ODVmWGtj?=
 =?utf-8?B?a0RXRktPT2V6NFpIeEh4U2dIR3U2NlpIK2VqNDVtR1U0TE5kalQzOGkreDFw?=
 =?utf-8?B?ZWF1NzJWS1JLbEJRdE9NclUyOWF2dVh1Nmw4OEhLZXpucGFqSENUSE5sanpW?=
 =?utf-8?B?UUdESHozcXljQ2UwZDhCWHh4UHhLcldCalJQQ3gydFgweTRHUXE5Q1NTTWxR?=
 =?utf-8?B?cFJsRDdGcHNuclJycStnRDlHS2gwVFdHdWtRU1ZnQVhlRU1YQTB6cjlhMUNH?=
 =?utf-8?B?bzNhaGdSakl6a3dFVUpINm90eDBEblN0alVXQzdOL29BaWtVWEF0c0o3L29O?=
 =?utf-8?B?dDh3K2ZYTXRoUllrclJmSFA2TDRhZkhWTnZ6Y2pXVzZDQkhWaEdXSWM5Yk1j?=
 =?utf-8?B?OXhaaFgyckhzMkRmWjFNNXVJZ1QwN0hPenFhcHZwZVU3MWhISUFTTzVWd0Z1?=
 =?utf-8?B?SWNpSHNxOVhtSlBRS1lLaFB4Njd2cXBYQjJ3MlFBbG9aWUhWbzU4ajl5MjRS?=
 =?utf-8?B?MThLQjZlbkRtZEdncTZLd21wb2VWUUMyWDh2MUt6Zmc1NnlHUlBpbFJKLzBX?=
 =?utf-8?B?alpMUjgyRUxraEpOYVI3S1I1WTJtUi8rcjc0ZWRZc3ErN0JranNhYkRXQ29Q?=
 =?utf-8?B?a2phTzBLcUhEWUdWcmRwSzFKZVA4WFBiOGoxRlhkblZMZkh0b0E0WU9pdzFw?=
 =?utf-8?B?WFNTQitHOUk1Y2ZZUnNBNUhsSmdhNnk4NnRuS0dVRlNTalp0aDgvc1oxSGhD?=
 =?utf-8?B?S0ZkQ1pBSHZoMlJLRW5yYngwa3ZpMUNUeUVNWE5NbDF6aHREOU9XQVlpOEZ6?=
 =?utf-8?B?SzNmS0VORXJqRXkydERjYVV0YUJnQW9IS1UyK0E0blNMY2VkS2hYU3oxVk54?=
 =?utf-8?B?cWxpckp0bGVsY0lrL3JwUElEU3B5d3pTK3JERUVVR2tEOXJCT2h0dmlUV081?=
 =?utf-8?Q?29gKRgyvMIqNbfLgpaW7MTNWQ7CbiN2pfXFYRFKtmbTYf?=
X-MS-Exchange-AntiSpam-MessageData-1: znrSv2n/fOk5zQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0afc71e-b7fa-43c6-5232-08deedf57375
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:45:59.5300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwEtn5XMa9Pry7XlwhClX3IzbQ1p/cdbYeS7qc/yUOu5iTx+cXfq8jw020m5MzxMRQ2HyU6JSpNDOc++2TicXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

The syncobj code in the TegraDRM submit path has been quite broken for a 
while. Let's get it in (better) shape for unstaging.

The first part of the series, patches 1-4 are fixes and and a cosmetic 
improvement. They fix the syncobj handling, though it remains unoptimal 
- CPU waited.

Patch 5 adds host1x_fence_extract, necessary to allow other drivers to 
see inside syncpoint fences and program hardware to do direct waits.

Patch 6 adds support to the TegraDRM submit path for waiting such fences 
directly using Host1x channel commands.

Tested on Tegra234.

Best regards
Mikko

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
Mikko Perttunen (6):
      drm/tegra: Fix syncobj_in wait return value check
      drm/tegra: Don't pass an ERR_PTR to drm_syncobj_replace_fence()
      drm/tegra: Drop reference on postfence
      drm/tegra: Remove unused includes from submit.c
      gpu: host1x: Add host1x_fence_extract()
      drm/tegra: Wait for syncpoint syncobj_in fences in hardware

 drivers/gpu/drm/tegra/submit.c | 109 +++++++++++++++++++++++++++++++++++------
 drivers/gpu/host1x/fence.c     |  43 ++++++++++++++++
 include/linux/host1x.h         |   2 +
 include/uapi/drm/tegra_drm.h   |   4 +-
 4 files changed, 140 insertions(+), 18 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260727-b4-host1x-syncobj-wait-84284ac2838c

