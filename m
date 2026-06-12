Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE757CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 22:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F3510E420;
	Fri, 12 Jun 2026 22:17:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mCAsz32O";
	dkim-atps=neutral
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5C410E420
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 22:17:17 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-9158643e538so137383685a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 15:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781302636; cv=none;
 d=google.com; s=arc-20240605;
 b=CQLyuqyEChXVJc/CdRf8BHVEmDyfVQzDxuh5rYtq3Vea8DccTMAxH28nNX62pKCe8U
 y4QFAMMXfZaoQj2BWKvESiik9VIG2ZtdHz1jNciGULi/oFA8b9Hw+uLv6v8cnK4g37ao
 Gw7wlwtYdpl4/zK79AM0q1qfnaC9/5+qDsqg9RR9L3yjsLw/QQYl0OqfCVeHiK3dY9eT
 /9JpW9wHd+KWy5LVBnexAYdHpLssQOftg4ABEIrqJkhVEqXOmxxq1ARN9falus1L+Zmg
 by1eiLXcgp8IVXe8UtmGMsSH1zFqhPq9yxOgyeW8ZEuwnTR902woJS5YMhdSMOMeXYdt
 Gq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=F3CiaY4b09SPAMAbx68m2pFZ/ap4WhDl2n+D8gMNeE4=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=bi2ExoVHaSSh22dLVwB/30Dg0LtdoHFF7uu9ANzreUOaCap7AWZIR0cI2ZicsA+xzQ
 H00kpoCuuPuGis3zFEFK8QMSByuj0BjOea1yOhlP+onX0gCKwDJ1OZMWSE1I9unBzb6/
 I9IpY6OP5wJHi4v/HHZthoLoTHaIWsLsLA6um54XR/ltfv8PKmPnm68xnT1CksbwbDmX
 0AFV3nrgW/b6aHY5j/ODzLzrmy5cJsJh5L7+sE2CiEyJnlI0IxGBOURnXoK0ESKSNqor
 6G7uNo9lUoUmL9LkFxQN3WqPew8VSenuDq3mIUYDXWQe6K/MYanadFZDZwDczjf0fXPM
 7iIw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781302636; x=1781907436; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F3CiaY4b09SPAMAbx68m2pFZ/ap4WhDl2n+D8gMNeE4=;
 b=mCAsz32O74wGd9UP/ByhP0f0BOuk1OP50oRPHb3jPpJTramHP9XmUvDxFyw1BWQ2q1
 oI0roFA1HJXciCPtnW6wEGHzVVgwBOmZtHYdxrme2d1nBDBjz+cjRS1g7aLsvnZczlVl
 dt5JGxL/VGZzg04hmLxnvI9qWkbAb4su4AYNR/YbhQfH3J2Frmx81Qwf9yhE1aZZjR4H
 epNsnz+s9wLrQ+N4HcCHJbnHiCnb/pZpIFxFL3YexfL0Tt3OSE++4s3NYyjE9Cgh9X6O
 iX9zFr1a/RtbKG2ltvpAs9XvoYl/f3tjSm4unrSs0ycPBzbWu69+fhjuY09kI+gYffRK
 ASJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781302636; x=1781907436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3CiaY4b09SPAMAbx68m2pFZ/ap4WhDl2n+D8gMNeE4=;
 b=iifiha+KHE2kTZIzSybj1YMoME7boESl4QCcD2udfny/rKD/VKbPKqOgI/v9TeIPNr
 LJ/XHxl4eB8rCbqImHzqjmVVDEF5QxMx2D9AqrPsenZupsjyQT1WYXIKUUw57DTyuCqI
 l8NRLKDJ9FtS2cd5FOeqIT1MrcOa9kY4ecXxmyMyAV5NPx8oGy8WFVnjGIfKj+wxGCFk
 CUmgFOfxlOTbFj73aHFKAYYwUL8He56TcjWljMxX7Vp7Y5wiwBAvmSfJBAk+zQc1MfjA
 0+6nNiSDumTkWUKE4wke8DCroLv44/nKYAcIPbs3XyzSiR23o/YImBe6DNEGoPH8ADeH
 FAWA==
X-Gm-Message-State: AOJu0YzdTgr9UthqVH8Vlmd3yrlnmf07yRNe5lwSi3HcVRxkg3XLWtJe
 wNmMPVQaHuT818TZAr/ZwzumR8fxArkCjvCd3zP+Y8tWPVztaFDZawMu47bXsC09dhCuwd5+VDk
 F3FxSRyEZVHjbbu8lXlZxuuT4foMLtzc=
X-Gm-Gg: Acq92OGfcz4CjUIiXpfdXNqf+YYPbr8CHfOu4V/FhCYtUTChjAMzjbA3PuKyd7CZbHG
 HLFGNI0Lbf5pvLi0RpIvJkoG8dB5QWNDs4RS6CJY+RL/bXv8Y2d7tuZNoe/Qmaj7mRQoU31Mxz+
 ceHQzXTtKxLgIGZQmpiJ2BOQt/FgI0IdNieGIbT2S445Z5o5Upcp+Nc4amzff6uatwuzLwIXZ0O
 P1LzPbs8zKbc0KMtcjrLcZtpiTyKFJOCArjcHF0TntoZCIIZAtIP5N6hRv31QX0/1aCKncM0y1w
 OR3wMf2wEtOBhXvx5FGl1kBPSdXLd8+JZDkCUWyAopNBOu3d7gtaj6zfxNhI7tN+pk/wlCDHOou
 u4ic=
X-Received: by 2002:a05:620a:2842:b0:915:86c6:842a with SMTP id
 af79cd13be357-9161bf6c000mr806189785a.41.1781302635953; Fri, 12 Jun 2026
 15:17:15 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 13 Jun 2026 08:17:04 +1000
X-Gm-Features: AVVi8CcMvm9L3Y4-lZ74wJr0ePweugWdZbxGEE7C9M6ZIJKfhZrc17vLZqWF1HI
Message-ID: <CAPM=9twRD5OAYencEyAtjTq7uqWek9C2CcrWrV1Bmtz8EpJFcA@mail.gmail.com>
Subject: [git pull] drm fixes for 7.1-rc8/final
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

Hey Linus,

Looks like it's settled down a bit more thankfully, small changes
across the board, amdgpu/xe leading with some colorop changes in the
core/amd. Otherwise some misc driver fixes.

Let me know if there are any problems,

Dave.

drm-fixes-2026-06-13:
drm fixes for 7.1-rc8/final

colorop:
- make lut interpolation mutable
- track colorop updates correctly

amdgpu:
- UserQ fix
- Userptr fix
- MCCS freesync fix
- track colorop changes correctly

amdkfd:
- Fix an event information leak
- Events bounds check fix
- Trap cleanup fix

i915:
- Check supported link rates DPCD read
- Fix phys BO pread/pwrite with offset

xe:
- fix oops in suspend/shutdown without display
- RAS fixes
- Use HW_ERR prefix in log
- include all registered queues in TLB invalidation
- Fix refcount leak in xe_range_tree in error paths
- fix job timeout recovery for unstarted jobs and kernel queues

amdxdna:
- fix possible leak of mm_struct

ivpu:
- fix integer truncation

vc4:
- fix leak in krealloc() error handling

virtio:
- fix dma_fence ref-count leak
The following changes since commit 4549871118cf616eecdd2d939f78e3b9e1dddc48=
:

  Linux 7.1-rc7 (2026-06-07 15:37:58 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-06-13

for you to fetch changes up to 7c62657a10625e4e113de248d41f543d5a2f3a1a:

  Merge tag 'drm-misc-fixes-2026-06-12' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2026-06-13 07:52:40 +1000)

----------------------------------------------------------------
drm fixes for 7.1-rc8/final

colorop:
- make lut interpolation mutable
- track colorop updates correctly

amdgpu:
- UserQ fix
- Userptr fix
- MCCS freesync fix
- track colorop changes correctly

amdkfd:
- Fix an event information leak
- Events bounds check fix
- Trap cleanup fix

i915:
- Check supported link rates DPCD read
- Fix phys BO pread/pwrite with offset

xe:
- fix oops in suspend/shutdown without display
- RAS fixes
- Use HW_ERR prefix in log
- include all registered queues in TLB invalidation
- Fix refcount leak in xe_range_tree in error paths
- fix job timeout recovery for unstarted jobs and kernel queues

amdxdna:
- fix possible leak of mm_struct

ivpu:
- fix integer truncation

vc4:
- fix leak in krealloc() error handling

virtio:
- fix dma_fence ref-count leak

----------------------------------------------------------------
Alex Hung (1):
      drm/colorop: Remove read-only comments from interpolation fields

Alexander A. Klimov (1):
      drm/vc4: fix krealloc() memory leak

Andrzej Kacprowski (1):
      accel/ivpu: Fix signed integer truncation in IPC receive

Christian K=C3=B6nig (1):
      drm/amdgpu: restart the CS if some parts of the VM are still invalida=
ted

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-7.1-2026-06-04' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2026-06-11' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-06-11' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-06-12' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

David Rosca (1):
      drm/amdgpu/userq: Fix reading timeline points in wait ioctl

Dmitry Osipenko (1):
      drm/virtio: Fix driver removal with disabled KMS

Jani Nikula (1):
      drm/xe/display: fix oops in suspend/shutdown without display

Joonas Lahtinen (1):
      drm/i915/gem: Fix phys BO pread/pwrite with offset

Lizhi Hou (1):
      accel/amdxdna: Fix mm_struct reference leak in aie2_populate_range()

Melissa Wen (3):
      drm/colorop: make lut(1/3)d_interpolation props correctly behave
as mutable
      drm/atomic: track individual colorop updates
      drm/amd/display: use plane color_mgmt_changed to track colorop change=
s

Michel D=C3=A4nzer (1):
      drm/amd/display: Consult MCCS FreeSync cap only if requested & suppor=
ted

Nikita Zhandarovich (1):
      drm/i915/edp: Check supported link rates DPCD read

Raag Jadav (3):
      drm/xe/drm_ras: Make counter allocation drm managed
      drm/xe/drm_ras: Add per node cleanup action
      drm/xe/hw_error: Use HW_ERR prefix in log

Rodrigo Vivi (1):
      drm/xe: fix job timeout recovery for unstarted jobs and kernel queues

Sunday Clement (1):
      drm/amdkfd: Add bounds check for AMDKFD_IOC_WAIT_EVENTS

Tangudu Tilak Tirumalesh (1):
      drm/xe: include all registered queues in TLB invalidation

Wentao Liang (2):
      drm/virtio: fix dma_fence refcount leak on error in
virtio_gpu_dma_fence_wait()
      drm/xe: fix refcount leak in xe_range_fence_insert()

Yongqiang Sun (2):
      drm/amdkfd: fix SMI event cross-process information leak
      drm/amdkfd: Unwind debug trap enable on copy_to_user failure

 drivers/accel/amdxdna/aie2_ctx.c                  |  3 +
 drivers/accel/ivpu/ivpu_ipc.c                     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  9 +--
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c            |  6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c           |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c       |  8 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++---
 drivers/gpu/drm/drm_atomic.c                      |  4 +-
 drivers/gpu/drm/drm_atomic_uapi.c                 | 68 ++++++++++++++++++-=
----
 drivers/gpu/drm/drm_colorop.c                     | 16 +++++-
 drivers/gpu/drm/i915/display/intel_dp.c           | 11 +++-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c          | 19 +++++--
 drivers/gpu/drm/vc4/vc4_validate_shaders.c        | 13 +++--
 drivers/gpu/drm/virtio/virtgpu_drv.c              |  5 +-
 drivers/gpu/drm/virtio/virtgpu_submit.c           |  4 +-
 drivers/gpu/drm/xe/display/xe_display.c           | 11 +++-
 drivers/gpu/drm/xe/xe_drm_ras.c                   | 61 ++++++++-----------=
-
 drivers/gpu/drm/xe/xe_guc_submit.c                | 49 +++++++++++-----
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c             |  7 +--
 drivers/gpu/drm/xe/xe_hw_error.c                  | 12 ++--
 drivers/gpu/drm/xe/xe_range_fence.c               |  2 +
 include/drm/drm_atomic_uapi.h                     |  4 +-
 include/drm/drm_colorop.h                         | 34 ++++++------
 24 files changed, 241 insertions(+), 133 deletions(-)
