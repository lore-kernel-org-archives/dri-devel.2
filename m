Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62B7CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 13:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF2A10EAA7;
	Tue, 12 May 2026 13:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ea6pgNYu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF10210EAA7;
 Tue, 12 May 2026 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778592568; x=1810128568;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Aa7rxsAs/sYFwfgXB3mJJNsnj4/qBnaD6Y7+0T/crN0=;
 b=ea6pgNYu115SlRY6TbSB08CggRBvaTCJtgwTPMyj5ejWUobBEZARxE0h
 m2TGgDDYjp8OGrBGT4vk5OMCmkggkqKtOjGELYC5kC2zxuz91jUl/8B09
 UMifbN9hL4tLoQpG8Lez7LZOibGNeyrWs4nJ4AtqEA0xSN/8lRsJZzyvb
 Mnq2kF8h7fCZatqi3DnKmDeH1RHSaxzFJoPBKGTjlVcbV5q8iKjHvVnb9
 jreiJpGaBFrWsHtHM3ZIICMA629pem8wG05DpThtLuLN3Q5MYoKE5QVVZ
 lxM/AJUCki6Y3ycO2C47nxo8CCqnmqVjJ6M/jARbx3ESXWNcFr03huyT8 Q==;
X-CSE-ConnectionGUID: g9vtMUYYQ9mBC+simu9FYg==
X-CSE-MsgGUID: WtJIfY91TJ6Sg0BKDlrq/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="102164645"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="102164645"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 06:29:27 -0700
X-CSE-ConnectionGUID: 7kKFv5NTS86pPpiz/ke8Iw==
X-CSE-MsgGUID: 9sHYz3+QQHOXQoDuvVTnwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="237855854"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa009.jf.intel.com with ESMTP; 12 May 2026 06:29:23 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v5 0/5] Introduce cold reset recovery method
Date: Tue, 12 May 2026 18:56:15 +0530
Message-ID: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
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

Cc: André Almeida <andrealmeid@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>

Mallesh Koujalagi (4):
  drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method
  drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET recovery method
  drm/xe: Handle PUNIT errors by requesting cold-reset recovery
  drm/xe: Suppress Surprise Link Down on non-hotplug device

Riana Tauro (1):
  Introduce Xe Uncorrectable Error Handling

 Documentation/gpu/drm-uapi.rst                |  64 +-
 drivers/gpu/drm/drm_drv.c                     |   2 +
 drivers/gpu/drm/xe/Makefile                   |   1 +
 drivers/gpu/drm/xe/xe_device.c                |  19 +-
 drivers/gpu/drm/xe/xe_device.h                |  15 +
 drivers/gpu/drm/xe/xe_device_types.h          |   6 +
 drivers/gpu/drm/xe/xe_gt.c                    |  14 +-
 drivers/gpu/drm/xe/xe_guc_submit.c            |   9 +-
 drivers/gpu/drm/xe/xe_pci.c                   |  10 +
 drivers/gpu/drm/xe/xe_pci_error.c             | 138 +++++
 drivers/gpu/drm/xe/xe_ras.c                   | 552 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |   5 +-
 drivers/gpu/drm/xe/xe_ras_types.h             | 215 +++++++
 drivers/gpu/drm/xe/xe_survivability_mode.c    |  13 +-
 drivers/gpu/drm/xe/xe_sysctrl_event.c         |   2 +-
 drivers/gpu/drm/xe/xe_sysctrl_event_types.h   |   2 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  11 +
 include/drm/drm_device.h                      |   1 +
 18 files changed, 1058 insertions(+), 21 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_pci_error.c

-- 
2.34.1

