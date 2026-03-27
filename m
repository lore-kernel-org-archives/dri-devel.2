Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5262610BA432
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 08:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9D3010EC69;
	Fri, 27 Mar 2026 08:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FAd8sKxR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37CCB10EC69;
 Fri, 27 Mar 2026 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774599395; x=1806135395;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VWKC7WfF9sq0UPoXI/VTX8BADLs4AZocKbls3bQOtDg=;
 b=FAd8sKxRYwm7HnfWA/SgyuCDWkuB9EzzO+d7m72ZMoQS/OpCHJdrZNwx
 wzc7FMDin9/P54UYQF2hvqAlgNE2p0kql8Z608+u6JlDuJOh0AymRRz+1
 1Rq3FmszVi+jEjr978280jQlAdb8mxoJwrvFu9jq6dq/MX4O1WwqoEjxx
 D6Zyqmcf+oB1ynGpKd+iE3ZBt6M98Xzrc4iOuJCJzYEQJxuCQggIWtoCW
 vcFG3XEkrLafd3WwhavyshSgeSYU9xs5vkA3C5j5W/LpTPgkX+BW7ekpT
 myNAH8nqD6XSwx7fn1Aul6R+C/6dWf4ga3ZtWgpPcBQ33bs7o+kYywwT1 A==;
X-CSE-ConnectionGUID: LMB/VOFESgy0AVjdxOz1Bw==
X-CSE-MsgGUID: aI5VtKmSQxWP3hkOOhmxQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75784015"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75784015"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 01:16:34 -0700
X-CSE-ConnectionGUID: NcH4tAOxSSul0MwY0s8pQQ==
X-CSE-MsgGUID: 0XW60LgxTiaGYZloM+zPAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255747866"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO fedora)
 ([10.245.244.146])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 01:16:29 -0700
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
Subject: [PATCH 0/5] Add reclaim to the dmem cgroup controller
Date: Fri, 27 Mar 2026 09:15:55 +0100
Message-ID: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
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

Patch 1 implements error propagation.
Patch 2 implements and documents a reclaim callback interface
      for the dmem controller.
Patch 3 implements a TTM reclaim callback.
Patch 4-5 hooks up the reclaim callback to the dmem cgroups-
      aware drivers xe and amdgpu.

Thomas Hellström (5):
  cgroup/dmem: Return error when setting max below current usage
  cgroup/dmem: Add reclaim callback for lowering max below current usage
  drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem
    controller
  drm/xe: Wire up dmem cgroup reclaim for VRAM manager
  drm/amdgpu: Wire up dmem cgroup reclaim for VRAM manager

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |  10 +-
 drivers/gpu/drm/ttm/ttm_bo.c                 |  95 ++++++++++++++++-
 drivers/gpu/drm/ttm/ttm_bo_util.c            |   3 +-
 drivers/gpu/drm/ttm/ttm_resource.c           |  36 +++++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c         |  19 ++--
 include/drm/ttm/ttm_bo.h                     |  10 ++
 include/drm/ttm/ttm_resource.h               |   4 +
 include/linux/cgroup_dmem.h                  |  11 ++
 kernel/cgroup/dmem.c                         | 102 ++++++++++++++++---
 10 files changed, 265 insertions(+), 27 deletions(-)

-- 
2.53.0

