Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB486CD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CAC110ECD9;
	Tue, 16 Jun 2026 18:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R1LFrXy4";
	dkim-atps=neutral
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 857E910E563
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 23:50:03 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-915aa0a9293so485066585a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 16:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781567402; x=1782172202; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMomLA5yc+OAXvOs3SpKTXvia9aXXpiO5BxVYuDjyFA=;
 b=R1LFrXy4gIycIJLbsi4rpYpJGMc6NH0ho+f9eWJbTXTQxNAf5hWaORlNsRFzhNWio3
 wPG1CqiN6dydRQqSfv37Y7bSYchfSkBjzBhZVSRphX+pW9/YY6K0IyzNKlrOK85Woc9u
 FaeLhDS9hOpAackAeMiNl6/mBbe+q2d526XWqwJ6C5D/Ql37PvF/76fdtYkgMXNwKgY0
 ZeRhjdN5AiC+SWnkHBd9YgXNUYaLkaomu7SF/8H/SvSsItpo81ZE6SWRCmNtn81dm/+T
 u73zHsR2K7XoeHt9ghi8kfKuXN7uRxOaszFbnsYRsyjHX5EFe66WwqImu1LfEbQX90qW
 WnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781567402; x=1782172202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gMomLA5yc+OAXvOs3SpKTXvia9aXXpiO5BxVYuDjyFA=;
 b=LJMsj2FFgiLlL4aO/ocXVKwlOGCgLfJ1490jzIam9Eq1Ef/4BZnXPOxHGbD/Oy6oP7
 dFg9+l4fYaFerNykFqBjl0w9cUYhcP/z8vTKLCtiCev2u1LjH0Sw0bVXHq+t04sN1ofL
 ReMfHiM1bWxUF+f8XsJZ0e2piJAiub7jKkLAyQGsjjv1BWMA5JBy7yeVaNv0d6Mt4MyP
 ZbcdYJTpuGoUvG3z0w5w3vTmIhz7NcnmhRxDhrEWwbxJofz6rXfsij+6QSfkD6M/zYv6
 hEI2putDpPB8t6edzrkyQieAnf6NUKv7KqJXt+RCn3kdqtevQ0soY1ZOIgwTMTGlEK7E
 l0sw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hudmQKc6Dkg357nTKI4xn5Fs1KdMoWRixQtXcq82HG0QG1yEnOmrZsRmDDv5ce+0eYyt5jDKQMwE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiOcGEHISYWIm0jWjllNkZjl3n9zMZfwr8c2/7nj3SjbPK8L2p
 5hsyn8uRMGi4imzneN+FNz38R7X7oLmjhzyhTw2lOc+tVSpFnPJLSaMb
X-Gm-Gg: Acq92OHHBkSjvwERt6Il57FPcFPm3/VaLoEH7KjXDP8wes5ndYGpu9r+Xt6aIu+gNEL
 /IJJ5p6RP16AtjIBluUDYcl2ZAaL91n0VdwkhE9ZeBKsL1HPgnQBEHY8ZBoqoPyt6w7mURgo/7f
 Fl1oDb4Z6umjBEr7dImsbbhIC6dm9R5uz0zGMUivUCyBwHzxwrFGyNY5/wieSrjMMLcnQaN+s/0
 XLuHRKDxcNmT8JFCZB8rfVHfmOUjIUCDbS1Fa7IeO/+/Q2DTgdaRPfJ/yCRY4D93vAIMJZ65fLJ
 vT6fJUjFOVJwWl5G+fm/f/ls4+YvveQ32DX+QpkIPF79ywtYiUK5iaco1C9v/qJ/OGEQTpBSitV
 FGSEk8MYR8o+lFAglIliYSrsspdBlocPEbT990SkThGg51QfD9mvIAVsPS9r7IdBNQwybtLiCKd
 iTwXMLRoLliDu69H+z9FBOqfFViztaRGixS9BEPS0lh2rrOf6ojlafltytUTTCmLE5ycG2RwChg
 /UiqJzS53ua
X-Received: by 2002:a05:620a:4008:b0:8f2:1ccf:46d2 with SMTP id
 af79cd13be357-91c2f1caa82mr230132685a.32.1781567402022; 
 Mon, 15 Jun 2026 16:50:02 -0700 (PDT)
Received: from tropical-turnip.tail32462.ts.net ([216.132.43.94])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a00af50sm1387942285a.30.2026.06.15.16.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 16:50:01 -0700 (PDT)
From: Samuel Ainsworth <skainsworth@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Samuel Ainsworth <skainsworth@gmail.com>
Subject: [PATCH v1 2/2] drm/ttm/tests: add bulk_move cursor regression tests
Date: Mon, 15 Jun 2026 19:49:22 -0400
Message-ID: <20260615234922.151263-3-skainsworth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615234922.151263-1-skainsworth@gmail.com>
References: <20260615234922.151263-1-skainsworth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 18:18:52 +0000
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

Add two kunit tests for the bulk_move LRU cursor accounting fixed in the
previous commit:

  - ttm_bo_bulk_move_swapped_free_dangles frees a swapped (unevictable)
    resource that is still referenced by the bulk_move cursor and
    asserts the cursor no longer points at the freed resource.

  - ttm_bo_bulk_move_dangling_corrupts then allocates on the same
    bulk_move, which without the fix dereferences the dangling cursor --
    reported by KASAN as a slab-use-after-free in
    ttm_resource_add_bulk_move().

Both run with no GPU under the existing TTM mock device. Without the fix
the first fails its expectation and the second triggers the
use-after-free; with it the whole TTM kunit suite passes.

Signed-off-by: Samuel Ainsworth <skainsworth@gmail.com>
---
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c | 163 ++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
index d468f8322072..07ad1a7821fd 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
@@ -603,7 +603,170 @@ static void ttm_bo_multiple_pin_one_unpin(struct kunit *test)
 	ttm_resource_free(bo, &res);
 }
 
+/*
+ * Regression tests for bulk_move LRU cursor accounting: a resource added to a
+ * bo's bulk_move cursor can become unevictable (pinned or swapped) before it is
+ * freed. ttm_resource_del_bulk_move() must still take it off the cursor, or
+ * pos->first/last are left dangling at the freed resource.
+ */
+
+/*
+ * Free a swapped (unevictable) resource that is still referenced by the
+ * bulk_move cursor and check that the cursor no longer points at it.
+ */
+static void ttm_bo_bulk_move_swapped_free_dangles(struct kunit *test)
+{
+	struct ttm_test_devices *priv = test->priv;
+	struct ttm_lru_bulk_move lru_bulk_move;
+	struct ttm_lru_bulk_move_pos *pos;
+	struct ttm_operation_ctx ctx = { };
+	struct ttm_resource *res1, *res1_saved;
+	struct ttm_buffer_object *bo1;
+	struct ttm_device *ttm_dev;
+	struct ttm_place *place;
+	struct dma_resv *resv;
+	struct ttm_tt *tt;
+	int err;
+
+	ttm_lru_bulk_move_init(&lru_bulk_move);
+	place = ttm_place_kunit_init(test, TTM_PL_SYSTEM, 0);
+
+	ttm_dev = kunit_kzalloc(test, sizeof(*ttm_dev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ttm_dev);
+	err = ttm_device_kunit_init(priv, ttm_dev, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	priv->ttm_dev = ttm_dev;
+
+	resv = kunit_kzalloc(test, sizeof(*resv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, resv);
+	dma_resv_init(resv);
+
+	bo1 = ttm_bo_kunit_init(test, priv, BO_SIZE, resv);
+
+	/* bo1: put a SYSTEM resource on the bulk_move pos */
+	dma_resv_lock(bo1->base.resv, NULL);
+	ttm_bo_set_bulk_move(bo1, &lru_bulk_move);
+	err = ttm_resource_alloc(bo1, place, &res1, NULL);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	bo1->resource = res1;
+
+	pos = &lru_bulk_move.pos[TTM_PL_SYSTEM][bo1->priority];
+	/* res1 is now tracked by the bulk_move pos */
+	KUNIT_EXPECT_PTR_EQ(test, pos->first, res1);
+	KUNIT_EXPECT_PTR_EQ(test, pos->last, res1);
+
+	/* make bo1->ttm swapped so res1 is "unevictable" (ttm_resource_is_swapped) */
+	tt = kunit_kzalloc(test, sizeof(*tt), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tt);
+	err = ttm_tt_init(tt, bo1, 0, ttm_cached, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	bo1->ttm = tt;
+	err = ttm_tt_populate(ttm_dev, tt, &ctx);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	ttm_tt_swapout(ttm_dev, tt, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, tt->page_flags & TTM_TT_FLAG_SWAPPED);
+
+	/* res1 is still tracked by the pos right before the free */
+	KUNIT_EXPECT_PTR_EQ(test, pos->first, res1);
+
+	/*
+	 * Free res1 while it is swapped (unevictable). ttm_resource_free() calls
+	 * ttm_resource_del_bulk_move(), which is a no-op for an unevictable
+	 * resource -- so res1 is NOT removed from the bulk_move pos before the
+	 * underlying memory is freed.
+	 */
+	res1_saved = res1;
+	ttm_resource_free(bo1, &res1);
+	dma_resv_unlock(bo1->base.resv);
+
+	/*
+	 * A correct implementation must not leave the bulk_move pos pointing at
+	 * the freed resource. On the buggy code these still equal the freed
+	 * res1_saved (a dangling pointer that the next add/move dereferences).
+	 */
+	KUNIT_EXPECT_PTR_NE(test, pos->first, res1_saved);
+	KUNIT_EXPECT_PTR_NE(test, pos->last, res1_saved);
+
+	dma_resv_fini(resv);
+}
+
+/*
+ * After a swapped-free leaves the bulk_move cursor dangling, a later
+ * ttm_resource_alloc() on the same bulk_move dereferences the freed cursor in
+ * ttm_lru_bulk_move_add() (use-after-free, catchable with KASAN) and corrupts
+ * the LRU list.
+ */
+static void ttm_bo_bulk_move_dangling_corrupts(struct kunit *test)
+{
+	struct ttm_test_devices *priv = test->priv;
+	struct ttm_lru_bulk_move lru_bulk_move;
+	struct ttm_operation_ctx ctx = { };
+	struct ttm_buffer_object *bo1, *bo2;
+	struct ttm_resource *res1, *res2;
+	struct ttm_device *ttm_dev;
+	struct ttm_place *place;
+	struct dma_resv *resv1, *resv2;
+	struct ttm_tt *tt;
+	int err;
+
+	ttm_lru_bulk_move_init(&lru_bulk_move);
+	place = ttm_place_kunit_init(test, TTM_PL_SYSTEM, 0);
+
+	ttm_dev = kunit_kzalloc(test, sizeof(*ttm_dev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ttm_dev);
+	err = ttm_device_kunit_init(priv, ttm_dev, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	priv->ttm_dev = ttm_dev;
+
+	resv1 = kunit_kzalloc(test, sizeof(*resv1), GFP_KERNEL);
+	resv2 = kunit_kzalloc(test, sizeof(*resv2), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, resv1);
+	KUNIT_ASSERT_NOT_NULL(test, resv2);
+	dma_resv_init(resv1);
+	dma_resv_init(resv2);
+
+	bo1 = ttm_bo_kunit_init(test, priv, BO_SIZE, resv1);
+	bo2 = ttm_bo_kunit_init(test, priv, BO_SIZE, resv2);
+
+	/* bo1: resource on the bulk_move pos, then swap + free -> dangling pos */
+	dma_resv_lock(bo1->base.resv, NULL);
+	ttm_bo_set_bulk_move(bo1, &lru_bulk_move);
+	err = ttm_resource_alloc(bo1, place, &res1, NULL);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	bo1->resource = res1;
+
+	tt = kunit_kzalloc(test, sizeof(*tt), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tt);
+	err = ttm_tt_init(tt, bo1, 0, ttm_cached, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	bo1->ttm = tt;
+	err = ttm_tt_populate(ttm_dev, tt, &ctx);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	ttm_tt_swapout(ttm_dev, tt, GFP_KERNEL);
+
+	ttm_resource_free(bo1, &res1);
+	dma_resv_unlock(bo1->base.resv);
+
+	/*
+	 * bo2 allocates on the SAME bulk_move. ttm_lru_bulk_move_add() reads the
+	 * dangling pos->first (freed res1) and list_move()s relative to the freed
+	 * pos->last -> use-after-free + list corruption.
+	 */
+	dma_resv_lock(bo2->base.resv, NULL);
+	ttm_bo_set_bulk_move(bo2, &lru_bulk_move);
+	err = ttm_resource_alloc(bo2, place, &res2, NULL);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	bo2->resource = res2;
+	ttm_resource_free(bo2, &res2);
+	dma_resv_unlock(bo2->base.resv);
+
+	dma_resv_fini(resv1);
+	dma_resv_fini(resv2);
+}
+
 static struct kunit_case ttm_bo_test_cases[] = {
+	KUNIT_CASE(ttm_bo_bulk_move_swapped_free_dangles),
+	KUNIT_CASE(ttm_bo_bulk_move_dangling_corrupts),
 	KUNIT_CASE_PARAM(ttm_bo_reserve_optimistic_no_ticket,
 			 ttm_bo_reserve_gen_params),
 	KUNIT_CASE(ttm_bo_reserve_locked_no_sleep),
-- 
2.54.0

