Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707BDC44516
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C948F10E3CB;
	Fri, 17 Jul 2026 23:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sz3+1D8q";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A40310E3CB
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 23:20:47 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8f186025973so90541986d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 16:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784330446; cv=none;
 d=google.com; s=arc-20260327;
 b=dqSLPkP8OKC6ljYkn10oUX71lW9x5tazAnsgtiNUi4NLOJOkelW8d4+E1d57QD8abo
 zup6C+dHJCSQdtK39bKfsp9CH8BXpvfmSR27imdHqBgMvd8bwBF9+/EUvvovGzvj4erk
 cTmVvcncHDANyDEad6wB0qhIPTrdByPtg4yqeCoLBLSChU0uOZfyHm89tUG7M+AlZhGZ
 bJoR8i0nl5rqG3O+a0d5BbKivt4PKPwjllazgheduIxVKyNidGQpv/DeO6pdOVBP5Esq
 duMNus230Al0IpfpL0k/pyhgt+OJJBdE+LBbFSHrreNxr35H0103x8EYTDv6cJwUDzSi
 uPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=73rPoT/vqlVFSVUVJouMVxj3BD2aPujLGZKTd8t5yHw=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=eaFmbzRnrdU1g+E/+CCHWhkQgak5yU2BE8aiIycLSy9Ki2+aE/K4Z5JULQ4m6o0dbd
 vu3kQfxjV9xNPs+Zd3rzkpbv5lkv+3J1Ux7X0fVA/QLgwaj1FZfcVAsh5YZysaTSm0Ai
 zJwaEgZLGPLBzFVTYKy3hskPovYtMQPtBs+B2wk0Wzbw25cWf5l73jqTPvOPxUKZRvnb
 I9XllXzzqZG3fQw1LwOeYoaFAvlwGR22pv4jHRUJHIMCWsMMJYhNmmlvClsLn1+UNHAU
 hnd/PYE7Bckqlff55GdQUl9XGv71+X3mWRd4gZpFG5Qsa6G8CiEdcXC+JzZNOJkS/o8q
 z80A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784330446; x=1784935246; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=73rPoT/vqlVFSVUVJouMVxj3BD2aPujLGZKTd8t5yHw=;
 b=sz3+1D8qSc47HAtg/zDRP9+fk94on0S4L/HM2tlTjNPY3sCKJVyh2L9wCDk6Du3UzX
 rofpEm7X7AmeI6qf6lwom/RTuenhJpA8yfw+OTKFrB43l0lh3blEvnSkCb8X+7cj0oOA
 sjr1oZeIgHw2cbiTjQUKWwRNWlk4VSntaY/I1cLpJF2SfWTKVZK0UW2ii32iKe8S+GGp
 B2Qxd5cTVGEHwRJ+4Wqa2bdKp3nthO26JgJa/+Okj1mvMn4UDRw1xE5D0/8KGcfj3Z/F
 +YgcA7Xrq0GZwNOeHUcyQ+nn8HwI66vRJqqs2P9N+3O6LlSu0JAitsEmilM44CkpNeCx
 WM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330446; x=1784935246;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=73rPoT/vqlVFSVUVJouMVxj3BD2aPujLGZKTd8t5yHw=;
 b=hv5ZJbbaWT2MNMALjkEkaH8+Xtjfcz5J6mB8nIOAd27uNLRlPuru6f1WRC0aX3dEd3
 6xeZ43caztA91t4Z7KzyzELgdTVi+H1wNoYucHmo0KYJZQFPwKpBou+ulJHKbS7i6KKc
 0N/BxepXiNc126XxkdI+WTXzCktf8Pclkbl3njwJfwDbX78z36uZAG0H7c4buFHEOuZB
 o6VvBAoMEWaiFv4m3DD/7n4p23f6JFzrozKW2xPLeIJi9hHtr9Aq3EhObW/5M+w/juOd
 xVNMlm8l2DDGiPha11GFQRNY5ZqRriJ2VyKIFsGUyzvtoPLuMWpIPeZpi0JvnhysFA+y
 ypDQ==
X-Gm-Message-State: AOJu0YyPSIyi9I6YFkQFichtj5trSzpf8VRQRFsxwVvxyO7f5Ihg26TU
 Lx8HPqZdlPy6DWBV5RP4fiW7p5GAkvGO9GR5YqJUqP9KJUfM+KCxRJcm/d4efCvxHsc0qfhZfNs
 rOEX/rN/xGQtCgIhQZvSu/f1hqxNqe4I+pdYt0+gSHA==
X-Gm-Gg: AfdE7ckhRg4l9CER+Eu56uUNuWkYf+KQ5IVl13gkFDu6rEFzuCbSt/gbMAuiOXorpps
 rvIgzpXHp8sMqQaR/l64+50cI9ly0b/b4PQdhlZrdQa6RIYClXYW4Y0LaQMdgcIqXEWdvxrXQIP
 0lvl02+S/4OKCGSMTZqAXu+jZT0Om6cmCCTfkzqY3/WjqRFqDJ3RLDUxi66VGNRGbDa3KmNxvCu
 EohcBGg+PAd1Luh0S3LJSG9MyMc8bhvhdjFKzKDYsvV+l0ROewFnDE8Ft1krEDPwy8ewyvLdZcI
 /ZGwCISJUhWNtp78zFAp5mayUnPw0J8ZWaqKbDYtDiuCkSE=
X-Received: by 2002:a05:6214:c83:b0:904:236d:a3c2 with SMTP id
 6a1803df08f44-90778331799mr53947516d6.16.1784330446127; Fri, 17 Jul 2026
 16:20:46 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 18 Jul 2026 09:20:34 +1000
X-Gm-Features: AUfX_mwN-EgnifiIW1IhCH9RgFo9VlzTd5gGfpZjjyNVnOqbOOyTv0-nC8pP01E
Message-ID: <CAPM=9txvBdB0TSf8W5S4M=CPu=vPZ5F2gBQQ27y4FzkoxoCKew@mail.gmail.com>
Subject: [git pull] drm fixes for 7.2-rc4 (updated with amdgpu)
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

Please ignore the previous one,

Weekly drm fixes, there is amdgpu, xe and i915 and then a lot of
scattered fixes.

Looks about the right level for the new right.

Regards,
Dave.

drm-fixes-2026-07-18-1:
drm fixes for 7.2-rc4

ttm:
- Handle NULL pages and backup handles in ttm_pool_backup() correctly.

gpusvm:
- Improve unmap and error handling on gpusvm.

udmabuf:
- Always synchronize for CPU in begin_cpu_udmabuf.

xe:
- Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOCK
- Hold a dma-buf reference for imported BOs
- Fix writable override for CRI
- Fix VF CCS attach/detach race with in-flight BO moves
- Fix WOPCM size for LNL+
- Reset current_op in xe_pt_update_ops_init
- Keep scheduler timeline name alive
- Hold device ref until queue teardown completes
- Disable display in admin only PF mode

i915:
- NV12 display fix for bigjoiner
- clear watermark on plane disable
- GT selftest fixes

host1x:
- Fix UAF

amdxdna
- Fix UAF
- Reject more invalid amdxdna command submissions.

ivpu:
- Fix wrong read
- Handle invalid firmware log in ivpu.

panthor:
- Fix error handling

virtio:
- Fix virtio deadlock
- Fix invalid gem detach.

amdgpu:
- DCN 4.2 fixes
- NUTMEG fixes
- 8K panel fix
- Backlight fixes
- UserQ fix
- Fix bo->pin leaking in amdgpu_bo_create_reserved()
- VFCT fixes
- devcoredump fixes
- Display fixes
- SMU7 DPM fix
- AC/DC fixes for SMU7 and SI
- Queue reset fix
- PCIe DPM fix
- XHCI/GPU resume ordering fix
- Pageflip timeout fix

amdkfd:
- Fix potential overflow in CWSR size calculation
- DQM error clean up fixes
The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa=
:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-07-18-1

for you to fetch changes up to 973fd9493ec21f12e760fbbedeb7b0b2317c02f4:

  Merge tag 'amd-drm-fixes-7.2-2026-07-17' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2026-07-18
08:20:41 +1000)

----------------------------------------------------------------
drm fixes for 7.2-rc4

ttm:
- Handle NULL pages and backup handles in ttm_pool_backup() correctly.

gpusvm:
- Improve unmap and error handling on gpusvm.

udmabuf:
- Always synchronize for CPU in begin_cpu_udmabuf.

xe:
- Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOCK
- Hold a dma-buf reference for imported BOs
- Fix writable override for CRI
- Fix VF CCS attach/detach race with in-flight BO moves
- Fix WOPCM size for LNL+
- Reset current_op in xe_pt_update_ops_init
- Keep scheduler timeline name alive
- Hold device ref until queue teardown completes
- Disable display in admin only PF mode

i915:
- NV12 display fix for bigjoiner
- clear watermark on plane disable
- GT selftest fixes

host1x:
- Fix UAF

amdxdna
- Fix UAF
- Reject more invalid amdxdna command submissions.

ivpu:
- Fix wrong read
- Handle invalid firmware log in ivpu.

panthor:
- Fix error handling

virtio:
- Fix virtio deadlock
- Fix invalid gem detach.

amdgpu:
- DCN 4.2 fixes
- NUTMEG fixes
- 8K panel fix
- Backlight fixes
- UserQ fix
- Fix bo->pin leaking in amdgpu_bo_create_reserved()
- VFCT fixes
- devcoredump fixes
- Display fixes
- SMU7 DPM fix
- AC/DC fixes for SMU7 and SI
- Queue reset fix
- PCIe DPM fix
- XHCI/GPU resume ordering fix
- Pageflip timeout fix

amdkfd:
- Fix potential overflow in CWSR size calculation
- DQM error clean up fixes

----------------------------------------------------------------
Alessandro Rinaldi (1):
      drm/amd/display: Force PWM backlight on Lenovo Legion 5 15ARH05

Alex Deucher (1):
      drm/amdgpu: always emit the job vm fence

Alexander Usyskin (1):
      drm/xe/nvm: fix writable override for CRI

Andriy Korud (1):
      drm/amd/display: dce100: skip non-DP stream encoders for DP MST

Arvind Yadav (2):
      drm/xe/guc: Keep scheduler timeline name alive
      drm/xe/guc: Hold device ref until queue teardown completes

Daniele Ceraolo Spurio (1):
      drm/xe/wopcm: fix WOPCM size for LNL+

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2026-07-17' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-07-17' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2026-07-17' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.2-2026-07-17' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Dmytro Laktyushkin (2):
      drm/amd/display: fix dcn42 det allocation order
      drm/amd/display: fix dcn42b det allocation order

Doruk Tan Ozturk (2):
      accel/amdxdna: reject user command submission without a command BO
      accel/amdxdna: reject command submission on devices without a submit =
op

Emre Cecanpunar (1):
      drm/i915/selftests: Fix GT PM sort comparators

Fangzhi Zuo (1):
      drm/amd/display: Fix 8K Mode Not Parsed by EDID

Guangshuo Li (1):
      drm/amdkfd: free MQD managers on DQM init failures

Himal Prasad Ghimiray (1):
      drm/xe/vm: Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC

Honglei Huang (3):
      drm/gpusvm: free the whole IOVA reservation on unmap
      drm/gpusvm: do not route system pages to device_unmap() on IOVA unmap
      drm/gpusvm: publish dpagemap early to avoid device mapping leak on er=
ror

Jason Macnak (1):
      drm/virtio: Don't detach GEM from a non-created context

Jesse Zhang (1):
      drm/amdgpu/userq: fix indefinite fence wait during GPU reset

Jhonraushan (1):
      accel/ivpu: Reject firmware log with size smaller than header

Karol Wachowski (1):
      accel/ivpu: Fix wrong register read in LNL failure diagnostics

Leo Li (3):
      drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no=
_lock
      drm/amd/display: check GRPH_FLIP status before sending event
      Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"

Linmao Li (1):
      drm/panthor: Check debugfs GEM lock initialization

Lizhi Hou (1):
      accel/amdxdna: Fix use-after-free of mm_struct in job scheduler

Maarten Lankhorst (1):
      Merge v7.2-rc3 into drm-misc-fixes

Mario Limonciello (5):
      drm/amd/display: Fix backlight max_brightness to match exported range
      drm/amdgpu: Fix VFCT bus number matching with soft filter
      drm/amdgpu: Release VFCT ACPI table reference
      drm/amdgpu: Disable PCIe dynamic speed switching on Ryzen Pinnacle Ri=
dge
      drm/amd: Create a device link between APU display and XHCI devices

Matthew Brost (2):
      drm/ttm: Account for NULL and handle pages in ttm_pool_backup
      drm/xe/vf: Fix VF CCS attach/detach race with in-flight BO moves

Matthew Stewart (1):
      drm/amd/display: Fix DCN42B null registers & register masks

Mikko Perttunen (1):
      gpu: host1x: Fix use-after-free in host1x_bo_clear_cached_mappings

Nitin Gote (1):
      drm/xe: Hold a dma-buf reference for imported BOs

Osama Abdelkader (1):
      drm/panthor: return error on truncated firmware

Pengpeng Hou (2):
      drm/i915/gt: use correct selftest config symbol
      drm/amd/display: wire DCN42B mcache programming callback

Robert Mader (1):
      udmabuf: Ensure to perform cache synchronisation in begin_cpu_udmabuf=
()

Roman Li (1):
      drm/amdgpu/discovery: Fix device family for DCN42

Ryosuke Yasuoka (1):
      drm/virtio: fix deadlock in display_info_cb by removing hotplug
from dequeue worker

Satyanarayana K V P (1):
      drm/xe/pf: Disable display in admin only PF mode

Timur Krist=C3=B3f (10):
      drm/amd/display: Fix preferred link rate for NUTMEG
      drm/amd/display: Add dp_skip_rbr flag for NUTMEG
      drm/amdgpu: Print vmid, pasid and more task info in devcoredump
      drm/amdgpu: Reserve space for IB contents in devcoredumps
      drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658 (R7 260X)
      drm/amd/display: Set native cursor mode for disabled CRTCs
      drm/amd/pm/si: Don't schedule thermal work when queue isn't initializ=
ed
      drm/amd/pm/si: Fix AC/DC switch notification
      drm/amd/pm/smu7: Fix AC/DC switch notification
      drm/amdgpu/ttm: Consider concurrent VM flushes for buffer entities

Vidya Srinivas (1):
      drm/i915/display: Fix NV12 ceiling division for bigjoiner case

Vinod Govindapillai (1):
      drm/i915/wm: clear the plane ddb_y entries on plane disable

WenTao Liang (1):
      drm/amd/display: set new_stream to NULL after release

Yongqiang Sun (1):
      drm/amdkfd: fix 32-bit overflow in CWSR total size calculation

Zhu Lingshan (1):
      drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved

Zongyao Bai (1):
      drm/xe/pt: Reset current_op in xe_pt_update_ops_init()

yanglinlin (1):
      drm/amd/display: fix __udivdi3 link error

 drivers/accel/amdxdna/amdxdna_ctx.c                |  18 +
 drivers/accel/ivpu/ivpu_fw_log.c                   |   4 +
 drivers/accel/ivpu/ivpu_hw_btrs.c                  |   2 +-
 drivers/dma-buf/udmabuf.c                          |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |  62 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  10 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |  23 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 551 +++++++++++++----=
----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  70 +--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  20 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  45 ++
 drivers/gpu/drm/amd/display/dc/dc.h                |   3 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  11 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   2 +-
 .../display/dc/link/protocols/link_dp_capability.c |   6 +-
 .../display/dc/resource/dce100/dce100_resource.c   |   7 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |   1 +
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |  23 +-
 .../display/dc/resource/dcn42b/dcn42b_resource.h   | 116 +----
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  17 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c     |   7 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  16 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  12 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  12 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |  45 ++
 drivers/gpu/drm/drm_gpusvm.c                       |  53 +-
 drivers/gpu/drm/drm_panel_backlight_quirks.c       |   9 +
 drivers/gpu/drm/i915/display/skl_universal_plane.c |  33 +-
 drivers/gpu/drm/i915/display/skl_watermark.c       |   2 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.c        |   2 +-
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c           |   8 +-
 drivers/gpu/drm/panthor/panthor_device.c           |   5 +-
 drivers/gpu/drm/panthor/panthor_fw.c               |   1 +
 drivers/gpu/drm/ttm/ttm_pool.c                     |  34 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c               |  14 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               |   5 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |   3 -
 drivers/gpu/drm/xe/xe_bo.c                         |  58 ++-
 drivers/gpu/drm/xe/xe_bo.h                         |   3 +-
 drivers/gpu/drm/xe/xe_bo_types.h                   |   2 +
 drivers/gpu/drm/xe/xe_device.c                     |   4 +-
 drivers/gpu/drm/xe/xe_device_types.h               |   2 +-
 drivers/gpu/drm/xe/xe_dma_buf.c                    |   2 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h       |   5 +
 drivers/gpu/drm/xe/xe_guc_submit.c                 |  70 +--
 drivers/gpu/drm/xe/xe_guc_types.h                  |   2 -
 drivers/gpu/drm/xe/xe_migrate.c                    |   5 +-
 drivers/gpu/drm/xe/xe_migrate.h                    |   1 +
 drivers/gpu/drm/xe/xe_module.c                     |  49 ++
 drivers/gpu/drm/xe/xe_module.h                     |   5 +
 drivers/gpu/drm/xe/xe_nvm.c                        |   9 +-
 drivers/gpu/drm/xe/xe_pci.c                        |   9 +-
 drivers/gpu/drm/xe/xe_pt.c                         |   3 +
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c               |  20 +-
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.h               |   3 +-
 drivers/gpu/drm/xe/xe_vm.c                         |  25 +-
 drivers/gpu/drm/xe/xe_wopcm.c                      |  15 +-
 drivers/gpu/host1x/bus.c                           |   4 +-
 include/drm/drm_utils.h                            |   1 +
 67 files changed, 1076 insertions(+), 564 deletions(-)
