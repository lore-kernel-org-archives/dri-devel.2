Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48420C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A598A10F541;
	Fri, 17 Jul 2026 12:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Dnwbk61c";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8929810F541
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:30:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E9841476;
 Fri, 17 Jul 2026 05:30:31 -0700 (PDT)
Received: from [10.57.84.220] (unknown [10.57.84.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B58A3F7B4;
 Fri, 17 Jul 2026 05:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784291435; bh=VughRvZS3iel7qOa0HOxMdU0JGPYnF1hquaPOHQ7V2g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Dnwbk61c//Ro+a5eEjiWYqY+mydSl9pQFPNRcoRGiC3zmU2ACKQh4KPeY5M8DvbTY
 ONBIzrrAMIInP2pev4eRDrecGDNOikY7Aaa7Rn9y9if8dfiGE9O2OCgVud9Is7W4MQ
 CxDUYX2C1F/uatWwkExaY4PvwxEmqEpdH0V0RvC0=
Message-ID: <38a7c29a-7859-4f38-b36d-473cae61cb56@arm.com>
Date: Fri, 17 Jul 2026 13:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] Arm Core Local Accelerator Driver
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, maz@kernel.org,
 oupton@kernel.org, hch@infradead.org, jgg@nvidia.com
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <aloS_T3LQvpHeZUV@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aloS_T3LQvpHeZUV@willie-the-truck>
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

Hi Will,

On 17/07/2026 12:33, Will Deacon wrote:
> Hi Ryan,
> 
> I haven't bothered to look at the code (looks like Sashiko is having fun
> with that), but I'm going to jump at this bit:

Thanks for the quick reply!

JP and I had a quick glance at the Sashiko feedback; looks like some useful
stuff, and a few false alarms. Nothing cricial though. Not that it matters too
much for this stage of discussion.

> 
> On Fri, Jul 17, 2026 at 11:47:44AM +0100, Ryan Roberts wrote:
>> * User space availability: The kernel driver exposes the capabilities of the
>>   hardware to user space. Arm plans to open source a user space driver, but does
>>   not yet have any committed date. I'd like to understand if the availability of
>>   this component will be a prerequisite for upstream acceptance of the kernel
>>   driver; either way, I'm hoping we can at least progress with some discussion
>>   in its absence.
> 
> From my perspective, I'm not particularly interested in having code in
> the upstream kernel tree that we can't meaningfully exercise or benefit
> from. I also think that the incentive for Arm to open source the
> user-space driver practically disappears if we merge the kernel part
> first. So, at the moment, this just looks like a burden to me, especially

Understood. Now that I have such a clear statement, hopefully I can use that to
work internally to get commitments and dates to build a proper plan. What I'm
trying to get out of this RFC though, is "is having an open source user space
the main blocker, or are there other significant challenges here too?".

> as it appears to create a brand new, device-specific UAPI for what is
> ostensibly a form of SVA - something which the community is actively
> working on already.
> 
> Relatedly, is there a spec and/or fastmodel/qemu (sorry...) support for
> this?

They both exist internally of course. There is a plan to publish the spec, but I
don't think we will converge on a timeframe until after the summer now. I'll
follow up regarding fastmodel.

> 
>> I'm deliberately constraining the scope to bare-metal support for now.
>> Virtualization is something we are considering (and have prototyped), but plan
>> to post a separate RFC for that as follow-up, once we have agreement on
>> direction for the bare-metal driver.
> 
> I'd actually like to see what the virtualisation part looks like first
> because doing it as a bolt-on later feels like the wrong approach. The
> structure you have at the moment is remarkably clean, given the
> architectural/CPU interactions (this thing even apparently builds as a
> module, nice!), but I'm unsure how far you can push the separation once
> you need to start hacking at KVM. Maybe the MMU notifiers are enough,
> but I can't tell.

The virtualization implementation is not as advanced as bare-metal and JP can
probably comment on it in more detail, but the intention is to expose the HW
using VFIO-MDEV (mediated device framework). We will need exported functions
from (the arm64 part of) KVM to grab the S2 pgdir and to get/put the VMID - we
would not be using MMU notifiers but instead sharing the pgtable and VMID and
piggybacking the CPU's TBLI operations. My current expectation is that it can be
made to work without deep KVM integration and still as a module, but let's see
where we get to with the code. (I have spoken with Marc about this briefly - I
would say he doesn't love it, but agreed to look at the code when we have it).

But I think I'm hearing that to get into a deeper discussion we will need to
post virt support? In which case, I'll prioritise getting something together.
I'm about to be on sabbatical for 4 weeks though, so probably won't be until
~early Sept.

Thanks,
Ryan


> 
> Will

