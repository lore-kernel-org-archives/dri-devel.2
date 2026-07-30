Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1A6C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFA110EDA5;
	Thu, 30 Jul 2026 04:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PZkPqPr6";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012059.outbound.protection.outlook.com
 [40.93.195.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD3310EDA5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQwzpDeI7eY5B02sVvQiUgK7/xdmUt4R0ojZ2uCOLvGa3B2H7i72yFuGPXH88q69XbIzqs71ZxhlzVHrCCLV5o1vdvXUosPI1+SMMijGfbYZ3c6Aaml2sW2aPxjY4+yXc+d3PTjQOS9S1mBn9KyM5HSjgM6PpIpdDNoalotGVVXJhUrH9CYNcU67YShWMUvbOjlxb4fOa5xY75tr3PbxJHI7VHthtt1pc+akHkQ/WTdV231UPZ5jnHSl9EzlCye7qOqlEX1kpAcGRhua8aZtwnWE/5nGqKtM/8koRbo567PExISAEa4NaEei7BHfyLR2bAsiWpFG7nC2+g4KhsaWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slOOfmYyq+14GAjkjONNmmCVCBqyBDuKc7+VOdIpXXw=;
 b=j+ZWRdNvW0TMxUQMqgFysg7d8X5PQM6HmlyM7C4nQ/cm1gWZW21TYNF/OPdmhplupOk8UHH6KhIL4gUmhoO7DgFSUzZNcfzpaADvrntAAJ0aBoeiYngUJb1bfwezvxnJ5n25HejHfGy3IieMMtR7ax1GFY2wEazrWGvJmdWSdrb4nDWGEiEf9c+FCa96i6M+8vT7BoUcgx9/mfc0TEdT1MMZI5holBX1/cgfDK8aLH8yS4G6U6OUr8fnUaKbo3HPaTUck2YGSZX+vWtuzRJ+1Y2l4sj8q3UNufrBX7CY9y7j4SMcavnjHwq2MC91M6oF191ZN6tmEbxzRJ8SpE4ijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slOOfmYyq+14GAjkjONNmmCVCBqyBDuKc7+VOdIpXXw=;
 b=PZkPqPr6LlPEQ2b2hdsxjdQr15bs1VKjgu3Hzx6Xuh6XysaarVKoAcCaV7HJtkDX3Abl7gFoEn5ZsVDUq7jm2orehV1JB6rSHy56ar1QqWBy0FSvvq7kinKaYJ+E+RcwZ7wePFyAdS1FnW9TmO5mqvuE/D0kqH6jXQNZFcBSvpihYVSUM3nT235cNXPdhRfpgXa+fX2MGltOIdkcluh3AI2e7AW1cQp8OeyAsj4vGxBUtzMwwv6oXod3OfEQ46PKNCNcm0BO1bi7oFbRyKFgUOIPNjLogphxOz8U5RnzUSzy4/0Now3GmrzjrzGRKqLmFs/TBWrejIJBnzpVegZvJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 04:46:20 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 04:46:19 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 30 Jul 2026 13:44:46 +0900
Subject: [PATCH 6/6] drm/tegra: Wait for syncpoint syncobj_in fences in
 hardware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-host1x-syncobj-wait-v1-6-afa730410392@nvidia.com>
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
X-ClientProxiedBy: TY6P301CA0009.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2a3e5c-0fe1-41e2-eed4-08deedf57f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|22082099003|18002099003|6133799003|5023799004|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: WP/dmgjilj7k+gx4v8xu8C6O3Y49Zen71poCHDhfpyZjsqVW5k9kAWbsEtJE1KdrDQHyIUXoIpXMv/wJwDnijYpVi6HUXJYHitnOgUckfwmfCy2AaPz92ssyCI7b7nE/7y78Qet+/cAL97iq33iy8TGHbVKro31z3mevgIxQOkSetHAjUdvRDXWYdgP4H2V9xH2SlM89i2Vu1W6uwbgsJr4YzsLdxstfOVcnk0roVwnCqK49d1Bp2Rsv04vkmaujmdoN9gfo23hxpz4EWpmX8e9HXfTIv8EMtubGKLM2gu8JTH58wGDz4x4HmlQDATDn2fXD41ub3sYWmIm3C9IdWrqNAkcDLdnueHTgQAYlhPedkAjOcaevG5c2WQVDJTBZYokkviF+U3rs7PB/WGF7OrVs+CvNcloNZP71sPF9/kDTlt0ic89FGSFNFyjC7CcmxyFUWhbbRorRbs1wybCewwyTE3MoP6EFYtuifsv224lVtLYbbzclz7fxdnzXngqEDhoeVdXKM2oGYllSrAu9fcDgNnPzIhYKpRat8PsvobSmSFAaS8vswqM5s4wrvejYwZVZMuGapyL//kX1CQvCe+4KX939nhdoHWdO+3142C3E9S2FJJNanIWTdv8HUuFn4IiiMVHLWeoGtnZypA7IyTu46eX88cFmmfVyMbCFJY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(5023799004)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0FSVTNjK3BkK3hISnlxZFJTbWdpUGl2Y042cjJHdWxiMzVRUFU3VFg2aXcx?=
 =?utf-8?B?RzZ0VnBKemduNmRYSHJXRmF1L3BSZjdVMDNTTXBCWGV0N1FOOFdhamhzak50?=
 =?utf-8?B?VzJwRm5OQzdrZlNUbGcxUHR4d1Q1RWVKb2tqZWdnbmlxb3J1VjkzVzN5N2pU?=
 =?utf-8?B?V0tsdzk0b1k0bG5xVVFFc0ZoTkNWcDdwQURxV1BTWU1zeWRXL0RnSFlDc1J0?=
 =?utf-8?B?ZVByYnVJcjRqWFV6dDZ5TG5xN0pxYzRaNEhuUnlrS1hnUGlQTU9Uc2lYRHgx?=
 =?utf-8?B?WkJKTnp1b0xGSEo4S3NwTC9lUkxmNys2anFzSHBVNWdsL2d2M3ljdlFkd2Nw?=
 =?utf-8?B?aXc5cXJ4bHBXWk9ueENWSnNVYWlSQnZzVFlqMU5reCtLRkxlSlJQRDU3RVBL?=
 =?utf-8?B?aFIrMVJqYVJtdFc3Zzkzc1gvblA3WVRVUTBhQU5USG56VTFhSHhBTXV2MFgv?=
 =?utf-8?B?RG9DWUMvY0l0eWVIMHZvQlJ1VlVFT2JqdGhMc1pTZlJyNHU2c21DUG80d2x4?=
 =?utf-8?B?THQvKzFWOHhVUks0V1p0RjM2SWtyNzFOaFkyWGJnbDQ5OHdOb2wwakdhNTVs?=
 =?utf-8?B?Tnc3MzhaQ0V1WlRJeWFkMENGQTdxVXExNXlLUmhhMXp2MHVwVDU0Z3M2eEEw?=
 =?utf-8?B?QXQ4aTdzQ1RndC9nOFZMLzllRHJnN2Jrdk04R09peFBmZHVLcDFOcXUzZCs1?=
 =?utf-8?B?Qng3QStVKzAzOHphVUlDWHJzbVpjVFRzMUZrenFyL1UvTUN0V2JPVTNYWkpK?=
 =?utf-8?B?TG9OclpIc3oycGgybjZzS3A0ZEpWcjI3N1AzM1Nld1hxUmtaUm9uKzRRdTVp?=
 =?utf-8?B?bU5jK0kwREpmNkNjQWJGMTBvMTN5VUl3UDJjTzEzNCtuTk9nQnI1SXQ1YnUv?=
 =?utf-8?B?aGNvZWJOcmtjdVY1aU5zZmJCUElVZ3ZKUjUreUMrMy9vR3JYdEl3U00xVzlC?=
 =?utf-8?B?b3BsemlyTWl0c0xGMzVuRkc3Z2pBSjFPMW50TkxqQURlRjdZU3R3NlBUa3BE?=
 =?utf-8?B?dGxSUktOL2M4bFBkUlBaeTB3citqd1Y1bkdmYVFIQWZiUVJHalZNNUhXTHJv?=
 =?utf-8?B?aE9ER1pPcmRRcFY2MlhYS3Y2bnMxOEpSWWlzL0UxaWdXUi9lMVpJU0xNUEJR?=
 =?utf-8?B?Yk03VDAwdWFDSEZzdGJIVVNoR3VKd3J3TkwrbHczZUk0dGF4UDJLUEpDeEhL?=
 =?utf-8?B?VHdBaUZRRWVzUnhaM0dHSC9qU1dDYXFaQy9tOUlqT09IR1I3WDJXc0FmVm9L?=
 =?utf-8?B?ZGIwcDJsejNiNUJtcXNoK2FWWlFZbWxtYVFkUmgrM0pWcGFIZEV3clAyeFVw?=
 =?utf-8?B?S2lFZmVjcWx4eDhSWDdNYXlvUXVVeU85MU9jcCtIdkJkSDg4L2xmZURzRUdx?=
 =?utf-8?B?VXVucUVvbWg5WmFTU2RvK29uR0gwZklNYnJLcEtmRjZtZU5vZWR5aGxPQzVX?=
 =?utf-8?B?WDZINnFwUDVYL043NVl5RnJ1K1RLL3orbmpSRlB3bzd1QWg4aFpPbzZ0UVJD?=
 =?utf-8?B?WWJha1dheXFFQ1VHeFp1M0pFY2JHRTRXRmQ0SHBBZUdPS0ZHSGpoZFFranFF?=
 =?utf-8?B?QURmOXdnaTY0ampiaVJpYXJ2Zm1DMWRucnRWOHRGMitNYVo0M1owcVlnSmZ4?=
 =?utf-8?B?b3hFejhXcnAvL0hKbWp2UXhSd2l0V0hiUkFaU2N6V09SazdWam04Y1c3aXVS?=
 =?utf-8?B?NjBndzJYTzltelV6STU0SS90c0hxMmowMksvaENYcVdMUXpObUNacVlQdzhJ?=
 =?utf-8?B?dzZxb2lrUmN6RUxkUWhQQnJuOGRVSTdkOWRoVjdjemdYeFhHNVYwMmJ4eWtU?=
 =?utf-8?B?Q3NjNHRKeHhZTGNGakNLZmU5SWVESjdPVTlneGlpRUdySlZ3Z0NvNUIzMU0y?=
 =?utf-8?B?YVdEN0FEa29JQnlDZ1JrdVNnMytHV3VjalkyTUVVZVp1OWI1bGtKNjNJa0Jo?=
 =?utf-8?B?UUxEKzhDYzNHQWtnS3R4N3pzZUY1c2VvNlViczF1Vm9rRnk4UzkxTHN6Z0Fx?=
 =?utf-8?B?MTdRVUhXc3QrZFM1SnpPQ0lEOWlNc29VMnp6UGJ2WTNFNWZWM1pNblFnbG85?=
 =?utf-8?B?UDVmeDNGRkxGV3VOL2paMFY3Wm9tNVQxVzZSZ2xYdEttOHFJU3NCVm9TWGRt?=
 =?utf-8?B?Rm9mekhDQ21Za1E2aUkrekdqbm5PU0xTeG15dU5JRi9qZDZyU0J2SS9KdnpR?=
 =?utf-8?B?RUdYOUxuNm9teFhvd2hxdVEzVEt6T3dFUkg2MUt5a3BIWEFVelE4YUtNODJo?=
 =?utf-8?B?YXBQam5TUlo4a2MvZzJsaUxsSWZtMHpPY3FXOWdGWDhRMXNsNVhNczFZaFE0?=
 =?utf-8?B?U0NnOVJxK3BDaVpEWGEyZlV2M3paajRqL1RHbWd0anBkRDhKVnUvdW5aZFhK?=
 =?utf-8?Q?Hph5ih8X1cGMpV79jcp3ckfzM12fULssJXTwuzGKlb3Id?=
X-MS-Exchange-AntiSpam-MessageData-1: m98IWnIvrw4peQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2a3e5c-0fe1-41e2-eed4-08deedf57f96
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:46:19.8508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5luIw5EYlCTiXM1IW67yqINFIQBTDF+BX8f6rgWDnbWmyhhlLJATmSbo8+C2E6i9t7nxKrbZJOoO0I88+GX6g==
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

Currently all syncobj_in fences are waited synchronously on the CPU.
However, since Host1x channels are capable of waiting for syncpoint
fences on the hardware, let's use that capability.

This filters the any non-syncpoint (or different host1x instance) fences
in syncobj_in, waits only those on the CPU, and adds the rest as waits
to the channel before the actual job contents.

Also make minor clarifications to the doc comments in the UAPI header.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/submit.c | 111 +++++++++++++++++++++++++++++++++--------
 include/uapi/drm/tegra_drm.h   |   4 +-
 2 files changed, 93 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index 1e5332eb6e26..54312922f7b2 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 NVIDIA Corporation */
 
+#include <linux/dma-fence-unwrap.h>
 #include <linux/dma-mapping.h>
 #include <linux/file.h>
 #include <linux/host1x.h>
@@ -344,6 +345,71 @@ static int submit_get_syncpt(struct tegra_drm_context *context, struct host1x_jo
 	return 0;
 }
 
+static int submit_handle_in_fence(struct tegra_drm_context *context, struct host1x *host1x,
+				  struct dma_fence *fence, u32 *num_waits)
+{
+	struct dma_fence_unwrap iter;
+	struct host1x *fence_host1x;
+	struct dma_fence *f;
+	int err = 0;
+
+	*num_waits = 0;
+
+	dma_fence_unwrap_for_each(f, &iter, fence) {
+		long wait_err;
+
+		if (err)
+			continue;
+
+		if (dma_fence_is_signaled(f))
+			continue;
+
+		err = host1x_fence_extract(f, &fence_host1x, NULL, NULL);
+		if (!err && fence_host1x == host1x) {
+			(*num_waits)++;
+			continue;
+		}
+
+		wait_err = dma_fence_wait_timeout(f, true, msecs_to_jiffies(10000));
+		if (wait_err == 0) {
+			SUBMIT_ERR(context, "wait for syncobj_in timed out");
+			err = -ETIMEDOUT;
+			continue;
+		} else if (wait_err < 0) {
+			/* In practice, -ERESTARTSYS */
+			err = wait_err;
+			continue;
+		} else {
+			err = 0;
+		}
+	}
+
+	return err;
+}
+
+static void submit_job_add_prefence(struct host1x_job *job, struct dma_fence *fence, u32 class)
+{
+	struct dma_fence_unwrap iter;
+	struct dma_fence *f;
+
+	dma_fence_unwrap_for_each(f, &iter, fence) {
+		u32 id, threshold;
+
+		if (dma_fence_is_signaled(f))
+			continue;
+
+		if (host1x_fence_extract(f, NULL, &id, &threshold)) {
+			/*
+			 * The fence may have signalled since the check above, and
+			 * the dma_fence framework then detached its ops.
+			 */
+			continue;
+		}
+
+		host1x_job_add_wait(job, id, threshold, false, class);
+	}
+}
+
 static int submit_job_add_gather(struct host1x_job *job, struct tegra_drm_context *context,
 				 struct drm_tegra_submit_cmd_gather_uptr *cmd,
 				 struct gather_bo *bo, u32 *offset,
@@ -389,7 +455,7 @@ static int submit_job_add_gather(struct host1x_job *job, struct tegra_drm_contex
 static struct host1x_job *
 submit_create_job(struct tegra_drm_context *context, struct gather_bo *bo,
 		  struct drm_tegra_channel_submit *args, struct tegra_drm_submit_data *job_data,
-		  struct xarray *syncpoints)
+		  struct xarray *syncpoints, struct dma_fence *in_fence, u32 num_prefence_waits)
 {
 	struct drm_tegra_submit_cmd *cmds;
 	u32 i, gather_offset = 0, class;
@@ -406,7 +472,7 @@ submit_create_job(struct tegra_drm_context *context, struct gather_bo *bo,
 		return ERR_CAST(cmds);
 	}
 
-	job = host1x_job_alloc(context->channel, args->num_cmds, 0, true);
+	job = host1x_job_alloc(context->channel, args->num_cmds + num_prefence_waits, 0, true);
 	if (!job) {
 		SUBMIT_ERR(context, "failed to allocate memory for job");
 		job = ERR_PTR(-ENOMEM);
@@ -421,6 +487,9 @@ submit_create_job(struct tegra_drm_context *context, struct gather_bo *bo,
 	job->class = context->client->base.class;
 	job->serialize = true;
 
+	if (in_fence)
+		submit_job_add_prefence(job, in_fence, class);
+
 	for (i = 0; i < args->num_cmds; i++) {
 		struct drm_tegra_submit_cmd *cmd = &cmds[i];
 
@@ -506,11 +575,14 @@ static void release_job(struct host1x_job *job)
 int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 				   struct drm_file *file)
 {
+	struct host1x *host1x = dev_get_drvdata(drm->dev->parent);
 	struct tegra_drm_file *fpriv = file->driver_priv;
 	struct drm_tegra_channel_submit *args = data;
 	struct tegra_drm_submit_data *job_data;
 	struct drm_syncobj *syncobj = NULL;
+	struct dma_fence *in_fence = NULL;
 	struct tegra_drm_context *context;
+	u32 num_prefence_waits = 0;
 	struct host1x_job *job;
 	struct gather_bo *bo;
 	u32 i;
@@ -527,26 +599,15 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 	}
 
 	if (args->syncobj_in) {
-		struct dma_fence *fence;
-		long wait_err;
-
-		err = drm_syncobj_find_fence(file, args->syncobj_in, 0, 0, &fence);
+		err = drm_syncobj_find_fence(file, args->syncobj_in, 0, 0, &in_fence);
 		if (err) {
 			SUBMIT_ERR(context, "invalid syncobj_in '%#x'", args->syncobj_in);
 			goto unlock;
 		}
 
-		wait_err = dma_fence_wait_timeout(fence, true, msecs_to_jiffies(10000));
-		dma_fence_put(fence);
-		if (wait_err == 0) {
-			SUBMIT_ERR(context, "wait for syncobj_in timed out");
-			err = -ETIMEDOUT;
-			goto unlock;
-		} else if (wait_err < 0) {
-			/* In practice, -ERESTARTSYS */
-			err = wait_err;
-			goto unlock;
-		}
+		err = submit_handle_in_fence(context, host1x, in_fence, &num_prefence_waits);
+		if (err)
+			goto put_in_fence;
 	}
 
 	if (args->syncobj_out) {
@@ -554,14 +615,14 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 		if (!syncobj) {
 			SUBMIT_ERR(context, "invalid syncobj_out '%#x'", args->syncobj_out);
 			err = -ENOENT;
-			goto unlock;
+			goto put_in_fence;
 		}
 	}
 
 	/* Allocate gather BO and copy gather words in. */
 	err = submit_copy_gather_data(&bo, drm->dev, context, args);
 	if (err)
-		goto unlock;
+		goto put_in_fence;
 
 	job_data = kzalloc_obj(*job_data);
 	if (!job_data) {
@@ -576,12 +637,20 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 		goto free_job_data;
 
 	/* Allocate host1x_job and add gathers and waits to it. */
-	job = submit_create_job(context, bo, args, job_data, &fpriv->syncpoints);
+	job = submit_create_job(context, bo, args, job_data, &fpriv->syncpoints, in_fence,
+				num_prefence_waits);
 	if (IS_ERR(job)) {
 		err = PTR_ERR(job);
 		goto free_job_data;
 	}
 
+	/*
+	 * The prefence has been recorded as plain syncpoint waits, so the fence
+	 * itself is not needed anymore.
+	 */
+	dma_fence_put(in_fence);
+	in_fence = NULL;
+
 	/* Map gather data for Host1x. */
 	err = host1x_job_pin(job, context->client->base.dev);
 	if (err) {
@@ -680,6 +749,8 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 	kfree(job_data);
 put_bo:
 	gather_bo_put(&bo->base);
+put_in_fence:
+	dma_fence_put(in_fence);
 unlock:
 	if (syncobj)
 		drm_syncobj_put(syncobj);
diff --git a/include/uapi/drm/tegra_drm.h b/include/uapi/drm/tegra_drm.h
index 8f21f3a44832..b17472103e91 100644
--- a/include/uapi/drm/tegra_drm.h
+++ b/include/uapi/drm/tegra_drm.h
@@ -986,8 +986,8 @@ struct drm_tegra_channel_submit {
 	/**
 	 * @syncobj_in: [in]
 	 *
-	 * Handle for DRM syncobj that will be waited before submission.
-	 * Ignored if zero.
+	 * Handle for DRM syncobj that will be waited for before the job
+	 * executes. Ignored if zero.
 	 */
 	__u32 syncobj_in;
 

-- 
2.53.0

