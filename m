Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60177C61DCB
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1414E10E3E4;
	Thu, 27 Aug 2026 10:18:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RPFGj6pe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 942BC10E3DC;
 Thu, 27 Aug 2026 10:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825909; x=1819361909;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=z3GjBuZ7hbSAdzW1gcnqWpK/McdhQk8Ug7xhXSIvdjQ=;
 b=RPFGj6pez8u1VRAMW62kyYZaYYV0Fdx7825EraNi71cwpVdl9LI0vnX5
 Ak8OiMcPTmkdbm2rZdGunJ4irhLi0q6Wql/T36gz1yNGZxOZTssFQSzzF
 W80vb6pv5/ktQDcmqM6uTg36lwfeJM8lbNQylHXriVgvPIWLHG0XLR2pj
 B1iKwE81a5cmzt2ZHmpPn+uj5knc7ngOzVU5KY8rSjjPceu3587xQwCX7
 5iZ8+4ge+L1I0RK4jIdQkDV2TA8YL6touQt99j7YdbMM3OKn9qNN7e26p
 DH19lO1tUFLWnvuEMt4OBmXhBVDodal24nKZ6dfYt5dOudwAu54+2mCMY A==;
X-CSE-ConnectionGUID: eVbTksc4QeaX4UgBgW/Rqg==
X-CSE-MsgGUID: CmmyIvaFTKW4aWgIUaZ+5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445855"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445855"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:29 -0700
X-CSE-ConnectionGUID: N4hoXceZTfeVjfPdx+kcxA==
X-CSE-MsgGUID: 7KN0mnWYSce5+hP5YN+JtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057602"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:27 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 00/13] drm/xe: Isolate wedged devices from hardware access
Date: Thu, 27 Aug 2026 15:47:48 +0530
Message-ID: <20260827101801.1247654-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

A permanently wedged device can still access hardware through pending work,
existing VRAM mappings and background driver paths. This can cause unwanted
DMA or MMIO access while userspace is preparing device recovery.

This series separates temporary PCI error recovery from permanent wedging and
introduces a common device-I/O-blocked state.

After a permanent wedge, the driver:
- stops queued VM, SVM and GuC work.
- shuts down the display.
- invalidates existing CPU mappings to VRAM.
- maps later CPU faults to a per-BO dummy page.
- stops interrupts and clears PCI bus mastering.
- rejects new VRAM allocations.
- notifies userspace only after isolation completes.
- drops queued page faults and stops VM, SVM and GuC work.

System suspend waits for wedge isolation to complete before skipping the
normal suspend path. The worker cannot reach synchronize_srcu() until all
GTs have been declared wedged and their pending fences have been signalled.

The device remains isolated until userspace performs the advertised recovery,
such as driver rebind or bus reset.

The series also fixes IRQ uninstall so requested handlers are freed after
interrupts have already been suspended.

Arvind Yadav (13):
  drm/xe/irq: Always free requested IRQs on uninstall
  drm/xe: Separate AER reset state from device wedging
  drm/xe: Drop queued page faults when device I/O is blocked
  drm/xe: Stop VM work when device I/O is blocked
  drm/xe: Send wedged notification from a worker
  drm/xe: Reuse one dummy page per BO after wedge
  drm/xe: Invalidate existing VRAM mappings on wedge
  drm/xe/irq: Serialize IRQ suspend and resume
  drm/xe: Isolate a wedged device before notifying userspace
  drm/xe/ttm: Reject VRAM allocations on wedged devices
  drm/xe/guc: Skip timeout recovery on a wedged device
  drm/xe: Skip PM notifier preparation for wedged devices
  drm/xe: Block BO VM access when device I/O is unavailable

 drivers/gpu/drm/xe/display/xe_display.c |  18 +++-
 drivers/gpu/drm/xe/xe_bo.c              | 101 +++++++++++++++++++-
 drivers/gpu/drm/xe/xe_bo.h              |   1 +
 drivers/gpu/drm/xe/xe_bo_types.h        |   4 +
 drivers/gpu/drm/xe/xe_device.c          | 118 ++++++++++++++++++++----
 drivers/gpu/drm/xe/xe_device.h          |  12 +++
 drivers/gpu/drm/xe/xe_device_types.h    |  26 ++++++
 drivers/gpu/drm/xe/xe_guc_ct.c          |   4 +-
 drivers/gpu/drm/xe/xe_guc_pc.c          |  10 +-
 drivers/gpu/drm/xe/xe_guc_rc.c          |   4 +-
 drivers/gpu/drm/xe/xe_guc_submit.c      |  13 ++-
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c   |   8 +-
 drivers/gpu/drm/xe/xe_irq.c             |  32 +++++--
 drivers/gpu/drm/xe/xe_pagefault.c       |  40 ++++++++
 drivers/gpu/drm/xe/xe_pci.c             |  23 ++++-
 drivers/gpu/drm/xe/xe_pci_error.c       |  22 ++---
 drivers/gpu/drm/xe/xe_pm.c              |  27 ++++++
 drivers/gpu/drm/xe/xe_sriov_pf.c        |   2 +-
 drivers/gpu/drm/xe/xe_svm.c             |  21 ++++-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c    |   4 +
 drivers/gpu/drm/xe/xe_vm.c              |  16 ++++
 21 files changed, 446 insertions(+), 60 deletions(-)

-- 
2.43.0

