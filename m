Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D6CE7E35C
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE74A10F488;
	Fri,  3 Apr 2026 09:32:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BgdYFo6a";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6ECA10F488
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 09:32:50 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-50d6b9bca48so4026031cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 02:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775208769; cv=none;
 d=google.com; s=arc-20240605;
 b=bhvCOdXpftbxINbyW4WLaSg4p4jUD2/5q8sAxLksOZyWEuyVoSsgCKcxDzS8244+N6
 Q61mRbsGOZPBhhIyxn3JHvyAkw/6PxwVh0PaKAoK8MkuH5aGIjiKUGQg3BticssG1OBN
 zw1TOC+NBdJ96baL/GLfLciEH4aaFTAcNZZN+LBkFQ3PTufRZ9CgZhg3vnMNP7WlNn93
 nfRXKqj3RRWgO6d5/0Nv0fHG8ud3e86y90xMBKfX2z47YAy+0WP146e2v6xeYnZ8ueEW
 /TQuiKH8qcnCxqbM1la+0noow37AeFIj0s14ut2X+GBk9Z4R9t5l0PmR8vyLkLZw3Yc6
 7DLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=yxbtIRa2t2rc4pTtPgtuFWbHaqZDE/SQK7e3xhl2bbs=;
 fh=A08XZwmmb57jzirbgTkluPSvjDeiJMkkojF1n6qDmTk=;
 b=faLxeq9wwxnNe56FGR1vgHgStFslbHxnU4d3qyu1q41IQpEA6vORihRUoTKkuafMfe
 GGFp+3E4JsU+WQZljHkQr0uv4Gnb2rEr2/tD420gPqlB1EnpKP4q8O0tJC2bnQrbmE9D
 6JYsjOvWNkT5LMjniWa+44NKDj6e3Y9nvlvsXLc8xs7CG08lyrGJ9Xv4s9JfAWA5Ofql
 c+o/yw0EMdtnV+xm/uhy/0sTI3t/whhD6ve9pOK9rH5nJxML3LQVmHU055jIk1c/DtDT
 /SphFZm1YfFyLvI0LU8N/Z15uCzQXNeiHcF25+LHsgg1gOwnxiTa7mlJXLqxGA61Tn4Y
 qc2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775208769; x=1775813569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yxbtIRa2t2rc4pTtPgtuFWbHaqZDE/SQK7e3xhl2bbs=;
 b=BgdYFo6aUiJ+xPuzFQDFS2nvc0tDhNDyiAzuBMibOLqf71VgjSWBB5we2taZ+dV29G
 tHwJMJ/so+FwrEciqQHG9OmSLkioiEORpl0fKEX+EjU1e7mWI33Kh2ZpAoHzd6ZTbK91
 ElccjguDB20sZ8x3N8zwl80M2+CD/fj7oLMyjY9UMwKS5Rj6QsCgMeiA4b69zx1Wc2M4
 ifEMBIRfmgSYujgCisPuZEj7i8LIEAgqshNCPUpEvmsIYRpNl/Z4EBqfU9IpQbk3wefC
 +r+S2enCUw8JOGpDAJYAiJhLgmFDOsKzT9GyU/o9iXdOCWxL6SBFQ3YbDyysEgTPXIsw
 YmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775208769; x=1775813569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxbtIRa2t2rc4pTtPgtuFWbHaqZDE/SQK7e3xhl2bbs=;
 b=q0p3sFcAcgcLZVKsl41JJNxDRlDGuHiM0yDKKh+Iv0QS8A0O5TLQYmCy1cBTOIK8jS
 UGlc5Hk2lIrPjKQDHBxUY15oh+vAlR/Htj8VlJ6lCChdUULacp57fnQ0v2R/RZBfcTtO
 PUrSgiwBVGAU4fbXR6YouqTstkczhgkdkofLOPgmw7KovEY0wNbjJ1C80xDqs9IfpMws
 OF9PzgyUZ0EeSfVWm7f1McghufmN1eVPtYEfP9tG0xiL67Bqr8gmHMQSDscHVXcIBz6M
 Mz1jJ9uicwA6E00jifuKlvmWNxhrBWkPS+UFr4++AOHZI65uP77Fhxyup9/zOqEhcFEr
 3A8Q==
X-Gm-Message-State: AOJu0YwucG5M/bl/eLOL5PfLZ186z/9NKc0EAnHR7YsVUpxW9VhMaRlJ
 13PjNzxnsSDBnSAhosULhVw+6C9MXraoaCBMfD2//HWQCbWhnvMXIxAJ0Wd/r/tGa8Pg/luWSvE
 +KhZabqp9KphdrPtsfHm2SZRleDkoaqE=
X-Gm-Gg: ATEYQzye2tKH3pONVcB57afLrEJAzqJa8BAyAXN/vN6T/3LqKwh2mcOnJSFEbRIlQoB
 /81sUh8br1YXjFsp8TBDTSMYeZYxDkmFBvzH913ZMuDIT2DNelS6OjoZR6KeXbRaVGAJMxP4Bi5
 VU/HJ+QLHUGYo4T0Z5SmBq52WhRkqK1H67L84fZAAmWHaPnoNwQng/mWbOMv99OOPjQA3xCV1PJ
 qP7rF632FI05rBR9qzNyarpWeowCQnbh/nznuLinAuYr3kGTMn5pOEQYcFEmpw9+4Q8OSO8yxxK
 aPcXJFnWoiRiXy4ZoskSswO2pbhL6ljsv/s/95hhnuDV6vHRktkg6jSFa1m70w1jB80=
X-Received: by 2002:ac8:5a06:0:b0:50d:5b62:5ed4 with SMTP id
 d75a77b69052e-50d627587bdmr37399551cf.19.1775208769412; Fri, 03 Apr 2026
 02:32:49 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 3 Apr 2026 19:32:38 +1000
X-Gm-Features: AQROBzDny9zjBdKv5HsjRAh6R0bqwQPLuGKPoDB-IrEAz-LrQeClGUDM98tJalE
Message-ID: <CAPM=9tyDYx6BAWV_KzJJ2h3LfxvmNgBj0DqV4qfEz7XvChVjaA@mail.gmail.com>
Subject: [git pull] drm fixes for 7.0-rc7
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

Hopefully no Easter eggs in this bunch of fixes. Usual stuff across
the amd/intel with some misc bits. Thanks to Thorsten and Alex for
making sure a regression fix that was hanging around in process land
finally made it in, that is probably the biggest change in here.

Let me know if any issues,

Thanks,
Dave.

drm-fixes-2026-04-03:
drm fixes for 7.0-rc7

core:
- revert unplug/framebuffer fix as it caused problems
- compat ioctl speculation fix

bridge:
- refcounting fix

sysfb:
- error handling fix

amdgpu:
- fix renoir audio regression
- UserQ fixes
- PASID handling fix
- S4 fix for smu11 chips
- Misc small fixes

amdkfd:
- Non-4K page fixes

i915:
- Fix for #12045: Huawei Matebook E (DRR-WXX): Persistent Black Screen
on Boot with i915 and Gen11: Modesetting and Backlight Control
Malfunction
- Fix for #15826: i915: Raptor Lake-P [UHD Graphics] display
flicker/corruption on eDP panel
- Use crtc_state->enhanced_framing properly on ivb/hsw CPU eDP

xe:
- uapi: Accept canonical GPU addresses in xe_vm_madvise_ioctl
- Disallow writes to read-only VMAs
- PXP fixes
- Disable garbage collector work item on SVM close
- void memory allocations in xe_device_declare_wedged

qaic:
- hang fix

ast:
- initialisation fix
The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d=
:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-04-03

for you to fetch changes up to 75f53c4b2dbca831bf91e9befe06c9ad58f29352:

  Merge tag 'drm-misc-fixes-2026-04-02' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2026-04-03 19:07:43 +1000)

----------------------------------------------------------------
drm fixes for 7.0-rc7

core:
- revert unplug/framebuffer fix as it caused problems
- compat ioctl speculation fix

bridge:
- refcounting fix

sysfb:
- error handling fix

amdgpu:
- fix renoir audio regression
- UserQ fixes
- PASID handling fix
- S4 fix for smu11 chips
- Misc small fixes

amdkfd:
- Non-4K page fixes

i915:
- Fix for #12045: Huawei Matebook E (DRR-WXX): Persistent Black Screen
on Boot with i915 and Gen11: Modesetting and Backlight Control
Malfunction
- Fix for #15826: i915: Raptor Lake-P [UHD Graphics] display
flicker/corruption on eDP panel
- Use crtc_state->enhanced_framing properly on ivb/hsw CPU eDP

xe:
- uapi: Accept canonical GPU addresses in xe_vm_madvise_ioctl
- Disallow writes to read-only VMAs
- PXP fixes
- Disable garbage collector work item on SVM close
- void memory allocations in xe_device_declare_wedged

qaic:
- hang fix

ast:
- initialisation fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/pm: drop SMU driver if version not matched messages

Arvind Yadav (1):
      drm/xe/madvise: Accept canonical GPU addresses in xe_vm_madvise_ioctl

Chen Ni (1):
      drm/sysfb: Fix efidrm error handling and memory type mismatch

Daniele Ceraolo Spurio (4):
      drm/xe/pxp: Clean up termination status on failure
      drm/xe/pxp: Remove incorrect handling of impossible state during susp=
end
      drm/xe/pxp: Clear restart flag in pxp_start after jumping back
      drm/xe/pxp: Don't allow PXP on older PTL GSC FWs

Dave Airlie (5):
      Merge tag 'amd-drm-fixes-7.0-2026-04-01' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2026-04-02' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-04-02' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.0-2026-04-02' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2026-04-02' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Donet Tom (4):
      drm/amdkfd: Align expected_queue_size to PAGE_SIZE
      drm/amd: Fix MQD and control stack alignment for non-4K
      drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 64KB
      drm/amdkfd: Fix queue preemption/eviction failures by aligning
control stack size to GPU page size

Greg Kroah-Hartman (1):
      drm/ioc32: stop speculation on the drm_compat_ioctl path

Ionut Nechita (1):
      drm/amd/display: Wire up dcn10_dio_construct() for all
pre-DCN401 generations

Jonathan Cavitt (1):
      drm/xe/xe_pagefault: Disallow writes to read-only VMAs

Junrui Luo (2):
      drm/amdgpu: validate doorbell_offset in user queue creation
      drm/amdgpu/userq: fix memory leak in MQD creation error paths

Lijo Lazar (1):
      drm/amdgpu: Fix wait after reset sequence in S4

Liu Ying (1):
      drm/bridge: Fix refcount shown via debugfs for encoder_bridges_show()

Maarten Lankhorst (1):
      Revert "drm: Fix use-after-free on framebuffers and property
blobs when calling drm_dev_unplug"

Matthew Brost (2):
      drm/xe: Disable garbage collector work item on SVM close
      drm/xe: Avoid memory allocations in xe_device_declare_wedged()

Prike Liang (1):
      drm/amdgpu: fix the idr allocation flags

Srinivasan Shanmugam (1):
      drm/amd/display: Fix NULL pointer dereference in dcn401_init_hw()

Thomas Zimmermann (1):
      drm/ast: dp501: Fix initialization of SCU2C

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915/dsi: Don't do DSC horizontal timing adjustments in command m=
ode
      drm/i915/cdclk: Do the full CDCLK dance for min_voltage_level changes
      drm/i915/dp: Use crtc_state->enhanced_framing properly on ivb/hsw CPU=
 eDP

Youssef Samir (1):
      accel/qaic: Handle DBC deactivation if the owner went away

 drivers/accel/qaic/qaic_control.c                  | 47 ++++++++++++++++++=
-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  8 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           | 44 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h           |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 16 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         | 16 +++++--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    | 23 +++++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             | 11 +++--
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  | 17 ++++---
 .../amd/display/dc/resource/dcn10/dcn10_resource.c | 41 ++++++++++++++++
 .../amd/display/dc/resource/dcn20/dcn20_resource.c | 42 +++++++++++++++++
 .../display/dc/resource/dcn201/dcn201_resource.c   | 41 ++++++++++++++++
 .../amd/display/dc/resource/dcn21/dcn21_resource.c | 34 ++++++++++++++
 .../amd/display/dc/resource/dcn30/dcn30_resource.c | 42 +++++++++++++++++
 .../display/dc/resource/dcn301/dcn301_resource.c   | 42 +++++++++++++++++
 .../display/dc/resource/dcn302/dcn302_resource.c   | 41 ++++++++++++++++
 .../display/dc/resource/dcn303/dcn303_resource.c   | 41 ++++++++++++++++
 .../amd/display/dc/resource/dcn31/dcn31_resource.c | 40 ++++++++++++++++
 .../display/dc/resource/dcn314/dcn314_resource.c   | 40 ++++++++++++++++
 .../display/dc/resource/dcn315/dcn315_resource.c   | 40 ++++++++++++++++
 .../display/dc/resource/dcn316/dcn316_resource.c   | 40 ++++++++++++++++
 .../amd/display/dc/resource/dcn32/dcn32_resource.c | 43 +++++++++++++++++
 .../display/dc/resource/dcn321/dcn321_resource.c   | 43 +++++++++++++++++
 .../amd/display/dc/resource/dcn35/dcn35_resource.c | 43 +++++++++++++++++
 .../display/dc/resource/dcn351/dcn351_resource.c   | 43 +++++++++++++++++
 .../amd/display/dc/resource/dcn36/dcn36_resource.c | 43 +++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  1 -
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c     |  1 -
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |  1 -
 drivers/gpu/drm/ast/ast_dp501.c                    |  2 +-
 drivers/gpu/drm/drm_bridge.c                       | 16 +++++--
 drivers/gpu/drm/drm_file.c                         |  5 +-
 drivers/gpu/drm/drm_ioc32.c                        |  2 +
 drivers/gpu/drm/drm_mode_config.c                  |  9 ++--
 drivers/gpu/drm/i915/display/g4x_dp.c              |  2 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |  4 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         | 54 ++++++++++++++++++=
++++
 drivers/gpu/drm/sysfb/efidrm.c                     | 46 ++++++++++++------
 drivers/gpu/drm/xe/xe_device.c                     | 27 ++++++-----
 drivers/gpu/drm/xe/xe_pagefault.c                  |  6 +++
 drivers/gpu/drm/xe/xe_pxp.c                        | 23 ++++++---
 drivers/gpu/drm/xe/xe_svm.c                        |  2 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c                 | 16 +++++--
 48 files changed, 1013 insertions(+), 108 deletions(-)
