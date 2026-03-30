Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39A8FF494F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 12:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABC910E204;
	Mon, 30 Mar 2026 12:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="lyd1qaKz";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46ACB10E683
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 12:51:40 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260330125138euoutp01cc8f411d2653e73ef5a3400f36e37e13~hn3_ULIsS1986619866euoutp01V
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 12:51:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260330125138euoutp01cc8f411d2653e73ef5a3400f36e37e13~hn3_ULIsS1986619866euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1774875098;
 bh=/K0BfatLUGOzJ2a4upShRyXd92Gck0knBszJjH43XM0=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=lyd1qaKzKOMZ/N8MPCsQmF5PntlcAwPgetCoeDe4ySx4mig0uYBXch9XggXmrVUzr
 /p05+mew8GhkRI8a9hzvHj3w0AnDpcZM/Wxis75yKmkrr+Z02UZq2MMZZ1XICvd8F9
 HpbWNeR7q5o6aznWI0alIbd+N/qLrjWo7Z7DLoVI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260330125136eucas1p20d38cd3f5c4c3772aeef5b7d2f2b8906~hn381TBya2647926479eucas1p2y;
 Mon, 30 Mar 2026 12:51:36 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260330125135eusmtip2d7715ffa0968cdc67f37ae3c3026faac~hn37iwEWw2261922619eusmtip2d;
 Mon, 30 Mar 2026 12:51:35 +0000 (GMT)
Message-ID: <ac7fa9bc-e966-4337-ae54-7bb6d8bd6e5a@samsung.com>
Date: Mon, 30 Mar 2026 14:51:34 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma/contiguous: Fix broken build
To: Maxime Ripard <mripard@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Robin Murphy
 <robin.murphy@arm.com>, Albert Esteve <aesteve@redhat.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev, Mark Brown <broonie@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260330-glaring-pygmy-dodo-fa06f3@houat>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260330125136eucas1p20d38cd3f5c4c3772aeef5b7d2f2b8906
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260330084111eucas1p1e7cd5c886e34d0ed41226fe524d2a55a
X-EPHeader: CA
X-CMS-RootMailID: 20260330084111eucas1p1e7cd5c886e34d0ed41226fe524d2a55a
References: <CGME20260330084111eucas1p1e7cd5c886e34d0ed41226fe524d2a55a@eucas1p1.samsung.com>
 <20260330-dma-build-fix-v1-1-748b64f0d8af@kernel.org>
 <62b9e47c-1c31-4654-8347-16516faf73f0@samsung.com>
 <20260330-glaring-pygmy-dodo-fa06f3@houat>
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

On 30.03.2026 13:41, Maxime Ripard wrote:
> On Mon, Mar 30, 2026 at 10:59:48AM +0200, Marek Szyprowski wrote:
>> On 30.03.2026 10:40, Maxime Ripard wrote:
>>> Commit 3a236f6a5cf2 ("dma: contiguous: Turn heap registration logic
>>> around") didn't remove one last call to dma_heap_cma_register_heap()
>>> that it removed, thus breaking the build.
>>>
>>> That last call is in dma_contiguous_reserve(), to handle the
>>> registration of the default CMA region heap instance if it's declared in
>>> the device tree.
>>>
>>> However, the default CMA region instance is already handled by
>>> retrieving it through dev_get_cma_area() in the CMA heap driver, so the
>>> call to dma_heap_cma_register_heap() wasn't actually needed.
>>>
>>> Let's remove this call, the now unused function definition, its now
>>> empty header, and all includes of this header.
>>>
>>> Fixes: 3a236f6a5cf2 ("dma: contiguous: Turn heap registration logic around")
>>> Reported-by: Mark Brown <broonie@kernel.org>
>>> Closes: https://lore.kernel.org/linux-next/acbjaDJ1a-YQC64d@sirena.co.uk/
>>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>>> ---
>>>  drivers/dma-buf/heaps/cma_heap.c  |  1 -
>>>  include/linux/dma-buf/heaps/cma.h | 16 ----------------
>>>  kernel/dma/contiguous.c           |  5 -----
>>>  3 files changed, 22 deletions(-)
>>>
>>> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
>>> index f8a3d87f3ccee9630383ba28502eb40b10671cc2..cc517ac68a0bec0788abcb338c03f530d169013b 100644
>>> --- a/drivers/dma-buf/heaps/cma_heap.c
>>> +++ b/drivers/dma-buf/heaps/cma_heap.c
>>> @@ -12,11 +12,10 @@
>>>  
>>>  #define pr_fmt(fmt) "cma_heap: " fmt
>>>  
>>>  #include <linux/cma.h>
>>>  #include <linux/dma-buf.h>
>>> -#include <linux/dma-buf/heaps/cma.h>
>>>  #include <linux/dma-heap.h>
>>>  #include <linux/dma-map-ops.h>
>>>  #include <linux/err.h>
>>>  #include <linux/highmem.h>
>>>  #include <linux/io.h>
>>> diff --git a/include/linux/dma-buf/heaps/cma.h b/include/linux/dma-buf/heaps/cma.h
>>> deleted file mode 100644
>>> index e751479e21e703e24a5f799b4a7fc8bd0df3c1c4..0000000000000000000000000000000000000000
>>> --- a/include/linux/dma-buf/heaps/cma.h
>>> +++ /dev/null
>>> @@ -1,16 +0,0 @@
>>> -/* SPDX-License-Identifier: GPL-2.0 */
>>> -#ifndef DMA_BUF_HEAP_CMA_H_
>>> -#define DMA_BUF_HEAP_CMA_H_
>>> -
>>> -struct cma;
>>> -
>>> -#ifdef CONFIG_DMABUF_HEAPS_CMA
>>> -int dma_heap_cma_register_heap(struct cma *cma);
>>> -#else
>>> -static inline int dma_heap_cma_register_heap(struct cma *cma)
>>> -{
>>> -	return 0;
>>> -}
>>> -#endif // CONFIG_DMABUF_HEAPS_CMA
>>> -
>>> -#endif // DMA_BUF_HEAP_CMA_H_
>>> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
>>> index ad50512d71d3088a73e4b1ac02d6e6122374888e..9fe001c712339f8388d3f40cca3dfff3f707fcbf 100644
>>> --- a/kernel/dma/contiguous.c
>>> +++ b/kernel/dma/contiguous.c
>>> @@ -40,11 +40,10 @@
>>>  #include <asm/page.h>
>>>  
>>>  #include <linux/memblock.h>
>>>  #include <linux/err.h>
>>>  #include <linux/sizes.h>
>>> -#include <linux/dma-buf/heaps/cma.h>
>>>  #include <linux/dma-map-ops.h>
>>>  #include <linux/cma.h>
>>>  #include <linux/nospec.h>
>>>  
>>>  #ifdef CONFIG_CMA_SIZE_MBYTES
>>> @@ -270,14 +269,10 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>>>  						  selected_limit,
>>>  						  &dma_contiguous_default_area,
>>>  						  fixed);
>>>  		if (ret)
>>>  			return;
>>> -
>>> -		ret = dma_heap_cma_register_heap(dma_contiguous_default_area);
>>> -		if (ret)
>>> -			pr_warn("Couldn't register default CMA heap.");
>> After this change no dma-buf heap for the default CMA area is created if it has 
>> not been specified in device-tree. This might be especially a problem for the
>> non-dt systems.
> I don't think that's the case? My understanding is that
> dma_contiguous_reserve() is called by the arch code, and will create
> that region only if it hasn't be set by the DT (that excerpt above is
> run only if !dma_contiguous_default_area).
>
> However, for the DT case, dma_contiguous_default_area will be set by
> rmem_cma_setup() a bit below if linux,cma-default is set in the DT.
>
> dma_contiguous_reserved() is called (on arm64 at least) through
> bootmem_init(), called as part of setup_arch().
>
> rmem_cma_setup() is called through RESERVEDMEM_OF_DECLARE, so through
> __reserved_mem_init_node(), so, if we consider only the public
> functions, through:
>
>   * fdt_scan_reserved_mem_reg_nodes(), called by
>     unflatten_device_tree(), called right before bootmem_init() in
>     setup_arch();
>
>   * or fdt_scan_reserved_mem() and then
>     early_init_fdt_scan_reserved_mem(), called in arm64_memblock_init(),
>     itself called in setup_arch() earlier than both
>     unflatten_device_tree(), and bootmem_init().
>
> Thus, the DT case will run first and set dma_contiguous_default_area if
> relevant on that platform, and if it's not set, the non-DT case will set
> it up. Either way, dma_contiguous_default_area will be set.
>
> The CMA heap runs much later using a regular module_init. It will
> retrieve dma_contiguous_default_area through dev_get_cma_area(), and
> will create a heap instance for the default area.
>
> Am I misunderstanding something?

The default CMA area is also optional for DT platforms. 

If DT doesn't provide such, it will be created based on the kernel cmdline cma= parameter or the default configuration defined in the kernel .config (this is also true for the non-dt platforms). I know that for most Android GKI systems the default CMA area will be defined in DT, but I see no reason to disable dma-buf heap support for the default CMA area if it has been instantiated from kernel cmdline or .config.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

