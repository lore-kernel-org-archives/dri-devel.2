Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13404C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7708710E18D;
	Mon, 14 Sep 2026 12:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ntSiCFzF";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 96DE410E18D
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:17:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DE821576;
 Mon, 14 Sep 2026 05:17:40 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 452523F86F;
 Mon, 14 Sep 2026 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789388264; bh=c0CFsUaosLdBaAY1WVZXpEpvXD8k8XfgcUQrkA6InPM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ntSiCFzFkuEdj3K33SmO+PzjbPECbuW1/EaQ1yQvrkgJeIHb8P1qXEcBjuw4L3n/a
 5feEXdS3bbHFTDLKA/lTSqqgfUdDt3PfSSPiCEpcXVf6A3/3eJtvrHG14tCb2NKu62
 oqcozB1jlR3R9fus2DDr7VYmt1u52rQT3C1hWedc=
Message-ID: <ea8caba1-eb78-40cd-b025-e8c02009f2d7@arm.com>
Date: Mon, 14 Sep 2026 13:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum segment
 size
To: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Matteo Kloiber <kernel@matt3o12.de>, aliceryhl@google.com,
 ojeda@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 a.hindborg@kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
 <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com> <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
 <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 14/09/2026 11:22 am, Gary Guo wrote:
> On Mon Sep 14, 2026 at 10:58 AM BST, Danilo Krummrich wrote:
>> On Mon Sep 14, 2026 at 2:45 AM CEST, Alexandre Courbot wrote:
>>> On Mon Sep 14, 2026 at 6:08 AM JST, Matteo Kloiber wrote:
>>>> On Mon Sep 7, 2026 at 11:43 AM JST, Alexandre Courbot wrote:
>>>>> It also means that without patch 1, nova-core would split the firmware
>>>>> into hundreds of 64KB SG entries, which is not breaking but still
>>>>> something we want to avoid. The correct fix is to make sure that
>>>>> `dma_set_max_seg_size` is called by the driver, and while we are at it
>>>>> we also want every driver to call `dma_set_mask_and_coherent`. Ideally
>>>>> we would use the type system to make sure that both functions are called
>>>>> before any DMA operation can take place (using a safe interface), but
>>>>> I'm not quite sure yet how we can do this.
>>>>
>>>> This sounds sensible indeed. Should I open a thread regarding that on Zulip?
>>>
>>> Probably not necessary, the mailing-list has a larger audience and is
>>> the right place for this. I expect people will jump in here with their
>>> thoughts.
>>
>> The problem with those is not that they must strictly be called before
>> allocating DMA memory, but they must not be called concurrently with other DMA
>> operations, such as allocating DMA memory, as it would technically be a data
>> race.
> 
> Do they really have to be called *before* allocating DMA memory, not do they
> just need not be called *concurrent* to DMA memory allocation?

Similar to DMA masks, the segment parameters should be set appropriately 
before any dma_map_sg() operation. Plus since they likely influence 
scatterlist geometry, that means typically they're also going to need to 
be set before building the scatterlist to be mapped in the first place.

I don't think there's any expectation that they would ever change 
*between* different mappings - especially given the underlying hardware 
properties they represent - so while that might technically be possible 
in the C API if the caller can enforce sufficient ordering, it should be 
fine to rule it out in the Rust abstraction if that makes things easier 
to reason about.

Thanks,
Robin.

> If it's the former, we can require these to require mutable reference instead,
> so the probe takes `Pin<&'bound mut Device<Core<'_>>>` which still derefs to
> `&'bound Device<Bound>`, but Rust will require the shared reference to not
> co-exist with the mutable reference.
> 
> Best,
> Gary
> 

