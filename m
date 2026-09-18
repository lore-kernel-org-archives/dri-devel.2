Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3022C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CA410E380;
	Fri, 18 Sep 2026 22:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p6EnUVfG";
	dkim-atps=neutral
Received: from mail-qv2-f18.google.com (mail-qv2-f18.google.com
 [74.125.230.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B024510E380
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 22:17:02 +0000 (UTC)
Received: by mail-qv2-f18.google.com with SMTP id
 6a1803df08f44-90cdfc6db0bso10856326d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 15:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789769821; cv=none;
 d=google.com; s=arc-20260327;
 b=OoMlcP6q2djpocUhsuvYVrEUyDV6IqcNNsVzf9BmqJjqkFys7hfC38TzDPwYkVq4Ks
 HSBhJGgiOU/UKwLsDIjwH/yD8x7nTobyf+XY2NpvIvslAjo5OtR5DDQrSJwrY4SJFDZr
 AwqZ+SoE7KfAy4VzS5fukpsYYh5Z/xhN/DlHIMT5o0Zb81TZ7tRKivJ6qJB79BzY6foJ
 4V5icIF80rpfnVo3Dl7gT6QFhOigl7Aoxl0Qmzd4u175IoxDDkPSCH4WsSdgbtCQdwE5
 EZ8GFaUN75dKMCyM80R0ABV6FblywhGcDur7+rRASOyJjpu3od/UtuNdVt0qqoYp6kpN
 Z7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=sWCosvsfQVPpNuncKfHYQ+E+ccnFp32L3Fcq+t9mQJQ=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=g54LXUsBleP9cfdF93Qypqf2wvERrJNjnrevwdjUyboViH3d7l9R0T+z6z+gi7AocC
 mGmYH3WGaTFPIPnJgEiIXjiIkx2v7L6hDpMqslqghkKfMrBma1YmvBM6sXpxX0my/QsM
 BHddk3DD/VLHmsi3+He/KF4TqxAjvywa2XYnm8LB4A+7RwV0axVgwmG5WOP+uMR/5mUM
 XUgAYzvD4Enp7EvHMBrKrR2mPWWSJ37FkoqrGRq8mVfuLZ2O7DuM9A2wGCwoOWiEKmqY
 yPaV1TPh7G4DKEf992P8SHjamiVd2ezD63Kll/+7vhnqBGVqS3LYatzCP6pxo0YKbqgf
 7akA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789769821; x=1790374621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sWCosvsfQVPpNuncKfHYQ+E+ccnFp32L3Fcq+t9mQJQ=;
 b=p6EnUVfGWD0G8KBQJ+TGxcGDGTGvto7JIRFhYyKkM7iwxmGYNm1Yf/thXoIhuM0M8K
 JqwcUhiuLeNuZy/EEDwvBtwdAp9rBrEWON+ku6t72byJ2wROVIp/jxO/TNYhEONenN5E
 5+MJ6Dl5YMjA0U07rKMltqwUZf2nDlHqmQtYdNykcz7BP2MmT2cvtVDsctiMctgSpmFa
 ux7eq+FU8RNeUcH6kwL52V0ejWk2I8psF3j+U8u0UmfvCF2lGRSAyEJBxJ932USIPl/p
 FJkBE9pdhNZ+Tt+4iWUl5VesXFnlBwiVDGGYyVVKQNib3sXPV8pq6Fk42+cqn4Bnd/Sp
 2BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789769821; x=1790374621;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sWCosvsfQVPpNuncKfHYQ+E+ccnFp32L3Fcq+t9mQJQ=;
 b=b5tNpSrgBZTOQQ3ZTC/xJo7yeRzupaMHSNr0t/QcV7WTJ8d+NH+AnQnZ5bCuHK+Y2Z
 bEi+MoE+pos/wndBVhkb6Nr96XMF3G7NQspeT+Cla7dGH7qxV5YnHtglxX7Oy1kwqg5i
 lbRq5uLdWQWKdcB4qXG+eWKw/4vMoFmF3f9ybaNii5f720hsCxiDFPyqaLEfsU2eug6a
 Wv6H2aKl2hcbG0IaQP6z3WXBixmruqRhNOlO1uvq3d1PWcD8r0MEI/yhfnchg2MQHKkV
 kroP8tzDJNY36mjQUSOH7yhsBPLGCnzd1O96HQYMirs4QXrt40qHjROyNys0KhxIfKHT
 wN5g==
X-Gm-Message-State: AFuF++mSjdLTHJ5za0hqwosZeh2gKIG2Mpstov/YYuY/SvnkCldnxWJs
 Id2xOW/CGaXMhbig1kcm7h4GQHNveteJ3rb2wZpYM51Wg0j3AhemLVQpF4KCo+D5NtdcOTkVWzh
 TFiUf1EZE4L1Nzm40VZcfaMtSX9Vocbs=
X-Gm-Gg: AYBFou22J3Gp8hgIobefXtTFxg4IM8kaCPssZ3lElZdRzJnsg1tob++i6PYdhEDG4dX
 QsKfVSdGzsUYScu1Id1C1uK1jnZzu7AXtPsveCgmdTTVNYLqAS26uZtVEXEmHi265paucDTcM+6
 xIGty55ovWMTFoXsSB4nfuarmpcM7oYEPf55rEpWEVc+kq+C05tFEHbR0QAVgbBrtMKNnIRO+Vx
 mtOObb5R5+SlXlDzo/mVM9S4uAdiVGmR865iff+LwmXjOgFHPHb/7hbo9096Mv4Ouqs0SaKPQGa
 aPOf8nvHiy0TjN7ypbENLamn53MmNJTNbUQqIkDxz3CtKvIBPJsVBwj+ptCFQKvSZRbzshiNd87
 cRdP/WfNKjli5dsTDJT31h1auQXH8MLJwiqn/wAB4
X-Received: by 2002:a05:620a:4388:b0:923:7821:dc0d with SMTP id
 af79cd13be357-93bdc747a3bmr583683685a.33.1789769816709; Fri, 18 Sep 2026
 15:16:56 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 19 Sep 2026 08:16:44 +1000
X-Gm-Features: AcwNN1UVFisS_x0KZXKDT3c7LqfISw1kqPwrM02TnH0wpePoF_XKSKCL6TAX4yQ
Message-ID: <CAPM=9tyHWoVvi75xn2duuoMm=MMux5fmBSx=UjbNkPAvbZZ3Nw@mail.gmail.com>
Subject: [git pull] drm fixes for 7.3-rc4
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

Things have picked back up a bit this week, mostly amdgpu, xe and msm
this time. There are a bunch of scattered changes across the rest of
drivers and core stuff, nouveau, i915.

In the signed tag I forgot to add the versilicon and longsoon entries,
but they are in the email below.

Regards,
Dave.

drm-fixes-2026-09-19:
drm fixes for 7.3-rc4

core:
- fix vblank pending event leak

ttm:
- swapout fixes

dma-buf:
- scattergather fixes
- enable dma-buf debug on debug kernels

dma-fence:
- fix signaling bit checks

sched:
- fix virtual runtime race

msm:
- DT:
  - Corrected indentation
- Core:
  - Marked fbdev as system memory
- GPU:
  - Fixed autosuspend cleanup on teardown
  - a750: fix timestamps
  - Increase GMU fw init timeout
  - Misc fixes/cleanups
- DPU:
  - Fixed clock rounding, unbreaking newest platforms
  - Cleared pending flush state
- DP:
  - Skip PUSH_IDLE when link was never enabled
  - Fixed bandwidth checks
- HDMI:
  - Fixed runtime PM cleanup on probe failure

xe:
- shrinker related fixes
- xe_mmio_gem fault handler and destroy fixes
- xe disable i2c irq on unbind

i915:
- Revert a commit touching registers that don't necessarily exist
- Check for negative numbers before passing to BIT()

amdgpu:
- SMU 14.x fix
- DC IRQ fix
- Runtime PM fix for P2P
- RAS fix
- PCIe reporting fix
- DCN 6 fix
- Device removal fix
- DC MALL fix

amdkfd:
- GC 12.x fixes
- Boundary checks
- Mapping clear fix

nouveau:
- suspend/resume fixes

gud:
- out of bounds access fix
- ignore damage clips in full update

vc4:
- use-after-free fix

versilicon:
- plane format fix

longsoon:
- blend mode property fix
The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780=
:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-09-19

for you to fetch changes up to 71f370e9ee1bdfe1f916547089d93b5265a918e7:

  Merge tag 'drm-misc-fixes-2026-09-17' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2026-09-19 06:49:36 +1000)

----------------------------------------------------------------
drm fixes for 7.3-rc4

core:
- fix vblank pending event leak

ttm:
- swapout fixes

dma-buf:
- scattergather fixes
- enable dma-buf debug on debug kernels

dma-fence:
- fix signaling bit checks

sched:
- fix virtual runtime race

msm:
- DT:
  - Corrected indentation
- Core:
  - Marked fbdev as system memory
- GPU:
  - Fixed autosuspend cleanup on teardown
  - a750: fix timestamps
  - Increase GMU fw init timeout
  - Misc fixes/cleanups
- DPU:
  - Fixed clock rounding, unbreaking newest platforms
  - Cleared pending flush state
- DP:
  - Skip PUSH_IDLE when link was never enabled
  - Fixed bandwidth checks
- HDMI:
  - Fixed runtime PM cleanup on probe failure

xe:
- shrinker related fixes
- xe_mmio_gem fault handler and destroy fixes
- xe disable i2c irq on unbind

i915:
- Revert a commit touching registers that don't necessarily exist
- Check for negative numbers before passing to BIT()

amdgpu:
- SMU 14.x fix
- DC IRQ fix
- Runtime PM fix for P2P
- RAS fix
- PCIe reporting fix
- DCN 6 fix
- Device removal fix
- DC MALL fix

amdkfd:
- GC 12.x fixes
- Boundary checks
- Mapping clear fix

nouveau:
- suspend/resume fixes

gud:
- out of bounds access fix
- ignore damage clips in full update

vc4:
- use-after-free fix

----------------------------------------------------------------
Chengjun Yao (1):
      drm/amdgpu: fix rmmio iounmap skipped on device removal

Christian K=C3=B6nig (1):
      dma-buf/dma-fence: fix checking signaling bit for timeline and
driver name v3

Dave Airlie (5):
      Merge tag 'drm-msm-fixes-2026-09-16' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'drm-xe-fixes-2026-09-17' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2026-09-17' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.3-2026-09-17' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-09-17' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

David Francis (2):
      drm/amdkfd: Avoid integer underflow with ffs in EOP ring size calc
      drm/amdkfd: Avoid integer underflow in EOP ring size calculation.

David Hu (2):
      dma-buf: Fix silent overflow for phys vec to sgt
      dma-buf: Split sgl by largest page-aligned chunk

Dmitriy Chumachenko (1):
      drm/amdgpu: check ras and obj before dereference

Dmitry Baryshkov (2):
      drm/msm: mark the fbdev framebuffer as system memory
      drm/msm/dsi: round the byte clock rate after reparenting to the PHY P=
LL

Francis Marlou Pacaro (1):
      drm/amd/display: fix MALL hysteresis timer underflow at high refresh =
rates

George Emmanuel Thomas (1):
      drm/msm: remove stale perf counter XML TODO

Guangshuo Li (2):
      drm/msm/adreno: fix autosuspend cleanup during teardown
      drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure

Huacai Chen (1):
      drm/loongson: Create blend mode property for cursor plane

Icenowy Zheng (3):
      drm/verisilicon: set blend mode for the cursor plane
      drm/verisilicon: add primary modifier for format tables
      drm/verisilicon: remove ARGB formats from primary plane

Ilia Levi (5):
      drm/xe/mmio_gem: forbid VMA split
      drm/xe/mmio_gem: use write-back mapping for dummy page
      drm/xe/mmio_gem: simplify fault handler loop
      drm/xe/mmio_gem: cache the dummy page per object
      drm/xe/mmio_gem: fix destroy flow

Jesse Casco (1):
      drm/msm/dp: skip PUSH_IDLE when the link was never enabled

Jonghyuk Kim(MalHyuk) (1):
      drm/msm: RCU-free the scheduler-containing ring and VM objects

Karl Mehltretter (4):
      drm/msm: Fix the separate_gpu_kms parameter description
      drm/msm/adreno: Fix the skip_gpu parameter description
      dma-buf: Make DMABUF_DEBUG default to y on DEBUG_KERNEL kernels
      drm/vc4: Use managed KMS polling to fix UAF on unbind

Kevin Wang (1):
      drm/amd/pm: report energy accumulator for smu 14.0.3

Krzysztof Kozlowski (1):
      dt-bindings: display/msm: Use consistent indentation in the example

Leo Li (1):
      drm/amd/display: Atomize IRQ register read/modify/write ops

Luca Coelho (1):
      drm/i915/display: check configuration index before shifting

Lyude Paul (4):
      Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"
      drm/nouveau/gsp/r570: Set GcOff =3D 0 in fbsr
      drm/nouveau/gsp/r570: Enable S/R Display workaround in GSP
      drm/nouveau/gsp: Increase delay for magic sleep in r535_gsp_fini()

Mario Limonciello (2):
      drm/amdgpu: Fix GPU PCIe link capability reporting
      drm/amdgpu: Skip KFD mapping clear before initialization

Maxime Ripard (1):
      Merge fdo/drm/drm-fixes into drm-misc-fixes

Mike Lothian (1):
      drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments

Neil Armstrong (2):
      drm/msm/a6xx: Add CX AO Counter registers used for a750 GPUs
      drm/msm/a6xx: Use CX AO Counter register for timestamp on a750 GPUs

Nemesa Garg (1):
      Revert "drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable"

Paul Hollinsky (1):
      drm/msm/adreno: Only check for PAS when a zap shader is present

Raag Jadav (1):
      drm/xe/i2c: Disable IRQ on unbind

Rob Clark (2):
      drm/ci: Update xfails for kms_cursor_legacy regression
      drm/msm/a6xx+: Increase GMU FW init timeout

Saim Shujah (1):
      drm/msm/dpu: clear pending peripheral flush state

Sajal Gupta (1):
      drm/gud: fix out-of-bounds write in gud_plane_atomic_check()

Shuicheng Lin (3):
      drm/xe/mmio_gem: Revoke drm_vma_node on xe_mmio_gem destroy
      drm/xe/shrinker: Return the freed page count through a parameter
      drm/xe/shrinker: Take a runtime PM ref before shrinking non-system me=
mory

Sophie D (1):
      drm/gud: Ignore damage clips in full update mode

Srinivasan Shanmugam (1):
      drm/amd/display: Fix NULL dereference in dcn50/dcn60 init_hw

Thadeu Lima de Souza Cascardo (1):
      drm: Fix drm_pending_vblank_event leak in error path for out_fence_pt=
r

Tvrtko Ursulin (1):
      drm/sched: Fix virtual runtime race

Vadim Nikitushkin (2):
      drm/ttm: fix swapped-out resources never leaving their bulk_move rang=
e
      drm/ttm: apply the swapout bulk_move fix to the intended condition

Vladimir Marioukhine (1):
      drm/amdkfd: implement restore_mqd callbacks for GFX12/12.1

William Bright (1):
      drm/msm/dp: fix link bandwidth check when wide bus is enabled

 .../bindings/display/msm/qcom,qcs8300-mdss.yaml    |   6 +-
 .../bindings/display/msm/qcom,sar2130p-mdss.yaml   |   4 +-
 .../bindings/display/msm/qcom,sm6150-dpu.yaml      |  14 +--
 .../bindings/display/msm/qcom,sm8350-mdss.yaml     |   2 +-
 .../bindings/display/msm/qcom,x1e80100-mdss.yaml   |  60 +++++-----
 drivers/dma-buf/Kconfig                            |   2 +-
 drivers/dma-buf/dma-buf-mapping.c                  |  31 ++++--
 drivers/dma-buf/dma-fence.c                        |  14 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  54 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |  43 ++++++-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c             |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |  61 +++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |  70 +++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |   5 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  12 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |  64 ++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |  28 +++++
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |  16 ++-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |   8 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |  34 +++---
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |  13 ++-
 .../drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c    |   6 +-
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c    |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |   3 +
 drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt    |   7 ++
 drivers/gpu/drm/drm_atomic_uapi.c                  |  13 ++-
 drivers/gpu/drm/gud/gud_pipe.c                     |   7 +-
 drivers/gpu/drm/i915/display/intel_cursor.c        |  15 +--
 drivers/gpu/drm/i915/display/intel_dp_link_caps.c  |   9 +-
 drivers/gpu/drm/i915/display/skl_universal_plane.c |  15 +--
 drivers/gpu/drm/loongson/lsdc_plane.c              |   5 +-
 drivers/gpu/drm/msm/Makefile                       |   1 -
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  12 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  15 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c                |  21 +++-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  36 +++---
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                |   8 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   2 +-
 drivers/gpu/drm/msm/msm_fbdev.c                    |   1 +
 drivers/gpu/drm/msm/msm_gem.h                      |   3 +
 drivers/gpu/drm/msm/msm_gem_vma.c                  |   2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c               |   2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h               |   1 +
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml  |   2 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c |   2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  |   8 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c |   8 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c  |   3 +-
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h |   8 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h    |   2 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |   8 +-
 drivers/gpu/drm/scheduler/sched_rq.c               |  20 ++--
 drivers/gpu/drm/ttm/ttm_bo.c                       |   2 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |   2 +-
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c      |   2 +
 drivers/gpu/drm/verisilicon/vs_hwdb.c              |  44 +-------
 drivers/gpu/drm/verisilicon/vs_hwdb.h              |   4 +-
 drivers/gpu/drm/verisilicon/vs_primary_plane.c     |   4 +-
 drivers/gpu/drm/xe/xe_i2c.c                        |   3 +
 drivers/gpu/drm/xe/xe_mmio_gem.c                   | 108 ++++++++++++-----=
-
 drivers/gpu/drm/xe/xe_mmio_gem.h                   |   2 +-
 drivers/gpu/drm/xe/xe_shrinker.c                   | 124 ++++++++++++-----=
----
 include/linux/dma-fence.h                          |   6 +
 75 files changed, 743 insertions(+), 388 deletions(-)
