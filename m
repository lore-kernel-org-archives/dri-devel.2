Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2965CCD5BAB
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 15:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5790610F0BD;
	Wed, 20 May 2026 15:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k6pHgPIA";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A53A10F0B7
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 15:17:53 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5a746f9c092so7993533e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779290272; x=1779895072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K81Nh8nBOwZaTCEqstpBUGuFaakdxNh2S8dsFKzzkkM=;
 b=k6pHgPIAAWuGJDPz8D1eVE/NYYL8a0V2CAnyB8eEta4C93n948bfzd4gy22YYcd/zX
 Me0CalnVD7oktyL3IkVmE9vIW6uiUC7h/Zt90YjqCmc4+0HoDlfVkEq4ecN9zE29TZIK
 HoAr+W8tC3Kivb4htz8IhyqM4B5qt4D45rWh4lpQ+p0faDaVAErFdtZGi519WWnAHquA
 puQlPMAeppIgIaox1bQePE3nLkQmejvSMXn8z+zw5dTij59mPVlcy/1BC0R9zmwAP4m0
 ac4cmcrkk14VcZQ0XdcsfGaaZNrhLNQFEr5uqMSCY9NYRXtvtJ7Rq4i1gYaq32fL69Yv
 rVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779290272; x=1779895072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K81Nh8nBOwZaTCEqstpBUGuFaakdxNh2S8dsFKzzkkM=;
 b=quNtdkI+LT1pcGY4Q/1w12qLcVHTagK0urmp1qp9ppFAbSkl9IR7IRqd2K+pIesjX3
 8P6HxyNOgQZBtSbT3hq2pBw5VI6++Uu5NXUw6aFq+YvkS8v20RmAMw+ZvM1kExnCm5M5
 1VMveCkW5GeOEq2KFyOnxDsC4FL4q38zFjM8IilmYhq2lj9rSvywEs9ULI+uShg4fvo3
 av4tBbuq5SIGX0+wuekBgQVwz4aaNPJL9eLI3i1drcqP7RDFGYlfh2aQsgA6eJyYnxi8
 IzT6KSNuxSe2Ya8OjEYOuxs9PUFchoetrg2wtK/akGZ1v2U3WxxDTdQdXEELU4ssBrAH
 9lEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NyTe+irTTbcngW/xtJ6svsfjEL++K50prhQiUdeUnzimJrZwOTNXZDxXAJMTkBDf4HYweuDyfCWI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxlf1reaQjLYXWMfz5Ae17sFpoPXKUW05YzVm3XouNAa5QVP5hz
 b81SoF5YUHj8x4mn0k/W9eTLmpiFnZxLOrAPnP39kSHgzXQXrjXrXD0I
X-Gm-Gg: Acq92OHHubB45orAMRo0lH/zOerXhbjsh0OdVXdNs5GvUSpl2MHm17SZov3xaEEvYj6
 6wDDYLhk8wKBoK1KIsTXvW6dS2JWpKsUopN9AocTguDGkdAMrZcNAo65zZq6ng3rLXKWj98AIFC
 75uT/TpPp83PZyaL8s22HDIkufwxrw8IbqwObHw6uvnzmwBtfGHV+spRwzbLYre5CmN+3KlrY43
 z/MZnNUnDjYbOFOjCQYJ5n/6wkTz/E/2gzd/aIH2yUgEUr/oo7vlmlyLatsZM1a5N1TswTRPrBl
 wf2xeNHDyj8LIh3yPjVgh6aKu4Rb+m/c+GzJJRFusscfc1MA6rkqvKutKfCzlcpkq/+vZLYG11D
 B9VCcE/S5nZnGWakSu7PiSzgJ/y1K/TD4YDMG+rHXs/GNASZ/k8j7KQdduLaHRS+i4pCFhgpfCq
 RQlIXaads2TVEfWG7b3QMMROpQOHn4fyu8IRX4Msjo2Dg=
X-Received: by 2002:ac2:4e01:0:b0:5a4:b02:66b1 with SMTP id
 2adb3069b0e04-5aa0de8aa10mr6131035e87.9.1779290271462; 
 Wed, 20 May 2026 08:17:51 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c8b2sm5022470e87.17.2026.05.20.08.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 08:17:50 -0700 (PDT)
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
Subject: [PATCH v3 2/2] drm/amdgpu: fix recursive ww_mutex acquire in
 amdgpu_devcoredump_format
Date: Wed, 20 May 2026 20:17:40 +0500
Message-ID: <20260520151741.50575-3-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520151741.50575-1-mikhail.v.gavrilov@gmail.com>
References: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
 <20260520151741.50575-1-mikhail.v.gavrilov@gmail.com>
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
and blocks forever.

With amdgpu.gpu_recovery=0 the timeout handler refires every ~2 s and
each invocation produces this splat, drowning the kernel ring buffer.

Now that amdgpu_vm_lock_by_pasid() takes a drm_exec context, lock the
root PD and every IB BO together in a single drm_exec ticket.
DRM_EXEC_IGNORE_DUPLICATES handles IB BOs that share a dma_resv (e.g.
always-valid BOs, or two IBs backed by the same BO). Every lock is now
a top-level acquire under one ww_acquire_ctx, so the recursive ww_mutex
condition is gone, and the per-IB amdgpu_bo_reserve()/amdgpu_bo_unref()
dance -- including a BO refcount leak on the amdgpu_bo_reserve() failure
path -- is removed.

Reproducer (~150 LoC libdrm_amdgpu): submit a single GFX IB containing
PACKET3_INDIRECT_BUFFER chained at GPU VA 0 and wait for the fence. The
TDR fires within ~10 s and the deferred coredump worker produces the
splat above on every invocation; with this change applied the splat is
gone.

Fixes: 7b15fc2d1f1a ("drm/amdgpu: dump job ibs in the devcoredump")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 103 ++++++++++++------
 1 file changed, 71 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index d386bc775d03..a9d8e03fad83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -24,6 +24,7 @@
 
 #include <generated/utsrelease.h>
 #include <linux/devcoredump.h>
+#include <drm/drm_exec.h>
 #include "amdgpu_dev_coredump.h"
 #include "atom.h"
 
@@ -214,13 +215,9 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 	struct drm_printer p;
 	struct drm_print_iterator iter;
 	struct amdgpu_vm_fault_info *fault_info;
-	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_ip_block *ip_block;
 	struct amdgpu_res_cursor cursor;
-	struct amdgpu_bo *abo, *root;
-	uint64_t va_start, offset;
 	struct amdgpu_ring *ring;
-	struct amdgpu_vm *vm;
 	u32 *ib_content;
 	uint8_t *kptr;
 	int ver, i, j, r;
@@ -343,43 +340,84 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
 
 	if (coredump->num_ibs) {
-		/* Don't try to lookup the VM or map the BOs when calculating the
-		 * size required to store the devcoredump.
+		struct amdgpu_bo_va_mapping *mapping;
+		struct amdgpu_bo *root, *abo;
+		struct drm_exec exec;
+		struct amdgpu_vm *vm;
+		u64 va_start, offset;
+		bool locked = false;
+
+		/*
+		 * Lock the VM root PD and every IB BO together in a single
+		 * drm_exec ticket. Reserving the IB BOs one by one while the
+		 * root PD is held would be a recursive reservation_ww_class_mutex
+		 * acquire without a ww_acquire_ctx, which trips lockdep and
+		 * self-deadlocks for IB BOs that share their dma_resv with the
+		 * root PD (always-valid BOs).
+		 *
+		 * Skip locking entirely on the sizing pass: it does not write
+		 * IB content, so the size estimate doesn't depend on whether
+		 * the BOs are reachable.
 		 */
-		if (sizing_pass)
-			vm = NULL;
-		else
-			vm = amdgpu_vm_lock_by_pasid(adev, &root, coredump->pasid);
+		if (!sizing_pass) {
+			drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES,
+				      1 + coredump->num_ibs);
+			drm_exec_until_all_locked(&exec) {
+				vm = amdgpu_vm_lock_by_pasid(adev, &root,
+							     coredump->pasid, &exec);
+				drm_exec_retry_on_contention(&exec);
+				if (!vm)
+					break;
+
+				for (int i = 0; i < coredump->num_ibs; i++) {
+					u64 pfn;
+
+					va_start = coredump->ibs[i].gpu_addr &
+						   AMDGPU_GMC_HOLE_MASK;
+					pfn = va_start / AMDGPU_GPU_PAGE_SIZE;
+					mapping = amdgpu_vm_bo_lookup_mapping(vm, pfn);
+					if (!mapping)
+						continue;
+
+					abo = mapping->bo_va->base.bo;
+					r = drm_exec_lock_obj(&exec, &abo->tbo.base);
+					drm_exec_retry_on_contention(&exec);
+					if (r)
+						break;
+				}
+				if (r)
+					break;
+			}
+			if (vm && !r)
+				locked = true;
+			else
+				drm_exec_fini(&exec);
+		}
+
+		for (int i = 0; i < coredump->num_ibs; i++) {
+			bool emit_content = sizing_pass;
 
-		for (int i = 0; i < coredump->num_ibs && (sizing_pass || vm); i++) {
 			ib_content = kvmalloc_array(coredump->ibs[i].ib_size_dw, 4,
 						    GFP_KERNEL);
 			if (!ib_content)
 				continue;
 
-			/* vm=NULL can only happen when 'sizing_pass' is true. Skip to the
-			 * drm_printf() calls (ib_content doesn't need to be initialized
-			 * as its content won't be written anywhere).
-			 */
-			if (!vm)
+			if (!locked)
 				goto output_ib_content;
 
 			va_start = coredump->ibs[i].gpu_addr & AMDGPU_GMC_HOLE_MASK;
 			mapping = amdgpu_vm_bo_lookup_mapping(vm, va_start / AMDGPU_GPU_PAGE_SIZE);
 			if (!mapping)
-				goto free_ib_content;
+				goto output_ib_content;
 
-			offset = va_start - (mapping->start * AMDGPU_GPU_PAGE_SIZE);
-			abo = amdgpu_bo_ref(mapping->bo_va->base.bo);
-			r = amdgpu_bo_reserve(abo, false);
-			if (r)
-				goto free_ib_content;
+			abo = mapping->bo_va->base.bo;
+			offset = va_start - mapping->start * AMDGPU_GPU_PAGE_SIZE;
 
 			if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
 				off = 0;
 
 				if (abo->tbo.resource->mem_type != TTM_PL_VRAM)
-					goto unreserve_abo;
+					goto output_ib_content;
 
 				amdgpu_res_first(abo->tbo.resource, offset,
 						 coredump->ibs[i].ib_size_dw * 4,
@@ -391,12 +429,13 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 					off += cursor.size;
 					amdgpu_res_next(&cursor, cursor.size);
 				}
+				emit_content = true;
 			} else {
 				r = ttm_bo_kmap(&abo->tbo, 0,
 						PFN_UP(abo->tbo.base.size),
 						&abo->kmap);
 				if (r)
-					goto unreserve_abo;
+					goto output_ib_content;
 
 				kptr = amdgpu_bo_kptr(abo);
 				kptr += offset;
@@ -404,21 +443,21 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 				       coredump->ibs[i].ib_size_dw * 4);
 
 				amdgpu_bo_kunmap(abo);
+				emit_content = true;
 			}
 
 output_ib_content:
 			drm_printf(&p, "\nIB #%d 0x%llx %d dw\n",
 				   i, coredump->ibs[i].gpu_addr, coredump->ibs[i].ib_size_dw);
-			for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
-				drm_printf(&p, "0x%08x\n", ib_content[j]);
-unreserve_abo:
-			if (vm)
-				amdgpu_bo_unreserve(abo);
-free_ib_content:
+			if (emit_content) {
+				for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
+					drm_printf(&p, "0x%08x\n", ib_content[j]);
+			}
 			kvfree(ib_content);
 		}
-		if (vm) {
-			amdgpu_bo_unreserve(root);
+
+		if (locked) {
+			drm_exec_fini(&exec);
 			amdgpu_bo_unref(&root);
 		}
 	}
-- 
2.54.0

