Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E25C4452B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74F3710E89A;
	Mon, 20 Jul 2026 11:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="iQmvjO2W";
	dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1094E10E897
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=a0eK456rMQPuzRvGTSP6BKwAKzhSje70kirn60D7E5o=; b=iQmvjO2WvxO2c6EmfKSmOa2nA/
 eXuFoKnfp9PEiy6SlOv9QcYlml5YIi7JZThecll32iw3QURI2q17eLQmYVdZF5Bg0hbuynlJqQWPz
 7VZ22SoGazxhFCpjXE/z628yOQ7M8LUJilOtXhZbsLWWzac186cgrATjUcEZJ6nj02aHUi+JBJnZP
 yv4zgLKOyDNFWrHc0amJQwixmuR8swOfSloX1evNJ7Bt/dLpaB5E0XTJKzMowyiA3aXSa6vWAzD+l
 vCSX7TqHHUcsGn1AkC+3Z0KpgxGbu2pESyuIVjsfkVnl3adDHQF6AzWm7TFq+XtU7zm79/EKo0dVq
 SLOX2eQw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
 id 1wllvj-0000000GWeC-0vzw; Mon, 20 Jul 2026 11:13:09 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red
 Hat Linux)) id 1wllvg-00000000W0X-2l6P;
 Mon, 20 Jul 2026 12:13:00 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>,
 Kees Cook <kees@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>,
 Connor Williamson <connordw@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhou Yuhang <zhouyuhang@kylinos.cn>, Zi Li <zi.li@linux.dev>,
 Dan Williams <djbw@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Colin Ian King <colin.i.king@gmail.com>, connordw@amazon.co.uk,
 graf@amazon.de, fgriffo@amazon.co.uk, David Woodhouse <dwmw@amazon.co.uk>
Subject: [RFC PATCH v2 03/11] KVM: SEV: Remove struct page dependency from SNP
 gmem paths
Date: Mon, 20 Jul 2026 12:03:04 +0100
Message-ID: <45325cc39f81b3e654ad3289b7214483dbd0ae13.1784545391.git.dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2b5e7a83d277134294199a455469bb436196b902.1784545391.git.dwmw@amazon.co.uk>
References: <2b5e7a83d277134294199a455469bb436196b902.1784545391.git.dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
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

From: Connor Williamson <connordw@amazon.com>

The SNP paths assume every guest_memfd PFN has a struct page and a
direct map alias.  That is not true for memory handed out by an
external guest_memfd provider that backs guest RAM with device or
carved-out physical memory (e.g. via mem=), which has no struct page.

Relax the RMP helpers in arch/x86/virt/svm/sev.c:

 - psmash(): drop the pfn_valid() gate.  PSMASH operates on the RMP
   entry for a physical address and touches neither the direct map nor
   struct page.

 - adjust_direct_map(): return 0 instead of -EINVAL for a page-less
   PFN, which has no direct map alias to split.  Checked before the 2M
   range test, which would otherwise reject the span.

 - __snp_leak_pages(): compute the struct page per iteration and skip
   list insertion when it is NULL; a page-less PFN cannot be chained
   onto the leaked pages list.

And the KVM SNP gmem paths in arch/x86/kvm/svm/sev.c:

 - sev_gmem_map_pfn()/sev_gmem_unmap_pfn() fall back to memremap() for
   the launch-update copy and the CPUID error read-back in
   sev_gmem_post_populate().  The destination PFN is mapped before the
   atomic kmap_local_page() of the source, since memremap() may sleep.

 - sev_clflush_pfn() falls back to memremap() for the cache flush in
   sev_gmem_invalidate().

No functional change for page-backed PFNs.

Signed-off-by: Connor Williamson <connordw@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/svm/sev.c  | 93 +++++++++++++++++++++++++++++++++++------
 arch/x86/virt/svm/sev.c | 27 ++++++++----
 2 files changed, 100 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 427229347876..125779c82bc4 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -12,6 +12,7 @@
 #include <linux/kvm_host.h>
 #include <linux/kernel.h>
 #include <linux/highmem.h>
+#include <linux/io.h>
 #include <linux/psp.h>
 #include <linux/psp-sev.h>
 #include <linux/pagemap.h>
@@ -2321,6 +2322,30 @@ struct sev_gmem_populate_args {
 	int fw_error;
 };
 
+/*
+ * Map a guest_memfd PFN for CPU access.  A PFN provided by an external
+ * guest_memfd provider may have no struct page, so fall back to memremap()
+ * for those.  Pair each call with sev_gmem_unmap_pfn().
+ */
+static void *sev_gmem_map_pfn(kvm_pfn_t pfn)
+{
+	if (pfn_valid(pfn))
+		return kmap_local_pfn(pfn);
+
+	return memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
+}
+
+static void sev_gmem_unmap_pfn(kvm_pfn_t pfn, void *vaddr)
+{
+	if (!vaddr)
+		return;
+
+	if (pfn_valid(pfn))
+		kunmap_local(vaddr);
+	else
+		memunmap(vaddr);
+}
+
 static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 				  struct page *src_page, void *opaque)
 {
@@ -2343,13 +2368,23 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	}
 
 	if (src_page) {
-		void *src_vaddr = kmap_local_page(src_page);
-		void *dst_vaddr = kmap_local_pfn(pfn);
+		void *dst_vaddr = sev_gmem_map_pfn(pfn);
+		void *src_vaddr;
 
-		memcpy(dst_vaddr, src_vaddr, PAGE_SIZE);
+		if (!dst_vaddr) {
+			ret = -ENOMEM;
+			goto out;
+		}
 
-		kunmap_local(dst_vaddr);
+		/*
+		 * Map the destination (which may be page-less and thus sleep in
+		 * memremap()) before the atomic kmap_local_page() of the source.
+		 */
+		src_vaddr = kmap_local_page(src_page);
+		memcpy(dst_vaddr, src_vaddr, PAGE_SIZE);
 		kunmap_local(src_vaddr);
+
+		sev_gmem_unmap_pfn(pfn, dst_vaddr);
 	}
 
 	ret = rmp_make_private(pfn, gfn << PAGE_SHIFT, PG_LEVEL_4K,
@@ -2379,14 +2414,17 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	if (ret && !snp_page_reclaim(kvm, pfn) &&
 	    sev_populate_args->type == KVM_SEV_SNP_PAGE_TYPE_CPUID &&
 	    sev_populate_args->fw_error == SEV_RET_INVALID_PARAM) {
-		void *src_vaddr = kmap_local_page(src_page);
-		void *dst_vaddr = kmap_local_pfn(pfn);
+		void *dst_vaddr = sev_gmem_map_pfn(pfn);
+		void *src_vaddr;
 
-		memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);
-		set_page_dirty(src_page);
+		if (dst_vaddr) {
+			src_vaddr = kmap_local_page(src_page);
+			memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);
+			set_page_dirty(src_page);
+			kunmap_local(src_vaddr);
 
-		kunmap_local(dst_vaddr);
-		kunmap_local(src_vaddr);
+			sev_gmem_unmap_pfn(pfn, dst_vaddr);
+		}
 	}
 
 out:
@@ -5117,6 +5155,38 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
 	return 0;
 }
 
+/*
+ * Flush the CPU caches for a guest_memfd PFN.  A PFN from an external
+ * guest_memfd provider may have no direct map alias, so fall back to a
+ * temporary memremap() mapping for the cache flush.
+ */
+static void sev_clflush_pfn(kvm_pfn_t pfn, size_t size)
+{
+	void *va;
+
+	if (pfn_valid(pfn)) {
+		clflush_cache_range(__va(pfn_to_hpa(pfn)), size);
+		return;
+	}
+
+	va = memremap(pfn_to_hpa(pfn), size, MEMREMAP_WB);
+	if (!va) {
+		/*
+		 * memremap() can fail under memory pressure (vmalloc space
+		 * exhaustion).  Callers reach us during guest_memfd hole-
+		 * punching, so this is user-triggerable; ratelimit rather
+		 * than WARN, otherwise panic_on_warn hosts turn it into a
+		 * denial of service.
+		 */
+		pr_warn_ratelimited("SEV: memremap failed for cache flush pfn=%llx size=%zu\n",
+				    pfn, size);
+		return;
+	}
+
+	clflush_cache_range(va, size);
+	memunmap(va);
+}
+
 void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
 {
 	kvm_pfn_t pfn;
@@ -5172,8 +5242,7 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
 		 * cache entries for these pages before free'ing them back to
 		 * the host.
 		 */
-		clflush_cache_range(__va(pfn_to_hpa(pfn)),
-				    use_2m_update ? PMD_SIZE : PAGE_SIZE);
+		sev_clflush_pfn(pfn, use_2m_update ? PMD_SIZE : PAGE_SIZE);
 next_pfn:
 		pfn += use_2m_update ? PTRS_PER_PMD : 1;
 		cond_resched();
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 8bcdce98f6dc..3623b52fbb11 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -897,8 +897,11 @@ int psmash(u64 pfn)
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return -ENODEV;
 
-	if (!pfn_valid(pfn))
-		return -EINVAL;
+	/*
+	 * Do not require a struct page.  PSMASH operates on the RMP entry for
+	 * a physical address; a valid PFN with no struct page backing (e.g.
+	 * memory handed out by an external guest_memfd provider) is fine.
+	 */
 
 	/* Binutils version 2.36 supports the PSMASH mnemonic. */
 	asm volatile(".byte 0xF3, 0x0F, 0x01, 0xFF"
@@ -953,8 +956,13 @@ static int adjust_direct_map(u64 pfn, int rmp_level)
 	if (WARN_ON_ONCE(rmp_level > PG_LEVEL_2M))
 		return -EINVAL;
 
+	/*
+	 * A PFN with no struct page has no direct map alias to split, so
+	 * there is nothing to do.  This is checked before the 2M range test
+	 * below, which would otherwise reject the whole span.
+	 */
 	if (!pfn_valid(pfn))
-		return -EINVAL;
+		return 0;
 
 	if (rmp_level == PG_LEVEL_2M &&
 	    (!IS_ALIGNED(pfn, PTRS_PER_PMD) || !pfn_valid(pfn + PTRS_PER_PMD - 1)))
@@ -1060,32 +1068,35 @@ EXPORT_SYMBOL_GPL(rmp_make_shared);
 
 void __snp_leak_pages(u64 pfn, unsigned int npages, bool dump_rmp)
 {
-	struct page *page = pfn_to_page(pfn);
-
 	pr_warn("Leaking PFN range 0x%llx-0x%llx\n", pfn, pfn + npages);
 
 	spin_lock(&snp_leaked_pages_list_lock);
 	while (npages--) {
+		struct page *page = pfn_valid(pfn) ? pfn_to_page(pfn) : NULL;
 
 		/*
 		 * Reuse the page's buddy list for chaining into the leaked
 		 * pages list. This page should not be on a free list currently
 		 * and is also unsafe to be added to a free list.
+		 *
+		 * A page-less PFN (e.g. memory backed by an external
+		 * guest_memfd provider) has no struct page to chain, so it is
+		 * only accounted and, optionally, its RMP entry dumped.
 		 */
-		if (likely(!PageCompound(page)) ||
+		if (page &&
+		    (likely(!PageCompound(page)) ||
 
 			/*
 			 * Skip inserting tail pages of compound page as
 			 * page->buddy_list of tail pages is not usable.
 			 */
-		    (PageHead(page) && compound_nr(page) <= npages))
+		     (PageHead(page) && compound_nr(page) <= npages)))
 			list_add_tail(&page->buddy_list, &snp_leaked_pages_list);
 
 		if (dump_rmp)
 			dump_rmpentry(pfn);
 		snp_nr_leaked_pages++;
 		pfn++;
-		page++;
 	}
 	spin_unlock(&snp_leaked_pages_list_lock);
 }
-- 
2.55.0

