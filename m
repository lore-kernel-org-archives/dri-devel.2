Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414B606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hsd4fGNE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B284210ECAB;
	Mon,  2 Nov 2026 10:14:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E30F10EC92;
 Mon,  2 Nov 2026 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793614444; x=1825150444;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0ceQo/tRTgufpd0EzjMfCZuyssVjECzNC7Mpv+r/mLA=;
 b=Hsd4fGNErTji84V1zAEY7KgQPADUPC9Fhz/CYoANbLF+TRI14ai8EZPg
 KS9P2tseH2eOZhQQ6calEFDbVmVhnY9tNk4AhgLLZhcz5i+YIOi7tLE9V
 ziF7QIorH0+A4gWhyffDQYY0YTwzcH8rpkr98aerNKXnWxLh3KDwlc0Zp
 148RggASH63ezisK0kfCGB/J/TdugfH5EM7qmGhPfHBNvTncibpkJW6WF
 U1DZIWS8C9w5VELNdr/K3m1NQOcylO7NLL7Gefbc+V/bOHpVnX/CdK9GH
 hKSZvl7xzcTaL8z4qJ1i9AeBe8fxdqKcO6VY4bbXkmVb83+R4BV5P+Y3b A==;
X-CSE-ConnectionGUID: Ghphz+JcSCmiXfynIq3W7A==
X-CSE-MsgGUID: zdqfNW6bQl+z2/CtKu+M5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2200811"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2200811"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:14:04 -0800
X-CSE-ConnectionGUID: O6V8PVDoQ5uE1ozQkv+0Zg==
X-CSE-MsgGUID: QQ/vVJ6RTny4goBVy1yZPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6002777"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:14:01 -0800
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [RFC 4/7] drm/xe/bo: Plumb a per-BO host NUMA node hint into tt
 populate
Date: Mon,  2 Nov 2026 15:48:08 +0530
Message-ID: <20261102101803.455921-13-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
References: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

Store a host NUMA node in the BO and its tt, and pass it to
ttm_pool_alloc_node() on populate. It defaults to NUMA_NO_NODE, so no
functional change.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c       | 7 ++++++-
 drivers/gpu/drm/xe/xe_bo_types.h | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 42a6aa1a2e4a..b0760d5d6bad 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -394,6 +394,8 @@ struct xe_ttm_tt {
 	struct sg_table *sg;
 	/** @purgeable: Whether the content of the pages of @ttm is purgeable. */
 	bool purgeable;
+	/** @numa_node: Preferred host NUMA node for backing pages. */
+	s16 numa_node;
 };
 
 static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
@@ -595,6 +597,7 @@ static struct ttm_tt *xe_ttm_tt_create(struct ttm_buffer_object *ttm_bo,
 		return NULL;
 
 	tt = &xe_tt->ttm;
+	xe_tt->numa_node = bo->numa_node;
 
 	extra_pages = 0;
 	if (xe_bo_needs_ccs_pages(bo))
@@ -676,7 +679,8 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
 		err = ttm_tt_restore(ttm_dev, tt, ctx);
 	} else {
 		ttm_tt_clear_backed_up(tt);
-		err = ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
+		err = ttm_pool_alloc_node(&ttm_dev->pool, tt, ctx,
+					  xe_tt->numa_node);
 	}
 	if (err)
 		return err;
@@ -2542,6 +2546,7 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 	bo->tile = tile;
 	bo->flags = flags;
 	bo->cpu_caching = cpu_caching;
+	bo->numa_node = NUMA_NO_NODE;
 	bo->ttm.base.funcs = &xe_gem_object_funcs;
 	bo->ttm.priority = XE_BO_PRIORITY_NORMAL;
 	INIT_LIST_HEAD(&bo->pinned_link);
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index 0265fb314c77..91e1c541b616 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -112,6 +112,13 @@ struct xe_bo {
 	 */
 	u16 cpu_caching;
 
+	/**
+	 * @numa_node: Preferred host NUMA node for system-memory backing
+	 * pages, or NUMA_NO_NODE to use the device-local node. Only honored
+	 * for user objects with a system-memory placement.
+	 */
+	s16 numa_node;
+
 	/** @devmem_allocation: SVM device memory allocation */
 	struct drm_pagemap_devmem devmem_allocation;
 
-- 
2.43.0

