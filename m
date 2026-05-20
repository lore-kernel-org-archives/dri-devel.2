Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74824CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 11:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC1A010F01C;
	Wed, 20 May 2026 11:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GI9U5d4w";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E30C310F01C;
 Wed, 20 May 2026 11:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779277014; x=1810813014;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=uKtXFLd6WpSFqWSnptJgggXrUzFIaZgwpB27BIaeAd0=;
 b=GI9U5d4wGPMLKu9TLjsaxljmu2ZQj3AxrpRdNN1D+TwkkiqYqFq3QEj0
 gsa5aI5Xwiaa2iqBM7zNO6gqZhFofkG2/49bo8uMeKRbkJRQNbThnPxU1
 BiclELjhNoPQDGTcXvprcC7qk32ASBLTaNUu9WHkK0qEP725mcauBrlcN
 6CHVOJZs/PBA0mK2VVMEW2iDoB+bAOFPs9yQ2yG7lsxi9YlWY+DedK7v0
 HHQ7KS0tpneDAuSm88uHT7Eqqq6eDmoff8l7s37uf6+6+H+4acCHGqx7m
 QAzzq0osFMqFZol8S14BtJpt7VL8u7aqTKmCgTZc6zf0E150XW8UlDlIT g==;
X-CSE-ConnectionGUID: BY6QsyXHQ1+i3eYdpGZa+w==
X-CSE-MsgGUID: MrxNBsAMSmWJ/zg4+rCVwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="84027458"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="84027458"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 04:36:53 -0700
X-CSE-ConnectionGUID: JyCID77tSRyCY8yQE6IWEA==
X-CSE-MsgGUID: V7rwa79aQ9WahsMvpkQ7CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="237153495"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa007.fm.intel.com with ESMTP; 20 May 2026 04:36:49 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v6 0/5] Introduce cold reset recovery method
Date: Wed, 20 May 2026 17:03:52 +0530
Message-ID: <20260520113351.171119-7-mallesh.koujalagi@intel.com>
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

 Documentation/gpu/drm-uapi.rst                |  60 +-
 drivers/gpu/drm/drm_drv.c                     |   2 +
 drivers/gpu/drm/xe/Makefile                   |   1 +
 drivers/gpu/drm/xe/xe_device.c                |  19 +-
 drivers/gpu/drm/xe/xe_device.h                |  15 +
 drivers/gpu/drm/xe/xe_device_types.h          |   6 +
 drivers/gpu/drm/xe/xe_gt.c                    |  14 +-
 drivers/gpu/drm/xe/xe_guc_submit.c            |   9 +-
 drivers/gpu/drm/xe/xe_pci.c                   |  10 +
 drivers/gpu/drm/xe/xe_pci_error.c             | 138 +++++
 drivers/gpu/drm/xe/xe_ras.c                   | 567 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |   5 +-
 drivers/gpu/drm/xe/xe_ras_types.h             | 215 +++++++
 drivers/gpu/drm/xe/xe_survivability_mode.c    |  13 +-
 drivers/gpu/drm/xe/xe_sysctrl_event.c         |   2 +-
 drivers/gpu/drm/xe/xe_sysctrl_event_types.h   |   2 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  11 +
 include/drm/drm_device.h                      |   1 +
 18 files changed, 1069 insertions(+), 21 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_pci_error.c

-- 
2.34.1

