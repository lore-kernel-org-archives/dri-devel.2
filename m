Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA92CA5FE6
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 22:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2885A10E6D8;
	Fri,  2 Oct 2026 22:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="STREqKlg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1091B10E00C;
 Fri,  2 Oct 2026 22:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790981141; x=1822517141;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JeuvI8ODlscsQ5KJ36arXtaxu8zSc50C8U9fv4qGyRI=;
 b=STREqKlgsvNIYm7d0bxupRQnO8NcSaCAdgjp8pcB93lXy4OGZzisg+u0
 MjppGjY7Td7c8UqeVaKnckFcafdElXfwyh+Q8Xi3kUnyb3bZn688r/BqL
 QTRqnnmmevSd2Sa8T2oxjRZngmwcbkrQ1TQ3YAqG8mJyrQbNQWITs+qc9
 XQxuAN4JJG0nAVKRTJArN3kkmXKOZ2EFYPK9MauBqvc3/m6nzhRNS/m/k
 N7VJKhW5srgphm92EO1JuAcfqKoXtWb7W4KbvE6tj0X9iFanlfPOLIYw3
 BNIwCxvKpmp0j9Vc/EU58jfTxwMUYpGR4SVAN8SM6vs/SzMYoCmUIcPcX Q==;
X-CSE-ConnectionGUID: xo8Q85mdSR6YSDRqaer01A==
X-CSE-MsgGUID: OLc+zaJVSNWqPJlpPKLd5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="102273172"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="102273172"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 15:45:41 -0700
X-CSE-ConnectionGUID: ZGjfFUnfQaqh9svfbTcU3Q==
X-CSE-MsgGUID: yrToihivTQe6QracOKI1/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="274996779"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 15:45:39 -0700
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@linux.intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v1 1/1] drm/ttm: remove num_pages from arguments' list
Date: Sat,  3 Oct 2026 00:45:21 +0200
Message-ID: <20261002224521.781690-2-michal.grzelak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261002224521.781690-1-michal.grzelak@linux.intel.com>
References: <20261002224521.781690-1-michal.grzelak@linux.intel.com>
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

ttm_pool_mgr_init() does not use num_pages argument in any way. Remove
it.

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
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

