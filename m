Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD3DCA9EC0
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 19:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A7D10E08A;
	Sat, 10 Oct 2026 19:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DGU5FcS2";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E883310E08A
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 19:23:29 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-5339381b46eso8270581cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 12:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791660209; cv=none;
 d=google.com; s=arc-20260327;
 b=LcXmSY+pA1malXlaqqQOD76wT+V6HlReFYMA3KBKCEIUDaOD7r63eyFD5W0gu4ahms
 TidXSQ8vJ2k7p8RT8mBCR8mvYv/b7EzMbvM2VunsG3EBIc0TSZVPymlNp3g6DcKzwH/q
 4f25s8lelutJCB+AAp5RN5A4mJUkSWKlgiQOYRLay9kRtPUsBOQoIZk1meMUibWBBzK8
 edyl2ffga89o19rIQfva7yMOeH8irVIPr6381n9Qa92M0M7zCSyZVHBaqD824QVfN7Oz
 w5yBXBiyWNCYRxAC2TThUABkLJTPpLEkGZj0//3jhO2EnOFIb9aiS913l6Qn7CwV1JSd
 34Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=y9a+TyL1ZUr2gWay3ENBMoj2LAgkfvRENCAy64d5+8I=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=bYKugs7uShgepfu7oTAf736f/GPrTfoYphcu/Z9nhoc0fgZ3NsZka70YSDyw+fT81u
 t6lSHq6mCUaPyfUCz6U7kNSy1XnsVZIrAq3gkPlwu8d/s3tckxfsOlVeEXTIu7NKKGNl
 ZMMfHMB8zWSQShLj3M+b7LhFemqe+Yqd7aHjibfGCXaKjlNR2fnMyh8tFkNC+J5A9r86
 30EOux3Cd54fXikoZLWOnP0145arQCS4c0Ja1Mh7b9VkTx1/DATGdxDphlkNbEAbTyxu
 cWuQyVfEm+HAepfMvsihsxOEmxuMyr3xgZ7StmXuqU0xgePDrMfaJY8PuatYOzUbda/R
 BEPw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791660209; x=1792265009; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y9a+TyL1ZUr2gWay3ENBMoj2LAgkfvRENCAy64d5+8I=;
 b=DGU5FcS2Nuq8NqMYeOHbuDT1SHL+NacK9nRt51ejvfbffFEmepwlmxt7vlP6WLqlkf
 scu664NxThqFqU2GnddQQbqqwuRDJmymAvz0zq2gtjzifA5Us8FvBmhEmW5vUS6pqypt
 LxjiGfZgIMQjkmG4D7Q8U7LEzcFsVVyi+NfWZUtutkZillsy4cOcd5wnSh0HTfD1BNxg
 aiYUOVEDQp/U6/i1O5lQ80am+pl9ZunuZCgNvarKzAuvApClShylU2fPsn4aCBCFHEUM
 Vxm3idX53DVAzEU3z7ND+nZjoFhJaeyKjr9wdJLj6fbLhVZUuJRXudvEa/YuLBS79kz6
 o0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791660209; x=1792265009;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y9a+TyL1ZUr2gWay3ENBMoj2LAgkfvRENCAy64d5+8I=;
 b=gXEKt2saEIoQUU6yM8WtytWlOqEz/gV0H2sDASPjfAeCzmXrEN3/ilnaNUdqR1U+LO
 CMj9mnzZgnu5vrjzp4jFTxJj/TyjIlBw8/9HKsMOud75s5l9RmYH5nvXMKxi3clvj9Xm
 lC/c5HXsONagkKiR+8tLBsLJjUliVb4OUb18MU8lA0tjVHWXSQu4y2bpAdztXS4I2507
 tBi2LlDdHocXHvTawyeEfCDYEJ7BwZcJ1P3yMUVeCJY9mEQr/GhoRhOaDkh2vhHg4Khx
 V1E/GmxuGCCZX6hEK/4FZYehib0k6LLcCNuK1rFcZH45LiJF+EZRUvEQE1VPbUKeBRak
 U0dg==
X-Gm-Message-State: AFq9FYLVQVx0/sudhCOVUmlxHyg948jy1yTnqFIpt9OGFIXFLLHH65tn
 WlqxMXvxf7HFawQdxpm1Br5Sp3UP0onB9fWSxUEXSdzol1bGVK5/lZnBMFRH4KUMuLFamOQ+JUj
 o2V8/sV85J07O+hPio2TrZtT3Juaesnc=
X-Gm-Gg: AYBFou04Scms7EwtucTmtiQpjwSnr4QrPwpQL34B08oIfARJ9pTswPrhmRjJdzusO7X
 UVd6ZijyQNxaogo1kLQaMX2R8tjFaEg9c+l7Psbv+nXhuvUpuYLyu9RiCGJAEGa81PMx55lxVHR
 QfdleUKx6Nm8X7nfqKPLXvrQRPMR/Yl3ZkB8s7nPtXTvt+Oya/YeLTewQw2bSJdgQmQpTYHSYyF
 uiWiGtxCL1qd0ED98MUemUvKNWoUmkhVPjzfC+1JQkf8fFB6ciBNR7fizXQPu0hYBaR4nYDxC3F
 RUoNV10YRrk+Qx2k5T/S4KiirUawMCEhNMvMJj+/2GZa2SfEry8bRBf86BDYHerM0FUUSdUWMo/
 KIVyl0fG35EvebYNXWIeLyMgxnbyrLOeoBgnfhAOn+jw=
X-Received: by 2002:a05:622a:447:b0:535:8559:f0f5 with SMTP id
 d75a77b69052e-5359facb683mr91855031cf.12.1791660208737; Sat, 10 Oct 2026
 12:23:28 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 10 Oct 2026 21:23:16 +0200
X-Gm-Features: AclHuK8j-BoreS8uhuzdDAlfJEdFk7nCvMvRxLKTOgifniCXrJep_EfcUlgLcyc
Message-ID: <CAPM=9ty-Gh9_5sqdFzz6gVvvVjQ4erOSEg_bm8S9a5O4Seu7Nw@mail.gmail.com>
Subject: [git pull] drm fixes for 7.3-rc7
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

Live from Dublin Airport, it's Saturday Night drm fixes. This week has
the missing misc fixes from last week which I tracked down and seemed
to be a race/bug in my lei setup somehow, once I asked lei to ignore
it's cache I got the missing email. But there are more misc fixes this
week and amd and intel ones.

The main ones in this are amdgpu and xe, with vc4, vmwgfx, nouveau and
imagination in the middle, with a bunch of small single fixes.

Bit busier than I'd like, but the missing misc might explain it,
anyways time for me to fly home.

Dave.

drm-fixes-2026-10-11:
drm fixes for 7.3-rc7

fb:
- defer setup when fbdev_probe() fails, not just on -EAGAIN

bridge:
- Fix unlocked list_del in drm_bridge_add()
- Fix unlocked list access in drm_bridge_attach()
- th1520-dw-hdmi: Fix error check on dw_hdmi_probe() return value
- th1520-dw-hdmi: Fix remove() callback

aspeed:
- Balance the display clock enable on teardown

i915:
- Fix a GT park race that could trigger spurious RPM wakelock warnings
- Fix execbuffer relocation cleanup to avoid out-of-bounds free

xe:
- i2c removal
- system Controller Maibox header handling
- two bo pin/unpin accounting bugs
- not emitting a w/a twice
- xe_mmio_wait32() to honor delay/sleep maximums

amdgpu:
- Fix direct scanout alpha on some DRM_FORMATs
- UserQ fixes
- Fix tearing flips with PSR
- GPU reset vblank fix
- Debugfs register interface fix
- Fix display mode patching
- Expand Mac reserved memory workaround

amdkfd:
- SDMA doorbell fix
- Fix dma-buf reference leak in error path

imagination:
- fix reference and vm_bo handling in remap()
- size page table preallocation by device address

gud:
- don't keep a connector without a CRTC as connector_state

panthor:
- validate userspace queue count against initialized firmware slot count

nouveau:
- fix null ptr regression
- skip turing CE workaround for non-GR

vmwgfx:
- validate pitch value
- add blend mode property

vc4:
- drain hangcheck timer on unbind
- free BO cache on teardown
- use kvmalloc_objs for bo cache size list
- disable V3D interrupt across runtime suspend
- fix binner slot allocation
- fix fw refcount leak
The following changes since commit a90ee4305c4a5df72c11b31dacfdc76e00fcf78a=
:

  Linux 7.3-rc6 (2026-10-04 13:45:25 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-10-11

for you to fetch changes up to c61e23ed14359e6289c08e55940dd3401fe27db0:

  Merge tag 'drm-misc-fixes-2026-10-09' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2026-10-11 04:58:03 +1000)

----------------------------------------------------------------
drm fixes for 7.3-rc7

fb:
- defer setup when fbdev_probe() fails, not just on -EAGAIN

bridge:
- Fix unlocked list_del in drm_bridge_add()
- Fix unlocked list access in drm_bridge_attach()
- th1520-dw-hdmi: Fix error check on dw_hdmi_probe() return value
- th1520-dw-hdmi: Fix remove() callback

aspeed:
- Balance the display clock enable on teardown

i915:
- Fix a GT park race that could trigger spurious RPM wakelock warnings
- Fix execbuffer relocation cleanup to avoid out-of-bounds free

xe:
- i2c removal
- system Controller Maibox header handling
- two bo pin/unpin accounting bugs
- not emitting a w/a twice
- xe_mmio_wait32() to honor delay/sleep maximums

amdgpu:
- Fix direct scanout alpha on some DRM_FORMATs
- UserQ fixes
- Fix tearing flips with PSR
- GPU reset vblank fix
- Debugfs register interface fix
- Fix display mode patching
- Expand Mac reserved memory workaround

amdkfd:
- SDMA doorbell fix
- Fix dma-buf reference leak in error path

imagination:
- fix reference and vm_bo handling in remap()
- size page table preallocation by device address

gud:
- don't keep a connector without a CRTC as connector_state

panthor:
- validate userspace queue count against initialized firmware slot count

nouveau:
- fix null ptr regression
- skip turing CE workaround for non-GR

vmwgfx:
- validate pitch value
- add blend mode property

vc4:
- drain hangcheck timer on unbind
- free BO cache on teardown
- use kvmalloc_objs for bo cache size list
- disable V3D interrupt across runtime suspend
- fix binner slot allocation
- fix fw refcount leak

----------------------------------------------------------------
Adrian Betschart (1):
      drm/amd/display: Don't replace a sink mode that shares the native tot=
als

Alan Previn (1):
      drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums

Alex Deucher (1):
      drm/amdgpu: make Mac FB workaround generic

Cristian Ciocaltea (2):
      drm/bridge: Fix unlocked list_del in drm_bridge_add()
      drm/bridge: Fix unlocked list access in drm_bridge_attach()

Dave Airlie (6):
      nouveau: check gsp->rm as well as gsp pointer before gcx ready
      Merge tag 'drm-misc-fixes-2026-10-01' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2026-10-08' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-10-08' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.3-2026-10-08' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-10-09' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Fan Wu (2):
      drm/vc4: drain the hangcheck timer and works on V3D unbind
      drm/xe/i2c: cancel the client work on remove

Felix Gu (2):
      drm/bridge: th1520-dw-hdmi: Fix error check on dw_hdmi_probe()
return value
      drm/bridge: th1520-dw-hdmi: Fix remove() callback

Gyeyoung Baek (2):
      drm/imagination: Fix reference and vm_bo handling in remap()
      drm/imagination: Size page table preallocation by device address

Haojie Li (1):
      drm/amdkfd: fix dma_buf reference leak in get_dmabuf_info

Ian Forbes (1):
      drm/vmwgfx: Add blend mode property

Jesse Zhang (2):
      drm/amdgpu/userq: only accept doorbell BOs as queue doorbell
      drm/amdgpu/userq: return the memdup_user() error for the user MQD

Krzysztof Karas (2):
      drm/i915/gem: Prevent overstepping exec array boundary
      drm/i915/gt: Unmask interrupts only when ACTIVE is true

Leo Li (2):
      drm/amd/display: Fix direct scanout alpha on some DRM_FORMATs
      drm/amd/display: disable self-refresh on tearing flips

Mallesh Koujalagi (1):
      drm/xe/sysctrl: Fix mailbox header handling

Mary Guillemard (1):
      drm/nouveau: Skip the Turing CE workaround object for non-GR channels

Ma=C3=ADra Canal (4):
      drm/vc4: Free the BO cache size list on teardown
      drm/vc4: Use kvmalloc_objs() for the BO cache size list
      drm/vc4: Disable the V3D interrupt across runtime suspend
      drm/vc4: Fix binner slot allocation failing on an idle GPU

Mikhail Gavrilov (1):
      drm/amdgpu: copy debugfs register data outside the GRBM/SRBM locks

Myeonghun Pak (1):
      drm/aspeed: Balance the display clock enable on teardown

Nguyen Ngoc Thang (1):
      drm/fb-helper: defer setup when fbdev_probe() fails, not just on -EAG=
AIN

Oleg Keri (1):
      drm/dp: don't mark the AUX backlight enabled when enabling failed

Osama Abdelkader (1):
      drm/panthor: validate userspace queue count against initialized
firmware slot count

Sajal Gupta (1):
      drm/gud: don't keep a connector without a CRTC as connector_state

Saleel Kudchadker (1):
      drm/amdkfd: align SDMA doorbell base for shader doorbell writes

Thomas Hellstr=C3=B6m (2):
      drm/xe: Fix shrinker accounting double-subtraction on nested external=
 pins
      drm/xe: Fix stale pinned_link entry when fb-pin performs the final un=
pin

Tvrtko Ursulin (1):
      drm/xe: Do not emit Wa_16010904313 twice

Vitaly Prosyak (1):
      drm/amdgpu: serialize vblank counter reads against GPU reset

Wentao Liang (1):
      drm/vc4: Fix firmware reference leak in vc4_drm_bind()

Zack Rusin (1):
      drm/vmwgfx: validate pitch coming from userspace

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  77 +++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  17 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  13 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |   9 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  32 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   7 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  19 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  20 +--
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |  42 +++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |   5 +-
 drivers/gpu/drm/bridge/th1520-dw-hdmi.c            |   8 +-
 drivers/gpu/drm/display/drm_dp_helper.c            |   4 +-
 drivers/gpu/drm/drm_bridge.c                       |   8 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   6 +-
 drivers/gpu/drm/gud/gud_pipe.c                     |   1 +
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |   2 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |   3 +-
 drivers/gpu/drm/imagination/pvr_mmu.c              |  25 ++--
 drivers/gpu/drm/imagination/pvr_vm.c               |   8 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c  |   2 +-
 drivers/gpu/drm/panthor/panthor_sched.c            |   3 +
 drivers/gpu/drm/vc4/vc4_bo.c                       |   5 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |   5 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |   2 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |   8 +-
 drivers/gpu/drm/vc4/vc4_irq.c                      |  24 ++--
 drivers/gpu/drm/vc4/vc4_v3d.c                      |  65 +++++-----
 drivers/gpu/drm/vc4/vc4_validate.c                 |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c       |  26 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   8 ++
 drivers/gpu/drm/xe/display/xe_fb_pin.c             |   6 +-
 drivers/gpu/drm/xe/xe_bo.c                         | 139 ++++++++++++++++-=
----
 drivers/gpu/drm/xe/xe_bo.h                         |   2 +
 drivers/gpu/drm/xe/xe_i2c.c                        |   5 +-
 drivers/gpu/drm/xe/xe_lrc.c                        |  38 ++++--
 drivers/gpu/drm/xe/xe_mmio.c                       |   5 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c            |  16 +--
 41 files changed, 461 insertions(+), 228 deletions(-)
