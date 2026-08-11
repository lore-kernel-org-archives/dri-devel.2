Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197CFC5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B6B10EE6C;
	Wed, 12 Aug 2026 07:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T6Twgvs0";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D07D10E35A
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:42:44 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so553265e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786477363; x=1787082163; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ThEXNcRr1uXZthkNQc1yyhogFUr1K8iZ1YVWwE63FbE=;
 b=T6Twgvs01b2U0yEVcznKV2gXPHPEaKg4HX8IqqWkCtM22iZQN475GqHYwLiDvxKt16
 8ndGp2zNdRV76e4gI494gdFrlLFl8e3GzonXiC48KhUwGWjQ7AFHsgMAIAb66SI3KAlg
 3sIG4pVUIW3eVg4kQOQUQgiVDRPhVVuEpZBP1JatcjoVkCueFDs28RFcKBwdrbFWXlqi
 u9MGz5oEIwHVjDY1jeAgua6SVxKxI6APjqnULLEatc8cJypO3Tyr2VxumsQzs0333Sfa
 X8EZ4EZ+rNGFVj8+EOAVSvqqcweVTeV2VZy/uRgyL/vckuvLCVR4/q8pdM7Si20r4DQ3
 xoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786477363; x=1787082163;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ThEXNcRr1uXZthkNQc1yyhogFUr1K8iZ1YVWwE63FbE=;
 b=fVSWF1agQS1qTTXqrKb7vKRwCA5pfq1j6dPzU/Yz/uJR3JMS0F46fWPHFZzoEsSRnk
 j6W5bojK+1Ol4ZnMXtOGqq/64E5ywZnR9C3wrDMOfBS4tOT0m+9kOcWTKpFPdCGKaOhz
 qnkFqw1IzWi5QmaMO3j2ZVhSWGOHa3ysX6NjgTgR99NeSyC6ImNsYdIsmQd+FQxVr2tm
 1ebuWqdKdsP1eZFVBXO0gZkbMCDC/HvD0SyaNXRZcTdWGFWKTgf6ZVqQ9k/M7ZQaG6jr
 /zbi9FrJchI5G5is8BplPZ7mg/1mA1wxFlWaz8n894tbegNxRA7I8tf3mnWs5YIVxi19
 0tsA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4+OCuDdyqCyfK0AeaeFNw9sddRTRBfj+PsssRYTkLke10iltrM/yP4PPEM5CyRDEy3noKwdMiNsU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlQjS+zYYnJfezqW2G5j74cZEJjF9ND7rDTOuwJc+h4GbiXWWR
 ijy99VBDDy5RHToz7voXUXj2FBLJaum5BnS44DmjlceM4bMCuCpHMok6
X-Gm-Gg: AR+sD12L31Tyqh112mWO0Jky0nsaNPTpjKhejWV1XhqY9WdH4+P6yS0YmAlTGKNqYvF
 COdKyKUB7T7ji4gKbExgATcrM4NI24qvmZOWWkVQXlrTre2G9c/OYQwTIghvO8CxfGzz4y4aJfA
 nubN9/wyUlfUjahUNKJ+ICSZgtljtok9SP/zBHovRONjEMhEsqwy5N49Xw099tGutfNAZD1nBGI
 u7LcM9QIUGjM7MzlIlv2E5nSdOhtkHgrUMLFBvNl1wBcaITJHh2au4LMymkwIv9HNioE/0yi0Cl
 FQR/bh1GIVxsy4ZWrnDgGjulObtlXHodHekgoqKS2EuNqkV2LAFskb7FvVbynnvOlbgziEK7ezr
 EOO7D3y8EoQRxO3juxp5hxqixJrLQyTgErDy3Taauqm/lHmXAuQSwQlnZoCsBLkctUECS+HYfc0
 a3zlnQ4MQ0iVlTN6QqDuQuEhu+haxP3LngUyMLYzWhH9/4M9eF4iTnS+OZAkHB3wyGxd2OyDYzp
 qeBzVXznrljV4hHD0lfpu8aYofC0dr4TwUAa9RB9t71bKkAAxv8c1k3/JQfsvM=
X-Received: by 2002:a05:600c:1f83:b0:499:4e47:eaf2 with SMTP id
 5b1f17b1804b1-49978413130mr87241535e9.6.1786477362706; 
 Tue, 11 Aug 2026 12:42:42 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2
 (212.pool95-21-2.static.orange.es. [95.21.2.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 12:42:42 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
Subject: [PATCH v5 4/6] ttm_pool_type_init() does not check return value
Date: Tue, 11 Aug 2026 21:42:19 +0200
Message-ID: <20260811194224.121597-5-megia.oscar@gmail.com>
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

Bug: ttm_pool_mgr_init() does not check ttm_pool_type_init() return
value and does not free pool if returns error.

Fix: Move up shrinker_alloc(), check ttm_pool_type_init() return and free
pool types and shrinker if non-zero and return error.

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 100 ++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 87c843f52736..74d8770f41d8 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1421,6 +1421,54 @@ static inline u64 ttm_get_node_memory_size(int nid)
 	return managed_pages * PAGE_SIZE;
 }
 
+static void ttm_pool_type_fini_and_list_lru_destroy(unsigned int nr)
+{
+	unsigned int i;
+
+	if (nr == 0)
+		return;
+
+	for (i = 0; i < nr; ++i) {
+		ttm_pool_type_fini(&global_write_combined[i]);
+		ttm_pool_type_fini(&global_uncached[i]);
+		ttm_pool_type_fini(&global_dma32_write_combined[i]);
+		ttm_pool_type_fini(&global_dma32_uncached[i]);
+	}
+
+	/* We removed the pool types from the LRU, but we need to also make sure
+	 * that no shrinker is concurrently freeing pages from the pool.
+	 */
+	ttm_pool_synchronize_shrinkers();
+
+	for (i = 0; i < nr; ++i) {
+		list_lru_destroy(&global_write_combined[i].pages);
+		list_lru_destroy(&global_uncached[i].pages);
+		list_lru_destroy(&global_dma32_write_combined[i].pages);
+		list_lru_destroy(&global_dma32_uncached[i].pages);
+	}
+
+}
+
+static void ttm_pool_type_fini_and_list_lru_destroy_partial(
+				struct ttm_pool_type *types[], unsigned int n)
+{
+	unsigned int k;
+
+	if (n == 0)
+		return;
+
+	for (k = 0; k < n; ++k)
+		ttm_pool_type_fini(types[k]);
+
+	/* We removed the pool types from the LRU, but we need to also make sure
+	 * that no shrinker is concurrently freeing pages from the pool.
+	 */
+	ttm_pool_synchronize_shrinkers();
+
+	for (k = 0; k < n; ++k)
+		list_lru_destroy(&types[k]->pages);
+}
+
 /**
  * ttm_pool_mgr_init - Initialize globals
  *
@@ -1431,6 +1479,8 @@ static inline u64 ttm_get_node_memory_size(int nid)
 int ttm_pool_mgr_init(unsigned long num_pages)
 {
 	unsigned int i;
+	int ret = 0;
+	struct ttm_pool_type *types_free[3];
 
 	int nid;
 	for_each_node(nid) {
@@ -1445,15 +1495,53 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	spin_lock_init(&shrinker_lock);
 	INIT_LIST_HEAD(&shrinker_list);
 
+	mm_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
+	if (!mm_shrinker)
+		return -ENOMEM;
+
 	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
-		ttm_pool_type_init(&global_write_combined[i], NULL,
+		ret = ttm_pool_type_init(&global_write_combined[i], NULL,
 				   ttm_write_combined, i);
-		ttm_pool_type_init(&global_uncached[i], NULL, ttm_uncached, i);
+		if (ret) {
+			ttm_pool_type_fini_and_list_lru_destroy(i);
+			shrinker_free(mm_shrinker);
+			return ret;
+		}
+
+		ret = ttm_pool_type_init(&global_uncached[i], NULL, ttm_uncached, i);
+		if (ret) {
+			types_free[0] = &global_write_combined[i];
+			ttm_pool_type_fini_and_list_lru_destroy_partial(types_free, 1);
 
-		ttm_pool_type_init(&global_dma32_write_combined[i], NULL,
+			ttm_pool_type_fini_and_list_lru_destroy(i);
+			shrinker_free(mm_shrinker);
+			return ret;
+		}
+
+		ret = ttm_pool_type_init(&global_dma32_write_combined[i], NULL,
 				   ttm_write_combined, i);
-		ttm_pool_type_init(&global_dma32_uncached[i], NULL,
+		if (ret) {
+			types_free[0] = &global_write_combined[i];
+			types_free[1] = &global_uncached[i];
+			ttm_pool_type_fini_and_list_lru_destroy_partial(types_free, 2);
+
+			ttm_pool_type_fini_and_list_lru_destroy(i);
+			shrinker_free(mm_shrinker);
+			return ret;
+		}
+
+		ret = ttm_pool_type_init(&global_dma32_uncached[i], NULL,
 				   ttm_uncached, i);
+		if (ret) {
+			types_free[0] = &global_write_combined[i];
+			types_free[1] = &global_uncached[i];
+			types_free[2] = &global_dma32_write_combined[i];
+			ttm_pool_type_fini_and_list_lru_destroy_partial(types_free, 3);
+
+			ttm_pool_type_fini_and_list_lru_destroy(i);
+			shrinker_free(mm_shrinker);
+			return ret;
+		}
 	}
 
 #ifdef CONFIG_DEBUG_FS
@@ -1467,10 +1555,6 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 #endif
 #endif
 
-	mm_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
-	if (!mm_shrinker)
-		return -ENOMEM;
-
 	mm_shrinker->count_objects = ttm_pool_shrinker_count;
 	mm_shrinker->scan_objects = ttm_pool_shrinker_scan;
 	mm_shrinker->batch = TTM_SHRINKER_BATCH;
-- 
2.55.0

