Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D750A1073CBC
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 14:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3912910E673;
	Wed,  8 Apr 2026 14:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ew98ODQm";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75A6A10E673;
 Wed,  8 Apr 2026 14:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhdePZ/tE9PY1NrxOuzdH9/oD3sLBrWTq3xkPiAhK/TUHqEDCuT6YSGna6P/MAsOQkRSrk0qWjPm9S9eBQ6FZg2sRSN7gyXMvE56QBeh7eUCgbMYNiXy98mhzx9IKa3H3RzgNR1P6SKGMuSnfO8aIE2fKfdoIA8B/i0Tu9tEcQ4W4DklMbSy9k73iE2lxfi8x5FSNBOtOumkYxiJCpOco/6Luc2J3aCks7W9xAjO5A5QEAJS0f16y4srP4K5tkUZkkEWHyn+tmJ/XeMzCucDSFznEOLV8pCNXGaRdilw18jhIpOWq9O1Kdl2zE/b89hh46thkbHtkEDmKcjVZLgd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GSC1zJugg2Ct9WBk3Gw2PSfSUwuin53FSU00oJ34G0=;
 b=lRDBWojhL8CIh6UBHy1rPA7Tq2szrVzv02yU23bWM66WVzjqJuvi5T8oQaynUm5BJKBm9l+teYLf8Mj1XVst0H1eZtSzbifqivdfcUQ4JX7E4aTY/3DPpEkn2fAdXF3ITMR1v/bzyo6gJTVKLtFVhB0NvFRnzw6v3Wa3n6nec1RD5zs32DFSa6/lPoXX6nEYE/+fOpsEui61TbkaCafElYTrrDyt1KEC7UOkWi7V3tJHK2Nf9frfy4xKCVSPMjJbwAA9SCUipcwPEp9tHQ5VDDnd3NI21oaAhqFCmsZDvXLYIXZbTlE7ZL/yUZNIwiT7LLFT/b6h0xvND6a6F04ROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GSC1zJugg2Ct9WBk3Gw2PSfSUwuin53FSU00oJ34G0=;
 b=ew98ODQmn1ghUXx1SXWrZ1zpABFlX62NCnMCytsVMB0zKFEx4T5u+bo+68t8H94PQZN+fT0GIWnYPoLzXUWPttLo7XxJoYeDEUf/dhBSwP65eMvwESSWXm6Me6qsBqXd2q+r6BLWB1tC+rNXEbMzsUj/5EuAm0q0e+IxFX0LeCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 14:10:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 14:10:02 +0000
Message-ID: <8bd8e805-47b7-414a-a570-73e3edfd9da9@amd.com>
Date: Wed, 8 Apr 2026 16:09:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] drm/amdgpu: pass all the sdma scheds to amdgpu_mman
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260408100327.1372-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408100327.1372-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3cb277-83e5-439c-e660-08de957886e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: j4cFLtsg31cZHNWcUYkcqLnz6V1TkuBa3HZIr2A3VNVKzCfr38WrT97jBXzZeJHwcGmFZmsPKf4FnaKrOyV0VN2SITcLzQTAn4e2ye1U0Qat1MWVg1k50zEvBYE4tQuCng5RQlE5Z5StyyF+wYqux38O9YK9b6F2mWjG2zzjsEqBtmSvuESjdC2YiV5Snvjp86PuGYyZ3UeMBc/G9hnStwjPs8Qzqn1JuNNueMH95wlwHExiAMKSZeyuwYPtoDZtM4KrwlOAhtwKAvP/PbF25VLU9nRd6yr228fIbi0xcFoutukZY/UGKqKJd05GXSlBKj126wWR0F7ZL8K+l1OuZvSSMhJQih46M8oa7NOwxJKGWa+DSG98XM1WymxQQOejwZd3skdyDXkKuut9PAFD7OA9HQ8mlM4/Y4gDjjV8b2Q5gGxcpsZzG671pKMrViKtifRP9cldvu0oOHN6kXG8UGqdgvbD84/aKpgcSipRRhhVOAr/3o9FGXCGy43URQ0C0fnLIk6NRdlfuLFNRcS+9ZPZmMBFcIGvhonCmwOUcSCQcGygBMKDxoF/5S9varRccQUBdpZ//ecb+M7nrOUtUaS9d/jKg8SDv3ZS2svHeOVDbZjHWvnOPbswJIak7H/01CStJReHUTwz6hSGE3NB6c0N15jM5jfRKDmLqDuP2I7Ua12grOVs3OzFgI26Y9m5/iuspQ0i6VPg0w99do5HdSiS2RNgJfEydXpfzW9zxWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azR2cS9wNW1jVmpCaFJ1VklzS2kzMUFDT3hjWElTRkszMklkU0ZYdzlBMllP?=
 =?utf-8?B?UERyY1hWSmJkeVBab3daV1owOC9lWmZYRURFVlZOTGVJZkorVDRxdXZHQUZN?=
 =?utf-8?B?dE4wQjRjeE9pd1NVWUNmZGdDZ0NiVnpxM204YktsRWw5Sllpb1ZveWZvUWVr?=
 =?utf-8?B?Q1paVEZEWEpvMGxvakpuYm4wSCtuZzg4M2dTTEgrazNsQnZlZWIrU1ZPQXhp?=
 =?utf-8?B?VzlRS3Q3cEdySzdrNFJ5Tm1OaTgzY0lvZUJ2enVpelZpNXBPaU53TzkxVnly?=
 =?utf-8?B?eVVHVGJCU1lhSWdzVzhMNFRxMHpRaVE4WUQ0Qm9hd3FqK1hoMVQ5cFJ0RmZq?=
 =?utf-8?B?VzlyNXJGcXMzQzFGYlNZb1NFUVhONmRoN2NET2FwVWFhTlZVSCtESk42UWFM?=
 =?utf-8?B?NXBFc3lxbFNiUlJDUjVRR2ZpK0tvbUhPbVo4dnlkVkJRYzN6R1VIajZXMVZJ?=
 =?utf-8?B?YkQvSWlIcGhCV1pEM2FMcDlqTGY0ZWN1T0dxdzZ4cEdpSmZhRUpqWERGZG45?=
 =?utf-8?B?RlJNc1Q1S1liYXVOaDd1bkZ0NHdLLzNoV0UwUURlYzloRGJQL0JOc2NOZXls?=
 =?utf-8?B?L2pnZldKdS9Vc2U3eG5VRC9FUEpDcXV4ZGl5VGNLMEZ4VG5hSlJQRncwbURZ?=
 =?utf-8?B?c1V5QU9SM3JyVmpIbmhkMEVSSjg0eFZnRHQ3T3BnRGo0NFdxVzF4bnRqc3dl?=
 =?utf-8?B?QzdRSGJqYjYvL0xuOE5RNCtiUnEyUGlFMlQ5VDVjd1VaSTRTS1A1aytOZHM2?=
 =?utf-8?B?UUF3bmNuQ2JGK1ZuQjdQcTRaQXp2dm9xVFhvYmRPMnBWZVhkQVRLZGttR0R6?=
 =?utf-8?B?S1NaUW9PSXdRYnRwMXh3Qy9aQTdNM25FMXB3VlJBMDZ6a3lYUEJsdFFET0lt?=
 =?utf-8?B?L2syeW5aUjdKVXpMT0IvVllqSks1RGg5YUgzb2tPLzFGM1Z1S2JpeFVUYldn?=
 =?utf-8?B?NGlOd0NDSDdVeTFkVTAveGZudytVci85cVlVeHRZNi9ZYVhtazFtQ3YwTm4y?=
 =?utf-8?B?U2R1d2JWdHR2OVZoT2tuYjdvelVQcFJRVGVVZWo1UStUQXJPWjJCVDV3RStB?=
 =?utf-8?B?WWdxRzB3VkExcXpEYnlFcjE5WU95bERnbUllL3paVjUwbU1RejlKMHAyVkRM?=
 =?utf-8?B?b0YwNnM5NWdwUlV6c3BReHZib1JtOUdqTThMVzJRWTMwUHF2SnhqV0szTW5h?=
 =?utf-8?B?MU9iQ2pxcmJSZlRtbTJVT00rNjVYd0tobk9CME5BbXZTdEhHb014US83QUov?=
 =?utf-8?B?d1VwZUFMY0xuaUkwUHNrWThwTk9mNXVhSnFVZVFpOGdNcFlWM1FJNG14c2NV?=
 =?utf-8?B?bTdITUQrMUp5L05YZTdtL25yS1YxWVU1WDMyOG9lbVNMRG1vMDJJaDg1V0xC?=
 =?utf-8?B?TTh0RzFkM0UveE8vNzVFSldaZU9ya1JHbWxNMk5LeHRuRllodmZYc3FuOGpW?=
 =?utf-8?B?eHVrckRiQkF3NzIrRXcrU2pHWmtIWDdoQmJha01wZGtwRTFPQklSWGFMeXRw?=
 =?utf-8?B?bmwrYVVnMkdMb0grVUNBMlN3VVpHUkZpM2loLzBKQnczYlE2YjlZcGNIZ1lw?=
 =?utf-8?B?Nk1va0dBV0NSNlFSenBhUjYyNHhjcDgvdm9wLzd0dmQ5djZGRjdwalg0Ujh3?=
 =?utf-8?B?TTNxSVpWbkVNTlRIYW45aVV1UE52eGdldDF0L1ZvaDE1R1B4M3ZHTjBjM3Jy?=
 =?utf-8?B?ZlJwM0R5UWlNL2dGbTdMay9WVThJMldrR1RveFdhazJucW9TRUpETVJKRW9p?=
 =?utf-8?B?b3IzekovVDg4cVNFaVo4Y2JsUEF5bU1jVkY3RHNWTFlMUXRjUVRsVFM3R2RJ?=
 =?utf-8?B?UnlybGYwVlJFNEJ0S2JoNnlkTHB1RUxVVFJCS0hmc05ubTQ1cy9mbnB1RTRl?=
 =?utf-8?B?V1NxQzV4a2xObGIvSStrN3pSNUhkVXdCbm1tcXcrZGZjbVlKQmJSUUFtbEx3?=
 =?utf-8?B?aWlyZU9TdWZvUmVMbG5rSksyR2tRQlZ5U2JoUEF2K1NoMFVEeDN4R3V3MU9R?=
 =?utf-8?B?R0JMaC94NGhWOUtORlAwOHhCQ25MTFR2eUJqQmdWZlljZHpjNXlRSkQ3Q1Rl?=
 =?utf-8?B?YzZRdkFWaHFTcXlPZGNCUlYrcEQ1bVo0OFVmeU1pM1JqTVRFT1BldXkzdzFo?=
 =?utf-8?B?RkxJbVlzSlpmanI4MDl1VEl0MG9WbnBDVFFkWlU0RE5EUnN0M00vU2lUK0Nv?=
 =?utf-8?B?TG91S1VMNUZYWVc1N3pLejIyK2tJZi9rc0IvWVlQTnAxcWlRSGtMNzhxVmkx?=
 =?utf-8?B?bC9QcCthNmhJMkI5Qjh2S281SUs2SmN6SllRREI3OHRJR1lpZ2FCR0FTcXVT?=
 =?utf-8?Q?jEeqOWHvqPJ2GpSaOp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3cb277-83e5-439c-e660-08de957886e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 14:10:02.8334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1V43VFh1LHKJT2h9/1+lFyIOZcv88d71r3PH27HHLdsnnsYwkrNEgJ/GzvsoNkvB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473
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



On 4/8/26 12:03, Pierre-Eric Pelloux-Prayer wrote:
> This will allow the use of all of them for clear/fill buffer
> operations.
> Since drm_sched_entity_init requires a scheduler array, we
> store schedulers rather than rings. For the few places that need
> access to a ring, we can get it from the sched using container_of.
> 
> Since the code is the same for all sdma versions, add a new
> helper amdgpu_sdma_set_buffer_funcs_scheds to set buffer_funcs_scheds
> based on the number of sdma instances.
> 
> Note: the new sched array is identical to the amdgpu_vm_manager one.
> These 2 could be merged.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  4 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 36 ++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 +-
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  8 ++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |  6 +---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  5 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  5 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/si_dma.c        |  3 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c   |  3 +-
>  17 files changed, 52 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 49e7881750fa..e3a8701f0b27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1467,6 +1467,8 @@ ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
>  ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
>  void amdgpu_sdma_set_vm_pte_scheds(struct amdgpu_device *adev,
>  				   const struct amdgpu_vm_pte_funcs *vm_pte_funcs);
> +void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
> +					 const struct amdgpu_buffer_funcs *buffer_funcs);
>  
>  /* atpx handler */
>  #if defined(CONFIG_VGA_SWITCHEROO)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0c0489395edf..4da8de34be3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3700,7 +3700,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	adev->num_rings = 0;
>  	RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
>  	adev->mman.buffer_funcs = NULL;
> -	adev->mman.buffer_funcs_ring = NULL;
> +	adev->mman.num_buffer_funcs_scheds = 0;
>  	adev->vm_manager.vm_pte_funcs = NULL;
>  	adev->vm_manager.vm_pte_num_scheds = 0;
>  	adev->gmc.gmc_funcs = NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index e9e53c7c37d0..1a253e4257ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -708,12 +708,14 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  			      uint32_t vmhub, uint32_t flush_type)
>  {
> -	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> +	struct amdgpu_ring *ring;
>  	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>  	struct dma_fence *fence;
>  	struct amdgpu_job *job;
>  	int r;
>  
> +	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
> +
>  	if (!hub->sdma_invalidation_workaround || vmid ||
>  	    !adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
>  	    !ring->sched.ready) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 3c63f87832e4..63ec3938cd41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -168,7 +168,7 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, struct amdgpu_ttm_buffer_entit
>  {
>  	struct amdgpu_ring *ring;
>  
> -	ring = adev->mman.buffer_funcs_ring;
> +	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>  	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>  	WARN_ON(job->ibs[0].length_dw > num_dw);
>  
> @@ -2349,18 +2349,17 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>  		return;
>  
>  	if (enable) {
> -		struct amdgpu_ring *ring;
>  		struct drm_gpu_scheduler *sched;
>  
> -		if (!adev->mman.buffer_funcs_ring || !adev->mman.buffer_funcs_ring->sched.ready) {
> +		if (!adev->mman.num_buffer_funcs_scheds ||
> +		    !adev->mman.buffer_funcs_scheds[0]->ready) {
>  			dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
>  			return;
>  		}
>  
>  		num_clear_entities = 1;
>  		num_move_entities = 1;
> -		ring = adev->mman.buffer_funcs_ring;
> -		sched = &ring->sched;
> +		sched = adev->mman.buffer_funcs_scheds[0];
>  		r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
>  						  &adev->mman.default_entity,
>  						  DRM_SCHED_PRIORITY_KERNEL,
> @@ -2497,7 +2496,7 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
>  	unsigned int i;
>  	int r;
>  
> -	ring = adev->mman.buffer_funcs_ring;
> +	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>  
>  	if (!ring->sched.ready) {
>  		dev_err(adev->dev,
> @@ -2730,6 +2729,31 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
>  	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>  }
>  
> +void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
> +					 const struct amdgpu_buffer_funcs *buffer_funcs)
> +{
> +	struct drm_gpu_scheduler *sched;
> +	struct amdgpu_vmhub *hub;
> +	int i;
> +
> +	adev->mman.buffer_funcs = buffer_funcs;
> +
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		if (adev->sdma.has_page_queue)
> +			sched = &adev->sdma.instance[i].page.sched;
> +		else
> +			sched = &adev->sdma.instance[i].ring.sched;
> +		adev->mman.buffer_funcs_scheds[i] = sched;
> +	}
> +
> +	/* Navi1x's workaround requires us to limit to a single SDMA sched
> +	 * for ttm.
> +	 */
> +	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> +	adev->mman.num_buffer_funcs_scheds = hub->sdma_invalidation_workaround ?
> +		1 : adev->sdma.num_instances;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>  
>  static int amdgpu_ttm_page_pool_show(struct seq_file *m, void *unused)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 3b1973611446..a6249252948b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -67,7 +67,8 @@ struct amdgpu_mman {
>  
>  	/* buffer handling */
>  	const struct amdgpu_buffer_funcs	*buffer_funcs;
> -	struct amdgpu_ring			*buffer_funcs_ring;
> +	struct drm_gpu_scheduler		*buffer_funcs_scheds[AMDGPU_MAX_RINGS];
> +	u32					num_buffer_funcs_scheds;
>  	bool					buffer_funcs_enabled;
>  
>  	/* @default_entity: for workarounds, has no gart windows */
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index 22780c09177d..26276dcfd458 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -1340,8 +1340,7 @@ static const struct amdgpu_buffer_funcs cik_sdma_buffer_funcs = {
>  
>  static void cik_sdma_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -	adev->mman.buffer_funcs = &cik_sdma_buffer_funcs;
> -	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
> +	amdgpu_sdma_set_buffer_funcs_scheds(adev, &cik_sdma_buffer_funcs);
>  }
>  
>  const struct amdgpu_ip_block_version cik_sdma_ip_block =
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index 0090ace49024..c6a059ca59e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -1235,8 +1235,7 @@ static const struct amdgpu_buffer_funcs sdma_v2_4_buffer_funcs = {
>  
>  static void sdma_v2_4_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -	adev->mman.buffer_funcs = &sdma_v2_4_buffer_funcs;
> -	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
> +	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v2_4_buffer_funcs);
>  }
>  
>  const struct amdgpu_ip_block_version sdma_v2_4_ip_block = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 2526d393162a..cb516a25210d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1677,8 +1677,7 @@ static const struct amdgpu_buffer_funcs sdma_v3_0_buffer_funcs = {
>  
>  static void sdma_v3_0_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -	adev->mman.buffer_funcs = &sdma_v3_0_buffer_funcs;
> -	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
> +	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v3_0_buffer_funcs);
>  }
>  
>  const struct amdgpu_ip_block_version sdma_v3_0_ip_block =
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 44f0f23e1148..d56be26f216b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2626,13 +2626,9 @@ static const struct amdgpu_buffer_funcs sdma_v4_4_buffer_funcs = {
>  static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)
>  {
>  	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >= IP_VERSION(4, 4, 0))
> -		adev->mman.buffer_funcs = &sdma_v4_4_buffer_funcs;
> +		amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_4_buffer_funcs);
>  	else
> -		adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
> -	if (adev->sdma.has_page_queue)
> -		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
> -	else
> -		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
> +		amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_0_buffer_funcs);
>  }
>  
>  static void sdma_v4_0_get_ras_error_count(uint32_t value,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 78bdfed0a7fd..67e9697301b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -2316,11 +2316,7 @@ static const struct amdgpu_buffer_funcs sdma_v4_4_2_buffer_funcs = {
>  
>  static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -	adev->mman.buffer_funcs = &sdma_v4_4_2_buffer_funcs;
> -	if (adev->sdma.has_page_queue)
> -		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
> -	else
> -		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
> +	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_4_2_buffer_funcs);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 52f4e9e099cb..86f5eb784d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -2052,10 +2052,7 @@ static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
>  
>  static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -	if (adev->mman.buffer_funcs == NULL) {
> -		adev->mman.buffer_funcs = &sdma_v5_0_buffer_funcs;
> -		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
> -	}
> +	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v5_0_buffer_funcs);
>  }
>  
>  const struct amdgpu_ip_block_version sdma_v5_0_ip_block = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index b4fb90cc8f7d..3fec838374b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -2056,10 +2056,7 @@ static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
>  
>  static void sdma_v5_2_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -	if (adev->mman.buffer_funcs == NULL) {
> -		adev->mman.buffer_funcs = &sdma_v5_2_buffer_funcs;
> -		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
> -	}
> +	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v5_2_buffer_funcs);
>  }
>  
>  const struct amdgpu_ip_block_version sdma_v5_2_ip_block = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index b005672f2f96..064508cecd11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1895,8 +1895,7 @@ static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
>  
>  static void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -	adev->mman.buffer_funcs = &sdma_v6_0_buffer_funcs;
> -	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
> +	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v6_0_buffer_funcs);
>  }
>  
>  const struct amdgpu_ip_block_version sdma_v6_0_ip_block = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 5679a94d0815..60447729271e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1845,8 +1845,7 @@ static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
>  
>  static void sdma_v7_0_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -	adev->mman.buffer_funcs = &sdma_v7_0_buffer_funcs;
> -	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
> +	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v7_0_buffer_funcs);
>  }
>  
>  const struct amdgpu_ip_block_version sdma_v7_0_ip_block = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> index f20e0fc3fc74..c3428d2731dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -1764,8 +1764,7 @@ static const struct amdgpu_buffer_funcs sdma_v7_1_buffer_funcs = {
>  
>  static void sdma_v7_1_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -	adev->mman.buffer_funcs = &sdma_v7_1_buffer_funcs;
> -	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
> +	amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v7_1_buffer_funcs);
>  }
>  
>  const struct amdgpu_ip_block_version sdma_v7_1_ip_block = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> index 3e58feb2d5e4..155067c20a0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -833,8 +833,7 @@ static const struct amdgpu_buffer_funcs si_dma_buffer_funcs = {
>  
>  static void si_dma_set_buffer_funcs(struct amdgpu_device *adev)
>  {
> -	adev->mman.buffer_funcs = &si_dma_buffer_funcs;
> -	adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
> +	amdgpu_sdma_set_buffer_funcs_scheds(adev, &si_dma_buffer_funcs);
>  }

I think all those single line SDMA functions can now be dropped as well.

But that's not a must have for this patch here, so Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

>  
>  const struct amdgpu_ip_block_version si_dma_ip_block =
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 964efa325908..28dc6886c1ff 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -129,13 +129,14 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
>  			     struct dma_fence **mfence)
>  {
>  	const u64 GTT_MAX_PAGES = AMDGPU_GTT_MAX_TRANSFER_SIZE;
> -	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> +	struct amdgpu_ring *ring;
>  	struct amdgpu_ttm_buffer_entity *entity;
>  	u64 gart_s, gart_d;
>  	struct dma_fence *next;
>  	u64 size;
>  	int r;
>  
> +	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>  	entity = &adev->mman.move_entities[0];
>  
>  	mutex_lock(&entity->lock);

