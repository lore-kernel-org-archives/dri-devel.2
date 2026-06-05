Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF1BCD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 23:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E26111ABAF;
	Fri,  5 Jun 2026 23:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OkcFsDj6";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AB2A11ABAF
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 23:14:32 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-5174a3d9598so21739051cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 16:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780701271; cv=none;
 d=google.com; s=arc-20240605;
 b=UKwtILZXLdjhTA3qRCp4tFGt7QeApAglfDONkkjoYoVVMg6L3WP7sv5kdMW7yivIsV
 hxvg37+p/gXt1wDIS4haH8rLGHzmaWEEstrxqCdxoeKGWobz2k1heyU+qzltc8Y7mQVp
 eLYgRArZ+EAPBrGFYwYMgIbo0+PP7UbquA8VKDYD2kkOJEoGx1aTHkTemSEcJj0KS9uw
 lKfjHXtU8gDhAa2Lz3sqQdb8xArG6nWhekyg/geI7DXjFIkPWHFPDwV0ogVMYwU/uH2y
 83Pk0Z0+fxWPmVLiQKYkyfwrJXpf++ym8/3x7JWGOgkoJVLO0CliJTNjm8YeVLojV6KB
 Ovrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=foq2FEH+Eb7PlHe5rBt1b8WeStT7dge0Sjdo8JeA+mA=;
 fh=A08XZwmmb57jzirbgTkluPSvjDeiJMkkojF1n6qDmTk=;
 b=B6psOkschlqULNdsRPulQyONeaFVl5H/vn8Mv4UdGw9M8zAr2bDyo3/BmRaH/m4ScI
 /qbIU2Z5V99/PSDQ+dXpaTs5d2g4K3VuHU3v3hoapvUi2kHzUFc5p+E0jjaxYO2xsyXP
 4g/AsvcSeIfJdLHiMJKR+V/QtKtu5uAFXPT8jq5BbxmCsashPWVqDbknwoIjNogDPqML
 rVlUu8zV2pglu+Y1ULN0Hd37+wnPRlWNNGL/9XRquTEqRn+ZHfDoS21jrcBP+H79KAxx
 +JNnXd3392L7xB/AeDEAXt8GRI7GLpDVVK7smeGVPu2ovKhMI9l+r7qf6L7yDfOeN3aW
 Xxaw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780701271; x=1781306071; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=foq2FEH+Eb7PlHe5rBt1b8WeStT7dge0Sjdo8JeA+mA=;
 b=OkcFsDj69DnonO9jxHXKH6eQLUUhK6Jl7nKIx0VeXUDSn6BKtO11/+OMxUqd3xvrbX
 Mq9ntdfAZJDpMWwj1QFCnzUte1ZftXHUxwoXVqN/dVQui+ZN8qCeftorCt0qt+b4/LK0
 /CgiU2mHqo/n2Is5IcsJhaQ90CXOhmMLF7Po6mMWR20YTnx4ajUfpOanmzFRtOvr183y
 DNVOdnoOKNBVHicoFD73myceBGqgPF2hjNpVF03KmHglWHQKvCuCNhMgnrk0C3CPoS+5
 gica9N4Xk/3+p/c8RjBEgbmfehBcndFVKyePMZXu6p45BYUlXw8rcMwTslEC2YdLrkgf
 NzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780701271; x=1781306071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foq2FEH+Eb7PlHe5rBt1b8WeStT7dge0Sjdo8JeA+mA=;
 b=KO17xT9tNGgX8t0F3CRuCAWFKzxETB6Nw/Etd2BwU/GA93ev9BffpQC5kXgW96j7jQ
 PXYq1VjN3CU5G6F7IILXVTxKouxmlYXsdMlAXqSr+94IoiFmvvS4PclQO/FD71qdweQA
 M34prszcHBuyJfd9vMTIKw3D+jsLZFeeYnAPMgUVoKR2eiLFnus2DrCunOMt0gqLusad
 4SyOKLfDDoedrIMfgDQfBrl+6QhA5BGJMMxSmhu2e969B5OltkkeVSiXKOIHyTY7A3Nt
 a1ItXmWgCjHmb0IYNVS6LAe5zR58BqZnOszf3P1COMvWGKx3e1tgbDwaOm0l1MCTeJWf
 484Q==
X-Gm-Message-State: AOJu0YwpljLaIEojYqs7ycqY+iIesiKGSkvxKs9lR8k/xy2KKrDvf2NM
 +NVu/GdBbHwqrEK9M1KHbO0z1+1Gxksx6zOlC4gshXnh3jx7egVvjdFSczVQTCxFhOoUw6/eInQ
 H7YtXWRSQluRUDFDgdhBN5fz+n5t5B2E=
X-Gm-Gg: Acq92OGxluWRWbbjQLy+Ap1MthaO/fDo5PQDh6BiN6+q5os+sOXYn0K2zZZpVDTnupy
 3U0YvnSwgJPQRJsREkdPJ5wyWJjkrQreNvehIqu5GTjcQjbLgyYXIbjsZZVrq1rccDp318kwbn/
 eEecTfOSzsLOHsnUWz9Z7cOpgrxOZBAp1HoPFKizDWvhh2/iCb7Y9dlIorv6nFfRH4FlzgmGcJg
 oz4RLV4pxKt2OUf1o6cQwlT7z/zpSahUPJmn+sSEoXyqebNdxq115B7vkS7KBo45Unnt/LxeVih
 1PExKV3348yC+fq09XmUBU3KdcxxbQ7r6s/SQjBhbaszGh9B5j2Htxk9vn4XMWsfka5pycG+0SD
 Jyw==
X-Received: by 2002:a05:622a:4e85:b0:517:5e32:f3b6 with SMTP id
 d75a77b69052e-51795a24229mr80058051cf.24.1780701271127; Fri, 05 Jun 2026
 16:14:31 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 6 Jun 2026 09:14:18 +1000
X-Gm-Features: AVVi8CeNd-ugie1KquctzYnPF0ncBOvLVbZm_qqcfWuRz8ODPUrfb-BZOFbiuGk
Message-ID: <CAPM=9tx-LsD-MVyNdO4uQ-of16HNt2JsbJYQqRCOMUzzH5bVrg@mail.gmail.com>
Subject: [git pull] drm fixes for 7.2-rc6
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

Weekly drm fixes, not contributing to things settling down
unfortunately, lots of driver fixes for various bounds checks, leaks
and UAF type things, i915/xe probably the most sane, amdgpu has a mix
of fixes all over, then ethosu has lots of small fixes.

The problem of fixing thing in private has really hit us with the
change handle ioctl, and "Sima was right" and we should have disabled
the ioctl, since it was only introduced a couple of kernels ago and
failed to upstream it's tests in time. The patch here fixes the
problems Sima identified, but disables the ioctl as well, with a list
of known problems in it and a request for proper tests to be written
and upstreamed. It's a niche user ioctl designed for CRIU with AMD
ROCm, so I think it's fine to just disable it.

Maybe this week will settle down,
Dave.

drm-fixes-2026-06-06:
drm fixes for 7.2-rc6

core:
- disable the gem change handle ioctl for security reasons
  (plan to fix it on list later with proper test coverage)

dumb-buffer:
- remove strict limits on buffer geometry

amdgpu:
- BT.2020 fix for DCE
- DC bounds checking fixes
- SDMA 7.1 fix
- UserQ fixes
- SI fix
- SMU 13 fixes
- SMU 14 fixes
- GC 12.1 fix
- Userptr fix
- GC 10.1 fix
- GART fix for non-4K pages

amdkfd:
- UAF race fix
- Fix a potential NULL pointer dereference
- GC 11 buffer overflow fix for SDMA

xe:
- Revert removing support for unpublished NVL-S GuC
- Suspend fixes related to multi-queue

i915:
- Fix color blob reference handling in intel_plane_state
- Revert "drm/i915/backlight: Remove try_vesa_interface"

ethosu:
- reject unsupported NPU_OP_RESIZE
- fix index of IFM region
- fix weight index
- fix overflows in DMA-size calculations
- reject DMA commands with uninitialized length
- fix OOB write in ethosu_gem_cmdstream_copy_and_validate

imx:
- fix kernel-doc warnings

ivpu:
- add overflow checks in firmware handling and get_info_ioctl

v3d:
- wait for pending L2T flush before cleaning caches
- fix leak of vaddr
- skip CSD when it has zeroed workgroups
- fix ref counting in performance monitoring
The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8=
:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-06-06

for you to fetch changes up to 1a4f03d22fb655e5f192244fb2c87d8066fcfca2:

  drm/gem: Try to fix change_handle ioctl, attempt 4 (2026-06-06 08:54:55 +=
1000)

----------------------------------------------------------------
drm fixes for 7.2-rc6

core:
- disable the gem change handle ioctl for security reasons
  (plan to fix it on list later with proper test coverage)

dumb-buffer:
- remove strict limits on buffer geometry

amdgpu:
- BT.2020 fix for DCE
- DC bounds checking fixes
- SDMA 7.1 fix
- UserQ fixes
- SI fix
- SMU 13 fixes
- SMU 14 fixes
- GC 12.1 fix
- Userptr fix
- GC 10.1 fix
- GART fix for non-4K pages

amdkfd:
- UAF race fix
- Fix a potential NULL pointer dereference
- GC 11 buffer overflow fix for SDMA

xe:
- Revert removing support for unpublished NVL-S GuC
- Suspend fixes related to multi-queue

i915:
- Fix color blob reference handling in intel_plane_state
- Revert "drm/i915/backlight: Remove try_vesa_interface"

ethosu:
- reject unsupported NPU_OP_RESIZE
- fix index of IFM region
- fix weight index
- fix overflows in DMA-size calculations
- reject DMA commands with uninitialized length
- fix OOB write in ethosu_gem_cmdstream_copy_and_validate

imx:
- fix kernel-doc warnings

ivpu:
- add overflow checks in firmware handling and get_info_ioctl

v3d:
- wait for pending L2T flush before cleaning caches
- fix leak of vaddr
- skip CSD when it has zeroed workgroups
- fix ref counting in performance monitoring

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/sdma7.1: fix support for disable_kq

Alysa Liu (1):
      drm/amdkfd: fix UAF race in destroy_queue_cpsch

Andrew Martin (1):
      drm/amdkfd: Fix buffer overflow in SDMA queue checkpoint/restore on G=
FX11

Andrzej Kacprowski (3):
      accel/ivpu: Add bounds check for firmware runtime memory
      accel/ivpu: Add bounds checks for firmware log indices
      accel/ivpu: Add buffer overflow check in MS get_info_ioctl

Chaitanya Kumar Borah (1):
      drm/i915: Fix color blob reference handling in intel_plane_state

Christian K=C3=B6nig (1):
      drm/amdgpu: fix waiting for all submissions for userptrs

Daniele Ceraolo Spurio (1):
      Revert "drm/xe/nvls: Define GuC firmware for NVL-S"

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-7.1-2026-06-03' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-xe-fixes-2026-06-04' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-06-05' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2026-06-05' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes

Donet Tom (1):
      drm/amdgpu: Fix incorrect VRAM GART mappings on non-4K page size syst=
ems

Harish Kasiviswanathan (2):
      drm/amdgpu: Use asic specific pte_addr_mask
      drm/amdgpu: drm/amdgpu: Set correct DMA mask for gfx12.1

Harry Wentland (7):
      drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval(=
)
      drm/amd/display: Clamp VBIOS HDMI retimer register count to array siz=
e
      drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs
      drm/amd/display: Use krealloc_array() in dal_vector_reserve()
      drm/amd/display: Reject gpio_bitshift >=3D 32 in
bios_parser_get_gpio_pin_info()
      drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
      drm/amd/display: Bound VBIOS record-chain walk loops

Leorize (1):
      drm/amd/display: add missing CSC entries for BT.2020 for DCE IPs

Ma=C3=ADra Canal (4):
      drm/v3d: Wait for pending L2T flush before cleaning caches
      drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups
      drm/v3d: Skip CSD when it has zeroed workgroups
      drm/v3d: Fix global performance monitor reference counting

Muhammad Bilal (7):
      drm/amdkfd: fix NULL dereference in get_queue_ids()
      accel/ethosu: fix IFM region index out-of-bounds in command stream pa=
rser
      accel/ethosu: reject NPU_OP_RESIZE commands from userspace
      accel/ethosu: fix wrong weight index in NPU_SET_SCALE1_LENGTH on U85
      accel/ethosu: fix arithmetic issues in dma_length()
      accel/ethosu: reject DMA commands with uninitialized length
      accel/ethosu: fix OOB write in ethosu_gem_cmdstream_copy_and_validate=
()

Niranjana Vishwanathapura (1):
      drm/xe/multi_queue: skip submit when primary queue is suspended

Prike Liang (2):
      drm/amdgpu: unmap userq for evicting user queue
      drm/amdgpu: improve the userq seq BO free bit lookup

Priya Hosur (1):
      drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in
set_soft_freq_limited_range

Simona Vetter (1):
      drm/gem: Try to fix change_handle ioctl, attempt 4

Sunil Khatri (2):
      drm/amdgpu/userq: remove the vital queue unmap logging
      drm/amdgpu/userq: move wptr_obj cleanup in mqd_destroy

Suraj Kandpal (1):
      Revert "drm/i915/backlight: Remove try_vesa_interface"

Tangudu Tilak Tirumalesh (2):
      Revert "drm/xe: Skip exec queue schedule toggle if queue is idle
during suspend"
      drm/xe: Clear pending_disable before signaling suspend fence

Thomas Zimmermann (1):
      drm/dumb-buffer: Drop buffer-size limits for now

Timur Krist=C3=B3f (2):
      drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on all SI
      drm/amdgpu/gfxhub: Program CRASH_ON_*_FAULT bits to 0 as needed

Vitaly Prosyak (1):
      drm/amdgpu: set noretry=3D1 as default for GFX 10.1.x (Navi10/12/14)

Yang Wang (4):
      drm/amd/pm: apply SMU 13.0.10 workaround during MP1 unload
      drm/amd/pm: fix smu13 power limit default/cap calculation
      drm/amd/pm: mark metrics.energy_accumulator is invalid for smu 14.0.2
      drm/amd/pm: zero unused SMU argument registers

Yicong Hui (1):
      drm/imx: Fix three kernel-doc warnings in dcss-scaler.c

 drivers/accel/ethosu/ethosu_gem.c                  | 35 +++++++---
 drivers/accel/ivpu/ivpu_fw.c                       | 16 +++++
 drivers/accel/ivpu/ivpu_fw_log.c                   |  5 ++
 drivers/accel/ivpu/ivpu_ms.c                       |  7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           | 12 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c          | 11 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 18 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c        | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c          | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c          | 14 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c           | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c           | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c         | 10 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             | 16 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  5 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |  1 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 10 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 49 ++++++++++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  5 ++
 drivers/gpu/drm/amd/display/dc/basics/vector.c     |  4 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  | 15 ++--
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 81 ++++++++++++++----=
----
 .../drm/amd/display/dc/bios/bios_parser_helper.h   |  5 ++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c | 10 ++-
 .../drm/amd/display/dc/dce110/dce110_opp_csc_v.c   | 10 ++-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c    |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 42 ++++++-----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 32 +++++----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  1 -
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  8 ++-
 drivers/gpu/drm/drm_dumb_buffers.c                 |  7 --
 drivers/gpu/drm/drm_gem.c                          | 73 +++++++++---------=
-
 drivers/gpu/drm/drm_ioctl.c                        |  3 +-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  | 19 +++--
 drivers/gpu/drm/i915/display/intel_plane.c         | 27 ++++++++
 drivers/gpu/drm/imx/dcss/dcss-scaler.c             |  3 +
 drivers/gpu/drm/v3d/v3d_gem.c                      |  8 +++
 drivers/gpu/drm/v3d/v3d_perfmon.c                  | 24 +++++--
 drivers/gpu/drm/v3d/v3d_sched.c                    | 17 ++++-
 drivers/gpu/drm/xe/xe_exec_queue.h                 | 17 -----
 drivers/gpu/drm/xe/xe_guc_submit.c                 | 62 +++--------------
 drivers/gpu/drm/xe/xe_hw_engine_group.c            | 10 +--
 drivers/gpu/drm/xe/xe_uc_fw.c                      |  1 -
 60 files changed, 472 insertions(+), 323 deletions(-)
