Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E69C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90FA910E041;
	Fri, 24 Jul 2026 21:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mTanqzqL";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D42E10E041
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:01:19 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-526f963372aso8200371cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784926878; cv=none;
 d=google.com; s=arc-20260327;
 b=InmxziZWTz63PXxTvZKgXQoxLDdSTW9T5AuUnbRoopL0GnbAmr/NcogQu8M6rA3b06
 TfXcZ4v5LiJbOnJOfHVZRg649VBNBA0+KGWyEQUtqHPpcR1FZWYtulGBvg65iT9u8D4K
 w4qjY09TMTaJXNDWPi+ltXUZeHZCJ+Wg9vuruC1NyNuDfYM7v75JuCuOZAxyypayPwFX
 IJgb6oBE5iToYLKyg2ffTka+d2tdovG+aa8TvtfBf4N+gUfUx7M1hKJHHRFvNtY7kcco
 /mTiAg4i3A1MiQtEebAD5bS1U7v7T6cFJYMEzyr3Vai/h3zCMt/clGCwe93FmYSPXz3Y
 ntVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=5puZIBvHdRHE0gPsIsCtcR7ubpFPHtDc+HSc8zDvRBg=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=qBHaKp6xRewwEjhUmTUs9PRLn6cXHUK/5QUC9+pMqUO39rGAEIgAxKKhEUSD35RIRg
 jaXSXdNLSYTN/8EiTDpoy9mmw6LLa+TAz/Ijb1IRMA6eaHG37J28DPVDlYPt8unhWr6Y
 +i6k4+icfG2izLQqsWYtWHaSv0hCKblCzNtKDOdY/T5ScIm3Px5D19aeEl/yV+QtBF9q
 3qCDlArChFZt4iIwO3uUAn5ku8g99mJuTenoLaFQ1TV6W2OOsGJofwLaFf0ceM3/y1oQ
 3tee495pSK1beNVvXBjHQbkl7PIrdPbfQUJUqkLhLvGmbyALWQq5FtMJCd8Fa6e6G62s
 EOQA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784926878; x=1785531678; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5puZIBvHdRHE0gPsIsCtcR7ubpFPHtDc+HSc8zDvRBg=;
 b=mTanqzqLpy3ytaywcqZOruY3ShRGRV625UTLPgRItqDBmf8ehaQQ1aC9LUI5iLWml5
 PV1gLOW2bq6HYpj7IusDjxn3rRQu6SeJL3z2lf8chKRIIpFgVGVlQ3xQ0L0hkmj+EMUR
 MDBLmr2Qc5VepeWvhI0zhJeC010JbmPdRtaOi4y4UetrWzzBPTjCcm21cmMWji/CznL2
 NTjgRuxam2cBKpSa13n6Z8uQokDmTds1F7YY2lX4D/7aHtZkkgg49SZWdh+juQVkLQpH
 6QttH1zQP5joXFpx+stWSa2VcI8JTZR0eCjioM8pPNWUW60tFJfOj1kuOZ/uPQ6yjJOS
 e/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784926878; x=1785531678;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5puZIBvHdRHE0gPsIsCtcR7ubpFPHtDc+HSc8zDvRBg=;
 b=X8EO8T54d5CVfgspmCyn5QOoLtngoljsC0Wke4yYKhdHDRXy6bRD86UlsD2YUjy4dr
 0IV5P+K0pnZot/NnmbpBlRW5zC/OeFM8lX48FyWcIxKOvBOkftu57ogat90o3HVBdczN
 jOExm9J8fdDUq8mDNZoNr1kkPmOkxE9UxGsCFIYnKwgdpznLuJN2BuOPoJTOqpu2PwUk
 BxkDN4sdI+3vZ1ynKLj1iNMwMxaRdbHCdQJzId9higtW7Dquz/ihW4xsc7RcZeClBUD5
 9STB2+APJxsc5WBeMsvFP1iGFTRVFBtJYujilplfYDnhGCCheFPV/5u4QvXhQ3i+vV4S
 SHIQ==
X-Gm-Message-State: AOJu0YyttNu9lPMN45dYTU4WNTVSBOWy0tZCBcX9E/spyn3x5BYuhJS0
 EklZhlTE9aQjkHsjDPqCGXF1YbFfyUDwGpiKUd0KO0bySBKM/vFZ6D6d8SUsznsnSne5jj5t1D9
 95hGbwRirfe6dkBPfMpZ9FFlCvkJPRo4=
X-Gm-Gg: AR+sD10tziFBN5CUgJyS/fGsrWaJyZES+GwpLvnm/e0esybr+ae3hgOA1cV1qrOT3w5
 RSqbtJOr4cLkoS8TgV2KG8oBEc/Esx/PmJ4AxWwq0n/yp+yC4R4eLUagEdz8bktifbQh/Nq0eNy
 XlcTeEeX3ozwo97TPZ6diOY5ksbetQCbgEPI7vENn80kyxaXSvJpm38K6ZXAMfZ5DwLOtfhPJeB
 LxhUWLwYC25QtG7dxV43TZwQhxnU+JHYvkQRq5BfNEvJOaU9PfiRvUOu9SRe9C/EFwfq7+BSSbh
 VgDf25WUekR1mnBYFhLexF65xxIQ/RRvVmZpkRbNFcR5eQg=
X-Received: by 2002:a05:622a:164e:b0:51f:798:cf23 with SMTP id
 d75a77b69052e-5283df62e39mr86504511cf.62.1784926871695; Fri, 24 Jul 2026
 14:01:11 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 25 Jul 2026 07:00:57 +1000
X-Gm-Features: AUfX_mzCRZJBeOszpuk-9GBNoYpXwWglLoVhdkkfL9iALHxAjetoM1vVZWDP0zk
Message-ID: <CAPM=9twoa3i8b3H5hLiJRdQeQ4X3n_mYtRXuoy9J=xtdHsq6bQ@mail.gmail.com>
Subject: [git pull] drm fixes for 7.2-rc5
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

Weekly drm pull request, small and scattered seems to be the new
normal, the ttm change is probably the largest, with xe being the
most. Alex was out this week so amdgpu is smaller and only has some
urgent fixes.

Regards,
Dave.

drm-fixes-2026-07-25:
drm fixes for 7.2-rc5

MAINTAINERS:
- update address

ttm:
- backup pages using correct order

gpusvm:
- fix mm leak on eviction
- properly zero page array in mm scanning

tests:
- fix dma mask errors in tests

panel:
- fix dependency issues
- ilitek-ili9881c - fix probing

i915:
- Remove DP_EDP_BACKLIGHT_AUX_ENABLE_CAP check for DPCD backlight

xe:
- Skip invalidation for purgeable state updates
- Add drm_dev guards when detaching CCS read / write buffers
- Alloc per domain unique i2c id
- Fix SVM leak on resv obj alloc failure in xe_vm_create

amdgpu:
- Fix a backport mistake for dm_gpureset_toggle_interrupts()
- Fix a failure on flip-done timeouts for mode1 reset

appletbdrm:
- fix issue in damage handling

amdxdna:
- fix command timeout race

imagination:
- fix gpu vm locking

vc4:
- prevent trusted bo from being mapped again
- prevent timer rearm on shutdown

v3d:
- fix NULL deref in unbind
- idle AXI before clock disable on suspend
- use proper GMP access for newer hw

vmwgfx:
- validate shader array size

ethosu:
- fix length calculations
- handle internal chaining buffers

gma500:
- return errors from HDMI i2c reads
The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f=
:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-07-25

for you to fetch changes up to 6c33542c01eac1ac4d5595c1ba2dace0e27e842d:

  Merge tag 'amd-drm-fixes-v7.2-2026-07-24' of
git://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux into
drm-fixes (2026-07-25 06:05:19 +1000)

----------------------------------------------------------------
drm fixes for 7.2-rc5

MAINTAINERS:
- update address

ttm:
- backup pages using correct order

gpusvm:
- fix mm leak on eviction
- properly zero page array in mm scanning

tests:
- fix dma mask errors in tests

panel:
- fix dependency issues
- ilitek-ili9881c - fix probing

i915:
- Remove DP_EDP_BACKLIGHT_AUX_ENABLE_CAP check for DPCD backlight

xe:
- Skip invalidation for purgeable state updates
- Add drm_dev guards when detaching CCS read / write buffers
- Alloc per domain unique i2c id
- Fix SVM leak on resv obj alloc failure in xe_vm_create

amdgpu:
- Fix a backport mistake for dm_gpureset_toggle_interrupts()
- Fix a failure on flip-done timeouts for mode1 reset

appletbdrm:
- fix issue in damage handling

amdxdna:
- fix command timeout race

imagination:
- fix gpu vm locking

vc4:
- prevent trusted bo from being mapped again
- prevent timer rearm on shutdown

v3d:
- fix NULL deref in unbind
- idle AXI before clock disable on suspend
- use proper GMP access for newer hw

vmwgfx:
- validate shader array size

ethosu:
- fix length calculations
- handle internal chaining buffers

gma500:
- return errors from HDMI i2c reads

----------------------------------------------------------------
Arvind Yadav (1):
      drm/xe/madvise: Skip invalidation for purgeable state updates

Dave Airlie (4):
      Merge tag 'drm-intel-fixes-2026-07-23' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-07-23' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-07-24' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-v7.2-2026-07-24' of
git://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux into
drm-fixes

David Oberhollenzer (1):
      drm/panel: ilitek-ili9881c: do not fail probe if iovcc is absent

Gregor Herburger (1):
      drm/vc4: hvs/v3d: Fix null dereference in unbind

Ian Forbes (1):
      drm/vmwgfx: Validate vmw_surface_metadata::array_size

Icenowy Zheng (1):
      drm/imagination: acquire vm_ctx->lock before mapping memory to GPU VM

Jos=C3=A9 Exp=C3=B3sito (1):
      drm/tests: shmem: Set DMA mask to 64-bit in drm_gem_shmem

Julian Braha (3):
      drm/panel: ilitek-ili9882t: fix unmet dependency for
DRM_PANEL_ILITEK_ILI9882T
      drm/panel: s6e3ha8: fix unmet dependency on DRM_DISPLAY_HELPER
      drm/panel: fix unmet dependency bug for DRM_PANEL_HIMAX_HX83121A

Leo Li (2):
      drm/amd/display: Fix flip-done timeouts on mode1 reset
      drm/amd/display: Fix missing DCE check in dm_gpureset_toggle_interrup=
ts()

Linmao Li (2):
      drm/vc4: Prevent shader BO mappings from becoming writable
      drm/vc4: Shut down BO cache timer before teardown

Maarten Lankhorst (1):
      Revert "drm/pagemap: Guard HPAGE_PMD_ORDER use with
CONFIG_ARCH_ENABLE_THP_MIGRATION"

Matthew Brost (4):
      drm/ttm/pool: back up at native page order
      drm/gpusvm: Fix MM reference leak in drm_gpusvm_range_evict
      drm/pagemap: Clear driver-provided PFNs from migration PFN array
      drm/pagemap: Guard HPAGE_PMD_ORDER use with
CONFIG_ARCH_ENABLE_THP_MIGRATION

Ma=C3=ADra Canal (3):
      mailmap: Update Ma=C3=ADra Canal's email address
      drm/v3d: Reach the GMP through the hub registers on V3D 7.x
      drm/v3d: Idle AXI transactions before disabling the clock on suspend

Pengpeng Hou (1):
      drm/gma500: return errors from Oaktrail HDMI I2C reads

Raag Jadav (1):
      drm/xe/i2c: Allow per domain unique id

Rob Herring (Arm) (2):
      accel: ethosu: Fix element size accounting for cmd stream validation
      accel: ethosu: Handle U85 internal chaining buffer

Satyanarayana K V P (1):
      drm/xe/vf: Add drm_dev guards when detaching CCS read/write buffers

Shuicheng Lin (1):
      drm/xe/vm: Fix SVM leak on resv obj alloc failure in xe_vm_create()

Stanislav Kinsburskii (1):
      drm/gpusvm: Zero HMM PFNs before scanning ranges

Suraj Kandpal (1):
      drm/i915/backlight: Remove DP_EDP_BACKLIGHT_AUX_ENABLE_CAP check
for DPCD backlight

Thomas Zimmermann (1):
      drm/appletbdrm: Allocate request/response buffers in begin_fb_access

Wendy Liang (1):
      accel/amdxdna: Fix command timeout race

 .mailmap                                           |   1 +
 drivers/accel/amdxdna/aie2_ctx.c                   |  26 +++--
 drivers/accel/amdxdna/aie2_pci.c                   |   1 +
 drivers/accel/amdxdna/aie2_pci.h                   |   7 +-
 drivers/accel/ethosu/ethosu_gem.c                  |  54 ++++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  13 ++-
 drivers/gpu/drm/drm_gpusvm.c                       |   6 +-
 drivers/gpu/drm/drm_pagemap.c                      |  11 +-
 drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c         |  21 +++-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |   7 +-
 drivers/gpu/drm/imagination/pvr_vm.c               |   2 +
 drivers/gpu/drm/panel/Kconfig                      |   3 +
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |   7 +-
 drivers/gpu/drm/tests/drm_gem_shmem_test.c         |  16 ++-
 drivers/gpu/drm/tiny/appletbdrm.c                  |  53 +++++----
 drivers/gpu/drm/ttm/ttm_backup.c                   | 123 ++++++++++++++---=
----
 drivers/gpu/drm/ttm/ttm_pool.c                     |  89 ++++++++++++---
 drivers/gpu/drm/ttm/ttm_pool_internal.h            |   8 ++
 drivers/gpu/drm/v3d/v3d_drv.h                      |   2 +
 drivers/gpu/drm/v3d/v3d_gem.c                      |  16 ++-
 drivers/gpu/drm/v3d/v3d_power.c                    |   7 ++
 drivers/gpu/drm/vc4/vc4_bo.c                       |  12 +-
 drivers/gpu/drm/vc4/vc4_hvs.c                      |   2 +-
 drivers/gpu/drm/vc4/vc4_v3d.c                      |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |  22 +++-
 drivers/gpu/drm/xe/xe_i2c.c                        |   5 +-
 drivers/gpu/drm/xe/xe_migrate.c                    |  16 ++-
 drivers/gpu/drm/xe/xe_migrate.h                    |   3 +-
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c               |  14 ++-
 drivers/gpu/drm/xe/xe_vm.c                         |   8 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c                 |  19 +++-
 include/drm/ttm/ttm_backup.h                       |  12 +-
 33 files changed, 418 insertions(+), 173 deletions(-)
