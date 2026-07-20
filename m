Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B29C44527
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB2410E13F;
	Mon, 20 Jul 2026 09:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ViEoCZkW";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 05F9F10E13F
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 09:54:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F0A62B;
 Mon, 20 Jul 2026 02:54:51 -0700 (PDT)
Received: from [10.57.84.220] (unknown [10.57.84.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC8F43F86F;
 Mon, 20 Jul 2026 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784541295; bh=tgJkIB4B+jky/Ski+nut9PFjibMvVkWxjSFcztspMP0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ViEoCZkWwBB4U5jsCe/MenGzFNXbQMBSaC5EHu6i6kjJWEKhL4xaRojQr89BKZSgs
 WpYAl0Cc9hYS6ia083mYJImUWffA77MzsU7zSZ8rY2Yj0q65clVrp/Br9jjmWtuN6Q
 kuM3BuW2JZYN/AhHBIMX5SftJJL97UjTEDm2Ics0=
Message-ID: <cd4258f6-084d-4759-9ba5-17cf29428b1d@arm.com>
Date: Mon, 20 Jul 2026 10:54:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/8] misc/arm-cla: Add driver skeleton and
 documentation
Content-Language: en-GB
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-2-ryan.roberts@arm.com>
 <1e561b1a-2c87-4a23-b4da-126b333de8ba@app.fastmail.com>
 <5f82ee6b-d106-4ae1-9b2c-5a817e3e43b9@arm.com>
 <2732dc3b-e3b0-4df6-9b63-f0de4eaca993@app.fastmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2732dc3b-e3b0-4df6-9b63-f0de4eaca993@app.fastmail.com>
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

On 17/07/2026 17:10, Arnd Bergmann wrote:
> On Fri, Jul 17, 2026, at 17:44, Ryan Roberts wrote:
>> On 17/07/2026 14:49, Arnd Bergmann wrote:
>>> On Fri, Jul 17, 2026, at 12:47, Ryan Roberts wrote:
>>> This sounds a lot like st64bv or st64bv0, passing an 8-word payload and returning
>>> a single word per accelerator operation with shared addressing.
>>
>> We're actually passing 9 words here; 8 DATA words plus the LAUNCH word. CLA
>> supports only 64 bit aligned and sized accesses (other accesses are RAZ/WI) so
>> they have to be written as 9x64bit stores. Then poll using 64bit loads.
>>
>>>
>>> Why are there now two interfaces to do the same thing?
>>
>> Good question. This is how the HW operates.
>>
>>>
>>> Can a user process use st64bv to do the four steps in a
>>> single instruction?
>>
>> No, unfortunately not.
>>
> 
> Ok
> 
>>> Can a CPU start multiple asynchronous operations concurrently?
>>
>> Yes; STATUS indicates READY while it can accept more asynchronous operations
>> ("comamnds").
> 
> How does userspace know which operations have already completed
> then? (not worried about this bit, just trying to understand)

There is nothing architected in the CLA to determine this; You can determine
READY (i.e. can accept new commands) and IDLE (i.e. completed all previously
submitted commands). If you want to know when a specific command completed
without having to wait for all commands to complete, then you need extra
knowledge of the specific accelerator.

> 
>>> Do these continue to run if the starting process is scheduled out
>>> and another process also tries to use CLA?
>>
>> Yes; the driver manages assignment of a CLA to a process context completely
>> separately from the thread scheduler's decisions about which threads run on
>> which CPUs and when. If another process is scheduled onto the CPU and it
>> attempts to access it's VA for the CLA, it will fault into the driver's handler
>> and be put to sleep until the driver decides to reassign the CLA.
> 
> This part does sound dangerous, not in the sense that I think it's
> fundamentally broken, but in the complexity it adds.

Can you describe more about the complexity you see here? The intention is to
_reduce_ complexity by not coupling with the CPU scheduler.

> 
> I wonder if it's feasible to simplify this by always canceling
> any ongoing CLA operations during switch_mm():

The advice I've had so far is to avoid at all costs, coupling the CLA context
switch with the CPU context switch; there are concerns about the latency
impliciaitons for the CLA context switch and also a desire not to couple the CLA
device driver with arch code.

> 
> Is there an upper bound on how long a single operation can take,
> or a guarantee that an operation at least provides a partial result
> in hardware?

For the compute accelerator we have, operations are gauranteed to complete in
finite time, but that time could technically be very large. In practice
operations for known use cases range from a few microseconds to ~10 milliseconds.

As I described in a previous response, the accelerator does not support full
save/restore so if it is interrupted while running an operation, the operation
appears aborted when the state is next restored. Due to forward progress
concerns, we are looking at the possibility of a grace period (of the order of a
few milliseconds) during CLA reassignment. I'm pretty sure we wouldn't want to
insert that into the (non-preemptible) CPU context switch path...

> 
> From your earlier descriptions, it sounds like the CPU is usually
> assumed to wait for completion with WFE anyway, so from the
> scheduler's perspective, the thread is active while waiting for
> the accelerator to complete a job (even if from hardware side
> the CPU is powered down during WFE).

In practice the CPU will have some parallel work to prepare the next
operation(s) for submission, but yes, eventually it will enter a polling loop
waiting for accelarator completion with WFE.

> 
> If this is how it generally operates, and the accelerator jobs
> are usually fast, forcing the CLA TTBR0 to be the same as the
> CPU TTBR0 would avoid the entire problem of unmapping the registers
> on context switch, but instead let this hook into the same place
> as the corresponding iommu_mm_data switch on x86, which seems> to handle this
more nicely.
>

I agree this feels like a much simpler model on the surface but because the jobs
are not always fast and because the accelerator doesn't support full
save/restore, I don't think this approach flies in practice.

Thanks,
Ryan


>> I'm not sure what you mean by "Which instruction specifically causes the fault".
>> A fault occurs within the accelerator if it tries to access a virtual address
>> that is not mapped by the page table or if the permissions of the mapping are
>> not sufficient, etc... The fact that the accelerator has faulted is reported to
>> the SW that is polling the accelerator's STATUS register within user space. That
>> SW is expected to trigger fault handling by the usual kernel mechanisms by
>> accessing the VA. Then it issues a RESOLVE operation to tell the accelerator it
>> can continue.
> 
> Got it now. I had assumed that the page fault is delivered asynchronously
> to the kernel without user space getting involved. In this case, I think
> the interface is actually cleaner, though it does add a little bit
> of overhead for userspace having to decipher the status. 
>  
>>>> +User space software is expected to create a thread to drive each CLA it is
>>>> +using, and for each thread to be pinned to the CLA's local CPU.
>>>
>>> What happens if multiple processes have the same chardev open and
>>> each mmap() that, e.g. after a fork()? Does each process see its
>>> own virtual instance of the accelerator and interact with it through
>>> the same physical MMIO register range but its own process address space,
>>> or do you have to rely on the registers being mapped only into a
>>> single mm_struct to prevent a process from messing with another process
>>> data?
>>
>> The driver maintains a cla_ctx for each {file description, mm_struct} pair. So
>> in this case, even though the file description is shared between the parent and
>> child processes, they still have distinct mm_structs so still have separate
>> contexts allowing the driver to virtualize access correctly.
> 
> Ok, got it.
> 
>      Arnd

