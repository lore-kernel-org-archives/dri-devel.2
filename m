Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCC4C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3279210EC00;
	Wed, 29 Jul 2026 12:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nkzr10MD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3558E10EC00
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:46:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B2F0E4125F;
 Wed, 29 Jul 2026 12:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158761F000E9;
 Wed, 29 Jul 2026 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1785329170;
 bh=hYP9VN6tsuHbVTjt7S+rFAE+HflAhuiJd5pEWBElp0k=;
 h=Subject:To:Cc:From:Date;
 b=nkzr10MDWeXL007lrBKTJGLwm1X5nMTUXqYdR8UGh01EIkrx+YBBOLeSl5D7Q1cEs
 yNhMmGhpmMEIVLdoi+m0Gu4gVoMjiOyVIyZ7Y3+snRjEwzkPNLXwCqQ00o+lZH3rcj
 guYlp8OI1naKCNDyxeNRlYlh0Pr+4XWr2UJalupw=
Subject: Patch "drm/ttm: Account for NULL and handle pages in ttm_pool_backup"
 has been added to the 6.18-stable tree
To: airlied@gmail.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
 matthew.brost@intel.com, mripard@kernel.org, ray.huang@amd.com,
 simona@ffwll.ch, thomas.hellstrom@linux.intel.com, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:45:24 +0200
Message-ID: <2026072924-debate-parched-01e5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

    drm/ttm: Account for NULL and handle pages in ttm_pool_backup

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-ttm-account-for-null-and-handle-pages-in-ttm_pool_backup.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 5b7b3b6595ee77d01c7463757baed114786094dd Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Thu, 2 Jul 2026 14:48:15 -0700
Subject: drm/ttm: Account for NULL and handle pages in ttm_pool_backup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

commit 5b7b3b6595ee77d01c7463757baed114786094dd upstream.

Pages in ttm_pool_backup can be NULL or backup handles
(ttm_backup_page_ptr_is_handle()), neither of which can be passed to
set_pages_array_wb() or freed. Add a dedicated WB pass before the
dma/purge loop that walks allocations using the same i += num_pages
stride, skipping NULL and handle entries, and calls set_pages_array_wb()
once per contiguous run of real pages. Apply the same NULL/handle guard
to the dma/purge loop.

Fixes the following oops:

Oops: general protection fault, kernel NULL pointer dereference 0x0: 0000 [#1] SMP NOPTI
RIP: 0010:__cpa_process_fault+0xf8/0x770
RSP: 0018:ffffc90000a87718 EFLAGS: 00010287
RAX: 0000000000000000 RBX: ffffc90000a87868 RCX: 0000000000000000
RDX: 0000000000001000 RSI: 0005088000000000 RDI: ffffffff827c5f34
RBP: 0005088000000000 R08: ffffc90000a877cb R09: ffffc90000a877d0
R10: 0000000000000000 R11: 000000000000001b R12: 000ffffffffff000
R13: ffffc90000a87868 R14: ffffc90000a87868 R15: ffff88815b882ae0
FS:  0000000000000000(0000) GS:ffff8884ec840000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f930b844000 CR3: 000000000262e003 CR4: 0000000008f70ef0
PKRU: 55555554
Call Trace:
 <TASK>
 __change_page_attr_set_clr+0x989/0xe90
 ? __purge_vmap_area_lazy+0x6c/0x3a0
 ? _vm_unmap_aliases+0x250/0x2a0
 set_pages_array_wb+0x7f/0x120
 ttm_pool_backup+0x4c9/0x5b0 [ttm]
 ? dma_resv_wait_timeout+0x3b/0xf0
 ttm_tt_backup+0x32/0x60 [ttm]
 ttm_bo_shrink+0x66/0x110 [ttm]
 xe_bo_shrink_purge+0x12b/0x1b0 [xe]
 xe_bo_shrink+0xbb/0x270 [xe]
 __xe_shrinker_walk+0xf7/0x160 [xe]
 xe_shrinker_walk+0x9d/0xc0 [xe]
 xe_shrinker_scan+0x11f/0x210 [xe]
 do_shrink_slab+0x13b/0x270
 shrink_slab+0xf1/0x400
 shrink_node+0x352/0x8a0
 balance_pgdat+0x32c/0x700
 kswapd+0x205/0x2f0
 ? __pfx_autoremove_wake_function+0x10/0x10
 ? __pfx_kswapd+0x10/0x10
 kthread+0xd1/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1b1/0x200
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to shrink pages")
Cc: stable@vger.kernel.org
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20260702214815.4009271-1-matthew.brost@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_pool.c |   34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -981,9 +981,31 @@ long ttm_pool_backup(struct ttm_pool *po
 		return -EBUSY;
 
 #ifdef CONFIG_X86
-	/* Anything returned to the system needs to be cached. */
-	if (tt->caching != ttm_cached)
-		set_pages_array_wb(tt->pages, tt->num_pages);
+	/* Anything returned to the system needs to be cached. Walk allocations
+	 * skipping NULL pages and issue set_pages_array_wb() per contiguous run.
+	 */
+	if (tt->caching != ttm_cached) {
+		pgoff_t run_start = 0, run_count = 0;
+
+		for (i = 0; i < tt->num_pages; i += num_pages) {
+			page = tt->pages[i];
+			if (unlikely(!page || ttm_backup_page_ptr_is_handle(page))) {
+				if (run_count) {
+					set_pages_array_wb(&tt->pages[run_start],
+							   run_count);
+					run_count = 0;
+				}
+				num_pages = 1;
+				continue;
+			}
+			num_pages = 1UL << ttm_pool_page_order(pool, page);
+			if (!run_count)
+				run_start = i;
+			run_count += num_pages;
+		}
+		if (run_count)
+			set_pages_array_wb(&tt->pages[run_start], run_count);
+	}
 #endif
 
 	if (tt->dma_address || flags->purge) {
@@ -991,7 +1013,7 @@ long ttm_pool_backup(struct ttm_pool *po
 			unsigned int order;
 
 			page = tt->pages[i];
-			if (unlikely(!page)) {
+			if (unlikely(!page || ttm_backup_page_ptr_is_handle(page))) {
 				num_pages = 1;
 				continue;
 			}
@@ -1034,6 +1056,10 @@ long ttm_pool_backup(struct ttm_pool *po
 		if (unlikely(!page))
 			continue;
 
+		/* Already-handled entry from a previous attempt. */
+		if (unlikely(ttm_backup_page_ptr_is_handle(page)))
+			continue;
+
 		ttm_pool_split_for_swap(pool, page);
 
 		shandle = ttm_backup_backup_page(backup, page, flags->writeback, i,


Patches currently in stable-queue which might be from matthew.brost@intel.com are

queue-6.18/drm-i915-gem-add-missing-nospec-on-parallel-submit-slot.patch
queue-6.18/drm-ttm-account-for-null-and-handle-pages-in-ttm_pool_backup.patch
queue-6.18/drm-xe-vf-shadow-buffer-management-for-ccs-read-writ.patch
queue-6.18/drm-xe-return-error-on-non-migratable-faults-requiring-devmem.patch
queue-6.18/drm-xe-vm-fix-svm-leak-on-resv-obj-alloc-failure-in-.patch
queue-6.18/drm-xe-fix-pte-index-in-xe_vm_populate_pgtable-for-chunked-binds.patch
queue-6.18/drm-xe-sa-shadow-buffer-support-in-the-sub-allocator.patch
queue-6.18/drm-xe-vf-fix-vf-ccs-attach-detach-race-with-in-flig.patch
