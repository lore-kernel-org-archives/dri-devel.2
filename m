Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11872606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SJEnqdEo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A81610E21F;
	Tue, 24 Nov 2026 06:17:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFB010E5F9;
 Tue, 24 Nov 2026 06:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501021; x=1827037021;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wtkDv0zGa1xFMsyLOgsOxT9wv9fP71+CF5vzL6r+fCM=;
 b=SJEnqdEoPYrdrdfeutyqaGIgdJMZU3lkQU0FQf3iwdIseVimBTdfYNrH
 cWRftWLdoAx2gBv5+nfDXoM29y6yBkEOX2UfnzsHCtoMsVPOSjrPp4MYp
 VlRf5jBSwjveHxsnRD9rLXcP1Ii7/PlW9IGaR1U3ntWWHo0Zxt8nEgiE2
 UwKhD9Kjhkc+jn+Ubybp4u9r1MeVh2cp9B8qcUcYjLNQhc13kFfn7tiV0
 NZ2JI3rwR8sd1gSV3Um52uJI0hKaeT33wFj56GL8hfahp2Ez+Arl5Tr97
 N6n9nLKSOYh8xfpantJUW4jl3KAYLNiv63jyKU3T5lzkhk1hRlXPtpaN4 w==;
X-CSE-ConnectionGUID: LwmRV9lCRdqSTteWOQV44Q==
X-CSE-MsgGUID: GCgQUDBURIujTaRvRrzH8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4220050"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4220050"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:17:01 -0800
X-CSE-ConnectionGUID: MR+ZhMseSCeIsuV8D20Jjw==
X-CSE-MsgGUID: ZybFmCm4QXaGMXRDrGfpEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11264128"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 22:16:58 -0800
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: Natalie Vock <natalie.vock@gmx.de>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [RFC v2 04/11] drm/ttm/pool: enforce per-node cache limits on free
Date: Tue, 24 Nov 2026 11:51:28 +0530
Message-ID: <20261124062123.2431244-17-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124062123.2431244-13-himal.prasad.ghimiray@intel.com>
References: <20261124062123.2431244-13-himal.prasad.ghimiray@intel.com>
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

v2:
- Update comment for the ttm_operation_ctx based node selection

Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index f140cc95e965..4ab37af0f1ba 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1158,13 +1158,20 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
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
+	 * ttm_operation_ctx can place pages on a caller-requested node, so
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

