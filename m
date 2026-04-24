Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BECFE51F1
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D250310F45D;
	Fri, 24 Apr 2026 09:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JcO3y8bF";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51DE10F45B
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:20:18 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4891f625344so62347895e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777022417; x=1777627217; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5qZznwpifCD/E+aebNnmqI/Te/6z9tieCsTrES4Zww=;
 b=JcO3y8bFmXF3NXMs/i47ek2j8GPi8zYNUw09ldTJD12en5Sz9YrmlUISn4VMsYi+T8
 6aICBSp2xAxYK/QOtmbf65E64DWcSWRlMKOPQ7D0XNk97LRZ5KeybfjpjX2AM+ffRdFA
 bfQE+8wv/kcs385n8XXMV7a23ESJbKieaPUuTndVclT5d6hjUUUqplULANZPp45YG+7o
 m1SJLd+sqmtNYj9+9Yefbgn+IUL7AGQoW9rHKAbpEowvC43gcdOOytYU4Uw8xFNVzlN2
 PLLOOrMSlV+Mt7luVN0J8re2R9z+lKqqUUsY1swNrpHM2ECO1pAOJsFIYiHIEjaVU2eX
 GakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777022417; x=1777627217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S5qZznwpifCD/E+aebNnmqI/Te/6z9tieCsTrES4Zww=;
 b=Aw9abP4eDc5HKIxUiS2/6mrlIJQOV8SC6DGZPbGdBK2OyZaKq4AR2ZHRHHOYo2CVbi
 7pi6sWqPd/gjnTWQQM4Hvs5GUMxig+zB5rIzRhL89wnnaOnu6AqalVZx7x7FzN38XxgA
 HHb9D7gx+6sPM00NZTc/YgwZoCYwzv13XWt+lf/DO0v2csswPSIdyTZmOhHGFR8XrASV
 R5HPnMwX6j6vzA9i/Dg8KMWW2Cc/NIVQBuR2FAD0oid4gSzZZahd3iKuyhuRR7u6PBqn
 k0OI8P2A/Vjn91l1m9JAChGufi6u7MYq7RxkeOCstOm0ezePjxtelBx/5L+M1zDm2N9D
 u2sg==
X-Gm-Message-State: AOJu0YzwWnuRJlS24ZUT7CkXy8NtLJXeSfbQ7AuRwRlL02Qmi8lsmrG4
 h7GIcnefBRoitbh4Xm2h+tozjtWwfIJz7HxSRnAiHU7sfUjabO18l9nj
X-Gm-Gg: AeBDietnX16R2c5YKS/XQvrbfwqI+DZ/D8ziSf16McD/wVFU4p4iU/iIQ9lLMRTlpyG
 O33jH6ayOxgIUjdhv1vmiitswnXU7dhzM/4xzzMmrb4n+jLHTcIzWUktIRJhnKF15RHKSYTUXLa
 f9HiBOD/Z5wX2PuCf0UE+9zfzkUbzSqxxODs7EcCjC+LgxsQ6ZEGBnL9Eq7UWcB9c5Pnc2XOJj0
 00uMtRCzLsN3ql8KSIH3uP5FE4tOECOQ7NzLXFKi7wWXaHfMrccg4BN6I1epFy19nZ85fjRy7T1
 YKORWEgqge/9hkot8a4wMfQKSRlfVaw+7ilksVNf/aqGDh31HjqQ+rZgD2sovQY0yyEsMZ2Ioba
 0PhPvdhbFPv/n0mjRqBOOpSp763aLJmP0cFS/N6Ep0OTW38X8zo1zsKBYCfmCk1UcbbcBSU4DXo
 o8/yUPo1yptAwfsqJIsYwnSWoyGV78onuFlVpzMbnm9mr7jw8=
X-Received: by 2002:a05:600c:c112:b0:486:fe83:861c with SMTP id
 5b1f17b1804b1-488fb896910mr354514235e9.7.1777022417068; 
 Fri, 24 Apr 2026 02:20:17 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f2:7300:95ce:4290:489c:f518])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm660955235e9.1.2026.04.24.02.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:20:16 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH 2/4] drm/vmwgfx: use the new drm_exec object v3
Date: Fri, 24 Apr 2026 11:15:10 +0200
Message-ID: <20260424092012.5694-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424092012.5694-1-christian.koenig@amd.com>
References: <20260424092012.5694-1-christian.koenig@amd.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Basically just switching over to the new infrastructure like we did for
all other drivers as well.

No intentional functional change, but only compile tested.

v2: fix kerneldoc issues
v3: use DMA_RESV_USAGE_WRITE instead of _READ

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c | 55 +++++++++++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h | 41 ++--------------
 2 files changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index 35dc94c3db39..1f2d16a5e6a3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -818,6 +818,58 @@ int vmw_validation_preload_res(struct vmw_validation_context *ctx,
 	return 0;
 }
 
+/**
+ * vmw_validation_bo_reserve - Reserve buffer objects registered with a
+ * validation context
+ * @ctx: The validation context
+ * @intr: Perform waits interruptible
+ *
+ * Return: Zero on success, -ERESTARTSYS when interrupted, negative error
+ * code on failure
+ */
+int vmw_validation_bo_reserve(struct vmw_validation_context *ctx, bool intr)
+{
+	struct vmw_validation_bo_node *entry;
+	int ret;
+
+	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
+	drm_exec_until_all_locked(&ctx->exec) {
+		list_for_each_entry(entry, &ctx->bo_list, base.head) {
+			ret = drm_exec_prepare_obj(&ctx->exec,
+						   &entry->base.bo->base, 1);
+			drm_exec_retry_on_contention(&ctx->exec);
+			if (ret)
+				goto error;
+		}
+	}
+	return 0;
+
+error:
+	drm_exec_fini(&ctx->exec);
+	return ret;
+}
+
+/**
+ * vmw_validation_bo_fence - Unreserve and fence buffer objects registered
+ * with a validation context
+ * @ctx: The validation context
+ * @fence: The fence to add
+ *
+ * This function unreserves the buffer objects previously reserved using
+ * vmw_validation_bo_reserve, and fences them with a fence object.
+ */
+void vmw_validation_bo_fence(struct vmw_validation_context *ctx,
+			     struct vmw_fence_obj *fence)
+{
+	struct vmw_validation_bo_node *entry;
+
+	list_for_each_entry(entry, &ctx->bo_list, base.head) {
+		dma_resv_add_fence(entry->base.bo->base.resv, &fence->base,
+				   DMA_RESV_USAGE_WRITE);
+	}
+	drm_exec_fini(&ctx->exec);
+}
+
 /**
  * vmw_validation_bo_backoff - Unreserve buffer objects registered with a
  * validation context
@@ -843,6 +895,5 @@ void vmw_validation_bo_backoff(struct vmw_validation_context *ctx)
 				vmw_bo_dirty_release(vbo);
 		}
 	}
-
-	ttm_eu_backoff_reservation(&ctx->ticket, &ctx->bo_list);
+	drm_exec_fini(&ctx->exec);
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
index 353d837907d8..55a7d8b68d5c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.h
@@ -31,8 +31,7 @@
 #include <linux/list.h>
 #include <linux/hashtable.h>
 #include <linux/ww_mutex.h>
-
-#include <drm/ttm/ttm_execbuf_util.h>
+#include <drm/drm_exec.h>
 
 #define VMW_RES_DIRTY_NONE 0
 #define VMW_RES_DIRTY_SET BIT(0)
@@ -59,7 +58,7 @@ struct vmw_validation_context {
 	struct list_head resource_ctx_list;
 	struct list_head bo_list;
 	struct list_head page_list;
-	struct ww_acquire_ctx ticket;
+	struct drm_exec exec;
 	struct mutex *res_mutex;
 	unsigned int merge_dups;
 	unsigned int mem_size_left;
@@ -106,39 +105,6 @@ vmw_validation_has_bos(struct vmw_validation_context *ctx)
 	return !list_empty(&ctx->bo_list);
 }
 
-/**
- * vmw_validation_bo_reserve - Reserve buffer objects registered with a
- * validation context
- * @ctx: The validation context
- * @intr: Perform waits interruptible
- *
- * Return: Zero on success, -ERESTARTSYS when interrupted, negative error
- * code on failure
- */
-static inline int
-vmw_validation_bo_reserve(struct vmw_validation_context *ctx,
-			  bool intr)
-{
-	return ttm_eu_reserve_buffers(&ctx->ticket, &ctx->bo_list, intr,
-				      NULL);
-}
-
-/**
- * vmw_validation_bo_fence - Unreserve and fence buffer objects registered
- * with a validation context
- * @ctx: The validation context
- *
- * This function unreserves the buffer objects previously reserved using
- * vmw_validation_bo_reserve, and fences them with a fence object.
- */
-static inline void
-vmw_validation_bo_fence(struct vmw_validation_context *ctx,
-			struct vmw_fence_obj *fence)
-{
-	ttm_eu_fence_buffer_objects(&ctx->ticket, &ctx->bo_list,
-				    (void *) fence);
-}
-
 /**
  * vmw_validation_align - Align a validation memory allocation
  * @val: The size to be aligned
@@ -185,6 +151,9 @@ int vmw_validation_preload_res(struct vmw_validation_context *ctx,
 			       unsigned int size);
 void vmw_validation_res_set_dirty(struct vmw_validation_context *ctx,
 				  void *val_private, u32 dirty);
+int vmw_validation_bo_reserve(struct vmw_validation_context *ctx, bool intr);
+void vmw_validation_bo_fence(struct vmw_validation_context *ctx,
+			     struct vmw_fence_obj *fence);
 void vmw_validation_bo_backoff(struct vmw_validation_context *ctx);
 
 #endif
-- 
2.43.0

