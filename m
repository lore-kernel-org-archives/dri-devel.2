Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B2AC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE25610E43B;
	Wed,  2 Sep 2026 19:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mtK7d3w5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E9DF10E43B;
 Wed,  2 Sep 2026 19:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788377525; x=1819913525;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wz5xNFAguyQKt79gMIwIhCHy5/68ybbYq0ip6RUB71k=;
 b=mtK7d3w5FoBOrMf0f3BhyB3VvRzaMAY19ge5HycaXxNAJtnKBb7mONuI
 rM+MbHyKGCL0MT1Awpluf24gmdrBYLhZb91MTNM1JvMmW49Lot+9lCtWy
 JSrFTOUJ/0+XnPkmSzHBoKrCXl6OzKNHimaomqA/kYxfjDClWBTwG058k
 v5T3CLph4o/JuHMvKwsUJnUamWNEG42ggpHIMiSTKoO1CCSg8+STyI+K8
 9B0uAK+XBHyUWCuYGtXYEfByXcto+3Y8ru7aWHp+rcEcNZGv5QzyVETuW
 n1r+fHzEoO7cma1Kq0vBuogajh/QWxIO/IDbixymf+RZY0MzQv1/9LYIl A==;
X-CSE-ConnectionGUID: hVUAF2iAQoWTG7KyNBNxZA==
X-CSE-MsgGUID: x2RROzMCRa6tHu6G9SIMUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="111622001"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="111622001"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 12:32:05 -0700
X-CSE-ConnectionGUID: En4Ike+DRoaopBA27eHvBA==
X-CSE-MsgGUID: c6c8eZSuScGj1wTDSurGqQ==
X-ExtLoop1: 1
Received: from clke06vm103.fm.intel.com (HELO clke06vm103.amr.corp.intel.com)
 ([10.80.128.218])
 by fmviesa003.fm.intel.com with ESMTP; 02 Sep 2026 12:32:04 -0700
From: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Krishna Prabhakaran <krishna.prabhakaran@intel.com>
Subject: [PATCH v4] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Date: Wed,  2 Sep 2026 12:31:47 -0700
Message-ID: <20260902193147.3835028-1-krishna.prabhakaran@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820205031.344338-1-krishna.prabhakaran@intel.com>
References: <20260820205031.344338-1-krishna.prabhakaran@intel.com>
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

Flush only the pages that actually need it instead:

 - If we imported one of our own dma-bufs, the backing object is
   normally struct-page backed once migrated to SMEM, so flush it
   directly with drm_clflush_sg(), exactly as we flush our other
   objects. This also avoids re-entering the exporter through
   dma_buf_vmap(), which would recurse into i915_gem_object_pin_map()
   on the source object we already hold locked (and fails the
   igt_dmabuf_import_same_driver selftest with -EBUSY). SMEM does not
   guarantee the struct-page flag though: phys objects clear it and it
   is dropped transiently during TTM moves, and drm_clflush_sg() walks
   the sgt with sg_page(), so guard the direct flush with
   i915_gem_object_has_struct_page() and fall back to wbinvd when it is
   not set.

 - For a foreign dma-buf the sg_table is not guaranteed to be backed by
   struct pages, and the importer has no way to tell, so drm_clflush_sg()
   cannot be used. vmap the buffer and flush that virtual range with
   drm_clflush_virt_range() instead: x86 uses PIPT caches, so flushing
   one virtual alias evicts the cache lines for every alias of the same
   physical pages. The dma_resv lock required by dma_buf_vmap() is
   already held here via the imported object.

Fall back to wbinvd only when the buffer cannot be vmapped or is backed
by I/O memory, where there is no CPU-side range to clflush.

Fixes: a035154da45d ("drm/i915/dmabuf: add paranoid flush-on-acquire")
Signed-off-by: Krishna Prabhakaran <krishna.prabhakaran@intel.com>
---
v4: Guard the own-dma-buf direct drm_clflush_sg() with
    i915_gem_object_has_struct_page() and fall back to wbinvd when the
    SMEM object is not struct-page backed (phys objects, transient TTM
    moves); sg_page() would otherwise walk bogus pages. (review feedback)
v3: Drop the wbinvd fallback inside the own-dma-buf branch; the exporter is
    migrated to SMEM on attach, so flushing device memory made no sense.
    (Matthew Auld)
v2: Special-case our own dma-bufs with drm_clflush_sg() instead of
    dma_buf_vmap(), which recursed into i915_gem_object_pin_map() on the
    already-locked source object and failed igt_dmabuf_import_same_driver
    with -EBUSY; foreign dma-bufs use vmap + drm_clflush_virt_range().
v1: https://patchwork.freedesktop.org/series/171760/
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 62 +++++++++++++++++++---
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index b43d34c7d641..d1695171019c 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -10,6 +10,8 @@
 
 #include <asm/smp.h>
 
+#include <drm/drm_cache.h>
+
 #include "gem/i915_gem_dmabuf.h"
 #include "i915_drv.h"
 #include "i915_gem_object.h"
@@ -249,16 +251,60 @@ static int i915_gem_object_get_pages_dmabuf(struct drm_i915_gem_object *obj)
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
+
+		if (dma_buf->ops == &i915_dmabuf_ops) {
+			struct drm_i915_gem_object *dma_obj =
+				dma_buf_to_obj(dma_buf);
+
+			/*
+			 * We imported one of our own dma-bufs. The exporter is
+			 * migrated to SMEM on attach, so it is normally struct-page
+			 * backed and we can flush it directly, the same way we
+			 * flush our other objects. This also avoids re-entering
+			 * the exporter through dma_buf_vmap(), which would
+			 * recurse into i915_gem_object_pin_map() on the source
+			 * object we already hold locked.
+			 *
+			 * SMEM does not guarantee the STRUCT_PAGE flag though: phys
+			 * objects clear it and it is dropped transiently during TTM
+			 * moves. drm_clflush_sg() walks the sgt with sg_page(), so
+			 * without struct pages those pointers are bogus; fall back to
+			 * wbinvd in that case (not the vmap path, which would recurse
+			 * on the already-locked source object).
+			 */
+			if (i915_gem_object_has_struct_page(dma_obj))
+				drm_clflush_sg(dma_obj->mm.pages);
+			else
+				wbinvd_on_all_cpus();
+		} else {
+			struct iosys_map map;
+
+			/*
+			 * A foreign sg_table is not guaranteed to be backed by
+			 * struct pages, so we cannot use drm_clflush_sg(). vmap
+			 * the buffer and flush the virtual range instead; x86
+			 * uses PIPT caches, so flushing one alias evicts the
+			 * lines for every alias of the same physical pages.
+			 *
+			 * We already hold the dma_resv lock via the imported
+			 * obj, so use the locked dma_buf_vmap() variant.
+			 */
+			if (!dma_buf_vmap(dma_buf, &map)) {
+				if (!map.is_iomem)
+					drm_clflush_virt_range(map.vaddr,
+							       obj->base.size);
+				else
+					wbinvd_on_all_cpus();
+				dma_buf_vunmap(dma_buf, &map);
+			} else {
+				wbinvd_on_all_cpus();
+			}
+		}
+	}
 
 	__i915_gem_object_set_pages(obj, sgt);
 
-- 
2.43.0

