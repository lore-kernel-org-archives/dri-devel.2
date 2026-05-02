Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7ADCD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 09:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02A710E074;
	Sat,  2 May 2026 09:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e0sUBeSl";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E48CB10E074
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 09:40:16 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so21828805e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 02 May 2026 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777714815; x=1778319615; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xWxxzhKBAmtcwBT63aGnVt/i27b3I+bhzf4HGA2Jwck=;
 b=e0sUBeSl4WUvHBLXNhKFAndxYcdMJR7d0C12I1j+7XZevA052yRrrhSNj4sQHSrM2K
 Eds+tyo8vQSXCWnjam9XUEJ//v6BAh1+DaNEwB75Q5PKp2MLRlcLveD3AuEvrqFxtPvT
 McVNAZlfeQCuI7xoGYemClvnOdhJszcRYvPH8SgJRwIx/ZrK+liwMMIJ9xyGv4et12wn
 uYcxUGSxmnPWeoOpvriFmR3lveaDNyFKhGRmckzmy2j7wvsfVbXfqm0cti7BiQxSz3rm
 AQW4JZKDTlDHn/sdinDkSLC1TLRA8P/45W45FKkO5OkhsGrB82ckV8vGP7FEoMDWv0jh
 YMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777714815; x=1778319615;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xWxxzhKBAmtcwBT63aGnVt/i27b3I+bhzf4HGA2Jwck=;
 b=jr3Z3HjwrGBWz+XapTa3XSVzIt2p7Gt0qU6C6CAH3g8cyDh0+4K2TprMp8VHpyI1+h
 QdJxjP0PxPV3rvNTDBRm2lNxDt+RHo/ban3hyBLTsKBHGSoOmyHGKh2/yc8WPd4qwfMw
 zBz5We+hcmsyk+9/AMlakyaMdOwRmLDPDe7ZWgaUXYR3BMx3RBVHhtJsZ9LY/oknwxss
 p3NUtTZUVzVbQFCKCifhU+QlThk1fqcTCcn7xHcgVzHFGy7Gruqmhr6tRLZKqHCHxmAM
 XKwdeiZXbdskPSghRdqt52hDTYrIpL132AtWzz9bBbT2HZPdcjL2NOCF7pHjnxLFdbc/
 g/zw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+beyZFEitoZj/LMaIiH3Z/xmKre6JW8UEKJ2CwK5A/GzGhVvMf04Upz7qDJRR2kher+aweTFLkHhw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKItxursXJeCCuuypYGOgCIwZJ86FvMH2Wo+KDo7tdMyeXH8A8
 U3WLsHT3VhRa7V4t3MRnSDPrcphn0yG1AxgsdCqDJCUcvF2ohhA+DdPf
X-Gm-Gg: AeBDieuOwYddr+a8Gny3ylzDDO2oHTVsLv8QDacDjsgOd7T1QmkoVA3TkDBzj9oADwv
 hZHLKbbgqJSc2esvDU90fZgnSz+/d5TKBu+/c57fLPx5zuPzQV6qB8EzgevXjHQt0Jisr17fZdl
 w9ZXRBlg19GOLbgUHzTR1znCyC/p9APrOBrpfuYpIVjObBsJbF+ODoufpMTmDB7KtVI853yaGR/
 /xstzfvn6J+k09Vpc/XsUVyKV5CArel72eHb3nMGIrO0JpVHdVjU6I+GYmbSGCMlkZPvhTqEcWZ
 nhd4jjKcTPdSXx2HVhs7CIlZvCf3qu34Mn4nxByISQFkluwKWthNBQy9buNMZn63oOtayuEwpWT
 Fbls3piHbqP8zpjNinRXPHq65jy+O3QuyixK+o17eZbD36BT5PznLEvLwMAF2/ye6j1jCV5tGO7
 dRwBfvMo5Tnq3zLxpdHHs3AAnNo4ZWoqx7ffvw5ms+
X-Received: by 2002:a05:600d:16:b0:48a:563c:c8e2 with SMTP id
 5b1f17b1804b1-48a9852d292mr27498815e9.3.1777714815081; 
 Sat, 02 May 2026 02:40:15 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81b99127sm180583055e9.0.2026.05.02.02.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 02:40:14 -0700 (PDT)
Date: Sat, 2 May 2026 12:40:10 +0300
From: Dan Carpenter <error27@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-mm@kvack.org,
 Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Subject: [bug report] dma-buf: heaps: Rework heap allocation hooks to return
 struct dma_buf instead of fd
Message-ID: <afXGeq1AvqFY76MY@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

I'm not sure exactly who to report this bug too.  Probably the mm
devs?

	drivers/dma-buf/heaps/system_heap.c:499 system_heap_allocate()
	warn: passing positive error code 's32min-(-1),1' to 'ERR_PTR'

drivers/dma-buf/heaps/system_heap.c
    459         if (cc_shared) {
    460                 for_each_sgtable_sg(table, sg, i) {
    461                         ret = system_heap_set_page_decrypted(sg_page(sg));
    462                         if (ret)
    463                                 goto free_pages;

It kind of looks like system_heap_set_page_decrypted() can return 1.

    464                 }
    465         }
    466 
    467         /* create the dmabuf */
    468         exp_info.exp_name = dma_heap_get_name(heap);
    469         exp_info.ops = &system_heap_buf_ops;
    470         exp_info.size = buffer->len;
    471         exp_info.flags = fd_flags;
    472         exp_info.priv = buffer;
    473         dmabuf = dma_buf_export(&exp_info);
    474         if (IS_ERR(dmabuf)) {
    475                 ret = PTR_ERR(dmabuf);
    476                 goto free_pages;
    477         }
    478         return dmabuf;
    479 
    480 free_pages:
    481         for_each_sgtable_sg(table, sg, i) {
    482                 struct page *p = sg_page(sg);
    483 
    484                 /*
    485                  * Intentionally leak pages that cannot be re-encrypted
    486                  * to prevent shared memory from being reused.
    487                  */
    488                 if (buffer->cc_shared &&
    489                     system_heap_set_page_encrypted(p))
    490                         continue;
    491                 __free_pages(p, compound_order(p));
    492         }
    493         sg_free_table(table);
    494 free_buffer:
    495         list_for_each_entry_safe(page, tmp_page, &pages, lru)
    496                 __free_pages(page, compound_order(page));
    497         kfree(buffer);
    498 
--> 499         return ERR_PTR(ret);
    500 }

The problem is that add_to_pagemap() returns PM_END_OF_BUFFER (1)
which is used by pagemap_read() and nowhere else.  The call tree
is:

system_heap_allocate()
system_heap_set_page_decrypted()
set_memory_decrypted()
realm_set_memory_decrypted()
__set_memory_enc_dec()
__change_memory_common()
update_range_prot()
walk_kernel_page_table_range_lockless()
walk_pgd_range()
pagemap_pte_hole()
add_to_pagemap()

This code seems sort of old and I guess no one has reported the bug
so maybe it's a false positive, but it feels like it's asking for
problems to return the PM_END_OF_BUFFER.  There aren't any comments
on any of those functions above explaining what return values are
expected.

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
