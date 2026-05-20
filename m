Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4893BCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE2E10E533;
	Wed, 20 May 2026 14:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QeKk2iq2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A4F10F0D6
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:54:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 06960440DC;
 Wed, 20 May 2026 14:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6969F1F000E9;
 Wed, 20 May 2026 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1779288881;
 bh=//ozQH9VnfjGGhd+riUfR1jE608ak+No9+/yeuqqSGc=;
 h=Subject:To:Cc:From:Date;
 b=QeKk2iq2or1umg4dajo2k7EjvmJvTqAJAzrXAamePeNDtgup2/SHlhyO1TIVYHS7i
 MpVdaZPyLbL3S94zfJW2+BQbA1FQisVzc+hBIhdc3rgKPFv1e1+KbF7pCR8SC38/XQ
 cHLoRoCywSY6ue3xTmvnzgnB27CNlLcULQJ4HvPk=
Subject: Patch "drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup
 failure" has been added to the 7.0-stable tree
To: airlied@redhat.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 matthew.auld@intel.com, matthew.brost@intel.com, ray.huang@amd.com,
 thomas.hellstrom@linux.intel.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:54:22 +0200
Message-ID: <2026052022-carless-bully-b327@gregkh>
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

    drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup failure

to the 7.0-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-ttm-fix-ttm_bo_shrink-infinite-lru-walk-on-backup-failure.patch
and it can be found in the queue-7.0 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 1d59f36e95f7f7134db0e313c9d787cb0adb2153 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Date: Mon, 11 May 2026 18:24:43 +0200
Subject: drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup failure
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit 1d59f36e95f7f7134db0e313c9d787cb0adb2153 upstream.

Apply the same fix as b2ed01e7ad ("drm/ttm: Fix ttm_bo_swapout()
infinite LRU walk on swapout failure") to the ttm_bo_shrink() path.

Move del_bulk_move from before the backup to after success only,
using ttm_resource_del_bulk_move_unevictable() since the resource
is now unevictable once fully backed up.

Fixes: 70d645deac98 ("drm/ttm: Add helpers for shrinking")
Cc: Christian König <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org # v6.15+
Assisted-by: GitHub_Copilot:claude-opus-4.6
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260511162443.24352-1-thomas.hellstrom@linux.intel.com
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -1112,19 +1112,14 @@ long ttm_bo_shrink(struct ttm_operation_
 	if (lret < 0)
 		return lret;
 
-	if (bo->bulk_move) {
-		spin_lock(&bdev->lru_lock);
-		ttm_resource_del_bulk_move(bo->resource, bo);
-		spin_unlock(&bdev->lru_lock);
-	}
-
 	lret = ttm_tt_backup(bdev, bo->ttm, (struct ttm_backup_flags)
 			     {.purge = flags.purge,
 			      .writeback = flags.writeback});
 
-	if (lret <= 0 && bo->bulk_move) {
+	if (lret > 0) {
 		spin_lock(&bdev->lru_lock);
-		ttm_resource_add_bulk_move(bo->resource, bo);
+		ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
+		ttm_resource_move_to_lru_tail(bo->resource);
 		spin_unlock(&bdev->lru_lock);
 	}
 


Patches currently in stable-queue which might be from thomas.hellstrom@linux.intel.com are

queue-7.0/drm-xe-dma-buf-fix-uaf-with-retry-loop.patch
queue-7.0/drm-ttm-fix-ttm_bo_shrink-infinite-lru-walk-on-backup-failure.patch
queue-7.0/drm-ttm-fix-ttm_bo_swapout-infinite-lru-walk-on-swapout-failure.patch
queue-7.0/drm-gpusvm-fix-unbalanced-unlock-in-drm_gpusvm_scan_.patch
queue-7.0/drm-xe-xelp-fix-wa_18022495364.patch
queue-7.0/drm-xe-dma-buf-handle-empty-bo-and-uaf-races.patch
queue-7.0/drm-ttm-convert-eagain-from-dmem_cgroup_try_charge-to-enospc.patch
