Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62625606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fCRwifOn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC02710E26B;
	Sun, 15 Nov 2026 10:23:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAE810E091;
 Sun, 15 Nov 2026 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794738218; x=1826274218;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JuxXlY6IaBd0B755FflZEMe/QX3tWDJIyujyYd/N/78=;
 b=fCRwifOnjzyeTDHNw2UqrFG3uZ5iff8B4jewkfkFgF1xV1wW1s0/BeT7
 KPFT3ojOB8smd2JJJ7a8THIdB2AMBzAv8qhmQE6QuC6z+2x2y3h8W7qsM
 HZx7/VvlLYvqsBGTf6E+TYAu9IwD4ypWdx4X5yW2xDT6gBwgmoriFzXs0
 Tqh9xDQn4GWNHrpWylpzb00R8O5arnNZIWng21k4j7JvtrM3FLYW1evRg
 HU92ND2ojkI2F3LNNphdSsmm+vJG64VGkTf+XvW8/EjHPjF1YGw48HKFa
 wdIVHYWisMxYevLniWZHgeXH0IXOtHsnG2GBKfptNRyHX23099PiBgtvC Q==;
X-CSE-ConnectionGUID: jZYn/SenRGisRPizZkaYQA==
X-CSE-MsgGUID: qNmGGogSSZK8YEvM8TQD4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3531468"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3531468"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 02:23:38 -0800
X-CSE-ConnectionGUID: XfJ10Ov3Qlq6bgFuKvP1ZQ==
X-CSE-MsgGUID: EOP925tATzub8xk7fWoeug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="9468601"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 02:23:36 -0800
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
Subject: [PATCH v2 1/1] drm/ttm: remove unused num_pages
Date: Sun, 15 Nov 2026 11:22:37 +0100
Message-ID: <20261115102237.3091682-2-michal.grzelak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261115102237.3091682-1-michal.grzelak@linux.intel.com>
References: <20261115102237.3091682-1-michal.grzelak@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ttm_pool_mgr_init() does not use num_pages argument in any way. Remove
it.

v1->v2
- include ttm maintainers in Cc: list

Cc: Natalie Vock <nat@pixelcluster.dev>
Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Michał Grzelak <michal.grzelak@linux.intel.com>
---
 drivers/gpu/drm/ttm/ttm_device.c | 2 +-
 drivers/gpu/drm/ttm/ttm_pool.c   | 4 +---
 include/drm/ttm/ttm_pool.h       | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index d3bfb9a696a74..4a9786ffa5fe2 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -96,7 +96,7 @@ static int ttm_global_init(void)
 		>> PAGE_SHIFT;
 	num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
 
-	ttm_pool_mgr_init(num_pages);
+	ttm_pool_mgr_init();
 	ttm_tt_mgr_init(num_pages, num_dma32);
 
 	glob->dummy_read_page = alloc_page(__GFP_ZERO | GFP_DMA32 |
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 1bf37023fed66..2f6c666868d5f 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1485,11 +1485,9 @@ static inline u64 ttm_get_node_memory_size(int nid)
 /**
  * ttm_pool_mgr_init - Initialize globals
  *
- * @num_pages: default number of pages
- *
  * Initialize the global locks and lists for the MM shrinker.
  */
-int ttm_pool_mgr_init(unsigned long num_pages)
+int ttm_pool_mgr_init(void)
 {
 	unsigned int i;
 
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 26ee592e19949..bb6347e5b2970 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -94,7 +94,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *ttm,
 int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 			       const struct ttm_operation_ctx *ctx);
 
-int ttm_pool_mgr_init(unsigned long num_pages);
+int ttm_pool_mgr_init(void);
 void ttm_pool_mgr_fini(void);
 
 #endif
-- 
2.45.2

