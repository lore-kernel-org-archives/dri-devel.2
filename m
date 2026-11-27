Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE220606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nHhBJwbB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF6BA10E602;
	Fri, 27 Nov 2026 16:35:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F2310E50B;
 Fri, 27 Nov 2026 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795797300; x=1827333300;
 h=message-id:date:mime-version:from:to:cc:subject:
 content-transfer-encoding;
 bh=rjzflJ/Ng6BL+eapi8Gj1qoKcKOCDzlHFeNGQ8gIkRA=;
 b=nHhBJwbBEpeopeFqKE9U4hTr2gkJ1F4cKTAeWOsTUA1CL31YS6UtyZ7W
 W2vyFsHwcpaM0n7ChWscGi7SO73zZ0aBeeSPukHJXhcuJNN7GwF7dBdN1
 25RhLlgcB0j4kIsrNwO+gP+Grx5hCZsZMz7f/YcYmX7mBFbIp4r+Id66V
 VjXBzNwrQkiMooCRW7nbe/SiWDPS9zxy17H7KXvj8hAj02EY0Hu9aixd8
 Pemg4ZAjbjkA/MQJLxjPR5Hynkc7pcianAwlfGraH46J/31pFl2RbWUFE
 Zroh6PCxFK7P3q4I5/bdkyJzvJxnD6Ct0SaxkbEKElbUIzISuWX+7uOQK g==;
X-CSE-ConnectionGUID: Q5tBZCDUQx6foSiA2bxHGw==
X-CSE-MsgGUID: 7+0/Q9VsRvaa+vc1VDTaBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4679109"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4679109"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 08:34:59 -0800
X-CSE-ConnectionGUID: YHlkVAJRTEuuLoRvQRqV4A==
X-CSE-MsgGUID: 8FbQU9veSd+QB70/8k8Gyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12754179"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.245.184])
 ([10.245.245.184])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 08:34:55 -0800
Message-ID: <7bc99a11-3ea7-4139-b97d-064f2819e6d3@linux.intel.com>
Date: Fri, 27 Nov 2026 17:36:05 +0100
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

Next pull request for v7.5!

Kind regards,
~Maarten Lankhorst

drm-misc-next-2026-11-27:
drm-misc-next for v7.5:

UAPI Changes:
- Rename dma_buf_map_attachment() -> dma_buf_map_sgt().

Cross-subsystem Changes:
- Add dt binding for starfive,jh7110-dc8200 to verisilicon.
- Remove dma_fence_later().
- Add Dawid Osuchowski as intel vpu maintainer.

Core Changes:
- Bridge cleanups, and conversion of drivers to use
  devm_drm_panel_bridge_add(), remove drmm_of_get_bridge()..
- DP definition fixes.
- More preparations for atomic commit reset.
- Add support for telemetry nodes to drm/ras, use in qaic.
- Cleanups for drm/writeback in preparation of writeback support for
  intel/display.
- Docbook fix for drm_exec.

Driver Changes:
- Convert many drivers to use drm_mode_config_create_initial_state.
- Split de33 plane support in sun4i.
- Assorted bugfixes to sti, vkms, sti, exynos, omapdrm, imx, rockchip,
  mcde, amdxdna, ivpu, mipi/dbi, bridge/analogix_dp, bridge/tc358767,
  msxfb.
- Support multiarch in imagination.
- Improve non-uniform LUT support in vkms.
The following changes since commit c408466a4dfaee4b12587e926c5b85e68c8b3c40:

  drm/panel: leadtek-ltk500hd1829: Use lowercase hex literals (2026-11-19 13:42:04 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-11-27

for you to fetch changes up to 5ce32a0c94a827ff44ee60898c28060714dcff75:

  drm/drm_exec: fix kernel-doc string in drm_exec_retry (2026-11-26 13:31:25 +0100)

----------------------------------------------------------------
drm-misc-next for v7.5:

UAPI Changes:
- Rename dma_buf_map_attachment() -> dma_buf_map_sgt().

Cross-subsystem Changes:
- Add dt binding for starfive,jh7110-dc8200 to verisilicon.
- Remove dma_fence_later().
- Add Dawid Osuchowski as intel vpu maintainer.

Core Changes:
- Bridge cleanups, and conversion of drivers to use
  devm_drm_panel_bridge_add(), remove drmm_of_get_bridge()..
- DP definition fixes.
- More preparations for atomic commit reset.
- Add support for telemetry nodes to drm/ras, use in qaic.
- Cleanups for drm/writeback in preparation of writeback support for
  intel/display.
- Docbook fix for drm_exec.

Driver Changes:
- Convert many drivers to use drm_mode_config_create_initial_state.
- Split de33 plane support in sun4i.
- Assorted bugfixes to sti, vkms, sti, exynos, omapdrm, imx, rockchip,
  mcde, amdxdna, ivpu, mipi/dbi, bridge/analogix_dp, bridge/tc358767,
  msxfb.
- Support multiarch in imagination.
- Improve non-uniform LUT support in vkms.

----------------------------------------------------------------
Alessio Belle (4):
      drm/imagination: Limit access to the RISC-V firmware interface
      drm/imagination: Make the RISC-V firmware header arch-independent
      drm/imagination: Limit access to the META firmware interface
      drm/imagination: Make the META firmware header arch-independent

Alexandru Dadu (1):
      drm/imagination: Prepare heap config header for multi-arch support

Arnd Bergmann (1):
      drm/mipi-dbi: hide unused mipi_dbi_dcs_read_commands array

Colin Ian King (1):
      drm/bridge: tc358767: make read-only array ext_div static const

Dawid Osuchowski (1):
      MAINTAINERS: Add Dawid Osuchowski as Intel VPU maintainer

Denis Arefev (1):
      drm/imx/dcss: Check return value of drm_mode_config_helper_suspend()

Dmitry Baryshkov (24):
      drm/panel: remove the get_timings() callback
      drm/panel: remove the unused struct panel_bridge
      drm/tidss: get the panel type from the embedded bridge
      drm/bridge: lvds-codec: use devm_drm_panel_bridge_add()
      drm/ingenic: use devm_drm_panel_bridge_add()
      drm: mxsfb: use devm_drm_panel_bridge_add()
      drm: rcar-du: use devm_drm_panel_bridge_add()
      drm: rz-du: use devm_drm_panel_bridge_add()
      drm/mcde: use drm_panel_bridge_add()
      drm/pl111: use drm_panel_bridge_add()
      drm/rockchip: lvds: use drm_panel_bridge_add()
      drm/rockchip: rgb: use drm_panel_bridge_add()
      drm/panel: remove the _typed() panel bridge functions
      drm/panel: remove drm_panel.connector_type
      drm/amd/display: embed the writeback encoder in amdgpu_dm_wb_connector
      drm/komeda: embed the writeback encoder in komeda_wb_connector
      drm/mali: embed the writeback encoder in malidp_drm
      drm: renesas: rcar-du: embed the writeback encoder in rcar_du_crtc
      drm: writeback: drop excess connector initialization functions
      drm: writeback: rename drm_writeback_connector_init_with_encoder()
      drm: writeback: don't destroy the shared writeback properties
      drm: writeback: clean up writeback jobs outside the job_lock
      drm: writeback: clean up writeback connectors in drm_connector_cleanup()
      drm: writeback: drop the drmm writeback cleanup action

Fabio Estevam (1):
      drm/mxsfb: lcdif: Fix use-after-free on unbind

Hans Verkuil (3):
      gpu: drm: sti: call cec_notifier_phys_addr_invalidate if no HPD
      gpu: drm: exynos: call cec_notifier_phys_addr_invalidate if no HPD
      gpu: drm: omapdrm: call cec_s_phys_addr only if HPD is present

Jakov Novak (1):
      drm/drm_exec: fix kernel-doc string in drm_exec_retry

Jason Gunthorpe (1):
      treewide: Rename dma_buf_(un)map_attachment() to dma_buf_(un)map_sgt()

Jernej Skrabec (5):
      drm/sun4i: Reject fractional source coordinates without scaler
      dt-bindings: display: allwinner: Add DE33 planes
      drm/sun4i: Add DE33 shared plane driver
      dt-bindings: display: allwinner: Split H616 DE33 layer reg space
      drm/sun4i: Switch DE33 to split plane bindings

Johan Hovold (1):
      drm/imx/tve: take i2c adapter module reference

Karol Wachowski (1):
      accel/ivpu: Allocate a scatterlist per userptr dma-buf mapping

Khaled Almahallawy (1):
      drm/display: Increase DP_RECEIVER_CAP_SIZE from 15 to 16 bytes

Krzysztof Kozlowski (1):
      dt-bindings: display: panel: Make DSI panels port optional

Leandro Ribeiro (12):
      drm/vkms: rename VKMS_LUT_SIZE to VKMS_GAMMA_LUT_SIZE
      drm/vkms: properly compute gamma LUT size in vkms_atomic_check()
      drm/vkms: allow color curve LUTs to have different sizes
      drm/vkms: remove TEST_LUT_SIZE
      drm/vkms: remove linear_eotf
      drm/vkms: improve the way in which we access LUT member
      drm/vkms: rename struct vkms_color_lut::base to y
      drm/vkms: rename get_lut_index() to get_uniform_lut_index()
      drm/vkms: add support to non-uniform LUT for internal color curves
      drm/vkms: test sRGB and inverse sRGB LUTs using more samples
      drm/vkms: add script to create optimized LUTs for color curves
      drm/vkms: replace uniform sRGB LUT and its inverse with optimal ones

Linus Walleij (1):
      drm/mcde: Use power domain for display power

Lizhi Hou (2):
      accel/amdxdna: Reject zero length user buffer entry
      accel/amdxdna: Drop dma-buf wrapping for ubuf

Louis Chauvet (2):
      drm/vkms: Explicitly display connector status
      drm/vkms: Add new lines for configfs attributes

Luca Ceresoli (3):
      drm: adp: stop using deprecated drmm_of_get_bridge()
      drm/panel: remove drmm_of_get_bridge()
      drm/todo: remove drmm_of_get_bridge()

Maxime Ripard (57):
      drm/adp: Switch to drm_mode_config_create_initial_state
      drm/amdgpu: Switch to drm_mode_config_create_initial_state
      drm/hdlcd: Switch to drm_mode_config_create_initial_state
      drm/armada: Switch to drm_mode_config_create_initial_state
      drm/ast: Switch to drm_mode_config_create_initial_state
      drm/exynos: Switch to drm_mode_config_create_initial_state
      drm/fsl-dcu: Switch to drm_mode_config_create_initial_state
      drm/hisilicon/hibmc: Remove hibmc_unload() from the load error path
      drm/hisilicon/hibmc: Switch to drm_mode_config_create_initial_state
      drm/imx/ipuv3: Switch to drm_mode_config_create_initial_state
      drm/ingenic: Move the private object creation before the reset
      drm/ingenic: Switch to drm_mode_config_create_initial_state
      drm/kmb: Switch to drm_mode_config_create_initial_state
      drm/logicvc: Switch to drm_mode_config_create_initial_state
      drm/mediatek: Switch to drm_mode_config_create_initial_state
      drm/mgag200: Switch to drm_mode_config_create_initial_state
      drm/msm: Switch to drm_mode_config_create_initial_state
      drm/nouveau: Switch to drm_mode_config_create_initial_state
      drm/omap: Switch to drm_mode_config_create_initial_state
      drm/qxl: Destroy the monitors object on the modeset init error path
      drm/qxl: Switch to drm_mode_config_create_initial_state
      drm/rz-du: Switch to drm_mode_config_create_initial_state
      drm/shmobile: Switch to drm_mode_config_create_initial_state
      drm/st7571: Switch to drm_mode_config_create_initial_state
      drm/sprd: Switch to drm_mode_config_create_initial_state
      drm/sti: Fix drm_atomic_helper_shutdown() on the bind error paths
      drm/sti: Move drm_mode_config_create_initial_state() before drm_dev_register()
      drm/sun4i: Switch to drm_mode_config_create_initial_state
      drm/tests: drm_atomic_state_test: Switch to drm_mode_config_create_initial_state
      drm/tests: drm_atomic_test: Switch to drm_mode_config_create_initial_state
      drm/tests: drm_bridge_test: Switch to drm_mode_config_create_initial_state
      drm/tests: drm_hdmi_state_helper_test: Switch to drm_mode_config_create_initial_state
      drm/tidss: Switch to drm_mode_config_create_initial_state
      drm/arcpgu: Switch to drm_mode_config_create_initial_state
      drm/bochs: Switch to drm_mode_config_create_initial_state
      drm/cirrus-qemu: Switch to drm_mode_config_create_initial_state
      drm/gm12u320: Switch to drm_mode_config_create_initial_state
      drm/hx8357d: Switch to drm_mode_config_create_initial_state
      drm/ili9163: Switch to drm_mode_config_create_initial_state
      drm/ili9341: Switch to drm_mode_config_create_initial_state
      drm/ili9486: Switch to drm_mode_config_create_initial_state
      drm/mi0283qt: Switch to drm_mode_config_create_initial_state
      drm/panel-mipi-dbi: Switch to drm_mode_config_create_initial_state
      drm/pixpaper: Switch to drm_mode_config_create_initial_state
      drm/repaper: Switch to drm_mode_config_create_initial_state
      drm/sharp-memory: Switch to drm_mode_config_create_initial_state
      drm/udl: Switch to drm_mode_config_create_initial_state
      drm/vboxvideo: Switch to drm_mode_config_create_initial_state
      drm/verisilicon: Switch to drm_mode_config_create_initial_state
      drm/virtio: Switch to drm_mode_config_create_initial_state
      drm/xen: Switch to drm_mode_config_create_initial_state
      drm/xlnx: Switch to drm_mode_config_create_initial_state
      drm/atomic: Add drm_atomic_get_connector_for_encoder_locked()
      drm/colorop: Export drm_atomic_helper_colorop_create_state()
      drm/atomic: Fix private obj error handling
      drm/bridge: Add drm_private_obj_is_bridge()
      drm/atomic: Export drm_atomic_*_print_state

Michal Wilczynski (1):
      dt-bindings: display: verisilicon: Add starfive,jh7110-dc8200

Philipp Stanner (1):
      dma-buf/dma-fence: Remove dma_fence_later()

Rob Herring (Arm) (1):
      dt-bindings: display: rockchip: Allow single 'port' node for DP input port

Rodrigo Vivi (1):
      drm/ras: Do not fail an error-counter dump on a skipped last ID

Suraj Kandpal (7):
      drm: writeback: Refactor drm_writeback_connector structure
      drm: writeback: Modify writeback init helpers
      drm: writeback: Modify drm_writeback_queue_job helper
      drm: writeback: Modify drm_writeback_signal_completion helper
      drm: writeback: Modify drm_writeback_get_out_fence helper
      drm: writeback: Modify prepare_writeback_job helper
      drm: writeback: Modify cleanup_writeback_job helper

Thomas Zimmermann (1):
      firmware: sysfb: Remove CONFIG_SYSFB_SIMPLEFB

Thorsten Blum (1):
      drm/bridge: analogix_dp: Use str_supported_unsupported() helper

Ville Syrjälä (2):
      drm/atomic: Add the state->checked WARN to colorop state
      drm/atomic: Prefer drm_WARN_ON() over WARN_ON() in drm_atomic_get_*_state()

Zack McKevitt (4):
      drm/drm_ras: Reference-count nodes across netlink handlers
      drm/drm_ras: Remove admin-perm flag from list-nodes operation
      drm/drm_ras: Extend DRM RAS interface to include telemetry nodes
      accel/qaic: Add callbacks for DRM RAS netlink telemetry

 .../display/allwinner,sun50i-h616-de33-planes.yaml |   46 +
 .../display/allwinner,sun8i-a83t-de2-mixer.yaml    |   16 +-
 .../bindings/display/panel/anbernic,td4310.yaml    |    1 -
 .../bindings/display/panel/boe,td4320.yaml         |    1 -
 .../bindings/display/panel/boe,tv101wum-ll2.yaml   |    1 -
 .../bindings/display/panel/ebbg,ft8719.yaml        |    1 -
 .../bindings/display/panel/elida,kd35t133.yaml     |    1 -
 .../display/panel/feiyang,fy07024di26a30d.yaml     |    1 -
 .../bindings/display/panel/himax,hx83112a.yaml     |    1 -
 .../bindings/display/panel/himax,hx83112b.yaml     |    1 -
 .../bindings/display/panel/himax,hx8394.yaml       |    1 -
 .../bindings/display/panel/ilitek,ili7807s.yaml    |    1 -
 .../bindings/display/panel/ilitek,ili9805.yaml     |    1 -
 .../bindings/display/panel/ilitek,ili9806e.yaml    |    2 +-
 .../bindings/display/panel/lxd,m9189a.yaml         |    1 -
 .../bindings/display/panel/novatek,nt35532.yaml    |    1 -
 .../bindings/display/panel/novatek,nt36672a.yaml   |    1 -
 .../bindings/display/panel/novatek,nt36672e.yaml   |    1 -
 .../bindings/display/panel/novatek,nt37801.yaml    |    1 -
 .../bindings/display/panel/novatek,nt51021.yaml    |    1 -
 .../bindings/display/panel/raydium,rm67191.yaml    |    1 -
 .../bindings/display/panel/raydium,rm67200.yaml    |    1 -
 .../bindings/display/panel/raydium,rm69220.yaml    |    1 -
 .../bindings/display/panel/raydium,rm692e5.yaml    |    1 -
 .../bindings/display/panel/renesas,r61307.yaml     |    1 -
 .../bindings/display/panel/renesas,r69328.yaml     |    1 -
 .../bindings/display/panel/ronbo,rb070d30.yaml     |    1 -
 .../bindings/display/panel/samsung,ams581vf01.yaml |    1 -
 .../bindings/display/panel/samsung,ams639rq08.yaml |    1 -
 .../display/panel/samsung,s6e88a0-ams452ef01.yaml  |    1 -
 .../bindings/display/panel/samsung,sofef01-m.yaml  |    1 -
 .../bindings/display/panel/sony,td4353-jdi.yaml    |    1 -
 .../display/panel/sony,tulip-truly-nt35521.yaml    |    1 -
 .../display/panel/startek,kd070fhfid015.yaml       |    1 -
 .../bindings/display/panel/synaptics,r63353.yaml   |    1 -
 .../display/panel/visionox,g2647fb105.yaml         |    1 -
 .../bindings/display/panel/visionox,r66451.yaml    |    1 -
 .../bindings/display/panel/visionox,rm69299.yaml   |    1 -
 .../bindings/display/panel/visionox,rm692e5.yaml   |    1 -
 .../bindings/display/panel/visionox,vtdr6130.yaml  |    1 -
 .../bindings/display/panel/xinpeng,xpp055c272.yaml |    1 -
 .../display/rockchip/rockchip,rk3399-cdn-dp.yaml   |   19 +-
 .../bindings/display/verisilicon,dc.yaml           |    1 +
 Documentation/gpu/todo.rst                         |    2 -
 Documentation/netlink/specs/drm_ras.yaml           |   98 +-
 MAINTAINERS                                        |    1 +
 drivers/accel/amdxdna/amdxdna_gem.c                |   76 +-
 drivers/accel/amdxdna/amdxdna_gem.h                |   10 +
 drivers/accel/amdxdna/amdxdna_ubuf.c               |  243 ++--
 drivers/accel/amdxdna/amdxdna_ubuf.h               |    8 +-
 drivers/accel/ivpu/ivpu_gem.c                      |    6 +-
 drivers/accel/ivpu/ivpu_gem_userptr.c              |   65 +-
 drivers/accel/qaic/Kconfig                         |    1 +
 drivers/accel/qaic/Makefile                        |    1 +
 drivers/accel/qaic/qaic.h                          |   19 +
 drivers/accel/qaic/qaic_data.c                     |    6 +-
 drivers/accel/qaic/qaic_drv.c                      |   15 +
 drivers/accel/qaic/qaic_telemetry.c                |  564 ++++++++
 drivers/accel/qaic/qaic_telemetry.h                |   14 +
 drivers/dma-buf/dma-buf.c                          |   54 +-
 drivers/dma-buf/dma-fence.c                        |    3 -
 drivers/firmware/Kconfig                           |   16 -
 drivers/firmware/Makefile                          |    1 -
 drivers/firmware/sysfb.c                           |   33 -
 drivers/firmware/sysfb_simplefb.c                  |  140 --
 drivers/gpu/drm/adp/adp_drv.c                      |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |    4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    8 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |    4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |   37 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h   |    4 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |    9 +-
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |    4 +-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |    2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   10 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |    2 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |    9 +-
 .../drm/arm/display/komeda/komeda_wb_connector.c   |   39 +-
 drivers/gpu/drm/arm/hdlcd_drv.c                    |    4 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |    2 +-
 drivers/gpu/drm/arm/malidp_drv.h                   |    3 +-
 drivers/gpu/drm/arm/malidp_mw.c                    |   32 +-
 drivers/gpu/drm/armada/armada_drv.c                |    4 +-
 drivers/gpu/drm/armada/armada_gem.c                |   16 +-
 drivers/gpu/drm/ast/ast_mode.c                     |    4 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    3 +-
 drivers/gpu/drm/bridge/lvds-codec.c                |    3 +-
 drivers/gpu/drm/bridge/tc358767.c                  |    2 +-
 drivers/gpu/drm/drm_atomic.c                       |  117 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |    4 +-
 drivers/gpu/drm/drm_bridge.c                       |   15 +
 drivers/gpu/drm/drm_colorop.c                      |    1 +
 drivers/gpu/drm/drm_connector.c                    |    3 +
 drivers/gpu/drm/drm_crtc_internal.h                |    3 +
 drivers/gpu/drm/drm_internal.h                     |   13 +
 drivers/gpu/drm/drm_mipi_dbi.c                     |   48 +-
 drivers/gpu/drm/drm_panel.c                        |  111 +-
 drivers/gpu/drm/drm_prime.c                        |    6 +-
 drivers/gpu/drm/drm_ras.c                          |  615 +++++++-
 drivers/gpu/drm/drm_ras_nl.c                       |   45 +-
 drivers/gpu/drm/drm_ras_nl.h                       |   10 +
 drivers/gpu/drm/drm_writeback.c                    |  202 +--
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |    4 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c          |    4 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |    7 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |    8 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |    2 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c   |    4 +-
 drivers/gpu/drm/imagination/pvr_fw.c               |    7 +-
 drivers/gpu/drm/imagination/pvr_fw.h               |   26 +
 drivers/gpu/drm/imagination/pvr_fw_meta.c          |  104 +-
 drivers/gpu/drm/imagination/pvr_fw_meta.h          |   14 -
 .../{pvr_rogue_meta.h => pvr_fw_meta_internal.h}   |  173 +--
 drivers/gpu/drm/imagination/pvr_fw_mips.c          |    1 +
 drivers/gpu/drm/imagination/pvr_fw_riscv.c         |   13 +-
 .../gpu/drm/imagination/pvr_fw_riscv_internal.h    |   43 +
 drivers/gpu/drm/imagination/pvr_fw_startstop.c     |   61 +-
 drivers/gpu/drm/imagination/pvr_gem.h              |    3 +-
 .../{pvr_rogue_heap_config.h => pvr_heap_config.h} |   26 +-
 drivers/gpu/drm/imagination/pvr_rogue_riscv.h      |   39 -
 drivers/gpu/drm/imagination/pvr_vm.c               |   18 +-
 drivers/gpu/drm/imx/dcss/dcss-dev.c                |    4 +-
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c           |    4 +-
 drivers/gpu/drm/imx/ipuv3/imx-tve.c                |   12 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |   25 +-
 drivers/gpu/drm/kmb/kmb_drv.c                      |    3 +-
 drivers/gpu/drm/logicvc/logicvc_mode.c             |    4 +-
 drivers/gpu/drm/mcde/mcde_clk_div.c                |    4 +-
 drivers/gpu/drm/mcde/mcde_display.c                |   13 +-
 drivers/gpu/drm/mcde/mcde_drm.h                    |    1 -
 drivers/gpu/drm/mcde/mcde_drv.c                    |   59 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |    1 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |    8 +-
 drivers/gpu/drm/mgag200/mgag200_g200.c             |    4 +-
 drivers/gpu/drm/mgag200/mgag200_g200eh.c           |    4 +-
 drivers/gpu/drm/mgag200/mgag200_g200eh3.c          |    4 +-
 drivers/gpu/drm/mgag200/mgag200_g200eh5.c          |    4 +-
 drivers/gpu/drm/mgag200/mgag200_g200er.c           |    4 +-
 drivers/gpu/drm/mgag200/mgag200_g200ev.c           |    4 +-
 drivers/gpu/drm/mgag200/mgag200_g200ew3.c          |    4 +-
 drivers/gpu/drm/mgag200/mgag200_g200se.c           |    4 +-
 drivers/gpu/drm/mgag200/mgag200_g200wb.c           |    4 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |    9 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |   10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h      |    4 +-
 drivers/gpu/drm/msm/msm_kms.c                      |    4 +-
 drivers/gpu/drm/mxsfb/lcdif_drv.c                  |   22 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |    3 +-
 drivers/gpu/drm/nouveau/nouveau_display.c          |    4 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |    7 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c            |    5 +
 drivers/gpu/drm/omapdrm/dss/hdmi4_cec.h            |    5 +
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    4 +-
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c          |    4 +-
 drivers/gpu/drm/panel/panel-edp.c                  |   18 -
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c        |   18 -
 drivers/gpu/drm/panel/panel-simple.c               |   18 -
 drivers/gpu/drm/pl111/pl111_drv.c                  |    3 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |   11 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h     |    8 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c  |    5 +-
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    |   42 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c   |    5 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c       |    4 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c   |    4 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |    2 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |    3 +-
 drivers/gpu/drm/sitronix/st7571.c                  |    4 +-
 drivers/gpu/drm/sprd/sprd_drm.c                    |    6 +-
 drivers/gpu/drm/sti/sti_drv.c                      |   10 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |    4 +-
 drivers/gpu/drm/sun4i/Makefile                     |    3 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |    4 +-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |    6 +-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.h          |    2 +-
 drivers/gpu/drm/sun4i/sun50i_planes.c              |  209 +++
 drivers/gpu/drm/sun4i/sun50i_planes.h              |   43 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |  191 ++-
 drivers/gpu/drm/sun4i/sun8i_mixer.h                |   11 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |   24 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |   24 +-
 drivers/gpu/drm/sysfb/Kconfig                      |    4 +-
 drivers/gpu/drm/tegra/gem.c                        |   14 +-
 drivers/gpu/drm/tests/drm_atomic_commit_test.c     |    3 +-
 drivers/gpu/drm/tests/drm_atomic_test.c            |    4 +-
 drivers/gpu/drm/tests/drm_bridge_test.c            |   12 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |    3 +-
 drivers/gpu/drm/tidss/tidss_drv.c                  |    6 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |    4 +-
 drivers/gpu/drm/tiny/arcpgu.c                      |    4 +-
 drivers/gpu/drm/tiny/bochs.c                       |    4 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c                 |    4 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |    4 +-
 drivers/gpu/drm/tiny/hx8357d.c                     |    4 +-
 drivers/gpu/drm/tiny/ili9163.c                     |    4 +-
 drivers/gpu/drm/tiny/ili9341.c                     |    4 +-
 drivers/gpu/drm/tiny/ili9486.c                     |    4 +-
 drivers/gpu/drm/tiny/mi0283qt.c                    |    4 +-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c              |    4 +-
 drivers/gpu/drm/tiny/pixpaper.c                    |    4 +-
 drivers/gpu/drm/tiny/repaper.c                     |    4 +-
 drivers/gpu/drm/tiny/sharp-memory.c                |    4 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |    4 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |    5 +-
 drivers/gpu/drm/vc4/vc4_txp.c                      |   16 +-
 drivers/gpu/drm/verisilicon/vs_drm.c               |    4 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |    3 +-
 drivers/gpu/drm/virtio/virtgpu_prime.c             |    8 +-
 drivers/gpu/drm/vkms/scripts/color-curve-lut.py    |  573 ++++++++
 drivers/gpu/drm/vkms/tests/vkms_color_test.c       |   48 +-
 drivers/gpu/drm/vkms/vkms_composer.c               |  127 +-
 drivers/gpu/drm/vkms/vkms_composer.h               |    2 +-
 drivers/gpu/drm/vkms/vkms_config.c                 |    5 +-
 drivers/gpu/drm/vkms/vkms_configfs.c               |    4 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |    4 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |    4 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |   15 +-
 drivers/gpu/drm/vkms/vkms_luts.c                   | 1473 +++++++++-----------
 drivers/gpu/drm/vkms/vkms_luts.h                   |    3 -
 drivers/gpu/drm/vkms/vkms_writeback.c              |   15 +-
 drivers/gpu/drm/xe/xe_bo.c                         |   16 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c            |    4 +-
 drivers/gpu/drm/xlnx/zynqmp_kms.c                  |    6 +-
 drivers/iio/industrialio-buffer.c                  |    6 +-
 drivers/infiniband/core/umem_dmabuf.c              |    8 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |    2 +-
 .../media/common/videobuf2/videobuf2-dma-contig.c  |    8 +-
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  |    4 +-
 .../media/platform/nvidia/tegra-vde/dmabuf-cache.c |    6 +-
 drivers/misc/fastrpc.c                             |    6 +-
 drivers/nvme/host/pci-dmabuf.c                     |    6 +-
 drivers/usb/gadget/function/f_fs.c                 |    4 +-
 drivers/xen/gntdev-dmabuf.c                        |    8 +-
 include/drm/display/drm_dp.h                       |    2 +-
 include/drm/drm_atomic.h                           |    2 +
 include/drm/drm_bridge.h                           |    2 +
 include/drm/drm_connector.h                        |   76 +-
 include/drm/drm_exec.h                             |    2 +-
 include/drm/drm_modeset_helper_vtables.h           |    4 +-
 include/drm/drm_panel.h                            |   36 -
 include/drm/drm_ras.h                              |   98 ++
 include/drm/drm_writeback.h                        |   98 +-
 include/linux/dma-buf.h                            |   26 +-
 include/linux/dma-fence.h                          |   26 -
 include/linux/sysfb.h                              |   25 -
 include/uapi/drm/drm_ras.h                         |   29 +-
 include/uapi/drm/qaic_accel.h                      |   28 +
 io_uring/zcrx.c                                    |    6 +-
 net/core/devmem.c                                  |    8 +-
 252 files changed, 4737 insertions(+), 2646 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/allwinner,sun50i-h616-de33-planes.yaml
 create mode 100644 drivers/accel/qaic/qaic_telemetry.c
 create mode 100644 drivers/accel/qaic/qaic_telemetry.h
 delete mode 100644 drivers/firmware/sysfb_simplefb.c
 delete mode 100644 drivers/gpu/drm/imagination/pvr_fw_meta.h
 rename drivers/gpu/drm/imagination/{pvr_rogue_meta.h => pvr_fw_meta_internal.h} (69%)
 create mode 100644 drivers/gpu/drm/imagination/pvr_fw_riscv_internal.h
 rename drivers/gpu/drm/imagination/{pvr_rogue_heap_config.h => pvr_heap_config.h} (85%)
 delete mode 100644 drivers/gpu/drm/imagination/pvr_rogue_riscv.h
 create mode 100644 drivers/gpu/drm/sun4i/sun50i_planes.c
 create mode 100644 drivers/gpu/drm/sun4i/sun50i_planes.h
 create mode 100644 drivers/gpu/drm/vkms/scripts/color-curve-lut.py
