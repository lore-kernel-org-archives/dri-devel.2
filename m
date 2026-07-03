Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CE9C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441EB10F7FE;
	Fri,  3 Jul 2026 13:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Eum6qo8r";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066A910F7E7;
 Fri,  3 Jul 2026 13:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783084021; x=1814620021;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XSSDJV30Wd36wi5sy2k20vmQlCp9wnUmTE7Bqh02MqY=;
 b=Eum6qo8rkSNINZ7E0qdUY9xCF2Wem9GMEHr/6LE1s5qnXnq4CXKTFnpL
 qV1H+0qq+c8TRHdtQ0Mgqbd9Yai4ZZ4wDa/CanOuuLLXndXzCJntxkwLW
 Wpg0i3ltwr3Vmp5WmNeNc7EOmkPPKuC5f0cz1Om/UyBklb4y4mrpmCWcx
 OabQXcGvRqsjkTv3O/fO7/G/Fu4je4u8ysbe/L2e3t/Ot5hzlKwE8fHni
 ih8lrxjWy6KyN0QYGHgxYnhGkvmDRYPict+zpM+YLtsN53ULOf1UH4+8/
 Eo0Obq8NdwsRVdKnbhA2zqQSyemiZ9oAGAFyuAWp21Du9pOpErCt39p6O A==;
X-CSE-ConnectionGUID: K5tctkTyQ4ie+vtxkMyfeA==
X-CSE-MsgGUID: skFbI7aHSxSZI3uEW/9Zew==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83702363"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="83702363"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 06:07:00 -0700
X-CSE-ConnectionGUID: dh7u1I78TRa7zRw2Z+fQVA==
X-CSE-MsgGUID: DgTimVrMQFGdFTFjNIYARg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="283199605"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.245.146])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 06:06:56 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>,
 =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/6] drm/amdgpu: Wire up dmem cgroup reclaim for VRAM
 manager
Date: Fri,  3 Jul 2026 15:05:41 +0200
Message-ID: <20260703130541.2686-7-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
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

Register the VRAM manager with the dmem cgroup reclaim infrastructure
so that lowering dmem.max below current VRAM usage triggers TTM
eviction rather than failing with -EBUSY.

Guard place->flags in amdgpu_ttm_bo_eviction_valuable() against NULL,
as the TTM reclaim path passes a NULL place in cgroup drain mode.

Use drmm_cgroup_register_region() so that the region is automatically
unregistered at DRM device release, after drm_dev_unplug() has already
made drm_dev_enter() return false.  The drm_dev_enter/exit guard in the
reclaim callback ensures no reclaim work touches the TTM manager after
driver unbind, closing the window between vram_mgr_fini() (called from
drm_driver.release) and the drmm cleanup that unregisters the region.

v3:
- Rebased on fix for uninitialized list and buddy allocator on the
  drmm_cgroup_register_region() error path.

v5:
- Rebased on the introduction of struct dmem_cgroup_init.
- Clear the reclaim callback in amdgpu_vram_mgr_fini() to prevent
  use-after-free if cgroup reclaim is triggered after driver unbind
  while userspace holds an open DRM file descriptor. (Sashiko-bot)
- Switch from drmm_cgroup_register_region() to the raw
  dmem_cgroup_register_region() and store the region in
  amdgpu_vram_mgr.cg_region. Call dmem_cgroup_unregister_region()
  in amdgpu_vram_mgr_fini() after ttm_resource_manager_evict_all()
  to drain in-flight reclaim callbacks, and clear man->cg afterwards.
  This is required because amdgpu's vram manager fini is called
  explicitly during driver unbind, which may precede the DRM device
  release and thus precede any drmm-based cleanup. (Sashiko-bot)

v6:
- Fix mgr->cg_region never being assigned, so
  dmem_cgroup_unregister_region() in fini silently no-ops on NULL
  and leaks the region. (Sashiko-bot)
- Reorder fini to call set_used(false) and evict_all() before
  dmem_cgroup_unregister_region(), so ttm_resource_free() can
  uncharge via man->cg during eviction; clear man->cg after
  unregister. (Sashiko-bot)

v7:
- Move dmem_cgroup_unregister_region() before the early return on
  evict_all() failure; not doing so leaves a dangling reclaim callback
  pointing to the partially-torn-down VRAM manager, causing a
  use-after-free when the cgroup later triggers reclaim. (Sashiko-bot)
- Switch back to drmm_cgroup_register_region() with a drm_dev_enter/
  exit guard in the reclaim callback (matching xe), rather than manual
  register/unregister.  drm_dev_unplug() fires before vram_mgr_fini(),
  so drm_dev_enter() returning false prevents any reclaim from touching
  the manager during teardown.  This also fixes the "vram" name
  collision on multi-GPU systems, since drmm_cgroup_register_region()
  automatically prefixes with "drm/<pci-addr>/". (Sashiko-bot)

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 37 +++++++++++++++++---
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 025625e7e800..58bb21451826 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1507,7 +1507,7 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	dma_resv_for_each_fence(&resv_cursor, bo->base.resv,
 				DMA_RESV_USAGE_BOOKKEEP, f) {
 		if (amdkfd_fence_check_mm(f, current->mm) &&
-		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
+		    !(place && (place->flags & TTM_PL_FLAG_CONTIGUOUS)))
 			return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 08f05c3aed1d..9b9d738ba794 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -906,6 +906,28 @@ static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
 	.debug	= amdgpu_vram_mgr_debug
 };
 
+static const struct dmem_cgroup_ops amdgpu_vram_mgr_dmem_ops;
+
+static int amdgpu_vram_mgr_dmem_reclaim(struct dmem_cgroup_pool_state *pool,
+					u64 target_bytes, void *priv)
+{
+	struct ttm_resource_manager *man = priv;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(man->bdev);
+	int ret, idx;
+
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		return -ENODEV;
+
+	ret = ttm_resource_manager_dmem_reclaim(pool, target_bytes, priv);
+
+	drm_dev_exit(idx);
+	return ret;
+}
+
+static const struct dmem_cgroup_ops amdgpu_vram_mgr_dmem_ops = {
+	.reclaim = amdgpu_vram_mgr_dmem_reclaim,
+};
+
 /**
  * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
  *
@@ -917,6 +939,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
 	struct ttm_resource_manager *man = &mgr->manager;
+	struct dmem_cgroup_region *cg;
 	int err;
 
 	ttm_resource_manager_init(man, &adev->mman.bdev,
@@ -933,12 +956,16 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	if (err)
 		return err;
 
-	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram",
-					      &(struct dmem_cgroup_init){
+	cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram",
+					 &(struct dmem_cgroup_init){
 						.size = adev->gmc.real_vram_size,
-					      });
-	if (IS_ERR(man->cg))
-		return PTR_ERR(man->cg);
+						.ops = &amdgpu_vram_mgr_dmem_ops,
+						.reclaim_priv = man,
+					 });
+	if (IS_ERR(cg))
+		return PTR_ERR(cg);
+
+	ttm_resource_manager_set_dmem_region(man, cg);
 
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
-- 
2.54.0

