Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6470BC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 05:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B96D10E127;
	Fri, 10 Jul 2026 05:01:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aPlb2QyB";
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0FC510E127
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 05:01:06 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-66771ded50aso878191d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 22:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783659665; cv=none;
 d=google.com; s=arc-20260327;
 b=F/MSiHb2q2FXcbWRdUUzFJ0RQ7QM33mIn4DkGpVNGEjh2phAsyKOux8biLWvT8/XBc
 9aiiUanHDYlIYZmNEjVMao9+a/6sWg9ju+uxPO5KuSK1PHx9i0S3PXnWLwAeAZ0bDwt3
 CML/PuYqY0TjnBzSLual5yN2G5sv+3B/YcOxDKOwyHfHR7+/GiPNMe5HB+LpzYzr2J+I
 DmLv0g2DyUG7Rxs06DadQZxPz6PWBDmWE/9CTt876cj1xD/RKKaw97koGB69zJ4Pt1zJ
 c8sL9AJEdElfl/se8aw81HTKkAwja7s30UqtDqQsnt2XFgTQyzs60VqWKOG4PlK5TBuA
 VZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=6v3ebEGxL52vSy4QWaYuY/5QKSK1TGHhDyp+canIrNI=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=WMAJBRe6/pk3uj3Wbi3mjXb/WG1IzNb+PAwugqFOT5VkP3hVMW4xotWecNZpRZ4neE
 LJjcpZTVth3stC25lEttNZfu9kWylU7mE3MfYpxRjf0MEvYgOAK2GQLgZ1elSi1daduw
 GljLJ1rRMY8ISYTKeISQT24d7kjjpJp2qmldLBVDVuMIORh/1t1+4M16jZlGpD6EKgu/
 csL+a77iJiYVAKE7SsU9Tqvj0cj8mijTH6UlRINZIsYmBgynaBOtxn/5tSlDVdFhRT/+
 Q/ODnSeayoT8ciqQlmFSH//CRtl6Hpmc51qCPVUZoA7Tab817Onl/R1ytR/LMISGveFj
 49Rw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783659665; x=1784264465; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6v3ebEGxL52vSy4QWaYuY/5QKSK1TGHhDyp+canIrNI=;
 b=aPlb2QyBoMGh2DxjFMA4oYVEh6PBLTpA/W3cxAHvPnmjo64f7lt4T/HIHSGksbvGOj
 wVXNFYJzsbPSYM+TwohBMSPneXHKTwM6WWN5Mu0x3mGEvrKbmWLd3wLhiCimLhfPaM0c
 3bA8q6I4Kwl3AHL5QH5Ml+ZSAKgaN0/nqcbUu2187HePVEVyi+9NPId46xgwip6zKGyM
 sB2mhn4Kxe/4+TkBvMW6e5GGbwlMnnb68Odqdmpwt2L0JvoO8rb3jM6jsROHcHrtX+sN
 yQT9VtgwcNjLZcC7VgOWgmTrl2Z2LnSB407I6LhGZEIU38VEi6WkD/X4Mn2Jbkjvbc//
 YY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783659665; x=1784264465;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6v3ebEGxL52vSy4QWaYuY/5QKSK1TGHhDyp+canIrNI=;
 b=XflJkyPbkVUwIvRG7Eev0xOAgp5LT2RpJBbULvbl6Et3ha1K/o7X5VGIvgKOLyNVFS
 WOzABfsRzZz5auZbjzko9eLrVNjNRNpF53MXMqPrDVUrVtU1PFgRI37saZDfUijggOPM
 laN9Xc8cbCspJOawXSzPSgZSbMXx9W/NyjbQ8MykiZuGsgS1L0ha1bp7XDtc8wQVKvm6
 ZG0c4FK3KjW5oLybmc9/wuVQorpIwZRaZJFoJhXq3d8d6bTu+S9is8NWEKFzNvSEk0AG
 fPAXs8lS61vfoCGpCZSAgufQEZeg4jMyzwhPv6zjp2fUHaLkDtY4Z4vBc6X5TPBTNMRk
 U+HQ==
X-Gm-Message-State: AOJu0YzN9yqA5lwFcXTZq4WE7RATz1Ino/c7mG2YHcTNXnDyK2flnIPX
 5wLmlX3hlZLGk5DsatVlHK4jzaR2vH/dTNFIk7pyO7NbWva76Z1vMC5GXo/Fy43y6YM6oG4DQ9a
 zZv99M05htLUNGM3+/9OMXm8+ip1RyNE=
X-Gm-Gg: AfdE7cnw7JbNB+fxs+TregPI/EZTvjsjA00RZx4frGrC0u+0PVMlgg6VNZ9BOa81rGh
 jpne769d6LuvbB6Frjnvr6WLAyd5lSrIeEUzOK2LEbNZGpw6GfkDRxj4upgHR/kVwLFfbjaN3Ye
 PLxPLrcvdI2NoBr7y+xWtqyp7R1jevpDhy9/FMYqpq1v3/+SjdB+kYcQJ6k0cuAcmajGt+rN+o+
 fRJaTxJC10BnNbsEaAAszgYNxFHzs3pdEkSb0HCCBtoIYDBiEafsUA748TRxW7WfoZpi3YslRsW
 WKltoj9UnfSA0G5TjOLq7wiGX8aPhfxMKx8oh8rD06YFDuNVQJ/jw5qxlQ==
X-Received: by 2002:a05:690c:e18f:10b0:81e:3e2c:6fea with SMTP id
 00721157ae682-81e3e3bb3fcmr52050677b3.70.1783659665327; Thu, 09 Jul 2026
 22:01:05 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 10 Jul 2026 15:00:53 +1000
X-Gm-Features: AUfX_mxgpklPxyCBkSuBHxP8AgKbTYbI-bwX6ICF6vLZwTUnkEtceAtEgGtuMz4
Message-ID: <CAPM=9twH=ycBLJyS7eEkqYexViq_Bju6R=Hj-ev1yWGkeStntA@mail.gmail.com>
Subject: [git pull] drm fixes for 7.2-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
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

Weekly fixes pull for drm, amdgpu, amdxdna, xe leading the way, some
small core fixes and a nouveau stability fix along with some minor
changes in other drivers.

Seems to be a bit quiter than last week at least,

Regards,
Dave.

drm-fixes-2026-07-10:
drm fixes for 7.2-rc3

fb-helper:
- Sync on first active crtc in fb_dirty, rather than first crtc.

drm_exec:
- Use direct label in drm_exec.

buddy:
- Rework try_harder in the buddy allocator.

i915:
- fix underrun on panthor lake
- LT PHY SSC programming fix
- fix some NULL derefs and leaks

nouveau:
- fix a vmm large/small page table update race

xe:
- Fix PTE index in xe_vm_populate_pgtable for chunked binds
- Wait on external BO kernel fences in exec IOCTL
- Remove duplicate include
- Free madvise VMA array on L2 flush failure
- Stub notifier_lock helpers when DRM_GPUSVM=3Dn

amdgpu:
- PSP 15.0.9 update
- SMU 15.0.9 update
- VCN 5.3 fix
- VI ASPM fix
- Userq fix
- lifetime fix for amdgpu_vm_get_task_info_pasid()
- Gfx10 fix
- SMU 14 fix

amdkfd:
- CRIU bounds checking fixes
- secondary context id fix
- Event bounds checking fix

amdxdna:
- Fix uaf in mmap failure path.
- A lot of deadlocks, access races and return value fixes

analogix_dp:
- Fix analogix_dp bitshifts during link training.

v3d:
- Fix absent indirect bo handling

imagination:
- Make function static to solve compiler warning.
- Fix error checking.
The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda=
:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-07-10

for you to fetch changes up to 6763a0aea6d658d69b9215ab9151d7bd4c1c314b:

  nouveau/vmm: fix another SPT/LPT race (2026-07-10 14:19:23 +1000)

----------------------------------------------------------------
drm fixes for 7.2-rc3

fb-helper:
- Sync on first active crtc in fb_dirty, rather than first crtc.

drm_exec:
- Use direct label in drm_exec.

buddy:
- Rework try_harder in the buddy allocator.

i915:
- fix underrun on panthor lake
- LT PHY SSC programming fix
- fix some NULL derefs and leaks

nouveau:
- fix a vmm large/small page table update race

xe:
- Fix PTE index in xe_vm_populate_pgtable for chunked binds
- Wait on external BO kernel fences in exec IOCTL
- Remove duplicate include
- Free madvise VMA array on L2 flush failure
- Stub notifier_lock helpers when DRM_GPUSVM=3Dn

amdgpu:
- PSP 15.0.9 update
- SMU 15.0.9 update
- VCN 5.3 fix
- VI ASPM fix
- Userq fix
- lifetime fix for amdgpu_vm_get_task_info_pasid()
- Gfx10 fix
- SMU 14 fix

amdkfd:
- CRIU bounds checking fixes
- secondary context id fix
- Event bounds checking fix

amdxdna:
- Fix uaf in mmap failure path.
- A lot of deadlocks, access races and return value fixes

analogix_dp:
- Fix analogix_dp bitshifts during link training.

v3d:
- Fix absent indirect bo handling

imagination:
- Make function static to solve compiler warning.
- Fix error checking.

----------------------------------------------------------------
Alex Deucher (1):
      drm/gfx10: Program DB_RING_CONTROL

Anas Khan (1):
      drm/xe: remove duplicate <kunit/test-bug.h> include

Ankit Nautiyal (1):
      Revert "drm/i915/psr: Allow SCL=3D0 on platforms with always-on VRR T=
G"

Arunpravin Paneer Selvam (1):
      gpu/buddy: bail out of try_harder when alignment cannot be honoured

Ben Dooks (1):
      drm/imagination: make pvr_fw_trace_init_mask_ops static

Christian K=C3=B6nig (1):
      drm/drm_exec: avoid indirect goto

Damon Ding (1):
      drm/bridge: analogix_dp: Fix PE/VS value shift mismatch during
link training

Dave Airlie (5):
      Merge tag 'drm-intel-fixes-2026-07-09' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-07-09' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.2-2026-07-09' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-xe-fixes-2026-07-09' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      nouveau/vmm: fix another SPT/LPT race

David Francis (4):
      drm/amdkfd: Check bounds on CRIU restore event id
      drm/amdkfd: Don't acquire buffers during CRIU queue restore.
      drm/amdkfd: Check bounds in allocate_event_notification_slot
      drm/amdkfd: Check bounds on CRIU restore queue type and mqd size

Guangshuo Li (1):
      drm/xe: free madvise VMA array on L2 flush failure

Jani Nikula (1):
      drm/i915/mst: limit DP MST ESI service loop

Jesse Zhang (1):
      drm/amdgpu: trigger GPU recovery when userq destroy fails to
unmap a hung queue

Joonas Lahtinen (3):
      drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU
      drm/i915/gt: Fix NULL deref on sched_engine alloc failure
      drm/i915/gem: Do not leak siblings[] on proto context error

Kanala Ramalingeswara Reddy (2):
      drm/amdgpu: add support for PSP version 15.0.9
      drm/amdgpu: add support for SMU version 15.0.9

Kenneth Feng (1):
      drm/amd/amdgpu: disable ASPM on VI if pcie dpm is disabled

Lizhi Hou (10):
      accel/amdxdna: Prevent PM resume deadlock in hwctx_sync_debug_bo()
      accel/amdxdna: Use unsigned long for nr_pages in amdxdna_hmm_register=
()
      accel/amdxdna: Fix VMA access race
      accel/amdxdna: Fix potential amdxdna_umap lifetime race
      accel/amdxdna: fix open_ref leak and stale client pointer on dma
map failure
      accel/amdxdna: Fix deadlock on debug BO command timeout
      accel/amdxdna: Fix hardware context race in amdxdna_update_heap()
      accel/amdxdna: Check drmm_mutex_init() return value
      accel/amdxdna: Check init_srcu_struct() return value
      accel/amdxdna: Fix potential NULL pointer dereference of abo->client

Luigi Santivetti (1):
      drm/imagination: fix error checking of pvr_vm_context_lookup()

Matthew Brost (2):
      drm/xe: Fix PTE index in xe_vm_populate_pgtable() for chunked binds
      drm/xe: Wait on external BO kernel fences in exec IOCTL

Ma=C3=ADra Canal (1):
      drm/v3d: Reject invalid indirect BO handle in indirect CSD setup

Robert Mader (1):
      drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE

Shahyan Soltani (1):
      drm/amdgpu: fix lifetime issue of amdgpu_vm_get_task_info_pasid()

Shuicheng Lin (1):
      drm/xe/userptr: Stub notifier_lock helpers when DRM_GPUSVM=3Dn

Suraj Kandpal (1):
      drm/i915/ltphy: Fix SSC Enablement bit in PORT_CLOCK_CTL

Suresh Guttula (1):
      drm/amdgpu: Disable JDPG on VCN5_3

Thomas Zimmermann (1):
      drm/fb-helper: Only consider active CRTCs for vblank sync

Wentao Liang (1):
      accel/amdxdna: Fix use-after-free in amdxdna_gem_dmabuf_mmap()

Yang Wang (1):
      drm/amd/pm: fix smu14 power limit range calculation

Zhu Lingshan (1):
      amdkfd: properly free secondary context id

 drivers/accel/amdxdna/aie2_ctx.c                   | 19 ++---
 drivers/accel/amdxdna/aie2_message.c               |  4 +-
 drivers/accel/amdxdna/amdxdna_ctx.c                | 56 ++++++++++---
 drivers/accel/amdxdna/amdxdna_gem.c                | 50 ++++++++----
 drivers/accel/amdxdna/amdxdna_gem.h                | 12 ++-
 drivers/accel/amdxdna/amdxdna_pci_drv.c            | 21 ++++-
 drivers/gpu/buddy.c                                | 67 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 27 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  9 +++
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  3 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  6 ++
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 37 +++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  1 +
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   | 28 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |  1 +
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |  3 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  4 +
 drivers/gpu/drm/drm_fb_helper.c                    | 92 ++++++++++++++++++=
+++-
 drivers/gpu/drm/drm_ioctl.c                        | 14 +++-
 drivers/gpu/drm/i915/display/intel_dp.c            |  8 +-
 drivers/gpu/drm/i915/display/intel_lt_phy.c        |  6 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  3 -
 drivers/gpu/drm/i915/gem/i915_gem_context.c        | 24 +++---
 .../gpu/drm/i915/gt/intel_execlists_submission.c   | 19 ++---
 drivers/gpu/drm/imagination/pvr_context.c          |  4 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.c         |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c      | 31 ++++----
 drivers/gpu/drm/tests/drm_exec_test.c              | 26 +++---
 drivers/gpu/drm/v3d/v3d_submit.c                   |  2 +
 drivers/gpu/drm/xe/tests/xe_pci.c                  |  1 -
 drivers/gpu/drm/xe/xe_exec.c                       | 22 ++++--
 drivers/gpu/drm/xe/xe_pt.c                         | 19 ++++-
 drivers/gpu/drm/xe/xe_vm_madvise.c                 |  2 +-
 include/drm/drm_exec.h                             | 34 ++++----
 42 files changed, 485 insertions(+), 203 deletions(-)
