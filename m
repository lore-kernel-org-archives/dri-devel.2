Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2692EC44517
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DB110F33E;
	Thu, 16 Jul 2026 15:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="cc1TtiAQ";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89EC010E37D
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=iLMkXQPoO9bJTen1/DML3UcjON7B/Jg/kBSza579AWA=; b=cc1TtiAQFQ8DOZRUX6MuTqORxo
 3ArYsOwxxvOD/iW2RtooPUh6L79VtTHcclwoLE8wFqC2jU0zr4pLMWD47YDQx7LiEI/oU2OddxTIL
 345PQewaiOjESgY5996NoB0YdB/vaEzdYBV/vmaxgc3HqyyUNxHztPPc87SKB7EiPigeKBCgKBBGa
 fhmdPYmN69FijEmwHI1b25K3ZNnGS65fhdcyZDM3J1OvImZRL6Pw/9w717ok/BqAe8DVrpWkakfij
 zX7U2VO/Cu+7KEHVeKwuqskTKjlvQoSjNeXnatCABHjczvS8y5ipVAr1nawllh2wxMxYsAjbTPvyb
 narHY3Zw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wkNpj-00000002l0U-37sL; Thu, 16 Jul 2026 15:17:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red
 Hat Linux)) id 1wkNpj-000000012tE-24AB;
 Thu, 16 Jul 2026 16:17:07 +0100
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
Subject: [RFC PATCH 07/11] KVM: guest_memfd: Add ops-driven page revocation
Date: Thu, 16 Jul 2026 10:31:27 +0100
Message-ID: <05c8944cb77fa68163303cefe1c922ff142ceb07.1784194290.git.dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

From: David Woodhouse <dwmw@amazon.co.uk>

Add kvm_gmem_invalidate_range(): a guest_memfd backing calls it to zap
the guest secondary-MMU mapping for a gfn range so the next access
re-faults through ops->get_pfn().  Mirrors the existing internal
__kvm_gmem_invalidate_start() for a single bound slot, bracketing the
unmap with the mmu_invalidate window so a racing vCPU fault retries
rather than installing a stale mapping.

The existing ops->invalidate callback is KVM -> implementation
(cleanup); this new symbol is the implementation -> KVM path, useful
for an overcommit manager or any subsystem that reclaims pages from a
running guest.  Export it for module use and add it to the KVM
external-export allowlist.

Signed-off-by: David Woodhouse (Kiro) <dwmw@amazon.co.uk>
---
 arch/x86/kvm/Makefile    |  3 ++-
 include/linux/kvm_host.h |  9 +++++++++
 virt/kvm/guest_memfd.c   | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 77337c37324b..cb963d6ecaab 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -63,7 +63,8 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
 				-e kvm_write_track_remove_gfn \
 				-e kvm_get_kvm \
 				-e kvm_get_kvm_safe \
-				-e kvm_put_kvm
+				-e kvm_put_kvm \
+				-e kvm_gmem_invalidate_range
 
 # Force grep to emit a goofy group separator that can in turn be replaced with
 # the above newline macro (newlines in Make are a nightmare).  Note, grep only
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b33d2f475042..04fa0cb126f6 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -701,6 +701,15 @@ static inline bool is_kvm_gmem_file(struct file *file)
 	return file && file->f_op == &kvm_gmem_fops;
 }
 
+/*
+ * Outbound (implementation -> KVM) revocation: zap the guest's secondary MMU
+ * (NPT/EPT) mapping for a gfn range so the next guest access re-faults
+ * through the ops' get_pfn().  This is the reverse of ->invalidate (which is
+ * KVM -> implementation) and is what a backing that manages its own memory
+ * (e.g. an overcommit manager) uses to reclaim a page from a running guest.
+ */
+void kvm_gmem_invalidate_range(struct kvm *kvm, gfn_t start, gfn_t end);
+
 #endif /* CONFIG_KVM_GUEST_MEMFD */
 
 static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2b277468a12f..6c13742de068 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -738,6 +738,45 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	return __kvm_gmem_create(kvm, size, flags);
 }
 
+/*
+ * Outbound (implementation -> KVM) revocation: an implementation zaps the
+ * guest's secondary MMU mapping for a gfn range so the next guest access
+ * re-faults through ops->get_pfn().  Mirrors __kvm_gmem_invalidate_start()
+ * for a single bound slot, bracketing the unmap with the mmu_invalidate
+ * window so a racing vCPU fault retries rather than installing a stale
+ * mapping.
+ */
+void kvm_gmem_invalidate_range(struct kvm *kvm, gfn_t start, gfn_t end)
+{
+	struct kvm_memory_slot *slot;
+	bool flush = false;
+	int idx;
+
+	idx = srcu_read_lock(&kvm->srcu);
+
+	slot = gfn_to_memslot(kvm, start);
+	if (slot) {
+		struct kvm_gfn_range gfn_range = {
+			.slot		= slot,
+			.start		= start,
+			.end		= min(end, slot->base_gfn + slot->npages),
+			.may_block	= true,
+			.attr_filter	= KVM_FILTER_SHARED | KVM_FILTER_PRIVATE,
+		};
+
+		KVM_MMU_LOCK(kvm);
+		kvm_mmu_invalidate_start(kvm);
+		flush = kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
+		if (flush)
+			kvm_flush_remote_tlbs(kvm);
+		kvm_mmu_invalidate_end(kvm);
+		KVM_MMU_UNLOCK(kvm);
+	}
+
+	srcu_read_unlock(&kvm->srcu, idx);
+}
+EXPORT_SYMBOL_GPL(kvm_gmem_invalidate_range);
+
 static const struct kvm_gmem_ops *kvm_gmem_get_ops(struct file *file)
 {
 	if (!is_kvm_gmem_file(file))
-- 
2.54.0

