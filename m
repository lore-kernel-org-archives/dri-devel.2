Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBCBFE5202
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD9C10F4DB;
	Fri, 24 Apr 2026 11:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="A+vM95VV";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id C2F3B10F4DB
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:20:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A549E1AC1;
 Fri, 24 Apr 2026 04:20:05 -0700 (PDT)
Received: from [10.1.26.15] (e122027.cambridge.arm.com [10.1.26.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 014B73F23F;
 Fri, 24 Apr 2026 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777029611; bh=Vq7dphJyiNe/41BynV2HS25LJ/wz7HyrvpSLoZFi5jg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=A+vM95VVz18pJfRVh3/orS6/AuoNHVS6HjIBQIfjIB0G6wBwcQw/RC7n34HHFHT6L
 lW1099kjfxNVhurR7rAvwQw4UpFt7So6QVLzAAupAwCh6IqC4CkVuX7CHS6YM23ruU
 Ds7COYg3Q7n4ylpclzCy79Iw8hMfvgnmO7EL+FqM=
Message-ID: <5087bbe4-4898-4fe1-9ea2-17e967bfeec0@arm.com>
Date: Fri, 24 Apr 2026 12:20:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] drm/panthor: Store IRQ register base iomem pointer
 in panthor_irq
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org,
 nd@arm.com, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260412142951.2309135-1-karunika.choo@arm.com>
 <20260412142951.2309135-5-karunika.choo@arm.com>
 <53a66bbd-7ed5-41d9-a15e-af17f292dea1@arm.com>
 <b6c97926-57aa-41dd-99f8-c5f0397e002c@arm.com>
 <05bc8e72-a914-4bee-b635-fe1e9c623900@arm.com>
 <20260424130302.4fb86551@fedora>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260424130302.4fb86551@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 24/04/2026 12:03, Boris Brezillon wrote:
> On Fri, 24 Apr 2026 11:38:24 +0100
> Steven Price <steven.price@arm.com> wrote:
> 
>> On 22/04/2026 17:08, Karunika Choo wrote:
>>> On 22/04/2026 10:34, Steven Price wrote:  
>>>> On 12/04/2026 15:29, Karunika Choo wrote:  
>>>>> Update common IRQ handling code to work from an IRQ-local iomem base
>>>>> instead of referencing block-specific interrupt register offsets.
>>>>>
>>>>> Store the interrupt base address iomem pointer in struct panthor_irq and
>>>>> switch the shared IRQ helpers to use generic INT_* offsets from that
>>>>> local base. This removes the need for each caller to expose absolute IRQ
>>>>> register addresses while keeping the common IRQ flow unchanged.
>>>>>
>>>>> No functional change intended.
>>>>>
>>>>> v2:
>>>>> - Change IRQ request function to accept an iomem pointer instead of
>>>>>   computing it from an offset argument.
>>>>>
>>>>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>  
>>>>
>>>> One minor comment below...
>>>>  
>>>>> ---
>>>>>  drivers/gpu/drm/panthor/panthor_device.h   | 32 ++++++++++++++--------
>>>>>  drivers/gpu/drm/panthor/panthor_fw.c       |  5 ++--
>>>>>  drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 ++
>>>>>  drivers/gpu/drm/panthor/panthor_gpu.c      |  6 ++--
>>>>>  drivers/gpu/drm/panthor/panthor_gpu_regs.h |  3 ++
>>>>>  drivers/gpu/drm/panthor/panthor_mmu.c      |  5 ++--
>>>>>  drivers/gpu/drm/panthor/panthor_mmu_regs.h |  3 ++
>>>>>  drivers/gpu/drm/panthor/panthor_pwr.c      |  6 ++--
>>>>>  8 files changed, 42 insertions(+), 20 deletions(-)
>>>>>  
>>>> [...]  
>>>>> @@ -1470,7 +1470,8 @@ int panthor_fw_init(struct panthor_device *ptdev)
>>>>>  	if (irq <= 0)
>>>>>  		return -ENODEV;
>>>>>  
>>>>> -	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0);
>>>>> +	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0,
>>>>> +				      ptdev->iomem + JOB_INT_BASE);
>>>>>  	if (ret) {
>>>>>  		drm_err(&ptdev->base, "failed to request job irq");
>>>>>  		return ret;  
>>>> [..]  
>>>>> @@ -162,7 +162,9 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>>>>>  	if (irq < 0)
>>>>>  		return irq;
>>>>>  
>>>>> -	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq, GPU_INTERRUPTS_MASK);
>>>>> +	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
>>>>> +				      GPU_INTERRUPTS_MASK,
>>>>> +				      ptdev->iomem + GPU_INT_BASE);
>>>>>  	if (ret)
>>>>>  		return ret;
>>>>>    
>>>> [...]  
>>>>> @@ -3229,7 +3229,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>>>>>  		return -ENODEV;
>>>>>  
>>>>>  	ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
>>>>> -				      panthor_mmu_fault_mask(ptdev, ~0));
>>>>> +				      panthor_mmu_fault_mask(ptdev, ~0),
>>>>> +				      ptdev->iomem + MMU_INT_BASE);
>>>>>  	if (ret)
>>>>>  		return ret;
>>>>>    
>>>> [...]  
>>>>> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
>>>>> index aafb0c5c7d23..11c43de1ddd5 100644
>>>>> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
>>>>> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
>>>>> @@ -70,7 +70,7 @@ static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
>>>>>  	}
>>>>>  	spin_unlock(&ptdev->pwr->reqs_lock);
>>>>>  }
>>>>> -PANTHOR_IRQ_HANDLER(pwr, PWR, panthor_pwr_irq_handler);
>>>>> +PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
>>>>>  
>>>>>  static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
>>>>>  {
>>>>> @@ -464,7 +464,9 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>>>>>  	if (irq < 0)
>>>>>  		return irq;
>>>>>  
>>>>> -	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK);
>>>>> +	err = panthor_request_pwr_irq(
>>>>> +		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
>>>>> +		ptdev->iomem + GPU_CONTROL_BASE + PWR_CONTROL_BASE);  
>>>>
>>>> This one is the odd one out because it adds GPU_CONTROL_BASE put the
>>>> other panthor_request_xxx_irq() calls don't. Sashiko also points out
>>>> that there's an argument these should all be using ptdev->gpu->iomem in
>>>> the final refactor.
>>>>  
>>>
>>> I understand that it is slightly different, it is only there to
>>> illustrate the fact that it is a child of the GPU_CONTROL register page.
>>> w.r.t using ptdev->gpu->iomem, that would mean that we need reach into
>>> the panthor_gpu component to access the memory, hence why we used a
>>> separate iomem for this one.  
>>
>> Why do you not add GPU_CONTROL_BASE on when accessing JOB_INT_BASE,
>> GPU_INT_BASE and MMU_INT_BASE though?
>>
>> The obvious answer for JOB/MMU is because they're not architecturally in
>> GPU_CONTROL. But then why don't we have
>> JOB_CONTROL_BASE/MMU_CONTROL_BASE (my guess is because there isn't
>> really anything other than INT registers in those blocks).
>>
>> So it looks like for JOB_INT_BASE/GPU_INT_BASE/MMU_INT_BASE these are
>> offsets from the beginning of the GPU registers iomem. But then for some
>> reason PWR_INT_BASE (introduced in patch 6) is treated as if it's a
>> relative offset within GPU_CONTROL_BASE. Which is just weirdly inconsistent.
>>
>> I'm happy to disagree with Sashiko on the use of ptdev->gpu->iomem - I
>> think interrupts are special enough that we can use the top-level iomem.
>> But that only holds as a justification if all interrupts are treated in
>> the same way.
> 
> I don't really mind if some intermediate patches use ugly tricks to get
> there,

Sorry, I should have been clearer on that - the intermediate patches can
be a big ugly if necessary (it's clearly better to split things up
rather than change everything in one go). I picked this patch to comment
on because it's the one changing the IRQ handling.

> but in the final state, I'd actually prefer if each block was>
initializing its own iomem, and then the interrupt iomem was calculated
> off this block-iomem region.
> 
> So, in patch, I'd like to see PWR_INT_BASE changed from 0x800 to 0 and
> 
> 	panthor_request_pwr_irq(ptdev, &pwr->irq, irq,
> 				PWR_INTERRUPTS_MASK,
> 				ptdev->pwr->iomem + PWR_INT_BASE);

Yes, using the relevant iomem pointer for each IRQ request also makes
sense. What I disagreed with Sashiko on was picking on just the GPU
instance ;)

Thanks,
Steve

