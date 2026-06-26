Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F4BC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 21:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0732C10E174;
	Fri, 26 Jun 2026 21:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RsFQfv6W";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B002B10E3D7
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 21:12:38 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-92c7a0a7059so97285a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782508358; cv=none;
 d=google.com; s=arc-20260327;
 b=DKu+ucUMDo8xA6uCcruAvUdD1Fnl+3Ve7G5J3EAjscsET12xTdl3ixA16JEPYsVf2E
 i+VbceU09gLw1XDp8zP9GvwSs8niCfOckGoZqnHYIrjzjXGDimlLGrD97osV4wxZhqui
 b2J/wchjbFIMQC3NwheZIbdoAZ45Dj6eNFCEbDepXWz6zUp7LohOqhvp2KJ3KEdmlXY8
 GpZda+g1hSV2Fn01ac5XkEtZXkyECbGeFTVsJV8C3m+/i0eOom56AJbViUQijbG9VDIW
 D6ohpPGe2hVZoUTwEls4wohY3e3QOs1m5OqPYmRiLJiMQfg7fOWBQR3D+zMGb1AMYfW8
 U/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=nZ39sfbitXUXtcziRdXb/IE2TsHmpt+rDZX8E4vivbU=;
 fh=hhDhD4o6ytY6jjjDoOc59Iidn+8MKyaa0XrgOy5SBEE=;
 b=XfPyHUR08WNapVBT5vhJShl0PVdSowVO7Zs1QOTFH3oI2TpYgjT0BMgSgDeHVatIXX
 oWSeSGjfyBlJw5/0WWN1+RKwr2W5mqr5Mls83wF3Hfdsp65dV+Ob2fqDO88/vReg8ENC
 Ib2r5Vz+I0NfdBFeWYmKvpkQxWjyKYGJ52BTDnMsA20PrZ9dbt5Z4m0LpYNAYECSaqpM
 aOrt9co2RuG9K2erxNZ0UQV5AjxIUMvc7NCbwkrDDbUsSl86evZP6IPuDN8O/JMwJnQF
 JHKUB3J5XwOVCCJlkbCjezxKH9pY4aik6vxDSgjuw/MvrtCMF8febrFTX60SpGkk/3M4
 H6WQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782508358; x=1783113158; darn=lists.freedesktop.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nZ39sfbitXUXtcziRdXb/IE2TsHmpt+rDZX8E4vivbU=;
 b=RsFQfv6W49hW8VzpbrkLhdm0iDM2JU7HuYwDCM+5D0se8ZAxam16fUgdRbSwejQulY
 188wUCMXnICAKZDsBzTReqC8RzPZU5VTih4rJ1Wmzg3upLrpwWlmqJ1FzKfGe9ncCoZt
 jkGS7NJYS5xrJ4kudlopTmgr+pyYlvvimFqRCHwUTyXPp9G/6KuSjYnuSWoSEB0dOYi5
 Driqgoe0yS9GzPgdvi8a6GBAuj4XYnocRiTK49mcxymLFZFInWwHz3cO8h3Pye5tfDo+
 N1lUpUSB7btQeheVd9QHbWKrfBSwiGePxtoOQvRDXf43lwMwwvH7fDE1d0B0gWAeZ+RE
 8IGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782508358; x=1783113158;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZ39sfbitXUXtcziRdXb/IE2TsHmpt+rDZX8E4vivbU=;
 b=IaCJ4ZZ9XkL4Qrv8+m5k+ANcLfRpZpoa/k9henSyD9D2OZEeLGu8X6NQvS6ftFBfAH
 BiO/9MUvAOUHg4cipmRUmZhHldjaDc/vjWHO6EOJT/pjAJ/F4oUpEtvuKgsowavMA5/A
 Rr6lmeB1iRrr5bbhemPzM/HKvhH4/hTec8jSOIhq1xUIZRFfTT4fCVFvei3rOmboUkML
 5DcEVnkcj/2mMcp/UhL/gw4Ydv5dLHzub9kGksUKslK2BJ6RrMMQan9LQkJLS13o+Pgk
 /lsX/SjJb9LrzJxhRUBoOFvgUrq5dUmOgRzvKcrrK7K2vbk+bwT+uM76KVyzoH372QvG
 panQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Vr2dT6IebJhHxvQL1GSQ3uvGPAxGnzmaA5IS9nx3AhHU8dHBqtoy/q13uZONd06Zs5Q4TyEYEONo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrvIQ1cbZ1QYl951ZQCn168bmsE/4FFEPaFQ7FLUGF0Y7hX9QK
 KyLf929KfUbQQN7YiHjROpL+CuuPzG+vD235uyAWGfkQ9PFDF1t6UUGyvmnDtv+cJM/qjqHS4e4
 z+mONz0X07Ul+/QgBg4CXlKGEcxyc32iLwm+dhisjGQ==
X-Gm-Gg: AfdE7cn283DcjChlC/bnTn4lbEPnY4CmkcrbRRYz2Gzy4PgOKRzaWR7Kw7lVYw5v+qf
 XvMQmwulqysiX8MmRxLLtKFA2At+qVdO/uG9yt1G7FWXSjlnpIrZu9yWbpLexs3VZpVER183wKJ
 IzWYYxPugusU0NOJc+J7JEI/SSJCRMACLeI6HYDwYt5CccOyM8fU8MUGwVE10XmcqvJh8L/pEtU
 BWNYbQEt2ByToXoccbVnCyQDFBeiloIy2QiJQIE66SCZ6tXJLDBVvfes8TPfVlffEpjIOpuKcNQ
 tluoLYXJi9D0X9ygos3sU129Fx0vS+3O/IXvnsYjzGAST+Ixzv1hPsSE5A==
X-Received: by 2002:a05:620a:6f0d:b0:929:2308:5995 with SMTP id
 af79cd13be357-9293c027bf4mr1312200885a.26.1782508357502; Fri, 26 Jun 2026
 14:12:37 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 27 Jun 2026 07:12:25 +1000
X-Gm-Features: AVVi8CdZR6l2Xtvk_jC7qXuSB4Lc5iCroT1SK3ukkyYTHjBMLo6qfibRTyHDAW0
Message-ID: <CAPM=9tys2rN-EwfmUowvdozkZXqJENMz4GsCYHG6eOwyo_-R1g@mail.gmail.com>
Subject: [git pull] drm-next-fixes for 7.2-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
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

This is the merge window fixes from our next tree, i915/xe and amdgpu
make up all of it, I've got a separate fixes pull from our fixes
branch arriving after this. It looks around the usual amount of
pre-rc1 fixing.

Regards,
Dave.


drm-next-2026-06-27:
drm next fixes for 7.2-rc1

i915:
- Fix corrupted display output on GLK, #16209
- Add missing Spectre mitigation for parallel submit IOCTL
- MTL+ fix for DP resume
- clear CRTC blobs after dropping refs
- fix sharpness filter on DP MST

xe:
- Set TTM beneficial order to 9 in Xe
- Several error path cleanups
- Fix TDR for unstarted jobs on kernel queues
- Several TLB invalidation fixes related to suspending LR queues
- Some small RAS fixes
- Multi-queue suspend fix for LR queues
- Revert inclusion of NVL_S firmware

amdgpu:
- devcoredump fixes
- SMU15 fix
- Various irq put/get imbalance cleanup fixes
- 8K panel fix
- DCN3.5 fix
- lockdep fix
- Cleaner shader sysfs IB overflow fix
- Async flip fixes
- GET_MAPPING_INFO fix
- CP_GFX_SHADOW fix
- Ctx pstate handling fix
- GTT bo move handling fixes
- Old UVD BO placement fixes
- GC9 mode2 reset fix
- IH6.1 version fix
- Soft IH ring fix

amdkfd:
- Fix doorbell/mmio double unpin on free
- CRIU fixes
- SMI event fixes
- Sysfs teardown fix
- Various boundary checking fixes
- Various error checking fixes
- SVM fix
The following changes since commit 52d4ab1ca790a668cc8f2c27017138b1c467168c=
:

  Merge tag 'drm-misc-next-fixes-2026-06-11' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
(2026-06-13 08:10:38 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-06-27

for you to fetch changes up to b41df707b6d7b7ae6188c6fc37ba81859293cb94:

  Merge tag 'drm-intel-next-fixes-2026-06-25-1' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
(2026-06-26 07:14:08 +1000)

----------------------------------------------------------------
drm next fixes for 7.2-rc1

i915:
- Fix corrupted display output on GLK, #16209
- Add missing Spectre mitigation for parallel submit IOCTL
- MTL+ fix for DP resume
- clear CRTC blobs after dropping refs
- fix sharpness filter on DP MST

xe:
- Set TTM beneficial order to 9 in Xe
- Several error path cleanups
- Fix TDR for unstarted jobs on kernel queues
- Several TLB invalidation fixes related to suspending LR queues
- Some small RAS fixes
- Multi-queue suspend fix for LR queues
- Revert inclusion of NVL_S firmware

amdgpu:
- devcoredump fixes
- SMU15 fix
- Various irq put/get imbalance cleanup fixes
- 8K panel fix
- DCN3.5 fix
- lockdep fix
- Cleaner shader sysfs IB overflow fix
- Async flip fixes
- GET_MAPPING_INFO fix
- CP_GFX_SHADOW fix
- Ctx pstate handling fix
- GTT bo move handling fixes
- Old UVD BO placement fixes
- GC9 mode2 reset fix
- IH6.1 version fix
- Soft IH ring fix

amdkfd:
- Fix doorbell/mmio double unpin on free
- CRIU fixes
- SMI event fixes
- Sysfs teardown fix
- Various boundary checking fixes
- Various error checking fixes
- SVM fix

----------------------------------------------------------------
Andrew Martin (1):
      drm/amdkfd: Fix SMI event PID reporting for containers

Asad Kamal (1):
      drm/amdgpu/gfx: fix cleaner shader IB buffer overflow

Brian Nguyen (1):
      drm/xe: Add compact-PT and addr mask handling for page reclaim

Daniele Ceraolo Spurio (1):
      Revert "drm/xe/nvls: Define GuC firmware for NVL-S"

Dave Airlie (4):
      Merge tag 'drm-intel-next-fixes-2026-06-17' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-xe-next-fixes-2026-06-17' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'amd-drm-fixes-7.2-2026-06-19' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2026-06-25-1' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next

David Francis (1):
      drm/amdkfd: Properly acquire queue buffers in CRIU restore

Geoffrey McRae (1):
      drm/amdkfd: Fix NULL deref during sysfs teardown

Gerhard Schwanzer (1):
      drm/amdkfd: Use exclusive bounds for SVM split alignment checks

Guangshuo Li (1):
      drm/i915: clear CRTC color blob pointers after dropping refs

Imre Deak (1):
      drm/i915/mtl+: Enable PPS before PLL

Ivan Lipski (1):
      drm/amd/display: Restore periodic detection for DCN35

James Lin (1):
      drm/amd/display: Add IN_FORMATS_ASYNC support for planes

Jiqian Chen (1):
      drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2

Joonas Lahtinen (1):
      drm/i915/gem: Add missing nospec on parallel submit slot

Mario Limonciello (3):
      drm/amdkfd: fix list_del corruption in kfd_criu_resume_svm
      drm/amdgpu: check amdgpu_vm_bo_find() result in GET_MAPPING_INFO
      drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1

Matthew Brost (1):
      drm/xe: Set TTM device beneficial_order to 9 (2M)

Matthew Schwartz (1):
      drm/amd/display: Fix mem_type change detection for async flips

Mikhail Gavrilov (2):
      drm/amdgpu: convert amdgpu_vm_lock_by_pasid() to drm_exec
      drm/amdgpu: fix recursive ww_mutex acquire in amdgpu_devcoredump_form=
at

Niranjana Vishwanathapura (1):
      drm/xe/multi_queue: skip submit when primary queue is suspended

Pavel Ondra=C4=8Dka (1):
      drm/radeon: fix r100_copy_blit for large BOs

Prike Liang (1):
      drm/amdgpu: allocate lockdep mutex on the heap to fix stack overflow

Qiang Yu (1):
      drm/amdgpu: initialize iter.start in amdgpu_devcoredump_format

Raag Jadav (3):
      drm/xe/drm_ras: Make counter allocation drm managed
      drm/xe/drm_ras: Add per node cleanup action
      drm/xe/hw_error: Use HW_ERR prefix in log

Rodrigo Vivi (1):
      drm/xe: fix job timeout recovery for unstarted jobs and kernel queues

Roman Li (1):
      drm/amd/display: Skip PHY SSC reduction on some 8K panels

Shubhankar Milind Sardeshpande (1):
      drm/amd/pm: re-enable MC access after PrepareMp1ForUnload on SMU V15 =
APUs

Tangudu Tilak Tirumalesh (3):
      Revert "drm/xe: Skip exec queue schedule toggle if queue is idle
during suspend"
      drm/xe: Clear pending_disable before signaling suspend fence
      drm/xe: include all registered queues in TLB invalidation

Tejas Upadhyay (1):
      drm/xe/guc: Fix buffer overflow in steered register list allocation

Thadeu Lima de Souza Cascardo (1):
      drm/amdgpu: initialize irq.lock spinlock earlier

Thomas Hellstr=C3=B6m (1):
      drm/xe: Fix wa_oob codegen recipe for external module builds

Timur Krist=C3=B3f (6):
      drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr function=
s
      drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are both GT=
T
      drm/amdgpu/uvd: Place VCPU BO only in VRAM for UVD 4.x and older
      drm/amdgpu/uvd: Fix forcing MSG, FB BOs into VCPU segment when
it isn't at 0 (v2)
      amdgpu/ih6.1: Fix minor version
      drm/amdgpu: Use system unbound workqueue for soft IH ring

Tvrtko Ursulin (1):
      drm/amdgpu: Fix context pstate override handling

Uwe Kleine-K=C3=B6nig (The Capable Hub) (1):
      drm/amdgpu: Don't use UTS_RELEASE directly

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/mst: Call intel_pfit_compute_config() for sharpness filter
      drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enabl=
e

Wentao Liang (1):
      drm/xe: fix refcount leak in xe_range_fence_insert()

Xiaogang Chen (3):
      drm/amdkfd: Let driver decide buffer size at
AMDKFD_IOC_GET_DMABUF_INFO ioctl
      drm/amdkfd: check find_first_zero_bit before __set_bit on
kfd->doorbell_bitmap
      drm/amdkfd: Use memdup_array_user to copy data from/to user
space at kfd ioctls

Yunxiang Li (2):
      drm/amdkfd: Avoid double-unpin of DOORBELL/MMIO BOs on free
      drm/amdgpu: skip already suspended IP blocks in ip_suspend_phase2

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  23 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |  73 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   | 220 ++++++++++++-----=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |  30 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c        | 103 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  18 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  50 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  91 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  39 ++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c               |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  56 ++----
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  46 +++--
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        |  99 ++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h        |  14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  15 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  10 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  13 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   1 +
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |   2 -
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |   2 -
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |   2 +
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |   7 +-
 drivers/gpu/drm/i915/display/intel_atomic.c        |   6 +
 drivers/gpu/drm/i915/display/intel_cdclk.c         |  41 +++-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  11 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   4 +
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |   1 +
 drivers/gpu/drm/radeon/r100.c                      |  13 +-
 drivers/gpu/drm/xe/Makefile                        |   4 +-
 drivers/gpu/drm/xe/regs/xe_gtt_defs.h              |   6 +-
 drivers/gpu/drm/xe/xe_device.c                     |   3 +-
 drivers/gpu/drm/xe/xe_drm_ras.c                    |  61 +++---
 drivers/gpu/drm/xe/xe_exec_queue.h                 |  17 --
 drivers/gpu/drm/xe/xe_guc_capture.c                |  10 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 | 111 ++++-------
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c              |   7 +-
 drivers/gpu/drm/xe/xe_hw_engine_group.c            |  10 +-
 drivers/gpu/drm/xe/xe_hw_error.c                   |  12 +-
 drivers/gpu/drm/xe/xe_pt.c                         | 131 +++++++-----
 drivers/gpu/drm/xe/xe_range_fence.c                |   2 +
 drivers/gpu/drm/xe/xe_uc_fw.c                      |   1 -
 52 files changed, 846 insertions(+), 598 deletions(-)
