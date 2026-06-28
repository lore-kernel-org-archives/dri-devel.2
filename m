Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A268C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBA6F10E705;
	Mon, 29 Jun 2026 07:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cceeQkEg";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C8610E32A
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:41:11 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4926046fbc5so28671625e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 08:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782661270; x=1783266070; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bdP/kJNcUoKP2dTQekglHV9xkq62178db/T4WFfvdsg=;
 b=cceeQkEgkyvctU6VRCFHJrRcUluGn+3ZXVgj4KlB8up7U434UyZ9GaTxjn1qO+oudU
 fA6Iq+5Hc4NsL5EEK7HNAv4KeLKYSIbRccLWhliJ6OBDxycj0Z4qIt8e+XaO4ZhgaOW4
 I76k0Zw1bUNRbnhCiMpRMqEe0RQDDOzsTWgscr7SZnxZNZIqV8T+ksOwO5I3AkY9i07Q
 UcS3H8u/C4q2e9mJGffUMyVUGiPMnjBAHNBtA5e64bZiijovVOk29og+gucGmOcH07DG
 WkGMQvLiGpdwGeZDIHBcdkCB/QRM7ZUzBVM+yxCeTuPLeq02ZO41bpr6yIZbtwvtGK8z
 qnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782661270; x=1783266070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdP/kJNcUoKP2dTQekglHV9xkq62178db/T4WFfvdsg=;
 b=cgRhlj7IDskV8kWmkGv4JATR4XJECIQNAsRonlBfIueTqgpjBm7Di9Qg4bIHgo+2lR
 s7DIz/qWkjLkeopKKJuQnhWEZK5f4lr/WyrYSbkq/LzTaa9U+xY2OZbMfS8oDhfS1Gzf
 BuBjKBzGykaF7vWCQURWVRb/LlzaeEnmkTawn7KJ7PGsQnwvIoR87MiJUCU/yKRBZSsR
 Ck65f/GMM+rI44PqD55a2adTcC6/RbSnz+RX0C2uISiomPR7zaY32EXXN03cCgM/dHJh
 XDd/Mxt+Fcxuxk/9BcHREuW7slvFlekDEY3XyIPTOQ4kPT0jO97qLIIpGnerimlfQj6J
 SjaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xYyRgTo9siihL9bSyvU0xK1T3RWuJdFive/nvDzR+5fDtBqeCDEjO0pQXIX8azPjcWoSqdGnb/UI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzeFf1QKu1u67eBjxAzRaThSnaD57HqkbsZaLs2LAsUUlauVQnS
 ZFSxal2id3QC45DZmtii4ShwxvKHOE1y4PubiN0Kh4orpZE/xDJdiYH5
X-Gm-Gg: AfdE7clyCd1TGjuhKkjwpHVhaR7D2Guv5B/yhYzcRVTtO90TMolniJTy3qeDdLYcTC5
 tiE63/CH8WREjTf5mmmubtBqAYw6gzkhMyOM80bSw5lm+1CTgtpfpAficTdcq6SBkXXKHNiBvuX
 YCsD+hZEOWx3Z4cxOTzgn0csPp3GWPmGiaCK4PFyXLRsNNIXyuPT3/rBkw1usP8VTg6rVQNMvV7
 FU3w1r0iVHjY/pYwVsHTlDr7N9p/3d9ozjcvJoL05dn9+s38hW8GMD/0pvvDRNKH4nB3Pp0+Btg
 IOyeHbtjtbfr48Vw/xVPnz6tE0wPT2iEKFpNdgWnVYk3fveA9uXs27/mQNvNBnvsQzFpzvH4zsD
 LQ2RY4MOXFS4CuPHQlp2lxRQoMRT6XPmU4VWL0u8M1LK5qBP6jHt2tc+6Z43xEcE4JlhexGYUna
 SbWz5kUQ304vx39/4e+lk4oMVF1m0xG1+iuvODLUw+j6HKopBzGvPqjOJMMU5nDBpPIClvuktkA
 UKM
X-Received: by 2002:a05:600c:3b89:b0:492:37a3:acda with SMTP id
 5b1f17b1804b1-4925a0444c4mr347631285e9.0.1782661269651; 
 Sun, 28 Jun 2026 08:41:09 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2
 (212.pool95-21-2.static.orange.es. [95.21.2.212])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4721c88bfcasm12707909f8f.10.2026.06.28.08.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 08:41:07 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] Memory leak error in qxl unbind
Date: Sun, 28 Jun 2026 17:40:43 +0200
Message-ID: <20260628154051.232214-1-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:39 +0000
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

I discovered OOM after run script below around two hours in my computer:

while :; do
    echo [pci qxl id] > /sys/bus/pci/drivers/qxl/unbind
    echo [pci qxl id] > /sys/bus/pci/drivers/qxl/bind
done

If you run 10000 times above script kmemleak does not report any
memory leak, but if you run above script about two hours several
OOM ocurs and at the end kernel panic.

The OOM isn't just a simple leak; it's a refcount corruption that renders
the list_lru fix dead code after the first mid-init failure.

Here's the chain:

Bug 1: ttm_global_init ignores ttm_pool_mgr_init() return
If shrinker_alloc() fails under memory pressure, ttm_pool_mgr_init
returns -ENOMEM with pool types already initialized (64 list_lru_init
calls done). ttm_global_init ignored this and returned 0, leaving orphaned
pool types with a NULL mm_shrinker.

Fix: Check ret from ttm_pool_mgr_init; if non-zero, goto out cleans up
refcount + debugfs.

Bug 2: ttm_pool_mgr_init leaks pool types on shrinker_alloc failure
If shrinker_alloc fails after all 64 pool types were list_lru_init'd,
the function returned -ENOMEM without undoing them. With Bug 1 now
triggering proper error handling, this undo is necessary.

Fix: err_shrinker: label that finalizes + destroys all 64 pool types
before returning.

You must apply the patch from the link "[PATCH v2] drm/qxl: fix
use-after-free to qxl_irq_handler in PCI mode" before testing.
If you don't apply this patch, you will get a UAF error when running
the script above.

Assisted-by: OpenCode:1.17.8-Big Pickle
Link: https://lore.kernel.org/virtualization/20260627105445.89827-2-megia.oscar@gmail.com/T/#u
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_device.c |  5 ++++-
 drivers/gpu/drm/ttm/ttm_pool.c   | 37 ++++++++++++++++++++++++++------
 include/drm/ttm/ttm_pool.h       |  2 ++
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index d3bfb9a696a7..c880a0430363 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -96,7 +96,10 @@ static int ttm_global_init(void)
 		>> PAGE_SHIFT;
 	num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
 
-	ttm_pool_mgr_init(num_pages);
+	ret = ttm_pool_mgr_init(num_pages);
+	if (ret)
+		goto out;
+
 	ttm_tt_mgr_init(num_pages, num_dma32);
 
 	glob->dummy_read_page = alloc_page(__GFP_ZERO | GFP_DMA32 |
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11ad..e0c82804a07d 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1198,6 +1198,17 @@ void ttm_pool_fini(struct ttm_pool *pool)
 	 * that no shrinker is concurrently freeing pages from the pool.
 	 */
 	ttm_pool_synchronize_shrinkers();
+
+	for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i) {
+		for (j = 0; j < NR_PAGE_ORDERS; ++j) {
+			struct ttm_pool_type *pt;
+
+			pt = ttm_pool_select_type(pool, i, j);
+			if (pt != &pool->caching[i].orders[j])
+				continue;
+			list_lru_destroy(&pt->pages);
+		}
+	}
 }
 EXPORT_SYMBOL(ttm_pool_fini);
 
@@ -1386,6 +1397,7 @@ static inline u64 ttm_get_node_memory_size(int nid)
 int ttm_pool_mgr_init(unsigned long num_pages)
 {
 	unsigned int i;
+	int ret = 0;
 
 	int nid;
 	for_each_node(nid) {
@@ -1423,8 +1435,10 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 #endif
 
 	mm_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
-	if (!mm_shrinker)
-		return -ENOMEM;
+	if (!mm_shrinker) {
+		ret = -ENOMEM;
+		goto err_shrinker;
+	}
 
 	mm_shrinker->count_objects = ttm_pool_shrinker_count;
 	mm_shrinker->scan_objects = ttm_pool_shrinker_scan;
@@ -1434,6 +1448,10 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	shrinker_register(mm_shrinker);
 
 	return 0;
+
+err_shrinker:
+	ttm_pool_type_fini_and_list_lru_destroy();
+	return ret;
 }
 
 /**
@@ -1442,17 +1460,24 @@ int ttm_pool_mgr_init(unsigned long num_pages)
  * Cleanup the global pools and unregister the MM shrinker.
  */
 void ttm_pool_mgr_fini(void)
+{
+	shrinker_free(mm_shrinker);
+	ttm_pool_type_fini_and_list_lru_destroy();
+	WARN_ON(!list_empty(&shrinker_list));
+}
+
+void ttm_pool_type_fini_and_list_lru_destroy(void)
 {
 	unsigned int i;
 
 	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
 		ttm_pool_type_fini(&global_write_combined[i]);
+		list_lru_destroy(&global_write_combined[i].pages);
 		ttm_pool_type_fini(&global_uncached[i]);
-
+		list_lru_destroy(&global_uncached[i].pages);
 		ttm_pool_type_fini(&global_dma32_write_combined[i]);
+		list_lru_destroy(&global_dma32_write_combined[i].pages);
 		ttm_pool_type_fini(&global_dma32_uncached[i]);
+		list_lru_destroy(&global_dma32_uncached[i].pages);
 	}
-
-	shrinker_free(mm_shrinker);
-	WARN_ON(!list_empty(&shrinker_list));
 }
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 26ee592e1994..bda8e816a206 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -97,4 +97,6 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 int ttm_pool_mgr_init(unsigned long num_pages);
 void ttm_pool_mgr_fini(void);
 
+void ttm_pool_type_fini_and_list_lru_destroy(void);
+
 #endif
-- 
2.54.0

