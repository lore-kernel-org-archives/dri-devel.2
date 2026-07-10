Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E422C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE2710F7CA;
	Fri, 10 Jul 2026 07:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SulcrwVh";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A2310F7C8
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezmJ1jjdOUV1Y8An50yzjVTQwsD5yGcA/Bul8vhO+xeUBKw/2u/yBeI/EYQ3T2IYZOFoKDT/q2sEaa/wz5uNeCFy14R+FYjx9TeiHNPntvsXjb0w/V831Ol0WA4O9lpxblvo3ZNFXDSSNgQ5S286WEzZ54ED1OZ1LHeuX8VivzwqKcG8q+V8gynKKoagiktaEUsZ3aHwVmYB5RMF9vCJQBGVcLxedcau0dXVUMSWa5dvEzUVU2kH/PiKfvOJ+cBrlLke980mauP4wqQi+dSnL0a+U6qCwagrh9Qqev2f7UaJDPo7mwf7kDvRYFx0Llpv2s1QF6csHPpILQIY8dh7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdFblkh+CYwJm+fDAmnhGdvuWw0K74nVQxzctG1PxrA=;
 b=jOLTylqvsh9I98e9fsa3/qVI8I9LC9Ki0eMR0YWetoUGp+3bB8oaRbYIg1WMWDh16kB1zdSkPQme0+mOEcLiMmDSwL6+QqtApwYDYH29bM81DfeaBp8sgCUZEeUXw2wMvCGNY0yrw4GyD90S/4xm5HjqfyqIISZT25gfPwAgMMN3tq1xXChQHdVjjEJ0SgEUr6XfwXIATN+kXD0Tvyj5t66dvjhJ2kVwIoPdAgtVESgvn/kWDMfoVKH5+MQGtNFeJ39DkQf6jJnqIrHpWC2OhQmfq8sFiCzGfztLy4ZY36wbSfoWvZ1iUs1EqgY/it2X0MNoSqfapyMxQkO4P9dgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdFblkh+CYwJm+fDAmnhGdvuWw0K74nVQxzctG1PxrA=;
 b=SulcrwVhE3Z4HOiouXO+E9I0LPvtIlfytfQKCEnLSIPjraMzjNYa9jrnnAgDjToswddePdxSyMqqfh8RcdyQa+g7q89uHtxOOwXoS/ztELYAwdk9eRU1pgyZeHJVptdc0fPM9pMQYCEAJXK4KMdP4NCUYX0bhNUJfArJ+3MDMm6oOpgA5CESfvI9eBDMDFg4fMLItUz+JJUYzIrPC/CCYSJ1/fMD/ES0HHblEn0kkqc8FAMq68gfgONq5Y1YZuKxj4Yc4r6PuIU0IXrysdcwrKTe6D6tabpPxHn/VFJ2pPfGMoTIND5BvRbrsQe9GfO27YhjO/TX+raPZL+f14/Wug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DSVPR12MB999124.namprd12.prod.outlook.com (2603:10b6:8:38b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 07:15:02 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 07:15:02 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 10 Jul 2026 16:14:31 +0900
Subject: [PATCH 1/2] gpu: host1x: Memory context stealing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-b4-host1x-ctxsteal-v1-1-b1f8f6b37cc5@nvidia.com>
References: <20260710-b4-host1x-ctxsteal-v1-0-b1f8f6b37cc5@nvidia.com>
In-Reply-To: <20260710-b4-host1x-ctxsteal-v1-0-b1f8f6b37cc5@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS7PR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:604:24f::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DSVPR12MB999124:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f45f86-9de5-4921-7be0-08dede52f5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|23010399003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: xUcnH2fK9eiWqCSbL6Gu+QwUgJnSHxQvAmqGESiudsCzIaYsqafDmpOvOe6nRFxdaxUO+Z5tJ9+c52I9Uj5/W3YFXXvwwudmkfGU3UIHHX4etEWOIS4rMzYablgpAnyLjt7g1EEmmWRsbPiPcAJDkGTQIN86hsghKQ2mXfx9ip0wRQpBsgOG3pe0pIblqFhZFlKQZYIOpxGiU6XijZ4yPa7sk+zWx/e0VxIKuedn2K3Ll2PzqRUvas9S812TofULzyG02Yxy3wuv/WIy5sqQTP6F1JI8IMwi02/zi0VwZqpx4EZ4iduo4mtAY/X3NchH0a4hkLnw5vuj6sKalNpbYA41b3Zs7nr0I+0VojvbWl/ZhjtxqE2553moEaaA5hJDqc3B5JL5Dk1bGK6OLti2Tnwoml/VWpX4oop7Izpe+8jJx3EuiqfRT5g6Hw90BLfE/YO3hkpNfP8VbMEUxXepfdhKJAqR2bK6fP5KwWAK0WFhKJFIOWXla1kN1nAT1QgsUtgE427Br2VEReezuTM56l5u86zbnYFvD3wSBxsnvogYf6iZLi87YUizSkejHmmD8WhZBUFMIWKi/nmP+2CRf+5k9B6vpBJRgGDw1/xahwbXqyPawcy9CVwdVRwaq00+p9FGLtODzBRjN74OJeOlgddDjVLsZtZ4ZZ3helEC0rw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWZmOUVhV2FzTXlnQ212eU96VFZCa3RaTXpxQkpMcHI0Z3ArNmJ4Y253YWVq?=
 =?utf-8?B?ME5WNnhNYUhNaktmYjhyYldaL0lDSXVvMEpqREJ1dWJsSWlEeS9VYytFcEdn?=
 =?utf-8?B?UitWcUJSbnMvc0g2M3ZSTElBbzQ4ckFUT1ZXeGRIckZlQjFGb1ZsR1dYeWpm?=
 =?utf-8?B?eFpZWC9HOC9rZU91alR1N1dkM21KRGQ5aVp5UzIwNTdEdm5UUCs5MXh6RWhS?=
 =?utf-8?B?dUNWWHY5enZvY3NaUjRxZVhuTXhGUWQzYTBqZHZwcXVIcnVXWjY2OGlHMldh?=
 =?utf-8?B?S0ZGVlY5b0w5R3VOQ0FJNUdYdXBHempwOWN3UmE1dE41L3djVTB3M3QxVHhE?=
 =?utf-8?B?Q055dG5RVUJxOXBxcU5iTHRyOGZJY1l0ZTZmblBHck9hM1JqMEYzMlpQT3Zr?=
 =?utf-8?B?dmkzUDFLSjRkdG9KL3BZNkVSQTUrR2RBUFNURGppV0gydmFOYlA2V3U2YzNa?=
 =?utf-8?B?b3VJU1ZIaHJBRVRpZ1IrVkFubEJTQVFqZW5Td1ZKcWFxMytuTm9NQ1d3V25q?=
 =?utf-8?B?cGwyYnpqTDNOa1l1QXBLbVdDaTlMdWh6djc3enhGak1jTG5FWFp3TlM3MTFk?=
 =?utf-8?B?cWFFd2h4Y3BVMnMxd3RHRXpERzRuK3RpSWtVN2NTZVhjNGE5TzFRRXBIWjhM?=
 =?utf-8?B?RERYTDNIWmJQd0p0VkJDTFBJVk9LSnJaUEhsaWxKRVNBWG40ai9MRjJMRk9C?=
 =?utf-8?B?TmUzQ1ppV1dvVVora2R0TXpMVGd5WTV1eGtPcWFjbkg3cWpsRjBJK01KQWpQ?=
 =?utf-8?B?bVcyR0xUSy9EZ1I0OTRBenp2M1VtQVp6dDlkRXh1eDlQV1g5TENNOVEwMXMz?=
 =?utf-8?B?eW1FNVE5SWtsSStUdVJMbk9hRWdRbk5tMzJjUEpsZlpTaU54OFFTZnl1VDVO?=
 =?utf-8?B?d3JEUWxLY1daUnZiVEwrRC9CRkVkWGt4a2l5b1EvbmNZOFlRT3dxSEdLaVg0?=
 =?utf-8?B?dzdCSGhmOTZ4UTVSWFVwcU1LclEwNTRxVEVnUE4rMDVaT3VFaXlBbzh0Q3Uy?=
 =?utf-8?B?aFV6SWdFRzBsV2ZmYmhQWGpCczN6akxCM1EvUFV3cURyTUhnbkxZaWllRkpY?=
 =?utf-8?B?ZkptVmVRdnVLSnptK05lRExidmxaUCtYa0w5V29rcHVKV0R2d1U5ejU3emJh?=
 =?utf-8?B?cnFIUGtqcTFYb09VOWVVblQ4R3NxRUN3V2ozNk16bHJmdmxjOXNwblNyb0Ex?=
 =?utf-8?B?Y2h0T0pLaHl6TWJ3VmVSaUo5Qnp5SndlNS9NY1VBN1dJcHpBcFluamRqSDFV?=
 =?utf-8?B?SkRONi8zV3FuUjlydEpvbGd3T1FmZUtBbXVtUU5VUDZncUFMUEg2cjh2QXE4?=
 =?utf-8?B?ZFdxb2JHcW1PcHI2TzRCOHQ1YlJRWlBPRHBVdDJZUm8vdlRFbStGVTlDdE11?=
 =?utf-8?B?MUxPY2VFczNZcEI5UnEzK3hlZHc2WTFCdUFERlJCWTdrbkF3cXBwNHI5VjY2?=
 =?utf-8?B?RHZkWTFBdkgvVUxlUnY1Z0ZQWUcvNmg3WE9kWlVwQ0dqV09SUzc5UklqNUo3?=
 =?utf-8?B?bWJwcE9DN1dqMDFuQU5zMTUvT2tOSTliSkRHZ0JxQTNDaHdscUV6aFNPK2hG?=
 =?utf-8?B?M21RTDlSbTltRXc5NTM2MkRLa2RJNlMwSU5RYm1lSWhXSE5Tb3BNSnprNkFn?=
 =?utf-8?B?L3Y1YzdSYitOdWdzVjUxNXZmd0tZY0JUV2JsTVdhSWxSVnBHZStEemg5OGFa?=
 =?utf-8?B?VUkrQno2cFJ2dFp2TTBHN253L2I4WHh5SjBteGpJTVhTVjE4ZGFHV0V0N0xV?=
 =?utf-8?B?WHFCM2FPZk0zSmVCdFBERncxQ3NsR1h6bDJyOVJjQStwMDhpZ1p3bWZyblky?=
 =?utf-8?B?QlhkeDJqMWVpUzcwODFlMW40aUd0UUNxWDJDYmdzUXlPZ0RIeW83TlhWcmE2?=
 =?utf-8?B?L256RUtkYnp2K3p2T3RybmtpaTJYeUwwOGtVUUo1dlJHbnYzQU9UV3ZKbTA0?=
 =?utf-8?B?UHhvelBhYjlNeHRzU2dWQldKdnZzSnF6Q2JvWENqR0hWUDVoR3FDN3dqK2M1?=
 =?utf-8?B?NmNqOU1ZZGdveVBoWEZhaWd2QXh5YWJsL2hBMXpocHV4SUVoejFoakZ5YU5j?=
 =?utf-8?B?dkRadXN5YUM3N25tYlIzNWllUVhPSW9ldDFoRVhBYVJ5dXZsQ0pOMkNtSjgy?=
 =?utf-8?B?b0V4a1Q2d1lCVytjL0RFR3RVVEpQYzVnckNWdDB0RTFnQm42bzVZUSswMWxQ?=
 =?utf-8?B?QnllN2xQM2ZyTVpBZ1lyY3BDMVRydW9mQlFyb2tQWjNaTDBBTDJKWHJFTGx1?=
 =?utf-8?B?V1dRWHczOXlxRzlNMitBRnJjd1N5K29heVlDVE93MkpBUU1LZDhRUUYyNk0w?=
 =?utf-8?B?bldsMGlCMzRGcytCR1pKN29uS2RDTkVsZW11OWhWNy9lSmQ1S1gzbUd4Z2Fq?=
 =?utf-8?Q?NtSNQ6gZQ6s0ZZVdeJYSgVp2gSSDReTjY8fsorcYltzTC?=
X-MS-Exchange-AntiSpam-MessageData-1: pachKXI1Rg3omQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f45f86-9de5-4921-7be0-08dede52f5a5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:15:02.6021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0a243RmDMGazUw77IR4/V2dz2sufXqmuz1B3gVRelQPVRHLQ6r2lvnPdUHOYlgFDdIGe41ecqaEEwmbagUUfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999124
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

Currently, each process holding an open TegraDRM channel reserves for
itself one of the limited number of hardware memory contexts. Attempting
to allocate a channel when all contexts are in use results in failure.

While we cannot have more contexts than the hardware supports in active
use, idle channels don't necessarily need to have a backing memory
context. As such, in this patch, we add another layer to allow hardware
memory contexts to be "stolen away" by channels that are in active use,
from idle processes.

The way this is implemented, is by keeping track of memory mappings on
each abstracted memory context. If we need to steal that memory
context's backing hardware context, we unmap everything from it and give
it away. When that abstracted memory context is needed again
(re-activated), we attempt to allocate or steal another hardware context
and re-map the previously unmapped buffers.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/submit.c     |  36 +++-
 drivers/gpu/drm/tegra/uapi.c       |  49 ++++--
 drivers/gpu/drm/tegra/uapi.h       |   3 +-
 drivers/gpu/host1x/context.c       | 351 ++++++++++++++++++++++++++++++++++---
 drivers/gpu/host1x/context.h       |  18 +-
 drivers/gpu/host1x/hw/channel_hw.c |   3 +-
 include/linux/host1x.h             |  48 ++++-
 7 files changed, 455 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index 3009b8b9e619..c8945e8a004d 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -229,9 +229,14 @@ static int submit_write_reloc(struct tegra_drm_context *context, struct gather_b
 			      struct drm_tegra_submit_buf *buf, struct tegra_drm_mapping *mapping)
 {
 	/* TODO check that target_offset is within bounds */
-	dma_addr_t iova = mapping->iova + buf->reloc.target_offset;
+	dma_addr_t iova = buf->reloc.target_offset;
 	u32 written_ptr;
 
+	if (mapping->bo_map)
+		iova += mapping->iova;
+	else
+		iova += mapping->ctx_map->mapping->phys;
+
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	if (buf->flags & DRM_TEGRA_SUBMIT_RELOC_SECTOR_LAYOUT)
 		iova |= BIT_ULL(39);
@@ -493,12 +498,14 @@ static void release_job(struct host1x_job *job)
 	struct tegra_drm_submit_data *job_data = job->user_data;
 	u32 i;
 
-	if (job->memory_context)
-		host1x_memory_context_put(job->memory_context);
-
 	for (i = 0; i < job_data->num_used_mappings; i++)
 		tegra_drm_mapping_put(job_data->used_mappings[i].mapping);
 
+	if (job->memory_context) {
+		host1x_memory_context_inactive(job->memory_context);
+		host1x_memory_context_put(job->memory_context);
+	}
+
 	kfree(job_data->used_mappings);
 	kfree(job_data);
 
@@ -509,6 +516,7 @@ static void release_job(struct host1x_job *job)
 int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 				   struct drm_file *file)
 {
+	struct host1x_memory_context *active_memctx = NULL;
 	struct tegra_drm_file *fpriv = file->driver_priv;
 	struct drm_tegra_channel_submit *args = data;
 	struct tegra_drm_submit_data *job_data;
@@ -529,6 +537,17 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 		return -EINVAL;
 	}
 
+	if (context->memory_context) {
+		err = host1x_memory_context_active(context->memory_context);
+		if (err) {
+			mutex_unlock(&fpriv->lock);
+			SUBMIT_ERR(context, "failed to activate memory context");
+			return err;
+		}
+
+		active_memctx = context->memory_context;
+	}
+
 	if (args->syncobj_in) {
 		struct dma_fence *fence;
 
@@ -605,7 +624,8 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 		}
 
 		if (supported) {
-			job->memory_context = context->memory_context;
+			job->memory_context = active_memctx;
+			active_memctx = NULL;
 			host1x_memory_context_get(job->memory_context);
 		}
 	} else if (context->client->ops->get_streamid_offset) {
@@ -658,8 +678,10 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 	goto put_job;
 
 put_memory_context:
-	if (job->memory_context)
+	if (job->memory_context) {
+		host1x_memory_context_inactive(job->memory_context);
 		host1x_memory_context_put(job->memory_context);
+	}
 unpin_job:
 	host1x_job_unpin(job);
 put_job:
@@ -678,6 +700,8 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 unlock:
 	if (syncobj)
 		drm_syncobj_put(syncobj);
+	if (active_memctx)
+		host1x_memory_context_inactive(active_memctx);
 
 	mutex_unlock(&fpriv->lock);
 	return err;
diff --git a/drivers/gpu/drm/tegra/uapi.c b/drivers/gpu/drm/tegra/uapi.c
index c0ac6b45f2d7..395ba3ea1d17 100644
--- a/drivers/gpu/drm/tegra/uapi.c
+++ b/drivers/gpu/drm/tegra/uapi.c
@@ -17,7 +17,11 @@ static void tegra_drm_mapping_release(struct kref *ref)
 	struct tegra_drm_mapping *mapping =
 		container_of(ref, struct tegra_drm_mapping, ref);
 
-	host1x_bo_unpin(mapping->map);
+	if (mapping->ctx_map)
+		host1x_memory_context_unmap(mapping->ctx_map);
+	else
+		host1x_bo_unpin(mapping->bo_map);
+
 	host1x_bo_put(mapping->bo);
 
 	kfree(mapping);
@@ -33,12 +37,12 @@ static void tegra_drm_channel_context_close(struct tegra_drm_context *context)
 	struct tegra_drm_mapping *mapping;
 	unsigned long id;
 
-	if (context->memory_context)
-		host1x_memory_context_put(context->memory_context);
-
 	xa_for_each(&context->mappings, id, mapping)
 		tegra_drm_mapping_put(mapping);
 
+	if (context->memory_context)
+		host1x_memory_context_put(context->memory_context);
+
 	xa_destroy(&context->mappings);
 
 	host1x_channel_put(context->channel);
@@ -192,7 +196,6 @@ int tegra_drm_ioctl_channel_map(struct drm_device *drm, void *data, struct drm_f
 	struct tegra_drm_mapping *mapping;
 	struct tegra_drm_context *context;
 	enum dma_data_direction direction;
-	struct device *mapping_dev;
 	int err = 0;
 
 	if (args->flags & ~DRM_TEGRA_CHANNEL_MAP_READ_WRITE)
@@ -214,11 +217,6 @@ int tegra_drm_ioctl_channel_map(struct drm_device *drm, void *data, struct drm_f
 
 	kref_init(&mapping->ref);
 
-	if (context->memory_context)
-		mapping_dev = &context->memory_context->dev;
-	else
-		mapping_dev = context->client->base.dev;
-
 	mapping->bo = tegra_gem_lookup(file, args->handle);
 	if (!mapping->bo) {
 		err = -EINVAL;
@@ -243,14 +241,26 @@ int tegra_drm_ioctl_channel_map(struct drm_device *drm, void *data, struct drm_f
 		goto put_gem;
 	}
 
-	mapping->map = host1x_bo_pin(mapping_dev, mapping->bo, direction, NULL);
-	if (IS_ERR(mapping->map)) {
-		err = PTR_ERR(mapping->map);
-		goto put_gem;
-	}
+	if (context->memory_context) {
+		mapping->ctx_map = host1x_memory_context_map(context->memory_context,
+							     mapping->bo, direction);
+
+		if (IS_ERR(mapping->ctx_map)) {
+			err = PTR_ERR(mapping->ctx_map);
+			goto put_gem;
+		}
+	} else {
+		mapping->bo_map = host1x_bo_pin(context->client->base.dev,
+						mapping->bo, direction, NULL);
 
-	mapping->iova = mapping->map->phys;
-	mapping->iova_end = mapping->iova + host1x_to_tegra_bo(mapping->bo)->gem.size;
+		if (IS_ERR(mapping->bo_map)) {
+			err = PTR_ERR(mapping->bo_map);
+			goto put_gem;
+		}
+
+		mapping->iova = mapping->bo_map->phys;
+		mapping->iova_end = mapping->iova + host1x_to_tegra_bo(mapping->bo)->gem.size;
+	}
 
 	err = xa_alloc(&context->mappings, &args->mapping, mapping, XA_LIMIT(1, U32_MAX),
 		       GFP_KERNEL);
@@ -262,7 +272,10 @@ int tegra_drm_ioctl_channel_map(struct drm_device *drm, void *data, struct drm_f
 	return 0;
 
 unpin:
-	host1x_bo_unpin(mapping->map);
+	if (mapping->ctx_map)
+		host1x_memory_context_unmap(mapping->ctx_map);
+	else
+		host1x_bo_unpin(mapping->bo_map);
 put_gem:
 	host1x_bo_put(mapping->bo);
 free:
diff --git a/drivers/gpu/drm/tegra/uapi.h b/drivers/gpu/drm/tegra/uapi.h
index 92ff1e44ff15..7703ebb3c95e 100644
--- a/drivers/gpu/drm/tegra/uapi.h
+++ b/drivers/gpu/drm/tegra/uapi.h
@@ -27,7 +27,8 @@ struct tegra_drm_file {
 struct tegra_drm_mapping {
 	struct kref ref;
 
-	struct host1x_bo_mapping *map;
+	struct host1x_bo_mapping *bo_map;
+	struct host1x_context_mapping *ctx_map;
 	struct host1x_bo *bo;
 
 	dma_addr_t iova;
diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
index 52ca663902ad..8c159076d0fa 100644
--- a/drivers/gpu/host1x/context.c
+++ b/drivers/gpu/host1x/context.c
@@ -3,8 +3,10 @@
  * Copyright (c) 2021, NVIDIA Corporation.
  */
 
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/kref.h>
+#include <linux/list.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pid.h>
@@ -22,13 +24,14 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 {
 	struct host1x_memory_context_list *cdl = &host1x->context_list;
 	struct device_node *node = host1x->dev->of_node;
-	struct host1x_memory_context *ctx;
+	struct host1x_hw_memory_context *ctx;
 	unsigned int devs, i;
 	int err;
 
 	cdl->devs = NULL;
 	cdl->len = 0;
 	mutex_init(&cdl->lock);
+	INIT_LIST_HEAD(&cdl->waiters);
 
 	err = of_property_count_u32_elems(node, "iommu-map");
 	if (err < 0)
@@ -52,6 +55,7 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 		ctx = &cdl->devs[i];
 
 		ctx->host = host1x;
+		INIT_LIST_HEAD(&ctx->owners);
 
 		device_initialize(&ctx->dev);
 
@@ -125,62 +129,367 @@ void host1x_memory_context_list_free(struct host1x_memory_context_list *cdl)
 	cdl->len = 0;
 }
 
-struct host1x_memory_context *host1x_memory_context_alloc(struct host1x *host1x,
-							  struct device *dev,
-							  struct pid *pid)
+static bool hw_usable_for_dev(struct host1x_hw_memory_context *hw, struct device *dev)
+{
+	return hw->dev.iommu->iommu_dev == dev->iommu->iommu_dev;
+}
+
+static struct host1x_hw_memory_context *
+host1x_memory_context_alloc_hw_locked(struct host1x *host1x, struct device *dev,
+				      struct pid *pid)
 {
 	struct host1x_memory_context_list *cdl = &host1x->context_list;
-	struct host1x_memory_context *free = NULL;
+	struct host1x_hw_memory_context *free = NULL, *can_steal = NULL;
+	struct host1x_memory_context *ctx;
 	int i;
 
 	if (!cdl->len)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	mutex_lock(&cdl->lock);
-
 	for (i = 0; i < cdl->len; i++) {
-		struct host1x_memory_context *cd = &cdl->devs[i];
+		struct host1x_hw_memory_context *cd = &cdl->devs[i];
 
-		if (cd->dev.iommu->iommu_dev != dev->iommu->iommu_dev)
+		if (!hw_usable_for_dev(cd, dev))
 			continue;
 
 		if (cd->owner == pid) {
 			refcount_inc(&cd->ref);
-			mutex_unlock(&cdl->lock);
 			return cd;
 		} else if (!cd->owner && !free) {
 			free = cd;
+		} else if (refcount_read(&cd->active) == 0) {
+			can_steal = cd;
 		}
 	}
 
-	if (!free) {
-		mutex_unlock(&cdl->lock);
+	if (free)
+		goto found;
+
+	/* Steal */
+
+	if (!can_steal)
 		return ERR_PTR(-EBUSY);
+
+	list_for_each_entry(ctx, &can_steal->owners, entry) {
+		struct host1x_context_mapping *mapping;
+
+		ctx->hw = NULL;
+
+		list_for_each_entry(mapping, &ctx->mappings, entry) {
+			host1x_bo_unpin(mapping->mapping);
+			mapping->mapping = NULL;
+		}
 	}
 
+	put_pid(can_steal->owner);
+
+	free = can_steal;
+
+found:
 	refcount_set(&free->ref, 1);
 	free->owner = get_pid(pid);
-
-	mutex_unlock(&cdl->lock);
+	INIT_LIST_HEAD(&free->owners);
 
 	return free;
 }
+
+static void host1x_memory_context_hw_put(struct host1x_hw_memory_context *cd)
+{
+	if (refcount_dec_and_test(&cd->ref)) {
+		put_pid(cd->owner);
+		cd->owner = NULL;
+	}
+}
+
+/**
+ * host1x_memory_context_alloc() - allocate a logical memory context
+ * @host1x: host1x instance
+ * @dev: engine device that will own the context
+ * @pid: PID (TGID) of the process the context is allocated for
+ *
+ * Allocate a logical memory context. The context has no backing hardware memory
+ * context until host1x_memory_context_active() is called unless static context
+ * allocation is enabled.
+ *
+ * Return: pointer to the new context, or an ERR_PTR() on failure.
+ * ERR_PTR(-EOPNOTSUPP) is returned if the platform has no hardware memory
+ * contexts.
+ */
+struct host1x_memory_context *host1x_memory_context_alloc(struct host1x *host1x,
+							  struct device *dev,
+							  struct pid *pid)
+{
+	struct host1x_memory_context_list *cdl = &host1x->context_list;
+	struct host1x_memory_context *ctx;
+
+	if (!cdl->len)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	ctx = kzalloc_obj(*ctx, GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->host = host1x;
+	ctx->dev = dev;
+	ctx->pid = get_pid(pid);
+
+	refcount_set(&ctx->ref, 1);
+	INIT_LIST_HEAD(&ctx->mappings);
+
+	return ctx;
+}
 EXPORT_SYMBOL_GPL(host1x_memory_context_alloc);
 
-void host1x_memory_context_get(struct host1x_memory_context *cd)
+struct hw_alloc_waiter {
+	struct completion wait; /* Completion to wait for free hw context */
+	struct list_head entry;
+	struct device *dev;
+};
+
+/**
+ * host1x_memory_context_active() - mark a memory context as in use
+ * @ctx: memory context
+ *
+ * Bind a hardware memory context to @ctx and map all of its stored mappings,
+ * allocating or stealing a hardware context from an idle context if needed.
+ * While the context is active its hardware context cannot be stolen away.
+ *
+ * Each successful call must be balanced by exactly one
+ * host1x_memory_context_inactive() call.
+ *
+ * May sleep, and may block until a hardware context becomes available unless
+ * static allocation is in use. Must be called in process context.
+ *
+ * Return: 0 on success or a negative error code. -EBUSY is returned if no
+ * hardware context could be obtained and static context allocation is enabled.
+ */
+int host1x_memory_context_active(struct host1x_memory_context *ctx)
+{
+	struct host1x_memory_context_list *cdl = &ctx->host->context_list;
+	struct host1x_context_mapping *mapping;
+	struct host1x_hw_memory_context *hw;
+	struct hw_alloc_waiter waiter;
+	bool retrying = false;
+	int err = 0;
+
+	mutex_lock(&cdl->lock);
+
+retry:
+	if (ctx->hw)
+		goto have_hw;
+
+	hw = host1x_memory_context_alloc_hw_locked(ctx->host, ctx->dev, ctx->pid);
+	if (PTR_ERR(hw) == -EBUSY) {
+		/* All contexts busy. Wait for free context. */
+		if (!retrying)
+			dev_warn(ctx->dev, "%s: all memory contexts are busy, waiting\n",
+				 current->comm);
+
+		init_completion(&waiter.wait);
+		waiter.dev = ctx->dev;
+		list_add(&waiter.entry, &cdl->waiters);
+
+		mutex_unlock(&cdl->lock);
+		err = wait_for_completion_interruptible(&waiter.wait);
+		mutex_lock(&cdl->lock);
+
+		list_del(&waiter.entry);
+		if (err)
+			goto unlock;
+
+		retrying = true;
+		goto retry;
+	}
+	if (IS_ERR(hw)) {
+		err = PTR_ERR(hw);
+		goto unlock;
+	}
+
+	ctx->hw = hw;
+	list_add(&ctx->entry, &hw->owners);
+
+	list_for_each_entry(mapping, &ctx->mappings, entry) {
+		mapping->mapping = host1x_bo_pin(&hw->dev, mapping->bo,
+						 mapping->direction, NULL);
+		if (IS_ERR(mapping->mapping)) {
+			err = PTR_ERR(mapping->mapping);
+			mapping->mapping = NULL;
+			goto unpin;
+		}
+	}
+
+have_hw:
+	/* We're just counting active users. No need to do anything on 0->1 transition.*/
+	if (!refcount_inc_not_zero(&ctx->hw->active))
+		refcount_set(&ctx->hw->active, 1);
+
+	mutex_unlock(&cdl->lock);
+
+	return 0;
+
+unpin:
+	list_for_each_entry(mapping, &ctx->mappings, entry) {
+		if (mapping->mapping) {
+			host1x_bo_unpin(mapping->mapping);
+			mapping->mapping = NULL;
+		}
+	}
+
+	host1x_memory_context_hw_put(ctx->hw);
+	list_del(&ctx->entry);
+	ctx->hw = NULL;
+unlock:
+	mutex_unlock(&cdl->lock);
+	return err;
+}
+EXPORT_SYMBOL_GPL(host1x_memory_context_active);
+
+/**
+ * host1x_memory_context_map() - add a buffer mapping to a memory context
+ * @ctx: memory context
+ * @bo: buffer object to map
+ * @direction: DMA direction of the mapping
+ *
+ * Register a mapping of @bo on @ctx. If @ctx currently has a hardware context
+ * bound, the buffer is mapped immediately; otherwise it is pinned the next time
+ * the context is made active. The mapping is unmapped and freed by
+ * host1x_memory_context_unmap().
+ *
+ * Return: pointer to the mapping, or an ERR_PTR() on failure.
+ */
+struct host1x_context_mapping *host1x_memory_context_map(struct host1x_memory_context *ctx,
+							 struct host1x_bo *bo,
+							 enum dma_data_direction direction)
+{
+	struct host1x_memory_context_list *cdl = &ctx->host->context_list;
+	struct host1x_context_mapping *m;
+	struct host1x_bo_mapping *bo_m;
+
+	m = kzalloc_obj(*m, GFP_KERNEL);
+	if (!m)
+		return ERR_PTR(-ENOMEM);
+
+	m->host = ctx->host;
+	m->bo = bo;
+	m->direction = direction;
+
+	mutex_lock(&cdl->lock);
+
+	if (ctx->hw) {
+		bo_m = host1x_bo_pin(&ctx->hw->dev, bo, direction, NULL);
+		if (IS_ERR(bo_m)) {
+			mutex_unlock(&cdl->lock);
+			kfree(m);
+
+			return ERR_CAST(bo_m);
+		}
+
+		m->mapping = bo_m;
+	}
+
+	list_add(&m->entry, &ctx->mappings);
+
+	mutex_unlock(&cdl->lock);
+
+	return m;
+}
+EXPORT_SYMBOL_GPL(host1x_memory_context_map);
+
+/**
+ * host1x_memory_context_unmap() - remove a buffer mapping from a memory context
+ * @m: mapping previously returned by host1x_memory_context_map()
+ *
+ * Unmap the buffer if it is currently mapped, and free the mapping.
+ */
+void host1x_memory_context_unmap(struct host1x_context_mapping *m)
+{
+	struct host1x_memory_context_list *cdl = &m->host->context_list;
+
+	mutex_lock(&cdl->lock);
+
+	list_del(&m->entry);
+
+	mutex_unlock(&cdl->lock);
+
+	if (m->mapping)
+		host1x_bo_unpin(m->mapping);
+
+	kfree(m);
+}
+EXPORT_SYMBOL_GPL(host1x_memory_context_unmap);
+
+/**
+ * host1x_memory_context_inactive() - mark a memory context as no longer in use
+ * @ctx: memory context
+ *
+ * Drop one active reference taken by host1x_memory_context_active(). When the
+ * last active reference is dropped, the backing hardware context becomes
+ * eligible to be stolen by another context, and any waiters are woken.
+ *
+ * Must be called exactly once for each successful
+ * host1x_memory_context_active().
+ */
+void host1x_memory_context_inactive(struct host1x_memory_context *ctx)
 {
-	refcount_inc(&cd->ref);
+	struct host1x_memory_context_list *cdl = &ctx->host->context_list;
+	struct hw_alloc_waiter *waiter;
+
+	mutex_lock(&cdl->lock);
+
+	if (refcount_dec_and_test(&ctx->hw->active)) {
+		/* Hardware context becomes eligible for stealing */
+		list_for_each_entry(waiter, &cdl->waiters, entry) {
+			if (!hw_usable_for_dev(ctx->hw, waiter->dev))
+				continue;
+
+			complete(&waiter->wait);
+
+			/*
+			 * Need to wake up all waiters -- there could be multiple from
+			 * the same process that can use the same freed hardware context.
+			 */
+		}
+	}
+
+	mutex_unlock(&cdl->lock);
+}
+EXPORT_SYMBOL_GPL(host1x_memory_context_inactive);
+
+/**
+ * host1x_memory_context_get() - take a reference to a memory context
+ * @ctx: memory context
+ */
+void host1x_memory_context_get(struct host1x_memory_context *ctx)
+{
+	refcount_inc(&ctx->ref);
 }
 EXPORT_SYMBOL_GPL(host1x_memory_context_get);
 
-void host1x_memory_context_put(struct host1x_memory_context *cd)
+/**
+ * host1x_memory_context_put() - release a reference to a memory context
+ * @ctx: memory context
+ *
+ * Drop a reference taken by host1x_memory_context_alloc() or
+ * host1x_memory_context_get(). When the last reference is dropped the context
+ * is detached from its hardware context and freed.
+ */
+void host1x_memory_context_put(struct host1x_memory_context *ctx)
 {
-	struct host1x_memory_context_list *cdl = &cd->host->context_list;
+	struct host1x_memory_context_list *cdl = &ctx->host->context_list;
 
-	if (refcount_dec_and_mutex_lock(&cd->ref, &cdl->lock)) {
-		put_pid(cd->owner);
-		cd->owner = NULL;
+	if (refcount_dec_and_mutex_lock(&ctx->ref, &cdl->lock)) {
+		if (ctx->hw) {
+			list_del(&ctx->entry);
+
+			host1x_memory_context_hw_put(ctx->hw);
+			ctx->hw = NULL;
+
+			WARN_ON(!list_empty(&ctx->mappings));
+		}
+
+		put_pid(ctx->pid);
 		mutex_unlock(&cdl->lock);
+		kfree(ctx);
 	}
 }
 EXPORT_SYMBOL_GPL(host1x_memory_context_put);
diff --git a/drivers/gpu/host1x/context.h b/drivers/gpu/host1x/context.h
index 3e03bc1d3bac..30d3876f27f4 100644
--- a/drivers/gpu/host1x/context.h
+++ b/drivers/gpu/host1x/context.h
@@ -17,8 +17,24 @@ extern struct bus_type host1x_context_device_bus_type;
 
 struct host1x_memory_context_list {
 	struct mutex lock;
-	struct host1x_memory_context *devs;
+	struct host1x_hw_memory_context *devs;
 	unsigned int len;
+	struct list_head waiters;
+};
+
+struct host1x_hw_memory_context {
+	struct host1x *host;
+
+	refcount_t ref;
+	struct pid *owner;
+
+	struct device_dma_parameters dma_parms;
+	struct device dev;
+	u64 dma_mask;
+	u32 stream_id;
+
+	struct list_head owners;
+	refcount_t active;
 };
 
 #ifdef CONFIG_IOMMU_API
diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/channel_hw.c
index 2df6a16d484e..8a85b3c2f9b5 100644
--- a/drivers/gpu/host1x/hw/channel_hw.c
+++ b/drivers/gpu/host1x/hw/channel_hw.c
@@ -12,6 +12,7 @@
 #include <trace/events/host1x.h>
 
 #include "../channel.h"
+#include "../context.h"
 #include "../dev.h"
 #include "../intr.h"
 #include "../job.h"
@@ -89,7 +90,7 @@ static void submit_setclass(struct host1x_job *job, u32 next_class)
 	 * firmware stream ID.
 	 */
 	if (job->memory_context)
-		stream_id = job->memory_context->stream_id;
+		stream_id = job->memory_context->hw->stream_id;
 	else
 		stream_id = job->engine_fallback_streamid;
 
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index 1f5f55917d1c..07f7dd6fb4dd 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -458,13 +458,25 @@ int host1x_client_resume(struct host1x_client *client);
 struct host1x_memory_context {
 	struct host1x *host;
 
+	struct device *dev; /* Owning engine */
+	struct pid *pid;
+
 	refcount_t ref;
-	struct pid *owner;
 
-	struct device_dma_parameters dma_parms;
-	struct device dev;
-	u64 dma_mask;
-	u32 stream_id;
+	struct host1x_hw_memory_context *hw;
+	struct list_head entry; /* Entry in hw_memory_context's list */
+	struct list_head mappings; /* List of mappings */
+};
+
+struct host1x_context_mapping {
+	struct host1x *host;
+
+	struct host1x_bo_mapping *mapping;
+
+	struct host1x_bo *bo;
+	enum dma_data_direction direction;
+
+	struct list_head entry;
 };
 
 #ifdef CONFIG_IOMMU_API
@@ -473,6 +485,12 @@ struct host1x_memory_context *host1x_memory_context_alloc(struct host1x *host1x,
 							  struct pid *pid);
 void host1x_memory_context_get(struct host1x_memory_context *cd);
 void host1x_memory_context_put(struct host1x_memory_context *cd);
+int host1x_memory_context_active(struct host1x_memory_context *cd);
+void host1x_memory_context_inactive(struct host1x_memory_context *cd);
+struct host1x_context_mapping *host1x_memory_context_map(struct host1x_memory_context *ctx,
+							 struct host1x_bo *bo,
+							 enum dma_data_direction direction);
+void host1x_memory_context_unmap(struct host1x_context_mapping *m);
 #else
 static inline struct host1x_memory_context *host1x_memory_context_alloc(struct host1x *host1x,
 									struct device *dev,
@@ -488,6 +506,26 @@ static inline void host1x_memory_context_get(struct host1x_memory_context *cd)
 static inline void host1x_memory_context_put(struct host1x_memory_context *cd)
 {
 }
+
+static inline int host1x_memory_context_active(struct host1x_memory_context *cd)
+{
+	return -ENODEV;
+}
+
+static inline void host1x_memory_context_inactive(struct host1x_memory_context *cd)
+{
+}
+
+static inline struct host1x_context_mapping *
+host1x_memory_context_map(struct host1x_memory_context *ctx, struct host1x_bo *bo,
+			  enum dma_data_direction direction)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void host1x_memory_context_unmap(struct host1x_context_mapping *m)
+{
+}
 #endif
 
 #endif

-- 
2.53.0

