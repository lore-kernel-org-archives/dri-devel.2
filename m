Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEF3FD5F99
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA7210E589;
	Wed,  8 Apr 2026 08:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="m913tN86";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="/Vn7FNg1";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC88710E589
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1775636896;
 bh=IUs+CEQnVM7B8OhrBHYwnjW
 oDMnj21vYP4RTDDhcnLk=; b=m913tN86eRMk//7KnW8P8WxRQi+tk/4Semmcuzj1cpIfr90nWY
 ku7xpD0ALTvCZUPF3EZcXKg71YDsXOHkMeep8Kkt2gXXKufN9wY7i9/2Y8m4wkKaWb6nRTfB3VP
 4QYx5bdO9HC72DmlkXBaLq6kFrwmjEjlWu+aNNMoYv+FGp37vMdbwFdGTg4QQeLuI+2FrpfRUUA
 Qc+7k+OzUvUbnKEJMT89ccwElEF31Ae8ixWpewhYgohJYLCRmQvdu+5yx+aEiWwxbSVf3GoUZ+J
 z/VolabLgChBUlqQJSorv9RH34coVGYdmYMyvL0UBeX6HbzJ+qNjyOR1gJmZ3UNHjMw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1775636896; bh=IUs+CEQnVM7B8OhrBHYwnjW
 oDMnj21vYP4RTDDhcnLk=; b=/Vn7FNg128JP4S6UFeq+y/pcxxTlT848677QPEr6dk3iQXJNSX
 b60dUUuzQJKRND5lOWleh4DFiZPigVwh5tAw==;
Message-ID: <5bbb4118-9151-425a-b359-2da33c6917f5@damsy.net>
Date: Wed, 8 Apr 2026 10:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] drm/amdgpu: rename amdgpu_fill_buffer as
 amdgpu_ttm_clear_buffer
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
 <20260403083602.1771-6-pierre-eric.pelloux-prayer@amd.com>
 <0c00c6ec-5834-42a3-b1a7-0bb81943bd98@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <0c00c6ec-5834-42a3-b1a7-0bb81943bd98@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Le 07/04/2026 à 12:16, Christian König a écrit :
> 
> 
> On 4/3/26 10:35, Pierre-Eric Pelloux-Prayer wrote:
>> This is the only use case for this function.
>>
>> ---
>> v2: amdgpu_ttm_clear_buffer instead of amdgpu_clear_buffer
>> ---
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 12 +++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 23 ++++++++++------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    | 13 ++++++------
>>   3 files changed, 22 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index d0884bbffa75..195cb1c814d1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -717,9 +717,9 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>   	    bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>>   		struct dma_fence *fence;
>>   
>> -		r = amdgpu_fill_buffer(amdgpu_ttm_next_clear_entity(adev),
>> -				       bo, 0, NULL, &fence,
>> -				       true, AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>> +		r = amdgpu_ttm_clear_buffer(amdgpu_ttm_next_clear_entity(adev),
>> +					    bo, NULL, &fence,
> 
> Wait a second. Why is the dependency NULL here?
> 

Good catch.

> Could it be that we relied on the fact that clears and moves were serialized in the past?
> 

No it's a mistake in the previous patch where the resv param was dropped. I've fixed it in v6.

Thanks,
PE


> Regards,
> Christian.
> 
>> +					    true, AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>>   		if (unlikely(r))
>>   			goto fail_unreserve;
>>   
>> @@ -1329,9 +1329,9 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>>   	if (r)
>>   		goto out;
>>   
>> -	r = amdgpu_fill_buffer(amdgpu_ttm_next_clear_entity(adev),
>> -			       abo, 0, &bo->base._resv, &fence,
>> -			       false, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>> +	r = amdgpu_ttm_clear_buffer(amdgpu_ttm_next_clear_entity(adev),
>> +				    abo, &bo->base._resv, &fence,
>> +				    false, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>>   	if (WARN_ON(r))
>>   		goto out;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index a3d0998b8cec..e74f9f8a88dc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -417,8 +417,8 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
>>   	if (old_mem->mem_type == TTM_PL_VRAM &&
>>   	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
>>   		struct dma_fence *wipe_fence = NULL;
>> -		r = amdgpu_fill_buffer(entity, abo, 0, NULL, &wipe_fence,
>> -				       false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
>> +		r = amdgpu_ttm_clear_buffer(entity, abo, NULL, &wipe_fence,
>> +					    false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
>>   		if (r) {
>>   			goto error;
>>   		} else if (wipe_fence) {
>> @@ -2572,26 +2572,23 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>>   }
>>   
>>   /**
>> - * amdgpu_fill_buffer - fill a buffer with a given value
>> + * amdgpu_ttm_clear_buffer - fill a buffer with 0
>>    * @entity: entity to use
>>    * @bo: the bo to fill
>> - * @src_data: the value to set
>>    * @resv: fences contained in this reservation will be used as dependencies.
>>    * @out_fence: the fence from the last clear will be stored here. It might be
>>    *             NULL if no job was run.
>> - * @dependency: optional input dependency fence.
>>    * @consider_clear_status: true if region reported as cleared by amdgpu_res_cleared()
>>    *                         are skipped.
>>    * @k_job_id: trace id
>>    *
>>    */
>> -int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>> -		       struct amdgpu_bo *bo,
>> -		       uint32_t src_data,
>> -		       struct dma_resv *resv,
>> -		       struct dma_fence **out_fence,
>> -		       bool consider_clear_status,
>> -		       u64 k_job_id)
>> +int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>> +			    struct amdgpu_bo *bo,
>> +			    struct dma_resv *resv,
>> +			    struct dma_fence **out_fence,
>> +			    bool consider_clear_status,
>> +			    u64 k_job_id)
>>   {
>>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>   	struct dma_fence *fence = NULL;
>> @@ -2622,7 +2619,7 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>   			goto error;
>>   
>>   		r = amdgpu_ttm_fill_mem(adev, entity,
>> -					src_data, to, cur_size, resv,
>> +					0, to, cur_size, resv,
>>   					&next, true, k_job_id);
>>   		if (r)
>>   			goto error;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 436a3e09a178..d7b14d5cac77 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -187,13 +187,12 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
>>   		       struct dma_resv *resv,
>>   		       struct dma_fence **fence,
>>   		       bool vm_needs_flush, uint32_t copy_flags);
>> -int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>> -		       struct amdgpu_bo *bo,
>> -		       uint32_t src_data,
>> -		       struct dma_resv *resv,
>> -		       struct dma_fence **out_fence,
>> -		       bool consider_clear_status,
>> -		       u64 k_job_id);
>> +int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>> +			    struct amdgpu_bo *bo,
>> +			    struct dma_resv *resv,
>> +			    struct dma_fence **out_fence,
>> +			    bool consider_clear_status,
>> +			    u64 k_job_id);
>>   struct amdgpu_ttm_buffer_entity *amdgpu_ttm_next_clear_entity(struct amdgpu_device *adev);
>>   
>>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
