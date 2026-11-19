Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16131606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mio3+RxQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B64112383;
	Thu, 19 Nov 2026 12:37:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345AF112372;
 Thu, 19 Nov 2026 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795091842; x=1826627842;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=HouPUWqS3i7sWa+QsRl9tz/BUqeC93diMWRovotdfIA=;
 b=Mio3+RxQTNGX+J3SXsnZc8rbmmpt+fmrVHgh3zPfqobfvs6RK2XIOYqc
 HEJi5Sb1odoZeE5cdJ0hsdGQy8sLH0Neq1mPefeH//LC5lfrtojeWCOQP
 hHOSl8dRmBAE9RlSkzqd5sxh66/0Tx39Swb/EL/50W+y4c4Qevy/ZE+B7
 OJn7oJh+JqPnk/7KUj/koQlL9CEcCIBnAFATjilGo778TKwIZPBmqkFR+
 Sg24VKLIXJiXTNL4hujpwTXP0O//38pEEAq8Jt+LwqEF0TQyAlN/OBHOr
 K+hpl2+R4ClHpWFR4tP22JM7XDjLR92xyKxDjeJNVbYMKNnoYYobQLPFZ Q==;
X-CSE-ConnectionGUID: uRZ5dsbOSaWDCuuPaPv7mw==
X-CSE-MsgGUID: KVNqNHlNQi2odiqK/Yn84g==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3943115"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3943115"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 04:37:22 -0800
X-CSE-ConnectionGUID: +NMwFF/HSZ2htn3VXm+Jtg==
X-CSE-MsgGUID: rNvx3RcGTRmpPmAyQ3mRiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10773001"
Received: from amilburn-desk.amilburn-desk (HELO fedora) ([10.245.245.91])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 04:37:18 -0800
Date: Thu, 19 Nov 2026 13:37:03 +0100
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
Message-ID: <av7tXyAinG4Pjaua@fedora>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Simona!

Here is this week's drm-xe-next PR. Highlights:

Series
------

- Introduce Xe PCIe FLR
  10/10 patches pushed
  Adds PCIe Function Level Reset support to xe. After FLR the driver
  re-initializes the GT: migrate context, kernel exec queues, BO mappings,
  GuC submission and firmware, with temporary device wedging and
  suspend/resume helpers. Documentation for PCI error handling is wired up.
  (Raag Jadav)

- Handle non-fatal errors routed via IRQ
  8/8 patches pushed
  Processes, logs and recovers non-fatal errors routed via direct IRQ,
  including double-bit ECC page offlining, and implements wa_14028434957 on
  CRI. Handles races with AER-reported errors that require a secondary bus
  reset, and wedges the device with a bus reset when needed.
  (Riana Tauro, Raag Jadav)

- Separate GGTT pools for submissions and VFs provisioning
  5/5 patches pushed
  Splits the GGTT into logical usable and shareable pools so driver-owned
  allocations and VF provisioning can be managed independently. Pools are
  initialized by SR-IOV mode and covered by new KUnit tests.
  (Piotr Piórkowski)

- drm/xe/display: Transparent fallback from stolen to sysmem
  4/5 patches pushed
  Avoids using stolen memory for the framebuffer when a media GT exists,
  adds sysmem<->stolen copy support in the migrate code, and adds an
  i915 fbdev BIOS fb takeover helper. Also raises GT frequency slightly
  earlier. (The "HACK: Always fallback" patch was not pushed.)
  (Maarten Lankhorst)

- Define GuC firmware for CRI and NVL-P
  2/4 patches pushed
  Defines the GuC firmware (70.83.0) for CRI and NVL-P. The two for-CI
  revert patches in the series were not pushed to drm-xe-next.
  (Daniele Ceraolo Spurio)

- drm/xe/guc: Fix TLB invalidation WARN when GuC CT is disabled during GT reset
  2/2 patches pushed
  Treats a CT-disabled TLB invalidation as cancelled, avoiding a WARN in
  userptr invalidation during GT reset, and drops a redundant error remap
  in the GGTT full invalidation path.
  (Zongyao Bai)


Single patches
--------------

- drm/xe/pf: Reset PF scheduling defaults on auto provisioning restore (Rachapalli Bandi Jagadeesh)
- drm/xe/dma-buf: Validate BOs on export to charge the exporter (Thomas Hellström)
- drm/xe/lrc: Fix math in LRC offset comments (Matt Roper)
- drm/xe/cri: Add new PCI IDs (Ranu Maurya)
- drm/xe/irq: Always free requested IRQs on uninstall (Arvind Yadav)
- drm/xe/guc: Reset TLB invalidation state in submit fini (Piotr Piórkowski)
- drm/xe/query: Use ordered clock reads for engine cycles cpu_delta (Sanjay Yadav)

The following changes since commit be73339dd9d70623b7dbc9c4e3b966824b771069:

  drm: xe: select configfs (2026-11-11 13:53:05 -0500)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-2026-11-19

for you to fetch changes up to 72f716775dae43f2f6ea042bc97f6552f5240db7:

  drm/xe/pf: Reset PF scheduling defaults on auto provisioning restore (2026-11-19 11:21:28 +0100)

----------------------------------------------------------------
Cross-subsystem Changes:
- drm/i915: Introduce intel_bo_fbdev_bios_fb_takeover() (Maarten Lankhorst)

Core Changes:
- drm/xe/cri: Add new PCI IDs (Ranu Maurya)

Driver Changes:
- drm/xe/pf: Reset PF scheduling defaults on auto provisioning restore (Rachapalli Bandi Jagadeesh)
- drm/xe/guc: Drop redundant error remap in send_tlb_inval_ggtt_full() (Zongyao Bai)
- drm/xe/guc: Treat CT-disabled TLB invalidation as cancelled (Zongyao Bai)
- drm/xe/dma-buf: Validate BOs on export to charge the exporter (Thomas Hellström)
- drm/xe: Raise gt frequency slightly earlier. (Maarten Lankhorst)
- drm/xe/migrate: Support copying between sysmem and stolen (Maarten Lankhorst)
- drm/xe/display: Avoid using stolen memory for framebuffer when media gt exists. (Maarten Lankhorst)
- drm/xe/lrc: Fix math in LRC offset comments (Matt Roper)
- drm/xe/irq: Always free requested IRQs on uninstall (Arvind Yadav)
- drm/xe/ggtt: Add KUnit tests for usable and shareable pools (Piotr Piórkowski)
- drm/xe/ggtt: Initialize GGTT pools by SR-IOV mode (Piotr Piórkowski)
- drm/xe/ggtt: Split GGTT into usable and shareable pools (Piotr Piórkowski)
- drm/xe/ggtt: Introduce full GGTT range size (Piotr Piórkowski)
- drm/xe/ggtt: Assert lower bound of GGTT PTE address (Piotr Piórkowski)
- drm/xe/guc: Reset TLB invalidation state in submit fini (Piotr Piórkowski)
- drm/xe/query: Use ordered clock reads for engine cycles cpu_delta (Sanjay Yadav)
- drm/xe/doc: Wire up PCI Error Handling (Raag Jadav)
- drm/xe/pci: Introduce PCIe Function Level Reset (Raag Jadav)
- drm/xe: Introduce temporary device wedging (Raag Jadav)
- drm/xe/pm: Introduce xe_device_suspend/resume() (Raag Jadav)
- drm/xe/migrate: Introduce xe_migrate_reinit() and xe_cpu_bind_reinit() (Raag Jadav)
- drm/xe/exec_queue: Introduce xe_exec_queue_reinit() (Raag Jadav)
- drm/xe/bo_evict: Introduce xe_bo_restore_map() (Raag Jadav)
- drm/xe/gt: Introduce FLR helpers (Raag Jadav)
- drm/xe/guc_submit: Introduce guc_exec_queue_reinit_kernel() (Raag Jadav)
- drm/xe/uc_fw: Allow re-initializing firmware (Raag Jadav)
- drm/xe/guc: Define GuC firmware for NVL-P (Daniele Ceraolo Spurio)
- drm/xe/guc: Define GuC firmware for CRI (Daniele Ceraolo Spurio)
- drm/xe/xe_ras: Skip double-bit ECC page offlining on AER path (Riana Tauro)
- drm/xe: Add support for wa_14028434957 (Riana Tauro)
- drm/xe/xe_ras: Add a flag for uncorrectable internal error (Riana Tauro)
- drm/xe/pci: Add upstream switch port lookup helper (Riana Tauro)
- drm/xe/ras: Treat non-fatal PCIe errors as recovered (Riana Tauro)
- drm/xe/survivability: Guard runtime survivability enable against unbind (Riana Tauro)
- drm/xe/hw_error: Initialize hw_error_work per tile (Raag Jadav)
- drm/xe/hw_error: Reuse CSC worker for generic error handling (Raag Jadav)

----------------------------------------------------------------
Arvind Yadav (1):
      drm/xe/irq: Always free requested IRQs on uninstall

Daniele Ceraolo Spurio (2):
      drm/xe/guc: Define GuC firmware for CRI
      drm/xe/guc: Define GuC firmware for NVL-P

Maarten Lankhorst (4):
      drm/xe/display: Avoid using stolen memory for framebuffer when media gt exists.
      drm/xe/migrate: Support copying between sysmem and stolen
      drm/xe: Raise gt frequency slightly earlier.
      drm/i915: Introduce intel_bo_fbdev_bios_fb_takeover()

Matt Roper (1):
      drm/xe/lrc: Fix math in LRC offset comments

Piotr Piórkowski (6):
      drm/xe/guc: Reset TLB invalidation state in submit fini
      drm/xe/ggtt: Assert lower bound of GGTT PTE address
      drm/xe/ggtt: Introduce full GGTT range size
      drm/xe/ggtt: Split GGTT into usable and shareable pools
      drm/xe/ggtt: Initialize GGTT pools by SR-IOV mode
      drm/xe/ggtt: Add KUnit tests for usable and shareable pools

Raag Jadav (12):
      drm/xe/hw_error: Reuse CSC worker for generic error handling
      drm/xe/hw_error: Initialize hw_error_work per tile
      drm/xe/uc_fw: Allow re-initializing firmware
      drm/xe/guc_submit: Introduce guc_exec_queue_reinit_kernel()
      drm/xe/gt: Introduce FLR helpers
      drm/xe/bo_evict: Introduce xe_bo_restore_map()
      drm/xe/exec_queue: Introduce xe_exec_queue_reinit()
      drm/xe/migrate: Introduce xe_migrate_reinit() and xe_cpu_bind_reinit()
      drm/xe/pm: Introduce xe_device_suspend/resume()
      drm/xe: Introduce temporary device wedging
      drm/xe/pci: Introduce PCIe Function Level Reset
      drm/xe/doc: Wire up PCI Error Handling

Rachapalli Bandi Jagadeesh (1):
      drm/xe/pf: Reset PF scheduling defaults on auto provisioning restore

Ranu Maurya (1):
      drm/xe/cri: Add new PCI IDs

Riana Tauro (6):
      drm/xe/survivability: Guard runtime survivability enable against unbind
      drm/xe/ras: Treat non-fatal PCIe errors as recovered
      drm/xe/pci: Add upstream switch port lookup helper
      drm/xe/xe_ras: Add a flag for uncorrectable internal error
      drm/xe: Add support for wa_14028434957
      drm/xe/xe_ras: Skip double-bit ECC page offlining on AER path

Sanjay Yadav (1):
      drm/xe/query: Use ordered clock reads for engine cycles cpu_delta

Thomas Hellström (1):
      drm/xe/dma-buf: Validate BOs on export to charge the exporter

Zongyao Bai (2):
      drm/xe/guc: Treat CT-disabled TLB invalidation as cancelled
      drm/xe/guc: Drop redundant error remap in send_tlb_inval_ggtt_full()

 Documentation/gpu/xe/index.rst                |   1 +
 Documentation/gpu/xe/xe_pci_error.rst         |   8 +
 drivers/gpu/drm/i915/display/intel_bo.c       |   7 +
 drivers/gpu/drm/i915/display/intel_bo.h       |   1 +
 drivers/gpu/drm/i915/display/intel_fbdev.c    |  63 ++++-
 drivers/gpu/drm/i915/i915_bo.c                |  14 +-
 drivers/gpu/drm/i915/i915_bo.h                |   6 -
 drivers/gpu/drm/i915/i915_initial_plane.c     |  14 --
 drivers/gpu/drm/xe/display/xe_display_bo.c    |  70 +++++-
 drivers/gpu/drm/xe/display/xe_display_bo.h    |   6 -
 drivers/gpu/drm/xe/display/xe_initial_plane.c |   8 -
 drivers/gpu/drm/xe/tests/xe_ggtt_kunit.c      | 334 ++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_bo_evict.c              |  43 +++-
 drivers/gpu/drm/xe/xe_bo_evict.h              |   1 +
 drivers/gpu/drm/xe/xe_cpu_bind.c              |  11 +
 drivers/gpu/drm/xe/xe_cpu_bind.h              |   1 +
 drivers/gpu/drm/xe/xe_device.c                | 161 ++++++++++++-
 drivers/gpu/drm/xe/xe_device.h                |   2 +
 drivers/gpu/drm/xe/xe_device_types.h          |   3 +
 drivers/gpu/drm/xe/xe_device_wa_oob.rules     |   1 +
 drivers/gpu/drm/xe/xe_dma_buf.c               |  82 ++++---
 drivers/gpu/drm/xe/xe_exec_queue.c            |  47 +++-
 drivers/gpu/drm/xe/xe_exec_queue.h            |   1 +
 drivers/gpu/drm/xe/xe_exec_queue_types.h      |   2 +
 drivers/gpu/drm/xe/xe_execlist.c              |   6 +
 drivers/gpu/drm/xe/xe_ggtt.c                  | 297 +++++++++++++++++++----
 drivers/gpu/drm/xe/xe_ggtt.h                  |   4 +
 drivers/gpu/drm/xe/xe_gpu_scheduler.c         |  17 ++
 drivers/gpu/drm/xe/xe_gpu_scheduler.h         |   1 +
 drivers/gpu/drm/xe/xe_gpu_scheduler_types.h   |   5 +
 drivers/gpu/drm/xe/xe_gsc.c                   |  14 ++
 drivers/gpu/drm/xe/xe_gsc.h                   |   1 +
 drivers/gpu/drm/xe/xe_gt.c                    |  42 ++++
 drivers/gpu/drm/xe/xe_gt.h                    |   2 +
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c    |   2 +-
 drivers/gpu/drm/xe/xe_guc.c                   |  29 +++
 drivers/gpu/drm/xe/xe_guc.h                   |   2 +
 drivers/gpu/drm/xe/xe_guc_ct.c                |   6 +-
 drivers/gpu/drm/xe/xe_guc_submit.c            |  11 +
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c         |  27 +--
 drivers/gpu/drm/xe/xe_huc.c                   |  14 ++
 drivers/gpu/drm/xe/xe_huc.h                   |   1 +
 drivers/gpu/drm/xe/xe_hw_error.c              |  65 ++++-
 drivers/gpu/drm/xe/xe_hw_error.h              |   1 +
 drivers/gpu/drm/xe/xe_irq.c                   |   6 +-
 drivers/gpu/drm/xe/xe_lrc.c                   |  21 +-
 drivers/gpu/drm/xe/xe_lrc.h                   |   2 +
 drivers/gpu/drm/xe/xe_migrate.c               | 100 ++++++--
 drivers/gpu/drm/xe/xe_migrate.h               |   2 +
 drivers/gpu/drm/xe/xe_pci.c                   |  25 ++
 drivers/gpu/drm/xe/xe_pci.h                   |   1 +
 drivers/gpu/drm/xe/xe_pci_error.c             | 199 +++++++++++++--
 drivers/gpu/drm/xe/xe_pm.c                    | 114 ++-------
 drivers/gpu/drm/xe/xe_pm.h                    |   1 +
 drivers/gpu/drm/xe/xe_query.c                 |   6 +-
 drivers/gpu/drm/xe/xe_ras.c                   |  78 ++++--
 drivers/gpu/drm/xe/xe_ras.h                   |   2 +
 drivers/gpu/drm/xe/xe_ras_types.h             |   2 +
 drivers/gpu/drm/xe/xe_sriov_pf_provision.c    |   7 +
 drivers/gpu/drm/xe/xe_survivability_mode.c    |  10 +
 drivers/gpu/drm/xe/xe_tile_types.h            |   4 +-
 drivers/gpu/drm/xe/xe_uc.c                    |  77 ++++++
 drivers/gpu/drm/xe/xe_uc.h                    |   2 +
 drivers/gpu/drm/xe/xe_uc_fw.c                 |  70 ++++++
 drivers/gpu/drm/xe/xe_uc_fw.h                 |   1 +
 drivers/gpu/drm/xe/xe_uc_types.h              |  14 ++
 drivers/gpu/drm/xe/xe_wedge.c                 |  48 +++-
 drivers/gpu/drm/xe/xe_wedge.h                 |  13 +-
 drivers/gpu/drm/xe/xe_wedge_types.h           |  13 +-
 include/drm/intel/display_parent_interface.h  |   1 +
 include/drm/intel/pciids.h                    |   6 +-
 71 files changed, 1911 insertions(+), 348 deletions(-)
 create mode 100644 Documentation/gpu/xe/xe_pci_error.rst
 create mode 100644 drivers/gpu/drm/xe/tests/xe_ggtt_kunit.c
