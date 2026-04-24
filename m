Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1682BFB44B4
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BDCF10E118;
	Fri, 24 Apr 2026 06:05:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D0UTK5F7";
	dkim-atps=neutral
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95EB10E118
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 06:05:50 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-5062fc5d86aso61195131cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 23:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777010750; cv=none;
 d=google.com; s=arc-20240605;
 b=eMklkl3jO8WoyYXjXv77kG/3tT6oAXfg4e0UUE/gLAohFZoCNZ8fCE5QQtY/tpv91i
 Qe0Ar6xjWWYsl1t6mzCJnwTmTc1aJXowBZssg6MQm+KJwu/nuozB+9h/UIy4nJU9J/3L
 Fxmfo+UEcPSIsOCG5JGuNF2ri3wrXAY0Tba+hWFh0QzP/df8832y96rPIR2VeUGGl2BW
 RI3i7Xum6dDVydjdYTq77gko6fHSy7NI24DKnMC5EzbYENr/uH89CBBml1lhbV/v+4I3
 ANEE+0MAd9Z+tOfLF79xUqjsQO5EEXN8W6s6OTBpS6US3zepmSFon9Omn8gFHQ5ql31L
 Kn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=Ybh5W7sbt1B+J4+CpbFkmKKjP5uQaf7WNuShnbBDeyc=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=cNA6FwiGqymhffV9EvwsvgRmVtmjbQcAE6jdmJwIRpveQMmO9KSUWWRf/A2FzoCrUw
 dUubglXaYi0bJ/+/XcQL9UAVVEehO+F5XD1SmvJiH3P/c438PgjYWNh/RT1fWV23yYO3
 tahvW63NHxX2GPv3+h+SeSLmsv6lEdPyr4Yr4az5MCp+hcPV1NIPy9xQ9O0iQOaFkQ/l
 dN1aZlG4ZaTgltGhnUj+RzOACQUc1+JzCP9g6Gc289RhQOe8aVAtbjP0n3bYZ3HncxMR
 nGhqQPSLjvuEDEBDTMNSeDoEwzekceNoavyKtscJPzhMT/58DeTPOENQxuUK0TQtJGnA
 sfXQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777010750; x=1777615550; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ybh5W7sbt1B+J4+CpbFkmKKjP5uQaf7WNuShnbBDeyc=;
 b=D0UTK5F7/AxtPeaFe6or/83hRO8EYC656N7ob1vlVHFZcFDvxv6qQyzteIvTOAAE4t
 KwyyzPpV+fu5RsrufomQ7tbkUFvy4SOG/+5590PGSRKTzygvg1IGhfTVXbtJCsan63TK
 xv4DjIz6Z7i2ZQwO5b6wTJBcsQfWnOqcTvVvgyDJzPeHTN1MdYn6cshwQnL8MvueHdBQ
 hzkuax8wcM8fb05YDhrDBnCJrBmLZ6lCwzjo9RFWj42+kXjw4tqzt3iZGEzcFZeNK2HI
 LCxUJAdIXhR6uuatGN3lHR6jZABNFusQUVQ+zQvm+KL+tJnGfFfEq2IqZF+5DWCyUzQ4
 RLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777010750; x=1777615550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ybh5W7sbt1B+J4+CpbFkmKKjP5uQaf7WNuShnbBDeyc=;
 b=mIvy3+bHwTX2j9wAolR40jYqRgn20hjngY6mbfEodos2X2mZxp/BoT6hNQ0bO60fb6
 SDG3WyOdupTfzOEpxOvpaC4HAIDdExe22D2sbFItdQ+0E0312v2V0kSCjW+C3B77TJv0
 eDc5KLBR3XNnd6YwzbRv8PGs+upvGhVlQMUMWEGawYJErQzkL1VzjaUph6B3eiJuJEYi
 e0Pv4ZTdshY1VqKthvIv7WUp5bsYHnzHZ1s9pMyTLpvAqUJcPHAa3VJm4wGz3Fh3QX2p
 qsW/eCoXu2w5EHf/xXJ1dxDHZkLyxL6j9+k69WsEfS0iH44w6JbvjJBy1BofN5igaL7N
 wwNg==
X-Gm-Message-State: AOJu0YwJiQORUTJ6ZSo0+RwWtprTNrjwX2r+Qo10EH0vsYVkmW2BaBeE
 OjPjhVUPSSWXeUvzBynPYbMYH2Q1rcmxSZObxB08FeHK7k6FM0KcOCaGRgDh4UJsfb9phq7M2YS
 uSlqDTf+4DA5nznMPQCi6XrFHmlcTvz0=
X-Gm-Gg: AeBDiesdiyU+IJmSvYPaRm8p8fFqDHzfMUEmuoxyXcD/2ZHXKdZ5S3PIbERfWeKJdWb
 wcA86hC39bKtlIEPv6ljktqLlgweMGi2gsLgMHs1ZQWJ1AkFmXxts4XwqJxM/zWS+Y9rb3hVox2
 sJh29ASLPlvrif3c/BQcgjkYZqxZNOChTgiRIfyTUBbZMqnmXtkacQXgKDB9VLlSrIQf160PPsB
 MpYke+GH/T1EKFlPtOKsxU+7xFmDSJ+XPylEXdMNknFa8GYDzdf4ro2Zf0DdL1kbgRsmfpDrNAH
 UE3+1YWJSfQ0+pzuLgmRUr2+f4UJerBzQrZvgM0CVS5yTuIlHuhhhRC/G6meKXaBFzKZI9ltsCJ
 Jzg==
X-Received: by 2002:a05:622a:4291:b0:50f:b81e:c663 with SMTP id
 d75a77b69052e-50fb81ecc7fmr203285301cf.40.1777010749434; Thu, 23 Apr 2026
 23:05:49 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 24 Apr 2026 16:05:38 +1000
X-Gm-Features: AQROBzC394zBP_m8GbtbD_dqJrYXKX-mYfEHbdcqyojWcNpXlB7MbfqKfIajdxI
Message-ID: <CAPM=9txGwneUzw-Qv2P1yy9jAqJssAdm+0-5C2yL=cDm-_SJOg@mail.gmail.com>
Subject: [git pull] drm next fixes for 7.1-rc1
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

This is the first of two fixes for the merge PRs, the other is based
on 7.0 branch. This mostly AMD fixes, a couple of weeks of backlog
built up and a this weeks. The main complaint I've seen is some boot
warnings around the FP code handling which this should fix. Otherwise
a single rcar-du and a single i915 fix.

and hopefully this has content in it.

Regards,
Dave.

drm-next-2026-04-24:
drm next fixes for 7.1-rc1

amdgpu:
- SMU 14 fixes
- Partition fixes
- SMUIO 15.x fix
- SR-IOV fixes
- JPEG fix
- PSP 15.x fix
- NBIF fix
- Devcoredump fixes
- DPC fix
- RAS fixes
- Aldebaran smu fix
- IP discovery fix
- SDMA 7.1 fix
- Runtime pm fix
- MES 12.1 fix
- DML2 fixes
- DCN 4.2 fixes
- YCbCr fixes
- Freesync fixes
- ISM fixes
- Overlay cursor fix
- DC FP fixes
- UserQ locking fixes
- DC idle state manager fix
- ASPM fix
- GPUVM SVM fix
- DCE 6 fix

amdkfd:
- Fix memory clear handling
- num_of_nodes bounds check fix

i915:
- Fix uninitialized variable in the alignment loop [psr]

rcar-du:
- fix NULL-ptr crash
The following changes since commit a7756371e57f69a137f295a418fb56f15ff2c10f=
:

  Merge tag 'drm-misc-next-fixes-2026-04-17' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
(2026-04-17 16:29:24 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-04-24

for you to fetch changes up to e49712ef03dbc4e282dd0e76469642279c2811e5:

  Merge tag 'amd-drm-fixes-7.1-2026-04-23' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next (2026-04-24
09:17:41 +1000)

----------------------------------------------------------------
drm next fixes for 7.1-rc1

amdgpu:
- SMU 14 fixes
- Partition fixes
- SMUIO 15.x fix
- SR-IOV fixes
- JPEG fix
- PSP 15.x fix
- NBIF fix
- Devcoredump fixes
- DPC fix
- RAS fixes
- Aldebaran smu fix
- IP discovery fix
- SDMA 7.1 fix
- Runtime pm fix
- MES 12.1 fix
- DML2 fixes
- DCN 4.2 fixes
- YCbCr fixes
- Freesync fixes
- ISM fixes
- Overlay cursor fix
- DC FP fixes
- UserQ locking fixes
- DC idle state manager fix
- ASPM fix
- GPUVM SVM fix
- DCE 6 fix

amdkfd:
- Fix memory clear handling
- num_of_nodes bounds check fix

i915:
- Fix uninitialized variable in the alignment loop [psr]

rcar-du:
- fix NULL-ptr crash

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/sdma7.1: add support for disable_kq

Alex Hung (1):
      drm/amd/display: Use overlay cursor when color pipeline is active

Alysa Liu (1):
      drm/amdkfd: Add upper bound check for num_of_nodes

Amir Shetaia (1):
      drm/amdkfd: Clear VRAM on allocation to prevent stale data exposure

Ce Sun (2):
      drm/amdgpu: correct single device PCIe reset flow for DPC
      drm/amd/ras: Avoid ECC status update in hw_fini for VF unload

Charlene Liu (1):
      drm/amd/display: update dcn42 bounding box

Chenglei Xie (1):
      drm/amdgpu: gate VM CPU HDP flush on reset lock

Chuanyu Tseng (1):
      drm/amd/display: Fix coding style issue

Dave Airlie (4):
      Merge tag 'amd-drm-next-7.1-2026-04-17' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2026-04-22' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-misc-next-fixes-2026-04-23' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'amd-drm-fixes-7.1-2026-04-23' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next

David (Ming Qiang) Wu (1):
      amdgpu/jpeg: fix deepsleep register for jpeg 5_0_0 and 5_0_2

Dmytro Laktyushkin (2):
      drm/amd/display: update dcn42 memory latencies
      drm/amd/display: move memory latency update to dml for dcn42

Gaghik Khachatrian (3):
      drm/amd/display: Fix unused parameters warnings in dml2_0
      drm/amd/display: Fix implicit narrowing conversions in modules
      drm/amd/display: Fix compiler warnings

George Shen (1):
      drm/amd/display: Remove unnecessary Freesync w/a from DCN32

Jouni H=C3=B6gander (1):
      drm/i915/psr: Init variable to avoid early exit from et alignment loo=
p

Laurent Pinchart (1):
      drm: rcar-du: Fix crash when no CMM is available

Leo Li (1):
      drm/amd/display: Undo accidental fix revert in amdgpu_dm_ism.c

Mario Limonciello (2):
      drm/amd: Add missing firmware declaration for PSP v15.0.0
      drm/amd: Adjust ASPM support quirk to cover more Intel hosts

Nicholas Kazlauskas (5):
      drm/amd/display: Fix HostVMMinPageSize unit mismatch in DML2.1
      drm/amd/display: Correct MALL parameters for DCN42 soc bb
      drm/amd/display: Pass min page size from SOC BB to dml2_1 plane confi=
g
      drm/amd/display: Fix DCN42 gpuvm_min_page_size_kbytes in SOC BB
      drm/amd/display: Add DCN42 PMO policy for DML2.1

Prike Liang (1):
      drm/amdgpu: drop userq fence driver refs out of fence process()

Rafal Ostrowski (1):
      drm/amd/display: Move dml2_destroy to non-FPU compilation unit

Ramalingeswara Reddy, Kanala (2):
      drm/amdgpu: Use SMUIO 15.0.0 offsets for TSC upper and lower count.
      drm/amdgpu: Use NBIF offset for register RCC_STRAP0_RCC_DEV0_EPF0_STR=
AP0 .

Ray Wu (1):
      drm/amd/display: fix NULL ptr deref in ISM delayed work

Relja Vojvodic (1):
      drm/amd/display: Rework YCbCr422 DSC policy

Roman Li (2):
      drm/amd/display: Drop unused tiling formats from dml2
      drm/amd/display: Remove redundant includes from DC

Siwei He (1):
      drm/amdgpu: OR init_pte_flags into invalid leaf PTE updates

Srinivasan Shanmugam (6):
      drm/amd/pm: smu7: Remove stale error check in smu7_hwmgr_backend_init
      drm/amd/pm: Fix mode2 reset ACK handling on aldebaran v2
      drm/amdgpu/mes_v12_1: Fix iterator reuse in mes_v12_1_test_ring()
      drm/amd/display: Add missing do_mccs parameter description
      drm/amdgpu: Clear cached EDID pointer after drm_edid_free()
      drm/amd/display: Fix ISM teardown crash from NULL dc dereference

Sunil Khatri (12):
      drm/amdgpu: add job->pasid in check as amdgpu_job could be NULL
      drm/amdgpu/userq: avoid uneccessary locking in amdgpu_userq_create
      drm/amdgpu/userq: clean the VA mapping list for failed queue creation
      drm/amdgpu/userq: fix kerneldoc for amdgpu_userq_ensure_ev_fence
      drm/amdgpu/userq: dont lock root bo with userq_mutex held
      drm/amdgpu/userq: create_mqd does not need userq_mutex
      drm/amdgpu/userq: caller to take reserv lock for vas_list_cleanup
      drm/amdgpu/userq: hold root bo lock in caller of input_va_validate
      drm/amdgpu/userq: unmap is to be called before freeing doorbell/wptr =
bo
      drm/amdgpu/userq: unmap_helper dont return the queue state
      drm/amdgpu/userq: use pm_runtime_resume_and_get and fix err handling
      drm/amdgpu/userq: unpin and unref doorbell and wptr outside mutex

Taimur Hassan (2):
      drm/amd/display: Promote DC to 3.2.377
      drm/amd/display: Promote DC to 3.2.378

Timur Krist=C3=B3f (1):
      drm/amd/display: Disable 10-bit truncation and dithering on DCE 6.x

Vitaly Prosyak (2):
      drm/amdgpu: fix NULL pointer dereference in amdgpu_devcoredump_format
      drm/amdgpu: fix heap buffer overflow in amdgpu_coredump ring dump

Wayne Lin (6):
      drm/amd/display: Adjust freesync pcon whitelist
      drm/amd/display: Parse freesync mccs vcp code
      drm/amd/display: Read sink freesync support via mccs
      drm/amd/display: Enable sink freesync via MCCS
      drm/amd/display: Avoid to do MCCS transaction if unnecessary
      drm/amd/display: Fix fpu guard warning

Wenjing Liu (3):
      drm/amd/display: fix math_mod() using arg1 instead of arg2
      drm/amd/display: add const qualifiers to watermark params struct
      drm/amd/display: add pstate schedule admissibility flags and
frame-time utility

Xiang Liu (1):
      drm/amdgpu: fix CPER ring header parsing

Xiaogang Chen (1):
      drm/amdgpu: Remove sys file compute_partition_mem_alloc_mode at
module unload

Yang Wang (4):
      drm/amd/pm: fix incorrect FeatureCtrlMask setting on smu v14.0.x
      drm/amd/pm: fix runtime PM imbalance issue in amdgpu_pm.c
      drm/amd/pm: add read arg support to smu_cmn_update_table
      drm/amd/pm: add od table upload error message parsing for smu v14.0.x

Zheng, Austin (1):
      drm/amd/display: Remove Duplicate Prefetch Parameter

filippor (1):
      drm/amdgpu: fix IP discovery v0 handling

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c           |  36 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 142 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  47 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c         |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  31 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |  52 ++++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  25 ++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   8 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           |   9 +-
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |  12 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   3 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  11 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 135 +++++++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   7 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 241 +++++++++++++++++=
++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |  15 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   2 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |  78 -------
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   2 -
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   6 +
 drivers/gpu/drm/amd/display/dc/dc.h                |  13 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |   6 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   2 -
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  10 +
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |   2 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h   |   2 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c   |   6 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h   |   6 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  37 ----
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |   1 +
 .../drm/amd/display/dc/dml2_0/display_mode_core.c  |  17 ++
 .../drm/amd/display/dc/dml2_0/display_mode_util.c  |  14 ++
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |  24 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c  |   2 +
 .../amd/display/dc/dml2_0/dml21/dml21_wrapper.c    |   4 +-
 .../display/dc/dml2_0/dml21/dml21_wrapper_fpu.c    |   2 +
 .../dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h |  25 ++-
 .../dml2_0/dml21/inc/dml_top_display_cfg_types.h   |  14 --
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c |   5 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |  37 +++-
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |  40 ++--
 .../dml2_0/dml21/src/dml2_core/dml2_core_utils.c   |  73 +------
 .../dml2_0/dml21/src/dml2_core/dml2_core_utils.h   |   3 +-
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |   1 +
 .../dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c |   2 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c   |   1 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c  | 192 ++++++++++++++++
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h  |  17 ++
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       |  21 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h       |  10 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c   |   3 +
 .../src/dml2_standalone_libraries/lib_float_math.c |   2 +-
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c  |   2 +
 .../amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c  |   9 +
 .../display/dc/dml2_0/dml2_translation_helper.c    |   6 +
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c |   1 +
 .../gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c   |  11 +
 .../drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c   |  10 -
 .../display/dc/dml2_0/dml_display_rq_dlg_calc.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |  13 +-
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c   |   2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c   |   2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c |   2 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |  25 ++-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   3 +-
 .../display/dc/link/protocols/link_dp_capability.c |   5 +-
 .../amd/display/dc/resource/dcn21/dcn21_resource.c |   7 +
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |   9 +
 .../display/dc/resource/dcn315/dcn315_resource.c   |   9 +
 .../display/dc/resource/dcn316/dcn316_resource.c   |   7 +
 .../dcn42/dcn42_soc_and_ip_translator.c            |   4 +
 .../drm/amd/display/include/ddc_service_types.h    |   1 +
 .../drm/amd/display/modules/freesync/freesync.c    |  32 ++-
 .../drm/amd/display/modules/power/power_helpers.c  |  49 +++--
 drivers/gpu/drm/amd/display/modules/vmid/vmid.c    |   8 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  14 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |   3 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  70 +++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  37 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |  14 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |   9 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |   2 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c     |   6 +-
 98 files changed, 1380 insertions(+), 535 deletions(-)
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h
