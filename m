Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEFA107BCE2
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 20:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 581B810E474;
	Fri, 13 Mar 2026 20:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MEj/gm3R";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E26010E474
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 20:57:03 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-899a9f445cbso35643746d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773435421; cv=none;
 d=google.com; s=arc-20240605;
 b=YlzS4aQNfaSoeP03WIIxzpnIUq/ndUsDhHO5OcLqzRTf8fveAC4EnZbeHESvHn4Hfq
 8F0hiPllbgrRWOSo/cnZW2pwk0iZY9Nq69HLqinnMoDRHN+KCEhC7gIjfJcfLIpjR4B8
 kByEtuA8aDd3cOy2QUu5sMhiWslWd1s3gXBKOm5BywEVscPYH1wxzZIcSUpKyIvoyTbS
 d0YjLUSPJ3hsDmqNQBx1eFeH2dVK68PTwaIihxSl3Dk2XNvJt3KgGVMe+/uNsV4NOfB6
 wGq71cxNn4MSNuUK5qyRIhPhiRqEr6HW/rFZShWAQBiB/kY2XZFE9ha2dMb1X9HMIwU5
 HMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=ELgkiztwOyhfOX/SY/z8y+qIK2kL8znxaXjPXbi+pqk=;
 fh=A08XZwmmb57jzirbgTkluPSvjDeiJMkkojF1n6qDmTk=;
 b=lDF1ZMNejsswx1O2OSvJO5YYcWlQhS0h0tbX2p2eoWaY655lBj82fXIsW0daGfAki2
 r8WVsaKA1A6/x2avO4Ymhe2n7WZqL/e6ojL0lCVg7zwKjcrWUJWToFc0QFoXkJei5E9G
 oDi/3K/Fx1IsWXgk9yU0L40wi6FujP8QaM+GMgkw0aLAgkAwfbnYm46rNNbVvp2P0M87
 6D/XR27feAKf9l/1HXuWdqaf35wUTbWln5WeAH/fn2hj3ERsYJ+a+JxxT4JHHXIo5RIq
 l0XerkJJe4n2NrD1Xpyy90a+CiE7QKb+X9OoHjbQGY6FOF3+Bxt+f4u5nddmhg4DTQda
 sB+g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773435421; x=1774040221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ELgkiztwOyhfOX/SY/z8y+qIK2kL8znxaXjPXbi+pqk=;
 b=MEj/gm3RwVrywk1Z1JwF4ujsnI+/aqLui5Vdghcn9MllTlXIX1SYgoaLIkvrd5k8YQ
 KwFajnVer23tFV2udhc+cGcXwCmdNhePEigct13DDPpIi0eVCDN5JwRcJgSxnRvvo6Y0
 UxmdeHtY+7cqPWVURtI/DiTuabU1iOZY38wrS1IrMJx6RE9wpZ9mGWlhER5JP7WU/xuM
 PwSSg0PeqEb4pBiDN6ho1oqMW4Sj/kQvEUh+XhIkw+9rTMpqzmk3qhrxRx3hzgfXf7K9
 14uK+BzTaR1Ddr2PuItd0aM2LTetx2l9ZAaf8Qcusi3Zo3Lq9hhrf6sefdajf4PhTnmZ
 qO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435421; x=1774040221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELgkiztwOyhfOX/SY/z8y+qIK2kL8znxaXjPXbi+pqk=;
 b=rbJp4Oyji42POZy6s8AYK6bd+uIzDYfujrwZSPAx9ddEeQmdT95U/Rcj4HnWekBFX6
 deR/WZStRfV2ieGKAGRzUcrRSCrEwYUwk5h0UJ1/cwAqyZP1C4sB6SAxfg4oLCkk4cos
 soFt7OnA5YT0vkK10vIMHcm2sHRuD3GhHXS+hyN/0bBUtOVH0NinNhEBh87gSxI/tR7R
 eocXDyRp8uZsR1/c5sqg5Wd+hNVwxszQlLCT9sE54A5Q9GicgtmDiLOdbQzFEpquPZLc
 dnR94cm0FHXmRKcJhew0lnIgoI2r+XyD+HelVXUzC8Cj7yvWIa8prCAoK/dL5mk0cQhH
 rkcw==
X-Gm-Message-State: AOJu0YzkhJLW2gRpApaVG7Xmw0sT0ytGGgVGA87P9kKghd7XAWVj03b1
 XrjpZFUmnquhKJMcDv0h8IO9Rn/iu+0oNCeIby/mgHgPcL5NgledIxxRBqxh4Sjs2akC6NClWuy
 N7SnDKhPEBtO292YAtpuhOm/x0gii3vA=
X-Gm-Gg: ATEYQzzjKzawOd+w4NuAnyw8yY3DlL1NJmKOJN5JG+HP/nIMFztUJfoujSiQetOWl6c
 RH5EzwGOW3eOjD6LpLPf8kJwBZRh3G+Y6G3QTxPk6D9IwF1gabTcoZ7F4ngJFulSHuG585etZRB
 kJWNbuyHCFsEgP0fEAv6TJgputO2KxXOZGgA2Jl3vsmNX4W+TIGvuXcIFc3BSp48Hl47UlqVTSG
 cqnN6b9nGEUTryHmivthne4eTvqtOOstBrR2fd3xxEFzLg3QgCBTBIkK/Xf2eeHJx2cIsqCXqxA
 mLQz8Z9Pxe/S1lkgsLfhVGYY1Wpaz28eIrvnHJ9rXI6Mr+MrthJT6iF3YEkpElUAEIs=
X-Received: by 2002:a05:6214:2aa4:b0:89a:2fe7:91d1 with SMTP id
 6a1803df08f44-89a81d20cdamr75635586d6.6.1773435421355; Fri, 13 Mar 2026
 13:57:01 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 14 Mar 2026 06:56:50 +1000
X-Gm-Features: AaiRm51jU8JCawik2JOJhbanCumMJDZueTE65G43u-xiLPITmwQ5JqXkbN8WiTA
Message-ID: <CAPM=9tyoZ7v9_Ki2wzYGryWDzTfnbMy6YE-1XBmRxcRCA-FonQ@mail.gmail.com>
Subject: [git pull] drm fixes for 7.0-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Linus,

The weekly drm fixes. This is mostly msm fixes across the functions,
with amdgpu and i915. It also has a core rust fix and changes in
nova-core to take advantage of it, and otherwise just has some minor
driver fixes, and marks loongsoon as orphaned.

Let me know if there are any issues,

Regards,
Dave.

drm-fixes-2026-03-14:
drm-fixes for 7.0-rc4

rust:
- Fix safety issue in dma_read! and dma_write!.

nova-core:
- Fix UB in DmaGspMem pointer accessors.
- Fix stack overflow in GSP memory allocation.

loongsoon:
- mark drm driver as unmaintained

msm:
- Core:
  - Adjusted msm_iommu_pagetable_prealloc_allocate() allocation type
- DPU:
  - Fixed blue screens on Hamoa laptops by reverting the LM reservation
  - Fixed the size of the LM block on several platforms
  - Dropped usage of %pK (again)
  - Fixed smatch warning on SSPP v13+ code
  - Fixed INTF_6 interrupts on Lemans
- DSI:
  - Fixed DSI PHY revision on Kaanapali
  - Fixed pixel clock calculation for the bonded DSI mode panels with
    compression enabled
- DT bindings:
  - Fixed DisplayPort description on Glymur
  - Fixed model name in SM8750 MDSS schema
- GPU:
  - Added MODULE_DEVICE_TABLE to the GPU driver
  - Fix bogus protect error on X2-85
  - Fix dma_free_attrs() buffer size
  - Gen8 UBWC fix for Glymur

i915:
- Avoid hang when configuring VRR [icl]
- Fix sg_table overflow with >4GB folios
- Fix PSR Selective Update handling
- Fix eDP ALPM read-out sequence

amdgpu:
- SMU13 fix
- SMU14 fix
- Fixes for bringup hw testing
- Kerneldoc fix
- GC12 idle power fix for compute workloads
- DCCG fixes

amdkfd:
- Fix missing BO unreserve in an error path

ivpu:
- drop unnecessary bootparams register setting

amdxdna:
- fix runtime/suspend resume deadlock

bridge:
- ti-sn65dsi83: fix DSI rounding and dual LVDS

gud:
- fix NULL crtc dereference on display disable
The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681=
:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-03-14

for you to fetch changes up to b28913e897edfeedc4e33b03b28068b27d002e6c:

  Merge tag 'drm-rust-fixes-2026-03-12' of
https://gitlab.freedesktop.org/drm/rust/kernel into drm-fixes
(2026-03-13 10:40:17 +1000)

----------------------------------------------------------------
drm-fixes for 7.0-rc4

rust:
- Fix safety issue in dma_read! and dma_write!.

nova-core:
- Fix UB in DmaGspMem pointer accessors.
- Fix stack overflow in GSP memory allocation.

loongsoon:
- mark drm driver as unmaintained

msm:
- Core:
  - Adjusted msm_iommu_pagetable_prealloc_allocate() allocation type
- DPU:
  - Fixed blue screens on Hamoa laptops by reverting the LM reservation
  - Fixed the size of the LM block on several platforms
  - Dropped usage of %pK (again)
  - Fixed smatch warning on SSPP v13+ code
  - Fixed INTF_6 interrupts on Lemans
- DSI:
  - Fixed DSI PHY revision on Kaanapali
  - Fixed pixel clock calculation for the bonded DSI mode panels with
    compression enabled
- DT bindings:
  - Fixed DisplayPort description on Glymur
  - Fixed model name in SM8750 MDSS schema
- GPU:
  - Added MODULE_DEVICE_TABLE to the GPU driver
  - Fix bogus protect error on X2-85
  - Fix dma_free_attrs() buffer size
  - Gen8 UBWC fix for Glymur

i915:
- Avoid hang when configuring VRR [icl]
- Fix sg_table overflow with >4GB folios
- Fix PSR Selective Update handling
- Fix eDP ALPM read-out sequence

amdgpu:
- SMU13 fix
- SMU14 fix
- Fixes for bringup hw testing
- Kerneldoc fix
- GC12 idle power fix for compute workloads
- DCCG fixes

amdkfd:
- Fix missing BO unreserve in an error path

ivpu:
- drop unnecessary bootparams register setting

amdxdna:
- fix runtime/suspend resume deadlock

bridge:
- ti-sn65dsi83: fix DSI rounding and dual LVDS

gud:
- fix NULL crtc dereference on display disable

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: display: msm: Fix reg ranges and clocks on Glymur

Abhinav Kumar (1):
      drm/msm/dpu: Correct the SA8775P intr_underrun/intr_underrun index

Akhil P Oommen (3):
      drm/msm/adreno: Add GPU to MODULE_DEVICE_TABLE
      drm/msm/a6xx: Fix the bogus protect error on X2-85
      drm/msm/a8xx: Fix ubwc config related to swizzling

Andrzej Kacprowski (1):
      accel/ivpu: Remove boot params address setting via MMIO register

Arun R Murthy (1):
      drm/i915/dp: Read ALPM caps after DPCD init

Cristian Ciocaltea (1):
      drm/amdgpu: Fix kernel-doc comments for some LUT properties

Danilo Krummrich (1):
      gpu: nova-core: gsp: fix UB in DmaGspMem pointer accessors

Dave Airlie (5):
      Merge tag 'drm-msm-fixes-2026-03-06' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'drm-misc-fixes-2026-03-12' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2026-03-12' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.0-2026-03-12' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-rust-fixes-2026-03-12' of
https://gitlab.freedesktop.org/drm/rust/kernel into drm-fixes

David Lechner (1):
      drm/sitronix/st7586: fix bad pixel data due to byte swap

Dmitry Baryshkov (1):
      Revert "drm/msm/dpu: try reserving the DSPP-less LM first"

Gary Guo (3):
      rust: ptr: add `KnownSize` trait to support DST size info extraction
      rust: ptr: add projection infrastructure
      rust: dma: use pointer projection infra for `dma_{read,write}` macro

Ivan Lipski (2):
      drm/amd/display: Add missing DCCG register entries for DCN20-DCN316
      drm/amd/display: Check for S0i3 to be done before DCCG init on DCN21

Janusz Krzysztofik (1):
      drm/i915: Fix potential overflow of shmem scatterlist length

Jouni H=C3=B6gander (4):
      drm/i915/psr: Repeat Selective Update area alignment
      drm/i915/dsc: Add Selective Update register definitions
      drm/i915/dsc: Add helper for writing DSC Selective Update ET paramete=
rs
      drm/i915/psr: Write DSC parameters on Selective Update in ET mode

Kees Cook (1):
      drm/msm: Adjust msm_iommu_pagetable_prealloc_allocate() allocation ty=
pe

Konrad Dybcio (1):
      drm/msm/dpu: Fix LM size on a number of platforms

Krzysztof Kozlowski (1):
      dt-bindings: display/msm: qcom,sm8750-mdss: Fix model typo

Lizhi Hou (1):
      accel/amdxdna: Fix runtime suspend deadlock when there is pending job

Luca Ceresoli (2):
      drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE rounding
      drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output

Mario Limonciello (3):
      drm/amd: Fix NULL pointer dereference in device cleanup
      drm/amd: Fix a few more NULL pointer dereference in device cleanup
      drm/amd: Set num IP blocks to 0 if discovery fails

Pengyu Luo (3):
      drm/msm/dsi: fix hdisplay calculation when programming dsi registers
      drm/msm/dsi/phy: fix hardware revision
      drm/msm/dsi: fix pclk rate calculation for bonded dsi

Philip Yang (1):
      drm/amdkfd: Unreserve bo if queue update failed

Shenghao Yang (1):
      drm/gud: fix NULL crtc dereference on display disable

Thomas Fourier (1):
      drm/msm: Fix dma_free_attrs() buffer size

Thomas Wei=C3=9Fschuh (1):
      drm/msm/dpu: Don't use %pK through printk (again)

Thomas Zimmermann (1):
      drm/loongson: Mark driver as orphaned

Tim Kovalenko (1):
      gpu: nova-core: fix stack overflow in GSP memory allocation

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915/vrr: Configure VRR timings after enabling TRANS_DDI_FUNC_CTL

Yang Wang (3):
      drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu=
 v13
      drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu=
 v14
      drm/amdgpu: fix gpu idle power consumption issue for gfx v12

sunliming (1):
      drm/msm/dpu: Fix smatch warnings about variable dereferenced before c=
heck

 .../bindings/display/msm/dp-controller.yaml        |  21 +-
 .../bindings/display/msm/qcom,glymur-mdss.yaml     |  16 +-
 .../bindings/display/msm/qcom,sm8750-mdss.yaml     |   2 +-
 MAINTAINERS                                        |   3 +-
 drivers/accel/amdxdna/aie2_ctx.c                   |  14 +-
 drivers/accel/amdxdna/amdxdna_ctx.c                |  10 +
 drivers/accel/ivpu/ivpu_hw_40xx_reg.h              |   6 -
 drivers/accel/ivpu/ivpu_hw_ip.c                    |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |  16 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   5 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   1 +
 .../gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h |   6 +-
 .../gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c |  21 +-
 .../drm/amd/display/dc/dccg/dcn301/dcn301_dccg.h   |   8 +-
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h |   5 +-
 .../drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h   |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |   3 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |  13 +-
 drivers/gpu/drm/gud/gud_drv.c                      |   9 +-
 drivers/gpu/drm/gud/gud_internal.h                 |   4 +
 drivers/gpu/drm/gud/gud_pipe.c                     |  54 ++--
 drivers/gpu/drm/i915/display/intel_alpm.c          |   6 -
 drivers/gpu/drm/i915/display/intel_display.c       |   1 -
 drivers/gpu/drm/i915/display/intel_dp.c            |   7 +
 drivers/gpu/drm/i915/display/intel_psr.c           |  60 +++-
 drivers/gpu/drm/i915/display/intel_vdsc.c          |  23 ++
 drivers/gpu/drm/i915/display/intel_vdsc.h          |   3 +
 drivers/gpu/drm/i915/display/intel_vdsc_regs.h     |  12 +
 drivers/gpu/drm/i915/display/intel_vrr.c           |  14 +
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |  12 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpummu.c           |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |   3 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |  14 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   1 +
 .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  12 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  12 +-
 .../drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h    |   4 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  12 +-
 .../drm/msm/disp/dpu1/catalog/dpu_9_1_sar2130p.h   |  12 +-
 .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c        |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp_v13.c    |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  52 +---
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  43 ++-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |  22 +-
 drivers/gpu/drm/sitronix/st7586.c                  |  15 +-
 drivers/gpu/nova-core/gsp.rs                       |  46 ++--
 drivers/gpu/nova-core/gsp/boot.rs                  |   2 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |  93 +++----
 drivers/gpu/nova-core/gsp/fw.rs                    | 101 ++++---
 rust/kernel/dma.rs                                 | 114 ++++----
 rust/kernel/lib.rs                                 |   4 +
 rust/kernel/ptr.rs                                 |  30 +-
 rust/kernel/ptr/projection.rs                      | 305 +++++++++++++++++=
++++
 samples/rust/rust_dma.rs                           |  30 +-
 scripts/Makefile.build                             |   4 +-
 60 files changed, 935 insertions(+), 399 deletions(-)
 create mode 100644 rust/kernel/ptr/projection.rs
