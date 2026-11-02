Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0CD606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O/Fpk8mT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28DE110EC6C;
	Mon,  2 Nov 2026 10:14:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD6D10E5B9;
 Mon,  2 Nov 2026 10:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793614434; x=1825150434;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3EJA6kuE28YnkY8VGAZQ07YFXJoIIx/ZTqybHIWFDD4=;
 b=O/Fpk8mTOwdNWcO54Y2KitEyDNSM0CiMWR43PMYNbQcLzBfXbUe2Qk2S
 XfLBXlej9hyhEnAUnC8ZFHZbR8BHlqO1mOkpeSzOvfRGIQ9r0XGvpdRTW
 4Ngf8BT2uyGlA+5vEMOOQ3hz2zzy4S6gHS38Yg2fwqmycPiRHcS7CxmbX
 WaXaYRPs9nnFc2QlsOFs8vKKFzg2LaS/33m/H+xLbqioowpTrZN+QAx34
 H4ocTbWc79w4/76J6Qpbjt1zYo+vwhLBhI8o09piwDgcQvpXyn3cRYK2K
 QYLunbZTKOYwU26P/ZRSdjIr0Txq3WQIvQXFvJltS4VnzBIgvFGAFn2CH w==;
X-CSE-ConnectionGUID: ksNDgeuZTRSjFB4HdINy7g==
X-CSE-MsgGUID: V0JSd+VQR7egQJdjT8UPhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2200778"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2200778"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:13:53 -0800
X-CSE-ConnectionGUID: lh6KbS9SSR2FZhfpcFe5Ww==
X-CSE-MsgGUID: KICT9/gfTw6IjRPqWm3z5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6002750"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:13:51 -0800
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [RFC 0/7] drm/ttm, drm/xe: Per-BO host NUMA node placement
Date: Mon,  2 Nov 2026 15:48:04 +0530
Message-ID: <20261102101803.455921-9-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The backing pages of an Xe system memory BO are allocated on the device
local node (dev_to_node()), or on the allocating CPU's node when the
device has none. That is fine when CPU and GPU access a buffer from the
same place, but not in general:

- On multi-socket systems, and where the GPU's PCIe/CXL link attaches
  to a different node than the threads using a buffer, the cost of
  accessing a BO depends on which node backs its pages. The device
  local node is not always the best choice.
- A runtime often knows where a BO should live: the node of the CPU
  threads producing or consuming it, the node closest to the link the
  GPU uses, or a node chosen to balance memory bandwidth. Today it has
  no way to express that for driver allocated system memory.
- mbind()/set_mempolicy() do not help: BO pages are allocated by the
  driver, not through the task's fault path, and BO CPU mappings are
  VM_PFNMAP.

This series lets userspace select the host NUMA node per BO at
creation time.

UAPI:
- New DRM_XE_GEM_CREATE_SET_PROPERTY_NUMA_NODE property on the existing
  GEM_CREATE set-property extension.
- The node is a preference (best effort, like MPOL_PREFERRED); the
  allocation falls back to other nodes under memory pressure.
- A negative value, or not setting the property, keeps the current
  default placement.
- Invalid or offline nodes, and BOs that can't be placed in system
  memory, are rejected with -EINVAL.
- The placement is preserved across shrinker backup / restore.
- A richer placement policy can be added later as a separate extension
  without changing this one.

Why a node aware TTM allocation API rather than one ttm_pool per node
in the driver:

The NUMA node is a property of each allocation, not of the pool. TTM
already tracks pages per node (per-node LRUs in the pool caches,
per-node shrinker, per-node cache limits) and __ttm_pool_alloc()
already takes a node internally. ttm_pool_alloc_node() and
ttm_tt_restore_node() only let a caller pass that node in, following
the alloc_pages_node() / kmalloc_node() pattern, with no new state.

One pool per node in the driver would work for Xe today, but:
- TTM core helpers (ttm_tt_restore(), ttm_tt_backup(), pool debugfs)
  all use the device pool. The driver would have to bypass them for
  populate, restore, backup and free, and re-check that whenever TTM
  adds or changes a helper. The restore issue fixed in this series is
  an example: the placement was silently lost after backup.
- It relies on non dma_alloc pools having no per-pool state. For
  dma_alloc pools, N pools mean N separate page caches that can't
  share pages.
- Every TTM driver that wants per-BO placement would have to duplicate
  the same per-node pool handling.

The existing ttm_pool_alloc() and ttm_tt_restore() become wrappers
passing NUMA_NO_NODE, so current users are unaffected.

Himal Prasad Ghimiray (7):
  drm/ttm/pool: Add ttm_pool_alloc_node() for caller-selected NUMA node
  drm/ttm: Add NUMA node aware restore helpers
  drm/ttm/pool: enforce per-node cache limits on free
  drm/xe/bo: Plumb a per-BO host NUMA node hint into tt populate
  drm/xe/bo: Preserve the host NUMA node across backup / restore
  drm/xe/uapi: Add GEM_CREATE NUMA node placement property
  drm/xe/uapi: Wire up GEM_CREATE NUMA node placement handler

 drivers/gpu/drm/ttm/ttm_pool.c          | 104 +++++++++++++++++++---
 drivers/gpu/drm/ttm/ttm_pool_internal.h |   4 +
 drivers/gpu/drm/ttm/ttm_tt.c            |  20 ++++-
 drivers/gpu/drm/xe/tests/xe_bo.c        |  12 +--
 drivers/gpu/drm/xe/tests/xe_dma_buf.c   |   4 +-
 drivers/gpu/drm/xe/tests/xe_migrate.c   |   8 +-
 drivers/gpu/drm/xe/xe_bo.c              | 109 +++++++++++++++++++-----
 drivers/gpu/drm/xe/xe_bo.h              |   5 +-
 drivers/gpu/drm/xe/xe_bo_types.h        |   7 ++
 drivers/gpu/drm/xe/xe_dma_buf.c         |   3 +-
 include/drm/ttm/ttm_pool.h              |   2 +
 include/drm/ttm/ttm_tt.h                |   2 +
 include/uapi/drm/xe_drm.h               |   7 ++
 13 files changed, 238 insertions(+), 49 deletions(-)

-- 
2.43.0

