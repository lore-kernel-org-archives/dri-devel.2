Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA36C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E21810EDA9;
	Thu, 30 Jul 2026 04:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VubZqLHf";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A81010EDA5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:46:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgvXMTgHg0oXsZvkIOXu7eA5VTdYeFIzFGGn5uqhgpaUbOlnBSpF8njRHPgxO/4MLCR+V7rHEbMJAvQCvdJ4shgTCPZukRJxX4Yh816tcOjLw+hyd0gwqQsnRugL1a8NsDP3xMYqWBid/f32KYdYVeKJsg3NBrzxuL8LkF2ivU6F+a092MFbZMYXVxFXXdpUV1Tk5lwy8Fj4atMn//oZaJN/W1MbQPk26gUMbF3g/0lzXKKGfCYVYWzGa7QxJ4XyE9GeDcNu+xSpCkN6R9sGst+8tHbFuXSkBxebSdfQMriu2clUaj1Ausnzz7iF53BopHELgeiN2pioEnWbi1r4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwg6Qp4BuB6JWzcWbnEPV1hmy7aDwGR6GUdCLr3F9G4=;
 b=YBk8wX+h+ma7iR49F7pFOat2JdZZkpW4pKD1bCQswNu2i12jlN1ratn5M4cXSUtyfDsoE2vEmKplP0WBKM2WmJak9Xudxa5LUnMJOJnNCqLfwRs1RbpkdC5eGyptlj+HC67NLDa6OWBuW8C9Z9CDU8tjDL0gIS04QOYDxmLC32wM/tD1Dq5ACLJxzPHe/SdI4nyiMSLse5au7onjirNrCB5xiIliuFo2Z/NJn3SvRG2DiGuccFmK/HAKOLPPsbg/ZIOnubw+R2R65K0u/VdCQW7Skmqj0x1MMbHXczLNPaZqZxPWUbeP75bsIPuWAIu47dg5sC1BavWFHixn69QuOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwg6Qp4BuB6JWzcWbnEPV1hmy7aDwGR6GUdCLr3F9G4=;
 b=VubZqLHfxh+xvwjQjX61BLnWXq5SHuZimUiElpMwq26UpfBIM8VBVHxkIvz22o2VWKEkv92EpBigEaeYLTxDzBqMueVrlr4ONjHqRhrQzQeP167wnmamH+dl6gdAqeujjj9Rl1u2khiBl0wFKGiZHV6rUD2N8AE2Vn7zcm0sDhAcYNdYiu1t3677TwpS+hZo9GK0mNyoNl7xkUKG2TL5hGAdrRdJguO0Y+19/XRLDFIMBOmXLY9jeKjJ9w7HaHPxDuHFTjgmpoHAGxdNcLJTbxY675mebvV5yZ+syFK5x4OPtJcWXY+ZFYbcernd/B0xFXrHMApwAkxlVnhU+n1Qpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 04:46:13 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 04:46:12 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 30 Jul 2026 13:44:44 +0900
Subject: [PATCH 4/6] drm/tegra: Remove unused includes from submit.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-host1x-syncobj-wait-v1-4-afa730410392@nvidia.com>
References: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
In-Reply-To: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
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
 <linaro-mm-sig@lists.linaro.org>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a7d321-5970-4535-8283-08deedf57b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: wxeD55SdApSCt7M86RlfpAMFHvbHjHmckNcXAhyPtMoG9NPspSSD3j78DE6frHvYKqOAl65bhBDOy/o+WEjOEdBmyc/cpksCokSODM+EUOq0VX5b4hucoS6xyP3EfzajV+/VbHuFNI4lGg+rRYoerw9ZGINu70gubm9Ot6Op4Ze1mrki3BdRi9GsoMlT02cFIYTZHB+agqc6K6JcvgcKPdPreyX59oJydhMtKK0NB32nKKkEo+P1RNBhLDLQPxsaxVtg6XenUvOU0wLinRUS7d7C82eVhLIo5zOPn3u71Ftj4PIlJFfdldGQKChScyDAOnFBe2PszUtOUs6OTWTtul6pdEnVmxlwmDfid22TSHumZnHJkv75XK+roDnfk3XG4wsWipLRN8al/29/AEN0kEnlxgbezgaV4yRhwuweDwXOOaUl3tHzOzFlgzjRlKpsBvaU4SWkmvv0INqDFhqSXPM+EGEu+Hhg/mYlM0sXUJXX1SqkQqyGzvYDK/z7dTuS5kFq66GPjKHV+CyJxulhHjDVGY3MQ57NtjUiDR6sROrnDu1ZuYSjc2y9kWBeqqaWgCLdbNFJvpLjk/zEF6bV2Zpjp/OYbBmJajTJJ9PvoL6JniyWdy+/053FDlwoofQLYPh6Y/Fy1HxepMMEkhQJi2wE8cYlf7M0kMvVS9md/b0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU1DcURRaFFOdDJ5ZWVyNjA2bEx0NDd5UE43TjU1bXRiZDltdDJsWEVYc0Iz?=
 =?utf-8?B?SDlTakFLRHZwRnp3blhUbmh1dGlmNzAzb2F2azJmbThTRzhRZDRHNXdJZjk4?=
 =?utf-8?B?NTRvem45dElHVXU4NCtHT3dMcmE0cUhKbEVWTHdYTkZjVFVmZXdDQUptUHZj?=
 =?utf-8?B?VUNsOWhHM1BibVdSNmx3Q1ZmTmtmMWdYWTVwa3NjY29JKzVJSjFnWHZNMHJk?=
 =?utf-8?B?Y25zUGF5OVQyOUlJYTVFUmhOaVJVc0hhQnlLOHhENU13Z2hyajhWNXh5Wits?=
 =?utf-8?B?V0d5am43Zk04d21vVktDQ3A3Vk5lSVUxbWF6czdlN1BKeEVpd3RPUGUyblJK?=
 =?utf-8?B?WkYzcmVqcGVOQWxhQWh2N1hwSzgxYnJVS2tzNTZucXg1dE00ZU55UmVLZVc2?=
 =?utf-8?B?NHhQV3ptWDNLQnNTV3pKb09NSFRXQk1Ia01WeUVKYnA4VnBJTmk5dWcvc0Fq?=
 =?utf-8?B?c2N5enE2UHk1Rkg3K3pZSmxBOEI2M3MxTk1TbXlMQmFONEI4REtFM0g3TEJR?=
 =?utf-8?B?Vmp6eEJIbmJ3bStzbGtXazMyMDI1cXBiUmthYTQwUldRU3phZEpBZmkreGlR?=
 =?utf-8?B?Uys2QjM5QUFPaXZHSk9qcnFaRzdKV1A0TUNYYkRCMzY0bWhKbGRyTWt0anlD?=
 =?utf-8?B?MDJjbmJZREVEZHBTNlU0VkZyOHJpUTRzSWp5dnVISFdCWUtTOENGazRmS1Bw?=
 =?utf-8?B?dEVJYWIrVDdDQVBVaVpjUk53a3V1WHlwUGVrUndkU0k3bWhaWTdaMFdOYVNX?=
 =?utf-8?B?cXVyWjlPcW1PUFVaVGtVV1VFZy9tcXNHTkNjcGVmck90Q250R0FZUjV1YzNq?=
 =?utf-8?B?c2R2V2xqN1dscitRRzJsZDdCQzVGc2JaeXBnVXVmVndDRkNRSFZjNUcrdC9l?=
 =?utf-8?B?T3kzWnlQZ3hUc3N3NGVYM0ViVnJveGtzeE9iSzRWWHRpcWp2THl4QUFlUHBH?=
 =?utf-8?B?dEhXUVpvQXRpa1VKbW5pa1VIbGNZMXF5QnVVT01WWmVHdk9KWEovNG9LWnpF?=
 =?utf-8?B?T1BRaXdNdWJkSVBxbkRTblJ4MmhxYkFMSFhVWkw1Rk9wV1hTZFNwOHVKN3JH?=
 =?utf-8?B?WTlRQ3VLeTNPbzB0YU1LOXY0ZUxTVlR1WE5VdzM1cEFtTWVmRnQwNE1JcU1t?=
 =?utf-8?B?ZDhESWRtcDN1VE5QUnJTN2hmSXR4RnpZRmZRSHFBeHByTHo1VVdxWDRhc2xW?=
 =?utf-8?B?N1lPY3pObXBsY1V3VThoWjAyR0pNZ1dDVmZ1UDJzdG5rbnM1blRrMXR0bXRh?=
 =?utf-8?B?Z0Y5VnFtRWU0VWJrZkNralgrbUxXYUlad0ZtZUYxS1FVRFJ1SkMvRVFiVE5m?=
 =?utf-8?B?cE5SVkd2aUFRMjlmR25lazQvZEF3YjRvV2FleWwxblh1cURJR1BMYldOc1Jq?=
 =?utf-8?B?SkNlcTNBV3RvMFl5c1R5bTN2WWlmbzBkMWJ6cm12UW5aTnIrQzBrTVV4MC82?=
 =?utf-8?B?NmJMQXRMa0tMZVhEcDhSNUlkVkFSYUNTSEM4eWEwVmZ2VU1uNzI0UmdLY0xh?=
 =?utf-8?B?Z1A0dnV3WFUzYUdOVGp3TE5sRzRFbW53KzBReGRDUEJ1Ujd2aGF4N3hRM3pJ?=
 =?utf-8?B?aHU4bW4rb2IxZG0rQWFvME93SUxQVnVHTUlSZE93V2RSL0g4OWNTT1VEMDUx?=
 =?utf-8?B?NVM3dDNXNFRiM1NiNXV4Q3BNR0N0VHVuZ2xYc1pkalpJMEpxOEdZNkdBT2F5?=
 =?utf-8?B?b1JuaktXTDlIeVZwK0tycndIenFqeGpOTzJTUFBaYUwyNGtxTVpuNk92QW0v?=
 =?utf-8?B?RDlKUm96V2lGYXd5YmZMc1dnUjhpNXcrZjVBOEZIaytibHpMa29ESTgyb0s2?=
 =?utf-8?B?ejBoRkhBOEtHMUV1RHNFUzBwWW1SNkUydkQyanIvc3dnUC9ESkhuei96bmpW?=
 =?utf-8?B?SHFZY0o1SkJjbHlGNE1ndTVxUGpRck4zWDl2R0FRam5VaUJZaEZRR2JKSGZ2?=
 =?utf-8?B?QnpRZGJQbytjR2JuUlB3WkhOMW1MZkVHVTV3UVlJNm9UeVdSVWJkUEpJMUc4?=
 =?utf-8?B?bU5pbzNqekdQQVc5R3E0ay84UWYvZEJJa2UwM0VBY1R6c0EwQ1JNdWI2MVhW?=
 =?utf-8?B?NGorV2xlSzJKd0I1bnQxblo4cm5jMFo4R21kT21PV0E0b0NkNDA5cEhUOWQv?=
 =?utf-8?B?QTVNc3BsaU1lM2lIdHh3aHdIc05qKzBzZkQ0Q0ZYeFpPY01VaGt2VTlIbVpl?=
 =?utf-8?B?WGtpRE5Ha3VReDlHK2JaTnpSREJPeDJGcGtEOU4rdDV3MnZWMTIza0daelNG?=
 =?utf-8?B?b0tLZlpQYTlzb3hldHVCVWl2VER2SmpFMWZRZlNWNFI3T3NUZ2FwckVkSG9m?=
 =?utf-8?B?cXhOcGFGRnZaUFRsazRURFpTaWhGditlR2V2SDl0eXlQUnhNMjJFM2VrNkI5?=
 =?utf-8?Q?AmSNt2lUfmQLnk6/5XLzYK7kuT3JVjUxL2pEPfBOkMMj0?=
X-MS-Exchange-AntiSpam-MessageData-1: xsWBzpIoPIc6Zg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a7d321-5970-4535-8283-08deedf57b79
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:46:12.9093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zihPKvUhNPhNHr6zs5Zk+x2emcgHBtA54SH0QvMZKvZ6dpSi/V65dd7NUeYN1x2AhodzbxEvDdKmNTLLKqIVZg==
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

The dma-fence-array.h and sync_file.h headers are not used. Drop the
includes.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/submit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index 658396f2e954..1e5332eb6e26 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 NVIDIA Corporation */
 
-#include <linux/dma-fence-array.h>
 #include <linux/dma-mapping.h>
 #include <linux/file.h>
 #include <linux/host1x.h>
@@ -12,7 +11,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
-#include <linux/sync_file.h>
 
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>

-- 
2.53.0

