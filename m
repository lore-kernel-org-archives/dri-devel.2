Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A17C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999DE10E65C;
	Mon, 13 Jul 2026 08:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hsWt/brN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1517010E866;
 Mon, 13 Jul 2026 08:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783932206; x=1815468206;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=alTSpKSQs27e75ukLSjfbEXioTiLDlcHn9L262AUuKc=;
 b=hsWt/brN03lXDqTbxavQN/KJKnrtLv0LuGkodyH87SM1OLk4zwYP8FfQ
 q1KU8W0FZCG25kW81hHioq7L6b0ad54AjBB8b9bFGmb9AH9C+U5eKRKkC
 gndd1mFVLTfbE7Hjzikn/WIGQoUy3BVdbu2Av9TD8WzwD6gkfdFdK/a2X
 eEJPYgyzRyXDPILkoSi/RH9kSHm/rm84iWaL3mhHxszox0s/Iu88Acaeh
 xZaordRfcY/8vwJ1Jjfxh94v6x3aeJ2lYW0JBgP7V8wNlMl+tnnrPGC7V
 t0LHqlMLD7F5aLRSCSa04mGHPKygaCYTWdVYYGFVDnSgxiCZnuXcofc8B w==;
X-CSE-ConnectionGUID: OhfDKasgSkiitgyDMlUhiw==
X-CSE-MsgGUID: Y2dni422Q0+HehZ9PS+YXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95903945"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95903945"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 01:43:26 -0700
X-CSE-ConnectionGUID: s2Im1l2eRKKG723mADf2wA==
X-CSE-MsgGUID: eavohGnXQrCXG55zeYWKbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="251072975"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa006.fm.intel.com with ESMTP; 13 Jul 2026 01:43:21 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v10 0/4] Introduce cold reset recovery method
Date: Mon, 13 Jul 2026 14:09:40 +0530
Message-ID: <20260713083939.251872-6-mallesh.koujalagi@intel.com>
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

v9:
- Remove unwanted header. (Sashiko)
- Removed #ifdef CONFIG_PCIEAER. (Riana)
- Used pci_find_ext_capability() instead of usp->aer_cap.
- Clear the PCI_ERR_UNC_SURPDN status bit (W1C) after
  reset complete. (Lukas Wunner)
- Use pci_clear_and_set_config_dword() helper.

v10:
- Rebase.
- Fix column width. (Sashiko) 

Cc: André Almeida <andrealmeid@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>

Mallesh Koujalagi (3):
  drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method
  drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET recovery method
  drm/xe: Handle PUNIT errors by requesting cold-reset recovery

Riana Tauro (1):
  drm/xe/xe_ras: Do not Review, compilation only.

 Documentation/gpu/drm-uapi.rst    | 91 +++++++++++++++++++++++++++++--
 drivers/gpu/drm/drm_drv.c         |  2 +
 drivers/gpu/drm/xe/xe_ras.c       | 49 +++++++++++++++++
 drivers/gpu/drm/xe/xe_ras_types.h | 80 +++++++++++++++++++++++++++
 include/drm/drm_device.h          |  1 +
 5 files changed, 219 insertions(+), 4 deletions(-)

-- 
2.48.1

