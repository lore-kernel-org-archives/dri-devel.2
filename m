Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C4A606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BPOJn/Dq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C43F112768;
	Thu, 19 Nov 2026 22:27:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C5C112756;
 Thu, 19 Nov 2026 22:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795127234; x=1826663234;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=Dl3zM7+W6L3iF+ifl0nE5H3bARVro7li5Na8wXYEdFU=;
 b=BPOJn/DqFcEv3om9GULoWncK0MqFeW5lsZzFRJRQACnbqm1htb7W7N+a
 nSIhnBeq2P+DsWmCEF+ISQJaUHzrwLeCgt+XEuEKsni1bo60llgKxCs7H
 Ihr1UZrytvRfYJFUeKPt4QSPaZWkCoadcTwN24POK/JdPd/Llly3wVCUl
 hr6J3gQjpdD2Uziexd8P8PwpS6ZhpuN2/mW3FE7u5UjwtQVuptcQiUWLl
 q29URPTdMXuMDDRyjXO1zMLOiXbQC36m8LID6N4zHI06QLOILNrjABbrB
 pUcq/lsijAnOQy4AL0NYd80/MvGaFUxiE8ZRTuBZdMKZgZDwrzGzjUCZI g==;
X-CSE-ConnectionGUID: Nr3RkLQOS9etJxxuk4e+tg==
X-CSE-MsgGUID: NFkyYdFpQ7GWsdxzJSC4pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3999081"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3999081"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 14:27:13 -0800
X-CSE-ConnectionGUID: bFx/1A3iRmaPYsj/bj71hA==
X-CSE-MsgGUID: WvTOEvMyRsKq+DLxwMDOFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10875076"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.245.203])
 ([10.245.245.203])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 14:27:10 -0800
Message-ID: <f507c272-be86-4cdf-a481-30e28df9dee8@linux.intel.com>
Date: Thu, 19 Nov 2026 23:27:07 +0100
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

Hi Dave, Simona,

Another week, another pull request!

Kind regards,
~Maarten Lankhorst

drm-misc-next-2026-11-19:
drm-misc-next for v7.5:

UAPI Changes:
- imagination clamping of heap count and stride for legacy usermode.
- bump max mmap offset range from 1 TB to 8 TB.

Cross-subsystem Changes:
- Add Oarora Etimis as VKMS reviewer.
- Cc linux-rockchip@lists.infradead.org for accel/rocket patches.
- Add flags to dma_fence_init and remove dma_fence_init64.

Core Changes:
- Improve scheduler logging and double init.
- Skip too small subtrees when doing exhaustive search of a free block
  to reduce time complexity.

Driver Changes:
- Add support for NPU10 and NPU11 devices to amdxdna, and bump driver
  version to 1.0.
- Add LGD LP129WT112684, LG LP129WT332166 panels.
- Add support for DE33 CSC to sun4i.
- Assorted bugfixes and updates to sun4i, imagination, sti, tidss,
  bridge/fsl-ldb, bridge/dw-hdmi-qp, imx, ingenic, panel/newvision,
  accel/ivpu, accel/rocket, panel/simple, hdlcd.
- Small regression fix in amd/display when converting to atomic_create_state.
- Add (runtime) suspend/resume support to renesas/rz-du.
- Convert more drivers to drm_mode_config_create_initial_state.
- Kerneldoc fixes to vkms.
The following changes since commit c88084027d0e922dd925b96e5a0d184ba04a8f43:

  drm: Discard pm_runtime_put_autosuspend() return values (2026-11-12 10:52:28 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-11-19

for you to fetch changes up to c408466a4dfaee4b12587e926c5b85e68c8b3c40:

  drm/panel: leadtek-ltk500hd1829: Use lowercase hex literals (2026-11-19 13:42:04 -0800)

----------------------------------------------------------------
drm-misc-next for v7.5:

UAPI Changes:
- imagination clamping of heap count and stride for legacy usermode.
- bump max mmap offset range from 1 TB to 8 TB.

Cross-subsystem Changes:
- Add Oarora Etimis as VKMS reviewer.
- Cc linux-rockchip@lists.infradead.org for accel/rocket patches.
- Add flags to dma_fence_init and remove dma_fence_init64.

Core Changes:
- Improve scheduler logging and double init.
- Skip too small subtrees when doing exhaustive search of a free block
  to reduce time complexity.

Driver Changes:
- Add support for NPU10 and NPU11 devices to amdxdna, and bump driver
  version to 1.0.
- Add LGD LP129WT112684, LG LP129WT332166 panels.
- Add support for DE33 CSC to sun4i.
- Assorted bugfixes and updates to sun4i, imagination, sti, tidss,
  bridge/fsl-ldb, bridge/dw-hdmi-qp, imx, ingenic, panel/newvision,
  accel/ivpu, accel/rocket, panel/simple, hdlcd.
- Small regression fix in amd/display when converting to atomic_create_state.
- Add (runtime) suspend/resume support to renesas/rz-du.
- Convert more drivers to drm_mode_config_create_initial_state.
- Kerneldoc fixes to vkms.

----------------------------------------------------------------
Andrzej Kacprowski (1):
      accel/ivpu: Remove sched_mode module parameter

Archit More (4):
      drm/panel: newvision-nv3051d: Propagate init sequence errors to prepare()
      drm/panel: newvision-nv3051d: Use lowercase hex literals
      drm/panel: kingdisplay-kd097d04: Use lowercase hex literals
      drm/panel: leadtek-ltk500hd1829: Use lowercase hex literals

Aryan Sinha (1):
      drm/vkms: Fix kernel-doc parameter and member names

Chaoyi Chen (1):
      MAINTAINERS: accel/rocket: Add rockchip mail list for rocket

David Zhang (4):
      accel/amdxdna: Add NPU10 and NPU11 devices
      accel/amdxdna: Bump driver version to 1.0
      accel/amdxdna: Add AIE4 debug buffer support
      accel/amdxdna: Add AIE4 CERT firmware version query

Detlev Casanova (1):
      drm/bridge: dw-hdmi-qp: Return -EOPNOTSUPP in HDMI audio functions

Florian Fainelli (1):
      drm/ingenic: Allocate and register the internal bridge separately

Haipeng Lin (1):
      drm/panel-edp: Add LG LP129WT332166 panel

Jernej Skrabec (3):
      drm/sun4i: Add support for DE33 CSC
      drm/sun4i: vi_layer: Limit formats for DE33
      drm/sun4i: dw-hdmi: Deinit PHY in bind error path

Johan Hovold (1):
      drm/panel-simple: take i2c adapter module reference

John Madieu (1):
      drm: renesas: rzg2l_mipi_dsi: Remove redundant driver data assignment

Laurentiu Palcu (1):
      drm/bridge: fsl-ldb: Remove panel naming and use scoped device_node cleanup

Linus Walleij (1):
      dt-bindings: display: ste,mcde: Deprecate EPOD supply

Lizhi Hou (3):
      accel/amdxdna: Destroy the context when hwctx restart fails
      accel/amdxdna: Detect a driver command without firmware response
      accel/amdxdna: Abort jobs when the firmware context is gone

Luigi Santivetti (5):
      drm/imagination: switch to inline init of rogue_fwif_rta_ctl
      drm/imagination: drop unused arg in free_list_create_fw_structure()
      drm/imagination: improve DRM_PVR_DEV_QUERY_HEAP_INFO_GET documentation
      drm/imagination: clamp stride of heaps and static areas for legacy UM
      drm/imagination: clamp count of heaps and static areas for legacy UM

Matthew Auld (1):
      drm: increase 64-bit mmap_range size to 8TB

Max Zhen (1):
      accel/amdxdna: Fix SMU command execution on platforms without interrupt trigger

Maxime Ripard (13):
      drm/amd/display: Fix planes atomic_create_state implementation
      drm/sti: Switch to drm_mode_config_create_initial_state
      drm/tidss: crtc: Add atomic_print_state implementation
      drm/tidss: dispc: Improve mode checking logs
      drm/hdlcd: Fix drm_atomic_helper_shutdown() on the probe error path
      drm/hyperv: Switch to drm_mode_config_create_initial_state
      drm/rcar-du: Switch to drm_mode_config_create_initial_state
      drm/st7586: Switch to drm_mode_config_create_initial_state
      drm/st7735r: Switch to drm_mode_config_create_initial_state
      drm/st7920: Switch to drm_mode_config_create_initial_state
      drm/stm: Switch to drm_mode_config_create_initial_state
      drm/tegra: Switch to drm_mode_config_create_initial_state
      drm/ili9225: Switch to drm_mode_config_create_initial_state

Michał Grzelak (1):
      drm/ttm: remove unused num_pages

Oarora Etimis (1):
      MAINTAINERS: Add myself as a VKMS reviewer

Pan Chuang (1):
      accel/rocket: Remove redundant dev_err()

Philipp Stanner (3):
      dma-buf: dma-fence: Add flags parameter to dma_fence_init()
      dma-buf: Port users of dma_fence_init64()
      dma-buf: dma-fence: Remove dma_fence_init64()

Sanjay Yadav (1):
      gpu/buddy: Prune exhausted subtrees in range-biased allocation

Tawheed Makhdoomi (1):
      drm/panel-edp: Add LGD LP129WT112684 panel

Tomi Valkeinen (10):
      drm/tidss: Add helper to identify the AM65x OLDI video port
      drm/tidss: Stop using vp_bus_type for directly connected panels
      drm/tidss: Drop the tied off video port check from mode validation
      drm/tidss: Remove the unused vp_bus_type feat
      drm/tidss: Use the AM625 features for AM62A7
      drm/tidss: oldi: Drop unnecessary forward declaration
      drm/tidss: oldi: Fix wrong return value from tidss_oldi_mode_valid()
      drm/tidss: oldi: Fix serial clock reference leak
      drm/tidss: oldi: Fix cleanup on a failed init
      drm/tidss: oldi: Move the setup of one OLDI TX to its own function

Tommaso Merciai (1):
      drm: renesas: rz-du: Add suspend/resume support

Tvrtko Ursulin (3):
      drm/sched: Reject double scheduler initialization
      drm/sched: Remove log message of questionable use
      drm/sched: Remove useless log message on memory exhaustion

laixiangwu (1):
      drm/imx/dcss: Fix clock leak on blkctl init failure

 .../devicetree/bindings/display/ste,mcde.yaml      |  11 +-
 MAINTAINERS                                        |   2 +
 drivers/accel/amdxdna/aie.h                        |   1 +
 drivers/accel/amdxdna/aie2_ctx.c                   |  38 +-
 drivers/accel/amdxdna/aie2_pci.c                   |   1 +
 drivers/accel/amdxdna/aie2_pci.h                   |   1 +
 drivers/accel/amdxdna/aie4_ctx.c                   | 284 +++++++++++++-
 drivers/accel/amdxdna/aie4_message.c               |  20 +
 drivers/accel/amdxdna/aie4_msg_priv.h              |  35 ++
 drivers/accel/amdxdna/aie4_pci.c                   |   7 +
 drivers/accel/amdxdna/aie4_pci.h                   |  10 +
 drivers/accel/amdxdna/aie_smu.c                    |  20 +-
 drivers/accel/amdxdna/amdxdna_ctx.c                |   6 +-
 drivers/accel/amdxdna/amdxdna_ctx.h                |   5 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c            |  27 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h            |   6 +
 drivers/accel/amdxdna/npu1_regs.c                  |   1 +
 drivers/accel/amdxdna/npu3_regs.c                  |  78 ++++
 drivers/accel/ethosu/ethosu_job.c                  |   2 +-
 drivers/accel/ivpu/ivpu_drv.c                      |   4 -
 drivers/accel/ivpu/ivpu_drv.h                      |   4 +-
 drivers/accel/ivpu/ivpu_fw.c                       |  84 ++--
 drivers/accel/ivpu/ivpu_job.c                      |   2 +-
 drivers/accel/rocket/rocket_job.c                  |   6 +-
 drivers/dma-buf/dma-fence-array.c                  |   2 +-
 drivers/dma-buf/dma-fence-chain.c                  |   4 +-
 drivers/dma-buf/dma-fence.c                        |  57 ++-
 drivers/dma-buf/st-dma-fence-chain.c               |   2 +-
 drivers/dma-buf/st-dma-fence-unwrap.c              |   2 +-
 drivers/dma-buf/st-dma-fence.c                     |   2 +-
 drivers/dma-buf/st-dma-resv.c                      |   2 +-
 drivers/dma-buf/sw_sync.c                          |   2 +-
 drivers/gpu/buddy.c                                |  56 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c   |   5 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   3 -
 drivers/gpu/drm/arm/hdlcd_drv.c                    |   5 +-
 drivers/gpu/drm/bridge/fsl-ldb.c                   |  31 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |   8 +-
 drivers/gpu/drm/drm_crtc.c                         |   2 +-
 drivers/gpu/drm/drm_writeback.c                    |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |   4 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c       |   2 +-
 drivers/gpu/drm/i915/i915_request.c                |   2 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c          |   2 +-
 drivers/gpu/drm/i915/i915_vma_resource.c           |   2 +-
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c     |   2 +-
 drivers/gpu/drm/imagination/pvr_ccb.c              |   2 +-
 drivers/gpu/drm/imagination/pvr_drv.h              |  33 ++
 drivers/gpu/drm/imagination/pvr_free_list.c        |   3 +-
 drivers/gpu/drm/imagination/pvr_hwrt.c             |  12 +-
 drivers/gpu/drm/imagination/pvr_queue.c            |   2 +-
 drivers/gpu/drm/imagination/pvr_vm.c               |  32 +-
 drivers/gpu/drm/imx/dcss/dcss-dev.c                |  22 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |  31 +-
 drivers/gpu/drm/lima/lima_sched.c                  |   2 +-
 drivers/gpu/drm/msm/msm_fence.c                    |   2 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |   4 +-
 drivers/gpu/drm/panel/panel-edp.c                  |   2 +
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c | 242 ++++++------
 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c | 426 ++++++++++-----------
 drivers/gpu/drm/panel/panel-newvision-nv3051d.c    | 383 +++++++++---------
 drivers/gpu/drm/panel/panel-simple.c               |   6 +-
 drivers/gpu/drm/panfrost/panfrost_job.c            |   2 +-
 drivers/gpu/drm/panthor/panthor_sched.c            |   2 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |   2 +-
 drivers/gpu/drm/radeon/radeon_fence.c              |   2 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c      |   4 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c       |  22 ++
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c     |   1 -
 drivers/gpu/drm/scheduler/sched_fence.c            |   4 +-
 drivers/gpu/drm/scheduler/sched_main.c             |  22 +-
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c   |   2 +-
 drivers/gpu/drm/sitronix/st7586.c                  |   4 +-
 drivers/gpu/drm/sitronix/st7735r.c                 |   4 +-
 drivers/gpu/drm/sitronix/st7920.c                  |   4 +-
 drivers/gpu/drm/sti/sti_drv.c                      |   6 +-
 drivers/gpu/drm/stm/drv.c                          |   6 +-
 drivers/gpu/drm/sun4i/sun8i_csc.c                  |  71 ++++
 drivers/gpu/drm/sun4i/sun8i_csc.h                  |   5 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |   1 +
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |  72 +++-
 drivers/gpu/drm/tegra/drm.c                        |   4 +-
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  10 +
 drivers/gpu/drm/tidss/tidss_dispc.c                | 123 ++----
 drivers/gpu/drm/tidss/tidss_dispc.h                |  18 +-
 drivers/gpu/drm/tidss/tidss_drv.c                  |   2 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |  13 +-
 drivers/gpu/drm/tidss/tidss_oldi.c                 | 276 ++++++-------
 drivers/gpu/drm/tidss/tidss_oldi.h                 |   2 -
 drivers/gpu/drm/tiny/ili9225.c                     |   4 +-
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c            |   2 +-
 drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c   |   2 +-
 drivers/gpu/drm/ttm/ttm_device.c                   |   2 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |   4 +-
 drivers/gpu/drm/v3d/v3d_fence.c                    |   2 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |   2 +-
 drivers/gpu/drm/vgem/vgem_fence.c                  |   2 +-
 drivers/gpu/drm/virtio/virtgpu_fence.c             |   2 +-
 drivers/gpu/drm/vkms/vkms_config.h                 |   6 +-
 drivers/gpu/drm/vkms/vkms_connector.h              |   2 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |  11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |   2 +-
 drivers/gpu/drm/xe/xe_hw_fence.c                   |   2 +-
 drivers/gpu/drm/xe/xe_oa.c                         |   2 +-
 drivers/gpu/drm/xe/xe_preempt_fence.c              |   2 +-
 drivers/gpu/drm/xe/xe_tlb_inval.c                  |   2 +-
 drivers/gpu/host1x/fence.c                         |   2 +-
 drivers/iio/industrialio-buffer.c                  |   2 +-
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 include/drm/drm_vma_manager.h                      |  13 +-
 include/drm/ttm/ttm_pool.h                         |   2 +-
 include/linux/dma-fence.h                          |  14 +-
 include/linux/gpu_buddy.h                          |   7 +
 include/uapi/drm/amdxdna_accel.h                   |  51 +++
 include/uapi/drm/pvr_drm.h                         |  84 +++-
 rust/kernel/dma_buf/dma_fence.rs                   |   2 +-
 121 files changed, 1889 insertions(+), 1101 deletions(-)
