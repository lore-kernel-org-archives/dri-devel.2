Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C15F9D0CF
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D832810E604;
	Tue, 14 Apr 2026 13:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="PajaCFDS";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="b1MQjeyt";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E432D10E603;
 Tue, 14 Apr 2026 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1776173755;
 bh=wuqJ0+8tTQrut8cYFWRTqT9
 IuBwrUL4CCq0juHDOsCI=; b=PajaCFDSxzBnFn0R3G8s9s+buN6l43SjgvHAifLnNq88vTdH4c
 SZvioWDcg95E60qudky+dKujJRhzvECiBW6mA7QlVMpDlx/N6SpKBYMZeqv7AWRsl9X2ypba7Av
 Zbq/AWccxXLg4iZq2V3FtPX9XnzemcYihMKio03ppcKr8E6Ag4PF6Id01k8JCqYg7vnKv6G5BI6
 fIBwnHGegcDKB4TQDuGw2iXDYDAnzAl/NQG4fHuCQX7KBkNbsLFhmmQ3XE/nIt4G8Ul/u9rnUcy
 uhNMkUDoiOTijwaVFIVWO9UObgRTF46RHiIIOUtT+D5QvWfUMBuk7zu5TbG2nbezDGg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1776173755; bh=wuqJ0+8tTQrut8cYFWRTqT9
 IuBwrUL4CCq0juHDOsCI=; b=b1MQjeytOeqHUhdxmpAzLq1uwojU8Fuprt2d9s1fepdjc6EKQ3
 SJu4mSoV9p2LPJzljd+LY32vlQ7UWd994kCw==;
Message-ID: <5b68bfbd-1821-46b9-8ac9-552735474a05@damsy.net>
Date: Tue, 14 Apr 2026 15:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: fix root reservation in
 amdgpu_vm_handle_fault
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260414122523.3645-1-pierre-eric.pelloux-prayer@amd.com>
 <2990351b-f3d8-4a6f-9902-9d558c444449@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <2990351b-f3d8-4a6f-9902-9d558c444449@amd.com>
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



Le 14/04/2026 à 15:30, Christian König a écrit :
> On 4/14/26 14:25, Pierre-Eric Pelloux-Prayer wrote:
>> svm_range_restore_pages might reserve the root bo so it must
>> be called after unreserving it.
>>
>> The code checking that the VM still exists can be moved in the
>> "if" block, since the VM can only be removed when the root bo
>> is not reserved.
> 
> That won't work like this. Dropping and reacquiring the root BO lock is a pretty big nono.

OK.

> 
> I think we need to fix svm_range_restore_pages() instead.

Alternatively I can modify the code from amdgpu_vm_lock_by_pasid to only reserve root when
"vm->is_compute_context" is false (or to never reserve root and leave that to the caller).

Pierre-Eric

> 
> Regards,
> Christian.
> 
>>
>> Fixes: 32b486e8541c ("drm/amdgpu: extract amdgpu_vm_lock_by_pasid from amdgpu_vm_handle_fault")
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 35 +++++++++++---------------
>>   1 file changed, 15 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 63156289ae7f..d86be0108913 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2975,25 +2975,12 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
>>   		return NULL;
>>   
>>   	r = amdgpu_bo_reserve(*root, true);
>> -	if (r)
>> -		goto error_unref;
>> -
>> -	/* Double check that the VM still exists */
>> -	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
>> -	vm = xa_load(&adev->vm_manager.pasids, pasid);
>> -	if (vm && vm->root.bo != *root)
>> -		vm = NULL;
>> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
>> -	if (!vm)
>> -		goto error_unlock;
>> +	if (r) {
>> +		amdgpu_bo_unref(root);
>> +		return NULL;
>> +	}
>>   
>>   	return vm;
>> -error_unlock:
>> -	amdgpu_bo_unreserve(*root);
>> -
>> -error_unref:
>> -	amdgpu_bo_unref(root);
>> -	return NULL;
>>   }
>>   
>>   /**
>> @@ -3026,11 +3013,19 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>>   
>>   	is_compute_context = vm->is_compute_context;
>>   
>> -	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
>> -	    node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
>> +	if (is_compute_context) {
>> +		/* Unreserve root since svm_range_restore_pages might try to reserve it. */
>>   		amdgpu_bo_unreserve(root);
>>   		amdgpu_bo_unref(&root);
>> -		return true;
>> +
>> +		if (!svm_range_restore_pages(adev, pasid, vmid,
>> +					     node_id, addr >> PAGE_SHIFT, ts, write_fault))
>> +			return true;
>> +
>> +		/* Double check that the VM still exists. */
>> +		vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
>> +		if (!vm)
>> +			return false;
>>   	}
>>   
>>   	addr /= AMDGPU_GPU_PAGE_SIZE;
