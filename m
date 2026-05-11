Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15727CD4840
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 17:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C1210E819;
	Mon, 11 May 2026 17:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GpjpJikG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8070210E220;
 Mon, 11 May 2026 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778520653; x=1810056653;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QwAUyWjs2Ijf+FDLhUVD/L6ZmCDjeyicV4iWxLk6j7w=;
 b=GpjpJikGTY4eK4I1fDNgl22jamRX8qt3lWto72Mb0V9sxRSFNdAHcf2a
 GagKdxYBGSeyAcAZqL+KZXr8R9oy+a1HBd8nx95qIQeFKiYtknb3sQjdV
 grrGf1AMqHRXWtFlvzHVbp8Md4xA6Kz/IOdGBy6nM4oFCl4vp7zjNgqDt
 SX3D+rZYOyjOueM8+72+NBn8Z2GUKE5PwxszXob5niTGCsjSO6Nkmv2+M
 PmjQeHlvmZtBVpvTS/0mWiM+z+z0MDH2Fb67EO8IpE0elgDXCPRqm3UK7
 Uh6SMSkMTz22tdfXf9MOIovTSGtDdwpuWsS0Z5Olzybv8YQ4FJ7ylWeVR g==;
X-CSE-ConnectionGUID: tqE+QrMrRcyDdajwhPKuwA==
X-CSE-MsgGUID: WwAcfcFQQ+Cdf5byIqaEqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314098"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="79314098"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 10:30:40 -0700
X-CSE-ConnectionGUID: 5rs/O7s1RCiuzwYiPThWVw==
X-CSE-MsgGUID: lp2pCNh7SwOCLVWmxpoCWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="261000287"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora)
 ([10.245.244.248])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 10:30:35 -0700
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
Subject: [PATCH v3 0/5] Add reclaim to the dmem cgroup controller
Date: Mon, 11 May 2026 19:30:03 +0200
Message-ID: <20260511173008.36526-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
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
Patch 2 implements and documents a reclaim callback interface
      for the dmem controller.
Patch 3 implements a TTM reclaim callback.
Patch 4-5 hooks up the reclaim callback to the dmem cgroups-
      aware drivers xe and amdgpu.

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

User-space tests are at
https://patchwork.freedesktop.org/series/163935/

Test-with: 20260428065411.4222-1-thomas.hellstrom@linux.intel.com

Thomas Hellström (5):
  drm/amdgpu: Fix init ordering in amdgpu_vram_mgr_init()
  cgroup/dmem: Add reclaim callback for lowering max below current usage
  drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem
    controller
  drm/xe: Wire up dmem cgroup reclaim for VRAM manager
  drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |  10 +-
 drivers/gpu/drm/ttm/ttm_bo.c                 |  95 ++++++++++++++++-
 drivers/gpu/drm/ttm/ttm_bo_util.c            |   3 +-
 drivers/gpu/drm/ttm/ttm_resource.c           |  37 +++++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c         |  19 ++--
 include/drm/ttm/ttm_bo.h                     |  10 ++
 include/drm/ttm/ttm_resource.h               |   4 +
 include/linux/cgroup_dmem.h                  |  24 +++++
 kernel/cgroup/dmem.c                         | 106 +++++++++++++++++--
 10 files changed, 286 insertions(+), 24 deletions(-)

-- 
2.54.0

