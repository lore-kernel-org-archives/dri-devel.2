Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF52C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049CC10E20B;
	Sun, 16 Aug 2026 19:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cajzbT8h";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B8910E34C
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 19:43:23 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so2821997a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786909403; x=1787514203; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+SXbBJ78nn/6ntIYDKfcWHsXpFCebrOGrhFTWiZhXyw=;
 b=cajzbT8h43V4a5Xy+LCtpZGt7MKG4rNv9lkyAKg3E0f2FgL1InfOrFGf0L8Wc4lMnF
 0iPRI3jlF7cuZO8yxEQOJ2gVT+O5kCpUzxWWb7Lq1uUNdt7peoUNigWpBJ60XqpJ+VM1
 7PCyftXoBgHtk+Kw+AWfh4jOnvJPM6QPIA6wyuFKwWkjrlIk4CcMTHKRu/Ri3jWsKXnK
 a5FeaqYcz2Iw4kvVSAGPvZAXt2Sydx4stWFsv9GbzHSrxCpGeEjMc35GCh9hEdopagyc
 4WS2qOoAoC1vEntve5iCIWeCpqo0FoVFUGb/Y9DOO/3nCgo1VlJsYdhWFESos7ZsZizM
 cyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786909403; x=1787514203;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+SXbBJ78nn/6ntIYDKfcWHsXpFCebrOGrhFTWiZhXyw=;
 b=AoQual7bKJ8XPcIcZ7Do+wr+NT39JUx/4u893UWutcS5mdxk6wNCZQs5510lj8Tpgf
 ER+g/Nwuf1xXb7ZXH2E8G58DFd4pxaGr37jMU3xGij60Ridc9d3z0PoXccJWeurUJjJf
 yAhZqEgIz+g1zz9wOcjKBJGHmjt5iX1rxdBJwcWA3faRBmjcXXLaNki8OP7WqRHcis+E
 6ZgLIWpQW+u4hXVRGahAYGZIbn+NU4v5PPB/Jc3KRQ+8SsTK7afs3wJVkzfzAN0fNp/o
 G2rSVGe4UyCHLb9BwH+BbTqXbC6oCuB/pK+H8g6S2dWUae0+PDhF7rISvLh+su8mfyg7
 1NpA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5ZEwUWVl2WrUvj9oXTle6TxH3veZKOMxrLYEE7sJF+PpKOwAL1rA010//dNzMKOcqs0tXTy4umlw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyj8cuOnz2OCb+Hlr2AXIEc1ePikqH0kfqv3LYsgAuiFfM13ayO
 X/TXQgiIpuNwzLc9XciKYrEzaIx91gnLp6RRapQU3wWur99YsswmhrYH
X-Gm-Gg: AR+sD12JfPrPAnsxoObzVNU9FHbO+q8lPN25bq7sFvkmRFf5okNOTkNmv1Cw36lGic3
 Rv3LsVOlCZmGy8MlGTQNiDPDKFoSkcIHUDpaivGICLpTeXzTIPpVcrAdGPe5WdHdPl6QgNxHrbT
 S5wy8oMSr71zMoymj0hwkmOL5R6QtdaetWiz9F1Qi1qfLvA3yXyCwpr3On4/1p4TAEb1YLgzFey
 g6Yn3F7HBvsvdEHdu+C5IF1FozPOeFkzeofnW/IYdRDq4VTZ5T0yXRjw7ogMkFqHVZWk4YdnclD
 lPmvyZUsd35ds8n/OVgwWF/f/FrjWVIklpz6FyVTzFRjInVsIOna7u3HSI7LG3fs0lYb55vlKCk
 xSdIZCX/YzUmsKGMKW8r0zc6UBYT2PmfBh7UANcXsLDUpCqfpKRHvftepMTtQGiUspme25rx5ej
 l7gBYaZFpc7q4JU7BTHieHllYeiIsKsmNiJu9RSa1YFAh13aUfOksspg==
X-Received: by 2002:a17:90b:1651:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-3933e633478mr19319456a91.15.1786909403036; 
 Sun, 16 Aug 2026 12:43:23 -0700 (PDT)
Received: from [127.0.1.1] ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395320229f4sm2141310a91.15.2026.08.16.12.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 12:43:22 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Mon, 17 Aug 2026 04:42:09 +0900
Subject: [PATCH 2/4] drm/imagination: Switch the GPUVM to immediate mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-pvr-vm-bind-v1-2-0a0f21be7d38@gmail.com>
References: <20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com>
In-Reply-To: <20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matt Coster <opensource@mtcoster.net>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

In preparation for the asynchronous VM_BIND that follows.

Why DRM_GPUVM_IMMEDIATE_MODE is needed:

Running binds from a async-job makes a deadlock. run_job() takes a BO's
dma_resv to update that BO's gpuva list, and has to signal a fence once
done(=signalling section). Another thread can be holding the same dma_resv
while waiting on that fence, so the two wait on each other.

Switching to DRM_GPUVM_IMMEDIATE_MODE requires two things:

1. Drop drm_gpuvm_exec.

   It calls dma_resv_lock() internally, which is the path that deadlocks.
   It did also serve as the address space tree lock, so take
   pvr_vm_context::lock explicitly instead.

2. Let the GEM's gpuva.lock protect the list.

   That lock is only ever held across list surgery, so no fence waiter can
   be holding it. Panthor went this way first, for the same reason.

No functional change intended.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 80 +++++++++++++-----------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 608e8c0467d..45df76e61f7 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -214,7 +214,7 @@ static int pvr_vm_bind_op_exec(struct pvr_vm_bind_op *bind_op)
 
 static void pvr_vm_bind_op_fini(struct pvr_vm_bind_op *bind_op)
 {
-	drm_gpuvm_bo_put(bind_op->gpuvm_bo);
+	drm_gpuvm_bo_put_deferred(bind_op->gpuvm_bo);
 
 	kfree(bind_op->new_va);
 	kfree(bind_op->prev_va);
@@ -255,11 +255,11 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_op,
 
 	bind_op->type = PVR_VM_BIND_TYPE_MAP;
 
-	dma_resv_lock(obj->resv, NULL);
-	bind_op->gpuvm_bo = drm_gpuvm_bo_obtain_locked(&vm_ctx->gpuvm_mgr, obj);
-	dma_resv_unlock(obj->resv);
-	if (IS_ERR(bind_op->gpuvm_bo))
-		return PTR_ERR(bind_op->gpuvm_bo);
+	bind_op->gpuvm_bo = drm_gpuvm_bo_create(&vm_ctx->gpuvm_mgr, obj);
+	if (!bind_op->gpuvm_bo)
+		return -ENOMEM;
+
+	bind_op->gpuvm_bo = drm_gpuvm_bo_obtain_prealloc(bind_op->gpuvm_bo);
 
 	bind_op->new_va = kzalloc_obj(*bind_op->new_va);
 	bind_op->prev_va = kzalloc_obj(*bind_op->prev_va);
@@ -366,7 +366,11 @@ pvr_vm_gpuva_map(struct drm_gpuva_op *op, void *op_ctx)
 		return err;
 
 	drm_gpuva_map(&ctx->vm_ctx->gpuvm_mgr, &ctx->new_va->base, &op->map);
+
+	mutex_lock(&op->map.gem.obj->gpuva.lock);
 	drm_gpuva_link(&ctx->new_va->base, ctx->gpuvm_bo);
+	mutex_unlock(&op->map.gem.obj->gpuva.lock);
+
 	ctx->new_va = NULL;
 
 	return 0;
@@ -396,7 +400,7 @@ pvr_vm_gpuva_unmap(struct drm_gpuva_op *op, void *op_ctx)
 		return err;
 
 	drm_gpuva_unmap(&op->unmap);
-	drm_gpuva_unlink(op->unmap.va);
+	drm_gpuva_unlink_defer(op->unmap.va);
 	kfree(to_pvr_vm_gpuva(op->unmap.va));
 
 	return 0;
@@ -419,6 +423,7 @@ static int
 pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *op_ctx)
 {
 	struct drm_gpuva *unmap_va = op->remap.unmap->va;
+	struct drm_gem_object *obj = unmap_va->gem.obj;
 	struct drm_gpuvm_bo *vm_bo = unmap_va->vm_bo;
 	struct pvr_vm_bind_op *ctx = op_ctx;
 	u64 va_start = 0, va_range = 0;
@@ -436,17 +441,21 @@ pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *op_ctx)
 
 	if (op->remap.prev) {
 		pvr_gem_object_get(gem_to_pvr_gem(ctx->prev_va->base.gem.obj));
+		mutex_lock(&obj->gpuva.lock);
 		drm_gpuva_link(&ctx->prev_va->base, vm_bo);
+		mutex_unlock(&obj->gpuva.lock);
 		ctx->prev_va = NULL;
 	}
 
 	if (op->remap.next) {
 		pvr_gem_object_get(gem_to_pvr_gem(ctx->next_va->base.gem.obj));
+		mutex_lock(&obj->gpuva.lock);
 		drm_gpuva_link(&ctx->next_va->base, vm_bo);
+		mutex_unlock(&obj->gpuva.lock);
 		ctx->next_va = NULL;
 	}
 
-	drm_gpuva_unlink(unmap_va);
+	drm_gpuva_unlink_defer(unmap_va);
 	kfree(to_pvr_vm_gpuva(unmap_va));
 
 	return 0;
@@ -590,7 +599,8 @@ pvr_vm_create_context(struct pvr_device *pvr_dev, bool is_userspace_context)
 	drm_gem_private_object_init(&pvr_dev->base, &vm_ctx->dummy_gem, 0);
 	drm_gpuvm_init(&vm_ctx->gpuvm_mgr,
 		       is_userspace_context ? "PowerVR-user-VM" : "PowerVR-FW-VM",
-		       0, &pvr_dev->base, &vm_ctx->dummy_gem,
+		       DRM_GPUVM_IMMEDIATE_MODE, &pvr_dev->base,
+		       &vm_ctx->dummy_gem,
 		       0, 1ULL << device_addr_bits, 0, 0, &pvr_vm_gpuva_ops);
 
 	mutex_init(&vm_ctx->lock);
@@ -624,6 +634,7 @@ pvr_vm_context_release(struct kref *ref_count)
 		pvr_fw_object_destroy(vm_ctx->fw_mem_ctx_obj);
 
 	pvr_vm_unmap_all(vm_ctx);
+	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
 
 	pvr_mmu_context_destroy(vm_ctx->mmu_ctx);
 	drm_gem_private_object_fini(&vm_ctx->dummy_gem);
@@ -693,16 +704,6 @@ void pvr_destroy_vm_contexts_for_file(struct pvr_file *pvr_file)
 	}
 }
 
-static int
-pvr_vm_lock_extra(struct drm_gpuvm_exec *vm_exec)
-{
-	struct pvr_vm_bind_op *bind_op = vm_exec->extra.priv;
-	struct pvr_gem_object *pvr_obj = bind_op->pvr_obj;
-
-	/* Acquire lock on the GEM object being mapped/unmapped. */
-	return drm_exec_lock_obj(&vm_exec->exec, gem_from_pvr_gem(pvr_obj));
-}
-
 /**
  * pvr_vm_map() - Map a section of physical memory into a section of
  * device-virtual memory.
@@ -730,15 +731,6 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 	   u64 pvr_obj_offset, u64 device_addr, u64 size)
 {
 	struct pvr_vm_bind_op bind_op = {0};
-	struct drm_gpuvm_exec vm_exec = {
-		.vm = &vm_ctx->gpuvm_mgr,
-		.flags = DRM_EXEC_INTERRUPTIBLE_WAIT |
-			 DRM_EXEC_IGNORE_DUPLICATES,
-		.extra = {
-			.fn = pvr_vm_lock_extra,
-			.priv = &bind_op,
-		},
-	};
 
 	int err = pvr_vm_bind_op_map_init(&bind_op, vm_ctx, pvr_obj,
 					  pvr_obj_offset, device_addr,
@@ -749,16 +741,12 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 
 	pvr_gem_object_get(pvr_obj);
 
-	err = drm_gpuvm_exec_lock(&vm_exec);
-	if (err)
-		goto err_cleanup;
-
+	mutex_lock(&vm_ctx->lock);
 	err = pvr_vm_bind_op_exec(&bind_op);
+	mutex_unlock(&vm_ctx->lock);
 
-	drm_gpuvm_exec_unlock(&vm_exec);
-
-err_cleanup:
 	pvr_vm_bind_op_fini(&bind_op);
+	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
 
 	return err;
 }
@@ -787,15 +775,6 @@ pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ctx,
 			u64 device_addr, u64 size)
 {
 	struct pvr_vm_bind_op bind_op = {0};
-	struct drm_gpuvm_exec vm_exec = {
-		.vm = &vm_ctx->gpuvm_mgr,
-		.flags = DRM_EXEC_INTERRUPTIBLE_WAIT |
-			 DRM_EXEC_IGNORE_DUPLICATES,
-		.extra = {
-			.fn = pvr_vm_lock_extra,
-			.priv = &bind_op,
-		},
-	};
 
 	int err = pvr_vm_bind_op_unmap_init(&bind_op, vm_ctx, pvr_obj,
 					    device_addr, size);
@@ -804,15 +783,8 @@ pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ctx,
 
 	pvr_gem_object_get(pvr_obj);
 
-	err = drm_gpuvm_exec_lock(&vm_exec);
-	if (err)
-		goto err_cleanup;
-
 	err = pvr_vm_bind_op_exec(&bind_op);
 
-	drm_gpuvm_exec_unlock(&vm_exec);
-
-err_cleanup:
 	pvr_vm_bind_op_fini(&bind_op);
 
 	return err;
@@ -840,6 +812,8 @@ pvr_vm_unmap_obj(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 	err = pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj, device_addr, size);
 	mutex_unlock(&vm_ctx->lock);
 
+	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
+
 	return err;
 }
 
@@ -874,6 +848,8 @@ pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
 
 	mutex_unlock(&vm_ctx->lock);
 
+	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
+
 	return err;
 }
 
@@ -906,6 +882,8 @@ pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
 	}
 
 	mutex_unlock(&vm_ctx->lock);
+
+	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
 }
 
 /* Static data areas are determined by firmware. */

-- 
2.43.0

