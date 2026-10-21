Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B85606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HvciW/7A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D31710FD14;
	Wed, 21 Oct 2026 10:03:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13EAD10F9BC;
 Wed, 21 Oct 2026 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577021; x=1824113021;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Q3vZC40JgSMJRgC2mLqp3j5pO7HlfQkUFmNN1BJQQpI=;
 b=HvciW/7A+QX7HnBR8sxyHe05trURoA7XtB/nSKxRoMLOy66O6KFsKUF7
 bszYwx1xzxcNkEfikviOzLM9xgzYrKvN12W/Ri+C29wKKzVPt2NYYvg/q
 GGj+fIuR73nvGbZJGh28aLEcB4Nc4KeDe3N9/SxeZAmLy0f5Wm/liiiL/
 7eOsVq1vmBahsAtKuJAqDjKwKhW+s99RRKHc1FVR/PtAv5n7agmjfHSoL
 9jRTcP7UX0IYTgG47p9+S87YTkolPOMMn9sKgNDSgenQuYCf43gv35Ncz
 oKLXNIqsBciPuR3maPW2nMLS/UrsPWeYNodiKr94hjTYDsaGBIQOvmKi+ Q==;
X-CSE-ConnectionGUID: kmea0UexTV2fy8HMnEtjjg==
X-CSE-MsgGUID: PygygZAnT2yzBfRo1sl/MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290250"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290250"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:41 -0700
X-CSE-ConnectionGUID: FBXhnfZaRJezIpQ+SRWr7g==
X-CSE-MsgGUID: XW/4aFvARiWi4ppFLYGlbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3381996"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:38 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 00/17] drm/xe: Isolate wedged devices from hardware access
Date: Wed, 21 Oct 2026 15:33:01 +0530
Message-ID: <20261021100322.1014449-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A permanently wedged device may still be accessed by pending work,
background workers and existing VRAM CPU mappings. This can leave DMA,
interrupt or MMIO activity running after userspace has been asked to
recover the device.

Add a common device I/O gate based on the DRM SRCU domain. Hardware
users enter the gate before checking the device state and leave it after
their hardware access has finished. PCI error recovery and permanent
wedge handling first publish the blocked state, signal pending GT fences
and then drain existing readers. This closes the race between checking
the device state and accessing hardware.

Keep recoverable PCI error handling separate from permanent wedging.
AER uses a temporary reset state and returns -ECANCELED for cancelled
GuC requests. A permanent wedge remains terminal and returns
-ENOTRECOVERABLE.

AER recovery recreates the Xe device. Existing DRM file descriptors
remain attached to the unplugged instance and are not recovered.
Userspace must close them and reopen the recovered device. This series
does not add transparent reset recovery.

After a permanent wedge, the driver:
 - Drops queued page faults.
 - Gates VM rebind, SVM fault and migration work, and GuC sends.
 - Stops the SVM garbage collector.
 - Skips GGTT removal and VM close hardware cleanup.
 - Waits for active users of the device I/O gate.
 - Shuts down and unregisters the display.
 - Suspends interrupts and clears PCI bus mastering.
 - Invalidates existing VRAM CPU mappings.
 - Maps later CPU faults to one dummy page per BO.
 - Rejects new VRAM allocations.
 - Notifies userspace after isolation completes.

System suspend waits for wedge isolation to finish. PCI disable and
D3Cold operations remain paired even when the device wedges during
suspend. Resume balances the PCI state but skips driver resume for a
permanently wedged device.

v2:
 - Add a common device I/O gate on the DRM SRCU domain. Hardware users
   enter the gate before checking device state, and blocked paths drain
   existing readers.
 - Return -ECANCELED for GuC sends blocked by AER recovery, keeping
  -ENOTRECOVERABLE for permanent wedges.
 - Update reported_method only when drm_dev_wedged_event() succeeds.
   Requeue only when the recovery method changes to avoid repeated
   retries after notification failure. (Andi)
 - Map only the faulting address to the per-BO dummy page instead of
   prefaulting the entire VMA.
 - Keep PCI enable/disable and D3Cold operations paired, including when
   the device wedges during suspend. Skip only driver-level PM work
   for wedged devices.
 - Use explicit runtime-PM get/put calls in xe_bo_vm_access() instead
   of mixing scope-based cleanup with goto-based error handling.
 - Protect VM and SVM hardware access with the common SRCU gate.
 - Hold the gate across page-fault, migration and rebind work.
 - Remove the racy device state checks.
 - Simplify the TLB invalidation warning check.
 - Report the wedged event from a worker after isolation.
 - Invalidate existing VRAM CPU mappings after draining active faults.

v3:
 - New patch: skip GGTT updates on a wedged device. GGTT node removal
   wrote page table entries and requested a TLB invalidation after a
   permanent wedge.
 - New patch: skip VM close hardware access when device I/O is blocked.
   VM close used drm_dev_enter(), which only checks unplug.
 - Stop the SVM garbage collector when device I/O is blocked. Range
   unbind writes page tables, so it must not run after a wedge.
 - Keep the device I/O gate held until forcewake cleanup completes.
   (Sashiko)
 - Use cmpxchg() when setting the default recovery method so a
   concurrent method update is not overwritten. (Sashiko)
 - Map the per-BO dummy page with normal WB protection. (Sashiko)
 - Protect display registration with the common device I/O gate.
   (Sashiko)
 - Track display PM suspend state to avoid a second display suspend.
   (Sashiko)
 - Keep display lifecycle checks inside the display helpers. (Sashiko)
 - Keep syncobj waits, syncobj transfers and Xe user-fence waits outside
   the outer device I/O gate. Protect each Xe user-fence memory read
   and wake waiters when device I/O is blocked or the device is unplugged.
 - Take the old GGTT offline before AER drains readers and disables PCI.
 - Invalidate existing VRAM CPU mappings before PCI disable during AER.
 - Prepare GTs only on the first wedge declaration and reject queue
   publication after the wedge under the submission lock.

Arvind Yadav (16):
  drm/xe: Separate AER reset state from device wedging
  drm/xe: Protect device I/O with DRM device SRCU
  drm/xe: Keep software waits outside the device I/O gate
  drm/xe: Drop queued page faults when device I/O is blocked
  drm/xe: Stop VM work when device I/O is blocked
  drm/xe/ggtt: Stop GGTT removal MMIO during wedge and AER
  drm/xe: Skip VM close hardware access when device I/O is blocked
  drm/xe: Send wedged notification from a worker
  drm/xe: Reuse one dummy page per BO after wedge
  drm/xe: Invalidate VRAM CPU mappings on wedge and PCI reset
  drm/xe/irq: Protect IRQ state during wedge isolation
  drm/xe: Isolate a wedged device before notifying userspace
  drm/xe/ttm: Reject VRAM allocations on wedged devices
  drm/xe/guc: Skip timeout recovery on a wedged device
  drm/xe: Skip PM notifier preparation when device I/O is blocked
  drm/xe: Block BO VM access when device I/O is unavailable

Thomas Hellström (1):
  drm/drv: Export drm_dev_srcu_synchronize()

 drivers/gpu/drm/drm_drv.c               |  17 ++-
 drivers/gpu/drm/xe/display/xe_display.c |  39 ++++-
 drivers/gpu/drm/xe/xe_bo.c              |  72 ++++++++-
 drivers/gpu/drm/xe/xe_bo.h              |   1 +
 drivers/gpu/drm/xe/xe_bo_types.h        |   4 +
 drivers/gpu/drm/xe/xe_device.c          | 185 +++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_device.h          |  41 ++++++
 drivers/gpu/drm/xe/xe_device_types.h    |  25 ++++
 drivers/gpu/drm/xe/xe_ggtt.c            |  43 +++++-
 drivers/gpu/drm/xe/xe_ggtt.h            |   1 +
 drivers/gpu/drm/xe/xe_guc_ct.c          |  24 ++-
 drivers/gpu/drm/xe/xe_guc_pc.c          |  10 +-
 drivers/gpu/drm/xe/xe_guc_rc.c          |   4 +-
 drivers/gpu/drm/xe/xe_guc_submit.c      |  22 ++-
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c   |  35 +++--
 drivers/gpu/drm/xe/xe_irq.c             |  23 ++-
 drivers/gpu/drm/xe/xe_pagefault.c       |  15 +-
 drivers/gpu/drm/xe/xe_pci.c             |  51 ++++++-
 drivers/gpu/drm/xe/xe_pci_error.c       |  37 +++--
 drivers/gpu/drm/xe/xe_pm.c              |  12 ++
 drivers/gpu/drm/xe/xe_sriov_pf.c        |   2 +-
 drivers/gpu/drm/xe/xe_svm.c             |  26 +++-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c    |   4 +
 drivers/gpu/drm/xe/xe_vm.c              |  21 +--
 drivers/gpu/drm/xe/xe_wait_user_fence.c |  12 +-
 include/drm/drm_drv.h                   |   1 +
 26 files changed, 617 insertions(+), 110 deletions(-)

-- 
2.43.0

