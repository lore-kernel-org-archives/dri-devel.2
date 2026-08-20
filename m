Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB77C5DF86
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D0310E5EE;
	Thu, 20 Aug 2026 20:50:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XVBpjFBo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FF710E5EE;
 Thu, 20 Aug 2026 20:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787259040; x=1818795040;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dgGTwCTwZAsfTSp48nLA1ZNHU2/eAYEOAjDLsn5Eu9w=;
 b=XVBpjFBo4jplu7msV2cHN6soPOzu/AuPB/Bs2szLHV5H0laWgc5tw7cO
 6/SNVQ0F6+O8gq1Yz0JV5QkoDSnB5DtkP1PE//C+JPKgxTZUtrF51/b/f
 n9udWyoYTPPwtJ4Lmd9xmITluz115klGmFi8IgNUWlLyjAcdbr3MsFOYq
 +SNrJSnpbQqwzgr9yQUcKaJZ2uvlqlojHp9oePfJjECTI92byhA3Ui0AG
 nOV2aS4HuvFfKgUm4NhJdybx9EKzYF6T+nqCJBglAkiBrtm5s2htzUIRL
 5SKBvns2342ywBzclLXcDtzIaLZUKSj0ie972QC/koq/HxZCT1ccITX8l g==;
X-CSE-ConnectionGUID: 4X8rNeDCTFKdpLS3NaLUrg==
X-CSE-MsgGUID: tsb9xCFkRzKgAZFHIVidIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87867884"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="87867884"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 13:50:40 -0700
X-CSE-ConnectionGUID: kHWwQfAkR5qBKqvjdatRdQ==
X-CSE-MsgGUID: 2W7d9BBcTginRkRLv6pCKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="264844254"
Received: from clke06vm103.fm.intel.com (HELO clke06vm103.amr.corp.intel.com)
 ([10.80.128.218])
 by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 13:50:40 -0700
From: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net,
 dri-devel@lists.freedesktop.org,
 Krishna Prabhakaran <krishna.prabhakaran@intel.com>
Subject: [PATCH v3] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
Date: Thu, 20 Aug 2026 13:50:31 -0700
Message-ID: <20260820205031.344338-1-krishna.prabhakaran@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
References: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
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
v3:
 - Drop the wbinvd fallback in the own-dma-buf branch: the exporter is
   migrated to SMEM on attach, so it is always struct-page backed here;
   flushing device memory made no sense from i915's point of view
   (Matthew Auld).

v2:
 - Flush our own imported dma-bufs directly with drm_clflush_sg() instead of
   dma_buf_vmap(), which re-entered i915_gem_object_pin_map() on the source
   object and failed igt_dmabuf_import_same_driver_smem with -EBUSY (reported
   by Intel CI on v1). Foreign dma-bufs still use dma_buf_vmap() +
   drm_clflush_virt_range(); wbinvd only as fallback.
 - Link to v1: https://patchwork.freedesktop.org/patch/744955/?series=171760

 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 52 ++++++++++++++++++----
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index b43d34c7d641..fbf0e0d4b026 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -10,6 +10,8 @@
 
 #include <asm/smp.h>
 
+#include <drm/drm_cache.h>
+
 #include "gem/i915_gem_dmabuf.h"
 #include "i915_drv.h"
 #include "i915_gem_object.h"
@@ -249,16 +251,50 @@ static int i915_gem_object_get_pages_dmabuf(struct drm_i915_gem_object *obj)
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
+			 * migrated to SMEM on attach, so it is struct-page
+			 * backed and we can flush it directly, the same way we
+			 * flush our other objects. This also avoids re-entering
+			 * the exporter through dma_buf_vmap(), which would
+			 * recurse into i915_gem_object_pin_map() on the source
+			 * object we already hold locked.
+			 */
+			drm_clflush_sg(dma_obj->mm.pages);
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

