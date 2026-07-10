Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DEBC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F39410F95B;
	Fri, 10 Jul 2026 19:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iw65ymGZ";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1A710F94F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:08:03 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493f60208a5so7599635e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783710482; x=1784315282; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HPmD3vMJoHO8CFqL7S7C4nD2ho35ackVcxiEqNgTWIk=;
 b=Iw65ymGZ0nr4pjqYS+zQ0QSKjdX9OvxcyT6J9Pk4s1d1AYVv+2+/vrthASVGHbisP8
 wzJksvPWoweX91B2ssMA96sFTDY0O0TjrRuU5wWMncboMm1eu8T/DIwkpMSHrpwV+tNV
 1X6yFQMHPhCg6juuO5gfyPKSzqI6u5LOubxIOnQ4lTglajsbkZSAMYdhj7AvrowM4T54
 6fncH3Omkb0oa6BBhHYkFV0PgLQyx8i9OD5Vj9BmuV2NteKKxnio9RqMreD1wOyV8YN5
 uarnclsjgpMzCJCU+IlMtzwlkpG+u6lz3D2nU9JuvFDeYONHAblipEmZbdIvS6Wfl08k
 p3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710482; x=1784315282;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HPmD3vMJoHO8CFqL7S7C4nD2ho35ackVcxiEqNgTWIk=;
 b=ABRa9QJthcSDGfZOQywHJ+9d0rkO++UzR/iutQkQ6h2lOe0bKyuP0jRH6eBzqMIIgC
 3Xg3O69sc12BJWmB0IRBv656UZLwAGK8Nd1rmOLjHBmc30ydeM6jtD3vUWRQnVAcUc7d
 QDYO4ODTrOQlCSG2W+lM0oBBKGg+ra+pxK2Sj4QKPkLuUREE2KCySaCtk6qm2h1B391U
 W89kWGKyl/cvZqWhQ49GxlDGWOF5mujalNG7/K26GSu3hlcbwbXfvqOxjGrBMrxuhzz7
 UrBYM1K0roAYvm4Dn1SvlOtNJDKhAtm+BRTYwFQm9dapA6tlxS10pBX9UuH8kCL6FC+b
 p92w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLV2RCMW7wVKE++eW6IMdptMEpZL4j0yvC/Y5DZaVP0QXcH1MWF6qPgNkIi4C9VAPjRifemrxY4vo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDG0ueP1syULtAnlsPWyUFXWm0pS7QbAeLuB8+iDH9LoPCsb8/
 o38aPiNOvusk/JBz7D6peALJX09mas8ODMBLv5zJt6ztktGFUmG99R7XJKDQvAbGlJ0=
X-Gm-Gg: AfdE7cmdcnP3LYzZi+QK+KiY2TGwNj/IIwFJoEnFeAC0jcvGXqDgqAzB+B+NbRSlRVy
 LJUf5P3vTiWLlgXeGpB9zTiZINIZYK4MB4hzcBXl3Le5T20JSRIdoDGpmrd8ozQRltgM//jh+ae
 HHFE2aarqVsdZodm877UA/+IWM50qROSEJb6BCXkjr9DVXV2kMry9n7U6hwUYLxhrHJC35B1ZRT
 3bpPDjRWoPVhHhd7wyxVmZvmzgoOu7vx/1WNLhP649QQ5U3EN+lpQtPKppNDUO8uO83kBltgrsw
 u2T+bFzgy78LUeRQH68M3+5ElKpQdJz9fmp5vAmUxS51jHYce2zKatrCCBTQX3r3PBhzCfIK1YX
 cq8mkNNhRvtsHY8kbLuuWkOQP/3UvNCNHm1shlPQW9W2H7XDnKwFDYorFRMywpx82jh/GpucCQ6
 jIPqgr88G6XQkx1Gp8rQO1iDbU6kmoHvQvLz6u
X-Received: by 2002:a05:600c:1f91:b0:493:e79e:daa6 with SMTP id
 5b1f17b1804b1-493f8826e69mr975965e9.33.1783710481767; 
 Fri, 10 Jul 2026 12:08:01 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154f:ec00:aa08:de24:db33:4496])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f567eadfsm55000755e9.6.2026.07.10.12.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:08:01 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 simona@ffwll.ch, matthew.brost@intel.com, nat@pixelcluster.dev,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/12] drm/ttm: use ttm_bo_lru_for_each_reserved_guarded in
 evict_all
Date: Fri, 10 Jul 2026 20:52:47 +0200
Message-ID: <20260710190752.2355-8-christian.koenig@amd.com>
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

Use the for_each loop to evict all BOs of an resource manager as well.

Greately simplifying the handling and finally allows us to
remove ttm_bo_evict_first().

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c       | 51 +-----------------------------
 drivers/gpu/drm/ttm/ttm_resource.c | 22 +++++++++----
 include/drm/ttm/ttm_bo.h           |  1 +
 3 files changed, 17 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index e28e11c06ef48..6af247dba53e5 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -355,8 +355,7 @@ static int ttm_bo_bounce_temp_buffer(struct ttm_buffer_object *bo,
 	return 0;
 }
 
-static int ttm_bo_evict(struct ttm_buffer_object *bo,
-			struct ttm_operation_ctx *ctx)
+int ttm_bo_evict(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx)
 {
 	struct ttm_resource *evict_mem;
 	struct ttm_placement placement;
@@ -441,54 +440,6 @@ bool ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(ttm_bo_eviction_valuable);
 
-/**
- * ttm_bo_evict_first() - Evict the first bo on the manager's LRU list.
- * @bdev: The ttm device.
- * @man: The manager whose bo to evict.
- * @ctx: The TTM operation ctx governing the eviction.
- *
- * Return: 0 if successful or the resource disappeared. Negative error code on error.
- */
-int ttm_bo_evict_first(struct ttm_device *bdev, struct ttm_resource_manager *man,
-		       struct ttm_operation_ctx *ctx)
-{
-	struct ttm_resource_cursor cursor;
-	struct ttm_buffer_object *bo;
-	struct ttm_resource *res;
-	unsigned int mem_type;
-	int ret = 0;
-
-	spin_lock(&bdev->lru_lock);
-	ttm_resource_cursor_init(&cursor, man);
-	res = ttm_resource_manager_first(&cursor);
-	ttm_resource_cursor_fini(&cursor);
-	if (!res) {
-		ret = -ENOENT;
-		goto out_no_ref;
-	}
-	bo = res->bo;
-	if (!ttm_bo_get_unless_zero(bo))
-		goto out_no_ref;
-	mem_type = res->mem_type;
-	spin_unlock(&bdev->lru_lock);
-	ret = ttm_bo_reserve(bo, ctx->interruptible, ctx->no_wait_gpu, NULL);
-	if (ret)
-		goto out_no_lock;
-	if (!bo->resource || bo->resource->mem_type != mem_type)
-		goto out_bo_moved;
-
-	ret = ttm_bo_evict(bo, ctx);
-out_bo_moved:
-	dma_resv_unlock(bo->base.resv);
-out_no_lock:
-	ttm_bo_put(bo);
-	return ret;
-
-out_no_ref:
-	spin_unlock(&bdev->lru_lock);
-	return ret;
-}
-
 /**
  * struct ttm_bo_evict_walk - Parameters for the evict walk.
  */
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 4a765b25472c3..e686fc2849d99 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -561,17 +561,25 @@ EXPORT_SYMBOL(ttm_resource_manager_init);
 int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 				   struct ttm_resource_manager *man)
 {
-	struct ttm_operation_ctx ctx = { };
+	struct ttm_bo_lru_cursor cursor;
+	struct ttm_operation_ctx ctx = {
+		.interruptible = false,
+		.no_wait_gpu = false,
+	};
+	struct ttm_lru_walk_arg arg = {
+		.ctx = &ctx,
+		.trylock_only = true
+	};
+	struct ttm_buffer_object *bo;
 	struct dma_fence *fence;
 	int ret, i;
 
-	do {
-		ret = ttm_bo_evict_first(bdev, man, &ctx);
+	ttm_bo_lru_for_each_reserved_guarded(&cursor, man, &arg, bo) {
+		ret = ttm_bo_evict(bo, &ctx);
+		if (ret)
+			return ret;
 		cond_resched();
-	} while (!ret);
-
-	if (ret && ret != -ENOENT)
-		return ret;
+	}
 
 	ret = 0;
 
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 33dfa61ba882a..026ab044b0202 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -404,6 +404,7 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
 void ttm_bo_fini(struct ttm_buffer_object *bo);
 void ttm_bo_set_bulk_move(struct ttm_buffer_object *bo,
 			  struct ttm_lru_bulk_move *bulk);
+int ttm_bo_evict(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx);
 bool ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 			      const struct ttm_place *place);
 int ttm_bo_init_reserved(struct ttm_device *bdev, struct ttm_buffer_object *bo,
-- 
2.43.0

