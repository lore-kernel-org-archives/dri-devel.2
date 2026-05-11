Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BBACD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 16:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808B710E80C;
	Mon, 11 May 2026 16:25:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VG1jFpyC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05FF010E808;
 Mon, 11 May 2026 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778516708; x=1810052708;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lwopUE8/yDCHMwZy/+ucK4EpsJaJ9gDkggd5H3h/eZo=;
 b=VG1jFpyCGBQjIke2BzJ74EKO5RUOgaVtpWasWv8UWwIKhRyOi790NHLE
 QSfkYFBDC95w0ejXIgXX3ftJHn+jZD4yYbxeV3mkVLcMLRRvUu8owvnEm
 qeCZIYgVbg4jdm8CWfSMDPmBBk6lXm8flmHL90LxeySr15I5+KcKOK/hz
 oga1H1tC1VIT4RcBB9WMI+npXgJoBUfMvV8P7m6VlGUwTy3LZDy17zS1r
 xqDxLk9dkiOQZu6ke6dlqfmbReOS4ZZkyz2VW1VrKXyuExs6vrZtJUj5b
 X4dWPEinj7oXDTb3oY0J+VznWKw0g8+gLLEy3D3bJJXv0ElO+yqjla/31 A==;
X-CSE-ConnectionGUID: 0n46+M+8Q9aFH8b4zjwumg==
X-CSE-MsgGUID: XDIzU1CvRQO60UhsUaTfJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83023048"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="83023048"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 09:25:07 -0700
X-CSE-ConnectionGUID: 8OSRMlNfSUOOjgD1CkPVvg==
X-CSE-MsgGUID: sbKhPI1OTFy9cYaycmlv8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="241489203"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora)
 ([10.245.244.248])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 09:25:05 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Dave Airlie <airlied@redhat.com>,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: [PATCH] drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup
 failure
Date: Mon, 11 May 2026 18:24:43 +0200
Message-ID: <20260511162443.24352-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
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
Cc: <stable@vger.kernel.org> # v6.15+
Assisted-by: GitHub_Copilot:claude-opus-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index f83b7d5ec6c6..3e3c201a0222 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -1112,19 +1112,14 @@ long ttm_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
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
 
-- 
2.54.0

