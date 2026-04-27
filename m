Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A808DFF8864
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D6F10E98D;
	Mon, 27 Apr 2026 22:20:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kavlgKA8";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010052.outbound.protection.outlook.com
 [40.93.198.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D718F10E98B;
 Mon, 27 Apr 2026 22:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXSvVWvQOxk7VhtbWV2rKAoILgPfVd95pRHv90/b0OivuKYfv8u3P6SXd7npkq5jYuWSVt4I3HNuDsgQ+ezIVSSWIOww4muqXb/nhCyKdsesggD2N0HWRzNN1aJPBtnQn06+q+MhxolUMp3lBNWLrilUfcIvTcHHq//isARG9dNshNpo4+Xe47a6ynrqUqkzijM7mYDr3ENBKb/6Ak9b2Sv9isn3E5Ek/Rk8V/tEQDW38JVLNGAdTjjP+G5s6Yz4aTrH8p2BhAUQGD2wi4p7jhNqTJ6c+NCnq/rrlov91b1g+Wir2aa/7Ur7DpRvUfXdFMec21hZFFAdD/JbYRUJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSSVyh3rDAZLenSi6Sjitr6B/+OB5zSr0L4yfD9rf3Y=;
 b=ZkrzOW6viqIyY7gSIgb5czyrYcDCsnQ6wftC5b6jmAoM9olw4hXMks9Q0j7Z6dg4zLdxAEdV8hefxBrca4cdge4cMRGRGN7Uhs2aBvzEDwR38DwptCXJIXK8q+jVQKVa9/zQVquAYrPPYoKJV/n4M3CvbkKu9UvBvPBPCyxevvKWdthXXJOUVdP5+X/0FRe/um9el5r4Ffax2JEaWrCbfGNFf5HBZAUSXb6Qh+VrNMvX4mEiKEuHYdXik19SXy9y5bgqu1tsp+RhSn8rXyGB580lz2xfVAXeP4JIrMQRTxLqy/ye+Ulen7HR6zmatXqOjvcKgCd6iqMy9p0lAFRNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSSVyh3rDAZLenSi6Sjitr6B/+OB5zSr0L4yfD9rf3Y=;
 b=kavlgKA8oJFZ9OrI4Ig8ZjnUJG5Fzpo1sX6w8HFQwBXSh+nfLFQMAjjzpQ0u2ce1OFttlySQSosVjz3SeO+6O5NMqVTpJAOEuW9jOHRwLT6hoN4qEdI69UcXsuHisXArNNFT27Anr6re+cp0EpYgQRGVDd2gze5Ov2OfkYlUGKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 22:20:35 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27%6]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 22:20:34 +0000
Message-ID: <9d223506-c424-4519-a3d5-e729468d88f5@amd.com>
Date: Mon, 27 Apr 2026 18:20:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm/amdgpu: implement drm_pagemap SDMA migration
 callbacks
To: Junhua Shen <Junhua.Shen@amd.com>, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 honglei1.huang@amd.com, Lingshan.Zhu@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260427100522.7014-1-Junhua.Shen@amd.com>
 <20260427100522.7014-3-Junhua.Shen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260427100522.7014-3-Junhua.Shen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0214.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::21) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f07f8c6-04b4-4696-01bb-08dea4ab3361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: 0sQmi6MynbbeLFP0Xo2XDMTgnGBx0vdgkj33U/q38pQGw9ULljtnQoM9vlbpLquvN2bqaw/AmHSu6t4FEc6lqa4xdZzymmYSIIkCL1pS1+6TxPXrJAv5ZKcKd0KXexFRYyo1SQmvQ8Zr5CUatefEzphrdNFwmfN67YlZs1ynYoLnSIhXKcgNn8KMVNmP59ivgAh9aTXuG7q7nkGOZh0xGp9O6NQbAfT90qja86xKctXYV8mFmi54yMxGCziqMILPmV2s2nBK6ACT1TSomf5XWiUQ9FTtbgW7vui+ahq6kLiyohCOOYCt9FKz5ys6CcqAyOIFbZbqE7nuj6pZQnC0/i19Lv46dVRU9NGlNW9DnqSn1fQT/V8moDRwSfLbra2rv3dYzo4hZczS3r/q/vne9vjK5D4Q7WVU4lVwWHKB/kemYPe83m9R3/vMWgX+Ea1ak9/kXr+NxOE8yB367X9HBPjnSHESwE4Yukm4TQ2+Iqvf3pYIdH13ky5BgHpDdlxoVtKBmQAmDNSHRKJWa9d73pUiO25goKOl1mBupJZUSuhNmAFPf/v2KzRScOJZ7OHUnCA6ZqRgPJOvYe2xZ+D0pjncUKd7OeF5g/bAxSskP8MntODagIXJn1PtLDQCoy/G2PwbTLlmKfoQ8MAXSPIdkxrGsdlKM3x9oc4krkDyJ/imwrLXsaR0CPRNCiH34E5iLF+EnTZnLIoXUS4eafSofOPEiD8VnI07PN8ma5jb+IebrKG/eNx72COH3qNrQX4ZrE3HfWf2NLBXdO1nBo0gRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWxPN0orZXJqNWxWMkpHRi84Ymw0TFJaTmVydHNUOEdCazRGVjY0cTdrcTVJ?=
 =?utf-8?B?QW9CQlNkOUhFUlQrdkp3Rm4vYTI3UFBXSmc2Rk03TjIvQ3V2cytwdzFGZW14?=
 =?utf-8?B?TkdQMGgvZ0tmU1hMUUVNaEMzVmVoR0NyM3BXNFk5a01iV1dBd2g2b1dmKzRk?=
 =?utf-8?B?NlBhdkdCWjBkRTJSUWlnT2Uxdmk4ZnlxR0Y5aTFRMkIvNHBZTHc5QUcrS21J?=
 =?utf-8?B?VXVCWm1sOGFhVDVvVnFmZGZHeGFKV3VVUTlMRVZWc0JleDQvd2d5VU5yWDZY?=
 =?utf-8?B?b0R1ZEdGQnpHYWVrMjBNaCsxekR2NHpIT0hiUmQydXM4QXd0UjlyWmJSWEt1?=
 =?utf-8?B?cFBDeXIxbDdZQmoxNHN6Y0VkeFE0bXRSQnZKLytLSzBpV2xyLzJiQkEwbVo5?=
 =?utf-8?B?bllvTzRLQldhVUp5Q2pYMFE1YTJyclpnYXVCaW0reHk2TWd0aUR1bDZnSkR0?=
 =?utf-8?B?ak1DV1dwQU9BTXl0RWxrV1pwRHliK0xzRUJVZjlGWlJvYzlEemFWd0VpVmxk?=
 =?utf-8?B?dm0welZCUWVRcHdGN1VoUmUwSW5qbnRqZE9aUE1jZjRIMG4rOUI3S3owZlhX?=
 =?utf-8?B?N3gvQTZsaVFQZ3BRNHBNOEdTQnZOZXNIY2dqVWY2VnZpbEUrM1VHblJBSnJp?=
 =?utf-8?B?ZTAzZXhtQnRDRjlIak5WUWlWRjVzbFkzMER5MTVOSGlqbHgyTGhsQ1hDeEJI?=
 =?utf-8?B?OG5rYVVxdDNuWGVwZDNYV0JrL0hwZ01tZngrWERvOGd6WGVDb0dXWTZFSll0?=
 =?utf-8?B?K0dFL1JMMnFlY29QTHFLL05qUjdtRFZYUzgwM2Y5VEtMeE5rVWsrRHhLWS9O?=
 =?utf-8?B?bUZSWEg2UGN3RTAxZDZURnBLOENCZWhOd3BXOFo5WDVGTFNHN1pkNHBOVjQ3?=
 =?utf-8?B?SE9IdEdZQWVCMWgvUmNmTjFZNGUxamFyRCt6dUVCZmRGalp3b29uUkxZdHhY?=
 =?utf-8?B?OGc1QzZFSTRaU2dqSHNtUDVKeklzQ2pZY0p3NEJVczZQbCtMdkxwMElGMEpO?=
 =?utf-8?B?ZkNjeFBaNDlKVkFXSWhuYnBFU3dLeDlZUDA1U0VSeDNiSkRBK1Avc2JNQzB3?=
 =?utf-8?B?aFRUYU41QzUxMW9hbk9JUms3bDlNcmgvWG1BSW9iYkp3MW5TNFpwZXcwcnAr?=
 =?utf-8?B?MzhQNWF2NmJtMHR0N2FvdHZOWGVWc1FBNnFycVZVdTdDQy9wNHJRdDlndEl5?=
 =?utf-8?B?dEIvOWp2MHIzR3NqS0h6czMrdFo5ZTVwL2xZOWlXRm9Zc3l4QkdsYUhCeHlS?=
 =?utf-8?B?alRESmorU1djNnphSkJRQldqTm5UTDUybWg4S0RYZGt0Q2ZibVI5ZkVpUER3?=
 =?utf-8?B?bW9jRGFiemRZcjE5SUhuR0U0ZlhKcDJqUXQvVy9sVFlLLzZNRVRWSzdrUUxx?=
 =?utf-8?B?dVNieUJSeWZaUXd5QlVYOThzUzF1ejJtUFRuQzZVSnhIbm9Fbyt1MWtkRHNC?=
 =?utf-8?B?aXdzU08xOENDelQ0dlVkNEhmWmV5RGZDOGNJaFNUUUFwNGZuQnZqQkhzOUxR?=
 =?utf-8?B?OStINzVWaWR6aHBZUDRaTER2U1ZrYmtOL0l6YUxoSThjRm9vQW9WT2tHTDR2?=
 =?utf-8?B?dWp3ZzA2WWNUMVlFem1CRVBDcVp3S3UrRHVFS3h2NzFLQ0hnMUFPRkZNWWpK?=
 =?utf-8?B?NDJSK1dxS2dDYzVrWjNxbzRiSjlzV1QyVkdNYTU5MDlIS0NWblJnaHRTb2Zr?=
 =?utf-8?B?ZFg3WFd6WDRqVzJaQkFVSExoUFhVZU5UMGVXaW4vYmNWandyRy9jZkdIM0t3?=
 =?utf-8?B?OWg4d2pnREdpbWVQUDNQazhzdmFScDRFZ1RsbnJUOURQRUpTdlN3RFZyM1BH?=
 =?utf-8?B?QXJhTlJDWTVVYlNYRG5lQTlMTTJWeG9yOG1FSlpZVnhSK3g3Q3BEK0lpZVFX?=
 =?utf-8?B?dG1GNTlZakZYUDRIWmxoVkt6VzRmakVOTDNHMDFSQU8wZUx2NDVuajZaOGdO?=
 =?utf-8?B?clRxYmd1WElUbEF6Kyt4YVJEMEpVczFwMjh0bDhrSXhpZXpMRDVHaVB6VFhu?=
 =?utf-8?B?c2xNVExqWVRqUEpvTk5hUC9uNDJIK3FjUkM5ZUJlVmVnalpoM3hzVjJ0VUxS?=
 =?utf-8?B?M05ZR2ZobnRGYTAxTmdEeHlSVUduWU9ZeXMxbmJJOVgzSmxMa29ZSFlnSUVs?=
 =?utf-8?B?aEVWWlJhNFhOWDhQbzZkdjR2Nk1VQ1I4b1ZhWCtIT0U1bkYzOTlRd2FtWlNS?=
 =?utf-8?B?K2V5amh2cWQ0cWFMOVcrYm03ZDI5SEdtNjlmVlFPbE1aV04xQldLSDZKa0pL?=
 =?utf-8?B?YXQ2SUVkejBzdUd1b2pyR2xOMWtYcWN1c1dUWW1YQU9SWGRHK1MwazN1UnUw?=
 =?utf-8?B?eXRlb2k3TW9xRVJyY3lkVHYyclRaWC91dEdMQ2RMUHpRRnNLTnE2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f07f8c6-04b4-4696-01bb-08dea4ab3361
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 22:20:34.7359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W137y/0rYnc3EoWMJlP8Rtbl4zfvHrgqSSPgwlcqv2qmNo1UOhowc5r3FaiPjRTBLhPxcyNzLba4EQ8IINEzkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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


On 2026-04-27 06:05, Junhua Shen wrote:
> Implement the drm_pagemap_devmem_ops and drm_pagemap_ops callbacks
> that the DRM GPUSVM migration framework requires:
>
> drm_pagemap_ops (top-level entry points):
>    - device_map:   convert ZONE_DEVICE page to GPU PTE address
>    - populate_mm:  allocate VRAM BO and trigger migration
>
> drm_pagemap_devmem_ops (per-BO migration mechanics):
>    - populate_devmem_pfn: walk BO buddy blocks to build PFN array
>    - copy_to_devmem:      SDMA copy system RAM -> VRAM via GART window
>    - copy_to_ram:         SDMA copy VRAM -> system RAM via GART window
>    - devmem_release:      free BO when all pages migrate back
>
> Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 616 +++++++++++++++++++-
>   1 file changed, 613 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
> index 170e2eadc106..42092651b4d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
> @@ -64,12 +64,20 @@
>   #include <linux/memremap.h>
>   #include <linux/migrate.h>
>   
> -#include "amdgpu_amdkfd.h"
>   #include "amdgpu_migrate.h"
>   #include "amdgpu.h"
> +#include "amdgpu_ttm.h"
> +#include "amdgpu_res_cursor.h"
> +
> +#define AMDGPU_MIGRATE_TRACE(fmt, ...) \
> +	pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
> +
> +/* SDMA copy direction */
> +#define FROM_RAM_TO_VRAM	0
> +#define FROM_VRAM_TO_RAM	1
>   
>   static inline struct amdgpu_pagemap *
> -dpagemap_to_apagemap(struct drm_pagemap *dpagemap)
> +to_amdgpu_pagemap(struct drm_pagemap *dpagemap)
>   {
>   	return container_of(dpagemap, struct amdgpu_pagemap, dpagemap);
>   }
> @@ -94,8 +102,610 @@ amdgpu_svm_page_to_apagemap(struct page *page)
>   	return container_of(pgmap, struct amdgpu_pagemap, pgmap);
>   }
>   
> +/* drm_pagemap_devmem_ops — per-BO migration mechanics */
> +
> +/**
> + * struct amdgpu_svm_bo - Wrapper linking drm_pagemap_devmem to amdgpu_bo
> + *
> + * @devmem: drm_pagemap device memory allocation (passed to framework)
> + * @bo: The backing VRAM amdgpu_bo
> + *
> + * It is allocated per-migration in populate_mm() and freed by
> + * devmem_release() when all device-private pages have migrated
> + * back to system memory.
> + *
> + * Lifecycle is managed by the drm_pagemap framework's internal zdd refcount:
> + *   - zdd->devmem_allocation points to &svm_bo->devmem
> + *   - When zdd refcount drops to zero, framework calls devmem_release()
> + *   - devmem_release() frees both the BO reference and the svm_bo itself
> + */
> +struct amdgpu_svm_bo {
> +	struct amdgpu_bo *bo;
> +	struct drm_pagemap_devmem devmem;
> +};
> +
> +static inline struct amdgpu_svm_bo *
> +to_amdgpu_svm_bo(struct drm_pagemap_devmem *devmem_allocation)
> +{
> +	return container_of(devmem_allocation, struct amdgpu_svm_bo, devmem);
> +}
> +
> +/**
> + * amdgpu_svm_devmem_release - Release BO when all device pages migrate back
> + *
> + * Called by the drm_pagemap framework (via drm_pagemap_zdd_destroy) when the
> + * last device-private page backed by this allocation has been migrated back
> + * to system memory (or the owning process exits).
> + *
> + * Frees both the amdgpu_bo reference and the wrapper amdgpu_svm_bo itself.
> + */
> +static void
> +amdgpu_svm_devmem_release(struct drm_pagemap_devmem *devmem_allocation)
> +{
> +	struct amdgpu_svm_bo *svm_bo = to_amdgpu_svm_bo(devmem_allocation);
> +
> +	AMDGPU_MIGRATE_TRACE("Release svm_bo=%px bo=%px\n", svm_bo, svm_bo->bo);
> +	amdgpu_bo_unref(&svm_bo->bo);
> +	kfree(svm_bo);
> +}
> +
> +/**
> + * amdgpu_svm_populate_devmem_pfn - Convert BO VRAM allocation to PFN array
> + * @devmem_allocation: The devmem allocation in the amdgpu_svm_bo wrapper
> + * @npages: Number of PFN entries to fill
> + * @pfn: Output PFN array
> + *
> + * Iterates over the BO's TTM vram_mgr buddy blocks and converts each
> + * block's VRAM offset to ZONE_DEVICE PFNs:
> + *
> + *   PFN = PHYS_PFN(block_offset + apagemap.hpa_base) + page_index
> + *
> + * This is called by drm_pagemap_migrate_to_devmem() to build the
> + * destination PFN array for migrate_vma_pages().
> + *
> + * Return: 0 on success
> + */
> +static int
> +amdgpu_svm_populate_devmem_pfn(struct drm_pagemap_devmem *devmem_allocation,
> +				unsigned long npages, unsigned long *pfn)
> +{
> +	struct amdgpu_pagemap *svm_dm = to_amdgpu_pagemap(devmem_allocation->dpagemap);
> +	struct amdgpu_svm_bo *svm_bo = to_amdgpu_svm_bo(devmem_allocation);
> +	struct amdgpu_bo *bo = svm_bo->bo;
> +	struct amdgpu_res_cursor cursor;
> +	unsigned long i = 0;
> +	int ret;
> +
> +	ret = amdgpu_bo_reserve(bo, false);
> +	if (ret)
> +		return ret;
> +
> +	amdgpu_res_first(bo->tbo.resource, 0, npages << PAGE_SHIFT, &cursor);

How do you ensure that the BO is valid and actually in VRAM at the time? 
And how do you ensure that it stays there as long as the zone_device 
pages are in use? As far as I can tell, the BO is not pinned and there 
is no fence that prevents it from being evicted to GTT by TTM without 
warning.

Regards,
   Felix


> +	while (cursor.remaining && i < npages) {
> +		u64 pfn_base = PHYS_PFN(cursor.start + svm_dm->hpa_base);
> +		u64 pages = cursor.size >> PAGE_SHIFT;
> +		unsigned long j;
> +
> +		for (j = 0; j < pages && i < npages; j++, i++)
> +			pfn[i] = pfn_base + j;
> +
> +		amdgpu_res_next(&cursor, cursor.size);
> +	}
> +
> +	amdgpu_bo_unreserve(bo);
> +
> +	AMDGPU_MIGRATE_TRACE("populate_devmem_pfn: npages=%lu first_pfn=0x%lx\n",
> +			  npages, npages > 0 ? pfn[0] : 0);
> +
> +	return 0;
> +}
> +
> +/* SDMA copy helpers — GART window based data transfer */
> +
> +/**
> + * amdgpu_svm_direct_mapping_addr - Convert VRAM offset to MC address
> + * @adev: AMDGPU device
> + * @vram_offset: Byte offset within VRAM
> + *
> + * Return: MC address suitable for SDMA src/dst
> + */
> +static u64
> +amdgpu_svm_direct_mapping_addr(struct amdgpu_device *adev, u64 vram_offset)
> +{
> +	return vram_offset + amdgpu_ttm_domain_start(adev, TTM_PL_VRAM);
> +}
> +
> +/**
> + * amdgpu_svm_gart_map - Map system DMA addresses into GART window
> + * @ring: SDMA ring for the GART update job
> + * @npages: Number of pages to map
> + * @addr: Array of system memory DMA addresses
> + * @gart_addr: Output — GART base address to use in SDMA copy
> + * @flags: PTE flags (e.g. writeable for RAM-to-VRAM src)
> + *
> + * Builds GART PTEs pointing at the given DMA addresses, submits an
> + * SDMA job to update the GART entries, and returns the GART address
> + * that can be used as src or dst in a subsequent amdgpu_copy_buffer().
> + *
> + * Uses GART window 0, protected by gtt_window_lock.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int
> +amdgpu_svm_gart_map(struct amdgpu_ring *ring,
> +		     struct amdgpu_ttm_buffer_entity *entity,
> +		     u64 npages,
> +		     dma_addr_t *addr, u64 *gart_addr, u64 flags)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_job *job;
> +	unsigned int num_dw, num_bytes;
> +	struct dma_fence *fence;
> +	u64 src_addr, dst_addr;
> +	u64 pte_flags;
> +	void *cpu_addr;
> +	int r;
> +
> +	/* Use entity's GART window 0 */
> +	*gart_addr = amdgpu_compute_gart_address(&adev->gmc, entity, 0);
> +
> +	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> +	num_bytes = npages * 8 * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +
> +	r = amdgpu_job_alloc_with_ib(adev, &entity->base,
> +				     AMDGPU_FENCE_OWNER_UNDEFINED,
> +				     num_dw * 4 + num_bytes,
> +				     AMDGPU_IB_POOL_DELAYED,
> +				     &job,
> +				     AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP);
> +	if (r)
> +		return r;
> +
> +	src_addr = num_dw * 4;
> +	src_addr += job->ibs[0].gpu_addr;
> +
> +	dst_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
> +	dst_addr += (entity->gart_window_offs[0] >> AMDGPU_GPU_PAGE_SHIFT) * 8;
> +	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr,
> +				dst_addr, num_bytes, 0);
> +
> +	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> +	WARN_ON(job->ibs[0].length_dw > num_dw);
> +
> +	pte_flags = AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
> +	pte_flags |= AMDGPU_PTE_SYSTEM | AMDGPU_PTE_SNOOPED;
> +	if (flags & AMDGPU_PTE_WRITEABLE)
> +		pte_flags |= AMDGPU_PTE_WRITEABLE;
> +	pte_flags |= adev->gart.gart_pte_flags;
> +
> +	cpu_addr = &job->ibs[0].ptr[num_dw];
> +
> +	amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
> +	fence = amdgpu_job_submit(job);
> +	dma_fence_put(fence);
> +
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_svm_copy_memory_gart - SDMA copy between system RAM and VRAM
> + * @adev: AMDGPU device
> + * @sys: Array of DMA addresses for system memory pages
> + * @vram: Array of VRAM byte offsets (relative to start of VRAM)
> + * @npages: Number of pages to copy
> + * @direction: FROM_RAM_TO_VRAM or FROM_VRAM_TO_RAM
> + * @mfence: In/out — carries the last SDMA fence for serialization
> + *
> + * Maps system memory pages into the GART window and uses SDMA to copy
> + * data to/from VRAM. Handles splitting into AMDGPU_GTT_MAX_TRANSFER_SIZE
> + * chunks. Acquires entity->lock internally to protect the GART window,
> + * matching the KFD svm_migrate_copy_memory_gart() pattern.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int
> +amdgpu_svm_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
> +			    u64 *vram, u64 npages, int direction,
> +			    struct dma_fence **mfence)
> +{
> +	const u64 max_pages = AMDGPU_GTT_MAX_TRANSFER_SIZE;
> +	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> +	struct amdgpu_ttm_buffer_entity *entity = &adev->mman.move_entity;
> +	u64 gart_s, gart_d;
> +	struct dma_fence *next;
> +	u64 size;
> +	int r;
> +
> +	mutex_lock(&entity->lock);
> +
> +	while (npages) {
> +		size = min(max_pages, npages);
> +
> +		if (direction == FROM_VRAM_TO_RAM) {
> +			gart_s = amdgpu_svm_direct_mapping_addr(adev, *vram);
> +			r = amdgpu_svm_gart_map(ring, entity, size, sys,
> +						&gart_d, AMDGPU_PTE_WRITEABLE);
> +		} else {
> +			r = amdgpu_svm_gart_map(ring, entity, size, sys,
> +						&gart_s, 0);
> +			gart_d = amdgpu_svm_direct_mapping_addr(adev, *vram);
> +		}
> +		if (r) {
> +			dev_err(adev->dev, "failed %d to map GART for SDMA\n", r);
> +			goto out_unlock;
> +		}
> +
> +		AMDGPU_MIGRATE_TRACE("SDMA_COPY: %s npages=%llu vram_off=0x%llx\n",
> +				  direction == FROM_RAM_TO_VRAM ? "RAM->VRAM" : "VRAM->RAM",
> +				  size, (u64)*vram);
> +
> +		r = amdgpu_copy_buffer(adev, entity, gart_s, gart_d,
> +				       size * PAGE_SIZE,
> +				       NULL, &next, true, 0);
> +		if (r) {
> +			dev_err(adev->dev, "failed %d to copy buffer\n", r);
> +			goto out_unlock;
> +		}
> +
> +		dma_fence_put(*mfence);
> +		*mfence = next;
> +		npages -= size;
> +		if (npages) {
> +			sys += size;
> +			vram += size;
> +		}
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&entity->lock);
> +
> +	return r;
> +}
> +
> +/**
> + * amdgpu_svm_copy_to_devmem - SDMA copy system memory -> VRAM
> + * @pages: Array of destination ZONE_DEVICE pages (VRAM-backed)
> + * @pagemap_addr: Array of source DMA addresses (system memory, already mapped)
> + * @npages: Number of pages to copy
> + *
> + * Builds parallel sys[] and vram[] arrays from the framework-provided
> + * pagemap_addr and device pages, then submits batched SDMA copies via
> + * the GART window.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int
> +amdgpu_svm_copy_to_devmem(struct page **pages,
> +			   struct drm_pagemap_addr *pagemap_addr,
> +			   unsigned long npages,
> +			   struct dma_fence *pre_migrate_fence)
> +{
> +	struct amdgpu_device *adev;
> +	struct amdgpu_pagemap *svm_dm;
> +	struct dma_fence *mfence = NULL;
> +	dma_addr_t *sys;
> +	u64 *vram;
> +	unsigned long i, j;
> +	int ret = 0;
> +
> +	if (!npages)
> +		return 0;
> +
> +	/*
> +	 * Find the first non-NULL page to derive the device.
> +	 * The pages array may contain NULL entries for positions where
> +	 * no valid device page exists.
> +	 */
> +	for (i = 0; i < npages; i++) {
> +		if (pages[i])
> +			break;
> +	}
> +	if (i == npages)
> +		return 0;
> +
> +	svm_dm = amdgpu_svm_page_to_apagemap(pages[i]);
> +	adev = svm_dm->adev;
> +
> +	sys = kvcalloc(npages, sizeof(*sys), GFP_KERNEL);
> +	vram = kvcalloc(npages, sizeof(*vram), GFP_KERNEL);
> +	if (!sys || !vram) {
> +		ret = -ENOMEM;
> +		goto out_free;
> +	}
> +
> +	for (i = 0, j = 0; i < npages; i++) {
> +		if (!pagemap_addr[i].addr)
> +			goto flush;
> +
> +		sys[j] = pagemap_addr[i].addr;
> +		vram[j] = ((u64)page_to_pfn(pages[i]) << PAGE_SHIFT) -
> +			  svm_dm->hpa_base;
> +
> +		/* Check if next vram page is contiguous with current */
> +		if (j > 0 && vram[j] != vram[j - 1] + PAGE_SIZE)
> +			goto flush;
> +
> +		j++;
> +		continue;
> +flush:
> +		if (j) {
> +			ret = amdgpu_svm_copy_memory_gart(adev, sys, vram, j,
> +							  FROM_RAM_TO_VRAM,
> +							  &mfence);
> +			if (ret)
> +				goto out_fence;
> +			j = 0;
> +		}
> +		/* Re-process current page if it was valid but broke contiguity */
> +		if (pagemap_addr[i].addr) {
> +			sys[0] = pagemap_addr[i].addr;
> +			vram[0] = ((u64)page_to_pfn(pages[i]) << PAGE_SHIFT) -
> +				  svm_dm->hpa_base;
> +			j = 1;
> +		}
> +	}
> +
> +	/* Flush remaining batch */
> +	if (j)
> +		ret = amdgpu_svm_copy_memory_gart(adev, sys, vram, j,
> +						  FROM_RAM_TO_VRAM, &mfence);
> +
> +out_fence:
> +	if (mfence) {
> +		dma_fence_wait(mfence, false);
> +		dma_fence_put(mfence);
> +	}
> +
> +	AMDGPU_MIGRATE_TRACE("copy_to_devmem done: npages=%ld ret=%d\n",
> +			  npages, ret);
> +
> +out_free:
> +	kvfree(vram);
> +	kvfree(sys);
> +	return ret;
> +}
> +
> +/**
> + * amdgpu_svm_copy_to_ram - SDMA copy VRAM -> system memory
> + * @pages: Array of source ZONE_DEVICE pages (VRAM-backed)
> + * @pagemap_addr: Array of destination DMA addresses (system memory, already mapped)
> + * @npages: Number of pages to copy
> + *
> + * Mirror of copy_to_devmem with src/dst swapped.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int
> +amdgpu_svm_copy_to_ram(struct page **pages,
> +			struct drm_pagemap_addr *pagemap_addr,
> +			unsigned long npages,
> +			struct dma_fence *pre_migrate_fence)
> +{
> +	struct amdgpu_device *adev;
> +	struct amdgpu_pagemap *svm_dm;
> +	struct dma_fence *mfence = NULL;
> +	dma_addr_t *sys;
> +	u64 *vram;
> +	unsigned long i, j;
> +	int ret = 0;
> +
> +	if (!npages)
> +		return 0;
> +
> +	for (i = 0; i < npages; i++) {
> +		if (pages[i])
> +			break;
> +	}
> +	if (i == npages)
> +		return 0;
> +
> +	svm_dm = amdgpu_svm_page_to_apagemap(pages[i]);
> +	adev = svm_dm->adev;
> +
> +	sys = kvcalloc(npages, sizeof(*sys), GFP_KERNEL);
> +	vram = kvcalloc(npages, sizeof(*vram), GFP_KERNEL);
> +	if (!sys || !vram) {
> +		ret = -ENOMEM;
> +		goto out_free;
> +	}
> +
> +	for (i = 0, j = 0; i < npages; i++) {
> +		if (!pagemap_addr[i].addr || !pages[i])
> +			goto flush;
> +
> +		vram[j] = ((u64)page_to_pfn(pages[i]) << PAGE_SHIFT) -
> +			  svm_dm->hpa_base;
> +		sys[j] = pagemap_addr[i].addr;
> +
> +		/* Check if next vram page is contiguous with current */
> +		if (j > 0 && vram[j] != vram[j - 1] + PAGE_SIZE)
> +			goto flush;
> +
> +		j++;
> +		continue;
> +flush:
> +		if (j) {
> +			ret = amdgpu_svm_copy_memory_gart(adev, sys, vram, j,
> +							  FROM_VRAM_TO_RAM,
> +							  &mfence);
> +			if (ret)
> +				goto out_fence;
> +			j = 0;
> +		}
> +		/* Re-process current page if it was valid but broke contiguity */
> +		if (pagemap_addr[i].addr && pages[i]) {
> +			vram[0] = ((u64)page_to_pfn(pages[i]) << PAGE_SHIFT) -
> +				  svm_dm->hpa_base;
> +			sys[0] = pagemap_addr[i].addr;
> +			j = 1;
> +		}
> +	}
> +
> +	/* Flush remaining batch */
> +	if (j)
> +		ret = amdgpu_svm_copy_memory_gart(adev, sys, vram, j,
> +						  FROM_VRAM_TO_RAM, &mfence);
> +
> +out_fence:
> +	if (mfence) {
> +		dma_fence_wait(mfence, false);
> +		dma_fence_put(mfence);
> +	}
> +
> +	AMDGPU_MIGRATE_TRACE("copy_to_ram done: npages=%ld ret=%d\n", npages, ret);
> +
> +out_free:
> +	kvfree(vram);
> +	kvfree(sys);
> +	return ret;
> +}
> +
> +static const struct drm_pagemap_devmem_ops amdgpu_pagemap_ops = {
> +	.devmem_release      = amdgpu_svm_devmem_release,
> +	.populate_devmem_pfn = amdgpu_svm_populate_devmem_pfn,
> +	.copy_to_devmem      = amdgpu_svm_copy_to_devmem,
> +	.copy_to_ram         = amdgpu_svm_copy_to_ram,
> +};
> +
> +/* drm_pagemap_ops — top-level migration entry points */
> +
> +/**
> + * amdgpu_svm_device_map - Convert ZONE_DEVICE page to GPU PTE address
> + * @dpagemap: The drm_pagemap for this device
> + * @dev: Requesting device (for P2P check)
> + * @page: ZONE_DEVICE page backed by VRAM
> + * @order: Page order (0 = 4K, 9 = 2M, etc.)
> + * @dir: DMA direction (unused for local VRAM)
> + *
> + * Address conversion chain:
> + *   page -> PFN -> HPA -> VRAM offset -> PTE address
> + *
> + *   HPA = page_to_pfn(page) << PAGE_SHIFT
> + *   VRAM offset = HPA - apagemap.hpa_base
> + *   PTE address = VRAM offset + adev->vm_manager.vram_base_offset
> + *
> + * Return: drm_pagemap_addr with PTE address and AMDGPU_INTERCONNECT_VRAM protocol
> + */
> +static struct drm_pagemap_addr
> +amdgpu_svm_device_map(struct drm_pagemap *dpagemap,
> +		       struct device *dev,
> +		       struct page *page,
> +		       unsigned int order,
> +		       enum dma_data_direction dir)
> +{
> +	struct amdgpu_pagemap *svm_dm = to_amdgpu_pagemap(dpagemap);
> +	struct amdgpu_device *adev = dpagemap_to_adev(dpagemap);
> +	dma_addr_t addr;
> +
> +	if (dpagemap->drm->dev == dev) {
> +		/* Same device: return VRAM PTE address */
> +		u64 hpa = (u64)page_to_pfn(page) << PAGE_SHIFT;
> +		u64 vram_offset = hpa - svm_dm->hpa_base;
> +
> +		addr = vram_offset + adev->vm_manager.vram_base_offset;
> +	} else {
> +		/* Cross-device P2P: not yet supported */
> +		addr = DMA_MAPPING_ERROR;
> +	}
> +
> +	return drm_pagemap_addr_encode(addr,
> +				AMDGPU_INTERCONNECT_VRAM, order, dir);
> +}
> +
> +/**
> + * amdgpu_svm_bo_alloc - Allocate an amdgpu_svm_bo wrapper with VRAM backing
> + * @adev: AMDGPU device
> + * @dpagemap: The drm_pagemap for this device
> + * @mm: mm_struct of the owning process
> + * @size: Allocation size in bytes
> + *
> + * Return: Pointer to allocated amdgpu_svm_bo on success, ERR_PTR on failure
> + */
> +static struct amdgpu_svm_bo *
> +amdgpu_svm_bo_alloc(struct amdgpu_device *adev,
> +		     struct drm_pagemap *dpagemap,
> +		     struct mm_struct *mm, unsigned long size)
> +{
> +	struct amdgpu_svm_bo *svm_bo;
> +	struct amdgpu_bo_param bp = {};
> +	struct amdgpu_bo *bo;
> +	int ret;
> +
> +	svm_bo = kzalloc(sizeof(*svm_bo), GFP_KERNEL);
> +	if (!svm_bo)
> +		return ERR_PTR(-ENOMEM);
> +
> +	bp.size = size;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> +	bp.type = ttm_bo_type_device;
> +	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> +		   AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> +		   AMDGPU_GEM_CREATE_VRAM_CLEARED;
> +
> +	ret = amdgpu_bo_create(adev, &bp, &bo);
> +	if (ret) {
> +		AMDGPU_MIGRATE_TRACE("Failed to create SVM BO\n");
> +		kfree(svm_bo);
> +		return ERR_PTR(ret);
> +	}
> +
> +	amdgpu_bo_unreserve(bo);
> +	svm_bo->bo = bo;
> +
> +	drm_pagemap_devmem_init(&svm_bo->devmem,
> +				adev->dev, mm,
> +				&amdgpu_pagemap_ops,
> +				dpagemap, size, NULL);
> +
> +	return svm_bo;
> +}
> +
> +/**
> + * amdgpu_svm_populate_mm - Allocate VRAM BO and migrate pages
> + * @dpagemap: The drm_pagemap for this device
> + * @start: Start virtual address of the range to migrate
> + * @end: End virtual address (exclusive)
> + * @mm: mm_struct of the owning process
> + * @timeslice_ms: Maximum time to spend migrating (for fairness)
> + *
> + * Core migration entry point called by drm_pagemap_populate_mm().
> + * Allocates an amdgpu_svm_bo via amdgpu_svm_bo_alloc(), then calls
> + * drm_pagemap_migrate_to_devmem() to execute the actual migration.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int
> +amdgpu_svm_populate_mm(struct drm_pagemap *dpagemap,
> +			unsigned long start, unsigned long end,
> +			struct mm_struct *mm,
> +			unsigned long timeslice_ms)
> +{
> +	struct amdgpu_device *adev = dpagemap_to_adev(dpagemap);
> +	struct drm_pagemap_migrate_details mdetails = {
> +		.timeslice_ms = timeslice_ms,
> +	};
> +	struct amdgpu_svm_bo *svm_bo;
> +	int ret;
> +
> +	svm_bo = amdgpu_svm_bo_alloc(adev, dpagemap, mm, end - start);
> +	if (IS_ERR(svm_bo))
> +		return PTR_ERR(svm_bo);
> +
> +	AMDGPU_MIGRATE_TRACE("populate_mm: [0x%lx-0x%lx] size=%lu\n",
> +			  start, end, end - start);
> +
> +	ret = drm_pagemap_migrate_to_devmem(&svm_bo->devmem,
> +					     mm, start, end,
> +					     &mdetails);
> +
> +	return ret;
> +}
>   
> -const struct drm_pagemap_ops amdgpu_svm_drm_pagemap_ops = { };
> +const struct drm_pagemap_ops amdgpu_svm_drm_pagemap_ops = {
> +	.device_map = amdgpu_svm_device_map,
> +	.populate_mm = amdgpu_svm_populate_mm,
> +};
>   
>   /**
>    * amdgpu_svm_migration_init - Register ZONE_DEVICE and initialize drm_pagemap
