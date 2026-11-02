Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE41606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=evy1iy0t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF43B10E5DE;
	Mon,  2 Nov 2026 09:45:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C941410E5DB;
 Mon,  2 Nov 2026 09:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793612745; x=1825148745;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+lA8oKBDk3tnCrkPPLEk6vNrCDyQERrNePWq8xzRsbI=;
 b=evy1iy0tXEIbapbqk6ejq0hCTU+QW2RNMOW/lO/rqs0/Jg/41cWKbOMe
 lOU+RdLV51rW31HHv+SC6sQdizT8q/7OEraPgEutZ4+08jFyPycqNGaVN
 VHfy1iQhJLQn0RLdSPLFwZCfycrpRLFVUnsCP5WHVrrgKRRF8ErTEQqEQ
 nA7h6T4Pw9Vzmd4XyEFu8rSHIMzcK1Zg3F3+QDXLmWZrgHVzL0f28u3q7
 jnVEa4fTC4tBOqpQ1ccpEa9VdMT3GzwM86+9Op94JxKiRsicATZr4abG6
 aTdmgUoMU//0iOyjhc/L3sun8tyArVcvXHWPxUV6YqvvmD0y+wXBird48 Q==;
X-CSE-ConnectionGUID: AV6lc2BsQX27vpEOVjNLRw==
X-CSE-MsgGUID: +RWI5UplT5W8pthwCxz26g==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2184604"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2184604"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 01:45:44 -0800
X-CSE-ConnectionGUID: 8mOEQivPSC2ggibO1ITdYA==
X-CSE-MsgGUID: Ghj2aRADTIKK+pGyOK0mIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6401723"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 01:45:43 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2] drm/xe: Tear down kernel mappings in release_notify
Date: Mon,  2 Nov 2026 15:15:29 +0530
Message-ID: <20261102094529.785224-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xe_gem_object_free() calls __xe_bo_vunmap() without holding the BO
reservation. The last GEM reference does not exclude TTM eviction,
which takes a separate reference on the TTM BO.

Eviction can free the resource while ttm_bo_kunmap() is using it.
ttm_mem_io_free() can then clear bus.addr and bus.offset in the freed
resource. This is consistent with the 16 zeroed bytes reported by
SLUB for a resource freed by xe_ttm_vram_mgr_del() during eviction.

Move the final unmap to xe_ttm_bo_release_notify(). It runs when the
TTM BO refcount reaches zero, so eviction and swapout can no longer
take a reference, and before TTM frees the resource and backing pages.

Also unmap real Xe BOs under the reservation lock in xe_bo_shrink().
When the GEM refcount is already zero, the shrinker can purge the BO
without calling xe_bo_move_notify(). Unmapping before the reclaim
branches prevents pages from being freed while the kernel mapping
remains active, including for BOs already in SYSTEM placement.
Skip TTM ghost objects, which do not contain the Xe mapping fields.

v2:
 - Unmap real Xe BOs under the reservation lock before shrinking.
   (Sashiko)

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 42a6aa1a2e4a..0793ed59a90a 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1454,6 +1454,10 @@ long xe_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
 	if (!xe_bo_eviction_valuable(bo, &place))
 		return -EBUSY;
 
+	/* Shrinking can free pages without calling xe_bo_move_notify(). */
+	if (xe_bo_is_xe_bo(bo))
+		xe_bo_vunmap(xe_bo);
+
 	if (!xe_bo_is_xe_bo(bo) || !xe_bo_get_unless_zero(xe_bo))
 		return xe_bo_shrink_purge(ctx, bo, scanned);
 
@@ -1866,6 +1870,12 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
 	bo = ttm_to_xe_bo(ttm_bo);
 	xe_assert(xe_bo_device(bo), !(bo->created && kref_read(&ttm_bo->base.refcount)));
 
+	/*
+	 * The TTM BO refcount is zero, so eviction and swapout cannot
+	 * take a reference. Unmap before TTM frees the backing store.
+	 */
+	__xe_bo_vunmap(bo);
+
 	if (!xe_ttm_bo_lock_in_destructor(ttm_bo))
 		return;
 
@@ -2056,7 +2066,6 @@ static void xe_gem_object_free(struct drm_gem_object *obj)
 	 * driver ttm callbacks is allowed to use the ttm_buffer_object
 	 * refcount directly if needed.
 	 */
-	__xe_bo_vunmap(gem_to_xe_bo(obj));
 	ttm_bo_fini(container_of(obj, struct ttm_buffer_object, base));
 }
 
-- 
2.43.0

