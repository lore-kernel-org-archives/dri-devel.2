Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38370C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0200D10E5A2;
	Fri, 14 Aug 2026 20:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZTgKjOr3";
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04E0610E5A2
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 20:33:57 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-836d2861a39so17255237b3.2
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786739636; cv=none;
 d=google.com; s=arc-20260327;
 b=hclJ5XwwpEAfdxSqNe1d9vwva3JBzd0teHDeK/TuJiOvFqMVAhnd5Hk7S4peK6WjO6
 fZJeaduL1uWl9hS3CGZRwmuTNvczFmTfbsQdEwtmfpiwvK0aJk4TccNAOxKAO0szucqx
 Js9c6ZHkalbgLw1oLYxcIwio9DMR8jjhdjPBgd+eQrlYApomf6QOKbGSr1Xtm6tniOvl
 OL/udhsjcSl/z/KYn24an9/Hu7hv0mlGy4tjZQJMqHXAti7IVvGaJ1h8jB/CXUIsMgHu
 qNmUiaNw0kBMR2McyvyYkwk2L0MUOcoqh6uTQaOWmVF8/CHwf25FP0hJRoycFwZJAad0
 gz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=DRklc4VkirG7wS5FHk1iGLejFbrPzNHMCuQKtPTQUuc=;
 fh=jB4zzpG4RiBzEqyCtcurCOYtGi/xRIni7Dp2F8WM78o=;
 b=cNKKOKIc44RYdpoMI968gYtLX3QaEnzLu4nzdGT7zcTqYjXjVwdkCpBXpggLUCdf7o
 jIuyi+hkcUDQ43gvVnced+ZiKtJLKu6LlcoMTx2L2oTkzjZO1CIZjldk9T3S0Cg3NusL
 8lfkNBt0gYWOdWSS9pXkpWTDxCKPT7lPtHz9f/Pnots4EieGnkkF5nGnKXldqZ2vYEhF
 kTJrmrE5Quz92F/uN0/jAlbAJe9IOYIvYyOnEW/JTbwhvWG33w9Cj1cFz4mKyxe+Ef8s
 mR4jsnoOHHj5Bkyk6ygQniA0gUSEItsfGaNYgkMXwMoUlKeK+yRhpHjjUb8ivR7Gc3Si
 qN1g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786739636; x=1787344436; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DRklc4VkirG7wS5FHk1iGLejFbrPzNHMCuQKtPTQUuc=;
 b=ZTgKjOr3TeQ75cNU9u0B7JDyvTMIZvco7sqeTNCs2z/oQnFIZr27m5tK88gwAHERZC
 ugtnjcDcNhKQgAgnpWrIJCf0HVdRjtHyYWLVwIndRQoVs7YU4YYuouzrqpMpBn+ZdJoQ
 SER01Yl16ACFNhc9Rj8QzycuSuyfWK4WL5DjluCb9fUReP1kK3lqaWcV4Vc9oiVuus+f
 +Kk93bTFnXaIYGk/CfC+rgCmRbrFXs7f7mXRjdmgTDk32HBlhHvPApr9KksDcXLkZ7la
 riD0r/a2TgDukoxChPVuwIGtK81FStYqZxk/cVXtJsF2i1J4iuQzUTBW3kv3kjRbRq1e
 bvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786739636; x=1787344436;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DRklc4VkirG7wS5FHk1iGLejFbrPzNHMCuQKtPTQUuc=;
 b=BlYIMO2n7CV/JXZHtOJnF4aWBXt2NtLZcOMg5wdpj4nJm8AB/62ViQmYM1v3LzH1tg
 bDjQASugQMXxtM53Fi6VBuVRT7SwQnaa3kaZTcyCVQgwx4LqpHmUBZ2XLqriLVfB88Q9
 uCsfQjq7J9tpZhVmNXJG3Y98NZkL2lHhGGmPtKxRGhyuYgHLzeif+8txc34XRakcdarG
 VqPeTb3oiul7KWP+/vGsQAbBvjOmK3UWj2Mua2v0qHK3Ua45e9SK/KIICGofK8XG/w2X
 a+hSL6JhycKXwbndVWodJYYNJ0/UaFlEH7ubCckEnEPVVov8dhPzGmJn2wkRnFzBld6R
 pacQ==
X-Gm-Message-State: AOJu0YwRYjO60M/qxa1qoE390pUjKEhlyIRm9i4UDrO14kcORc17M0EU
 kVmdv16LdM/fzJ58veKy4YSwkuB6+knGNgQBu7ierxAAnUQFsHXWU23GUmLxYFnodeLR89E7/47
 kXtqyV1psJAeM2RlM2KVqbiUsTY/JRow=
X-Gm-Gg: AR+sD12+0FksLbg3D04/H1Yo71Op27/2Zz+7kojC29a9aRQQEcB5UvZRYie6SB1Qk6M
 CybQ/MWaF4VvofdANucTDDMzjKERsIUpnakoWCmaAM/GndA2JvRut9RU+kRt6MczBtCtpjif5eH
 cyIGXPEyKoxmUkHFiPenKYkW5uVqXDu2jusp5/BzFIRbh+Ya0qBhFOKrdt0LKIwlSW/ytFb0xg2
 EJPqEK2mhsqw+Z0Hje/BUAVJOBhp/KafyLO+aFetKh/PTSrwnYDIPXkxlxiiKEpNkEHAFsRFV6L
 C5nEeldDarr1ySUa5/AC6N36pmgURkZW5sBSgLN9oNZSZU/4U66llWk2w2FTupDLxMGSzJ2QRk1
 EYKAPTiKmlM/Ji5TY5uFuaKYD9PGLUQ==
X-Received: by 2002:a05:690c:56c9:b0:820:b89:52c6 with SMTP id
 00721157ae682-83714dd414cmr30945107b3.33.1786739635909; Fri, 14 Aug 2026
 13:33:55 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 15 Aug 2026 06:33:44 +1000
X-Gm-Features: AcwNN1WapWFJ-TOJxWOWRbZyvzpC_rcOnaLEiYI_TvRxqQBxECIIgfUPkkC--6E
Message-ID: <CAPM=9tz9+VhERCnDCCiFw3_FF_-C5ygQMUVQTcozjwdVRS7Ppw@mail.gmail.com>
Subject: [git pull] drm fixes for 7.2 final
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Linus

While this is large for rc8 time but also AI driven fixes is a lot of
it, we had a more traditional screw up, and a regression was just
found in the fair scheduling patches that went in back in rc1. This
reverts the fair scheduler back to an option and sets the default back
to what it should have been. We might have been a bit overly zealous
in switching over, but at least it feels more normal than the AI
driven fixes.

Apart from the scheduler, it's mostly amdgpu and xe fixes, with some
misc fixes to the log code and connector code.

Dave

drm-fixes-2026-08-15:
drm fixes for 7.2 final:

scheduler:
- revert fair scheduler patches due to regression
- mark fair as experimental

connector:
- fix OOB read in hdmi audio infoframe

log:
- fix divide by 0 if module param is set to 0
- fix OOB read on empty message
- fix infinite loop for too large scale

xe:
- Fix DPT Allocation paths
- Fixes around UM queue BO
- Order ring writes before ring tail updates
- Add termination on resume for PXP
- Document Sentinel and make CTX_TIMESTAMP read TOCTOU-safe
- Fix sync entry leak on OA config emit failure
- Check managed mutex initilization errors
- Fix min frequency setting
- Fix xe_device_probe error path

amdgpu:
- Bounds checking fix in CS IOCTL
- Bounds checking fix in GEM IOCTL
- Display fixes
- GPUVM fix
- ASPM fix
- UVD bounds checking fixes
- VCE 3 fix
- BT.2020 fixes
- NBIF 6.3.1 fix
- IP discovery fix

radeon:
- Runtime pm fix

amdxdna:
- skip attempting to populate unmapped pages
The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-08-15

for you to fetch changes up to b2601e783a2e54f6963d65f0d94f96d96c146a3a:

  Merge tag 'drm-xe-fixes-2026-08-13' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2026-08-14 15:41:40 +1000)

----------------------------------------------------------------
drm fixes for 7.2 final:

scheduler:
- revert fair scheduler patches due to regression
- mark fair as experimental

connector:
- fix OOB read in hdmi audio infoframe

log:
- fix divide by 0 if module param is set to 0
- fix OOB read on empty message
- fix infinite loop for too large scale

xe:
- Fix DPT Allocation paths
- Fixes around UM queue BO
- Order ring writes before ring tail updates
- Add termination on resume for PXP
- Document Sentinel and make CTX_TIMESTAMP read TOCTOU-safe
- Fix sync entry leak on OA config emit failure
- Check managed mutex initilization errors
- Fix min frequency setting
- Fix xe_device_probe error path

amdgpu:
- Bounds checking fix in CS IOCTL
- Bounds checking fix in GEM IOCTL
- Display fixes
- GPUVM fix
- ASPM fix
- UVD bounds checking fixes
- VCE 3 fix
- BT.2020 fixes
- NBIF 6.3.1 fix
- IP discovery fix

radeon:
- Runtime pm fix

amdxdna:
- skip attempting to populate unmapped pages

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: fix missing check in vm_flush()

Candice Li (1):
      drm/amdgpu: validate GEM_CREATE domain combinations

Daniele Ceraolo Spurio (1):
      drm/xe/pxp: add termination on resume

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-7.2-2026-08-12' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2026-08-13' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-08-13' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

David Rosca (6):
      drm/amdgpu: Reject UVD message with dimensions above 4096
      drm/amdgpu: Fix UVD dpb min size calculation for H264
      drm/amdgpu: Fix UVD decode image min size calculation
      drm/amdgpu: Fix UVD min buffer sizes
      drm/amdgpu: Implement insert_end for VCE 3
      drm/amdgpu: Reject UVD message with invalid number of h265 refs

Gajendra Uttamchand (1):
      drm/xe/lrc: document sentinel and make CTX_TIMESTAMP read TOCTOU-safe

Guangshuo Li (1):
      drm/radeon: fix autosuspend cleanup during teardown

Jia Yao (3):
      drm/xe/guc_ads: allocate UM queues in a separate BO
      drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
      drm/xe/guc_ads: use uncached mapping for UM queue BO

John Harrison (1):
      drm/connector/hdmi: Fix out of bounds memory read

Junrui Luo (1):
      drm/amdgpu: disallow multiple FENCE chunks in one submit

Lijo Lazar (1):
      drm/amdgpu: Prefer default discovery offset

Linmao Li (2):
      drm/xe/oa: Fix sync entry leak on OA config emit failure
      drm/xe/oa: Check managed mutex initialization errors

Lizhi Hou (1):
      accel/amdxdna: Skip unmapped range in aie2_populate_range()

Maarten Lankhorst (2):
      Merge remote-tracking branch 'drm/drm-fixes' into drm-misc-fixes
      drm/xe: Fix DPT allocation paths.

Matthew Brost (1):
      drm/xe: Order ring writes before ring tail updates

Nathan Lucas (2):
      drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix
      drm/amd/display: fix BT.2020 YCbCr output CSC matrices for DCE

Raag Jadav (1):
      drm/xe: Fix xe_device_probe() failure

Samuel Pitoiset (1):
      drm/amd/display: Fix NULL pointer dereference in
amdgpu_dm_crtc_set_vblank()

Shixiong Ou (3):
      drm/log: Fix division by zero when scale module parameter is 0
      drm/log: Fix out-of-bounds read on empty message length
      drm/log: Fix infinite loop when scale is too large for display

Tvrtko Ursulin (19):
      Revert "drm/sched: Remove drm_sched_init_args->num_rqs"
      Revert "drm/xe: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/v3d: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/sched: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/panthor: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/panfrost: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/nouveau: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/msm: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/lima: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/imagination: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/etnaviv: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/amdgpu: Remove drm_sched_init_args->num_rqs usage"
      Revert "accel/ethosu: Remove drm_sched_init_args->num_rqs usage"
      Revert "accel/rocket: Remove drm_sched_init_args->num_rqs usage"
      Revert "accel/amdxdna: Remove drm_sched_init_args->num_rqs usage"
      Revert "drm/sched: Embed run queue singleton into the scheduler"
      Revert "drm/sched: Remove FIFO and RR and simplify to a single run queue"
      Revert "drm/sched: Switch default policy to fair"
      drm/sched: Mark fair policy as experimental

Vinay Belgaumkar (1):
      drm/xe: Fix a bug in pc_adjust_freq_bounds()

Yang Wang (2):
      drm/amdgpu: check ASPM on the dGPU host link
      drm/amdgpu: fix nbif 6.3.1 l1 low power not functional

 drivers/accel/amdxdna/aie2_ctx.c                   |  17 +++
 drivers/accel/ethosu/ethosu_job.c                  |   1 +
 drivers/accel/rocket/rocket_job.c                  |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  51 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  13 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  21 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |  27 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  85 +++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           |  42 +++---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |  26 +++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  31 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |   7 +-
 .../drm/amd/display/dc/dce110/dce110_opp_csc_v.c   |   7 +-
 drivers/gpu/drm/clients/drm_log.c                  |  12 ++
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |   3 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |   1 +
 drivers/gpu/drm/imagination/pvr_queue.c            |   1 +
 drivers/gpu/drm/lima/lima_sched.c                  |   1 +
 drivers/gpu/drm/msm/msm_gem_vma.c                  |   1 +
 drivers/gpu/drm/msm/msm_ringbuffer.c               |   1 +
 drivers/gpu/drm/nouveau/nouveau_sched.c            |   1 +
 drivers/gpu/drm/panfrost/panfrost_job.c            |   1 +
 drivers/gpu/drm/panthor/panthor_mmu.c              |   1 +
 drivers/gpu/drm/panthor/panthor_sched.c            |   1 +
 drivers/gpu/drm/radeon/radeon_kms.c                |   1 +
 drivers/gpu/drm/scheduler/sched_entity.c           |  52 +++++--
 drivers/gpu/drm/scheduler/sched_fence.c            |   2 +-
 drivers/gpu/drm/scheduler/sched_internal.h         |  15 +-
 drivers/gpu/drm/scheduler/sched_main.c             | 121 +++++++++++++--
 drivers/gpu/drm/scheduler/sched_rq.c               |  89 +++++++----
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c   |   1 +
 drivers/gpu/drm/v3d/v3d_sched.c                    |   1 +
 drivers/gpu/drm/xe/display/xe_fb_pin.c             |  33 +----
 drivers/gpu/drm/xe/xe_bo.h                         |  14 ++
 drivers/gpu/drm/xe/xe_dep_scheduler.c              |   1 +
 drivers/gpu/drm/xe/xe_device.c                     |   6 +-
 drivers/gpu/drm/xe/xe_execlist.c                   |   1 +
 drivers/gpu/drm/xe/xe_gpu_scheduler.c              |   1 +
 drivers/gpu/drm/xe/xe_guc_ads.c                    |  93 ++++++++----
 drivers/gpu/drm/xe/xe_guc_ads_types.h              |   5 +
 drivers/gpu/drm/xe/xe_guc_pc.c                     |  13 +-
 drivers/gpu/drm/xe/xe_lrc.c                        |  29 +++-
 drivers/gpu/drm/xe/xe_lrc.h                        |   7 +
 drivers/gpu/drm/xe/xe_oa.c                         |  13 +-
 drivers/gpu/drm/xe/xe_pxp.c                        | 162 +++++++++++++++------
 drivers/gpu/drm/xe/xe_pxp_types.h                  |  27 +++-
 include/drm/gpu_scheduler.h                        |  42 +++++-
 54 files changed, 790 insertions(+), 336 deletions(-)
