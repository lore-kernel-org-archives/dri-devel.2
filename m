Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E233FC982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A41810E66C;
	Tue, 22 Sep 2026 10:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JzbWGIpz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B46D10E66C;
 Tue, 22 Sep 2026 10:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072255; x=1821608255;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1pPHK4HOnEXij0D22vj38m3WgRFZCGTGyxQO3A73MmY=;
 b=JzbWGIpz/IcYb5C8IpG+1Wic29krspimVm3/d2mX9/CakQXONtBwzcUP
 XV8suvmFdu9aBwDlV08f827f/+7dxWCC97IxV9W554uBtyykxNE2EnutK
 dguvYjoSb/J6Xjls/VDUEzQwQHdeN9LHX3am8sMTJmrUpUG2u8VOG8Jmr
 hLF69QT2xJLQfeLdwsVDzppZ+ciCua1vwhTnxT0jfzuiNA6T37BnCfCN/
 UuWGV+gpZbo3uJaFJK8i4oU7ilXRtKWN3E0EO8yXBp5Mq6bn75YBCp0e4
 LmsgsJ9ik8KLAw9VpCBVk90HLfmef60/NvBkhM7nFaaKxVV/0SNDQElhE g==;
X-CSE-ConnectionGUID: aQep686cQq+BzoKS0mGj6Q==
X-CSE-MsgGUID: o3xTa2zOQPacaEZiti5hGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322772"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322772"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:35 -0700
X-CSE-ConnectionGUID: OD0IMN5RSz2QvncNHEF93A==
X-CSE-MsgGUID: BgPvJCdFSECgxmtFhFru6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307734"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:33 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 00/15] drm/xe: Isolate wedged devices from hardware access
Date: Tue, 22 Sep 2026 15:46:45 +0530
Message-ID: <20260922101721.1583542-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
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
 - Blocks VM, SVM and GuC hardware access.
 - Waits for active device I/O users.
 - Shuts down and unregisters the display.
 - Suspends interrupts and clears PCI bus mastering.
 - invalidates existing VRAM CPU mappings
 - maps later CPU faults to one dummy page per BO
 - Rejects new VRAM allocations.
 - Notifies userspace after isolation completes.

System suspend waits for wedge isolation to finish. PCI disable and
D3Cold operations remain paired even when the device wedges during
suspend. Resume balances the PCI state but skips driver resume for a
permanently wedged device.

The series also fixes IRQ uninstall so requested IRQ handlers are freed
after interrupts have already been suspended.

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
 - report the wedged event from a worker after isolation.
 - invalidate existing VRAM CPU mappings after draining active faults.

Arvind Yadav (14):
  drm/xe/irq: Always free requested IRQs on uninstall
  drm/xe: Separate AER reset state from device wedging
  drm/xe: Protect device I/O with DRM device SRCU
  drm/xe: Drop queued page faults when device I/O is blocked
  drm/xe: Stop VM work when device I/O is blocked
  drm/xe: Send wedged notification from a worker
  drm/xe: Reuse one dummy page per BO after wedge
  drm/xe: Invalidate existing VRAM mappings on wedge
  drm/xe/irq: Protect IRQ state during wedge isolation
  drm/xe: Isolate a wedged device before notifying userspace
  drm/xe/ttm: Reject VRAM allocations on wedged devices
  drm/xe/guc: Skip timeout recovery on a wedged device
  drm/xe: Skip PM notifier preparation when device I/O is blocked
  drm/xe: Block BO VM access when device I/O is unavailable

Thomas Hellström (1):
  drm/drv: Export drm_dev_srcu_synchronize()

 drivers/gpu/drm/drm_drv.c               |  17 ++-
 drivers/gpu/drm/xe/display/xe_display.c |  17 ++-
 drivers/gpu/drm/xe/xe_bo.c              |  72 ++++++++++-
 drivers/gpu/drm/xe/xe_bo.h              |   1 +
 drivers/gpu/drm/xe/xe_bo_types.h        |   4 +
 drivers/gpu/drm/xe/xe_device.c          | 155 ++++++++++++++++++++----
 drivers/gpu/drm/xe/xe_device.h          |  41 +++++++
 drivers/gpu/drm/xe/xe_device_types.h    |  21 ++++
 drivers/gpu/drm/xe/xe_guc_ct.c          |  24 +++-
 drivers/gpu/drm/xe/xe_guc_pc.c          |  10 +-
 drivers/gpu/drm/xe/xe_guc_rc.c          |   4 +-
 drivers/gpu/drm/xe/xe_guc_submit.c      |  13 +-
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c   |  15 ++-
 drivers/gpu/drm/xe/xe_irq.c             |  29 +++--
 drivers/gpu/drm/xe/xe_pagefault.c       |  20 ++-
 drivers/gpu/drm/xe/xe_pci.c             |  51 ++++++--
 drivers/gpu/drm/xe/xe_pci_error.c       |  24 ++--
 drivers/gpu/drm/xe/xe_pm.c              |  12 ++
 drivers/gpu/drm/xe/xe_sriov_pf.c        |   2 +-
 drivers/gpu/drm/xe/xe_svm.c             |  29 ++++-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c    |   4 +
 drivers/gpu/drm/xe/xe_vm.c              |  11 +-
 include/drm/drm_drv.h                   |   1 +
 23 files changed, 487 insertions(+), 90 deletions(-)

-- 
2.43.0

