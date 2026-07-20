Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F79CC4452B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E7A10E8A1;
	Mon, 20 Jul 2026 11:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="BT+q7E2A";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D17410E17B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=I3TETJN52syz2g6MqbTdVZEfpnX6inPwc/Frrrs4gHo=; b=BT+q7E2AS/3rNM1X4x48dFjFBR
 YvyZw5wXe9MWmOIi3uXcOCpV72NauOWsyr/XxcIpCm5CrWOTOIU4IfHGM6LCr6Y4xhRtHbL9Snqw9
 wuKVsNbq++8pFFMJ/FbMpbG1z9IUgbuDPVZw4Zb/EiXJGjR9BzB5WeCw5vjqXzOZwQ2ufimRODodA
 ugyYSEZvNHZHnUB67Jqa4d0l6f6WQrax6nhNzQ24+xzyY0/l1Iqw9+MqjsWif5HbkMNrOB70wAwFw
 g1Srv8pJphEFT2IreEwkETTw32qjPpvP0xxl9CjS0zlJKYGRANWgHS5QM+TPFZJVtuhrOmSZI8gpS
 hMVb3KDw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wllvh-0000000Akyu-14T7; Mon, 20 Jul 2026 11:13:01 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red
 Hat Linux)) id 1wllvg-00000000W0o-48o2;
 Mon, 20 Jul 2026 12:13:01 +0100
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
Subject: [RFC PATCH v2 07/11] KVM: guest_memfd: Add ops-driven page revocation
Date: Mon, 20 Jul 2026 12:03:08 +0100
Message-ID: <ee95ed5aaf06772a1086bf32c65125db90e7e3cf.1784545391.git.dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2b5e7a83d277134294199a455469bb436196b902.1784545391.git.dwmw@amazon.co.uk>
References: <2b5e7a83d277134294199a455469bb436196b902.1784545391.git.dwmw@amazon.co.uk>
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
 include/linux/kvm_host.h |  9 +++++++
 virt/kvm/guest_memfd.c   | 52 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

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
index 057f90eb835a..1da22da0a6ec 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -738,6 +738,58 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
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
+	struct kvm_memslot_iter iter;
+	bool flush = false;
+	int as_id;
+	int idx;
+
+	idx = srcu_read_lock(&kvm->srcu);
+
+	/*
+	 * Walk every address space (SMM has its own on x86) and every
+	 * intersecting memslot.  A single invalidation may span several
+	 * slots and holes: skip the holes, clamp to each slot's range.
+	 */
+	KVM_MMU_LOCK(kvm);
+	kvm_mmu_invalidate_start(kvm);
+
+	for (as_id = 0; as_id < kvm_arch_nr_memslot_as_ids(kvm); as_id++) {
+		struct kvm_memslots *slots = __kvm_memslots(kvm, as_id);
+
+		kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
+			struct kvm_gfn_range gfn_range;
+
+			slot = iter.slot;
+			gfn_range.slot		= slot;
+			gfn_range.start		= max(start, slot->base_gfn);
+			gfn_range.end		= min(end, slot->base_gfn + slot->npages);
+			gfn_range.may_block	= true;
+			gfn_range.attr_filter	= KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
+
+			flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
+		}
+	}
+	if (flush)
+		kvm_flush_remote_tlbs(kvm);
+
+	kvm_mmu_invalidate_end(kvm);
+	KVM_MMU_UNLOCK(kvm);
+
+	srcu_read_unlock(&kvm->srcu, idx);
+}
+EXPORT_SYMBOL_GPL(kvm_gmem_invalidate_range);
+
 static const struct kvm_gmem_ops *kvm_gmem_get_ops(struct file *file)
 {
 	if (!is_kvm_gmem_file(file))
-- 
2.55.0

