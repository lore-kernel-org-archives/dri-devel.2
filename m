Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F37606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZTeE2JWl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F288112385;
	Fri, 13 Nov 2026 12:15:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6B810E7D6;
 Fri, 13 Nov 2026 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794572112; x=1826108112;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=5V4MzKvZmCK2Ady7G2kz0eRBWhwzWTBLJtZOOB0jDfU=;
 b=ZTeE2JWlc5q5q1l+t6iCk6DcwuuamCF+j9lzoDklnrBJfzEBCQgeV+px
 mTajkGQ3kBE8XZWXxBfqsMpQkY84O5DoXpLm9WCR8Nm4sCMajwULCYYIO
 XaictzAZ9QHftJw7nVNBjOieaJMWmA6ZVYSn2A+8QUSw6Pi6dyIWfBo7q
 AXiIHv3W4NW42CKJeUxE3hbx7vLnggcdS/4RbLC441PahORzGkZaSwNVh
 GP7iHjTQWCch6qvzxSmubyQcACb/xp/wEMXWfTXTyacyDTlbE3qtP25tD
 GczhC8rMSN2BPxrruu1SnrJftYcjs7SEu853uJm/qzfYaipf31QtRnsId Q==;
X-CSE-ConnectionGUID: wsl/aPTtRCWNZZC8JwDFhA==
X-CSE-MsgGUID: cqLIKfduTjOyuauuSivnGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3241131"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3241131"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 04:15:11 -0800
X-CSE-ConnectionGUID: jgafNGxTQiSpV0A25byl6w==
X-CSE-MsgGUID: TNzJEQKVTqaW+q4MOkEUJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9233900"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.166])
 ([10.245.244.166])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 04:15:07 -0800
Message-ID: <48d133a9-097f-4be3-b50e-66a703e57a2c@linux.intel.com>
Date: Fri, 13 Nov 2026 13:16:09 +0100
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

Next pull request for drm-misc-next, enjoy!

Kind regards,
~Maarten Lankhorst

drm-misc-next-2026-11-13:
drm-misc-next for v7.5-rc1:

Cross-subsystem Changes:
- Fix drm-misc MAINTAINERS entry to include include/drm/drm*.h
- Update documentation for dma_buf_set_name().
- Fix DMA-BUF heaps selftest.
- Add reviewers to drm/panthor.

Core Changes:
- Add drm_gpusvm_pages helpers and use them in amdxdna.
- Drop unneeded header from drm_dp_aux_bus.h
- Print (none) instead of (efault) when no firmware mode is configured in drm/client.
- Small fix to drm/buddy and drm/gem.

Driver Changes:
- Convert remaining users of connector ->reset() hook to atomic_create_state().
- Mass conversion of drivers to use drm_mode_config_create_initial_state().
- More preparations for resetting atomic state.
- Assorted bugfixes and improvements to amdxdna, vc4, rockchip,
  bridge/dw_hdmi_qp, imagination, bridge/tc358767, omap, xlnx,
  drm/panel, v3d.
- Add YUV422, YUV420 to bridge/dw_hdmi_qp.
- Add BOE NS140WUM-L61 panels.
- Support higher bandwidth and pixel blending in meson.
- Add Allwinner T527 VIP9000 support to etnaviv.
- Add GlandaGPU driver.
- Add HyperV cursor plane support.
- Add support for i.MX94 to bridge/fsl-ldb.
The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-11-13

for you to fetch changes up to c88084027d0e922dd925b96e5a0d184ba04a8f43:

  drm: Discard pm_runtime_put_autosuspend() return values (2026-11-12 10:52:28 -0800)

----------------------------------------------------------------
drm-misc-next for v7.5-rc1:

Cross-subsystem Changes:
- Fix drm-misc MAINTAINERS entry to include include/drm/drm*.h
- Update documentation for dma_buf_set_name().
- Fix DMA-BUF heaps selftest.
- Add reviewers to drm/panthor.

Core Changes:
- Add drm_gpusvm_pages helpers and use them in amdxdna.
- Drop unneeded header from drm_dp_aux_bus.h
- Print (none) instead of (efault) when no firmware mode is configured in drm/client.
- Small fix to drm/buddy and drm/gem.

Driver Changes:
- Convert remaining users of connector ->reset() hook to atomic_create_state().
- Mass conversion of drivers to use drm_mode_config_create_initial_state().
- More preparations for resetting atomic state.
- Assorted bugfixes and improvements to amdxdna, vc4, rockchip,
  bridge/dw_hdmi_qp, imagination, bridge/tc358767, omap, xlnx,
  drm/panel, v3d.
- Add YUV422, YUV420 to bridge/dw_hdmi_qp.
- Add BOE NS140WUM-L61 panels.
- Support higher bandwidth and pixel blending in meson.
- Add Allwinner T527 VIP9000 support to etnaviv.
- Add GlandaGPU driver.
- Add HyperV cursor plane support.
- Add support for i.MX94 to bridge/fsl-ldb.

----------------------------------------------------------------
Abel Vesa (1):
      drm/panel-edp: add BOE NS140WUM-L61 entry

Alessio Belle (2):
      drm/imagination: Switch to kernel-style MMU defines and access
      drm/imagination: Don't include MMU defines outside of MMU code

Alexander Stein (1):
      drm/bridge: tc358767: register DP aux bus even in DRM_BRIDGE_ATTACH_NO_CONNECTOR case

Andreas Kemnade (1):
      drm/omap: dss: fix handling deferrals

Arunpravin Paneer Selvam (1):
      gpu/buddy: restore two-pass clear/dirty guard for range-biased allocation

Brajesh Gupta (1):
      drm/imagination: Support for querying Firmware information

Brian Norris (1):
      drm: Discard pm_runtime_put_autosuspend() return values

Cristian Ciocaltea (23):
      dt-bindings: display: vop2: Add missing reset properties
      drm/rockchip: vop2: Fix resource leak on vop2_enable() error path
      drm/rockchip: vop2: Disable core clocks before dropping runtime PM reference
      drm/rockchip: vop2: Balance state on atomic_enable() error paths
      drm/rockchip: vop2: Avoid division by zero when computing max_dclk
      drm/rockchip: vop2: Fix VOP2_MAX_DCLK_RATE overflow on 32-bit
      drm/rockchip: vop2: Reset AXI and DCLK to improve robustness
      drm/rockchip: vop2: Consolidate HDMI PHY PLL clock parent switch
      drm/rockchip: vop2: Use TMDS character rate to select DCLK source
      drm/rockchip: vop2: Switch to enum vop_csc_format
      drm/bridge: dw-hdmi-qp: Log resolution and refresh rate in atomic_enable()
      drm/rockchip: dw_hdmi_qp: Do not mask error code in atomic_check()
      drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422 output format
      drm/rockchip: dw_hdmi_qp: Enable YUV420 output format
      drm/vc4: hdmi: Use common TMDS char rate constants
      drm/vc4: hdmi: Switch to drm_hdmi_mode_needs_scrambling()
      drm/vc4: hdmi: Switch to .force_ctx() connector helper
      drm/vc4: hdmi: Propagate -EDEADLK to the top level
      drm/vc4: hdmi: Convert to drmm_connector_hdmi_init()
      drm/vc4: hdmi: Convert to common HDMI 2.0 scrambling infrastructure
      drm/vc4: hdmi: Clamp CEC clock divider to its register field width
      drm/vc4: hdmi: Bump BCM2835 max pixel clock to 165 MHz
      drm/vc4: hdmi: Defer pixel clock validation to HDMI helpers

Dave Stevenson (1):
      drm/vc4: hdmi: Remove unused packet_ram_enabled flag

Dmitry Ilvokhin (1):
      drm/gem: Switch to __nonnull_args() macro

Frank Li (1):
      drm: xlnx: zynqmp_disp: use dmaengine_get_copy_align() accessor

Hamza Mahfooz (1):
      drm/hyperv: add cursor plane support

Hugo Sales (1):
      drm/client: Don't print a NULL firmware config mode

Hung-Chun Tseng (1):
      dma-buf: fix stale return value documentation for dma_buf_set_name()

Joe Perches (1):
      MAINTAINERS: DRM DRIVERS AND MISC GPU PATCHES

Jose Maria Casanova Crespo (1):
      drm/v3d: Count released supergroup IDs as CSD progress on V3D 7.x

Jose Nieto (1):
      drm/meson: plane: add pixel blend mode property

Laurentiu Palcu (2):
      dt-bindings: display: fsl,ldb: Add i.MX94 LDB
      drm/bridge: fsl-ldb: Add support for i.MX94

Leander Kieweg (2):
      dt-bindings: display: Add GlandaGPU binding
      drm/glanda: Add initial DRM driver for GlandaGPU

Linus Walleij (1):
      dt-bindings: display: panel: samsung,s6e63m0: Describe ESD interrupt

Liviu Dudau (1):
      drm/panthor: Add more reviewers

Lizhi Hou (1):
      accel/amdxdna: Use vma->vm_mm consistently in amdxdna_hmm_register()

Luca Ceresoli (3):
      drm/vc4: dpi: stop using deprecated drmm_of_get_bridge()
      drm/vc4: dsi: stop using deprecated drmm_of_get_bridge()
      drm/vc4: dsi: remove unnecessary intermediate pointer computation

Mario Limonciello (1):
      accel/amdxdna: Load the aie4 firmware variant the PSP reports

Martin Blumenstingl (1):
      drm/meson: add support for higher bandwidth HDMI DTDs

Matthew Brost (2):
      drm/gpusvm: Add drm_gpusvm_pages unmapped and retry helpers
      accel/amdxdna: Use drm_gpusvm_pages for user mapping tracking

Maxime Ripard (71):
      drm/amdgpu: vkms: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: analogix-anx6345: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: analogix-anx78xx: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: chrontel-ch7033: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: nxp-ptn3460: Switch to drm_atomic_helper_connector_create_state
      drm/panel: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: synopsys: dw-hdmi: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: tc358767: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: tda998x: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: ti-tfp410: Switch to drm_atomic_helper_connector_create_state
      drm/exynos: Switch to drm_atomic_helper_connector_create_state
      drm/fsl-dcu: Switch to drm_atomic_helper_connector_create_state
      drm/loongson: Switch to drm_atomic_helper_connector_create_state
      drm/mipi-dbi: Switch to drm_atomic_helper_connector_create_state
      drm/renesas: shmobile: Switch to drm_atomic_helper_connector_create_state
      drm/sitronix: st7571: Switch to drm_atomic_helper_connector_create_state
      drm/sti: Switch to drm_atomic_helper_connector_create_state
      drm/sun4i: Switch to drm_atomic_helper_connector_create_state
      drm/tegra: Switch to drm_atomic_helper_connector_create_state
      drm/tests: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: arcpgu: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: sharp: Switch to drm_atomic_helper_connector_create_state
      drm/virtio: Switch to drm_atomic_helper_connector_create_state
      drm/vkms: Switch to drm_atomic_helper_connector_create_state
      drm/xen: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: synopsys: dw-hdmi: Convert to atomic_create_state
      drm/meson: Convert to atomic_create_state
      drm/sun4i: hdmi: Convert to atomic_create_state
      drm/sun4i: tv: Convert to atomic_create_state
      drm/tests: hdmi: Convert to atomic_create_state
      drm/connector: Remove drm_atomic_helper_connector_reset()
      drm/amdgpu: dm: Convert to atomic_create_state
      drm/i915: Convert to atomic_create_state
      drm/nouveau: Convert to atomic_create_state
      drm/tegra: Convert to atomic_create_state
      drm/connector: Remove __drm_atomic_helper_connector_reset()
      drm/connector: Remove reset
      drm/solomon: ssd130x: Drop the init-only assumption in ssd130x_crtc_create_state()
      drm/atomic: Switch to krealloc_array() in drm_atomic_get_private_obj_state()
      drm/atomic: Use __GFP_ZERO instead of explicit memset in drm_atomic_get_private_obj_state()
      drm/atomic: Use __GFP_ZERO instead of explicit memset in drm_atomic_get_connector_state()
      drm/atomic: Create function to insert CRTC state into a commit
      drm/atomic: Create function to insert plane state into a commit
      drm/atomic: Create function to insert colorop state into a commit
      drm/atomic: Create function to insert private obj state into a commit
      drm/atomic: Create function to insert connector state into a commit
      drm/vkms: Switch container_of helpers to container_of_const
      drm/appletbdrm: Switch to drm_mode_config_create_initial_state
      drm/komeda: Switch to drm_mode_config_create_initial_state
      drm/malidp: Switch to drm_mode_config_create_initial_state
      drm/aspeed: Switch to drm_mode_config_create_initial_state
      drm/atmel-hlcdc: Switch to drm_mode_config_create_initial_state
      drm/gud: Switch to drm_mode_config_create_initial_state
      drm/hisilicon/kirin: Switch to drm_mode_config_create_initial_state
      drm/imx/dc: Switch to drm_mode_config_create_initial_state
      drm/imx/dcss: Switch to drm_mode_config_create_initial_state
      drm/mcde: Switch to drm_mode_config_create_initial_state
      drm/meson: Switch to drm_mode_config_create_initial_state
      drm/lcdif: Switch to drm_mode_config_create_initial_state
      drm/mxsfb: Switch to drm_mode_config_create_initial_state
      drm/pl111: Switch to drm_mode_config_create_initial_state
      drm/rockchip: Switch to drm_mode_config_create_initial_state
      drm/ssd130x: Switch to drm_mode_config_create_initial_state
      drm/corebootdrm: Switch to drm_mode_config_create_initial_state
      drm/efidrm: Switch to drm_mode_config_create_initial_state
      drm/ofdrm: Switch to drm_mode_config_create_initial_state
      drm/simpledrm: Switch to drm_mode_config_create_initial_state
      drm/vesadrm: Switch to drm_mode_config_create_initial_state
      drm/tve200: Switch to drm_mode_config_create_initial_state
      drm/vc4: Switch to drm_mode_config_create_initial_state
      drm/vkms: Switch to drm_mode_config_create_initial_state

Maíra Canal (10):
      drm/vc4: Refcount vc4_exec_info
      drm/vc4: Return the seqno of the submitted job
      drm/vc4: Attach the job fences outside of job_lock
      drm/vc4: Use the inline fence lock
      drm/vc4: Signal the render fence outside of job_lock
      drm/vc4: Take job_lock only once to drain job_done_list
      drm/vc4: Protect perfmon state with a dedicated lock
      drm/vc4: Protect the hang state with a dedicated lock
      drm/vc4: Split out bin_alloc_lock
      drm/vc4: Take the IRQ number from vc4_dev in vc4_irq_install()

Phong LE (1):
      drm/etnaviv: add the Allwinner T527 VIP9000 hardware database entry

T.J. Mercier (1):
      kselftests: dmabuf-heaps: Open heap device files O_RDONLY

Thomas Zimmermann (1):
      Merge drm/drm-next into drm-misc-next

Uwe Kleine-König (The Capable Hub) (1):
      drm: Drop #include <linux/mod_devicetable.h> from <drm/display/drm_dp_aux_bus.h>

 Documentation/accel/amdxdna/amdnpu.rst             |    2 +-
 .../bindings/display/bridge/fsl,ldb.yaml           |    2 +
 .../devicetree/bindings/display/kieweg,gpu.yaml    |   56 +
 .../bindings/display/panel/himax,hx8279.yaml       |   13 +
 .../bindings/display/panel/hit,tx10d07vm0baa.yaml  |   58 +
 .../bindings/display/panel/ilitek,ili9881c.yaml    |    2 +
 .../bindings/display/panel/novatek,nt36672a.yaml   |    9 +-
 .../bindings/display/panel/novatek,nt37705.yaml    |   71 ++
 .../bindings/display/panel/panel-simple-dsi.yaml   |    2 +
 .../bindings/display/panel/panel-simple.yaml       |    1 +
 .../display/panel/rocktech,jh057n00900.yaml        |    2 +
 .../bindings/display/panel/samsung,ams644vk04.yaml |   76 ++
 .../bindings/display/panel/samsung,s6e63m0.yaml    |    8 +
 .../display/panel/truly,wqhd60-nt36850.yaml        |   98 ++
 .../display/rockchip/rockchip,analogix-dp.yaml     |   28 +-
 .../bindings/display/rockchip/rockchip-vop2.yaml   |   46 +-
 .../bindings/display/ti/ti,am625-oldi.yaml         |    3 +
 .../bindings/display/ti/ti,am62l-dss.yaml          |  136 +++
 .../bindings/display/ti/ti,am65x-dss.yaml          |  149 +--
 .../devicetree/bindings/vendor-prefixes.yaml       |    8 +
 Documentation/gpu/drm-mm.rst                       |    6 +
 Documentation/gpu/todo.rst                         |   17 -
 MAINTAINERS                                        |   20 +-
 drivers/accel/amdxdna/Kconfig                      |    3 +-
 drivers/accel/amdxdna/aie.c                        |   33 +-
 drivers/accel/amdxdna/aie.h                        |   47 +-
 drivers/accel/amdxdna/aie2_ctx.c                   |  119 +-
 drivers/accel/amdxdna/aie2_message.c               |    4 +-
 drivers/accel/amdxdna/aie2_pci.c                   |   67 +-
 drivers/accel/amdxdna/aie2_pci.h                   |   40 +-
 drivers/accel/amdxdna/aie2_pm.c                    |   10 +-
 drivers/accel/amdxdna/aie4_ctx.c                   | 1132 ++++++++++++++++++--
 drivers/accel/amdxdna/aie4_host_queue.h            |   72 +-
 drivers/accel/amdxdna/aie4_message.c               |  245 +++++
 drivers/accel/amdxdna/aie4_msg_priv.h              |  149 ++-
 drivers/accel/amdxdna/aie4_pci.c                   |  988 +++++++++++++++--
 drivers/accel/amdxdna/aie4_pci.h                   |  117 +-
 drivers/accel/amdxdna/aie4_sriov.c                 |   66 +-
 drivers/accel/amdxdna/amdxdna_ctx.c                |   72 +-
 drivers/accel/amdxdna/amdxdna_ctx.h                |   28 +-
 drivers/accel/amdxdna/amdxdna_debugfs.c            |    3 +
 drivers/accel/amdxdna/amdxdna_gem.c                |  420 +++++---
 drivers/accel/amdxdna/amdxdna_gem.h                |   21 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.c            |   73 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h            |   23 +-
 drivers/accel/amdxdna/amdxdna_pm.c                 |   26 +
 drivers/accel/amdxdna/amdxdna_pm.h                 |    2 +
 drivers/accel/amdxdna/amdxdna_sysfs.c              |    2 +-
 drivers/accel/amdxdna/npu1_regs.c                  |   19 +-
 drivers/accel/amdxdna/npu3_regs.c                  |  105 +-
 drivers/accel/amdxdna/npu4_regs.c                  |   30 +-
 drivers/accel/ethosu/ethosu_gem.c                  |    2 +-
 drivers/accel/ivpu/ivpu_debugfs.c                  |   29 -
 drivers/accel/ivpu/ivpu_drv.c                      |   13 +-
 drivers/accel/ivpu/ivpu_drv.h                      |    6 +-
 drivers/accel/ivpu/ivpu_fw.c                       |   91 +-
 drivers/accel/ivpu/ivpu_fw.h                       |    1 +
 drivers/accel/ivpu/ivpu_hw.c                       |   13 -
 drivers/accel/ivpu/ivpu_hw.h                       |    1 -
 drivers/accel/ivpu/ivpu_hw_btrs.c                  |    7 +-
 drivers/accel/ivpu/ivpu_job.c                      |    3 +
 drivers/accel/ivpu/ivpu_mmu.c                      |    6 +-
 drivers/accel/ivpu/ivpu_pm.c                       |    2 +-
 drivers/accel/ivpu/vpu_boot_api.h                  |   36 +-
 drivers/accel/rocket/rocket_core.c                 |   21 +-
 drivers/accel/rocket/rocket_drv.h                  |    1 +
 drivers/accel/rocket/rocket_job.c                  |   45 +-
 drivers/dma-buf/dma-buf.c                          |   13 +-
 drivers/dma-buf/udmabuf.c                          |   13 +-
 drivers/gpu/buddy.c                                |  105 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   32 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |    3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   11 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |   17 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |    2 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |    2 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |  102 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |    7 +-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |    2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |    2 +-
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |    4 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |    2 +-
 drivers/gpu/drm/arm/Kconfig                        |    4 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |    4 +-
 drivers/gpu/drm/arm/hdlcd_drv.c                    |   85 +-
 drivers/gpu/drm/arm/hdlcd_drv.h                    |    1 +
 drivers/gpu/drm/arm/malidp_drv.c                   |    4 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |    4 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_out.c            |    2 +-
 drivers/gpu/drm/ast/ast_dp.c                       |   18 +-
 drivers/gpu/drm/ast/ast_dp501.c                    |    2 +-
 drivers/gpu/drm/ast/ast_sil164.c                   |    2 +-
 drivers/gpu/drm/ast/ast_vga.c                      |    2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |    4 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |    2 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |    2 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    1 +
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |    2 +-
 drivers/gpu/drm/bridge/fsl-ldb.c                   |   17 +-
 drivers/gpu/drm/bridge/inno-hdmi.c                 |    1 -
 drivers/gpu/drm/bridge/microchip-lvds.c            |    1 -
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |    2 +-
 drivers/gpu/drm/bridge/sii902x.c                   |   22 +-
 drivers/gpu/drm/bridge/simple-bridge.c             |    2 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |    1 -
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |   10 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   14 +-
 drivers/gpu/drm/bridge/tc358767.c                  |    8 +-
 drivers/gpu/drm/bridge/tda998x_drv.c               |    3 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |    2 +-
 drivers/gpu/drm/ci/drm-misc-ci.yml                 |  147 +++
 drivers/gpu/drm/display/drm_bridge_connector.c     |    4 +-
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |    9 +-
 drivers/gpu/drm/drm_atomic.c                       |  187 ++--
 drivers/gpu/drm/drm_atomic_state_helper.c          |   67 +-
 drivers/gpu/drm/drm_bridge.c                       |    5 +-
 drivers/gpu/drm/drm_client_modeset.c               |    4 +-
 drivers/gpu/drm/drm_connector.c                    |    8 -
 drivers/gpu/drm/drm_drv.c                          |   12 +-
 drivers/gpu/drm/drm_gem_atomic_helper.c            |   92 --
 drivers/gpu/drm/drm_gpusvm.c                       |   49 +-
 drivers/gpu/drm/drm_gpuvm.c                        |  518 ++++++++-
 drivers/gpu/drm/drm_mode_config.c                  |    4 +-
 drivers/gpu/drm/drm_panel.c                        |   19 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |  328 ------
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   10 +-
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c             |   32 +
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |    2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |    2 +-
 drivers/gpu/drm/gud/gud_connector.c                |   20 +-
 drivers/gpu/drm/gud/gud_drv.c                      |    4 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c     |    3 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |    3 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |    6 +-
 drivers/gpu/drm/hyperv/hyperv_drm.h                |   42 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c            |   14 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |  170 ++-
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c          |  218 +++-
 drivers/gpu/drm/i915/display/intel_connector.c     |    6 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |    6 +-
 drivers/gpu/drm/imagination/pvr_device.c           |   43 +-
 drivers/gpu/drm/imagination/pvr_device.h           |   28 +
 drivers/gpu/drm/imagination/pvr_drv.c              |    5 +
 drivers/gpu/drm/imagination/pvr_drv.h              |    4 +-
 drivers/gpu/drm/imagination/pvr_free_list.c        |   12 +-
 drivers/gpu/drm/imagination/pvr_fw.c               |   46 +
 drivers/gpu/drm/imagination/pvr_fw.h               |    3 +
 drivers/gpu/drm/imagination/pvr_fw_meta.c          |    5 +-
 drivers/gpu/drm/imagination/pvr_fw_startstop.c     |   37 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.c         |   25 +-
 drivers/gpu/drm/imagination/pvr_mmu.c              |   93 +-
 drivers/gpu/drm/imagination/pvr_mmu.h              |    2 +-
 drivers/gpu/drm/imagination/pvr_rogue_mmu_defs.h   |  206 ++--
 drivers/gpu/drm/imagination/pvr_vm.c               |   22 +-
 drivers/gpu/drm/imagination/pvr_vm.h               |    2 -
 drivers/gpu/drm/imx/dc/dc-kms.c                    |    4 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c                |    4 +-
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c                |    2 +-
 drivers/gpu/drm/logicvc/logicvc_interface.c        |    2 +-
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c      |    2 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c      |    4 +-
 drivers/gpu/drm/mcde/mcde_drv.c                    |    4 +-
 drivers/gpu/drm/meson/meson_drv.c                  |    4 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |   12 +-
 drivers/gpu/drm/meson/meson_plane.c                |   20 +-
 drivers/gpu/drm/meson/meson_vclk.c                 |    6 +-
 drivers/gpu/drm/mgag200/mgag200_vga.c              |    2 +-
 drivers/gpu/drm/mgag200/mgag200_vga_bmc.c          |    2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |    2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |   90 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |   16 +-
 drivers/gpu/drm/mxsfb/lcdif_drv.c                  |    4 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |    4 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   25 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  129 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.h        |    3 +-
 drivers/gpu/drm/omapdrm/dss/output.c               |    3 +
 drivers/gpu/drm/panel/Kconfig                      |   66 ++
 drivers/gpu/drm/panel/Makefile                     |    5 +
 .../gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c   |   20 +-
 drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c     |   19 +-
 drivers/gpu/drm/panel/panel-boe-himax8279d.c       |   23 +-
 drivers/gpu/drm/panel/panel-boe-td4320.c           |   23 +-
 .../gpu/drm/panel/panel-boe-th101mb31ig002-28a.c   |   24 +-
 drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c     |   23 +-
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |   24 +-
 drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c  |   20 +-
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c          |   20 +-
 drivers/gpu/drm/panel/panel-edp.c                  |    4 +
 drivers/gpu/drm/panel/panel-elida-kd35t133.c       |   20 +-
 drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c  |   19 +-
 .../gpu/drm/panel/panel-feiyang-fy07024di26a30d.c  |  100 +-
 drivers/gpu/drm/panel/panel-himax-hx8279.c         |    3 +-
 .../gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c    |  297 +++++
 drivers/gpu/drm/panel/panel-hydis-hv101hd1.c       |   24 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |  216 ++++
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |   76 +-
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c   |   19 +-
 drivers/gpu/drm/panel/panel-khadas-ts050.c         |   23 +-
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c |   83 +-
 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c |   40 +-
 drivers/gpu/drm/panel/panel-lg-lh400wv3.c          |  236 ++++
 drivers/gpu/drm/panel/panel-lg-sw43408.c           |   22 +-
 drivers/gpu/drm/panel/panel-lincolntech-lcd197.c   |   20 +-
 drivers/gpu/drm/panel/panel-lxd-m9189a.c           |   26 +-
 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c   |   16 +-
 drivers/gpu/drm/panel/panel-newvision-nv3051d.c    |   60 +-
 drivers/gpu/drm/panel/panel-novatek-nt35510.c      |   13 +-
 drivers/gpu/drm/panel/panel-novatek-nt35532.c      |   23 +-
 drivers/gpu/drm/panel/panel-novatek-nt35560.c      |   19 +-
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c     |  598 +++++++++--
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c     |   21 +-
 drivers/gpu/drm/panel/panel-novatek-nt36850.c      |  350 ++++++
 drivers/gpu/drm/panel/panel-novatek-nt37700f.c     |   23 +-
 drivers/gpu/drm/panel/panel-novatek-nt37705.c      |  396 +++++++
 drivers/gpu/drm/panel/panel-novatek-nt37801.c      |   23 +-
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |   16 +-
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c |   23 +-
 .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   |   31 +-
 drivers/gpu/drm/panel/panel-raydium-rm67191.c      |   22 +-
 drivers/gpu/drm/panel/panel-raydium-rm67200.c      |   23 +-
 drivers/gpu/drm/panel/panel-raydium-rm68200.c      |  297 +++--
 drivers/gpu/drm/panel/panel-raydium-rm692e5.c      |   20 +-
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c       |   19 +-
 drivers/gpu/drm/panel/panel-samsung-ams644vk04.c   |  356 ++++++
 drivers/gpu/drm/panel/panel-simple.c               |   40 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c      |   13 +-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c      |  131 ++-
 .../gpu/drm/panel/panel-startek-kd070fhfid015.c    |   24 +-
 drivers/gpu/drm/panel/panel-summit.c               |   15 +-
 drivers/gpu/drm/panel/panel-synaptics-r63353.c     |   25 +-
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c       |   19 +-
 drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c   |   20 +-
 drivers/gpu/drm/panthor/panthor_gpu.c              |    4 +
 drivers/gpu/drm/panthor/panthor_gpu_regs.h         |    1 +
 drivers/gpu/drm/panthor/panthor_hw.h               |    6 +
 drivers/gpu/drm/panthor/panthor_mmu.c              |   72 +-
 drivers/gpu/drm/panthor/panthor_mmu_regs.h         |    1 +
 drivers/gpu/drm/panthor/panthor_pwr.c              |   29 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h         |    7 +
 drivers/gpu/drm/pl111/pl111_drv.c                  |    4 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |    2 +-
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    |   16 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |    2 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |   24 +-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     |   27 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |    4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |  231 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h       |   10 +
 drivers/gpu/drm/sitronix/st7571.c                  |    2 +-
 drivers/gpu/drm/sitronix/st7920.c                  |    2 +-
 drivers/gpu/drm/solomon/ssd130x.c                  |    7 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |    2 +-
 drivers/gpu/drm/sti/sti_hda.c                      |    2 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |    2 +-
 drivers/gpu/drm/stm/lvds.c                         |    2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   17 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |    2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |    2 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |   16 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |    2 +-
 drivers/gpu/drm/sysfb/corebootdrm.c                |    4 +-
 drivers/gpu/drm/sysfb/efidrm.c                     |    4 +-
 drivers/gpu/drm/sysfb/ofdrm.c                      |    4 +-
 drivers/gpu/drm/sysfb/simpledrm.c                  |    4 +-
 drivers/gpu/drm/sysfb/vesadrm.c                    |    4 +-
 drivers/gpu/drm/tegra/dsi.c                        |   17 +-
 drivers/gpu/drm/tegra/hdmi.c                       |    2 +-
 drivers/gpu/drm/tegra/output.c                     |    1 -
 drivers/gpu/drm/tegra/sor.c                        |   13 +-
 drivers/gpu/drm/tests/drm_atomic_commit_test.c     |    2 +-
 drivers/gpu/drm/tests/drm_atomic_test.c            |    2 +-
 drivers/gpu/drm/tests/drm_connector_test.c         |    4 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |   17 +-
 drivers/gpu/drm/tests/drm_probe_helper_test.c      |    2 +-
 drivers/gpu/drm/tidss/tidss_crtc.c                 |   10 +-
 drivers/gpu/drm/tidss/tidss_crtc.h                 |    4 +-
 drivers/gpu/drm/tidss/tidss_dispc.c                |   28 +-
 drivers/gpu/drm/tidss/tidss_dispc.h                |    5 +-
 drivers/gpu/drm/tidss/tidss_dispc_regs.h           |    1 +
 drivers/gpu/drm/tidss/tidss_drv.c                  |    7 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |   70 +-
 drivers/gpu/drm/tidss/tidss_oldi.c                 |   46 +-
 drivers/gpu/drm/tidss/tidss_oldi.h                 |    1 -
 drivers/gpu/drm/tiny/Kconfig                       |   11 +
 drivers/gpu/drm/tiny/Makefile                      |    1 +
 drivers/gpu/drm/tiny/appletbdrm.c                  |    4 +-
 drivers/gpu/drm/tiny/arcpgu.c                      |    2 +-
 drivers/gpu/drm/tiny/bochs.c                       |    2 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c                 |    2 +-
 drivers/gpu/drm/tiny/glandagpu.c                   |  634 +++++++++++
 drivers/gpu/drm/tiny/gm12u320.c                    |    2 +-
 drivers/gpu/drm/tiny/pixpaper.c                    |    2 +-
 drivers/gpu/drm/tiny/repaper.c                     |    2 +-
 drivers/gpu/drm/tiny/sharp-memory.c                |    2 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |    4 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |    2 +-
 drivers/gpu/drm/v3d/v3d_drv.c                      |    3 +
 drivers/gpu/drm/v3d/v3d_drv.h                      |    6 +-
 drivers/gpu/drm/v3d/v3d_regs.h                     |   24 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |   44 +-
 drivers/gpu/drm/v3d/v3d_submit.c                   |    9 +
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |    2 +-
 drivers/gpu/drm/vc4/vc4_dpi.c                      |   11 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |   22 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |   30 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |  106 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  400 ++-----
 drivers/gpu/drm/vc4/vc4_hdmi.h                     |   36 +-
 drivers/gpu/drm/vc4/vc4_irq.c                      |   87 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |    4 +-
 drivers/gpu/drm/vc4/vc4_perfmon.c                  |   40 +-
 drivers/gpu/drm/vc4/vc4_v3d.c                      |    4 +-
 drivers/gpu/drm/vc4/vc4_vec.c                      |   17 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c            |    1 -
 drivers/gpu/drm/virtio/virtgpu_display.c           |    2 +-
 drivers/gpu/drm/vkms/vkms_connector.c              |    2 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |    8 +-
 drivers/gpu/drm/vkms/vkms_output.c                 |    4 +-
 drivers/gpu/drm/vkms/vkms_writeback.c              |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   23 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |    3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |    2 +-
 drivers/gpu/drm/xe/xe_exec.c                       |   23 +-
 drivers/gpu/drm/xe/xe_vm.c                         |   43 +-
 drivers/gpu/drm/xe/xe_vm.h                         |    3 +-
 drivers/gpu/drm/xen/xen_drm_front_conn.c           |    2 +-
 drivers/gpu/drm/xlnx/zynqmp_disp.c                 |    2 +-
 drivers/gpu/tests/gpu_buddy_test.c                 |   93 ++
 drivers/staging/fbtft/TODO                         |    4 +-
 include/drm/bridge/analogix_dp.h                   |    2 +
 include/drm/display/drm_dp_aux_bus.h               |    1 -
 include/drm/display/drm_hdmi_state_helper.h        |    4 +-
 include/drm/drm_atomic_state_helper.h              |    9 +-
 include/drm/drm_connector.h                        |   12 -
 include/drm/drm_gem.h                              |    2 +-
 include/drm/drm_gem_atomic_helper.h                |   28 -
 include/drm/drm_gpusvm.h                           |   29 +
 include/drm/drm_gpuvm.h                            |  139 ++-
 include/drm/drm_mipi_dbi.h                         |    2 +-
 include/drm/drm_simple_kms_helper.h                |   56 +-
 include/uapi/drm/pvr_drm.h                         |   21 +
 include/uapi/drm/v3d_drm.h                         |    5 +
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c |    4 +-
 349 files changed, 11304 insertions(+), 4046 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/kieweg,gpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,ams644vk04.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/truly,wqhd60-nt36850.yaml
 create mode 100644 Documentation/devicetree/bindings/display/ti/ti,am62l-dss.yaml
 create mode 100644 drivers/gpu/drm/ci/drm-misc-ci.yml
 create mode 100644 drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
 create mode 100644 drivers/gpu/drm/panel/panel-lg-lh400wv3.c
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36850.c
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt37705.c
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-ams644vk04.c
 create mode 100644 drivers/gpu/drm/tiny/glandagpu.c
