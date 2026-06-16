Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3F0CD8CA8
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0420D10E64A;
	Tue, 16 Jun 2026 05:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="etOth1jc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F109A10E64A
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 05:39:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B757B44418;
 Tue, 16 Jun 2026 05:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4671F000E9;
 Tue, 16 Jun 2026 05:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1781588383;
 bh=vKoBrQE8wzBLpEAnIkMcDoUpbUA5lgpT+nddipRS5Lc=;
 h=Subject:To:Cc:From:Date:In-Reply-To;
 b=etOth1jc/sVfniugPlBeNQ4+aA2fjCpzKde/LI/eMvb7XD2QzkBseIcxoprzvBzik
 QAO4EcClzaSt1OWrqJa+L49FvZ9VsgHUVbhFmErSqxd2skP/VQ8aBXUgVKaeM0dTKs
 hBYz+b5eDJ2Kya/GxGuprSHoOlMH+lg8D5aIfamc=
Subject: Patch "fbdev: defio: Disconnect deferred I/O from the lifetime of
 struct fb_info" has been added to the 5.15-stable tree
To: deller@gmx.de, dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 sashal@kernel.org, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Jun 2026 11:02:05 +0530
In-Reply-To: <20260505094937.506038-1-sashal@kernel.org>
Message-ID: <2026061605-vowel-shrivel-8150@gregkh>
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

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     fbdev-defio-disconnect-deferred-i-o-from-the-lifetime-of-struct-fb_info.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-244037-greg=kroah.com@vger.kernel.org Tue May  5 15:19:47 2026
From: Sasha Levin <sashal@kernel.org>
Date: Tue,  5 May 2026 05:49:37 -0400
Subject: fbdev: defio: Disconnect deferred I/O from the lifetime of struct fb_info
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>
Message-ID: <20260505094937.506038-1-sashal@kernel.org>

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
[ replaced `kzalloc_obj()` with `kzalloc(sizeof(*fbdefio_state), GFP_KERNEL)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fb_defio.c |  152 +++++++++++++++++++++++++++++++-----
 include/linux/fb.h                  |    4 
 2 files changed, 138 insertions(+), 18 deletions(-)

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
 
@@ -115,8 +198,14 @@ static vm_fault_t fb_deferred_io_fault(s
 	BUG_ON(!page->mapping);
 	page->index = vmf->pgoff; /* for page_mkclean() */
 
+	mutex_unlock(&fbdefio_state->lock);
+
 	vmf->page = page;
 	return 0;
+
+err_mutex_unlock:
+	mutex_unlock(&fbdefio_state->lock);
+	return ret;
 }
 
 int fb_deferred_io_fsync(struct file *file, loff_t start, loff_t end, int datasync)
@@ -143,8 +232,9 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
 static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct fb_info *info = vmf->vma->vm_private_data;
-	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_deferred_io_state *fbdefio_state = vmf->vma->vm_private_data;
+	struct fb_info *info;
+	struct fb_deferred_io *fbdefio;
 	struct fb_deferred_io_pageref *pageref;
 	unsigned long offset;
 	vm_fault_t ret;
@@ -160,7 +250,15 @@ static vm_fault_t fb_deferred_io_mkwrite
 	file_update_time(vmf->vma->vm_file);
 
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
@@ -182,18 +280,20 @@ static vm_fault_t fb_deferred_io_mkwrite
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
 
 static const struct vm_operations_struct fb_deferred_io_vm_ops = {
+	.open		= fb_deferred_io_vm_open,
+	.close		= fb_deferred_io_vm_close,
 	.fault		= fb_deferred_io_fault,
 	.page_mkwrite	= fb_deferred_io_mkwrite,
 };
@@ -215,7 +315,10 @@ int fb_deferred_io_mmap(struct fb_info *
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
 
@@ -225,9 +328,10 @@ static void fb_deferred_io_work(struct w
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
@@ -242,12 +346,13 @@ static void fb_deferred_io_work(struct w
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
@@ -257,7 +362,11 @@ int fb_deferred_io_init(struct fb_info *
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
@@ -276,10 +385,12 @@ int fb_deferred_io_init(struct fb_info *
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
@@ -320,11 +431,18 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_release
 
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
@@ -480,6 +481,7 @@ struct fb_info {
 	unsigned long npagerefs;
 	struct fb_deferred_io_pageref *pagerefs;
 	struct fb_deferred_io *fbdefio;
+	struct fb_deferred_io_state *fbdefio_state;
 #endif
 
 	const struct fb_ops *fbops;


Patches currently in stable-queue which might be from sashal@kernel.org are

queue-5.15/bonding-refuse-to-enslave-can-devices.patch
queue-5.15/asoc-intel-bytcht_es8316-fix-mclk-leak-on-init-error.patch
queue-5.15/asoc-codecs-simple-mux-fix-enum-control-bounds-check.patch
queue-5.15/bluetooth-l2cap-fix-possible-crash-on-l2cap_ecred_co.patch
queue-5.15/ipv6-sit-reload-inner-ipv6-header-after-gso-offloads.patch
queue-5.15/ethtool-eeprom-add-more-safeties-to-eeprom-netlink-f.patch
queue-5.15/6lowpan-fix-off-by-one-in-multicast-context-address-.patch
queue-5.15/randomize_kstack-maintain-kstack_offset-per-task.patch
queue-5.15/sctp-fix-race-between-sctp_wait_for_connect-and-peel.patch
queue-5.15/pcnet32-stop-holding-device-spin-lock-during-napi_co.patch
queue-5.15/drm-vc4-fix-krealloc-memory-leak.patch
queue-5.15/f2fs-fix-to-do-sanity-check-on-dcc-discard_cmd_cnt-conditionally.patch
queue-5.15/arm64-tlb-optimize-arm64_workaround_repeat_tlbi.patch
queue-5.15/nfc-llcp-fix-use-after-free-race-in-nfc_llcp_recv_cc.patch
queue-5.15/net-netlink-fix-sending-unassigned-nsid-after-assign.patch
queue-5.15/bluetooth-bnep-reject-short-frames-before-parsing.patch
queue-5.15/nvme-respect-nvme_quirk_disable_write_zeroes-when-wzsl-is-set.patch
queue-5.15/rtw88-8821ce-disable-pcie-aspm-l1-for-8821ce-using-chip-id.patch
queue-5.15/net-qrtr-ns-free-the-node-during-ctrl_cmd_bye.patch
queue-5.15/dm-cache-policy-smq-check-allocation-under-invalidat.patch
queue-5.15/crypto-nx-avoid-wflex-array-member-not-at-end-warning.patch
queue-5.15/drm-i915-psr-read-intel-dpcd-workaround-register.patch
queue-5.15/ipv6-rpl-fix-hdrlen-overflow-in-ipv6_rpl_srh_decompr.patch
queue-5.15/ieee802154-6lowpan-only-accept-ipv6-packets-in-lowpa.patch
queue-5.15/tun-free-page-on-short-frame-rejection-in-tun_xdp_on.patch
queue-5.15/usb-serial-mct_u232-fix-memory-corruption-with-small.patch
queue-5.15/ext4-validate-p_idx-bounds-in-ext4_ext_correct_index.patch
queue-5.15/wifi-rtw88-check-for-pci-upstream-bridge-existence.patch
queue-5.15/bluetooth-bnep-fix-incorrect-length-parsing-in-bnep_.patch
queue-5.15/mtd-spi-nor-sst-fix-write-enable-before-aai-sequence.patch
queue-5.15/signal-clear-jobctl_pending_mask-for-caller-in-zap_o.patch
queue-5.15/alsa-aoa-i2sbus-clear-stale-prepared-state.patch
queue-5.15/sched-use-u64-for-bandwidth-ratio-calculations.patch
queue-5.15/revert-rdma-rxe-fix-double-free-in-rxe_srq_from_init.patch
queue-5.15/can-ucan-fix-devres-lifetime.patch
queue-5.15/net-qrtr-fix-refcount-saturation-and-potential-uaf-i.patch
queue-5.15/media-rc-igorplugusb-heed-coherency-rules.patch
queue-5.15/bpf-free-reuseport-cbpf-prog-after-rcu-grace-period.patch
queue-5.15/net-qrtr-ns-change-servers-radix-tree-to-xarray.patch
queue-5.15/net-mctp-ensure-our-nlmsg-responses-are-initialised.patch
queue-5.15/media-rc-ttusbir-respect-dma-coherency-rules.patch
queue-5.15/batman-adv-tt-fix-toctou-race-for-reported-vlans.patch
queue-5.15/nvme-fix-interpretation-of-dmrsl.patch
queue-5.15/time-fix-off-by-one-in-settimeofday-usec-validation.patch
queue-5.15/usb-serial-cypress_m8-fix-memory-corruption-with-sma.patch
queue-5.15/crypto-nx-fix-bounce-buffer-leaks-in-nx842_crypto_-alloc-free-_ctx.patch
queue-5.15/xfrm-policy-fix-use-after-free-on-inexact-bin-in-xfr.patch
queue-5.15/netlabel-validate-unlabeled-address-and-mask-attribu.patch
queue-5.15/can-ucan-fix-typos-in-comments.patch
queue-5.15/batman-adv-tt-avoid-empty-vlan-responses.patch
queue-5.15/drm-remove-plane-hsub-vsub-alignment-requirement-for.patch
queue-5.15/net-qrtr-ns-limit-the-total-number-of-nodes.patch
queue-5.15/scsi-sd-fix-missing-put_disk-when-device_add-disk_dev-fails.patch
queue-5.15/serial-dz-fix-bootconsole-handover-lockup.patch
queue-5.15/net-sched-revert-net-sched-restrict-conditions-for-a.patch
queue-5.15/drm-i915-psr-add-defininitions-for-intel_wa_register.patch
queue-5.15/net-mvpp2-limit-xdp-frame-size-to-the-rx-buffer.patch
queue-5.15/vxlan-do-not-reuse-cached-ip_hdr-value-after-skb_tun.patch
queue-5.15/udf-fix-partition-descriptor-append-bookkeeping.patch
queue-5.15/scsi-sd-add-error-handling-support-for-add_disk.patch
queue-5.15/net-guard-timestamp-cmsgs-to-real-error-queue-skbs.patch
queue-5.15/batman-adv-tvlv-reject-oversized-tvlv-packets.patch
queue-5.15/net-mvpp2-add-metadata-support-for-xdp-mode.patch
queue-5.15/net-mctp-fix-don-t-require-received-header-reserved-bits-to-be-zero.patch
queue-5.15/xfrm-check-for-underflow-in-xfrm_state_mtu.patch
queue-5.15/net-garp-fix-unsigned-integer-underflow-in-garp_pdu_.patch
queue-5.15/alsa-aloop-fix-peer-runtime-uaf-during-format-change-stop.patch
queue-5.15/hid-core-fix-size_t-specifier-in-hid_report_raw_even.patch
queue-5.15/rds-mark-snapshot-pages-dirty-in-rds_info_getsockopt.patch
queue-5.15/net-sched-act_api-use-rcu-with-deferred-freeing-for-.patch
queue-5.15/wifi-brcmfmac-fix-use-after-free-when-rescheduling-b.patch
queue-5.15/bluetooth-6lowpan-check-skb_clone-return-value-in-se.patch
queue-5.15/mtd-docg3-fix-use-after-free-in-docg3_release.patch
queue-5.15/batman-adv-v-stop-ogmv2-on-disabled-interface.patch
queue-5.15/net-openvswitch-fix-possible-kfree_skb-of-err_ptr.patch
queue-5.15/smb-client-fix-smbdirect_recv_io-leak-in-smbd_negoti.patch
queue-5.15/fbdev-defio-disconnect-deferred-i-o-from-the-lifetime-of-struct-fb_info.patch
queue-5.15/net-packet-fix-toctou-race-on-mmap-d-vnet_hdr-in-tpacket_snd.patch
queue-5.15/ip6_vti-fix-incorrect-tunnel-matching-in-vti6_tnl_lo.patch
queue-5.15/gpio-rockchip-convert-bank-clk-to-devm_clk_get_enabl.patch
queue-5.15/hid-pass-the-buffer-size-to-hid_report_raw_event.patch
queue-5.15/smb-server-fix-active_num_conn-leak-on-transport-allocation-failure.patch
queue-5.15/alsa-aoa-skip-devices-with-no-codecs-in-i2sbus_resume.patch
queue-5.15/printk-add-print_hex_dump_devel.patch
queue-5.15/batman-adv-bla-avoid-null-ptr-deref-for-claim-via-dr.patch
queue-5.15/usb-serial-digi_acceleport-fix-memory-corruption-wit.patch
queue-5.15/bluetooth-rfcomm-hold-listener-socket-in-rfcomm_conn.patch
queue-5.15/wifi-mwifiex-fix-use-after-free-in-mwifiex_adapter_cleanup.patch
queue-5.15/tracepoint-balance-regfunc-on-func_add-failure-in-tracepoint_add_func.patch
queue-5.15/batman-adv-iv-recover-ogm-scheduling-after-forward-p.patch
queue-5.15/net-sched-cls_fw-fix-null-dereference-of-old-filters.patch
queue-5.15/compiler-clang.h-add-__diag-infrastructure-for-clang.patch
queue-5.15/net-netlink-don-t-set-nsid-on-local-notifications.patch
queue-5.15/smb-client-fix-oob-read-in-smb2_ioctl_query_info-query_info-path.patch
queue-5.15/batman-adv-tp_meter-directly-shut-down-timer-on-clea.patch
queue-5.15/netfilter-nf_log-validate-mac-header-was-set-before-.patch
queue-5.15/alsa-core-fix-potential-data-race-at-fasync-handling.patch
queue-5.15/net-smc-do-not-re-initialize-smc-hashtables.patch
queue-5.15/ipvs-clear-the-svc-scheduler-ptr-early-on-edit.patch
queue-5.15/bluetooth-l2cap-clear-chan-ident-on-ecred-reconfigur.patch
queue-5.15/tunnels-do-not-assume-transport-header-in-iptunnel_p.patch
queue-5.15/phy-mscc-use-phy_id_match_vendor-to-minimize-phy-id-.patch
queue-5.15/net-802-mrp-fix-vector-attribute-parsing-in-mrp_pdu_.patch
queue-5.15/batman-adv-bla-avoid-double-decrement-of-bla.num_req.patch
queue-5.15/hfsplus-fix-uninit-value-by-validating-catalog-record-size.patch
queue-5.15/batman-adv-tvlv-abort-ogm-send-on-tvlv-append-failur.patch
queue-5.15/net-mvpp2-refill-rx-buffers-before-xdp-or-skb-use.patch
queue-5.15/mtd-docg3-convert-to-platform-remove-callback-returning-void.patch
queue-5.15/scsi-core-pm-rely-on-the-device-driver-core-for-async-power-management.patch
queue-5.15/tun-free-page-on-build_skb-failure-in-tun_xdp_one.patch
queue-5.15/net-mvpp2-build-skb-from-xdp-adjusted-data-on-xdp_pa.patch
queue-5.15/bluetooth-fix-memory-leak-in-error-path-of-hci_alloc.patch
queue-5.15/hid-core-add-printk_ratelimited-variants-to-hid_warn.patch
queue-5.15/bluetooth-mgmt-validate-advertising-tlv-before-type-.patch
queue-5.15/mm-damon-ops-common-call-folio_test_lru-after-folio_.patch
queue-5.15/mmc-sdhci-of-dwcmshc-disable-clock-before-dll-configuration.patch
queue-5.15/netfilter-synproxy-add-mutex-to-guard-hook-reference.patch
queue-5.15/drm-dp-add-edp-1.5-bit-definition.patch
queue-5.15/dmaengine-idxd-fix-not-releasing-workqueue-on-.relea.patch
queue-5.15/tee-optee-prevent-use-after-free-when-the-client-exi.patch
queue-5.15/disable-wattribute-alias-for-clang-23-and-newer.patch
queue-5.15/net-qrtr-ns-limit-the-maximum-number-of-lookups.patch
queue-5.15/net-sched-sch_sfb-replace-direct-dequeue-call-with-p.patch
queue-5.15/netfilter-x_tables-avoid-leaking-percpu-counter-poin.patch
queue-5.15/tunnels-load-network-headers-after-skb_cow-in-iptunn.patch
queue-5.15/netfilter-synproxy-refresh-tcphdr-after-skb_ensure_w.patch
queue-5.15/arm64-mm-enable-batched-tlb-flush-in-unmap_hotplug_range.patch
queue-5.15/alsa-aoa-use-guard-for-mutex-locks.patch
queue-5.15/bluetooth-hci_event-fix-potential-uaf-in-ssp-passkey-handlers.patch
queue-5.15/kvm-arm64-remove-vpipt-i-cache-handling.patch
queue-5.15/xhci-tegra-fix-ghost-usb-device-on-dual-role-port-un.patch
queue-5.15/netfilter-nft_exthdr-fix-register-tracking-for-f_pre.patch
queue-5.15/net-cpsw_new-fix-potential-unregister-of-netdev-that.patch
queue-5.15/smb-server-fix-max_connections-off-by-one-in-tcp-accept-path.patch
queue-5.15/drm-i915-psr-apply-intel-dpcd-workaround-when-sdp-on.patch
queue-5.15/net-iucv-fix-locking-in-.getsockopt.patch
queue-5.15/rdma-rxe-fix-double-free-in-rxe_srq_from_init.patch-82
queue-5.15/sctp-purge-outqueue-on-stale-cookie-echo-handling.patch
queue-5.15/ipv4-restrict-ipopt_ssrr-and-ipopt_lsrr-options.patch
queue-5.15/netfilter-xt_cpu-prefer-raw_smp_processor_id.patch
queue-5.15/erofs-fix-the-out-of-bounds-nameoff-handling-for-trailing-dirents.patch
queue-5.15/smb-client-require-a-full-nfs-mode-sid-before-reading-mode-bits.patch
queue-5.15/netfilter-ebtables-fix-oob-read-in-compat_mtw_from_u.patch
queue-5.15/ceph-only-d_add-negative-dentries-when-they-are-unhashed.patch
queue-5.15/tap-free-page-on-error-paths-in-tap_get_user_xdp.patch
queue-5.15/nfc-nxp-nci-i2c-use-rising-edge-irq-on-acpi-systems.patch
queue-5.15/bluetooth-rfcomm-validate-skb-length-in-mcc-handlers.patch
queue-5.15/net-bridge-use-a-stable-fdb-dst-snapshot-in-rcu-readers.patch
queue-5.15/fs-ntfs3-return-error-for-inconsistent-extended-attr.patch
queue-5.15/f2fs-fix-uaf-caused-by-decrementing-sbi-nr_pages-in-f2fs_write_end_io.patch
queue-5.15/thermal-core-fix-thermal-zone-governor-cleanup-issues.patch
queue-5.15/net-lan743x-permit-vlan-tagged-packets-up-to-configu.patch
queue-5.15/crypto-nx-migrate-to-scomp-api.patch
queue-5.15/drm-imx-fix-three-kernel-doc-warnings-in-dcss-scaler.patch
queue-5.15/sd-rename-the-scsi_disk.dev-field.patch
queue-5.15/crypto-caam-guard-hmac-key-hex-dumps-in-hash_digest_key.patch
queue-5.15/netfilter-bridge-make-ebt_snat-arp-rewrite-writable.patch
queue-5.15/nfc-llcp-fix-use-after-free-in-llcp_sock_release.patch
queue-5.15/selftests-forwarding-lib-add-helpers-for-checksum-ha.patch
queue-5.15/hfsplus-fix-held-lock-freed-on-hfsplus_fill_super.patch
queue-5.15/ksmbd-require-minimum-ace-size-in-smb_check_perm_dacl.patch
queue-5.15/netfilter-conntrack_irc-fix-possible-out-of-bounds-r.patch
queue-5.15/netfilter-xt_nfqueue-prefer-raw_smp_processor_id.patch
queue-5.15/phy-mscc-use-phy_id_match_exact-for-vsc8584-vsc8582-.patch
queue-5.15/net-rds-fix-null-deref-in-rds_ib_send_cqe_handler-on.patch
queue-5.15/erofs-fix-unsigned-underflow-in-z_erofs_lz4_handle_overlap.patch
queue-5.15/sctp-fix-uninit-value-in-__sctp_rcv_asconf_lookup.patch
queue-5.15/ipv4-free-net-ipv4.sysctl_local_reserved_ports-after.patch
queue-5.15/net-mvpp2-sync-rx-data-at-the-hardware-packet-offset.patch
queue-5.15/arm64-tlb-allow-xzr-argument-to-tlbi-ops.patch
queue-5.15/rxrpc-fix-conn-level-packet-handling-to-unshare-response-packets.patch
queue-5.15/nfsd-don-t-ignore-the-return-code-of-svc_proc_regist.patch
