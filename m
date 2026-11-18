Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC0606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=aKdqcyhG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A80710E76E;
	Wed, 18 Nov 2026 08:05:45 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1074510E7B1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:05:38 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261118080536euoutp0211b4b49d4cfda8bd6bd7cb0a84101115~pFRv7hBiF2515525155euoutp02O
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:05:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261118080536euoutp0211b4b49d4cfda8bd6bd7cb0a84101115~pFRv7hBiF2515525155euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1794989136;
 bh=D6wcvXz+3VFjmwaXZqu53OPZKJ3AhVArDX6YTdc8W4E=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=aKdqcyhGFaiQHwYEXFHR+D2kPlLirVWKgp/AFFxw/eNnJGJIRz9+vXUSujwa70g+j
 rfkLIK5cYprST4iPTbgbMH9XNL0iJjg3nkVgKI127PhdnWu0IB4Ym/TNWjtdIckRAQ
 N8vLCZsOhxh+DetlQuUdkga13JrKpJzqgsd1mZws=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261118080536eucas1p250aaaa4c5a74f1d8ea77b05ae499c208~pFRvmAThv0498604986eucas1p2B;
 Wed, 18 Nov 2026 08:05:35 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261118080534eusmtip1f0c261bfe6ce1a4f8ad61f83e303149e~pFRukqbHp2329623296eusmtip1s;
 Wed, 18 Nov 2026 08:05:34 +0000 (GMT)
Message-ID: <ac09180d-27ea-40dc-a728-68e07333e153@samsung.com>
Date: Wed, 18 Nov 2026 09:05:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-buf: heaps: system: zero pages after
 set_memory_decrypted()
To: Ying Xiao <eagleshaw@google.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, "T . J . Mercier" <tjmercier@google.com>, Jiri
 Pirko <jiri@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, Jacob
 Moroni <jmoroni@google.com>, Xuehao Hu <xuehaohu@google.com>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261117155431.1654298-1-eagleshaw@google.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261118080536eucas1p250aaaa4c5a74f1d8ea77b05ae499c208
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261117155436eucas1p2fa7d030f5557d1c88d943226d65f69ca
X-EPHeader: CA
X-CMS-RootMailID: 20261117155436eucas1p2fa7d030f5557d1c88d943226d65f69ca
References: <CGME20261117155436eucas1p2fa7d030f5557d1c88d943226d65f69ca@eucas1p2.samsung.com>
 <20261117155431.1654298-1-eagleshaw@google.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17.11.2026 16:54, Ying Xiao wrote:
> system_heap_allocate() allocates pages via order_flags[] with __GFP_ZERO
> while the direct map still has the memory encryption bit set. For the
> system_cc_shared heap, set_memory_decrypted() subsequently clears the
> encryption bit without re-zeroing, leaving ciphertext in DRAM on
> confidential computing (CoCo) guests instead of plaintext zeros.
>
> Skip __GFP_ZERO during alloc_pages() for cc_shared allocations, and zero
> the pages once in system_heap_set_page_decrypted() after
> set_memory_decrypted() succeeds.
>
> Fixes: 78b30c50a7ac ("dma-buf: heaps: system: add system_cc_shared heap for explicitly shared memory")
> Reviewed-by: Jacob Moroni <jmoroni@google.com>
> Signed-off-by: Ying Xiao <eagleshaw@google.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
>  drivers/dma-buf/heaps/system_heap.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index c8959eadc71d..5f98d0df11e7 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -72,11 +72,19 @@ static int system_heap_set_page_decrypted(struct page *page)
>  	int ret;
>  
>  	ret = set_memory_decrypted(addr, nr_pages);
> -	if (ret)
> +	if (ret) {
>  		pr_warn_ratelimited("dma-buf system heap: failed to decrypt page at %p\n",
>  				    page_address(page));
> +		return ret;
> +	}
>  
> -	return ret;
> +	/*
> +	 * Clearing the encryption bit does not clear DRAM, leaving ciphertext
> +	 * from when the page was encrypted. Zero it now that it is decrypted.
> +	 */
> +	memset((void *)addr, 0, (size_t)nr_pages << PAGE_SHIFT);
> +
> +	return 0;
>  }
>  
>  static int system_heap_set_page_encrypted(struct page *page)
> @@ -376,7 +384,8 @@ static const struct dma_buf_ops system_heap_buf_ops = {
>  };
>  
>  static struct page *alloc_largest_available(unsigned long size,
> -					    unsigned int max_order)
> +					    unsigned int max_order,
> +					    bool cc_shared)
>  {
>  	struct page *page;
>  	int i;
> @@ -388,6 +397,12 @@ static struct page *alloc_largest_available(unsigned long size,
>  		if (max_order < orders[i])
>  			continue;
>  		flags = order_flags[i];
> +		/*
> +		 * Zeroing while encrypted is wasted since decryption leaves
> +		 * ciphertext; system_heap_set_page_decrypted() zeroes instead.
> +		 */
> +		if (cc_shared)
> +			flags &= ~__GFP_ZERO;
>  		if (mem_accounting)
>  			flags |= __GFP_ACCOUNT;
>  		page = alloc_pages(flags, orders[i]);
> @@ -438,7 +453,8 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>  			goto free_buffer;
>  		}
>  
> -		page = alloc_largest_available(size_remaining, max_order);
> +		page = alloc_largest_available(size_remaining, max_order,
> +					       cc_shared_buffer(buffer));
>  		if (!page)
>  			goto free_buffer;
>  

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

