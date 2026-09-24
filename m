Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3535C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF9A10F62F;
	Thu, 24 Sep 2026 14:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SB2t3yum";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C38910F62F;
 Thu, 24 Sep 2026 14:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=PgCIPXJGgQ1RoakY6skCKlByw6TKSlJVQY3Ukqu3GWw=; b=SB2t3yum/DllcGimybkq52VHZo
 EdOA8Zcp/+/bjcL0KAR9OcP8W/JJk1m/hFuyr4UC3rWyJZpda01R95KY6Bix0SXIlMwoDgNz6ZK8m
 7BivjE5WvRA9Nl5kIps3CHS+BMSOh7ZBgxGMw6YXKNekfd3EoJFIsu23u9kf22/5iLH2wyARlN0db
 3qBjo0Z9IbgGHNtbujYLiAZSR1Gwxz2bt4SNrwS1iF/45q3WeIsCXCRvvW77lw2GUoNZ+qdSa5VkO
 Z5dHPFg1sgtVCnLtn9dFaTEQjwH07M1tp1fWhB0Q3mpSu9Xzct8NqX4K3D2ShXRSPuwg9pR8wBeT0
 RDwgFzZQ==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9kuQ-006hVV-NP; Thu, 24 Sep 2026 16:58:50 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 24 Sep 2026 11:58:40 -0300
Subject: [PATCH] drm/amdgpu: make amdgpu_vm_update_funcs commit return void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-amdgpu_vm_update_funcs_commit_void-v1-1-9ad7a8283920@igalia.com>
X-B4-Tracking: v=1; b=H4sIAKE6tWoC/x3NTQrDIBBA4auEWVdQm6bYq5QiRsd0Fv6gUQohd
 69k+W3eO6BiIazwmg4o2KlSigPiNoH9mrghIzcMksuFK3lnJrgtN92DbtmZHbVv0VZtUwi0657
 Isee6eDE/hFIrhxHKBT39rsn7c55/qbEWJHQAAAA=
X-Change-ID: 20260923-amdgpu_vm_update_funcs_commit_void-7b6f145199b0
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  8 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  8 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 11 +++--------
 5 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bb04101b0fb5..09037df76400 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1027,9 +1027,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			goto error;
 	}
 
-	r = vm->update_funcs->commit(&params, &vm->last_update);
-	if (r)
-		goto error;
+	vm->update_funcs->commit(&params, &vm->last_update);
 
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
@@ -1243,9 +1241,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		start = tmp;
 	}
 
-	r = vm->update_funcs->commit(&params, fence);
-	if (r)
-		goto error_free;
+	vm->update_funcs->commit(&params, fence);
 
 	if (params.needs_flush) {
 		amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d32183cd9e0f..3b237e78c8a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -332,8 +332,8 @@ struct amdgpu_vm_update_funcs {
 	int (*update)(struct amdgpu_vm_update_params *p,
 		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
 		      unsigned count, uint32_t incr, uint64_t flags);
-	int (*commit)(struct amdgpu_vm_update_params *p,
-		      struct dma_fence **fence);
+	void (*commit)(struct amdgpu_vm_update_params *p,
+		       struct dma_fence **fence);
 };
 
 struct amdgpu_vm_fault_info {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index b31ff6f56f0d..5c17946632cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -116,8 +116,8 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
  *
  * Make sure that the hardware sees the page table updates.
  */
-static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
-				struct dma_fence **fence)
+static void amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
+				 struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = p->adev;
 
@@ -127,12 +127,10 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index e43a60d09808..e9622adf1246 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -422,7 +422,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto exit;
 
-	r = vm->update_funcs->commit(&params, NULL);
+	vm->update_funcs->commit(&params, NULL);
 exit:
 	drm_dev_exit(idx);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 50cc0779c340..9e3ade3cd646 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -100,11 +100,9 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
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
@@ -142,7 +140,6 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 		swap(*fence, f);
 	}
 	dma_fence_put(f);
-	return 0;
 }
 
 /**
@@ -246,9 +243,7 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 		ndw -= p->job->ibs->length_dw;
 
 		if (ndw < 32) {
-			r = amdgpu_vm_sdma_commit(p, NULL);
-			if (r)
-				return r;
+			amdgpu_vm_sdma_commit(p, NULL);
 
 			r = amdgpu_vm_sdma_alloc_job(p, count,
 						     AMDGPU_KERNEL_JOB_ID_VM_UPDATE);

---
base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
change-id: 20260923-amdgpu_vm_update_funcs_commit_void-7b6f145199b0

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

