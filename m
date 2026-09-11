Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D97C88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E22A10E598;
	Fri, 11 Sep 2026 20:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FFLArUaB";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEECF10E598
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 20:44:38 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-93a00298c53so17356085a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789159478; cv=none;
 d=google.com; s=arc-20260327;
 b=V6rm3oToJXZUSIUqVxy6NGZme0Ggo4sPMGI1B1XlYITHf+XnMSMVHnNxeFrYE4xqME
 fQr0X10RkcYZTDiLuBbtSqPpSdW7a+AVA8e0anBzWdylk2GwEFY3rS+EQ1gjDVjA3rac
 p48INx1ANyxfgJCEg8D8q9JTFdr39qMOvmMeOhH8k2/pntdIBukLhDVmH8EbSUr1OLAP
 6a9HHK76b1RSop0b6TioPs/2DyeJHlhMXf/PSRDhk3INViOLWQD7iUnyp9PBr1jLBflJ
 NsfiStFiq85ZMV4BKyVl/oToyI7qf3XVI7An2AG2EMbJDO5i9WlEn9eRv53Zoq6oKlyM
 prmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=SkISSLquT6XeODeqqMzRS36GrWecMNEutYooMtswli4=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=idw5rVscsfFIceX1f1AG+KMN5uB6RlKtujatc0oiQ2Dbcdk5Hl7OkdwdrC6WLMy7b7
 cAPbbh6cV8jKk5ATaihMvwob/8bDOk1hQsfoLXw/sL7vmCpgzdooxdaqWzsn/Mstx7Kx
 eVzP+nu8vyTf5XZArvyezXuVCo3Vg2eriC5xcgxQPbn/KSdhlQlidpAkDCz8AQfQXWS4
 bcDUO84sE5e9XVCwtP+Mp/RTnfcYwVarrV/C0h0WUYztjcyL+PX1Wk54TV+6E0ufkeWu
 jv7ccfyyXp4Tq17sEsAtJeSozZ7nLW5qcnAx0AsreHtD6YuzW0hTvqDkmfirpVsu8/2J
 ZP8w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789159478; x=1789764278; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SkISSLquT6XeODeqqMzRS36GrWecMNEutYooMtswli4=;
 b=FFLArUaB+MKX0GML1g4S5gbFpKE3G1cjQXTS3gPEaqY+rKaWxF4Z8WugXPE32VvBIO
 Zmns43aRjwhVzifpKJHY894qUqmkn4YNXJ52TOWwlNkgT8tLERC5B1R83GaAd0Ipo2Ne
 CpMB6PbHU84vIE6Jo0cyOB6f/jzImZyLBt+x8QVUIDnmHeequPLQQraIDqVpkjfw82hn
 Jyk2eyEWRMUshcDNLa2LIo9zuv3RD+pN7j6ckm1TEVGH2dyRKdoMQVAmbpCJwx4bd6mL
 oiv14O08E4E2WzRCZs9YTjHlviPLHd8ShiZrg0DLJZLkyBYIRiBYRvPJRAL5Wdglxfp4
 ZUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789159478; x=1789764278;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SkISSLquT6XeODeqqMzRS36GrWecMNEutYooMtswli4=;
 b=SqDHjHe1WBgeUxlOaFo4pjHPahL4v+RJlzLSjdrD2e2FawCZ8saqAZIqSp4jzezPZM
 9yp/tjNtSkgkzR1J7Bh6x1PtnLxuXC7IpkrHRkGC6LUVzVcR1O1WJQCKX/eMnnm68+oE
 YT7GCirstM5CG2E0hdQ57nXhDJufmMmMI/Ps8b8NjWMO9iBYuLVAdL5eXuF8CQXX8VeK
 ceZN98YcZ5zxc6rUoSAYqyFt5Qa5X59HLoZ0MaMYNu9izAaFLmOLqnbpRyohH0YF4oaV
 WTLpkMT1qKd7i/WOOJLjOn1N958nsI+HmlMp3HWgJkJW4uFk9KTMpY1Ff5N1hzQqtWGg
 qcaA==
X-Gm-Message-State: AFuF++kAtGqXs2Q68cmvzx7h6FN53SvT1BZdlIcrz21cdDK/NpXRQNUQ
 vpCAz3u6O7aG0uxjf0Zvy6/zLy1Ho3zVxfHT0A/JWtX5TPA9/VpRTZxF19s0lPkeRMhYoY7TV5w
 lt90ihEqrQROvO6Np9amUwRhZg3dRbCY=
X-Gm-Gg: AYBFou1K01+LoPsp8ECLcGX1af2PbpiFeP2K6uK0uiZjAn2pWMxu6tAhHeTX/bdL0xN
 cdHGGq81iTc+bYjRmfeZWvfqyBUxFqa/1gRdJXUvn/g8ipPl91JnLmOMv9dIKPimw4z3Q/2dwO1
 jBYl8ph5b1XXU24HFRpPQFSF8driinZxy+yBDpYxutQkEpF/uOgiaZQ+bk0I2OS0YTarf3oPKeN
 LgxwVI/syVJp7sVrXNSKg7DX/oEs0TjrOPCoTw//EsnL/FpvKUqthjrruf+1l9arLVSns1ZHBG6
 JJFqQ5nZ7Z1cJNB79KyHaokvbNqR5p5tGAdRPXpw8vtISJQ0NZJxNMAtv9mbH2P/BpxG5zhoiKU
 9d/JtEFvRbGOfsU5eE+dNeKCbNE+PQU+gV21qXbyAAnWTn0Ef3Vo=
X-Received: by 2002:a05:620a:4686:b0:939:922b:3de1 with SMTP id
 af79cd13be357-939ea2a3baemr846826085a.44.1789159477578; Fri, 11 Sep 2026
 13:44:37 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 12 Sep 2026 06:44:25 +1000
X-Gm-Features: AcwNN1XjHdzvwzLxGSBI74aDBaOJ28PfdU-i2VQPskwjh6gRDQm8IPruONYay-U
Message-ID: <CAPM=9ty1x=g_7+obhbefCdWXQoEoW7-WdVuoN+P4+sfYJ34=_A@mail.gmail.com>
Subject: [git pull] drm fixes for 7.3-rc3
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

Weekly fixes pull, this seems relatively quiet for the new world,
scattered fixes, mostly amdgpu leading the way, but lots of minor
fixes in other drivers.

Regards,
Dave.

drm-fixes-2026-09-12:
drm fixes for 7.3-rc3

drm_exec:
- fix 0 object handling

sched:
- null ptr deref fix in kunit tests

amdgpu:
- Freesync fix
- GPUVM fix
- Debugfs fixes
- HDMI fixes
- IPS fix
- GPU reset fix
- RGB quantization fixes
- SMU 13.0.x fixes

xe:
- runtime PM guard fix
- cache flushing fix

i915:
- Fix a memleak on perf config query error path
- Fix UHBR SST SDP splitting when sink doesn't support it

bridge:
- fix ti-sn65dsi83 error handling
- tc358768: Enforce input bus flags via atomic_check

ast:
- fix blend mode property on cursor plane

qxl:
- fix blend mode property on primary/cursor planes

virtio:
- fix blend mode property on cursor plane

vboxvideo:
- fix blend mode property on planes

rockchip:
- fix endpoint name length
- fix Kconfig issues

ivpu:
- limit firmware log prints to field size
- validate buffer range in ivpu address translation
- validate fw log buffers

ethosu:
- ensure SRAM sizing
- ensure cmd stream formatting
- drop IRQF_SHARED
- fix open return value

adp:
- fix Kconfig

logicvc:
- fix Kconfig
The following changes since commit df2908090cda368b01ff43709f51890076c56157=
:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-09-12

for you to fetch changes up to b1edd3a3e00369080012b2e4c665fc662b96ecbd:

  Merge tag 'amd-drm-fixes-7.3-2026-09-10' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes
(2026-09-11 18:42:13 +1000)

----------------------------------------------------------------
drm fixes for 7.3-rc3

drm_exec:
- fix 0 object handling

sched:
- null ptr deref fix in kunit tests

amdgpu:
- Freesync fix
- GPUVM fix
- Debugfs fixes
- HDMI fixes
- IPS fix
- GPU reset fix
- RGB quantization fixes
- SMU 13.0.x fixes

xe:
- runtime PM guard fix
- cache flushing fix

i915:
- Fix a memleak on perf config query error path
- Fix UHBR SST SDP splitting when sink doesn't support it

bridge:
- fix ti-sn65dsi83 error handling
- tc358768: Enforce input bus flags via atomic_check

ast:
- fix blend mode property on cursor plane

qxl:
- fix blend mode property on primary/cursor planes

virtio:
- fix blend mode property on cursor plane

vboxvideo:
- fix blend mode property on planes

rockchip:
- fix endpoint name length
- fix Kconfig issues

ivpu:
- limit firmware log prints to field size
- validate buffer range in ivpu address translation
- validate fw log buffers

ethosu:
- ensure SRAM sizing
- ensure cmd stream formatting
- drop IRQF_SHARED
- fix open return value

adp:
- fix Kconfig

logicvc:
- fix Kconfig

----------------------------------------------------------------
Arunpravin Paneer Selvam (1):
      drm/amdgpu: skip the VMID 0 flush for VRAM

Dave Airlie (4):
      Merge tag 'drm-misc-fixes-2026-09-10' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-09-10' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2026-09-10' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.3-2026-09-10' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes

Dawid Osuchowski (1):
      accel/ivpu: Limit firmware log name prints to field size

Esben Haabendal (1):
      drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work(=
)

Fangzhi Zuo (2):
      drm/amd/display: Exit IPS before connector detection on resume
      drm/amd/display: Fix HF-VSDB DSC bpc detection to be cumulative

Harry Wentland (1):
      dm/amdgpu: fix malformed link_settings debugfs output

Igor Paunovic (2):
      drm/rockchip: dw_dp: Select DRM_BRIDGE_CONNECTOR
      drm/rockchip: rk3066_hdmi: Add missing Kconfig selects

Karl Mehltretter (2):
      drm/adp: Drop the select of the nonexistent CONFIG_DRM_KMS_DMA_HELPER
      drm/logicvc: Drop the select of the nonexistent CONFIG_DRM_KMS_DMA_HE=
LPER

Kevin Wang (2):
      drm/amd/pm: fix gpu metrics energy accumulator for smu 13.0.0/13.0.7
      drm/amd/pm: report energy accumulator for smu 13.0.0

Leonardo Costa (1):
      drm/bridge: tc358768: Enforce input bus flags via atomic_check

Magdalena Schulfer (2):
      accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr
      accel/ivpu: Validate firmware log buffer metadata

Michel D=C3=A4nzer (1):
      drm/amd/display: Consult MCCS FreeSync cap only if requested & suppor=
ted

Mitul Golani (1):
      drm/i915/dp: Gate UHBR SST SDP splitting on sink capability

Nathan Chancellor (1):
      drm/amd/display: Shorten hdmi_frl_status_polling_workqueue

Prike Liang (1):
      drm/amdgpu: skip gfx switch_power_profile during GPU reset

Qinyun Tan (4):
      drm/ast: create blend mode property on cursor plane
      drm/qxl: create blend mode property on primary and cursor planes
      drm/virtio: create blend mode property on cursor plane
      drm/vboxvideo: create blend mode property on planes

Rob Herring (Arm) (5):
      accel: ethosu: Fix ethosu_job_open() return value
      accel: ethosu: Drop IRQF_SHARED flag
      accel: ethosu: Ensure cmd stream ends with a stop op
      accel: ethosu: Ensure SRAM size is 0 on mapping failure
      accel: ethosu: Ensure SRAM region size matches job

Satyajit Roy (3):
      drm/amd/display: Propagate HDMI RGB quantization selectability
      drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output
      drm/amd/display: Rebuild InfoFrames on output color space changes

Shixiong Ou (1):
      drm/sched: Create a fake device for KUnit tests

Sunil Khatri (1):
      drm/drm_exec: fix up contended obj when num_objects is 0

Thadeu Lima de Souza Cascardo (1):
      Revert "drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info"

Thomas Hellstr=C3=B6m (1):
      drm/xe: Flush LSC untyped L1 dataport cache after rcs/ccs batches

Thomas Zimmermann (1):
      Merge drm/drm-fixes into drm-misc-fixes

Thorsten Blum (1):
      drm/i915: Fix memory leak in query_perf_config_list()

Varun Gupta (1):
      drm/xe: Guard page-fault worker with runtime PM check

Yudi Yang (1):
      drm/rockchip: analogix_dp: fix unchecked bound endpoint name length

 drivers/accel/ethosu/ethosu_device.h               |  1 +
 drivers/accel/ethosu/ethosu_drv.c                  |  3 +-
 drivers/accel/ethosu/ethosu_gem.c                  |  9 +++
 drivers/accel/ethosu/ethosu_job.c                  | 16 ++--
 drivers/accel/ivpu/ivpu_fw_log.c                   | 87 +++++++++++++-----=
----
 drivers/accel/ivpu/ivpu_gem.h                      | 14 +++-
 drivers/accel/ivpu/ivpu_ipc.c                      |  7 +-
 drivers/gpu/drm/adp/Kconfig                        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 20 +++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 24 +++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 20 ++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  6 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 37 +++++++++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |  4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  3 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |  6 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  8 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  4 +-
 drivers/gpu/drm/ast/ast_cursor.c                   |  3 +
 drivers/gpu/drm/bridge/tc358768.c                  | 15 ++--
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |  6 +-
 drivers/gpu/drm/drm_exec.c                         | 13 ++++
 drivers/gpu/drm/i915/display/intel_display_types.h |  2 +
 drivers/gpu/drm/i915/display/intel_dp.c            | 44 +++++++++--
 drivers/gpu/drm/i915/i915_query.c                  |  4 +-
 drivers/gpu/drm/logicvc/Kconfig                    |  1 -
 drivers/gpu/drm/qxl/qxl_display.c                  |  4 +
 drivers/gpu/drm/rockchip/Kconfig                   |  3 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  7 +-
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c   | 11 +++
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |  4 +
 drivers/gpu/drm/virtio/virtgpu_plane.c             |  4 +
 drivers/gpu/drm/xe/instructions/xe_gpu_commands.h  |  1 +
 drivers/gpu/drm/xe/xe_pagefault.c                  | 10 +++
 drivers/gpu/drm/xe/xe_pagefault_types.h            |  3 +
 drivers/gpu/drm/xe/xe_ring_ops.c                   | 11 +++
 38 files changed, 312 insertions(+), 115 deletions(-)
