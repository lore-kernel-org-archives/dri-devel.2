Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A44CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E827610F085;
	Wed, 20 May 2026 14:37:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lKMIEs4i";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D15C810F085
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:37:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 01E4960008;
 Wed, 20 May 2026 14:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6451F000E9;
 Wed, 20 May 2026 14:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1779287852;
 bh=Xvne2QFrGMT67HLsEBwrqQtIanzuJIgnsF8ubzLBWGY=;
 h=Subject:To:Cc:From:Date;
 b=lKMIEs4ik2y0CkYSyoUiBpsLc+Z52qhxKIp2I+psCuVrF7lq2KtebGc5GCwX/S/qE
 ezlSI1xb+q5d1kLZHOAz9J9knTdolx8eJsrcnD9cPtBmbADXPNmOc8AwS495IgLV8M
 9s3pXnRHDjQdsKunaLIHvD3lBa1Y8IsVBekT9Z+Q=
Subject: FAILED: patch "[PATCH] drm/ttm: Fix ttm_bo_swapout() infinite LRU
 walk on swapout" failed to apply to 6.18-stable tree
To: thomas.hellstrom@linux.intel.com, boqun@kernel.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 jkataria@netflix.com, matthew.brost@intel.com, stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:37:35 +0200
Message-ID: <2026052035-sweat-creed-1388@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b2ed01e7ad3de80333e9b962a44024b094bc0b2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052035-sweat-creed-1388@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2ed01e7ad3de80333e9b962a44024b094bc0b2b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Date: Tue, 28 Apr 2026 11:44:42 +0200
Subject: [PATCH] drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When ttm_tt_swapout() fails, the current code calls
ttm_resource_add_bulk_move() followed by ttm_resource_move_to_lru_tail()
to restore the resource's bulk_move membership.

However, ttm_resource_move_to_lru_tail() places the resource at the tail
of the LRU list which, relative to the walk cursor's hitch node (placed
immediately after the resource when it was yielded), puts the resource
*in front of the* the hitch. The next list_for_each_entry_continue() from
the hitch finds the same resource again, causing an infinite loop.

Fix by deferring del_bulk_move to the success path only.

On the success path, TTM_TT_FLAG_SWAPPED has just been set by
ttm_tt_swapout() but the resource is still tracked in the bulk_move range,
so ttm_resource_del_bulk_move()'s !ttm_resource_unevictable() guard would
incorrectly skip the removal. Introduce
ttm_resource_del_bulk_move_unevictable() which bypasses that guard.

Reported-by: Jatin Kataria <jkataria@netflix.com>
Fixes: fc5d96670eb2 ("drm/ttm: Move swapped objects off the manager's LRU list")
Cc: Christian König <christian.koenig@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <dri-devel@lists.freedesktop.org>
Cc: <stable@vger.kernel.org> # v6.13+
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Tested-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260428094442.16985-1-thomas.hellstrom@linux.intel.com

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d85f0a37ac35..293401705542 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1177,17 +1177,13 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 		bdev->funcs->swap_notify(bo);
 
 	if (ttm_tt_is_populated(tt)) {
-		spin_lock(&bdev->lru_lock);
-		ttm_resource_del_bulk_move(bo->resource, bo);
-		spin_unlock(&bdev->lru_lock);
-
 		ret = ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
-
-		spin_lock(&bdev->lru_lock);
-		if (ret)
-			ttm_resource_add_bulk_move(bo->resource, bo);
-		ttm_resource_move_to_lru_tail(bo->resource);
-		spin_unlock(&bdev->lru_lock);
+		if (!ret) {
+			spin_lock(&bdev->lru_lock);
+			ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
+			ttm_resource_move_to_lru_tail(bo->resource);
+			spin_unlock(&bdev->lru_lock);
+		}
 	}
 
 out:
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 9f36631d48b6..0e5f1582f13d 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -292,6 +292,19 @@ void ttm_resource_del_bulk_move(struct ttm_resource *res,
 		ttm_lru_bulk_move_del(bo->bulk_move, res);
 }
 
+/*
+ * Remove a resource from its bulk_move, bypassing the unevictable check.
+ * Use only when the resource is known to still be tracked in the range despite
+ * the BO having just become unevictable; asserts that this is the case.
+ */
+void ttm_resource_del_bulk_move_unevictable(struct ttm_resource *res,
+					    struct ttm_buffer_object *bo)
+{
+	WARN_ON_ONCE(!ttm_resource_unevictable(res, bo));
+	if (bo->bulk_move)
+		ttm_lru_bulk_move_del(bo->bulk_move, res);
+}
+
 /* Move a resource to the LRU or bulk tail */
 void ttm_resource_move_to_lru_tail(struct ttm_resource *res)
 {
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index 33e80f30b8b8..a5d386583fb6 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -448,6 +448,8 @@ void ttm_resource_add_bulk_move(struct ttm_resource *res,
 				struct ttm_buffer_object *bo);
 void ttm_resource_del_bulk_move(struct ttm_resource *res,
 				struct ttm_buffer_object *bo);
+void ttm_resource_del_bulk_move_unevictable(struct ttm_resource *res,
+					    struct ttm_buffer_object *bo);
 void ttm_resource_move_to_lru_tail(struct ttm_resource *res);
 
 void ttm_resource_init(struct ttm_buffer_object *bo,

