Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4637910BA447
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 08:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A564810E3A6;
	Fri, 27 Mar 2026 08:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="G7p00Q18";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD0D10E3A6
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 08:33:56 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260327083354euoutp0201ccb8cf57d1303b0ee445c6a3f960af~gpbFtoU480102701027euoutp02S
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 08:33:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260327083354euoutp0201ccb8cf57d1303b0ee445c6a3f960af~gpbFtoU480102701027euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1774600434;
 bh=pWW1Ogs/ZdOFg15O/X78oW0BF6OEjLh6WF/GCRVR2Fw=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=G7p00Q18xvenjeqyltH6mDGbmCjnbLmz2xt4xjc/0A15A2MNdYsE6qRtkqkjdJgEE
 gWLsqVg5bPrhnWqa+Hz2FaO3aXds6+sd5qyVYDllRfVqvjnvDbjdP5yqsbpaHYcsUZ
 6jzaUAxPti8cVzpoBKsCBq/O+Zm/0wll3crPN9rM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260327083354eucas1p2e649b550ecb5424fabb9ad899e26277a~gpbFbCkiN0771907719eucas1p2w;
 Fri, 27 Mar 2026 08:33:54 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260327083352eusmtip241284ad9eaeb3b7cf68e4df2189c2fd0~gpbD2FF0k0181601816eusmtip2K;
 Fri, 27 Mar 2026 08:33:52 +0000 (GMT)
Message-ID: <2cffa109-5b88-488f-9dfb-8709164dd9f8@samsung.com>
Date: Fri, 27 Mar 2026 09:33:51 +0100
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 0/8] dma-buf: heaps: Turn heaps into modules
To: Maxime Ripard <mripard@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Robin Murphy
 <robin.murphy@arm.com>, Andrew Morton <akpm@linux-foundation.org>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Albert
 Esteve <aesteve@redhat.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260320-cryptic-industrious-otter-5b696a@houat>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260327083354eucas1p2e649b550ecb5424fabb9ad899e26277a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260303101320eucas1p2eb4fea499364ef20825d0d73585a2555
X-EPHeader: CA
X-CMS-RootMailID: 20260303101320eucas1p2eb4fea499364ef20825d0d73585a2555
References: <CGME20260303101320eucas1p2eb4fea499364ef20825d0d73585a2555@eucas1p2.samsung.com>
 <20260303-dma-buf-heaps-as-modules-v3-0-24344812c707@kernel.org>
 <c60a3f30-6fc3-41ab-835a-2fdd887e18fd@samsung.com>
 <20260320-cryptic-industrious-otter-5b696a@houat>
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

On 20.03.2026 14:09, Maxime Ripard wrote:
> On Fri, Mar 20, 2026 at 01:24:18PM +0100, Marek Szyprowski wrote:
>> On 03.03.2026 11:13, Maxime Ripard wrote:
>>> The recent introduction of heaps in the optee driver [1] made possible
>>> the creation of heaps as modules.
>>>
>>> It's generally a good idea if possible, including for the already
>>> existing system and CMA heaps.
>>>
>>> The system one is pretty trivial, the CMA one is a bit more involved,
>>> especially since we have a call from kernel/dma/contiguous.c to the CMA
>>> heap code. This was solved by turning the logic around and making the
>>> CMA heap call into the contiguous DMA code.
>>>
>>> Let me know what you think,
>>> Maxime
>>>
>>> 1: https://lore.kernel.org/dri-devel/20250911135007.1275833-4-jens.wiklander@linaro.org/
>>>
>>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>> I'm okay with the kernel/dma/contiguous.c changes. I only wonder how to
>> properly merge them. There are other pending changes to
>> kernel/dma/contiguous.c file [1] and if they finally get reviewed, I
>> would like to merge both via dma-mapping-for-next tree. Then I can
>> provide a stable branch for merging the remaining dma-buf pathes. Is it
>> okay for You?
> That sounds reasonable to me

I've applied patches 1-5 to my dma-mapping-for-next branch and resolved 
conflicts in the mentioned kernel/dma/contiguous.c file.

Here is a stable branch to apply remaining dma-buf heaps patches:

https://web.git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git/log/?h=dma-contig-for-7.1-modules-prep

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

