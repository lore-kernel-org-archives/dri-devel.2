Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E29C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3156510F05B;
	Thu, 23 Jul 2026 10:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="f8MFlBfK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8A110F058;
 Thu, 23 Jul 2026 10:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784801058; x=1816337058;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/k5TklTHou5l2dBOb2sTQtk7OujtNVKbrhR2IlqNeZ4=;
 b=f8MFlBfKZy84K7ABB6MgiYi7Os/wJwwvps0L9N47wBXklxyHJZH3YjhE
 VLIDGeYZ263p0N/V3yQDA4jsKxXDR5Kq/jQSr4foSpnu7oV4nCrE0pjEn
 YjdlFevwcoUxFPsZaLA7x65Chcy21vhLW6K0vTsGjUl8tmZ7BL44+zXpR
 4ePGTR+/HIMV9/dAOXmteapzGsFK3roB/+U7tXdxzaf2YqGYI9asp0XQC
 LrH1BQRWJQYnMQ6VuaRoXUihOkeh0EydAR/g/lLbkAh/jzd8lYEIjw/cu
 kCLgepsCqBBUIjtMt6oUt8Lg5CbAwWKHxD2D3z9IRhUR+UROR3M6eX7V3 w==;
X-CSE-ConnectionGUID: KATnO9dfSt+Sl2SmCoIRcA==
X-CSE-MsgGUID: /zoggW/CRi6P8sGv9Oe+Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="87991833"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="87991833"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:04:17 -0700
X-CSE-ConnectionGUID: /jUMWDEQRdmamFTezA5kHQ==
X-CSE-MsgGUID: JR7PUPQPQTijYEq6o8dobg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="254984847"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO fedora)
 ([10.245.244.122])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:04:12 -0700
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
Subject: [PATCH v8 0/6] Add reclaim to the dmem cgroup controller
Date: Thu, 23 Jul 2026 12:03:44 +0200
Message-ID: <20260723100350.16895-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.55.0
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

When writing a "max" limit lower than the current usage, the
existing code silently failed. This series aims to improve
on that by returning -EBUSY on failure and also attempt
to synchronously reclaim device memory to push the usage
under the new max limit to avoid the error.

Patch 1 fixes a pre-existing amdgpu_vram_mgr_init() error path
Patch 2 introduces struct dmem_cgroup_init for extensible region
      registration.
Patch 3 implements and documents a reclaim callback interface
      for the dmem controller.
Patch 4 implements a TTM reclaim callback.
Patches 5-6 hook up the reclaim callback to the dmem cgroup-aware
      drivers xe and amdgpu.

v2:
- Remove the error propagation that was in a previous series (Maarten)
- A number of updates in patch 1. See its commit message for
  details (Maarten)

v3:
- Add patch 1 fixing a pre-existing amdgpu_vram_mgr_init() error path
  bug where drmm_cgroup_register_region() was called before
  INIT_LIST_HEAD() and gpu_buddy_init(), causing a kernel panic on
  failure. (Sashiko-bot)
- Use an rwsem to protect reclaim callback registration and region
  unregister against concurrent reclaim invocations. (Sashiko-bot)
- Fix ttm_resource_manager_set_dmem_region() storing an error pointer
  in man->cg unconditionally. (Sashiko-bot)
- Fix kernel-doc function name format for ttm_bo_evict_cgroup() and
  ttm_resource_manager_set_dmem_region().

v4:
- Rebased on drm-tip; dropped the XE_PL_STOLEN guard in the xe patch
  as stolen memory uses a separate TTM manager.

v5:
- Add patch 2 introducing struct dmem_cgroup_init to make the
  dmem_cgroup_register_region() API extensible without adding positional
  arguments in the future.
- Use nonblock=true in reset_all_resource_limits() to avoid sleeping
  inside rcu_read_lock() in dmemcs_offline(). (Sashiko-bot)
- Compare usage against the truncated limit stored in cnt.max, not the
  original u64. (Sashiko-bot)
- Use DMEM_MAX_RECLAIM_RETRIES (16) retry budget instead of 5, matching
  the memcg controller; only -ENOSPC (no progress) counts against the
  budget, other errors abort immediately.
- Handle NULL region in ttm_resource_manager_set_dmem_region() to clear
  the reclaim callback, preventing use-after-free when the manager is
  torn down while the dmem region outlives it. (Sashiko-bot)
- Return 0 on any eviction progress; reserve -ENOSPC for zero progress.
- Clear the reclaim callback in xe and amdgpu fini paths to prevent
  use-after-free after driver unbind with open DRM file descriptors.
  (Sashiko-bot)
- Register xe fini devres action before drmm_cgroup_register_region()
  so LIFO teardown runs unregister first, draining callbacks before the
  manager is destroyed. (Sashiko-bot)
- Switch amdgpu to explicit dmem_cgroup_unregister_region() at the top
  of amdgpu_vram_mgr_fini() before any manager teardown, since amdgpu's
  fini is called explicitly during driver unbind before drmm cleanup.
  (Sashiko-bot)
- Wrap the xe reclaim callback with drm_dev_enter()/drm_dev_exit() to
  prevent TTM reclaim from running after driver unbind.

v6:
- Move the ops check inside down_read() in set_resource_max(), guarded
  by region->unregistered, to close a UAF race against
  dmem_cgroup_unregister_region(). (Sashiko-bot)
- Fix dmem_cgroup_ops->reclaim docstring: -ENOSPC is retried up to
  DMEM_MAX_RECLAIM_RETRIES times, not an immediate stop. (Sashiko-bot)
- Fix mgr->cg_region never being assigned in amdgpu_vram_mgr_init(),
  causing dmem_cgroup_unregister_region() in fini to silently no-op.
  (Sashiko-bot)
- Reorder amdgpu_vram_mgr_fini() to call set_used(false) and
  evict_all() before dmem_cgroup_unregister_region(), so
  ttm_resource_free() can uncharge via man->cg during eviction; clear
  man->cg after unregister. (Sashiko-bot)

v7:
- Replace the per-region rw_semaphore with a static SRCU domain
  (dmemcg_srcu). SRCU is a better fit: it avoids per-region lock
  overhead on every reclaim call, and synchronize_srcu() at unregister
  time is a rare, shutdown-time operation. (Maarten)
- Trim in-function comments to focus on what rather than how.
- Switch back to drmm_cgroup_register_region() with a drm_dev_enter/
  exit guard in the reclaim callback (matching xe), rather than manual
  register/unregister.  drm_dev_unplug() fires before vram_mgr_fini(),
  so drm_dev_enter() returning false prevents any reclaim from touching
  the manager during teardown.  This also fixes the "vram" name
  collision on multi-GPU systems, since drmm_cgroup_register_region()
  automatically prefixes with "drm/<pci-addr>/". (Sashiko-bot)

v8:
- Fix ttm_resource_manager_set_dmem_region() using IS_ERR_OR_NULL(),
  which skipped the assignment for a NULL region and thus never cleared
  man->cg. Use IS_ERR() so that a NULL region detaches the region as the
  kernel-doc and the v5 changelog intended. (Sashiko-bot)
- Move the amdgpu dmem cgroup region teardown back into
  amdgpu_vram_mgr_fini() with an explicit dmem_cgroup_unregister_region()
  after evict_all(), keeping the drm_dev_enter() guard. The v7 drmm-only
  approach left a use-after-free on the probe-error teardown path, where
  drm_dev_unplug() is never called so the drm_dev_enter() guard stays
  open while drm_driver.release destroys the manager before the drmm
  action unregisters the region. (Sashiko-bot)

User-space tests are at
https://patchwork.freedesktop.org/series/163935/

Test-with: 20260428065411.4222-1-thomas.hellstrom@linux.intel.com

Thomas Hellström (6):
  drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()
  cgroup/dmem: Introduce struct dmem_cgroup_init for region
    initialization
  cgroup/dmem: Add reclaim callback for lowering max below current usage
  drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem
    controller
  drm/xe: Wire up dmem cgroup reclaim for VRAM manager
  drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 52 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |  3 +
 drivers/gpu/drm/drm_drv.c                    |  8 +-
 drivers/gpu/drm/ttm/ttm_bo.c                 | 95 +++++++++++++++++++-
 drivers/gpu/drm/ttm/ttm_bo_util.c            |  3 +-
 drivers/gpu/drm/ttm/ttm_resource.c           | 52 +++++++++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c         | 53 +++++++++--
 include/drm/drm_drv.h                        |  4 +-
 include/drm/ttm/ttm_bo.h                     | 10 +++
 include/drm/ttm/ttm_resource.h               |  7 ++
 include/linux/cgroup_dmem.h                  | 38 +++++++-
 kernel/cgroup/dmem.c                         | 90 +++++++++++++++----
 13 files changed, 380 insertions(+), 37 deletions(-)

-- 
2.55.0

