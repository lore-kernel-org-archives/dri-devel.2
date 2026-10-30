Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0553606A336
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UOEBE8Gl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35BFA10E116;
	Fri, 30 Oct 2026 21:38:14 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE2AE112A1E
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:38:07 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-917aca1aee5so14151436d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793396287; cv=none;
 d=google.com; s=arc-20260327;
 b=S8OoG43dytPn1VbwxSOtGe1gTEr+nY+ayyGnH1DcYx4Bs8RyTrrysUk3c8GqnEVv4T
 cte9BGhWEf2PJMwcWUVb8E+AfOsBZe5ShWkGnp42gQY5cmx7GZLEBIAEU3R/XKPWEuPb
 fnysy2tgHhuXZA6XZvERD+MBtdsXR/DYeOy36WdlMREYMqLOJgw5xW1aqqWZnm6uV54e
 kn6zOHasRuc293G66T+gu1XatyCDRA0PmaYQNKYFzWDZyNi3ZnawvuPqOddn76Wx2Mbc
 lBM0SVQ4PZxhu7SuS2zuMarV7wGUfM4t/BDlRjPSuiNezhM0XRb0O8w7wTXAvteuZhGc
 uVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=VWIvYVNrTi7O7BpAsxKjHom4qcgseHjxHJ3UUC8R2UQ=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=Nw3zQt/FT10rVUpOi0YBd+Zh9Umw6f+djAZc/x8rIrqqC7Xx/4XvR9n9TIaaxvovY9
 hO9M8JtwOQd7rbA2wP9Q1eZUSYHiaazuqDqOdlZObpl5DibfJeoBZfcIuPsI0+xPmrLz
 SMEl9BnFt6E65h3lX6g6UvdCkTlTSFl5febNwtFX9+25tlid4X2x/t2oxW4t2vHz6Rzn
 v8X+ruF39BimrMgokPiV2sbAYKoisnnNrcfkOXP3fPlR83C1QvCQBZzyu+CudoCbvyYE
 cDqgSodM2kJBY5syyHq2OonNgRvOM2PWQN36RzAqVbbxVsng6fy5Dgbokgp3YTYgS9QS
 kkrA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793396287; x=1794001087; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VWIvYVNrTi7O7BpAsxKjHom4qcgseHjxHJ3UUC8R2UQ=;
 b=UOEBE8GllVaXhhnyOjJv5PMIydGxd88SQa5C4s54osp8RNi5HnrINTs5stjGdPVpRg
 LnnYj3qezwpAx5hkGlSernqCFPCHNvYoDQVuHo+Joa48r+O3u5iV9w6MOtIfUvgIOCeV
 QYo2pgp9M2QIZFltT4cm2syVWecv0lIhzV8EFhUdrlw3mE2ySH25UvKO4z5QAo+95Hov
 VBk7ac0x38aYQToWskBcBJuFhYIGmLaZEY8sXEoJjWmEX9klHU95sGPyGbK8NTiOzSlS
 Q9qEIWIeVBEX6kA/3tX/mvuPNZUDs2tLbkGMPznklpAqWXS3628wbIrWUtfMLRwHB2f7
 A27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793396287; x=1794001087;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VWIvYVNrTi7O7BpAsxKjHom4qcgseHjxHJ3UUC8R2UQ=;
 b=j/wC9eqCead7KLcFXmCn5LLK2/vVge13V5IvujGiVeNpjEuSsnkNlwlsfJJv7Pqtxb
 3G0aSBFC+IUxRE3zRiEgJk6BBDslK81Ml1OJERErXM3b6kgOtABGAU9Kxzq2zpazkYIm
 6RHv6AEClwzOb8u6hoNrD8dgKrpAcpeHrlzEEC5hjRRKji3/UILSnGItmIz8C3gKQD0G
 gP8SpHkiPxGWw9b9w1wnL1wpZoFPJeRWjiqlKYHxDoBdIjXHH0fHAthI4bAUhGTvhhv4
 kzX9i25y0DJO9OcRCVfa8YefIcW/PjzaGYvPz2TzCa2MLJZoXTmh7cJByMKCU+AAMynS
 jh+w==
X-Gm-Message-State: AFq9FYIyanacqWBFD/gq6b2nkrHpiifwG79rzAW4fmmsE/oMk6gso9ev
 Eu2zTKwazPii0X1xNPWv9fvTxin6NUVsbCLY+ScxuKlaOJkcy8ikZGh5wnE9EWGr8aptY2xYGjw
 JwxGUNJ2m1W900kOxP4Mvhi/uGImx4W4=
X-Gm-Gg: AYBFou1+NomhyTn9AQuUzuEDy44ywiiex/e6rMZWO/qLyXCzNlKvbaHtlDBRkG0/MuG
 KIgp9V2zyjeNR5KYI5pG2cS+O4h8iO1mqGAkjN2G/L3IyzEALyNgC2pG5C62OD3UBmiHtsm5tS6
 jgfLMsEn7QYoouOIl7oHrnJWs5kKbgY/AT/5GIq3sK0sCPholBwsmh0ryQ//zE2h+h8Gq3l6EIa
 Ki5WwUSk52Uvr9ee5VBz3nCjWFKuo2wEkCiiwNw6wEPTC50wjKANyZo5dNbQXsYunm44hlIk14q
 pWjpusrqVLGMv3gsiAo5tO8iZUzEiSKzX8PeMXJJ7aabqJM7tJxCMkhgG0cmV9h1/LgezTNGCU8
 HJaq+D16OOV0XnBgaI1vf4sgDywI0OJqjaWeTD37JBF45jAaUf/OwtK6u5FjdtBWiUySyrcFGQm
 qpGnBJNkz+U+bI8TGfHa3IfGI=
X-Received: by 2002:a05:6214:4586:b0:91c:617a:16d1 with SMTP id
 6a1803df08f44-91ca4b4709amr57040926d6.33.1793396286556; Fri, 30 Oct 2026
 14:38:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 31 Oct 2026 07:37:55 +1000
X-Gm-Features: AclHuK9ybmELFwq_U08T2CsIgoOYjcy1Jz6f1yIFGxlfnvZsJDgvyERSVKXAdCA
Message-ID: <CAPM=9txuHS0rd7POC2gReGGnD0gmA-NrPzh1Gy4QC9824Qc4sA@mail.gmail.com>
Subject: [git pull] drm fixes for 7.4-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

The final set of merge window fixes, from AMD mostly. with one set of
panthor mmu fixes.

Regards,
Dave.

drm-next-2026-10-31:
drm fixes for 7.4-rc1

amdgpu:
- UALink fixes
- Runtime PM fixes
- GPUVM fixes
- Mac fixes
- HDMI fixes
- DP MST fix
- Userptr fix
- SMU fixes
- DSC fix
- VCE/UVD sched teardown fix
- Display runpm reference fix
- Display TD-LUT fix
- SMU 13.x fixes
- SMU 14.x fixes
- Gang submit fix
- Passive DVI sink fix
- USB4 tunnel fix
- Freesync fix

amdkfd:
- SVM fixes
- Fix doorbell allocation race
- GC 12.1 fix
- GPU reset fix
- Buffer accounting fixes
- Bounds checking fixes
- Hotplug fixes
- SVM fixes
- CRIU fixes
- GFX12 fix

panthor:
- Fix bugs in MMU handling
The following changes since commit fad06cfaf385787b9ffa2f73f049d42dbe1de57f:

  Merge tag 'drm-misc-next-2026-10-16' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
(2026-10-21 11:03:26 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-10-31

for you to fetch changes up to f94ed3d7cba3c83eef50b1a96d630d63cf54f69c:

  Merge tag 'amd-drm-next-fixes-7.4-2026-10-28' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-next
(2026-10-29 16:01:40 +1000)

----------------------------------------------------------------
drm fixes for 7.4-rc1

amdgpu:
- UALink fixes
- Runtime PM fixes
- GPUVM fixes
- Mac fixes
- HDMI fixes
- DP MST fix
- Userptr fix
- SMU fixes
- DSC fix
- VCE/UVD sched teardown fix
- Display runpm reference fix
- Display TD-LUT fix
- SMU 13.x fixes
- SMU 14.x fixes
- Gang submit fix
- Passive DVI sink fix
- USB4 tunnel fix
- Freesync fix

amdkfd:
- SVM fixes
- Fix doorbell allocation race
- GC 12.1 fix
- GPU reset fix
- Buffer accounting fixes
- Bounds checking fixes
- Hotplug fixes
- SVM fixes
- CRIU fixes
- GFX12 fix

panthor:
- Fix bugs in MMU handling

----------------------------------------------------------------
Asad Kamal (5):
      drm/amd/pm: Update smu_v15_0_8 PMFW headers
      drm/amd/pm: Add set_npm_limit function
      drm/amd/pm: Add NPM metrics reads and SetNpmLimit
      drm/amd/pm: Add store npm limit function
      drm/amd/pm: Notify node unload during driver unload

Avi Weiss (1):
      drm/amd/display: Initialize missing TD-LUT programming inputs

Boris Brezillon (3):
      drm/panthor: Don't invalidate OTHER caches
      drm/panthor: Fully disable the AS even if it's going to be re-assigned
      drm/panthor: Move cache-flush after UPDATE(UNMAPPED)

Daniel Phillips (1):
      amdkfd: Fix memory availability double accounting of kfd pinned objects

Dave Airlie (3):
      Merge tag 'amd-drm-next-fixes-7.4-2026-10-21' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-next
      Merge tag 'drm-misc-next-fixes-2026-10-23' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
      Merge tag 'amd-drm-next-fixes-7.4-2026-10-28' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-next

Elena Sakhnovitch (1):
      drm/amdgpu/gmc9: add extra type-2 TLB flush for gfx942/gfx950

Fangzhi Zuo (3):
      drm/amd/display: Poll passive DVI sinks for EDID readiness
      drm/amd/display: Cap DSC bpp for USB4 DP tunnels
      drm/amd/display: refresh cached HDMI FreeSync state

Harish Kasiviswanathan (1):
      drm/amdkfd: fix NULL deref in SDMA HQD debugfs dump on GC 12.1

Harkirat Gill (1):
      drm/amdgpu: re-enable GFXOFF for compute on GFX12

Henry Martin (1):
      drm/amdkfd: fix doorbell allocation race creating duplicate allocations

Horatio Zhang (1):
      drm/amdgpu: skip the PASID TLB fence for the UALink NPA VM

Ilya Bakoulin (2):
      drm/amd/display: Fix HDMI FRL FFE compliance test
      drm/amd/display: Adjust HDMI FRL LT timeout

Jesse Zhang (9):
      drm/amdgpu: wake the GPU for INFO queries that access the hardware
      drm/amdgpu: fix the error path in amdgpu_vm_pt_alloc()
      drm/amdgpu: reject ANONONLY userptrs that span multiple VMAs
      drm/amdkfd: don't drop an SVM CWSR reference that was never taken
      drm/amdgpu: reject CS chunks too large for kvmalloc()
      drm/amdkfd: split vram_pages of SVM ranges prefetched without a
GPU mapping
      drm/amdkfd: send SMI process and VM fault events only to allowed clients
      drm/amdgpu: drop the gang leader reference when freeing gang jobs
      drm/amdkfd: evict the queues only once for CRIU PROCESS_INFO

Jiale Yao (1):
      drm/amdkfd: validate SRAT subtables before parsing

John Fisher (1):
      drm/amdgpu: wait for pending page table updates before switching
a VM to CPU updates

Keita Morisaki (1):
      drm/amd/display: Fix swap in median3() for DSC rate control

Kenneth Feng (2):
      drm/amd/pm:restate all customized OD features on every table
upload for smu 13.0.0/smu 14.0.2
      drm/amd/pm: add zero fan stop temperature support on smu 14.0.2

Kevin Wang (3):
      drm/amd/pm: reapply umd profile state after recovery
      drm/amd/pm: preserve committed OD features for SMU 13.0.0/13.0.7
      drm/amd/pm: preserve committed OD features for SMU 14.0.2

Luigi Lauro (2):
      drm/amdgpu: require _PR3 for BOCO
      drm/amd/display: take a runtime PM reference only when a CRTC turns on

Maciej Kucharek (3):
      drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
      drm/amdgpu: reset CIK ASIC on Apple boards with VRAM at 0
      drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0

Mario Limonciello (1):
      drm/amd/display: don't WARN when removing an unallocated MST payload

Olivier Kaloudoff (3):
      drm/amdkfd: tear down KFD processes before early fini_sw on disconnect
      drm/amdkfd: stop restore retries on device unplug
      drm/amdgpu: guard VCE/UVD sched entity teardown on failed probe

Philip Yang (3):
      drm/amdkfd: Fix svm_bo use after free in svm_range_clone
      drm/amdgpu: Reject UALink source-identification address mode
      drm/amdgpu: Enable remote TLB shootdown

William Palacek (2):
      drm/amdkfd: wait for a GPU reset before freeing a BO
      drm/amdkfd: Validate the control stack of a restored queue

Zhen Han (1):
      drm/amdkfd: correct vram_available calculation

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  19 ++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c   |  44 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 105 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  14 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  28 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  33 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |  12 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |  10 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  18 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |  10 +
 drivers/gpu/drm/amd/amdgpu/vi.c                    |  10 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  48 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |  35 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   9 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   9 +
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |  23 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |   9 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   4 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  30 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |  23 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        |  60 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  36 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  15 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  24 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  17 +-
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h     |   4 +-
 .../gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c   |   2 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |   2 +
 .../amd/display/dc/link/hwss/link_hwss_hpo_frl.c   |   3 +
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   2 +
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  | 129 +++++++---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   3 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                | 103 ++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  33 ++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |   2 +
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |  33 ++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 101 +++++++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   8 +
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pmfw.h    |  12 +-
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h   |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |   1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 200 +++++++++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 199 +++++++++++----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   | 279 +++++++++++++++++----
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   | 157 +++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h   |   4 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  26 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |   2 +
 drivers/gpu/drm/panthor/panthor_mmu.c              |  45 ++--
 68 files changed, 1660 insertions(+), 468 deletions(-)
