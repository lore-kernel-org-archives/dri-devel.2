Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA05ECD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 23:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435DE10E44F;
	Fri, 15 May 2026 23:47:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hNiS0bNm";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570A510E44F
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 23:47:48 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-90d2acb9936so61963185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 16:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778888867; cv=none;
 d=google.com; s=arc-20240605;
 b=DzL6xj8/w51wdcqln9yMyRhcRwACl7bEGNf6ATcdS98i5a9oMFkFEtHGyCLJ3pHpXE
 LLKuWZ9Yg1Fh1aAE0LkqpGhLDD21MboI6RIBoUFozY7b19aVcimSsK5QMddhy8W5em5y
 jovagUsICGwbfac+1j6EIBposKT+62S+Twnz4Lj68pOL3wG7gt0zyUlAGuck0BK73ek2
 kE4QvNZ2GHetmYmFbANoS6Q3yC0eonTKD0LuDQEzVtffO2bhm5bulbRgiiyvE7G3qZAu
 qKdNLJxjwp/WeXksFUCQscoTPLdQHukb3htzB9pbB5NNTxjbAz0C0nfQsRfk7EtSQ/Ma
 cO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=dzaISux0gIy56Dz+aHmjNvcjHo0xCTdush8TXP7uSzw=;
 fh=A08XZwmmb57jzirbgTkluPSvjDeiJMkkojF1n6qDmTk=;
 b=MRgMEF2FB4iSO4QuqMhc0v7lkm0jXQIHTousAMoyeEmTk8aiy2nbZQCzQapdh0pJFX
 il50dLc6Fmb3nMAA2OF1l00zlwNfBjVRpDdwdU2CRue+bRx3vSNKh0JeTwbfK60jNpbU
 huDwfTXIUeMIVugBmmqG16vXt9sELcUPZZpPpYoh1z0XU0GNJ6e0oTksCSz8ozEoKNF3
 D/uJHdeqwA8J/SXxyYoYEpKlju4vY/TjYz3AkLZBnZqQtDhA6OzTreMW/S7aWQUCdwPk
 F9TwD75jWc6j91S6u73XEmfRvpBFJOJ5Fz7Z5J20bgBkdrnEIUMxNrC+nHPBx11z5haq
 Id4g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778888867; x=1779493667; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dzaISux0gIy56Dz+aHmjNvcjHo0xCTdush8TXP7uSzw=;
 b=hNiS0bNmOrkEdvkn13m529lmyvbBc974k6u126JtYRqE3SRrIJBr+fOYLKLUAaTan4
 c0OQz74h58fSJHBnooWR9mTL8BYihRnE9JLgqLJhy6z0vfgJYvnIYd6/rU34Zx0qHe4r
 C/gRmEwaEtTn8szRb8iiio4jGjFxRkMMShup1U8mB0CMXynHMsxMwWigAo3AfaiNY+m9
 O1zjiqRp1iYRPywACyq5IFRkl5MqCEaLOZ6wsB37pASE5S5uRgzcM5hQY1bnHi9APjkN
 7rFqCtZGD5TS/4IsHBOPaC683drPtm0cDRTM1QZVmtWls+8QEMNpgmdrqMc9FjRBbtDV
 A32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778888867; x=1779493667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzaISux0gIy56Dz+aHmjNvcjHo0xCTdush8TXP7uSzw=;
 b=BIM80LLesgVjTRkX5qf45S89zACy/pCn/bkpWaj2L7ZyrVaTY3Lk+mIbsono6vumFt
 ut5jxl4wASVBAMoWxJOcdE6bqqFZpu6G4RB0zJ9wI9U8JVSmAebgE9OjHCwlR5d3ek0R
 C6Izbv7PC8jjDG6BYb/j1DJgSMtJKRNmuZAt1jhJvVP9ejRuHKU+tUa65dAQ1i9X9bn/
 I8rxr/WrE57C1Ixu198dmT3CFw/wgLUZGvGtdCaFE7qJw+89doyuO2jPpeAGbuOo/apA
 ZIP3L+tH9D7qC0LuwYQHzxYO0HnE7KWEHRfbxyF+OU+mUohlaMHWGZS6FdMDjA3Wv7jH
 tbpg==
X-Gm-Message-State: AOJu0Yzpk1uReZ3vNJ3ZMcQ30gL8SGa9wT8QaCKuPQ2AYrIKvRWVtmAn
 gTydtJ3/vj01uPOS1XnHw20FwFIWW45qj1+6Wc6YEuX4Zyh+gNE4XHJnzOdFmPZybmcAq1c5nJ1
 R5YMuyjbmWZZkNNyrouvcF3w7bWqR4/Q=
X-Gm-Gg: Acq92OGO0zv1alfAHhLA53S/Gd1NGSqnNAXYdEBN2VBGc3evZZpFlYRTYSD3iHAyh3f
 Uj/30tIyZik2fFuAfSQ/DJ7sI7nFMw6Xxn91tCYjs9UzF8RLUfgGZnT9IDcpFLuz++YxgwpXEnA
 QE6eCWRPIzK99CK1I79DfuT0t4/I3DZ+dURzyRWejhBBfUFlfI1lU0a3MrJbWMWH/8c+5OfteRx
 g+sKMRiunMO2wZWOafAvGbRIOwZ4iuBhIhN1SMhYRtZ/kas9F0H1D9wU6yZZdJmcXIX+OuUOkJO
 iKC4pzUBu4dkXuXyQp9qyNj4xl3Ke7MjVGiLwLsZAc31D6N+SOS9v8azhn3Feb+X53w=
X-Received: by 2002:a05:620a:a8f:b0:911:e1ab:a3c0 with SMTP id
 af79cd13be357-911e1aba5e4mr684469885a.60.1778888867129; Fri, 15 May 2026
 16:47:47 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 16 May 2026 09:47:35 +1000
X-Gm-Features: AVHnY4LzNQsE-S1ojBr2D4AZm7rngzhPd64vTtNWIzo7nE_rnXdsQW1P438UU2Q
Message-ID: <CAPM=9tysLUnY240+JBoYG8QVo=cVDCxai4kkS-an9_1n6qnA2A@mail.gmail.com>
Subject: [git pull] drm fixes for 7.1-rc4
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

Weekly fixes pull, small and all over fixes, mostly xe and amdgpu,
with some ttm and a core fix for the handle change pain.

Let me know if any issues,

Dave.

drm-fixes-2026-05-16:
drm fixes for 7.1-rc4

core:
- fix for the fix for the handle change race.

ttm:
- avoid infinite loop in swap out
- avoid infinite loop in BO shrinking
- convert -EAGAIN from dmem_cgroup_try_charge to -ENOSPC

bridge:
- imx8qxp-pxl2dpi: avoid ERR_PTR with device_node cleanup

i915:
- Skip __i915_request_skip() for already signaled requests
- Fix VSC dynamic range signaling for RGB formats [dp]

xe:
- Madvise fix around purgeability tracking
- Restore engine mask for specific blitter style
- Couple UAF fixes
- Drop unused ggtt_balloon field

amdgpu:
- Userq fixes
- DCN 3.2 fix
- RAS fix
- GC 12 fix

gma500:
- oaktrail_lvds: fix i2c handling

loongson:
- use managed cleanup for connector polling

panfrost:
- handle results from reservation locking correctly

qaic:
- check for integer overflows in mmap logic

rocket:
- handle results from reservation locking correctly
The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581=
:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-05-16

for you to fetch changes up to dc366607c41c45fd0ae6f3db090f31dd611b644a:

  drm: Replace old pointer to new idr (2026-05-16 09:32:43 +1000)

----------------------------------------------------------------
drm fixes for 7.1-rc4

core:
- fix for the fix for the handle change race.

ttm:
- avoid infinite loop in swap out
- avoid infinite loop in BO shrinking
- convert -EAGAIN from dmem_cgroup_try_charge to -ENOSPC

bridge:
- imx8qxp-pxl2dpi: avoid ERR_PTR with device_node cleanup

i915:
- Skip __i915_request_skip() for already signaled requests
- Fix VSC dynamic range signaling for RGB formats [dp]

xe:
- Madvise fix around purgeability tracking
- Restore engine mask for specific blitter style
- Couple UAF fixes
- Drop unused ggtt_balloon field

amdgpu:
- Userq fixes
- DCN 3.2 fix
- RAS fix
- GC 12 fix

gma500:
- oaktrail_lvds: fix i2c handling

loongson:
- use managed cleanup for connector polling

panfrost:
- handle results from reservation locking correctly

qaic:
- check for integer overflows in mmap logic

rocket:
- handle results from reservation locking correctly

----------------------------------------------------------------
Arvind Yadav (1):
      drm/xe/madvise: Track purgeability with BO-local counters

Chaitanya Kumar Borah (1):
      drm/i915/dp: Fix VSC dynamic range signaling for RGB formats

Christian K=C3=B6nig (4):
      drm/amdgpu: remove deadlocks from amdgpu_userq_pre_reset
      drm/amdgpu: rework amdgpu_userq_signal_ioctl v3
      drm/amdgpu: remove almost all calls to
amdgpu_userq_detect_and_reset_queues
      drm/amdgpu: fix userq hang detection and reset

Dave Airlie (4):
      Merge tag 'drm-intel-fixes-2026-05-13' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.1-2026-05-13' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-xe-fixes-2026-05-14' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-05-15' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Edward Adam Davis (1):
      drm: Replace old pointer to new idr

Guangshuo Li (1):
      drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with device_node cleanup

Gyeyoung Baek (2):
      accel/rocket: Fix prep_bo ioctl leaking positive return from
dma_resv_wait_timeout()
      drm/panfrost: Fix wait_bo ioctl leaking positive return from
dma_resv_wait_timeout()

Jesse Zhang (1):
      drm/amdgpu/gfx_v12_0: set gfx.rs64_enable from PFP header on GFX12

Johan Hovold (3):
      drm/gma500/oaktrail_hdmi: fix i2c adapter leak on setup
      drm/gma500/oaktrail_lvds: fix hang on init failure
      drm/gma500/oaktrail_lvds: fix i2c adapter leaks on init

Matt Roper (1):
      drm/xe: Make decision to use Xe2-style blitter instructions a feature=
 flag

Matthew Auld (2):
      drm/xe/dma-buf: handle empty bo and UAF races
      drm/xe/dma-buf: fix UAF with retry loop

Michal Wajdeczko (1):
      drm/xe: Drop unused ggtt_balloon field

Mikhail Gavrilov (1):
      drm/amd/display: Wrap DCN32 phantom-plane allocation in
DC_RUN_WITH_PREEMPTION_ENABLED

Myeonghun Pak (1):
      drm/loongson: Use managed KMS polling

Sebastian Brzezinka (1):
      drm/i915: skip __i915_request_skip() for already signaled requests

Thomas Hellstr=C3=B6m (3):
      drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout failure
      drm/ttm: Convert -EAGAIN from dmem_cgroup_try_charge to -ENOSPC
      drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup failure

Xiang Liu (1):
      drm/amd/ras: Fix CPER ring debugfs read overflow

Zack McKevitt (1):
      accel/qaic: Add overflow check to remap_pfn_range during mmap

 drivers/accel/qaic/qaic_data.c                     |  23 +-
 drivers/accel/rocket/rocket_gem.c                  |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  29 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 131 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    | 245 ++++++++++-------=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h    |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   7 +
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |   8 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c       |  40 ++--
 drivers/gpu/drm/drm_gem.c                          |   7 +-
 drivers/gpu/drm/gma500/oaktrail_hdmi.c             |   1 +
 drivers/gpu/drm/gma500/oaktrail_lvds.c             |   9 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   9 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |   3 +-
 drivers/gpu/drm/loongson/lsdc_drv.c                |   2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |   2 +
 drivers/gpu/drm/ttm/ttm_bo.c                       |  18 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |  11 +-
 drivers/gpu/drm/ttm/ttm_resource.c                 |  18 +-
 drivers/gpu/drm/xe/xe_bo.c                         |   6 +-
 drivers/gpu/drm/xe/xe_bo.h                         |  88 +++++++-
 drivers/gpu/drm/xe/xe_bo_types.h                   |  28 ++-
 drivers/gpu/drm/xe/xe_dma_buf.c                    |  80 ++++---
 drivers/gpu/drm/xe/xe_gt_types.h                   |   7 +
 drivers/gpu/drm/xe/xe_migrate.c                    |  18 +-
 drivers/gpu/drm/xe/xe_pci.c                        |   9 +
 drivers/gpu/drm/xe/xe_tile_types.h                 |   2 -
 drivers/gpu/drm/xe/xe_vm.c                         |  51 ++++-
 drivers/gpu/drm/xe/xe_vm_madvise.c                 | 162 +-------------
 drivers/gpu/drm/xe/xe_vm_madvise.h                 |   2 -
 include/drm/ttm/ttm_resource.h                     |   2 +
 32 files changed, 540 insertions(+), 495 deletions(-)
