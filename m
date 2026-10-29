Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6D606A323
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NLuNa/hV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09707112354;
	Thu, 29 Oct 2026 14:42:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C83F10E110;
 Thu, 29 Oct 2026 14:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793284926; x=1824820926;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=cPIpGwMsK40ZmgMXS8+Oc2H49uEAbyXDlCo7W73KXkk=;
 b=NLuNa/hVoc7mM3U0KTxCzLUTB962061VFB9bfJ999AOvp0PotWOpWxyv
 KHPZ/h4ko4JyoWacIyK8Zo5WsfC1yChYZ4oyXtyy/apTR4i8gekXiOYfj
 737VQxY5dSyioPjtpHIdjqaNc3yrDqaUgZpVArr8Iq6hLmTyOz7Y3FX+H
 aTArv/1QrOIL88aP5F7OXrGe1MsH2xhiH4wpzO4Yz2uD43aRc62vQ/i7p
 oLC1KV1oBuqG+HHKmUHj7d2ldSDKfoRcqBA/mcNJnuDHIC7q1WgvWyZV5
 QcY+UEnp+I6VTiCQoEOtcaKdJB+P3e2Z7RXr78LD8+kElgnLN1wy7qWiX A==;
X-CSE-ConnectionGUID: FPIyNHqqTjaFW0HUkUEU3A==
X-CSE-MsgGUID: sjcJHf7OTuul/lSzuBITWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2046250"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2046250"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 07:42:05 -0700
X-CSE-ConnectionGUID: io79ij54Ssq5FRNwxd05iw==
X-CSE-MsgGUID: XrX1BiZ8Rb+Y70Emk1R/jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5052788"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.245.177])
 ([10.245.245.177])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 07:42:01 -0700
Message-ID: <ba231556-17a6-4b2b-8ebc-3150f887db48@linux.intel.com>
Date: Thu, 29 Oct 2026 15:41:54 +0100
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
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Sima,

Quiet drm-misc-next pull, but it seems the one from the 16th hasn't been pulled yet.

So I'm only adding the changelog compared to that one.

Kind regards,
~Maarten Lankhorst

drm-misc-next-2026-10-29:
drm-misc-next for v7.5:

UAPI Changes:
- Add TFU constant color suport for v3d.

Core Changes:
- tidss devicetree bindings updates.

Driver Changes:
- Assorted fixes and cleanups in panthor, arm/hdlcd, amdxdna, bridge/sii902x,
  v3d, tidss, imagination, ivpu.
- Add BOE NV116WH2-M32 V8.0, PNB601LS1-3 HW:1.2 panels.
The following changes since commit db1de27aca30ebaad04aea74ac21e4c4fb531a37:

  drm/adp: Switch to drm_atomic_helper_connector_create_state (2026-10-16 17:08:45 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-10-29

for you to fetch changes up to 33ed26235db93162935d1719bc6f538c384a2fd8:

  accel/ivpu: Read preemption buffer size from boot params (2026-10-29 09:24:25 +0100)

----------------------------------------------------------------
drm-misc-next for v7.5:

UAPI Changes:
- Add TFU constant color suport for v3d.

Core Changes:
- tidss devicetree bindings updates.

Driver Changes:
- Assorted fixes and cleanups in panthor, arm/hdlcd, amdxdna, bridge/sii902x,
  v3d, tidss, imagination, ivpu.
- Add BOE NV116WH2-M32 V8.0, PNB601LS1-3 HW:1.2 panels.

----------------------------------------------------------------
Alessio Belle (4):
      drm/imagination: Improve logging of unknown freelist IDs
      drm/imagination: Remove wrong soft reset code from GPU start sequence
      drm/imagination: Add utility function to write and read back register
      drm/imagination: Check virtual address space size only once

Alice Ryhl (1):
      drm/gpuvm: skip setting kernel_alloc_node range on overflow

Andrzej Kacprowski (1):
      accel/ivpu: Read preemption buffer size from boot params

Aryan Sinha (1):
      accel: ethosu: Fix kernel-doc for ethosu_gem_cmdstream_create()

Daniel Stone (2):
      drm/panthor: Add neural-engine presence and power bits for v14+
      drm/panthor: Delegate neural power domain to CSF when present

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

Marek Szyprowski (1):
      drm/arm/hdlcd: Attach the output bridge directly

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

Max Zhen (1):
      accel/amdxdna: Use compatible fdinfo engine key

Maxime Ripard (8):
      drm/vmwgfx: Convert to atomic_create_state
      drm/amdgpu: dm: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: sii902x: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: simple-bridge: Switch to drm_atomic_helper_connector_create_state
      drm/msm: dpu1: Switch to drm_atomic_helper_connector_create_state
      drm/stm: Switch to drm_atomic_helper_connector_create_state
      drm/rcar-du: Convert to atomic_create_state
      drm/ci: Add CI pipeline for drm-misc branches

Maíra Canal (4):
      drm/panthor: Replace panthor_mmu_as_fault_mask() with a macro
      drm/v3d: Validate the v71 fields of the TFU submit ioctl
      drm/v3d: Only program TFU coefficients when used on V3D 7.x
      drm/v3d: Add TFU constant colour support for V3D 7.x

Raag Jadav (1):
      drm: Log recovery method with wedged event

Rob Herring (Arm) (1):
      drm/bridge: sii902x: Read "sil,i2s-data-lanes" as u32

Rosen Penev (1):
      drm/imagination: simplify pvr_fw_trace_seq_data

Ryan Zhang (1):
      drm/panthor: dummy read to discard the stale first GPU_TIMESTAMP read

Terry Hsiao (1):
      drm/panel-edp: Add BOE NV116WH2-M32 V8.0, PNB601LS1-3 HW:1.2

Thomas Zimmermann (7):
      drm/hyperv: Add missing include statements
      drm/kms-helper: Remove struct drm_simple_display_pipe and helpers
      drm/bridge: Do not include <drm/drm_simple_kms_helper.h>
      drm/hisilicon/hibmc: Do not include <drm/drm_simple_kms_helper.h>
      drm/tegra: Do not include <drm/drm_simple_kms_helper.h>
      drm/verisilicon: Do not include <drm/drm_simple_kms_helper.h>
      drm/vc4: Do not include <drm/drm_simple_kms_helper.h>

Tomi Valkeinen (10):
      dt-bindings: display: ti: Move ti,am62l-dss binding to a new binding file
      dt-bindings: display: ti,am65x-dss: Simplify binding
      dt-bindings: display: ti,am625-oldi: Add optional power-domain for OLDI
      drm/tidss: Remove extra pm_runtime_mark_last_busy
      drm/tidss: oldi: Remove define for unused register OLDI_LB_CTRL
      drm/tidss: Add mechanism to detect DPI output
      drm/tidss: Add support for DPIENABLE bit
      drm/tidss: oldi: Fix OLDI signal polarities
      drm/tidss: Drop WARN_ON() from tidss_runtime_put()
      drm/tidss: oldi: Fix missing of_node_put()s in error paths

 Documentation/accel/amdxdna/amdnpu.rst             |    2 +-
 .../bindings/display/ti/ti,am625-oldi.yaml         |    3 +
 .../bindings/display/ti/ti,am62l-dss.yaml          |  136 +++
 .../bindings/display/ti/ti,am65x-dss.yaml          |  149 +--
 Documentation/gpu/drm-mm.rst                       |    6 +
 Documentation/gpu/todo.rst                         |   17 -
 MAINTAINERS                                        |    1 +
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
 drivers/accel/amdxdna/amdxdna_pci_drv.c            |   50 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h            |   20 +-
 drivers/accel/amdxdna/amdxdna_pm.c                 |   26 +
 drivers/accel/amdxdna/amdxdna_pm.h                 |    2 +
 drivers/accel/amdxdna/amdxdna_sysfs.c              |    2 +-
 drivers/accel/amdxdna/npu1_regs.c                  |   19 +-
 drivers/accel/amdxdna/npu3_regs.c                  |  105 +-
 drivers/accel/amdxdna/npu4_regs.c                  |   30 +-
 drivers/accel/ethosu/ethosu_gem.c                  |    2 +-
 drivers/accel/ivpu/ivpu_drv.c                      |   11 +-
 drivers/accel/ivpu/ivpu_drv.h                      |    2 +-
 drivers/accel/ivpu/ivpu_fw.c                       |   91 +-
 drivers/accel/ivpu/ivpu_fw.h                       |    1 +
 drivers/accel/ivpu/ivpu_job.c                      |    3 +
 drivers/accel/ivpu/ivpu_pm.c                       |    2 +-
 drivers/accel/ivpu/vpu_boot_api.h                  |   36 +-
 drivers/dma-buf/udmabuf.c                          |   13 +-
 drivers/gpu/buddy.c                                |   20 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |    2 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |    2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |    7 +-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |    2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |    2 +-
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |    4 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |    2 +-
 drivers/gpu/drm/arm/Kconfig                        |    4 +-
 drivers/gpu/drm/arm/hdlcd_drv.c                    |   85 +-
 drivers/gpu/drm/arm/hdlcd_drv.h                    |    1 +
 drivers/gpu/drm/bridge/inno-hdmi.c                 |    1 -
 drivers/gpu/drm/bridge/microchip-lvds.c            |    1 -
 drivers/gpu/drm/bridge/sii902x.c                   |   22 +-
 drivers/gpu/drm/bridge/simple-bridge.c             |    2 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |    1 -
 drivers/gpu/drm/bridge/tda998x_drv.c               |    1 -
 drivers/gpu/drm/ci/drm-misc-ci.yml                 |  147 +++
 drivers/gpu/drm/drm_drv.c                          |    4 +-
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
 drivers/gpu/drm/imagination/pvr_fw_trace.c         |   25 +-
 drivers/gpu/drm/imagination/pvr_mmu.h              |    2 +-
 drivers/gpu/drm/imagination/pvr_vm.c               |   22 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |    2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |   90 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |   16 +-
 drivers/gpu/drm/panel/panel-edp.c                  |    3 +
 drivers/gpu/drm/panthor/panthor_gpu.c              |    4 +
 drivers/gpu/drm/panthor/panthor_gpu_regs.h         |    1 +
 drivers/gpu/drm/panthor/panthor_hw.h               |    6 +
 drivers/gpu/drm/panthor/panthor_mmu.c              |   72 +-
 drivers/gpu/drm/panthor/panthor_mmu_regs.h         |    1 +
 drivers/gpu/drm/panthor/panthor_pwr.c              |   29 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h         |    7 +
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    |   16 +-
 drivers/gpu/drm/stm/lvds.c                         |    2 +-
 drivers/gpu/drm/tegra/output.c                     |    1 -
 drivers/gpu/drm/tidss/tidss_crtc.c                 |   10 +-
 drivers/gpu/drm/tidss/tidss_crtc.h                 |    4 +-
 drivers/gpu/drm/tidss/tidss_dispc.c                |   28 +-
 drivers/gpu/drm/tidss/tidss_dispc.h                |    5 +-
 drivers/gpu/drm/tidss/tidss_dispc_regs.h           |    1 +
 drivers/gpu/drm/tidss/tidss_drv.c                  |    7 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |   70 +-
 drivers/gpu/drm/tidss/tidss_oldi.c                 |   46 +-
 drivers/gpu/drm/tidss/tidss_oldi.h                 |    1 -
 drivers/gpu/drm/v3d/v3d_drv.c                      |    3 +
 drivers/gpu/drm/v3d/v3d_regs.h                     |   19 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |   30 +-
 drivers/gpu/drm/v3d/v3d_submit.c                   |    9 +
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
 include/uapi/drm/v3d_drm.h                         |    5 +
 124 files changed, 4693 insertions(+), 1389 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/ti/ti,am62l-dss.yaml
 create mode 100644 drivers/gpu/drm/ci/drm-misc-ci.yml
