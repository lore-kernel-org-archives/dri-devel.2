Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE4CC44531
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A4C10E8B0;
	Mon, 20 Jul 2026 11:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="neLctlvI";
	dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1062D10E893
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=r8tIfYKk1SuuC2KPz9R6wpRumPmGYMrpaT7TgfGxWfE=; b=neLctlvIipNXWD0C/67N3PwzPG
 Smoa8GKFZNKI/u2ZRFEUq1fcGhsKNYsNSUZSXh8ItX1IN0BcdRxjlEJ7nIjOq271wBycrHIeQxOUc
 m/BziD2qAdshXW+9FSkKOGB+LpVlwwfVpEONUVHyABWpLinKFj6h8J1lyqQrjqbySchRADO59g5lQ
 Z1d16UH/55dz8+YiorGxzzLML9I4qM1YPeo0yKZ9RkvpIia6hBZcZQvBGtxt9y0eCXaz6+9CwTfJb
 h2dwMdzQTLVOsuG89GQJ6M5yVFhEQ3mDTzfxEixwULglhkAERnGVsMsW6iAPPPOEAvGjdmft92CB9
 iyiMZSQw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
 id 1wllvj-0000000GWeD-0xIj; Mon, 20 Jul 2026 11:13:09 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red
 Hat Linux)) id 1wllvg-00000000W0b-3CcU;
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
Subject: [RFC PATCH v2 04/11] KVM: guest_memfd: Introduce guest memory ops and
 route native gmem through them
Date: Mon, 20 Jul 2026 12:03:05 +0100
Message-ID: <de89b470d6321c8c65a442050a9546013c67d36a.1784545391.git.dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2b5e7a83d277134294199a455469bb436196b902.1784545391.git.dwmw@amazon.co.uk>
References: <2b5e7a83d277134294199a455469bb436196b902.1784545391.git.dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Guest_memfd today has exactly one backing implementation, hard-wired
into virt/kvm/guest_memfd.c.  To let other subsystems supply guest
memory from an alternate source -- for example a physically contiguous
range without struct page, or memory shared with a peer device --
lift the operations into a small vtable and route the built-in gmem
through it.

Introduce struct kvm_gmem_ops in <linux/kvm_host.h>: bind / unbind /
get_pfn / populate / invalidate for the memory-side operations, plus
release / mmap / fallocate for the file-level ones.  Every file that
can back guest memory is created with one shared struct
file_operations, kvm_gmem_fops, and file->private_data points at a
struct kvm_gmem_backing whose ->ops field is the per-instance vtable.
This mirrors the dma-buf / socket / iommufd pattern: a canonical fops
identifies the file (is_kvm_gmem_file() is a plain fops-equality
check), and per-instance behaviour is reached via private_data.

Every callback on kvm_gmem_fops -- release, mmap, fallocate, and the
memory-side dispatchers already present -- reaches through the ops
table, so foreign implementations get a private hook for each and
KVM code never has to distinguish "native vs foreign".  Native gmem
becomes one implementation of the ops (kvm_gmem_native_ops), with the
current release/mmap/fallocate bodies moved into
kvm_gmem_native_release/_mmap/_fallocate.  struct gmem_file gains a
struct kvm_gmem_backing as its first member so file->private_data can
be reinterpreted uniformly across implementations.

.populate is deliberately left NULL for the built-in path;
kvm_gmem_populate() keeps an inline fast path because the current
folio-locked + attribute-checked shape of post_populate() does not fit
the ops signature cleanly.  Wiring that flow through ops is a separate
cleanup.  .invalidate is likewise NULL for the built-in path, because
its invalidations run through inode->i_mapping (truncate, hwpoison,
free_folio) rather than an out-of-band notification.

kvm_gmem_unbind() gains a struct kvm * parameter so the dispatcher can
pass it to ops->unbind() without keeping a duplicate copy anywhere.
The three existing callers in kvm_main.c already have @kvm in scope.

Based on a proof-of-concept by Connor Williamson <connordw@amazon.com>.

Signed-off-by: David Woodhouse (Kiro) <dwmw@amazon.co.uk>
---
 arch/x86/kvm/Makefile    |   5 +-
 include/linux/kvm_host.h |  82 ++++++++++
 virt/kvm/guest_memfd.c   | 339 +++++++++++++++++++++++++++++++--------
 virt/kvm/kvm_main.c      |   8 +-
 virt/kvm/kvm_mm.h        |   4 +-
 5 files changed, 365 insertions(+), 73 deletions(-)

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 77337c37324b..36a319f382b7 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -63,7 +63,10 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
 				-e kvm_write_track_remove_gfn \
 				-e kvm_get_kvm \
 				-e kvm_get_kvm_safe \
-				-e kvm_put_kvm
+				-e kvm_put_kvm \
+				-e kvm_gmem_invalidate_range \
+				-e kvm_gmem_fops \
+				-e file_is_kvm
 
 # Force grep to emit a goofy group separator that can in turn be replaced with
 # the above newline macro (newlines in Make are a nightmare).  Note, grep only
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec82d3..b33d2f475042 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -621,6 +621,88 @@ static inline bool kvm_slot_has_gmem(const struct kvm_memory_slot *slot)
 	return slot && (slot->flags & KVM_MEM_GUEST_MEMFD);
 }
 
+#ifdef CONFIG_KVM_GUEST_MEMFD
+/*
+ * struct kvm_gmem_ops - vtable a guest_memfd backing implementation exposes.
+ *
+ * Every file that can back KVM guest memory -- KVM's own guest_memfd (see
+ * kvm_gmem_create()) and any other subsystem opting in -- is created with
+ * the shared kvm_gmem_fops (see is_kvm_gmem_file()).  file->private_data on
+ * such a file points at a struct kvm_gmem_backing whose ->ops field is the
+ * per-instance vtable below.  KVM never looks any further; the rest of the
+ * per-file state (allocator, refcount, private xarray, ...) is up to the
+ * implementation and is reached via container_of() from the backing.
+ *
+ * The memory-side callbacks (bind, unbind, get_pfn, populate, invalidate)
+ * are the reason the interface exists.  The file-level callbacks (release,
+ * mmap, fallocate, ...) are dispatched by kvm_gmem_fops so that every
+ * implementation gets a private hook -- see the dispatchers in
+ * virt/kvm/guest_memfd.c.
+ *
+ * get_pfn() contract:
+ *  - *pfn is the host PFN backing @gfn.  It need not have a struct page.
+ *  - *max_order is the largest order KVM may use to map starting at @gfn.
+ *    The implementation MUST clamp it to the physical contiguity and the
+ *    HPA/GPA alignment of the backing, so KVM never builds a huge SPTE that
+ *    spans discontiguous physical memory.
+ *  - If *page is non-NULL on return the caller owns that page reference and
+ *    is responsible for put_page() after use.  If *page is left NULL the PFN
+ *    is treated as non-refcounted, and its lifetime is owned by the
+ *    implementation across bind()/unbind().
+ *
+ * Memory intended to back guest RAM MUST be reported as E820_TYPE_RAM by the
+ * host so KVM maps it write-back (and applies the memory-encryption bit on
+ * encrypted hosts) rather than treating it as MMIO.
+ */
+struct kvm_gmem_ops {
+	/* Memory operations. */
+	int (*bind)(struct file *file, struct kvm *kvm,
+		    struct kvm_memory_slot *slot, loff_t offset);
+	void (*unbind)(struct file *file, struct kvm *kvm,
+		       struct kvm_memory_slot *slot);
+	int (*get_pfn)(struct file *file, struct kvm *kvm,
+		       struct kvm_memory_slot *slot, gfn_t gfn,
+		       kvm_pfn_t *pfn, struct page **page, int *max_order);
+	int (*populate)(struct file *file, struct kvm *kvm,
+			struct kvm_memory_slot *slot, gfn_t gfn,
+			kvm_pfn_t *pfn, struct page *src_page, int order);
+	void (*invalidate)(struct file *file, struct kvm *kvm,
+			   struct kvm_memory_slot *slot,
+			   gfn_t start, gfn_t end);
+
+	/*
+	 * File-level operations, dispatched by kvm_gmem_fops.  These are
+	 * per-instance analogues of the like-named file_operations members,
+	 * with the same semantics.  A NULL entry causes the dispatcher to
+	 * fail the file-level operation with an appropriate errno.
+	 */
+	void (*release)(struct file *file);
+	int (*mmap)(struct file *file, struct vm_area_struct *vma);
+	long (*fallocate)(struct file *file, int mode, loff_t offset,
+			  loff_t len);
+	long (*ioctl)(struct file *file, unsigned int cmd, unsigned long arg);
+};
+
+/*
+ * Anchor placed at file->private_data of every guest_memfd-backing file.
+ * KVM's own gmem embeds it as the first member of struct gmem_file; other
+ * implementations do the same in their own per-fd state.  is_kvm_gmem_file()
+ * (fops-identity check) proves the reinterpretation is safe.
+ */
+struct kvm_gmem_backing {
+	const struct kvm_gmem_ops *ops;
+};
+
+/* Defined in guest_memfd.c; single canonical fops for every gmem file. */
+extern struct file_operations kvm_gmem_fops;
+
+static inline bool is_kvm_gmem_file(struct file *file)
+{
+	return file && file->f_op == &kvm_gmem_fops;
+}
+
+#endif /* CONFIG_KVM_GUEST_MEMFD */
+
 static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
 {
 	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index db57c5766ab6..057f90eb835a 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -22,11 +22,22 @@ static struct vfsmount *kvm_gmem_mnt;
  * specific to its associated VM, e.g. memslots=>gmem bindings.
  */
 struct gmem_file {
+	/*
+	 * MUST be first: file->private_data points here.
+	 * is_kvm_gmem_file(file) proves this reinterpretation is safe.
+	 */
+	struct kvm_gmem_backing backing;
+
 	struct kvm *kvm;
 	struct xarray bindings;
 	struct list_head entry;
 };
 
+static inline struct gmem_file *gmem_file_of(struct file *file)
+{
+	return container_of(file->private_data, struct gmem_file, backing);
+}
+
 struct gmem_inode {
 	struct shared_policy policy;
 	struct inode vfs_inode;
@@ -296,7 +307,7 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 	return r;
 }
 
-static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
+static long kvm_gmem_native_fallocate(struct file *file, int mode, loff_t offset,
 			       loff_t len)
 {
 	int ret;
@@ -320,9 +331,10 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 	return ret;
 }
 
-static int kvm_gmem_release(struct inode *inode, struct file *file)
+static void kvm_gmem_native_release(struct file *file)
 {
-	struct gmem_file *f = file->private_data;
+	struct inode *inode = file_inode(file);
+	struct gmem_file *f = gmem_file_of(file);
 	struct kvm_memory_slot *slot;
 	struct kvm *kvm = f->kvm;
 	unsigned long index;
@@ -367,7 +379,6 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 
 	kvm_put_kvm(kvm);
 
-	return 0;
 }
 
 static inline struct file *kvm_gmem_get_file(struct kvm_memory_slot *slot)
@@ -466,7 +477,7 @@ static const struct vm_operations_struct kvm_gmem_vm_ops = {
 #endif
 };
 
-static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int kvm_gmem_native_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	if (!kvm_gmem_supports_mmap(file_inode(file)))
 		return -ENODEV;
@@ -481,12 +492,61 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
-static struct file_operations kvm_gmem_fops = {
-	.mmap		= kvm_gmem_mmap,
+/* File-op dispatchers — thin: they all go through the backing's ops table. */
+
+static int kvm_gmem_fops_release(struct inode *inode, struct file *file)
+{
+	struct kvm_gmem_backing *b = file->private_data;
+
+	if (b && b->ops && b->ops->release)
+		b->ops->release(file);
+	return 0;
+}
+
+static int kvm_gmem_fops_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct kvm_gmem_backing *b = file->private_data;
+
+	if (!b || !b->ops || !b->ops->mmap)
+		return -ENODEV;
+	return b->ops->mmap(file, vma);
+}
+
+static long kvm_gmem_fops_fallocate(struct file *file, int mode,
+				    loff_t offset, loff_t len)
+{
+	struct kvm_gmem_backing *b = file->private_data;
+
+	if (!b || !b->ops || !b->ops->fallocate)
+		return -EOPNOTSUPP;
+	return b->ops->fallocate(file, mode, offset, len);
+}
+
+static long kvm_gmem_fops_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg)
+{
+	struct kvm_gmem_backing *b = file->private_data;
+
+	if (!b || !b->ops || !b->ops->ioctl)
+		return -ENOTTY;
+	return b->ops->ioctl(file, cmd, arg);
+}
+
+/*
+ * A single struct file_operations for every guest_memfd-backing file --
+ * KVM's built-in gmem and any subsystem-supplied backing alike.  All
+ * callbacks that can vary per implementation dispatch through the
+ * kvm_gmem_backing at file->private_data.
+ */
+struct file_operations kvm_gmem_fops = {
 	.open		= generic_file_open,
-	.release	= kvm_gmem_release,
-	.fallocate	= kvm_gmem_fallocate,
+	.release	= kvm_gmem_fops_release,
+	.mmap		= kvm_gmem_fops_mmap,
+	.fallocate	= kvm_gmem_fops_fallocate,
+	.unlocked_ioctl	= kvm_gmem_fops_ioctl,
+	.compat_ioctl	= kvm_gmem_fops_ioctl,
 };
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_fops);
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
 				  struct folio *dst, struct folio *src,
@@ -557,6 +617,43 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return true;
 }
 
+static int  kvm_gmem_native_bind(struct file *file, struct kvm *kvm,
+				 struct kvm_memory_slot *slot, loff_t offset);
+static void kvm_gmem_native_unbind(struct file *slot_file, struct kvm *kvm,
+				   struct kvm_memory_slot *slot);
+static int  kvm_gmem_native_get_pfn(struct file *file, struct kvm *kvm,
+				    struct kvm_memory_slot *slot, gfn_t gfn,
+				    kvm_pfn_t *pfn, struct page **page,
+				    int *max_order);
+static void kvm_gmem_native_release(struct file *file);
+static int  kvm_gmem_native_mmap(struct file *file,
+				 struct vm_area_struct *vma);
+static long kvm_gmem_native_fallocate(struct file *file, int mode,
+				      loff_t offset, loff_t len);
+
+static const struct kvm_gmem_ops kvm_gmem_native_ops = {
+	/* Memory operations. */
+	.bind      = kvm_gmem_native_bind,
+	.unbind    = kvm_gmem_native_unbind,
+	.get_pfn   = kvm_gmem_native_get_pfn,
+	/*
+	 * .populate is deliberately NULL: kvm_gmem_populate() has an inline
+	 * fast path that drives post_populate() with the folio locked and
+	 * the memory-attribute check in the right place; that flow doesn't
+	 * fit the current ops signature cleanly.  Wiring it through ops
+	 * is a separate cleanup.
+	 *
+	 * .invalidate is deliberately NULL: invalidations for the built-in
+	 * implementation flow through inode->i_mapping (truncate, hwpoison,
+	 * free_folio) and don't need an out-of-band callback from KVM.
+	 */
+
+	/* File-level operations (dispatched by kvm_gmem_fops). */
+	.release   = kvm_gmem_native_release,
+	.mmap      = kvm_gmem_native_mmap,
+	.fallocate = kvm_gmem_native_fallocate,
+};
+
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
 	static const char *name = "[kvm-gmem]";
@@ -605,7 +702,8 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	}
 
 	file->f_flags |= O_LARGEFILE;
-	file->private_data = f;
+	file->private_data = &f->backing;
+	f->backing.ops = &kvm_gmem_native_ops;
 
 	kvm_get_kvm(kvm);
 	f->kvm = kvm;
@@ -640,34 +738,27 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	return __kvm_gmem_create(kvm, size, flags);
 }
 
-int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-		  unsigned int fd, uoff_t offset)
+static const struct kvm_gmem_ops *kvm_gmem_get_ops(struct file *file)
+{
+	if (!is_kvm_gmem_file(file))
+		return NULL;
+	return ((struct kvm_gmem_backing *)file->private_data)->ops;
+}
+
+static int kvm_gmem_native_bind(struct file *file, struct kvm *kvm,
+				struct kvm_memory_slot *slot, loff_t offset)
 {
 	uoff_t size = slot->npages << PAGE_SHIFT;
+	struct gmem_file *f = gmem_file_of(file);
+	struct inode *inode = file_inode(file);
 	unsigned long start, end;
-	struct gmem_file *f;
-	struct inode *inode;
-	struct file *file;
 	int r = -EINVAL;
 
-	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
-	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
-
-	file = fget(fd);
-	if (!file)
-		return -EBADF;
-
-	if (file->f_op != &kvm_gmem_fops)
-		goto err;
-
-	f = file->private_data;
 	if (f->kvm != kvm)
-		goto err;
-
-	inode = file_inode(file);
+		return -EINVAL;
 
-	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
-		goto err;
+	if (offset < 0 || !PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
+		return -EINVAL;
 
 	filemap_invalidate_lock(inode->i_mapping);
 
@@ -677,14 +768,13 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!xa_empty(&f->bindings) &&
 	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
 		r = -EEXIST;
-		filemap_invalidate_unlock(inode->i_mapping);
-		goto err;
+		goto out;
 	}
 
 	/*
-	 * memslots of flag KVM_MEM_GUEST_MEMFD are immutable to change, so
-	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
-	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
+	 * memslots of flag KVM_MEM_GUEST_MEMFD are immutable, so bind must
+	 * occur on a new memslot.  Because the memslot is not visible yet,
+	 * kvm_gmem_get_pfn() is guaranteed to see the file.
 	 */
 	WRITE_ONCE(slot->gmem.file, file);
 	slot->gmem.pgoff = start;
@@ -692,15 +782,51 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
 	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
+	r = 0;
+out:
 	filemap_invalidate_unlock(inode->i_mapping);
+	return r;
+}
+
+int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
+		  unsigned int fd, uoff_t offset)
+{
+	const struct kvm_gmem_ops *ops;
+	struct file *file;
+	int r;
+
+	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
+	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+
+	ops = kvm_gmem_get_ops(file);
+	if (!ops || !ops->bind || !ops->get_pfn) {
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (!PAGE_ALIGNED(offset)) {
+		r = -EINVAL;
+		goto out;
+	}
 
 	/*
-	 * Drop the reference to the file, even on success.  The file pins KVM,
-	 * not the other way 'round.  Active bindings are invalidated if the
-	 * file is closed before memslots are destroyed.
+	 * On success .bind() associates the fd with @kvm and (if the
+	 * implementation needs it) records the reference that makes the fd
+	 * pin the VM.  A .bind() that returns success is trusted to have
+	 * done so; there is no separate ownership check here.
+	 */
+	r = ops->bind(file, kvm, slot, offset);
+out:
+	/*
+	 * Drop the reference to the file even on success.  The file pins
+	 * KVM, not the other way 'round: it is the implementation's job to
+	 * invalidate its bindings if the fd is closed before the memslots
+	 * are destroyed.
 	 */
-	r = 0;
-err:
 	fput(file);
 	return r;
 }
@@ -719,21 +845,15 @@ static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct gmem_file *f)
 	WRITE_ONCE(slot->gmem.file, NULL);
 }
 
-void kvm_gmem_unbind(struct kvm_memory_slot *slot)
+static void kvm_gmem_native_unbind(struct file *slot_file, struct kvm *kvm,
+				   struct kvm_memory_slot *slot)
 {
-	/*
-	 * Nothing to do if the underlying file was _already_ closed, as
-	 * kvm_gmem_release() invalidates and nullifies all bindings.
-	 */
-	if (!slot->gmem.file)
-		return;
-
 	CLASS(gmem_get_file, file)(slot);
 
 	/*
-	 * However, if the file is _being_ closed, then the bindings need to be
-	 * removed as kvm_gmem_release() might not run until after the memslot
-	 * is freed.  Note, modifying the bindings is safe even though the file
+	 * If the file is _being_ closed, then the bindings need to be removed
+	 * as kvm_gmem_release() might not run until after the memslot is
+	 * freed.  Note, modifying the bindings is safe even though the file
 	 * is dying as kvm_gmem_release() nullifies slot->gmem.file under
 	 * slots_lock, and only puts its reference to KVM after destroying all
 	 * bindings.  I.e. reaching this point means kvm_gmem_release() hasn't
@@ -741,15 +861,41 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 	 * until the caller drops slots_lock.
 	 */
 	if (!file) {
-		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
+		__kvm_gmem_unbind(slot, gmem_file_of(slot_file));
 		return;
 	}
 
 	filemap_invalidate_lock(file->f_mapping);
-	__kvm_gmem_unbind(slot, file->private_data);
+	__kvm_gmem_unbind(slot, gmem_file_of(file));
 	filemap_invalidate_unlock(file->f_mapping);
 }
 
+void kvm_gmem_unbind(struct kvm *kvm, struct kvm_memory_slot *slot)
+{
+	const struct kvm_gmem_ops *ops;
+	struct file *file;
+
+	/*
+	 * Nothing to do if the underlying file was _already_ closed, as
+	 * kvm_gmem_release() invalidates and nullifies all bindings.
+	 */
+	file = READ_ONCE(slot->gmem.file);
+	if (!file)
+		return;
+
+	ops = kvm_gmem_get_ops(file);
+	if (ops && ops->unbind)
+		ops->unbind(file, kvm, slot);
+
+	/*
+	 * .unbind() may clear slot->gmem.file itself (as the built-in gmem
+	 * ops do, under filemap_invalidate_lock, to serialise against
+	 * release/invalidate); catch the ones that don't.
+	 */
+	if (READ_ONCE(slot->gmem.file))
+		WRITE_ONCE(slot->gmem.file, NULL);
+}
+
 /* Returns a locked folio on success.  */
 static struct folio *__kvm_gmem_get_pfn(struct file *file,
 					struct kvm_memory_slot *slot,
@@ -757,7 +903,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 					int *max_order)
 {
 	struct file *slot_file = READ_ONCE(slot->gmem.file);
-	struct gmem_file *f = file->private_data;
+	struct gmem_file *f = gmem_file_of(file);
 	struct folio *folio;
 
 	if (file != slot_file) {
@@ -787,17 +933,14 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 	return folio;
 }
 
-int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
-		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
-		     int *max_order)
+static int kvm_gmem_native_get_pfn(struct file *file, struct kvm *kvm,
+				   struct kvm_memory_slot *slot, gfn_t gfn,
+				   kvm_pfn_t *pfn, struct page **page,
+				   int *max_order)
 {
 	pgoff_t index = kvm_gmem_get_index(slot, gfn);
 	struct folio *folio;
-	int r = 0;
-
-	CLASS(gmem_get_file, file)(slot);
-	if (!file)
-		return -EFAULT;
+	int r;
 
 	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
 	if (IS_ERR(folio))
@@ -809,7 +952,6 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	}
 
 	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
-
 	folio_unlock(folio);
 
 	if (!r)
@@ -819,6 +961,24 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	return r;
 }
+
+int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
+		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
+		     int *max_order)
+{
+	const struct kvm_gmem_ops *ops;
+
+	CLASS(gmem_get_file, file)(slot);
+	if (!file)
+		return -EFAULT;
+
+	ops = kvm_gmem_get_ops(file);
+	if (!ops || !ops->get_pfn)
+		return -EFAULT;
+
+	*page = NULL;
+	return ops->get_pfn(file, kvm, slot, gfn, pfn, page, max_order);
+}
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
@@ -860,11 +1020,51 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return ret;
 }
 
+static int kvm_gmem_populate_one(const struct kvm_gmem_ops *ops,
+				      struct file *file, struct kvm *kvm,
+				      struct kvm_memory_slot *slot, gfn_t gfn,
+				      struct page *src_page,
+				      kvm_gmem_populate_cb post_populate,
+				      void *opaque)
+{
+	struct page *ignored_page = NULL;
+	kvm_pfn_t pfn;
+	int ret;
+
+	/*
+	 * Resolve the PFN via the ops.  A populate() op may also copy
+	 * @src_page into the backing before the arch post_populate() step
+	 * (e.g. SNP LAUNCH_UPDATE); otherwise fall back to get_pfn().
+	 */
+	if (ops->populate)
+		ret = ops->populate(file, kvm, slot, gfn, &pfn,
+				    src_page, 0);
+	else
+		ret = ops->get_pfn(file, kvm, slot, gfn, &pfn,
+				   &ignored_page, NULL);
+	if (ret)
+		return ret;
+
+	ret = post_populate(kvm, gfn, pfn, src_page, opaque);
+
+	/*
+	 * Populate does not consume a refcount on the destination page.
+	 * Drop @page (if any) AFTER post_populate() so the PFN cannot be
+	 * freed and reallocated behind an arch hook (e.g. RMPUPDATE) that
+	 * is still operating on it.
+	 */
+	if (ignored_page)
+		put_page(ignored_page);
+
+	return ret;
+}
+
 long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 		       long npages, bool may_writeback_src,
 		       kvm_gmem_populate_cb post_populate, void *opaque)
 {
 	struct kvm_memory_slot *slot;
+	const struct kvm_gmem_ops *ops;
 	int ret = 0;
 	long i;
 
@@ -884,6 +1084,8 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 	if (!file)
 		return -EFAULT;
 
+	ops = kvm_gmem_get_ops(file);
+
 	npages = min_t(ulong, slot->npages - (start_gfn - slot->base_gfn), npages);
 	for (i = 0; i < npages; i++) {
 		struct page *src_page = NULL;
@@ -906,8 +1108,13 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 			}
 		}
 
-		ret = __kvm_gmem_populate(kvm, slot, file, start_gfn + i, src_page,
-					  post_populate, opaque);
+		if (ops && (ops->populate || ops->get_pfn != kvm_gmem_native_get_pfn))
+			ret = kvm_gmem_populate_one(ops, file, kvm, slot,
+						    start_gfn + i, src_page,
+						    post_populate, opaque);
+		else
+			ret = __kvm_gmem_populate(kvm, slot, file, start_gfn + i,
+						  src_page, post_populate, opaque);
 
 		if (src_page)
 			put_page(src_page);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e44c20c04961..3af5270d2a90 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -935,7 +935,7 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
 static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 {
 	if (slot->flags & KVM_MEM_GUEST_MEMFD)
-		kvm_gmem_unbind(slot);
+		kvm_gmem_unbind(kvm, slot);
 
 	kvm_destroy_dirty_bitmap(slot);
 
@@ -1747,7 +1747,7 @@ static void kvm_commit_memory_region(struct kvm *kvm,
 		 * flags-only changes on guest_memfd slots should be impossible.
 		 */
 		if (WARN_ON_ONCE(old->flags & KVM_MEM_GUEST_MEMFD))
-			kvm_gmem_unbind(old);
+			kvm_gmem_unbind(kvm, old);
 
 		/*
 		 * The final quirk.  Free the detached, old slot, but only its
@@ -2118,7 +2118,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 
 out_unbind:
 	if (mem->flags & KVM_MEM_GUEST_MEMFD)
-		kvm_gmem_unbind(new);
+		kvm_gmem_unbind(kvm, new);
 out:
 	kfree(new);
 	return r;
@@ -5475,7 +5475,7 @@ bool file_is_kvm(struct file *file)
 {
 	return file && file->f_op == &kvm_vm_fops;
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
+EXPORT_SYMBOL_GPL(file_is_kvm);
 
 static int kvm_dev_ioctl_create_vm(unsigned long type)
 {
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 7510ca915dd1..ea0fe74e89d4 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -76,7 +76,7 @@ void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, uoff_t offset);
-void kvm_gmem_unbind(struct kvm_memory_slot *slot);
+void kvm_gmem_unbind(struct kvm *kvm, struct kvm_memory_slot *slot);
 #else
 static inline int kvm_gmem_init(struct module *module)
 {
@@ -91,7 +91,7 @@ static inline int kvm_gmem_bind(struct kvm *kvm,
 	return -EIO;
 }
 
-static inline void kvm_gmem_unbind(struct kvm_memory_slot *slot)
+static inline void kvm_gmem_unbind(struct kvm *kvm, struct kvm_memory_slot *slot)
 {
 	WARN_ON_ONCE(1);
 }
-- 
2.55.0

