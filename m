Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8EBC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189C210E89A;
	Wed, 23 Sep 2026 10:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gfeKGD7Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1997A10E89A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:28:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 72B3E4048E;
 Wed, 23 Sep 2026 10:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7196B1F000FF;
 Wed, 23 Sep 2026 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790159314;
 bh=Tw+YzFR1Q3RDJ/ocFl7RH+C/kpA7xkpXpKPh0rT8+YE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=gfeKGD7Zx1t68oVKPD3pJdIls6095LdyIYbLzcbi2lWu0uZc4Ag6czwUu/3rMOVvu
 5DkKG7QVnUdoUJyu1nzlZlhO5qsE27dTDKv4KVUeUxS/0fGMmnV48ACdIVTacKhMLM
 Kp2Etb2iursi6SlXAk2q9a0Y6ZYslY12NqaBGyj2gFaxqHvu92+46mMlc5J8MMsSdD
 HGiK3yV1AdehOFvWHLjpPcT/57yOMwlxfev62t4C+oD/yqe8IWaG9c7HzZhanNfFx0
 V7SG8BRuoVDTolq0VsrAo7+8om8W5vw2V1IN/4OrxXJcM2FyWTn+Eqh0SDfkr9xU/H
 iMGeRqREn7XNA==
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
In-Reply-To: <arOfD6syXOgQhZYA@arm.com>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com> <yq5aik3w344o.fsf@kernel.org>
 <arOfD6syXOgQhZYA@arm.com>
Date: Wed, 23 Sep 2026 15:58:25 +0530
Message-ID: <yq5a5wzw2ree.fsf@kernel.org>
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

> On Wed, Sep 23, 2026 at 11:23:27AM +0530, Aneesh Kumar K.V wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>> > On Mon, Sep 21, 2026 at 08:18:36PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> >> +int alloc_cc_shared_pages_node(int nid, gfp_t gfp,
>> >> +		size_t requested, struct cc_shared_pages *mem)
>> >> +{
>> >> +	struct cc_shared_layout layout;
>> >> +	struct page *page;
>> >> +	unsigned int order;
>> >> +	bool zero = gfp & __GFP_ZERO;
>> >> +	int ret;
>> >> +
>> >> +	if (!mem)
>> >> +		return -EINVAL;
>> >> +
>> >> +	ret = cc_shared_calc_layout(requested, &layout);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	order = get_order(layout.shared_size);
>> >> +	if (order > MAX_PAGE_ORDER)
>> >> +		return -EINVAL;
>> >> +
>> >> +	/*
>> >> +	 * State transitions require a linear-map address and may modify memory.
>> >> +	 * Allocate from low memory and defer requested zeroing until afterwards.
>> >> +	 */
>> >> +	gfp &= ~(__GFP_HIGHMEM | __GFP_ZERO);
>> >> +	if (nid == NUMA_NO_NODE)
>> >> +		page = alloc_pages(gfp, order);
>> >> +	else
>> >> +		page = alloc_pages_node(nid, gfp, order);
>> >> +	if (!page)
>> >> +		return -ENOMEM;
>> >> +
>> >> +	ret = cc_make_shared(page_address(page), layout.shared_size);
>> >> +	if (ret) {
>> >> +		if (!cc_make_private(page_address(page), layout.shared_size))
>> >> +			__free_pages(page, order);
>> >> +		else
>> >> +			pr_warn_ratelimited("leaking %zu bytes with uncertain shared state\n",
>> >> +					    layout.shared_size);
>> >> +		return ret;
>> >> +	}
>> >> +
>> >> +	if (zero)
>> >> +		memset(page_address(page), 0, layout.shared_size);
>> >
>> > Does the memset() post sharing logic work for pKVM as well? If nothing
>> > clears it, we have a small window where guest data is leaked to the
>> > host.
>> >
>> > Is there a case where we *do not* need the memory cleared? If not, maybe
>> > we can move the logic in the arch set_memory_decrypted().
>> >
>> 
>> I don't think every architecture or platform can unconditionally zero
>> memory in set_memory_decrypted(). Some callers may need to share valid
>> contents with the host.
>
> Is there any? That would be a bad assumptions in the caller. Most
> set_memory_* backends don't preserve the content as they change the
> encryption key. So properly written code shouldn't rely on this unless
> it knows specifically it's only running on pKVM for example. The only
> use-case I see to avoid explicit zeroing is when the caller doesn't care
> about the page initialisation and wants to save some cycles. The
> encryption key change would take care of the security aspect.
>

I checked this, and you are right. We cannot expect the contents to
remain valid across sharing; set_memory_decrypted() is destructive in
that sense. Since pKVM does not rely on memory encryption, it needs to
zero the memory unconditionally in set_memory_decrypted() to avoid
exposing existing guest data. Other CoCo implementations may omit the
memset(0). We still need to zero the memory when the caller requests
__GFP_ZERO, where the memory location is expected to be zero.

We could either zero the memory unconditionally or pass a flag to allow
this micro-optimization. We would also need to audit all call paths to
avoid redundant zeroing after set_memory_decrypted(). Let me know if you
have a preference for either approach.

-aneesh
