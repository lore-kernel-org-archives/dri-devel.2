Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDF606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O32GvL1y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344F810ECA2;
	Mon,  2 Nov 2026 10:14:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D546210EC82;
 Mon,  2 Nov 2026 10:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793614441; x=1825150441;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CUEgLGUpiEmAijzae2V/qB+ia8xm5dgRIR2nEi4B8Eo=;
 b=O32GvL1y8EBQZ/583pIRJ+GIhy3oyuUyUzRHFwadHj+5RfM65ZiLVGH6
 5XcXQ4rbLe7NpMj6sVK7buRSPi6rClsBG/UYySnUO9Kk1IS4OxB9Hw9gb
 SZj7U3tni/TKhvkVivlMHbt/ZMkTzcAQeB7YFCoBtBxw/K9CiT5PMmp7B
 94Amo6VoWJgQ/VHwDewWrhB9gjqPs0GZvWjQHWJUOoTkIVE+XMzjwY870
 F/6apaFh3X8N9W0mxStSc77rXPZ04uLUDLoVDevb4aTdQXDMpWM8m7lxs
 8w6/rMQY8j/pyUHPSdeHzyNZxiOJLFecTiXdrmDG4mPDt66NZ2and3Pwe w==;
X-CSE-ConnectionGUID: Hr88b4xWSnmXpUCqXlOqhw==
X-CSE-MsgGUID: ge61qpOcTdGLL/lcv8UtFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2200807"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2200807"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:14:01 -0800
X-CSE-ConnectionGUID: 1+qW6UwrSc2ClApJ0K8P3g==
X-CSE-MsgGUID: hwmJcH+AQhmzElFkUlNT8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6002769"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:13:59 -0800
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [RFC 3/7] drm/ttm/pool: enforce per-node cache limits on free
Date: Mon,  2 Nov 2026 15:48:07 +0530
Message-ID: <20261102101803.455921-12-himal.prasad.ghimiray@intel.com>
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

ttm_pool_free() only trims the cache of the pool's default node. With
pages allocated on other nodes, check each node's limit on free. The
per-node accounting and shrinker already exist in TTM.

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 2107dc6c69b3..faba20cef216 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1050,13 +1050,20 @@ int ttm_pool_restore_and_alloc_node(struct ttm_pool *pool, struct ttm_tt *tt,
  */
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt)
 {
-	int nid = ttm_pool_nid(pool);
+	int nid;
 
 	ttm_pool_free_range(pool, tt, tt->caching, 0, tt->num_pages);
 
-	while (atomic_long_read(&allocated_pages[nid]) > pool_node_limit[nid]) {
-		unsigned long diff = atomic_long_read(&allocated_pages[nid]) - pool_node_limit[nid];
-		ttm_pool_shrink(nid, diff);
+	/*
+	 * ttm_pool_alloc_node() can place pages on a caller-requested node, so
+	 * freed pages may land on any node's cache; enforce every node's limit.
+	 */
+	for_each_node(nid) {
+		unsigned long cached;
+
+		while ((cached = atomic_long_read(&allocated_pages[nid])) >
+		       pool_node_limit[nid])
+			ttm_pool_shrink(nid, cached - pool_node_limit[nid]);
 	}
 }
 EXPORT_SYMBOL(ttm_pool_free);
-- 
2.43.0

