Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3071C79F88
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C0010F612;
	Thu,  3 Sep 2026 13:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cxQdb7sP";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87EC810F618
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:44:22 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-485853f8800so243743f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788443061; x=1789047861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=osmnXHfN1aAvpkeZJQXAogNz4+3Y+e31osw4EooYaq4=;
 b=cxQdb7sP/NDcJRag7W6atmjLw72VpDydKIHQAB47X3mHiqOOz2Mxkr91WtzmAq+6HF
 gEiaZd/jwxh6jVkLSAVziWSX4p438OPln7C7N6OSKsLpNGj5UNFykmyvAK5IcmtJGAdB
 EUEU3AFvUato/dpf+7oub4KuvEINzi3aDUYqj/R/PUuHI+t3ddOqbcROsn09RIWCw99G
 KcI6rt5x1N8CN6DH6Y6UO7a2wDMuvH1+EbF2SxlRQfsHaVFU5qvZd8Xw/VR6kRaymTei
 RiO++FhpIvOFBCHA5n9+Y0ZHDMDRCQhEt7fdg5MIgmIqfChic5gLIHWwVARt2qwAX8vZ
 5Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443061; x=1789047861;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=osmnXHfN1aAvpkeZJQXAogNz4+3Y+e31osw4EooYaq4=;
 b=nXu4zyE1bvLJjDncSBjQr1gdjddBPtZ1PDPRrUcXdXcTnmqxDFitKRbBvWgum4NaH/
 yZ8ytAkzxejYkaBvxcfhuKVCFqUj+Q8ihRogBaADitHLDO2Ib8PwkkFFyMk4OUDxvtBn
 5qt44kcOENmX6WykmpSwrB6TTE4627nCETRz7i+XMtv1Bxu05YFPO0Q3wAm0OWuYyJqU
 tlUHt2kAroL4U6uiBSz2FUbC25bOJnhOVZp0PSbx5/2/2KA0Behe3IKOWcNJiZL0kC7h
 q+Iz3Yqj9d/gz3DrPQEgYrhEPH8CuRBsG13TDh8VF5iZpbfhm4iYjyxx9vzQpR+E4uMg
 YZDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzip7sw7bo3I6/zd/4XHazGaY/prfZO2UpwCwBilFVCiOa/2YZK7XriEk3ONO8DF/F/lJ/qlaeoOOA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mNCAilnzlsD9RyC5HUcZE/MLtTgho8iJAMAuHK613Kj+DqPnRM
 gnml8KwRKy+4gtWMJHUjlmo8Fq2PW9ffBcn7leNZ0uIBJKSrBOi/CNDK
X-Gm-Gg: AYBFou1soAi3x2G103vC2lwIR+Q7cVJfgCc6whYePoS/hQf8mxAY+zIvjXdwhN5et6L
 uybJ1p/LkelIN+ZHRQbNErZNYkY7hMulV2GkyWi9kdznMs3/6o/sfEx9GsPleEnH+jqu2pG3+A6
 4GzBMBuS5EX6eLAtqNOBfVjHgNsMx6RTCpq1o/Nsapbrx8hZdxoVWLw/E7FxrcCUbyztWjJvmgs
 4Y+TE62ab/v5BmFNQ9Mr81ZrA1cJhj/nqCuOtc8Pi3zJsEXV6xtwt8v44S395dvtevUz12RQwrv
 6SZS7AsUvlccfS4oXuis8J8EMleR2YDJA2/zMUMYKDpPCM/q/HGMRkCbee0XwUG/LLMmb8m76a/
 5112aStbAJb2LmzDGkt4dHXL1FEvsibJI6CYaSGTdvqxdJ3oNxsmgD6wvoaJJcvlRP+KSKhrQUZ
 QQq4TFmIMpj5YRkt+dXQ8meTzOHrwIsWXzMnQXww5msaVZxvOkVEA8i9jp+QgSpo5gJ+u9TOZgG
 g==
X-Received: by 2002:a5d:5e86:0:b0:485:8226:c693 with SMTP id
 ffacd0b85a97d-4858226c906mr4126355f8f.18.1788443060763; 
 Thu, 03 Sep 2026 06:44:20 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:4700:e712:9f38:603a:54e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e736a6sm13597080f8f.5.2026.09.03.06.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:19 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/11] drm/ttm/tests: Use dma_resv_alloc in test files
Date: Thu,  3 Sep 2026 15:28:04 +0200
Message-ID: <20260903134408.105317-10-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903134408.105317-1-christian.koenig@amd.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
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

Replace the remaining dma_resv_init usage in TTM test files with
dma_resv_alloc(). This completes the migration away from embedded
dma_resv structures to reference-counted dynamic allocation throughout
the DRM subsystem.

Changes in test files:
- ttm_bo_validate_test.c: Convert stack-allocated resv to pointer and
  use dma_resv_alloc() with proper cleanup via dma_resv_put()
- ttm_bo_test.c: Replace kunit_kzalloc + dma_resv_init with direct
  dma_resv_alloc() calls, add cleanup for external_resv

All test assertions updated to check for successful allocation. The
tests now properly exercise the dynamic allocation path that production
code uses.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c          | 11 ++++-------
 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c | 13 ++++++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
index 3aff1c427cd1..853024724af9 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
@@ -339,14 +339,12 @@ static void ttm_bo_unreserve_bulk(struct kunit *test)
 	ttm_dev = kunit_kzalloc(test, sizeof(*ttm_dev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ttm_dev);
 
-	resv = kunit_kzalloc(test, sizeof(*resv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, resv);
-
 	err = ttm_device_kunit_init(priv, ttm_dev, 0);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	priv->ttm_dev = ttm_dev;
 
-	dma_resv_init(resv);
+	resv = dma_resv_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, resv);
 
 	bo1 = ttm_bo_kunit_init(test, test->priv, BO_SIZE, resv);
 	bo2 = ttm_bo_kunit_init(test, test->priv, BO_SIZE, resv);
@@ -441,11 +439,9 @@ static void ttm_bo_fini_shared_resv(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, err, 0);
 	priv->ttm_dev = ttm_dev;
 
-	external_resv = kunit_kzalloc(test, sizeof(*ttm_dev), GFP_KERNEL);
+	external_resv = dma_resv_alloc();
 	KUNIT_ASSERT_NOT_NULL(test, external_resv);
 
-	dma_resv_init(external_resv);
-
 	fence = kunit_kzalloc(test, sizeof(*fence), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, fence);
 
@@ -464,6 +460,7 @@ static void ttm_bo_fini_shared_resv(struct kunit *test)
 	drm_gem_object_set_resv(&bo->base, external_resv);
 
 	ttm_bo_fini(bo);
+	dma_resv_put(external_resv);
 }
 
 static void ttm_bo_pin_basic(struct kunit *test)
diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
index bb430763e7a5..e0ecadccccf8 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
@@ -201,7 +201,7 @@ static void ttm_bo_init_reserved_resv(struct kunit *test)
 	struct ttm_placement *placement;
 	struct ttm_buffer_object *bo;
 	struct ttm_place *place;
-	struct dma_resv resv;
+	struct dma_resv *resv;
 	int err;
 
 	bo = kunit_kzalloc(test, sizeof(*bo), GFP_KERNEL);
@@ -212,19 +212,22 @@ static void ttm_bo_init_reserved_resv(struct kunit *test)
 
 	err = drm_gem_private_object_init(priv->drm, &bo->base, size);
 	KUNIT_ASSERT_EQ(test, err, 0);
-	dma_resv_init(&resv);
-	dma_resv_lock(&resv, NULL);
+
+	resv = dma_resv_alloc();
+	KUNIT_ASSERT_NOT_NULL(test, resv);
+	dma_resv_lock(resv, NULL);
 
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo, bo_type, placement,
-				   PAGE_SIZE, &ctx, NULL, &resv,
+				   PAGE_SIZE, &ctx, NULL, resv,
 				   &dummy_ttm_bo_destroy);
 	dma_resv_unlock(bo->base.resv);
 
 	KUNIT_EXPECT_EQ(test, err, 0);
-	KUNIT_EXPECT_PTR_EQ(test, bo->base.resv, &resv);
+	KUNIT_EXPECT_PTR_EQ(test, bo->base.resv, resv);
 
 	ttm_resource_free(bo, &bo->resource);
 	ttm_bo_fini(bo);
+	dma_resv_put(resv);
 }
 
 static void ttm_bo_validate_basic(struct kunit *test)
-- 
2.43.0

