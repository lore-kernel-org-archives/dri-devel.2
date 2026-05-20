Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54824CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15EC10EFF6;
	Wed, 20 May 2026 10:17:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XY/yDG76";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2439310EFEC;
 Wed, 20 May 2026 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779272237; x=1810808237;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2+TZnBOjtxQ+7sgnE4dyyDqIf36lmebFPCa1N4eu7nA=;
 b=XY/yDG76HhazP5bVOpuXsrikWcURtLBmuqdJ4pgdY0xsxDCg2oE2uz+H
 uR+gotMdzxPeNVJlmLMLvp4YxjEm7TsNqdLAw+WfZBDvAG9Btlyz79IfZ
 uuOdudr6roI1KC4/4r2gg8y5C5LXZY+J8/YSt0+QmVgJDawkIzHq3FTwU
 kgI7pQba/sI51NHoQ+s0sVtprynYjJugQ5WlU75H4KxT2yusStXjINrQK
 V4aDJqjbAy0KIpkMtT2KpsEa8wMwQk4lLQA3JUJjmvyoGrE8o3BRpk3pu
 dlkjmZo+aGnJFqDZjgGc9+bklAelWcWlyZSV/FBBpl+wcuLYROrpYp4bA w==;
X-CSE-ConnectionGUID: 1vdvtZ1MR42i3Atr0LwAcQ==
X-CSE-MsgGUID: 7WH3u+EVRYagfDo9AX3fJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="102843277"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="102843277"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:17:16 -0700
X-CSE-ConnectionGUID: 8nMwht/ST7eAzWXdyzN2Eg==
X-CSE-MsgGUID: D9rW5Y7HQOuRjiNm7VZm7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="244114053"
Received: from vpanait-mobl.ger.corp.intel.com (HELO fedora) ([10.245.245.175])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:17:11 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Alice Ryhl <aliceryhl@google.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: [PATCH v2 1/4] drm/exec: Remove the index parameter from
 drm_exec_for_each_locked_obj[_reverse]
Date: Wed, 20 May 2026 12:16:13 +0200
Message-ID: <20260520101616.41284-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520101616.41284-1-thomas.hellstrom@linux.intel.com>
References: <20260520101616.41284-1-thomas.hellstrom@linux.intel.com>
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

Nobody makes any use of it. Possible internal future users can
instead use the _index variable. External users shouldn't use
it since the array it's pointing into is internal drm_exec state.

v2:
- Use a unique id for the loop variable (Christian)

Assisted-by: GitHub Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  9 +++------
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  3 +--
 drivers/gpu/drm/drm_exec.c                    |  6 ++----
 drivers/gpu/drm/drm_gpuvm.c                   |  3 +--
 drivers/gpu/drm/xe/xe_vm.c                    |  3 +--
 include/drm/drm_exec.h                        | 20 +++++++++++--------
 6 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 32af8cce3df8..97a851ae7bd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -850,7 +850,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *obj;
-	unsigned long index;
 	unsigned int i;
 	int r;
 
@@ -961,7 +960,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		goto out_free_user_pages;
 	}
 
-	drm_exec_for_each_locked_object(&p->exec, index, obj) {
+	drm_exec_for_each_locked_object(&p->exec, obj) {
 		r = amdgpu_cs_bo_validate(p, gem_to_amdgpu_bo(obj));
 		if (unlikely(r))
 			goto out_free_user_pages;
@@ -1201,7 +1200,6 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 	struct drm_gpu_scheduler *sched;
 	struct drm_gem_object *obj;
 	struct dma_fence *fence;
-	unsigned long index;
 	unsigned int i;
 	int r;
 
@@ -1212,7 +1210,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 		return r;
 	}
 
-	drm_exec_for_each_locked_object(&p->exec, index, obj) {
+	drm_exec_for_each_locked_object(&p->exec, obj) {
 		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 
 		struct dma_resv *resv = bo->tbo.base.resv;
@@ -1281,7 +1279,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	struct amdgpu_job *leader = p->gang_leader;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *gobj;
-	unsigned long index;
 	unsigned int i;
 	uint64_t seq;
 	int r;
@@ -1331,7 +1328,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	}
 
 	p->fence = dma_fence_get(&leader->base.s_fence->finished);
-	drm_exec_for_each_locked_object(&p->exec, index, gobj) {
+	drm_exec_for_each_locked_object(&p->exec, gobj) {
 
 		ttm_bo_move_to_lru_tail_unlocked(&gem_to_amdgpu_bo(gobj)->tbo);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 4c5e38dea4c2..f6b7522c3c82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -121,7 +121,6 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
 {
 	struct amdgpu_eviction_fence *ev_fence;
 	struct drm_gem_object *obj;
-	unsigned long index;
 
 	/* Create and initialize a new eviction fence */
 	ev_fence = kzalloc_obj(*ev_fence);
@@ -140,7 +139,7 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	evf_mgr->ev_fence = &ev_fence->base;
 
 	/* And add it to all existing BOs */
-	drm_exec_for_each_locked_object(exec, index, obj) {
+	drm_exec_for_each_locked_object(exec, obj) {
 		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 
 		amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 8d0601400182..746210f3f6c2 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -24,7 +24,6 @@
  *
  *	struct drm_gem_object *obj;
  *	struct drm_exec exec;
- *	unsigned long index;
  *	int ret;
  *
  *	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
@@ -40,7 +39,7 @@
  *			goto error;
  *	}
  *
- *	drm_exec_for_each_locked_object(&exec, index, obj) {
+ *	drm_exec_for_each_locked_object(&exec, obj) {
  *		dma_resv_add_fence(obj->resv, fence, DMA_RESV_USAGE_READ);
  *		...
  *	}
@@ -56,9 +55,8 @@
 static void drm_exec_unlock_all(struct drm_exec *exec)
 {
 	struct drm_gem_object *obj;
-	unsigned long index;
 
-	drm_exec_for_each_locked_object_reverse(exec, index, obj) {
+	drm_exec_for_each_locked_object_reverse(exec, obj) {
 		dma_resv_unlock(obj->resv);
 		drm_gem_object_put(obj);
 	}
diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 83020b6cf9ba..c422c5af1f4b 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1557,9 +1557,8 @@ drm_gpuvm_resv_add_fence(struct drm_gpuvm *gpuvm,
 			 enum dma_resv_usage extobj_usage)
 {
 	struct drm_gem_object *obj;
-	unsigned long index;
 
-	drm_exec_for_each_locked_object(exec, index, obj) {
+	drm_exec_for_each_locked_object(exec, obj) {
 		dma_resv_assert_held(obj->resv);
 		dma_resv_add_fence(obj->resv, fence,
 				   drm_gpuvm_is_extobj(gpuvm, obj) ?
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index b01f31ed4417..080c2fff0e95 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -373,7 +373,6 @@ int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
 			  unsigned int num_fences)
 {
 	struct drm_gem_object *obj;
-	unsigned long index;
 	int ret;
 
 	do {
@@ -386,7 +385,7 @@ int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
 			return ret;
 	} while (!list_empty(&vm->gpuvm.evict.list));
 
-	drm_exec_for_each_locked_object(exec, index, obj) {
+	drm_exec_for_each_locked_object(exec, obj) {
 		ret = dma_resv_reserve_fences(obj->resv, num_fences);
 		if (ret)
 			return ret;
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index aa786b828a0a..dee6ebdbe416 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -65,31 +65,35 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
 	return index < exec->num_objects ? exec->objects[index] : NULL;
 }
 
+/* Helper for drm_exec_for_each_locked_object(). Internal use only. */
+#define __drm_exec_for_each_locked_object(exec, obj, __index)		\
+	for (unsigned long __index = 0; ((obj) = drm_exec_obj(exec, __index)); ++__index)
 /**
  * drm_exec_for_each_locked_object - iterate over all the locked objects
  * @exec: drm_exec object
- * @index: unsigned long index for the iteration
  * @obj: the current GEM object
  *
  * Iterate over all the locked GEM objects inside the drm_exec object.
  */
-#define drm_exec_for_each_locked_object(exec, index, obj)		\
-	for ((index) = 0; ((obj) = drm_exec_obj(exec, index)); ++(index))
+#define drm_exec_for_each_locked_object(exec, obj)			\
+	__drm_exec_for_each_locked_object(exec, obj, __UNIQUE_ID(drm_exec))
 
+/* Helper for drm_exec_for_each_locked_object_reverse(). Internal use only. */
+#define __drm_exec_for_each_locked_object_reverse(exec, obj, __index)	\
+	for (unsigned long __index = (exec)->num_objects - 1;		\
+	     ((obj) = drm_exec_obj(exec, __index)); --__index)
 /**
  * drm_exec_for_each_locked_object_reverse - iterate over all the locked
  * objects in reverse locking order
  * @exec: drm_exec object
- * @index: unsigned long index for the iteration
  * @obj: the current GEM object
  *
  * Iterate over all the locked GEM objects inside the drm_exec object in
- * reverse locking order. Note that @index may go below zero and wrap,
+ * reverse locking order. Note that the internal index may wrap around,
  * but that will be caught by drm_exec_obj(), returning a NULL object.
  */
-#define drm_exec_for_each_locked_object_reverse(exec, index, obj)	\
-	for ((index) = (exec)->num_objects - 1;				\
-	     ((obj) = drm_exec_obj(exec, index)); --(index))
+#define drm_exec_for_each_locked_object_reverse(exec, obj)		\
+	__drm_exec_for_each_locked_object_reverse(exec, obj, __UNIQUE_ID(drm_exec))
 
 /**
  * drm_exec_until_all_locked - loop until all GEM objects are locked
-- 
2.54.0

