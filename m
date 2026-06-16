Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DED7CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F1510E810;
	Tue, 16 Jun 2026 05:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guvmiXiR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789AD10E810
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 05:18:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F74F60137;
 Tue, 16 Jun 2026 05:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144081F000E9;
 Tue, 16 Jun 2026 05:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1781587085;
 bh=WlBHYVyJHRmSAFXFvIbs5rLAaFcIwVszqDUGkbg7c6o=;
 h=Subject:To:Cc:From:Date:In-Reply-To;
 b=guvmiXiR4bALOvPox6yjZvTsLzkE/WrATKd7qe4r8SR2ovDiqHxC98iHMNswVrQ25
 VUsmT73A4lcap1B4Eh6PiioTFOeL8BbsFPzFm2yXPi/G27g/zdqZ1R/b6j4W+wn4tn
 X3aJFCe0A/k+Uq9r3IqLgWbb6hu8bn8ARTaLvooQ=
Subject: Patch "fbdev: defio: Disconnect deferred I/O from the lifetime of
 struct fb_info" has been added to the 6.1-stable tree
To: deller@gmx.de, dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 sashal@kernel.org, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Jun 2026 10:46:29 +0530
In-Reply-To: <20260505073129.414475-1-sashal@kernel.org>
Message-ID: <2026061629-replica-prison-7e07@gregkh>
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

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     fbdev-defio-disconnect-deferred-i-o-from-the-lifetime-of-struct-fb_info.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-244001-greg=kroah.com@vger.kernel.org Tue May  5 13:03:20 2026
From: Sasha Levin <sashal@kernel.org>
Date: Tue,  5 May 2026 03:31:29 -0400
Subject: fbdev: defio: Disconnect deferred I/O from the lifetime of struct fb_info
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>
Message-ID: <20260505073129.414475-1-sashal@kernel.org>

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
[ context + _obj() conversion ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fb_defio.c |  164 +++++++++++++++++++++++++++++++-----
 include/linux/fb.h                  |    4 
 2 files changed, 145 insertions(+), 23 deletions(-)

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
 
 	/* first write in this cycle, notify the driver */
 	if (fbdefio->first_io && list_empty(&fbdefio->pagereflist))
@@ -173,14 +272,14 @@ static vm_fault_t fb_deferred_io_track_p
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
 
@@ -198,25 +297,28 @@ err_mutex_unlock:
  * Returns:
  * VM_FAULT_LOCKED on success, or a VM_FAULT error otherwise.
  */
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
 
 /* vm_ops->page_mkwrite handler */
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
@@ -231,7 +333,10 @@ int fb_deferred_io_mmap(struct fb_info *
 	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
 	if (!(info->flags & FBINFO_VIRTFB))
 		vma->vm_flags |= VM_IO;
-	vma->vm_private_data = info;
+	vma->vm_private_data = info->fbdefio_state;
+
+	fb_deferred_io_state_get(info->fbdefio_state); /* released in vma->vm_ops->close() */
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_mmap);
@@ -242,9 +347,10 @@ static void fb_deferred_io_work(struct w
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
@@ -259,12 +365,13 @@ static void fb_deferred_io_work(struct w
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
@@ -274,7 +381,11 @@ int fb_deferred_io_init(struct fb_info *
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
@@ -293,10 +404,12 @@ int fb_deferred_io_init(struct fb_info *
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
@@ -337,11 +450,18 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_release
 
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
@@ -213,12 +213,13 @@ struct fb_deferred_io {
 	unsigned long delay;
 	bool sort_pagereflist; /* sort pagelist by offset */
 	int open_count; /* number of opened files; protected by fb_info lock */
-	struct mutex lock; /* mutex that protects the pageref list */
 	struct list_head pagereflist; /* list of pagerefs for touched pages */
 	/* callback */
 	void (*first_io)(struct fb_info *info);
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
 };
+
+struct fb_deferred_io_state;
 #endif
 
 /*
@@ -479,6 +480,7 @@ struct fb_info {
 	unsigned long npagerefs;
 	struct fb_deferred_io_pageref *pagerefs;
 	struct fb_deferred_io *fbdefio;
+	struct fb_deferred_io_state *fbdefio_state;
 #endif
 
 	const struct fb_ops *fbops;


Patches currently in stable-queue which might be from sashal@kernel.org are

queue-6.1/f2fs-use-kfree-instead-of-kvfree-to-free-some-memory.patch
queue-6.1/hwmon-pmbus-adm1266-serialize-gpio-pmbus-accesses-wi.patch
queue-6.1/bonding-refuse-to-enslave-can-devices.patch
queue-6.1/asoc-intel-bytcht_es8316-fix-mclk-leak-on-init-error.patch
queue-6.1/asoc-codecs-simple-mux-fix-enum-control-bounds-check.patch
queue-6.1/selftests-bpf-add-read_build_id-function.patch
queue-6.1/smb-client-validate-the-whole-dacl-before-rewriting-it-in-cifsacl.patch
queue-6.1/rdma-rxe-complete-the-rxe_cleanup_task-backport.patch
queue-6.1/bluetooth-l2cap-fix-possible-crash-on-l2cap_ecred_co.patch
queue-6.1/ipv6-sit-reload-inner-ipv6-header-after-gso-offloads.patch
queue-6.1/ethtool-eeprom-add-more-safeties-to-eeprom-netlink-f.patch
queue-6.1/vxlan-vnifilter-fix-spurious-notification-on-vni-upd.patch
queue-6.1/6lowpan-fix-off-by-one-in-multicast-context-address-.patch
queue-6.1/sctp-fix-race-between-sctp_wait_for_connect-and-peel.patch
queue-6.1/pcnet32-stop-holding-device-spin-lock-during-napi_co.patch
queue-6.1/drm-vc4-fix-krealloc-memory-leak.patch
queue-6.1/f2fs-fix-to-do-sanity-check-on-dcc-discard_cmd_cnt-conditionally.patch
queue-6.1/arm64-tlb-optimize-arm64_workaround_repeat_tlbi.patch
queue-6.1/nfc-llcp-fix-use-after-free-race-in-nfc_llcp_recv_cc.patch
queue-6.1/revert-selftests-bpf-workaround-strict-bpf_lsm-retur.patch
queue-6.1/net-netlink-fix-sending-unassigned-nsid-after-assign.patch
queue-6.1/bluetooth-bnep-reject-short-frames-before-parsing.patch
queue-6.1/net-packet-convert-po-has_vnet_hdr-to-an-atomic-flag.patch
queue-6.1/net-qrtr-ns-free-the-node-during-ctrl_cmd_bye.patch
queue-6.1/dm-cache-policy-smq-check-allocation-under-invalidat.patch
queue-6.1/ipmi-fix-rcu_read_unlock-to-srcu_read_unlock-in-hand.patch
queue-6.1/drm-i915-psr-read-intel-dpcd-workaround-register.patch
queue-6.1/net-fec-fix-pinctrl-default-state-restore-order-on-r.patch
queue-6.1/ipv6-rpl-fix-hdrlen-overflow-in-ipv6_rpl_srh_decompr.patch
queue-6.1/net-gro-don-t-merge-zcopy-skbs.patch
queue-6.1/ieee802154-6lowpan-only-accept-ipv6-packets-in-lowpa.patch
queue-6.1/tun-free-page-on-short-frame-rejection-in-tun_xdp_on.patch
queue-6.1/usb-serial-mct_u232-fix-memory-corruption-with-small.patch
queue-6.1/bluetooth-bnep-fix-incorrect-length-parsing-in-bnep_.patch
queue-6.1/signal-clear-jobctl_pending_mask-for-caller-in-zap_o.patch
queue-6.1/loongarch-add-spectre-boundry-for-syscall-dispatch-table.patch
queue-6.1/alsa-aoa-i2sbus-clear-stale-prepared-state.patch
queue-6.1/sched-use-u64-for-bandwidth-ratio-calculations.patch
queue-6.1/revert-rdma-rxe-fix-double-free-in-rxe_srq_from_init.patch
queue-6.1/net-qrtr-fix-refcount-saturation-and-potential-uaf-i.patch
queue-6.1/media-rc-igorplugusb-heed-coherency-rules.patch
queue-6.1/bpf-free-reuseport-cbpf-prog-after-rcu-grace-period.patch
queue-6.1/net-qrtr-ns-change-servers-radix-tree-to-xarray.patch
queue-6.1/net-mctp-ensure-our-nlmsg-responses-are-initialised.patch
queue-6.1/media-rc-ttusbir-respect-dma-coherency-rules.patch
queue-6.1/batman-adv-tt-fix-toctou-race-for-reported-vlans.patch
queue-6.1/ptp-vclock-switch-from-rcu-to-srcu.patch
queue-6.1/time-fix-off-by-one-in-settimeofday-usec-validation.patch
queue-6.1/usb-serial-cypress_m8-fix-memory-corruption-with-sma.patch
queue-6.1/xfrm-policy-fix-use-after-free-on-inexact-bin-in-xfr.patch
queue-6.1/tools-bootconfig-cleanup-bootconfig-footer-size-calc.patch
queue-6.1/netlabel-validate-unlabeled-address-and-mask-attribu.patch
queue-6.1/batman-adv-tt-avoid-empty-vlan-responses.patch
queue-6.1/net-hsr-fix-potential-oob-access-in-supervision-fram.patch
queue-6.1/drm-remove-plane-hsub-vsub-alignment-requirement-for.patch
queue-6.1/net-qrtr-ns-limit-the-total-number-of-nodes.patch
queue-6.1/selftests-bpf-convert-test_global_funcs-test-to-test.patch
queue-6.1/serial-dz-fix-bootconsole-handover-lockup.patch
queue-6.1/net-sched-revert-net-sched-restrict-conditions-for-a.patch
queue-6.1/net-packet-convert-po-tp_loss-to-an-atomic-flag.patch
queue-6.1/mm-hugetlb-avoid-false-positive-lockdep-assertion.patch
queue-6.1/drm-i915-psr-add-defininitions-for-intel_wa_register.patch
queue-6.1/revert-selftests-bpf-add-a-cgroup-prog-bpf_get_ns_cu.patch
queue-6.1/net-mvpp2-limit-xdp-frame-size-to-the-rx-buffer.patch
queue-6.1/bpf-fix-a-few-selftest-failures-due-to-llvm18-change.patch
queue-6.1/vxlan-do-not-reuse-cached-ip_hdr-value-after-skb_tun.patch
queue-6.1/net-guard-timestamp-cmsgs-to-real-error-queue-skbs.patch
queue-6.1/batman-adv-tvlv-reject-oversized-tvlv-packets.patch
queue-6.1/r8152-block-future-register-access-if-register-acces.patch
queue-6.1/net-mvpp2-add-metadata-support-for-xdp-mode.patch
queue-6.1/net-packet-convert-po-tp_tx_has_off-to-an-atomic-fla.patch
queue-6.1/net-mctp-fix-don-t-require-received-header-reserved-bits-to-be-zero.patch
queue-6.1/xfrm-check-for-underflow-in-xfrm_state_mtu.patch
queue-6.1/netfilter-nf_conntrack-destroy-stale-expectfn-expect.patch
queue-6.1/net-garp-fix-unsigned-integer-underflow-in-garp_pdu_.patch
queue-6.1/selftests-bpf-s-iptables-iptables-legacy-in-the-bpf_.patch
queue-6.1/revert-selftests-bpf-add-tests-for-_opts-variants-of.patch
queue-6.1/hid-core-fix-size_t-specifier-in-hid_report_raw_even.patch
queue-6.1/rds-mark-snapshot-pages-dirty-in-rds_info_getsockopt.patch
queue-6.1/net-sched-act_api-use-rcu-with-deferred-freeing-for-.patch
queue-6.1/bluetooth-6lowpan-check-skb_clone-return-value-in-se.patch
queue-6.1/batman-adv-v-stop-ogmv2-on-disabled-interface.patch
queue-6.1/net-openvswitch-fix-possible-kfree_skb-of-err_ptr.patch
queue-6.1/hwmon-pmbus-adm1266-serialize-sequencer_state-debugf.patch
queue-6.1/fbdev-defio-disconnect-deferred-i-o-from-the-lifetime-of-struct-fb_info.patch
queue-6.1/bluetooth-mgmt-fix-backward-compatibility-with-users.patch
queue-6.1/ip6_vti-fix-incorrect-tunnel-matching-in-vti6_tnl_lo.patch
queue-6.1/gpio-rockchip-convert-bank-clk-to-devm_clk_get_enabl.patch
queue-6.1/selftests-bpf-enhance-align-selftest-s-expected-log-.patch
queue-6.1/netfilter-ctnetlink-ensure-safe-access-to-master-con.patch
queue-6.1/rdma-rxe-fix-double-free-in-rxe_srq_from_init.patch-25226
queue-6.1/hid-pass-the-buffer-size-to-hid_report_raw_event.patch
queue-6.1/alsa-aoa-skip-devices-with-no-codecs-in-i2sbus_resume.patch
queue-6.1/batman-adv-bla-avoid-null-ptr-deref-for-claim-via-dr.patch
queue-6.1/usb-serial-digi_acceleport-fix-memory-corruption-wit.patch
queue-6.1/tools-bootconfig-fix-buf-leaks-in-apply_xbc.patch
queue-6.1/bluetooth-rfcomm-hold-listener-socket-in-rfcomm_conn.patch
queue-6.1/wifi-mwifiex-fix-use-after-free-in-mwifiex_adapter_cleanup.patch
queue-6.1/batman-adv-iv-recover-ogm-scheduling-after-forward-p.patch
queue-6.1/net-sched-cls_fw-fix-null-dereference-of-old-filters.patch
queue-6.1/net-netlink-don-t-set-nsid-on-local-notifications.patch
queue-6.1/tcp-restrict-so_attach_filter-to-priv-users.patch
queue-6.1/batman-adv-tp_meter-directly-shut-down-timer-on-clea.patch
queue-6.1/netfilter-nf_log-validate-mac-header-was-set-before-.patch
queue-6.1/mm-page_alloc-clear-page-private-in-free_pages_prepa.patch
queue-6.1/octeontx2-af-npc-fix-cpt-channel-mask-in-npc_install.patch
queue-6.1/net-smc-do-not-re-initialize-smc-hashtables.patch
queue-6.1/ipvs-clear-the-svc-scheduler-ptr-early-on-edit.patch
queue-6.1/bluetooth-l2cap-clear-chan-ident-on-ecred-reconfigur.patch
queue-6.1/bpf-bonding-reject-vlan-srcmac-xmit_hash_policy-chan.patch
queue-6.1/tunnels-do-not-assume-transport-header-in-iptunnel_p.patch
queue-6.1/iomap-don-t-revert-iov_iter-on-partially-completed-b.patch
queue-6.1/phy-mscc-use-phy_id_match_vendor-to-minimize-phy-id-.patch
queue-6.1/net-802-mrp-fix-vector-attribute-parsing-in-mrp_pdu_.patch
queue-6.1/batman-adv-bla-avoid-double-decrement-of-bla.num_req.patch
queue-6.1/batman-adv-tvlv-abort-ogm-send-on-tvlv-append-failur.patch
queue-6.1/lib-test_hmm-evict-device-pages-on-file-close-to-avoid-use-after-free.patch
queue-6.1/alsa-pcm-fix-wait-queue-list-corruption-in-snd_pcm_d.patch
queue-6.1/net-mvpp2-refill-rx-buffers-before-xdp-or-skb-use.patch
queue-6.1/tun-free-page-on-build_skb-failure-in-tun_xdp_one.patch
queue-6.1/selftests-bpf-fix-arg_ptr_to_long-half-uninitialized.patch
queue-6.1/net-mvpp2-build-skb-from-xdp-adjusted-data-on-xdp_pa.patch
queue-6.1/selftests-bpf-add-generic-bpf-program-tester-loader.patch
queue-6.1/bluetooth-fix-memory-leak-in-error-path-of-hci_alloc.patch
queue-6.1/hid-core-add-printk_ratelimited-variants-to-hid_warn.patch
queue-6.1/bluetooth-mgmt-validate-advertising-tlv-before-type-.patch
queue-6.1/mm-damon-ops-common-call-folio_test_lru-after-folio_.patch
queue-6.1/netfilter-synproxy-add-mutex-to-guard-hook-reference.patch
queue-6.1/asoc-wm_adsp-fix-null-dereference-when-removing-firm.patch
queue-6.1/net-skbuff-fix-missing-zerocopy-reference-in-pskb_ca.patch
queue-6.1/drm-dp-add-edp-1.5-bit-definition.patch
queue-6.1/dmaengine-idxd-fix-not-releasing-workqueue-on-.relea.patch
queue-6.1/ipv6-fix-possible-infinite-loop-in-rt6_fill_node.patch
queue-6.1/tee-optee-prevent-use-after-free-when-the-client-exi.patch
queue-6.1/disable-wattribute-alias-for-clang-23-and-newer.patch
queue-6.1/vxlan-vnifilter-send-notification-on-vni-add.patch
queue-6.1/usb-gadget-f_ncm-fix-net_device-lifecycle-with-devic.patch
queue-6.1/selftests-bpf-update-bpf_clone_redirect-expected-ret.patch
queue-6.1/net-skbuff-fix-pskb_carve-leaking-zcopy-pages.patch
queue-6.1/net-qrtr-ns-limit-the-maximum-number-of-lookups.patch
queue-6.1/net-sched-sch_sfb-replace-direct-dequeue-call-with-p.patch
queue-6.1/netfilter-x_tables-avoid-leaking-percpu-counter-poin.patch
queue-6.1/tunnels-load-network-headers-after-skb_cow-in-iptunn.patch
queue-6.1/spi-imx-fix-use-after-free-on-unbind.patch
queue-6.1/netfilter-synproxy-refresh-tcphdr-after-skb_ensure_w.patch
queue-6.1/arm64-mm-enable-batched-tlb-flush-in-unmap_hotplug_range.patch
queue-6.1/netfilter-nf_tables-restore-set-elements-when-delete.patch
queue-6.1/alsa-aoa-use-guard-for-mutex-locks.patch
queue-6.1/mm-huge_memory-update-file-pmd-counter-before-folio_.patch
queue-6.1/spi-fix-resource-leaks-on-device-setup-failure.patch
queue-6.1/kvm-arm64-remove-vpipt-i-cache-handling.patch
queue-6.1/xhci-tegra-fix-ghost-usb-device-on-dual-role-port-un.patch
queue-6.1/net-mana-add-null-guards-in-teardown-path-to-prevent.patch
queue-6.1/netfilter-nft_exthdr-fix-register-tracking-for-f_pre.patch
queue-6.1/net-packet-fix-toctou-race-on-mmap-d-vnet_hdr-in-tpa.patch
queue-6.1/net-cpsw_new-fix-potential-unregister-of-netdev-that.patch
queue-6.1/drm-i915-psr-apply-intel-dpcd-workaround-when-sdp-on.patch
queue-6.1/net-iucv-fix-locking-in-.getsockopt.patch
queue-6.1/sctp-purge-outqueue-on-stale-cookie-echo-handling.patch
queue-6.1/ipv4-restrict-ipopt_ssrr-and-ipopt_lsrr-options.patch
queue-6.1/netfilter-xt_cpu-prefer-raw_smp_processor_id.patch
queue-6.1/batman-adv-tt-reject-oversized-local-tvlv-buffers.patch
queue-6.1/net-annotate-sk-sk_write_space-for-udp-sockmap.patch
queue-6.1/r8152-handle-the-return-value-of-usb_reset_device.patch
queue-6.1/hwmon-pmbus-adm1266-serialize-nvmem-blackbox-read-wi.patch
queue-6.1/netfilter-ebtables-fix-oob-read-in-compat_mtw_from_u.patch
queue-6.1/r8152-reduce-the-control-transfer-of-rtl8152_get_ver.patch
queue-6.1/net-packet-convert-po-running-to-an-atomic-flag.patch
queue-6.1/tap-free-page-on-error-paths-in-tap_get_user_xdp.patch
queue-6.1/nfc-nxp-nci-i2c-use-rising-edge-irq-on-acpi-systems.patch
queue-6.1/bluetooth-rfcomm-validate-skb-length-in-mcc-handlers.patch
queue-6.1/net-bridge-use-a-stable-fdb-dst-snapshot-in-rcu-readers.patch
queue-6.1/fs-ntfs3-return-error-for-inconsistent-extended-attr.patch
queue-6.1/f2fs-fix-uaf-caused-by-decrementing-sbi-nr_pages-in-f2fs_write_end_io.patch
queue-6.1/thermal-core-fix-thermal-zone-governor-cleanup-issues.patch
queue-6.1/net-lan743x-permit-vlan-tagged-packets-up-to-configu.patch
queue-6.1/drm-imx-fix-three-kernel-doc-warnings-in-dcss-scaler.patch
queue-6.1/spi-imx-convert-to-platform-remove-callback-returning-void.patch
queue-6.1/net-mlx4-avoid-gcc-10-__bad_copy_from-false-positive.patch
queue-6.1/ipv6-fix-possible-infinite-loop-in-fib6_select_path.patch
queue-6.1/netfilter-bridge-make-ebt_snat-arp-rewrite-writable.patch
queue-6.1/nfc-llcp-fix-use-after-free-in-llcp_sock_release.patch
queue-6.1/selftests-forwarding-lib-add-helpers-for-checksum-ha.patch
queue-6.1/ksmbd-require-minimum-ace-size-in-smb_check_perm_dacl.patch
queue-6.1/netfilter-conntrack_irc-fix-possible-out-of-bounds-r.patch
queue-6.1/netfilter-xt_nfqueue-prefer-raw_smp_processor_id.patch
queue-6.1/phy-mscc-use-phy_id_match_exact-for-vsc8584-vsc8582-.patch
queue-6.1/usb-gadget-u_ether-fix-null-pointer-deref-in-eth_get.patch
queue-6.1/net-rds-fix-null-deref-in-rds_ib_send_cqe_handler-on.patch
queue-6.1/sctp-fix-uninit-value-in-__sctp_rcv_asconf_lookup.patch
queue-6.1/ipv4-free-net-ipv4.sysctl_local_reserved_ports-after.patch
queue-6.1/net-mvpp2-sync-rx-data-at-the-hardware-packet-offset.patch
queue-6.1/arm64-tlb-allow-xzr-argument-to-tlbi-ops.patch
