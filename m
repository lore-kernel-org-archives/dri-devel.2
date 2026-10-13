Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFD6CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79DCA10E3C3;
	Tue, 13 Oct 2026 12:11:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2ED810E3C3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:11:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B409405FF;
 Tue, 13 Oct 2026 12:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23621F000FF;
 Tue, 13 Oct 2026 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1791893513;
 bh=zOkc/l6koR2m86btVdLXNHN6N8T6mfQeDjLv7FobC0I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LCDvzXp+suVF1+DX9cKrCnNGm0rM7Sg6akLSSPIUDmjQMzDI/igazQdxe2D8P4zGq
 k27kE/JL7wdM1tKF3vXaJdFW7coVXLyd8OOPP3e0og4a6qYGWNLjOO+lFOMA72coOS
 jnFRjdwdueO4SsCy456mOXeoSFREuIdTLCQcUztw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 Jatin Kataria <jkataria@netflix.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Boqun Feng <boqun@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 207/621] drm/ttm: Fix ttm_bo_swapout() infinite LRU walk
 on swapout failure
Date: Tue, 13 Oct 2026 13:33:22 +0200
Message-ID: <20261013112925.773214291@linuxfoundation.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013112920.855194808@linuxfoundation.org>
References: <20261013112920.855194808@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

[ Upstream commit b2ed01e7ad3de80333e9b962a44024b094bc0b2b ]

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
Stable-dep-of: 1d59f36e95f7 ("drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c       | 16 ++++++----------
 drivers/gpu/drm/ttm/ttm_resource.c | 13 +++++++++++++
 include/drm/ttm/ttm_resource.h     |  2 ++
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d7a722d875cbc..493471012820e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1175,17 +1175,13 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
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
index 8396cab34cb03..a6a948fa0b83c 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -291,6 +291,19 @@ void ttm_resource_del_bulk_move(struct ttm_resource *res,
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
index f49daa504c36a..a4e3f0447d384 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -434,6 +434,8 @@ void ttm_resource_add_bulk_move(struct ttm_resource *res,
 				struct ttm_buffer_object *bo);
 void ttm_resource_del_bulk_move(struct ttm_resource *res,
 				struct ttm_buffer_object *bo);
+void ttm_resource_del_bulk_move_unevictable(struct ttm_resource *res,
+					    struct ttm_buffer_object *bo);
 void ttm_resource_move_to_lru_tail(struct ttm_resource *res);
 
 void ttm_resource_init(struct ttm_buffer_object *bo,
-- 
2.53.0



