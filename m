Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4521C61DDF
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23BBF10F02C;
	Thu, 27 Aug 2026 12:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YvwsvSB4";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94CCA10F025
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 12:49:24 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso19626445e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 05:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787834963; x=1788439763; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N8mDe5o2IhEvMzlea+bfmuWRPz0ePMPn3R+ho2zQsEc=;
 b=YvwsvSB4h/L2t5o2tucacfuwFd5v5bACPi70zyLLgyTLNygLcNDxMqO2n81mzBMhI+
 kRHvxUEzKo7RXpJxuH8VdRHPvIHr0vHy/W5RPPsylEfjwhdcH2zP8V6NujiHoWwuEcLY
 8w1ofZDWq3YXhJegEEmFmXirU/MmDwn6h1FT8SVThUvUsYb87/mVnpgYGDtrHDiE5Fji
 C9aXNoQJWoUNg9GQOViPuHUMtFRCy9+a6NXYNF5GV0aw/hp7GURTX5P4xXWgkhSDYqZa
 KGi4IqcdnaPRdM/Kl2eO6gWj1uBlD00N7rQnQVU6tunZGy4dJHk0X1snMA9syIGJm5/t
 L35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834963; x=1788439763;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N8mDe5o2IhEvMzlea+bfmuWRPz0ePMPn3R+ho2zQsEc=;
 b=RfYI0SkJEeyz0EXH2In+5iVEZo6OImAto8gcStTJmbZ/W0Amk+RYLp2Kkrb0qBHsBv
 KUHLh+nHeAaBYGcTy2KblguncoLwBfOaiVgJC6ylKAUEr0QqzCTaAB3sV+8IXHh4QIhT
 ykVrHpo5JOdbl48DFtlCihxokbNNpHnJDLre6CLgZhst57roqmnD7jABQAaKoccy+sQV
 4Dpc9mIyurmmsUpuGW0SWZp2srdtUtn25cBZIFpo6sRjyiyvfBAy7nx/2JyHgDt82sqa
 BZkYC8QsydTCBq0fS4Y+saJuCw49+GhrMUCVHk1zgPP3s7bzKiFVjU8CXIExasKzCLM8
 XHBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdMMWcwOrgee4ptymSpajZVGy5MXW1242zv0uKMgvml5FgSIZm/sIBWJW4fyBi9ZHapcziMSoN0Gw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nZnh4BQihRjFYnuirpAVWvwkRRclY7qhrDmO1Wh0BUOw3IeiSS
 ff9SxdItcoxfyWQAyH3ol+6gNYJ2WAlpZRnUOlfEBN3U0vDwKg9Km9Ub
X-Gm-Gg: AR+sD135RhQ1kYoHl608eqwwnmcv7DqGcwIlhJA88zeEF71O61fK2m5GfQXGW35uDQD
 s2jKl9kMjrlzV+TRHPTvOoF4i9E0iFbSn/I+O4Q9guBjAtd3/ja4pfjMFjrTl/sTgzVCWu9d1ul
 6sGVopkkLWHqOxlig79LV2m5ct2nMxf8EmGSWRVOo+VHzehN8mIJ6ZCwVRCg0lhJeqhNnC6/5vv
 uEY4QpPZ5Rd5WWRx9pzWe1N7tLsZ7TZpX63ftJKpCS2IeLG6LAnFOuerXV4d8IiUMyoYZmN+IwZ
 sR/JEV6kgFk7oo8N7vmvBvsG8/OICuZB1RgRtk/1+6gUg3QIpu5hQH5zrC4HHyUL/VY0Xs6fKGh
 jgkvkfToaOfNjqPA0H7T5TEh/B97KaHYYugPDxzogrNZpikE2E1CMWlcnY/RFHNLsEv6RzwRIRu
 d/4GU8C6NTE21OmsDFRFG9FGpNX8w/vjOm2rlR4MLhW1ouEG2JrLGDHk/b3hRJDmsUwScFuOYSE
 HV4y/0expw2
X-Received: by 2002:a05:600c:4592:b0:499:b402:6c0 with SMTP id
 5b1f17b1804b1-499dc6eac3bmr170763485e9.3.1787834962697; 
 Thu, 27 Aug 2026 05:49:22 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1524:4300:a4b8:720e:f64f:4778])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b465226d8sm52089985e9.0.2026.08.27.05.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:49:22 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/10] drm/ttm/tests: Use dma_resv_alloc in test files
Date: Thu, 27 Aug 2026 14:38:57 +0200
Message-ID: <20260827124910.2245-10-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827124910.2245-1-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
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
index 6fc381a9d2da..4559352e7115 100644
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

