Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41026606A330
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sMLw28aE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7293B112119;
	Thu, 12 Nov 2026 12:59:23 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8928E11210D;
 Thu, 12 Nov 2026 12:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yO4QZfNwecywWYAX9IO5fTTrKe+xlECSKFvpdc9hUviCSbdCWE4QLRVLCF/hzDuqV21YFXa51H44U0rdylayCZZRCmswSo4ATXddxFBPYxGP5iFAK/+PABaqdIwbdhFaziKsxn70h0a+YMwUl/e23G6C8tqZq0h4YJLJm99oLyy4ynkPsogjvg3fh1sQ6QUS5f/+TfLsCjiBj95+whjrgajdedEROPywLOMJdpEg25JY/i+X8c4kI+pLkieNsgpYLX46hFHSory23bbK1Frja1bRFbEogLlw/GH6bTCpCgOOWtFQ16bKQ3sOX57Y6TP5duzo4YcP5VcQiKMoh+TLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFslsDgRwmBp86bYFvapdkEadzdtuev1jB06ZxRfm+Q=;
 b=qubeDc3NFcyNKNacsFLNYmFpjAt5muuSV+aRTQmsins3kObivk5eNFH8iBZcIdPqZJ+Asvs3tKTUOvAas+dEf2NP7Xl4S4fy9y7hvfk7Dj2tWQLnQP2FZXn9eZR3AW3RNf6eY8T3jWE+iEfdSMNPoll71dNbUe73Duk7icdSZqyAVMs+azpnqbmoQCGH1S/K8gYu7/xK+EwfSLYrfDPdte5ao15aTLVmylPgJ71JRT0PK1f98xGg4Uyhi/sT70wOeKeZyykX9YppXKp15DQV/aEcOKiT9PpVbV79Audwb8W55XLWwW6aJOnWnZbD89DzegQprytK9NlTrfUXnYoqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFslsDgRwmBp86bYFvapdkEadzdtuev1jB06ZxRfm+Q=;
 b=sMLw28aEVa4buyHOlScKC1rPHpW8FqZuFBoPNjt7SM6qMFow/82nApkq3QGru1fcqAQ3SBORHY+NiO0kpjCnjX76jL+0sd4Pkhv0EMs4tJ6FZMC9uICKoO+uSI/Y4lskZbJyum344bLQ+QZOp0bbkfyNThSbHKuBafHSqoSTFis=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 12:58:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 12:58:25 +0000
Message-ID: <007c58e6-9af5-4d42-b307-0827df55fbb4@amd.com>
Date: Thu, 12 Nov 2026 13:58:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: increase 64-bit mmap_range size to 8TB
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20261112122049.1990826-2-matthew.auld@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261112122049.1990826-2-matthew.auld@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: f128cf95-73bc-483d-072b-08df40bca384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|261009221227099003|261009223027099003|56012099006|11063799006|261028144727099003|261102123227099003|261021121427099003|261026140227099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: LJhc/+JsOtzNYJjJCS50hca7FNNhn9BtBSTrUAPnbYOWbaY3ETA2JrCc7B0dHQIA4pqcTyuqGp98QtPNzOoA6xyGY45pXYY1+i3Est8JhCzt8NDWQk30LkT3Cw7mZhPXhK2FfsCdHS/HIQGxer/ZmaXdza51v58pBoG0yrNvUM/RYLKXwZbss9RHfpidx4cDHA9x4bfQCRiTygQt1Dc8UBIPTE7frEXfM//yGSErzFwC64S/T6VbujQHFqZVtgDdA+7Z61srQ7W4wOupZ/7Z/qbKfdKmHhENp0tNugpe8BdHrRkqRrx+kwjSyQAnRIdm1EmDDPgKajGg7gMh6fDSsO7DjQuWSPD7WfIoIF67YYIhqDUUenhtSBBCaqEkji/qw3t9iyUw48U/9E44jxxEN+TMdiZ5d5tACQvTHh+Lm/P3/cbgljrszKYsNp8u5LNO6sS8la+5JAlfgP00XBrEC/9dhnHArPgAa8vU3jMfd9t4MzdxdK/ofP/zzmgGk3sU6lYnHfeqG92QlcFWapp/i8nu/cehFmEF4uYFygdGLrRytJymPTVAlENwV/zJGo6Ulh3oXW2XjQQpiz9q9X79392en01d7XPYKsHBudMYcD4gJIMGime+vbXbtt6RBUgXncS1efhjXA1EMeEyJwqAAV9gEIWgbB4M4B+abw4/M80=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(261009221227099003)(261009223027099003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261021121427099003)(261026140227099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnBkUmtGb2FMd05xNHdRNHJmZ0k4dEFSUlk0WTZyNEhkOGRJaitYTHZ3VGNm?=
 =?utf-8?B?S3ZGdnRCMzdoWWR3UXdLTlAwVngzMGpqN09WVTRMb01DVmVDdWdPVGVZc1FJ?=
 =?utf-8?B?U1RpT0h5T2dqMHhneHpVd2lLR2g0Y08wNENlVDhvdmVOWWMzMCtrL3VtY2Nr?=
 =?utf-8?B?V1N0dWQxcVJJcStHT2NpSExIaE4zSW9BZWtWZjF0TlBFUWV6Vjg2aytTMHJK?=
 =?utf-8?B?b25ta1VqUWNSd2FhUmlFTjJucGJFMGlzTExyUm84V1AvNTN2cllOT2s3Q2xW?=
 =?utf-8?B?S3l4eTFyMW5lNjgyckdUT2RuYnRKTkh2M3FxQ2VPUmtqU1RzVDN6NnRCWStm?=
 =?utf-8?B?VHJiaFBUKzR1ZnY2UElhR3k0Q3BBOEZWbFZPcERjczNhRGdVQXBKcDdwQ2pL?=
 =?utf-8?B?Yk5ISU1LYkNWYUY1RVlQdFlJMytmWlNPbTZmWndlV0F1SDBKK3V0NjUwM3Fw?=
 =?utf-8?B?Vk1TNzlSZmVTTXR5NTkwMmpqYllXSlZpb2ExZ2F6Si9lTG4wbEVoUVd5NFVw?=
 =?utf-8?B?VjJPNHlTaEhvT2F0MHZ1N0VqR0ZpcnV4VzF4UFM3bW43b3hnQ3NPcnFtanBN?=
 =?utf-8?B?U0Fuc2FPSlhCMFB2b2ZvNjMveUE4OHljRmNsL3NyVWFVOExQZGgyOE8xL3o0?=
 =?utf-8?B?cmFGa3pBbzJCeXR5dGliaXdITnVWV3dYMzFKQ2lPMUhPWG8wUnl2WnFNRXZW?=
 =?utf-8?B?ZUV1WUtiQ1NoMTk0NmpDWmlJWE1QWDlOa1UwYUpacWZHa3h3SStvb2ZsMFQ0?=
 =?utf-8?B?SkdLVWNoeGtoSWJpLytFaDJ1dzlHdXJGZzVQQ01hTWwxbkI3MmI3U1VmZEw2?=
 =?utf-8?B?TlVOVWxaUGxiaXNHVVRVNDhtbktxWWJubUFCMmZVMGJ2S1lmWHNtMUVtd244?=
 =?utf-8?B?bWtsaTVXU2gvbGdkSERBUmpWeENrTnluaEZFVmxLNlBtb05tZTlxcWZjWTkw?=
 =?utf-8?B?bFJZUGZOeVdrWWgyUGRQbVEva3Y1eGc5TGtyd1FyS0xBN3YwQThPczY4ZWds?=
 =?utf-8?B?eDJFS2Z6OGhwS3BnYkZZV2hLb29vcHJCWHNBUnMzeS9ucjVHeHNuT2gyUThs?=
 =?utf-8?B?OXhsb1UvQlZWOWRiMGxSMllVR3lYR2RmamFqaSszdDJaK29UWWV0N1N2MGIy?=
 =?utf-8?B?YUNxU0h5SGc0NFVZVCtHdk5Vb05SUkVQUXVyVjkvdjFoYi9sYjBjaXB5Y0tE?=
 =?utf-8?B?blM1TzVybWQ1V2xnbXNvdzFtYytjOUlYZVdjWVlrQWUyOG9QRnlvQ25DbGtq?=
 =?utf-8?B?dkJZUlBob3h1dEFCcVkzTDk2Mm4wM3o0SVBBaEUxQmY4K0VyWmxiaDlob1Rk?=
 =?utf-8?B?QVFYR0R6bWpvcHYweWIvRHdOdmMyVlROWXY0K2pkbm1PdzNCUklFdHh3dy9N?=
 =?utf-8?B?aDFRbmIxZ25COHFuenVaZGxHNldqWVQ5QVVCNEVqcjljQTB1YXNnZzBtVkdI?=
 =?utf-8?B?czZDNkJzanNjR1pmeXFkZW1tM29GTFpLNi9NcFdTUWp6ajd4cHc5K2FLUVVP?=
 =?utf-8?B?TFhsTWRIdmtCS2xaNzNqK1lOV1lGSUtLYU9rcmhvRXU3eHNNNEtrb242VXZr?=
 =?utf-8?B?RWwyRFcvVVRiYlVJQmMranVpVk5EekM1R0VJdzl2c1lpck5LbHVDdjB6aVkw?=
 =?utf-8?B?eG1FYWtmeExzVXBNMlpSVUJFa3FsbXdLcXNDMmJRVEx0bm1DUXV0ZmRuaFg3?=
 =?utf-8?B?ZXlPcldyNWVBU1RxR3ljS0xPd1cyWXFwSENMRWN6Q2kralppNm56MmNpNlh5?=
 =?utf-8?B?eTR6bjVMc2JraE5wRWpId1JtMityN1RYMm9YeDR6WGpUS1M5ZW1LR01pdEhJ?=
 =?utf-8?B?b25HdVVqZlY3OUxKWXFrUHhKbHRSQXp6V0J3dHlnc2czaDRDZkdCZG1xd3Zo?=
 =?utf-8?B?dnByMjhWVGtzNlJ3UkRwQWVKVkx5UFRzaHNYb2hOaVdydFB6dERHN2I5YzBK?=
 =?utf-8?B?Q1dIMWkwWjArWE8zYkI1VzkranB3R0xVZWVzSm1jSWtRYXlpUXpKeHVaNUZH?=
 =?utf-8?B?SmVCUjJJREdpTTFFb1dYZzc2OE5vNHhrU3JxT1c3SmdIajl6MDArMmxpRmt2?=
 =?utf-8?B?Ynp3U0NtZURmZjZrNEVqSUFGR2dNV2FXWHRCa3lsdk80WXV3cFRWbXZGVVNh?=
 =?utf-8?B?UzRFbGRmc0krL21tb3FidGgybE5mak9va3M4L1grUVZVSVExa25WOWlncjRk?=
 =?utf-8?B?WDVpUFJJYnBkZnk3K1ZvdTlRVHI5dmIzOXpVTUlwVFpvaTQrc29CZEh4azdt?=
 =?utf-8?B?ZGpSeVBzZytTdHY0V0k3UG0ySVE2Lzk4bkdJVGdNSC9oUUZFaUxzeUo5T3Fa?=
 =?utf-8?Q?wG+fJ0GqC3iRNV6Q5o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f128cf95-73bc-483d-072b-08df40bca384
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:58:25.3968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/Mm6OSbWplfXl2YMgFsV7HJycOe41FxJnQBrdY0rSgMVXUCmHjAKw5Yh6mQ5wpY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 13:20, Matthew Auld wrote:
> Every GEM/TTM buffer object, including imported dma-bufs, allocates a
> fake mmap offset from the per-device drm_vma_offset_manager. On multi-GPU
> systems with large VRAM, peer-to-peer dma-buf imports across devices and
> processes can exhaust the current 1 TiB 64-bit range and fail BO creation
> or PRIME import with -ENOSPC. Skipping mmap offset allocation for
> imported sg buffers is not straightforward without risking userspace
> regressions, as existing userspace (such as Intel compute-runtime) still
> queries mmap_offset on imported host dma-bufs even when mapping the
> dma-buf fd directly.

I was just about to ask why the heck we grab mmap offsets for imported DMA-bufs :)

> Increase DRM_FILE_PAGE_OFFSET_SIZE on 64-bit kernels so the fake offset
> range spans up to 8 TiB (SZ_8T). This stays strictly below panthor's
> DRM_PANTHOR_USER_MMIO_OFFSET_32BIT (1ULL << 43) carveout and within
> 32-bit compat mmap2's pgoff limit (16 TiB with 4K pages).
> 
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  include/drm/drm_vma_manager.h | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/drm/drm_vma_manager.h b/include/drm/drm_vma_manager.h
> index 6c2a2f21dbf0..2c3233f9dec4 100644
> --- a/include/drm/drm_vma_manager.h
> +++ b/include/drm/drm_vma_manager.h
> @@ -26,16 +26,23 @@
>  #include <drm/drm_mm.h>
>  #include <linux/mm.h>
>  #include <linux/rbtree.h>
> +#include <linux/sizes.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  
> -/* We make up offsets for buffer objects so we can recognize them at
> +/*
> + * We make up offsets for buffer objects so we can recognize them at
>   * mmap time. pgoff in mmap is an unsigned long, so we need to make sure
> - * that the faked up offset will fit
> + * that the faked up offset will fit.
> + *
> + * On 64-bit, cap the range at 8 TiB (SZ_8T) so offsets remain below both
> + * panthor's DRM_PANTHOR_USER_MMIO_OFFSET_32BIT (1ULL << 43) and 32-bit
> + * compat mmap2's pgoff ceiling (16 TiB with 4K pages).
>   */
>  #if BITS_PER_LONG == 64
>  #define DRM_FILE_PAGE_OFFSET_START ((0xFFFFFFFFUL >> PAGE_SHIFT) + 1)
> -#define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFFUL >> PAGE_SHIFT) * 256)
> +#define DRM_FILE_PAGE_OFFSET_SIZE ((SZ_8T >> PAGE_SHIFT) - \
> +				   DRM_FILE_PAGE_OFFSET_START)
>  #else
>  #define DRM_FILE_PAGE_OFFSET_START ((0xFFFFFFFUL >> PAGE_SHIFT) + 1)
>  #define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFUL >> PAGE_SHIFT) * 16)

