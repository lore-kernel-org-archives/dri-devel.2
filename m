Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41F5FD5F94
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DD110E585;
	Wed,  8 Apr 2026 08:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="GvNX4EKk";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="bmZjPCWl";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C41210E585
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1775636774;
 bh=+qpGNZpM/4zlDBjPSmbKKvW
 1+lrka7rHduPuKMaiudA=; b=GvNX4EKk8fC9QPwE7fnNl5xP+v66Lub+LYWxC/oEfFcdJ3MYde
 8nRpufZ62K5CvuOfRvXleuCWWRWfQsMXYII0bNe25LnbEQ5MmGTwah3txJzYadgIBbkcFW+FYNP
 M86yjpLOAaCktNy7pXJckssOSVMa+bIN0NnlcE4ZYRfL7cgbBQBcqI1gT0f3h/ZM8NBy7b4NwaN
 QlWNMq3XWyUGBIp8GuJ/UCrqz8xLZa0bno3Vn908n1mmKoQwYCtYULjGwDFWmCH3WP1mKVTQELC
 ABC3cM8rEae8uvNmo7D0gkqPrZ669NYTfLZMzoYbcThvR/LYyr/z0z7Vq4wvu0yPPHQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1775636774; bh=+qpGNZpM/4zlDBjPSmbKKvW
 1+lrka7rHduPuKMaiudA=; b=bmZjPCWlf25rT+rt29D4AjqY0HNNUXddKH9lYxXQy4w1z91CQr
 4feg8EsFP1MOZ5fuXK058OXPyl3aC8fSAcCA==;
Message-ID: <cb980ffb-1180-4613-a801-6e8bed5d669c@damsy.net>
Date: Wed, 8 Apr 2026 10:26:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] drm/amdgpu: give ttm entities access to all the
 sdma scheds
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
 <20260403083602.1771-4-pierre-eric.pelloux-prayer@amd.com>
 <c9123064-413d-4cf3-b39f-5268cedcf92d@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <c9123064-413d-4cf3-b39f-5268cedcf92d@amd.com>
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



Le 07/04/2026 à 12:05, Christian König a écrit :
> On 4/3/26 10:35, Pierre-Eric Pelloux-Prayer wrote:
>> With this change we now have as many clear and move entities as we
>> have sdma engines (limited to TTM_NUM_MOVE_FENCES).
>>
>> To enable load-balancing this patch gives access to all sdma
>> schedulers to all entities.
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 83f6d00dc3a0..648ad344e89c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -2349,8 +2349,6 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>   		return;
>>   
>>   	if (enable) {
>> -		struct drm_gpu_scheduler *sched;
>> -
>>   		if (!adev->mman.num_buffer_funcs_scheds) {
>>   			dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
>>   			return;
>> @@ -2358,11 +2356,10 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>   
>>   		num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
>>   		num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
>> -		sched = adev->mman.buffer_funcs_scheds[0];
>>   		r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
>>   						  &adev->mman.default_entity,
>>   						  DRM_SCHED_PRIORITY_KERNEL,
>> -						  &sched, 1, 0);
>> +						  adev->mman.buffer_funcs_scheds, 1, 0);
> 
> Why still giving num_schedulers as 1 here???
> 

Because I think multiple schedulers aren't useful for this entity. But if you prefer I can pass all 
available schedulers to all ttm entities (in which case I'd remove the parameters from 
amdgpu_ttm_buffer_entity_init).

>>   		if (r < 0) {
>>   			dev_err(adev->dev,
>>   				"Failed setting up TTM entity (%d)\n", r);
>> @@ -2380,8 +2377,11 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>   
>>   		for (i = 0; i < num_clear_entities; i++) {
>>   			r = amdgpu_ttm_buffer_entity_init(
>> -				&adev->mman.gtt_mgr, &adev->mman.clear_entities[i],
>> -				DRM_SCHED_PRIORITY_NORMAL, &sched, 1, 1);
>> +				&adev->mman.gtt_mgr,
>> +				&adev->mman.clear_entities[i],
>> +				DRM_SCHED_PRIORITY_NORMAL,
> 
> That should be DRM_SCHED_PRIORITY_KERNEL, same below.

OK, will update in v6.

Thanks,
Pierre-Eric


> 
> Regards,
> Christian.
> 
>> +				adev->mman.buffer_funcs_scheds,
>> +				adev->mman.num_buffer_funcs_scheds, 1);
>>   
>>   			if (r < 0) {
>>   				for (j = 0; j < i; j++)
>> @@ -2400,7 +2400,9 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>   			r = amdgpu_ttm_buffer_entity_init(
>>   				&adev->mman.gtt_mgr,
>>   				&adev->mman.move_entities[i],
>> -				DRM_SCHED_PRIORITY_NORMAL, &sched, 1, 2);
>> +				DRM_SCHED_PRIORITY_NORMAL,
>> +				adev->mman.buffer_funcs_scheds,
>> +				adev->mman.num_buffer_funcs_scheds, 2);
>>   
>>   			if (r < 0) {
>>   				for (j = 0; j < i; j++)
