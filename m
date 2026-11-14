Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DD606A337
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LcfKKwar
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C01410E1C5;
	Sat, 14 Nov 2026 01:30:51 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E9E10E1C5
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 01:30:45 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-93f20c3aaa5so322610885a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:30:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794619844; cv=none;
 d=google.com; s=arc-20260327;
 b=NSE3hVYk2RSNmLr15X/BMDeS/PnMdlMEK31s41QYryccPCVTkcbVUBbv8ooXpl9Z/V
 Qn9tNnvuozQgWtGfPgPnPwur4JzlsyDj6Yv0y44wKhVKPSVibVu7X23PqkmAd6LJHe1a
 q90uyKKR1skeTCi69jeU6T036AUIMzdRo6CTIdjWRXrs+IkVP4RWteEljD4FR17igt0K
 /DnCwKUIsYqw0c5ArrKWHW+grTM6XBv7pecDlmqCEI7Z82bKn0YiwHvyADRPoEPtm7x9
 Xr2uiun8xCM+PpHpoNt/tv/PBEZIl/aW9XU/SDJKmZyH8quwF4oHTrmgXHyQFN4vc2Bh
 OhPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=aU4qdjqU2yozqqLbsriO/uZOt3jQy0S8E/CVbp7Mc5o=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=mAYO/GrzuNDEMNbybuJ5GwjF8gMmpKYgNoRAMnhkuqJWaMy2i8qd7fjztHMNukznFl
 shh5vPPPc10+W9P/AKDhuJ+4/E6fvRffz+GOm6ITz0dlIsXEhLSuekSebYykcgBOyHrt
 fsK5StVI3htS6XZW49QPl05sZ0eneLkfnzCJaA7uy4Nsbo8Nmbn7SA7+AZvfneWSnfZ8
 6cGYv5bGeLACciwWW+eAUhI1VpxUT5SDzbXU368deczOWmoALaz1VmMR7RIYs21O90EA
 +t5h2/loklj9hvVPRzIZEZSeSJofNm06EKJGbo8x/fW5p7TtvIQjVckmcO84lCxjrr3x
 5YPA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794619844; x=1795224644; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aU4qdjqU2yozqqLbsriO/uZOt3jQy0S8E/CVbp7Mc5o=;
 b=LcfKKwary4lTqbNWjDX12XyZgMV3UuWoMyktQISG3wbkr2qNgYxiDlgv5qV3xjqs5f
 J3b5tZNLsxrlr4Jbn+atTy2eGD+evgDntIUnHTUua3MfNrvomxSmXalauMZuSyZpkOSY
 rjZt5HbYpFp/US7fMWSRgMlptOU63brOidDU+8D6Ptzjs0dJH8dSVHldsAbrXY4QGKrA
 54+Y5S7Cwr3MRrOVsHvc905ZsBbBb9n3RlD1yPj9l+MBuWvK7airc+9SttMe+8R4dL55
 TZnY3n6HLjmhwotDGmf0VHsRk6+xlcsbe0OE+CGzWyK5N2U10AoQd7GCtPiKJm4yoc0m
 Koqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794619844; x=1795224644;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aU4qdjqU2yozqqLbsriO/uZOt3jQy0S8E/CVbp7Mc5o=;
 b=Kv5ODonC0tBT35YqTbLI2LBoo2abUitnt16x2hhkGiPXfMKH2N4fn8VocccvHIQ6LJ
 8rYzwaC12TPnxftHp5RISmTUZ+hvbAKuYPwasergIyRerA2+evwS8T216mAcr69LWJcE
 ue+lngiIpN5tInGEW3ZBifIRyS/pfVJUaLX8gPoROG7mTd341B6Nz4bXq/Mg2GAQBBhP
 IStMvq8RcJM24SFUQO0ysLAoJXT80R5Buhv4ENGFOvPzRLhJY8ZF4aDrFjovJj/tl5xz
 tCcC3l5oV3yh5JHUxxm6v6QTQ4dofg7+s+/WZpJ+MF8Q/uf+sdV1tmQ6KUYOXQMA4BDV
 HSrQ==
X-Gm-Message-State: APuU4Z+7/SgJ0FfjMNWYzPHXmrb/aE6waHLQL7PCEeFPjv1IZg9s/oNh
 nPb4Z6k/wleqNnR3NJhdq0IPgFFrai7E+zhjocL8cCb42sNcRN5F/yVF7miMFJYRb0rvY/+RqNp
 U2kco4P7PJhFNF3mVwyYHOs3TpO0tSKo=
X-Gm-Gg: AYBFou3QlxstKvZ6k1cZ4y+nyyUkEc1/6QeFvtWNsXHjtqVn64Yx0uB+BTv73Ni/Ym3
 kNxJ7cL7irsK2FQPcNU4zdjrVQ53o5AsHn7WPfKxfhnIpI4uda0AsvVAlLw/uSD9MYZzBtllOle
 5BzaOhdtreo20+W+9TXTrYXDrp4LShb//EUFkLD1bJGUrseVqClI79tpL3fezvBC4serq4oI03u
 Ve/KWTJwofBHOWmSXm21pPBZeukvG+K267/TO2UrX91+q2YMOc36knGG3KNNlR7T2irnI1mK+G5
 oBLdNfLgZyW2KnZdwsErvX95HGau6BCfa0mGoao6cyqA0Y0vbglFe0SWVutp0pgqPS3yLbUClNN
 0gMheWEJlw+lFGprQkH7iwsrmC95gGFZSCbpUYloxtoRp5LTKee38xovHHpFI1VSbdBjzJn+FaR
 CQqrZaNu6OIWMLbYPQJZkkeXEi4LGW8CXZoG0I71hEYJE=
X-Received: by 2002:a05:620a:a989:10b0:949:57b4:387a with SMTP id
 af79cd13be357-94957b43b37mr338991985a.36.1794619843865; Fri, 13 Nov 2026
 17:30:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 14 Nov 2026 11:30:32 +1000
X-Gm-Features: AclHuK_0Ht3nmkKUmoGltaAWaT2b3ahVa5kW-P179gYEraTyQ0b0MFpIKviy_Q4
Message-ID: <CAPM=9tyPUacWoB9-tqq+hNDB2RexAuTB7Whp1hMs1d4ZmeswpA@mail.gmail.com>
Subject: [git pull] drm fixes for 7.4-rc3
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

Weekly drm fixes, this is a bit bigger as we missed xe last week due
to a tree screw up, so it's mostly xe and amdgpu, then the usual
scattering of fixes across drivers.

Let me know if there are any issues,

Dave.

drm-fixes-2026-11-14:
drm fixes for 7.4-rc3

sched:
- Ensure stopped entity cannot be re-added to the run-queue

bridge:
- ssd2825: Fix panel enable sequence
- sii902x: validate I2S data lane values

display:
- hdmi: Fixes to SCDC

i915:
- Fix for PTL GitLab #9196: eDP-2 on DDI B ends up in a state where
any enable fails
- PSR fixes

amdgpu:
- DCN 6 DML2 fix
- VCE fixes
- GC 11.0.2 fix
- SMU 15 fix
- Error handling fixes
- Partition fix
- IMU firmware clean up fix
- TLB fence handling fix

amdkfd:
- SVM fixes
- CRIU fixes

xe:
- select configfs
- Sync Wa_16023105232 in xe_was to match OOB rule
- Program LMTT directory pointer from each GT init path
- Demote uncorrectable local error log on CRI
- Apply tile workarounds after PCODE init
- VRAM offlining fixes
- ras: Fix sysctrl and drm-ras discrepancy
- pat: Return error from xe_pat_init_early() on unknown
- Prevent VF memory IRQ from accessing a torn-down engine
- guc: Protect timeout handling from device unplug
- gt: Disable GT reset worker before engine teardown
- Various hwmon fixes
- tuning: Restrict Anyhit NULL-query tuning to render engines
- gsc: Fix NVL-S GSC compatibility number
- Don't abort the shrinker walk on -EBUSY
- Mark xe_vma_ops_alloc() noinline for error injection
- lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2
- Fix build with DRM_XE=3Dy and CONFIGFS_FS=3Dm
- madvise: use already clamped pat_index
- Various wedging fixes
- Rebind BOs evicted before the first LR queue
- Toggle the D3Cold enable flag at runtime resume
- Access GT MMIO after pcode init
- xe_late_bind_fw: Fix firmware leak on missing manifest entry
- svm: Preserve default PAT index when resetting VMA attributes
- Unwrap sync fences before adding them as job dependencies
- Schedule disable G2H fixes

gud:
- Avoid divide error in gud_stats_debugfs

meson:
- load ENCL gamma table while ENCL is disabled

nouveau:
- disp: Set atomic functions in struct drm_mode_config_funcs
- gsp: Handle only IRQs routed to host

panfrost:
- Fixes to perfcnt

vc4:
- Fix firmware reference leak
- Hold runtime PM reference while allocating the binner BO
- Rebuild V3D interrupt mask on every power transition
- Re-enable the V3D interrupt after a GPU reset
The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb=
:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-11-14

for you to fetch changes up to 637c4514732baa5d19bb716c00d6fd67034f238f:

  Merge tag 'drm-misc-fixes-2026-11-13' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2026-11-14 09:49:09 +1000)

----------------------------------------------------------------
drm fixes for 7.4-rc3

sched:
- Ensure stopped entity cannot be re-added to the run-queue

bridge:
- ssd2825: Fix panel enable sequence
- sii902x: validate I2S data lane values

display:
- hdmi: Fixes to SCDC

i915:
- Fix for PTL GitLab #9196: eDP-2 on DDI B ends up in a state where
any enable fails
- PSR fixes

amdgpu:
- DCN 6 DML2 fix
- VCE fixes
- GC 11.0.2 fix
- SMU 15 fix
- Error handling fixes
- Partition fix
- IMU firmware clean up fix
- TLB fence handling fix

amdkfd:
- SVM fixes
- CRIU fixes

xe:
- select configfs
- Sync Wa_16023105232 in xe_was to match OOB rule
- Program LMTT directory pointer from each GT init path
- Demote uncorrectable local error log on CRI
- Apply tile workarounds after PCODE init
- VRAM offlining fixes
- ras: Fix sysctrl and drm-ras discrepancy
- pat: Return error from xe_pat_init_early() on unknown
- Prevent VF memory IRQ from accessing a torn-down engine
- guc: Protect timeout handling from device unplug
- gt: Disable GT reset worker before engine teardown
- Various hwmon fixes
- tuning: Restrict Anyhit NULL-query tuning to render engines
- gsc: Fix NVL-S GSC compatibility number
- Don't abort the shrinker walk on -EBUSY
- Mark xe_vma_ops_alloc() noinline for error injection
- lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe2
- Fix build with DRM_XE=3Dy and CONFIGFS_FS=3Dm
- madvise: use already clamped pat_index
- Various wedging fixes
- Rebind BOs evicted before the first LR queue
- Toggle the D3Cold enable flag at runtime resume
- Access GT MMIO after pcode init
- xe_late_bind_fw: Fix firmware leak on missing manifest entry
- svm: Preserve default PAT index when resetting VMA attributes
- Unwrap sync fences before adding them as job dependencies
- Schedule disable G2H fixes

gud:
- Avoid divide error in gud_stats_debugfs

meson:
- load ENCL gamma table while ENCL is disabled

nouveau:
- disp: Set atomic functions in struct drm_mode_config_funcs
- gsp: Handle only IRQs routed to host

panfrost:
- Fixes to perfcnt

vc4:
- Fix firmware reference leak
- Hold runtime PM reference while allocating the binner BO
- Rebuild V3D interrupt mask on every power transition
- Re-enable the V3D interrupt after a GPU reset

----------------------------------------------------------------
Adri=C3=A1n Larumbe (1):
      drm/panfrost: Fix race when restoring reset state in perfcnt

Andrei Krautsou (1):
      drm/amdgpu: enable MGCG/FGCG/PERF_CLK for GC 11.0.2

Apurv Mishra (1):
      drm/amdkfd: Don't reuse a VRAM page that is still referenced

Arnd Bergmann (1):
      drm: xe: select configfs

Arvind Yadav (2):
      drm/xe: Rebind BOs evicted before the first LR queue
      drm/xe/svm: Preserve default PAT index when resetting VMA attributes

Badal Nilawar (1):
      drm/xe/xe_late_bind_fw: Fix firmware leak on missing manifest entry

Boris Brezillon (1):
      drm/panfrost: Enable cycle counting when perfcnt is enabled

Chen, Junjia (1):
      drm/xe: Unwrap sync fences before adding them as job dependencies

Christian K=C3=B6nig (1):
      drm/amdgpu: fix TLB invalidation fence handling v4

Cristian Ciocaltea (3):
      drm/display: hdmi: Prevent NULL pointer dereference in sync_scdc()
      drm/display: hdmi: Use committed state to decide on SCDC resync
      drm/display: hdmi: Reset sink scrambling on non-scrambled modesets

Daniel Charles (1):
      drm/xe/pm: Apply tile workarounds after PCODE initialization

Daniele Ceraolo Spurio (1):
      drm/xe/gsc: Fix NVL-S GSC compatibility number

Dave Airlie (5):
      drm/nouveau/disp: Set
drm_mode_config_funcs.atomic_(check|commit) (attempt 2)
      Merge tag 'drm-intel-fixes-2026-11-12' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.4-2026-11-12' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-11-12' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-11-13' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

David Francis (2):
      drm/amdkfd: Acquire buffers in CRIU queue restore (again)
      drm/amdkfd: Acquire cwsr buffer during CRIU resume

David Rosca (1):
      drm/amdgpu: Fix VCE buffer size check for DPB and input surface

Dnyaneshwar Bhadane (1):
      drm/xe/pat: Return error from xe_pat_init_early() on unknown platform

Gustavo Sousa (1):
      drm/xe: Sync Wa_16023105232 in xe_was to match OOB rule

Hamza Mahfooz (1):
      MAINTAINERS: add myself as a maintainer for the Hyper-V DRM driver

Helen Koike (1):
      drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET programming for pre-Xe=
2

Imre Deak (6):
      drm/i915/dp_aux: Take the TypeC port lock after the PPS lock
      drm/i915/pps: Hold a TypeC link reference for PPS VDD
      drm/i915/pps: Reset PPS state after TypeC port init on resume
      drm/i915/ptl+: Add TypeC HPD pin selection for port B
      drm/i915/mtl+: Use PHY type to identify TypeC ports in PLL ID lookup
      drm/i915/ptl+: Fix TypeC detection for eDP on port B

Ivan Lipski (1):
      drm/amd/display: Fix __udivdi3 link error in DCN6 DML2

Jagmeet Randhawa (2):
      drm/xe/guc: Fix race around q->guc->suspend_pending access
      drm/xe/guc: Do not attribute a TDR disable to a pending suspend

Jesse Zhang (3):
      drm/amdkfd: skip GPUs without a VM when checkpointing the BO mappings
      drm/amdgpu: fix the error handling of amdgpu_vm_init_entities()
      drm/amdgpu: release the IMU firmware with the other GFX microcode

Joe Finzel (1):
      drm/nouveau/gsp: only handle GSP interrupts routed to the host

Jouni H=C3=B6gander (4):
      drm/i915/psr: Flush on cursor update also when not using Selective Fe=
tch
      drm/i915/display: Flush the fbdev frontbuffer
      drm/i915/psr: Re-arm PSR after flush
      drm/i915/psr: Clear CFF state on flip flush

Kanala Ramalingeswara Reddy (1):
      drm/amdgpu: use supported SMU clock messages on SMU 15.0.0

Karthik Poosa (5):
      drm/xe/hwmon: Fix pcode power limit handling
      drm/xe/hwmon: Decode mailbox temperature as sign-magnitude
      drm/xe/hwmon: Fix thermal sensor data handling
      drm/xe/hwmon: Add helpers to validate thermal sensor readings
      drm/xe/hwmon: Handle unavailable memory controller sensors

Lijo Lazar (1):
      drm/amdgpu: Allow cancelling a requested NPS mode

Matthew Auld (1):
      drm/xe/madvise: use already clamped pat_index

Matthew Brost (1):
      Merge v7.4-rc2 into drm-xe-fixes

Ma=C3=ADra Canal (3):
      drm/vc4: Hold a runtime PM reference while allocating the binner BO
      drm/vc4: Rebuild the V3D interrupt mask on every power transition
      drm/vc4: Re-enable the V3D interrupt after a GPU reset

Nitin Gote (1):
      drm/xe/tuning: Restrict Anyhit NULL-query tuning to render engines

Pengpeng Hou (1):
      drm/bridge: sii902x: validate I2S data lane values

Perry Yuan (1):
      drm/amdkfd: check CRIU SVM priv data bounds before allocating

Raag Jadav (8):
      drm/xe/ras: Fix sysctrl and drm-ras discrepancy
      drm/xe/gt: Use GT ordered workqueue for wedging
      drm/xe: Drop xe_device_set_wedged_method()
      drm/xe/hw_error: Guard csc_hw_error_work() with runtime PM
      drm/xe: Move xe_device_wedged_fini() registration to
xe_device_probe_early()
      drm/xe: Make xe_device_declare_wedged() IRQ safe
      drm/xe/pci_error: Flush GT wedge worker before bus reset
      drm/xe/amc: Guard xe_amc_work() with runtime PM

Rodrigo Vivi (1):
      drm/xe: Fix build with DRM_XE=3Dy and CONFIGFS_FS=3Dm

Satyanarayana K V P (4):
      drm/xe: Prevent VF memory IRQ from accessing a torn-down engine
      drm/xe/guc: Protect timeout handling from device unplug
      drm/xe/gt: Disable GT reset worker before engine teardown
      drm/xe/pf: Program LMTT directory pointer from each GT's init path

Shigeaki Asai (1):
      drm/meson: encoder_dsi: load ENCL gamma table while ENCL is disabled

Shuicheng Lin (1):
      drm/xe: Mark xe_vma_ops_alloc() noinline for error injection

Svyatoslav Ryhel (1):
      drm/bridge: ssd2825: Fix panel enable sequence

Tejas Upadhyay (3):
      drm/xe: Re-validate external pin under resv lock before VRAM purge
      drm/xe: Drop RCU list handling for VRAM bad-page tracking, use mgr->l=
ock
      drm/xe: Keep VRAM fault injection within the usable range

Thomas Hellstr=C3=B6m (1):
      drm/xe: Don't abort the shrinker walk on -EBUSY

Timur Krist=C3=B3f (1):
      drm/amdgpu/vce1: Fix checking whether VCE1 is idle

Tvrtko Ursulin (1):
      drm/sched: Ensure stopped entity cannot be re-added to the run-queue

Varun Gupta (1):
      drm/xe/guc: Demote uncorrectable local error log on CRI

Vinay Belgaumkar (2):
      drm/xe: Toggle the D3Cold enable flag at runtime resume
      drm/xe: Access GT MMIO after pcode init

Wentao Liang (1):
      drm/vc4: Fix firmware reference leak in vc4_hvs_bind()

YuanZhe Liu (1):
      drm/gud: avoid divide error in gud_stats_debugfs

 MAINTAINERS                                        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  32 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  52 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |  33 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  49 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c   |  22 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  13 ++
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |   3 +
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              |  25 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |  20 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   7 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  44 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |  17 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   7 +-
 .../inc/bounding_boxes/utm_qos_model_dchub_v2.h    |  32 ++--
 .../inc/bounding_boxes/utm_qos_model_dchub_v3.h    |   2 +-
 .../drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h |   2 -
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |   2 +-
 drivers/gpu/drm/bridge/sii902x.c                   |   8 +-
 drivers/gpu/drm/bridge/ssd2825.c                   |   9 ++
 drivers/gpu/drm/display/drm_hdmi_helper.c          |  65 ++++++--
 drivers/gpu/drm/gud/gud_drv.c                      |  13 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |   6 +-
 drivers/gpu/drm/i915/display/intel_display.c       |  11 ++
 drivers/gpu/drm/i915/display/intel_dp_aux.c        |  39 +++--
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   3 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |  13 +-
 drivers/gpu/drm/i915/display/intel_pps.c           |  14 ++
 drivers/gpu/drm/i915/display/intel_psr.c           |  52 +++---
 drivers/gpu/drm/i915/display/intel_tc.c            |   9 +-
 drivers/gpu/drm/meson/meson_encoder_dsi.c          |   2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/falcon.h   |   1 +
 drivers/gpu/drm/nouveau/nouveau_display.c          |  11 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c    |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c    |   1 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  |   4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c    |   1 +
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |   7 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c        |  18 ++-
 drivers/gpu/drm/scheduler/sched_rq.c               |   7 +
 drivers/gpu/drm/vc4/vc4_hvs.c                      |  18 +--
 drivers/gpu/drm/vc4/vc4_irq.c                      |  42 ++---
 drivers/gpu/drm/vc4/vc4_v3d.c                      |   8 +-
 drivers/gpu/drm/xe/Kconfig                         |   1 +
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |   1 +
 drivers/gpu/drm/xe/regs/xe_lrc_layout.h            |   3 +
 drivers/gpu/drm/xe/xe_amc.c                        |  10 +-
 drivers/gpu/drm/xe/xe_configfs.h                   |  30 ----
 drivers/gpu/drm/xe/xe_device.c                     |  60 +++----
 drivers/gpu/drm/xe/xe_device.h                     |   7 +-
 drivers/gpu/drm/xe/xe_device_types.h               |   4 +
 drivers/gpu/drm/xe/xe_drm_ras.c                    |  17 +-
 drivers/gpu/drm/xe/xe_gpu_scheduler_types.h        |   5 +-
 drivers/gpu/drm/xe/xe_gsc.c                        |   3 +-
 drivers/gpu/drm/xe/xe_gt.c                         |  77 ++++++---
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c                |   2 +-
 drivers/gpu/drm/xe/xe_gt_types.h                   |   9 ++
 drivers/gpu/drm/xe/xe_guc.c                        |   1 -
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h       |   5 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 | 137 +++++++++++-----
 drivers/gpu/drm/xe/xe_hw_engine.c                  |  17 +-
 drivers/gpu/drm/xe/xe_hw_error.c                   |   2 +
 drivers/gpu/drm/xe/xe_hwmon.c                      | 180 +++++++++++++++--=
----
 drivers/gpu/drm/xe/xe_irq.c                        |   3 +
 drivers/gpu/drm/xe/xe_late_bind_fw.c               |  15 +-
 drivers/gpu/drm/xe/xe_lmtt.c                       |  58 +++++--
 drivers/gpu/drm/xe/xe_lmtt.h                       |   5 +-
 drivers/gpu/drm/xe/xe_lrc.c                        |   8 +-
 drivers/gpu/drm/xe/xe_memirq.c                     |   3 +
 drivers/gpu/drm/xe/xe_mert.c                       |   6 +-
 drivers/gpu/drm/xe/xe_pat.c                        |  11 +-
 drivers/gpu/drm/xe/xe_pat.h                        |   4 +-
 drivers/gpu/drm/xe/xe_pci.c                        |   5 +
 drivers/gpu/drm/xe/xe_pci_error.c                  |   6 +-
 drivers/gpu/drm/xe/xe_pci_types.h                  |   1 +
 drivers/gpu/drm/xe/xe_pm.c                         |  20 ++-
 drivers/gpu/drm/xe/xe_ras.c                        |   3 +-
 drivers/gpu/drm/xe/xe_shrinker.c                   |   3 +
 drivers/gpu/drm/xe/xe_survivability_mode.c         |   3 +-
 drivers/gpu/drm/xe/xe_svm.c                        |   1 +
 drivers/gpu/drm/xe/xe_sync.c                       |  33 +++-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c               |  53 ++++--
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h         |   2 -
 drivers/gpu/drm/xe/xe_tuning.c                     |   2 +-
 drivers/gpu/drm/xe/xe_uc_fw.c                      |   2 +-
 drivers/gpu/drm/xe/xe_vm.c                         |  11 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c                 |   5 +-
 drivers/gpu/drm/xe/xe_wa.c                         |   5 +-
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |   1 +
 95 files changed, 1100 insertions(+), 496 deletions(-)
