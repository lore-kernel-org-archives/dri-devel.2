Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CB2CD4F3C
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 13:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBF810F1E9;
	Thu, 14 May 2026 13:20:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="g683HWt2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991EC10E558;
 Thu, 14 May 2026 13:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778764857; x=1810300857;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=CXbTnOUt4jA2dtByvS9qaWKqyo/KWV67+K2NB3pWDxA=;
 b=g683HWt2h1MU0MiZZ3IujXZy0NzGvZKzesgZxJM68MWIrTcUVn34vQMu
 aQcbmCosU1WK0nIvdhULGY2r0mOAjWBceLQd3WN0+s285YgzsJb+rIkH7
 MD6ND46NzrqutolGuF8VSDEcnaXwSbml14upSlUNO9w2MEnVZTcb/s8vM
 mcyXSC5G3Gh15Q7ph/c0TWJlzMVOYQUi3A/N+KtQUyUHghfkTQv3PlYpj
 FtSjr9flIF9aeWgLNErWXCoPOXA44U3Z74KJLfEsNK1qUj1WcCCWC+RDZ
 ov0ET/1cFnJM1goyXaupPrdXXtaTdY0Sr5FHaIE1d4NUw77pQDx6ifCN0 g==;
X-CSE-ConnectionGUID: 2wHj8SGzSTex8bS8FntD+g==
X-CSE-MsgGUID: WN/VZstrTpKhFPzZQgYWNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="105165730"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="105165730"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 06:20:56 -0700
X-CSE-ConnectionGUID: phzF58l0SOC181gQp3f6Tg==
X-CSE-MsgGUID: b7sTUSlaQmWUoi9ry2UBZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="268733333"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.244])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 06:20:52 -0700
Date: Thu, 14 May 2026 15:20:41 +0200
From: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dim-tools@lists.freedesktop.org
Subject: [PULL] drm-xe-next
Message-ID: <agXMKRRl1oxB204x@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

Hi, Dave & Simona

The drm-xe-next PR for this week:

Series highlights:

- Support run ticks for multi-queue use case
  11/11 patches pushed
  In multi-queue scenarios the CTX_TIMESTAMP represents run ticks of all
  queues combined. To determine individual queue run ticks, QUEUE TIMESTAMP
  must be used instead. The series adds support to read QUEUE TIMESTAMP for
  multi-queue use cases, including LRC snapshot support, trace events, and
  the infrastructure to capture queue run times for active queues.
  (Umesh Nerlige Ramappa, Matthew Brost)

- Refactor functions implementing the blt batch
  3/3 patches
  Functions implementing batch buffers for blitter instructions (MEM_SET,
  MEM_COPY, XY_FAST_COPY, XY_FAST_COLOR) used hardcoded fixed instruction
  lengths. Replaces these with a helper function that returns the correct
  length based on the platform, as preparatory work for upcoming platforms
  where these instruction lengths will increase.
  (Balasubramani Vivekanandan)

- drm/xe/memirq: Update interrupt handler logic
  2/2 patches
  A new programming note for memory-based interrupts was released. Updates
  the interrupt handler to follow the new note and stops enabling all
  GT_MI_USER_INTERRUPTs to avoid unnecessary empty processing cycles.
  (Michal Wajdeczko)

- drm/xe/dma-buf: UAF and race condition fixes
  2/2 patches
  Fixes two use-after-free and race conditions in the dma-buf import path.
  The invalidate_mappings hook could be called back into with a partially
  initialized or already freed buffer object. Fixes this by moving the
  attach step until after the buffer object is fully set up.
  (Matthew Auld)

- drm/xe/multi_queue: Code refactor and cleanup
  2/2 patches
  Removes a redundant assignment in guc_exec_queue_run_job and refactors
  the CGP_SYNC send path to reduce code size and improve clarity.
  (Niranjana Vishwanathapura)

- More MERTOA WA's
  4/4 patches
  Two hardware workarounds for the MERTOA OA unit. Wa_14026746987
  restricts the supported OA format to XE_OAM_FORMAT_MPEC8u32_B8_C8.
  Wa_14026779378 blocks the SYS_MEM_LAT_MEASURE_EN bit to prevent memory
  corruption. Also includes a refactor of oa_unit_supports_oa_format and
  a new val argument to xe_oa_is_valid_config_reg.
  (Ashutosh Dixit)

Individual commits:

- drm/xe: Drop unused ggtt_balloon field (Michal Wajdeczko)
- drm/xe/devcoredump: Drop a FIXME in devcoredump (Shekhar Chauhan)
- drm/xe/eustall: Return ENODEV from read if EU stall registers get reset (Harish Chegondi)
- drm/xe: Make decision to use Xe2-style blitter instructions a feature flag (Matt Roper)
- drm/xe: Convert stolen memory over to ttm_range_manager (Sanjay Yadav)
- drm/xe/madvise: Track purgeability with BO-local counters (Arvind Yadav)
- drm/xe/cri: Add new PCI IDs (Balasubramani Vivekanandan)
- drm/xe/xe_survivability: Simplify runtime survivability error handling (Mallesh Koujalagi)
- drm/xe/guc: Exclude indirect ring state page from ADS engine state size (Satyanarayana K V P)
- drm/xe/hw_error: Cleanup array map (Raag Jadav)
- drm/xe/pf: Fix MMIO access using PF view instead of VF view during migration (Shuicheng Lin)
- drm/xe/pf: Fix EAGAIN sign in pf_migration_consume() (Shuicheng Lin)

Thanks,
Thomas

drm-xe-next-2026-05-14:
Driver Changes:

- drm/xe/cri: Add new PCI IDs (Balasubramani Vivekanandan)
- drm/xe/memirq: Enable GT_MI_USER_INTERRUPT only (Michal Wajdeczko)
- drm/xe/memirq: Update interrupt handler logic (Michal Wajdeczko)
- drm/xe: Drop unused ggtt_balloon field (Michal Wajdeczko)
- drm/xe: Refactor emit_xy_fast_copy and emit_mem_copy functions (Balasubramani Vivekanandan)
- drm/xe: Refactor emit_clear_link_copy (Balasubramani Vivekanandan)
- drm/xe: Refactor emit_clear_main_copy (Balasubramani Vivekanandan)
- drm/xe/devcoredump: Drop a FIXME in devcoredump (Shekhar Chauhan)
- drm/xe/oa: MERTOA Wa_14026779378 (Ashutosh Dixit)
- drm/xe/oa: Add val arg to xe_oa_is_valid_config_reg (Ashutosh Dixit)
- drm/xe/oa: MERTOA Wa_14026746987 (Ashutosh Dixit)
- drm/xe/oa: Refactor oa_unit_supports_oa_format (Ashutosh Dixit)
- drm/xe/dma-buf: fix UAF with retry loop (Matthew Auld)
- drm/xe/dma-buf: handle empty bo and UAF races (Matthew Auld)
- drm/xe/multi_queue: Whitelist QUEUE_TIMESTAMP register (Umesh Nerlige Ramappa)
- drm/xe/multi_queue: Use QUEUE_TIMESTAMP as job timestamp for multi-queue (Umesh Nerlige Ramappa)
- drm/xe/multi_queue: Add trace event for the multi queue timestamp (Umesh Nerlige Ramappa)
- drm/xe/multi_queue: Capture queue run times for active queues (Umesh Nerlige Ramappa)
- drm/xe/lrc: Refactor out engine id to hwe conversion (Umesh Nerlige Ramappa)
- drm/xe/multi_queue: Add helpers to access CS QUEUE TIMESTAMP from lrc (Umesh Nerlige Ramappa)
- drm/xe/multi_queue: Store primary LRC and position info in LRC (Umesh Nerlige Ramappa)
- drm/xe/multi_queue: Refactor check for multi queue support for engine class (Umesh Nerlige Ramappa)
- drm/xe/lrc: Refactor xe_lrc_timestamp to simplify logic (Umesh Nerlige Ramappa)
- drm/xe: Add timestamp_ms to LRC snapshot (Matthew Brost)
- drm/xe/lrc: Use 64 bit ctx timestamp in the LRC snapshot (Umesh Nerlige Ramappa)
- drm/xe/eustall: Return ENODEV from read if EU stall registers get reset (Harish Chegondi)
- drm/xe/multi_queue: Refactor CGP_SYNC send path (Niranjana Vishwanathapura)
- drm/xe/multi_queue: Remove redundant assignment in guc_exec_queue_run_job (Niranjana Vishwanathapura)
- drm/xe: Make decision to use Xe2-style blitter instructions a feature flag (Matt Roper)
- drm/xe: Convert stolen memory over to ttm_range_manager (Sanjay Yadav)
- drm/xe/madvise: Track purgeability with BO-local counters (Arvind Yadav)
- drm/xe/xe_survivability: Simplify runtime survivability error handling (Mallesh Koujalagi)
- drm/xe/guc: Exclude indirect ring state page from ADS engine state size (Satyanarayana K V P)
- drm/xe/hw_error: Cleanup array map (Raag Jadav)
- drm/xe/pf: Fix MMIO access using PF view instead of VF view during migration (Shuicheng Lin)
- drm/xe/pf: Fix EAGAIN sign in pf_migration_consume() (Shuicheng Lin)
The following changes since commit f96538285cfdbb3acf5e3356e0bb88c38815790b:

  Merge tag 'drm-misc-next-2026-05-07' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next (2026-05-08 14:16:04 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-2026-05-14

for you to fetch changes up to 2ddedd4b7b7c329dd65358025cba8652675bec3d:

  drm/xe/memirq: Enable GT_MI_USER_INTERRUPT only (2026-05-13 20:11:21 +0200)

----------------------------------------------------------------
Driver Changes:

- drm/xe/cri: Add new PCI IDs (Balasubramani Vivekanandan)
- drm/xe/memirq: Enable GT_MI_USER_INTERRUPT only (Michal Wajdeczko)
- drm/xe/memirq: Update interrupt handler logic (Michal Wajdeczko)
- drm/xe: Drop unused ggtt_balloon field (Michal Wajdeczko)
- drm/xe: Refactor emit_xy_fast_copy and emit_mem_copy functions (Balasubramani Vivekanandan)
- drm/xe: Refactor emit_clear_link_copy (Balasubramani Vivekanandan)
- drm/xe: Refactor emit_clear_main_copy (Balasubramani Vivekanandan)
- drm/xe/devcoredump: Drop a FIXME in devcoredump (Shekhar Chauhan)
- drm/xe/oa: MERTOA Wa_14026779378 (Ashutosh Dixit)
- drm/xe/oa: Add val arg to xe_oa_is_valid_config_reg (Ashutosh Dixit)
- drm/xe/oa: MERTOA Wa_14026746987 (Ashutosh Dixit)
- drm/xe/oa: Refactor oa_unit_supports_oa_format (Ashutosh Dixit)
- drm/xe/dma-buf: fix UAF with retry loop (Matthew Auld)
- drm/xe/dma-buf: handle empty bo and UAF races (Matthew Auld)
- drm/xe/multi_queue: Whitelist QUEUE_TIMESTAMP register (Umesh Nerlige Ramappa)
- drm/xe/multi_queue: Use QUEUE_TIMESTAMP as job timestamp for multi-queue (Umesh Nerlige Ramappa)
- drm/xe/multi_queue: Add trace event for the multi queue timestamp (Umesh Nerlige Ramappa)
- drm/xe/multi_queue: Capture queue run times for active queues (Umesh Nerlige Ramappa)
- drm/xe/lrc: Refactor out engine id to hwe conversion (Umesh Nerlige Ramappa)
- drm/xe/multi_queue: Add helpers to access CS QUEUE TIMESTAMP from lrc (Umesh Nerlige Ramappa)
- drm/xe/multi_queue: Store primary LRC and position info in LRC (Umesh Nerlige Ramappa)
- drm/xe/multi_queue: Refactor check for multi queue support for engine class (Umesh Nerlige Ramappa)
- drm/xe/lrc: Refactor xe_lrc_timestamp to simplify logic (Umesh Nerlige Ramappa)
- drm/xe: Add timestamp_ms to LRC snapshot (Matthew Brost)
- drm/xe/lrc: Use 64 bit ctx timestamp in the LRC snapshot (Umesh Nerlige Ramappa)
- drm/xe/eustall: Return ENODEV from read if EU stall registers get reset (Harish Chegondi)
- drm/xe/multi_queue: Refactor CGP_SYNC send path (Niranjana Vishwanathapura)
- drm/xe/multi_queue: Remove redundant assignment in guc_exec_queue_run_job (Niranjana Vishwanathapura)
- drm/xe: Make decision to use Xe2-style blitter instructions a feature flag (Matt Roper)
- drm/xe: Convert stolen memory over to ttm_range_manager (Sanjay Yadav)
- drm/xe/madvise: Track purgeability with BO-local counters (Arvind Yadav)
- drm/xe/xe_survivability: Simplify runtime survivability error handling (Mallesh Koujalagi)
- drm/xe/guc: Exclude indirect ring state page from ADS engine state size (Satyanarayana K V P)
- drm/xe/hw_error: Cleanup array map (Raag Jadav)
- drm/xe/pf: Fix MMIO access using PF view instead of VF view during migration (Shuicheng Lin)
- drm/xe/pf: Fix EAGAIN sign in pf_migration_consume() (Shuicheng Lin)

----------------------------------------------------------------
Arvind Yadav (1):
      drm/xe/madvise: Track purgeability with BO-local counters

Ashutosh Dixit (4):
      drm/xe/oa: Refactor oa_unit_supports_oa_format
      drm/xe/oa: MERTOA Wa_14026746987
      drm/xe/oa: Add val arg to xe_oa_is_valid_config_reg
      drm/xe/oa: MERTOA Wa_14026779378

Balasubramani Vivekanandan (4):
      drm/xe/cri: Add new PCI IDs
      drm/xe: Refactor emit_clear_main_copy
      drm/xe: Refactor emit_clear_link_copy
      drm/xe: Refactor emit_xy_fast_copy and emit_mem_copy functions

Harish Chegondi (1):
      drm/xe/eustall: Return ENODEV from read if EU stall registers get reset

Mallesh Koujalagi (1):
      drm/xe/xe_survivability: Simplify runtime survivability error handling

Matt Roper (1):
      drm/xe: Make decision to use Xe2-style blitter instructions a feature flag

Matthew Auld (2):
      drm/xe/dma-buf: handle empty bo and UAF races
      drm/xe/dma-buf: fix UAF with retry loop

Matthew Brost (1):
      drm/xe: Add timestamp_ms to LRC snapshot

Michal Wajdeczko (3):
      drm/xe: Drop unused ggtt_balloon field
      drm/xe/memirq: Update interrupt handler logic
      drm/xe/memirq: Enable GT_MI_USER_INTERRUPT only

Niranjana Vishwanathapura (2):
      drm/xe/multi_queue: Remove redundant assignment in guc_exec_queue_run_job
      drm/xe/multi_queue: Refactor CGP_SYNC send path

Raag Jadav (1):
      drm/xe/hw_error: Cleanup array map

Sanjay Yadav (1):
      drm/xe: Convert stolen memory over to ttm_range_manager

Satyanarayana K V P (1):
      drm/xe/guc: Exclude indirect ring state page from ADS engine state size

Shekhar Chauhan (1):
      drm/xe/devcoredump: Drop a FIXME in devcoredump

Shuicheng Lin (2):
      drm/xe/pf: Fix EAGAIN sign in pf_migration_consume()
      drm/xe/pf: Fix MMIO access using PF view instead of VF view during migration

Thomas Hellström (1):
      Merge drm/drm-next into drm-xe-next

Umesh Nerlige Ramappa (10):
      drm/xe/lrc: Use 64 bit ctx timestamp in the LRC snapshot
      drm/xe/lrc: Refactor xe_lrc_timestamp to simplify logic
      drm/xe/multi_queue: Refactor check for multi queue support for engine class
      drm/xe/multi_queue: Store primary LRC and position info in LRC
      drm/xe/multi_queue: Add helpers to access CS QUEUE TIMESTAMP from lrc
      drm/xe/lrc: Refactor out engine id to hwe conversion
      drm/xe/multi_queue: Capture queue run times for active queues
      drm/xe/multi_queue: Add trace event for the multi queue timestamp
      drm/xe/multi_queue: Use QUEUE_TIMESTAMP as job timestamp for multi-queue
      drm/xe/multi_queue: Whitelist QUEUE_TIMESTAMP register

 drivers/gpu/drm/xe/display/xe_display_bo.c        |   2 +-
 drivers/gpu/drm/xe/instructions/xe_gpu_commands.h |   4 +-
 drivers/gpu/drm/xe/regs/xe_engine_regs.h          |   4 +
 drivers/gpu/drm/xe/regs/xe_lrc_layout.h           |   3 +
 drivers/gpu/drm/xe/regs/xe_oa_regs.h              |   3 +
 drivers/gpu/drm/xe/tests/xe_migrate.c             |   2 +-
 drivers/gpu/drm/xe/xe_bo.c                        |  22 +-
 drivers/gpu/drm/xe/xe_bo.h                        |  88 +++++++-
 drivers/gpu/drm/xe/xe_bo_types.h                  |  28 ++-
 drivers/gpu/drm/xe/xe_device_types.h              |   3 +
 drivers/gpu/drm/xe/xe_device_wa_oob.rules         |   2 +
 drivers/gpu/drm/xe/xe_dma_buf.c                   |  80 ++++---
 drivers/gpu/drm/xe/xe_eu_stall.c                  |  40 +++-
 drivers/gpu/drm/xe/xe_exec_queue.c                |  14 +-
 drivers/gpu/drm/xe/xe_gt.h                        |  15 ++
 drivers/gpu/drm/xe/xe_gt_sriov_pf_migration.c     |   8 +-
 drivers/gpu/drm/xe/xe_gt_types.h                  |   7 +
 drivers/gpu/drm/xe/xe_guc_ads.c                   |   5 +-
 drivers/gpu/drm/xe/xe_guc_capture.c               |   6 -
 drivers/gpu/drm/xe/xe_guc_submit.c                |  69 ++----
 drivers/gpu/drm/xe/xe_hw_error.c                  |  32 ++-
 drivers/gpu/drm/xe/xe_lrc.c                       | 253 +++++++++++++++++-----
 drivers/gpu/drm/xe/xe_lrc.h                       |  12 +-
 drivers/gpu/drm/xe/xe_lrc_types.h                 |  11 +
 drivers/gpu/drm/xe/xe_memirq.c                    |  32 ++-
 drivers/gpu/drm/xe/xe_migrate.c                   |  75 ++++---
 drivers/gpu/drm/xe/xe_oa.c                        |  40 ++--
 drivers/gpu/drm/xe/xe_pci.c                       |   9 +
 drivers/gpu/drm/xe/xe_reg_whitelist.c             |  14 ++
 drivers/gpu/drm/xe/xe_res_cursor.h                |  14 +-
 drivers/gpu/drm/xe/xe_ring_ops.c                  |   8 +-
 drivers/gpu/drm/xe/xe_sriov_pf_migration.c        |   7 +-
 drivers/gpu/drm/xe/xe_survivability_mode.c        |  14 +-
 drivers/gpu/drm/xe/xe_survivability_mode.h        |   2 +-
 drivers/gpu/drm/xe/xe_tile_types.h                |   2 -
 drivers/gpu/drm/xe/xe_trace_lrc.h                 |  27 +++
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c            |  64 ++----
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.h            |  12 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c              |  11 +-
 drivers/gpu/drm/xe/xe_vm.c                        |  51 ++++-
 drivers/gpu/drm/xe/xe_vm_madvise.c                | 162 +-------------
 drivers/gpu/drm/xe/xe_vm_madvise.h                |   2 -
 include/drm/intel/pciids.h                        |   6 +-
 43 files changed, 779 insertions(+), 486 deletions(-)
