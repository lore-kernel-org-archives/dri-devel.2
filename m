Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A74CCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 22:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0532C10E167;
	Fri, 16 Oct 2026 22:02:37 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F5310E167
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 22:02:30 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-917b78dfe30so5867396d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 15:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792188150; cv=none;
 d=google.com; s=arc-20260327;
 b=l2uT03VGDd5D769OxxhuxBywwK+o0jR8MLgaMxLVx4aAHFNp6VQNG6gvWcbGRS5XiC
 u/v//C3hUItRkG50PdMs+dt8dgCbXOm5lSLx+rV9Cn9LS2QysOgUrjsnWcGPga5s+UB4
 0m9fN7/ytftwFxRm8tKQjsXGNkizuwR5y6YMr/NS4stli+Yet7AAjojENJbnYyjRwUlZ
 WFLYV9TI3Di6YZ8IxkK7y0vpFpg9sW78oUGlHbzfoRGFQJuBRw73v3lkFqocMiTEhQYl
 mOxXZ/VR9rwjNPUMd0WDsIRRKWfg7RTf2f206r3uXt8yyG9kroCvTPtlswx1Pvhs1qKh
 D92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=ne8c5V/AfxPlCOWHa/ykZPcK1xAAPofEMVR3nTOUv1A=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=AKP+09Gu112KMmxbk5GBTs9nZ+fHbHgXvDu6TeH9qDXBdIRSbnQ3tfUZuMhgDejXg2
 c8QMLnyIUcN646/emzadhfTKbj9cEYNBq6QaFBrBTZQRyUhHlVTuUhGV4luNYmWAnUe5
 lXHFe7X3NFeQVzXJdErxsHZUw3e4PUHZrPQ5AVgD4zeniuEe4976hdM0P9L+TjnmEj9h
 wwXufnth/y5sjVUXqa70WYEIkcJygytiDvvkBdYM1+YcV4z/AW4JQw+8ijoYHl0Hq+Dk
 wCsZlUxwnMVBsyxClTj6xpi486S/xdUaiwYXVTt3Rv1qcO6fzS3HkG/FC9lXZ2gS3b1B
 gUew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792188150; x=1792792950; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ne8c5V/AfxPlCOWHa/ykZPcK1xAAPofEMVR3nTOUv1A=;
 b=Ibhb7OoHK8VbzEpOVef2vM9a4CpjFbbiHzFs0WcKov6BBFyJePTxH+UCwcGtZ6UhbR
 ZV6RVdrrrys4wB84kbEuDSSNIif9teIF59txWpJ5rVU71VWfqqvpgdIjm1bbUOg/oOek
 YqLlx1T/3kspkBO50NFy/4Lv2Ocb43eNdRdExzSreVFS0Ld4fSGQTNFFNbjDLB/GBkV0
 npBYvcxt8ZzeDSWShgjj540EfpwO/M7JC50wIKvi8my3U2ut0zfboGhPxZQjgTdAaw8b
 HpaBjDcUxp1fRXI3IrW5sORjMKXl4utN0+ZGHayYhgBx9DAMzGFMujv+V3vFlQv3/l6m
 GFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792188150; x=1792792950;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ne8c5V/AfxPlCOWHa/ykZPcK1xAAPofEMVR3nTOUv1A=;
 b=RMEsH61w1B1KXVTA18vM5DaVFKWLM1c4hV67eR7wcvLm/Om+mF1ule68peWCo2JJDk
 WvXNF0GIgSuN8xxt/gM4fj+5rRAY8CwHU5gjfPCdUop4/GLiRH/5gSR6QjiutOL7XQyT
 wnvoJ5Rf98M6R9KFcjY6YuEpfXFHJ3BFSt0OOa+N4LSmOcqVC2CRS7EzuHSwvrwc7lzk
 Zd4xnd9rBplGMGe8IFWyZVhcI+0Da+ypp2iO9VqhIG6+CNMjehIM6eeQqaVGn8PfTXRS
 D3DKZ9qMu5uP2PfQXayfiHNktQ7kvRhZTy60Yc+y3dNR9TgC+damqnlq3+k0wlAFx5wh
 NIbA==
X-Gm-Message-State: AFq9FYJO9Jc3urwngBg3EECkyXHWB71mnRbOsX7reIKZsWZ+DjnJlDV3
 LlqdS6i23zlp73fOQwi4s2U2il4htYDpN+mgzbzksspWbRQ1xM+OT4QuqaG8Ruj3HASjv4yL8pX
 c4FHmS1ufwg+oQFjEl+1vu/rI7+T3IDw=
X-Gm-Gg: AYBFou3eJ4N0RahqXBt0KJF1yXgEqUNV/RpovPqjyEU3jWHZDTrPUDDAUdnz5z8BoPe
 qmlYSv7F3V99m9zghiaFTXHj5oDlUC0BxlQicsR8LI+5WpPX7Ov0COquTB6owlE5UmpEfj1RaNR
 C2zaDvL4S/ohaJsjUA/AdkAbOOO19VFebYWLhbIRS/vDo84QmDMr7fH4dSKsG3hPXH0SO9MPbiK
 aHUobOVP1W5scgtohh8+JaDqtZd08iBuiAYQ28cRA3pzjY5kb7RlETXPYTcbEOIMTJWGDgYObCv
 a66GQMSkjuGYRBAm02NcU+JYAXGoEqDhtmMQDIbWLzuEVD17vFzMZqD1Io+zYrxcok7p7dR9prG
 67Q7b3C4ADn+44o5W+VqC/97YQN4TuFHNo0zy/2uv
X-Received: by 2002:a05:620a:2609:b0:93e:7dfa:2f3f with SMTP id
 af79cd13be357-93f29d9614cmr215421485a.62.1792188149594; Fri, 16 Oct 2026
 15:02:29 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 17 Oct 2026 08:02:17 +1000
X-Gm-Features: AclHuK9FrmJmWHNbTalVbIQ6Jj0K1MjeWwWf28VCCnLfBjAm_jRBOTkZeqjz3gQ
Message-ID: <CAPM=9tz6wzOBn8o_xgpKkstWwUem0tGzau544TETtuiNthN1KQ@mail.gmail.com>
Subject: [git pull] drm fixes for 7.3 final
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

Last set of fixes, mostly amdgpu, some i915 and xe, I think the
dma-buf revert is probably the most important, while technically
correct the fallout from it, means we shouldn't do it now and fix the
fallout first.

Dave.

drm-fixes-2026-10-17:
drm fixes for 7.3 final

MAINTAINERS update

dma-buf:
- revert dma-debug y on debug kernel due to msm interaction

core:
- fix drm_exec prelocked object interaction

i915:
- Fix ARL-S host bridge detection
- Add sanity checks for malformed DMC firmware

xe:
- OA uAPI fix
- shrinker fix
- fix eviction of object with no bo resource
- fix LRU for external objects

amdgpu:
- UVD fix
- TTM sched entity fixes
- SMU 14 fix
- Userptr leak fixes
- Runpm ref count fix
- CRIU fix
- UserQ fixes
- USB4 fix
- SDMA 3 fix

virtio-gpu:
- revert double setting blend property
- reset device before deleting vqs on freeze

vc4:
- fix hdmi audio runtime_pm interaction

amdxdna:
- fix Kconfig invalid configuration

rocket:
- fix error path for failed init
- fix core unbinding and scheduler lookup paths

panthor:
- fix immortalis configuration
The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907=
:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-10-17

for you to fetch changes up to f91a4ac69629e1479745e82100863157e6967ec0:

  Merge tag 'amd-drm-fixes-7.3-2026-10-15' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes
(2026-10-16 18:37:24 +1000)

----------------------------------------------------------------
drm fixes for 7.3 final

MAINTAINERS update

dma-buf:
- revert dma-debug y on debug kernel due to msm interaction

core:
- fix drm_exec prelocked object interaction

i915:
- Fix ARL-S host bridge detection
- Add sanity checks for malformed DMC firmware

xe:
- OA uAPI fix
- shrinker fix
- fix eviction of object with no bo resource
- fix LRU for external objects

amdgpu:
- UVD fix
- TTM sched entity fixes
- SMU 14 fix
- Userptr leak fixes
- Runpm ref count fix
- CRIU fix
- UserQ fixes
- USB4 fix
- SDMA 3 fix

virtio-gpu:
- revert double setting blend property
- reset device before deleting vqs on freeze

vc4:
- fix hdmi audio runtime_pm interaction

amdxdna:
- fix Kconfig invalid configuration

rocket:
- fix error path for failed init
- fix core unbinding and scheduler lookup paths

panthor:
- fix immortalis configuration

----------------------------------------------------------------
Andy Yan (1):
      MAINTAINERS: update my email address

Benjamin Cheng (1):
      drm/amdgpu/userq: actually validate userq BOs

Bommu Krishnaiah (1):
      drm/xe/oa: Zero OA buffer at allocation

Christian K=C3=B6nig (1):
      drm/exec: don't immediately add prelocked obj to array of locked objs

Dave Airlie (4):
      Merge tag 'drm-intel-fixes-2026-10-15' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-10-15' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-10-15' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.3-2026-10-15' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes

Dave Stevenson (1):
      drm/vc4: hdmi: Move packet RAM enable to PM runtime

Dibin Moolakadan Subrahmanian (2):
      drm/i915/dmc: Harden DMC firmware payload parsing
      drm/i915/dmc: Add sanity check for DMC load address

Dmitry Osipenko (1):
      Revert "drm/virtio: Add pixel blend mode property to cursor plane"

Dnyaneshwar Bhadane (1):
      drm/i915/cx0_phy: Fix ARL-S host bridge detection

Erik Faye-Lund (1):
      drm/panthor: fix immortalis condition

Guangshuo Li (1):
      accel/rocket: clear rdev on device init failure

Heiko Stuebner (1):
      MAINTAINERS: Add myself as reviewer for the Rocket NPU driver

Igor Paunovic (2):
      accel/rocket: search every core slot when a core is removed
      accel/rocket: search every core slot when looking up a scheduler

Jesse Zhang (4):
      drm/amdgpu: don't drop the runtime PM reference twice in amdgpu_gpr
      drm/amdgpu: free the userptr ranges when a CS fails after parser_bos
      drm/amdgpu: report the BO alignment in bytes in GEM_LIST_HANDLES
      drm/amdgpu: keep the eviction fence until the last handle is closed

Jianfeng Liu (1):
      Revert "dma-buf: Make DMABUF_DEBUG default to y on DEBUG_KERNEL kerne=
ls"

Kenneth Feng (1):
      drm/amd/pm: add zero fan stop temperature support on smu 14.0.2

Liam R. Howlett (1):
      accel/amdxdna: Fix Kconfig invalid configuration

Niranjana Vishwanathapura (1):
      drm/xe: skip eviction of a BO with no resource

Perry Yuan (3):
      drm/amdgpu: fix sched entity leak in ttm buffer entity init
      drm/amdgpu: destroy mutex when tearing down ttm buffer entity
      drm/amdgpu: fix GEM object leak on ENOMEM in userptr ioctl

Srinivasan Shanmugam (1):
      drm/amd/display: Fix NULL sink dereference in USB4 bandwidth function=
s

Thomas Hellstr=C3=B6m (2):
      drm/xe: Don't transfer shrinker pages for pinned bos on
purgeable state change
      drm/xe: Bump LRU for external objects on exec and rebind

Timur Krist=C3=B3f (2):
      drm/amdgpu/uvd3.1: Fix checking whether UVD firmware keyselect
was already set
      drm/amdgpu/sdma3: Work around POLL_REGMEM / FENCE hang

Yuho Choi (1):
      drm/virtio: Reset device before deleting virtqueues on freeze

 MAINTAINERS                                        |  7 +-
 drivers/accel/amdxdna/Kconfig                      |  1 +
 drivers/accel/rocket/rocket_device.c               |  2 +
 drivers/accel/rocket/rocket_device.h               |  1 +
 drivers/accel/rocket/rocket_drv.c                  |  7 +-
 drivers/accel/rocket/rocket_job.c                  |  2 +-
 drivers/dma-buf/Kconfig                            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             | 15 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 23 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            | 17 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 10 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             | 25 +++++--
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |  2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    | 18 +++--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   | 55 +++++++++++++++-
 drivers/gpu/drm/drm_exec.c                         | 77 +++++++++++++-----=
----
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       | 12 ++--
 drivers/gpu/drm/i915/display/intel_dmc.c           | 76 ++++++++++++++++++=
+--
 drivers/gpu/drm/i915/display/intel_dmc_regs.h      | 12 ++++
 drivers/gpu/drm/panthor/panthor_hw.c               |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 20 +++---
 drivers/gpu/drm/virtio/virtgpu_drv.c               |  1 +
 drivers/gpu/drm/virtio/virtgpu_plane.c             | 13 ----
 drivers/gpu/drm/xe/xe_bo.c                         | 11 +++-
 drivers/gpu/drm/xe/xe_exec.c                       |  7 +-
 drivers/gpu/drm/xe/xe_oa.c                         |  7 ++
 drivers/gpu/drm/xe/xe_vm.c                         | 31 ++++++++-
 drivers/gpu/drm/xe/xe_vm.h                         |  2 +
 include/drm/drm_exec.h                             | 15 +++--
 30 files changed, 348 insertions(+), 132 deletions(-)
