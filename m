Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF38CA5FA7
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F5110E854;
	Mon, 28 Sep 2026 08:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nOHVy2qN";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1161F10E456
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 10:32:37 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48882c1f261so657058f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790505155; x=1791109955; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=45tBD3kZBcNwqDCe4McFRRFSHceImT3aj0kJG1xkuLo=;
 b=nOHVy2qNZfo29/ERLFbNSbHZV2d8rdzUKPBgu1R2djm2Ldd+So9DTuiASfgX83XYau
 mTBMm2qBiKMSyYyZL4qB0caijuASBnSqpy+psu8wjxPsU3xIH8OyR21jw3AcSlAiaDW0
 zjJTMVLIK3F6s6+0zjsKqo9I3lGPJBVnWNMEwbOIkx0+L9oyoUet1zitf/WKF0fsbwhQ
 ZYiPRXnfAZEe99xl4FwzoyP2N55bvYhD6ZNeYvy2uPnK1k3MmXb6INw8VJVKLdzvp04K
 rJwU86xcc4gFfy55EoSgBlWEFLmvX3SEmf7t/V40lDZS22P57xFuNXHsEcPj+f6tJ7HR
 qsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790505155; x=1791109955;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=45tBD3kZBcNwqDCe4McFRRFSHceImT3aj0kJG1xkuLo=;
 b=QROZKYRYECRnll/P8M/oxoMe62sEeIrrCnyEzsNNkWijg75yjEdkZPH0kSYxX5xczr
 Ick3RLjCHKDs3fSMWVsJBe1fybGaLK3YSnKlX/SW+jljs6Xmize1oUHU4mK76YX7Rzzh
 DqxtSj1YnabXvtKhgjZmh3qbn0cjZTHqEsAdPN0b26XJaESgE/HyXPkVIfYXNX2YxSG2
 D+fWw0Q602flw6h1yoXqpb1hrXRNSD4q1P9RbrJCb13lCCdqWOhhPsKj0fv/r28bHFdh
 RMnL88Z+v8QZ6kXX0kSbSIxa23+f3idKSk3dCDvGsctMVXRkJVMRY2AV9KqDJkCrwiwu
 tTBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxi/w0eu50lm4Z4tZjL9W6h8f7yIJFSnkxOCqVWpYcWb0oHTPUy/Ae0ygulo9gYp4rsGZWLGq7sT7Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lwaRO/8lSP6JavI3yMffu9g3Oo3hc81WMt++ymig46pQ3r4yZy
 NCI0iArwCJpsfTs8i3jNEmXrdYa0YF1NYvRWWBw8jlQZJ/x7eeBdwu1k
X-Gm-Gg: AYBFou09auSgzHRk/R0cQS5PiVQ8E+SlsE3ClYUfcSTr1ZGAQXt5SUdH4FVaJT/JC3s
 e1+m6kVIgg1t2JeFPEyL4Kt0uKX5rwy+bq6p2/0FBLBldeUqqf56KD7J2cjlXhFVM04owQq1r4q
 aAywlIubLvsc3jwkUVi0CRxtKTPpe1xQIJ1+SUOthxw2B13l6+tk8KWgIfpiA/RN1u1/xE5GXFs
 5CxfuLRF4Y/ZilQsrmHxl14SVUBKWSUqh4qShU1fkNOzbCtNmlnATplAxRCYZIjVBnsm7KuLEXV
 M2hZ9FHv4jB6fFIUSDpQtCAh7JebXXqdH3aflMY6hSX7LPG9c6FY0DXWU2z6ixUCpGIzSliIZW3
 mCrR4cd8KPCU7/oK8P+Z2b2kfPcZwtncKzVgqU/YEKw2LWcbs8S/ARIsrq+DEU0eI/yVqZfw5+p
 2lgtBp3GGhQKsqtY5QyXwBFE+p4P0P/mcgucb54tYHtFgy3zlebcWyqYvjO7HM6WomUJUTSDGK1
 bDx2TyWbFrzDZW87Y/Hp220jTF5lXl7YJ6vqIln81RirpEEM+Ql3EuRRvH87g==
X-Received: by 2002:a05:600c:a00e:b0:49e:6865:904e with SMTP id
 5b1f17b1804b1-49fe66f176dmr201357565e9.12.1790505155186; 
 Sun, 27 Sep 2026 03:32:35 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2
 (212.pool95-21-2.static.orange.es. [95.21.2.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ffd137346sm79586805e9.1.2026.09.27.03.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 03:32:34 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
Subject: [PATCH v6] Memory leak error in qxl unbind
Date: Sun, 27 Sep 2026 12:32:27 +0200
Message-ID: <20260927103231.47692-1-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:41 +0000
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
(I updated it and added udevadm settle to allow the cache to
recover):

i=0;\
while [ 1 -eq 1 ]; do\
    i=$((i+1)); echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/unbind;\
    if (($i%1000==0)); then\
        echo loops=$i; free;\
        grep nr_free_pages /proc/vmstat;\
        grep -E "VmallocUsed|Slab|Reclaimable|SUnreclaim" /proc/meminfo;\
        sync; echo 3 > /proc/sys/vm/drop_caches;\
        echo 1 > /proc/sys/vm/compact_memory;\
        echo "running udevadm settle;";\
        udevadm settle;\
        free;\
        grep nr_free_pages /proc/vmstat;\
        grep -E "VmallocUsed|Slab|Reclaimable|SUnreclaim" /proc/meminfo;\
        uptime;\
    fi;\
    echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/bind;\
done

ttm_pool_mgr_fini() does not destroy the list lru leaving memory leak.

Fix: Add list_lru_destroy() after ttm_pool_type_fini().

This patch depends on patch ("[PATCH v4] drm/qxl: fix use-after-free in
qxl_irq_handler on PCI"), link [1] below.

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: https://claude.ai:Sonnet 5
Assisted-by: https://gemini.google.com:3.6 Flash
Link: https://lore.kernel.org/virtualization/
20260927101026.45411-1-megia.oscar@gmail.com/ [1]
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

Changes in v5:
 - In ttm_pool_init() return int and check return value from
   ttm_pool_type_init and propagate error. Free pt and pg->pages
   if returns error.
 - In ttm_pool_mgr_init() free previous ttm_pool_type_init() if returns
   error.
 - In ttm_global_init() check return value from ttm_pool_mgr_init() and
   propagate.

Changes in v6:
 - Add list_lru_destroy in ttm_pool_mgr_fini to avoid memory leak.
---
 drivers/gpu/drm/ttm/ttm_pool.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11ad..09fdfe45e39f 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1453,6 +1453,18 @@ void ttm_pool_mgr_fini(void)
 		ttm_pool_type_fini(&global_dma32_uncached[i]);
 	}
 
+	/* We removed the pool types from the LRU, but we need to also make sure
+	 * that no shrinker is concurrently freeing pages from the pool.
+	 */
+	ttm_pool_synchronize_shrinkers();
+
+	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
+		list_lru_destroy(&global_write_combined[i].pages);
+		list_lru_destroy(&global_uncached[i].pages);
+		list_lru_destroy(&global_dma32_write_combined[i].pages);
+		list_lru_destroy(&global_dma32_uncached[i].pages);
+	}
+
 	shrinker_free(mm_shrinker);
 	WARN_ON(!list_empty(&shrinker_list));
 }
-- 
2.55.0

