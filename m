Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F5AC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9CF410E0D1;
	Wed, 23 Sep 2026 11:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j3QZjKt2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73AF510E0D1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 11:50:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05F5940A5F;
 Wed, 23 Sep 2026 11:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D332E1F000FF;
 Wed, 23 Sep 2026 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790164201;
 bh=jI0vAlJKhDmiOEB6Q23h3G6CLXMXdX46480mhO3rjOk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=j3QZjKt2RDG++7vwN6aJe3RA7jXlLMR25KRKluo6b+e2fpyRs/pTz6vg3MeMVgz3Y
 H/uFrc3+3pyN38Avf0YeUAxm/S/O+UYkxoG1yg2hevAJ7xtnMPU4ruJWSG/bl4vDRu
 a2+E5u83/YxSpGaDgPepX4M+KVq5eQWV3LxaqaNvqgJ0xF/Xh37LMhSBpaanlugiGi
 a6+IqmVFl9eTuZSg2ZqPukR9Tb5u+HfSSew9/Q5ZdNFqsJuWTV56233K9JINsg6JB4
 SaDj00V23Bhf5UDAvsQeyU1kxlfysMR0sLQ47c99jCokiOgVXxgydYh+6zjRxefc3x
 m/QmnRG8vSOaA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 christian.koenig@amd.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>,
 Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC PATCH v7 06/13] dma-contiguous: Accept an explicit minimum
 alignment
In-Reply-To: <arOrgRfi1k12clT7@arm.com>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-7-aneesh.kumar@kernel.org>
 <arOrgRfi1k12clT7@arm.com>
Date: Wed, 23 Sep 2026 17:19:52 +0530
Message-ID: <yq5a33v02nmn.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Sep 21, 2026 at 08:18:40PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> @@ -125,7 +126,8 @@ static inline int dma_contiguous_reserve_area(phys_addr_t size,
>>  	return -ENOSYS;
>>  }
>>  static inline struct page *dma_alloc_from_contiguous(struct device *dev,
>> -		size_t count, unsigned int order, bool no_warn)
>> +		size_t count, unsigned int order, unsigned int required_order,
>> +		bool no_warn)
>>  {
>>  	return NULL;
>>  }
>> @@ -136,7 +138,7 @@ static inline bool dma_release_from_contiguous(struct device *dev,
>>  }
>>  /* Use fallback alloc() and free() when CONFIG_DMA_CMA=n */
>>  static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
>> -		gfp_t gfp)
>> +		gfp_t gfp, unsigned int align_order)
>
> Can we not just bake the alignment further down in these functions
> rather than getting the callers to pass the {required,align}_order?
>

But, we need this to be conditional on CoCo shared allocations. We could
derive that from attrs and pass attrs instead of align_order, i.e.
something like:


 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
-		unsigned int align, unsigned int required_align, bool no_warn)
+		unsigned int align, unsigned long attrs, bool no_warn)
 {
-	if (required_align > CONFIG_CMA_ALIGNMENT)
+	if (!dma_contiguous_resolve_alignment(attrs, &align))
 		return NULL;
-	align = min(max(align, required_align), CONFIG_CMA_ALIGNMENT);
 
 	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
 }


with

+static bool dma_contiguous_resolve_alignment(unsigned long attrs,
+					     unsigned int *align)
+{
+	unsigned int required_align = 0;
+
+	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED)
+		required_align = get_order(cc_shared_granule_size());
+	if (required_align > CONFIG_CMA_ALIGNMENT)
+		return false;
+
+	*align = min(max(*align, required_align), CONFIG_CMA_ALIGNMENT);
+	return true;
+}
+

-aneesh
