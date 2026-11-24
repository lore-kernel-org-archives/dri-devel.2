Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA8606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lLLV6g99
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAAF10E0DE;
	Tue, 24 Nov 2026 06:16:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E7810E0DE;
 Tue, 24 Nov 2026 06:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795501008; x=1827037008;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/tQMzNZzKEESVkUXl6pvXxR3usY5Gw/rjmjxVjGABQQ=;
 b=lLLV6g99If+qlA3RM1XR8lJM+jdkJ/yxLCu5jOi/XILMXNddanBC/UEd
 pL+eaYUux1tpdayZBxcc1vxiewFtN8ZjJEPSPTAwlFo5BhEyBMj7MCmuu
 dX0ad4XPgphmmDpfke/KVjz9IEQaO48nwpRogDIfQdS4iZn5JWZfnjGPr
 ZutdTK49yoSgyiuMStgNnNw84ATa8pra/abr2C6ppJ6kG9D7FZJvO1HQa
 F7x1xfdiAGfBqFWokbHjzl2r6n2pnACu/bjhEzT+6Nv5kX1opohfmTw0N
 QlZUCPzWUtm6UQhjSO3BClC3inlXpm64aIYCL3c9g1uPct13XKKXTs7tf A==;
X-CSE-ConnectionGUID: qLB/2H2tRS+QizEAUhCmFg==
X-CSE-MsgGUID: IOrlkxJtRGyk8gjQarpTvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4220023"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4220023"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 22:16:47 -0800
X-CSE-ConnectionGUID: NW0T0jzcRzeahL4koTGFGg==
X-CSE-MsgGUID: gWlKe8CVTmaK2lfQzXZGQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11264077"
Received: from hghimira.iind.intel.com ([10.190.239.34])
 by orviesa008.jf.intel.com with ESMTP; 23 Nov 2026 22:16:44 -0800
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: Natalie Vock <natalie.vock@gmx.de>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [RFC v2 00/11] drm/ttm, drm/xe: Per-BO host NUMA memory policy
Date: Tue, 24 Nov 2026 11:51:24 +0530
Message-ID: <20261124062123.2431244-13-himal.prasad.ghimiray@intel.com>
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
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
  GPU uses, or a set of nodes chosen to balance memory bandwidth. Today
  it has no way to express that for driver allocated system memory.
- mbind()/set_mempolicy() do not help: BO pages are allocated by the
  driver, not through the task's fault path, and BO CPU mappings are
  VM_PFNMAP.

This series lets userspace select a host NUMA memory policy per BO at
creation time, using the same vocabulary as mbind(): a mode and a
nodemask.

UAPI:
- New DRM_XE_GEM_CREATE_EXTENSION_SET_MEMPOLICY GEM_CREATE extension
  with struct drm_xe_gem_create_mempolicy { mode, flags, nodemask,
  maxnode }. The nodemask is a user pointer to an unsigned long array
  of maxnode bits, as for mbind().
- Modes:
  - PREFERRED: one node, best effort, falls back under memory pressure
    (like MPOL_PREFERRED).
  - BIND: only the nodes in the mask, never falls back outside it, so
    the allocation fails with -ENOMEM when they are exhausted (like
    MPOL_BIND).
  - INTERLEAVE: pages spread round-robin across the nodes in the mask
    (like MPOL_INTERLEAVE).
- Not attaching the extension keeps the current default placement.
- Unknown modes, non-zero flags or pad, empty masks, bits at or above
  maxnode, nodes without memory, PREFERRED with more than one node, and
  BOs that can't be placed in system memory are rejected with -EINVAL.
- The policy is captured at creation and applied whenever the backing
  pages are allocated, including late populate and shrinker restore.
- New DRM_XE_DEVICE_QUERY_MEMPOLICY reports a bitmask of supported
  modes, so userspace can probe support before creating BOs. A mode the
  device cannot apply is rejected with -EOPNOTSUPP. Further modes, such
  as weighted interleave, can be added as new mode values and reported
  through the same query.

TTM:
- struct ttm_operation_ctx gains numa_info { policy, nodes }. The
  default TTM_NUMA_POLICY_NONE is zero, so existing zero-initialized
  users are unaffected.
- __ttm_pool_alloc() honors the policy per allocation:
  - PREFERRED allocates from the single node and may fall back.
  - BIND tries the mask nodes nearest first from the local node, with
    __GFP_THISNODE so it never leaves the mask.
  - INTERLEAVE picks the node for each chunk from its page offset,
    scaled by the allocation order as core mm does for large folios.
    If that node is short, the other mask nodes are tried nearest first
    before the order is lowered.
- Pool caches, accounting and the shrinker are already per node. Free
  now trims every over-limit node instead of only the pool's default
  node.
- dma_alloc pools cannot honor a policy and return -EOPNOTSUPP.

Why a policy in ttm_operation_ctx rather than one ttm_pool per node in
the driver:

The NUMA placement is a property of each allocation, not of the pool.
TTM already tracks pages per node (per-node LRUs in the pool caches,
per-node shrinker, per-node cache limits). Carrying the policy in the
operation context reaches populate, restore and backup through the
existing TTM helpers, without a second NUMA aware entry point.

One pool per node in the driver does not cover this:
- INTERLEAVE spreads a single BO across nodes, which a pool bound to
  one node cannot do.
- TTM core helpers (ttm_tt_restore(), ttm_tt_backup(), pool debugfs)
  all use the device pool. The driver would have to bypass them for
  populate, restore, backup and free.
- For dma_alloc pools, N pools mean N separate page caches that can't
  share pages.
- Every TTM driver that wants per-BO placement would have to duplicate
  the same per-node pool handling.

amdgpu already creates one pool per memory partition only to select the
partition's node. It is converted to the operation context with
PREFERRED, after which no caller needs a per-pool node, so the nid
argument of ttm_pool_init() is dropped.

Changes since v1:
- v1 added ttm_pool_alloc_node(), ttm_tt_restore_node() and
  ttm_pool_restore_and_alloc_node(). Christian asked for no secondary
  NUMA aware path, so the placement is now carried in struct
  ttm_operation_ctx and reaches the existing TTM helpers.
- Thomas asked for the interface to extend beyond a single node to the
  other mempolicy modes, so the single node became a policy and a
  nodemask, grouped in a numa_info sub-struct, adding BIND and
  INTERLEAVE.
- The Xe UAPI moved from the DRM_XE_GEM_CREATE_SET_PROPERTY_NUMA_NODE
  property to a dedicated mempolicy extension, plus a device query for
  the supported modes.
- amdgpu converted from per-partition pools to the operation context,
  and the nid argument of ttm_pool_init() removed.
- Per-node cache limits enforced on free.
- GEM_CREATE extensions are parsed once before BO creation through the
  existing extension tables (Matt Auld).
- NUMA_NO_NODE is kept unresolved for alloc_pages_node() so memoryless
  nodes still fall back to numa_mem_id() (sashiko).

v1: https://patchwork.freedesktop.org/series/177437/


Himal Prasad Ghimiray (11):
  drm/ttm: Add NUMA placement policy to ttm_operation_ctx
  drm/ttm: Add TTM_NUMA_POLICY_BIND
  drm/ttm: Add TTM_NUMA_POLICY_INTERLEAVE
  drm/ttm/pool: enforce per-node cache limits on free
  drm/amdgpu: Use ttm_operation_ctx numa_info instead of per-partition
    pools
  drm/ttm/pool: Drop the nid argument from ttm_pool_init()
  drm/xe/uapi: Add GEM_CREATE host NUMA mempolicy extension
  drm/xe/bo: Carry a per-BO host NUMA mempolicy
  drm/xe/uapi: Wire up GEM_CREATE mempolicy extension handler
  drm/xe/uapi: Add device query for supported host NUMA mempolicy modes
  drm/xe: Implement the host NUMA mempolicy device query

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   |  78 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h   |   1 -
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c |  10 +-
 drivers/gpu/drm/ttm/ttm_device.c          |   9 +-
 drivers/gpu/drm/ttm/ttm_pool.c            | 221 +++++++++++++++++++--
 drivers/gpu/drm/xe/tests/xe_bo.c          |  12 +-
 drivers/gpu/drm/xe/tests/xe_dma_buf.c     |   4 +-
 drivers/gpu/drm/xe/tests/xe_migrate.c     |   8 +-
 drivers/gpu/drm/xe/xe_bo.c                | 229 ++++++++++++++++++----
 drivers/gpu/drm/xe/xe_bo.h                |   6 +-
 drivers/gpu/drm/xe/xe_bo_types.h          |  24 +++
 drivers/gpu/drm/xe/xe_dma_buf.c           |   3 +-
 drivers/gpu/drm/xe/xe_query.c             |  23 +++
 include/drm/ttm/ttm_bo.h                  |  37 ++++
 include/drm/ttm/ttm_pool.h                |   4 +-
 include/uapi/drm/xe_drm.h                 |  79 ++++++++
 16 files changed, 610 insertions(+), 138 deletions(-)

-- 
2.43.0

