Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BC0F44847
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 12:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FACB10E224;
	Fri, 10 Apr 2026 12:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vOhYvvy0";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8791F10E21F;
 Fri, 10 Apr 2026 12:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vd25EzR/HQqqFrFrDLhLF6OWJFRoNSlZ+VBj+sVJfbj7YHsDuBYCilYfGX26w+AbwCdJZdw7MNEIwjw7oR9CByj+0CGHKyp1kjmHjmoIUzjYJFa3ilh7z3uzU0FpAmIrWvbG9jbugqTyu1Et5r4kZLum9uu9rG0eZeJg7GgArXDuV08TNhjTo/pZIYNcHTSF1/whAjo9mf+gJ9iqayMi0VfqH2vosLwyVMo6gIp7e2A1cs8p3yCteefwlSqA/nUMeEaFiOn4Lcx5HYaNK2+/NevmShuKaDODQHZEO2srOi/37F2xJBLxCXfc8tG5cz/X9gQKYNR0TBS3J0g+SbOy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaxhRXX165W6Y5iAMpo26t1lEg6zw4s2X3A8RKBypZg=;
 b=q+nAj8N+MnnxKnSTmsuTSVisFNwZ7E0QyFx7CHSYzhAkNZ9qgc5POqrCEOYprbRvU/1iT+WYQBFyJpqMgM79h1O84ThVmNc4woASqfkLTDjAAXYwqD5wGqVa2wQHP6xBMRMCp0k/1eO//ttsucvFd0NIOHc04gRp1bXBw7lYLmkpsniZ0IPdPnrpK+kfZGMJe3XFmpLVEB90pKbe5iOHJe1vwPAFWmrz8vchtJo4wp7aLVfuxaQgaU3RKaO3hw/5GQCixkK2AO5zF70IQBmPz48UhurD5HgUZ5CtfbuT3GtGI/cfmYQPYyMEQafbGggzK1ojDwOuf8IOwAP6JW0ZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaxhRXX165W6Y5iAMpo26t1lEg6zw4s2X3A8RKBypZg=;
 b=vOhYvvy0Juy1+H2wwRFpc6XqfR4jZ/U0Gawuz+1Zv+gSRgmzxG9caVjoCT38CC1igM3VcuCMyyis4LrG79HQrGVW6yM6MjfJxYuNYy1wua7tKPrO4acQw3qNpJHMctjrvGOzcTmpPnAQb0aWJB1P2tqRWWVh8RfklBkjXdMBYL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 12:07:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 12:07:33 +0000
Message-ID: <8ee389bc-5321-4ff7-82db-351d4f641e6a@amd.com>
Date: Fri, 10 Apr 2026 14:07:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/6] drm/amdgpu: add SVM eviction fences for VRAM
 overcommit
To: Junhua Shen <Junhua.Shen@amd.com>, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 honglei1.huang@amd.com, Lingshan.Zhu@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 junhshen@amd.com
References: <20260410113146.146212-1-Junhua.Shen@amd.com>
 <20260410113146.146212-5-Junhua.Shen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260410113146.146212-5-Junhua.Shen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:408:112::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d4ad43-e68c-48bf-5d10-08de96f9bedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: L9D/QDDoGoTyjHx1RrNlC7ERUK1MTFLygHD55WPEKzOZvA+X98zPutLPv6DRN+10bJVhBxqKTH+VQFdP6DUnmlYJFB+38/UeJT74HK0CB65Tk49Kp7zQjS89VWaki+feCc+w+u6S3i1vyYnpcv/99dPkgDNI4I+eyYYOgSP9QiDgvSRqiyVFmd9TYQ8VDAkkhG9jWxCfTK5d7l+MpG3L6niwWCBdCb4N+HTwYZHMUFfsHvOZ3GsWVbsE4PFRH+yWRQqIDo8ND0eQMVsL6Q/6A+2dlyPmZ6ChdCaUi9g6iit3QgwVUdHnEI+J+pbsdEyJNEEpnbWI7eteB3ABHSNjP17V7m88SrBIRAg4F40AgQvnsH/krtOVxaQxL6ORI6fDU0RLEY/Eqf0M9sJoZavN2ohrlHs//cMgl9F39KctZHI1zehOoQkZzjFN3GFhjIG1HPgVuqPMPbfXZSW89QHF5XcVcD69ckKCzDcfFM4JjUnHllhD8qgEefiYzSC+stVUlOuaDKsVSHh3tG4+yR1yIPJLkEH52jXBKgTsi9BcVq7YO/lC+t8FUyn6tejK98Iql4XLMn6jqFLzM6eipazUShsbPymaZpp64KGp0pYLMbHVtyKKIbKc9cBo7M7ZDXqVUMeKjYaDdWhIV1rRjiyi6/AyYktHezHrgDzRUQIq1QXNkKe7cq3D1oWwC6iOOfT+1NMo85D7izOZRRzqco2xHHCoKgCmduO5iL+FHS3REw4PwTdyowIapOmPG713hi2BbspB2sTp6giMV/rdqKCUmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTZnbUI5d2lPVE02ajEyNUNXQXJrdzM5RjNnaDNaV3Znb0MweVRNTVZ5WE1r?=
 =?utf-8?B?eVRwaVNIU1J3Z1dYOEhxcHJhNnQ0SVJSSVVTcXEvMCtRNkMvbURRU29NUVUx?=
 =?utf-8?B?SU9vUjE0RFU5elJNYlhEdzhmdEgyVUV1ZmVISjgwQXJ5ODdSSC9QM2pkMzBy?=
 =?utf-8?B?R3VoV1VrOEYrYUVpZGgwL2gvbC84Rzdlb29KdTRCWDdFOWZlVm9vZGx4SEky?=
 =?utf-8?B?NHRETXFuSEVzdTZYS0xYWE13TzgwQ1hNVkRHUXU4cUYyTW53eEhwTzI4enFj?=
 =?utf-8?B?RzUyZm5nUzlTWVBRcUsyUnVRU2lsZVV4Vi8ybmxkR0J0T2FscXE5Z3FhM1JL?=
 =?utf-8?B?ZFdhTFJ1SjRwcmdLS2VDSXRrVGJKZnlsb1I2VW1tUGxnK0JZZXVMS1I5djQ3?=
 =?utf-8?B?RTFZeFBINkF6VVFJL0dKZUR5akZFK3RZR2RFTm5NcklFOHhoTDUvRXVTQmdQ?=
 =?utf-8?B?YmFjZGRtZ3BkQ1pDZ1U2V3lvdCtoQUFSMGdNSXNQVWdFOEhucXJSaTNCOVpt?=
 =?utf-8?B?ejJSTHZuMVJhRGgxaDRZdW5IaDRWOFhDbG5sV3J6UFNKY3JiSEVCRFU2MjdU?=
 =?utf-8?B?K3dTTUU0WWJlY0E4QXRFZ0ZjOU1BVGZ2YS9yamx5MWtYZkxtUStIZ1k1QVJE?=
 =?utf-8?B?LytvdnA2aXRDMUhicS9zZ3ZyZGJhdllhQXJ5eTViUEd3aE9WcmVRODRaRHhx?=
 =?utf-8?B?WHRLdDJxUFZKMmsvMldML2NrdXBMTEY5SlludkNBYlQ2MUxRMTZFdVNuK3VL?=
 =?utf-8?B?a29ZV3BmRU50K0NzRHVMN2hIUDc5RVdOcXZPQjRKckhsTmwxYzNlMkwxYlF3?=
 =?utf-8?B?TzNnYWdPa2Z0a0o4K3YyN1VZQTJWaml3bXdtcEVuK2l0eE90aFFJeWNPSmlT?=
 =?utf-8?B?MUpsdjZVLzgrRDBHY2M5Skt5YjBVakd1b0lickJZa3FrS3Q3T042VE1rc21B?=
 =?utf-8?B?a0M0RlgweVN1ZDZTN3Q0d2U1WVo4YmpabC9kMVJGciszT2x2M3p1bzdxT0VJ?=
 =?utf-8?B?YXBDOFNjb2NwRzhCRWRUYXhQWk9wMU9FVUpyb2pveXpSOUlzMm81OHlmRjBp?=
 =?utf-8?B?cHB0eWZXRFR0YVlJdkRZZ3gwQXViV1FqdHYyKytZUnVySjdxTXlSUFpBdlpv?=
 =?utf-8?B?dWlEUDdyODFFR0llekcxVVUwbTZNVGN0Tks0eUFlc2Z4akkwVjVsOVZwSExz?=
 =?utf-8?B?U0p2Z09CZkVmTS80R3FBeEpYbDRieUtLTUFNNVNPOHExZ0dJeW1sNWZSWVZV?=
 =?utf-8?B?dXU4dzhvVC9heENyUkl0c3E3Ung2ZllIU1pkdzJXUk1QVG12T2xvcTFqZTBR?=
 =?utf-8?B?UE0za1NDcGcyOTBoOTVuZzl6NGNHbzA2YUU4VDh3SjBSM2JCYVNicHd0bHJN?=
 =?utf-8?B?NkRHTk0rSGcrWVlvRzBKUlRjOEFhTVF1aXFPV2VVckplRGNvQ3NuTDFkdXhU?=
 =?utf-8?B?Und6dFpMaFB6aWxVbmpSbERwSTRYR3k2MVFtR0NiZk0wSkRaS1Q0dmhBYmRm?=
 =?utf-8?B?Wi9odnR4dEhZTGtOKzI0TFk0amcvS1BKM2M0TU16cjNiQlR1ejhiUkI5S21K?=
 =?utf-8?B?K3NtUXdJYnFEZGtJWWg4U1BKTEpLTHFLYUUxeUhXSC9UTGE5Z1pTYU9Uc0VX?=
 =?utf-8?B?c0M2SVJzV2U0UGgwOXhTOVhsRWVqY3V4T0VmdUVhTTJMNmhpVld2ZWNrSUNp?=
 =?utf-8?B?U1dpYm1GODRjam8yOHRBYjM3MXVjQ3c5ZjBGQnZVZEhXUjhGOWJVc3g4UWEz?=
 =?utf-8?B?dHV1WENmTW0zbnVFeWhRUTFKdFdkU05YQ3Y5TlJnZGRwb0JRZWFRNFFMQ1Ux?=
 =?utf-8?B?SVB4OWhDZS93c3pmb25ha0puRmhIRXM5Y3Q2aE1DK2IzZThpRTVvMGpsdkdG?=
 =?utf-8?B?dmZFTXRUZDErVTRYSFU4UStESm0zbGVDbnR5UU5qNmRYL1ZFWjE3UFl3MFZT?=
 =?utf-8?B?eGk1RFRKRy81YnVUUDRwM1RucUlMU2NOTkRSRXFESmsyOEVWL1BqR1U0c0M4?=
 =?utf-8?B?SWRMaW5iOTFRaTBjTjRvd1lDS3puRVowaUdvckYrUE93c0dHVmVDWEZPNldQ?=
 =?utf-8?B?V21waXpiWGwvUUhLcVozMmdoN2hzZiszMVhVaEx6K3I2a2x2VzhrTjF0dWhB?=
 =?utf-8?B?MkhKNUhZQ1ZLMlJiYWRnSHJIS1VFRkNZWGVsRGdLTndnUDd5ZHI5QythRXlY?=
 =?utf-8?B?NmNWdXdRUGoraFY0TTdQbm44Zi81aitiVVJhV1hQWW52azc3TzNlZmlxaUpZ?=
 =?utf-8?B?YmV2T0RNa0IyUFZHUm5JQ0hydzVGV2JBcm9kejQ2V091S0U5REFWQ2hTc0lX?=
 =?utf-8?Q?CFudbycj++BITtntsN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d4ad43-e68c-48bf-5d10-08de96f9bedb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 12:07:32.8793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpKQZTiM+4Vpk0jflH3dro5gh+VJ297yVl2Hz2H5ifgBYkARbGEs+ur/FPSXffmH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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

On 4/10/26 13:31, Junhua Shen wrote:
> Add eviction fence support so that TTM can reclaim SVM VRAM
> when the system is under memory pressure.
> 
> When TTM needs to evict a DISCARDABLE SVM BO, the fence's
> enable_signaling callback schedules a work item that calls
> hmm_range_fault(dev_private_owner=NULL) to trigger
> migrate_to_ram for all device-private pages in the BO's
> virtual address range. After SDMA copies the data back to
> system RAM, the fence is signaled and TTM discards the
> now-empty VRAM resource.

Absolutely clear NAK to that whole approach! This doesn't even remotely work correctly.

Please see the documentation for dma_fence handling for the background.

Regards,
Christian.

> 
> The implementation adds:
>   - struct amdgpu_svm_evict_fence with dma_fence_ops
>   - amdgpu_svm_evict_bo_worker using mmu_interval_notifier
>   - amdgpu_svm_evict_fence_create called from bo_alloc
>   - AMDGPU_GEM_CREATE_DISCARDABLE flag on SVM BOs
>   - fence attached as DMA_RESV_USAGE_BOOKKEEP
> 
> Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c | 267 +++++++++++++++++++-
>  1 file changed, 264 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
> index 115df0cf0f94..0724416f5aa8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
> @@ -61,8 +61,11 @@
>   */
>  
>  #include <drm/drm_pagemap.h>
> +#include <linux/dma-fence.h>
> +#include <linux/hmm.h>
>  #include <linux/memremap.h>
>  #include <linux/migrate.h>
> +#include <linux/mmu_notifier.h>
>  
>  #include "amdgpu_migrate.h"
>  #include "amdgpu.h"
> @@ -76,6 +79,10 @@
>  #define FROM_RAM_TO_VRAM	0
>  #define FROM_VRAM_TO_RAM	1
>  
> +/* Fence context for SVM eviction fences (shared by all instances) */
> +static u64 amdgpu_svm_evict_fence_context;
> +static atomic_t amdgpu_svm_evict_fence_seq = ATOMIC_INIT(0);
> +
>  static inline struct amdgpu_pagemap *
>  dpagemap_to_apagemap(struct drm_pagemap *dpagemap)
>  {
> @@ -102,6 +109,214 @@ amdgpu_svm_page_to_apagemap(struct page *page)
>  	return container_of(pgmap, struct amdgpu_pagemap, pgmap);
>  }
>  
> +/*
> + * Eviction fence — prevents TTM from discarding BO before pages migrate back
> + */
> +
> +/**
> + * struct amdgpu_svm_evict_fence - Fence that gates TTM eviction of SVM BOs
> + *
> + * @base: dma_fence base (attached to BO's dma_resv as BOOKKEEP fence)
> + * @lock: Spinlock for fence signaling
> + * @eviction_work: Work item that migrates ZONE_DEVICE pages back to RAM
> + * @mm: The owning process's mm_struct (mmgrab'd)
> + * @start: Virtual address range start (inclusive)
> + * @end: Virtual address range end (exclusive)
> + *
> + * When TTM needs to evict an SVM BO (DISCARDABLE) to reclaim VRAM,
> + * it waits on this fence. The enable_signaling callback schedules
> + * the eviction worker, which uses hmm_range_fault(owner=NULL) to
> + * trigger migrate_to_ram for all device-private pages in [start, end).
> + * After migration completes the fence is signaled, allowing TTM to
> + * discard the now-empty VRAM resource.
> + */
> +struct amdgpu_svm_evict_fence {
> +	struct dma_fence base;
> +	spinlock_t lock;
> +	struct work_struct eviction_work;
> +	struct mm_struct *mm;
> +	unsigned long start;
> +	unsigned long end;
> +};
> +
> +static inline struct amdgpu_svm_evict_fence *
> +to_amdgpu_svm_evict_fence(struct dma_fence *f)
> +{
> +	return container_of(f, struct amdgpu_svm_evict_fence, base);
> +}
> +
> +/* Temporary MMU interval notifier ops for eviction worker's hmm_range_fault */
> +static bool
> +amdgpu_svm_evict_notifier_invalidate(struct mmu_interval_notifier *mni,
> +				     const struct mmu_notifier_range *range,
> +				     unsigned long cur_seq)
> +{
> +	return true;	/* no-op: we don't need invalidation tracking */
> +}
> +
> +static const struct mmu_interval_notifier_ops amdgpu_svm_evict_mni_ops = {
> +	.invalidate = amdgpu_svm_evict_notifier_invalidate,
> +};
> +
> +/**
> + * amdgpu_svm_evict_bo_worker - Work item to migrate device pages back to RAM
> + * @work: Embedded work_struct in amdgpu_svm_evict_fence
> + *
> + * Registers a temporary mmu_interval_notifier and calls hmm_range_fault()
> + * with dev_private_owner=NULL, which triggers the dev_pagemap migrate_to_ram
> + * callback for each device-private page.  This copies VRAM data to system
> + * memory via SDMA.
> + *
> + * After migration (or on error), signals the fence so TTM can proceed.
> + */
> +static void amdgpu_svm_evict_bo_worker(struct work_struct *work)
> +{
> +	struct amdgpu_svm_evict_fence *fence =
> +		container_of(work, struct amdgpu_svm_evict_fence, eviction_work);
> +	struct mm_struct *mm = fence->mm;
> +	unsigned long start = fence->start;
> +	unsigned long end = fence->end;
> +	unsigned long npages = (end - start) >> PAGE_SHIFT;
> +	struct mmu_interval_notifier notifier;
> +	unsigned long timeout;
> +	unsigned long *pfns;
> +	int retries = 3;
> +	int err = 0;
> +
> +	if (!mmget_not_zero(mm))
> +		goto signal;
> +
> +	err = mmu_interval_notifier_insert(&notifier, mm, start, end - start,
> +					   &amdgpu_svm_evict_mni_ops);
> +	if (err) {
> +		pr_warn("amdgpu: SVM eviction notifier insert failed: %d\n", err);
> +		goto put_mm;
> +	}
> +
> +	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> +	if (!pfns)
> +		goto remove_notifier;
> +
> +	timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> +	do {
> +		struct hmm_range hmm_range = {
> +			.notifier = &notifier,
> +			.start = start,
> +			.end = end,
> +			.hmm_pfns = pfns,
> +			.default_flags = HMM_PFN_REQ_FAULT,
> +			.dev_private_owner = NULL,
> +		};
> +
> +		hmm_range.notifier_seq = mmu_interval_read_begin(&notifier);
> +		if (time_after(jiffies, timeout)) {
> +			err = -ETIME;
> +			break;
> +		}
> +
> +		mmap_read_lock(mm);
> +		err = hmm_range_fault(&hmm_range);
> +		mmap_read_unlock(mm);
> +	} while (err == -EBUSY && --retries);
> +
> +	if (err)
> +		pr_warn("amdgpu: SVM eviction migration failed: %d [0x%lx-0x%lx]\n",
> +			err, start, end);
> +
> +	kvfree(pfns);
> +remove_notifier:
> +	mmu_interval_notifier_remove(&notifier);
> +put_mm:
> +	mmput(mm);
> +signal:
> +	dma_fence_signal(&fence->base);
> +	dma_fence_put(&fence->base);	/* drop worker's reference */
> +}
> +
> +static const char *amdgpu_svm_fence_get_driver_name(struct dma_fence *f)
> +{
> +	return "amdgpu_svm";
> +}
> +
> +static const char *amdgpu_svm_fence_get_timeline_name(struct dma_fence *f)
> +{
> +	return "svm_eviction";
> +}
> +
> +/**
> + * amdgpu_svm_fence_enable_signaling - Called by TTM when it wants to evict
> + *
> + * Takes a fence reference for the worker and schedules the eviction work.
> + * The worker will migrate device pages back to RAM and signal the fence.
> + */
> +static bool amdgpu_svm_fence_enable_signaling(struct dma_fence *f)
> +{
> +	struct amdgpu_svm_evict_fence *fence = to_amdgpu_svm_evict_fence(f);
> +
> +	if (dma_fence_is_signaled(f))
> +		return true;
> +
> +	AMDGPU_MIGRATE_TRACE("evict fence enable_signaling: [0x%lx-0x%lx]\n",
> +			  fence->start, fence->end);
> +
> +	dma_fence_get(f);	/* reference for the worker */
> +	schedule_work(&fence->eviction_work);
> +	return true;
> +}
> +
> +static void amdgpu_svm_fence_release(struct dma_fence *f)
> +{
> +	struct amdgpu_svm_evict_fence *fence = to_amdgpu_svm_evict_fence(f);
> +
> +	mmdrop(fence->mm);
> +	kfree_rcu(f, rcu);
> +}
> +
> +/**
> + * amdgpu_svm_evict_fence_check_mm - Allow cross-process eviction
> + *
> + * TTM calls check_mm to see if an eviction should be skipped for the
> + * calling process.  For SVM overcommit, we always allow eviction
> + * (return false = "do not skip"), matching KFD SVM behavior.
> + */
> +static const struct dma_fence_ops amdgpu_svm_evict_fence_ops = {
> +	.get_driver_name = amdgpu_svm_fence_get_driver_name,
> +	.get_timeline_name = amdgpu_svm_fence_get_timeline_name,
> +	.enable_signaling = amdgpu_svm_fence_enable_signaling,
> +	.release = amdgpu_svm_fence_release,
> +};
> +
> +/**
> + * amdgpu_svm_evict_fence_create - Create an eviction fence for an SVM BO
> + * @mm: The owning process's mm_struct
> + * @start: VA range start
> + * @end: VA range end (exclusive)
> + *
> + * Return: Pointer to fence, or NULL on allocation failure
> + */
> +static struct amdgpu_svm_evict_fence *
> +amdgpu_svm_evict_fence_create(struct mm_struct *mm,
> +			      unsigned long start, unsigned long end)
> +{
> +	struct amdgpu_svm_evict_fence *fence;
> +
> +	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
> +	if (!fence)
> +		return NULL;
> +
> +	mmgrab(mm);
> +	fence->mm = mm;
> +	fence->start = start;
> +	fence->end = end;
> +	spin_lock_init(&fence->lock);
> +	INIT_WORK(&fence->eviction_work, amdgpu_svm_evict_bo_worker);
> +	dma_fence_init(&fence->base, &amdgpu_svm_evict_fence_ops, &fence->lock,
> +		       amdgpu_svm_evict_fence_context,
> +		       atomic_inc_return(&amdgpu_svm_evict_fence_seq));
> +
> +	return fence;
> +}
> +
>  /*
>   * drm_pagemap_devmem_ops — per-BO migration mechanics
>   */
> @@ -111,6 +326,8 @@ amdgpu_svm_page_to_apagemap(struct page *page)
>   *
>   * @devmem: drm_pagemap device memory allocation (passed to framework)
>   * @bo: The backing VRAM amdgpu_bo
> + * @eviction_fence: Fence that gates TTM eviction — worker migrates pages
> + *                  back to RAM before signaling, so BO can be discarded
>   *
>   * It is allocated per-migration in populate_mm() and freed by
>   * devmem_release() when all device-private pages have migrated
> @@ -124,6 +341,7 @@ amdgpu_svm_page_to_apagemap(struct page *page)
>  struct amdgpu_svm_bo {
>  	struct amdgpu_bo *bo;
>  	struct drm_pagemap_devmem devmem;
> +	struct amdgpu_svm_evict_fence *eviction_fence;
>  };
>  
>  static inline struct amdgpu_svm_bo *
> @@ -149,6 +367,12 @@ amdgpu_svm_devmem_release(struct drm_pagemap_devmem *devmem_allocation)
>  	AMDGPU_MIGRATE_TRACE("release svm_bo=%px bo=%px\n",
>  			  svm_bo, svm_bo->bo);
>  
> +	if (svm_bo->eviction_fence) {
> +		/* Ensure fence is signaled (e.g., process exit path) */
> +		dma_fence_signal(&svm_bo->eviction_fence->base);
> +		dma_fence_put(&svm_bo->eviction_fence->base);
> +	}
> +
>  	amdgpu_bo_unref(&svm_bo->bo);
>  	kfree(svm_bo);
>  }
> @@ -629,14 +853,27 @@ amdgpu_svm_device_map(struct drm_pagemap *dpagemap,
>   * @dpagemap: The drm_pagemap for this device
>   * @mm: mm_struct of the owning process
>   * @size: Allocation size in bytes
> + * @start: Virtual address range start (for eviction fence)
> + * @end: Virtual address range end (for eviction fence)
> + *
> + * Allocates an amdgpu_svm_bo wrapper, creates a VRAM-only amdgpu_bo
> + * with the DISCARDABLE flag, and attaches an eviction fence.
> + *
> + * When TTM later needs to reclaim VRAM, the eviction fence's
> + * enable_signaling schedules a work item that migrates all
> + * ZONE_DEVICE pages in [start, end) back to system RAM via
> + * hmm_range_fault(owner=NULL).  After migration, the fence is
> + * signaled and TTM discards the now-empty VRAM resource.
>   *
>   * Return: Pointer to allocated amdgpu_svm_bo on success, ERR_PTR on failure
>   */
>  static struct amdgpu_svm_bo *
>  amdgpu_svm_bo_alloc(struct amdgpu_device *adev,
>  		     struct drm_pagemap *dpagemap,
> -		     struct mm_struct *mm, unsigned long size)
> +		     struct mm_struct *mm, unsigned long size,
> +		     unsigned long start, unsigned long end)
>  {
> +	struct amdgpu_svm_evict_fence *evict_fence;
>  	struct amdgpu_svm_bo *svm_bo;
>  	struct amdgpu_bo_param bp = {};
>  	struct amdgpu_bo *bo;
> @@ -646,13 +883,20 @@ amdgpu_svm_bo_alloc(struct amdgpu_device *adev,
>  	if (!svm_bo)
>  		return ERR_PTR(-ENOMEM);
>  
> +	evict_fence = amdgpu_svm_evict_fence_create(mm, start, end);
> +	if (!evict_fence) {
> +		kfree(svm_bo);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
>  	bp.size = size;
>  	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>  	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>  	bp.type = ttm_bo_type_device;
>  	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
>  		   AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> -		   AMDGPU_GEM_CREATE_VRAM_CLEARED;
> +		   AMDGPU_GEM_CREATE_VRAM_CLEARED |
> +		   AMDGPU_GEM_CREATE_DISCARDABLE;
>  
>  	ret = amdgpu_bo_create(adev, &bp, &bo);
>  	if (ret) {
> @@ -671,8 +915,20 @@ amdgpu_svm_bo_alloc(struct amdgpu_device *adev,
>  		return ERR_PTR(ret);
>  	}
>  
> +	/* Attach eviction fence to BO reservation (BO is born reserved) */
> +	ret = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
> +	if (ret) {
> +		dma_fence_put(&evict_fence->base);
> +		amdgpu_bo_unref(&bo);
> +		kfree(svm_bo);
> +		return ERR_PTR(ret);
> +	}
> +	dma_resv_add_fence(bo->tbo.base.resv, &evict_fence->base,
> +			   DMA_RESV_USAGE_BOOKKEEP);
>  	amdgpu_bo_unreserve(bo);
> +
>  	svm_bo->bo = bo;
> +	svm_bo->eviction_fence = evict_fence;
>  
>  	drm_pagemap_devmem_init(&svm_bo->devmem,
>  				adev->dev, mm,
> @@ -709,7 +965,8 @@ amdgpu_svm_populate_mm(struct drm_pagemap *dpagemap,
>  	struct amdgpu_svm_bo *svm_bo;
>  	int ret;
>  
> -	svm_bo = amdgpu_svm_bo_alloc(adev, dpagemap, mm, end - start);
> +	svm_bo = amdgpu_svm_bo_alloc(adev, dpagemap, mm, end - start,
> +				     start, end);
>  	if (IS_ERR(svm_bo))
>  		return PTR_ERR(svm_bo);
>  
> @@ -796,6 +1053,10 @@ int amdgpu_svm_migration_init(struct amdgpu_device *adev)
>  	svm_dm->hpa_base = pgmap->range.start;
>  	svm_dm->initialized = true;
>  
> +	/* One-time init of the shared fence context for SVM eviction fences */
> +	if (!amdgpu_svm_evict_fence_context)
> +		amdgpu_svm_evict_fence_context = dma_fence_context_alloc(1);
> +
>  	dev_info(adev->dev, "SVM: registered %ldMB device memory, hpa_base=0x%llx\n",
>  			size >> 20, svm_dm->hpa_base);
>  	return 0;

