Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2639BC44506
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584D910F946;
	Fri, 10 Jul 2026 19:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YlzW18S5";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4668A10E227
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:07:59 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4759b4f0897so753075f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783710477; x=1784315277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/fM2g6hrSRmJlUHgqQyOMFyX9IRPiNo3S9XYkHpe50w=;
 b=YlzW18S5//ZZ2aOznE5k4eERw0ydZMLwncIxPbPUJxS8azu7h+oYjXI38AFycvVfM5
 uAFTfmdJms5cG6FNli/ggg4PTpAAkN1wR/+6vt/JYQIq7dHpY3gbuLuKi6cKMk+g8VZ1
 rO3SLKLmQtsxz8fNeQ+Oo+2W2SjmhU152CwAPXqV+n58djQJAEuQO0he9GWLYJ/VTv5Q
 VPW0mZUmzG5UxpKWSsyL3hijxB48fmvo8InF2JG4oGxg3/aFNWsil1avE8TV64K4/C9m
 bLwUl9yaySc7GcNPjQvmJW2ZYDnpikA7yqvAW/UY2CQCy+Dqs3zK3Dzqx8ANJNtC2xFn
 tKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710477; x=1784315277;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/fM2g6hrSRmJlUHgqQyOMFyX9IRPiNo3S9XYkHpe50w=;
 b=IRYIC2gDdwpvmKvQtZ4TF+uewzoHC4exMRUzyJcAY97s4Zq3+iR+Srg4c08rDl5uv5
 Sb0bSKHM1vQaAFf3fBJY8FE+iMV41EvAZPVWMAsRUZJ8rRe4Pj9F8EqssbiL32yGQBjy
 Hp1LQBRUFgRQlTfX9ZV+6Lw/cqP9O5jDnZ/Eug6KrzF8xov/21eM0KAT5vL6mXSM+eO+
 7T6NNAuMjsN8aIVL/+Cq4ERradq7UvhHJgT+pefmXr17b5e5Ukn8PHRhX7seSH+M7nAi
 RC/koYm9NrC8mivo14/ubaZvv8r9SFLJ2bmvjuVCCYoH0RUQz8KlJL1keIfwu5v8knLK
 L49g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4vW9Fiy5u6Z6wShF3IAwN6joffVkow2UrQe1Tp/B3uel4uh+YWzfpLTp+cXi4Lliu5f9uY9rzWqA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDPRuDA3WxigZRGNjxpvD/h+UCr60MWGULD8/6PE6Q35k1KvFa
 vk30wlni+Jzxc9ne99E86nCFpf2etd46tsQGwBn3/o6K8t/fn1V5oxJDBwLSlA==
X-Gm-Gg: AfdE7cmNbT2WztSzszGVhUqZCWaQ8O/17O9qHDYjz/0rRudz/wqhbWaXH5khg8Dl4oR
 OJh3YZmn+OwFnpL+ZETtezxOqY4uO27Wd6/OTh+iGO/DiuYDDp14fkUfiRirA3oZLvsPUfrwWde
 WaPzD7evXd25HTprvqBJYK9AK3TdXfNsMetj2OtsrEkD3C27AgHZQrloYL7eOBQkIEiiDifKD+M
 MHq9861ZSULZ+UqGWhaEBnfODjOHqtZ8Jfs2XomHz5egn0JVXZ2RPdCA9+mza7S3tXm8NNHxg9R
 1Su20uAKLQaOWeUO1VF812SouOtjCahNljapMKdlPN9ZE9TI0V+DMqdZm3Hv0GUv0Ud0i56Hn5W
 l/MxUR2Rr7AyHutHvWBoKvbsCwE3la7VLLQNs3v04zrY894pSo922areWa1DQJbw8Q+J/Gyk69F
 HVKCUCN18D+GunmKI6b/tjpXZ4lg==
X-Received: by 2002:a05:600c:821a:b0:493:bba7:e9f4 with SMTP id
 5b1f17b1804b1-493f881ddfbmr1001965e9.18.1783710477135; 
 Fri, 10 Jul 2026 12:07:57 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154f:ec00:aa08:de24:db33:4496])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f567eadfsm55000755e9.6.2026.07.10.12.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:07:56 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 simona@ffwll.ch, matthew.brost@intel.com, nat@pixelcluster.dev,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/12] dma-buf/tests: Convert st-dma-resv tests to use
 dma_resv_alloc
Date: Fri, 10 Jul 2026 20:52:42 +0200
Message-ID: <20260710190752.2355-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710190752.2355-1-christian.koenig@amd.com>
References: <20260710190752.2355-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Update all test cases in st-dma-resv.c to use the new dma_resv_alloc()
API instead of stack-allocating dma_resv objects. This demonstrates the
proper usage of the new allocation and reference counting interface.

All five test functions now:
- Use dma_resv_alloc() to allocate objects
- Check for allocation failure with KUNIT_ASSERT_NOT_NULL
- Clean up with dma_resv_put() which handles freeing

This change also provides better test coverage for the reference
counting implementation.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/dma-buf/st-dma-resv.c | 90 +++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/drivers/dma-buf/st-dma-resv.c b/drivers/dma-buf/st-dma-resv.c
index 2c43d2d2b0169..b843d90417822 100644
--- a/drivers/dma-buf/st-dma-resv.c
+++ b/drivers/dma-buf/st-dma-resv.c
@@ -41,7 +41,7 @@ static struct dma_fence *alloc_fence(void)
 
 static void test_sanitycheck(struct kunit *test)
 {
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	struct dma_fence *f;
 	int r;
 
@@ -53,20 +53,22 @@ static void test_sanitycheck(struct kunit *test)
 	dma_fence_signal(f);
 	dma_fence_put(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, resv);
+
+	r = dma_resv_lock(resv, NULL);
 	if (r)
 		KUNIT_FAIL(test, "Resv locking failed\n");
 	else
-		dma_resv_unlock(&resv);
-	dma_resv_put(&resv);
+		dma_resv_unlock(resv);
+	dma_resv_put(resv);
 }
 
 static void test_signaling(struct kunit *test)
 {
 	const struct dma_resv_usage_param *param = test->param_value;
 	enum dma_resv_usage usage = param->usage;
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	struct dma_fence *f;
 	int r;
 
@@ -75,33 +77,35 @@ static void test_signaling(struct kunit *test)
 
 	dma_fence_enable_signaling(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, resv);
+
+	r = dma_resv_lock(resv, NULL);
 	if (r) {
 		KUNIT_FAIL(test, "Resv locking failed");
 		goto err_free;
 	}
 
-	r = dma_resv_reserve_fences(&resv, 1);
+	r = dma_resv_reserve_fences(resv, 1);
 	if (r) {
 		KUNIT_FAIL(test, "Resv shared slot allocation failed");
 		goto err_unlock;
 	}
 
-	dma_resv_add_fence(&resv, f, usage);
-	if (dma_resv_test_signaled(&resv, usage)) {
+	dma_resv_add_fence(resv, f, usage);
+	if (dma_resv_test_signaled(resv, usage)) {
 		KUNIT_FAIL(test, "Resv unexpectedly signaled");
 		goto err_unlock;
 	}
 	dma_fence_signal(f);
-	if (!dma_resv_test_signaled(&resv, usage)) {
+	if (!dma_resv_test_signaled(resv, usage)) {
 		KUNIT_FAIL(test, "Resv not reporting signaled");
 		goto err_unlock;
 	}
 err_unlock:
-	dma_resv_unlock(&resv);
+	dma_resv_unlock(resv);
 err_free:
-	dma_resv_put(&resv);
+	dma_resv_put(resv);
 	dma_fence_put(f);
 }
 
@@ -111,7 +115,7 @@ static void test_for_each(struct kunit *test)
 	enum dma_resv_usage usage = param->usage;
 	struct dma_resv_iter cursor;
 	struct dma_fence *f, *fence;
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	int r;
 
 	f = alloc_fence();
@@ -119,23 +123,25 @@ static void test_for_each(struct kunit *test)
 
 	dma_fence_enable_signaling(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, resv);
+
+	r = dma_resv_lock(resv, NULL);
 	if (r) {
 		KUNIT_FAIL(test, "Resv locking failed");
 		goto err_free;
 	}
 
-	r = dma_resv_reserve_fences(&resv, 1);
+	r = dma_resv_reserve_fences(resv, 1);
 	if (r) {
 		KUNIT_FAIL(test, "Resv shared slot allocation failed");
 		goto err_unlock;
 	}
 
-	dma_resv_add_fence(&resv, f, usage);
+	dma_resv_add_fence(resv, f, usage);
 
 	r = -ENOENT;
-	dma_resv_for_each_fence(&cursor, &resv, usage, fence) {
+	dma_resv_for_each_fence(&cursor, resv, usage, fence) {
 		if (!r) {
 			KUNIT_FAIL(test, "More than one fence found");
 			goto err_unlock;
@@ -158,9 +164,9 @@ static void test_for_each(struct kunit *test)
 	}
 	dma_fence_signal(f);
 err_unlock:
-	dma_resv_unlock(&resv);
+	dma_resv_unlock(resv);
 err_free:
-	dma_resv_put(&resv);
+	dma_resv_put(resv);
 	dma_fence_put(f);
 }
 
@@ -170,7 +176,7 @@ static void test_for_each_unlocked(struct kunit *test)
 	enum dma_resv_usage usage = param->usage;
 	struct dma_resv_iter cursor;
 	struct dma_fence *f, *fence;
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	int r;
 
 	f = alloc_fence();
@@ -178,25 +184,27 @@ static void test_for_each_unlocked(struct kunit *test)
 
 	dma_fence_enable_signaling(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, resv);
+
+	r = dma_resv_lock(resv, NULL);
 	if (r) {
 		KUNIT_FAIL(test, "Resv locking failed");
 		goto err_free;
 	}
 
-	r = dma_resv_reserve_fences(&resv, 1);
+	r = dma_resv_reserve_fences(resv, 1);
 	if (r) {
 		KUNIT_FAIL(test, "Resv shared slot allocation failed");
-		dma_resv_unlock(&resv);
+		dma_resv_unlock(resv);
 		goto err_free;
 	}
 
-	dma_resv_add_fence(&resv, f, usage);
-	dma_resv_unlock(&resv);
+	dma_resv_add_fence(resv, f, usage);
+	dma_resv_unlock(resv);
 
 	r = -ENOENT;
-	dma_resv_iter_begin(&cursor, &resv, usage);
+	dma_resv_iter_begin(&cursor, resv, usage);
 	dma_resv_for_each_fence_unlocked(&cursor, fence) {
 		if (!r) {
 			KUNIT_FAIL(test, "More than one fence found");
@@ -231,7 +239,7 @@ static void test_for_each_unlocked(struct kunit *test)
 	dma_resv_iter_end(&cursor);
 	dma_fence_signal(f);
 err_free:
-	dma_resv_put(&resv);
+	dma_resv_put(resv);
 	dma_fence_put(f);
 }
 
@@ -240,7 +248,7 @@ static void test_get_fences(struct kunit *test)
 	const struct dma_resv_usage_param *param = test->param_value;
 	enum dma_resv_usage usage = param->usage;
 	struct dma_fence *f, **fences = NULL;
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	int r, i;
 
 	f = alloc_fence();
@@ -248,24 +256,26 @@ static void test_get_fences(struct kunit *test)
 
 	dma_fence_enable_signaling(f);
 
-	dma_resv_init(&resv);
-	r = dma_resv_lock(&resv, NULL);
+	resv = dma_resv_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, resv);
+
+	r = dma_resv_lock(resv, NULL);
 	if (r) {
 		KUNIT_FAIL(test, "Resv locking failed");
 		goto err_resv;
 	}
 
-	r = dma_resv_reserve_fences(&resv, 1);
+	r = dma_resv_reserve_fences(resv, 1);
 	if (r) {
 		KUNIT_FAIL(test, "Resv shared slot allocation failed");
-		dma_resv_unlock(&resv);
+		dma_resv_unlock(resv);
 		goto err_resv;
 	}
 
-	dma_resv_add_fence(&resv, f, usage);
-	dma_resv_unlock(&resv);
+	dma_resv_add_fence(resv, f, usage);
+	dma_resv_unlock(resv);
 
-	r = dma_resv_get_fences(&resv, usage, &i, &fences);
+	r = dma_resv_get_fences(resv, usage, &i, &fences);
 	if (r) {
 		KUNIT_FAIL(test, "get_fences failed");
 		goto err_free;
@@ -282,7 +292,7 @@ static void test_get_fences(struct kunit *test)
 		dma_fence_put(fences[i]);
 	kfree(fences);
 err_resv:
-	dma_resv_put(&resv);
+	dma_resv_put(resv);
 	dma_fence_put(f);
 }
 
-- 
2.43.0

