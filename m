Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A807FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CC610EABE;
	Tue, 28 Apr 2026 09:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lWsVbJ0W";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2320010EABE;
 Tue, 28 Apr 2026 09:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777369513; x=1808905513;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HtsGNwL7hZ0zkDzN6OgQLhPV3N5XrvY+T6jNJxzmLCE=;
 b=lWsVbJ0W7lNPrrDPTH7oYDjpC0/ygOqAfN3Dh1fgWHKIw2x5NSWYC5rj
 iL2CFvXapm3NEsclx1NOpvH7SHuRPvjg1WMOvA620xlwKMmql+pAdlVbP
 OEOZKg4mt2b2SNCKw1owR2zf/kyH+1W4EfZe+Nnxf81OIZ7fp1FYL5qLo
 7uf3ur0w7EXawEaf32eLge+oUuBsShPSN2D3KpryDHo1xZHjk8vQSZmg0
 ESf6o9yfMZNR1GgfGYl2QT6tDVOpOJh0gy3/YosLMgZBl+iLbP4gXxnQV
 qAkkTLi8UiypPXGOJsfM/L3RALAmhllIut7dm3qWOeUR84UBihUnrMMFx w==;
X-CSE-ConnectionGUID: TSgTmYXvTZWCv9XjBgQQdg==
X-CSE-MsgGUID: u90DSEK5T2qsBtV1ecU5Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89652819"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="89652819"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 02:45:13 -0700
X-CSE-ConnectionGUID: B6lNAgBATgqUnABcneHejw==
X-CSE-MsgGUID: pFBO/0EOSiuvmZStuD/9MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="257439238"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora)
 ([10.245.244.161])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 02:45:09 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Jatin Kataria <jkataria@netflix.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Boqun Feng <boqun@kernel.org>
Subject: [PATCH] drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout
 failure
Date: Tue, 28 Apr 2026 11:44:42 +0200
Message-ID: <20260428094442.16985-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
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
---
 drivers/gpu/drm/ttm/ttm_bo.c       | 16 ++++++----------
 drivers/gpu/drm/ttm/ttm_resource.c | 13 +++++++++++++
 include/drm/ttm/ttm_resource.h     |  2 ++
 3 files changed, 21 insertions(+), 10 deletions(-)

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
-- 
2.53.0

