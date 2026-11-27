Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A64606A689
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N6IYrry5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD10A10EAEE;
	Fri, 27 Nov 2026 23:04:54 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F86110E095
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 23:04:49 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-92107df3f13so80686446d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 15:04:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795820688; cv=none;
 d=google.com; s=arc-20260327;
 b=HhMECqJQcq0hTlxOR2souifxNFETGx/DHBaW5cT8lVwufG1kF6OhMhx0O1pT5pD51v
 z6jL8DY/ekDQPJyUE5y72+MnwGIGEfJe4O2lvjEaA6ASbhRzJ8Igwx/iG4yLs0DlhivN
 KldryLoBOwjjNs0WFAABvpi+rrLOVGxSqGIh9NhpdN+xeAdOvRDfLfmtHykRMqwDEiNs
 jkm5rH3IQUTUVn8XI61D9aVYY7PP3NoBN7ImCnZZSUdJIhhZQp8OQscR9EaSiy0DBh9C
 vQtuJUDTCtbuIa2INCjvvrfD5WocmRNtmP4XhV2HzUWU815cUuWDEgv6QnvZ+hyMYja/
 bHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=/b2+qyA9K6Lsgmca7ZCpnNmp2UOo1415xEJn6O9u+Jk=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=UqNP89IZy72hC2Xy4M05wf7OZLHA+0fp8IVoSxl0V5yWrNii90FxC3ZOEz4tfHUbmH
 A5SPM4EAwLzAXemmzcLg+TKIIIEj2d6dqL+u76+RL0deb4RStT8KXy6WvzjjlvJx7Rna
 OT0RFC2QPEXxz23jyJdvdU4Rz+FMP1v31AjUd+E2FLXT7u+h7lbxldHeeIiBWQeHvNjw
 p9ZyNu5x4MEiKBzzpmYTYTYcOYPHPTZhbUADnlfmmR8roOme36QVWaGNH7+OANJMHsnV
 lqs3KsDD3FUvukR6ZJsZeDlZMjFy4rucV2kPG4s7cJYpziTMKc1tQWqmW5tat5Wag9xk
 Yn0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795820688; x=1796425488; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/b2+qyA9K6Lsgmca7ZCpnNmp2UOo1415xEJn6O9u+Jk=;
 b=N6IYrry5ou3mIvfFawKcZA6Vs3zDIb84oUqA7UtmNnytHMPLtP0sienBVBD5RSam/v
 P06KWwuX1XiLHg/0nUkOEc9CJZCV+EB7g/pHN/hf9vsB0+y62j8Rs1RuJYYtF4G/0u9A
 QoQfuF3iEYLqona2zNvC07gsfG3FeevgFzJXZSAC95WYbuvt2cYEfJ5VTqg9Odez0nkK
 cV5uMJ+L3DZvtGpeZFqPMkYC1AJGpctjvgNkQ2fm5zO54rYTez9YGpNV6281muwQw+T3
 Rl0gMjNZHqjaeH8OsfYvxc1O+bE21ex7nNKXTey6cBiTJXhnDNn5VObP4416dtFhAvMv
 Mogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795820688; x=1796425488;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/b2+qyA9K6Lsgmca7ZCpnNmp2UOo1415xEJn6O9u+Jk=;
 b=vG2fkqrwjB1HbFoBJDtXO6QlFIhqNYjeslJCutZe8ZolgI11ZA7FsvSFT8F5oD5FT+
 t/9632sKuFwbT7Tn2/RfGwkdKwafx4ukBygeidJwcQeZLjqxx11DLyCgRqpoC0WylHjb
 wEi3FLHWrqClP7yXQ2p9cb+JpD2QqFsq3tA/EDBxV1L+IgXVeJXCcJbuouDhSPOYxF1k
 9pyFHpC1QxKMyXec9iJE2NkHl6D9CjnUo7oNZQ4zPVkzBc5QG/vSdl9j4yyufPYvH3Cd
 jCH9bAWAQ0zPEO55Yh1rQMePft7qA5mzmXn9BsPWxE3LG8bF3BZib4fl/grvmmvaMHNw
 t1Vg==
X-Gm-Message-State: APuU4Z93F7ecT3dtTz2oUJpAxlI4jhofShDZEIwH8kwPlcIYvX8lToId
 X9MN9cr5NSYfVC/U7kfjJ5P/KUOaCsHpT+d+sjrIEYoQ6piKvTijLu3+e3F8qpA7sIOvw9jg7yt
 MTcW5gmIy/BHUUhL+tTP5t4dMyOEMsWc=
X-Gm-Gg: AZFdTZdt6O3k5ox7It04iXmiBSWPKL8UD8HtfAuHAG6p/83oVghP3xOEl9UEXzRlf+w
 4hax49iqPJ9bPV9cwyuN6GL/r6c97fxBmaMWwke2g27CgYYRnpNOq0ECnA0ZtlTjlC5sI2/6khI
 QyMaA4/vKAGFsRjc5C5opD3FGmsjxy1AKchQdFwIMrTFk5MSHlDPut18zi0I1bONoPjYeJjiCaP
 ZLVIjxrEUl9mwXx4clDwdZ6VUQ//J6Bf1+rJZ7JaQk+juknyspVsxjoByVKZXbg8NeT625gwkcK
 IGeE9N0MuMfsF421lQ+MLe/ctZWZa2oyDe8VZC0llW2FpbPM0YWwjF457nBPvv3w8VUXGvP57Nu
 KUnz0x/GOMBbXo+oH6gNwi9S4VImxQcJaw8KrCLcZ0WzLRPCb/SLiGBIVA8RbfeRTcMnwFCBq0A
 YgU8uocFpLGzH+Uw9FyEmPMQ==
X-Received: by 2002:a05:6214:328d:b0:921:23e5:37ed with SMTP id
 6a1803df08f44-92134bbcdb7mr459774586d6.56.1795820687910; Fri, 27 Nov 2026
 15:04:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 28 Nov 2026 09:04:35 +1000
X-Gm-Features: Aa3M54rvMNa9lv1SfvbEGQ3fm_rDzjyGzUtYBeu2cpXmgJm_hRrZ2uW3k1cIZCI
Message-ID: <CAPM=9tw3Esbfcq+zcZyg80J9_1FaFLKD1S-83DstzL=WfrRbpA@mail.gmail.com>
Subject: [git pull] drm fixes for 7.4-rc5
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

Weekly fixes, amdgpu and msm leading the charge, with a bunch of i915
display fixes and then some misc driver fixes. There is one pci fix in
here that is acked. Don't think anything major stands out.

Dave.

drm-fixes-2026-11-28:
drm fixes for 7.4-rc5

pci:
- Cache firmware secondary bus number

core:
- panic: Restore kmsg screen fix
- ttm: Don't leak LRU list on shutdown

dma-buf:
- dma-fence: Prevent misordering for error checks

xe:
- hwmon: Unregister hwmon before the device is unplugged
- Serialize migrate ULLS enter against a pending exit

i915:
- Fix GitLab #9575: Xiaomi Book Pro 14 2026 screen corruption
- Fix GitLab #9746: Screen corruption when enabling HDR
- Fix GitLab #9247: MSI Claw 8 AI+ screen corruption
- Fix GitLab #16854: Regression ASUS ROG Strix SCAR 18 lost mode 3840x2400@=
240
- Fixes for ALPM

amdgpu:
- GPUVM fixes
- Reset fixes
- MES fix
- Multi-entity fix
- GC 11 APU fix
- GC 12.1 fix
- Error path cleanup fixes
- TB fix
- Fix handling of ACPI tables when PCI bus numbers change
- Display OTG fix
- eDP fix
- Replay fix
- DSC fix
- Fix display handling for RGBA8888
- VPE fix
- Fence accounting fixes

amdkfd:
- CWSR fixes
- SVM fixes
- Error path cleanup fixes
- Fence accounting fix
- Debugger fix
- CRIU fix

radeon:
- Fix handling of ACPI tables when PCI bus numbers change

msm:
- GPU:
  - Fix GMEM_BASE on gen8
  - VM_BIND parameter validation and related fixes
  - Reset preemption records across suspend
  - Fix missing CLX request
  - Fix lock leak
  - Add missing AQE fw for x2-90
  - Fix 1/2b alpha filtering precision on gen8
  - Fix priority inversion caused by commit 38f922a563aa ("drm/sched:
    Reverse run-queue priority enumeration")
  - Fix missing preempt_record_size on glymur/mahua

ast:
- Allow disabling Write-Combine if CONFIG_RT=3Dy

gud:
- Fix potential divide-by-zero bug

imagination:
- Fix the value of ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP

nouveau:
- Fix double VBIOS checks

v3d:
- Fix double-free bug
The following changes since commit b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f=
:

  Linux 7.4-rc4 (2026-11-22 14:57:40 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-11-28

for you to fetch changes up to e1dc9c441d4a92a54833c85b44c1ee474afaf57b:

  Merge tag 'drm-msm-fixes-2026-10-27' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes (2026-11-28
08:30:23 +1000)

----------------------------------------------------------------
drm fixes for 7.4-rc5

pci:
- Cache firmware secondary bus number

core:
- panic: Restore kmsg screen fix
- ttm: Don't leak LRU list on shutdown

dma-buf:
- dma-fence: Prevent misordering for error checks

xe:
- hwmon: Unregister hwmon before the device is unplugged
- Serialize migrate ULLS enter against a pending exit

i915:
- Fix GitLab #9575: Xiaomi Book Pro 14 2026 screen corruption
- Fix GitLab #9746: Screen corruption when enabling HDR
- Fix GitLab #9247: MSI Claw 8 AI+ screen corruption
- Fix GitLab #16854: Regression ASUS ROG Strix SCAR 18 lost mode 3840x2400@=
240
- Fixes for ALPM

amdgpu:
- GPUVM fixes
- Reset fixes
- MES fix
- Multi-entity fix
- GC 11 APU fix
- GC 12.1 fix
- Error path cleanup fixes
- TB fix
- Fix handling of ACPI tables when PCI bus numbers change
- Display OTG fix
- eDP fix
- Replay fix
- DSC fix
- Fix display handling for RGBA8888
- VPE fix
- Fence accounting fixes

amdkfd:
- CWSR fixes
- SVM fixes
- Error path cleanup fixes
- Fence accounting fix
- Debugger fix
- CRIU fix

radeon:
- Fix handling of ACPI tables when PCI bus numbers change

msm:
- GPU:
  - Fix GMEM_BASE on gen8
  - VM_BIND parameter validation and related fixes
  - Reset preemption records across suspend
  - Fix missing CLX request
  - Fix lock leak
  - Add missing AQE fw for x2-90
  - Fix 1/2b alpha filtering precision on gen8
  - Fix priority inversion caused by commit 38f922a563aa ("drm/sched:
    Reverse run-queue priority enumeration")
  - Fix missing preempt_record_size on glymur/mahua

ast:
- Allow disabling Write-Combine if CONFIG_RT=3Dy

gud:
- Fix potential divide-by-zero bug

imagination:
- Fix the value of ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP

nouveau:
- Fix double VBIOS checks

v3d:
- Fix double-free bug

----------------------------------------------------------------
Akhil P Oommen (4):
      drm/msm/a6xx: Check BX dependency vote index
      drm/msm/a6xx: Reset preemption records across suspend
      drm/msm/a6xx: Request CLX enable from secure world
      drm/msm/a8xx: Add AQE firmware to Adreno X2-90 GPU

Alex Deucher (2):
      drm/amdkfd: move TBA/TMA back to system memory
      drm/amdgpu: add helper for determining removable devices (USB4, TB)

Ankit Nautiyal (3):
      drm/i915/dsc: Fix QP table index calculation for bpp selection
      drm/i915/dsc: Fix the helper range_bpg_offset()
      drm/i915/bios: Add quirk to allow eDP joiner on ASUS ROG Strix SCAR 1=
8

Aveline Noir (1):
      drm/amdkfd: preserve the byte address when removing retry faults

Bart Van Assche (1):
      drm/msm: Fix a lock leak in msm_ioctl_gem_info_set_metadata()

Benjamin Cheng (3):
      drm/amdkfd: reserve TTM move fences
      drm/amdgpu/gem: reserve fences on the VM root PD
      drm/amdgpu/vm: reserve TTM_NUM_MOVE_FENCES in amdgpu_vm_lock_pd

Caden Chien (1):
      drm/amdgpu/vpe: align with reg read permission

Chaitanya Kumar Borah (1):
      drm/i915/dip: Write the DIP header last

Christoph Berliner (1):
      drm/amdgpu/gfx9: deactivate all compute HQDs before MODE2 on APUs

Connor Abbott (1):
      drm/msm: Fix GMEM_BASE on a8xx

Dave Airlie (6):
      drm/nouveau/devinit/gf100-: fix double vbios init checks
      Merge tag 'drm-xe-fixes-2026-11-25' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2026-11-26' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.4-2026-11-26' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-11-27' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-msm-fixes-2026-10-27' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes

David Francis (1):
      drm/amdkfd: Correctly handle multi-xcc mqd size in CRIU restore

Devin Wittmayer (1):
      drm/panic: Bring back the kmsg screen fixes lost in a merge

Fei Yang (1):
      drm/xe: Serialize migrate ULLS enter against a pending exit

Felix Kuehling (1):
      drm/amdkfd: Fix context ID cleanup after failures

Harry VanZyllDeJong (1):
      drm/amd/display: Honor the Replay stream regeneration wait event

Harry Wentland (2):
      drm/amd/display: Add RGBA8888 surface pixel format support
      drm/amd/display: Fix DCE crossbar for RGBA8888 surface format

Hongyan Xu (1):
      drm/amdkfd: fix use-after-free in create_process() error path

Ian Forbes (1):
      ttm/pool: Don't leak LRU list on shutdown

Ian Rogers (2):
      drm/amdgpu: initialize r in amdgpu_vm_bo_update()
      drm/amdgpu: initialize r in amdgpu_ttm_clear_buffer()

Jesse Zhang (1):
      drm/amdkfd: return the memory violation data to the debugger

Jie Zhang (4):
      drm/msm/a6xx: Fix GMU shutdown idle check
      drm/msm/a6xx: Fix stale boot up BW vote
      drm/msm/devfreq: Record idle_time at GPU idle onset
      drm/msm: Fix sched_prio inversion within a ring

Jouni H=C3=B6gander (2):
      drm/i915/psr: Adjust Xiaomi Book Pro 14 2026 psr2 disable quirk
      drm/i915/alpm: Track the configured transcoder lifetime

Kent Russell (1):
      drm/amdgpu: Disable XNACK retry on GFX12.1

Mario Limonciello (3):
      PCI: Cache bridge firmware secondary bus number
      drm/amdgpu: Match VFCT using initial PCI bus number
      drm/radeon: Match VFCT using initial PCI bus number

Michael Strauss (1):
      drm/amd/display: Clear OTG_AUTO_FORCE_VSYNC_MODE on OTG disable

Micha=C5=82 Grzelak (1):
      drm/ttm/tests: do not count pages after pool's teardown

Nicholas Kazlauskas (1):
      drm/amd/display: Skip DSC padding borrow estimate for zero padding

Perry Yuan (2):
      drm/amdkfd: test copy_from_user() directly in kfd_criu_restore_svm()
      drm/amdkfd: fix units when unmapping a PROT_NONE VMA from GPUs

Philipp Stanner (1):
      dma-buf/dma-fence: Prevent misordering for error checks

Pierre-Eric Pelloux-Prayer (2):
      drm/amdgpu: use a single clear entity on some chips
      drm/amdgpu: fix NULL deref in error path

Prike Liang (1):
      drm/amdgpu/mes: keep the RS64 context slot bitmaps across MES re-init

Priya Hosur (1):
      drm/amd/pm: restore the forced performance level after a reset

Rob Clark (7):
      drm/msm/adreno: Soften no-firmware message
      drm/msm/gem: Fix VM_BIND range check
      drm/msm/gem: Disallow nr_bos for VM_BIND contexts
      drm/msm/gem: Decrement loop idx if handle lookup fails
      drm/msm/gem: Clear nr_ops in lookup_ops() failure path
      drm/msm/a8xx: Fix 1/2b alpha filtering precision
      drm/msm/a8xx: Add missing preempt_record_size

Rodrigo Vivi (1):
      drm/xe/hwmon: Unregister hwmon before the device is unplugged

Ruben Wauters (1):
      drm/gud: fix potential divide error due to optimisation

Ruijing Dong (1):
      drm/amdgpu: keep the commit padding when re-emitting submissions

Ryan Brue (1):
      drm/imagination: Fix the value of ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVER=
LAP

Suresh Guttula (1):
      drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD

Thadeu Lima de Souza Cascardo (1):
      drm/amdgpu: clear the entire mapping when partially unmapping

Thomas Zimmermann (1):
      drm/ast: Add an option to disable Write-Combine

Xiaogang Chen (2):
      drm/amdkfd: Fix a race issue at svm_migrate_copy_to_ram() error path
      drm/amdkfd: Swap order of svm_range_dma_unmap_dev and migrate_vma_fin=
alize

Xiaolei Wang (1):
      drm/v3d: Fix double free of query arrays on parse failure

Zhikai Zhai (1):
      drm/amd/display: Power up eDP when detect link

chong li (1):
      drm/amdgpu: post the ASIC after the reset done at init time

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |  42 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  31 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  25 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  19 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |  17 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 100 ++++++++++-----
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |  14 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c              |   3 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c              |   3 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c              |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c             |   4 +-
 .../amd/amdkfd/kfd_device_queue_manager_v12_1.c    |  18 +--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |  21 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  58 ++++++++-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  16 +--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h               |   4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   3 +
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c  |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   4 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |  42 ++++--
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h |   6 +
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c |   1 +
 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c   |   1 +
 .../gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |   3 +
 .../gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c   |   3 +
 .../gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c |   3 +
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |   3 +
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c |   3 +
 .../gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c   |   3 +
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c   |   3 +
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c   |   3 +
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c |   1 +
 .../drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c |   1 +
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |   1 +
 .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c |   4 +
 .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |   4 +
 .../gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c |   4 +
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |   4 +
 .../gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c |   4 +
 .../gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c    |   1 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   1 +
 .../gpu/drm/amd/display/dc/link/link_detection.c   |  15 ++-
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |   4 +
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c |   4 +
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.c   |   4 +
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |   4 +
 .../drm/amd/display/modules/power/power_replay.c   |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |  21 ++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  39 +-----
 drivers/gpu/drm/ast/Kconfig                        |   9 ++
 drivers/gpu/drm/ast/ast_mm.c                       |  13 ++
 drivers/gpu/drm/drm_panic_helper.c                 |  10 +-
 drivers/gpu/drm/gud/gud_drv.c                      |   2 +-
 drivers/gpu/drm/i915/display/intel_alpm.c          |  11 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |   5 +
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  17 ++-
 drivers/gpu/drm/i915/display/intel_quirks.c        |  14 ++
 drivers/gpu/drm/i915/display/intel_quirks.h        |   1 +
 drivers/gpu/drm/i915/display/intel_vdsc.c          |  10 +-
 .../gpu/drm/imagination/pvr_rogue_fwif_client.h    |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  31 ++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   2 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c          |  37 +++---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c          |  15 ++-
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c          |  11 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  12 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   3 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |   5 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |  11 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |  24 ++--
 drivers/gpu/drm/msm/msm_gpu_devfreq.c              |   3 +-
 drivers/gpu/drm/msm/msm_submitqueue.c              |   2 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml  |   1 +
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c    |   4 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |  40 ++----
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c          |   2 -
 drivers/gpu/drm/ttm/ttm_pool.c                     |   1 +
 drivers/gpu/drm/v3d/v3d_drv.h                      |   6 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |  40 +++---
 drivers/gpu/drm/v3d/v3d_submit.c                   | 142 +++++++----------=
----
 drivers/gpu/drm/xe/xe_device.c                     |   9 +-
 drivers/gpu/drm/xe/xe_hwmon.c                      |  22 +++-
 drivers/gpu/drm/xe/xe_hwmon.h                      |   2 +
 drivers/gpu/drm/xe/xe_migrate.c                    |  15 +++
 drivers/pci/probe.c                                |   1 +
 include/linux/dma-fence.h                          |  15 ++-
 include/linux/pci.h                                |   2 +
 104 files changed, 772 insertions(+), 427 deletions(-)
