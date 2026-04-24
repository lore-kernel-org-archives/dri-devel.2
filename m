Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA5AFE51EE
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D0610F45B;
	Fri, 24 Apr 2026 09:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DdbowBL3";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF1410F458
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:20:18 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488ad135063so67939965e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777022416; x=1777627216; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZdo+If1lLytGtOaSjQbfAv+7SgkCtqTeWVuYEfZbnI=;
 b=DdbowBL3RJsfFAJrXdK7NPSpmIHEMjuUAsT03L0CiTgHVtjrhkFw4Kiy4H6cSdYKIr
 e734EDRuCkYGFKc5a74eVDpEnhNJ2qsOMQ5M9f3V37iZD7UUnztKRQYPt6DuL+izMEzo
 Kp9OcQpEAjw21h9yrvtxHb86cOO4Rz8htD73Yl0njR9v9wAq/gHufthWkCyfi4yZ9RzL
 8ux/5t+74KTHNxf/3ezST4pt+IjUFAo/7noCDIjhGNEjwrsSP7FbIx+z6QB3j6KmwDec
 V87FXur5rsmkmmHwMXRXDB2pm294aIm4eG7rbofxbC56zlaYDfUXAYsjf3qZDQvi+qEt
 mbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777022416; x=1777627216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wZdo+If1lLytGtOaSjQbfAv+7SgkCtqTeWVuYEfZbnI=;
 b=a7T6CzWUtz4KmceZIBD7AQFoSb9DZRllA0ovXGdJqDiowd0WvVU+ht2WTH4P58CNV5
 CfJeiERVX6dmIUhZ91TituzDGEwUw0m1uVjwaJWxf7akaEFye6nRtVL+FXnWObdL97Vj
 rJuJVpf9zghKk/cvQVfr31sxPX7ePx9uDhPh92TiVWJ5SM2JiMeDOkBvZoSWskzjkxaJ
 /kjFDeyunRAkxM5dNXUsi8gGsG/+nRILhwzpjJLT7Zn9tOaGmRNeK56cHy6x9cbC2SnZ
 Ccy0g39Y7UEqG9V7nQz2uc4GEDnpQKuDzQWMtT8eIhr3wtjMsG5mOlOCej2hUwWnon1J
 sTQQ==
X-Gm-Message-State: AOJu0YxltcScxFQ5oCNs3IIyThdOq5AKyh6r8HrQXzt5sbAXwydav/Fh
 4I+95yac+SRQM7KISQD/3yxYwZzGzUJnTiKl0u1Tup0LJLwvy6MIL73m
X-Gm-Gg: AeBDiesm86xZnyfasqM8bJcNDp8WugqCuiSRrXE71JbEl7d+0KpPPn7pYBRrxv0TKZc
 TGD0Ab2KomqyYhyQ6bkQ9psMAIzfqxhUe5/IbcQJ9+V3urNG17jxzB8nvwRNhzkOxX3FFLjFpnV
 vf6VVz1ZNChX7neMSQKRETJXxgty/id6Uul+adLRJc6uXtB+LLHfbKOIMwUgNA/OM02Famr+Drz
 yE8DSwqckpdfHr2qMsvIQelyqQQAtIAwOtYTGzhDRkb7oWjxIkZeepuGi+zXsThO4pjbLLxjQTs
 L5BQWhf3XoGIuNN8SSlwr90Q7YjScjt/RBpuqkDx8qlnNhvR6EAOvVUgw574BnqjKmp/odhIpyM
 WO/5cAjaT3n1JIVeWBfW19J9Xe5tqJD3O7rThwDGpbAzWqtAxFoEUS94owEP6R6eRkEiUbPpRwP
 05EgJySihBmG5sT87wVHSm0Fix6GZK4Rv9VNkJz/zDuT7C+2s=
X-Received: by 2002:a05:600c:3f10:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-488fb753c9amr411532165e9.10.1777022416310; 
 Fri, 24 Apr 2026 02:20:16 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f2:7300:95ce:4290:489c:f518])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm660955235e9.1.2026.04.24.02.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:20:15 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH 1/4] drm/vmwgfx: use single locking in
 vmw_resource_check_buffer
Date: Fri, 24 Apr 2026 11:15:09 +0200
Message-ID: <20260424092012.5694-2-christian.koenig@amd.com>
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

Replacing some unnecessary complex calls with just just single BO dma_resv
locking.

No intentional functional change, but only compile tested.

v2: fix kerneldoc issues
v3: rebase on upstream changes

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 58 ++++++++----------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index 388011696941..1a518ab81b28 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -510,17 +510,16 @@ void vmw_resource_unreserve(struct vmw_resource *res,
  * @res:            The resource for which to allocate a backup buffer.
  * @interruptible:  Whether any sleeps during allocation should be
  *                  performed while interruptible.
- * @val_buf:        On successful return contains data about the
- *                  reserved and validated backup buffer.
+ * @bo:             On successful return contains the reserved and validated
+ *                  backup buffer.
  */
 static int
 vmw_resource_check_buffer(struct ww_acquire_ctx *ticket,
 			  struct vmw_resource *res,
 			  bool interruptible,
-			  struct ttm_validate_buffer *val_buf)
+			  struct ttm_buffer_object **bo)
 {
 	struct ttm_operation_ctx ctx = { true, false };
-	struct list_head val_list;
 	bool guest_memory_dirty = false;
 	int ret;
 
@@ -530,12 +529,13 @@ vmw_resource_check_buffer(struct ww_acquire_ctx *ticket,
 			return ret;
 	}
 
-	INIT_LIST_HEAD(&val_list);
-	val_buf->bo = &res->guest_memory_bo->tbo;
-	val_buf->num_shared = 0;
-	drm_gem_object_get(&val_buf->bo->base);
-	list_add_tail(&val_buf->head, &val_list);
-	ret = ttm_eu_reserve_buffers(ticket, &val_list, interruptible, NULL);
+	*bo = &res->guest_memory_bo->tbo;
+	drm_gem_object_get(&(*bo)->base);
+
+	if (ticket)
+		ww_acquire_init(ticket, &reservation_ww_class);
+
+	ret = ttm_bo_reserve(*bo, interruptible, (ticket == NULL), ticket);
 	if (unlikely(ret != 0))
 		goto out_no_reserve;
 
@@ -555,10 +555,12 @@ vmw_resource_check_buffer(struct ww_acquire_ctx *ticket,
 	return 0;
 
 out_no_validate:
-	ttm_eu_backoff_reservation(ticket, &val_list);
+	dma_resv_unlock((*bo)->base.resv);
+	if (ticket)
+		ww_acquire_fini(ticket);
 out_no_reserve:
-	drm_gem_object_put(&val_buf->bo->base);
-	val_buf->bo = NULL;
+	drm_gem_object_put(&(*bo)->base);
+	*bo = NULL;
 	if (guest_memory_dirty)
 		vmw_user_bo_unref(&res->guest_memory_bo);
 
@@ -600,29 +602,6 @@ int vmw_resource_reserve(struct vmw_resource *res, bool interruptible,
 	return 0;
 }
 
-/**
- * vmw_resource_backoff_reservation - Unreserve and unreference a
- *                                    guest memory buffer
- *.
- * @ticket:         The ww acquire ctx used for reservation.
- * @val_buf:        Guest memory buffer information.
- */
-static void
-vmw_resource_backoff_reservation(struct ww_acquire_ctx *ticket,
-				 struct ttm_validate_buffer *val_buf)
-{
-	struct list_head val_list;
-
-	if (likely(val_buf->bo == NULL))
-		return;
-
-	INIT_LIST_HEAD(&val_list);
-	list_add_tail(&val_buf->head, &val_list);
-	ttm_eu_backoff_reservation(ticket, &val_list);
-	drm_gem_object_put(&val_buf->bo->base);
-	val_buf->bo = NULL;
-}
-
 /**
  * vmw_resource_do_evict - Evict a resource, and transfer its data
  *                         to a backup buffer.
@@ -642,7 +621,7 @@ static int vmw_resource_do_evict(struct ww_acquire_ctx *ticket,
 
 	val_buf.bo = NULL;
 	val_buf.num_shared = 0;
-	ret = vmw_resource_check_buffer(ticket, res, interruptible, &val_buf);
+	ret = vmw_resource_check_buffer(ticket, res, interruptible, &val_buf.bo);
 	if (unlikely(ret != 0))
 		return ret;
 
@@ -657,7 +636,10 @@ static int vmw_resource_do_evict(struct ww_acquire_ctx *ticket,
 	res->guest_memory_dirty = true;
 	res->res_dirty = false;
 out_no_unbind:
-	vmw_resource_backoff_reservation(ticket, &val_buf);
+	dma_resv_unlock(val_buf.bo->base.resv);
+	if (ticket)
+		ww_acquire_fini(ticket);
+	drm_gem_object_put(&val_buf.bo->base);
 
 	return ret;
 }
-- 
2.43.0

