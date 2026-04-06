Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3C3F46C45
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C96310E139;
	Mon,  6 Apr 2026 14:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jSf4oD4Y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1164810E139;
 Mon,  6 Apr 2026 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775485552; x=1807021552;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rKELkQvIme8uI4n9QS8Dc9D6SMs/Rewb2K+DEE4ozts=;
 b=jSf4oD4YW048++ntvtUJf5Tn/M3Y0TeHyo899ffOPl6/GY3wqt5KYmsI
 zoiZSKbqmZI4+WyTyTOh5qdpDlNm9Gx/EL7EL0r5Hws0yUvqtGZebcvvj
 4XBIDXBz/6yo4iA67vzuHzKLQWhqcf7suvlWnSuT9v2iLB4XuI0cDcMXd
 VtgYPFSohouJ2+xcJjQG+ijnMIbxfIdj7kD+Yx98zIolgAlZYvAm5C/YA
 LRYbYQWKPsw31zaNuCaeqXjUGmzJXQLVNvcYAUowlqJvaN9dTvI4PirOZ
 u45DR1ZfHqwD2zWC9FgqDIRjjs7it/cIt2gt1eXfZAktNMQL5UIphO8px A==;
X-CSE-ConnectionGUID: fj4Gw9bsTWWulvXSMNW9Qg==
X-CSE-MsgGUID: EhL1ROeYROyF6C6SZdgB9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="75603890"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="75603890"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 07:25:51 -0700
X-CSE-ConnectionGUID: Fe5HivbtSWuOvhZaFQEbkw==
X-CSE-MsgGUID: mx1hRxbFQluVXJRqrII6Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="221309236"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa009.fm.intel.com with ESMTP; 06 Apr 2026 07:25:48 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v3 0/4] Introduce cold reset recovery method
Date: Mon,  6 Apr 2026 19:53:26 +0530
Message-ID: <20260406142325.157035-6-mallesh.koujalagi@intel.com>
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
This patch series introduces a call to xe_punit_error_handler() from
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

Cc: André Almeida <andrealmeid@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Maxime Ripard <mripard@kernel.org>

Mallesh Koujalagi (3):
  drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method
  drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET recovery method
  drm/xe: Handle PUNIT errors by requesting cold-reset recovery

Riana Tauro (1):
  Introduce Xe Uncorrectable Error Handling

 Documentation/gpu/drm-uapi.rst                |  60 +++-
 drivers/gpu/drm/drm_drv.c                     |   2 +
 drivers/gpu/drm/xe/Makefile                   |   2 +
 drivers/gpu/drm/xe/xe_device.c                |  10 +
 drivers/gpu/drm/xe/xe_device.h                |  15 +
 drivers/gpu/drm/xe/xe_device_types.h          |   6 +
 drivers/gpu/drm/xe/xe_gt.c                    |  14 +-
 drivers/gpu/drm/xe/xe_guc_submit.c            |   9 +-
 drivers/gpu/drm/xe/xe_pci.c                   |   3 +
 drivers/gpu/drm/xe/xe_pci_error.c             | 118 ++++++
 drivers/gpu/drm/xe/xe_ras.c                   | 337 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |  17 +
 drivers/gpu/drm/xe/xe_ras_types.h             | 203 +++++++++++
 drivers/gpu/drm/xe/xe_survivability_mode.c    |  12 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  13 +
 include/drm/drm_device.h                      |   1 +
 16 files changed, 813 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_pci_error.c
 create mode 100644 drivers/gpu/drm/xe/xe_ras.c
 create mode 100644 drivers/gpu/drm/xe/xe_ras.h
 create mode 100644 drivers/gpu/drm/xe/xe_ras_types.h

-- 
2.34.1

