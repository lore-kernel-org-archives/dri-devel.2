Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E7AF94CB3
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E2C110E221;
	Tue, 21 Apr 2026 21:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BKo9J7hc";
	dkim-atps=neutral
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCAAC10E92A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 21:50:47 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-50d87c138e1so50253641cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 14:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776808247; cv=none;
 d=google.com; s=arc-20240605;
 b=DJJHrbk9w3vOyn5HiSTUlS/y+b7o3bwMZmKg2ZYoFy+bCbUcDSkK9VQC5pqSR9YfUr
 MMsKi9oWzMjG38z7KtQs1/Ti6VMb9eXib+siut+HX7mLtuEo/UQCa2Y1Gt2PCUGOL9a9
 5DrRydC1+Fq5ev/dnlWQLKHYGreo8oPJoE5DOLl5oDKBHc/8KyfODhYGeJCN6MUIEwn4
 1CoE+7tbAkIMVQ4B80zm1Y5Wa8TxJsfSii+MzahYYtL5+Ur+ZNoM/I4SrCnM5Vqz/7iV
 uTP2GrVsiD2VCy81povguc8dSFWRDyfLsoGLWShNjeFBABjXztkcZ+L7c8eY8UPXOalQ
 T1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=nC4/IfuCqWLrHOWIb20vixvq8u04Kfw625zC9Zwh3XE=;
 fh=A08XZwmmb57jzirbgTkluPSvjDeiJMkkojF1n6qDmTk=;
 b=S/O1n4YZIDu+HIxEPfRZxfyfdL6hC0ZNp7+Sj6vmIHZnqyeBFGglKp95BRNnwpCNhU
 LPthvMjjNe/IAZSoqGp05ZdUaU3LT3aSEkLMww35tdlIeTqreHArvYKWZalWNsstH0Nu
 0aD15aZlRuDS0GLEQ13GNPcWGakWJ0I0nPSSN37fI4zfYqnqitnrX6fdDd1ZorfnCl9h
 bElB4IImCWc8HSqOdVK5ITDhmjLAREuhgwwFBoH0HiuJmmf8hxLZKiTGvNvmpIUclRbk
 O3SSSlIR0COBKUdgixIgTIq83eKYNef+I88ick292BwtHghn7KYUzvj8u3AO710fIP20
 SWPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776808247; x=1777413047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nC4/IfuCqWLrHOWIb20vixvq8u04Kfw625zC9Zwh3XE=;
 b=BKo9J7hc3VPOrW8bOv2bVdF0MUdtIhO14Ir+08F5Pod+C1xzYDr4MCp4uMAX3oVF9A
 I98MJjbXswx/nrcxMPsGk0clP7VNTs1ZnvlPm5P5tUxwpOCqX0U7ZW9/e6MUMO6aeDP+
 Dg39+HlHA8uHB9pk6VUZFVivA4kVxa6c/YLyaVPX1hbCbH7+Njfcersxs53eTFv8KmuO
 2j1f9IrR6yZU5w5FRJBR45Qc/LlKQpXXqpCModPaEsIzIjnbrcZTZ/XwLt2JtRzDEZRY
 ckp+2B5W48XU/hagzBv9RHr/2Rv8HUWVH5tAKdhoqJelb2F/T6i1E6sV2GIHz+BtkXrU
 9iEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776808247; x=1777413047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nC4/IfuCqWLrHOWIb20vixvq8u04Kfw625zC9Zwh3XE=;
 b=ajG5pdx3pOOcSuDp/iBcqhevW4bfl4kyq/I5edD0B1Hv7XQxb4t5Dr9AEeR9meCm20
 Fykzh500JryC06wC1wJ++MDcjuYpU4tUgWvuEwGKygcVVaFvvB7CgA/n+28lxuXzpeOn
 x7vmcyG+zBGebVIeHEy3JsRo7vwUXvLWJQFpUBYDz+Xt4V5WXbUO4hL7xIV1Ox/Ppby2
 wigcJRnJzr6jhrcVq3hs7jvclMhj5Ub9xfGhC8yeDbkNTC6tm9n+DsVqfABhZ9zm4ahk
 OOgLoFU/E84urcP/RpduL0hqBjIMzheOCmRateDqgeDQqjH6ZA2PeGfm5gdUvRbSGNox
 GjFg==
X-Gm-Message-State: AOJu0YxKclguBbQquoECq8qQ110GexcftOxb+c6SjLAirJ0gUe4v8RMR
 O241HDlR+7TwKUZiAPEqsxRvXVLShGktkF1x/0wVPAlJBQlRXV9Ilgm2+V7z2wTjSiQFd9V4eq/
 NJDoy6hayMRmMZ30boBok+CwT+AM4rO8=
X-Gm-Gg: AeBDievA/tMl0ec8/hhss+mBi+hQYxWKM6zmZnu60Q9P/BMbCJ2MmfaSTdom8TiO1dB
 SZ+18G93xjrpwUGwhsJs1rKoHhsr8roW+Xd2GNsnnzjZNHc7Lza+oBbsEmupToqK5e35VS1Ih2B
 EfNYDnuGHmsmY/pXreT5pAPkhaWET1wdKBKf4wC+Xj5CBoVuinYgX/1QXtqHjCYn3eAQmjn19ir
 y0isPCsstcJn/Wygn/t/ZjFYcZSoKs+wwZbRaMRF7Mm1aQdYfxppNuPtKZPLob2R61RIlNy4Qte
 IRfomEChJVhDYbEDa0LGiRByxCQ1O+0p872gVuqzRsrkLwrIg7bl4DiJIt/kjwNUvVHz91UKh7N
 MPjMBgdAcN1gA
X-Received: by 2002:ac8:5851:0:b0:50e:fcbc:6b82 with SMTP id
 d75a77b69052e-50efcbc6ed3mr119300431cf.15.1776808246515; Tue, 21 Apr 2026
 14:50:46 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 22 Apr 2026 07:50:35 +1000
X-Gm-Features: AQROBzDhD6MNYJ3pJMeHarnDzwR9wW6Ms839fofMhDJzyFc9ymyaASPDGvVTpcM
Message-ID: <CAPM=9tyROdmL71Qe+2gLbCEogPDFwLyHhkUoW3H3tfKsKK4qMw@mail.gmail.com>
Subject: [git pull] drm for 7.1-rc1 (part two again...)
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

Okay this time I hope I got the right base and tag. This is just a
resend of that I'll send some fixes content later.

This is a followup pull which is mostly next material with some fixes.

Alex pointed out I missed one of his AMD MRs from last week, so I
added that, then Jani sent the pipe reordering stuff, otherwise it's
just some minor i915 fixes and a dma-buf fix.

Dave.

drm-next-2026-04-22:
drm for 7.1-rc1 (part 2)

drm:
- Add support for AMD VSDB parsing to drm_edid

dma-buf:
- fix documentation formatting

i915:
- add support for reordered pipes to support joined pipes better
- Fix VESA backlight possible check condition
- Verify the correct plane DDB entry

amdgpu:
- Audio regression fix
- Use drm edid parser for AMD VSDB
- Misc cleanups
- VCE cs parse fixes
- VCN cs parse fixes
- RAS fixes
- Clean up and unify vram reservation handling
- GPU Partition updates
- system_wq cleanups
- Add CONFIG_GCOV_PROFILE_AMDGPU kconfig option
- SMU vram copy updates
- SMU 13/14/15 fixes
- UserQ fixes
- Replace pasid idr with an xarray
- Dither handling fix
- Enable amdgpu by default for CIK APUs
- Add IBs to devcoredump

amdkfd:
- system_wq cleanups

radeon:
- system_wq cleanups
The following changes since commit 83e8d8bbffa8161e94f3aeee4dd09a35062a78c8=
:

  Merge tag 'drm-misc-next-fixes-2026-04-09' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
(2026-04-10 11:15:22 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-04-22

for you to fetch changes up to a7756371e57f69a137f295a418fb56f15ff2c10f:

  Merge tag 'drm-misc-next-fixes-2026-04-17' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
(2026-04-17 16:29:24 +1000)

----------------------------------------------------------------
drm for 7.1-rc1 (part 2)

drm:
- Add support for AMD VSDB parsing to drm_edid

dma-buf:
- fix documentation formatting

i915:
- add support for reordered pipes to support joined pipes better
- Fix VESA backlight possible check condition
- Verify the correct plane DDB entry

amdgpu:
- Audio regression fix
- Use drm edid parser for AMD VSDB
- Misc cleanups
- VCE cs parse fixes
- VCN cs parse fixes
- RAS fixes
- Clean up and unify vram reservation handling
- GPU Partition updates
- system_wq cleanups
- Add CONFIG_GCOV_PROFILE_AMDGPU kconfig option
- SMU vram copy updates
- SMU 13/14/15 fixes
- UserQ fixes
- Replace pasid idr with an xarray
- Dither handling fix
- Enable amdgpu by default for CIK APUs
- Add IBs to devcoredump

amdkfd:
- system_wq cleanups

radeon:
- system_wq cleanups

----------------------------------------------------------------
Benjamin Cheng (5):
      drm/amdgpu: Add bounds checking to ib_{get,set}_value
      drm/amdgpu/vce: Prevent partial address patches
      drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg
      drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg
      drm/amdgpu/vcn4: Prevent OOB reads when parsing IB

Ce Sun (1):
      drm/amd/ras: enable uniras via IP version check

Chenyu Chen (2):
      drm/edid: Parse AMD Vendor-Specific Data Block
      drm/amd/display: Use drm_display_info for AMD VSDB data

Dave Airlie (4):
      Merge tag 'amd-drm-next-7.1-2026-04-03' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'topic/pipe-reorder-2026-04-15' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-intel-next-fixes-2026-04-16' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-misc-next-fixes-2026-04-17' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next

Ionut Nechita (1):
      drm/amd/display: Wire up dcn10_dio_construct() for all
pre-DCN401 generations

Jani Nikula (1):
      drm/i915/display: change pipe allocation order for discrete platforms

Lijo Lazar (17):
      drm/amdgpu: Add reserved region ids
      drm/amdgpu: Add stolen vga reserve-region
      drm/amdgpu: Add extended stolen vga reserve-region
      drm/amdgpu: Add stolen_reserved reserve-region
      drm/amdgpu: Add fw_reserved reserve-region
      drm/amdgpu: Add firmware extended reserve-region
      drm/amdgpu: Add fw vram usage reserve-region
      drm/amdgpu: Add host driver reserved-region
      drm/amdgpu: Add memory training reserve-region
      drm/amdgpu: Group filling reserve region details
      drm/amdgpu: Add function to fill fw reserve region
      drm/amdgpu: Add function to fill training region
      drm/amdgpu: Move validation of reserve region info
      drm/amdgpu: Consolidate reserve region allocations
      drm/amd/pm: Add smu vram copy function
      drm/amd/pm: Use smu vram copy in SMUv13
      drm/amd/pm: Use smu vram copy in SMUv15

Linus Probert (2):
      drm/amd/display: Replace inline NUM_ELEMENTS macro with ARRAY_SIZE
      drm/amd/display: Remove unused NUM_ELEMENTS macros

Marco Crivellari (5):
      drm/amd/display: Replace use of system_wq with system_percpu_wq
      drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
      drm/amdgpu: replace use of system_wq with system_dfl_wq
      amd/amdkfd: add WQ_UNBOUND to alloc_workqueue users
      drm/radeon: add WQ_PERCPU to alloc_workqueue users

Mario Kleiner (1):
      drm/amd/display: Change dither policy for 10 bpc output back to dithe=
ring

Mikhail Gavrilov (1):
      drm/amdgpu: replace PASID IDR with XArray

Pierre-Eric Pelloux-Prayer (4):
      drm/amdgpu: save ring content before resetting the device
      drm/amdgpu: extract amdgpu_vm_lock_by_pasid from amdgpu_vm_handle_fau=
lt
      drm/amdgpu: store ib info for devcoredump
      drm/amdgpu: dump job ibs in the devcoredump

Prike Liang (2):
      drm/amdgpu: rework userq fence driver alloc/destroy
      drm/amdgpu: make userq fence_drv drop explicit in queue destroy

Srinivasan Shanmugam (3):
      drm/amd/display: Fix dc_is_fp_enabled name mismatch
      drm/amd/display: Fix parameter mismatch in panel self-refresh helper
      drm/amd/display: Fix missing parameter details in amdgpu_dm_ism

Sumit Semwal (1):
      dma-buf: fix htmldocs error for dma_buf_attach_revocable

Sunil Khatri (5):
      drm/amdgpu/userq: dont need check for return values in amdgpu_userq_e=
vict
      drm/amdgpu/userq: fence wait for max time in amdgpu_userq_wait_for_si=
gnal
      drm/amdgpu/userq: add the return code too in error condition
      drm/amdgpu/userq: call dma_resv_wait_timeout without test for signall=
ed
      drm/amdgpu/userq: use dma_fence_wait_timeout without test for signall=
ed

Suraj Kandpal (1):
      drm/i915/backlight: Fix VESA backlight possible check condition

Timur Krist=C3=B3f (1):
      drm/amdgpu: Use amdgpu by default for CIK APUs too

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915/joiner: Make joiner "nomodeset" state copy independent
of pipe order
      drm/i915: Walk crtcs in pipe order
      drm/i915/wm: Verify the correct plane DDB entry

Vitaly Prosyak (1):
      drm/amdgpu: add CONFIG_GCOV_PROFILE_AMDGPU Kconfig option

Xiaogang Chen (1):
      drm/amdgpu: add an option to allow gpu partition allocate all
available memory

Yang Wang (4):
      drm/amd/pm: correct mem_busy_percent display due to calculation error=
s
      drm/amd/pm: fix null pointer dereference issue in
smu_v15_0_8_get_power_limit()
      drm/amd/pm: optimize logic and remove unnecessary checks in smu v15.0=
.8
      drm/amd/pm: fix memleak issue in smu_v15_0_8_get_gpu_metrics()

 drivers/dma-buf/dma-buf.c                          |   1 +
 drivers/gpu/drm/amd/amdgpu/Kconfig                 |  17 +
 drivers/gpu/drm/amd/amdgpu/Makefile                |   4 +
 drivers/gpu/drm/amd/amdgpu/aldebaran.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   5 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   | 185 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |  21 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  39 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |  17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |  39 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 364 +++++++++--------=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |  53 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  81 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |  50 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  89 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h            |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |  11 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   2 -
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  23 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |  44 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 128 ++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  14 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  21 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |   9 +
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c     |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   2 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   6 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c    |   3 -
 .../drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |   3 -
 .../gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c   |   2 -
 .../gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   |   4 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  17 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  10 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |   9 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  19 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  10 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  10 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |  86 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  12 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |   3 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |   9 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |  16 +-
 drivers/gpu/drm/drm_edid.c                         |  72 ++++
 drivers/gpu/drm/i915/display/intel_crtc.c          |  49 ++-
 drivers/gpu/drm/i915/display/intel_display.c       |  20 +-
 drivers/gpu/drm/i915/display/intel_display.h       |  90 +++--
 drivers/gpu/drm/i915/display/intel_display_core.h  |   3 +
 .../gpu/drm/i915/display/intel_display_driver.c    |   1 +
 drivers/gpu/drm/i915/display/intel_display_types.h |   1 +
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |   9 +-
 drivers/gpu/drm/i915/display/skl_watermark.c       |   4 +-
 drivers/gpu/drm/radeon/radeon_display.c            |   3 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |   3 +-
 drivers/gpu/drm/xe/display/xe_display.c            |   1 +
 include/drm/drm_connector.h                        |  38 +++
 85 files changed, 1165 insertions(+), 780 deletions(-)
