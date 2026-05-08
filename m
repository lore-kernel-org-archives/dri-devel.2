Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02236CD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 08:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB6F10E5C0;
	Fri,  8 May 2026 08:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i+AeZ0+d";
	dkim-atps=neutral
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB2110E5C0
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 08:10:39 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8b6c9fdb68cso15338866d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 01:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778227838; cv=none;
 d=google.com; s=arc-20240605;
 b=SuXhJI6NFgDqGvJRw4AFwVxsy1j2zdhfhZ+Pw5+BedAOoT6n1MVwS2HTfWGiIDRg05
 KAMHDRERbv07HOZIwC+BhqVmstKXI1cPZWptf2FDwcDmy6WWNZIU+ULnFSsnO1rDd/nR
 eg/ItMV1Q/1fFyfbYUeLEn/VLoBJ65PoQQ1f58t/zYU3S+GFEvyTJMajOxSybdTjhSyY
 r98B0T7ubT3xMGCMgqQYy0TJJRaqnNSw9tpYJAg896G4eOXgOplBxIm/vc92q5WQBjob
 JbAk7N7CWehkA7f/L0/arGMiEwy4NPqTrGczp8KXgQ3fLtq1RjU4kM0hxvLjfNjT0Zz6
 dzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=70x4EHSDsFeXGT1tMeqNQOIz75/r+dfmtJOmc3ZiE+g=;
 fh=A08XZwmmb57jzirbgTkluPSvjDeiJMkkojF1n6qDmTk=;
 b=AVbRvXWcz+AcCn9nwAOP2aFMPYlic697h0jsDzu3FfJ39P16J50X4iAWsdW4cvumhM
 euhuusbJOt+6aRigssbQOuJi960e2MvdfmxXTuubY+SIkf/NKhu2CxyNB1gYQ/XLyBAZ
 NjLy5NliI4mJ+xwe3ndJ0y8FywT+r1WnR1qxlosZNWlWKto7z/fnCO4Qvp0QfNUVXt5D
 9yr43mtvm+P7VOzYzutvXJPcrM9zdXlKX/MIaIawe7ktTIfHf23/92DTKEuNY0iADe9M
 ZWJuQdRTGSQb31itd5fPMMYM6vLnepI7WlPi1c8s2Oyp6lbapti2ETxviW/3h6eYjG8b
 1bLQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778227838; x=1778832638; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=70x4EHSDsFeXGT1tMeqNQOIz75/r+dfmtJOmc3ZiE+g=;
 b=i+AeZ0+dW2ZMtYwdi23v/voN82Yg7RWrtFw797C515t78+H5I2GYaiBEDZYrUthmKa
 ORZW1lFiWil52OlwsVyCB80f02stq1kdZtm0WDbnYbN1ScSE9C6kn9xcdUKhQvdSpCTj
 fU1OSV2XNw+HltTRIZRhxZ6k4ZFP96hxGGFNJAHgxOu/vb7gate6sMdiQ97GOlFDiPyU
 uKWXwD3t4jExxr95hYIUwdwLcsFpYCLrFfGb1dy/zs60+OBQl5E3wPrvLo57a+E0eeTz
 YSBGadc0Hh7hKKGiQOvkOdgbYOFvrn2VnvX3+E4wHLTusZhKmIZMLia7dnB+hfw1bmWY
 zogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778227838; x=1778832638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70x4EHSDsFeXGT1tMeqNQOIz75/r+dfmtJOmc3ZiE+g=;
 b=dIortyYgBjZO/nTBm1nht/PZZj/Yl+4NV9CNbtlXlhV2+N/lvgzv96ABGjReDqN8P1
 cAmRkh5ivluNC0IHcMTwFBGZklrFiFGsly5s5aDI9fC2uwFTxNaqORXz42EpVOXJxSGf
 yZfJzxChdWQUSCL5QsYFdGBv9RS5O0m8pk2rioA7N2d+//9wOe7HGJHBvt+53PKKsbKs
 dLGgIhmaibSI0tt2465QUykjikxXvbA2ncQsqEVgz3pwEQp2Cj9I2DyWctPGB8pqoW8O
 INBtETUDt0HxXnNIgOVFVSuPBtp62W7f2xHuEKMb/ScRCCKT49+GDiPG2fofn/yjyJHG
 bJWg==
X-Gm-Message-State: AOJu0YxGdi8C9vZ44xlUAEgVORF1dyI+eiCNPyR0es32g6BFO2K6BAES
 Y0sy/OV1CTsfZWKbwAdrJOSlWvjR5ux6cKI8iSosRDCPx8u4PZmWvb/jsGslK5/DPX/DoWGbcdO
 gliLP4SNM4weZ2/wdQr8jhCGzu9CNI24=
X-Gm-Gg: Acq92OHn/y2OcNpHEEc8eNgT33PTIFat2AXf4FK27r4NSyQ8i1Cl5odYXGh4I7rPcxw
 W+ID/c8fYD2sXWZXg9d31L/3aAZGJ/Lsg5cSCJBaHhab+mtOLptseJeNUcj2Y8ZHTyoWJUtA4ij
 OILyRGPttEpS/uP6m7DOdl0VERJA6NBbHHirzxleavlbLIwizpKoNzrZ8lKhoffTgriqptQ32Dw
 kp5kA4gpj9gebSuUUtiTxObDqxH7wHRc5m4oASGRoD23OVEwO6JfQJwyoBTQPkSaZMMTg617+76
 KdYXkt3EJaXheeLAzXsgWnwb04wAGsEYcFE0uD2BoqK7e+G6Xyg3GS2091Dk4tqqDdm4XUL+rsE
 uQg==
X-Received: by 2002:a05:6214:19ec:b0:8bd:de6d:c341 with SMTP id
 6a1803df08f44-8bdde6dc718mr95905576d6.30.1778227838035; Fri, 08 May 2026
 01:10:38 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 8 May 2026 18:10:26 +1000
X-Gm-Features: AVHnY4KV8S77sfhj7lqSOQ16U3X0yQvhEQ8VJdLrtpMc6vyEcHESYDuHUwd_SXY
Message-ID: <CAPM=9tw+hnprz_uW=B3TprAfTgNMWzAEQgeCVrKvuqam8tirDg@mail.gmail.com>
Subject: [git pull] drm fixes for 7.1-rc3
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

Weekly fixes, lots of them but all pretty small, amdgpu and xe are the
usual but then a large amount of fixes all over.

Regards,
Dave.

drm-fixes-2026-05-08-1:
drm fixes for 7.1-rc3

core:
- fix race condition in handle change ioctl

fb-helper:
- fix clipping

rust:
- fix unsound initialization
- fix GEM state cleanup
- fix wrong ARef import

ttm:
- update GPU MM stats on pool shrinking

i915:
- Re-enable ccs modifiers on dg2

nova:
- fix mailing list

xe:
- Add NULL check for media_gt in intel_hdcp_gsc_check_status
- Fix EAGAIN sign in pf_migration_consume
- Fix MMIO access using PF view instead of VF view during migration
- Exclude indirect ring state page from ADS engine state size

amdgpu:
- GFX9 fixes
- Hawaii SMU fixes
- SDMA4 fix
- GART fix
- Userq fixes

amdkfd:
- GPUVM TLB flush fix
- Hotplug fix

radeon:
- Hawaii SMU fixes

bochs:
- fix managed cleanup

bridge:
- tda998x: fix sparse warnings on type correctness

etnaviv:
- schedule armed jobs

exynos:
- managed bridge cleanup

ivpu:
- disallow reexport of GEM buffer objects

noveau:
- revert support for GA100

panel:
- boe-tv101wum-nl16: use correct MIPI_DSI mode
- feyjang-fy07024di26a30d: fix error reporting
- himax-hx83102: use correct MIPI_DSI mode
- himax-hx83121a: fix error checks
- himax-hx83121a: select DRM_DISPLAY_DSC_HELPER

qaic:
- fix RAS message handling

qxl:
- clean up polling

sti:
- managed bridge cleanup
The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32=
:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-05-08-1

for you to fetch changes up to 5e28b7b94408897e41c63477aabc9e1db439bc8c:

  drm: Set old handle to NULL before prime swap in change_handle
(2026-05-08 17:53:59 +1000)

----------------------------------------------------------------
drm fixes for 7.1-rc3

core:
- fix race condition in handle change ioctl

fb-helper:
- fix clipping

rust:
- fix unsound initialization
- fix GEM state cleanup
- fix wrong ARef import

ttm:
- update GPU MM stats on pool shrinking

i915:
- Re-enable ccs modifiers on dg2

nova:
- fix mailing list

xe:
- Add NULL check for media_gt in intel_hdcp_gsc_check_status
- Fix EAGAIN sign in pf_migration_consume
- Fix MMIO access using PF view instead of VF view during migration
- Exclude indirect ring state page from ADS engine state size

amdgpu:
- GFX9 fixes
- Hawaii SMU fixes
- SDMA4 fix
- GART fix
- Userq fixes

amdkfd:
- GPUVM TLB flush fix
- Hotplug fix

radeon:
- Hawaii SMU fixes

bochs:
- fix managed cleanup

bridge:
- tda998x: fix sparse warnings on type correctness

etnaviv:
- schedule armed jobs

exynos:
- managed bridge cleanup

ivpu:
- disallow reexport of GEM buffer objects

noveau:
- revert support for GA100

panel:
- boe-tv101wum-nl16: use correct MIPI_DSI mode
- feyjang-fy07024di26a30d: fix error reporting
- himax-hx83102: use correct MIPI_DSI mode
- himax-hx83121a: fix error checks
- himax-hx83121a: select DRM_DISPLAY_DSC_HELPER

qaic:
- fix RAS message handling

qxl:
- clean up polling

sti:
- managed bridge cleanup

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu/pm: add missing revision check for CI
      drm/amdgpu/pm: align Hawaii mclk workaround with radeon
      drm/radeon: add missing revision check for CI

Alok Tiwari (1):
      accel/qaic: fix incorrect counter check in RAS message decode

Arnd Bergmann (1):
      drm/panel: hx83121a: select DRM_DISPLAY_DSC_HELPER

Chen Ni (1):
      drm/panel: himax-hx83121a: Fix incorrect error check for
devm_drm_panel_alloc()

Christian K=C3=B6nig (1):
      drm/amdgpu: nuke amdgpu_userq_fence_slab v2

Christian Van (1):
      drm/panel: feiyang-fy07024di26a30d: return display-on error

Danilo Krummrich (1):
      MAINTAINERS: nova: update mailing list

Dave Airlie (5):
      Merge tag 'drm-intel-fixes-2026-05-06' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-rust-fixes-2026-05-07' of
https://gitlab.freedesktop.org/drm/rust/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-05-07' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-05-07' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.1-2026-05-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Eliot Courtney (2):
      rust: drm: gem: clean up GEM state in init failure case
      rust: drm: fix unsound initialization in drm::Device::new

Felix Kuehling (1):
      drm/amdkfd: Make all TLB-flushes heavy-weight

Francesco Lavra (1):
      drm/fb-helper: Fix clipping when damage area spans a single scanline

Francis, David (1):
      drm: Set old handle to NULL before prime swap in change_handle

Gustavo Sousa (1):
      drm/xe/hdcp: Add NULL check for media_gt in intel_hdcp_gsc_check_stat=
us()

Icenowy Zheng (2):
      drm/panel: boe-tv101wum-nl6: restore MODE_LPM after sending disable c=
mds
      drm/panel: himax-hx83102: restore MODE_LPM after sending disable cmds

John B. Moore (2):
      drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check in KIQ
      drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fence emission

Juha-Pekka Heikkila (1):
      drm/i915/display: enable ccs modifiers on dg2

Karol Wachowski (1):
      accel/ivpu: Disallow re-exporting imported GEM objects

Kory Maincent (TI) (2):
      drm/bridge: tda998x: Use __be32 for audio port OF property pointer
      drm/bridge: tda998x: Return NULL instead of 0 in tda998x_edid_read()

Matthew Brost (1):
      drm/ttm: Fix GPU MM stats during pool shrinking

Ma=C3=ADra Canal (1):
      drm/etnaviv: Fix armed job not being pushed to the DRM scheduler

Mukesh Kumar Chaurasiya (IBM) (1):
      rust/drm: import ARef from sync crate

Myeonghun Pak (2):
      drm/qxl: Fix missing KMS poll cleanup
      drm/bochs: Drop manual put on probe error path

Osama Abdelkader (2):
      drm/sti: remove bridge when sti_hda component_add fails
      drm/exynos: remove bridge when component_add fails

Philip Yang (1):
      drm/amdgpu: zero-initialize GART table on allocation

Satyanarayana K V P (1):
      drm/xe/guc: Exclude indirect ring state page from ADS engine state si=
ze

Shuicheng Lin (2):
      drm/xe/pf: Fix EAGAIN sign in pf_migration_consume()
      drm/xe/pf: Fix MMIO access using PF view instead of VF view
during migration

Sunil Khatri (1):
      drm/amdgpu/userq: fix access to stale wptr mapping

Timur Tabi (1):
      Revert "drm/nouveau/gsp: add support for GA100"

Xiaogang Chen (1):
      drm/amdkfd: Check if there are kfd porcesses using adev by
kfd_processes_count

 MAINTAINERS                                        |  6 +-
 drivers/accel/ivpu/ivpu_drv.c                      | 21 +++++
 drivers/accel/qaic/qaic_ras.c                      |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 13 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           | 13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    | 28 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h    |  3 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  3 -
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         | 97 +++++++++---------=
----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 33 +-------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  4 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c    | 13 +--
 drivers/gpu/drm/bridge/tda998x_drv.c               |  4 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  2 +-
 drivers/gpu/drm/drm_gem.c                          | 25 +++++-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            | 16 ++--
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |  8 +-
 drivers/gpu/drm/i915/i915_driver.c                 |  5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  | 11 ++-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c    |  4 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c    | 18 ++--
 drivers/gpu/drm/panel/Kconfig                      |  1 +
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |  2 +
 .../gpu/drm/panel/panel-feiyang-fy07024di26a30d.c  |  4 +-
 drivers/gpu/drm/panel/panel-himax-hx83102.c        |  2 +
 drivers/gpu/drm/panel/panel-himax-hx83121a.c       |  4 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      |  6 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |  9 +-
 drivers/gpu/drm/sti/sti_hda.c                      |  8 +-
 drivers/gpu/drm/tiny/bochs.c                       | 10 +--
 drivers/gpu/drm/ttm/ttm_pool.c                     | 18 ++--
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c           | 12 ++-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_migration.c      |  8 +-
 drivers/gpu/drm/xe/xe_guc_ads.c                    |  5 +-
 drivers/gpu/drm/xe/xe_lrc.c                        | 11 ++-
 drivers/gpu/drm/xe/xe_lrc.h                        |  2 +-
 drivers/gpu/drm/xe/xe_sriov_pf_migration.c         |  7 +-
 rust/kernel/drm/device.rs                          | 22 +++--
 rust/kernel/drm/gem/mod.rs                         | 13 ++-
 rust/kernel/drm/gem/shmem.rs                       |  6 +-
 44 files changed, 254 insertions(+), 247 deletions(-)
