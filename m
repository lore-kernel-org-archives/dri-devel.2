Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05C8109E545
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 09:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C1910ED4F;
	Fri, 27 Mar 2026 09:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="tEJ9O1Jn";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA3410ED4F
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:38:15 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260327093813euoutp0207e68ae41eded6f5daf4d53dc936e98c~gqTPzhMjA0964809648euoutp02i
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:38:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260327093813euoutp0207e68ae41eded6f5daf4d53dc936e98c~gqTPzhMjA0964809648euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1774604293;
 bh=0wrrBT9Vgx5xYr3ZtqLPUbt27G4B7MOzYfS2jPrN8kQ=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=tEJ9O1Jnk3kcIWa/GQWlYDVsdjOZbDe2dmIbrigJ2c8G34HJxvn4IGvWDvX6x+guU
 7OpBFxvD7I7peNfcsUSBPn89cUk2ApU4PUTRxPyPG696UClnlWenGkehnLiZR0L6c7
 OM7P/DSIpX29McX5cWpjCy5Zro3ZtRdqNda5cH0o=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260327093813eucas1p2491c30df8c61bc550d31f05d90811332~gqTPXpzSE0810508105eucas1p2a;
 Fri, 27 Mar 2026 09:38:13 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260327093811eusmtip192818a11797378662e842d7b047a01bf~gqTNROVR00077200772eusmtip1F;
 Fri, 27 Mar 2026 09:38:11 +0000 (GMT)
Message-ID: <f2047cd7-91a8-4f6a-b6b9-0e4f143f6854@samsung.com>
Date: Fri, 27 Mar 2026 10:38:10 +0100
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly shared/decrypted memory
To: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
 Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
 christian.koenig@amd.com, robin.murphy@arm.com, jgg@ziepe.ca,
 leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com,
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260325192352.437608-1-jiri@resnulli.us>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260327093813eucas1p2491c30df8c61bc550d31f05d90811332
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260325192400eucas1p2ae38ff4c2b3ab35a7047cfd680d9fda3
X-EPHeader: CA
X-CMS-RootMailID: 20260325192400eucas1p2ae38ff4c2b3ab35a7047cfd680d9fda3
References: <CGME20260325192400eucas1p2ae38ff4c2b3ab35a7047cfd680d9fda3@eucas1p2.samsung.com>
 <20260325192352.437608-1-jiri@resnulli.us>
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

On 25.03.2026 20:23, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>
> Confidential computing (CoCo) VMs/guests, such as AMD SEV and Intel TDX,
> run with private/encrypted memory which creates a challenge
> for devices that do not support DMA to it (no TDISP support).
>
> For kernel-only DMA operations, swiotlb bounce buffering provides a
> transparent solution by copying data through shared memory.
> However, the only way to get this memory into userspace is via the DMA
> API's dma_alloc_pages()/dma_mmap_pages() type interfaces which limits
> the use of the memory to a single DMA device, and is incompatible with
> pin_user_pages().
>
> These limitations are particularly problematic for the RDMA subsystem
> which makes heavy use of pin_user_pages() and expects flexible memory
> usage between many different DMA devices.
>
> This patch series enables userspace to explicitly request shared
> (decrypted) memory allocations from new dma-buf system_cc_shared heap.
> Userspace can mmap this memory and pass the dma-buf fd to other
> existing importers such as RDMA or DRM devices to access the
> memory. The DMA API is improved to allow the dma heap exporter to DMA
> map the shared memory to each importing device.
>
> Based on dma-mapping-for-next e7442a68cd1ee797b585f045d348781e9c0dde0d

I would like to merge this to dma-mapping-next, but I feel a bit 
uncomfortable with my lack of knowledge about CoCo and friends. Could 
those who know a bit more about it provide some Reviewed-by tags?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

