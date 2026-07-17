Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD48C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989D410E4B4;
	Fri, 17 Jul 2026 15:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="jliRQOkE";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id AEAA010E4C3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 15:44:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6FC01477;
 Fri, 17 Jul 2026 08:44:49 -0700 (PDT)
Received: from [10.57.84.220] (unknown [10.57.84.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB6F63F905;
 Fri, 17 Jul 2026 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784303094; bh=1xqYa/5eSWO7i3QP0dwUy73LBcyWjTX2AK0R00/T4tk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jliRQOkE9YYIg7mEmb5ahS59eMTSsRkz6QjEO32DvIEzQMBMVYPxak1GlBzdkb8qR
 eywBRrswngVRf/LANCYJsWVyMvysXWsNScQ681mRFptJT62NK8A+xG7j1er6nSWfFw
 h+uqLfwxw0zrCyFg+pZRyxUTmZ75YoAF5xFwUQXc=
Message-ID: <5f82ee6b-d106-4ae1-9b2c-5a817e3e43b9@arm.com>
Date: Fri, 17 Jul 2026 16:44:49 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <1e561b1a-2c87-4a23-b4da-126b333de8ba@app.fastmail.com>
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

Hi Arnd,

Thanks for all your fast feedback!...


On 17/07/2026 14:49, Arnd Bergmann wrote:
> On Fri, Jul 17, 2026, at 12:47, Ryan Roberts wrote:
>> From: Jean-Philippe Brucker <jpb@kernel.org>
>>
>> Add the initial Kconfig and build-system plumbing for the Arm Core Local
>> Accelerator driver.
>>
>> Introduce the common driver header and register definitions used by
>> later CLA support. The definitions cover the CLA MMIO frame, launch
>> response and status fields, standard accelerator registers, launch
>> opcodes, error codes and memory translation context state.
>>
>> Add documentation describing the CLA programming model, its CPU-local
>> MMIO access rules, userspace assignment model, domain grouping and
>> expected boot state.
> 
> I have a few more questions here. Most of the description and
> the design decisions make perfect sense to me, but there are
> a few things I don't understand from your current document.
> 
>> +The CLA supports up to 8 attached accelerators, which are accessed by
>> +programming the CLA's MMIO registers. Operations are launched to an 
>> accelerator
>> +and are polled for completion. CLA does not raise interrupts.
>> +
>> +            CPU                     CLA              Accel
>> +             |--- write DATA[7:0] -->|                 |
>> +             |--- write LAUNCH ----->|---- launch ---->|
>> +             |<--- poll LRESP -------|                 |
>> +             |                       |                 |
>> +             |<--- poll STATUS ------|<--- complete ---|
>> +
>> +Each operation can take a 512-bit payload in the DATA registers. After handling
>> +a LAUNCH write, CLA indicates the launch status in the LRESP register. A further
>> +operation can only be launched after LRESP indicates completion of the previous
>> +launch.
> 
> This sounds a lot like st64bv or st64bv0, passing an 8-word payload and returning
> a single word per accelerator operation with shared addressing.

We're actually passing 9 words here; 8 DATA words plus the LAUNCH word. CLA
supports only 64 bit aligned and sized accesses (other accesses are RAZ/WI) so
they have to be written as 9x64bit stores. Then poll using 64bit loads.

> 
> Why are there now two interfaces to do the same thing?

Good question. This is how the HW operates.

> 
> Can a user process use st64bv to do the four steps in a
> single instruction?

No, unfortunately not.

> 
>> +Some operations continue to run asynchronously on the accelerator after launch
>> +completion. In this case progress is tracked by polling the STATUS register.
>> +When the CLA updates the STATUS register, it also raises an event which will
>> +wake an in-progress WFE (wait for event) instruction on the local CPU.
> 
> The asynchronous interface seems very confusing.
> 
> How are page faults from the SVA master resolved during an
> asynchronous operation?

The STATUS register has a fault bit; the poller notices, reads fault info from
accelerator registers and takes actions to resolve the fault (which in practice
means access from user space on CPU and fault into the kernel to handle).

> 
> Can a CPU start multiple asynchronous operations concurrently?

Yes; STATUS indicates READY while it can accept more asynchronous operations
("comamnds").

> 
> Do these continue to run if the starting process is scheduled out
> and another process also tries to use CLA?

Yes; the driver manages assignment of a CLA to a process context completely
separately from the thread scheduler's decisions about which threads run on
which CPUs and when. If another process is scheduled onto the CPU and it
attempts to access it's VA for the CLA, it will fault into the driver's handler
and be put to sleep until the driver decides to reassign the CLA.

> 
>> +Faults during address translation are reported by the accelerator in its
>> +registers and in STATUS. While polling for work completion, software fixes up
>> +the faults and notifies the accelerator with RESOLVE operations.
> 
> I would like to understand the faulting part better. Which instruction
> specifically causes the fault, is that the poll STATUS read?

I'm not sure what you mean by "Which instruction specifically causes the fault".
A fault occurs within the accelerator if it tries to access a virtual address
that is not mapped by the page table or if the permissions of the mapping are
not sufficient, etc... The fact that the accelerator has faulted is reported to
the SW that is polling the accelerator's STATUS register within user space. That
SW is expected to trigger fault handling by the usual kernel mechanisms by
accessing the VA. Then it issues a RESOLVE operation to tell the accelerator it
can continue.

> 
>> +Inter-Accelerator Communication
>> +-------------------------------
>> +
>> +On some platforms, multiple accelerators, each attached to a separate CLA within
>> +a cluster, are also directly connected to each other via a shared bus to
>> +accelerate cooperation between accelerators. The accelerators sharing a bus
>> +cannot be isolated from each other. When collaborative operations are launched
>> +on each of the participating accelerators, they synchronize over the bus,
>> +stalling until all are ready.
> 
> Could you give an example what this model might be good for?

I can't currently share that information. I expect you might be able to have a
good guess though :)

> 
> Does this mean a user may have to start one operation on each CPU
> from a thread of the same process in order to get a result efficiently
> across a shared accelerator?

Yes, correct. User space threads don't need to be precisesly synchronized
because multiple operations can be queued.

> 
> I assume this will become clearer once you can show an example userspace
> application that uses this type of accelerator.

Yes indeed. As I said, Arm plans to open source a user space driver, but there
is no commitment on dates yet.

> 
>> +Intended SW Usage Model
>> +=======================
>> +
>> +CLA is designed for its PL0 MMIO frame to be mapped into user space  and for user
>> +space to directly launch accelerator operations and poll for completion. It has
>> +been observed that for some use cases, the operation execution time is small and
>> +a trip through the kernel would consume a significant amount of the CPU budget
>> +for preparing the next operation leading to a significant reduction in bandwidth
>> +through the accelerator.
> 
> Do you have any plans for in-kernel usage of the accelerators?
> I would assume that for things like cryptographic features, these
> make sense to be exposed to the kernel itself.

As per cover letter: "the initial (and currently only) target is a compute
engine". There are not any plans for crypto accelerators (or other things like
that). So haven't been considering this as something the kernel would want to
use directly.

(Sorry I'm being vague - I'm sure you appreciate I'm limited on what I can say
around the use cases for now).

> 
>> +User space software is expected to create a thread to drive each CLA it is
>> +using, and for each thread to be pinned to the CLA's local CPU.
> 
> What happens if multiple processes have the same chardev open and
> each mmap() that, e.g. after a fork()? Does each process see its
> own virtual instance of the accelerator and interact with it through
> the same physical MMIO register range but its own process address space,
> or do you have to rely on the registers being mapped only into a
> single mm_struct to prevent a process from messing with another process
> data?

The driver maintains a cla_ctx for each {file description, mm_struct} pair. So
in this case, even though the file description is shared between the parent and
child processes, they still have distinct mm_structs so still have separate
contexts allowing the driver to virtualize access correctly.

> 
>> +Saving and restoring the internal state of the accelerator is an optional
>> +feature. Current platforms only support it when the accelerator is idle, so
>> +preempting an accelerator causes work cancellation. Software must carefully
>> +consider how to balance forward-progress guarantees with preemption 
>> latency.
> 
> I'm not sure I understand this point. Do you mean any async operation
> that was started on an accelerator may fail due to preemption, so user
> space must be able to restart it?

Yes, at it's simplest. But it gets a bit complicated if you introduce the idea
of a priority to each cla_ctx. If a high priority context needs the HW
periodically and preempts a low priority context, if we just abort the low
priority work on preemption, it may never make forward progress. We've been
considering a grace period where the kernel will wait for the accelerators to
complete their current work (up to a certain timeout) before reassigning them to
the incomming context. But none of that is part of this RFC - I think that's
discussion that can come later once we have the basic shape of everything agreed.

Thanks,
Ryan

> 
>      Arnd

