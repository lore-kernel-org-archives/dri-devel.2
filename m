Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54F5CC6B03
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 06:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D21F10E2DF;
	Thu,  2 Apr 2026 06:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="c7KoBj+H";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA91F10E2DF
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 06:52:43 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260402065241euoutp0280f019741d8ace8798636a6591bfcbc6~id6brI7490115801158euoutp02w
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 06:52:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260402065241euoutp0280f019741d8ace8798636a6591bfcbc6~id6brI7490115801158euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1775112761;
 bh=JqJnKEECHMM1x06qmTO+uD6JrQrf2ZS4nGeqK+WTZzo=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=c7KoBj+HLoJ9sWu1hkYtLUUIevwDXI6D3RK20LI8rvG29JUKJiiiahbBwF5EWYT81
 YYsa2S2U6wfC9v9jKmDjGDjAFUqu4hVrc1o0CJnhBLOgrBBNI4u98esBReAXz7NbdN
 5HZRhHlKS0NnclWLjqBiY2m961MOpr6oaC9+k1Eo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260402065241eucas1p26fe08801bf816ff198a0361e0e00aa7d~id6bQM3u42082120821eucas1p2Q;
 Thu,  2 Apr 2026 06:52:41 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260402065238eusmtip2465f475377dc393f8274ea72cd5e5991~id6YxQUhd3266432664eusmtip2A;
 Thu,  2 Apr 2026 06:52:38 +0000 (GMT)
Message-ID: <7fc83a05-b392-4fc9-8ddb-1c169c698870@samsung.com>
Date: Thu, 2 Apr 2026 08:52:37 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 5/6] dma-buf: heaps: Add Coherent heap to dmabuf heaps
To: Maxime Ripard <mripard@redhat.com>, Andrew Davis <afd@ti.com>
Cc: Albert Esteve <aesteve@redhat.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Robin Murphy
 <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, Saravana Kannan
 <saravanak@kernel.org>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, echanude@redhat.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260316-cherubic-eel-of-philosophy-10ef2b@houat>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260402065241eucas1p26fe08801bf816ff198a0361e0e00aa7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260316120911eucas1p26492fa73abe29d02bb7f5da73f047abc
X-EPHeader: CA
X-CMS-RootMailID: 20260316120911eucas1p26492fa73abe29d02bb7f5da73f047abc
References: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
 <20260306-b4-dmabuf-heap-coherent-rmem-v3-5-3d00d36c9bc4@redhat.com>
 <e8dd476f-1be8-46fa-bf56-65fe0bfe29a1@ti.com>
 <CADSE00+-SQr3wGdgBmLowHPWE5bGxoyO4o20jZs4ma-71aOxUA@mail.gmail.com>
 <1afc696a-9afb-48af-887d-2a209680784e@ti.com>
 <CGME20260316120911eucas1p26492fa73abe29d02bb7f5da73f047abc@eucas1p2.samsung.com>
 <20260316-cherubic-eel-of-philosophy-10ef2b@houat>
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

On 16.03.2026 13:08, Maxime Ripard wrote:
> On Wed, Mar 11, 2026 at 08:18:28AM -0500, Andrew Davis wrote:
>> On 3/11/26 5:19 AM, Albert Esteve wrote:
>>> On Tue, Mar 10, 2026 at 4:34 PM Andrew Davis <afd@ti.com> wrote:
>>>> On 3/6/26 4:36 AM, Albert Esteve wrote:
>>>>> Expose DT coherent reserved-memory pools ("shared-dma-pool"
>>>>> without "reusable") as dma-buf heaps, creating one heap per
>>>>> region so userspace can allocate from the exact device-local
>>>>> pool intended for coherent DMA.
>>>>>
>>>>> This is a missing backend in the long-term effort to steer
>>>>> userspace buffer allocations (DRM, v4l2, dma-buf heaps)
>>>>> through heaps for clearer cgroup accounting. CMA and system
>>>>> heaps already exist; non-reusable coherent reserved memory
>>>>> did not.
>>>>>
>>>>> The heap binds the heap device to each memory region so
>>>>> coherent allocations use the correct dev->dma_mem, and
>>>>> it defers registration until module_init when normal
>>>>> allocators are available.
>>>>>
>>>>> Signed-off-by: Albert Esteve <aesteve@redhat.com>
>>>>> ---
>>>>>     drivers/dma-buf/heaps/Kconfig         |   9 +
>>>>>     drivers/dma-buf/heaps/Makefile        |   1 +
>>>>>     drivers/dma-buf/heaps/coherent_heap.c | 414 ++++++++++++++++++++++++++++++++++
>>>>>     3 files changed, 424 insertions(+)
>>>>>
>>>>> (...)
>>>> You are doing this DMA allocation using a non-DMA pseudo-device (heap_dev).
>>>> This is why you need to do that dma_coerce_mask_and_coherent(64) nonsense, you
>>>> are doing a DMA alloc for the CPU itself. This might still work, but only if
>>>> dma_map_sgtable() can handle swiotlb/iommu for all attaching devices at map
>>>> time.
>>> The concern is valid. We're allocating via a synthetic device, which
>>> ties the allocation to that device's DMA domain. I looked deeper into
>>> this trying to address the concern.
>>>
>>> The approach works because dma_map_sgtable() handles both
>>> dma_map_direct and use_dma_iommu cases in __dma_map_sg_attrs(). For
>>> each physical address in the sg_table (extracted via sg_phys()), it
>>> creates device-specific DMA mappings:
>>> - For direct mapping: it checks if the address is directly accessible
>>> (dma_capable()), and if not, it falls back to swiotlb.
>>> - For IOMMU: it creates mappings that allow the device to access
>>> physical addresses.
>>>
>>> This means every attached device gets its own device-specific DMA
>>> mapping, properly handling cases where the physical addresses are
>>> inaccessible or have DMA constraints.
>>>
>> While this means it might still "work" it won't always be ideal. Take
>> the case where the consuming device(s) have a 32bit address restriction,
>> if the allocation was done using the real devices then the backing buffer
>> itself would be allocated in <32bit mem. Whereas here the allocation
>> could end up in >32bit mem, as the CPU/synthetic device supports that.
>> Then each mapping device would instead get a bounce buffer.
>>
>> (this example might not be great as we usually know the address of
>> carveout/reserved memory regions, but substitute in whatever restriction
>> makes more sense)
>>
>> These non-reusable carveouts tend to be made for some specific device, and
>> they are made specifically because that device has some memory restriction.
>> So we might run into the situation above more than one would expect.
>>
>> Not a blocker here, but just something worth thinking on.
> As I detailed in the previous version [1] the main idea behind that work
> is to allow to get rid of dma_alloc_attrs for framework and drivers to
> allocate from the heaps instead.
>
> Robin was saying he wasn't comfortable with exposing this heap to
> userspace, and we're saying here that maybe this might not always work
> anyway (or at least that we couldn't test it fully).
>
> Maybe the best thing is to defer this series until we are at a point
> where we can start enabling the "heap allocations" in frameworks then?
> Hopefully we will have hardware to test it with by then, and we might
> not even need to expose it to userspace at all but only to the kernel.
>
> What do you think?

IMHO a good idea. Maybe in-kernel heap for the coherent allocations will 
be just enough.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

