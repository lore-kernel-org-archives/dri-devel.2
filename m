Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A76AC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F2710F2D8;
	Fri, 24 Jul 2026 07:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PfmJGy/R";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C33A10F2D8;
 Fri, 24 Jul 2026 07:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784876629; x=1816412629;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=m2M8cu2pJ21Uvg2STbZRPd6qnnGftsn2h56ng7Eja0g=;
 b=PfmJGy/Rp43mBbGLe6uVWuW/Q+6UAlvzGnVWJo+Ytjt1G/kI10Y7CVQd
 xSl2CRhrvnrGiGFegnYmlVxAYL+X1BI8GjwRnGhnReWtBGqNFMoUaKU+4
 syqt9vCv8WF9BrlRm4B8NwQe8TW2DgKuvpNOHSvLJfE7tyDJ/JiF8XrxO
 eBwsU+R7TICFH3Koh1z1O9uT4VTcM0Czc3iQdIsngt3kk3mHOFhxVSB/D
 Zj4/mHdF9G3bEzlQsqXIiNgKWfZmJLNHKi9Uq166+/OkqTa67PlOWvpq7
 Xki2imjyiEzsqwqVqFBiEEPGZpb7igendCFcmj23VaXF0//UFWaB/NbOG Q==;
X-CSE-ConnectionGUID: JQOoFHdaQyWx9evo2BPlQQ==
X-CSE-MsgGUID: F65LNtL1QSiBK0hh4b8lBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85587219"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="85587219"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2026 00:03:48 -0700
X-CSE-ConnectionGUID: B+W7kY7xTWajgD7vIGSsVg==
X-CSE-MsgGUID: bRuXLHuhT9yeJxVhf6UsWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="263605670"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO [10.245.244.238])
 ([10.245.244.238])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2026 00:03:44 -0700
Message-ID: <07284633-6b9b-40f9-8949-b1516a42a34c@linux.intel.com>
Date: Fri, 24 Jul 2026 09:04:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Simona Vetter <simona.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: dim-tools@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PULL] drm-misc-fixes
Content-Language: en-US
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

Hi Dave, Sima,

drm-misc-fixes for next rc!

Kind regards,
~Maarten Lankhorst

drm-misc-fixes-2026-07-24:
drm-misc-fixes for v7.2-rc5:
- Improve damage handling in appletbdrm.
- Fix harmful fragmenting of MM by backing up TTM pages at native
  page order.
- Fix timeout handling in amdxdna.
- Fix imagination locking for map/unmap operations.
- Fix mm leak in gpusvm eviction.
- Properly zero page array in gpusvm mm scanning.
- Prevent trusted shader bo's from being mapped again in vc4.
- Validate shader array size in vmwgfx.
- Fix length calculation bugs in ethosu.
- Better error handling during pagemap migration.
- Improve v3d suspend.
- Kconfig updates for some panels.
- Handle missing iovcc in ili9881c panel.
- Fix vc4 unbind.
- Add i2c error handling in gma500.
- Fix kunit tests on pp64le and s390x.
- Prevent rearming vc4 timer on shutdown.
The following changes since commit faebb7ba1ac65fa5810b640df02ce04e509fdc11:

  accel/amdxdna: Fix use-after-free of mm_struct in job scheduler (2026-07-16 20:05:28 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-07-24

for you to fetch changes up to 1ff399c4cd132a24c73e5e237a11cb9d6b68dff1:

  Revert "drm/pagemap: Guard HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION" (2026-07-24 08:02:14 +0200)

----------------------------------------------------------------
drm-misc-fixes for v7.2-rc5:
- Improve damage handling in appletbdrm.
- Fix harmful fragmenting of MM by backing up TTM pages at native
  page order.
- Fix timeout handling in amdxdna.
- Fix imagination locking for map/unmap operations.
- Fix mm leak in gpusvm eviction.
- Properly zero page array in gpusvm mm scanning.
- Prevent trusted shader bo's from being mapped again in vc4.
- Validate shader array size in vmwgfx.
- Fix length calculation bugs in ethosu.
- Better error handling during pagemap migration.
- Improve v3d suspend.
- Kconfig updates for some panels.
- Handle missing iovcc in ili9881c panel.
- Fix vc4 unbind.
- Add i2c error handling in gma500.
- Fix kunit tests on pp64le and s390x.
- Prevent rearming vc4 timer on shutdown.

----------------------------------------------------------------
David Oberhollenzer (1):
      drm/panel: ilitek-ili9881c: do not fail probe if iovcc is absent

Gregor Herburger (1):
      drm/vc4: hvs/v3d: Fix null dereference in unbind

Ian Forbes (1):
      drm/vmwgfx: Validate vmw_surface_metadata::array_size

Icenowy Zheng (1):
      drm/imagination: acquire vm_ctx->lock before mapping memory to GPU VM

José Expósito (1):
      drm/tests: shmem: Set DMA mask to 64-bit in drm_gem_shmem

Julian Braha (3):
      drm/panel: ilitek-ili9882t: fix unmet dependency for DRM_PANEL_ILITEK_ILI9882T
      drm/panel: s6e3ha8: fix unmet dependency on DRM_DISPLAY_HELPER
      drm/panel: fix unmet dependency bug for DRM_PANEL_HIMAX_HX83121A

Linmao Li (2):
      drm/vc4: Prevent shader BO mappings from becoming writable
      drm/vc4: Shut down BO cache timer before teardown

Maarten Lankhorst (1):
      Revert "drm/pagemap: Guard HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION"

Matthew Brost (4):
      drm/ttm/pool: back up at native page order
      drm/gpusvm: Fix MM reference leak in drm_gpusvm_range_evict
      drm/pagemap: Clear driver-provided PFNs from migration PFN array
      drm/pagemap: Guard HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION

Maíra Canal (3):
      mailmap: Update Maíra Canal's email address
      drm/v3d: Reach the GMP through the hub registers on V3D 7.x
      drm/v3d: Idle AXI transactions before disabling the clock on suspend

Pengpeng Hou (1):
      drm/gma500: return errors from Oaktrail HDMI I2C reads

Rob Herring (Arm) (2):
      accel: ethosu: Fix element size accounting for cmd stream validation
      accel: ethosu: Handle U85 internal chaining buffer

Stanislav Kinsburskii (1):
      drm/gpusvm: Zero HMM PFNs before scanning ranges

Thomas Zimmermann (1):
      drm/appletbdrm: Allocate request/response buffers in begin_fb_access

Wendy Liang (1):
      accel/amdxdna: Fix command timeout race

 .mailmap                                      |   1 +
 drivers/accel/amdxdna/aie2_ctx.c              |  26 ++++--
 drivers/accel/amdxdna/aie2_pci.c              |   1 +
 drivers/accel/amdxdna/aie2_pci.h              |   7 +-
 drivers/accel/ethosu/ethosu_gem.c             |  54 +++++++----
 drivers/gpu/drm/drm_gpusvm.c                  |   6 +-
 drivers/gpu/drm/drm_pagemap.c                 |  11 ++-
 drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c    |  21 +++--
 drivers/gpu/drm/imagination/pvr_vm.c          |   2 +
 drivers/gpu/drm/panel/Kconfig                 |   3 +
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c |   7 +-
 drivers/gpu/drm/tests/drm_gem_shmem_test.c    |  16 ++--
 drivers/gpu/drm/tiny/appletbdrm.c             |  53 ++++++-----
 drivers/gpu/drm/ttm/ttm_backup.c              | 123 +++++++++++++++++---------
 drivers/gpu/drm/ttm/ttm_pool.c                |  89 +++++++++++++++----
 drivers/gpu/drm/ttm/ttm_pool_internal.h       |   8 ++
 drivers/gpu/drm/v3d/v3d_drv.h                 |   2 +
 drivers/gpu/drm/v3d/v3d_gem.c                 |  16 +++-
 drivers/gpu/drm/v3d/v3d_power.c               |   7 ++
 drivers/gpu/drm/vc4/vc4_bo.c                  |  12 ++-
 drivers/gpu/drm/vc4/vc4_hvs.c                 |   2 +-
 drivers/gpu/drm/vc4/vc4_v3d.c                 |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c       |  22 +++--
 include/drm/ttm/ttm_backup.h                  |  12 +--
 24 files changed, 355 insertions(+), 148 deletions(-)
