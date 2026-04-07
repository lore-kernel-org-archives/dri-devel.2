Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DF1EDB7E8
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7E510E3BC;
	Tue,  7 Apr 2026 10:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RMXX9bcl";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB5710E3BB;
 Tue,  7 Apr 2026 10:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nn3XAXHjHxp6qZzmUlz/Nfi4xVX1MJfNpHN0z+aakywRcbK82f/VTb7tVTTWLFYalQjz4EAYJHX1JTOH3CCZZ9G0fCV/jpBsD+vcZ0swKjJDg1MbXgPtSaNMmVeLeLxS1e0ywx1xCDqSKS9jMZr/lG0yVjedJ0BdI5AAsVBasvgShbr9aFpScqemgBOU6wo1hjvTqeWhg2VOV4RxyHU3r49qLNj0UMWELvEtlLAhfIq7aU63xhPxVjdM4lLVREi0bI+8SRyy0rlI0dc0d4A6KOvU0BYCd5NnVBPeKwoH4d5a80s2+KsNsmvMdLvQl85z3XHSKJnZBDFhKAXKWjwwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOEegJjGQJ4cvjiwt8wihrYgXWKvcVrs8kQUp1TJ/fo=;
 b=tz3lWFC9Z5YL0aNoVLlAfHlUC8icaCvNUi2nOGVMn7UQ/fCQDc70507Kmt56Q7yN274QWXxU+jpriQRKcQnsh8YvZYoftKJBNo8UIohHamNfLDEpuC913qDiwjPx5PH0Xld6y5KpVHtWW/9IpSeC6n7sHgQhy7WkWNjekasQti8jWlgJYGh3R/SRMXSpVUcxWiM74IuH6rTxX9GF4EQAgK6PpWBlVbCBgOOHlTDLsO9tfx2ZwezCbElMNZnYZMfmy/xGsYwXVuvijAgUHhKvfFAMrfSgRe6YC6CkI11dM6BdY4JIE3PjTcMXxDps0R8ZMKjfdHwKQSfpez74dblLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOEegJjGQJ4cvjiwt8wihrYgXWKvcVrs8kQUp1TJ/fo=;
 b=RMXX9bclj+O2ml3FGajsT0KHq/tYeZ2vh6NqhfK7e1dNEhXNa8ZuyTi9KWyNVnWKNpHg4SSOQx39diE+C4yb11OeNrlEah43C1cxIU7zvPwq+aMGto0OqbT4he00+0hsiERrpXAUt7vOxvCkcdFslXcxUncAulZp57xoCjuOVBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 10:11:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 10:11:17 +0000
Message-ID: <a85bc6d2-aa0f-485b-84cb-84d0c9f935fb@amd.com>
Date: Tue, 7 Apr 2026 12:11:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] drm/amdgpu: get rid of amdgpu_ttm_clear_buffer
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
 <20260403083602.1771-5-pierre-eric.pelloux-prayer@amd.com>
 <1b46bb85-dcaf-4eee-b5ae-110d711107db@amd.com>
Content-Language: en-US
In-Reply-To: <1b46bb85-dcaf-4eee-b5ae-110d711107db@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0302.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: e85879fe-6b12-4a87-e53f-08de948e0200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: m/DDhOAwl9AeBgSAuwGMzgBGHs6+8laMqj0ymMYNbKus5wEtsNUNMxttRaf0SECJ4xQhtNnySyhjrVej8oJuDF13/CrdC545m1Wm1hDA2dVwIr4SUgMNwzLuT7b71acScUzC7soVXUiV1m7bprw7nDev/ysfPJYmZH22V0njbjRdIOqsXBPFUgeZJxB/IBtMJ8B2GyW+tZlN/hNc1VpxnCIIzMjJzEcB/RnQBrx4ETn1DAIqweE/mcEe/Ak+RFfVICwWYpfZeq2Lnj7Uox/LlTiWQ9no83CpSVpqARgbyNTVVuGvfe6W9W8M6Ye6kxgGmg5siFtL9IHwd6Qu4WR2Uf82uRlbxzRrU0LbBpfeK70XnpNNR99JQI127EDveAAqzYYf7pXG44w2GKiVVhmRFViuKtn30oCkvfs32hKjqK9anm9cC3pVFIRTaaZWmL9v2YjMT4Ce29Nwk/rhYrrUUZVxHoo2mFYnLDVTlL3mkyFOgvF1m8EMU/7e0NAvEaLRIEB3h6agQ/zeGnuivPh0x65ZrG8drurfHk/GDD6nwtq6hBsjrHsLt8NyM4Jv2zfTIj3U8Xcz74HyetxJ2DdOoKF0juvTOmxjwjhM0lpWqkg+0Fx/hoUZtj3qFjV5aCi/ZLUIJSegECepK6iayFtUcQuwdTjQv8uDhqQddxCJ/QntzJvgWswqFD1eEpCgW5R30s6mdXCVJm7cFUlvGo0pGfCg1PX27F/PLj85o1kzyCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUd6Y3I0bVRaUnI2NlhHSXVCYWgrcDdGSkpMdUttbTE4K2NNOTRXQTVZbWgv?=
 =?utf-8?B?Uk8zdUgzd3R6ODFGQzJYcG9meVNBVThSNEhuRjBTanRsWTluMFk5eW5wWmw2?=
 =?utf-8?B?ZW8xdG82WWxPdUhtQnhjT0ZDUmZhc1N2M1JiV1Z5QWsxZFNvSzZNcWZjMHdx?=
 =?utf-8?B?RW9tb21WOWlSZ3RhOXdaSmoxM1k2WWlPK25PNjNCWkUxRk1JZWR0SjAzYS85?=
 =?utf-8?B?bnlqRDh6czgzOUF6b1N4cTQ1NzdSRlFsaUc2eVpLQ3FVaDcwcmpjMmZZd0sw?=
 =?utf-8?B?TkdIQkZHc1RBSkNLdDFaVytUWEF6djcvdzBSdXNjb3h1dExrTWRCTGxtc2xF?=
 =?utf-8?B?UWhZWFEySmViNEN2UGo2bExxc3p4SjVPYk1JWXcydldyYmt3TWM4Q3EwcFMy?=
 =?utf-8?B?L0k0RkVDbkIzanJ3OVFWREFKa2hXUlhLaWJnSjBUaGMvcFJNSzZZTjVaUUlB?=
 =?utf-8?B?LzV1UGp0UFUwcjJVMHN1RGpxTHZKcGlPdXhlMHFwVjRXN2JDWTI2ZlBjcDV4?=
 =?utf-8?B?RmVpcnpjb21OMCsydlNZdTdveEpUSHI2c0R3RWNMNVY3dThPRytEWDdTVGJi?=
 =?utf-8?B?Q2FCTWZENmpmU3Z0SkNMampHSTdQT1c4dXJ4cjFndnlOVFNDdG9TbXBDYWZQ?=
 =?utf-8?B?Mk56aG1LSlFPMmtoMDZOS2l5SGVrRWNGcFBUaVlIbC9Qdy9vMjJUWlB1MGhN?=
 =?utf-8?B?dkZhc2hVWXcxZVpzZldyUmtTdkdHYWdPeWhJUHpncFZEOUl1NSt3Z3h4ZGp3?=
 =?utf-8?B?NE0vcTB0YTBmQWZ4VU43UzdRMEQwTTEzRXRHS240UnpXQ2NwQis2V2gvWExN?=
 =?utf-8?B?U3d3Z1hkaUpJY0QzMi9OT09pTlFMTVZkbFZKaEtuT25xMnZyRkxMSVJSZC9i?=
 =?utf-8?B?TUlCR2lFT24xb3JtNllxR0NlOVQ5TEVRZlJib2dWZGZZZlZJVHBlYW5qb0xq?=
 =?utf-8?B?TkdNK3M2UWNvcDV0YVdFQzFpUWRzWVBrc1d4S042ZTQ5NjV6eUhmZnB0dXcv?=
 =?utf-8?B?Lzc0R2VWZEI4bS9sZ2xKa0tMNTY4bk9sbzRObmQ2KzNlTnA2K2VOaVR5T3V1?=
 =?utf-8?B?N1p5em16cVpPOWttNnNueHhTWEVDSGZZTS8wTEdIRUpTMThvK1NKOTBXVTRk?=
 =?utf-8?B?WHpTSEpuWnlVdDY1UnYzYlRsRFQ4TkwzTzd6Y3VJNVZFUm9oVTk2aHVXczFr?=
 =?utf-8?B?YlFTakxyajBVNVZrWEdIbjFZS0JZQUxLNEkwQlJQU0p4QWlyUERWNDlFQWZC?=
 =?utf-8?B?SThzdDl1UzNrVmk2cXlhcXB5czdnSmRBcmtNK3VtZWlnSExreGVXS3dpQ3pl?=
 =?utf-8?B?bGFBbFc4a1FPSUFxZSt2VCtHMjRycWtnVXFTVy8wN3lKT29CMUhwdDI0TmtF?=
 =?utf-8?B?UWtsZis2WjdkUkNoTktQUGYrRXR1WGtZdllhSFIwa3dQSXBTOEtnbDFvN2FS?=
 =?utf-8?B?dkNoQnFTVXQ5WFpXWk1ERTcwVTQxRk1BdE9HZW5ZRUUxWndyMkszaXJKWDNq?=
 =?utf-8?B?ZnlPMSt4bHNZV3pwUGRGN1NMU2NiY1J2bmxmYm1CaVgxcENmbGNpeDFVN0hX?=
 =?utf-8?B?RC9WRFBWWk1LbFVyRXFIVlYwdGZ0VFN1WnM0TDdwN1JQYXVMNFBpYlZmU0l2?=
 =?utf-8?B?OFF0eHlGblhjQjVQejdTeHBJNEJpTytGcFI4ckJnTmVmcFE2RVcwR0tsZ3lB?=
 =?utf-8?B?ajQvdEJtbnNJa3BEbDJveWdwall1MllORFB4cUJtdVFtY0pTbWE1QS9lRWM1?=
 =?utf-8?B?VHdGQm5KU29PUjlFZUJZMlU5NFl1SWdud2JJYUozdDV6ck9EU3pmU09mMTRY?=
 =?utf-8?B?NGVLTmxvZ3NyRFF1eHo1QkVuQUU0TER1NURkRmc5ak11U2xYaHBxanlQZFc3?=
 =?utf-8?B?cWs3bFdMYXdTeWpYdWtVbXNXdE9Fa2NyWENmTHJPRUxKTU5jUzE2TDRXRmN3?=
 =?utf-8?B?dlh3czd6VHZDRWpFb2tUKzZpQmVySjEyUTEwb2x6Q3YyZEgzbHgvZXJlVCtp?=
 =?utf-8?B?S2hYZjYwRStHSlB0YWxJcm5oK2IwOExmb256YnRXSjBtYXJ1K05NbXdTUXNT?=
 =?utf-8?B?d2FvUjEyeUVNcVNMMVlrYlZsclJaVnp1RC9KYlp0cWxHUTYyVXA5K1plZUJ0?=
 =?utf-8?B?L0o1enByUkpPckxhYlVsR1J0SVRSSmN0RTRabkdFVXM4ZDhWNXd3SXZwNmE3?=
 =?utf-8?B?OUtvcW56dHNWWEV2VGtTSUR3NXRYQy85K1JZbE9Oc0Zhc3dXdk9PM0hhY0Fw?=
 =?utf-8?B?YW5oQkpkbTFNejkyaWZDd2JrM0RBV2wyUldpUCt0ZFk5K3Bna0xYNng3bzF4?=
 =?utf-8?Q?p1cAAe8kydp3nU/YnF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85879fe-6b12-4a87-e53f-08de948e0200
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:11:17.5485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JcNvBi9hWpVNKnegYMhbMilpGUQe+tkb5oR+4JAIklJOjIU7dwTcdrD6QZOXatL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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



On 4/7/26 12:09, Christian König wrote:
> 
> 
> On 4/3/26 10:35, Pierre-Eric Pelloux-Prayer wrote:
>> It's doing the same thing as amdgpu_fill_buffer(src_data=0), so drop it.
>>
>> The only caveat is that amdgpu_res_cleared() return value is only valid
>> right after allocation.
>>
>> ---
>> v2: introduce new "bool consider_clear_status" arg
>> ---
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 16 ++--
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 88 +++++-----------------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  6 +-
>>  3 files changed, 32 insertions(+), 78 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 66c20dd46d12..d0884bbffa75 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -717,13 +717,17 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>  	    bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>>  		struct dma_fence *fence;
>>  
>> -		r = amdgpu_ttm_clear_buffer(bo, bo->tbo.base.resv, &fence);
>> +		r = amdgpu_fill_buffer(amdgpu_ttm_next_clear_entity(adev),
>> +				       bo, 0, NULL, &fence,
>> +				       true, AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>>  		if (unlikely(r))
>>  			goto fail_unreserve;
>>  
>> -		dma_resv_add_fence(bo->tbo.base.resv, fence,
>> -				   DMA_RESV_USAGE_KERNEL);
>> -		dma_fence_put(fence);
>> +		if (fence) {
>> +			dma_resv_add_fence(bo->tbo.base.resv, fence,
>> +					   DMA_RESV_USAGE_KERNEL);
>> +			dma_fence_put(fence);
>> +		}
>>  	}
>>  	if (!bp->resv)
>>  		amdgpu_bo_unreserve(bo);
>> @@ -1326,8 +1330,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>>  		goto out;
>>  
>>  	r = amdgpu_fill_buffer(amdgpu_ttm_next_clear_entity(adev),
>> -			       abo, 0, &bo->base._resv,
>> -			       &fence, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>> +			       abo, 0, &bo->base._resv, &fence,
>> +			       false, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>>  	if (WARN_ON(r))
>>  		goto out;
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 648ad344e89c..a3d0998b8cec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -418,7 +418,7 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
>>  	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
>>  		struct dma_fence *wipe_fence = NULL;
>>  		r = amdgpu_fill_buffer(entity, abo, 0, NULL, &wipe_fence,
>> -				       AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
>> +				       false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
>>  		if (r) {
>>  			goto error;
>>  		} else if (wipe_fence) {
>> @@ -2572,76 +2572,25 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>>  }
>>  
>>  /**
>> - * amdgpu_ttm_clear_buffer - clear memory buffers
>> - * @bo: amdgpu buffer object
>> - * @resv: reservation object
>> - * @fence: dma_fence associated with the operation
>> + * amdgpu_fill_buffer - fill a buffer with a given value
>> + * @entity: entity to use
>> + * @bo: the bo to fill
>> + * @src_data: the value to set
>> + * @resv: fences contained in this reservation will be used as dependencies.
>> + * @out_fence: the fence from the last clear will be stored here. It might be
>> + *             NULL if no job was run.
>> + * @dependency: optional input dependency fence.
>> + * @consider_clear_status: true if region reported as cleared by amdgpu_res_cleared()
>> + *                         are skipped.
>> + * @k_job_id: trace id
>>   *
>> - * Clear the memory buffer resource.
>> - *
>> - * Returns:
>> - * 0 for success or a negative error code on failure.
>>   */
>> -int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>> -			    struct dma_resv *resv,
>> -			    struct dma_fence **fence)
>> -{
>> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>> -	struct amdgpu_ttm_buffer_entity *entity;
>> -	struct amdgpu_res_cursor cursor;
>> -	u64 addr;
>> -	int r = 0;
>> -
>> -	if (!adev->mman.buffer_funcs_enabled)
>> -		return -EINVAL;
>> -
>> -	if (!fence)
>> -		return -EINVAL;
>> -	entity = &adev->mman.clear_entities[0];
>> -	*fence = dma_fence_get_stub();
>> -
>> -	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);
>> -
>> -	mutex_lock(&entity->lock);
>> -	while (cursor.remaining) {
>> -		struct dma_fence *next = NULL;
>> -		u64 size;
>> -
>> -		if (amdgpu_res_cleared(&cursor)) {
>> -			amdgpu_res_next(&cursor, cursor.size);
>> -			continue;
>> -		}
>> -
>> -		/* Never clear more than 256MiB at once to avoid timeouts */
>> -		size = min(cursor.size, 256ULL << 20);
>> -
>> -		r = amdgpu_ttm_map_buffer(entity, &bo->tbo, bo->tbo.resource, &cursor,
>> -					  0, false, &size, &addr);
>> -		if (r)
>> -			goto err;
>> -
>> -		r = amdgpu_ttm_fill_mem(adev, entity, 0, addr, size, resv,
>> -					&next, true,
>> -					AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>> -		if (r)
>> -			goto err;
>> -
>> -		dma_fence_put(*fence);
>> -		*fence = next;
>> -
>> -		amdgpu_res_next(&cursor, size);
>> -	}
>> -err:
>> -	mutex_unlock(&entity->lock);
>> -
>> -	return r;
>> -}
>> -
>>  int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
> 
> We should probably rename the function to amdgpu_ttm_clear_buffer() while doing this.

Forget that, I've just seen that patch #6 does exactly that.

Feel free to add Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> 
> Apart from that looks good to me.
> 
> Regards,
> Christian.
> 
>>  		       struct amdgpu_bo *bo,
>>  		       uint32_t src_data,
>>  		       struct dma_resv *resv,
>> -		       struct dma_fence **f,
>> +		       struct dma_fence **out_fence,
>> +		       bool consider_clear_status,
>>  		       u64 k_job_id)
>>  {
>>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>> @@ -2659,6 +2608,11 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>  		struct dma_fence *next;
>>  		uint64_t cur_size, to;
>>  
>> +		if (consider_clear_status && amdgpu_res_cleared(&dst)) {
>> +			amdgpu_res_next(&dst, dst.size);
>> +			continue;
>> +		}
>> +
>>  		/* Never fill more than 256MiB at once to avoid timeouts */
>>  		cur_size = min(dst.size, 256ULL << 20);
>>  
>> @@ -2680,9 +2634,7 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>  	}
>>  error:
>>  	mutex_unlock(&entity->lock);
>> -	if (f)
>> -		*f = dma_fence_get(fence);
>> -	dma_fence_put(fence);
>> +	*out_fence = fence;
>>  	return r;
>>  }
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index a6249252948b..436a3e09a178 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -187,14 +187,12 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
>>  		       struct dma_resv *resv,
>>  		       struct dma_fence **fence,
>>  		       bool vm_needs_flush, uint32_t copy_flags);
>> -int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>> -			    struct dma_resv *resv,
>> -			    struct dma_fence **fence);
>>  int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>  		       struct amdgpu_bo *bo,
>>  		       uint32_t src_data,
>>  		       struct dma_resv *resv,
>> -		       struct dma_fence **f,
>> +		       struct dma_fence **out_fence,
>> +		       bool consider_clear_status,
>>  		       u64 k_job_id);
>>  struct amdgpu_ttm_buffer_entity *amdgpu_ttm_next_clear_entity(struct amdgpu_device *adev);
>>  
> 

