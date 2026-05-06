Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F05CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCB310EE0C;
	Wed,  6 May 2026 15:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="OP8+PNR9";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3B47A10EE0C
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 15:55:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F74D1A00;
 Wed,  6 May 2026 08:55:42 -0700 (PDT)
Received: from [10.57.69.49] (unknown [10.57.69.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAE7A3F7B4;
 Wed,  6 May 2026 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778082947; bh=yx44QsR+dr0wp1FGWIHshhf2FouszWxeHYwpeS2FZdA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OP8+PNR9HAAL7fsQC1pkWVwQFHDeoeuWGPOUMiDIZm2DfhnHN1KIfEHs0OrIRvYaz
 xZSj4xf4c/FtDLNgS6E19u5T/pdKEJmw6oI8rUcTk9jiwZCAJ5g1QeRXU4zdbx5elF
 cN/N/QgEV5oR424hZ7qnkvgDAFMaE0jWBZz6r+J8=
Message-ID: <b3c98120-2493-46a5-a48c-d90c31cf25c0@arm.com>
Date: Wed, 6 May 2026 16:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Let userspace explicitly trigger memory reclaims
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260506-panthor-explicit-reclaim-v1-0-44f82ac147ce@collabora.com>
 <829b8887-48de-4cfa-8bb2-79db1471bb8d@arm.com>
 <qxAaM8FMQLuQt09qti64IA@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <qxAaM8FMQLuQt09qti64IA@collabora.com>
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

On 06/05/2026 16:43, Nicolas Frattaroli wrote:
> On Wednesday, 6 May 2026 17:06:56 Central European Summer Time Steven Price wrote:
>> On 06/05/2026 11:45, Nicolas Frattaroli wrote:
>>> RAM is not, in fact, cheap. Especially on embedded systems with a low
>>> amount of memory, but known and well-defined userspace, more explicit
>>> resource management can lead to better utilisation patterns. As an
>>> example, a resource manager process on a purpose-built device may wish
>>> to launch, and then explicitly swap out, memory of processes that are
>>> kept "warm", to improve perceived startup latency of individual
>>> full-screen applications without making the kernel figure out the usage
>>> pattern from observation alone in order to swap out the right pages.
>>
>> Have you considered memory control groups (memcg) for this purpose?
>> Imposing a lower limit than currently allocated should trigger reclaim,
>> so 'background' applications could have the limit lowered and then
>> restored when moved to the foreground.
> 
> This is a suggestion in line with what I've made to the entity for
> whom I am adding this, but was told that for them they really do want
> tight control without having to use cgroups into technically doing it
> by dynamically adjusting the limits of them.
> 
> I do think that writing 0 to `memory.high` to swap it out and `"max"`
> to allow it to swap back in might work, though that'll then apply to
> all of the process' memory, not just the GPU resources.
> 
> I will ask for clarification internally.

Thanks, it would be good to have a better understanding of why GPU
memory is special (and needs to be paged out) and the process' other
memory can be kept.

>>
>>> To allow for this explicit control in the context of panthor's GPU
>>> memory, add two new sysfs knobs. The first, mem_reclaim, runs an
>>> explicit priv BO reclaim cycle on the TGID written to it.
>>>
>>> The second, mem_claim, does the opposite: it swaps BOs back into active
>>> memory.
>>
>> How necessary is this mem_claim for performance? Have you done any
>> benchmarking of explicitly claiming vs just allowing it to happen
>> naturally? My gut feeling is that mem_claim should be unnecessary in
>> most situations, but I'm prepared to be proved wrong.
> 
> I've done no benchmarking, but can do so if you have any preferred
> workloads for this. Since we have to keep entire groups either in
> memory or out of memory right now AFAIK, I don't expect this to be
> very beneficial at all. At most we avoid a single fault I think.

Yes the memory should be brought back in as soon as a job is submitted.
I've no particular workloads in mind - but it would be nice to be able
to point to something that actually improves by adding this feature.

> I can drop the mem_claim part, though it may become relevant if we
> ever have more fine-grained memory eviction where a single job or
> group can run into multiple faults before everything it needs to
> render a new frame is back in memory. In that case, it will be
> beneficial, because it avoids doing the swap-in dance several
> times while the user wonders why the UI is rendering at powerpoint
> speeds as it touches memory pages that are still swapped out during
> subsequent frames.

We don't want to be faulting memory in a page at a time for exactly the
reasons you state. So even if we do make things more fine-grained we're
going to have to implement some form of read-ahead. Otherwise it's
"powerpoint time" after any even that causes memory pressure.

A possible justification is if the system can tell an application is
about to be used and can "pre-fault" things before rendering starts. But
it's a rare system design where it has this form of precognition.

Thanks,
Steve

>>
>> I'm not saying this series is necessarily the wrong approach - but I
>> think we need a bit more justification for adding a new API for this.
>>
>> Thanks,
>> Steve
> 
> Kind regards,
> Nicolas Frattaroli
> 
>>
>>> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>>> ---
>>> Nicolas Frattaroli (4):
>>>       drm/panthor: Add freed_sz parameter to reclaim_priv_bos
>>>       MAINTAINERS: Add sysfs ABI docs to list of panthor files
>>>       drm/panthor: Add explicit memory reclaim sysfs knob
>>>       drm/panthor: Add explicit memory claim sysfs knob
>>>
>>>  Documentation/ABI/testing/sysfs-driver-panthor-mem | 34 ++++++++
>>>  MAINTAINERS                                        |  1 +
>>>  drivers/gpu/drm/panthor/panthor_drv.c              | 93 ++++++++++++++++++++++
>>>  drivers/gpu/drm/panthor/panthor_gem.c              |  7 +-
>>>  drivers/gpu/drm/panthor/panthor_gem.h              |  1 +
>>>  drivers/gpu/drm/panthor/panthor_mmu.c              | 70 +++++++++++++++-
>>>  drivers/gpu/drm/panthor/panthor_mmu.h              |  4 +
>>>  7 files changed, 205 insertions(+), 5 deletions(-)
>>> ---
>>> base-commit: 2c4b906cd135bbb44855287d0d0eff0ee0b47afe
>>> change-id: 20260506-panthor-explicit-reclaim-3dffed028d8c
>>>
>>> Best regards,
>>> --  
>>> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>>>
>>
>>
> 
> 
> 
> 

