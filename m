Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F834CCF2C2
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A77C10E2BF;
	Fri, 16 Oct 2026 16:27:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F8788DA9;
 Fri, 16 Oct 2026 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792168016; x=1823704016;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=sY+urODliV4UowPEdnCcx3i6TFEBtGTMDCApM7zhF7o=;
 b=Gp6v9xJyVaVD1bijPY9nJc9tSD7c2tgoVclgijxd/J4KSxuhKKKsyIti
 QsgYENKYmQhz9kU1Xk9fU98ff7nDfqhid4ROj4lEq2bUS3m2shS7iXqUd
 F0s2dp2hW5l2tXAeooKZW7rH74Jri+/9BbEK3p86v/ZENfhl+RXjZeGZZ
 wAViR049mHirl37pt526/bPMYQtYrk37ryHUvHWDrd5WBL+bAgbVIWRgG
 2RCBhUOfbaQwX4IL6NkHqZlM779xGDHCBNToLZPAiJQi0EXr25CfYK7H8
 wfHe5T4E7+9uIjJEXM8tQjBiLXZ4KLjABsw3u6WdQRRhm0BTJCTNMjROg A==;
X-CSE-ConnectionGUID: viuZKqUCSh248Amv4REmbw==
X-CSE-MsgGUID: KSOAJtsLTvm2qwnwbJSc9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="835107"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="835107"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 09:26:56 -0700
X-CSE-ConnectionGUID: xriebtNXTKyqoq4pCEyu9w==
X-CSE-MsgGUID: yAQOq529RduhqgHxwIRJfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="3826469"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.82])
 ([10.245.245.82])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 09:26:52 -0700
Message-ID: <75e7de61-048c-4fdd-9ad2-6b47b29a4863@linux.intel.com>
Date: Fri, 16 Oct 2026 18:27:20 +0200
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

First pull request for v7.5!

Kind regards,
~Maarten Lankhorst

drm-misc-next-2026-10-16:
drm-misc-next for v7.5:

UAPI Changes:
- Add Apple Interchange fourcc.
- Expose amdxdna busy time via DRM fdinfo.

Cross-subsystem Changes:
- Improve DT bindings for display/ste,mcde
- Add kunit test for dma_fence_dedup_array() to dma-buf/test.

Core Changes:
- Documentation updates to drm/scheduler, gpu/buddy.
- Fail kmapping a bo without pages.

Driver Changes:
- Bugfixes and improvements to panel/Raystar RFF500F-AWH-DNN,
  accel/ivpu, vc4, accel/amdxdna, panthor, nouveau, panfrost,
  panthor, accel/qaic, accel/rocket, bridge/lontium-lt8713sx,
  appletbdrm.
- Add support for BOE Novatek NT51021, Retroid Pocket 6,
  Raydium RM69220 DDIC panels, Sharp LQ138P1JX61 eDP,
  BOE NV140FHD-N43, AUO B140HAN04.0, AUO 0x0db3,
  panels.
- Add support for Mali-G68 to panfrost.
- Add Chrontel CH7218A to bridge/simple.
- Support ARGB8888 for virtio primary planes.
- Improve panfrost gpu reset handling and initialization.
- Add HDMI 2.0 support to rockchip/dw-hdmi-qp and improve HPD handling.
- Advertise HDMI 1.2 capabilities in sun4i, bridge/adv7511, it66121 & inno-hdmi.
- Advertise HDMI 1.3 capabilities in bridge/ite-6263.
- Advertise HDMI 1.4 capabilities in bridge/lt9611 & rockchip/rk3066_hdmi
- Switch many drivers to drm_atomic_helper_create_state in preparation
  for readout.
The following changes since commit 589e63c53a9a57cd3c14cff2ea42ad606c1e2a24:

  drm/tegra: Wait for syncpoint syncobj_in fences in hardware (2026-10-02 01:02:54 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-10-16

for you to fetch changes up to db1de27aca30ebaad04aea74ac21e4c4fb531a37:

  drm/adp: Switch to drm_atomic_helper_connector_create_state (2026-10-16 17:08:45 +0200)

----------------------------------------------------------------
drm-misc-next for v7.5:

UAPI Changes:
- Add Apple Interchange fourcc.
- Expose amdxdna busy time via DRM fdinfo.

Cross-subsystem Changes:
- Improve DT bindings for display/ste,mcde
- Add kunit test for dma_fence_dedup_array() to dma-buf/test.

Core Changes:
- Documentation updates to drm/scheduler, gpu/buddy.
- Fail kmapping a bo without pages.

Driver Changes:
- Bugfixes and improvements to panel/Raystar RFF500F-AWH-DNN,
  accel/ivpu, vc4, accel/amdxdna, panthor, nouveau, panfrost,
  panthor, accel/qaic, accel/rocket, bridge/lontium-lt8713sx,
  appletbdrm.
- Add support for BOE Novatek NT51021, Retroid Pocket 6,
  Raydium RM69220 DDIC panels, Sharp LQ138P1JX61 eDP,
  BOE NV140FHD-N43, AUO B140HAN04.0, AUO 0x0db3,
  panels.
- Add support for Mali-G68 to panfrost.
- Add Chrontel CH7218A to bridge/simple.
- Support ARGB8888 for virtio primary planes.
- Improve panfrost gpu reset handling and initialization.
- Add HDMI 2.0 support to rockchip/dw-hdmi-qp and improve HPD handling.
- Advertise HDMI 1.2 capabilities in sun4i, bridge/adv7511, it66121 & inno-hdmi.
- Advertise HDMI 1.3 capabilities in bridge/ite-6263.
- Advertise HDMI 1.4 capabilities in bridge/lt9611 & rockchip/rk3066_hdmi
- Switch many drivers to drm_atomic_helper_create_state in preparation
  for readout.

----------------------------------------------------------------
Aaron Kling (4):
      dt-bindings: display: visionox,vtdr6130: Add Retroid Pocket 6 panel
      drm/panel: visionox-vtdr6130: Add panel orientation support
      drm/panel: visionox-vtdr6130: Modularize panel config
      drm/panel: visionox-vtdr6130: Add Retroid Pocket 6 panel

Adam Azuddin (1):
      drm/appletbdrm: Fix incorrect error message on encoder attach failure

Adrián Larumbe (15):
      drm/panfrost: Move shrinker initialization and unplug one level down
      drm/panfrost: Move lock and modparam initialisations into their subsystems
      drm/panfrost: Move debugfs initialisation to relevant subsystems
      drm/panfrost: Skip NULL checks for clock enable/disabling
      drm/panfrost: Consolidate device clock management and reset
      drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove
      drm/panfrost: Explicitly enable MMU interrupts at device init
      drm/panfrost: Move all DRM device initialisation into device_init()
      drm/panfrost: Warn of RPM get failure at device remove time
      drm/panfrost: Add debugfs knob for manually triggering a GPU reset
      drm/panfrost: Move perfcnt GPU disable sequence into a helper
      drm/panfrost: Skip cache flush/invalidate when enabling perfcnt
      drm/panfrost: Avoid cache flush after perfcnt sample in fully coherent systems
      drm/panfrost: Introduce a reset lock
      drm/panfrost: Fix races between perfcnt and reset sequence

Akash Goel (2):
      drm/panthor: Fix handling of NO_MMAP BOs
      drm/panthor: Remove redundant drm_gem_create_mmap_offset() call from BO_MMAP_OFFSET ioctl

Alexander Koskovich (2):
      dt-bindings: display: panel: Document Raydium RM69220 DDIC
      drm/panel: Add driver for Raydium RM69220 DDIC

Andrzej Kacprowski (4):
      accel/ivpu: Improve HW IP gen and buttress version checks
      accel/ivpu: Drop MTL interrupt clear-with-zero workaround
      accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling
      accel/ivpu: Load firmware on cold boot

Arnd Bergmann (1):
      drm/panel: fix novatek-nt36536 dependencies

Baineng Shou (1):
      dma-buf/test: add KUnit case for dma_fence_dedup_array() empty input

Christian König (1):
      drm/sched: document the RCU dependency

Cristian Ciocaltea (26):
      drm/bridge: dw-hdmi-qp: Demote i2c bus error messages to debug level
      drm/bridge: dw-hdmi-qp: Provide .{enable,disable}_hpd() PHY ops
      drm/bridge: dw-hdmi-qp: Remove unused workqueue include and define
      drm/bridge: dw-hdmi-qp: Add HDMI 2.0 scrambling support
      drm/bridge: dw-hdmi-qp: Provide dw_hdmi_qp_hpd_notify() helper
      drm/rockchip: dw_hdmi_qp: Fix invalid drvdata access in PM ops
      drm/rockchip: dw_hdmi_qp: Cancel pending HPD work on suspend
      drm/rockchip: dw_hdmi_qp: Add missing newlines in dev_err_probe() messages
      drm/rockchip: dw_hdmi_qp: Use local dev variable consistently in bind()
      drm/rockchip: dw_hdmi_qp: Avoid spurious HPD IRQ thread wakeups
      drm/rockchip: dw_hdmi_qp: Mask RK3576 HPD IRQ in io_init
      drm/rockchip: dw_hdmi_qp: Implement .{enable,disable}_hpd() PHY ops
      drm/rockchip: dw_hdmi_qp: Factor out HPD interrupt (un)mask helpers
      drm/rockchip: dw_hdmi_qp: Control the HPD IRQ line via the bridge HPD ops
      drm/rockchip: dw_hdmi_qp: Use dw_hdmi_qp_hpd_notify() for HPD reports
      drm/bridge: dw-hdmi-qp: Drop unused .setup_hpd() phy op
      drm/rockchip: rk3066_hdmi: Convert to devm_drm_bridge_alloc() API
      drm/bridge: lontium-lt8713sx: Drop redundant bridge funcs assignment
      drm/bridge: adv7511: Advertise HDMI 1.2 capabilities
      drm/bridge: inno-hdmi: Advertise HDMI 1.2 capabilities
      drm/bridge: ite-it6263: Drop redundant .mode_valid hook
      drm/bridge: ite-it6263: Advertise HDMI 1.3 capabilities
      drm/bridge: ite-it66121: Advertise HDMI 1.2 capabilities
      drm/bridge: lontium-lt9611: Advertise HDMI 1.4 capabilities
      drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4 capabilities
      drm/sun4i: hdmi: Convert to drmm_connector_hdmi_init()

Daniel Drake (1):
      drm/vc4: Set DRM DMA device directly from HVS and V3D

David Zhang (1):
      accel/amdxdna: Reject device heap BO when dev_mem_size is not set

Dawid Osuchowski (1):
      accel/ivpu: Convert hw_ip_gen/btrs_gen to enum types

Dorinda Bassey (1):
      drm/virtio: add ARGB8888 support for primary planes

Eva Crystal (1):
      accel/amdxdna: document trusted mailbox ring geometry and drop the power-of-two check

Fabio Estevam (1):
      drm/panel: simple: Add Raystar RFF500F-AWH-DNN enable delay

Gopikrishna Garmidi (1):
      drm/panel-edp: Add Sharp LQ138P1JX61 (Surface Laptop 8th Ed.)

Hsieh Hung-En (2):
      drm/panel: ronbo-rb070d30: Use mipi_dsi_*_multi() functions
      drm/panel: ronbo-rb070d30: Ignore DCS errors in disable()

James Calligeros (1):
      drm/fourcc: Add Apple Interchange layout format modifier

Jasper Korten (1):
      drm/panel-edp: Add AUO B140HAN04.0 panel entry

Jesse Zhang (1):
      drm/ttm: return an error when kmapping a BO without pages

Juerg Haefliger (1):
      drm/panel-edp: Add AUO 0x0db3 panel

Jun Yan (1):
      drm/panel-edp: Add BOE NV140FHD-N43 panel

Karl Mehltretter (1):
      gpu: buddy: Drop the stale @p line from the gpu_buddy_print() kernel-doc

Karol Wachowski (8):
      accel/ivpu: Split HW IP generation dispatch into helpers
      accel/ivpu: Limit DMA address width to 42 bits on 40XX and later
      accel/ivpu: Cache FW API version and simplify API check macros
      accel/ivpu: Add test mode to enable the FREQ_CHANGE interrupt
      accel/ivpu: Merge NPU IP register headers
      accel/ivpu: Merge identical 37xx and 40xx IP functions
      accel/ivpu: Merge buttress register headers
      accel/ivpu: Extend tile fuse config to 7 bits

Linus Walleij (1):
      dt-bindings: display: ste,mcde: Allow power domains

Markuss Broks (1):
      drm/panfrost: add Mali-G68 support

Max Zhen (2):
      accel/amdxdna: eliminate GFP_KERNEL allocation from mailbox send path
      accel/amdxdna: Expose NPU device busy time via DRM fdinfo

Maxime Ripard (10):
      drm/arm: komeda: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: lontium-lt8912b: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: megachips: Switch to drm_atomic_helper_connector_create_state
      drm/hyperv: Switch to drm_atomic_helper_connector_create_state
      drm/imx: ipuv3: Switch to drm_atomic_helper_connector_create_state
      drm/solomon: ssd130x: Switch to drm_atomic_helper_connector_create_state
      drm/sysfb: Switch to drm_atomic_helper_connector_create_state
      drm/vc4: Switch to drm_atomic_helper_connector_create_state
      drm/malidp: Convert to atomic_create_state
      drm/adp: Switch to drm_atomic_helper_connector_create_state

Myeonghun Pak (1):
      accel/qaic: Cancel Sahara read data work on removal

Nickolay Goppen (3):
      dt-bindings: display: panel: Add Novatek NT51021
      drivers: gpu: drm: panel: Add BOE NT51021 driver
      MAINTAINERS: Add myself and Ryan Brue as maintainers of NT51021 panel driver

Osama Abdelkader (1):
      drm/panthor: Fix TOCTOU race between GROUP_REGISTERED check and erase

Shuvam Pandey (1):
      accel/qaic: Protect perf stats BO state with bo->lock

Sidong Yang (3):
      accel/rocket: Don't tear down the scheduler when drm_sched_init() fails
      accel/rocket: Use an unsigned index to copy the job's tasks
      accel/rocket: Validate task regcmd address and count on submission

Tvrtko Ursulin (1):
      drm/sched: Document entity->stopped is protected by entity->lock

Vasilij Markin (1):
      drm/appletbdrm: Add suspend and resume support

Xilin Wu (2):
      dt-bindings: display: bridge: simple: document Chrontel CH7218A
      drm/bridge: simple: add Chrontel CH7218A

Zack McKevitt (1):
      accel/qaic: Add support for AI200 virtual functions

Zhenhao Wan (1):
      drm/nouveau: prevent NULL deref of gr in GETPARAM_GRAPH_UNITS

 Documentation/accel/amdxdna/amdnpu.rst             |   1 +
 .../bindings/display/bridge/simple-bridge.yaml     |   1 +
 .../bindings/display/panel/novatek,nt51021.yaml    |  87 ++
 .../bindings/display/panel/raydium,rm69220.yaml    |  74 ++
 .../bindings/display/panel/visionox,vtdr6130.yaml  |   8 +-
 .../devicetree/bindings/display/ste,mcde.yaml      |   5 +
 MAINTAINERS                                        |  13 +
 drivers/accel/amdxdna/aie.c                        |  39 +
 drivers/accel/amdxdna/aie.h                        |   4 +
 drivers/accel/amdxdna/aie2_ctx.c                   |   6 +
 drivers/accel/amdxdna/aie2_error.c                 |   9 +-
 drivers/accel/amdxdna/aie2_message.c               |  18 +-
 drivers/accel/amdxdna/aie2_pci.c                   |  15 +-
 drivers/accel/amdxdna/aie2_pci.h                   |   2 +-
 drivers/accel/amdxdna/aie4_pci.c                   |   8 +-
 drivers/accel/amdxdna/amdxdna_error.h              |  10 +
 drivers/accel/amdxdna/amdxdna_gem.c                |   5 +
 drivers/accel/amdxdna/amdxdna_mailbox.c            | 219 ++++--
 drivers/accel/amdxdna/amdxdna_mailbox.h            |   9 +-
 drivers/accel/amdxdna/amdxdna_mailbox_helper.c     |   2 +-
 drivers/accel/amdxdna/amdxdna_mailbox_helper.h     |   1 -
 drivers/accel/amdxdna/amdxdna_pci_drv.c            |   6 +
 drivers/accel/amdxdna/amdxdna_pci_drv.h            |   9 +
 drivers/accel/ivpu/ivpu_drv.c                      |  85 +-
 drivers/accel/ivpu/ivpu_drv.h                      |  67 +-
 drivers/accel/ivpu/ivpu_fw.c                       |  41 +-
 drivers/accel/ivpu/ivpu_fw.h                       |   3 +-
 drivers/accel/ivpu/ivpu_hw.c                       |  11 +-
 drivers/accel/ivpu/ivpu_hw.h                       |   8 +-
 drivers/accel/ivpu/ivpu_hw_40xx_reg.h              | 195 -----
 drivers/accel/ivpu/ivpu_hw_btrs.c                  |  56 +-
 drivers/accel/ivpu/ivpu_hw_btrs.h                  |   3 -
 drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h          |  83 --
 .../{ivpu_hw_btrs_lnl_reg.h => ivpu_hw_btrs_reg.h} |  84 +-
 drivers/accel/ivpu/ivpu_hw_ip.c                    | 488 +++---------
 drivers/accel/ivpu/ivpu_hw_ip.h                    |   3 +-
 .../ivpu/{ivpu_hw_37xx_reg.h => ivpu_hw_ip_reg.h}  |  71 +-
 drivers/accel/ivpu/ivpu_pm.c                       |   1 -
 drivers/accel/qaic/mhi_controller.c                | 192 ++++-
 drivers/accel/qaic/qaic.h                          |   1 +
 drivers/accel/qaic/qaic_data.c                     |  14 +-
 drivers/accel/qaic/qaic_drv.c                      |  47 ++
 drivers/accel/qaic/sahara.c                        |   1 +
 drivers/accel/rocket/rocket_job.c                  |  28 +-
 drivers/dma-buf/st-dma-fence-unwrap.c              |  10 +
 drivers/gpu/buddy.c                                |   1 -
 .../drm/arm/display/komeda/komeda_wb_connector.c   |   2 +-
 drivers/gpu/drm/arm/malidp_mw.c                    |  18 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  22 +-
 drivers/gpu/drm/bridge/inno-hdmi.c                 |   1 +
 drivers/gpu/drm/bridge/ite-it6263.c                |  33 +-
 drivers/gpu/drm/bridge/ite-it66121.c               |  13 +-
 drivers/gpu/drm/bridge/lontium-lt8713sx.c          |   1 -
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |   2 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            |  16 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |   2 +-
 drivers/gpu/drm/bridge/simple-bridge.c             |   5 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       | 159 +++-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |   2 +-
 drivers/gpu/drm/imx/ipuv3/imx-tve.c                |   2 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |   2 +-
 drivers/gpu/drm/panel/Kconfig                      |  26 +
 drivers/gpu/drm/panel/Makefile                     |   2 +
 drivers/gpu/drm/panel/panel-edp.c                  |   4 +
 drivers/gpu/drm/panel/panel-novatek-nt51021.c      | 875 +++++++++++++++++++++
 drivers/gpu/drm/panel/panel-raydium-rm69220.c      | 417 ++++++++++
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c       |  14 +-
 drivers/gpu/drm/panel/panel-simple.c               |   3 +
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c    | 221 +++++-
 drivers/gpu/drm/panfrost/panfrost_device.c         | 291 +++++--
 drivers/gpu/drm/panfrost/panfrost_device.h         |   5 +
 drivers/gpu/drm/panfrost/panfrost_drv.c            | 198 +----
 drivers/gpu/drm/panfrost/panfrost_drv.h            |   9 -
 drivers/gpu/drm/panfrost/panfrost_features.h       |   2 +
 drivers/gpu/drm/panfrost/panfrost_gem.c            |  64 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h            |  10 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c   |   9 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |   5 +
 drivers/gpu/drm/panfrost/panfrost_issues.h         |   8 +
 drivers/gpu/drm/panfrost/panfrost_job.c            | 103 ++-
 drivers/gpu/drm/panfrost/panfrost_job.h            |   4 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |  14 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c        | 321 +++++---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h        |   1 +
 drivers/gpu/drm/panthor/panthor_drv.c              |   6 +-
 drivers/gpu/drm/panthor/panthor_gem.c              |   3 +
 drivers/gpu/drm/panthor/panthor_sched.c            |  14 +-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     | 205 +++--
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |  10 +-
 drivers/gpu/drm/scheduler/sched_main.c             |   5 +
 drivers/gpu/drm/solomon/ssd130x.c                  |   2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  25 +-
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h           |   2 +-
 drivers/gpu/drm/tiny/appletbdrm.c                  |  50 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |  11 +-
 drivers/gpu/drm/vc4/tests/vc4_mock_output.c        |   2 +-
 drivers/gpu/drm/vc4/vc4_bo.c                       |   3 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |  28 -
 drivers/gpu/drm/vc4/vc4_hvs.c                      |  10 +
 drivers/gpu/drm/vc4/vc4_txp.c                      |   2 +-
 drivers/gpu/drm/vc4/vc4_v3d.c                      |   7 +
 drivers/gpu/drm/virtio/virtgpu_plane.c             |   1 +
 include/drm/bridge/dw_hdmi_qp.h                    |   4 +-
 include/drm/gpu_scheduler.h                        |   2 +-
 include/uapi/drm/drm_fourcc.h                      |  24 +
 include/uapi/drm/panfrost_drm.h                    |  29 +-
 106 files changed, 3730 insertions(+), 1645 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm69220.yaml
 delete mode 100644 drivers/accel/ivpu/ivpu_hw_40xx_reg.h
 delete mode 100644 drivers/accel/ivpu/ivpu_hw_btrs_mtl_reg.h
 rename drivers/accel/ivpu/{ivpu_hw_btrs_lnl_reg.h => ivpu_hw_btrs_reg.h} (58%)
 rename drivers/accel/ivpu/{ivpu_hw_37xx_reg.h => ivpu_hw_ip_reg.h} (73%)
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt51021.c
 create mode 100644 drivers/gpu/drm/panel/panel-raydium-rm69220.c
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_drv.h
