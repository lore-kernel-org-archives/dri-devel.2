Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C9606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.a=rsa-sha256 header.s=default header.b=f4v6DKIt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BBD112439;
	Thu,  5 Nov 2026 13:31:51 +0000 (UTC)
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3AE10E1C0;
 Thu,  5 Nov 2026 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1793885503;
 bh=jh470o6OGMsJYgzj8WsJs2IvRu8KjnGphItsS0jYveM=;
 h=Date:From:To:Cc:Subject:From;
 b=f4v6DKItKsz1sQVxUNWXu6nx900TWnvlBF3swfSCeXqlShDg2BrfOiXNZOu4fFwcE
 Rdz0Xh3e/aab4L8g4y9OODm2yrWPghS6gJjkWIBJcC1Kbd/iNjghUbwdcfonrdHWnj
 FQMkd0Pz7ITY1SSa0DPyia/AwWpa3s2yH2q3QilKTHmffWvB/zJJbLMywClgK5bsYy
 mrIDlYEBI6Ezzd4p3LlaT8SdgSfk+h4NBbX3GkUmWUOjcJdV7T13L2eiBFLYUKjNXO
 3z25hltI80YUaIC90BfvRMBT7Bt3RkaAS4B8GOO/mlMmtf1VxSzysmcMNLk1/57DCf
 /MMZjzLQl+RoQ==
Message-ID: <79a8e2a2-e693-4437-9a7e-0c2ff69beeec@lankhorst.se>
Date: Thu, 5 Nov 2026 14:31:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Maarten Lankhorst <dev@lankhorst.se>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Sima,

Here's the third pull request for v7.5. It includes the contens of the previous 2 pull requests.

Kind regards,
~Maarten

drm-misc-next-2026-11-05:
drm-misc-next for v7.5:

Cross-subsystem Changes:
- dma-buf: explicitly forbid exposing pages from get_user_pages()

Core Changes:
- Convert more drivers and helpers to use atomic create state.
- Remove mention of some deprecated functions in docs.

Driver Changes:
- Assorted bugfixes to etnaviv, imx, panel/st7703, drm/panel, accel/rocket,
  imagination, accel/amdxdna, bridge/fsl-ldb, accel/ivpu.
- Use the multi version of mipi dsi calls in some panel drivers.
- Convert some panels to use managed helpers.
- Add support for DCLTek 300249 5.5", DLCTek 300248 10.5", Novetake NT37705,
  xiaomi-lavender, Tianma TL063FVMC43-02, Tianma TL063FVMCA01-00, Tianma
  TL060FVXS16-00, TXD TXDI600YANPA-43V3, AUO B101UAN01, Truly NT36850 WQHD,
  Novatek NT36850, Samsung AMS644VK04, Hitachi TX10D07VM0BAA, LG LH400WV3-SD04,
  Mingjun MJ070BI30IA2 panels.
- Add support for RK3568 to rockchip driver.
The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-11-05

for you to fetch changes up to 8258a37702b9b9cf27f5c0ea07625e3e6bd74f5a:

  dma-buf: explicitly forbid exposing pages from get_user_pages() (2026-11-05 10:11:53 +0100)

----------------------------------------------------------------
drm-misc-next for v7.5:

Cross-subsystem Changes:
- dma-buf: explicitly forbid exposing pages from get_user_pages()

Core Changes:
- Convert more drivers and helpers to use atomic create state.
- Remove mention of some deprecated functions in docs.

Driver Changes:
- Assorted bugfixes to etnaviv, imx, panel/st7703, drm/panel, accel/rocket,
  imagination, accel/amdxdna, bridge/fsl-ldb, accel/ivpu.
- Use the multi version of mipi dsi calls in some panel drivers.
- Convert some panels to use managed helpers.
- Add support for DCLTek 300249 5.5", DLCTek 300248 10.5", Novetake NT37705,
  xiaomi-lavender, Tianma TL063FVMC43-02, Tianma TL063FVMCA01-00, Tianma
  TL060FVXS16-00, TXD TXDI600YANPA-43V3, AUO B101UAN01, Truly NT36850 WQHD,
  Novatek NT36850, Samsung AMS644VK04, Hitachi TX10D07VM0BAA, LG LH400WV3-SD04,
  Mingjun MJ070BI30IA2 panels.
- Add support for RK3568 to rockchip driver.

----------------------------------------------------------------
Abhai Kollara (1):
      accel/rocket: use dev_err_probe() for MMIO mapping errors

Akash Sukhavasi (4):
      drm/panel: leadtek-ltk500hd1829: Use mipi_dsi_*_multi()
      drm/panel: kingdisplay-kd097d04: Use mipi_dsi_*_multi(); fix minor bugs
      drm/panel: innolux-p079zca: Use mipi_dsi_*_multi(); fix minor bugs
      drm/panel: newvision-nv3051d: Use mipi_dsi_*_multi(); fix minor bugs

Alessio Belle (4):
      drm/imagination: Improve logging of unknown freelist IDs
      drm/imagination: Remove wrong soft reset code from GPU start sequence
      drm/imagination: Add utility function to write and read back register
      drm/imagination: Check virtual address space size only once

Alexey Minnekhanov (9):
      dt-bindings: vendor-prefixes: Add Shenzhen TXD Technology Co., Ltd.
      dt-bindings: vendor-prefixes: Add Shen Chao Optoelectronics
      dt-bindings: display: novatek,nt36672a: Add 5 new panels
      drm/panel: novatek-nt36672a: Set driver name to novatek for consistency
      drm/panel: novatek-nt36672a: Combine two init callbacks into one
      drm/panel: novatek-nt36672a: Add 3 panels used in Xiaomi phones
      drm/panel: novatek-nt36672a: Add Tianma panel for Xiaomi Mi A2
      drm/panel: novatek-nt36672a: Add panel for Asus Zenfone Max Pro M1
      MAINTAINERS: Add Alexey Minnekhanov as maintainer for NT36672A panel

Alice Ryhl (1):
      drm/gpuvm: skip setting kernel_alloc_node range on overflow

Andrzej Kacprowski (2):
      accel/ivpu: Read preemption buffer size from boot params
      accel/ivpu: Replace profiling frequency debugfs with test mode bit

Aryan Sinha (1):
      accel: ethosu: Fix kernel-doc for ethosu_gem_cmdstream_create()

Asif Ikbal (2):
      dt-bindings: panel-simple-dsi: Add AUO B101UAN01
      drm/panel: simple: Add AUO B101UAN01 panel

Christian König (1):
      dma-buf: explicitly forbid exposing pages from get_user_pages()

Damon Ding (3):
      dt-bindings: display: rockchip: analogix-dp: Add support for RK3568
      drm/bridge: analogix_dp: Add support for RK3568
      drm/rockchip: analogix_dp: Add support for RK3568

Daniel Stone (2):
      drm/panthor: Add neural-engine presence and power bits for v14+
      drm/panthor: Delegate neural power domain to CSF when present

Dario Binacchi (1):
      drm/bridge: fsl-ldb: return -EPROBE_DEFER if the panel bridge is not found

David Lechner (2):
      dt-bindings: display: panel: himax,hx8279: add vddp-supply
      drm/panel: himax-hx8279: add the VDDP supply

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

Dmitry Baryshkov (2):
      dt-bindings: display: panel: add Truly NT36850 WQHD panel
      drm/panel: add Novatek NT36850 panel driver

Gyeyoung Baek (1):
      drm/imagination: Update sgt_offset kerneldoc in pvr_mmu_op_context

Haoming Gao (3):
      accel/rocket: Validate BO handle counts on job submission
      accel/rocket: Collect job dependencies before arming
      accel/rocket: Propagate job submission errors

Hsieh Hung-En (5):
      drm/panel: feiyang-fy07024di26a30d: Fix prepare error cleanup
      drm/panel: raydium-rm68200: Fix prepare error cleanup
      drm/panel: feiyang-fy07024di26a30d: Use mipi_dsi_*_multi() functions
      drm/panel: raydium-rm68200: Use mipi_dsi_*_multi() functions
      drm/panel: raydium-rm68200: Use lowercase hex literals

Icenowy Zheng (2):
      dt-bindings: vendor-prefixes: add Shenzhen Mingjun Optoelectronics
      dt-bindings: ili9881c: add compatible string for Mingjun MJ070BI30IA2

Ishu Brar (2):
      dt-bindings: display: panel: Add Samsung AMS644VK04
      drm/panel: Add Samsung AMS644VK04 panel driver

Karl Mehltretter (1):
      udmabuf: respect the device's maximum segment size

Karol Wachowski (1):
      accel/ivpu: Limit SSIDs to 128 on all generations

Lizhi Hou (2):
      accel/amdxdna: Serialize HMM range faults on one umap
      accel/amdxdna: Remap BO pages instead of using vm_insert_pages

Luca Ceresoli (4):
      drm/bridge: stop mentioning deprecated devm_drm_of_get_bridge() in docs
      drm/panel: stop mentioning deprecated devm_drm_of_get_bridge() in docs
      drm/drv: stop mentioning deprecated drm_of_find_panel_or_bridge() in docs
      drm/imx/lcdc: fix inconsistent indenting

Luca Weiss (2):
      dt-bindings: display: panel: Add Novatek NT37705
      drm/panel: Add driver for Novatek NT37705 panel

Luke Macken (1):
      drm/panel-edp: Add BOE NE140WUM-N41 (0x0d9b) panel

Marc-Olivier Champagne (6):
      dt-bindings: display: panel: add compatible for DCLTek 300249 5.5in panel
      drm/panel: ilitek-ili9881c: Add DCLTek 300249 5.5in display
      drm/panel: st7703: set prepare_prev_first
      drm/panel: st7703: move init commands to prepare()
      dt-bindings: display: panel: add compatible for DCLTek 300248 10.25in panel
      drm/panel: st7703: Add DCLTek 300248 10.25in display

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

Maxime Ripard (30):
      drm/vmwgfx: Convert to atomic_create_state
      drm/amdgpu: dm: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: sii902x: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: simple-bridge: Switch to drm_atomic_helper_connector_create_state
      drm/msm: dpu1: Switch to drm_atomic_helper_connector_create_state
      drm/stm: Switch to drm_atomic_helper_connector_create_state
      drm/rcar-du: Convert to atomic_create_state
      drm/ci: Add CI pipeline for drm-misc branches
      drm/hdmi: Change __drm_atomic_helper_connector_hdmi_state_init parameter order
      drm/atomic-state-helper: Rename connector_tv_margins_reset to state_init
      drm/atomic-state-helper: Rename connector_tv_reset to state_init
      drm/panel: Add atomic_create_state support
      drm/aspeed: Switch to drm_atomic_helper_connector_create_state
      drm/ast: Switch to drm_atomic_helper_connector_create_state
      drm/hisilicon: hibmc: Switch to drm_atomic_helper_connector_create_state
      drm/logicvc: Switch to drm_atomic_helper_connector_create_state
      drm/mgag200: Switch to drm_atomic_helper_connector_create_state
      drm/qxl: Switch to drm_atomic_helper_connector_create_state
      drm/sitronix: st7920: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: bochs: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: cirrus: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: gm12u320: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: pixpaper: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: repaper: Switch to drm_atomic_helper_connector_create_state
      drm/udl: Switch to drm_atomic_helper_connector_create_state
      drm/vboxvideo: Switch to drm_atomic_helper_connector_create_state
      drm/gud: Convert to atomic_create_state
      drm/vc4: hdmi: Convert to atomic_create_state
      drm/vc4: vec: Convert to atomic_create_state
      drm/ast: Convert to atomic_create_state

Maíra Canal (4):
      drm/panthor: Replace panthor_mmu_as_fault_mask() with a macro
      drm/v3d: Validate the v71 fields of the TFU submit ioctl
      drm/v3d: Only program TFU coefficients when used on V3D 7.x
      drm/v3d: Add TFU constant colour support for V3D 7.x

Osama Abdelkader (3):
      drm/panel: Use devm_mipi_dsi_attach in BOE panels
      drm/panel: Use managed helpers in Novatek and Raydium panels
      drm/panel: Use managed helpers in assorted panels

Philipp Stanner (2):
      drm/etnaviv: etnaviv_fence: Put base class first
      drm/etnaviv: Remove deprecated fence_ops->release()

Primoz Fiser (1):
      dt-bindings: display: panel-simple: Allow "data-mapping" for "auo,g104sn02"

Raag Jadav (1):
      drm: Log recovery method with wedged event

Rob Herring (Arm) (1):
      drm/bridge: sii902x: Read "sil,i2s-data-lanes" as u32

Rosen Penev (1):
      drm/imagination: simplify pvr_fw_trace_seq_data

Ryan Zhang (1):
      drm/panthor: dummy read to discard the stale first GPU_TIMESTAMP read

Svyatoslav Ryhel (3):
      dt-bindings: display: panel: Document Hitachi TX10D07VM0BAA and LG LH400WV3 panels
      drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI Type B panel driver
      drm/panel: Add LG LH400WV3-SD04 MIPI DBI Type B panel driver

Terry Hsiao (1):
      drm/panel-edp: Add BOE NV116WH2-M32 V8.0, PNB601LS1-3 HW:1.2

Thomas Zimmermann (8):
      drm/hyperv: Add missing include statements
      drm/kms-helper: Remove struct drm_simple_display_pipe and helpers
      drm/bridge: Do not include <drm/drm_simple_kms_helper.h>
      drm/hisilicon/hibmc: Do not include <drm/drm_simple_kms_helper.h>
      drm/tegra: Do not include <drm/drm_simple_kms_helper.h>
      drm/verisilicon: Do not include <drm/drm_simple_kms_helper.h>
      drm/vc4: Do not include <drm/drm_simple_kms_helper.h>
      Merge drm/drm-next into drm-misc-next

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

Triet Hoang (2):
      accel/rocket: Check allocations before use
      drm/rocket: Keep scheduler allocation in rocket_file_priv

 Documentation/accel/amdxdna/amdnpu.rst             |    2 +-
 .../bindings/display/panel/himax,hx8279.yaml       |   13 +
 .../bindings/display/panel/hit,tx10d07vm0baa.yaml  |   58 +
 .../bindings/display/panel/ilitek,ili9881c.yaml    |    2 +
 .../bindings/display/panel/novatek,nt36672a.yaml   |    9 +-
 .../bindings/display/panel/novatek,nt37705.yaml    |   71 ++
 .../bindings/display/panel/panel-simple-dsi.yaml   |    2 +
 .../bindings/display/panel/panel-simple.yaml       |    1 +
 .../display/panel/rocktech,jh057n00900.yaml        |    2 +
 .../bindings/display/panel/samsung,ams644vk04.yaml |   76 ++
 .../display/panel/truly,wqhd60-nt36850.yaml        |   98 ++
 .../display/rockchip/rockchip,analogix-dp.yaml     |   28 +-
 .../bindings/display/ti/ti,am625-oldi.yaml         |    3 +
 .../bindings/display/ti/ti,am62l-dss.yaml          |  136 +++
 .../bindings/display/ti/ti,am65x-dss.yaml          |  149 +--
 .../devicetree/bindings/vendor-prefixes.yaml       |    6 +
 Documentation/gpu/drm-mm.rst                       |    6 +
 Documentation/gpu/todo.rst                         |   17 -
 MAINTAINERS                                        |    8 +
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
 drivers/accel/amdxdna/amdxdna_gem.c                |  246 +++--
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
 drivers/dma-buf/dma-buf.c                          |    8 +
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
 drivers/gpu/drm/aspeed/aspeed_gfx_out.c            |    2 +-
 drivers/gpu/drm/ast/ast_dp.c                       |   18 +-
 drivers/gpu/drm/ast/ast_dp501.c                    |    2 +-
 drivers/gpu/drm/ast/ast_sil164.c                   |    2 +-
 drivers/gpu/drm/ast/ast_vga.c                      |    2 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    1 +
 drivers/gpu/drm/bridge/fsl-ldb.c                   |    2 +-
 drivers/gpu/drm/bridge/inno-hdmi.c                 |    1 -
 drivers/gpu/drm/bridge/microchip-lvds.c            |    1 -
 drivers/gpu/drm/bridge/sii902x.c                   |   22 +-
 drivers/gpu/drm/bridge/simple-bridge.c             |    2 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |    1 -
 drivers/gpu/drm/bridge/tda998x_drv.c               |    1 -
 drivers/gpu/drm/ci/drm-misc-ci.yml                 |  147 +++
 drivers/gpu/drm/display/drm_bridge_connector.c     |    4 +-
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |    6 +-
 drivers/gpu/drm/drm_atomic_state_helper.c          |   24 +-
 drivers/gpu/drm/drm_bridge.c                       |    5 +-
 drivers/gpu/drm/drm_drv.c                          |   12 +-
 drivers/gpu/drm/drm_gem_atomic_helper.c            |   92 --
 drivers/gpu/drm/drm_gpuvm.c                        |  518 ++++++++-
 drivers/gpu/drm/drm_panel.c                        |   17 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |  328 ------
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   10 +-
 drivers/gpu/drm/gud/gud_connector.c                |   20 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c     |    3 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |    3 +-
 drivers/gpu/drm/hyperv/hyperv_drm.h                |    5 +
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c            |    1 -
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c          |    1 -
 drivers/gpu/drm/imagination/pvr_device.c           |   43 +-
 drivers/gpu/drm/imagination/pvr_device.h           |   28 +
 drivers/gpu/drm/imagination/pvr_free_list.c        |   12 +-
 drivers/gpu/drm/imagination/pvr_fw_meta.c          |    5 +-
 drivers/gpu/drm/imagination/pvr_fw_startstop.c     |   37 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.c         |   25 +-
 drivers/gpu/drm/imagination/pvr_mmu.c              |    2 +-
 drivers/gpu/drm/imagination/pvr_mmu.h              |    2 +-
 drivers/gpu/drm/imagination/pvr_vm.c               |   22 +-
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c                |    2 +-
 drivers/gpu/drm/logicvc/logicvc_interface.c        |    2 +-
 drivers/gpu/drm/mgag200/mgag200_vga.c              |    2 +-
 drivers/gpu/drm/mgag200/mgag200_vga_bmc.c          |    2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |    2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |   90 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |   16 +-
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
 drivers/gpu/drm/panel/panel-edp.c                  |    3 +
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
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c     |  598 ++++++++--
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
 drivers/gpu/drm/panel/panel-simple.c               |   32 +
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
 drivers/gpu/drm/qxl/qxl_display.c                  |    2 +-
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    |   16 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |   24 +-
 drivers/gpu/drm/sitronix/st7920.c                  |    2 +-
 drivers/gpu/drm/stm/lvds.c                         |    2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |    3 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |    2 +-
 drivers/gpu/drm/tegra/output.c                     |    1 -
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |    3 +-
 drivers/gpu/drm/tidss/tidss_crtc.c                 |   10 +-
 drivers/gpu/drm/tidss/tidss_crtc.h                 |    4 +-
 drivers/gpu/drm/tidss/tidss_dispc.c                |   28 +-
 drivers/gpu/drm/tidss/tidss_dispc.h                |    5 +-
 drivers/gpu/drm/tidss/tidss_dispc_regs.h           |    1 +
 drivers/gpu/drm/tidss/tidss_drv.c                  |    7 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |   70 +-
 drivers/gpu/drm/tidss/tidss_oldi.c                 |   46 +-
 drivers/gpu/drm/tidss/tidss_oldi.h                 |    1 -
 drivers/gpu/drm/tiny/bochs.c                       |    2 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c                 |    2 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |    2 +-
 drivers/gpu/drm/tiny/pixpaper.c                    |    2 +-
 drivers/gpu/drm/tiny/repaper.c                     |    2 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |    2 +-
 drivers/gpu/drm/v3d/v3d_drv.c                      |    3 +
 drivers/gpu/drm/v3d/v3d_regs.h                     |   19 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |   30 +-
 drivers/gpu/drm/v3d/v3d_submit.c                   |    9 +
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |    2 +-
 drivers/gpu/drm/vc4/vc4_dpi.c                      |    1 -
 drivers/gpu/drm/vc4/vc4_dsi.c                      |    1 -
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   32 +-
 drivers/gpu/drm/vc4/vc4_vec.c                      |   17 +-
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
 include/drm/bridge/analogix_dp.h                   |    2 +
 include/drm/display/drm_hdmi_state_helper.h        |    4 +-
 include/drm/drm_atomic_state_helper.h              |    6 +-
 include/drm/drm_gem_atomic_helper.h                |   28 -
 include/drm/drm_gpuvm.h                            |  139 ++-
 include/drm/drm_simple_kms_helper.h                |   56 +-
 include/uapi/drm/v3d_drm.h                         |    5 +
 235 files changed, 8365 insertions(+), 2748 deletions(-)
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
