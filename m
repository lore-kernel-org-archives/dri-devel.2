Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B18CA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 20:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5622110F083;
	Tue, 29 Sep 2026 20:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Y5hNfTFk";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56F5810F083;
 Tue, 29 Sep 2026 20:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=4JFQSlkOpl/juhAvdKb3xT2ojX/cdAsls0KqZvgss9o=; b=Y5hNfTFk1mUA90tfQg9hhrcIYO
 2tOQAlibMjy9T1UJnUw49AxQsAhL/Y52kceXdyqUiAFm13dBqZOOzDMWUI1aNLJvSBrAfCqcdRSHG
 p9r0RUEJoIB/2LAedYrFlPIQMzjMGPvLfahL3eUQUSjLZqp1lp+Hhjzcw5FD3On70R74lMZXy65jv
 aLMlA0zs9h2esZ/4CctjH23OZOLLa/V0jR3oWiChnsJujkMcjGCZrREJKwd9WxV/32WfYeo6ueN0A
 0M9NXbsrhIYwNwrkP3fG26v3oM/9JwjImbVHnmZKjlb4Br514JTVSmJIJa1lD5MC1fydhIgX2SBpX
 jpq0CegQ==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xBeWu-0096Z5-LJ; Tue, 29 Sep 2026 22:34:24 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Tue, 29 Sep 2026 17:34:04 -0300
Subject: [PATCH 1/2] drm/amdgpu: make amdgpu_vm_update_funcs commit return void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-amdgpu_vm_update_funcs_abort-v1-1-a8072140a7db@igalia.com>
References: <20260929-amdgpu_vm_update_funcs_abort-v1-0-a8072140a7db@igalia.com>
In-Reply-To: <20260929-amdgpu_vm_update_funcs_abort-v1-0-a8072140a7db@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, 
 Chunming Zhou <david1.zhou@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Natalie Vock <nat@pixelcluster.dev>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel-dev@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.16-dev-62088
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

As both SDMA and CPU implementations always return 0, they can as well
just return void.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          | 14 ++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c      |  8 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c     | 11 +++--------
 5 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bcb5015bdede..201e3e114f07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1024,9 +1024,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 			goto error;
 	}
 
-	r = vm->update_funcs->commit(&params, &vm->last_update);
-	if (r)
-		goto error;
+	vm->update_funcs->commit(&params, &vm->last_update);
 
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
@@ -1242,9 +1240,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		start = tmp;
 	}
 
-	r = vm->update_funcs->commit(&params, fence);
-	if (r)
-		goto error_free;
+	vm->update_funcs->commit(&params, fence);
 
 	if (params.needs_flush) {
 		amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
@@ -1319,9 +1315,7 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	amdgpu_vm_pt_leaves(&params, start, last + 1, NULL, flags);
 
-	r = vm->update_funcs->commit(&params, fence);
-	if (r)
-		goto error_free;
+	vm->update_funcs->commit(&params, fence);
 
 	amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
 	amdgpu_vm_pt_free_list(adev, &params);
@@ -3250,7 +3244,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 
 	amdgpu_vm_pt_leaves(&params, addr, addr + 1, dst, flags);
 
-	r = vm->update_funcs->commit(&params, &vm->last_update);
+	vm->update_funcs->commit(&params, &vm->last_update);
 
 error_end_critical:
 	amdgpu_vm_end_critical(&params);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index d03b9bbe20c7..ec715bcaa0f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -117,8 +117,8 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
  *
  * Make sure that the hardware sees the page table updates.
  */
-static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
-				struct dma_fence **fence)
+static void amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
+				 struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = p->adev;
 
@@ -128,12 +128,10 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 	mb();
 	/* A reset flushed the HDP anyway, so that here can be skipped when a reset is ongoing */
 	if (!down_read_trylock(&adev->reset_domain->sem))
-		return 0;
+		return;
 
 	amdgpu_device_flush_hdp(adev, NULL);
 	up_read(&adev->reset_domain->sem);
-
-	return 0;
 }
 
 const struct amdgpu_vm_update_funcs amdgpu_vm_cpu_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 8a0e5fcbd55b..e056999d8406 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -119,8 +119,8 @@ struct amdgpu_vm_update_funcs {
 	int (*update)(struct amdgpu_vm_update_params *p,
 		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
 		      unsigned count, uint32_t incr, uint64_t flags);
-	int (*commit)(struct amdgpu_vm_update_params *p,
-		      struct dma_fence **fence);
+	void (*commit)(struct amdgpu_vm_update_params *p,
+		       struct dma_fence **fence);
 };
 
 uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index dea80796f139..f9abafef6a4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -433,7 +433,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto exit;
 
-	r = vm->update_funcs->commit(&params, NULL);
+	vm->update_funcs->commit(&params, NULL);
 exit:
 	drm_dev_exit(idx);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 6dc71687c398..0611ae38a9b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -101,11 +101,9 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
  * @p: see amdgpu_vm_update_params definition
  * @fence: resulting fence
  *
- * Returns:
- * Negativ errno, 0 for success.
  */
-static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
-				 struct dma_fence **fence)
+static void amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
+				  struct dma_fence **fence)
 {
 	struct amdgpu_ib *ib = p->job->ibs;
 	struct amdgpu_ring *ring;
@@ -143,7 +141,6 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 		swap(*fence, f);
 	}
 	dma_fence_put(f);
-	return 0;
 }
 
 /**
@@ -247,9 +244,7 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 		ndw -= p->job->ibs->length_dw;
 
 		if (ndw < 32) {
-			r = amdgpu_vm_sdma_commit(p, NULL);
-			if (r)
-				return r;
+			amdgpu_vm_sdma_commit(p, NULL);
 
 			r = amdgpu_vm_sdma_alloc_job(p, count,
 						     AMDGPU_KERNEL_JOB_ID_VM_UPDATE);

-- 
2.47.3

