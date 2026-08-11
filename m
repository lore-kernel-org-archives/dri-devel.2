Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43D1C5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAA510EE69;
	Wed, 12 Aug 2026 07:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UC5mzFRy";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4293D10E35A
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:42:41 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so1713165e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786477360; x=1787082160; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Yi6COyPD9cih637RhWmDl/GrYJABMEvAXSPzHDaHyRc=;
 b=UC5mzFRymjpnJlzfxMP+yxMQOEFjsqfpkpVBVuOo9LmeaaQPXtV2zvWUqlsr3quy69
 McAtZ9C2ZGLI/xxZ0qqXauooR5GsIccr53UrDS0iQqsiv6dn0KkwpqFyhNrNBm2g634g
 MAfu+RCstWze3OJHT84/SgYIUN8SosY18NIfEpasnze6AAXwsxKrPrfjYv0qx9IUOf6C
 zqylUtZDV6XhMoSHgtD28vKgUtlbqTzxUTNlHIF8LlQjne2rmO2NtCsP7REsbuI8b/zD
 DU45EOFFJ4mABTkuzbVbpKEv5j9+VtXgeOF2vNOSJy55ZRUKE7KB4Ozt/RZVPxn+pdF6
 76Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786477360; x=1787082160;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yi6COyPD9cih637RhWmDl/GrYJABMEvAXSPzHDaHyRc=;
 b=lQHzBbwo2VQWPigYzb3ZJ5knFVdwXVSLhbegsEZdjVX5T9bE4otC9iAJfHgbSllZIc
 1FpGNk2Ad5IYgWm0/14vzky9a6xHFAdT02pWKlD0RqrgQdSKzeW53COz4dcj5vFuuj/R
 Ocf7UGwoxPm/NzTOfzLv7BUuE7HmsJqaJ6zh/Q/bn4Lz6vE9ytXJxHLbQbHy0Cloi42S
 xJZTCXzOKSmeuN5+4efW/f2wzHKcLIJ8NmWl1uk8Av2xbqFphiy83CXNZt7b5MBLuhxf
 b/zv54rohOJaZ/VeqoBnl9bIZ19y5o1u9uo3gSmeJPYPDN5YB/dtDhtEyUzS3KnWeZy4
 zGZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqoAqz18Qhl1yZBYHej5fJq72oO2BkbDR5KLfY9EnL5BMesc3eGJl3kmRVJMbp74n5pXZkyVJgQkE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yywy3/hBBF5qkTUTJoaxZdTXNITrVJ2E14n4de4IoD1cedWNLIm
 oTVy4ot08P2GMCk8RnYZoBI4Cj9ecIdEdzKadrzxOYV4fNuB9vWaR/sh
X-Gm-Gg: AR+sD13OgA/CEuk7IMjM6UDUDf82e2BoH/Rwvp9B402AhsKWmYnjHaB09Opp4FxVjK0
 MVnsHvs+oooEQAaBnNZ9U1bkzVoGjLtSaeM9TPAZy8y/WFSTBjWoeH1t3RfDqS2ejgsqld+kenK
 7g6weQ3Y/HfKZJoC7hRmuFdTYophRF9EygOqcs1FtXTVqfNkyEa42xZ4RVmUEr8zG1X0LD7X20t
 9K4lyr6B8tDetgey61+E/qQGnG/8VVZDhWfOb7vbCUTIs8eFta6S8CY3X5b8qo9iLWtr+dwKIAn
 8Awq1cjHgtQZD0Z3OqyMDS2BUw0hBbB7ULtgccebB5SFsyDHjeqpc8xWLruA/t/RELvGAmXrRHv
 oGsp8tG36WRs5YTeZZU9IUslj08NSMs+TUbPHpyV1D1BSzFtdj5WJRRwm2Efk62R+w/T1FLpTr3
 9uE/cT8WFbx9zjP90ICvTR2jynDPU93+PrT/ljo7KN6JV1CsDtPmFuzoj1aTfG1tfUCYZuQx/yq
 QLSrZJ9mCFB2sswvT7EIAYrmGfzz6WDYB/TqGHVBCFqkqj7S0WC
X-Received: by 2002:a05:600c:4f86:b0:496:c378:6420 with SMTP id
 5b1f17b1804b1-4997843b3famr69845395e9.8.1786477359442; 
 Tue, 11 Aug 2026 12:42:39 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2
 (212.pool95-21-2.static.orange.es. [95.21.2.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 12:42:39 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
Subject: [PATCH v5 1/6] Memory leak error in qxl unbind
Date: Tue, 11 Aug 2026 21:42:16 +0200
Message-ID: <20260811194224.121597-2-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811194224.121597-1-megia.oscar@gmail.com>
References: <20260811194224.121597-1-megia.oscar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

I discovered an OOM after run the script below
(I updated it and added a sleep to allow enough time for the cache to
recover):

while [ 1 -eq 1 ]; do\
    i=$((i+1)); echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/unbind;\
    if (($i%1000==0)); then\
        echo i=$i; free;\
        grep nr_free_pages /proc/vmstat;\
        grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
        sync; echo 3 > /proc/sys/vm/drop_caches;\
        echo 1 > /proc/sys/vm/compact_memory;\
        sleep 10s;\
        free;\
        grep nr_free_pages /proc/vmstat;\
        grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
        uptime;\
    fi;\
    echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/bind;\
done

The OOM isn't just a simple leak; it's a refcount corruption which renders
the list_lru fix dead code after the first mid-init failure.

Fixed check if shrinker_list is empty holding shrinker_lock.
Fixed check return value from ttm_pool_type_init and run
ttm_pool_type_fini and list_lru_destroy for every pt initialized.
Fixed change return value from ttm_pool_init to int.

This patch depends on patch ("[PATCH v3] drm/qxl: fix use-after-free in
qxl_irq_handler on PCI"), link [1] below.

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Link: https://lore.kernel.org/lkml/
20260727110212.64913-1-megia.oscar@gmail.com/ [1]
Link: https://lore.kernel.org/dri-devel/
20260731053047.24503-1-megia.oscar@gmail.com/ [2]
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
Changes in v2:
 - Bug 1: ttm_global_init ignores ttm_pool_mgr_init() return.
   If shrinker_alloc() fails under memory pressure, ttm_pool_mgr_init
   returns -ENOMEM with pool types already initialized (64 list_lru_init
   calls done). ttm_global_init ignored this and returned 0, leaving orphaned
   pool types with a NULL mm_shrinker.

   Fix: Check ret from ttm_pool_mgr_init; if non-zero, goto out cleans up
   refcount + debugfs.

 - Bug 2: ttm_pool_mgr_init leaks pool types on shrinker_alloc failure
   If shrinker_alloc fails after all 64 pool types were list_lru_init'd,
   the function returned -ENOMEM without undoing them. With Bug 1 now
   triggering proper error handling, this undo is necessary.

   Fix: err_shrinker: label that finalizes + destroys all 64 pool types
   before returning.

Changes in v3:
 - Fix: "Unchecked list_lru_init() return value in ttm_pool_type_init()
   causes a deterministic NULL pointer dereference in the newly added
   error path."
   Now check list_lru_init return value in ttm_pool_type_init() and
   returns error if any.

 - Solved pre-existing issues reported by kernel test robot:
   - [High] `ttm_pool_type_init()` ignores the return value of
     `list_lru_init()`, leading to a NULL pointer dereference
     if allocation fails.

     Fix: get return value from list_lru_init and return error if any.

   - [High] `ttm_pool_shrink()` assumes `shrinker_list` is never empty,
     causing memory corruption and crashes during module unload
     if triggered.

     Fix: Check if shrinker_list is empty and return 0 if it is empty.

Changes in v4:
 - removed check return value in ttm_pool_mgr_init, now in new patch
 ("[PATCH] ttm: Add error handling for ttm_pool_mgr_init()")
 link [2] above.
 - Fixed check empty shrinker_list.
 - Check return value from ttm_pool_type_init.
 - Move up shrinker_alloc.
 - Deleted dput(backup_fault_inject.dname);
 - Fixed issue [High] The patch introduces a use-after-free race condition
   between `ttm_pool_type_fini()` and the active memory shrinker
   `ttm_pool_shrink()` by calling `list_lru_destroy()` prematurely as
   reported by kernel test robot.

   Fix: separate ttm_pool_type_fini and list_lru_destroy. Then, add
   ttm_pool_synchronize_shrinkers between them.
---
 drivers/gpu/drm/ttm/ttm_pool.c | 62 ++++++++++++++++++++++++----------
 include/drm/ttm/ttm_pool.h     |  2 +-
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11ad..88c0d33eed1a 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -437,13 +437,21 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
 	LIST_HEAD(dispose);
 	struct ttm_pool_type *pt;
 	unsigned int num_pages;
+	int empty = 0;
 
 	down_read(&pool_shrink_rwsem);
 	spin_lock(&shrinker_lock);
-	pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
-	list_move_tail(&pt->shrinker_list, &shrinker_list);
+	if ((shrinker_list.prev == &shrinker_list) && (shrinker_list.next == &shrinker_list)) {
+		empty = 1;
+	} else {
+		pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
+		list_move_tail(&pt->shrinker_list, &shrinker_list);
+	}
 	spin_unlock(&shrinker_lock);
 
+	if (empty)
+		return 0;
+
 	num_pages = list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_list, &dispose, &num_to_free);
 	num_pages *= 1 << pt->order;
 
@@ -1122,6 +1130,18 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 	return shrunken ? shrunken : ret;
 }
 
+/**
+ * ttm_pool_synchronize_shrinkers - Wait for all running shrinkers to complete.
+ *
+ * This is useful to guarantee that all shrinker invocations have seen an
+ * update, before freeing memory, similar to rcu.
+ */
+static void ttm_pool_synchronize_shrinkers(void)
+{
+	down_write(&pool_shrink_rwsem);
+	up_write(&pool_shrink_rwsem);
+}
+
 /**
  * ttm_pool_init - Initialize a pool
  *
@@ -1132,10 +1152,13 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
  *
  * Initialize the pool and its pool types.
  */
-void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
+int ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 		   int nid, unsigned int alloc_flags)
 {
-	unsigned int i, j;
+	unsigned int i, j, k;
+	int ret;
+	struct ttm_pool_type *initialized[TTM_NUM_CACHING_TYPES * NR_PAGE_ORDERS];
+	unsigned int n_initialized = 0;
 
 	WARN_ON(!dev && ttm_pool_uses_dma_alloc(pool));
 
@@ -1152,23 +1175,28 @@ void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 			if (pt != &pool->caching[i].orders[j])
 				continue;
 
-			ttm_pool_type_init(pt, pool, i, j);
+			ret = ttm_pool_type_init(pt, pool, i, j);
+			if (ret)
+				goto error;
+
+			initialized[n_initialized++] = pt;
 		}
 	}
-}
-EXPORT_SYMBOL(ttm_pool_init);
 
-/**
- * ttm_pool_synchronize_shrinkers - Wait for all running shrinkers to complete.
- *
- * This is useful to guarantee that all shrinker invocations have seen an
- * update, before freeing memory, similar to rcu.
- */
-static void ttm_pool_synchronize_shrinkers(void)
-{
-	down_write(&pool_shrink_rwsem);
-	up_write(&pool_shrink_rwsem);
+	return 0;
+
+error:
+	for (k = 0; k < n_initialized; ++k)
+		ttm_pool_type_fini(initialized[k]);
+
+	ttm_pool_synchronize_shrinkers();
+
+	for (k = 0; k < n_initialized; ++k)
+		list_lru_destroy(&initialized[k]->pages);
+
+	return ret;
 }
+EXPORT_SYMBOL(ttm_pool_init);
 
 /**
  * ttm_pool_fini - Cleanup a pool
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 26ee592e1994..66248323c2c1 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -81,7 +81,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		   struct ttm_operation_ctx *ctx);
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
 
-void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
+int ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 		   int nid, unsigned int alloc_flags);
 void ttm_pool_fini(struct ttm_pool *pool);
 
-- 
2.55.0

