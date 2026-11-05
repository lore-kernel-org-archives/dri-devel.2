Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96875606D803
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=knscMZkI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA4B1127E0;
	Thu,  5 Nov 2026 15:38:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518201127CC;
 Thu,  5 Nov 2026 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793893123; x=1825429123;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=wcmEgAmrNqkbPp5ErltyteHVDWi7TjyzI0l2SUKvwgo=;
 b=knscMZkI2Y9OcO3dviQKUvH+vsFJqo8ACMJMC2+hpgKw27C9fsxZbdZZ
 OsdAxqUh/SoWWXjxRcH/zba+i9uofIL4EMLQ6C/fSJcsbCYzxSoyLPKWF
 TmOvoeVc9btJeXa9YOe+5Pq2vSURtiWCtt4kTIF7xBQYvnRbjGoXVjPdj
 OLABBgHJB6igRzLpWfiUf7lm0wy8oldrbag97Gm3PgVQIj5dGGgQEqhT0
 P40fL5xIkcBfS33PQa6oO/R6lQFSeZoU+bhc0TEQgJAoqGAG3iBN1REDw
 SAdVcZCtc6z8oYKeejLJaMZuUGmiZMQIiH4PzzfPxiw0dAU/t6ofEs5/L A==;
X-CSE-ConnectionGUID: UzHd/GfASBOUuK+0NtqmRg==
X-CSE-MsgGUID: +h5rI9/pRkukkzZiH6UDbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2691456"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2691456"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 07:38:43 -0800
X-CSE-ConnectionGUID: 2bBNZXhUQ3OFIQ+eWZWirQ==
X-CSE-MsgGUID: EGJlVfcgTrG8il3bFYTwGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7097559"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO fedora)
 ([10.245.244.219])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 07:38:39 -0800
Date: Thu, 5 Nov 2026 16:38:17 +0100
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
Message-ID: <auyi6d4io7J5iiwa@fedora>
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

Here's the first drm-xe-next PR towards 7.5.

Highlights:

Series
------

- drm/xe/hwmon: Update hwmon thermal mailbox (v14)
  16/16 patches pushed
  Adds CRI-specific temperature sensor handling to xe hwmon: sensor
  presence checks, platform-reported VRAM thermal channels, PCIe and memory
  controller temperature support, IEEE-754 / sign-magnitude register
  decoding, cached availability to cut probe time, and several hwmon fixes
  (error propagation, pcode power limit handling).
  (Karthik Poosa)

- Convert IO_BUS errors to structured xe_log API (v7)
  12/12 patches pushed
  Converts error reporting in VRAM, LMTT, PCI, PAT, reg_sr, memirq, MMIO,
  hwmon and GGTT to the structured xe_log API, adding new VRAM, PAT and
  HWMON driver-hardware components. Also makes xe_pat_init_early() return an
  error on unknown platforms.
  (Dnyaneshwar Bhadane)

- Add CPER logging support for CRI (v8)
  10/10 patches pushed
  Adds CPER (Common Platform Error Record) logging of RAS errors reported by
  the device, emitted via a trace event and the xe_log SIGID infrastructure.
  Also converts correctable, SoC internal, core compute and device memory
  error reporting to SIGID.
  (Badal Nilawar)

- drm/xe/sysctrl: Clean up error handling in the System Controller mailbox (v9)
  10/10 patches pushed
  Makes error propagation in the sysctrl mailbox driver consistent and uses
  xe_log_err() for structured reporting. Removes redundant checks, simplifies
  helpers without an error path and fixes mailbox header handling.
  (Mallesh Koujalagi)

- Introduce xe_wedge (v14)
  9/9 patches pushed
  Consolidates the wedging implementation into a dedicated xe_wedge
  component and fixes several pre-existing wedge-handling issues (IRQ-safe
  declare_wedged, runtime PM guards in RAS/AMC/HW error workers, wedge
  worker flushing before bus reset, GT ordered workqueue).
  (Raag Jadav)

- drm/xe: Capture additional HW register state in devcoredump (v7)
  7/7 patches pushed
  Extends the devcoredump with GuC status/capture registers, GT fuses, GAM
  page-fault reports and L3 node status on Xe3p, to make hang and fault
  triage post-mortem dumps self-contained.
  (Nareshkumar Gollakoti)

- Use SIG ID logs for GuC component (v8)
  7/7 patches pushed
  Adds SIG ID logging for GuC CT shutdown, major GuC failures and DMA
  failures, with cleanups of GuC error codes, separate CRASH/EXCEPTION G2H
  handlers, and ct_dead_capture available on non-debug configs.
  (Daniele Ceraolo Spurio, Umesh Nerlige Ramappa)

- Add Ocode late binding support for CRI (v7)
  6/6 patches pushed
  Refactors the late-bind PM flow and adds Ocode (OOBMSM telemetry/
  manageability) firmware loading on CRI, with status-code string mappings,
  a flag-to-mask conversion and a firmware leak fix.
  (Badal Nilawar)

- Add support to handle memory double-bit ECC errors (v6)
  6/6 patches pushed
  Adds the firmware commands needed to handle uncorrectable memory
  double-bit ECC errors: page offline requests and queue/list queries via
  sysctrl, tracking of firmware-offlined pages, and reporting max_pages to
  userspace.
  (Riana Tauro)

- Fix memory corruption with unaligned dst in MEM_COPY (v5)
  4/4 patches pushed
  Fixes xe_migrate_access_memory() corruption on BMG when the MATRIX_COPY
  destination is not pitch aligned, fixes page tracking, optimizes unaligned
  copies and adds a subtest.
  (Jan Maslak, Christoph Manszewski)

- Split the BO shrinker and adjust batch size (v5)
  4/4 patches pushed
  Sets the shrinker batch size from the average BO size, splits the shrinker
  into purgeable and non-purgeable ones, tracks populated ttm_tts and no
  longer aborts the shrinker walk on -EBUSY.
  (Thomas Hellström)

- Split GuC ID space into usable and shareable pools (v7)
  4/4 patches pushed
  Separates GuC IDs usable for submission from IDs shareable with VFs in the
  ID manager, with dedicated allocation interfaces, accounting and KUnit
  coverage.
  (Piotr Piórkowski)

- Follow-up fixes for memory page offline (v2)
  4/4 patches pushed
  Addresses review comments on page offline: drops RCU list handling for
  VRAM bad-page tracking, re-validates external pin under the resv lock,
  keeps fault injection in the usable range and fixes kernel-doc.
  (Tejas Upadhyay)

- access_memory chunking fixes and tests (no cover letter)
  3/3 patches pushed
  Keeps access_memory chunks within the transfer limit and extends the
  tests to cover large writes to unaligned BO offsets and short bounce-
  buffered accesses.
  (Mika Kuoppala)

- drm/xe: Some D3Cold related fixes (v4)
  3/3 patches pushed
  Toggles the D3Cold enable flag on runtime resume, accesses GT MMIO only
  after pcode init and memsets the g2g buffer on resume.
  (Vinay Belgaumkar)

- drm/xe: Update Wa_14026539277 (v5)
  3/3 patches pushed
  Reverts the old implementation and adds the up-to-date one after the
  workaround database changed; extracts override_has_cached_pt().
  (Gustavo Sousa)

- Improve HW reserved PAT checking (v3)
  3/3 patches pushed
  Replaces the !coh_mode based check for HW reserved PAT indices with
  pat.valid and hardens all PAT index queries accordingly.
  (Matthew Auld)

- Fix kernel crash during driver teardown (v7)
  3/3 patches pushed
  Disables the GT reset worker before engine teardown, protects GuC timeout
  handling from device unplug and prevents the VF memory IRQ handler from
  accessing a torn-down engine.
  (Satyanarayana K V P)

- GuC: Compress GuC log and CTB dump with zstd (v11)
  3/3 patches pushed
  Adds a dump cache and zstd compression of large GuC log/CTB snapshot
  payloads and trims noise in the LRC snapshot output.
  (Zhanjun Dong, Alan Previn)

- drm/xe/sysctrl: Add system controller debugfs (v8)
  3/3 patches pushed
  Adds sysctrl debugfs infrastructure with a loopback test, RAS error
  injection and a generic mailbox passthrough entry for firmware validation.
  (Anoop Vijay)

- Fix two BO pin/unpin accounting bugs (v3)
  2/2 patches pushed
  Fixes shrinker accounting double-subtraction on nested external pins and a
  stale pinned_link entry when fb-pin performs the final unpin.
  (Thomas Hellström)

- Don't dereference a NULL resource in xe_evict_flags() (v3)
  2/2 patches pushed
  Skips eviction of a BO without a ttm resource (e.g. imported dma-buf BO
  being torn down) and adds a regression test.
  (Niranjana Vishwanathapura)

- drm/xe/nvm: Add survivability partition (v3)
  2/2 patches pushed (1 xe, 1 mtd: mtd_intel_dg)
  Defines a survivability partition covering the whole storage so a card in
  survivability mode can recover from a corrupted partition table. The mtd
  patch went in via drm with the MTD maintainer's ack.
  (Alexander Usyskin)

- drm/xe/tuning: Fix Xe3p tuning register mismatches
  2/2 patches pushed
  Stops applying obsolete media CCCHKNREG1/L3SQCREG3 tunings from Xe3p
  onward and restricts the Anyhit NULL-query tuning to render engines.
  (Nitin Gote)

- Intel Xe GPU debug support (eudebug) (v10)
  1/27 patches pushed
  Only the xe-relevant subset was pushed: removes the ifdef in the
  DRM_GPUVA_OP_DRIVER svm sub-op checking.
  (Mika Kuoppala)


Single patches
--------------

- drm/xe/svm: Preserve default PAT index when resetting VMA attributes (Arvind Yadav)
- drm/xe/eu_stall: Don't mark stream enabled if enable fails (Fei Yang)
- drm/xe/guc: Add WA 14028709524 to disable PRL from VF (Alan Previn)
- drm/xe/vf: Move H2G CTB to VRAM on VF (Piotr Piórkowski)
- drm/xe/hwmon: Use overflows_type() for temperature range check (Mallesh Koujalagi)
- drm/xe/dma-buf: Add xe_dma_buf_to_gem() self-import helper (Niranjana Vishwanathapura)
- drm/xe/cri: Add new PCI ID (Balasubramani Vivekanandan)
- drm/xe/guc: Do not attribute a TDR disable to a pending suspend (Jagmeet Randhawa)
- drm/xe: Rebind BOs evicted before the first LR queue (Arvind Yadav)
- drm/xe: Extend Wa_16030224309 to graphics version 35.11 (Tangudu Tilak Tirumalesh)
- drm/xe/madvise: use already clamped pat_index (Matthew Auld)
- drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m (Rodrigo Vivi)
- drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2 (Helen Koike)
- drm/xe: Tie BO TTM LRU priority to DONTNEED/WILLNEED madvise state (Matthew Brost)
- drm/xe/xe3: Fix OAM stream broken on Xe3+ (Shekhar Chauhan)
- drm/xe: Mark xe_vma_ops_alloc() noinline for error injection (Shuicheng Lin)
- drm/xe/gsc: Fix NVL-S GSC compatibility number (Daniele Ceraolo Spurio)
- drm/xe/uc: Add missing HuC firmware entry for Alderlake-N (Kumar, Sachin)
- drm/xe: Bump LRU for external objects on exec and rebind (Thomas Hellström)
- drm/xe/oa: Zero OA buffer at allocation (Bommu Krishnaiah)
- drm/xe/log: fix documentation title levels (Guillaume Tucker)
- drm/xe/ras: Fix sysctrl and drm-ras discrepancy (Raag Jadav)
- drm/xe/sysctrl: Add mailbox control state to error messages (Anoop Vijay)
- drm/xe: Don't transfer shrinker pages for pinned bos on purgeable state change (Thomas Hellström)
- drm/xe/i2c: cancel the client work on remove (Fan Wu)
- drm/xe: Don't allow XE_VALIDATION_UNIMPLEMENTED outside of debug builds (Thomas Hellström)
- drm/xe/xe3p: Read resource copy presence from fuse register (Matt Roper)
- drm/xe: Unwrap sync fences before adding them as job dependencies (Chen, Junjia)

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-2026-11-05

for you to fetch changes up to 3b8860fe2581a8db796150728687ba1c6b78ddab:

  drm/xe: Unwrap sync fences before adding them as job dependencies (2026-11-04 14:44:09 -0800)

----------------------------------------------------------------
Cross-subsystem Changes:

- mtd: mtd_intel_dg: add survivability partition (Alexander Usyskin)

Core Changes:

- drm/xe/cri: Add new PCI ID (Balasubramani Vivekanandan)

Driver Changes:

- drm/xe: Unwrap sync fences before adding them as job dependencies (Chen, Junjia)
- drm/xe/svm: Preserve default PAT index when resetting VMA attributes (Arvind Yadav)
- drm/xe/guc: capture additional engine state registers (Nareshkumar Gollakoti)
- drm/xe: capture L3 node status registers in devcoredump (Nareshkumar Gollakoti)
- drm/xe/guc: add TDL, SLICE gfx registers to capture list (Nareshkumar Gollakoti)
- drm/xe: dump GAM page fault report registers in devcoredump (Nareshkumar Gollakoti)
- drm/xe/guc: Print register addresses in capture snapshot output (Nareshkumar Gollakoti)
- drm/xe/devcoredump: Add GuC register snapshot to devcoredump (Nareshkumar Gollakoti)
- drm/xe/devcoredump: Capture GT fuse registers in devcoredump (Nareshkumar Gollakoti)
- drm/xe/xe_late_bind_fw: Refactor pm flow (Badal Nilawar)
- drm/xe/xe_late_bind_fw: Enable late binding support for CRI (Badal Nilawar)
- drm/xe/xe_late_bind_fw: Add support to load Ocode firmware (Badal Nilawar)
- drm/xe/xe_late_bind_fw: Convert late bind flag to mask (Badal Nilawar)
- drm/xe/xe_late_bind_fw: Add string mappings of status codes (Badal Nilawar)
- drm/xe/xe_late_bind_fw: Fix firmware leak on missing manifest entry (Badal Nilawar)
- drm/xe/eu_stall: Don't mark stream enabled if enable fails (Fei Yang)
- drm/xe/guc: Add WA 14028709524 to disable PRL from VF (Alan Previn)
- drm/xe/vf: Move H2G CTB to VRAM on VF (Piotr Piórkowski)
- drm/xe/hwmon: Use overflows_type() for temperature range check (Mallesh Koujalagi)
- drm/xe/dma-buf: Add xe_dma_buf_to_gem() self-import helper (Niranjana Vishwanathapura)
- drm/xe/tests: Keep bounce buffered accesses short in access_memory test (Mika Kuoppala)
- drm/xe/tests: Cover a large write to an unaligned bo offset (Mika Kuoppala)
- drm/xe/migrate: Keep access_memory chunks within the transfer limit (Mika Kuoppala)
- drm/xe: Memset g2g buffer on resume (Vinay Belgaumkar)
- drm/xe: Access GT MMIO after pcode init (Vinay Belgaumkar)
- drm/xe: Toggle the D3Cold enable flag at runtime resume (Vinay Belgaumkar)
- drm/xe/xe_ras: Report correctable errors using SIGID (Badal Nilawar)
- drm/xe/xe_ras: Report soc internal errors using SIGID (Badal Nilawar)
- drm/xe/xe_ras: Report core compute errors using SIGID (Badal Nilawar)
- drm/xe/xe_ras: Report device memory errors using SIGID (Badal Nilawar)
- drm/xe/cper: Emit cper record to trace buf (Badal Nilawar)
- drm/xe/cper: Construct CPER record for hardware errors (Badal Nilawar)
- drm/xe/cper: Initialize Intel-specific CPER header (Badal Nilawar)
- drm/xe/cper: Retrieve the error counter record for CPER reporting (Badal Nilawar)
- drm/xe/cper: Add CPER reporting entry point for xe_log (Badal Nilawar)
- drm/xe: Add up-to-date implementation for Wa_14026539277 (Gustavo Sousa)
- Revert "drm/xe/nvlp: Implement Wa_14026539277" (Gustavo Sousa)
- drm/xe: Extract override_has_cached_pt() (Gustavo Sousa)
- drm/xe/guc: Do not attribute a TDR disable to a pending suspend (Jagmeet Randhawa)
- drm/xe: Remove ifdef in DRM_GPUVA_OP_DRIVER svm subop checking (Mika Kuoppala)
- drm/xe: Rebind BOs evicted before the first LR queue (Arvind Yadav)
- drm/xe: Extend Wa_16030224309 to graphics version 35.11 (Tangudu Tilak Tirumalesh)
- drm/xe/tuning: Stop applying media CCCHKNREG1 tuning from Xe3p onward (Nitin Gote)
- drm/xe/pat: always check is_valid() when querying an index (Matthew Auld)
- drm/xe: revamp hw reserved PAT index checking (Matthew Auld)
- drm/xe/pat: initialise pat.valid everywhere (Matthew Auld)
- drm/xe/ras: Move xe_ras_process_errors() to xe_ras (Raag Jadav)
- drm/xe/amc: Guard xe_amc_work() with runtime PM (Raag Jadav)
- drm/xe/pci_error: Flush GT wedge worker before bus reset (Raag Jadav)
- drm/xe: Make xe_device_declare_wedged() IRQ safe (Raag Jadav)
- drm/xe: Move xe_device_wedged_fini() registration to xe_device_probe_early() (Raag Jadav)
- drm/xe/hw_error: Guard csc_hw_error_work() with runtime PM (Raag Jadav)
- drm/xe: Drop xe_device_set_wedged_method() (Raag Jadav)
- drm/xe/gt: Use GT ordered workqueue for wedging (Raag Jadav)
- drm/xe/tests: Add xe_migrate_access_memory subtest (Jan Maslak)
- drm/xe/xe_migrate: Optimize unaligned access_memory copies (Jan Maslak)
- drm/xe/xe_migrate: Align MEM_COPY pitch with destination address (Christoph Manszewski)
- drm/xe/xe_migrate: Fix page tracking in access_memory (Christoph Manszewski)
- drm/xe/madvise: use already clamped pat_index (Matthew Auld)
- drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m (Rodrigo Vivi)
- drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2 (Helen Koike)
- drm/xe: Tie BO TTM LRU priority to DONTNEED/WILLNEED madvise state (Matthew Brost)
- drm/xe/xe3: Fix OAM stream broken on Xe3+ (Shekhar Chauhan)
- drm/xe: Mark xe_vma_ops_alloc() noinline for error injection (Shuicheng Lin)
- drm/xe: Update non-purgeable shrinker batch size based on average BO size (Thomas Hellström)
- drm/xe: Split the bo shrinker into purgeable and non-purgeable shrinkers (Thomas Hellström)
- drm/xe: Track number of populated ttm_tts in the shrinker (Thomas Hellström)
- drm/xe: Don't abort the shrinker walk on -EBUSY (Thomas Hellström)
- drm/xe/guc: Report errors that cause a CT shutdown using SIGID (Daniele Ceraolo Spurio)
- drm/xe/guc: Report major GuC failures using SIGID (Daniele Ceraolo Spurio)
- drm/xe/uc: Report DMA failure using SIGID (Daniele Ceraolo Spurio)
- drm/xe/guc: Cleanup error codes and handling for CT errors (Umesh Nerlige Ramappa)
- drm/xe/guc: Make ct_dead_capture available on non-debug config (Umesh Nerlige Ramappa)
- drm/xe/guc: Handle CRASH and EXCEPTION G2H with separate helpers (Umesh Nerlige Ramappa)
- drm/xe/guc: Use different error codes for GuC load errors (Daniele Ceraolo Spurio)
- drm/xe/gsc: Fix NVL-S GSC compatibility number (Daniele Ceraolo Spurio)
- drm/xe/pf: Explicitly use shareable GuC IDs for VFs provisioning (Piotr Piórkowski)
- drm/xe/guc: Start use explicitly usable GuC IDs for for submission (Piotr Piórkowski)
- drm/xe/kunit: Extend GuC ID manager split-pool coverage (Piotr Piórkowski)
- drm/xe/guc: Split GuC ID manager into usable and shareable pools (Piotr Piórkowski)
- drm/xe/tuning: Restrict Anyhit NULL-query tuning to render engines (Nitin Gote)
- drm/xe/hwmon: Propagate all hardware read errors (Karthik Poosa)
- drm/xe: Validate thermal sensor count before reads (Karthik Poosa)
- drm/xe/hwmon: Simplify temperature channels config (Karthik Poosa)
- drm/xe/hwmon: add PCIe temperature support for CRI (Karthik Poosa)
- drm/xe/hwmon: Update memory controller temperature offset for CRI (Karthik Poosa)
- drm/xe/hwmon: Decode CRI temperature registers as IEEE-754 (Karthik Poosa)
- drm/xe/hwmon: Add platform-aware VRAM thermal channel support (Karthik Poosa)
- drm/xe/hwmon: use CRI-specific package and VRAM temperature registers (Karthik Poosa)
- drm/xe/hwmon: Cache temperature availability to reduce probe time (Karthik Poosa)
- drm/xe/hwmon: Consolidate temperature sensor availability checks (Karthik Poosa)
- drm/xe/hwmon: Detect unavailable PCIe thermal sensors (Karthik Poosa)
- drm/xe/hwmon: Handle unavailable memory controller sensors (Karthik Poosa)
- drm/xe/hwmon: Add helpers to validate thermal sensor readings (Karthik Poosa)
- drm/xe/hwmon: Fix thermal sensor data handling (Karthik Poosa)
- drm/xe/hwmon: Decode mailbox temperature as sign-magnitude (Karthik Poosa)
- drm/xe/hwmon: Fix pcode power limit handling (Karthik Poosa)
- drm/xe/xe_ras: Track offlined pages by firmware to avoid duplicates (Riana Tauro)
- drm/xe/xe_ttm_vram: Report max_pages reported by firmware to userspace (Riana Tauro)
- drm/xe/xe_ras: Add function to get maximum pages firmware can store (Riana Tauro)
- drm/xe/xe_ras: Add support to query page offline queue and list (Riana Tauro)
- drm/xe/xe_ras: Handle page offline requests for device memory ecc errors (Riana Tauro)
- drm/xe: Separate drm-ras netlink data from device and firmware RAS state (Riana Tauro)
- drm/xe/gt: Disable GT reset worker before engine teardown (Satyanarayana K V P)
- drm/xe/guc: Protect timeout handling from device unplug (Satyanarayana K V P)
- drm/xe: Prevent VF memory IRQ from accessing a torn-down engine (Satyanarayana K V P)
- drm/xe/guc: Add dump_cache to optimize GuC CT/Log compression flow (Alan Previn)
- drm/xe/guc: Compress GuC log and CTB dump with zstd (Zhanjun Dong)
- drm/xe: Remove extra newlines from LRC snapshot dump (Zhanjun Dong)
- drm/xe/vram: Report VRAM errors using structured xe_log API (Dnyaneshwar Bhadane)
- drm/xe/vram: Report tile vs device VRAM visibility errors (Dnyaneshwar Bhadane)
- drm/xe/lmtt: Report invalidation errors using structured xe_log API (Dnyaneshwar Bhadane)
- drm/xe/pci: Report unknown GMDID versions using structured xe_log API (Dnyaneshwar Bhadane)
- drm/xe/pat: Report missing PAT table using structured xe_log API (Dnyaneshwar Bhadane)
- drm/xe/pat: Return error from xe_pat_init_early() on unknown platform (Dnyaneshwar Bhadane)
- drm/xe/reg_sr: Report save-restore errors using structured xe_log API (Dnyaneshwar Bhadane)
- drm/xe/memirq: Report errors using structured xe_log API (Dnyaneshwar Bhadane)
- drm/xe/mmio: Report BAR mapping errors using structured xe_log API (Dnyaneshwar Bhadane)
- drm/xe/hwmon: Report errors using structured xe_log API (Dnyaneshwar Bhadane)
- drm/xe/ggtt: Report GGTT errors using structured logging (Dnyaneshwar Bhadane)
- drm/xe/log: Add VRAM, PAT, and HWMON DRIVER_HARDWARE components (Dnyaneshwar Bhadane)
- drm/xe/uc: Add missing HuC firmware entry for Alderlake-N (Kumar, Sachin)
- drm/xe: Bump LRU for external objects on exec and rebind (Thomas Hellström)
- drm/xe/oa: Zero OA buffer at allocation (Bommu Krishnaiah)
- drm/xe/tests: add regression for eviction of a BO with no resource (Niranjana Vishwanathapura)
- drm/xe: skip eviction of a BO with no resource (Niranjana Vishwanathapura)
- drm/xe/log: fix documentation title levels (Guillaume Tucker)
- drm/xe/ras: Fix sysctrl and drm-ras discrepancy (Raag Jadav)
- drm/xe/sysctrl: Add mailbox control state to error messages (Anoop Vijay)
- drm/xe: Don't transfer shrinker pages for pinned bos on purgeable state change (Thomas Hellström)
- drm/xe/nvm: define survivability partition (Alexander Usyskin)
- drm/xe: Keep VRAM fault injection within the usable range (Tejas Upadhyay)
- drm/xe: Drop RCU list handling for VRAM bad-page tracking, use mgr->lock (Tejas Upadhyay)
- drm/xe: Re-validate external pin under resv lock before VRAM purge (Tejas Upadhyay)
- drm/xe: Clean up kernel-doc typos in VRAM manager (Tejas Upadhyay)
- drm/xe/i2c: cancel the client work on remove (Fan Wu)
- drm/xe: Don't allow XE_VALIDATION_UNIMPLEMENTED outside of debug builds (Thomas Hellström)
- drm/xe/sysctrl: Report 'System Controller event' error using SIGID (Mallesh Koujalagi)
- drm/xe/sysctrl: Log group and command ID on mailbox failure (Mallesh Koujalagi)
- drm/xe/sysctrl: Improve firmware response error logging (Mallesh Koujalagi)
- drm/xe/sysctrl: Replace FIELD_GET() with REG_FIELD_GET() (Mallesh Koujalagi)
- drm/xe/sysctrl: Fix mailbox header handling (Mallesh Koujalagi)
- drm/xe/sysctrl: Use xe_assert() for payload size validation (Mallesh Koujalagi)
- drm/xe/sysctrl: Make sysctrl_read_frame() void (Mallesh Koujalagi)
- drm/xe/sysctrl: Make sysctrl_write_frame() void (Mallesh Koujalagi)
- drm/xe/sysctrl: Return error codes from sysctrl_wait_bit_set() (Mallesh Koujalagi)
- drm/xe/sysctrl: Return error codes from sysctrl_wait_bit_clear() (Mallesh Koujalagi)
- drm/xe/xe3p: Read resource copy presence from fuse register (Matt Roper)
- drm/xe/sysctrl: Add generic mailbox passthrough debugfs entry (Anoop Vijay)
- drm/xe/sysctrl: Add RAS error injection debugfs interface (Anoop Vijay)
- drm/xe/sysctrl: Add sysctrl debugfs infrastructure and loopback test interface (Anoop Vijay)
- drm/xe: Fix stale pinned_link entry when fb-pin performs the final unpin (Thomas Hellström)
- drm/xe: Fix shrinker accounting double-subtraction on nested external pins (Thomas Hellström)
- drm/xe/cper: Log CPER records for aggregate counter retrieval (Badal Nilawar)
- drm/xe: Introduce xe_wedge (Raag Jadav)

----------------------------------------------------------------
Alan Previn (2):
      drm/xe/guc: Add dump_cache to optimize GuC CT/Log compression flow
      drm/xe/guc: Add WA 14028709524 to disable PRL from VF

Alexander Usyskin (2):
      mtd: mtd_intel_dg: add survivability partition
      drm/xe/nvm: define survivability partition

Anoop Vijay (4):
      drm/xe/sysctrl: Add sysctrl debugfs infrastructure and loopback test interface
      drm/xe/sysctrl: Add RAS error injection debugfs interface
      drm/xe/sysctrl: Add generic mailbox passthrough debugfs entry
      drm/xe/sysctrl: Add mailbox control state to error messages

Arvind Yadav (2):
      drm/xe: Rebind BOs evicted before the first LR queue
      drm/xe/svm: Preserve default PAT index when resetting VMA attributes

Badal Nilawar (16):
      drm/xe/cper: Add CPER reporting entry point for xe_log
      drm/xe/cper: Retrieve the error counter record for CPER reporting
      drm/xe/cper: Initialize Intel-specific CPER header
      drm/xe/cper: Construct CPER record for hardware errors
      drm/xe/cper: Log CPER records for aggregate counter retrieval
      drm/xe/cper: Emit cper record to trace buf
      drm/xe/xe_ras: Report device memory errors using SIGID
      drm/xe/xe_ras: Report core compute errors using SIGID
      drm/xe/xe_ras: Report soc internal errors using SIGID
      drm/xe/xe_ras: Report correctable errors using SIGID
      drm/xe/xe_late_bind_fw: Fix firmware leak on missing manifest entry
      drm/xe/xe_late_bind_fw: Add string mappings of status codes
      drm/xe/xe_late_bind_fw: Convert late bind flag to mask
      drm/xe/xe_late_bind_fw: Add support to load Ocode firmware
      drm/xe/xe_late_bind_fw: Enable late binding support for CRI
      drm/xe/xe_late_bind_fw: Refactor pm flow

Balasubramani Vivekanandan (2):
      drm/xe/cri: Add new PCI ID
      drm/xe/cri: Add new PCI ID

Bommu Krishnaiah (1):
      drm/xe/oa: Zero OA buffer at allocation

Chen, Junjia (1):
      drm/xe: Unwrap sync fences before adding them as job dependencies

Christoph Manszewski (2):
      drm/xe/xe_migrate: Fix page tracking in access_memory
      drm/xe/xe_migrate: Align MEM_COPY pitch with destination address

Daniele Ceraolo Spurio (5):
      drm/xe/gsc: Fix NVL-S GSC compatibility number
      drm/xe/guc: Use different error codes for GuC load errors
      drm/xe/uc: Report DMA failure using SIGID
      drm/xe/guc: Report major GuC failures using SIGID
      drm/xe/guc: Report errors that cause a CT shutdown using SIGID

Dnyaneshwar Bhadane (12):
      drm/xe/log: Add VRAM, PAT, and HWMON DRIVER_HARDWARE components
      drm/xe/ggtt: Report GGTT errors using structured logging
      drm/xe/hwmon: Report errors using structured xe_log API
      drm/xe/mmio: Report BAR mapping errors using structured xe_log API
      drm/xe/memirq: Report errors using structured xe_log API
      drm/xe/reg_sr: Report save-restore errors using structured xe_log API
      drm/xe/pat: Return error from xe_pat_init_early() on unknown platform
      drm/xe/pat: Report missing PAT table using structured xe_log API
      drm/xe/pci: Report unknown GMDID versions using structured xe_log API
      drm/xe/lmtt: Report invalidation errors using structured xe_log API
      drm/xe/vram: Report tile vs device VRAM visibility errors
      drm/xe/vram: Report VRAM errors using structured xe_log API

Fan Wu (1):
      drm/xe/i2c: cancel the client work on remove

Fei Yang (1):
      drm/xe/eu_stall: Don't mark stream enabled if enable fails

Guillaume Tucker (1):
      drm/xe/log: fix documentation title levels

Gustavo Sousa (3):
      drm/xe: Extract override_has_cached_pt()
      Revert "drm/xe/nvlp: Implement Wa_14026539277"
      drm/xe: Add up-to-date implementation for Wa_14026539277

Helen Koike (1):
      drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2

Jagmeet Randhawa (2):
      drm/xe/guc: Fix race around q->guc->suspend_pending access
      drm/xe/guc: Do not attribute a TDR disable to a pending suspend

Jan Maslak (2):
      drm/xe/xe_migrate: Optimize unaligned access_memory copies
      drm/xe/tests: Add xe_migrate_access_memory subtest

Karthik Poosa (16):
      drm/xe/hwmon: Fix pcode power limit handling
      drm/xe/hwmon: Decode mailbox temperature as sign-magnitude
      drm/xe/hwmon: Fix thermal sensor data handling
      drm/xe/hwmon: Add helpers to validate thermal sensor readings
      drm/xe/hwmon: Handle unavailable memory controller sensors
      drm/xe/hwmon: Detect unavailable PCIe thermal sensors
      drm/xe/hwmon: Consolidate temperature sensor availability checks
      drm/xe/hwmon: Cache temperature availability to reduce probe time
      drm/xe/hwmon: use CRI-specific package and VRAM temperature registers
      drm/xe/hwmon: Add platform-aware VRAM thermal channel support
      drm/xe/hwmon: Decode CRI temperature registers as IEEE-754
      drm/xe/hwmon: Update memory controller temperature offset for CRI
      drm/xe/hwmon: add PCIe temperature support for CRI
      drm/xe/hwmon: Simplify temperature channels config
      drm/xe: Validate thermal sensor count before reads
      drm/xe/hwmon: Propagate all hardware read errors

Kumar, Sachin (1):
      drm/xe/uc: Add missing HuC firmware entry for Alderlake-N

Mallesh Koujalagi (11):
      drm/xe/sysctrl: Return error codes from sysctrl_wait_bit_clear()
      drm/xe/sysctrl: Return error codes from sysctrl_wait_bit_set()
      drm/xe/sysctrl: Make sysctrl_write_frame() void
      drm/xe/sysctrl: Make sysctrl_read_frame() void
      drm/xe/sysctrl: Use xe_assert() for payload size validation
      drm/xe/sysctrl: Fix mailbox header handling
      drm/xe/sysctrl: Replace FIELD_GET() with REG_FIELD_GET()
      drm/xe/sysctrl: Improve firmware response error logging
      drm/xe/sysctrl: Log group and command ID on mailbox failure
      drm/xe/sysctrl: Report 'System Controller event' error using SIGID
      drm/xe/hwmon: Use overflows_type() for temperature range check

Matt Roper (1):
      drm/xe/xe3p: Read resource copy presence from fuse register

Matthew Auld (4):
      drm/xe/madvise: use already clamped pat_index
      drm/xe/pat: initialise pat.valid everywhere
      drm/xe: revamp hw reserved PAT index checking
      drm/xe/pat: always check is_valid() when querying an index

Matthew Brost (1):
      drm/xe: Tie BO TTM LRU priority to DONTNEED/WILLNEED madvise state

Mika Kuoppala (4):
      drm/xe: Remove ifdef in DRM_GPUVA_OP_DRIVER svm subop checking
      drm/xe/migrate: Keep access_memory chunks within the transfer limit
      drm/xe/tests: Cover a large write to an unaligned bo offset
      drm/xe/tests: Keep bounce buffered accesses short in access_memory test

Nareshkumar Gollakoti (7):
      drm/xe/devcoredump: Capture GT fuse registers in devcoredump
      drm/xe/devcoredump: Add GuC register snapshot to devcoredump
      drm/xe/guc: Print register addresses in capture snapshot output
      drm/xe: dump GAM page fault report registers in devcoredump
      drm/xe/guc: add TDL, SLICE gfx registers to capture list
      drm/xe: capture L3 node status registers in devcoredump
      drm/xe/guc: capture additional engine state registers

Niranjana Vishwanathapura (3):
      drm/xe: skip eviction of a BO with no resource
      drm/xe/tests: add regression for eviction of a BO with no resource
      drm/xe/dma-buf: Add xe_dma_buf_to_gem() self-import helper

Nitin Gote (2):
      drm/xe/tuning: Restrict Anyhit NULL-query tuning to render engines
      drm/xe/tuning: Stop applying media CCCHKNREG1 tuning from Xe3p onward

Piotr Piórkowski (5):
      drm/xe/guc: Split GuC ID manager into usable and shareable pools
      drm/xe/kunit: Extend GuC ID manager split-pool coverage
      drm/xe/guc: Start use explicitly usable GuC IDs for for submission
      drm/xe/pf: Explicitly use shareable GuC IDs for VFs provisioning
      drm/xe/vf: Move H2G CTB to VRAM on VF

Raag Jadav (10):
      drm/xe/ras: Fix sysctrl and drm-ras discrepancy
      drm/xe/gt: Use GT ordered workqueue for wedging
      drm/xe: Drop xe_device_set_wedged_method()
      drm/xe/hw_error: Guard csc_hw_error_work() with runtime PM
      drm/xe: Move xe_device_wedged_fini() registration to xe_device_probe_early()
      drm/xe: Make xe_device_declare_wedged() IRQ safe
      drm/xe/pci_error: Flush GT wedge worker before bus reset
      drm/xe/amc: Guard xe_amc_work() with runtime PM
      drm/xe: Introduce xe_wedge
      drm/xe/ras: Move xe_ras_process_errors() to xe_ras

Riana Tauro (6):
      drm/xe: Separate drm-ras netlink data from device and firmware RAS state
      drm/xe/xe_ras: Handle page offline requests for device memory ecc errors
      drm/xe/xe_ras: Add support to query page offline queue and list
      drm/xe/xe_ras: Add function to get maximum pages firmware can store
      drm/xe/xe_ttm_vram: Report max_pages reported by firmware to userspace
      drm/xe/xe_ras: Track offlined pages by firmware to avoid duplicates

Rodrigo Vivi (1):
      drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m

Satyanarayana K V P (3):
      drm/xe: Prevent VF memory IRQ from accessing a torn-down engine
      drm/xe/guc: Protect timeout handling from device unplug
      drm/xe/gt: Disable GT reset worker before engine teardown

Shekhar Chauhan (1):
      drm/xe/xe3: Fix OAM stream broken on Xe3+

Shuicheng Lin (1):
      drm/xe: Mark xe_vma_ops_alloc() noinline for error injection

Tangudu Tilak Tirumalesh (1):
      drm/xe: Extend Wa_16030224309 to graphics version 35.11

Tejas Upadhyay (4):
      drm/xe: Clean up kernel-doc typos in VRAM manager
      drm/xe: Re-validate external pin under resv lock before VRAM purge
      drm/xe: Drop RCU list handling for VRAM bad-page tracking, use mgr->lock
      drm/xe: Keep VRAM fault injection within the usable range

Thomas Hellström (13):
      drm/xe: Don't unload the driver until all drm devices are freed
      drm/xe: Route deferred xe_vma/xe_vm teardown off system_dfl_wq
      drm/xe: Route execlist exec queue teardown off system_dfl_wq
      drm/xe: Fix shrinker accounting double-subtraction on nested external pins
      drm/xe: Fix stale pinned_link entry when fb-pin performs the final unpin
      drm/xe: Don't allow XE_VALIDATION_UNIMPLEMENTED outside of debug builds
      drm/xe: Don't transfer shrinker pages for pinned bos on purgeable state change
      drm/xe: Bump LRU for external objects on exec and rebind
      drm/xe: Don't abort the shrinker walk on -EBUSY
      drm/xe: Track number of populated ttm_tts in the shrinker
      drm/xe: Split the bo shrinker into purgeable and non-purgeable shrinkers
      drm/xe: Update non-purgeable shrinker batch size based on average BO size
      Merge drm/drm-next into drm-xe-next

Tvrtko Ursulin (1):
      drm/xe: Do not emit Wa_16010904313 twice

Umesh Nerlige Ramappa (3):
      drm/xe/guc: Handle CRASH and EXCEPTION G2H with separate helpers
      drm/xe/guc: Make ct_dead_capture available on non-debug config
      drm/xe/guc: Cleanup error codes and handling for CT errors

Vinay Belgaumkar (3):
      drm/xe: Toggle the D3Cold enable flag at runtime resume
      drm/xe: Access GT MMIO after pcode init
      drm/xe: Memset g2g buffer on resume

Zhanjun Dong (2):
      drm/xe: Remove extra newlines from LRC snapshot dump
      drm/xe/guc: Compress GuC log and CTB dump with zstd

 .../ABI/testing/sysfs-driver-intel-xe-cper         |  18 +
 Documentation/gpu/xe/xe_device.rst                 |   2 +-
 drivers/gpu/drm/xe/Kconfig                         |  15 +
 drivers/gpu/drm/xe/Kconfig.profile                 |  12 +
 drivers/gpu/drm/xe/Makefile                        |   5 +
 drivers/gpu/drm/xe/abi/uc_fw_abi.h                 |  11 +-
 drivers/gpu/drm/xe/abi/xe_log_abi.h                |   3 +
 drivers/gpu/drm/xe/abi/xe_sigid_abi.h              |  16 +-
 drivers/gpu/drm/xe/regs/xe_engine_regs.h           |  24 +
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |  20 +-
 drivers/gpu/drm/xe/regs/xe_guc_regs.h              |   5 +
 drivers/gpu/drm/xe/regs/xe_lrc_layout.h            |   3 +
 drivers/gpu/drm/xe/regs/xe_pcode_regs.h            |   4 +
 drivers/gpu/drm/xe/tests/xe_dma_buf.c              |  89 +++
 .../gpu/drm/xe/tests/xe_gt_sriov_pf_config_kunit.c |   5 +
 drivers/gpu/drm/xe/tests/xe_guc_id_mgr_test.c      | 689 +++++++++++++++++++--
 drivers/gpu/drm/xe/tests/xe_kunit_helpers.c        |   3 +-
 drivers/gpu/drm/xe/tests/xe_migrate.c              | 366 +++++++++++
 drivers/gpu/drm/xe/xe_amc.c                        |  11 +-
 drivers/gpu/drm/xe/xe_bo.c                         |  58 +-
 drivers/gpu/drm/xe/xe_bo_types.h                   |   8 +-
 drivers/gpu/drm/xe/xe_configfs.h                   |   2 +-
 drivers/gpu/drm/xe/xe_cper.c                       | 322 ++++++++++
 drivers/gpu/drm/xe/xe_cper.h                       |  37 ++
 drivers/gpu/drm/xe/xe_cper_types.h                 | 110 ++++
 drivers/gpu/drm/xe/xe_debugfs.c                    |  70 +--
 drivers/gpu/drm/xe/xe_devcoredump.c                | 353 ++++++++++-
 drivers/gpu/drm/xe/xe_devcoredump_types.h          |  67 ++
 drivers/gpu/drm/xe/xe_device.c                     | 257 ++------
 drivers/gpu/drm/xe/xe_device.h                     |  16 +-
 drivers/gpu/drm/xe/xe_device_sysfs.c               |  50 ++
 drivers/gpu/drm/xe/xe_device_types.h               |  51 +-
 drivers/gpu/drm/xe/xe_device_wa_oob.rules          |   1 -
 drivers/gpu/drm/xe/xe_dma_buf.c                    |  38 +-
 drivers/gpu/drm/xe/xe_dma_buf.h                    |   2 +
 drivers/gpu/drm/xe/xe_drm_ras.c                    |  33 +-
 drivers/gpu/drm/xe/xe_drm_ras_types.h              |   3 -
 drivers/gpu/drm/xe/xe_eu_stall.c                   |   6 +-
 drivers/gpu/drm/xe/xe_execlist.c                   |   6 +-
 drivers/gpu/drm/xe/xe_ggtt.c                       |   9 +-
 drivers/gpu/drm/xe/xe_gpu_scheduler_types.h        |   5 +-
 drivers/gpu/drm/xe/xe_gsc.c                        |   4 +-
 drivers/gpu/drm/xe/xe_gt.c                         | 121 ++--
 drivers/gpu/drm/xe/xe_gt.h                         |   3 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c         |  21 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_service.c        |   1 +
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c                |   3 +-
 drivers/gpu/drm/xe/xe_gt_types.h                   |   9 +
 drivers/gpu/drm/xe/xe_guc.c                        |  76 ++-
 drivers/gpu/drm/xe/xe_guc.h                        |   3 +-
 drivers/gpu/drm/xe/xe_guc_capture.c                |  86 ++-
 drivers/gpu/drm/xe/xe_guc_ct.c                     | 355 +++++++----
 drivers/gpu/drm/xe/xe_guc_ct.h                     |   4 +-
 drivers/gpu/drm/xe/xe_guc_ct_types.h               |   3 +
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h       |   5 +-
 drivers/gpu/drm/xe/xe_guc_id_mgr.c                 | 469 +++++++++++---
 drivers/gpu/drm/xe/xe_guc_id_mgr.h                 |  31 +-
 drivers/gpu/drm/xe/xe_guc_log.c                    | 222 ++++++-
 drivers/gpu/drm/xe/xe_guc_log.h                    |  11 +-
 drivers/gpu/drm/xe/xe_guc_log_types.h              |  20 +
 drivers/gpu/drm/xe/xe_guc_pc.c                     |  11 +-
 drivers/gpu/drm/xe/xe_guc_rc.c                     |   5 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 | 155 +++--
 drivers/gpu/drm/xe/xe_guc_submit.h                 |   2 +-
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c              |   3 +-
 drivers/gpu/drm/xe/xe_guc_types.h                  |   8 +-
 drivers/gpu/drm/xe/xe_hw_engine.c                  |  54 +-
 drivers/gpu/drm/xe/xe_hw_error.c                   |   8 +-
 drivers/gpu/drm/xe/xe_hwmon.c                      | 618 +++++++++++++-----
 drivers/gpu/drm/xe/xe_irq.c                        |   3 +
 drivers/gpu/drm/xe/xe_late_bind_fw.c               | 150 ++++-
 drivers/gpu/drm/xe/xe_late_bind_fw.h               |   4 +-
 drivers/gpu/drm/xe/xe_late_bind_fw_types.h         |   6 +-
 drivers/gpu/drm/xe/xe_lmtt.c                       |  10 +-
 drivers/gpu/drm/xe/xe_log.c                        |   5 +-
 drivers/gpu/drm/xe/xe_lrc.c                        |  12 +-
 drivers/gpu/drm/xe/xe_memirq.c                     |  10 +-
 drivers/gpu/drm/xe/xe_mert.c                       |   5 +-
 drivers/gpu/drm/xe/xe_migrate.c                    | 180 +++++-
 drivers/gpu/drm/xe/xe_mmio.c                       |  12 +-
 drivers/gpu/drm/xe/xe_module.c                     |  24 +-
 drivers/gpu/drm/xe/xe_nvm.c                        |  13 +-
 drivers/gpu/drm/xe/xe_oa.c                         |  24 +-
 drivers/gpu/drm/xe/xe_pagefault.c                  |   8 -
 drivers/gpu/drm/xe/xe_pagefault_types.h            |   3 -
 drivers/gpu/drm/xe/xe_pat.c                        | 131 +++-
 drivers/gpu/drm/xe/xe_pat.h                        |  29 +-
 drivers/gpu/drm/xe/xe_pci.c                        |  23 +-
 drivers/gpu/drm/xe/xe_pci_error.c                  |  13 +-
 drivers/gpu/drm/xe/xe_pci_types.h                  |   4 +-
 drivers/gpu/drm/xe/xe_pcode_api.h                  |   2 -
 drivers/gpu/drm/xe/xe_pm.c                         |  18 +-
 drivers/gpu/drm/xe/xe_pt.c                         |   2 -
 drivers/gpu/drm/xe/xe_ras.c                        | 469 ++++++++++++--
 drivers/gpu/drm/xe/xe_ras.h                        |   7 +-
 drivers/gpu/drm/xe/xe_ras_types.h                  |  85 +++
 drivers/gpu/drm/xe/xe_reg_sr.c                     |  11 +-
 drivers/gpu/drm/xe/xe_shrinker.c                   | 218 +++++--
 drivers/gpu/drm/xe/xe_shrinker.h                   |   7 +-
 drivers/gpu/drm/xe/xe_sriov_pf.c                   |   3 +-
 drivers/gpu/drm/xe/xe_survivability_mode.c         |   4 +-
 drivers/gpu/drm/xe/xe_svm.c                        |   1 +
 drivers/gpu/drm/xe/xe_sync.c                       |  33 +-
 drivers/gpu/drm/xe/xe_sysctrl.c                    |  32 +
 drivers/gpu/drm/xe/xe_sysctrl.h                    |   1 +
 drivers/gpu/drm/xe/xe_sysctrl_debugfs.c            | 500 +++++++++++++++
 drivers/gpu/drm/xe/xe_sysctrl_debugfs.h            |  14 +
 drivers/gpu/drm/xe/xe_sysctrl_event.c              |  14 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c            | 140 +++--
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h            |   6 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h      |  55 ++
 drivers/gpu/drm/xe/xe_sysctrl_types.h              |  47 ++
 drivers/gpu/drm/xe/xe_trace_cper.c                 |   9 +
 drivers/gpu/drm/xe/xe_trace_cper.h                 |  65 ++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c               |  68 +-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h         |   6 +-
 drivers/gpu/drm/xe/xe_tuning.c                     |   4 +-
 drivers/gpu/drm/xe/xe_uc.c                         |  21 +-
 drivers/gpu/drm/xe/xe_uc.h                         |   3 +-
 drivers/gpu/drm/xe/xe_uc_fw.c                      |  16 +-
 drivers/gpu/drm/xe/xe_validation.h                 |   2 +
 drivers/gpu/drm/xe/xe_vm.c                         |  38 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c                 |  17 +-
 drivers/gpu/drm/xe/xe_vram.c                       |  38 +-
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |   4 +-
 drivers/gpu/drm/xe/xe_wedge.c                      | 262 ++++++++
 drivers/gpu/drm/xe/xe_wedge.h                      |  24 +
 drivers/gpu/drm/xe/xe_wedge_types.h                |  44 ++
 drivers/mtd/devices/mtd_intel_dg.c                 |  65 +-
 include/drm/intel/pciids.h                         |   4 +-
 include/linux/intel_dg_nvm_aux.h                   |   1 +
 131 files changed, 6754 insertions(+), 1391 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-xe-cper
 create mode 100644 drivers/gpu/drm/xe/xe_cper.c
 create mode 100644 drivers/gpu/drm/xe/xe_cper.h
 create mode 100644 drivers/gpu/drm/xe/xe_cper_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_debugfs.c
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_debugfs.h
 create mode 100644 drivers/gpu/drm/xe/xe_trace_cper.c
 create mode 100644 drivers/gpu/drm/xe/xe_trace_cper.h
 create mode 100644 drivers/gpu/drm/xe/xe_wedge.c
 create mode 100644 drivers/gpu/drm/xe/xe_wedge.h
 create mode 100644 drivers/gpu/drm/xe/xe_wedge_types.h
