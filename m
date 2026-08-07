Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F24C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 21:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5A410F5B9;
	Fri,  7 Aug 2026 21:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JM8fTG12";
	dkim-atps=neutral
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8560610F5B9
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 21:08:30 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-66896892b6cso5830009d50.0
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 14:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786136909; cv=none;
 d=google.com; s=arc-20260327;
 b=LbAid4ZStxfsCFSRuxC6t7bmlDpRT/Iu2SO0Iq9dR21RIrwTRqi/Pe14Q2CnrOY9pd
 San+LNiwht17VD1t/WEbw7ZVa5/j2LKcjw+gKbGBFNNUMx7ScFJDEp2fiMbNalVjPjey
 H9lmDMC81WFpfdjIEKYQYyy3RaOyUXJIsk9UrxLfYBBQstRN0adDuG0FSHoaLlD8IoRA
 5IUSj2WvJ8tTT8PZhb5R2mscYG1YTGWCw17A9SGYNvW9StN4n1Pe7ROGAqMmn7oHCJys
 GKu98yxkQnf4xUde7Zn3gufXEqgygLbdD4qaEuThr0zp4UqKEvDVxYYSHmALbOtzt0yM
 6qqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=nt7G6PRGbVb32WbBIDt3TUteTbneyf7z9qhRgeC0QHM=;
 fh=jB4zzpG4RiBzEqyCtcurCOYtGi/xRIni7Dp2F8WM78o=;
 b=q3uj9qdzblm5wD5mLZ6D6riseTWzW/36lE/ahsndFMCZNhBFwShp3WdeysnhrfahHg
 +mRcOzVNZzHf1Z8QS9zYRxOhTWYhc2+EyW/Sm/40tDC7JJxPnS7hEJtsvfakssfGsTKI
 vTqccKwPC4aO6rbzIS/Tz5g/VWpGl8V6G9CLP1MhtinQ3n/TfTGa/FE4K1RlSaocJ4CC
 UYCEor56i8CyoIu1b1pEjwPVSR5+BmxCGp5vJJ3Dx2slDHqnDSLHfy1NT2Zs2dBA4ccA
 Yy29cWRILDvb2QGZDcm5pI7ne393MKNupK6l7W7B/SbLKpcOKTc4RLcpllNsigDEwmZU
 CVEQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786136909; x=1786741709; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nt7G6PRGbVb32WbBIDt3TUteTbneyf7z9qhRgeC0QHM=;
 b=JM8fTG12Y7SijqOSbA2XncJHvB2/l/FwdNBA52PK5EcfKkG9pG+x6XRa1ZFmX8J4rL
 IaDHmsjo30vHd0eity9FN2YOQTdI8xJiITgOa/G3dAOAMw6+4oi8bjA+8yd9nLstMeBw
 3RaPCtKVg2niZzyr+J6QmfuRIHzTYHSaqdfFuvH6hMeDIW8oZK2fNU/VK4hl7xVJptdO
 Omij3wNzOCekW+5ItzzgulgCm70Y+HKfVhH4N9qB+F7cT86ersf0+pt+Fde+i9FpNN2J
 e4XZu0TKU5neq5szRTKBHpoqpMgngRtKma19T6ERACGA5uzOhz/nlAshIS+2ZzeGt82V
 dweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786136909; x=1786741709;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nt7G6PRGbVb32WbBIDt3TUteTbneyf7z9qhRgeC0QHM=;
 b=Gq/6Z38W+jtYd/bE0SAwBi0NepQQSfgW1LWXHRU12lleZtGyIhCFTU513vHHl4hEyQ
 AlM/+gwbn7JO/jJyc6oSZNQ0JlqT8pXElSeVptEwuijHcB+0oUL7XaNiwMYaLx9PO6Ka
 OoAiry+0JIzTDmDNQs+Mn0oSypNB+C+RCiBtgFai+EXrr7dt+oyOEs4Z0KBTJTlen1nu
 B49SdHvjVP32TWhA1UaVtGsYs4D/TRYrkC3x7vM3F9HJw50j8FY9oVv7RgSTa+C30ofz
 7ek49/LGTuYmB+4gNlNdI3aJNtthN4qc0hASG0G5g7yBrgfu3jVXNphuNKgNZ14OivB5
 yMJQ==
X-Gm-Message-State: AOJu0Ywt6aA0hlD6iJAGWhzh3e9jVVXkD8m8WQmyLtMji/H86HC+B7Ur
 lbo3qekGAbwhN2a5j90yDXhZfo9UyEAMijEKFdcTFG/2JyC1ug8sOc4NZpuM+SmDe/TT2gvV41F
 3pPmiNlQNYQr8smwGl8ulImZvMlriap0=
X-Gm-Gg: AR+sD10yV9vl1XRRyYvIpyIzQEPTuGAcW/kBRfra0A98iPhXAGRizFR0tPJPjQi2pjW
 qnIPKwcAejKhvuu7WbAwoTHY29gMXlANg+bFzO7Lq+ueoVbnrJNi3P6MjYzZMKJa47C4XiZBlWX
 SmaYU4uNdXNzXuMoUkT+uSAkYEkWvaWpbUfkI6M0xjt+x4nIJNlzouBwvY6bkjz5zABD1FEubwW
 wBkufQo1+onn/mrpy6wsCKCydMTzhKFYw0YYD6Geln+s82EiJ3laeOAlozfOke5T+c3roTtR1jK
 fYbDwtIos+YxoNkLIAawMtuInInI7m4kwiRpHyYBkuzJbVbkIzX4f2xBpe67p6w7t1+Yfh4szX0
 EmAyLVEbCye9ppGeYvn+1nk72GoVqwjopJ+ZW7s2cVg==
X-Received: by 2002:a05:690e:4550:10b0:667:af58:8d78 with SMTP id
 956f58d0204a3-6699ab62ad4mr11512555d50.37.1786136909139; Fri, 07 Aug 2026
 14:08:29 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 8 Aug 2026 07:08:17 +1000
X-Gm-Features: AUfX_mwNbO5Z9WORFyl6ImQLSePjRDQ9K7jP8ru3iivtQsXWDr9QZtZvxU0eY8o
Message-ID: <CAPM=9ty7AHCg=yvFJzcet0E8EJaW39ZWTBXcMjKfRv5gn_qKTg@mail.gmail.com>
Subject: [git pull] drm fixes for 7.2-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona.vetter@ffwll.ch>
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

Weekly fixes for drm, feels relatively quiet for the post-AI world,
mostly amdgpu and xe with a few fixes across the board.

Dave.

drm-fixes-2026-08-08:
drm fixes for 7.2-rc7

shmem:
- check VMA boundaries for PMD mappings

xe:
- Fix memory leak in exec_queue_set_hang_replay_state
- Apply RCS/CCS yield policy to SR-IOV VFs

amdgpu:
- JPEG queue reset fixes
- GC 12 fix
- GMC 12.1 fixes
- Lockdep false positive fix
- Userq fix
- Bounds checking fixes
- Devcoredump fixes
- DCN 2.0.1 fix
- Aperture mapping fix
- DC avmute fix
- DC self refresh fix

radeon:
- Performance regression fix

panthor:
- skip zero sized firmware segments
- check VMA boundaries for PMD mappings

bridge:
- ps8640: propagate AUX transfer register errors

amdxdna:
- Improve error handling in amdxdna_insert_pages.

v3d:
- serialise scheduler timeouts
The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68=
:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-08-08

for you to fetch changes up to 5fb210754ed66ce2dbd3ccffd508df769ff0bcdc:

  Merge tag 'amd-drm-fixes-7.2-2026-08-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2026-08-07
21:01:05 +1000)

----------------------------------------------------------------
drm fixes for 7.2-rc7

shmem:
- check VMA boundaries for PMD mappings

xe:
- Fix memory leak in exec_queue_set_hang_replay_state
- Apply RCS/CCS yield policy to SR-IOV VFs

amdgpu:
- JPEG queue reset fixes
- GC 12 fix
- GMC 12.1 fixes
- Lockdep false positive fix
- Userq fix
- Bounds checking fixes
- Devcoredump fixes
- DCN 2.0.1 fix
- Aperture mapping fix
- DC avmute fix
- DC self refresh fix

radeon:
- Performance regression fix

panthor:
- skip zero sized firmware segments
- check VMA boundaries for PMD mappings

bridge:
- ps8640: propagate AUX transfer register errors

amdxdna:
- Improve error handling in amdxdna_insert_pages.

v3d:
- serialise scheduler timeouts

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/gmc12.1: implement tlb inv semaphore
      drm/amdgpu/gmc12.1: fix MMHUB0 check in pasid tlb flush

Asad Kamal (2):
      Revert "drm/amdgpu: fix aperture mapping leak"
      drm/amdgpu: fix aperture iounmap skipped on device removal

Candice Li (1):
      drm/amdgpu: reject oversized IBs with per-ring packet limits

Christian A. Ehrhardt (2):
      drm/shmem_helper: Check VMA boundaries for PMD mappings
      drm/panthor: Check VMA boundaries for PMD mappings

Dave Airlie (3):
      Merge tag 'drm-xe-fixes-2026-08-06' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-08-06' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.2-2026-08-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

David Weber (1):
      drm/amd/display: allow self-refresh exit while entry is blocked

Jesse Zhang (4):
      drm/amdgpu: fix JPEG v5.0.0 queue reset failure in DPG mode
      drm/amdgpu: fix JPEG v4.0.5 queue reset failure in DPG mode
      drm/amdgpu: fix JPEG v5.3.0 queue reset failure in DPG mode
      drm/amdgpu/userq: serialize queue map against GPU reset

Lijo Lazar (2):
      drm/amdgpu: Use virtual alloc during coredump
      drm/amdgpu: Allocate coredump ring buffers per ring

Lizhi Hou (2):
      accel/amxdna: Fix page-insertion errors in amdxdna_insert_pages()
      accel/amdxdna: Fix locally exploitable BUG_ON in amdxdna_insert_pages=
()

Marcin Bernatowicz (1):
      drm/xe/uc: Apply RCS/CCS yield policy to SR-IOV VFs

Ma=C3=ADra Canal (1):
      drm/v3d: Serialize the scheduler timeout handlers

Micha=C5=82 Winiarski (1):
      drm/xe: Fix memory leak in exec_queue_set_hang_replay_state()

Osama Abdelkader (1):
      drm/panthor: skip zero-sized firmware sections

Pengpeng Hou (1):
      drm/bridge: ps8640: propagate AUX transfer register errors

Qiang Yu (1):
      drm/amdgpu: read TRUNCATE_COORD_MODE on gfx12

Ray Wu (1):
      drm/amd/display: Check for tg ops in dce110_set_avmute

Travis K. Bangs (1):
      drm/amd: Disable DP audio spread spectrum for Cyan Skillfish

Vitaly Prosyak (1):
      drm/amdgpu: Fix lockdep false positive in amdgpu_lockdep_init

Wang Jiang (1):
      drm/radeon: restore hardware polling in fence_is_signaled to fix
performance regression

 drivers/accel/amdxdna/amdxdna_gem.c                | 47 ++++++++++--------=
-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             | 27 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   | 54 ++++++++++++------=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c        | 21 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 29 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  5 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  5 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             | 48 ++++++++++++++++++=
-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           | 21 +++++++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           | 21 +++++++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           | 21 +++++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  5 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  6 ++-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |  5 +-
 drivers/gpu/drm/bridge/parade-ps8640.c             | 27 ++++++++---
 drivers/gpu/drm/drm_gem_shmem_helper.c             |  6 ++-
 drivers/gpu/drm/panthor/panthor_fw.c               |  3 ++
 drivers/gpu/drm/panthor/panthor_gem.c              |  6 ++-
 drivers/gpu/drm/radeon/radeon_fence.c              |  7 +++
 drivers/gpu/drm/v3d/v3d_drv.h                      |  6 +++
 drivers/gpu/drm/v3d/v3d_sched.c                    |  9 +++-
 drivers/gpu/drm/xe/xe_exec_queue.c                 |  3 ++
 drivers/gpu/drm/xe/xe_uc.c                         |  7 ++-
 25 files changed, 298 insertions(+), 96 deletions(-)
