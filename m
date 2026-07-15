Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DE9C4450E
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 04:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC4A010EEB4;
	Wed, 15 Jul 2026 04:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="A76UYnqO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A6C10E10C;
 Wed, 15 Jul 2026 04:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784089720; x=1815625720;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=++FMMRipgho53Hb2CqoFUV6ggoh6ZB2u9RyypMpVm/0=;
 b=A76UYnqOSmx1rjiQqIcV0yk7U5NbJ9ZAK/tTEXc03gjPSp6osUz09uWS
 e+XQyGIlXiyFvnvwHcmxckAO1p1874mTNpUKQuF9u+AssEQfbVk8OCsUR
 /vzwk3L2iFMoeRuXmRT9moV2fS+1A1bKDJm8ThnoL6UQexicbMW32iR2h
 HBh7Zv3XgXnL72jPCdfpFot6++urF14fbuvX6RfBcvCm/mSXpSwCi9jqr
 TD6hO94cySSlvxckQkfV8rOmjz4IPccWjyKNLJyRccHc5I+CxpjHMcxHN
 0PXOVE7Jy3iUfJCTJ+PW3qbauE6XqZEcp80gOf1eFbypzM2oHDyA0ry0k A==;
X-CSE-ConnectionGUID: j3OvRJcLTFKFc6u5iKbiRA==
X-CSE-MsgGUID: 9mQfjAmNS021zmZ9BylSRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88542518"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="88542518"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 21:28:40 -0700
X-CSE-ConnectionGUID: hB/YtED0STuqsmo+Zm9u+A==
X-CSE-MsgGUID: JaHAhWJcQlmoKT/e0mAMtg==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 21:28:40 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>,
	Ryan Neph <ryanneph@google.com>
Subject: [PATCH v2 4/4] drm/xe: Lower BO TTM priority to lowest when fully
 unmapped from VM
Date: Tue, 14 Jul 2026 21:28:32 -0700
Message-Id: <20260715042832.3625096-5-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715042832.3625096-1-matthew.brost@intel.com>
References: <20260715042832.3625096-1-matthew.brost@intel.com>
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

An UNMAP (or the unmap half of a REMAP) can leave a BO with no
remaining VMA mappings anywhere. Such a BO is unlikely to be touched
again soon, so rather than leaving it at whatever priority band it had
while still in active use, drop it to XE_BO_PRIORITY_LOW, the lowest
level, so it becomes one of the first candidates considered for
eviction/shrinking. This applies both to BOs private to a VM and to
extobjs shared across multiple VMs (bo->vm == NULL) -- an extobj with
no bindings left anywhere is just as good an eviction/shrink candidate
as an unmapped private BO. Imported bos are excluded, since their
vma_count is never tracked (xe_bo_vma_count_inc/dec_locked() are
no-ops for them), so it would never reflect anything meaningful.

This has to be done inside xe_vma_destroy() itself, right after
xe_bo_vma_count_dec_locked(), rather than by its callers after the
fact: xe_vma_destroy() may drop the last reference to the BO via
xe_bo_put() in xe_vma_destroy_late() (called either synchronously, or
asynchronously via a fence callback), so a caller that stashed a
pointer to the BO before calling xe_vma_destroy() and then dereferences
it afterwards risks a use-after-free. Doing the check and update
before that possible final put avoids this.

bo->purgeable.vma_count, which xe_bo_vma_count_dec_locked() just
updated, tells us whether the BO has become fully unmapped. A REMAP
that only shrinks a mapping still leaves vma_count > 0 via the
prev/next VMA(s) created earlier in the bind, so those are correctly
left untouched. This runs under the BO's dma-resv, already asserted
held via xe_bo_assert_held() just above.

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Assisted-by: GitHub_Copilot:claude-sonnet-5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index d42390e7ae2f..8f3827f957ea 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1282,6 +1282,22 @@ static void xe_vma_destroy(struct xe_vma *vma, struct dma_fence *fence)
 		xe_bo_vma_count_dec_locked(bo);
 		if (vma->attr.purgeable_state == XE_MADV_PURGEABLE_WILLNEED)
 			xe_bo_willneed_put_locked(bo);
+
+		/*
+		 * @bo has just lost a VMA mapping. If it now has none left
+		 * anywhere, it is unlikely to be used again soon, so lower
+		 * its TTM priority to the lowest level, making it one of the
+		 * first buffers considered for eviction/shrinking. This
+		 * applies both to BOs private to @vm and to extobjs shared
+		 * across multiple VMs (bo->vm == NULL), but not to imported
+		 * bos, whose vma_count is never tracked. Must be done here,
+		 * rather than by the caller, as this may be the last
+		 * reference to @bo (see xe_vma_destroy_late()).
+		 */
+		if (!drm_gem_is_imported(&bo->ttm.base) &&
+		    !bo->purgeable.vma_count &&
+		    bo->ttm.priority != XE_BO_PRIORITY_LOW)
+			xe_bo_update_ttm_priority(bo, XE_BO_PRIORITY_LOW);
 	}
 
 	xe_vm_assert_held(vm);
-- 
2.34.1

