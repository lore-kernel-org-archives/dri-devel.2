Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0142606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KvhrT8NK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3340610EC95;
	Mon, 23 Nov 2026 11:05:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9F3E810ECD1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 11:05:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 218E3143D;
 Mon, 23 Nov 2026 03:05:32 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A83273F882;
 Mon, 23 Nov 2026 03:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795431935; bh=kCUeWgNlDSox1V+xXIV0FoQklIwe01iQtQShkTSpFns=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KvhrT8NKkwfUQlN/JVYJ5xdBVy5POFXKjhsTfodMnif/DZoxUXBTRSE+v99DKNllE
 5d1fBxUVR51g74P9by/+O7T3jZUmuCzToT2ynvCd+snaLJQPIjfE7jA9gHVgHouzT3
 DFYSeENRGheUkSn0CCeE9f0MsFw+W0BZ+uXNA9WQ=
Date: Mon, 23 Nov 2026 11:05:23 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Marc Zyngier <maz@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Mark Rutland <mark.rutland@arm.com>, Radu Rendec <radu@rendec.net>,
 "T.J. Mercier" <tjmercier@google.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, kvmarm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH v10 04/13] irqchip/gic-v3-its: Allocate shared tables
 using CoCo shared memory allocator
Message-ID: <awQd81MwZqi55gf8@arm.com>
References: <20261116091137.94252-1-aneesh.kumar@kernel.org>
 <20261116091137.94252-5-aneesh.kumar@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116091137.94252-5-aneesh.kumar@kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aneesh,

I'm replying on this patch rather than on the one introducing the API. I
think it's more obvious here why I think we can make things simpler.

On Mon, Nov 16, 2026 at 02:41:27PM +0530, Aneesh Kumar K.V (Arm) wrote:
>  static struct page *its_alloc_pages_node(int node, gfp_t gfp,
>  					 unsigned int order)
>  {
> -	struct page *page;
> -	int ret = 0;
> +	struct cc_shared_pages mem;
>  
>  	if (node == NUMA_NO_NODE)
>  		node = numa_mem_id();
>  
> -	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
> -
> -	if (!page)
> -		return NULL;
> -
> -	ret = set_memory_decrypted((unsigned long)page_address(page),
> -				   1 << order);
> -	/*
> -	 * If set_memory_decrypted() fails then we don't know what state the
> -	 * page is in, so we can't free it. Instead we leak it.
> -	 * set_memory_decrypted() will already have WARNed.
> -	 */
> -	if (ret)
> +	if (alloc_cc_shared_pages_node(node, gfp | gfp_flags_quirk,
> +				       PAGE_SIZE << order, &mem))
>  		return NULL;
>  
> -	return page;
> +	return mem.page;

This part is mostly fine but I do wonder why not make this alloc
function the same as buddy alloc_pages_node() - return a struct page
pointer.

>  static void its_free_pages(void *addr, unsigned int order)
>  {
> -	/*
> -	 * If the memory cannot be encrypted again then we must leak the pages.
> -	 * set_memory_encrypted() will already have WARNed.
> -	 */
> -	if (set_memory_encrypted((unsigned long)addr, 1 << order))
> +	struct cc_shared_layout layout;
> +	struct cc_shared_pages mem;
> +
> +	if (WARN_ON(cc_shared_calc_layout(PAGE_SIZE << order, &layout)))
>  		return;
> -	free_pages((unsigned long)addr, order);
> +
> +	mem.page = virt_to_page(addr);
> +	mem.shared_size = layout.shared_size;
> +	free_cc_shared_pages(&mem);
>  }

Here it gets weird and I don't see why we can't have just a buddy-like
interface. The kernel-doc for alloc says that shared_size must be
retained for the corresponding free but without reading the source code,
you can't tell that cc_shared_calc_layout() gives you the same
shared_size populated by alloc. We have a similar pattern in dma-buf but
using the compound page order.

What's wrong with a simpler API:

struct page *alloc_cc_shared_pages_node(int nid, gfp_t gfp, unsigned int order);
struct page *alloc_cc_shared_pages(gfp_t gfp, unsigned int order);
void free_cc_shared_pages(struct page *page, unsigned int order);

Both alloc and free take the original request order and perform the
round up internally without exposing the details to the caller. Alloc
shares the whole resulting buddy block and free makes the same block
private before releasing it. We can document that free takes the
original requested order and releases the whole allocation. Partial
frees aren't supported.

We can get rid of layout and mem structures (or at least not as
part of the API). Of course, this assumes that the shared granule size
remains constant for a guest's lifetime but I don't think that's a
problem.

> @@ -278,7 +267,8 @@ static void *itt_alloc_pool(int node, int size)
>  		if (!page)
>  			break;
>  
> -		gen_pool_add(itt_pool, (unsigned long)page_address(page), PAGE_SIZE, node);
> +		gen_pool_add(itt_pool, (unsigned long)page_address(page),
> +			     cc_shared_granule_size(), node);

Here we can introduce:

unsigned int cc_shared_page_order(unsigned int order);

and just use (PAGE_SIZE << cc_shared_page_order(0)) for gen_pool_add().

Was there a caller you had in mind that needs the common allocator to
share less than the whole buddy block?

-- 
Catalin
