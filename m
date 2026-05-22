Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF94ECD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 22:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F9D10E0C7;
	Fri, 22 May 2026 22:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PmtkV0d0";
	dkim-atps=neutral
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E854910E0C7
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 22:16:24 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-8b8e98fd885so99962176d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 15:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779488184; cv=none;
 d=google.com; s=arc-20240605;
 b=W2s9OyboNQTjEDwWwY5LAmSiHLUyRNZo0/jIUQUGaO79DXtOSyTCUj0Q0jZwftY7ka
 RZgQoFs37WdmXP/OWBY/IycJhMGR6MxoMxv4sqkayBEF1RhtEIRt/09OLaNFLkezFKYw
 LSan/4Tr9xxztxOfNfZgiznx7UwTq2UeKH9ArWiIFMriOQETpwam3HlP3lfxsEilh/ug
 FZwVarsuWhABdH21vtbSjfb7AeZKJuKjBfWvSbEHtiHy41C5IHExWhtS6EzyKvZtwBsm
 +BAmf2Z8wZL4gMYrcoOCONy8yCGV0QwfhmyCpLkso/wBvCDlSzahG2WxsGzjGooarCp2
 27Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=r00ndh05UzQilLEaaUlD3IjUwYcy4oaoRx7GdHCK8Jk=;
 fh=A08XZwmmb57jzirbgTkluPSvjDeiJMkkojF1n6qDmTk=;
 b=VCcLwsyURBmBjp8IAmny+BOn6Us1DZ7+5LgR5mjPzrSG9Q05XR2ZxSHlv27t2RVXu/
 kgEdaQdhnxchRdv4zA13OqSBGO5hobye/Owk0tjyOVAna9hPlBKGwG/F9jui2RhzfIcj
 iTu7gnQnzErWjpCAw6ueqMBdtjgzB1KE0DS34J5q6EJ/FDUdr3nF0dicPrDUsfi4nWpV
 rNxMRc1Pj507wqWUIY/m+h+bGhWiynXbSLJmGEtyjMlL/ChcK9k+i8392SCu51xHcUMW
 bcp6rpxaVLRWi3R5SUUa0Gv/PFIRJQnueQUO/FIYDGr61HQEadKHQhUNshsGmg7lbmc3
 d0VQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779488184; x=1780092984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r00ndh05UzQilLEaaUlD3IjUwYcy4oaoRx7GdHCK8Jk=;
 b=PmtkV0d0Qmk7jf5fcvvrbhP65RBDjMlW8f1YS1R2vq1A7LeDKs4XYD4d5PeU42jueV
 DsdKA6p21y45AwB50cTITW27kwoj+TmEB9zfLgFDRY2DDt8IGt5nBqhA0z4DOM/U0TJb
 9Gca7UHu3ecF0NgQw9dDQx0LX4QQawNnPtiqMJYWKB9tCphTrTl47zpQe9Rg2mSWJbck
 6pfFGWM2uIdSYhC2iLFWax6rNEX3VDNexhgxDbpKLfU/rq6zT1ay1A0u6wY72HZkq5tA
 +FTRprjGYlITxn4KhCM0Yggyf8K4AujUmwd349yu8I7K7OhccW/RmQo+YxK9Ev0izKMv
 nA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779488184; x=1780092984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r00ndh05UzQilLEaaUlD3IjUwYcy4oaoRx7GdHCK8Jk=;
 b=JemJ6+V1EYS0EfKY/dwbzf+FtynFIIOnm/nY9PH+3op2kZ7Y2x0ceuRX46bMVFqIzm
 NA+s2KjJy/AxnwQVHFSkxnDh/8P2TlqUoP6O5KNacDnErGCHvNWiX0SAH2OtsDgW2tT0
 TBrSYkzrPFzlcLyTwJZ87t98XcvOXVKIQDjBdqxdeoOCLg6qIdRv2rP07Z++0PsoTD+M
 kd8rW1v5rjKk1BzPvHV5q/zNvcf+uHpe5maG4GdwSKb2MEJXYv6ucMsP/JzaHhPRVB31
 05IGoY1Kn05WhtvSgKoRkRoz43nRaDqQpxUHZKbWlqT++C8GvYb0b5u+Fk8FKY5vT2oL
 cpTg==
X-Gm-Message-State: AOJu0YzupGja+B2xKqRJXXnVrNT4qNBg1vkoILnwl1Cvck2ldo+gzyvk
 x6HE4WQEW9MFQp+XVRmMNfzw9+WlAqo5oxVqz0txP4zMXp8BUSLYtx4JEgXonoh3ApmmR40JRnt
 HBNP9iDHQu0JuiSC946W9FJzxRZ/e8w4=
X-Gm-Gg: Acq92OG1hqSlL6Ise+di4vdBajv27xUBgcxXFIHLDAt/boS00jrLN6XQIyO5EBQ8oxO
 4ipr+U9sDU6n6PnMflwp5dZVALTflA82yLqJZxAnOzGUHwtT+jTTb/7HIjSH4uuKRO0MaLfjo3w
 g88SN/9Gl8LpavoyqDINYateI9OBt7l1pRBE2peiFww4UC47H4ojNCJlF0sdGiSy8LvBxd7ppS4
 t9bKmq0UDhlYNOBl88F6lyF7PRaryeNYrynU59aMD3n7Ae4d4FXq2Hfswo2twPkihqO/vyXptvc
 mVDoaZHL8U0w4nJW8noidh/3Kr3TzqVEEhl8aVjODuSgJ5eDfErYWkrvh2NoDv6Tdxg=
X-Received: by 2002:a05:6214:401d:b0:8ac:a5bc:a6b4 with SMTP id
 6a1803df08f44-8cc7b5b946emr104411816d6.36.1779488183558; Fri, 22 May 2026
 15:16:23 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 23 May 2026 08:16:11 +1000
X-Gm-Features: AVHnY4JZkrO9DevsVIPgVrTnFkMtWxSPECSEyQJGsrsij69MBrSk27rpqtPJLNI
Message-ID: <CAPM=9tx1oasUKYLGvimk5eXftsYk1LOSaNV_X27tVp-pvrMLLA@mail.gmail.com>
Subject: [git pull] drm fixes for 7.1-rc5
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

Regular fixes pull, amdgpu/xe being the usual, with bonus msm content
to bulk things out, otherwise it has the usual scattered changes, with
amdxdna dropping a badly thought out userspace api.

Regards,
Dave.

drm-fixes-2026-05-23:
drm fixes for 7.1-rc5

gem:
- clean up LRU locking

msm:
- Core:
 - Fixed bindings for SM8650, SM8750 and Eliza
 - Don't use UTS_RELEASE directly
 - Fix typo in clock-names property
- DPU:
  - Fixed CWB description on Kaanapali
  - Fixed scanline strides for YUV UBWC formats
  - Stopped DSI register dumping to access past the end of region
- DSI:
  - Fix dumping unaligned regions
- GPU:
  - Fix GMEM_BASE for a6xx gen3
  - Fix userspace reachable crash on a2xx-a4xx
  - Fix sysprof_active for counter collection with IFPC enabled GPUs
  - Fix shrinker lockdep

amdgpu:
- Userq fixes
- VPE fix
- SMU 15 fix
- Misc fixes
- VCE fixes
- DC bios parsing fixes
- DC aux fix
- Mode1 reset fix
- RAS fixes

amdkfd:
- Misc fixes

radeon:
- CS parser fix

xe:
- SRIOV related fixes
- Fix leak and double-free
- Multi-cast register fixes
- Multi-queue fix

i915:
- Fix joiner color pipeline selection [display]
- Fix readback for target_rr in Adaptive Sync SDP [dp]
- Apply Intel DPCD workaround when SDP on prior line used [psr]

amdxdna:
- remove mmap and export for ubuf

bridge:
- chipone-icn6211: managed bridge cleanup
- lt66121: acquire reset GPIO
- megachips: fix clean up on failed IRQ requests

v3d:
- fix UAF in error code paths
- release GEM-object ref on free'd jobs

virtio:
- use uninterruptible resv locking in plane updates

mediatek:
- fix sparse warnings
The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8=
:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-05-23

for you to fetch changes up to 84335a9985867c1a6cd28c693ffbedc4ef1caa39:

  Merge tag 'drm-xe-fixes-2026-05-21' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2026-05-23 07:57:08 +1000)

----------------------------------------------------------------
drm fixes for 7.1-rc5

gem:
- clean up LRU locking

msm:
- Core:
 - Fixed bindings for SM8650, SM8750 and Eliza
 - Don't use UTS_RELEASE directly
 - Fix typo in clock-names property
- DPU:
  - Fixed CWB description on Kaanapali
  - Fixed scanline strides for YUV UBWC formats
  - Stopped DSI register dumping to access past the end of region
- DSI:
  - Fix dumping unaligned regions
- GPU:
  - Fix GMEM_BASE for a6xx gen3
  - Fix userspace reachable crash on a2xx-a4xx
  - Fix sysprof_active for counter collection with IFPC enabled GPUs
  - Fix shrinker lockdep

amdgpu:
- Userq fixes
- VPE fix
- SMU 15 fix
- Misc fixes
- VCE fixes
- DC bios parsing fixes
- DC aux fix
- Mode1 reset fix
- RAS fixes

amdkfd:
- Misc fixes

radeon:
- CS parser fix

xe:
- SRIOV related fixes
- Fix leak and double-free
- Multi-cast register fixes
- Multi-queue fix

i915:
- Fix joiner color pipeline selection [display]
- Fix readback for target_rr in Adaptive Sync SDP [dp]
- Apply Intel DPCD workaround when SDP on prior line used [psr]

amdxdna:
- remove mmap and export for ubuf

bridge:
- chipone-icn6211: managed bridge cleanup
- lt66121: acquire reset GPIO
- megachips: fix clean up on failed IRQ requests

v3d:
- fix UAF in error code paths
- release GEM-object ref on free'd jobs

virtio:
- use uninterruptible resv locking in plane updates

mediatek:
- fix sparse warnings

----------------------------------------------------------------
Alan Liu (1):
      drm/amdgpu/vpe: Force collaborate sync after TRAP

Alexander Koskovich (1):
      drm/msm: Fix GMEM_BASE for A650

Amir Shetaia (1):
      drm/amdgpu: reject non-user addresses early in GEM_USERPTR ioctl

Ankit Nautiyal (1):
      drm/i915/dp: Fix readback for target_rr in Adaptive Sync SDP

Boris Brezillon (1):
      drm/gem: Make the GEM LRU lock part of drm_device

Ce Sun (1):
      drm/amdgpu: avoid integer overflow in VA range check

Chaitanya Kumar Borah (1):
      drm/i915/display: Copy color pipeline from plane in the primary
joiner pipe

Chen Ni (1):
      drm/msm/a6xx: Check kzalloc return in a8xx_hfi_send_perf_table

Christian K=C3=B6nig (2):
      drm/amdgpu: rework userq reset work handling
      drm/amdgpu: fix handling in amdgpu_userq_create

Daniel J Blueman (1):
      drm/msm: Fix shrinker deadlock

Dave Airlie (6):
      Merge tag 'drm-msm-fixes-2026-05-17' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'drm-intel-fixes-2026-05-20' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.1-2026-05-20' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2026-05-21' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'mediatek-drm-fixes-20260521' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes
      Merge tag 'drm-xe-fixes-2026-05-21' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

David Francis (2):
      drm/amdkfd: Check bounds on allocate_doorbell
      drm/amdkfd: Check bounds for allocate_sdma_queue restore_sdma_id

Deepanshu Kartikey (1):
      drm/virtio: use uninterruptible resv lock for plane updates

Dmitry Baryshkov (4):
      drm/msm/dsi: don't dump registers past the mapped region
      drm/msm/dpu: don't mix devm and drmm functions
      drm/msm/adreno: fix userspace-triggered crash on a2xx-a4xx
      drm/msm/snapshot: fix dumping of the unaligned regions

Felix Gu (1):
      drm/msm/adreno: Fix a reference leak in a6xx_gpu_init()

Gustavo Sousa (3):
      drm/xe: Define CACHE_MODE_1 as MCR register
      drm/xe: Define and use MCR version of COMMON_SLICE_CHICKEN1
      drm/xe: Define and use MCR version of COMMON_SLICE_CHICKEN4

Harry Wentland (3):
      drm/amd/display: Fix integer overflow in bios_get_image()
      drm/amd/display: Validate GPIO pin LUT table size before iterating
      drm/amd/display: Validate payload length and link_index in
dc_process_dmub_aux_transfer_async

Jouni H=C3=B6gander (3):
      drm/i915/psr: Add defininitions for INTEL_WA_REGISTER_CAPS DPCD regis=
ter
      drm/i915/psr: Read Intel DPCD workaround register
      drm/i915/psr: Apply Intel DPCD workaround when SDP on prior line used

Julien Chauveau (1):
      drm/bridge: it66121: acquire reset GPIO in probe

Krzysztof Kozlowski (5):
      dt-bindings: display/msm: dp-controller: Correct SM8650 IO range
      dt-bindings: display/msm: dp-controller: Allow DAI on SM8650 and othe=
rs
      dt-bindings: display/msm: sm8650: Correct VBIF range in example
      dt-bindings: display/msm: sm8750-mdss: Correct DPU and DP ranges
in example
      dt-bindings: display/msm: qcom,eliza-mdss: Correct DPU and DP
ranges in example

Lad Prabhakar (1):
      dt-bindings: display/msm: Fix typo in clock-names property

Lijo Lazar (1):
      drm/amdgpu: Fix discovery offset check under VF

Lizhi Hou (1):
      accel/amdxdna: Remove mmap and export support for ubuf

Louis-Alexis Eyraud (4):
      drm/mediatek: mtk_hdmi_ddc_v2: Fix non-static global variable
      drm/mediatek: mtk_hdmi_v2: Fix non-static global variable
      drm/mediatek: mtk_cec: Fix non-static global variable
      drm/mediatek: mtk_hdmi_ddc: Fix non-static global variable

Mahadevan P (1):
      drm/msm/dpu: Fix Kaanapali CWB register configuration

Ma=C3=ADra Canal (2):
      drm/v3d: Fix use-after-free of CPU job query arrays on error path
      drm/v3d: Release indirect CSD GEM reference on CPU job free

Michal Wajdeczko (2):
      drm/xe/memirq: Update interrupt handler logic
      drm/xe/vf: Fix signature of print functions

Mikko Perttunen (1):
      drm/msm: Fix iommu_map_sgtable() return value check and avoid WARN

Mohanram Meenakshisundaram (1):
      drm/xe/pf: Fix CFI failure in debugfs access

Neil Armstrong (1):
      drm/msm/dpu: fix UV scanlines calculation for YUV UBWC formats

Niranjana Vishwanathapura (1):
      drm/xe/multi_queue: Fix secondary queue error case

Osama Abdelkader (2):
      drm/bridge: chipone-icn6211: use devm_drm_bridge_add in i2c probe
      drm/bridge: megachips: remove bridge when irq request fails

Rob Clark (2):
      drm/msm/a6xx: Restore sysprof_active
      drm/msm: Correct modparam description

Shuicheng Lin (2):
      drm/xe/gsc: Fix double-free of managed BO in error path
      drm/xe/oa: Fix exec_queue leak on width check in stream open

Sunday Clement (1):
      drm/amdkfd: Fix OOB memory exposure in get_wave_state()

Sunil Khatri (7):
      drm/amdgpu/userq: use drm_exec in amdgpu_userq_fence_read_wptr
      drm/amdgpu/userq: pin mqd and fw object bo to avoid eviction
      drm/amdgpu/userq: cancel reset work while tear down in progress
      drm/amdgpu/userq: update the vm task info during signal ioctl
      drm/amdgpu: remove va cursors for all mappings
      drm/amdgpu: use atomic operation to achieve lockless serialization
      drm/amdgpu: userq_va_mapped should remain true once done

Timur Krist=C3=B3f (9):
      drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on Tahiti (v2)
      drm/amdgpu/vce1: Check that the GPU address is < 128 MiB
      drm/amdgpu/vce1: Remove superfluous address check
      drm/amdgpu/vce1: Check if VRAM address is lower than GART.
      drm/amdgpu/vce1: Don't repeat GTT MGR node allocation
      drm/amdgpu/vce1: Fix VCE 1 firmware size and offsets
      drm/amdgpu/vce1: Stop using amdgpu_vce_resume
      drm/amdgpu/vce2: Fix VCE 2 firmware size and offsets
      drm/amdgpu/vce3: Fix VCE 3 firmware size and offsets

Uwe Kleine-K=C3=B6nig (The Capable Hub) (1):
      drm/msm: Don't use UTS_RELEASE directly

Vitaliy Triang3l Kuzmin (1):
      drm/radeon/evergreen_cs: Add missing NULL prefix check in surface che=
ck

Xiang Liu (1):
      drm/amd/ras: Fix UMC error address allocation leak

Yang Wang (1):
      drm/amd/pm: fix memleak of dpm_policies on smu v15

Yifan Zhang (1):
      drm/amdgpu: unmap all user mappings of framebuffer and doorbell
before mode1 reset

 .../bindings/display/msm/dp-controller.yaml        |  28 ++-
 .../bindings/display/msm/qcom,eliza-mdss.yaml      |  20 +-
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |   2 +-
 .../bindings/display/msm/qcom,sm8650-mdss.yaml     |   2 +-
 .../bindings/display/msm/qcom,sm8750-mdss.yaml     |  16 +-
 drivers/accel/amdxdna/amdxdna_gem.c                |   9 +-
 drivers/accel/amdxdna/amdxdna_gem.h                |   2 +
 drivers/accel/amdxdna/amdxdna_ubuf.c               |  50 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  25 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c          |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 265 ++++++++++-------=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  57 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |   7 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              |  64 +++--
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |   9 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  22 ++
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   9 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   1 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   9 +
 .../drm/amd/display/dc/bios/bios_parser_helper.c   |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   6 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |   2 +
 drivers/gpu/drm/bridge/chipone-icn6211.c           |   4 +-
 drivers/gpu/drm/bridge/ite-it66121.c               |   5 +
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  16 +-
 drivers/gpu/drm/drm_drv.c                          |   2 +
 drivers/gpu/drm/drm_gem.c                          |  36 ++-
 drivers/gpu/drm/i915/display/intel_display_types.h |   1 +
 drivers/gpu/drm/i915/display/intel_dp.c            |   2 +-
 drivers/gpu/drm/i915/display/intel_dpcd.h          |  15 ++
 drivers/gpu/drm/i915/display/intel_plane.c         |   2 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  44 +++-
 drivers/gpu/drm/mediatek/mtk_cec.c                 |   2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c            |   2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c         |   2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c             |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   7 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |   2 +
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   8 +-
 .../drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |   3 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c  |  28 ++-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |   1 +
 drivers/gpu/drm/msm/msm_drv.c                      |  11 +-
 drivers/gpu/drm/msm/msm_drv.h                      |   7 -
 drivers/gpu/drm/msm/msm_gem.c                      |  33 ++-
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |  44 ++--
 drivers/gpu/drm/msm/msm_gem_submit.c               |   6 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |  12 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   4 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |   5 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c               |   6 +-
 drivers/gpu/drm/radeon/evergreen_cs.c              |   6 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |  16 +-
 drivers/gpu/drm/v3d/v3d_submit.c                   |  22 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |   1 +
 drivers/gpu/drm/virtio/virtgpu_gem.c               |  17 ++
 drivers/gpu/drm/virtio/virtgpu_plane.c             |  10 +-
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |   4 +-
 drivers/gpu/drm/xe/xe_gsc.c                        |   5 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.c        |   6 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.h        |   2 +-
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c                |  24 +-
 drivers/gpu/drm/xe/xe_gt_sriov_vf.h                |   6 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  16 +-
 drivers/gpu/drm/xe/xe_memirq.c                     |  26 +-
 drivers/gpu/drm/xe/xe_oa.c                         |   6 +-
 drivers/gpu/drm/xe/xe_tuning.c                     |   2 +-
 drivers/gpu/drm/xe/xe_wa.c                         |   6 +-
 include/drm/drm_device.h                           |   7 +
 include/drm/drm_gem.h                              |  20 +-
 85 files changed, 739 insertions(+), 484 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/display/intel_dpcd.h
