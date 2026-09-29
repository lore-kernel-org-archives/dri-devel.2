Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BBACA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 20:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF3C310F08D;
	Tue, 29 Sep 2026 20:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cPqlDVUc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17AB010F08D;
 Tue, 29 Sep 2026 20:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=iC0rPzMQI+Iz27Lx6x02hGWhWmmmEWXNSGie2PKlBYE=; b=cPqlDVUcympBIusM9qhmUz/CeO
 iSDFbC2JyIdD7wDB+nIDtzvJNCuk4Mb/ZQYgNwCY1hwQmBR/rpa9THGKBfyUTRAKvDJTZjRMAkjEg
 HZOmj6FEkmqW62os2WngSxwLP2U6t5ZjsnR2g0tfSj9fu5qohkm7+M/N+uo70Ko/X3zt8AbW3l6AC
 kwmd32f1xYSQNZcwLK+6xYfm8XPajbaddi6sCGNdOnVdemItb0o3pw0J3TM9kmm12jhtvwVIjblXE
 4zvcgqyIhTUfg0SwiMbJRFwXMZdppebZNcz6PROq81BMdKWb8VGzKySIWOeiLRRYGAoYnF+g5Kddd
 KTp+bkug==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xBeWy-0096Z5-Uz; Tue, 29 Sep 2026 22:34:29 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Tue, 29 Sep 2026 17:34:05 -0300
Subject: [PATCH 2/2] drm/amdgpu: free job when amdgpu_vm_ptes_update fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-amdgpu_vm_update_funcs_abort-v1-2-a8072140a7db@igalia.com>
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

When amdgpu_vm_update_range hits a failure at amdgpu_vm_ptes_update, it
will skip calling update_funcs commit, which might lead to a memory
leak.

[ 2877.877264] kmemleak: unreferenced object 0xffff89b1f3cf0800 (size 1024):
[ 2877.877273] kmemleak:   comm "vm_always_valid", pid 3027, jiffies 4295714403
[ 2877.877275] kmemleak:   hex dump (first 32 bytes):
[ 2877.877277] kmemleak:     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[ 2877.877279] kmemleak:     00 03 da 52 b1 89 ff ff 38 25 5f cb b1 89 ff ff  ...R....8%_.....
[ 2877.877280] kmemleak:   backtrace (crc d52b9041):
[ 2877.877282] kmemleak:     __kmalloc_noprof+0x4b3/0x770
[ 2877.877288] kmemleak:     amdgpu_job_alloc+0x69/0x280 [amdgpu]
[ 2877.877668] kmemleak:     amdgpu_job_alloc_with_ib+0x55/0xf0 [amdgpu]
[ 2877.878023] kmemleak:     amdgpu_vm_sdma_prepare+0x4b/0xa0 [amdgpu]
[ 2877.878350] kmemleak:     amdgpu_vm_update_range+0x24f/0x940 [amdgpu]
[ 2877.878668] kmemleak:     amdgpu_vm_clear_freed+0x13b/0x290 [amdgpu]
[ 2877.878983] kmemleak:     amdgpu_gem_object_close+0x1ac/0x270 [amdgpu]
[ 2877.879300] kmemleak:     drm_gem_object_release_handle+0x35/0xd0
[ 2877.879305] kmemleak:     idr_for_each+0x70/0xe0
[ 2877.879310] kmemleak:     drm_gem_release+0x23/0x30
[ 2877.879311] kmemleak:     drm_file_free+0x217/0x2a0
[ 2877.879314] kmemleak:     drm_release+0x61/0xe0
[ 2877.879317] kmemleak:     amdgpu_drm_release+0x62/0xd0 [amdgpu]
[ 2877.879630] kmemleak:     __fput+0xfb/0x2d0
[ 2877.879634] kmemleak:     __x64_sys_close+0x3d/0x80
[ 2877.879637] kmemleak:     do_syscall_64+0x12d/0x6c0

So introduce a amdgpu_vm_update_funcs abort hook that is empty for CPU
and frees the job for SDMA and call it on any error path after the
prepare hook has been successfully called.

Fixes: 81417bea8755 ("drm/amdgpu: explicitly sync VM update to PDs/PTs")
Fixes: c3546695830e ("drm/amdgpu: use the new VM backend for PTEs")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c      |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c     |  9 ++++++++-
 5 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 201e3e114f07..be908ef3fe80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1021,7 +1021,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 		r = amdgpu_vm_pde_update(&params, entry);
 		if (r)
-			goto error;
+			goto error_abort;
 	}
 
 	vm->update_funcs->commit(&params, &vm->last_update);
@@ -1033,6 +1033,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 				 vm_status)
 		amdgpu_vm_bo_idle(entry);
 
+error_abort:
+	if (r)
+		vm->update_funcs->abort(&params);
 error:
 	drm_dev_exit(idx);
 	return r;
@@ -1234,7 +1237,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		tmp = start + num_entries;
 		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
 		if (r)
-			goto error_free;
+			goto error_abort;
 
 		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
 		start = tmp;
@@ -1249,6 +1252,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	amdgpu_vm_pt_free_list(adev, &params);
 
+error_abort:
+	if (r)
+		vm->update_funcs->abort(&params);
 error_free:
 	kfree(tlb_cb);
 	amdgpu_vm_end_critical(&params);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index ec715bcaa0f2..8565a2899e08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -134,9 +134,14 @@ static void amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 	up_read(&adev->reset_domain->sem);
 }
 
+static void amdgpu_vm_cpu_abort(struct amdgpu_vm_update_params *p)
+{
+}
+
 const struct amdgpu_vm_update_funcs amdgpu_vm_cpu_funcs = {
 	.map_table = amdgpu_vm_cpu_map_table,
 	.prepare = amdgpu_vm_cpu_prepare,
 	.update = amdgpu_vm_cpu_update,
-	.commit = amdgpu_vm_cpu_commit
+	.commit = amdgpu_vm_cpu_commit,
+	.abort = amdgpu_vm_cpu_abort,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index e056999d8406..3d8cbd4530ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -121,6 +121,7 @@ struct amdgpu_vm_update_funcs {
 		      unsigned count, uint32_t incr, uint64_t flags);
 	void (*commit)(struct amdgpu_vm_update_params *p,
 		       struct dma_fence **fence);
+	void (*abort)(struct amdgpu_vm_update_params *p);
 };
 
 uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f9abafef6a4f..e98a7a86bf3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -426,14 +426,17 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	r = vm->update_funcs->prepare(&params, NULL,
 				      AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR);
 	if (r)
-		goto exit;
+		goto exit_abort;
 
 	flags = amdgpu_vm_pt_clear_flags(adev, vm, level);
 	r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0, flags);
 	if (r)
-		goto exit;
+		goto exit_abort;
 
 	vm->update_funcs->commit(&params, NULL);
+exit_abort:
+	if (r)
+		vm->update_funcs->abort(&params);
 exit:
 	drm_dev_exit(idx);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 0611ae38a9b5..7c48a370a6bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -298,9 +298,16 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 	return 0;
 }
 
+static void amdgpu_vm_sdma_abort(struct amdgpu_vm_update_params *p)
+{
+	if (p->job)
+		amdgpu_job_free(p->job);
+}
+
 const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs = {
 	.map_table = amdgpu_vm_sdma_map_table,
 	.prepare = amdgpu_vm_sdma_prepare,
 	.update = amdgpu_vm_sdma_update,
-	.commit = amdgpu_vm_sdma_commit
+	.commit = amdgpu_vm_sdma_commit,
+	.abort = amdgpu_vm_sdma_abort,
 };

-- 
2.47.3

