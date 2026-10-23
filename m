Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E78606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MO0OqL1T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A8A112B90;
	Fri, 23 Oct 2026 12:20:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C75E112B17;
 Fri, 23 Oct 2026 12:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792758037; x=1824294037;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=RfIGYwc1p5QQFfjO425LqTL9402FHAbInWR+9FbIi9M=;
 b=MO0OqL1TQfV/UZP+jGrrf0IfZpHZkDs1p51XPX0XBSiV/r2TWhcb2UO4
 3VcK7EPwftlge0dEfmDg7XRzP8q+Tor9uFCI9r/bevpGR71ON6Bx0d4z+
 kjHW3VvMTdB/UttiRpJQYNDANeF1CI+4YrbIzL3BuEKeKF376bbJXd5Dd
 Kd2sxQk0vX4bcgMD2OsDsx8Qzvz3w3fi4gCHNY4SaU4COY8RGBR8pZB25
 AQ8EBzg8avOb/bwCt7Obyl6tOUH1aeksS6AdRcMxlHupSRKUBeipQh3ux
 v+9s0XCorraS8DVY3HNamuT9aqiR/K9Dd74i/7NUSE8emRV2konX+sPSG Q==;
X-CSE-ConnectionGUID: ClbZdvO6TIaiCnZ6FSfNQg==
X-CSE-MsgGUID: 6CoolAe9QgyhzNlwExEb/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1529133"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1529133"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 05:20:32 -0700
X-CSE-ConnectionGUID: 9LtER6/xRSu+syoDQ/ejdw==
X-CSE-MsgGUID: 4sdz/4jVTJmPYxD5dpkAOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3525062"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.179])
 ([10.245.244.179])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 05:20:21 -0700
Message-ID: <81f099a7-62f4-4103-89a4-78622c342e13@linux.intel.com>
Date: Fri, 23 Oct 2026 14:20:14 +0200
X-Archived-By: <archiver.kernel.org>
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
Subject: [PULL] drm-misc-next
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Sima,

New pull request for drm-misc-next!

Kind regards,
~Maarten Lankhorst

drm-misc-next-2026-10-23:
drm-misc-next for v7.5:

UAPI Changes:

Cross-subsystem Changes:
- Add CI pipelines for drm-misc-*.
- Respect device's max sg segment size in udmabuf.

Core Changes:
- Enable support for two-pass locking in ttm.
- Improve drm_gpuvm_init for rust.

Driver Changes:
- Assorted fixes to adp, accel/amdxdna, imagination.
- Cleanup a few unnecessary drm_simple_kms_helper.h includes.
- Add BOE NE140WUM-N41 panel.
- Convert drivers to use atomic_create_state in preparation for readout.
- Add support for new firmware version to amdxdna, and implement more
  features of AIE4.
The following changes since commit db1de27aca30ebaad04aea74ac21e4c4fb531a37:

  drm/adp: Switch to drm_atomic_helper_connector_create_state (2026-10-16 17:08:45 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-10-23

for you to fetch changes up to cf5d8e390e2ac2cfa24a50645efdbb9f0eebe65f:

  accel/amdxdna: Implement runtime suspend and resume support (2026-10-21 09:32:51 -0700)

----------------------------------------------------------------
drm-misc-next for v7.5:

UAPI Changes:

Cross-subsystem Changes:
- Add CI pipelines for drm-misc-*.
- Respect device's max sg segment size in udmabuf.

Core Changes:
- Enable support for two-pass locking in ttm.
- Improve drm_gpuvm_init for rust.

Driver Changes:
- Assorted fixes to adp, accel/amdxdna, imagination.
- Cleanup a few unnecessary drm_simple_kms_helper.h includes.
- Add BOE NE140WUM-N41 panel.
- Convert drivers to use atomic_create_state in preparation for readout.
- Add support for new firmware version to amdxdna, and implement more
  features of AIE4.

----------------------------------------------------------------
Alessio Belle (4):
      drm/imagination: Improve logging of unknown freelist IDs
      drm/imagination: Remove wrong soft reset code from GPU start sequence
      drm/imagination: Add utility function to write and read back register
      drm/imagination: Check virtual address space size only once

Alice Ryhl (1):
      drm/gpuvm: skip setting kernel_alloc_node range on overflow

Aryan Sinha (1):
      accel: ethosu: Fix kernel-doc for ethosu_gem_cmdstream_create()

David Zhang (19):
      accel/amdxdna: Rename NPU3 firmware files
      accel/amdxdna: Remove mmap for doorbell
      accel/amdxdna: Add CERT firmware version support
      accel/amdxdna: Support firmware 6.0
      accel/amdxdna: Add NPU3 classic device support
      accel/amdxdna: Add AIE version query to aie4_get_info
      accel/amdxdna: Add get and set power_mode for AIE4
      accel/amdxdna: Add clock, DPM frequency, and resource info queries for AIE4
      accel/amdxdna: Add context switch hysteresis with debugfs control
      accel/amdxdna: Refactor AIE4 hardware initialization sequence
      accel/amdxdna: Decouple AIE4 doorbell and MSI-X notify transport hooks
      accel/amdxdna: Implement AIE4 kernel queue lifecycle and memory layout
      accel/amdxdna: Prepare for AIE4 command submission
      accel/amdxdna: Move HMM invalidate wait into common GEM code
      accel/amdxdna: Make populate_range common for AIE2 and AIE4
      accel/amdxdna: Implement AIE4 command packet building and submission
      accel/amdxdna: Enable AIE4 firmware logging to DRAM
      accel/amdxdna: Implement AIE4 suspend and resume
      accel/amdxdna: Implement runtime suspend and resume support

Karl Mehltretter (1):
      udmabuf: respect the device's maximum segment size

Lizhi Hou (1):
      accel/amdxdna: Serialize HMM range faults on one umap

Luke Macken (1):
      drm/panel-edp: Add BOE NE140WUM-N41 (0x0d9b) panel

Matthew Auld (1):
      gpu/buddy: do not pass caller list to __alloc_contig_try_harder()

Matthew Brost (7):
      accel/amdxdna: Wait uninterruptibly for jobs in the HMM invalidate callback
      drm/gpuvm: allow locking external objects in two passes
      drm/xe: lock the resident BOs of an exec last
      drm/panthor: lock the resident BOs of a submit last
      drm/msm: reject a submit_bo table on VM_BIND contexts
      drm/msm: use DRM_GPUVM_RESV_PROTECTED for VM_BIND VMs
      drm/msm: lock the resident BOs of a VM_BIND submit last

Maxime Ripard (8):
      drm/vmwgfx: Convert to atomic_create_state
      drm/amdgpu: dm: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: sii902x: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: simple-bridge: Switch to drm_atomic_helper_connector_create_state
      drm/msm: dpu1: Switch to drm_atomic_helper_connector_create_state
      drm/stm: Switch to drm_atomic_helper_connector_create_state
      drm/rcar-du: Convert to atomic_create_state
      drm/ci: Add CI pipeline for drm-misc branches

Thomas Zimmermann (7):
      drm/hyperv: Add missing include statements
      drm/kms-helper: Remove struct drm_simple_display_pipe and helpers
      drm/bridge: Do not include <drm/drm_simple_kms_helper.h>
      drm/hisilicon/hibmc: Do not include <drm/drm_simple_kms_helper.h>
      drm/tegra: Do not include <drm/drm_simple_kms_helper.h>
      drm/verisilicon: Do not include <drm/drm_simple_kms_helper.h>
      drm/vc4: Do not include <drm/drm_simple_kms_helper.h>

 Documentation/gpu/drm-mm.rst                       |    6 +
 Documentation/gpu/todo.rst                         |   17 -
 drivers/accel/amdxdna/aie.c                        |   33 +-
 drivers/accel/amdxdna/aie.h                        |   47 +-
 drivers/accel/amdxdna/aie2_ctx.c                   |   90 +-
 drivers/accel/amdxdna/aie2_message.c               |    4 +-
 drivers/accel/amdxdna/aie2_pci.c                   |   67 +-
 drivers/accel/amdxdna/aie2_pci.h                   |   40 +-
 drivers/accel/amdxdna/aie2_pm.c                    |   10 +-
 drivers/accel/amdxdna/aie4_ctx.c                   | 1139 ++++++++++++++++++--
 drivers/accel/amdxdna/aie4_host_queue.h            |   72 +-
 drivers/accel/amdxdna/aie4_message.c               |  245 +++++
 drivers/accel/amdxdna/aie4_msg_priv.h              |  149 ++-
 drivers/accel/amdxdna/aie4_pci.c                   |  818 +++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h                   |  117 +-
 drivers/accel/amdxdna/aie4_sriov.c                 |   66 +-
 drivers/accel/amdxdna/amdxdna_ctx.c                |   72 +-
 drivers/accel/amdxdna/amdxdna_ctx.h                |   28 +-
 drivers/accel/amdxdna/amdxdna_debugfs.c            |    3 +
 drivers/accel/amdxdna/amdxdna_gem.c                |   89 +-
 drivers/accel/amdxdna/amdxdna_gem.h                |    2 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c            |   46 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h            |   20 +-
 drivers/accel/amdxdna/amdxdna_pm.c                 |   26 +
 drivers/accel/amdxdna/amdxdna_pm.h                 |    2 +
 drivers/accel/amdxdna/amdxdna_sysfs.c              |    2 +-
 drivers/accel/amdxdna/npu1_regs.c                  |   19 +-
 drivers/accel/amdxdna/npu3_regs.c                  |  105 +-
 drivers/accel/amdxdna/npu4_regs.c                  |   30 +-
 drivers/accel/ethosu/ethosu_gem.c                  |    2 +-
 drivers/dma-buf/udmabuf.c                          |   13 +-
 drivers/gpu/buddy.c                                |   20 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |    2 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |    2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |    7 +-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |    2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |    2 +-
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |    4 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |    2 +-
 drivers/gpu/drm/bridge/inno-hdmi.c                 |    1 -
 drivers/gpu/drm/bridge/microchip-lvds.c            |    1 -
 drivers/gpu/drm/bridge/sii902x.c                   |    2 +-
 drivers/gpu/drm/bridge/simple-bridge.c             |    2 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |    1 -
 drivers/gpu/drm/bridge/tda998x_drv.c               |    1 -
 drivers/gpu/drm/ci/drm-misc-ci.yml                 |  147 +++
 drivers/gpu/drm/drm_gem_atomic_helper.c            |   92 --
 drivers/gpu/drm/drm_gpuvm.c                        |  518 ++++++++-
 drivers/gpu/drm/drm_simple_kms_helper.c            |  328 ------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c     |    1 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |    1 -
 drivers/gpu/drm/hyperv/hyperv_drm.h                |    5 +
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c            |    1 -
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c          |    1 -
 drivers/gpu/drm/imagination/pvr_device.c           |   43 +-
 drivers/gpu/drm/imagination/pvr_device.h           |   28 +
 drivers/gpu/drm/imagination/pvr_free_list.c        |   13 +-
 drivers/gpu/drm/imagination/pvr_fw_meta.c          |    5 +-
 drivers/gpu/drm/imagination/pvr_fw_startstop.c     |   37 +-
 drivers/gpu/drm/imagination/pvr_mmu.h              |    2 +-
 drivers/gpu/drm/imagination/pvr_vm.c               |   22 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |    2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |   90 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |   16 +-
 drivers/gpu/drm/panel/panel-edp.c                  |    1 +
 drivers/gpu/drm/panthor/panthor_mmu.c              |   55 +-
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    |   16 +-
 drivers/gpu/drm/stm/lvds.c                         |    2 +-
 drivers/gpu/drm/tegra/output.c                     |    1 -
 drivers/gpu/drm/vc4/vc4_dpi.c                      |    1 -
 drivers/gpu/drm/vc4/vc4_dsi.c                      |    1 -
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |    1 -
 drivers/gpu/drm/vc4/vc4_vec.c                      |    1 -
 drivers/gpu/drm/verisilicon/vs_bridge.c            |    1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   23 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |    3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |    2 +-
 drivers/gpu/drm/xe/xe_exec.c                       |   23 +-
 drivers/gpu/drm/xe/xe_vm.c                         |   43 +-
 drivers/gpu/drm/xe/xe_vm.h                         |    3 +-
 drivers/gpu/tests/gpu_buddy_test.c                 |    9 +
 drivers/staging/fbtft/TODO                         |    4 +-
 include/drm/drm_gem_atomic_helper.h                |   28 -
 include/drm/drm_gpuvm.h                            |  139 ++-
 include/drm/drm_simple_kms_helper.h                |   56 +-
 87 files changed, 4078 insertions(+), 1119 deletions(-)
 create mode 100644 drivers/gpu/drm/ci/drm-misc-ci.yml
