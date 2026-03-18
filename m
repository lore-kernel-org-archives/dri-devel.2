Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450E6FCD0C1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A91810E070;
	Wed, 18 Mar 2026 06:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ij1csOO1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3190810E070;
 Wed, 18 Mar 2026 06:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773816177; x=1805352177;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sEs7P2PcLE3PTFFUlLNl7o4OCIkXogd8/YHkTz7eGi0=;
 b=ij1csOO12IutEk+dQJJrxot6iEaEJ17p6RH4mHZM0pRDJrILWsW3LHb3
 Z6TjxR/ZLvtKhlw1P4dkuimXO/MCeqk/UCibpTsYfP3nUXQf70z2hRlO2
 MXesYx5KgjmLbcRqER5je9lPDqWr9HwHXcLIbPqHsuSqM7bJELGC96/Q3
 MmxoaJAhWn2/96tTsbtGcpmfQyduGgK/g9aJLj3/5c+MMQuQnY2UMdbC4
 CVTzfqCT4bea9Ph5vSAAZssYqhdpg0K/VC+76/SsLESUOyVsKzrHE4YEE
 0P5qj4E7vgbTdaBxvxUXg+dtNufjaAP4HP0Ta11/Y2MwUvBkrdR9dzdzz A==;
X-CSE-ConnectionGUID: lS8c/VzzSnunicyaEum7DQ==
X-CSE-MsgGUID: 4tyv1aV6R3iBUlomj0J3lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78723323"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="78723323"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 23:42:57 -0700
X-CSE-ConnectionGUID: Pc2BJN2RQ/qMTLW7oD6Hng==
X-CSE-MsgGUID: zxAthQa5RqSuk09uw1MKmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="227464484"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa005.jf.intel.com with ESMTP; 17 Mar 2026 23:42:52 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v2 0/5] Introduce cold reset recovery method
Date: Wed, 18 Mar 2026 12:10:17 +0530
Message-ID: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

This series builds on top of Introduce Xe Uncorrectable Error Handling[1]
and adds support for handling power management unit (PMU) errors
that require a complete device power cycle to recover.

Certain PMU error conditions leave the device in a persistent hardware
error state that cannot be cleared through existing recovery mechanisms
such as driver reload or PCIe reset. In these cases, functionality can
only be restored by performing a cold reset (complete power cycle).

To support this, the series introduces a new DRM wedging recovery
method, DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)). When a device is wedged
with this method, the DRM core notifies userspace via a uevent that a cold
reset is required. This allows userspace to take appropriate action to
power-cycle the device.

Example uevent received:
  SUBSYSTEM=drm
  WEDGED=cold-reset
  DEVPATH=/devices/.../drm/card0

The cold reset recovery path can be exercised through the debugfs
interface:

  echo 1 > /sys/kernel/debug/dri/N/trigger_punit_error

This triggers the PMU error handler, wedges the device using the cold
reset recovery method, and emits the corresponding uevent to userspace.

Detailed description in commit message.

[1] https://patchwork.freedesktop.org/series/160482/
This patch series introduces a call to xe_punit_error_handler() from
within handle_soc_internal_errors() when PMU errors detected.

v2:
- Add use case: Handling errors from power management unit,
  which requires a complete power cycle (cold reset)
  to recover. (Christian)
- Add several instead of number to avoid update. (Jani)

Cc: André Almeida <andrealmeid@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Maxime Ripard <mripard@kernel.org>

Mallesh Koujalagi (4):
  drm: Add DRM_WEDGE_RECOVERY_COLD_RESET for power management unit error
  drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET recovery method
  drm/xe: Add handler for power management unit errors which require
    cold-reset
  drm/xe/debugfs: Add interface to trigger power management unit error
    handler

Riana Tauro (1):
  Introduce Xe Uncorrectable Error Handling

 Documentation/gpu/drm-uapi.rst                |  73 +++-
 drivers/gpu/drm/drm_drv.c                     |   2 +
 drivers/gpu/drm/xe/Makefile                   |   4 +
 drivers/gpu/drm/xe/regs/xe_sysctrl_regs.h     |  36 ++
 drivers/gpu/drm/xe/xe_debugfs.c               |  38 ++
 drivers/gpu/drm/xe/xe_device.c                |  15 +
 drivers/gpu/drm/xe/xe_device.h                |  15 +
 drivers/gpu/drm/xe/xe_device_types.h          |  12 +
 drivers/gpu/drm/xe/xe_gt.c                    |  11 +-
 drivers/gpu/drm/xe/xe_guc_submit.c            |   9 +-
 drivers/gpu/drm/xe/xe_hw_error.c              |  27 ++
 drivers/gpu/drm/xe/xe_hw_error.h              |   1 +
 drivers/gpu/drm/xe/xe_pci.c                   |   5 +
 drivers/gpu/drm/xe/xe_pci_error.c             | 111 +++++
 drivers/gpu/drm/xe/xe_pci_types.h             |   1 +
 drivers/gpu/drm/xe/xe_ras.c                   | 332 +++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |  16 +
 drivers/gpu/drm/xe/xe_ras_types.h             | 282 +++++++++++++
 drivers/gpu/drm/xe/xe_survivability_mode.c    |  12 +-
 drivers/gpu/drm/xe/xe_sysctrl.c               |  80 ++++
 drivers/gpu/drm/xe/xe_sysctrl.h               |  13 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c       | 390 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h       |  35 ++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  55 +++
 drivers/gpu/drm/xe/xe_sysctrl_types.h         |  33 ++
 include/drm/drm_device.h                      |   1 +
 26 files changed, 1600 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/regs/xe_sysctrl_regs.h
 create mode 100644 drivers/gpu/drm/xe/xe_pci_error.c
 create mode 100644 drivers/gpu/drm/xe/xe_ras.c
 create mode 100644 drivers/gpu/drm/xe/xe_ras.h
 create mode 100644 drivers/gpu/drm/xe/xe_ras_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl.c
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl.h
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_types.h

-- 
2.34.1

