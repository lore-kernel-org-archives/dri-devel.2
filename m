Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0920C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A00910E48A;
	Fri, 17 Jul 2026 14:35:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="FJbsSHAo";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A186F10E48A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:35:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAF601476;
 Fri, 17 Jul 2026 07:35:23 -0700 (PDT)
Received: from [10.57.84.220] (unknown [10.57.84.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 181A03F7B4;
 Fri, 17 Jul 2026 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784298928; bh=04h1xL9bVQhcWyqK0UDPWaUwr2jn0aX6jLQn+ZTNHmw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FJbsSHAoWobppT89ACo5EWn2LTm0G5snGwt2P7C8OT9u5cemEKtdWX4NvAyHrqkMx
 mmfy/NeA1yWTyLl8PseeJ7Tq2QUS511amuYPQcBw9Xv6ZC8Vvofwh+753Oc7IfWUPt
 +vHyGLZbI4QAuIJfituO9CjDFwv/xNzg7DPwJ6eQ=
Message-ID: <5012970d-a0f0-461c-b0b6-61823e0aab2d@arm.com>
Date: Fri, 17 Jul 2026 15:35:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 8/8] misc/arm-cla: Add userspace interface
Content-Language: en-GB
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-9-ryan.roberts@arm.com>
 <404d2c6d-4a18-40c2-9da9-fb030c39536f@app.fastmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <404d2c6d-4a18-40c2-9da9-fb030c39536f@app.fastmail.com>
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

On 17/07/2026 13:54, Arnd Bergmann wrote:
> On Fri, Jul 17, 2026, at 12:47, Ryan Roberts wrote:
>> Expose CLA devices through a character device so userspace can enumerate
>> the available hardware and map accelerator register frames.
>>
>> Define version 1 of the CLA UAPI with a GET_PARAM ioctl. Report device
>> topology, CPU affinity, domain membership, mmap offsets, architecture
>> version and attached accelerator masks, together with the IIDR, DEVARCH
>> and REVIDR of each accelerator.
>>
>> CLA registers can only be read from the CPU local to the device, while
>> enumeration may occur on any CPU. Validate the supported CLA
>> architecture version during device setup and cache the CLA and
>> accelerator identification registers for later ioctl queries.
> 
> This interface looks very raw at the moment, I expect this will have
> one or more larger redesigns.

Are you referring to the overall UABI or specifically to the ioctl interface
here? I could imagine the ioctl interface evolving before we get this merged
(although it is based on similar patterns used by some DRM and accel drivers -
it's intended to be easily extensible while existing params remain stable).

The aspect where the CLA MMIO is directly mapped into user space is an aspect we
are keen to keep though since it has significant performance implications if we
need to redirect through the kernel.

> 
> Most importantly, a single character device to expose an arbitrary
> number of underlying hardware features is an inherently flawed security
> model. If any specific accelerator is ever found to have a
> major vulnerability, that would mean administrators will have to
> disable all of them by default.

Note that we are exposing MMIO per CLA, not per accelerator. So preventing
access to a single CLA would prevent access to all accelerators attached to it.
There is a per-accelerator availability masking control that the kernel can use
to disable access to selected accelerators though, which might help with the
vulnerability example.

The rationale for choosing a single device file was driven by performance: At
domain reassignment time, we need to unmap and invalidate the TLB entries for
all the devices in the domain from the out-going process's address space. By
having all the devices in a single file and all devices within the same domain
adjacent, they can all be mapped to a single VMA, meaning the driver can use a
single call to the existing zap_special_vma_range(), which will result in a
single TLBI-by-range instruction, which is faster than a TLBI-by-va for every
device.

If you think it is important for security to have each CLA exposed by an
independent device file, I'll take another look.

> 
>> Support shared read-write mmap of one or more CLA register pages. Create
>> a context for every domain covered by the mapping and resolve faults
>> only while that context owns the domain. Queue unassigned contexts with
>> the domain scheduler, drop mmap_lock while waiting for assignment and
>> retry the fault after the context is woken.
> 
> I still need some time to better understand what this means.

I can probably do a better job of explaining this: The kernel keeps a cla_ctx
object which represents a single {file description, mm_struct} context that
wants to use the cla_domain (collection of 1 or more cla_dev). Initially the VMA
is not populated so when user space tries to access, it will fault to the
driver. If the cla_domain is assigned to a different cla_ctx, the faulting
thread is put to sleep until the driver determines that it's the turn of that
cla_ctx to be assigned the domain. At that point the waiting thread(s) are woken
and map the devices from the domain to the VMA and return to user space. The
out-going cla_ctx had it's mappings removed during the reassignment process so
any user space access will now fault and sleep waiting for assignment.

> Does a CPU have multiple concurrently running contexts? 

The HW only has a single HW context, hence the timesliced assignment approach
described above (assuming there is more than 1 concurrent user).

> Is a
> user process able to starve the allocation of other processes
> by just requesting a lot of them?

In the current code, a process can theoretically create the same number of
cla_ctx as the number of file descriptors it can open(). It would then need to
mmap and access to get into the queue to be assigned the domain. I see it as
similar to threads; if process A creates 10 threads and process B creates 1
thread, then in the long run (ignoring cgroups et al) you'd expect A to get
10/11th of the CPU time (IIUC?).

Do you think this consitutes a DoS?

> 
>> +static long cla_ioctl_get_param(unsigned long arg)
>> +{
>> +	struct arm_cla_param __user *uparam = (void __user *)arg;
>> +	struct arm_cla_param param;
>> +	int accel_id;
>> +	int dev_id;
>> +	int ret;
>> +
>> +	if (copy_from_user(&param, uparam, sizeof(param)))
>> +		return -EFAULT;
>> +
>> +	ret = cla_ioctl_validate_param(&param);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_id = dev_nospec(ARM_CLA_PARAM_INDEX_DEV(param.index));
>> +	accel_id = accel_nospec(ARM_CLA_PARAM_INDEX_ACCEL(param.index));
> 
> Why is the dev_id/accel_id not a property of the device node itself?

As per above, I can go look again at having a device node per CLA device (i.e.
one for each CPU that has a CLA). But it doesn't make sense to have a device
node per accelerator (a CLA can have up to 8 connected accelerators); there is
only a single HW interface.

> 
>> +	switch (param.param) {
>> +	case ARM_CLA_PARAM_UABI_VERSION:
>> +		param.value = ARM_CLA_UABI_VERSION;
>> +		break;
> 
> UABI definitions are not versioned, you have to stay compatible
> indefinitely. If you need something else, add a new command.

Yes agreed; my mistake - this is used for the internal development versions
where the interface has been changing and I forgot to remove it for the RFC.

> 
>> +	wait_event_interruptible(ctx->waitq,
>> +				 READ_ONCE(domain->assigned_ctx) == ctx ||
>> +				 cla_ctx_is_dying(ctx) ||
>> +				 READ_ONCE(domain->broken));
> 
> If you call wait_event_interruptible(), you have to check the return
> code and deal with it being interrupted.

I believe this is already correct - I'm reeturning VM_FAULT_RETRY
unconditionally at this point, which is also the correct return code if we get
interrupted. This unwinds to arm64's do_page_fault() which then notices and
handles the fault:

	/* Quick path to respond to signals */
	if (fault_signal_pending(fault, regs)) {
		if (!user_mode(regs))
			goto no_context;
		return 0;
	}

I believe GUP and other handle_mm_fault() callers have similar logic.

I'll add a comment to make that clear.

> 
>> +static const struct file_operations cla_fops = {
>> +	.owner = THIS_MODULE,
>> +	.mmap = cla_file_mmap,
>> +	.unlocked_ioctl = cla_file_ioctl,
>> +#ifdef CONFIG_COMPAT
>> +	.compat_ioctl = cla_file_ioctl,
>> +#endif
> 
> No need for the #ifdef here. Technically setting .compat_ioctl=compat_ptr_ioctl
> is the correct way here, though that may change in the future now that
> s390 compat mode is gone.

ACK, I'll fix this.

Thanks,
Ryan


> 
>       Arnd

