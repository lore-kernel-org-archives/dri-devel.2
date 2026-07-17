Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0CCC44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101F210E20B;
	Fri, 17 Jul 2026 15:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="ayR+2bnK";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXe87VyP";
	dkim-atps=neutral
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DAB10E20B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 15:32:29 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BC88114000F9;
 Fri, 17 Jul 2026 11:32:28 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 11:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784302348;
 x=1784388748; bh=TkO/aox8uFR+z4c46jXuQspWe37T9Xp9ua6dPWUt5B0=; b=
 ayR+2bnKzFwvDyTUkUXUA979lsMANjW/+lwEeFTUJF1kwbd+pXadR6zr3UQP7kgl
 +LVQITK9EMoWvEUlygss8KzHmmKXxJiKniJtaVFPcL5sTY4GDbJ8aKonlPHfs8h7
 yXY2XCKrJGcC3yY9Pc1lpxJuVhqeoCt44hVaApZNtOUaF3Fi78jyb1RbR2rSpObn
 ZtfhsVB+26HHOon5j5DShK6vu6JC7tu06YtRCUhfxjHo1pPLY8V9rkMB1xoCSF8J
 zqOL+a4UMNaxhw66aR6pz3r2vFXNA+jEoRuqtuBjVlSXyav01EC/m052vJ+sTl43
 DWU6SnYFJIQVTyNrB5gEww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784302348; x=
 1784388748; bh=TkO/aox8uFR+z4c46jXuQspWe37T9Xp9ua6dPWUt5B0=; b=S
 Xe87VyPEv/2DJzyKlyw5fB2PGa8js3f/YlDjapl3VKy6CJnheQfBSQZUkQJ12aoe
 Ilz8zVbPd4EA8oIe+zkXPKOYWqQ/o2ECh4sjB7PrGh12t/Oo9iw4/Iezcg8O2HFB
 Qs6OMezjrAtpbSnqshXeWAdbcl3oLyJwVMddP15p//3I4sqEAEsSlENg5LCf8Lzf
 RHSZHdD+g9J6ol4Uz9GyEvXvXQB86PPR2CvjfRyxcjTaGT8a/vaNG6QNrF35esqk
 QBjApT0BTMxxMb/mtdHa0hB3nHdjrkP6TF42tceAO3MzlcTxaXGX759fE0hYz+pI
 iD9zNirJTC6x0Co8Fxaww==
X-ME-Sender: <xms:DEtaagiZsl80jOKIBdGOIeSWLQOub8F126JMVwb0c25XIGS0sH2f7g>
 <xme:DEtaaj0sdxOu-K2w2FjH6yz4ZeKFKotFovyiMVV5wTlp42HUK70YhViKbDswgz5PG
 VwKXtE4pssPZIOt4soBSj1hja-AoXxsI5jNyxNNGwa-5XvMDh3HvE4>
X-ME-Proxy-Cause: dmFkZTEOevtZFY/N4PT4evPVa9WBEY+aygc2JfMQCkxFVSNKBsO5+I4PeBsINq3meJu7/G
 EwKIJp6jep73C9Lg6TyThhm9QLgivUW/0UAjEB5I2cWY2q8kU7EIcGwc03IYcUTHS+W9gx
 2j30v3NGklUs1fXTgk5HLFvc3ewcSlzHi6L/YLZQPiJeuRJtzw2TBcto2ZRKnEopszbf/o
 WeQWBIpMzh2FEUF8x1qWVMuoL7J3On9XKvhH9IhsTPPzRtB1/lQMyAANufRnotgZwn3kdY
 0vMwDtthsPcTStHdQ3ECNfOLVNIBAa0pgSCiXV1k3H7rMH6cYLI4nQW7tDABfN21UghWFb
 uphLS3bKCxAijp6ftlcdh/tLn3EclsxZwskR3paLVNrpgKP+MrphbjIzhIzsWKJllt+GIn
 S6Z2E5HnD4C1JJrrbFlNKS6jYNnf4pqsJyn6Frf8ko5g7LgTvELh+QPGcfzAKhuKR2/vwC
 8xmOyo8F1GSlq+7rfK58L3qmzIVBDUy4PL9FEjB7Br0+BKUo2oOONQBQTS/mKCOKzcSIdI
 i2nTkknlFo9JbqumCgJA9zsLgvYl57HvrEsJVzihUu+nVfCAmDBp4fUHTBz0/9EI0jUYbo
 fVqgrDZDAw3WFnmsCw9Z3soJhBlZUSCNtO6onndkgn0NcFXBE8dl1pV+6csw
X-ME-Proxy: <xmx:DEtaanymUTF3WkBFIEQiRjCD4LA34CD_Qj62Xihkit-dfZDU9KfpPA>
 <xmx:DEtaapVVkfYHAILIrUMIn6qCpmm39vTFYfyd7j2aOcCjpRHwxu1Uow>
 <xmx:DEtaamSay7fEFEkKLBFAoBHQVlAQKFuNGx6Pxe4mzkOiJ6EqPb70Jg>
 <xmx:DEtaapR3hLQQbwsodyleJ3q-eiPyqkQ96EUoq611YgsgdXU-OlA7QQ>
 <xmx:DEtaasHfi2dgKtolHB0fCJfXlRYTE9m8p2aoQn6hmcN4tusG4O-AJ49O>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 273BC182007E; Fri, 17 Jul 2026 11:32:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AVTSZ6OHPQ6F
Date: Fri, 17 Jul 2026 17:31:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Roberts" <ryan.roberts@arm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, 
 "Mark Rutland" <mark.rutland@arm.com>,
 "Jean-Philippe Brucker" <jpb@kernel.org>, "Oded Gabbay" <ogabbay@kernel.org>, 
 "Jonathan Corbet" <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Message-Id: <59d0c4d5-af53-410d-9bf8-8dd2ba17f697@app.fastmail.com>
In-Reply-To: <5012970d-a0f0-461c-b0b6-61823e0aab2d@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-9-ryan.roberts@arm.com>
 <404d2c6d-4a18-40c2-9da9-fb030c39536f@app.fastmail.com>
 <5012970d-a0f0-461c-b0b6-61823e0aab2d@arm.com>
Subject: Re: [RFC PATCH v1 8/8] misc/arm-cla: Add userspace interface
Content-Type: text/plain
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

On Fri, Jul 17, 2026, at 16:35, Ryan Roberts wrote:
> On 17/07/2026 13:54, Arnd Bergmann wrote:
>> On Fri, Jul 17, 2026, at 12:47, Ryan Roberts wrote:
>>> Expose CLA devices through a character device so userspace can enumerate
>>> the available hardware and map accelerator register frames.
>>>
>>> Define version 1 of the CLA UAPI with a GET_PARAM ioctl. Report device
>>> topology, CPU affinity, domain membership, mmap offsets, architecture
>>> version and attached accelerator masks, together with the IIDR, DEVARCH
>>> and REVIDR of each accelerator.
>>>
>>> CLA registers can only be read from the CPU local to the device, while
>>> enumeration may occur on any CPU. Validate the supported CLA
>>> architecture version during device setup and cache the CLA and
>>> accelerator identification registers for later ioctl queries.
>> 
>> This interface looks very raw at the moment, I expect this will have
>> one or more larger redesigns.
>
> Are you referring to the overall UABI or specifically to the ioctl interface
> here? I could imagine the ioctl interface evolving before we get this merged
> (although it is based on similar patterns used by some DRM and accel drivers -
> it's intended to be easily extensible while existing params remain stable).
>
> The aspect where the CLA MMIO is directly mapped into user space is an aspect we
> are keen to keep though since it has significant performance implications if we
> need to redirect through the kernel.

I see no problem with having a per-accelerator VM area for MMIO
operations mapped to userspace, this is obviously part of all
designs like this one that sneak custom coprocessor instructions
in by disguising them as MMIO.

My concern is about how userspace gets to that mapping, both
the chardev itself, but also the ioctls.

>> Most importantly, a single character device to expose an arbitrary
>> number of underlying hardware features is an inherently flawed security
>> model. If any specific accelerator is ever found to have a
>> major vulnerability, that would mean administrators will have to
>> disable all of them by default.
>
> Note that we are exposing MMIO per CLA, not per accelerator. So preventing
> access to a single CLA would prevent access to all accelerators attached to it.
> There is a per-accelerator availability masking control that the kernel can use
> to disable access to selected accelerators though, which might help with the
> vulnerability example.
>
> The rationale for choosing a single device file was driven by performance: At
> domain reassignment time, we need to unmap and invalidate the TLB entries for
> all the devices in the domain from the out-going process's address space. By
> having all the devices in a single file and all devices within the same domain
> adjacent, they can all be mapped to a single VMA, meaning the driver can use a
> single call to the existing zap_special_vma_range(), which will result in a
> single TLBI-by-range instruction, which is faster than a TLBI-by-va for every
> device.
>
> If you think it is important for security to have each CLA exposed by an
> independent device file, I'll take another look.

Without concrete implementation examples, I find it hard to imagine
how granular the CLA and accelerator blocks are. What I'm interested
in is separating things into special character devices when they
refer to units that you want to manage separately in userspace.

If you have e.g. one accelerator for tensor operations and one for
handling gzip, I would very much want to see those have a separate
chardev nodes so a local administrator can give permissions to each
one separately, and have device names that are sensible to the
functionality underneath.

If you have separate accelerators for AES encryption and decryption,
or a large set of identical accelerators that can run concurrently,
those would of course get managed as a single device file.

Most importantly, I don't think a global /dev/cla device node
is a sensible interface from a management perspective as that
would give unprivileged userspace direct control to something
that is essentially arbitrary (or buggy) vendor firmware
with DMA permissions.

>>> Support shared read-write mmap of one or more CLA register pages. Create
>>> a context for every domain covered by the mapping and resolve faults
>>> only while that context owns the domain. Queue unassigned contexts with
>>> the domain scheduler, drop mmap_lock while waiting for assignment and
>>> retry the fault after the context is woken.
>> 
>> I still need some time to better understand what this means.
>
> I can probably do a better job of explaining this: The kernel keeps a cla_ctx
> object which represents a single {file description, mm_struct} context that
> wants to use the cla_domain (collection of 1 or more cla_dev). Initially the VMA
> is not populated so when user space tries to access, it will fault to the
> driver. If the cla_domain is assigned to a different cla_ctx, the faulting
> thread is put to sleep until the driver determines that it's the turn of that
> cla_ctx to be assigned the domain. At that point the waiting thread(s) are woken
> and map the devices from the domain to the VMA and return to user space. The
> out-going cla_ctx had it's mappings removed during the reassignment process so
> any user space access will now fault and sleep waiting for assignment.

Got it, thanks

>> Does a CPU have multiple concurrently running contexts? 
>
> The HW only has a single HW context, hence the timesliced assignment approach
> described above (assuming there is more than 1 concurrent user).

Sorry, I think we have a clash of terminology. I meant whether
a CPU can start multiple operations on one or more accelerator
in a single cla_domain, and have each of those operate at the
same time while the hardware is asynchronously processing them
in parallel.

It sounds like a single accelerator has one register to wait for
completion and can only have single operation in progress at any
time, but if multiple accelerators are in the same cla_ctx,
can a single thread start an operation in each one before waiting
for the first to complete?

>> Is a
>> user process able to starve the allocation of other processes
>> by just requesting a lot of them?
>
> In the current code, a process can theoretically create the same number of
> cla_ctx as the number of file descriptors it can open(). It would then need to
> mmap and access to get into the queue to be assigned the domain. I see it as
> similar to threads; if process A creates 10 threads and process B creates 1
> thread, then in the long run (ignoring cgroups et al) you'd expect A to get
> 10/11th of the CPU time (IIUC?).
>
> Do you think this consitutes a DoS?

I need to think about it more. Probably not a DoS, but if the resource
is managed like CPU timeslices, I wonder whether you'd have to also
consider things like realtime tasks or priority inversion.
 
>>> +	wait_event_interruptible(ctx->waitq,
>>> +				 READ_ONCE(domain->assigned_ctx) == ctx ||
>>> +				 cla_ctx_is_dying(ctx) ||
>>> +				 READ_ONCE(domain->broken));
>> 
>> If you call wait_event_interruptible(), you have to check the return
>> code and deal with it being interrupted.
>
> I believe this is already correct - I'm reeturning VM_FAULT_RETRY
> unconditionally at this point, which is also the correct return code if we get
> interrupted. This unwinds to arm64's do_page_fault() which then notices and
> handles the fault:
>
> 	/* Quick path to respond to signals */
> 	if (fault_signal_pending(fault, regs)) {
> 		if (!user_mode(regs))
> 			goto no_context;
> 		return 0;
> 	}

Ok, makes sense.

> I believe GUP and other handle_mm_fault() callers have similar logic.
>
> I'll add a comment to make that clear.

Thanks

   Arnd
