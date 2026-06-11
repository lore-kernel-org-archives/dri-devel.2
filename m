Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0DECD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E58D10EF7C;
	Thu, 11 Jun 2026 14:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IAsd6abO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC2C10EF51;
 Thu, 11 Jun 2026 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781187815; x=1812723815;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=awhOvbKuIT8kazUlxYlfnhoiupJ7K7wXsTHZirjffKQ=;
 b=IAsd6abOryFZMYHzNZocqrIcTXvSkE14kuXvNaVtDRBNCipFP1ZaiXEk
 3SeZMMe55JcVQeBQB6lxbwnXu9X/34BnkN9DjYdDyPeBS649vFMy3PMJB
 K7FwW0vJmUfPSBXCAFK84j408iTAn4jJwTR1TXCSPJROfXqb+ElsROpPU
 mwL39xwoSf4ToeF24pFu9uSYMgDDpB4NN2NODQppbYFDfOMl/dcPUzLKh
 H3e5lIc1VumsFoDCfL9dMlqq3Yb4x1RMVePsaT5vr9VxuPWoASsbSjkw3
 +HzMpGmFuCzgGDqf7n+5CkGUI/qMXsYXEbDAS9ZX6xhtez33+PY2qv7+I g==;
X-CSE-ConnectionGUID: BHRFwIDwS5exlJ979ea/jQ==
X-CSE-MsgGUID: u9+eTrt6R7u/xpDTEY9csQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81983467"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="81983467"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 07:23:34 -0700
X-CSE-ConnectionGUID: 7XeEKXDxQ/a37dPKAsAtfw==
X-CSE-MsgGUID: zK/aDci3QaeXjSjER8BUcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="284574385"
Received: from amilburn-desk.amilburn-desk (HELO fedora) ([10.245.244.169])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 07:23:30 -0700
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
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] drm/amdgpu: Wire up dmem cgroup reclaim for VRAM
 manager
Date: Thu, 11 Jun 2026 16:22:42 +0200
Message-ID: <20260611142242.2529-7-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611142242.2529-1-thomas.hellstrom@linux.intel.com>
References: <20260611142242.2529-1-thomas.hellstrom@linux.intel.com>
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
  amdgpu_vram_mgr.cg_region. Explicitly call
  dmem_cgroup_unregister_region() at the top of amdgpu_vram_mgr_fini()
  before any manager teardown, draining in-flight reclaim callbacks via
  the rwsem before the manager is destroyed. This is required because
  amdgpu's vram manager fini is called explicitly during driver unbind,
  which may precede the DRM device release and thus precede any
  drmm-based cleanup. (Sashiko-bot)

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 29 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |  2 ++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2740de94e93c..8cbcd33f51a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1488,7 +1488,7 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	dma_resv_for_each_fence(&resv_cursor, bo->base.resv,
 				DMA_RESV_USAGE_BOOKKEEP, f) {
 		if (amdkfd_fence_check_mm(f, current->mm) &&
-		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
+		    !(place && (place->flags & TTM_PL_FLAG_CONTIGUOUS)))
 			return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 08f05c3aed1d..ee98b963e84a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -906,6 +906,10 @@ static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
 	.debug	= amdgpu_vram_mgr_debug
 };
 
+static const struct dmem_cgroup_ops amdgpu_vram_mgr_dmem_ops = {
+	.reclaim = ttm_resource_manager_dmem_reclaim,
+};
+
 /**
  * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
  *
@@ -917,6 +921,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
 	struct ttm_resource_manager *man = &mgr->manager;
+	struct dmem_cgroup_region *cg;
 	int err;
 
 	ttm_resource_manager_init(man, &adev->mman.bdev,
@@ -933,12 +938,15 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	if (err)
 		return err;
 
-	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram",
-					      &(struct dmem_cgroup_init){
-						.size = adev->gmc.real_vram_size,
-					      });
-	if (IS_ERR(man->cg))
-		return PTR_ERR(man->cg);
+	cg = dmem_cgroup_register_region(&(struct dmem_cgroup_init){
+					     .size = adev->gmc.real_vram_size,
+					     .ops = &amdgpu_vram_mgr_dmem_ops,
+					     .reclaim_priv = man,
+					 }, "vram");
+	if (IS_ERR(cg))
+		return PTR_ERR(cg);
+
+	ttm_resource_manager_set_dmem_region(man, cg);
 
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
@@ -960,6 +968,15 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
 	int ret;
 	struct amdgpu_vram_reservation *rsv, *temp;
 
+	/*
+	 * Drain any in-flight dmem cgroup reclaim callbacks and remove the
+	 * region from the global list before tearing down the manager.
+	 * This must happen first so no reclaim callback can access the
+	 * manager after this point.
+	 */
+	dmem_cgroup_unregister_region(mgr->cg_region);
+	mgr->cg_region = NULL;
+
 	ttm_resource_manager_set_used(man, false);
 
 	ret = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
index 429a21a2e9b2..07103cddb335 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
@@ -36,6 +36,8 @@ struct amdgpu_vram_mgr {
 	atomic64_t vis_usage;
 	u64 default_page_size;
 	struct list_head allocated_vres_list;
+	/** @cg_region: dmem cgroup region for VRAM; unregistered in fini. */
+	struct dmem_cgroup_region *cg_region;
 };
 
 struct amdgpu_vres_task {
-- 
2.54.0

