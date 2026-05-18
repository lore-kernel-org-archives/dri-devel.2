Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7BDCD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D11710E8DD;
	Mon, 18 May 2026 15:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dFmRQNgv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 613CF10E8DD
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 15:06:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 151AF43CBC;
 Mon, 18 May 2026 15:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F976C2BCB7;
 Mon, 18 May 2026 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779116809;
 bh=pBqnVpw3j1aq4FC8bJx5X8I7niRcnpb+yzemwEGWIm8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dFmRQNgvaK/sEKCsSU5dU9VXcXDYrkV1E8PUzaTOCyb/A2q2XxNpxqsKRgh83MGSq
 iL9bUarFULyucGdH1rsCHCbludiwbA5afG7jhMKwYHrAmx9kFd/BpZCXrY4FTLKKcF
 +qppNazAKQp2zjd09uPeUCgiy9a/py736dNl8tW8icQJ+jC6937z6lxrUojQRY0gm4
 mPQ9m8AYvcJIMwaUEvEXAH0lqkW9239pMDoGwIyYdIlksBODCVfQKYxmxobwWoiOck
 EpJdbJ5ZhzNiVBk+lAH0KuQh0K2gsD2v9c90UrQilKexeNSLVmBsitaHU/d5+pyhSX
 LF1cV7m7fFzcg==
Date: Mon, 18 May 2026 16:06:44 +0100
From: Will Deacon <will@kernel.org>
To: Dan Carpenter <error27@gmail.com>, jstultz@google.com, tjmercier@google.com
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [bug report] dma-buf: heaps: Rework heap allocation hooks to
 return struct dma_buf instead of fd
Message-ID: <agsrBPXYXA2vZgj1@willie-the-truck>
References: <afXGeq1AvqFY76MY@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afXGeq1AvqFY76MY@stanley.mountain>
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

On Sat, May 02, 2026 at 12:40:10PM +0300, Dan Carpenter wrote:
> I'm not sure exactly who to report this bug too.  Probably the mm
> devs?

[Adding John and TJ, in case they are interested / able to help]

Will

(original report follows)

> 	drivers/dma-buf/heaps/system_heap.c:499 system_heap_allocate()
> 	warn: passing positive error code 's32min-(-1),1' to 'ERR_PTR'
> 
> drivers/dma-buf/heaps/system_heap.c
>     459         if (cc_shared) {
>     460                 for_each_sgtable_sg(table, sg, i) {
>     461                         ret = system_heap_set_page_decrypted(sg_page(sg));
>     462                         if (ret)
>     463                                 goto free_pages;
> 
> It kind of looks like system_heap_set_page_decrypted() can return 1.
> 
>     464                 }
>     465         }
>     466 
>     467         /* create the dmabuf */
>     468         exp_info.exp_name = dma_heap_get_name(heap);
>     469         exp_info.ops = &system_heap_buf_ops;
>     470         exp_info.size = buffer->len;
>     471         exp_info.flags = fd_flags;
>     472         exp_info.priv = buffer;
>     473         dmabuf = dma_buf_export(&exp_info);
>     474         if (IS_ERR(dmabuf)) {
>     475                 ret = PTR_ERR(dmabuf);
>     476                 goto free_pages;
>     477         }
>     478         return dmabuf;
>     479 
>     480 free_pages:
>     481         for_each_sgtable_sg(table, sg, i) {
>     482                 struct page *p = sg_page(sg);
>     483 
>     484                 /*
>     485                  * Intentionally leak pages that cannot be re-encrypted
>     486                  * to prevent shared memory from being reused.
>     487                  */
>     488                 if (buffer->cc_shared &&
>     489                     system_heap_set_page_encrypted(p))
>     490                         continue;
>     491                 __free_pages(p, compound_order(p));
>     492         }
>     493         sg_free_table(table);
>     494 free_buffer:
>     495         list_for_each_entry_safe(page, tmp_page, &pages, lru)
>     496                 __free_pages(page, compound_order(page));
>     497         kfree(buffer);
>     498 
> --> 499         return ERR_PTR(ret);
>     500 }
> 
> The problem is that add_to_pagemap() returns PM_END_OF_BUFFER (1)
> which is used by pagemap_read() and nowhere else.  The call tree
> is:
> 
> system_heap_allocate()
> system_heap_set_page_decrypted()
> set_memory_decrypted()
> realm_set_memory_decrypted()
> __set_memory_enc_dec()
> __change_memory_common()
> update_range_prot()
> walk_kernel_page_table_range_lockless()
> walk_pgd_range()
> pagemap_pte_hole()
> add_to_pagemap()
> 
> This code seems sort of old and I guess no one has reported the bug
> so maybe it's a false positive, but it feels like it's asking for
> problems to return the PM_END_OF_BUFFER.  There aren't any comments
> on any of those functions above explaining what return values are
> expected.
> 
> This email is a free service from the Smatch-CI project [smatch.sf.net].
> 
> regards,
> dan carpenter
