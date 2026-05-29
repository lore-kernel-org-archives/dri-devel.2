Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEF2CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 06:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7276B10F99B;
	Fri, 29 May 2026 06:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jx5Ov6rW";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BCC710F995
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:48:25 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5aa2d5a1d51so6586718e87.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780037304; x=1780642104; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJUei/KuumAUMNhgELgEfVVLFOVaFW7qqMv2FxIHEpg=;
 b=Jx5Ov6rWaS1snQAkLU3AqhckLB2v06ISJrgxW6AKK6b5IhrZ35vDzUyQrWxbYpppHR
 CfYmSpk+DqXByqTVWWg/za8l1ijuCL+PvtrYmqmVnl25y61nRJRKoRfd2gDYpVGdbmaO
 A06MLMmaUoWYYIpoFOwwpqmdzpBUGjMoL90saLyA7+pPhm6gxO5rfM17L0taCi06H4IZ
 6UcZEZUASspMCHf0N7aMREXaVJfW05WNJcksUfGx578vrPUhh+K2sk/nEIFqxOWpNyxp
 mz9FqCzIALPfoRkRMEpPuWTB0QPECo/i7SY8T5dcVphkYZfnus6Xe7bZ3ZomR7t1+3iG
 62mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780037304; x=1780642104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pJUei/KuumAUMNhgELgEfVVLFOVaFW7qqMv2FxIHEpg=;
 b=mK8yfdMhHZ/odX7lQy8ZxV0XNfMcZbOr0+PJPX3va5DvEKP+ExncBl0qp0Up/yESQP
 /ngeQSRqKl9WdLddSx/xwcglvX3+yk2Z22a88GOYaCQzOGQNN+aI9ViLO4XQDd89C9dM
 QhtYCEfZyUHyUaQrb83XEo2XJQCzzVcZfkRhImivWoFrT3Z/jVUzVco0JE6nO51eJlBc
 /7Waaq0GzHSa+McDF1u9VqkifrvkNCzCr4zM//phHPgL7cljMWUd4Tpl9OZkKsS2pfyV
 VS6y7pEi18xIKxfefLAwJHXxYTwXk4eSWf9hS0PgGOHEEvYiZ9+uc8SUUR/s9is82Ufz
 zhiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+e3HepDtVosdGuSzQ1LlnCTxc77zBtLNHTgvDyEqUJtHkZbBaSrbYyP8nlfOOLemW8y6BejiG61tI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+cXOF6XDNGhpadzodug+QkRKb/92ViSQiu/IUvKGy1nhibfei
 GR4c2s9z1b1irEaJafgGX0BKNa4n9MInaTvixxoydpcEogWWbps8qj0X
X-Gm-Gg: Acq92OEQ2PV4D58W4NgQj9X+6+tghhlXKVXyRgwDo6YoPr7Mmfh08AruZ4LMgeUPWTG
 AY49LJM1Huf7pIYLJcK5S7hxp5M55p0BjMJyDEXmw+iLo1johBs51G0VsTOneznhKmShW9d7Qwy
 HP8M+TKGu5twMIxtRCl51HVr6Sstnr/Vo25xprJB0F/U5LZDj6kZv7yHjx5srfj5oXpYazuhBzD
 sPI6DYVkKw0dWMny06zP3aEk4iS2mFoNtTkfDuNoY8ywcu+rdFF4Es2OAbso/efJPEheurv1KTq
 1hJGkb7DvYXXpuJOagy+QRE10ShQ3ogR3YDfpmxATPl4FZ54OQnCzr6vf7L3kJrsYM9ekpZSNEw
 hK1WtRtfJ4ZV749DGPpTHkfRzC9OUrS/YrIS6GHoBxH1nvCml6NRTEN5Bk0WTjS6MboF+dFBOhQ
 esfXpccqk6Udj3URSzCpRTjm2ugPtvsUU+cjdM7tlqcz0=
X-Received: by 2002:a05:6512:a8c:b0:5aa:106f:87bb with SMTP id
 2adb3069b0e04-5aa59475a96mr400169e87.3.1780037303600; 
 Thu, 28 May 2026 23:48:23 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa5b79f04dsm72147e87.83.2026.05.28.23.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 23:48:23 -0700 (PDT)
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
Subject: [PATCH v6 2/2] drm/amdgpu: fix recursive ww_mutex acquire in
 amdgpu_devcoredump_format
Date: Fri, 29 May 2026 11:47:39 +0500
Message-ID: <20260529064740.25060-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529064740.25060-1-mikhail.v.gavrilov@gmail.com>
References: <20260521150841.20625-1-mikhail.v.gavrilov@gmail.com>
 <20260529064740.25060-1-mikhail.v.gavrilov@gmail.com>
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

When dumping IB contents from a hung job, amdgpu_devcoredump_format()
acquired the VM root PD's reservation via amdgpu_vm_lock_by_pasid() and
then, for each IB, called amdgpu_bo_reserve() on the BO backing the IB.
Both reservations are reservation_ww_class_mutex objects and neither
used a ww_acquire_ctx, which trips lockdep:

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

The two reservations are on different BOs in the captured trace, so the
splat is a lockdep-correctness warning, not an observed deadlock. It
becomes a real self-deadlock whenever the IB BO shares its dma_resv with
the root PD (the always-valid case, see amdgpu_vm_is_bo_always_valid()):
amdgpu_bo_reserve(abo) re-acquires the same ww_mutex without a ticket
and blocks forever. With amdgpu.gpu_recovery=0 the timeout handler
refires every ~2 s and each invocation produces this splat, drowning the
kernel ring buffer.

Now that amdgpu_vm_lock_by_pasid() takes a drm_exec context, move the IB
dumping into a separate helper that locks the root PD and every IB BO
together in a single drm_exec ticket. DRM_EXEC_IGNORE_DUPLICATES handles
IB BOs that share a dma_resv (e.g. always-valid BOs, or two IBs backed
by the same BO). Every lock is now a top-level acquire under one
ww_acquire_ctx, so the recursive ww_mutex condition is gone, and the
per-IB amdgpu_bo_reserve()/amdgpu_bo_unref() dance -- including a BO
refcount leak on the amdgpu_bo_reserve() failure path -- is removed.

Fixes: 7b15fc2d1f1a ("drm/amdgpu: dump job ibs in the devcoredump")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 215 ++++++++++--------
 1 file changed, 126 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index d386bc775d03..c7d43796d603 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -24,6 +24,7 @@
 
 #include <generated/utsrelease.h>
 #include <linux/devcoredump.h>
+#include <drm/drm_exec.h>
 #include "amdgpu_dev_coredump.h"
 #include "atom.h"
 
@@ -207,23 +208,137 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
 	}
 }
 
+static void
+amdgpu_devcoredump_print_ibs(struct drm_printer *p,
+			     struct amdgpu_coredump_info *coredump,
+			     bool sizing_pass)
+{
+	struct amdgpu_device *adev = coredump->adev;
+	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_bo *abo;
+	struct drm_exec exec;
+	struct amdgpu_vm *vm;
+	u32 *ib_content;
+	u64 va_start, offset;
+	u8 *kptr;
+	u32 off;
+	int r;
+
+	/*
+	 * On the sizing pass there is no VM to look up and no BO to lock; the
+	 * size estimate doesn't depend on whether the IB BOs are reachable.
+	 * Just emit the per-IB headers (the content is not written anywhere).
+	 */
+	if (sizing_pass) {
+		for (int i = 0; i < coredump->num_ibs; i++) {
+			drm_printf(p, "\nIB #%d 0x%llx %d dw\n", i,
+				   coredump->ibs[i].gpu_addr,
+				   coredump->ibs[i].ib_size_dw);
+		}
+		return;
+	}
+
+	/*
+	 * Lock the VM root PD and every IB BO together in a single drm_exec
+	 * ticket. Reserving the IB BOs one by one while the root PD is held
+	 * would be a recursive reservation_ww_class_mutex acquire without a
+	 * ww_acquire_ctx, which trips lockdep and self-deadlocks for IB BOs
+	 * that share their dma_resv with the root PD (always-valid BOs).
+	 */
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 1 + coredump->num_ibs);
+	drm_exec_until_all_locked(&exec) {
+		vm = amdgpu_vm_lock_by_pasid(adev, coredump->pasid, &exec);
+		if (!vm)
+			goto unlock;
+
+		for (int i = 0; i < coredump->num_ibs; i++) {
+			u64 pfn = (coredump->ibs[i].gpu_addr &
+				   AMDGPU_GMC_HOLE_MASK) / AMDGPU_GPU_PAGE_SIZE;
+
+			mapping = amdgpu_vm_bo_lookup_mapping(vm, pfn);
+			if (!mapping)
+				continue;
+
+			abo = mapping->bo_va->base.bo;
+			r = drm_exec_lock_obj(&exec, &abo->tbo.base);
+			drm_exec_retry_on_contention(&exec);
+			if (r)
+				goto unlock;
+		}
+	}
+
+	for (int i = 0; i < coredump->num_ibs; i++) {
+		bool emit_content = false;
+
+		ib_content = kvmalloc_array(coredump->ibs[i].ib_size_dw, 4,
+					    GFP_KERNEL);
+		if (!ib_content)
+			continue;
+
+		va_start = coredump->ibs[i].gpu_addr & AMDGPU_GMC_HOLE_MASK;
+		mapping = amdgpu_vm_bo_lookup_mapping(vm,
+						      va_start / AMDGPU_GPU_PAGE_SIZE);
+		if (!mapping)
+			goto output_ib_content;
+
+		abo = mapping->bo_va->base.bo;
+		offset = va_start - mapping->start * AMDGPU_GPU_PAGE_SIZE;
+
+		if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
+			struct amdgpu_res_cursor cursor;
+
+			off = 0;
+
+			if (abo->tbo.resource->mem_type != TTM_PL_VRAM)
+				goto output_ib_content;
+
+			amdgpu_res_first(abo->tbo.resource, offset,
+					 coredump->ibs[i].ib_size_dw * 4, &cursor);
+			while (cursor.remaining) {
+				amdgpu_device_mm_access(adev, cursor.start / 4,
+							&ib_content[off], cursor.size / 4,
+							false);
+				off += cursor.size;
+				amdgpu_res_next(&cursor, cursor.size);
+			}
+			emit_content = true;
+		} else {
+			r = ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size),
+					&abo->kmap);
+			if (r)
+				goto output_ib_content;
+
+			kptr = amdgpu_bo_kptr(abo);
+			kptr += offset;
+			memcpy(ib_content, kptr, coredump->ibs[i].ib_size_dw * 4);
+
+			amdgpu_bo_kunmap(abo);
+			emit_content = true;
+		}
+
+output_ib_content:
+		drm_printf(p, "\nIB #%d 0x%llx %d dw\n", i,
+			   coredump->ibs[i].gpu_addr, coredump->ibs[i].ib_size_dw);
+		if (emit_content) {
+			for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
+				drm_printf(p, "0x%08x\n", ib_content[j]);
+		}
+		kvfree(ib_content);
+	}
+
+unlock:
+	drm_exec_fini(&exec);
+}
+
 static ssize_t
 amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_info *coredump)
 {
-	struct amdgpu_device *adev = coredump->adev;
 	struct drm_printer p;
 	struct drm_print_iterator iter;
 	struct amdgpu_vm_fault_info *fault_info;
-	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_ip_block *ip_block;
-	struct amdgpu_res_cursor cursor;
-	struct amdgpu_bo *abo, *root;
-	uint64_t va_start, offset;
 	struct amdgpu_ring *ring;
-	struct amdgpu_vm *vm;
-	u32 *ib_content;
-	uint8_t *kptr;
-	int ver, i, j, r;
+	int ver, i, j;
 	u32 ring_idx, off;
 	bool sizing_pass;
 
@@ -342,86 +457,8 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 	else if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
 
-	if (coredump->num_ibs) {
-		/* Don't try to lookup the VM or map the BOs when calculating the
-		 * size required to store the devcoredump.
-		 */
-		if (sizing_pass)
-			vm = NULL;
-		else
-			vm = amdgpu_vm_lock_by_pasid(adev, &root, coredump->pasid);
-
-		for (int i = 0; i < coredump->num_ibs && (sizing_pass || vm); i++) {
-			ib_content = kvmalloc_array(coredump->ibs[i].ib_size_dw, 4,
-						    GFP_KERNEL);
-			if (!ib_content)
-				continue;
-
-			/* vm=NULL can only happen when 'sizing_pass' is true. Skip to the
-			 * drm_printf() calls (ib_content doesn't need to be initialized
-			 * as its content won't be written anywhere).
-			 */
-			if (!vm)
-				goto output_ib_content;
-
-			va_start = coredump->ibs[i].gpu_addr & AMDGPU_GMC_HOLE_MASK;
-			mapping = amdgpu_vm_bo_lookup_mapping(vm, va_start / AMDGPU_GPU_PAGE_SIZE);
-			if (!mapping)
-				goto free_ib_content;
-
-			offset = va_start - (mapping->start * AMDGPU_GPU_PAGE_SIZE);
-			abo = amdgpu_bo_ref(mapping->bo_va->base.bo);
-			r = amdgpu_bo_reserve(abo, false);
-			if (r)
-				goto free_ib_content;
-
-			if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
-				off = 0;
-
-				if (abo->tbo.resource->mem_type != TTM_PL_VRAM)
-					goto unreserve_abo;
-
-				amdgpu_res_first(abo->tbo.resource, offset,
-						 coredump->ibs[i].ib_size_dw * 4,
-						 &cursor);
-				while (cursor.remaining) {
-					amdgpu_device_mm_access(adev, cursor.start / 4,
-								&ib_content[off], cursor.size / 4,
-								false);
-					off += cursor.size;
-					amdgpu_res_next(&cursor, cursor.size);
-				}
-			} else {
-				r = ttm_bo_kmap(&abo->tbo, 0,
-						PFN_UP(abo->tbo.base.size),
-						&abo->kmap);
-				if (r)
-					goto unreserve_abo;
-
-				kptr = amdgpu_bo_kptr(abo);
-				kptr += offset;
-				memcpy(ib_content, kptr,
-				       coredump->ibs[i].ib_size_dw * 4);
-
-				amdgpu_bo_kunmap(abo);
-			}
-
-output_ib_content:
-			drm_printf(&p, "\nIB #%d 0x%llx %d dw\n",
-				   i, coredump->ibs[i].gpu_addr, coredump->ibs[i].ib_size_dw);
-			for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
-				drm_printf(&p, "0x%08x\n", ib_content[j]);
-unreserve_abo:
-			if (vm)
-				amdgpu_bo_unreserve(abo);
-free_ib_content:
-			kvfree(ib_content);
-		}
-		if (vm) {
-			amdgpu_bo_unreserve(root);
-			amdgpu_bo_unref(&root);
-		}
-	}
+	if (coredump->num_ibs)
+		amdgpu_devcoredump_print_ibs(&p, coredump, sizing_pass);
 
 	return count - iter.remain;
 }
-- 
2.54.0

