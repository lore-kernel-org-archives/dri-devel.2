Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14A4CA9ED0
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 05:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED37E10E741;
	Tue, 13 Oct 2026 05:02:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D0410E719
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:02:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03DDD600D1;
 Tue, 13 Oct 2026 05:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8976E1F000FF;
 Tue, 13 Oct 2026 05:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791867761;
 bh=A3OJ9sn0kRm9V1II1Qn3IuSHpJQjgK1Jxzrt2caViI8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ArjR7x1ZUzKUrP/ExXDEY0/1y2fpxzw9KIxKYa38Wn1nIjTZJSTNV4q+ZKtksvm7d
 3ZKXphcw51EsfnVXkTTeMaQCI9WgbNEz5rhFAODN5Yvz6NODbQsCljU0FVxFchIep/
 yhhkX+5p+QY97tbX3448342riMyPFArDOCL/nzlVQPlWg9byM7RG6prLi/NUGBo0zI
 dA/MXzQzVHCdTHTvMER58WgCgYT6KUiQ6Yw8PZBE15aNpz9YpgkuZVvIK0XwhiaaoB
 YSEEdXEedIPVhwVUOfKABwfhmMLLiekBcVSkW8gKUp2Nd4kT2jZ5IooiMBq4qEpK1s
 9miQAwltyELUw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org,
 media-ci@linuxtv.org, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>
Subject: Re: [RFC PATCH v8 01/14] mm: Add an allocator for CoCo shared memory
In-Reply-To: <20260924182643.GC9354@nvidia.com>
References: <20260924100529.1398790-1-aneesh.kumar@kernel.org>
 <20260924100529.1398790-2-aneesh.kumar@kernel.org>
 <20260924101907.5C6261F000FF@smtp.kernel.org>
 <yq5a1pai4tlc.fsf@kernel.org> <20260924182643.GC9354@nvidia.com>
Date: Tue, 13 Oct 2026 10:32:36 +0530
Message-ID: <yq5a33uary4z.fsf@kernel.org>
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

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Thu, Sep 24, 2026 at 07:52:39PM +0530, Aneesh Kumar K.V wrote:

 [ ... 67 lines skipped ... ] 

>
>> >> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>> >> +		return __alloc_cc_shared_pages_node(nid, gfp, requested, mem);
>> >> +
>> >> +	order = get_order(requested);
>> >> +	if (order > MAX_PAGE_ORDER)
>> >> +		return -EINVAL;
>> >> +
>> >> +	if (nid == NUMA_NO_NODE)
>> >> +		page = alloc_pages(gfp, order);
>> >> +	else
>> >> +		page = alloc_pages_node(nid, gfp, order);
>> >
>> > [Severity: Medium]
>> > Can this fallback path inadvertently allocate a highmem page?
>> >
>> > The function's kernel-doc explicitly guarantees: "A memory-state transition
>> > requires a valid linear-map address, so such allocations never come from
>> > high memory".
>> 
>> Only when a private-to-shared transition is required.
>
> IMHO disable the whole thing at kconfig if highmem is enabled. Make
> the calls always fail.
>

But we also want other kernel subsystems to use alloc_cc_shared_pages()
when CoCo is not enabled. In other words, usage like the following
should work even when the kernel is not running as a CoCo guest.

static struct page *its_alloc_pages_node(int node, gfp_t gfp,
					 unsigned int order)
{
	struct cc_shared_pages mem;

	if (alloc_cc_shared_pages_node(node, gfp | gfp_flags_quirk,
				       PAGE_SIZE << order, &mem))
		return NULL;

	return mem.page;
}

-aneesh
