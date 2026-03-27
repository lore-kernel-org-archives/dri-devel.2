Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF7310F2865
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 22:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC60610EF67;
	Fri, 27 Mar 2026 22:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YYCD7hWN";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A920310EF67
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 22:09:37 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8cbc593a67aso281304785a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 15:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774649376; cv=none;
 d=google.com; s=arc-20240605;
 b=IIiCsK8qGT3WMqrcSTiNPo1Ic7imLez6U98OZEQPIhZU7Q630XvQtMVwIuuNkFtoZT
 yiA85TJHVRbfvaLARTf7mIdcROS+pkwzS14x5dSBt2FbwGgt+/4TbkLbEfBu5N4C3WGt
 Sx0PbC5LYnx26tb8bVfsX4JZl7HJZDx4ASaJ2/t2YF7ZolwijBbsIx+3oBzUBCBQANsw
 uMoNTDKaAOQMUVGD7JzDdWbzgbA5qFi7h4HdXJnU37138SYixVSepzDtTsREd8rKku0v
 jZxM/CHBMgbzoD8ZB3fL1CPH/4l++wSBvweQbggTv5OIf9T6hAJA1Sk44ccSwKAKU8tw
 A0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=GmUbpSp5p2b4Tsquo/5jDoCgyOHnk+VEME/hc6fsE4E=;
 fh=A08XZwmmb57jzirbgTkluPSvjDeiJMkkojF1n6qDmTk=;
 b=K9IJskH3W+MAHbsiktYKmrg+qHVn5B3vvXAMetZIaVMhIJj4RKzDEXZdP/GmVkNwhw
 WBj+IeiQzGjoifgAhVReEKSF9SpDWvR/IdaBTqHOT5Xj4d0bdd5t4EDbT7p0F68qbU56
 21+y3LGzjGA4EreNGsdN0/BBe98Lu9yGxx1eSxliTNzxYK2IKYkjNCIIUvLhJjHPfbz6
 OhLFovFAS+AGb/ENXOYD3WvoSC5DouF0oeBdFfLyAg4B6b+0J3wmRA8hQhQqbAFkYIB1
 Rfz2hRxV06ueFHGIreMcDLlCt5PpjH+/ZGj1w1XVjRWkLX37phQjQI/nqPNBRen7BfUZ
 c1hw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774649376; x=1775254176; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GmUbpSp5p2b4Tsquo/5jDoCgyOHnk+VEME/hc6fsE4E=;
 b=YYCD7hWNely7B6sOYDKNJSZ1zNwkJCH7yOv7pDt39x9XelHjYI8MxW8nEpEg0QhSUF
 p7qY9mkNhfeluLBVyxtUMQra8YpPV7gIMCU5aQybzSAEE4wN4WfIp8wfeUbSFUdbI6zL
 GDiXyEG2yDhot/b+7TCZoF8r8rKd1oWwdFzM/0jBXJLl/b89cFRYqE8UpDVo+UTKaqde
 nhpT8/Y2XlV3iXCB3KW3DAysdu54TlfPbf8EJsXopdxzr8jy1PojDv5qMK0F3vw76lZi
 7xBhhxJKe96ckD0elp8vRZIP7CulE2U1UaGLYj8amSkxYy/I7YUFzOrWNvSa5IABAm/+
 kasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774649376; x=1775254176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmUbpSp5p2b4Tsquo/5jDoCgyOHnk+VEME/hc6fsE4E=;
 b=hx3KMyxPOlvqKJ2gT4FRASvr5IzqUGLq+To/2tgWos2SOBfkpZODnAi3RRYpa8jJpb
 5tdt+fqFPb+7B7rbzkftvvq9q8LsrMPS1huA52lM0gwyeuLEaUqoO1/jMxPt7a67Gk+N
 usXHegi5CUyhU4pcI7cvx/yzA6ssnD5emXBmzZSLAX+8DvrMdcY/Yu2+z+7W6edfWmgF
 lkeHMVSmHKir5wIi8Lw5qAmZdL4dpRsOJgjP12Rphyx5Cy1qTbmIOve7BJJA5YJUYoPA
 JJYoxs2PEd0N09abAFPKrIhEPT1L17I3sw6P2sOVxS6bdFV8GwLgaZvlODmiCdaYZMjx
 a2Pg==
X-Gm-Message-State: AOJu0YzRU5ztELgAXFfEyowlJsCi4c+ibPbeyCB0qcEEOG7X7/DrXJH2
 re54bvpKjC2tjtPvbEkrzn5kxGOFiamuH0Bha5PtzpyY6LHwhcC+rQ9vkA102CIA56b1rcJkbpk
 QnXnNFT9PQROI/YHQ0npexLwTcM4g8kA=
X-Gm-Gg: ATEYQzw76Y4nOdu6SVB/2h3gM6X9yqZ408MRWo4Hz859OBbAsthgdNo40o5vH+XhCOr
 ZrWBYWfKE3cruuIzzM7Wkg1QX7QGFpGfoo4NMILLxig8qgeqL7PcFZg6dDnO6f9vmw/wqD6Z0o8
 Nmq+KTGd96PYjUp68sBETvQ6XrStvdf+IyG9iN+CaP/YF2QwZbQXDcVKUO7WiolMr/AC0kIzGz1
 Rf/fWNHsihWaU0x+B8QoIMfzpSU8FFNY5y+ZxQgXK8nOy6DdpV41gnnxMgmsfkgT157XCoDQIUf
 EMz5vlbLF31QXawf1w39acDdCK0fsGykIDA8LnykyQucqmbXiGR9qhDMyTjD6jkj9E0=
X-Received: by 2002:a05:620a:4589:b0:8cd:6175:9b17 with SMTP id
 af79cd13be357-8d01c5bf3ffmr568252985a.3.1774649376315; Fri, 27 Mar 2026
 15:09:36 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 28 Mar 2026 08:09:25 +1000
X-Gm-Features: AQROBzA-VLtt2GlNNXTXUFpwpW4h3xD-uaAg78qnREalzCPIkGnoOYpfrA74I78
Message-ID: <CAPM=9tyArjCxangpgvhE2MrRdkSyWMrEJWDei4eX4EjFgW8uyw@mail.gmail.com>
Subject: [git pull] drm fixes for 7.0-rc6
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

Weekly fixes, still a bit busy, but the usual suspects amdgpu and
i915/xe have a bunch of small fixes, and otherwise it's just a few
minor driver fixes.

Regards,
Dave.

drm-fixes-2026-03-28-1:
drm fixes for 7.0-rc6

loognsoon:
- update MAINTAINERS

shmem:
- fault handler fix

syncobj:
- fix GFP flags

amdgpu:
- DSC fix
- Module parameter parsing fix
- PASID reuse fix
- drm_edid leak fix
- SMU 13.x fixes
- SMU 14.x fix
- Fence fix in amdgpu_amdkfd_submit_ib()
- LVDS fixes
- GPU page fault fix for non-4K pages

amdkfd:
- Ordering fix in kfd_ioctl_create_process()

i915/display:
- DP tunnel error handling fix
- Spurious GMBUS timeout fix
- Unlink NV12 planes earlier
- Order OP vs. timeout correctly in __wait_for()

xe:
- Fix UAF in SRIOV migration restore
- Updates to HW W/a
- VMBind remap fix

ivpu:
- poweroff fix

mediatek:
- fix register ordering
The following changes since commit c369299895a591d96745d6492d4888259b004a9e=
:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-03-28-1

for you to fetch changes up to 5ba61d8a25ddf89915f71bf8b63c06d6ffdf06cc:

  Merge tag 'mediatek-drm-fixes-20260323' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes (2026-03-28 08:05:36 +1000)

----------------------------------------------------------------
drm fixes for 7.0-rc6

loognsoon:
- update MAINTAINERS

shmem:
- fault handler fix

syncobj:
- fix GFP flags

amdgpu:
- DSC fix
- Module parameter parsing fix
- PASID reuse fix
- drm_edid leak fix
- SMU 13.x fixes
- SMU 14.x fix
- Fence fix in amdgpu_amdkfd_submit_ib()
- LVDS fixes
- GPU page fault fix for non-4K pages

amdkfd:
- Ordering fix in kfd_ioctl_create_process()

i915/display:
- DP tunnel error handling fix
- Spurious GMBUS timeout fix
- Unlink NV12 planes earlier
- Order OP vs. timeout correctly in __wait_for()

xe:
- Fix UAF in SRIOV migration restore
- Updates to HW W/a
- VMBind remap fix

ivpu:
- poweroff fix

mediatek:
- fix register ordering

----------------------------------------------------------------
Alex Deucher (2):
      drm/amd/display: check if ext_caps is valid in BL setup
      drm/amd/display: Fix DCE LVDS handling

Alex Hung (1):
      drm/amd/display: Fix drm_edid leak in amdgpu_dm

Asad Kamal (2):
      drm/amd/pm: Skip redundant UCLK restore in smu_v13_0_6
      drm/amd/pm: Return -EOPNOTSUPP for unsupported OD_MCLK on smu_v13_0_6

Dave Airlie (5):
      Merge tag 'amd-drm-fixes-7.0-2026-03-25' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2026-03-26' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-03-26' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-03-26' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'mediatek-drm-fixes-20260323' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes

Donet Tom (1):
      drm/amdgpu: Handle GPU page faults correctly on non-4K page systems

Eric Huang (1):
      drm/amdgpu: prevent immediate PASID reuse case

Imre Deak (1):
      drm/i915/dp_tunnel: Fix error handling when clearing stream BW
in atomic state

Jianmin Lv (1):
      MAINTAINERS: Update GPU driver maintainer information

Karol Wachowski (1):
      accel/ivpu: Add disable clock relinquish workaround for NVL-A0

Luca Leonardo Scorcia (1):
      drm/mediatek: dsi: Store driver data before invoking
mipi_dsi_host_register

Matt Roper (1):
      drm/xe: Implement recent spec updates to Wa_16025250150

Matthew Auld (1):
      drm/xe: always keep track of remap prev/next

Micha=C5=82 Winiarski (1):
      drm/xe/pf: Fix use-after-free in migration restore

Pedro Demarchi Gomes (1):
      drm/shmem-helper: Fix huge page mapping in fault handler

Ruijing Dong (1):
      drm/amdgpu: fix strsep() corrupting lockup_timeout on multi-GPU (v3)

Samasth Norway Ananda (1):
      drm/i915/gmbus: fix spurious timeout on 512-byte burst reads

Srinivasan Shanmugam (2):
      drm/amdgpu: Fix fence put before wait in amdgpu_amdkfd_submit_ib
      drm/amdkfd: Fix NULL pointer check order in kfd_ioctl_create_process

Tvrtko Ursulin (1):
      drm/syncobj: Fix xa_alloc allocation flags

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Order OP vs. timeout correctly in __wait_for()
      drm/i915: Unlink NV12 planes earlier

Yang Wang (2):
      drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid for smu=
 v13
      drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid for smu=
 v14

Yussuf Khalil (1):
      drm/amd/display: Do not skip unrelated mode changes in DSC validation

 MAINTAINERS                                        |  8 +++-
 drivers/accel/ivpu/ivpu_drv.h                      |  1 +
 drivers/accel/ivpu/ivpu_hw.c                       |  6 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 13 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            | 45 ++++++++++++++----=
--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  7 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  6 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 10 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  4 +-
 .../display/dc/resource/dce100/dce100_resource.c   |  6 +--
 .../display/dc/resource/dce110/dce110_resource.c   |  5 ++-
 .../display/dc/resource/dce112/dce112_resource.c   |  5 ++-
 .../display/dc/resource/dce120/dce120_resource.c   |  5 ++-
 .../amd/display/dc/resource/dce60/dce60_resource.c | 14 +++----
 .../amd/display/dc/resource/dce80/dce80_resource.c |  6 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 33 ++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 21 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 33 ++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   | 33 ++++++++++++++-
 drivers/gpu/drm/drm_gem_shmem_helper.c             | 48 ++++++++++++------=
----
 drivers/gpu/drm/drm_syncobj.c                      |  4 +-
 drivers/gpu/drm/i915/display/intel_display.c       |  8 +++-
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c     | 20 ++++++---
 drivers/gpu/drm/i915/display/intel_dp_tunnel.h     | 11 +++--
 drivers/gpu/drm/i915/display/intel_gmbus.c         |  4 +-
 drivers/gpu/drm/i915/display/intel_plane.c         | 11 ++++-
 drivers/gpu/drm/i915/i915_wait_util.h              |  2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |  9 ++--
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |  1 +
 drivers/gpu/drm/xe/xe_pt.c                         | 12 +++---
 drivers/gpu/drm/xe/xe_sriov_packet.c               |  2 +
 drivers/gpu/drm/xe/xe_vm.c                         | 22 ++++++++--
 drivers/gpu/drm/xe/xe_vm_types.h                   |  4 ++
 drivers/gpu/drm/xe/xe_wa.c                         |  3 +-
 37 files changed, 312 insertions(+), 116 deletions(-)
