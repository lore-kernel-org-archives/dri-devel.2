Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C826AC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A0410EF1C;
	Wed, 23 Sep 2026 05:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dfiMSTdw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B421810E403
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 05:53:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D71D46020A;
 Wed, 23 Sep 2026 05:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B328E1F000FF;
 Wed, 23 Sep 2026 05:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790142817;
 bh=NLg7eC5tmmPMhZrdk3Y2A4+KtVVGLpx4Z4IOl6QmxuU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=dfiMSTdwFtu0GCkhWemNFDgm+eZPZTNwX9NfJANQl2p7VUL12gPuLOT5GFrp9s1/W
 gYHsfaLK7hikvujYiuXBUn8tMKa90RN/oaYf2S0NAbKARN3nHId0g1n9dBJrUeJeqm
 1Q44Iafx85llSabeXDEcOdxXWocXCUP5y+CfG+SLeH3LQKK2DCfDxkDMtcFBDaOqJv
 3HMHpRbUUmlsMii5otr4W/LYqrG4eJChKhKMXRP42VluhoUFMzhKQPjXcnsbxGFGAB
 eSZq2hnozQ8Ha+TQTKHYQZsH+7U8XaqMquyRiYdYscnEhoNd02LZ7qoYGMlm0AwCPg
 wXpHkFmSzOfPQ==
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
Subject: Re: [RFC PATCH v7 02/13] mm: Add an allocator for CoCo shared memory
In-Reply-To: <arKsFofudnTYpXj1@arm.com>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com>
Date: Wed, 23 Sep 2026 11:23:27 +0530
Message-ID: <yq5aik3w344o.fsf@kernel.org>
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

> On Mon, Sep 21, 2026 at 08:18:36PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> +int alloc_cc_shared_pages_node(int nid, gfp_t gfp,
>> +		size_t requested, struct cc_shared_pages *mem)
>> +{
>> +	struct cc_shared_layout layout;
>> +	struct page *page;
>> +	unsigned int order;
>> +	bool zero = gfp & __GFP_ZERO;
>> +	int ret;
>> +
>> +	if (!mem)
>> +		return -EINVAL;
>> +
>> +	ret = cc_shared_calc_layout(requested, &layout);
>> +	if (ret)
>> +		return ret;
>> +
>> +	order = get_order(layout.shared_size);
>> +	if (order > MAX_PAGE_ORDER)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * State transitions require a linear-map address and may modify memory.
>> +	 * Allocate from low memory and defer requested zeroing until afterwards.
>> +	 */
>> +	gfp &= ~(__GFP_HIGHMEM | __GFP_ZERO);
>> +	if (nid == NUMA_NO_NODE)
>> +		page = alloc_pages(gfp, order);
>> +	else
>> +		page = alloc_pages_node(nid, gfp, order);
>> +	if (!page)
>> +		return -ENOMEM;
>> +
>> +	ret = cc_make_shared(page_address(page), layout.shared_size);
>> +	if (ret) {
>> +		if (!cc_make_private(page_address(page), layout.shared_size))
>> +			__free_pages(page, order);
>> +		else
>> +			pr_warn_ratelimited("leaking %zu bytes with uncertain shared state\n",
>> +					    layout.shared_size);
>> +		return ret;
>> +	}
>> +
>> +	if (zero)
>> +		memset(page_address(page), 0, layout.shared_size);
>
> Does the memset() post sharing logic work for pKVM as well? If nothing
> clears it, we have a small window where guest data is leaked to the
> host.
>
> Is there a case where we *do not* need the memory cleared? If not, maybe
> we can move the logic in the arch set_memory_decrypted().
>

I don't think every architecture or platform can unconditionally zero
memory in set_memory_decrypted(). Some callers may need to share valid
contents with the host.

Also, if zeroing is added only to the CCA implementation, the allocator
must retain __GFP_ZERO for platforms such as pKVM. This would cause the
memory to be zeroed twice on CCA.

How about extending cc_make_shared() with a flag indicating that the
memory must be zeroed, and passing that requirement down to the
architecture-specific implementation? The implementation could then zero
the memory at the appropriate point: before sharing for pKVM and after
the destructive transition for CCA.

The allocator could derive this flag from __GFP_ZERO, remove __GFP_ZERO
before calling alloc_pages(), and let the sharing operation perform the
requested zeroing with the correct ordering.

-aneesh
