Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F2FC4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 710C410E1D0;
	Fri, 17 Jul 2026 13:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="r/um21kc";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="DoydIq9w";
	dkim-atps=neutral
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9494510E1D0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:50:15 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D5EFA140007F;
 Fri, 17 Jul 2026 09:50:14 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 09:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784296214;
 x=1784382614; bh=scOaW8T/6xUJRRlim9gHWFq1a9XkSY2vJK+xeZy0trI=; b=
 r/um21kch8ow3J1TlPz7DsYLRS5x/5p+ifQZVJb9KcCwMZG++e09REtPBx2lRI6m
 oOrXnn2WlvAo6FcDCI2/ZtofNF17kTP0ybWPeU8tdFKyKhsSGQI1CHd5yZDU+8QO
 lxDxYmfSW/TUSq5IRHRfkcvYvkoFSNUFyTZ4N5TbNlgrl8pQfRVU9xLuhvqrIN7D
 xrQs044u2cqEat4+gOkhxLlZc86nzfaXxrKDHStBjFsqCzrZLKhppLnAn6l18YUM
 YGSHZHBocWfiEtJrMyIRhfAuNCF2aYXce8CtE9TaNwgbIU9ggWE/JWYCquIFCL0/
 Qhu/y+hnfzNu+mws1iiLTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784296214; x=
 1784382614; bh=scOaW8T/6xUJRRlim9gHWFq1a9XkSY2vJK+xeZy0trI=; b=D
 oydIq9wkbVOPVWiKqSHMiUUJ4G+ySIrB2H2FYAMoYIXXo5c61sliw/TTlXDy1EFP
 GvrlyvK+EJ1stS99PkkysyqQWkhucJMiP3Bx/0NSOLTiB0YKE0c+P04aOwh4vocF
 TynxJVlqje3pzToEJSuSTgC8FPoNYjyeEpOT29JKkx8sTweRQmXB5oy6QpbBOLqg
 vTKKg+tPJtnlLjvlIyjo1eR16WwPFEjCg0t4pAQ0zJz1NC7VZuqgtZveMZVbPXly
 uIEPbrL4DD0e2sXqG0bfuXFAWVKXtBOW5akDfINzNJ5Xwff6FVmB++l09vA/rylF
 tkc0iUtiKZUxaweCjyH1w==
X-ME-Sender: <xms:FjNaalM_FGYe6x43Rb5xf9-Xv3B4lGttCwUJST8D3LJlIzQQzGVOvw>
 <xme:FjNaaixclt27LGU_DnpycOWrK19gJpv-lQLWtTT-XdkmlEnbWize9SlvB3PDFbRLT
 K8AqG3Ny4WDczSKHXYVsCFG8Fftk0omkVmOxBBPoqenZApd0S06kXA>
X-ME-Proxy-Cause: dmFkZTERJCEXhIMrlS3slC0kmihwzJcFh0B4FXxdorq9T1Q0T0Mxl29TLDsJr5PeZzGWpe
 UbsORXZHVsIFCXvn0fDDgnTxiwceDhvaxWSAKiGO3RO78ePsJ557lq0IMb4ArG7EdMLnrj
 ZL3WEQ+Qp24tDiqurw4OiSagfB4DUNROb0h59g66fvn2eDLm/mX/B6tFPaqc1vG8cGEMPm
 b4w+u8YJHg/gWEczMsrNlQavLyVKsZ/mLrIZFqlZ2MMLunTExVR0vGBTjO9qpVxP+JpJG4
 W8SaW5cmC9Ohkhw1t691Tt+5oN2Hp1oDsnEsLpo68Hcdm7NBmWzO6m44nEjLuchtJA34EB
 Tfhl9ZZbodA7mkTtwZdAEls37TCYJrc3EWJHEBBdA9G+XO1BPyHnDBko//x9eCv+MsjKla
 EU5Eu/77IejqxFtmojaZ6Tc4RwGf/02oejE3Fn27NwJH36Tla5N/GrPl9Q1XC3hh2bENT3
 kaoNT+A1/rbt0EyikRLkoxiIOuXXEs5yeglbceonlVkgQ9qxZEQYvofR1zAqRoGjMpsAue
 at3qpm34p43g3dgSDNyOAaAgUyv+fl4EczPjEHSWLg7tra71EzXDh3UWeY2b7TgtQC1Ul+
 3sATV7/B7x7GKIGuBSK/Ss7vgZLdrAuzj/c46hkU6rRrkjXuhk2P3jDbE19A
X-ME-Proxy: <xmx:FjNaap9TJUaoTtgF3nBlyvC724B9DzcZU-H5ngyHTB8sc5zzrUom6w>
 <xmx:FjNaakMUB8W__6BUCuLsbEQ1MxFgaC5U5iR47kpOH50DYLzV07PRXQ>
 <xmx:FjNaalDd5aAdEW4FEffL78C5yzp5pFGOkfAl8GloX0rQpYauNMLHzA>
 <xmx:FjNaagNnH3rgajyUv8Wo41Nt42gfB-JH_xMvZa03p659IFbO6xhgUA>
 <xmx:FjNaaiSqUESq2TOdRHcQNoLt08u6EyXWR9qPDMzWvqCKc9KFYoO5drv5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 653CB1820086; Fri, 17 Jul 2026 09:50:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AIcAXbcH1-lN
Date: Fri, 17 Jul 2026 15:49:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Roberts" <ryan.roberts@arm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, 
 "Mark Rutland" <mark.rutland@arm.com>,
 "Jean-Philippe Brucker" <jpb@kernel.org>, "Oded Gabbay" <ogabbay@kernel.org>, 
 "Jonathan Corbet" <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Message-Id: <1e561b1a-2c87-4a23-b4da-126b333de8ba@app.fastmail.com>
In-Reply-To: <20260717104759.123203-2-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-2-ryan.roberts@arm.com>
Subject: Re: [RFC PATCH v1 1/8] misc/arm-cla: Add driver skeleton and
 documentation
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

On Fri, Jul 17, 2026, at 12:47, Ryan Roberts wrote:
> From: Jean-Philippe Brucker <jpb@kernel.org>
>
> Add the initial Kconfig and build-system plumbing for the Arm Core Local
> Accelerator driver.
>
> Introduce the common driver header and register definitions used by
> later CLA support. The definitions cover the CLA MMIO frame, launch
> response and status fields, standard accelerator registers, launch
> opcodes, error codes and memory translation context state.
>
> Add documentation describing the CLA programming model, its CPU-local
> MMIO access rules, userspace assignment model, domain grouping and
> expected boot state.

I have a few more questions here. Most of the description and
the design decisions make perfect sense to me, but there are
a few things I don't understand from your current document.

> +The CLA supports up to 8 attached accelerators, which are accessed by
> +programming the CLA's MMIO registers. Operations are launched to an 
> accelerator
> +and are polled for completion. CLA does not raise interrupts.
> +
> +            CPU                     CLA              Accel
> +             |--- write DATA[7:0] -->|                 |
> +             |--- write LAUNCH ----->|---- launch ---->|
> +             |<--- poll LRESP -------|                 |
> +             |                       |                 |
> +             |<--- poll STATUS ------|<--- complete ---|
> +
> +Each operation can take a 512-bit payload in the DATA registers. After handling
> +a LAUNCH write, CLA indicates the launch status in the LRESP register. A further
> +operation can only be launched after LRESP indicates completion of the previous
> +launch.

This sounds a lot like st64bv or st64bv0, passing an 8-word payload and returning
a single word per accelerator operation with shared addressing.

Why are there now two interfaces to do the same thing?

Can a user process use st64bv to do the four steps in a
single instruction?

> +Some operations continue to run asynchronously on the accelerator after launch
> +completion. In this case progress is tracked by polling the STATUS register.
> +When the CLA updates the STATUS register, it also raises an event which will
> +wake an in-progress WFE (wait for event) instruction on the local CPU.

The asynchronous interface seems very confusing.

How are page faults from the SVA master resolved during an
asynchronous operation?

Can a CPU start multiple asynchronous operations concurrently?

Do these continue to run if the starting process is scheduled out
and another process also tries to use CLA?

> +Faults during address translation are reported by the accelerator in its
> +registers and in STATUS. While polling for work completion, software fixes up
> +the faults and notifies the accelerator with RESOLVE operations.

I would like to understand the faulting part better. Which instruction
specifically causes the fault, is that the poll STATUS read?

> +Inter-Accelerator Communication
> +-------------------------------
> +
> +On some platforms, multiple accelerators, each attached to a separate CLA within
> +a cluster, are also directly connected to each other via a shared bus to
> +accelerate cooperation between accelerators. The accelerators sharing a bus
> +cannot be isolated from each other. When collaborative operations are launched
> +on each of the participating accelerators, they synchronize over the bus,
> +stalling until all are ready.

Could you give an example what this model might be good for?

Does this mean a user may have to start one operation on each CPU
from a thread of the same process in order to get a result efficiently
across a shared accelerator?

I assume this will become clearer once you can show an example userspace
application that uses this type of accelerator.

> +Intended SW Usage Model
> +=======================
> +
> +CLA is designed for its PL0 MMIO frame to be mapped into user space  and for user
> +space to directly launch accelerator operations and poll for completion. It has
> +been observed that for some use cases, the operation execution time is small and
> +a trip through the kernel would consume a significant amount of the CPU budget
> +for preparing the next operation leading to a significant reduction in bandwidth
> +through the accelerator.

Do you have any plans for in-kernel usage of the accelerators?
I would assume that for things like cryptographic features, these
make sense to be exposed to the kernel itself.

> +User space software is expected to create a thread to drive each CLA it is
> +using, and for each thread to be pinned to the CLA's local CPU.

What happens if multiple processes have the same chardev open and
each mmap() that, e.g. after a fork()? Does each process see its
own virtual instance of the accelerator and interact with it through
the same physical MMIO register range but its own process address space,
or do you have to rely on the registers being mapped only into a
single mm_struct to prevent a process from messing with another process
data?

> +Saving and restoring the internal state of the accelerator is an optional
> +feature. Current platforms only support it when the accelerator is idle, so
> +preempting an accelerator causes work cancellation. Software must carefully
> +consider how to balance forward-progress guarantees with preemption 
> latency.

I'm not sure I understand this point. Do you mean any async operation
that was started on an accelerator may fail due to preemption, so user
space must be able to restart it?

     Arnd
