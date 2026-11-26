Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D2606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bRGz8uFh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09CA510E9C2;
	Thu, 26 Nov 2026 13:37:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 950CB10E9A5;
 Thu, 26 Nov 2026 13:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795700219; x=1827236219;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=+j5fFMBUvF9lo3irPgTeQLRP0I0UYe+4fWHyTG1svJw=;
 b=bRGz8uFhPKaefgataEmidAZaS3zsq/KVElHv9Dk2vjWnuRK+Y+4xv+zN
 PareO6oBSPNBNqeK4VDMu4lYE9dk2R+ylQ1oewZLDr0VjsR6260/Oe2UT
 ssCDtTUy5J2ghRTAytF9YndizKWZFeM3WkUovqdrLcZA67V9wlSt9HE8u
 z7t3/AOTswSnB40lxWu5SPAPda7xls8MUJZ7eYvg6u0Vc9jWNCkUsw53T
 otvkf0rVFL3zwMwColZ7G0feZXtOIrGcFI/1tYHfu/WskkOSIWlGVFASf
 yGgahR3Z5jMofyq9T1xzR1g7kKM3+P+pa/WHuwQP18K/HOfseq+w8P/rl A==;
X-CSE-ConnectionGUID: 6qLCApi6TTiVKTsFfsMG5A==
X-CSE-MsgGUID: FON+4rmaR8+Y3mLAbCI+KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4628695"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4628695"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 05:36:59 -0800
X-CSE-ConnectionGUID: RwVpAVG8TUWhalyfEqmZYQ==
X-CSE-MsgGUID: dYOKlEuRR8yLDiK3xJyTXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12179410"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO fedora)
 ([10.245.244.247])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 05:36:55 -0800
Date: Thu, 26 Nov 2026 14:36:39 +0100
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
Message-ID: <awg159ip1bk2xbn5@fedora>
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

Hi Dave, Simona.

Here's the drm-xe-next PR for -rc5. Highlights:

- Crescent Island PMT support
  19/19 patches pushed (17 drm/xe/vsec, 2 platform/x86/intel/pmt)
  Adds Platform Monitoring Technology support for Crescent Island (CRI).
  The PMT driver gains a callback infrastructure for driver-specific
  discovery/control access, and the xe vsec code is reworked (probe order,
  PM handling, locking, BMG defines) to expose CRI PMT, late bind firmware
  information and survivability mode through it.
  (Michael J. Ruhl)

- Non-fatal repin retries and NUMA-local rebind worker
  6/6 patches pushed
  Userptr repins that fail with -EBUSY under changing CPU mappings are no
  longer fatal: the rebind worker is requeued on -EAGAIN up to a configurable
  userptr_repin_timeout_ms sysfs timeout. Also restores userptr invalidations
  lost on VMA op unwind, frees preempt fences on VF rebind retry, and runs the
  compute rebind worker on the device's NUMA node.
  (Matthew Auld, Thomas Hellström)

- Expose CRI memory capability limits via sysfs
  3/3 patches pushed
  Adds PCODE MEMORY_CONFIG mailbox definitions, renames xe_vram_freq to
  xe_vram_config, and exposes maximum memory frequency and bandwidth as
  read-only sysfs attributes on CRI for compute runtime capability discovery.
  (Himal Prasad Ghimiray)

- Prepare VFs enabling for VGPU profiles
  3/3 patches pushed
  Splits pf_enable_vfs() into prepare and commit steps with a revert helper so
  upcoming VGPU profile code can reuse it with its own provisioning step. Also
  restores default PF scheduling when VF enabling fails.
  (Michal Wajdeczko, Marcin Bernatowicz)

- Extend CPER records with RAS info queue data
  3/3 patches pushed
  Adds support for retrieving RAS info queue data from the system controller
  and uses it to prepare Intel-specific CPER info records.
  (Badal Nilawar)

- Skip OCODE late bind if already running
  2/2 patches pushed
  OCODE keeps running across reloads and warm resets, so the late-bind worker
  now skips the upload when OCODE is ready. A debug configfs option
  (ocode_force_load) forces the load for testing replacement blobs.
  (Sk Anirban)

- drm/xe: Handle GuC semaphore instruction field check error
  2/2 patches pushed
  Adds a has_sem64 bit to the graphics/media IP descriptors, and uses it to opt
  in to the GuC check of 64-bit semaphore instruction fields and handle the
  resulting G2H error.
  (Jesus Narvaez, Tangudu Tilak Tirumalesh)

- drm/xe: Hold a fence reference while waiting for migration
  2/2 patches pushed
  Fixes a race between xe_migrate_wait() and migration submissions replacing
  m->fence by holding a fence reference while waiting, and centralizes fence
  replacement in a helper.
  (Bommu Krishnaiah)

- Drop repeated SIGID logging
  2/2 patches pushed
  A single page offline error previously logged multiple SIGID messages and
  generated multiple CPERs. SIGID logging is dropped in the page offline and
  sysctrl error paths in favor of plain xe_err()/xe_dbg().
  (Riana Tauro)

- Protect drm_ras against unplugged or wedged device
  2/2 patches pushed
  Fixes drm_ras counter access against an unplugged or wedged device and
  introduces the xe_wedge_mode_is_no_reset() helper.
  (Raag Jadav)

- NVL-P PXP and GSC firmware enablement
  2/2 patches pushed
  Defines the GSC firmware for NVL-P and enables PXP on it.
  (Daniele Ceraolo Spurio)

- WOPCM programming cleanups
  2/2 patches pushed
  Simplifies GuC WOPCM programming and uses the HW-reported size when excluding
  the WOPCM range from the GGTT.
  (Daniele Ceraolo Spurio)


Single patches
--------------

- drm/xe/survivability: Fix infinite loop in aux info traversal (Sk Anirban)
- drm/xe/cper: Add GUIDs for device IDs 6753-6756 (Badal Nilawar)
- drm/xe: Serialize migrate ULLS enter against a pending exit (Fei Yang)
- drm/xe/guc: Reset GuC before unmapping its post-hwconfig buffers (Sujaritha Sundaresan)
- drm/xe/hwmon: Unregister hwmon before the device is unplugged (Rodrigo Vivi)
- drm/xe/gt: Wait for context teardown between default LRC recordings (Nitin Gote)
- drm/xe: Add a per-client debugfs file reporting bo NUMA node distribution (Thomas Hellström)

Thanks,
Thomas

The following changes since commit 72f716775dae43f2f6ea042bc97f6552f5240db7:

  drm/xe/pf: Reset PF scheduling defaults on auto provisioning restore (2026-11-19 11:21:28 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-2026-11-26

for you to fetch changes up to fc2a3dd1a3a2105f34e2f5c7a3e21f82fc0a0851:

  drm/xe: Expose CRI maximum memory frequency and bandwidth in sysfs (2026-11-26 16:52:05 +0530)

----------------------------------------------------------------
Cross-subsystem Changes:

- platform/x86/intel/pmt: Use the pre-populated header info for crashlog (Michael J. Ruhl)
- platform/x86/intel/pmt: Introduce a callback for discovery data (Michael J. Ruhl)

Driver Changes:

- drm/xe: Expose CRI maximum memory frequency and bandwidth in sysfs (Himal Prasad Ghimiray)
- drm/xe/vsec: Add DOC text for VSEC (Michael J. Ruhl)
- drm/xe/wopcm: Simplify GuC WOPCM programming (Daniele Ceraolo Spurio)
- drm/xe: Rename xe_vram_freq to xe_vram_config (Himal Prasad Ghimiray)
- drm/xe/pcode: Add MEMORY_CONFIG mailbox definitions (Himal Prasad Ghimiray)
- drm/xe/survivability: Fix infinite loop in aux info traversal (Sk Anirban)
- drm/xe: Add debug configfs option to force OCODE load (Sk Anirban)
- drm/xe: Skip OCODE late bind if already running (Sk Anirban)
- drm/xe: run compute rebind worker on device NUMA node (Matthew Auld)
- drm/xe/userptr: Make the repin retry loop non-fatal (Thomas Hellström)
- drm/xe: Add a userptr repin timeout sysfs attribute (Thomas Hellström)
- drm/xe: Requeue the rebind worker instead of retrying in-line on -EAGAIN (Thomas Hellström)
- drm/xe/vf: Free preempt fences on rebind worker retry (Thomas Hellström)
- drm/xe/vm: restore userptr invalidations on VMA op unwind (Matthew Auld)
- drm/xe/pf: Split VFs enabling into prepare and commit steps (Michal Wajdeczko)
- drm/xe/pf: Extract VFs enabling revert helper (Michal Wajdeczko)
- drm/xe/pf: Restore default PF scheduling on failed VF enable (Marcin Bernatowicz)
- drm/xe/guc: Handle GuC semaphore instruction field check error (Jesus Narvaez)
- drm/xe: Add has_sem64 bit to graphics/media IP descriptors (Tangudu Tilak Tirumalesh)
- drm/xe/vsec: Support survivability mode for CRI (Michael J. Ruhl)
- drm/xe/vsec: Refactor platform check (Michael J. Ruhl)
- drm/xe/vsec: Update PMT internal access (Michael J. Ruhl)
- drm/xe/vsec: Add PMT GUID internal access (Michael J. Ruhl)
- drm/xe/vsec: Support late bind fw information (Michael J. Ruhl)
- drm/xe/vsec: Crescent Island PMT callbacks (Michael J. Ruhl)
- drm/xe/vsec: Crescent Island PMT decode (Michael J. Ruhl)
- drm/xe/vsec: Support Crescent Island PMT (Michael J. Ruhl)
- drm/xe/vsec: Add base_offset to allow for more flexibilty (Michael J. Ruhl)
- drm/xe/vsec: Update VSEC probe order (Michael J. Ruhl)
- drm/xe/vsec: Refactor BattleMage PMT defines (Michael J. Ruhl)
- drm/xe/vsec: Support possible hotplug exit (Michael J. Ruhl)
- drm/xe/vsec: Use correct pm state get (Michael J. Ruhl)
- drm/xe/vsec: Correct locking order (Michael J. Ruhl)
- drm/xe/vsec: Do not register BMG PMT for VF (Michael J. Ruhl)
- drm/xe/vsec: VSEC requires soc-remapper (Michael J. Ruhl)
- drm/xe: Centralize migration fence updates (Bommu Krishnaiah)
- drm/xe: Hold a fence reference while waiting for migration (Bommu Krishnaiah)
- drm/xe/cper: Add GUIDs for device IDs 6753-6756 (Badal Nilawar)
- drm/xe/ras: Drop SIGID logging for sysctrl errors (Riana Tauro)
- drm/xe/ras: Drop SIGID logging in page offline flow (Riana Tauro)
- drm/xe: Serialize migrate ULLS enter against a pending exit (Fei Yang)
- drm/xe/wedge: Introduce xe_wedge_mode_is_no_reset() (Raag Jadav)
- drm/xe/drm_ras: Protect against unplugged or wedged device (Raag Jadav)
- drm/xe/cper: Prepare Intel CPER info records (Badal Nilawar)
- drm/xe/xe_ras: Add support to retrieve info queue data (Badal Nilawar)
- drm/xe/cper: Drop redundant counter argument (Badal Nilawar)
- drm/xe/guc: Reset GuC before unmapping its post-hwconfig buffers (Sujaritha Sundaresan)
- drm/xe/hwmon: Unregister hwmon before the device is unplugged (Rodrigo Vivi)
- drm/xe/pxp: Enable PXP for NVL-P (Daniele Ceraolo Spurio)
- drm/xe/gsc: Define GSC firmware for NVL-P (Daniele Ceraolo Spurio)
- drm/xe/wopcm: Use the size from HW when excluding the wopcm range from GGTT (Daniele Ceraolo Spurio)
- drm/xe/gt: Wait for context teardown between default LRC recordings (Nitin Gote)
- drm/xe: Add a per-client debugfs file reporting bo NUMA node distribution (Thomas Hellström)

----------------------------------------------------------------
Badal Nilawar (4):
      drm/xe/cper: Drop redundant counter argument
      drm/xe/xe_ras: Add support to retrieve info queue data
      drm/xe/cper: Prepare Intel CPER info records
      drm/xe/cper: Add GUIDs for device IDs 6753-6756

Bommu Krishnaiah (2):
      drm/xe: Hold a fence reference while waiting for migration
      drm/xe: Centralize migration fence updates

Daniele Ceraolo Spurio (4):
      drm/xe/wopcm: Use the size from HW when excluding the wopcm range from GGTT
      drm/xe/wopcm: Simplify GuC WOPCM programming
      drm/xe/gsc: Define GSC firmware for NVL-P
      drm/xe/pxp: Enable PXP for NVL-P

Fei Yang (1):
      drm/xe: Serialize migrate ULLS enter against a pending exit

Himal Prasad Ghimiray (3):
      drm/xe/pcode: Add MEMORY_CONFIG mailbox definitions
      drm/xe: Rename xe_vram_freq to xe_vram_config
      drm/xe: Expose CRI maximum memory frequency and bandwidth in sysfs

Jesus Narvaez (1):
      drm/xe/guc: Handle GuC semaphore instruction field check error

Marcin Bernatowicz (1):
      drm/xe/pf: Restore default PF scheduling on failed VF enable

Matthew Auld (2):
      drm/xe/vm: restore userptr invalidations on VMA op unwind
      drm/xe: run compute rebind worker on device NUMA node

Michael J. Ruhl (19):
      platform/x86/intel/pmt: Introduce a callback for discovery data
      platform/x86/intel/pmt: Use the pre-populated header info for crashlog
      drm/xe/vsec: VSEC requires soc-remapper
      drm/xe/vsec: Do not register BMG PMT for VF
      drm/xe/vsec: Correct locking order
      drm/xe/vsec: Use correct pm state get
      drm/xe/vsec: Add DOC text for VSEC
      drm/xe/vsec: Support possible hotplug exit
      drm/xe/vsec: Refactor BattleMage PMT defines
      drm/xe/vsec: Update VSEC probe order
      drm/xe/vsec: Add base_offset to allow for more flexibilty
      drm/xe/vsec: Support Crescent Island PMT
      drm/xe/vsec: Crescent Island PMT decode
      drm/xe/vsec: Crescent Island PMT callbacks
      drm/xe/vsec: Support late bind fw information
      drm/xe/vsec: Add PMT GUID internal access
      drm/xe/vsec: Update PMT internal access
      drm/xe/vsec: Refactor platform check
      drm/xe/vsec: Support survivability mode for CRI

Michal Wajdeczko (2):
      drm/xe/pf: Extract VFs enabling revert helper
      drm/xe/pf: Split VFs enabling into prepare and commit steps

Nitin Gote (1):
      drm/xe/gt: Wait for context teardown between default LRC recordings

Raag Jadav (2):
      drm/xe/drm_ras: Protect against unplugged or wedged device
      drm/xe/wedge: Introduce xe_wedge_mode_is_no_reset()

Riana Tauro (2):
      drm/xe/ras: Drop SIGID logging in page offline flow
      drm/xe/ras: Drop SIGID logging for sysctrl errors

Rodrigo Vivi (1):
      drm/xe/hwmon: Unregister hwmon before the device is unplugged

Sk Anirban (3):
      drm/xe: Skip OCODE late bind if already running
      drm/xe: Add debug configfs option to force OCODE load
      drm/xe/survivability: Fix infinite loop in aux info traversal

Sujaritha Sundaresan (1):
      drm/xe/guc: Reset GuC before unmapping its post-hwconfig buffers

Tangudu Tilak Tirumalesh (1):
      drm/xe: Add has_sem64 bit to graphics/media IP descriptors

Thomas Hellström (5):
      drm/xe: Add a per-client debugfs file reporting bo NUMA node distribution
      drm/xe/vf: Free preempt fences on rebind worker retry
      drm/xe: Requeue the rebind worker instead of retrying in-line on -EAGAIN
      drm/xe: Add a userptr repin timeout sysfs attribute
      drm/xe/userptr: Make the repin retry loop non-fatal

 .../ABI/testing/sysfs-driver-intel-xe-gpu          |  24 +
 Documentation/gpu/xe/index.rst                     |   1 +
 Documentation/gpu/xe/xe_firmware.rst               |   6 -
 Documentation/gpu/xe/xe_vsec.rst                   |  14 +
 drivers/gpu/drm/xe/Makefile                        |   5 +-
 drivers/gpu/drm/xe/abi/guc_actions_abi.h           |   1 +
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h              |  10 +
 drivers/gpu/drm/xe/regs/xe_pmt.h                   |  12 +-
 drivers/gpu/drm/xe/tests/xe_ggtt_kunit.c           |   4 +-
 drivers/gpu/drm/xe/xe_bo.c                         | 113 ++++
 drivers/gpu/drm/xe/xe_bo.h                         |   6 +
 drivers/gpu/drm/xe/xe_configfs.c                   |  58 ++
 drivers/gpu/drm/xe/xe_configfs.h                   |   1 +
 drivers/gpu/drm/xe/xe_cper.c                       | 271 ++++++++-
 drivers/gpu/drm/xe/xe_cper.h                       |   3 -
 drivers/gpu/drm/xe/xe_cper_types.h                 |  59 +-
 drivers/gpu/drm/xe/xe_debugfs.c                    | 202 ++++++-
 drivers/gpu/drm/xe/xe_debugfs.h                    |   3 +
 drivers/gpu/drm/xe/xe_device.c                     |  36 +-
 drivers/gpu/drm/xe/xe_device.h                     |   3 +
 drivers/gpu/drm/xe/xe_device_sysfs.c               |  57 ++
 drivers/gpu/drm/xe/xe_device_types.h               |  24 +-
 drivers/gpu/drm/xe/xe_drm_ras.c                    |  93 ++-
 drivers/gpu/drm/xe/xe_exec.c                       |   9 +-
 drivers/gpu/drm/xe/xe_ggtt.c                       |  19 +-
 drivers/gpu/drm/xe/xe_gt.c                         |  18 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c         |   1 -
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c                |   1 -
 drivers/gpu/drm/xe/xe_gt_types.h                   |   2 +
 drivers/gpu/drm/xe/xe_guc.c                        |  63 +-
 drivers/gpu/drm/xe/xe_guc_ads.c                    |   3 +-
 drivers/gpu/drm/xe/xe_guc_capture.c                |   3 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                     |   4 +
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  77 ++-
 drivers/gpu/drm/xe/xe_guc_submit.h                 |   3 +
 drivers/gpu/drm/xe/xe_hwmon.c                      |  32 +-
 drivers/gpu/drm/xe/xe_hwmon.h                      |   2 +
 drivers/gpu/drm/xe/xe_late_bind_fw.c               |  11 +
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h         |   2 +
 drivers/gpu/drm/xe/xe_migrate.c                    |  57 +-
 drivers/gpu/drm/xe/xe_pagefault.c                  |   4 +
 drivers/gpu/drm/xe/xe_pci.c                        |  28 +-
 drivers/gpu/drm/xe/xe_pci_error.c                  |   2 +-
 drivers/gpu/drm/xe/xe_pci_sriov.c                  |  91 ++-
 drivers/gpu/drm/xe/xe_pci_types.h                  |   2 +
 drivers/gpu/drm/xe/xe_pcode.c                      |  10 +-
 drivers/gpu/drm/xe/xe_pcode_api.h                  |   4 +
 drivers/gpu/drm/xe/xe_ras.c                        | 254 ++++++--
 drivers/gpu/drm/xe/xe_ras.h                        |   6 +-
 drivers/gpu/drm/xe/xe_ras_types.h                  | 118 +++-
 drivers/gpu/drm/xe/xe_survivability_mode.c         |   8 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h      |   2 +
 drivers/gpu/drm/xe/xe_tile.c                       |  61 ++
 drivers/gpu/drm/xe/xe_tile.h                       |   3 +
 drivers/gpu/drm/xe/xe_tile_sriov_vf.c              |   1 -
 drivers/gpu/drm/xe/xe_tile_sysfs.c                 |   4 +-
 drivers/gpu/drm/xe/xe_tile_types.h                 |   3 +
 drivers/gpu/drm/xe/xe_trace.h                      |   5 +
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c             |  53 +-
 drivers/gpu/drm/xe/xe_uc.c                         | 131 +++-
 drivers/gpu/drm/xe/xe_uc_fw.c                      |  16 +
 drivers/gpu/drm/xe/xe_uc_types.h                   |   3 -
 drivers/gpu/drm/xe/xe_userptr.c                    |  47 +-
 drivers/gpu/drm/xe/xe_userptr.h                    |  53 ++
 drivers/gpu/drm/xe/xe_vm.c                         | 139 +++--
 drivers/gpu/drm/xe/xe_vm.h                         |   6 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c                 |  23 +-
 drivers/gpu/drm/xe/xe_vm_types.h                   |   8 +
 drivers/gpu/drm/xe/xe_vram_config.c                | 217 +++++++
 drivers/gpu/drm/xe/xe_vram_config.h                |  13 +
 drivers/gpu/drm/xe/xe_vram_freq.c                  | 123 ----
 drivers/gpu/drm/xe/xe_vram_freq.h                  |  13 -
 drivers/gpu/drm/xe/xe_vsec.c                       | 666 +++++++++++++++++++--
 drivers/gpu/drm/xe/xe_vsec.h                       |   2 +
 drivers/gpu/drm/xe/xe_wedge.c                      |   5 +-
 drivers/gpu/drm/xe/xe_wedge.h                      |   5 +
 drivers/gpu/drm/xe/xe_wopcm.c                      | 287 ---------
 drivers/gpu/drm/xe/xe_wopcm.h                      |  16 -
 drivers/gpu/drm/xe/xe_wopcm_types.h                |  26 -
 drivers/platform/x86/intel/pmt/class.c             |  18 +-
 drivers/platform/x86/intel/pmt/crashlog.c          |  24 +-
 include/linux/intel_vsec.h                         |  10 +
 82 files changed, 2963 insertions(+), 860 deletions(-)
 create mode 100644 Documentation/gpu/xe/xe_vsec.rst
 create mode 100644 drivers/gpu/drm/xe/xe_vram_config.c
 create mode 100644 drivers/gpu/drm/xe/xe_vram_config.h
 delete mode 100644 drivers/gpu/drm/xe/xe_vram_freq.c
 delete mode 100644 drivers/gpu/drm/xe/xe_vram_freq.h
 delete mode 100644 drivers/gpu/drm/xe/xe_wopcm.c
 delete mode 100644 drivers/gpu/drm/xe/xe_wopcm.h
 delete mode 100644 drivers/gpu/drm/xe/xe_wopcm_types.h
