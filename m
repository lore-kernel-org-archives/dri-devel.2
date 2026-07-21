Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132FAC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7157D10E39A;
	Tue, 21 Jul 2026 17:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mRSjvVV9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6854D10E397;
 Tue, 21 Jul 2026 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784656050; x=1816192050;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nKJKT/P+qEgUMo/wDI71pfPxFpDWy8cquVcetFsF/9A=;
 b=mRSjvVV9d8MQu08ApQ8EQncYK+mFljP/0uOmnpNXKh7G052RCztBnPPQ
 nJTYD1lqmd/oJczestI+byqYfsrUVKVVZohc7/inxmDRRsSueJ8nHelMJ
 Dcux2tnAZqt8aonkPvNqMUdksecLqpXViFwCsh4ymknFgqyHeI+EGNzA8
 dfHxY3HnmT4mHGdZ1g4pT2Ad7OlnwSrwSvsu9heiMokYubKKbdaT8Nmb1
 PUphUEkzWciPeuq8svpkufecC4RF80itHZwSdaDCXQIP66Xt0Vzw43LnL
 +vrOFWPwPkyrKV7uZlSC5UFceB2NNItUoRZk8y5sNFg34zGO7id1J4Utz g==;
X-CSE-ConnectionGUID: Gs2wI4uNSY2zcB29pgpJGQ==
X-CSE-MsgGUID: EvqeMWqeQROoI0Z3ZdvbUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="95920605"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="95920605"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 10:47:30 -0700
X-CSE-ConnectionGUID: aX85PhGqRZ2+OzCWKl4KjA==
X-CSE-MsgGUID: C9cUg2WjRnO17Cple9Z0iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="254418016"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 10:47:29 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] drm/ttm: use shmem_backup_folio() for folio backup
Date: Tue, 21 Jul 2026 10:47:23 -0700
Message-Id: <20260721174723.1039395-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721174723.1039395-1-matthew.brost@intel.com>
References: <20260721174723.1039395-1-matthew.brost@intel.com>
MIME-Version: 1.0
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

Replace the open-coded shmem-backup loop in ttm_backup_backup_folio()
with a thin wrapper around the new shmem_backup_folio() helper. The
wrapper maps the helper's (int errno, *nr_pages_backed) contract onto
TTM's existing (s64 handle) return convention:

  - 0                                     -> base handle
  - -ENOMEM with *nr_pages_backed > 0     -> base handle (short backup;
                                             partial progress kept)
  - any other error                       -> that error verbatim

The mid-compound -ENOMEM fault-injection point that used to live
inside the per-subpage loop moves up to the wrapper and takes a new
shape: instead of synthesizing an error partway through the loop, the
wrapper passes order-1 to shmem_backup_folio() when
ttm_backup_fault_inject_folio() fires. shmem_backup_folio() then
backs up the first half of the compound normally, returns 0 with
*nr_pages_backed = (1 << (order - 1)), and TTM's caller sees the same
"short backup, nr_backed < (1 << order)" it would see on a real
mid-compound OOM and drives its reactive-split path unchanged.
Injection is skipped for order == 0 since there is nothing to shrink;
the previous "inject only on i > 0" guard mapped onto the same
observable subset of runs.

No functional change intended for non-injection paths.

Cc: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: GitHub-Copilot:claude-sonnet-5

---

The patch is based on drm-tip rather than the core MM branches to
facilitate Intel CI testing and initial review. It can be rebased onto
the core MM branches in a subsequent revision.
---
 drivers/gpu/drm/ttm/ttm_backup.c | 91 ++++++++------------------------
 1 file changed, 21 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 3c067aadc52d..a6c4e6cb643b 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -105,76 +105,27 @@ ttm_backup_backup_folio(struct file *backup, struct folio *folio,
 			gfp_t folio_gfp, gfp_t alloc_gfp,
 			pgoff_t *nr_pages_backed)
 {
-	struct address_space *mapping = backup->f_mapping;
-	int nr_pages = 1 << order;
-	struct folio *to_folio;
-	int ret, i;
-
-	*nr_pages_backed = 0;
-
-	for (i = 0; i < nr_pages; ) {
-		int to_nr, j;
-
-		/*
-		 * Only inject past the first subpage so *nr_pages_backed is
-		 * always > 0 here, matching a genuine mid-compound -ENOMEM
-		 * and driving the caller's reactive split fallback instead
-		 * of an early, no-progress failure.
-		 */
-		if (IS_ENABLED(CONFIG_FAULT_INJECTION) && i &&
-		    ttm_backup_fault_inject_folio())
-			to_folio = ERR_PTR(-ENOMEM);
-		else
-			to_folio = shmem_read_folio_gfp(mapping, idx + i, alloc_gfp);
-		if (IS_ERR(to_folio)) {
-			int err = PTR_ERR(to_folio);
-
-			if (err == -ENOMEM && *nr_pages_backed)
-				return ttm_backup_shmem_idx_to_handle(idx);
-
-			if (*nr_pages_backed) {
-				shmem_truncate_range(file_inode(backup),
-						     (loff_t)idx << PAGE_SHIFT,
-						     ((loff_t)(idx + i) << PAGE_SHIFT) - 1);
-				/*
-				 * The pages just truncated are no longer
-				 * backed up; don't let the caller mistake
-				 * them for valid handles.
-				 */
-				*nr_pages_backed = 0;
-			}
-			return err;
-		}
-
-		to_nr = min_t(int, nr_pages - i,
-			      folio_next_index(to_folio) - (idx + i));
-
-		folio_mark_accessed(to_folio);
-		folio_lock(to_folio);
-		folio_mark_dirty(to_folio);
-
-		for (j = 0; j < to_nr; j++)
-			copy_highpage(folio_file_page(to_folio, idx + i + j),
-				      folio_page(folio, i + j));
-
-		if (writeback && !folio_mapped(to_folio) &&
-		    folio_clear_dirty_for_io(to_folio)) {
-			folio_set_reclaim(to_folio);
-			ret = shmem_writeout(to_folio, NULL, NULL);
-			if (!folio_test_writeback(to_folio))
-				folio_clear_reclaim(to_folio);
-			if (ret == AOP_WRITEPAGE_ACTIVATE)
-				folio_unlock(to_folio);
-		} else {
-			folio_unlock(to_folio);
-		}
-
-		folio_put(to_folio);
-		i += to_nr;
-		*nr_pages_backed = i;
-	}
-
-	return ttm_backup_shmem_idx_to_handle(idx);
+	unsigned int backup_order = order;
+	int err;
+
+	/*
+	 * Fault injection: back up only the first half of the folio to
+	 * simulate a mid-compound OOM. The caller sees *nr_pages_backed
+	 * < (1 << order) on success and drives its reactive-split path
+	 * exactly as it would on a real short return. order == 0 cannot
+	 * be shrunk further, so injection is skipped in that case.
+	 */
+	if (IS_ENABLED(CONFIG_FAULT_INJECTION) && order &&
+	    ttm_backup_fault_inject_folio())
+		backup_order = order - 1;
+
+	err = shmem_backup_folio(folio, backup, idx, alloc_gfp, backup_order,
+				 nr_pages_backed, writeback);
+
+	if (!err || (err == -ENOMEM && *nr_pages_backed))
+		return ttm_backup_shmem_idx_to_handle(idx);
+
+	return err;
 }
 
 /**
-- 
2.34.1

