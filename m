Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2512606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DUTbARDE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA72010E5B5;
	Mon,  2 Nov 2026 08:26:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24AC910E5B5;
 Mon,  2 Nov 2026 08:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793607998; x=1825143998;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=k41mBmtJkuVXeJseFaZycWkbR33x7I/1nItYj3EU9ac=;
 b=DUTbARDE5waBIc1YS7sWIxypHxit/ImSKLgUX/xQpERNiFNMeQDiew4n
 XoKLZsymBoSDD4KpWKMlYV5GhHICwA8mDG9AF0Rk0jJBaCUxIlLn0LINH
 JL5D+Jg9tZawn0sVY7EtpH81b24/6Z8Nf6B+LamGgBAQx+lBMeggHTTiA
 YZmEqT6/Js6tnzxHvtaqYRf97cvhVNNyJmu1Y0BfR1rI7z3tqI1KfIBLU
 OmIxubPashXY5q5QtC+n23u3V5f5yMoMw1c91w7BSmrF9ZydQ8i5qp+5Q
 srBpDMKmgm2vcpgvkFf1IJl8uG96nrdMiswEfOO2++xuAqlgkfm+un8is w==;
X-CSE-ConnectionGUID: EH3ab8//RaGnRbHz9jds8A==
X-CSE-MsgGUID: 3I5OklrFQ9+zGAtXnZ0zeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2169611"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2169611"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 00:26:37 -0800
X-CSE-ConnectionGUID: zVUl1XY6Q3OKJFfd2Ys+iA==
X-CSE-MsgGUID: detXpDILRkixxWiZUQ5Atw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6414417"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 00:26:34 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 stable@vger.kernel.org
Subject: [PATCH] drm/xe: Tear down kernel mappings in release_notify
Date: Mon,  2 Nov 2026 13:56:26 +0530
Message-ID: <20261102082626.747462-1-arvind.yadav@intel.com>
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

Move __xe_bo_vunmap() to xe_ttm_bo_release_notify(). It runs when the
TTM BO refcount reaches zero, so eviction and swapout can no longer
take a reference, and before TTM frees the resource and backing pages.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 42a6aa1a2e4a..b7a982a9d81a 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1866,6 +1866,12 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
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
 
@@ -2056,7 +2062,6 @@ static void xe_gem_object_free(struct drm_gem_object *obj)
 	 * driver ttm callbacks is allowed to use the ttm_buffer_object
 	 * refcount directly if needed.
 	 */
-	__xe_bo_vunmap(gem_to_xe_bo(obj));
 	ttm_bo_fini(container_of(obj, struct ttm_buffer_object, base));
 }
 
-- 
2.43.0

