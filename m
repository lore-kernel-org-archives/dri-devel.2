Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB5BFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D689810E9D9;
	Wed, 29 Apr 2026 14:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qGswkzT0";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C58310E9D9
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:37:50 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5a283c44478so19703477e87.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777473468; x=1778078268; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jll39Xqy18SFNSEMkkDeWu7wM9j7NCAIvdDzP0v4P/M=;
 b=qGswkzT0C4EAqR07uu4ATAfwD3ofyy6UZnWUV43N5OKIwfMKeGcCN7MdkDTn7RWGcU
 yGfOvRZoBzrR0W3V4RQ+Aa/S/l0TKRKvcC1jQ6iEeNrrnXXYVBX0H6jz0e2pcM/ncFxn
 heNWV9hLMH58tKeqzQ9DEbiIchkf6EgCis66p5+fZHjh4gHUmZ60VQJLTKrduCdJiODn
 GOjy8HV6SCtJPJB5licgwTiNds14glk9KyRT3sENptGhlgcA81vAgzAxMRcXM62BYDjw
 VBqxzdR3wfoVJ/FZI7NEktfFYLBv0/ayhYPYKsIDsxdxOyDN97mB7x0UnY26P4JvsVP9
 6ADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473468; x=1778078268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jll39Xqy18SFNSEMkkDeWu7wM9j7NCAIvdDzP0v4P/M=;
 b=VG0dYrm+FgZ0mEc3j7A/1Pb6mNEpuv4DslBJarAS2EwC33ldnz5cM++PqOMkBEBHp/
 G0QRbsGbt42PdERxej0jaZqysu7v0TxyuCEr4y8l5PVOU/EvuVLzAqevx5kjf5s1S8Qc
 A71O1aLRYSUdD3uAw/RqdeJwvedsA57RbUSmTB3qwUtB/dwFFCVhbfBEg57yadev5G+N
 YIJCD/qqQEkn/XggZflrFZh+xFK6bVbdZsiGNFjwl2x7ng79VolrwgiHzYjMS0AfKYTT
 t2pHnI00fWKncI/25pncGaIulvH0UordX01AqztpsFPa5q/7YGwON4CF2gfNk7xuFsMe
 FA8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YidCz4pYZlgAVZfVAogaDz0H9AfCx+PZu7SQV1TM64YLNKjtrRYymLIuKmInlNCA+EemBoAkWp/8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwooyTdXFjnAV1A7zzqmdx3V1aGETdIATZPXBdTkO2rjhgDgEbp
 GRWOc5oFOUabvEueP3T3O7ChZfEW+RqWWcpYroswYGw01xYD6U1ciYfw
X-Gm-Gg: AeBDiesGLUmKXspZ3eryIDLseLyDLwjqL3LuZ1hSe6476sQPuzpYjoUGYZNyY2Yu6Zm
 m+OfBgnG8G+u8Y5fT5rMBUsKA9oiLfT/MICM+oD/1HpH5alxAt0CpBwJWg/mMofhH9prCiB31dv
 cwTvO8NYXaElkb1mt56Agu6cgQgd0WtQ+qek7jZA/z89QrMAauYIY7vz+Jt9AEQIGkna7Oda1Ee
 U+7TYOtpvmOtSdvfDpZTxFix28uUiTN0tSxcDIfaTnwqsZ3FnENLKt/BRi58ouqOi+V3rYqHXJb
 wjDdgUW1/OYEOzq8lk20omLBF/9Vv0P/HK4KKFBMqwzo2YN4acjjDmRPsKnaVuc2sZtrx501LCW
 n5ySfwadFSGef8/PJTNT/HfhOjqoxc/fKyU21+uvpDF26SJctI8pYHQJ54A3Mi2QWcMljTj5Fhi
 exPXFwYFH2C7+t4wB0EQkZ1kU0gYPVabuSdAcGSYluIxUF
X-Received: by 2002:a05:6512:3502:b0:5a2:86a3:709f with SMTP id
 2adb3069b0e04-5a74660cd3amr3134081e87.17.1777473467800; 
 Wed, 29 Apr 2026 07:37:47 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a74a6f3019sm607425e87.20.2026.04.29.07.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:37:47 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, stable@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH] drm/amdgpu: fix recursive ww_mutex acquire in
 amdgpu_devcoredump_format
Date: Wed, 29 Apr 2026 19:37:43 +0500
Message-ID: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
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

When dumping IB contents from a hung job, amdgpu_devcoredump_format()
acquires the VM root PD's reservation lock via amdgpu_vm_lock_by_pasid()
and then, for each IB referenced by the job, calls amdgpu_bo_reserve()
on the BO that backs the IB.  Both reservations are taken on
reservation_ww_class_mutex objects but neither uses a ww_acquire_ctx,
which trips lockdep:

  WARNING: possible recursive locking detected
  --------------------------------------------
  kworker/u128:0 is trying to acquire lock:
  ffff88838b16e1f0 (reservation_ww_class_mutex){+.+.}-{4:4},
    at: amdgpu_devcoredump_format+0x1594/0x23f0 [amdgpu]

  but task is already holding lock:
  ffff8882f82681f0 (reservation_ww_class_mutex){+.+.}-{4:4},
    at: amdgpu_devcoredump_format+0x1594/0x23f0 [amdgpu]

   Possible unsafe locking scenario:
         CPU0
         ----
    lock(reservation_ww_class_mutex);
    lock(reservation_ww_class_mutex);

   *** DEADLOCK ***
   May be due to missing lock nesting notation

  Workqueue: events_unbound amdgpu_devcoredump_deferred_work [amdgpu]
  Call Trace:
   __ww_mutex_lock.constprop.0
   ww_mutex_lock
   amdgpu_bo_reserve
   amdgpu_devcoredump_format+0x1594 [amdgpu]
   amdgpu_devcoredump_deferred_work+0xea [amdgpu]
   process_one_work
   worker_thread
   kthread

The two reservations are on different BOs in the captured trace, so the
splat is a lockdep-correctness warning, not an observed deadlock.  It
becomes a real self-deadlock whenever the IB BO shares its dma_resv
with the root PD (the always-valid case, see
amdgpu_vm_is_bo_always_valid()): amdgpu_bo_reserve(abo) re-acquires the
same ww_mutex without a ticket and blocks forever.

With amdgpu.gpu_recovery=0 the timeout handler refires every ~2 s and
each invocation produces this splat, drowning the kernel ring buffer.

Fix it by collecting the per-IB BO references under the root PD's
reservation, then releasing the root before reserving each IB BO
individually.  The walk over the VM mapping tree must remain under the
root lock (mappings can be torn down without it), but the actual
content copies do not need to nest inside it.  Each per-IB reservation
is now an independent top-level acquire, eliminating the nested
ww_mutex.

The collect/release logic is factored out into two small helpers
(amdgpu_devcoredump_collect_ib_refs / amdgpu_devcoredump_release_ib_refs)
to keep the main function's indentation reasonable.

This also fixes a BO refcount leak in the original code: when
amdgpu_bo_reserve() failed, control jumped to free_ib_content without
running amdgpu_bo_unref().  In the new structure the per-IB BO refs
are released unconditionally in the cleanup helper.

Reproducer (~150 LoC libdrm_amdgpu): submit a single GFX IB containing
PACKET3_INDIRECT_BUFFER chained at GPU VA 0 and wait for the fence.
The TDR fires within ~10 s and the deferred coredump worker produces
the splat above on every invocation.

Fixes: 7b15fc2d1f1a ("drm/amdgpu: dump job ibs in the devcoredump")
Cc: stable@vger.kernel.org # 7.1
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 147 +++++++++++++-----
 1 file changed, 110 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index d386bc775d03..f6bb968de756 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -207,6 +207,72 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
 	}
 }
 
+struct amdgpu_devcoredump_ib_ref {
+	struct amdgpu_bo	*bo;
+	u64			offset;
+};
+
+/*
+ * Walk the VM's mapping tree under the root PD's reservation to obtain the BO
+ * that backs each IB and pin it with a refcount. The root PD reservation is
+ * dropped before this function returns; the caller can then reserve each IB
+ * BO individually without nesting ww_mutex acquires on
+ * reservation_ww_class_mutex.
+ *
+ * Returns an array of num_ibs entries (each ib_refs[i].bo may be NULL if its
+ * mapping was not found), or NULL on allocation failure / VM lookup failure.
+ * The caller must release the BO refs and free the array.
+ */
+static struct amdgpu_devcoredump_ib_ref *
+amdgpu_devcoredump_collect_ib_refs(struct amdgpu_device *adev,
+				   struct amdgpu_coredump_info *coredump)
+{
+	struct amdgpu_devcoredump_ib_ref *ib_refs;
+	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_bo *root;
+	struct amdgpu_vm *vm;
+	u64 va_start;
+
+	ib_refs = kcalloc(coredump->num_ibs, sizeof(*ib_refs), GFP_KERNEL);
+	if (!ib_refs)
+		return NULL;
+
+	vm = amdgpu_vm_lock_by_pasid(adev, &root, coredump->pasid);
+	if (!vm) {
+		kfree(ib_refs);
+		return NULL;
+	}
+
+	for (int i = 0; i < coredump->num_ibs; i++) {
+		va_start = coredump->ibs[i].gpu_addr & AMDGPU_GMC_HOLE_MASK;
+		mapping = amdgpu_vm_bo_lookup_mapping(vm, va_start / AMDGPU_GPU_PAGE_SIZE);
+		if (!mapping)
+			continue;
+
+		ib_refs[i].bo = amdgpu_bo_ref(mapping->bo_va->base.bo);
+		ib_refs[i].offset = va_start -
+				    mapping->start * AMDGPU_GPU_PAGE_SIZE;
+	}
+
+	amdgpu_bo_unreserve(root);
+	amdgpu_bo_unref(&root);
+
+	return ib_refs;
+}
+
+static void
+amdgpu_devcoredump_release_ib_refs(struct amdgpu_devcoredump_ib_ref *ib_refs,
+				   int num_ibs)
+{
+	if (!ib_refs)
+		return;
+
+	for (int i = 0; i < num_ibs; i++)
+		if (ib_refs[i].bo)
+			amdgpu_bo_unref(&ib_refs[i].bo);
+	kfree(ib_refs);
+}
+
 static ssize_t
 amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_info *coredump)
 {
@@ -214,13 +280,11 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 	struct drm_printer p;
 	struct drm_print_iterator iter;
 	struct amdgpu_vm_fault_info *fault_info;
-	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_ip_block *ip_block;
 	struct amdgpu_res_cursor cursor;
-	struct amdgpu_bo *abo, *root;
-	uint64_t va_start, offset;
+	struct amdgpu_bo *abo;
+	uint64_t offset;
 	struct amdgpu_ring *ring;
-	struct amdgpu_vm *vm;
 	u32 *ib_content;
 	uint8_t *kptr;
 	int ver, i, j, r;
@@ -343,43 +407,52 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
 
 	if (coredump->num_ibs) {
-		/* Don't try to lookup the VM or map the BOs when calculating the
-		 * size required to store the devcoredump.
+		struct amdgpu_devcoredump_ib_ref *ib_refs = NULL;
+
+		/*
+		 * Snapshot per-IB BO references under the root PD's reservation,
+		 * then release the root before reserving each IB BO individually
+		 * to copy its contents.
+		 *
+		 * Reserving an IB BO while the root PD is still reserved would
+		 * be a nested ww_mutex acquire on reservation_ww_class_mutex
+		 * without a ww_acquire_ctx, which trips lockdep's recursive-
+		 * locking check and self-deadlocks for IB BOs that share their
+		 * dma_resv with the root PD (always-valid BOs).
+		 *
+		 * Skip lookup/reservation entirely on the sizing pass: it does
+		 * not write IB content, and the size estimate doesn't depend on
+		 * whether the BOs are reachable.
 		 */
-		if (sizing_pass)
-			vm = NULL;
-		else
-			vm = amdgpu_vm_lock_by_pasid(adev, &root, coredump->pasid);
+		if (!sizing_pass)
+			ib_refs = amdgpu_devcoredump_collect_ib_refs(adev, coredump);
 
-		for (int i = 0; i < coredump->num_ibs && (sizing_pass || vm); i++) {
+		for (int i = 0; i < coredump->num_ibs; i++) {
 			ib_content = kvmalloc_array(coredump->ibs[i].ib_size_dw, 4,
 						    GFP_KERNEL);
 			if (!ib_content)
 				continue;
 
-			/* vm=NULL can only happen when 'sizing_pass' is true. Skip to the
-			 * drm_printf() calls (ib_content doesn't need to be initialized
-			 * as its content won't be written anywhere).
-			 */
-			if (!vm)
+			if (sizing_pass)
 				goto output_ib_content;
 
-			va_start = coredump->ibs[i].gpu_addr & AMDGPU_GMC_HOLE_MASK;
-			mapping = amdgpu_vm_bo_lookup_mapping(vm, va_start / AMDGPU_GPU_PAGE_SIZE);
-			if (!mapping)
-				goto free_ib_content;
+			if (!ib_refs || !ib_refs[i].bo)
+				goto output_ib_content;
+
+			abo = ib_refs[i].bo;
+			offset = ib_refs[i].offset;
 
-			offset = va_start - (mapping->start * AMDGPU_GPU_PAGE_SIZE);
-			abo = amdgpu_bo_ref(mapping->bo_va->base.bo);
 			r = amdgpu_bo_reserve(abo, false);
 			if (r)
-				goto free_ib_content;
+				goto output_ib_content;
 
 			if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
 				off = 0;
 
-				if (abo->tbo.resource->mem_type != TTM_PL_VRAM)
-					goto unreserve_abo;
+				if (abo->tbo.resource->mem_type != TTM_PL_VRAM) {
+					amdgpu_bo_unreserve(abo);
+					goto output_ib_content;
+				}
 
 				amdgpu_res_first(abo->tbo.resource, offset,
 						 coredump->ibs[i].ib_size_dw * 4,
@@ -395,8 +468,10 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 				r = ttm_bo_kmap(&abo->tbo, 0,
 						PFN_UP(abo->tbo.base.size),
 						&abo->kmap);
-				if (r)
-					goto unreserve_abo;
+				if (r) {
+					amdgpu_bo_unreserve(abo);
+					goto output_ib_content;
+				}
 
 				kptr = amdgpu_bo_kptr(abo);
 				kptr += offset;
@@ -406,21 +481,19 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 				amdgpu_bo_kunmap(abo);
 			}
 
+			amdgpu_bo_unreserve(abo);
+
 output_ib_content:
 			drm_printf(&p, "\nIB #%d 0x%llx %d dw\n",
 				   i, coredump->ibs[i].gpu_addr, coredump->ibs[i].ib_size_dw);
-			for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
-				drm_printf(&p, "0x%08x\n", ib_content[j]);
-unreserve_abo:
-			if (vm)
-				amdgpu_bo_unreserve(abo);
-free_ib_content:
+			if (!sizing_pass && ib_refs && ib_refs[i].bo) {
+				for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
+					drm_printf(&p, "0x%08x\n", ib_content[j]);
+			}
 			kvfree(ib_content);
 		}
-		if (vm) {
-			amdgpu_bo_unreserve(root);
-			amdgpu_bo_unref(&root);
-		}
+
+		amdgpu_devcoredump_release_ib_refs(ib_refs, coredump->num_ibs);
 	}
 
 	return count - iter.remain;
-- 
2.54.0

