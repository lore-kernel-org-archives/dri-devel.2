Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0449C4452C
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7767210E89D;
	Mon, 20 Jul 2026 11:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="pgsyrWdF";
	dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16AEE10E89A
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=ql86eOCC8dRr5qOEZeRtNlJU+leHqjCbIW4xS2MIWJ0=; b=pgsyrWdF7q7YdXw4XUz6KzWYWU
 qThk+3cTjq/2lx6RGvNPQUax23c4gc3rvP3eZ2IkjPLEh5l2E9TnWQ9b5A+MQfzo44Fem7p7B4qWn
 ChB5T3OaC/iLqDec8kjbTwwnklKa5c83DY0F+pk42jj0UVqUSDUI75NupAeLokoIiTqZoMuUmnvfq
 b16uou8LhqOq+yEnGJWoKIhPtwOVI2EC6SavybOWt7sbcbziMKz8fhXZDDZ4e1c0cHAoIiMY/4Ooa
 Qym8U8O8ISsTWBK8Nwk3HmYSsSGpvK5rDp4MRqgeQeAKs9USg1ro7SbN3lklAupYJ6aMk2xhVLVef
 4NSoJ/1g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
 id 1wllvj-0000000GWeI-0xDw; Mon, 20 Jul 2026 11:13:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red
 Hat Linux)) id 1wllvh-00000000W0s-0H8M;
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
Subject: [RFC PATCH v2 08/11] samples/kvm: Add guest_memfd backing sample
Date: Mon, 20 Jul 2026 12:03:09 +0100
Message-ID: <7692f08b801f788d942583d388d600030fadb22c.1784545391.git.dwmw@amazon.co.uk>
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

From: David Woodhouse <dwmw@amazon.co.uk>

A minimal in-tree implementation of the guest_memfd ops interface,
useful both as reference code and as the substrate for the selftests
that follow.

Features:

- Backs a slot from a fixed page-less physical range specified by the
  module parameters addr= and len=, or falls back to a CMA-allocated
  contiguous region when neither is given.  The addr=/len= mode lets a
  reserved DRAM carve-out (mem=... or an explicit e820/DT reservation)
  become KVM slot backing without any struct page.

- Per-fd mmap capability via GMEM_PROVIDER_FLAG_MMAP_CAPABLE at
  GMEM_PROVIDER_SETUP time.  An mmap-capable fd is bound as a gmem-only
  slot (KVM_MEMSLOT_GMEM_ONLY) so the host mmap and the guest fault
  path both route through this implementation.  The mmap-capable fd is
  refused for hardware-encrypted VM types (SEV, SEV-ES, SEV-SNP, TDX)
  where a host view onto private-marked pages can only fault; the
  sample enforces this at bind time.  KVM_X86_SW_PROTECTED_VM has no
  hardware encryption and is allowed.

- Page revocation via GMEM_PROVIDER_SET_PRESENT.  Marking a range
  absent tracks it in a bitmap, invokes kvm_gmem_invalidate_range() to
  zap the guest NPT/EPT, and fans dma_buf_invalidate_mappings() out to
  any exported dma-buf so iommufd tears down its mapping.  Subsequent
  get_pfn() on the range returns -EFAULT until it is restored with
  present=1.  Models overcommit-style reclaim without needing the
  platform 's real reclaim machinery.

- A dma-buf exporter (GMEM_PROVIDER_GET_DMABUF) that yields an fd
  suitable for IOMMU_IOAS_MAP_FILE.  The exporter mirrors the shape of
  drivers/vfio/pci/vfio_pci_dmabuf.c: dma_buf_attach_revocable,
  ->map_dma_buf via dma_buf_phys_vec_to_sgt, a single-range phys_vec,
  and the "well-known symbol" hook for iommufd's private-interconnect
  phys-map lookup.

The sample is layered on top of the shared kvm_gmem_fops: its fd is
created with those fops and file->private_data points at a
kvm_gmem_backing embedded at the head of its per-instance state.
Release / mmap / ioctl for the fd all run through the ops table, so
the sample owns no file_operations of its own.

Exposing kvm_gmem_fops for module use required promoting its export
from EXPORT_SYMBOL_FOR_KVM_INTERNAL to EXPORT_SYMBOL_GPL and adding
it to the KVM external-export allowlist.

SEV-SNP bind takes a psmash + rmp_make_shared sweep over the range so
a new SNP VM can transition its pages private and re-encrypt them --
harmless on non-SNP hosts, where the calls return -ENODEV.

Based on a proof-of-concept by Connor Williamson <connordw@amazon.com>.

Signed-off-by: David Woodhouse (Kiro) <dwmw@amazon.co.uk>
---
 samples/Kconfig             |  18 +
 samples/Makefile            |   1 +
 samples/kvm/Makefile        |   2 +
 samples/kvm/gmem_provider.c | 772 ++++++++++++++++++++++++++++++++++++
 samples/kvm/gmem_provider.h |  53 +++
 virt/kvm/guest_memfd.c      |   2 +-
 6 files changed, 847 insertions(+), 1 deletion(-)
 create mode 100644 samples/kvm/Makefile
 create mode 100644 samples/kvm/gmem_provider.c
 create mode 100644 samples/kvm/gmem_provider.h

diff --git a/samples/Kconfig b/samples/Kconfig
index a75e8e78330d..3482659638b5 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -326,6 +326,24 @@ source "samples/rust/Kconfig"
 
 source "samples/damon/Kconfig"
 
+config SAMPLE_KVM_GMEM_PROVIDER
+	tristate "Build sample guest_memfd provider -- loadable module only"
+	depends on KVM_GUEST_MEMFD && X86_64 && m
+	help
+	  This builds a sample external guest_memfd provider module with two
+	  backing modes.  Loaded with addr=/len= it backs guest memory with a
+	  fixed physical range that has no struct page -- for example memory
+	  carved out of the kernel with mem= on the command line.  Without
+	  those params it falls back to a physically contiguous, page-backed
+	  region from alloc_contig_pages(), sized by the setup ioctl (easier to
+	  run, no boot param).
+
+	  It demonstrates the guest_memfd provider ABI including 2M and 1G
+	  guest mappings and, on SEV-SNP hosts, the RMP reset that lets a
+	  page-less range be re-bound to a new VM across a live update.
+
+	  If unsure, say N.
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
diff --git a/samples/Makefile b/samples/Makefile
index 07641e177bd8..e85397e5e34f 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_SAMPLE_TPS6594_PFSM)	+= pfsm/
 subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
+obj-$(CONFIG_SAMPLE_KVM_GMEM_PROVIDER)	+= kvm/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
diff --git a/samples/kvm/Makefile b/samples/kvm/Makefile
new file mode 100644
index 000000000000..dcad6e53ea78
--- /dev/null
+++ b/samples/kvm/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SAMPLE_KVM_GMEM_PROVIDER) += gmem_provider.o
diff --git a/samples/kvm/gmem_provider.c b/samples/kvm/gmem_provider.c
new file mode 100644
index 000000000000..9728f5a8029b
--- /dev/null
+++ b/samples/kvm/gmem_provider.c
@@ -0,0 +1,772 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * gmem_provider - sample external guest_memfd provider.
+ *
+ * Demonstrates the KVM guest_memfd provider ABI with two backing modes:
+ *
+ *  - External (page-less): loaded with addr=/len=, backs guest memory with a
+ *    fixed physical range that has no struct page -- e.g. memory carved out of
+ *    the kernel with mem= on the command line.  This is the case the provider
+ *    ABI exists for; get_pfn() returns bare PFNs KVM treats as non-refcounted.
+ *
+ *  - CMA fallback (page-backed): when addr=/len= are not given, allocates a
+ *    physically contiguous region via alloc_contig_pages() sized by the setup
+ *    ioctl.  Easier to run (no mem= boot param), and still exercises 2M/1G
+ *    mappings.  Not preserved across kexec/live update.
+ *
+ * On SEV-SNP hosts, bind() resets the range's RMP entries to 4K shared so a
+ * (new) SNP VM can re-encrypt it, which is what allows re-binding the range to
+ * a fresh VM across a live update.
+ *
+ * Usage:
+ *   # page-less external range:
+ *   insmod gmem_provider.ko addr=0x5D40000000 len=0x1000000
+ *   # or CMA fallback (no params); size comes from the ioctl
+ *   insmod gmem_provider.ko
+ *   fd = open("/dev/gmem_provider"); ioctl(fd, GMEM_PROVIDER_SETUP, {kvm_fd, size});
+ *   pass the returned fd + KVM_MEM_GUEST_MEMFD to KVM_SET_USER_MEMORY_REGION2.
+ */
+
+#include <linux/anon_inodes.h>
+#include <linux/bitmap.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-buf-mapping.h>
+#include <linux/dma-resv.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/gfp.h>
+#include <linux/highmem.h>
+#include <linux/io.h>
+#include <linux/kvm_host.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/pgtable.h>
+#include <linux/slab.h>
+
+#if IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)
+#include <asm/sev.h>
+#endif
+
+#include "gmem_provider.h"
+
+MODULE_IMPORT_NS("DMA_BUF");
+
+static unsigned long long addr;
+module_param(addr, ullong, 0444);
+MODULE_PARM_DESC(addr, "physical base of an external page-less backing region (optional)");
+
+static unsigned long long len;
+module_param(len, ullong, 0444);
+MODULE_PARM_DESC(len, "size in bytes of the external backing region (optional)");
+
+
+struct gmem_info {
+	/*
+	 * MUST be first: file->private_data points here.  is_kvm_gmem_file()
+	 * on the KVM side proves the reinterpretation is safe.
+	 */
+	struct kvm_gmem_backing backing;
+
+	/*
+	 * Protects everything below (except the immutable base_pfn/npages/
+	 * cma_pages fields set at setup).  Ordering: info->lock is a leaf;
+	 * do not acquire other locks under it.  KVM's slots_lock is already
+	 * held on the .bind/.unbind paths so info->lock is only needed to
+	 * serialise those against ioctl(SET_PRESENT).
+	 */
+	struct mutex lock;
+
+	/* Kept locally: kvm_gmem_ops does not carry a kvm pointer. */
+	struct kvm *kvm;
+
+	/*
+	 * Single active memslot binding.  Used at release time to zap any
+	 * still-active guest mappings before the memory disappears.  NULL
+	 * when no memslot is bound (or the last one has been unbound).
+	 */
+	struct kvm_memory_slot *bound_slot;
+
+	bool mmap_capable;			/* -> KVM_MEMSLOT_GMEM_ONLY at bind */
+
+	unsigned long base_pfn;
+	unsigned long npages;
+	struct page *cma_pages;			/* non-NULL if CMA-allocated */
+	gfn_t base_gfn;				/* recorded at bind, for revoke */
+	pgoff_t pgoff;				/* provider offset (pages) of the slot */
+	unsigned long *absent;			/* bitmap of currently-revoked pages */
+	struct list_head dmabufs;		/* struct gmem_dmabuf entries */
+	struct mutex dmabufs_lock;
+};
+
+static struct gmem_info *to_gmem_info(struct file *file)
+{
+	return container_of(file->private_data, struct gmem_info, backing);
+}
+
+/* Map a backing PFN for CPU access: page-backed via kmap, page-less via memremap. */
+static void *gmem_map_pfn(kvm_pfn_t pfn)
+{
+	if (pfn_valid(pfn))
+		return kmap_local_pfn(pfn);
+	return memremap(PFN_PHYS(pfn), PAGE_SIZE, MEMREMAP_WB);
+}
+
+static void gmem_unmap_pfn(kvm_pfn_t pfn, void *vaddr)
+{
+	if (!vaddr)
+		return;
+	if (pfn_valid(pfn))
+		kunmap_local(vaddr);
+	else
+		memunmap(vaddr);
+}
+
+/* Largest order KVM may map at @gfn, snapped to 4K/2M/1G. */
+static int gmem_max_order(struct gmem_info *info, gfn_t gfn, unsigned long index)
+{
+	unsigned long pfn = info->base_pfn + index;
+	unsigned long remaining = info->npages - index;
+	unsigned int pud_order = PUD_SHIFT - PAGE_SHIFT;
+	unsigned int pmd_order = PMD_SHIFT - PAGE_SHIFT;
+	unsigned long absent_next;
+
+	/*
+	 * A hugepage may not span any revoked page.  Clamp by the distance to
+	 * the next absent bit; scanning is cheap because @absent is a plain
+	 * bitmap and the caller already checked test_bit(index).
+	 */
+	if (info->absent) {
+		absent_next = find_next_bit(info->absent, info->npages,
+					    index + 1);
+		remaining = min(remaining, absent_next - index);
+	}
+
+	if (IS_ALIGNED(pfn, 1UL << pud_order) &&
+	    IS_ALIGNED(gfn, 1UL << pud_order) &&
+	    remaining >= (1UL << pud_order))
+		return pud_order;
+
+	if (IS_ALIGNED(pfn, 1UL << pmd_order) &&
+	    IS_ALIGNED(gfn, 1UL << pmd_order) &&
+	    remaining >= (1UL << pmd_order))
+		return pmd_order;
+
+	return 0;
+}
+
+static int gmem_get_pfn(struct file *file, struct kvm *kvm,
+			struct kvm_memory_slot *slot, gfn_t gfn,
+			kvm_pfn_t *pfn, struct page **page, int *max_order)
+{
+	struct gmem_info *info = to_gmem_info(file);
+	pgoff_t index = gfn - slot->base_gfn + slot->gmem.pgoff;
+
+	if (index >= info->npages)
+		return -EINVAL;
+
+	/* Revoked (absent) page: behave like not-present so the fault fails. */
+	if (info->absent && test_bit(index, info->absent))
+		return -EFAULT;
+
+	*pfn = info->base_pfn + index;
+	if (max_order)
+		*max_order = gmem_max_order(info, gfn, index);
+	return 0;
+}
+
+static int gmem_populate(struct file *file, struct kvm *kvm,
+			 struct kvm_memory_slot *slot, gfn_t gfn,
+			 kvm_pfn_t *pfn, struct page *src_page, int order)
+{
+	struct gmem_info *info = to_gmem_info(file);
+	pgoff_t index = gfn - slot->base_gfn + slot->gmem.pgoff;
+
+	if (index >= info->npages)
+		return -EINVAL;
+
+	*pfn = info->base_pfn + index;
+
+	if (src_page) {
+		void *dst, *src;
+
+		/* Map dst first: memremap() may sleep, kmap_local_page() must not. */
+		dst = gmem_map_pfn(*pfn);
+		if (!dst)
+			return -ENOMEM;
+		src = kmap_local_page(src_page);
+		memcpy(dst, src, PAGE_SIZE);
+		kunmap_local(src);
+		gmem_unmap_pfn(*pfn, dst);
+	}
+	return 0;
+}
+
+static int gmem_bind(struct file *file, struct kvm *kvm,
+		     struct kvm_memory_slot *slot, loff_t offset)
+{
+	struct gmem_info *info = to_gmem_info(file);
+	struct kvm *old_kvm = NULL;
+	unsigned long start = offset >> PAGE_SHIFT;
+
+	if (offset < 0 || !PAGE_ALIGNED(offset) ||
+	    start + slot->npages > info->npages)
+		return -EINVAL;
+
+	/*
+	 * An mmap-capable backing hands the VMM a host mapping onto pages
+	 * that a hardware-encrypted VM (SEV, SEV-ES, SEV-SNP, TDX) will mark
+	 * private in the RMP/EPT; the mmap can only ever fault on those
+	 * pages.  Refuse rather than hand the VMM a useless (and misleading)
+	 * shared view.  SW_PROTECTED_VM has no hardware encryption and is
+	 * fine.
+	 */
+#ifdef CONFIG_X86
+	if (info->mmap_capable &&
+	    (kvm->arch.vm_type == KVM_X86_SEV_VM ||
+	     kvm->arch.vm_type == KVM_X86_SEV_ES_VM ||
+	     kvm->arch.vm_type == KVM_X86_SNP_VM ||
+	     kvm->arch.vm_type == KVM_X86_TDX_VM))
+		return -EACCES;
+#endif
+
+	/* Record the binding so the revoke ioctl can translate offset -> gfn. */
+	mutex_lock(&info->lock);
+	info->base_gfn = slot->base_gfn;
+	info->pgoff = start;
+	info->bound_slot = slot;
+	mutex_unlock(&info->lock);
+
+#if IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)
+	/*
+	 * Reset the RMP for the range to 4K shared so a (new) SEV-SNP VM can
+	 * transition it to private and re-encrypt it.  PSMASH any 2M entries
+	 * first.  Harmless on non-SNP hosts, where these return -ENODEV.
+	 */
+	{
+		unsigned long i;
+		unsigned long first_pmd_pfn = ALIGN(info->base_pfn + start,
+						    PTRS_PER_PMD);
+
+		for (i = first_pmd_pfn - (info->base_pfn + start);
+		     i + PTRS_PER_PMD <= slot->npages;
+		     i += PTRS_PER_PMD)
+			psmash(info->base_pfn + start + i);
+
+		for (i = 0; i < slot->npages; i++) {
+			unsigned long pfn = info->base_pfn + start + i;
+			int ret = rmp_make_shared(pfn, PG_LEVEL_4K);
+
+			if (ret && ret != -ENODEV)
+				pr_info_once("gmem_provider: rmp_make_shared(0x%lx) = %d\n",
+					     pfn, ret);
+		}
+	}
+#endif
+
+	/*
+	 * Claim (or, on re-bind, transfer) VM ownership; pins the VM.
+	 * kvm_put_kvm(old_kvm) MUST run outside info->lock: if the put
+	 * drops the last ref, kvm_destroy_vm() runs inline and calls back
+	 * into our gmem_unbind() (via kvm_gmem_unbind() on each memslot),
+	 * which needs info->lock -- taking it here would self-deadlock.
+	 */
+	mutex_lock(&info->lock);
+	if (info->kvm != kvm) {
+		old_kvm = info->kvm;
+		kvm_get_kvm(kvm);
+		info->kvm = kvm;
+	}
+	mutex_unlock(&info->lock);
+	if (old_kvm)
+		kvm_put_kvm(old_kvm);
+
+	/*
+	 * Record the file on the slot (KVM's outer bind no longer does this
+	 * for us) and mark the slot gmem-only if this backing serves host
+	 * accesses through its own mmap.
+	 */
+	WRITE_ONCE(slot->gmem.file, file);
+	slot->gmem.pgoff = start;
+	if (info->mmap_capable)
+		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
+
+	return 0;
+}
+
+static void gmem_unbind(struct file *file, struct kvm *kvm,
+			struct kvm_memory_slot *slot)
+{
+	struct gmem_info *info = to_gmem_info(file);
+
+	mutex_lock(&info->lock);
+	if (info->bound_slot == slot)
+		info->bound_slot = NULL;
+	mutex_unlock(&info->lock);
+
+#if IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)
+	{
+		unsigned long start = slot->gmem.pgoff;
+		unsigned long first_pmd_pfn = ALIGN(info->base_pfn + start,
+						    PTRS_PER_PMD);
+		unsigned long i;
+
+		/*
+		 * Symmetric with gmem_bind(): PSMASH any 2M RMP entries first
+		 * so rmp_make_shared(PG_LEVEL_4K) can succeed on SNP hosts.
+		 * Harmless on non-SNP: psmash() returns -ENODEV.
+		 */
+		for (i = first_pmd_pfn - (info->base_pfn + start);
+		     i + PTRS_PER_PMD <= slot->npages;
+		     i += PTRS_PER_PMD)
+			psmash(info->base_pfn + start + i);
+
+		for (i = 0; i < slot->npages; i++) {
+			unsigned long pfn = info->base_pfn + start + i;
+
+			rmp_make_shared(pfn, PG_LEVEL_4K);
+		}
+	}
+#endif
+}
+
+static void gmem_release(struct file *file);
+static int gmem_mmap(struct file *file, struct vm_area_struct *vma);
+static long gmem_fd_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+
+static const struct kvm_gmem_ops gmem_ops = {
+	.bind		= gmem_bind,
+	.unbind		= gmem_unbind,
+	.get_pfn	= gmem_get_pfn,
+	.populate	= gmem_populate,
+	.release	= gmem_release,
+	.mmap		= gmem_mmap,
+	.ioctl		= gmem_fd_ioctl,
+};
+
+static void gmem_release(struct file *file)
+{
+	struct gmem_info *info = to_gmem_info(file);
+	struct kvm_memory_slot *slot;
+
+	/*
+	 * If a memslot is still bound at close time, KVM has not yet had a
+	 * chance to call ops->unbind.  Zap the guest mappings for the range
+	 * and clear slot->gmem.file so the eventual unbind is a no-op.  This
+	 * matches native gmem's kvm_gmem_release() and prevents the guest
+	 * from continuing to hit backing memory after we free it below.
+	 */
+	mutex_lock(&info->lock);
+	slot = info->bound_slot;
+	if (slot && info->kvm) {
+		kvm_gmem_invalidate_range(info->kvm, slot->base_gfn,
+					  slot->base_gfn + slot->npages);
+		WRITE_ONCE(slot->gmem.file, NULL);
+		info->bound_slot = NULL;
+	}
+	mutex_unlock(&info->lock);
+
+	if (info->kvm)
+		kvm_put_kvm(info->kvm);
+	if (info->cma_pages)
+		free_contig_range(info->base_pfn, info->npages);
+	kvfree(info->absent);
+	kfree(info);
+	module_put(THIS_MODULE);
+}
+
+static int gmem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct gmem_info *info = to_gmem_info(file);
+	unsigned long npages = vma_pages(vma);
+
+	/*
+	 * gmem_bind() refuses to bind an mmap-capable fd to a coco VM.  A fd
+	 * that was created without GMEM_PROVIDER_FLAG_MMAP_CAPABLE has no
+	 * such gate at bind time, so its mmap must not succeed at any point.
+	 */
+	if (!info->mmap_capable)
+		return -EPERM;
+
+	if (vma->vm_pgoff + npages > info->npages)
+		return -EINVAL;
+
+	/* Page-less backing: map raw PFNs, not folios. */
+	vm_flags_set(vma, VM_PFNMAP | VM_IO | VM_DONTEXPAND | VM_DONTDUMP);
+	return remap_pfn_range(vma, vma->vm_start, info->base_pfn + vma->vm_pgoff,
+			       npages << PAGE_SHIFT, vma->vm_page_prot);
+}
+
+/*
+ * Dynamic dma-buf exporter over the provider's backing.
+ *
+ * Follows the same shape as drivers/vfio/pci/vfio_pci_dmabuf.c: a per-dmabuf
+ * priv holding a phys_vec, a revocable dynamic attach, and a "private
+ * interconnect" symbol iommufd looks up to fetch phys directly (instead of
+ * mapping through the DMA API).
+ *
+ * A revoke on the provider (SET_PRESENT present=0) fans out to every exported
+ * dma-buf via dma_buf_invalidate_mappings(), so iommufd (which registered a
+ * revocable importer) tears down the IOMMU mapping alongside KVM's NPT zap.
+ */
+struct gmem_dmabuf {
+	struct dma_buf *dmabuf;
+	struct gmem_info *info;
+	struct file *provider_file;		/* holds info alive */
+	struct list_head list;			/* info->dmabufs */
+	struct phys_vec phys;			/* single contiguous range */
+	struct kref kref;
+	struct completion comp;
+	bool revoked;
+};
+
+static int gmem_dma_buf_attach(struct dma_buf *dmabuf,
+			       struct dma_buf_attachment *attach)
+{
+	struct gmem_dmabuf *priv = dmabuf->priv;
+
+	if (!attach->peer2peer)
+		return -EOPNOTSUPP;
+	if (priv->revoked)
+		return -ENODEV;
+	if (!dma_buf_attach_revocable(attach))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static void gmem_dma_buf_done(struct kref *kref)
+{
+	struct gmem_dmabuf *priv = container_of(kref, struct gmem_dmabuf, kref);
+
+	complete(&priv->comp);
+}
+
+static struct sg_table *gmem_dma_buf_map(struct dma_buf_attachment *attach,
+					 enum dma_data_direction dir)
+{
+	struct gmem_dmabuf *priv = attach->dmabuf->priv;
+	struct sg_table *sgt;
+
+	dma_resv_assert_held(priv->dmabuf->resv);
+	if (priv->revoked)
+		return ERR_PTR(-ENODEV);
+
+	/* RAM, not P2P MMIO: no p2pdma_provider. */
+	sgt = dma_buf_phys_vec_to_sgt(attach, NULL, &priv->phys, 1,
+				      priv->phys.len, dir);
+	if (IS_ERR(sgt))
+		return sgt;
+
+	kref_get(&priv->kref);
+	return sgt;
+}
+
+static void gmem_dma_buf_unmap(struct dma_buf_attachment *attach,
+			       struct sg_table *sgt,
+			       enum dma_data_direction dir)
+{
+	struct gmem_dmabuf *priv = attach->dmabuf->priv;
+
+	dma_resv_assert_held(priv->dmabuf->resv);
+	dma_buf_free_sgt(attach, sgt, dir);
+	kref_put(&priv->kref, gmem_dma_buf_done);
+}
+
+static void gmem_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct gmem_dmabuf *priv = dmabuf->priv;
+
+	if (priv->info) {
+		mutex_lock(&priv->info->dmabufs_lock);
+		list_del_init(&priv->list);
+		mutex_unlock(&priv->info->dmabufs_lock);
+	}
+	if (priv->provider_file)
+		fput(priv->provider_file);
+	kfree(priv);
+}
+
+static const struct dma_buf_ops gmem_dma_buf_ops = {
+	.attach		= gmem_dma_buf_attach,
+	.map_dma_buf	= gmem_dma_buf_map,
+	.unmap_dma_buf	= gmem_dma_buf_unmap,
+	.release	= gmem_dma_buf_release,
+};
+
+/*
+ * Private interconnect for iommufd (mirrors vfio_pci_dma_buf_iommufd_map).
+ * Returns the single contiguous phys range for the exported region so iommufd
+ * can program the IOMMU directly, bypassing the DMA API.
+ */
+int gmem_provider_dma_buf_iommufd_map(struct dma_buf_attachment *attach,
+				      struct phys_vec *phys);
+int gmem_provider_dma_buf_iommufd_map(struct dma_buf_attachment *attach,
+				      struct phys_vec *phys)
+{
+	struct gmem_dmabuf *priv;
+
+	dma_resv_assert_held(attach->dmabuf->resv);
+	if (attach->dmabuf->ops != &gmem_dma_buf_ops)
+		return -EOPNOTSUPP;
+	priv = attach->dmabuf->priv;
+	if (priv->revoked)
+		return -ENODEV;
+	*phys = priv->phys;
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(gmem_provider_dma_buf_iommufd_map, "iommufd");
+
+/* Called with info->dmabufs_lock held on the revoke path. */
+static void gmem_dma_buf_revoke_all(struct gmem_info *info)
+{
+	struct gmem_dmabuf *priv;
+
+	list_for_each_entry(priv, &info->dmabufs, list) {
+		dma_resv_lock(priv->dmabuf->resv, NULL);
+		if (!priv->revoked) {
+			priv->revoked = true;
+			dma_buf_invalidate_mappings(priv->dmabuf);
+		}
+		dma_resv_unlock(priv->dmabuf->resv);
+	}
+}
+
+static int gmem_provider_get_dmabuf(struct file *file)
+{
+	struct gmem_info *info = to_gmem_info(file);
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct gmem_dmabuf *priv;
+	int fd;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->info = info;
+	priv->provider_file = get_file(file);
+	priv->phys.paddr = (u64)info->base_pfn << PAGE_SHIFT;
+	priv->phys.len = (u64)info->npages << PAGE_SHIFT;
+	kref_init(&priv->kref);
+	init_completion(&priv->comp);
+	INIT_LIST_HEAD(&priv->list);
+
+	exp_info.ops = &gmem_dma_buf_ops;
+	exp_info.size = priv->phys.len;
+	exp_info.flags = O_RDWR;
+	exp_info.priv = priv;
+
+	priv->dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(priv->dmabuf)) {
+		fd = PTR_ERR(priv->dmabuf);
+		kfree(priv);
+		return fd;
+	}
+
+	mutex_lock(&info->dmabufs_lock);
+	list_add(&priv->list, &info->dmabufs);
+	mutex_unlock(&info->dmabufs_lock);
+
+	fd = dma_buf_fd(priv->dmabuf, O_CLOEXEC);
+	if (fd < 0)
+		dma_buf_put(priv->dmabuf);
+	return fd;
+}
+
+static long gmem_fd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct gmem_info *info = to_gmem_info(file);
+	struct gmem_provider_present p;
+	unsigned long start_index, end_index;
+
+	if (cmd == GMEM_PROVIDER_GET_DMABUF)
+		return gmem_provider_get_dmabuf(file);
+
+	if (cmd != GMEM_PROVIDER_SET_PRESENT)
+		return -ENOTTY;
+	if (copy_from_user(&p, (void __user *)arg, sizeof(p)))
+		return -EFAULT;
+	if (!p.len || !PAGE_ALIGNED(p.offset) || !PAGE_ALIGNED(p.len))
+		return -EINVAL;
+
+	start_index = p.offset >> PAGE_SHIFT;
+	end_index = start_index + (p.len >> PAGE_SHIFT);
+	if (end_index > info->npages || end_index < start_index)
+		return -EINVAL;
+
+	if (p.present) {
+		/* Restore: next guest fault calls get_pfn() and re-maps. */
+		mutex_lock(&info->lock);
+		bitmap_clear(info->absent, start_index, end_index - start_index);
+		mutex_unlock(&info->lock);
+	} else {
+		unsigned long clamped_start;
+
+		/* Revoke: mark absent, then zap the guest NPT/EPT for the range. */
+		mutex_lock(&info->lock);
+		bitmap_set(info->absent, start_index, end_index - start_index);
+
+		/*
+		 * Translate provider offset -> guest gfn.  Skip any part of
+		 * the range that falls outside the currently bound slot; a
+		 * naive subtraction would underflow.
+		 */
+		clamped_start = max_t(unsigned long, start_index, info->pgoff);
+		if (info->kvm && end_index > clamped_start)
+			kvm_gmem_invalidate_range(info->kvm,
+				info->base_gfn + clamped_start - info->pgoff,
+				info->base_gfn + end_index - info->pgoff);
+		mutex_unlock(&info->lock);
+
+		/*
+		 * Fan out to iommufd (and any other dma-buf importer): mark the
+		 * exported dma-buf(s) revoked and invalidate any active mappings.
+		 * The provider stays ignorant of scratch-page policy; that lives
+		 * in the importer.
+		 */
+		mutex_lock(&info->dmabufs_lock);
+		gmem_dma_buf_revoke_all(info);
+		mutex_unlock(&info->dmabufs_lock);
+	}
+	return 0;
+}
+
+static long gmem_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct gmem_provider_setup setup;
+	struct gmem_info *info;
+	struct file *kvm_file;
+	struct page *pages = NULL;
+	struct kvm *kvm;
+	unsigned long npages;
+	int fd, ret;
+
+	if (cmd != GMEM_PROVIDER_SETUP)
+		return -ENOTTY;
+
+	if (copy_from_user(&setup, (void __user *)arg, sizeof(setup)))
+		return -EFAULT;
+	if (setup.flags & ~GMEM_PROVIDER_FLAG_MMAP_CAPABLE)
+		return -EINVAL;
+
+	kvm_file = fget(setup.kvm_fd);
+	if (!kvm_file)
+		return -EBADF;
+	if (!file_is_kvm(kvm_file)) {
+		fput(kvm_file);
+		return -EINVAL;
+	}
+	kvm = kvm_file->private_data;
+	if (!kvm) {
+		fput(kvm_file);
+		return -EINVAL;
+	}
+	kvm_get_kvm(kvm);
+	fput(kvm_file);
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		ret = -ENOMEM;
+		goto err_put_kvm;
+	}
+
+	if (addr && len) {
+		/* External page-less range from module params. */
+		info->base_pfn = addr >> PAGE_SHIFT;
+		info->npages = len >> PAGE_SHIFT;
+	} else {
+		/* CMA fallback: allocate a contiguous, page-backed region. */
+		if (!setup.size || !PAGE_ALIGNED(setup.size)) {
+			ret = -EINVAL;
+			goto err_free_info;
+		}
+		npages = setup.size >> PAGE_SHIFT;
+		pages = alloc_contig_pages(npages, GFP_KERNEL, numa_node_id(), NULL);
+		if (!pages) {
+			ret = -ENOMEM;
+			goto err_free_info;
+		}
+		/* Provider path skips KVM's folio-clear; zero to avoid data leak. */
+		memset(page_to_virt(pages), 0, (size_t)npages << PAGE_SHIFT);
+		info->base_pfn = page_to_pfn(pages);
+		info->npages = npages;
+		info->cma_pages = pages;
+	}
+
+	info->absent = kvzalloc(BITS_TO_LONGS(info->npages) * sizeof(unsigned long),
+				GFP_KERNEL);
+	if (!info->absent) {
+		ret = -ENOMEM;
+		goto err_free_pages;
+	}
+
+	INIT_LIST_HEAD(&info->dmabufs);
+	mutex_init(&info->dmabufs_lock);
+	mutex_init(&info->lock);
+
+	/*
+	 * Pin THIS_MODULE while the provider fd is alive.  The fd is created
+	 * with kvm_gmem_fops (owned by kvm.ko), which does not pin us, so
+	 * rmmod of gmem_provider is otherwise free to run behind our ops.
+	 */
+	if (!try_module_get(THIS_MODULE)) {
+		ret = -ENODEV;
+		goto err_free_pages;
+	}
+
+	info->backing.ops = &gmem_ops;
+	info->kvm = kvm;
+	info->mmap_capable = !!(setup.flags & GMEM_PROVIDER_FLAG_MMAP_CAPABLE);
+
+	fd = anon_inode_getfd("[gmem-provider]", &kvm_gmem_fops,
+			      &info->backing, O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		ret = fd;
+		goto err_module_put;
+	}
+	return fd;
+
+err_module_put:
+	module_put(THIS_MODULE);
+
+err_free_pages:
+	if (pages)
+		free_contig_range(page_to_pfn(pages), npages);
+err_free_info:
+	kvfree(info->absent);
+	kfree(info);
+err_put_kvm:
+	kvm_put_kvm(kvm);
+	return ret;
+}
+
+static const struct file_operations gmem_ctl_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= gmem_ctl_ioctl,
+	.compat_ioctl	= gmem_ctl_ioctl,
+};
+
+static struct miscdevice gmem_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "gmem_provider",
+	.fops	= &gmem_ctl_fops,
+};
+
+static int __init gmem_provider_init(void)
+{
+	if ((addr || len) &&
+	    (!addr || !len || !PAGE_ALIGNED(addr) || !PAGE_ALIGNED(len))) {
+		pr_err("gmem_provider: addr= and len= must both be set and page aligned\n");
+		return -EINVAL;
+	}
+	return misc_register(&gmem_dev);
+}
+module_init(gmem_provider_init);
+
+static void __exit gmem_provider_exit(void)
+{
+	misc_deregister(&gmem_dev);
+}
+module_exit(gmem_provider_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Sample guest_memfd provider (external page-less range or CMA fallback)");
diff --git a/samples/kvm/gmem_provider.h b/samples/kvm/gmem_provider.h
new file mode 100644
index 000000000000..45f1b8257f60
--- /dev/null
+++ b/samples/kvm/gmem_provider.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SAMPLES_KVM_GMEM_PROVIDER_H
+#define _SAMPLES_KVM_GMEM_PROVIDER_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/*
+ * ioctl on /dev/gmem_provider: create a guest_memfd provider fd and return it
+ * for use with KVM_SET_USER_MEMORY_REGION2.
+ *
+ * If the module was loaded with addr=/len=, the fd is backed by that fixed
+ * page-less physical range and @size is ignored.  Otherwise the fd is backed
+ * by a @size-byte physically contiguous region from alloc_contig_pages().
+ */
+/* Flags for struct gmem_provider_setup.flags */
+#define GMEM_PROVIDER_FLAG_MMAP_CAPABLE	(1u << 0)	/* fd is mmap()-able; slot becomes gmem-only.
+								   Refused for coco VMs (SEV-SNP/TDX). */
+
+struct gmem_provider_setup {
+	__s32 kvm_fd;	/* an open KVM VM fd */
+	__u32 flags;	/* GMEM_PROVIDER_FLAG_* */
+	__u64 size;	/* CMA fallback size in bytes, page aligned */
+};
+
+#define GMEM_PROVIDER_IOCTL_BASE	'G'
+#define GMEM_PROVIDER_SETUP		_IOW(GMEM_PROVIDER_IOCTL_BASE, 1, struct gmem_provider_setup)
+
+/*
+ * ioctl on a provider fd (returned by SETUP): flip a byte range of the backing
+ * between present and absent.  Revoking (present=0) marks the range absent and
+ * zaps the guest's NPT/EPT so the next access re-faults; get_pfn() then refuses
+ * the range until it is restored (present=1).  Models overcommit page reclaim.
+ */
+struct gmem_provider_present {
+	__u64 offset;	/* byte offset into the provider region, page aligned */
+	__u64 len;	/* byte length, page aligned */
+	__u32 present;	/* 0 = revoke (absent), 1 = restore (present) */
+	__u32 pad;
+};
+
+#define GMEM_PROVIDER_SET_PRESENT	_IOW(GMEM_PROVIDER_IOCTL_BASE, 2, struct gmem_provider_present)
+
+/*
+ * ioctl on a provider fd (returned by SETUP): export the backing region as a
+ * dynamic dma-buf and return an fd for it, suitable for
+ * IOMMU_IOAS_MAP_FILE.  Revoking the region (SET_PRESENT present=0) fans out
+ * to the exported dma-buf via dma_buf_invalidate_mappings(), causing iommufd
+ * to tear down the IOMMU mapping so DMA to the reclaimed range faults.
+ */
+#define GMEM_PROVIDER_GET_DMABUF	_IO(GMEM_PROVIDER_IOCTL_BASE, 3)
+
+#endif /* _SAMPLES_KVM_GMEM_PROVIDER_H */
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 1da22da0a6ec..d284bb70fe05 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -546,7 +546,7 @@ struct file_operations kvm_gmem_fops = {
 	.unlocked_ioctl	= kvm_gmem_fops_ioctl,
 	.compat_ioctl	= kvm_gmem_fops_ioctl,
 };
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_fops);
+EXPORT_SYMBOL_GPL(kvm_gmem_fops);
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
 				  struct folio *dst, struct folio *src,
-- 
2.55.0

