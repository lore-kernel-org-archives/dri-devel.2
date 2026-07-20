Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC3BC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC0B10E863;
	Mon, 20 Jul 2026 10:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WSEyutcF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC9CC10E161;
 Mon, 20 Jul 2026 10:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784542931; x=1816078931;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Nbe+7ueollokR2LMuvdixnDLwY1fCmunk+iwimAhyN4=;
 b=WSEyutcFgsfkg6fjy5jOmbhhnOun5hJQo3HLhqvS8t8HyUvWJmXne2Xu
 Cvyv4Cxt0j2az+pLN+S8m/jWZ+1uUIPmlH8Me2SBgV5pMaigQuqlYAteT
 w0NtRJgUYOycJGyIzHu0ymTTjy/5q1b2rWgqPRBjiiNDUcR4cIEzDjAyC
 sz3UzL1nQ+tQsO9OHS6wsU0Mc83Zivs41YnUODgdOQovRlZQeml1phSPb
 erVlKRXvu9y3AMBRr/BCOwyorWg/ATY51zi7BbuTCbBObTmv0L3H1bW1a
 Gdo3Xd5b2B44tirfRgqrbu2z+QJ3OSxnRGKSGWN8XusmXAsSJOVPKv6gJ A==;
X-CSE-ConnectionGUID: JaGkPJmISyS1zM5+jsaeww==
X-CSE-MsgGUID: NvO94CGqRXOYRavbvxEW4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85070508"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85070508"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:22:10 -0700
X-CSE-ConnectionGUID: oxTh0wrFSYS3SfkQ88ZaXw==
X-CSE-MsgGUID: hp4N8HuZRfC8dRRoX+7c8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="287475784"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa002.jf.intel.com with ESMTP; 20 Jul 2026 03:22:07 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v11 0/3] Introduce cold reset recovery method
Date: Mon, 20 Jul 2026 15:48:16 +0530
Message-ID: <20260720101815.526813-5-mallesh.koujalagi@intel.com>
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

Add support for handling errors that require a complete
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

v11:
- Make udev rules in single line. (Sashiko)

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

 Documentation/gpu/drm-uapi.rst | 93 ++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/drm_drv.c      |  2 +
 drivers/gpu/drm/xe/xe_ras.c    |  8 ++-
 include/drm/drm_device.h       |  1 +
 4 files changed, 98 insertions(+), 6 deletions(-)

-- 
2.48.1

