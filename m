Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C171CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 10:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E91310E0AD;
	Fri, 15 May 2026 10:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lIRNxy1R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C242C10E0AD
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 10:27:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F0E0403A9;
 Fri, 15 May 2026 10:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76B9C2BCB0;
 Fri, 15 May 2026 10:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1778840866;
 bh=5A2DKQjB4f+sBTnsBZEJX4rbKHgDUzOVgHBdIqUnUMw=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=lIRNxy1RgqkibnSSyWfFCRVn7yMaDxN03Dsb7ZPrGdoW8mxLGgMA0xpc9D7Bv+pk/
 OsD7TRYUlBCWJx2tFqUeXcSCN56CvZwSWJmbPQE2U6t5r34hgI5aMliO8ruuKJl3mM
 ELkBeytfZ9fa2uPFJylmbACo7aGbBpowLJRpAwsc=
Subject: Patch "fbdev: defio: Disconnect deferred I/O from the lifetime of
 struct fb_info" has been added to the 6.6-stable tree
To: deller@gmx.de, dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 sashal@kernel.org, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 12:27:35 +0200
In-Reply-To: <20260505060001.225157-1-sashal@kernel.org>
Message-ID: <2026051535-directed-catsup-7101@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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


This is a note to let you know that I've just added the patch titled

    fbdev: defio: Disconnect deferred I/O from the lifetime of struct fb_info

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     fbdev-defio-disconnect-deferred-i-o-from-the-lifetime-of-struct-fb_info.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-243987-greg=kroah.com@vger.kernel.org Tue May  5 08:00:14 2026
From: Sasha Levin <sashal@kernel.org>
Date: Tue,  5 May 2026 02:00:00 -0400
Subject: fbdev: defio: Disconnect deferred I/O from the lifetime of struct fb_info
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>
Message-ID: <20260505060001.225157-1-sashal@kernel.org>

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 9ded47ad003f09a94b6a710b5c47f4aa5ceb7429 ]

Hold state of deferred I/O in struct fb_deferred_io_state. Allocate an
instance as part of initializing deferred I/O and remove it only after
the final mapping has been closed. If the fb_info and the contained
deferred I/O meanwhile goes away, clear struct fb_deferred_io_state.info
to invalidate the mapping. Any access will then result in a SIGBUS
signal.

Fixes a long-standing problem, where a device hot-unplug happens while
user space still has an active mapping of the graphics memory. The hot-
unplug frees the instance of struct fb_info. Accessing the memory will
operate on undefined state.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 60b59beafba8 ("fbdev: mm: Deferred IO support")
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org # v2.6.22+
Signed-off-by: Helge Deller <deller@gmx.de>
[ replaced `kzalloc_obj` with `kzalloc`, and dropped `mutex_destroy(&fbdefio->lock)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fb_defio.c |  179 ++++++++++++++++++++++++++++--------
 include/linux/fb.h                  |    4 
 2 files changed, 145 insertions(+), 38 deletions(-)

--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -23,6 +23,75 @@
 #include <linux/rmap.h>
 #include <linux/pagemap.h>
 
+/*
+ * struct fb_deferred_io_state
+ */
+
+struct fb_deferred_io_state {
+	struct kref ref;
+
+	struct mutex lock; /* mutex that protects the pageref list */
+	/* fields protected by lock */
+	struct fb_info *info;
+};
+
+static struct fb_deferred_io_state *fb_deferred_io_state_alloc(void)
+{
+	struct fb_deferred_io_state *fbdefio_state;
+
+	fbdefio_state = kzalloc(sizeof(*fbdefio_state), GFP_KERNEL);
+	if (!fbdefio_state)
+		return NULL;
+
+	kref_init(&fbdefio_state->ref);
+	mutex_init(&fbdefio_state->lock);
+
+	return fbdefio_state;
+}
+
+static void fb_deferred_io_state_release(struct fb_deferred_io_state *fbdefio_state)
+{
+	mutex_destroy(&fbdefio_state->lock);
+
+	kfree(fbdefio_state);
+}
+
+static void fb_deferred_io_state_get(struct fb_deferred_io_state *fbdefio_state)
+{
+	kref_get(&fbdefio_state->ref);
+}
+
+static void __fb_deferred_io_state_release(struct kref *ref)
+{
+	struct fb_deferred_io_state *fbdefio_state =
+		container_of(ref, struct fb_deferred_io_state, ref);
+
+	fb_deferred_io_state_release(fbdefio_state);
+}
+
+static void fb_deferred_io_state_put(struct fb_deferred_io_state *fbdefio_state)
+{
+	kref_put(&fbdefio_state->ref, __fb_deferred_io_state_release);
+}
+
+/*
+ * struct vm_operations_struct
+ */
+
+static void fb_deferred_io_vm_open(struct vm_area_struct *vma)
+{
+	struct fb_deferred_io_state *fbdefio_state = vma->vm_private_data;
+
+	fb_deferred_io_state_get(fbdefio_state);
+}
+
+static void fb_deferred_io_vm_close(struct vm_area_struct *vma)
+{
+	struct fb_deferred_io_state *fbdefio_state = vma->vm_private_data;
+
+	fb_deferred_io_state_put(fbdefio_state);
+}
+
 static struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs)
 {
 	void *screen_base = (void __force *) info->screen_base;
@@ -93,17 +162,31 @@ static void fb_deferred_io_pageref_put(s
 /* this is to find and return the vmalloc-ed fb pages */
 static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 {
+	struct fb_info *info;
 	unsigned long offset;
 	struct page *page;
-	struct fb_info *info = vmf->vma->vm_private_data;
+	vm_fault_t ret;
+	struct fb_deferred_io_state *fbdefio_state = vmf->vma->vm_private_data;
+
+	mutex_lock(&fbdefio_state->lock);
+
+	info = fbdefio_state->info;
+	if (!info) {
+		ret = VM_FAULT_SIGBUS; /* our device is gone */
+		goto err_mutex_unlock;
+	}
 
 	offset = vmf->pgoff << PAGE_SHIFT;
-	if (offset >= info->fix.smem_len)
-		return VM_FAULT_SIGBUS;
+	if (offset >= info->fix.smem_len) {
+		ret = VM_FAULT_SIGBUS;
+		goto err_mutex_unlock;
+	}
 
 	page = fb_deferred_io_page(info, offset);
-	if (!page)
-		return VM_FAULT_SIGBUS;
+	if (!page) {
+		ret = VM_FAULT_SIGBUS;
+		goto err_mutex_unlock;
+	}
 
 	get_page(page);
 
@@ -115,8 +198,15 @@ static vm_fault_t fb_deferred_io_fault(s
 	BUG_ON(!page->mapping);
 	page->index = vmf->pgoff; /* for page_mkclean() */
 
+	mutex_unlock(&fbdefio_state->lock);
+
 	vmf->page = page;
+
 	return 0;
+
+err_mutex_unlock:
+	mutex_unlock(&fbdefio_state->lock);
+	return ret;
 }
 
 int fb_deferred_io_fsync(struct file *file, loff_t start, loff_t end, int datasync)
@@ -143,15 +233,24 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
  * Adds a page to the dirty list. Call this from struct
  * vm_operations_struct.page_mkwrite.
  */
-static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long offset,
-					    struct page *page)
+static vm_fault_t fb_deferred_io_track_page(struct fb_deferred_io_state *fbdefio_state,
+					    unsigned long offset, struct page *page)
 {
-	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_info *info;
+	struct fb_deferred_io *fbdefio;
 	struct fb_deferred_io_pageref *pageref;
 	vm_fault_t ret;
 
 	/* protect against the workqueue changing the page list */
-	mutex_lock(&fbdefio->lock);
+	mutex_lock(&fbdefio_state->lock);
+
+	info = fbdefio_state->info;
+	if (!info) {
+		ret = VM_FAULT_SIGBUS; /* our device is gone */
+		goto err_mutex_unlock;
+	}
+
+	fbdefio = info->fbdefio;
 
 	pageref = fb_deferred_io_pageref_get(info, offset, page);
 	if (WARN_ON_ONCE(!pageref)) {
@@ -169,50 +268,38 @@ static vm_fault_t fb_deferred_io_track_p
 	 */
 	lock_page(pageref->page);
 
-	mutex_unlock(&fbdefio->lock);
+	mutex_unlock(&fbdefio_state->lock);
 
 	/* come back after delay to process the deferred IO */
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
 	return VM_FAULT_LOCKED;
 
 err_mutex_unlock:
-	mutex_unlock(&fbdefio->lock);
+	mutex_unlock(&fbdefio_state->lock);
 	return ret;
 }
 
-/*
- * fb_deferred_io_page_mkwrite - Mark a page as written for deferred I/O
- * @fb_info: The fbdev info structure
- * @vmf: The VM fault
- *
- * This is a callback we get when userspace first tries to
- * write to the page. We schedule a workqueue. That workqueue
- * will eventually mkclean the touched pages and execute the
- * deferred framebuffer IO. Then if userspace touches a page
- * again, we repeat the same scheme.
- *
- * Returns:
- * VM_FAULT_LOCKED on success, or a VM_FAULT error otherwise.
- */
-static vm_fault_t fb_deferred_io_page_mkwrite(struct fb_info *info, struct vm_fault *vmf)
+static vm_fault_t fb_deferred_io_page_mkwrite(struct fb_deferred_io_state *fbdefio_state,
+					      struct vm_fault *vmf)
 {
 	unsigned long offset = vmf->pgoff << PAGE_SHIFT;
 	struct page *page = vmf->page;
 
 	file_update_time(vmf->vma->vm_file);
 
-	return fb_deferred_io_track_page(info, offset, page);
+	return fb_deferred_io_track_page(fbdefio_state, offset, page);
 }
 
-/* vm_ops->page_mkwrite handler */
 static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 {
-	struct fb_info *info = vmf->vma->vm_private_data;
+	struct fb_deferred_io_state *fbdefio_state = vmf->vma->vm_private_data;
 
-	return fb_deferred_io_page_mkwrite(info, vmf);
+	return fb_deferred_io_page_mkwrite(fbdefio_state, vmf);
 }
 
 static const struct vm_operations_struct fb_deferred_io_vm_ops = {
+	.open		= fb_deferred_io_vm_open,
+	.close		= fb_deferred_io_vm_close,
 	.fault		= fb_deferred_io_fault,
 	.page_mkwrite	= fb_deferred_io_mkwrite,
 };
@@ -227,7 +314,10 @@ int fb_deferred_io_mmap(struct fb_info *
 	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
 	if (!(info->flags & FBINFO_VIRTFB))
 		vm_flags_set(vma, VM_IO);
-	vma->vm_private_data = info;
+	vma->vm_private_data = info->fbdefio_state;
+
+	fb_deferred_io_state_get(info->fbdefio_state); /* released in vma->vm_ops->close() */
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_mmap);
@@ -238,9 +328,10 @@ static void fb_deferred_io_work(struct w
 	struct fb_info *info = container_of(work, struct fb_info, deferred_work.work);
 	struct fb_deferred_io_pageref *pageref, *next;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state = info->fbdefio_state;
 
 	/* here we mkclean the pages, then do all deferred IO */
-	mutex_lock(&fbdefio->lock);
+	mutex_lock(&fbdefio_state->lock);
 	list_for_each_entry(pageref, &fbdefio->pagereflist, list) {
 		struct page *cur = pageref->page;
 		lock_page(cur);
@@ -255,12 +346,13 @@ static void fb_deferred_io_work(struct w
 	list_for_each_entry_safe(pageref, next, &fbdefio->pagereflist, list)
 		fb_deferred_io_pageref_put(pageref, info);
 
-	mutex_unlock(&fbdefio->lock);
+	mutex_unlock(&fbdefio_state->lock);
 }
 
 int fb_deferred_io_init(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state;
 	struct fb_deferred_io_pageref *pagerefs;
 	unsigned long npagerefs, i;
 	int ret;
@@ -270,7 +362,11 @@ int fb_deferred_io_init(struct fb_info *
 	if (WARN_ON(!info->fix.smem_len))
 		return -EINVAL;
 
-	mutex_init(&fbdefio->lock);
+	fbdefio_state = fb_deferred_io_state_alloc();
+	if (!fbdefio_state)
+		return -ENOMEM;
+	fbdefio_state->info = info;
+
 	INIT_DELAYED_WORK(&info->deferred_work, fb_deferred_io_work);
 	INIT_LIST_HEAD(&fbdefio->pagereflist);
 	if (fbdefio->delay == 0) /* set a default of 1 s */
@@ -289,10 +385,12 @@ int fb_deferred_io_init(struct fb_info *
 	info->npagerefs = npagerefs;
 	info->pagerefs = pagerefs;
 
+	info->fbdefio_state = fbdefio_state;
+
 	return 0;
 
 err:
-	mutex_destroy(&fbdefio->lock);
+	fb_deferred_io_state_release(fbdefio_state);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_init);
@@ -333,11 +431,18 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_release
 
 void fb_deferred_io_cleanup(struct fb_info *info)
 {
-	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state = info->fbdefio_state;
 
 	fb_deferred_io_lastclose(info);
 
+	info->fbdefio_state = NULL;
+
+	mutex_lock(&fbdefio_state->lock);
+	fbdefio_state->info = NULL;
+	mutex_unlock(&fbdefio_state->lock);
+
+	fb_deferred_io_state_put(fbdefio_state);
+
 	kvfree(info->pagerefs);
-	mutex_destroy(&fbdefio->lock);
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -214,11 +214,12 @@ struct fb_deferred_io {
 	unsigned long delay;
 	bool sort_pagereflist; /* sort pagelist by offset */
 	int open_count; /* number of opened files; protected by fb_info lock */
-	struct mutex lock; /* mutex that protects the pageref list */
 	struct list_head pagereflist; /* list of pagerefs for touched pages */
 	/* callback */
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
 };
+
+struct fb_deferred_io_state;
 #endif
 
 /*
@@ -476,6 +477,7 @@ struct fb_info {
 	unsigned long npagerefs;
 	struct fb_deferred_io_pageref *pagerefs;
 	struct fb_deferred_io *fbdefio;
+	struct fb_deferred_io_state *fbdefio_state;
 #endif
 
 	const struct fb_ops *fbops;


Patches currently in stable-queue which might be from sashal@kernel.org are

queue-6.6/ksmbd-reset-rcount-per-connection-in-ksmbd_conn_wait_idle_sess_id.patch
queue-6.6/dmaengine-idxd-fix-crash-when-the-event-log-is-disab.patch
queue-6.6/bpf-don-t-mark-stack_invalid-as-stack_misc-in-mark_s.patch
queue-6.6/wifi-mt76-connac-introduce-helper-for-mt7925-chipset.patch
queue-6.6/wifi-mt76-mt792x-describe-usb-wfsys-reset-with-a-descriptor.patch
queue-6.6/mmc-core-optimize-time-for-secure-erase-trim-for-some-kingston-emmcs.patch
queue-6.6/ksmbd-replace-connection-list-with-hash-table.patch
queue-6.6/selftests-bpf-validate-fake-register-spill-fill-prec.patch
queue-6.6/block-relax-pgmap-check-in-bio_add_page-for-compatible-zone-device-pages.patch
queue-6.6/wifi-rtl8xxxu-fix-potential-use-of-uninitialized-value.patch
queue-6.6/x86-shadow-stacks-proper-error-handling-for-mmap-loc.patch
queue-6.6/ksmbd-use-msleep-instaed-of-schedule_timeout_interruptible.patch
queue-6.6/net-txgbe-fix-rtnl-assertion-warning-when-remove-mod.patch
queue-6.6/bluetooth-mgmt-fix-possible-uafs.patch
queue-6.6/net-qrtr-ns-limit-the-total-number-of-nodes.patch
queue-6.6/bpf-handle-fake-register-spill-to-stack-with-bpf_st_.patch
queue-6.6/io_uring-poll-fix-multishot-recv-missing-eof-on-wake.patch
queue-6.6/drm-amdgpu-use-vmemdup_array_user-in-amdgpu_bo_creat.patch
queue-6.6/arm64-mm-enable-batched-tlb-flush-in-unmap_hotplug_range.patch
queue-6.6/smb-common-change-the-data-type-of-num_aces-to-le16.patch
queue-6.6/mtd-docg3-convert-to-platform-remove-callback-return.patch
queue-6.6/f2fs-fix-uaf-caused-by-decrementing-sbi-nr_pages-in-f2fs_write_end_io.patch
queue-6.6/iommu-amd-use-atomic64_inc_return-in-iommu.c.patch
queue-6.6/wifi-mwifiex-fix-use-after-free-in-mwifiex_adapter_cleanup.patch
queue-6.6/f2fs-fix-to-detect-potential-corrupted-nid-in-free_n.patch
queue-6.6/selftests-bpf-validate-precision-logic-in-partial_st.patch
queue-6.6/rxrpc-fix-rxrpc_input_call_event-to-only-unshare-dat.patch
queue-6.6/regset-use-kvzalloc-for-regset_get_alloc.patch
queue-6.6/pci-epf-mhi-return-0-not-remaining-timeout-when-edma-ops-complete.patch
queue-6.6/spi-meson-spicc-fix-double-put-in-remove-path.patch
queue-6.6/net-fix-icmp-host-relookup-triggering-ip_rt_bug.patch
queue-6.6/alsa-aoa-use-guard-for-mutex-locks.patch
queue-6.6/udf-fix-partition-descriptor-append-bookkeeping.patch
queue-6.6/lib-test_hmm-evict-device-pages-on-file-close-to-avoid-use-after-free.patch
queue-6.6/kvm-x86-fix-shadow-paging-use-after-free-due-to-unex.patch
queue-6.6/bpf-preserve-stack_zero-slots-on-partial-reg-spills.patch
queue-6.6/driver-core-don-t-let-a-device-probe-until-it-s-read.patch
queue-6.6/hfsplus-fix-uninit-value-by-validating-catalog-record-size.patch
queue-6.6/selftests-bpf-validate-zero-preservation-for-sub-slo.patch
queue-6.6/bpf-preserve-constant-zero-when-doing-partial-regist.patch
queue-6.6/smb-move-some-duplicate-definitions-to-common-smbacl.h.patch
queue-6.6/alsa-aoa-i2sbus-clear-stale-prepared-state.patch
queue-6.6/padata-fix-pd-uaf-once-and-for-all.patch
queue-6.6/drm-amdgpu-limit-bo-list-entry-count-to-prevent-reso.patch
queue-6.6/net-mctp-fix-don-t-require-received-header-reserved-bits-to-be-zero.patch
queue-6.6/media-rc-ttusbir-respect-dma-coherency-rules.patch
queue-6.6/f2fs-fix-to-do-sanity-check-on-dcc-discard_cmd_cnt-conditionally.patch
queue-6.6/hfsplus-fix-held-lock-freed-on-hfsplus_fill_super.patch
queue-6.6/spi-fix-resource-leaks-on-device-setup-failure.patch
queue-6.6/selftests-bpf-add-stack-access-precision-test.patch
queue-6.6/bpf-track-aligned-stack_zero-cases-as-imprecise-spil.patch
queue-6.6/mtd-docg3-fix-use-after-free-in-docg3_release.patch
queue-6.6/smb-client-validate-the-whole-dacl-before-rewriting-it-in-cifsacl.patch
queue-6.6/sched-use-u64-for-bandwidth-ratio-calculations.patch
queue-6.6/flow_dissector-do-not-dissect-pppoe-pfc-frames.patch
queue-6.6/padata-remove-comment-for-reorder_work.patch
queue-6.6/fbdev-defio-disconnect-deferred-i-o-from-the-lifetime-of-struct-fb_info.patch
queue-6.6/dmaengine-idxd-fix-leaking-event-log-memory.patch
queue-6.6/selftests-bpf-validate-stack_zero-is-preserved-on-su.patch
queue-6.6/net-qrtr-ns-limit-the-maximum-number-of-lookups.patch
queue-6.6/iommu-amd-serialize-sequence-allocation-under-concur.patch
queue-6.6/alsa-aoa-skip-devices-with-no-codecs-in-i2sbus_resume.patch
queue-6.6/loongarch-add-spectre-boundry-for-syscall-dispatch-t.patch
queue-6.6/net-bridge-use-a-stable-fdb-dst-snapshot-in-rcu-readers.patch
queue-6.6/x86-shstk-prevent-deadlock-during-shstk-sigreturn.patch
queue-6.6/rdma-mana_ib-disable-rx-steering-on-rss-qp-destroy.patch
queue-6.6/xfs-fix-a-resource-leak-in-xfs_alloc_buftarg.patch
queue-6.6/thermal-core-fix-thermal-zone-governor-cleanup-issues.patch
queue-6.6/drm-amd-display-do-not-skip-unrelated-mode-changes-i.patch
queue-6.6/wifi-mt76-mt792x-fix-mt7925u-usb-wfsys-reset-handling.patch
queue-6.6/net-qrtr-ns-limit-the-maximum-server-registration-per-node.patch
queue-6.6/ext4-validate-p_idx-bounds-in-ext4_ext_correct_index.patch
queue-6.6/bpf-support-non-r10-register-spill-fill-to-from-stac.patch
queue-6.6/rxrpc-fix-potential-uaf-after-skb_unshare-failure.patch
queue-6.6/firmware-google-framebuffer-do-not-unregister-platform-device.patch
queue-6.6/ksmbd-require-minimum-ace-size-in-smb_check_perm_dacl.patch
queue-6.6/media-rc-igorplugusb-heed-coherency-rules.patch
