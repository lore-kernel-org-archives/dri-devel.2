Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A89606A33B
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U1rniv3/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C52110E5B8;
	Thu, 12 Nov 2026 09:43:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA6E10E3EB;
 Thu, 12 Nov 2026 09:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794476581; x=1826012581;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=wrmCX5fGx9Yz7WK5HIzUeMMQ2P5mJ9TfqeJDoYeCUF8=;
 b=U1rniv3/N0nK051mhq1XIYhOAkJWuITKCCbEwqWzXsOt0ffZGOet1oXC
 Lr/D3L1kKpuhwocqbLMo4EWNifg1GCHxkN2aGI+ie8LHPks95kDsGEa5I
 gZSCp6y2dsbLNPxMg5IQi3y40VvnuelefnE9tSi3HjJzqXWRFGEvc85So
 +anT72kmhnJfcgyAKsl2wFH0JugD/n/SzJkQ07CnhYlhMsF+yDaBH4o8G
 w+KQrvEwbgYP9WCFJUpIwnaoPXnslHVEqvBbjA+Swugj3nfoTyWdXlQYv
 a5EljrU61/fpKGCmeRTi16DzeCq4EB5U1iM/m8in5BLhknnhOwhwRlnLk A==;
X-CSE-ConnectionGUID: B8nBfCy1Rw29t7zKpaU8jA==
X-CSE-MsgGUID: RI9RWGWoR+KZnLX5a4ZV8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3134241"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3134241"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 01:43:00 -0800
X-CSE-ConnectionGUID: vIPc3PgnSJq2WWRz+sNwvQ==
X-CSE-MsgGUID: h08u8yPkROCvew/7NAJ21Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8942481"
Received: from carterle-desk.ger.corp.intel.com (HELO fedora) ([10.245.244.5])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 01:42:57 -0800
Date: Thu, 12 Nov 2026 10:42:35 +0100
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
Message-ID: <avWKCypDrHj5139M@fedora>
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

This week's drm-xe-next PR. Highlights:

Series
------

- drm/xe: Clean up adjust_idledly() and implement Wa_16031259911 (v3)
  10/10 patches pushed
  Refactors adjust_idledly() (common picosecond unit, early bails, factored
  min/max helpers, VF-mode bail-out), syncs Wa_16023105232 with its OOB rule,
  fixes GuC regset size accounting for RING_IDLEDLY workarounds, and adds
  Wa_16031259911 for graphics IP 35.10/35.11.
  (Gustavo Sousa)

- Prepare SR-IOV provisioning for vGPU profiles
  5/5 patches pushed
  Splits the PF provisioning-mode change and bulk priority provisioning into
  static helpers that expect the master mutex held, and makes mode changes,
  VF auto-provisioning and unprovisioning run under that mutex, in
  preparation for vGPU profile support.
  (Piotr Piórkowski, Michal Wajdeczko)

- drm/xe: Clean up the GU_MISC irq handling
  3/4 patches pushed (the 4th, "drm/xe: Use intel_display_gse_irq_handler()",
  went via drm-intel-next together with its i915 dependency)
  Only enables the GSE interrupt when display needs it, extracts
  xe_gu_misc_irq_{postinstall,reset}() and renames the display GSE irq
  handler.
  (Ville Syrjälä)

- drm/xe: Fix tile workaround resume handling and enable Wa_14028586678
  2/2 patches pushed
  Waits for PCODE init before applying tile workarounds on resume (and
  reapplies after D3cold runtime resume), then enables Wa_14028586678 on
  Crescent Island.
  (Daniel Charles, Fei Yang)

- Optimise suspend handling for CCS iGPU platforms (v2)
  2/2 patches pushed
  Avoids evicting CCS buffers from TT and skips BO eviction on iGPU for
  non-hibernation sleep, since CCS stolen memory persists across them.
  (Matthew Auld)

- Fix VF probe issue due to missing LMTT dir ptr (v3)
  2/2 patches pushed
  Programs the LMTT directory pointer from each GT's init path and uses
  multicast writes for early-generation LMTT config, fixing VF probe
  failures. (b4 reports the two patches as separate 1-patch threads; the
  cover letter describes a two-patch series.)
  (Satyanarayana K V P)


Single patches
--------------

- drm: xe: select configfs (Arnd Bergmann)
- drm/xe: Don't ask for bug reports on force probed platforms (Rodrigo Vivi)
- drm/xe: Add support for Wa_14028250015 (Alan Previn)
- drm/xe/xe_pci_error: Wait for pcode init post SBR (Riana Tauro)
- drm/xe/guc: Demote uncorrectable local error log on CRI (Varun Gupta)


The following changes since commit 3b8860fe2581a8db796150728687ba1c6b78ddab:

  drm/xe: Unwrap sync fences before adding them as job dependencies (2026-11-04 14:44:09 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-2026-11-12

for you to fetch changes up to be73339dd9d70623b7dbc9c4e3b966824b771069:

  drm: xe: select configfs (2026-11-11 13:53:05 -0500)

----------------------------------------------------------------
Driver Changes:
- drm: xe: select configfs (Arnd Bergmann)
- drm/xe: Don't ask for bug reports on force probed platforms (Rodrigo Vivi)
- drm/xe/pf: Split the provisioning mode change function (Michal Wajdeczko)
- drm/xe/pf: Provision VFs under mutex (Piotr Piórkowski)
- drm/xe/pf: Add locked variant of the fair VFs provisioning (Piotr Piórkowski)
- drm/xe/pf: Change provisioning mode under mutex (Michal Wajdeczko)
- drm/xe/pf: Split the bulk priority provisioning function (Michal Wajdeczko)
- drm/xe: Only enable the GSE interrupt when display needs it (Ville Syrjälä)
- drm/xe: Extract xe_gu_misc_irq_{postinstall,reset}() (Ville Syrjälä)
- drm/xe: s/xe_display_irq_enable()/xe_display_gse_irq_handler()/ (Ville Syrjälä)
- drm/xe/pm: skip BO eviction on iGPU for non-hibernation sleep (Matthew Auld)
- drm/xe: only evict CCS buffers from TT on iGPU (Matthew Auld)
- drm/xe: Implement Wa_16031259911 (Gustavo Sousa)
- drm/xe/guc: Increment regset size for RING_IDLEDLY workarounds (Gustavo Sousa)
- drm/xe/guc: Increment regset size for Wa_1607983814 inside hwe loop (Gustavo Sousa)
- drm/xe: Replace MAXCNT comment with a comment on adjust_idledly() (Gustavo Sousa)
- drm/xe: Drop early and redundant workaround checks in adjust_idledly() (Gustavo Sousa)
- drm/xe: Bail from adjust_idledly() if no applicable workaround (Gustavo Sousa)
- drm/xe: Factor out {min,max}_idledly_ps in adjust_idledly() (Gustavo Sousa)
- drm/xe: Use picosecond as common unit in adjust_idledly() (Gustavo Sousa)
- drm/xe: Sync Wa_16023105232 in xe_was to match OOB rule (Gustavo Sousa)
- drm/xe: Bail from adjust_idledly() if in VF mode (Gustavo Sousa)
- drm/xe: Add support for Wa_14028250015 (Alan Previn)
- drm/xe/pf: Use multicast writes for early-generation LMTT config (Satyanarayana K V P)
- drm/xe/pf: Program LMTT directory pointer from each GT's init path (Satyanarayana K V P)
- drm/xe/xe_pci_error: Wait for pcode init post SBR (Riana Tauro)
- drm/xe/guc: Demote uncorrectable local error log on CRI (Varun Gupta)
- drm/xe/cri: Implement Wa_14028586678 (Fei Yang)
- drm/xe/pm: Apply tile workarounds after PCODE initialization (Daniel Charles)

----------------------------------------------------------------
Alan Previn (1):
      drm/xe: Add support for Wa_14028250015

Arnd Bergmann (1):
      drm: xe: select configfs

Daniel Charles (1):
      drm/xe/pm: Apply tile workarounds after PCODE initialization

Fei Yang (1):
      drm/xe/cri: Implement Wa_14028586678

Gustavo Sousa (10):
      drm/xe: Bail from adjust_idledly() if in VF mode
      drm/xe: Sync Wa_16023105232 in xe_was to match OOB rule
      drm/xe: Use picosecond as common unit in adjust_idledly()
      drm/xe: Factor out {min,max}_idledly_ps in adjust_idledly()
      drm/xe: Bail from adjust_idledly() if no applicable workaround
      drm/xe: Drop early and redundant workaround checks in adjust_idledly()
      drm/xe: Replace MAXCNT comment with a comment on adjust_idledly()
      drm/xe/guc: Increment regset size for Wa_1607983814 inside hwe loop
      drm/xe/guc: Increment regset size for RING_IDLEDLY workarounds
      drm/xe: Implement Wa_16031259911

Matthew Auld (2):
      drm/xe: only evict CCS buffers from TT on iGPU
      drm/xe/pm: skip BO eviction on iGPU for non-hibernation sleep

Michal Wajdeczko (3):
      drm/xe/pf: Split the bulk priority provisioning function
      drm/xe/pf: Change provisioning mode under mutex
      drm/xe/pf: Split the provisioning mode change function

Piotr Piórkowski (2):
      drm/xe/pf: Add locked variant of the fair VFs provisioning
      drm/xe/pf: Provision VFs under mutex

Riana Tauro (1):
      drm/xe/xe_pci_error: Wait for pcode init post SBR

Rodrigo Vivi (1):
      drm/xe: Don't ask for bug reports on force probed platforms

Satyanarayana K V P (2):
      drm/xe/pf: Program LMTT directory pointer from each GT's init path
      drm/xe/pf: Use multicast writes for early-generation LMTT config

Varun Gupta (1):
      drm/xe/guc: Demote uncorrectable local error log on CRI

Ville Syrjälä (3):
      drm/xe: s/xe_display_irq_enable()/xe_display_gse_irq_handler()/
      drm/xe: Extract xe_gu_misc_irq_{postinstall,reset}()
      drm/xe: Only enable the GSE interrupt when display needs it

 drivers/gpu/drm/xe/Kconfig                 |   1 +
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h      |   1 +
 drivers/gpu/drm/xe/display/xe_display.c    |  19 +++-
 drivers/gpu/drm/xe/display/xe_display.h    |   6 +-
 drivers/gpu/drm/xe/regs/xe_gt_regs.h       |   3 +-
 drivers/gpu/drm/xe/regs/xe_mert_regs.h     |   4 +
 drivers/gpu/drm/xe/xe_bo_evict.c           |  66 ++++++++++--
 drivers/gpu/drm/xe/xe_configfs.h           |  30 ------
 drivers/gpu/drm/xe/xe_device_types.h       |   2 +
 drivers/gpu/drm/xe/xe_device_wa_oob.rules  |   1 +
 drivers/gpu/drm/xe/xe_gt.c                 |  14 ++-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c |  69 ++++++-------
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.h |  17 +--
 drivers/gpu/drm/xe/xe_guc_ads.c            |  21 +++-
 drivers/gpu/drm/xe/xe_guc_submit.c         |  18 +++-
 drivers/gpu/drm/xe/xe_hw_engine.c          | 160 ++++++++++++++---------------
 drivers/gpu/drm/xe/xe_irq.c                |  29 ++++--
 drivers/gpu/drm/xe/xe_lmtt.c               |  52 +++++++---
 drivers/gpu/drm/xe/xe_lmtt.h               |   5 +-
 drivers/gpu/drm/xe/xe_pci.c                |  22 +++-
 drivers/gpu/drm/xe/xe_pci_error.c          |   6 ++
 drivers/gpu/drm/xe/xe_pm.c                 |  36 +++++--
 drivers/gpu/drm/xe/xe_pm.h                 |   2 +-
 drivers/gpu/drm/xe/xe_sriov_pf_provision.c | 100 +++++++++++-------
 drivers/gpu/drm/xe/xe_wa.c                 |  12 ++-
 drivers/gpu/drm/xe/xe_wa_oob.rules         |   7 +-
 drivers/gpu/drm/xe/xe_wedge.c              |   8 +-
 27 files changed, 437 insertions(+), 274 deletions(-)
