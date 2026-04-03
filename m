Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3B9E7E358
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658B510F3E8;
	Fri,  3 Apr 2026 09:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dZOfZycT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473F710F3E8
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 09:20:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CF46644177;
 Fri,  3 Apr 2026 09:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AB8C4CEF7;
 Fri,  3 Apr 2026 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775208033;
 bh=6yQ3vTenqXPoi+0PWTGukMJaYEPSz03tyljhBa6IByM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dZOfZycTXUM3i6iopk6sUfFHNU0/Xqwy/r8HbSQ7CGZvidHZ1Z3vrFRo3K4SCpK22
 /we6sw2gldNdAVF1lwjBWvDa/GZf/pmNvP3tcFcJMJyu4PI2NmNxfKygepsu5Nlmyd
 r29qFVbXkGyAWEA6ZQ+r9fqoscaZpyJhPPCBlbpdSKJyk6r/b9EkC7sfyiqKzbGSNp
 3dMqIBR3UB5nRPZt2U4fQ9PRrKKaUmpHTmfdJ38ZmKRO9U+i3l4nsJXmLqU6M7+UGY
 CC7h3IPn5r9Dyfjvo7CUEJ1Vg8+EW13P18cgEcIxwbjf+jI/Ihh93Zr9NHd3mOyaXO
 kWrJy7LRxAjyQ==
From: Barry Song <baohua@kernel.org>
To: urezki@gmail.com
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, david@kernel.org,
 dri-devel@lists.freedesktop.org, jstultz@google.com,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org, mripard@kernel.org,
 sumit.semwal@linaro.org, xueyuan.chen21@gmail.com
Subject: Re: [PATCH] mm/vmalloc: map contiguous pages in batches for vmap()
 whenever possible
Date: Fri,  3 Apr 2026 17:20:28 +0800
Message-Id: <20260403092028.61257-1-baohua@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <aVvmxGUp2l0Tavwb@milan>
References: <aVvmxGUp2l0Tavwb@milan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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


> I think so, at least the place:
> 
> <snip>
> [    2.959030] Oops: Oops: 0000 [#66] SMP NOPTI
> [    2.960004] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0+ #220 PREEMPT(none)
> [    2.961781] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [    2.963870] BUG: unable to handle page fault for address: ffffffff3fd68118
> [    2.965383] #PF: supervisor read access in kernel mode
> [    2.966532] #PF: error_code(0x0000) - not-present page
> [    2.967682] BAD
> <snip>
> 
> but it is broken for sure:

> i += 1U << shift - "i" is an index in the page array.
> For example if order-0 you jump 4096 indices ahead.

> Should be: i += 1U << (shift - PAGE_SHIFT)

You’re right! And sorry for the slow response—it’s been
three months since the last discussion.

> vmap_page_range() does flushing and it has instrumented KMSAN inside.
> We should follow same semantic. Also it uses ioremap_max_page_shift as
> maximum page shift policy.

Not quite sure if vmap() should follow ioremap()’s
ioremap_max_page_shift. If needed, it shouldn’t be
difficult to do so.

I have a version queued for testing (Xueyuan is working
hard on it). Meanwhile, if you have any comments, please
feel free to share.

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 57eae99d9909..8d449e78a07a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3513,6 +3513,60 @@ void vunmap(const void *addr)
 }
 EXPORT_SYMBOL(vunmap);
 
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
+static inline int get_vmap_batch_order(struct page **pages,
+		unsigned int max_steps, unsigned int idx)
+{
+	unsigned int nr_pages;
+
+	if (ioremap_max_page_shift == PAGE_SHIFT)
+		return 0;
+
+	nr_pages = compound_nr(pages[idx]);
+	if (nr_pages == 1 || max_steps < nr_pages)
+		return 0;
+
+	if (num_pages_contiguous(&pages[idx], nr_pages) == nr_pages)
+		return compound_order(pages[idx]);
+	return 0;
+}
+#else
+static inline int get_vmap_batch_order(struct page **pages,
+		unsigned int max_steps, unsigned int idx)
+{
+	return 0;
+}
+#endif
+
+static int vmap_contig_pages_range(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages)
+{
+	unsigned int count = (end - addr) >> PAGE_SHIFT;
+	int err;
+
+	err = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
+						PAGE_SHIFT, GFP_KERNEL);
+	if (err)
+		goto out;
+
+	for (unsigned int i = 0; i < count; ) {
+		unsigned int shift = PAGE_SHIFT;
+
+		shift += get_vmap_batch_order(pages, count - i, i);
+		err = vmap_range_noflush(addr, addr + (1UL << shift),
+				page_to_phys(pages[i]), prot, shift);
+		if (err)
+			goto out;
+
+		addr += 1UL  << shift;
+		i += 1U << (shift - PAGE_SHIFT);
+	}
+
+out:
+	flush_cache_vmap(addr, end);
+	return err;
+}
+
 /**
  * vmap - map an array of pages into virtually contiguous space
  * @pages: array of page pointers
@@ -3556,8 +3610,8 @@ void *vmap(struct page **pages, unsigned int count,
 		return NULL;
 
 	addr = (unsigned long)area->addr;
-	if (vmap_pages_range(addr, addr + size, pgprot_nx(prot),
-				pages, PAGE_SHIFT) < 0) {
+	if (vmap_contig_pages_range(addr, addr + size, pgprot_nx(prot),
+				pages) < 0) {
 		vunmap(area->addr);
 		return NULL;
 	}
-- 
2.39.3 (Apple Git-146)
