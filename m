Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9B3C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E03410F629;
	Thu, 24 Sep 2026 14:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N0Bsh2JG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011063.outbound.protection.outlook.com
 [40.93.194.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9171210F626;
 Thu, 24 Sep 2026 14:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awJ59NDII0E+EJ0Unh4LQ6MYDdtw6N1JlOcAYlgfhK0pkVsfc0Y9yqvjZU1w5V7IQrcS7ZM6CB7Dxg7vOt5pbJnpTb3QlAlOJhE0e8xt6rZwSCv7Hpxx2bDwfoaZfgbTkeDbWtC+FbgtYMSiT6bONeoSU6/CQMYX+JJHxfx8s3S6fn8KEdGysh+q7H+wUu0kx5vSgizRhHGQL79ly5A1+BCeKcWTuGr4pKT7xb8CtWExt3LD17QsS/3jSeLyJLDdj6fmNbwvi5GBVCjvGDobQpoz00Xdji2AH2xI0yUHx05OmttOJzbDNfbOqBP+gs3vAAEEIOVUHtx9Tz+KkfA29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUgM1aiIIX77RaHxNQ5tFH6tOI5LJSpdDgfd9LTd0Ns=;
 b=qzUPUzkE/lU5bkxJXtaesmkotfg1bogsPbn33vEezACYRXb+c9OldoVjMqfI6P3uKOii3c1nVuqWRoEtbBGu2NYaHW51NlgCQgpwSyAA5liFkRlhv5fP2wOHoc0udXrcmuMIXIILKTX54WY27HdWU3NBhMaxLDOfDuZuKAaol14yW1jv5g4m9lzGwTx7RY1hZlGGTgareWnOlJsPZImMN3ek58nzmKrAjQ+gxmNSwWZRUykYk1vf26a3hW5knJk4fF4C6Jp6mQgVFPKxEyYPkMWmBpZbdVMrrshC1OnO5XHdCXHSPgySTYjzJSkHAj3n3quiMwOP/CN7uw268lQBug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUgM1aiIIX77RaHxNQ5tFH6tOI5LJSpdDgfd9LTd0Ns=;
 b=N0Bsh2JGdAXyq2TzB6ekadSr6zl7k+r7DohRbGXtak0fbJlSnr0eiCkvGp610OnFO6p3SrykXyTFqh4O4Jc4eeknc6sKaPwwby+b/+XjOkjVPV10U1y8Lr4x4/527QUHcSY1Tfyb+o3TZUAvzuXicZiVvJAJcUO6ssOOnBt3UMM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 14:57:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 14:57:08 +0000
Message-ID: <76909ea7-cea4-49cf-9a6c-6af260ff3728@amd.com>
Date: Thu, 24 Sep 2026 16:57:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: implement workaround for sdma dcc
 corruption
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260924140616.2647-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260924140616.2647-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: cb21c566-5fbc-4969-0529-08df1a4c1b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xS7ajhfcAdtgUK2E0OyLiHCFHIwfRLU+C0HSdbHRHv+ufTGKfw9bfPfHRcLVAGqNnLwkW6CNvZG+Q/4RnVxOv3o6F9icX8jxKgxfVOgJXnDwMBKTJvaMnZx9eRGmuS7mqaTwYVEevIzCNP3+619WrOAFBW2W8TZ+4Lzr1tYoWSrmn9K+Gz1yIVjsaTpBxbXMHd0seSE5BZS4N9M28BifbgmLMTXuUjual9RGZ3M68In0w3tcAbhVWFtrtvIQjXTUQeHN694vWwfbtBEeSElAZ0yC67C0PbpnXMyNEaH/iP6TE5HUf772wmcY/hOsohzXGhHKzGBKHbk35o2Qf32K+F2PyD/uEgVPSHXWkCZeH6UAqK7JrlsRFUcP9FQfbXW/DqqEaBkVMGsTFsHpMagCtDGU+jQePSbMm9r7SfZp4A3ygqtftpKW2rWo4VUikvvQZnPycS1GWoW1F4IwZKvtr+MzQ2izt7kFuV5au9i28/uYjZErd4sPhjc0Y2vYrpF9pLKlqeNQXHMqVkOT5IrRGQgcTwCSJZK9ihffDzTlH5W9hjPiaQQ/bB/qEjEWALAYnDLN+ftahzotO8kCBLFdjWjLasP8xSKHee5PIgiT9ChutNYBKIk3U/j6LQXxX7Xj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDZoWExDRmhHQkdZdjBLWDVNZitsZU1tcGRFNndDR1NqRWhSSVhwOHM2TGY3?=
 =?utf-8?B?RWxDcXp5U0VZQjZYZlRzQ1JsdVA5WUFsNzdGRWI1TDRIZUwybktoUDhtWW1s?=
 =?utf-8?B?UkFtOGwvZXhodFlwb0ZsY2wxSW9qR0RvcGIrWUFRVWJoTzFnN1B4RkJXYjJD?=
 =?utf-8?B?T1dUbEVJWHB6VUtFSjh2Z213emt5UkQ0eEVKYjM3dWdZNExsOUFMZDZTRVY3?=
 =?utf-8?B?bWVLdzNqWjFOQ2FsU3I0TjNRRWEyakNIMk1WUXV2TENQVnV3L3RUMEVvYUpW?=
 =?utf-8?B?dHdSWDNWZkdaWE9IQ3RUWG44Mmd4RXpsMmNhaUU1ZUFWakFyMllWVElRWGQ0?=
 =?utf-8?B?OWJpaXRWaTFmQ1cveTBqNlN2ZklwSlQzQUpJQytOU3ViV3NTRyt6L0dCWU1o?=
 =?utf-8?B?UWVhNUF5bXo4Sk9CSGY1TzNnM0I5dFVRVkJVZHZWRkNVL3Zjc0Z3ZFViZUNt?=
 =?utf-8?B?RmFXQ1dsOWM1SVp1OUFGbi9GNmlmTmtQMUdJMHh5ZlBDbXhldzRINnZhMUdp?=
 =?utf-8?B?OGc0b29IbmorZ1ZlWWFMeEdmellWbXdkK1pvdllyNG5QQlljL1VJVTVnUHlx?=
 =?utf-8?B?Zy9lTFhxRFRuODNsNG5IODh6RXk1QXAxaHU5MHJEbFlZWVB3b0pia1lBOVRR?=
 =?utf-8?B?cmdiaHdoWkNZUXZRZ3BnTU50MGJFQkU0Sm00SVQ4R3Vjcjg1ZEhMd2RVOFFl?=
 =?utf-8?B?N25zcjNtc09uWFdGMWNmcjNhQWlKN3hDZDU3Q1N5M2N3WUVRWWlFbEFaNVpo?=
 =?utf-8?B?bWxMVjlqZlo2K0FlOGE0NWFLSUR3MHljSCtWNDFSWE9Ub3VFODFrcXYwdGlL?=
 =?utf-8?B?ai9KQnhmclMzdTlMTXRuS0gvdW94QkFPVVdBR0ZITkZRejFiVExmc2NSZ2Jm?=
 =?utf-8?B?UGQwd2x3eGMzVE1UcUNHaU1OUmU2WlNJOFNRdmJseWlieVprb25rbFdUaDQ1?=
 =?utf-8?B?RS9FTkZDUm1YRjRyK3dUZUIzN0h6aVN0YkZZKzlRUWpFSWdlZEZock1VbW1G?=
 =?utf-8?B?YVlDc1IzY3FQaWY3TnNoQmVGNXQvTHhsWTQzWWhkM1dIbk0vU1hNZnh3b2o5?=
 =?utf-8?B?Q3Q5YlV5RlVsZGcyTmpmTEV1YlF6RisyUG9xR3ZLaU9XdUtacWYySUQxazlL?=
 =?utf-8?B?K0tUV3hHNkdHcUdQTVYwM0t0aVVnZ2lQN3ljL3VZSmxqS3ZHK2oyZkFHTjY3?=
 =?utf-8?B?amcydE9CbWFncUFjR3hNTnByUW04b3lycjZiSGM1alVCQ1NYOXJRbmJDcG5w?=
 =?utf-8?B?VktjaTBEczhzK3EyMExqdTlaYkdMbCtQeDR2TkltSWltY3VIc0RsVU5Na1V3?=
 =?utf-8?B?WDRYVGxhd1d5K2ltbHdZTTN2N0J5MmF3S21aMHdDWkdpMGl6Qlc1N1N3SUlP?=
 =?utf-8?B?bzNhREJRcnpNeGVTSzRReEFIOGRjSmFyazlka1pmWEFqb0hxWnZVd3VMQlBI?=
 =?utf-8?B?YWhWNzU2dDBoM0VZZzYraUF0eWVDTXZVRVRnUndhZVF1b1ZtWHVuUUJtTG9G?=
 =?utf-8?B?SFRoblFSa0dOMitOL2JQTzQvUldlZU1jMHZzV2FpSk5oK2JYZFhXVWZOaG5M?=
 =?utf-8?B?TzhhVHhQVHlxaU81a2hRb3dOa2czdEtRQ3BNYUd1VDJKSkVxcDNhUE9XOTNK?=
 =?utf-8?B?d2dBRE1zdXV0MXJoMFc4eS81UnZ4RmpFWlNyMmh2SzAwU25tVVF3RytGd3JS?=
 =?utf-8?B?TjF5eWNiTENiWWh0QmRSSlVuS2FVVnhtSndtdXRLSkxGWXF4U29rbG5kcXNO?=
 =?utf-8?B?WklBVGNoM3VQbHl0L0FRdEFaZ3RiT2RWd2dxZnVlNnlOamwyV3FVMXBKWWpi?=
 =?utf-8?B?UWpjTEo1R3hzR0xNZGJYVFpOV0l5TXFRV053QnpHVzJKNzNZOHVkOHI1Sjl0?=
 =?utf-8?B?UndCZ1VXd25uYmdWWWtveXBPdFpYZGNJRW1MTkliU2wyRWVaUVpnUyt0VmEx?=
 =?utf-8?B?V29qY0FWRXk5ZHFFOXBXNHFOam5QZEtoQlh3Ukl5UllQNWFDUG9HUkg2Um80?=
 =?utf-8?B?dDRpbGx0d0lGMzV5ZWNzSTFZb1dJTS9ISWpLY1VVT2p0Y1A4RG1XNXRSbm1t?=
 =?utf-8?B?dEpuUWRBaWVLNzJtWWt0YjRXazAwTHlwSldHUjRHbGM3U0txVmE0QnhUbGow?=
 =?utf-8?B?TUZLWDR0WG1WUVlHR2UxTmR0VXA1ZzVaaFRmTWRlUUJYekQ3QzM5RHpBQ2tV?=
 =?utf-8?B?Y2VVN1lwQk1DR1g3OVBSUWdZY2Q2WmFJcHZrWGpyQjZrdVZiMnVOY0cvdUw1?=
 =?utf-8?B?YytIM1BKc2duNlZhM2FrcGdYYzFndUYyZWwwY08wQUdKUXMvNU85ZkxEejhG?=
 =?utf-8?Q?c6BpxOSPXbiFKH1Kk8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb21c566-5fbc-4969-0529-08df1a4c1b2f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 14:57:08.7409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEi/NprheQxpDu9kotCtrv4tNlPuOFB+hQk3CDhpS6iV++YtC5gFuJT7gz2NS677
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
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

On 9/24/26 16:06, Pierre-Eric Pelloux-Prayer wrote:
> For unknown reasons, on gfx12 using multiple entities can causes
> random corruption of BOs with DCC.
> This workaround seems to prevent the issue until the root cause
> is understood and fixed.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5663
> Fixes: 3a6f6eeb3db5 ("drm/amdgpu: give ttm entities access to all the sdma scheds")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 3d620ec2937f..e9de5c4b7f63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2367,7 +2367,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev)
>  {
>  	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
> -	u32 num_clear_entities, num_move_entities;
> +	u32 num_clear_entities, num_move_entities, sdma_ip_version;
>  	int r, i, j;
>  
>  	if (!adev->mman.initialized || amdgpu_in_reset(adev) ||
> @@ -2392,6 +2392,12 @@ void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev)
>  
>  	num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
>  	num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
> +        /* TODO: workaround for DCC corruption when moving BOs from multiple queues at
> +         * the same time: use a single queue until the root cause is identified and fixed.
> +         */
> +	sdma_ip_version = amdgpu_ip_version(adev, SDMA0_HWIP, 0);
> +	if (sdma_ip_version == IP_VERSION(7, 0, 0) || sdma_ip_version == IP_VERSION(7, 0, 1))
> +		num_move_entities = 1;
>  
>  	adev->mman.clear_entities = kcalloc(num_clear_entities,
>  						sizeof(struct amdgpu_ttm_buffer_entity),

