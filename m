Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D88EC5CFC1
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 01:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CEC10E23F;
	Sun, 16 Aug 2026 01:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HUC++z9+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5758510E23F;
 Sun, 16 Aug 2026 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786844761; x=1818380761;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=It30WGELctoJSQf1hi57IpECUFR9aIkATg1Jg7hD7nw=;
 b=HUC++z9+C5b7G+0JykFOjs8+RsxTMpFkOxJqCt3GJGYKC6JucF+9TlzS
 e82huse5MrfKMSkQ++Xd/PmtwiydjPPP7qH+OiJcrCCxoDdu0oBuBanbP
 KOrbPVDSvghUSP/cWrJHEQwLOuo5uYQXtagkkUNt3mgGi6iYWPfcf6eBD
 5j+2ZhVslPM13P6F5uameYNoYl5ahGDZOK+NOFi+qY2g7HWKrBa8CmUZ6
 weW5OdyLOrkysVMsmYKRsSfMlLYgy3oBQ+3sxkgpA9TuOYodF5P816fTH
 YW9SA95hdAHN4RgQjy4Mu5yXdCcOyRLFMTTY9TmTpThH+qxt9maBUuiO9 w==;
X-CSE-ConnectionGUID: IRkCMf+OTIO5bGDQm7i1OQ==
X-CSE-MsgGUID: lUW79Mb7TWWxRTcG7Q+AJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="98729442"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; d="scan'208";a="98729442"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2026 18:46:00 -0700
X-CSE-ConnectionGUID: Wm91vM66T9qkYSiYchjHDg==
X-CSE-MsgGUID: kQauwJtHQKemrJyICo5qIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; d="scan'208";a="269760674"
Received: from clke06vm103.fm.intel.com (HELO clke06vm103.amr.corp.intel.com)
 ([10.80.128.218])
 by fmviesa005.fm.intel.com with ESMTP; 15 Aug 2026 18:46:00 -0700
From: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, matthew.auld@intel.com,
 thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org,
 Krishna Prabhakaran <krishna.prabhakaran@intel.com>
Subject: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Date: Sat, 15 Aug 2026 18:45:52 -0700
Message-ID: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
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

Flush only the pages that actually need it instead:

 - If we imported one of our own dma-bufs, the backing object is
   struct-page backed once migrated to SMEM, so flush it directly with
   drm_clflush_sg(), exactly as we flush our other objects. This also
   avoids re-entering the exporter through dma_buf_vmap(), which would
   recurse into i915_gem_object_pin_map() on the source object we
   already hold locked (and fails the igt_dmabuf_import_same_driver
   selftest with -EBUSY).

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
v2:
 - Flush our own imported dma-bufs directly with drm_clflush_sg() instead of
   dma_buf_vmap(), which re-entered i915_gem_object_pin_map() on the source
   object and failed igt_dmabuf_import_same_driver_smem with -EBUSY (reported
   by Intel CI on v1). Foreign dma-bufs still use dma_buf_vmap() +
   drm_clflush_virt_range(); wbinvd only as fallback.
 - Link to v1: https://patchwork.freedesktop.org/patch/744955/?series=171760

 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 55 ++++++++++++++++++----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index b43d34c7d641..c798a90f1c0f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -10,6 +10,8 @@
 
 #include <asm/smp.h>
 
+#include <drm/drm_cache.h>
+
 #include "gem/i915_gem_dmabuf.h"
 #include "i915_drv.h"
 #include "i915_gem_object.h"
@@ -249,16 +251,53 @@ static int i915_gem_object_get_pages_dmabuf(struct drm_i915_gem_object *obj)
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
+			 * We imported one of our own dma-bufs. The backing
+			 * object is struct-page backed once migrated to SMEM,
+			 * so flush it directly, the same way we flush our
+			 * other objects. This also avoids re-entering the
+			 * exporter through dma_buf_vmap(), which would recurse
+			 * into i915_gem_object_pin_map() on the source object
+			 * we already hold locked.
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
 

base-commit: 682ea2d28d18bb06f9fc663cb5ab7e80dc0e606a
-- 
2.43.0

