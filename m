Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EF3C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECBAC10F3FB;
	Fri,  7 Aug 2026 04:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bI+kdRRs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD7210F3F8;
 Fri,  7 Aug 2026 04:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077274; x=1817613274;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AUi+gCo4kulH2npNlvS/HOJU4ckriZuI9b2wAGE7mVA=;
 b=bI+kdRRsyimRTDS695ZOaIdm+xJoKT0NcPfCu94+Y+CLYd4jTBMCrtZR
 GlecDgExViq7a/XBX18RuJvo2KaOGCph5hrljmxkuN+xvwslA+l5+tuJ9
 b0DuteseuS4zYRKWVEGq6q2yXN6lS4uUisq7OIUXUHytHqBYW3A3AgrLr
 9XZJtZhESRlULMSB1lmzUJluKE0TnC9i0C+MSXyDQsLVyrcRw73Gu1WVx
 ONg7kwrNtFHO5SPK9YD+w7rCrWi4OQ5da0/XQQJWx5mXBYrloSdFTgbne
 qo0CwFO0utefhLK5e4aAypfyuE4SZ7da3DbI4N1jW1izfdMXhS3nUYTko g==;
X-CSE-ConnectionGUID: +JFNlBUVTL+fZ3Uee3M13w==
X-CSE-MsgGUID: HMtev+v/TrGuILCfXJsttw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85653383"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="85653383"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:34:34 -0700
X-CSE-ConnectionGUID: bDxFfp/sTOuFx1O/+pfPaQ==
X-CSE-MsgGUID: OWYw+UjRQH22nuF15Ygnsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="265773919"
Received: from clke06vm103.fm.intel.com (HELO clke06vm103.amr.corp.intel.com)
 ([10.80.128.218])
 by orviesa003.jf.intel.com with ESMTP; 06 Aug 2026 21:34:34 -0700
From: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, sumit.semwal@linaro.org, christian.koenig@amd.com,
 Krishna Prabhakaran <krishna.prabhakaran@intel.com>
Subject: [PATCH 1/1] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Date: Thu,  6 Aug 2026 21:33:26 -0700
Message-ID: <20260807043326.556767-1-krishna.prabhakaran@intel.com>
X-Mailer: git-send-email 2.43.0
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

From: Krishna Prabhakaran <krishna.prabhakaran@intel.com>

When i915 needs to make an imported dma-buf coherent for GPU access on
non-LLC platforms, or for objects that bypass LLC, it currently calls
wbinvd_on_all_cpus(). get_pages() runs whenever an imported buffer is
pinned, so this triggers a whole-cache write-back and invalidate,
broadcast by IPI to every CPU, on every execbuf submission involving an
imported dma-buf. That stalls the entire machine for milliseconds and
starves latency-sensitive work on unrelated cores (e.g. USB isochronous
audio serviced on the VMM's main thread).

A dma-buf sg_table is not guaranteed to be backed by struct pages, and
the importer has no way to tell, so drm_clflush_sg() cannot be used
here. Instead vmap the buffer and flush that virtual range with
drm_clflush_virt_range(): x86 uses PIPT caches, so flushing one virtual
alias evicts the cache lines for every alias of the same physical
pages. This provides the required coherency, locally and without an IPI.

Fall back to wbinvd only when the buffer cannot be vmapped or is backed
by I/O memory, where there is no CPU-side range to clflush. The
dma_resv lock required by dma_buf_vmap() is already held here via the
imported object.

Fixes: a035154da45d ("drm/i915/dmabuf: add paranoid flush-on-acquire")
Signed-off-by: Krishna Prabhakaran <krishna.prabhakaran@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 26 +++++++++++++++-------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index b43d34c7d641..1c1f3dc9c212 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -10,6 +10,8 @@
 
 #include <asm/smp.h>
 
+#include <drm/drm_cache.h>
+
 #include "gem/i915_gem_dmabuf.h"
 #include "i915_drv.h"
 #include "i915_gem_object.h"
@@ -249,16 +251,24 @@ static int i915_gem_object_get_pages_dmabuf(struct drm_i915_gem_object *obj)
 	 * DG1 is special here since it still snoops transactions even with
 	 * CACHE_NONE. This is not the case with other HAS_SNOOP platforms. We
 	 * might need to revisit this as we add new discrete platforms.
-	 *
-	 * XXX: Consider doing a vmap flush or something, where possible.
-	 * Currently we just do a heavy handed wbinvd_on_all_cpus() here since
-	 * the underlying sg_table might not even point to struct pages, so we
-	 * can't just call drm_clflush_sg or similar, like we do elsewhere in
-	 * the driver.
 	 */
 	if (i915_gem_object_can_bypass_llc(obj) ||
-	    (!HAS_LLC(i915) && !IS_DG1(i915)))
-		wbinvd_on_all_cpus();
+	    (!HAS_LLC(i915) && !IS_DG1(i915))) {
+		struct dma_buf *dma_buf = obj->base.import_attach->dmabuf;
+		struct iosys_map map;
+		int vmap_ret;
+
+		/* We already hold the dma_resv lock via the imported obj. */
+		vmap_ret = dma_buf_vmap(dma_buf, &map);
+		if (!vmap_ret && !map.is_iomem) {
+			drm_clflush_virt_range(map.vaddr, obj->base.size);
+			dma_buf_vunmap(dma_buf, &map);
+		} else {
+			if (!vmap_ret)
+				dma_buf_vunmap(dma_buf, &map);
+			wbinvd_on_all_cpus();
+		}
+	}
 
 	__i915_gem_object_set_pages(obj, sgt);
 
-- 
2.43.0

