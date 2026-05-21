Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94FBCD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 10:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F5410F2DC;
	Thu, 21 May 2026 10:43:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZUgUexvO";
	dkim-atps=neutral
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0117410E4AD
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 10:43:45 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-38e7c3a2deaso55576721fa.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 03:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779360224; x=1779965024; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tost9z39fc3oAwF71abrFy2xi58J916FX1uOTr+0ob4=;
 b=ZUgUexvOsG+OFopmCptG9vJGlh0kC5o1UYruPEZxcNGkwGN95OD+zyqlr13flLuoQV
 hWRNfO2Hh6+gnqZkO23Wkoo6UZIofhQI+UPGwZg6ie1J5IwzQ+b/tAMsEpbXkOxEsvdc
 nepGh0/GShBILochU55qut5CdZ95ezf2zJAQEkByG2lNNUpQo75qmHHmbNjT7IYw7bIC
 KS3gU22oZQ4v93l4qacqm+oh6Et2cJJYqVJ+eJSEzi4ayEXMxgIa7eGktsaKTaGHp7GW
 g0P8+5Jvo5AbJCBcLHVgXwjO1VOU3UY3GKb06lNKrZF0rwVhJlkAO1VBSrLaK/iPOnD7
 dhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779360224; x=1779965024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tost9z39fc3oAwF71abrFy2xi58J916FX1uOTr+0ob4=;
 b=SVpAqb6oVFvBD4RJPK5vm46dDVJhuvSYinfWl2qw9QIJLsNxrxbZXlSNRWduA+xYYT
 vwhwxVqdTPSRr09CN+7fCQzIw7e20Wkm4J9ZcutvAhJ5QNNMKmiuWPqDdBuQKkJqan6S
 Vrh8CJpXMpTMGhTPc8HtSzkUXXl6z91TWX6w3Oek3WQ2i8vFnFkSrj9RWOOH1PncKcpM
 BIj6EdkzrGwi+orBBJxU1App9aE4spTy+7vOZcq101KRzz9piU4xetLJWbo0PadUXwpY
 XBKh62c7c3fvlpNpe3L9fFdTYihnzLQXPaaEe3fAsf7j89P9bdp3tH0Bp+kgZP9tcmwd
 VYog==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LrQYRAbvjuhleu5ikckCnJiLdGHy9yENa1EoZraRZpD0r+eCg8KQdYD30oHxs/Jb0xwz8m3Vaxi4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHaKZxxs4+FXfh8n7b9Nyf0kcvPr40cozD3iOd23DtGlwOgUWw
 PcP1CYALMte7Xz6sXAjpl68TmMOxd5Qku7i3VJxgxHhpQOA3ZAZ7NPvA
X-Gm-Gg: Acq92OFCPQtPDXQguWkU6zbjNMNMzlHSvVGAGXJ3F+O4vt1tv6f9ID4E+AU8OPp8sRg
 SPaKM2OUF8El4mmqj3SLrKhJn3byvbHpcA5RkNQjg1dEJQasHwUiD1MFu21dk1vHunI1RA45wkd
 nNa/ak0PAMRQXDg7vubgfVCUa+3hhvan31OVwpRJpxKypYalSFqAWiRy37DeXp8c7iOVT5NP7nj
 ZVvY4FrAoNDWt7P6klbBpJge4dRRig+gpRjRwDVL9NQuUlL1dsdlWM84eamDlOxS9jwOvN2H235
 sM0lQDmFgZhQ7jawIdCimaHdejF+O7pRrmgOfpa1tqufAYmhcCFg9A6Glwso/pphNl81rgrDaJ6
 9MFPAi+SGfnnnY+UALXkWJS7VKImJy8NEA+fwn4acBu/VGfvAerCJvuyweBEtVGYgXfIlTL8nvU
 skdr2xA/RfwZVQP1pnLIUymuvRIybnRaAdI+H42PoCbccW
X-Received: by 2002:a2e:a548:0:b0:38e:cab9:3637 with SMTP id
 38308e7fff4ca-395ca6386cfmr9212891fa.18.1779360223995; 
 Thu, 21 May 2026 03:43:43 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395d0b49073sm1595611fa.31.2026.05.21.03.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 03:43:42 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v4 1/2] drm/amdgpu: convert amdgpu_vm_lock_by_pasid() to
 drm_exec
Date: Thu, 21 May 2026 15:43:32 +0500
Message-ID: <20260521104335.28978-2-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521104335.28978-1-mikhail.v.gavrilov@gmail.com>
References: <20260520151741.50575-1-mikhail.v.gavrilov@gmail.com>
 <20260521104335.28978-1-mikhail.v.gavrilov@gmail.com>
MIME-Version: 1.0
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

amdgpu_vm_lock_by_pasid() looks up a VM by PASID and reserves its root
PD with a bare amdgpu_bo_reserve(), returning the still-reserved root to
the caller. A caller that then needs to reserve further BOs (for example
the devcoredump IB dump) ends up nesting reservation_ww_class_mutex
acquires without a ww_acquire_ctx, which lockdep flags as recursive
locking.

Convert the helper to take a drm_exec context and lock the root PD with
drm_exec_lock_obj(). Callers now run it inside a
drm_exec_until_all_locked() loop and can lock additional BOs in the same
ww ticket, so there is no nested ww_mutex acquire.

The drm_exec context holds its own reference on the locked root BO, so
the helper no longer hands a root reference back to the caller: the
root output parameter is dropped, and the transient reference taken
across the PASID lookup is released before returning.

The only existing caller, amdgpu_vm_handle_fault(), is updated
accordingly. Its is_compute_context path, which previously dropped the
root reservation around svm_range_restore_pages() and re-took it, now
finalises the drm_exec context and re-initialises a fresh one; behaviour
is otherwise unchanged.

No functional change intended for the page-fault path.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 91 ++++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
 2 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9ba9de16a27a..591980907211 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2950,47 +2950,56 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 }
 
 /**
- * amdgpu_vm_lock_by_pasid - return an amdgpu_vm and its root bo from a pasid, if possible.
+ * amdgpu_vm_lock_by_pasid - look up a VM by PASID and lock its root PD
  * @adev: amdgpu device pointer
- * @root: root BO of the VM
  * @pasid: PASID of the VM
- * The caller needs to unreserve and unref the root bo on success.
+ * @exec: drm_exec context to lock the root PD in
+ *
+ * Must be called from within a drm_exec_until_all_locked() loop; the caller
+ * runs drm_exec_retry_on_contention() afterwards. The drm_exec context holds
+ * a reference on the root BO until it is finalised.
+ *
+ * Return: the VM on success, or NULL if the PASID has no VM, the VM is being
+ * torn down, or locking the root PD failed.
  */
 struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
-					  struct amdgpu_bo **root, u32 pasid)
+					  u32 pasid, struct drm_exec *exec)
 {
 	unsigned long irqflags;
+	struct amdgpu_bo *root;
 	struct amdgpu_vm *vm;
 	int r;
 
 	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
 	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	*root = vm ? amdgpu_bo_ref(vm->root.bo) : NULL;
+	root = vm ? amdgpu_bo_ref(vm->root.bo) : NULL;
 	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
 
-	if (!*root)
+	if (!root)
 		return NULL;
 
-	r = amdgpu_bo_reserve(*root, true);
-	if (r)
-		goto error_unref;
+	r = drm_exec_lock_obj(exec, &root->tbo.base);
+	if (r) {
+		amdgpu_bo_unref(&root);
+		return NULL;
+	}
 
 	/* Double check that the VM still exists */
 	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
 	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm && vm->root.bo != *root)
+	if (vm && vm->root.bo != root)
 		vm = NULL;
 	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
-	if (!vm)
-		goto error_unlock;
+	if (!vm) {
+		drm_exec_unlock_obj(exec, &root->tbo.base);
+		amdgpu_bo_unref(&root);
+		return NULL;
+	}
 
-	return vm;
-error_unlock:
-	amdgpu_bo_unreserve(*root);
+	/* The drm_exec context holds its own reference on the root BO. */
+	amdgpu_bo_unref(&root);
 
-error_unref:
-	amdgpu_bo_unref(root);
-	return NULL;
+	return vm;
 }
 
 /**
@@ -3012,33 +3021,49 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    uint64_t ts, bool write_fault)
 {
 	bool is_compute_context = false;
-	struct amdgpu_bo *root;
+	struct drm_exec exec;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
 	int r;
 
-	vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
-	if (!vm)
+	drm_exec_init(&exec, 0, 0);
+	drm_exec_until_all_locked(&exec) {
+		vm = amdgpu_vm_lock_by_pasid(adev, pasid, &exec);
+		drm_exec_retry_on_contention(&exec);
+		if (!vm)
+			break;
+	}
+	if (!vm) {
+		drm_exec_fini(&exec);
 		return false;
+	}
 
 	is_compute_context = vm->is_compute_context;
 
 	if (is_compute_context) {
-		/* Unreserve root since svm_range_restore_pages might try to reserve it. */
-		/* TODO: rework svm_range_restore_pages so that this isn't necessary. */
-		amdgpu_bo_unreserve(root);
+		/* Release the root PD lock since svm_range_restore_pages
+		 * might try to take it.
+		 * TODO: rework svm_range_restore_pages so that this isn't
+		 * necessary.
+		 */
+		drm_exec_fini(&exec);
 
 		if (!svm_range_restore_pages(adev, pasid, vmid,
-					     node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
-			amdgpu_bo_unref(&root);
+					     node_id, addr >> PAGE_SHIFT, ts, write_fault))
 			return true;
-		}
-		amdgpu_bo_unref(&root);
 
 		/* Re-acquire the VM lock, could be that the VM was freed in between. */
-		vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
-		if (!vm)
+		drm_exec_init(&exec, 0, 0);
+		drm_exec_until_all_locked(&exec) {
+			vm = amdgpu_vm_lock_by_pasid(adev, pasid, &exec);
+			drm_exec_retry_on_contention(&exec);
+			if (!vm)
+				break;
+		}
+		if (!vm) {
+			drm_exec_fini(&exec);
 			return false;
+		}
 	}
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
@@ -3062,7 +3087,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		value = 0;
 	}
 
-	r = dma_resv_reserve_fences(root->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
 	if (r) {
 		pr_debug("failed %d to reserve fence slot\n", r);
 		goto error_unlock;
@@ -3076,12 +3101,10 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	r = amdgpu_vm_update_pdes(adev, vm, true);
 
 error_unlock:
-	amdgpu_bo_unreserve(root);
+	drm_exec_fini(&exec);
 	if (r < 0)
 		dev_err(adev->dev, "Can't handle page fault (%d)\n", r);
 
-	amdgpu_bo_unref(&root);
-
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d083d7aab75c..0c6e3e0368c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -593,7 +593,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    bool write_fault);
 
 struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
-					  struct amdgpu_bo **root, u32 pasid);
+					  u32 pasid, struct drm_exec *exec);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 
-- 
2.54.0

