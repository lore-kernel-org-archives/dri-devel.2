Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52935CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 14:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CB910E4F1;
	Wed,  6 May 2026 14:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="DWmoJJl0";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9F8FE10E4F1
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 14:35:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 665E0169C;
 Wed,  6 May 2026 07:35:18 -0700 (PDT)
Received: from [10.57.69.49] (unknown [10.57.69.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F6793F836;
 Wed,  6 May 2026 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778078123; bh=OtZbaHcczJ4t5lEE53IsIQVdWbjnwbCuDAL/2m/n8WA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DWmoJJl0SWRfeRpP2E/rnm3WJjdhKDck5KBFI721URrcsf8KFfX2BCjPllpDLbTgi
 BzePVSEVE29iq8oZxQzlm/tkahhkCcnRnjSjyU0FwyTf+HKoIFbjJ8ONeIWBnXjW9x
 2oOAPNqDCGwBA7Qy8QEPHVOqBq8RZ4l0HK7nXfl4=
Message-ID: <687ecf58-3602-46ef-a76e-94f7b1852dce@arm.com>
Date: Wed, 6 May 2026 15:35:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] drm/panthor: Automatically enable interrupts in
 panthor_fw_wait_acks()
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-8-4b92ae4142d2@collabora.com>
 <446e9d1f-b6be-42fa-bd2b-f4fcbc130f70@arm.com>
 <20260504130215.0222b3bd@fedora>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260504130215.0222b3bd@fedora>
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

On 04/05/2026 12:02, Boris Brezillon wrote:
> On Fri, 1 May 2026 15:20:17 +0100
> Steven Price <steven.price@arm.com> wrote:
> 
>> On 29/04/2026 10:38, Boris Brezillon wrote:
>>> Rather than assuming an interrupt is always expected for request
>>> acks, temporarily enable the relevant interrupts when the polling-wait
>>> failed. This should hopefully reduce the number of interrupts the CPU
>>> has to process.
>>>
>>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>  
>>
>> It seems to work, although I'm lightly uneasy about this because I'm not
>> entirely sure whether the FW will immediately see the updates to
>> ack_irq_mask and therefore whether there's a possibility to miss an
>> event and be stuck waiting for the timeout.
>>
>> Memory models are not my strong point, OpenAI tells me the sequence
>> should be something like:
>>
>>   scoped_guard(spinlock_irqsave, lock) {
>>   	u32 ack_irq_mask = READ_ONCE(*ack_irq_mask_ptr);
>>
>>   	WRITE_ONCE(*ack_irq_mask_ptr, ack_irq_mask | req_mask);
>>   }
> 
> Is this really needed? In which situation would the compiler/CPU decide
> to re-order this read_update_modify sequence?

I think that's the AI being a bit overzealous, but in general WRITE_ONCE
is necessary to avoid some surprising effects. In theory the compiler
can decide to perform multiple writes if it's non-volatile. I.e. a
sequence like:

	u32 old_mask = *ack_irq_mask_ptr;
	if (condition)
		*ack_irq_mask_ptr = 0;
	else
		*ack_irq_mask_ptr |= req_mask;

Can be 'optimised' to:

	u32 old_mask = *ack_irq_mask_ptr;
	*ack_irq_mask_ptr = 0;
	if (!condition)
		*ack_irq_mask_ptr = old_mask | req_mask;

In which the compiler has changed the (!condition) path to do two writes
one of which "should never be seen".

Given that the compiler shouldn't be able to move any of the effects
outside of the scoped_guard(), and since there's only one operation then
I can't see how a compiler would screw it up - but the compiler is
technically free to do so.

>>
>>   /*
>>    * The FW interface can be mapped write-combine/Normal-NC.
> 
> I'm not too sure I see what the non-cached property has to do with it.
> If it was cached we would still need this memory barrier, and in
> addition, we'd need a cache flush if the FW is not IO-coherent.

I *think* the point the AI was making is that the memory isn't Device.
I.e. it's writeback and the write might not have completed.

>> Make sure the
>>    * IRQ mask update is visible to the FW before sleeping waiting for
>> the IRQ.
>>    */
>>   wmb();
>>
>> Which seems plausible. But I've long ago learnt that plausible doesn't
>> mean much when dealing with memory models!
> 
> Yeah, I'm not too sure. I was honestly expecting the spinlock guard to
> act as a memory barrier already, but maybe it's not enough.

So logically it must be enough to enable other CPUs to see writes within
the spinlock - otherwise spinlocks would be completely broken on SMP. I
guess it should be sufficient for the GPU's firmware MCU to see.

This is of course the problem with AI - it's found something 'plausible'
but it's probably completely wrong. I guess we just ignore it unless we
do actually start seeing that timeout happen.

Thanks,
Steve
