Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88085CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E899D10E995;
	Fri, 12 Jun 2026 08:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iXtOLBpm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C8210E995;
 Fri, 12 Jun 2026 08:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781251844; x=1812787844;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O8/mEy2P3GJoo53+O5eq2qLKNQbaWnl6wTZT8A6xYDg=;
 b=iXtOLBpmp5b/5boqCF7tWb1q2GhQ+zBXoF8j7lN3z7rUXLaKwiJh3zRV
 mScXKuz3RDSYCeHqc4u1Qe7sGB/vP5UIqTdWukf+xZEePTjgxpm5mUjJR
 XFZW9Rsp3YlqcwVsdG6RDQ8vQv1uMvTcczdQ1SlIZJDVJ0txbH5kGAJaS
 j1B5n7PkMV25s6Y7TSSunD0VCWTgyDqxU2OrPMtjUAAUX+k9AHlGn4ueJ
 FKGf65p/0lSHgMyB/s0xQLpgGkyREZdEFAwfnE60D+yttHd5dF7q1aSRH
 aBx11TsYow1sVbxsql/BT8U1Zkf7/6eK0pPFt5scn2Z9k6/mDCFGMPyrS A==;
X-CSE-ConnectionGUID: Mkko+0ZNTem7fjtQq0ETkA==
X-CSE-MsgGUID: O+sI/0l9QDuo1KfJQVtK0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85921364"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="85921364"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 01:10:43 -0700
X-CSE-ConnectionGUID: edPUOSDRRZ20D4tNwD9thg==
X-CSE-MsgGUID: N6J/crCDS/W1LTTNPQe0bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="245667151"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa006.jf.intel.com with ESMTP; 12 Jun 2026 01:10:38 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v8 0/6] Introduce cold reset recovery method
Date: Fri, 12 Jun 2026 13:37:23 +0530
Message-ID: <20260612080722.26726-8-mallesh.koujalagi@intel.com>
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
and adds support for handling errors that require a complete
device power cycle (cold reset) to recover.

Certain error conditions leave the device in a persistent hardware
error state that cannot be cleared through existing recovery mechanisms
such as driver reload or PCIe reset. In these cases, functionality can
only be restored by performing a cold reset.

To support this, the series introduces a new DRM wedging recovery
method, DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)). When a device is wedged
with this method, the DRM core notifies userspace via a uevent that a cold
reset is required. This allows userspace to take appropriate action to
power-cycle the device.

Example uevent received:
  SUBSYSTEM=drm
  WEDGED=cold-reset
  DEVPATH=/devices/.../drm/card0

Detailed description in commit message.

[1] https://patchwork.freedesktop.org/series/160482/
This patch series introduces a call to punit_error_handler() from
within handle_soc_internal_errors() when PUNIT errors detected.

v2:
- Add use case: Handling errors from power management unit,
  which requires a complete power cycle to
  recover. (Christian)
- Add several instead of number to avoid update. (Jani)

v3:
- Update any scenario that requires cold-reset. (Riana)
- Update document with generic scenario. (Riana)
- Consistent with terminology. (Raag)
- Remove already covered information.
- Use PUNIT instead of PMU. (Riana)
- Use consistent wordingi.
- Remove log. (Raag)

v4:
- Rename cold reset to power cyclce. (Raag)
- Update doc. (Raag/Riana)
- Change commit message. (Raag)
- Make function static. (Raag)

v5:
- Make it consistent with consumer expectations. (Raag)
- Update commit message.
- Remove unbind.
- Simplify cold-reset script.
- Remove kdoc for static function.
- Remove xe_ prefix for static function.

v6:
- Drop "last resort" wording. (Riana)
- Look up the hotplug slot in DEVPATH instead of scanning
  every PCI slot on the system. (Raag)
- Drop arbitrary sleep values from the example script.
- Expand commit message to explain why SUR_DN is masked. (Raag/Riana)
- Check Slot Implemented bit before reading Slot Capabilities, per
  PCIe spec. (Riana)
- Add debug log.

v7:
- Update recovery script. (Raag)
- Handle surprise link down event properly. (Aravind/Riana)
- Update commit message. (Riana)
- Correct log message.

v8:
- Add rescan instead of reset. (Raag)
- Use find_usp_dev() in punit_error_handler() function.

Cc: André Almeida <andrealmeid@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>

Mallesh Koujalagi (5):
  drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method
  drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET recovery method
  drm/xe: Handle PUNIT errors by requesting cold-reset recovery
  drm/xe: Suppress Surprise Link Down on device
  drm/xe/ras: Add debugfs entry to inject punit error

Riana Tauro (1):
  Introduce Xe Uncorrectable Error Handling

 Documentation/gpu/drm-uapi.rst                |  85 ++-
 drivers/gpu/drm/drm_drv.c                     |   2 +
 drivers/gpu/drm/xe/Makefile                   |   1 +
 drivers/gpu/drm/xe/xe_debugfs.c               |   3 +
 drivers/gpu/drm/xe/xe_device.c                |  24 +-
 drivers/gpu/drm/xe/xe_device.h                |  27 +-
 drivers/gpu/drm/xe/xe_device_types.h          |  12 +-
 drivers/gpu/drm/xe/xe_gt.c                    |  14 +-
 drivers/gpu/drm/xe/xe_guc_submit.c            |   9 +-
 drivers/gpu/drm/xe/xe_pci.c                   |   9 +
 drivers/gpu/drm/xe/xe_pci_error.c             | 135 +++++
 drivers/gpu/drm/xe/xe_pci_error.h             |  13 +
 drivers/gpu/drm/xe/xe_ras.c                   | 570 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |  11 +
 drivers/gpu/drm/xe/xe_ras_types.h             | 227 +++++++
 drivers/gpu/drm/xe/xe_survivability_mode.c    |  13 +-
 drivers/gpu/drm/xe/xe_sysctrl_event.c         |   2 +-
 drivers/gpu/drm/xe/xe_sysctrl_event_types.h   |   3 -
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c       |  28 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h       |   4 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  11 +
 include/drm/drm_device.h                      |   1 +
 22 files changed, 1175 insertions(+), 29 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_pci_error.c
 create mode 100644 drivers/gpu/drm/xe/xe_pci_error.h

-- 
2.34.1

