Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B65108B912
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF4510E562;
	Fri, 20 Mar 2026 12:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Lm+LMJ1N";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4034010E562
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:24:23 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260320122421euoutp010b2c70aea8c55c4270e4ee53bf374981~ejDS4Tb082252722527euoutp01s
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:24:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260320122421euoutp010b2c70aea8c55c4270e4ee53bf374981~ejDS4Tb082252722527euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1774009461;
 bh=zBoVOBx1I566RxpDMI+o2b7Nge6l1DhueDNqbVeTZ9I=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=Lm+LMJ1N2KMDXYMK1DOJQHu+mcsmsRVm47PRbfNKkp8LdCVnjJF+uuVbrRgj1j9cG
 U6RyPHSthJw3H1wRb6DJWdKEkegzlLK8kjUL4OkQza+IkqiKcpbdhiO2jqVXlE4EAI
 pmpJvKXTiVmVuJGUhpk10ye6Ti+6l5/UoHmotHuQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260320122421eucas1p17d0a17d9bdd22b45c1e60c78271e1d65~ejDSnuv7b2308323083eucas1p1i;
 Fri, 20 Mar 2026 12:24:21 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260320122419eusmtip117bbdef1d0f760c12e7437f2d83e9ca0~ejDRniVoR0999509995eusmtip1m;
 Fri, 20 Mar 2026 12:24:19 +0000 (GMT)
Message-ID: <c60a3f30-6fc3-41ab-835a-2fdd887e18fd@samsung.com>
Date: Fri, 20 Mar 2026 13:24:18 +0100
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 0/8] dma-buf: heaps: Turn heaps into modules
To: Maxime Ripard <mripard@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Robin Murphy
 <robin.murphy@arm.com>, Andrew Morton <akpm@linux-foundation.org>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: Albert Esteve <aesteve@redhat.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260303-dma-buf-heaps-as-modules-v3-0-24344812c707@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260320122421eucas1p17d0a17d9bdd22b45c1e60c78271e1d65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260303101320eucas1p2eb4fea499364ef20825d0d73585a2555
X-EPHeader: CA
X-CMS-RootMailID: 20260303101320eucas1p2eb4fea499364ef20825d0d73585a2555
References: <CGME20260303101320eucas1p2eb4fea499364ef20825d0d73585a2555@eucas1p2.samsung.com>
 <20260303-dma-buf-heaps-as-modules-v3-0-24344812c707@kernel.org>
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

Hi Maxime,

On 03.03.2026 11:13, Maxime Ripard wrote:
> The recent introduction of heaps in the optee driver [1] made possible
> the creation of heaps as modules.
>
> It's generally a good idea if possible, including for the already
> existing system and CMA heaps.
>
> The system one is pretty trivial, the CMA one is a bit more involved,
> especially since we have a call from kernel/dma/contiguous.c to the CMA
> heap code. This was solved by turning the logic around and making the
> CMA heap call into the contiguous DMA code.
>
> Let me know what you think,
> Maxime
>
> 1: https://lore.kernel.org/dri-devel/20250911135007.1275833-4-jens.wiklander@linaro.org/
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

I'm okay with the kernel/dma/contiguous.c changes. I only wonder how to 
properly merge them. There are other pending changes to 
kernel/dma/contiguous.c file [1] and if they finally get reviewed, I 
would like to merge both via dma-mapping-for-next tree. Then I can 
provide a stable branch for merging the remaining dma-buf pathes. Is it 
okay for You?

1. 
https://lore.kernel.org/all/20260313150802.1121442-1-m.szyprowski@samsung.com/ 



> ---
> Changes in v3:
> - Squashed cma_get_name and cma_alloc/release patches
> - Fixed typo in Export dev_get_cma_area commit title
> - Fixed compilation failure with DMA_CMA but not OF_RESERVED_MEM
> - Link to v2: https://lore.kernel.org/r/20260227-dma-buf-heaps-as-modules-v2-0-454aee7e06cc@kernel.org
>
> Changes in v2:
> - Collect tags
> - Don't export dma_contiguous_default_area anymore, but export
>    dev_get_cma_area instead
> - Mentioned that heap modules can't be removed
> - Link to v1: https://lore.kernel.org/r/20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org
>
> ---
> Maxime Ripard (8):
>        dma: contiguous: Turn heap registration logic around
>        dma: contiguous: Make dev_get_cma_area() a proper function
>        dma: contiguous: Make dma_contiguous_default_area static
>        dma: contiguous: Export dev_get_cma_area()
>        mm: cma: Export cma_alloc(), cma_release() and cma_get_name()
>        dma-buf: heaps: Export mem_accounting parameter
>        dma-buf: heaps: cma: Turn the heap into a module
>        dma-buf: heaps: system: Turn the heap into a module
>
>   drivers/dma-buf/dma-heap.c          |  1 +
>   drivers/dma-buf/heaps/Kconfig       |  4 ++--
>   drivers/dma-buf/heaps/cma_heap.c    | 21 +++++----------------
>   drivers/dma-buf/heaps/system_heap.c |  5 +++++
>   include/linux/dma-map-ops.h         | 18 ++++++++++--------
>   kernel/dma/contiguous.c             | 37 ++++++++++++++++++++++++++++++++++---
>   mm/cma.c                            |  3 +++
>   7 files changed, 60 insertions(+), 29 deletions(-)
> ---
> base-commit: 499a718536dc0e1c1d1b6211847207d58acd9916
> change-id: 20260225-dma-buf-heaps-as-modules-1034b3ec9f2a
>
> Best regards,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

