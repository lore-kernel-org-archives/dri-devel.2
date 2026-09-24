Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D65C98315
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18BE810F5ED;
	Thu, 24 Sep 2026 14:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iJLjQ+z3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3CC210F5ED
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:22:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC1C3601DE;
 Thu, 24 Sep 2026 14:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F791F000FF;
 Thu, 24 Sep 2026 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790259766;
 bh=j5t8Z8t0hCyzALZcT8Uztk064hS1Vk/1yGtt+yian+I=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=iJLjQ+z3yyBT7V5gaptAQEHSv7FTz/FXSmqHiO42Xo42m/OKfDyHmm/iO9/9MUoSs
 J45fM7pL+Ot6+gX1Fpq48VbXjG4uXEU5cnrLrh5SH0tZbo+e0bpeH2oMr0dwc47jdq
 GZPtGzBbdsMj7b49J6R7n83Ug9s3KMqW8ssG7BX1SWji3S5NxFM9gme2Zcc130wqCx
 d8EiTZh/xomFPqCEEoOQ8Rn5bCnqjDAcLE/538AMBOIHAx3UnOVpnBVjhdHZVeQIIN
 +pVqoAgWP4vIhy4oIPBBsj7Kuwax8eDlSOP9d2FsbWpNMcZGyepNsrl72ahyUqgj8W
 e7rQ7140vEEiQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
 Oliver Upton <oupton@kernel.org>
Subject: Re: [RFC PATCH v8 01/14] mm: Add an allocator for CoCo shared memory
In-Reply-To: <20260924101907.5C6261F000FF@smtp.kernel.org>
References: <20260924100529.1398790-1-aneesh.kumar@kernel.org>
 <20260924100529.1398790-2-aneesh.kumar@kernel.org>
 <20260924101907.5C6261F000FF@smtp.kernel.org>
Date: Thu, 24 Sep 2026 19:52:39 +0530
Message-ID: <yq5a1pai4tlc.fsf@kernel.org>
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

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] mm: alloc_cc_shared_pages_node fails to strip __GFP_MOVABLE
> - [Medium] mm: alloc_cc_shared_pages_node fails to strip __GFP_HIGHMEM in fallback path
> - [Medium] mm: cc_make_shared and cc_make_private are not exported for modular callers
> --
>
> commit 3978c8ce72bbc2aa23e57a460b585808665262a4
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> mm: Add an allocator for CoCo shared memory
>
> This commit introduces a common allocator for confidential-computing guests
> to allocate shared memory. It provides helpers to allocate properly aligned
> contiguous pages and transition them to shared state. It also adds helpers
> for transitioning memory states when callers manage their own backing memory.
>
>> diff --git a/mm/cc_shared.c b/mm/cc_shared.c
>> new file mode 100644
>> index 0000000000000..85e16f4504b8f
>> --- /dev/null
>> +++ b/mm/cc_shared.c
> [ ... ]
>> +int cc_make_shared(void *addr, size_t size)
>> +{
>> +	int ret = cc_validate_transition(addr, size);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	return set_memory_decrypted((unsigned long)addr, size >> PAGE_SHIFT);
>> +}
>
> [Severity: Medium]
> Will this function be unavailable to dynamically loadable modules since it
> is missing an EXPORT_SYMBOL_GPL() macro?
>
> The commit message states it should be usable by callers managing their own
> backing memory, but virtio or guest drivers won't be able to link to it
> without an export.
>
>> +
>> +int cc_make_private(void *addr, size_t size)
>> +{
>> +	int ret = cc_validate_transition(addr, size);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	return set_memory_encrypted((unsigned long)addr, size >> PAGE_SHIFT);
>> +}
>
> [Severity: Medium]
> Does this function also need an EXPORT_SYMBOL_GPL() macro so that modules
> can successfully link and call it?
>


I guess we don't want the cc_make_shared() and cc_make_private() APIs to be
called by modules. Modules that need CoCo shared memory should use
alloc_cc_shared_pages().


>
> [ ... ]
>> +static int __alloc_cc_shared_pages_node(int nid, gfp_t gfp,
>> +					size_t requested,
>> +					struct cc_shared_pages *mem)
>> +{
> [ ... ]
>> +	/*
>> +	 * State transitions require a linear-map address and may modify memory.
>> +	 * Allocate from low memory and defer requested zeroing until afterwards.
>> +	 */
>> +	gfp &= ~(__GFP_HIGHMEM | __GFP_ZERO);
>
> [Severity: High]
> Does this code inadvertently leave __GFP_MOVABLE intact if passed by the
> caller?
>
> Pages are returned as shared memory, but they lack migration hooks
> (movable_operations) to handle encryption state transitions during page
> migration.
>
> If a caller passes __GFP_MOVABLE, the page might be placed in ZONE_MOVABLE.
> Since the kernel migration code does not know how to handle encryption state
> transitions, the page cannot be safely migrated. Could this permanently pin
> the movable zone, thereby breaking memory hot-unplug and compaction?
>

I don't think we want CoCo shared memory allocations to be movable, but
I'm also not sure whether we should filter out all of these GFP flags.

>
>> +	if (nid == NUMA_NO_NODE)
>> +		page = alloc_pages(gfp, order);
> [ ... ]
>> +int alloc_cc_shared_pages_node(int nid, gfp_t gfp,
>> +			       size_t requested,
>> +			       struct cc_shared_pages *mem)
>> +{
> [ ... ]
>> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>> +		return __alloc_cc_shared_pages_node(nid, gfp, requested, mem);
>> +
>> +	order = get_order(requested);
>> +	if (order > MAX_PAGE_ORDER)
>> +		return -EINVAL;
>> +
>> +	if (nid == NUMA_NO_NODE)
>> +		page = alloc_pages(gfp, order);
>> +	else
>> +		page = alloc_pages_node(nid, gfp, order);
>
> [Severity: Medium]
> Can this fallback path inadvertently allocate a highmem page?
>
> The function's kernel-doc explicitly guarantees: "A memory-state transition
> requires a valid linear-map address, so such allocations never come from
> high memory".
>

Only when a private-to-shared transition is required.

>
> In the non-encrypted fallback path, the caller's unmodified gfp flags
> (potentially containing __GFP_HIGHMEM) are passed directly to alloc_pages()
> or alloc_pages_node() without any masking.
>
> If a caller passes a flag mask containing __GFP_HIGHMEM (e.g., GFP_HIGHUSER)
> on a system without memory encryption, the fallback path will allocate a
> highmem page. Any subsequent attempt by the caller to access the memory via
> page_address() could return NULL and cause a crash, breaking the API
> contract. Should the gfp flags be sanitized in this path as well?
>

From the allocation API's perspective, both GFP flags are supported. The
only restriction is that memory cannot come from highmem when the
allocation requires a private-to-shared transition.

-aneesh
