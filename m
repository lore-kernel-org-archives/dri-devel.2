Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFFDC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E3C10FB1C;
	Tue, 15 Sep 2026 08:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="dCblNtuj";
	dkim-atps=neutral
Received: from smtpout9.mo536.mail-out.ovh.net
 (smtpout9.mo536.mail-out.ovh.net [51.210.91.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F035610FB1B
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:53:48 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hkbQy41Vpz88QW;
 Tue, 15 Sep 2026 08:53:46 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <Felix.Kuehling@amd.com>; Tue, 15 Sep 2026 08:53:46 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.54.195])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hkbQy2jX3z1xnN; Tue, 15 Sep 2026 08:53:46 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.10])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id BD736941C0F; 
 Tue, 15 Sep 2026 08:53:44 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S0062fb875ee-7c31-4641-b87e-a825690d011d,
 634639D5DEE1255606E722C812DAF3B2B8290A83) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <acc1e3eb-264c-4591-9f66-5fe93b96f97f@pixelcluster.dev>
Date: Tue, 15 Sep 2026 10:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: don't free mapping when
 amdgpu_vm_update_range fails
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
References: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
 <20260914-amdgpu_vm_fixes-v1-3-d6d835591e0f@igalia.com>
 <9c507259-f65c-4f18-8fc7-8e03de0c4f87@amd.com>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <9c507259-f65c-4f18-8fc7-8e03de0c4f87@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 547750305977950490
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFP1GB/Mq9ugbM65ptfFecNw4cE6zHrfZis2lK1tpIUbbCcsZCoCSFfIOYVagt4YIq6NPVPxnGw8Qn+mRW35l0FjHn7gkVpMsWM8Aoy8pg6AuYbdux3eM4ZnDMxpSrEhhRfu0D75a8OUHZCTD/D4eg6Veszz3P0NBvRChc5XjdNmB+xu1GWYUbP/aW2KD1Pm3bIIv1G1t1F6ePePgqMNDdjfqKRF1fgTbVHGZRcv9k6PMA6xy3ytIu6K7LKgLTuzVnzeH8XMZjX+ckOOvLPbZl8sl7W363UDy8pmdCJyYuxlXecjiWWPz0NFdUJIBR/wrFlHiSRQc1oU0AvNaQhSWetEFQo089szU/wSCVpVdOiFhWauRVD2iUJZlqzxkmOT/uP82ygCdOz8FNHJHGULPVqMrgCepOdeXEO3afwUKAjoS+QuDhhfzlTwQX7pQTzGAVO2cMov1jP6QJKuOEcGSA5AOjm8ek+vLMJkWw/Ui3GYfNR0CdUwzNzX3OUEgLUFH9F0OsMFaUifLWOt6v3RKxlYzcXo3IxkmY0SjJWqtpSieyey4M8BVmugQz06bojCyHmRvjXEcpfdlifHQ/rIeW9oHIfrrAeSudljTDXeRzFjeTspxJjrjy+0BPivI3bVpBLXFEP9Jx0Eef0djplfGgnoFdVQj4yGynCuu6LEQ3Qdw
DKIM-Signature: a=rsa-sha256; bh=WRp+mPf4zKF8qWvhUr9y9cqRugHJ5fNXfhoLK6UIoMg=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1789462427; v=1;
 b=dCblNtujZMaVqLQ5ejsv/FUac444JD5iLJ/cjyYv6Wmecsc9pxaiIDYjbyPPSvrfSLTUi4BG
 70FWkIHS1gMPdpCtFZbe1Twpw55foc1Gty8CT6sfhEYabfPcBhrc52kgJySHl7zeH1BMmDwdGX1
 s5tTh5mX5u5A9C9FoZnJ2kle7CZYEv0SLk7WPv9L+O+sbPW4nYL+Fi4AJik9N5nZpMb//RaazTD
 aSsKlnrwyJBpsc4244i1YpTEbcBFoKccbVvKqhzsJTPUTuDqLgWi0g+SiCFubuQaUxbMsoGHLn2
 2weeEVrAbDUR4ImuA6q8Vp1wKuHTr3q8M9rctk2DZ8fyw==
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

On 9/15/26 10:33, Christian König wrote:
> On 9/14/26 22:25, Thadeu Lima de Souza Cascardo wrote:
>> If amdgpu_vm_update_range fails when called by amdgpu_vm_clear_freed,
>> the clearing of that mapping will not be attempted again. Later on, when
>> an IB tries to read that mapping, the read succeeds, leading to a
>> potential info leak, or even data corruption, if it attempts to write to
>> it.
>>
>> If the mapping is left in the freed list, then clearing will be
>> attempted again during amdgpu_cs_ioctl, which will either fail and not
>> submit the job or will succeed in clearing the mapping, preventing the
>> invalid access.
> 
> Same as I replied to oushinnyo <oushinnyo@163.com>, absolutely clear NAK to that.
> 
> amdgpu_vm_update_range() can only fail when the device is hot removed and we don't care about clearing page tables in that case.

Actually, how so? The SDMA update path has lots of allocations that 
happen at random points throughout the update process (think the SDMA IB 
being exhausted, then vm_funcs->update() will allocate a new one and can 
fail on that, or various fence allocations. Some paths allocate from the 
delayed IB pool which is just regular GFP_KERNEL, why couldn't these 
allocations fail?

Aside from that, the more trivial failure path that I think Thadeu is 
also talking about here is that amdgpu_vm_ptes_update will call 
amdgpu_vm_pt_alloc (so that happens in the middle of VM updates) and 
these allocations can fail. I'm not even sure if drm_exec can save this 
one because we need to be ready to drop locks and retry.

I get that failing is unacceptable for the cases inside a pagefault 
handler (though I'm not sure if anything of what I mentioned applies 
here, pagefault VM updates are immediate so they get GFP_ATOMIC, but 
maybe the pagefault handler could still allocate PTs?) but for anything 
else, failure seems like a possibility and maybe we should think about 
handling it in some way.

I'm not sure I see a problem in keeping BOs invalidated and backing off 
later, since new submissions should be rejected unless the VM manages to 
complete all updates successfully.

Best,
Natalie

> 
> Regards,
> Christian.
> 
>>
>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 09037df76400..5bde36754607 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1594,16 +1594,16 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>   	while (!list_empty(&vm->freed)) {
>>   		mapping = list_first_entry(&vm->freed,
>>   			struct amdgpu_bo_va_mapping, list);
>> -		list_del(&mapping->list);
>>   
>>   		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
>>   					   &sync, mapping->start, mapping->last,
>>   					   0, 0, 0, NULL, NULL, &f);
>> -		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>   		if (r) {
>>   			dma_fence_put(f);
>>   			goto error_free;
>>   		}
>> +		list_del(&mapping->list);
>> +		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>   	}
>>   
>>   	if (fence && f) {
>>
> 

