Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDCACD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 15:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D2910F0B7;
	Wed, 20 May 2026 15:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KPKUFZ/o";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1AFE10F0B5
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 15:17:51 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5aa0cf8bca3so5026821e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779290270; x=1779895070; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fyVPZSX7MwDddJkv/HM4B88jEPRd96zpfMtgKanmjaM=;
 b=KPKUFZ/oHCFtv82AIe7G1SlLbMjiYUaPOq9HMHEg7vMCUoIZAMPZ8UqVI5kgxNbiXs
 dvSk5h65TxpHR3F9TKBvrYKYl2Htn8BQDr1tZWpfiHTr7ztKfLGyJ6aN1qN+f0l5F54C
 7jHk8L0557SMjZJFoLYJ/i+hhv7fkE4vkYqsIfYylcU/VzowJvu5tKN49dIO+SKeGOJd
 ncRwHHlWRjO+FYdHbV4HyPN08ByO94/dXyaU2F+nV4gzr19Pej33Tbw1bxC5A5VnbHAR
 dM2/aktWvPenEwngCFTT9u//1m6UNVtzXTEmh+W/dQWp3kjd2jWZKg4A74MEhpCg7I4c
 QK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779290270; x=1779895070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fyVPZSX7MwDddJkv/HM4B88jEPRd96zpfMtgKanmjaM=;
 b=PMSlJ9QYFIeyCtAffPqGYii8Ti36BBDHsgwqWepRGYXM9Do4iOt7GDS1hvp/kOIXfn
 /E8B2AAh5JDEEP0zgAMMTjznkQKHztQVJyrHHfIaGk5R/+1Cm41oOB2Ov4C8kM32A65e
 8GCRyWSUZ1xQEzxDVire5Ef5DpvwL1R5J0a71NViNxsx4E59wc1pl2wJ/an72HuzrTnm
 /obhr5A0832VD8E3HHrXXBJgGj+7jvgKX4IKCVsiTE+VnOW9N9f/KyIfYTHIlGEysZ++
 69TMvdQ26LOpHxQiLyfzyl/MZYWMWj88z2mcXLQlEOLFGC2/xUs8zQeShEhitr88T9iM
 jadw==
X-Forwarded-Encrypted: i=1;
 AFNElJ96xZpl1kREOKOTvB7shBQVjO4k8HVVnQKmXQXq8xQEh7JsqGKR8me/ydL+gxUWLaLHEQo50LJw5WY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBccUsyNoBEsvJ3WAhYMRWCLWomPVTl/nD/0yvwS30sPprAQ2d
 wAwZkDPI1yvbHc98jXTavmik9Wa87rP+OMXzlymKDZK05jTvzOAWgLiv
X-Gm-Gg: Acq92OFSYOfbABKSPgSNp75As1RzVVfYI2zdyvYSc4/gz0YBGUYRK8PjTefBGBW6HRL
 c2Si2x6PjXl/qNekNDkK436ITDPNPBkANkeDqKZGv4Nl/gIRuA7aYnQTeUfrJRjgQCx5vAA/SjT
 C3GRpt9aT4282/Fhmf8HEhyoMWd8U8UqkgJEtw8U7LsTxV1I0w4Dhh9iFlQ/516KTyB2FMXVZBP
 F3QMX4bjT8jjjVOBn5YuBTASLfvdJtbRV4vN6jM2pMYsk1q1bsDMqr7nCC6XpkvoCW1jXQmWtzH
 7RwgGWyqaajI8/Ql1M1vMitxRv7ugkgzXZthg8Y84KlxTYBh0CCPrcPToyLLSDFzgPg2spIusQh
 U9DXp9u7L11JOCuWTNoDzKIg3JbGUJ2d3YB/GKleGUUjBQG9Q8kvy1CtTJgNYfxp1QOmeoSFkKs
 1bPYAFfKpvpgRZSIFh1yz76auxJ6/jd1pS
X-Received: by 2002:a05:6512:1053:b0:5a3:ffed:8440 with SMTP id
 2adb3069b0e04-5aa0e73d549mr8445759e87.12.1779290269709; 
 Wed, 20 May 2026 08:17:49 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c8b2sm5022470e87.17.2026.05.20.08.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 08:17:49 -0700 (PDT)
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
Subject: [PATCH v3 1/2] drm/amdgpu: convert amdgpu_vm_lock_by_pasid() to
 drm_exec
Date: Wed, 20 May 2026 20:17:39 +0500
Message-ID: <20260520151741.50575-2-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520151741.50575-1-mikhail.v.gavrilov@gmail.com>
References: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
 <20260520151741.50575-1-mikhail.v.gavrilov@gmail.com>
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

Convert the helper to take a drm_exec context and lock the root PD via
amdgpu_vm_lock_pd() instead. Callers now run it inside a
drm_exec_until_all_locked() loop and can lock additional BOs in the same
ww ticket, so there is no nested ww_mutex acquire.

The only existing caller, amdgpu_vm_handle_fault(), is updated
accordingly. Its is_compute_context path, which previously dropped the
root reservation around svm_range_restore_pages() and re-took it, now
finalises the drm_exec context and re-initialises a fresh one; behaviour
is otherwise unchanged.

No functional change intended for the page-fault path.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 72 ++++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  3 +-
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9ba9de16a27a..3a22670b733f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2950,14 +2950,22 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 }
 
 /**
- * amdgpu_vm_lock_by_pasid - return an amdgpu_vm and its root bo from a pasid, if possible.
+ * amdgpu_vm_lock_by_pasid - look up a VM by PASID and lock its root PD
  * @adev: amdgpu device pointer
- * @root: root BO of the VM
+ * @root: out: reference to the VM's root BO, dropped by the caller
  * @pasid: PASID of the VM
- * The caller needs to unreserve and unref the root bo on success.
+ * @exec: drm_exec context to lock the root PD in
+ *
+ * Must be called from within a drm_exec_until_all_locked() loop; the caller
+ * runs drm_exec_retry_on_contention() afterwards and drops the *root
+ * reference once the drm_exec context is finalised.
+ *
+ * Return: the VM on success, or NULL if the PASID has no VM, the VM is being
+ * torn down, or locking the root PD failed.
  */
 struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
-					  struct amdgpu_bo **root, u32 pasid)
+					  struct amdgpu_bo **root, u32 pasid,
+					  struct drm_exec *exec)
 {
 	unsigned long irqflags;
 	struct amdgpu_vm *vm;
@@ -2971,9 +2979,11 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
 	if (!*root)
 		return NULL;
 
-	r = amdgpu_bo_reserve(*root, true);
-	if (r)
-		goto error_unref;
+	r = amdgpu_vm_lock_pd(vm, exec, 0);
+	if (r) {
+		amdgpu_bo_unref(root);
+		return NULL;
+	}
 
 	/* Double check that the VM still exists */
 	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
@@ -2981,16 +2991,12 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
 	if (vm && vm->root.bo != *root)
 		vm = NULL;
 	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
-	if (!vm)
-		goto error_unlock;
+	if (!vm) {
+		amdgpu_bo_unref(root);
+		return NULL;
+	}
 
 	return vm;
-error_unlock:
-	amdgpu_bo_unreserve(*root);
-
-error_unref:
-	amdgpu_bo_unref(root);
-	return NULL;
 }
 
 /**
@@ -3013,20 +3019,32 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 {
 	bool is_compute_context = false;
 	struct amdgpu_bo *root;
+	struct drm_exec exec;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
 	int r;
 
-	vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
-	if (!vm)
+	drm_exec_init(&exec, 0, 0);
+	drm_exec_until_all_locked(&exec) {
+		vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid, &exec);
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
 					     node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
@@ -3036,9 +3054,17 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		amdgpu_bo_unref(&root);
 
 		/* Re-acquire the VM lock, could be that the VM was freed in between. */
-		vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
-		if (!vm)
+		drm_exec_init(&exec, 0, 0);
+		drm_exec_until_all_locked(&exec) {
+			vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid, &exec);
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
@@ -3076,7 +3102,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	r = amdgpu_vm_update_pdes(adev, vm, true);
 
 error_unlock:
-	amdgpu_bo_unreserve(root);
+	drm_exec_fini(&exec);
 	if (r < 0)
 		dev_err(adev->dev, "Can't handle page fault (%d)\n", r);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d083d7aab75c..af292c2fc521 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -593,7 +593,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    bool write_fault);
 
 struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
-					  struct amdgpu_bo **root, u32 pasid);
+					  struct amdgpu_bo **root, u32 pasid,
+					  struct drm_exec *exec);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 
-- 
2.54.0

