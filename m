Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487BAC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A0310F945;
	Fri, 10 Jul 2026 19:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YSrMpfEk";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC9410F946
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:08:01 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493f140ca8eso7939415e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783710480; x=1784315280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nud4LNt/xG3jbsNqzwGg/sdwe8KwtNGJ8l07srTvdek=;
 b=YSrMpfEkJSPhM+gvQDFRCgk4owQOTS0FAwQCd1uoqP5PY6D0vKf+mc15Dy+q8UOhk5
 HyKJhAXosU8huu8coAhgghcQsQv8RO0zaLC/TPb9wvNOUbd1QEjFu66ScmA+YWm5q7SC
 Yn2u2FeIiKlpTgOKRbTQc1rfE/3SKexYpt55WCEG1iQAKBFti+bE7fRmnIyLD/QMwNXx
 k908LXBFAW/8qpZwvJjlHl5+B1dkGZ0Uy5F2quKq05Y9vk9Gnt3djFthvHmex59U9wJU
 q/LuwEK243koZwnhTGxp0dWJhjeBFw0ZUo7z5fVsJstMT+Qho7mFQh+FtZ/NpHysZs9h
 sbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710480; x=1784315280;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nud4LNt/xG3jbsNqzwGg/sdwe8KwtNGJ8l07srTvdek=;
 b=LDICrRnCqZzMCk+x/6ko2fXdc6qqkL+/grR3Jf/17ddtkgrpxPfZyAt8cS81/goaWy
 rIBRH8sJ/T9t91DOxvXM8i0nL2DItrV+YbcH6OTigNXblcWXuUFGJ8kstXBCKI1jbTbv
 Xzv+rmkqndyg/XqjUWHpQOF//T+kV12N+QtcsaZQW2D43V8dHVJULyz76meYkwLZz01K
 DfoIE/RBNnc0fAZ4w7gI1PIm5u2nGNxto2ptbyoAfNYFpPfT2EsQh/9Yl/Lcg6w+h4RP
 hQRAMjCuDcn2GuQRepZNuBrjfEECyKiqsIfKDunvMgAMl8mwKhHBG14oKzFWFBHtWHZG
 4F9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RplTbv7g19xv5jUX0gfSVrTsk1MBbe8ZvDMNU/sVxylhWRKlPcdLzIV7vRd9MR/JLgXv2gdiW/injw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzKbKHyTE8SZMn2X3zYfkw/BS1rJFcFNlQE4VuglOV2x+unAU/
 tGWx7BVX+uuPVKQgw+COgbQhMcqr2Hv5Ig2erENxe787LeQZhdv259Lw
X-Gm-Gg: AfdE7cnTb1IFdCb+f+ss75L+IJlx+KL1p6FLsB3vcwF3jhCny+UgquiXNADmWDkJ9Y2
 3/vinSAJYRS5phgYExQJg9LPtTxwjhS55iNZUutbq+h80WcwmQgW4Y2aB0N1MeLxJ5FaxMYn1Ga
 kYrrpifwq4VWxr49gAGNocz75kYyYISQQkmnro68u2Cn+Wan/yQkRB6eTSktz7jLzLGKMI3EUUC
 66Sk4rNAY0M408xUzZ3bHsgvO4Hv/cCqQD8ZqVk3bRiWKJE+xXkFgJOpHg2s95LxjfFoS60/KQA
 +sYbR2cQxLGKwmOI145iUj3wDQDXEyuLtA7+5HynVeYPWS0F0pQnHqPXSo8WlXKc/7A0rfbVV5T
 4ycZvl2ijn5PhbkR6jPlI9MpRAi0S5hm5PaILhmjFf7nPwYkAb2OG1LH3LvrsMDfohONcvmyluL
 mVKLdeT6gKNdK7ShN1CVVmpJlvtw==
X-Received: by 2002:a05:600c:1394:b0:493:b89b:9a27 with SMTP id
 5b1f17b1804b1-493f87e6c34mr1200255e9.9.1783710479887; 
 Fri, 10 Jul 2026 12:07:59 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154f:ec00:aa08:de24:db33:4496])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f567eadfsm55000755e9.6.2026.07.10.12.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:07:59 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 simona@ffwll.ch, matthew.brost@intel.com, nat@pixelcluster.dev,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/12] drm/ttm: switch to ttm_bo_lru_for_each_reserved_guarded
 for swapout
Date: Fri, 10 Jul 2026 20:52:45 +0200
Message-ID: <20260710190752.2355-6-christian.koenig@amd.com>
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

Instead of the walker wrapper use the underlying foreach. Saves us quite
a bunch of complexity and loc.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c     | 64 ++++++--------------------------
 drivers/gpu/drm/ttm/ttm_device.c | 19 ++++++++--
 include/drm/ttm/ttm_bo.h         |  5 +--
 3 files changed, 28 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 8cf266da2bc61..db72fb2fde9ff 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1088,25 +1088,18 @@ int ttm_bo_wait_ctx(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx)
 EXPORT_SYMBOL(ttm_bo_wait_ctx);
 
 /**
- * struct ttm_bo_swapout_walk - Parameters for the swapout walk
+ * ttm_bo_swapout() - Swap out buffer objects on the LRU list to shmem.
+ * @bo: The buffer to swap out.
+ * @ctx: The ttm_operation_ctx governing the swapout operation.
+ * @gfp_flags: The gfp flags used for shmem page allocations.
+ *
+ * Return: The number of bytes actually swapped out, or negative error code
+ * on error.
  */
-struct ttm_bo_swapout_walk {
-	/** @walk: The walk base parameters. */
-	struct ttm_lru_walk walk;
-	/** @gfp_flags: The gfp flags to use for ttm_tt_swapout() */
-	gfp_t gfp_flags;
-	/** @hit_low: Whether we should attempt to swap BO's with low watermark threshold */
-	/** @evict_low: If we cannot swap a bo when @try_low is false (first pass) */
-	bool hit_low, evict_low;
-};
-
-static s64
-ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
+s64 ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
+		   gfp_t gfp_flags)
 {
-	struct ttm_place place = { .mem_type = bo->resource->mem_type };
-	struct ttm_bo_swapout_walk *swapout_walk =
-		container_of(walk, typeof(*swapout_walk), walk);
-	struct ttm_operation_ctx *ctx = walk->arg.ctx;
+	struct ttm_place place = {.mem_type = bo->resource->mem_type};
 	struct ttm_device *bdev = bo->bdev;
 	struct ttm_tt *tt = bo->ttm;
 	s64 ret;
@@ -1174,7 +1167,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 		bdev->funcs->swap_notify(bo);
 
 	if (ttm_tt_is_populated(tt)) {
-		ret = ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
+		ret = ttm_tt_swapout(bdev, tt, gfp_flags);
 		if (!ret) {
 			spin_lock(&bdev->lru_lock);
 			ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
@@ -1191,41 +1184,6 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 	return ret;
 }
 
-const struct ttm_lru_walk_ops ttm_swap_ops = {
-	.process_bo = ttm_bo_swapout_cb,
-};
-
-/**
- * ttm_bo_swapout() - Swap out buffer objects on the LRU list to shmem.
- * @bdev: The ttm device.
- * @ctx: The ttm_operation_ctx governing the swapout operation.
- * @man: The resource manager whose resources / buffer objects are
- * goint to be swapped out.
- * @gfp_flags: The gfp flags used for shmem page allocations.
- * @target: The desired number of pages to swap out.
- *
- * Return: The number of pages actually swapped out, or negative error code
- * on error.
- */
-s64 ttm_bo_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ctx,
-		   struct ttm_resource_manager *man, gfp_t gfp_flags,
-		   s64 target)
-{
-	struct ttm_bo_swapout_walk swapout_walk = {
-		.walk = {
-			.ops = &ttm_swap_ops,
-			.arg = {
-				.ctx = ctx,
-				.trylock_only = true,
-			},
-		},
-		.gfp_flags = gfp_flags,
-	};
-
-	return ttm_lru_walk_for_evict(&swapout_walk.walk, bdev, man, target);
-}
-EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_bo_swapout);
-
 void ttm_bo_tt_destroy(struct ttm_buffer_object *bo)
 {
 	if (bo->ttm == NULL)
diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index d3bfb9a696a74..e4188e2ee7ab1 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -171,6 +171,12 @@ int ttm_device_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ctx,
 		       gfp_t gfp_flags)
 {
 	struct ttm_resource_manager *man;
+	struct ttm_bo_lru_cursor cursor;
+	struct ttm_buffer_object *bo;
+	struct ttm_lru_walk_arg arg = {
+		.ctx = ctx,
+		.trylock_only = true
+	};
 	unsigned i;
 	s64 lret;
 
@@ -179,10 +185,15 @@ int ttm_device_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ctx,
 		if (!man || !man->use_tt)
 			continue;
 
-		lret = ttm_bo_swapout(bdev, ctx, man, gfp_flags, 1);
-		/* Can be both positive (num_pages) and negative (error) */
-		if (lret)
-			return lret;
+		ttm_bo_lru_for_each_reserved_guarded(&cursor, man, &arg, bo) {
+			lret = ttm_bo_swapout(bo, ctx, gfp_flags);
+				continue;
+			/* Can be both positive (num_pages) and negative (error) */
+			if (lret && lret != -EBUSY && lret != -EALREADY)
+				return lret;
+		}
+		if (IS_ERR(bo))
+			return PTR_ERR(bo);
 	}
 	return 0;
 }
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 30e835414e721..33dfa61ba882a 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -423,9 +423,8 @@ void *ttm_bo_kmap_try_from_panic(struct ttm_buffer_object *bo, unsigned long pag
 int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map);
 void ttm_bo_vunmap(struct ttm_buffer_object *bo, struct iosys_map *map);
 int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_buffer_object *bo);
-s64 ttm_bo_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ctx,
-		   struct ttm_resource_manager *man, gfp_t gfp_flags,
-		   s64 target);
+s64 ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
+		   gfp_t gfp_flags);
 void ttm_bo_pin(struct ttm_buffer_object *bo);
 void ttm_bo_unpin(struct ttm_buffer_object *bo);
 int ttm_bo_evict_first(struct ttm_device *bdev,
-- 
2.43.0

