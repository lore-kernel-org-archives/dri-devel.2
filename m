Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE4606A336
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zkFWNNut
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7547310E09A;
	Fri, 20 Nov 2026 22:36:12 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0A810E09A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 22:36:06 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-9497a167a6aso300522085a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:36:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795214165; cv=none;
 d=google.com; s=arc-20260327;
 b=aoQsYPwFDbCyZOW/stUtoT99NCkoMhuO9RDR2FAqE7wGiifZ7MnQxTy7j9JpXeGWfm
 pl9+sbYQK4w+Pr5DK4oN+dnjw/evbCYKXORV4u8q4Ttew6eLedrr7MxN6wLsoFvCIAgb
 WcOMu1T2AdacRDo+IF0NxSmJSVuXpcn3BNBh4xzeW7PEpUYKZiOLkzcD/NmyR2jMCo23
 lYQ7K84gxejd+pUn6jUsqB2LxlV6FKU71W5Qz0Q44Wg/jXmHBg2MehXOAO4j/fbZpvuM
 j2kJbAnoEmumtKDdslV8RE6e36adeFHDBdt6WBy3s+Wi6+8PEeJ9eJLwTtfL+lvmmEhO
 TVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=om2eQkM/JRjtjJ/j1uD7TO0ShCQcGRiebdmjkxmghqg=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=YIKB1xETeoP9qaR1Z/CN2rqiNQY1QtWWNmBZ/vLPPFrnJKXzDa0qFjQuEPL1CaNRg2
 9mhcL83ygx/QBcWsShJPeBoVVLoe7VB7vSXUYoW4MJKQKq4hQNTbft/g7ns5auGaodal
 r9ttS995L5QiEV8/dN/v647MfK0pWy1CEIDfQGgp6eMX6FAxl/coAPnBkIIgj2I2kJiI
 1GF6YjiUe+FHd2iHh+AuhLW4L6WvSAFjDLNEVzKT9uHtqXo9r6ItHEjXyTgc5lbpzzUl
 pcXHlYG9aRkaM713MQ0HUwP1H/QUbooBHg9XgMXKhqf3Up3xOYo1M3QGh1O3SgT1RPTP
 qHkg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795214165; x=1795818965; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=om2eQkM/JRjtjJ/j1uD7TO0ShCQcGRiebdmjkxmghqg=;
 b=zkFWNNutdoemrMPPtHyap7XnYIXHyXZjzSdVZiUs9AGjIUIyBI5ruYLKgczUPlXPqM
 8G4lcPIvW5hSRKDTiss8Zb2DXYcrp5vaLEt9OGuttWuvGKWPmb2PA00lbLRrEpr7KhQu
 COe2ccEkdnf2Z7vRHKPqOAvTHvZyocJ7ZZEimEA5zhcu18ZUP4+uFOUP3hB6D/oTyQK9
 BbV7kjwKnMcPAiLVf5rN9Z5byW+qAmBI0m7EebtV0Vlp/FO/uSpl31EVATm1mTqi2lMW
 ifjM3SLU9eLE1IUpN/aoIxlNI0Jg1dpc2MQy9ANeAWN2olLZhLi37mtviuDhDIzt5nO3
 Vy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795214165; x=1795818965;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=om2eQkM/JRjtjJ/j1uD7TO0ShCQcGRiebdmjkxmghqg=;
 b=r2mIejFTG3tOa/oK5AGQbU8Jj06vAi3wyGnCUoc8Kz0miwooL388vUB23rYrKE+yoh
 BHFhY+71eqbaJDcVeJzyLTBbRvUNtLSLfDeJk/3RLoEP6jn6vnkvujcBsnc+Ji5m9Ly7
 po0jpNaLIzIM3IoSZ9ufs1Ig2Mcb/R7xp3lP65e0KMrK/mb6amz9ihBBcbgD+O26ASAm
 dyvOgcwGcD9LOI2uMdr72w9W+gRNQKh+/cPZLar4vWVr5t75lu3WQMfLGmVkic9pusXr
 ktG2AOqRJbNprqNEhy17mms7m/Uviq3hnwSn2CBcrGqost1KBDUhYcrzdnJLKDNHw2Ju
 U1xQ==
X-Gm-Message-State: APuU4Z+AXN40+141Wxe7Sk7XDgRobdHBxz/+8qN2xIBn3G5L0kuZRNoR
 hcjb9rbbqVW+Fjyjp08Lcyfn4xrITKp5YEIM8Q+gnp+viAb880bIXhp9qQDNw5jCZWJsT48ogjB
 QqCPxrIv9x/Z9Zoe22YZikaxu2mJxOWE=
X-Gm-Gg: AYBFou1oBKsMa4cN9dIJ6W7AtR2BBe2Qii4IdmT+75XA+NIpooOR93rUk2UgjsjpZIh
 ZwSnn4lFTFRZKv9U7eo4EOx1st9rIIgGzaJ/UigPigLvDXCEFItJ2IlOJ1uttMUa2dKfMdWAZPo
 M5r8XMgZfxybK8FNMifpRX6vM8B06fo+BPF3qGVCs5Xub//QRU8/Oh4GC+pIJmAwzU/ghwOXSBD
 tjNfhN3kluzY91omDCq3GsRHIJ79sWK4jKiG65C33vkW1eFZA3IZtqqWzULJSpv24Q04+E4WkgF
 KNKOruIlGh0g5jUCVYgEQrnlzXz1uyqm4uFfimnepxG2G0bmiv97x44mTIZErLNv8gX24ArjHxo
 QVeorjvxshgxi6TNoWvtGn89uuRdDIdXTwwH8XISribFdANHpZWtkiKfiQq/ln8EJC/4u6ItOvL
 kK410xXkVzMcPvm9u8LuitQOo=
X-Received: by 2002:a05:620a:8386:b0:945:d7a2:4b57 with SMTP id
 af79cd13be357-949ba9b1549mr684426985a.21.1795214164871; Fri, 20 Nov 2026
 14:36:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 21 Nov 2026 08:35:51 +1000
X-Gm-Features: AclHuK_sY9Ust1B_-xfjRr0-pjxL3gzyLtuKgIBQyecq9ey6-ym79-dXyjl-slA
Message-ID: <CAPM=9ty1FBin9jGz8CoumpTTBOe-LB_Qs5RNn_uMJMbMGTYmyQ@mail.gmail.com>
Subject: [git pull] drm fixes for 7.4-rc4
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

Weekly fixes, around the usual size, though it looks like vmwgfx got
hit with a lot of analysis and has a bunch of validation fixes.
nouveau fixes for a 7.3 regression. I know of one open i915 7.3
regressions that hopefully a fix will land next week. Otherwise amdgpu
and xe have the most with a scattering for others.

Dave.

drm-fixes-2026-11-21:
drm fixes for 7.4-rc4

core:
- syncobj: Limit allocations
- vblank: Resolve deadlock in timer

amdgpu:
- GPUVM fixes
- SMU 8 fix
- PCO quirk
- ATPX lifetime fix
- Unwinding fix for module loading failure
- UserQ fix
- HDMI fixes
- DML2 fix
- DC DRAM config fixes
- DCN 4.2 fixes
- DC pre-OS clock handling fixes
- DPMS fix
- Cleaner shader fixes for multi-XCC parts
- Vblank fix for GPU resets
- Properly handle firmware with different trust athorities
- Freesync/VRR fixes
- Backlight fix
- Display warning fixes
- PSR fixes

amdkfd:
- SVM fixes

radeon:
- Bounds checks in vbios parsing
- ATPX lifetime fix

xe:
- hwmon error handling fixes
- Treat CT-disabled TLB invalidation as cancelled
- Validate BOs on export to charge the exporter
- Always free requested IRQs on uninstall
- Reset TLB invalidation state in submit fini
- Use ordered clock reads for engine cycles cpu_delta
- Treat non-fatal PCIe errors as recovered

i915:
- Regression fix for GitLab #16595 and #17423: 4K displays
corrupt/black on CML/KBL
- DSB programming fix for GOSUB

imagination:
- Use correct function for polling non-iomem

ivpu:
- Fix race condition in recovery

nouveau:
- Fix instmem io_mapping faults and slowdowns

omap:
- dss: Fix handling deferrals

qaic:
- Harden ioctl checks

rocket:
- iommu fixes
- lifetime and validation fixes
- clock request fix
- devicetre core count fix

tilcdc:
- Fix drvdata in suspend/resume

vc4:
- async flip fixes
- off by one shader record
- object lifetime fixes
- two dsi fixes

vmwgfx:
- bounds checking fixes
- validation fixes
The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3=
:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-11-21

for you to fetch changes up to ce29b8f9fb606f87014c2d05483a3fef05a11f38:

  Merge tag 'drm-misc-fixes-2026-11-20' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2026-11-21 07:38:38 +1000)

----------------------------------------------------------------
drm fixes for 7.4-rc4

core:
- syncobj: Limit allocations
- vblank: Resolve deadlock in timer

amdgpu:
- GPUVM fixes
- SMU 8 fix
- PCO quirk
- ATPX lifetime fix
- Unwinding fix for module loading failure
- UserQ fix
- HDMI fixes
- DML2 fix
- DC DRAM config fixes
- DCN 4.2 fixes
- DC pre-OS clock handling fixes
- DPMS fix
- Cleaner shader fixes for multi-XCC parts
- Vblank fix for GPU resets
- Properly handle firmware with different trust athorities
- Freesync/VRR fixes
- Backlight fix
- Display warning fixes
- PSR fixes

amdkfd:
- SVM fixes

radeon:
- Bounds checks in vbios parsing
- ATPX lifetime fix

xe:
- hwmon error handling fixes
- Treat CT-disabled TLB invalidation as cancelled
- Validate BOs on export to charge the exporter
- Always free requested IRQs on uninstall
- Reset TLB invalidation state in submit fini
- Use ordered clock reads for engine cycles cpu_delta
- Treat non-fatal PCIe errors as recovered

i915:
- Regression fix for GitLab #16595 and #17423: 4K displays
corrupt/black on CML/KBL
- DSB programming fix for GOSUB

imagination:
- Use correct function for polling non-iomem

ivpu:
- Fix race condition in recovery

nouveau:
- Fix instmem io_mapping faults and slowdowns

omap:
- dss: Fix handling deferrals

qaic:
- Harden ioctl checks

rocket:
- iommu fixes
- lifetime and validation fixes
- clock request fix
- devicetre core count fix

tilcdc:
- Fix drvdata in suspend/resume

vc4:
- async flip fixes
- off by one shader record
- object lifetime fixes
- two dsi fixes

vmwgfx:
- bounds checking fixes
- validation fixes

----------------------------------------------------------------
Abdulla Bubshait (1):
      drm/amd/display: Abort DPMS ON when enabling the link fails

Adrian Betschart (1):
      drm/amd/display: Apply the HDMI RGB range default only to HDMI signal=
s

Aldo Ariel Panzardo (3):
      drm/vmwgfx: return an error when a shared GB surface has no backup bu=
ffer
      drm/vmwgfx: close TOCTOU on guest_memory_bo in surface reference ioct=
l
      drm/vmwgfx: do not hand the embedded sg_table to the PRIME core

Allen Pan (1):
      drm/amd/display: Update DCN42B stutter latency to match DCN42

Andreas Kemnade (1):
      drm/omap: dss: fix handling deferrals

Andrey Misiurov (1):
      drm/radeon: Bound GPIO I2C table entry count from VBIOS

Arvind Yadav (1):
      drm/xe/irq: Always free requested IRQs on uninstall

Austin Zheng (1):
      drm/amd/display: Flip
dml2_core_utils_get_segment_horizontal_contiguous() Inputs

Benjamin Cheng (2):
      drm/amdgpu: wait for tlb flush before freeing BO
      drm/amdgpu/gem: use dma_resv_add_fence directly

Chaoyi Chen (1):
      accel/rocket: Fix the extra iommu_group_get call in rocket_job_handle=
_irq

Christian K=C3=B6nig (1):
      drm/amdgpu: fix cleared PDE/PTE flag generation

Cooper Morgan (2):
      drm/amd/display: Saturate refresh rates in v1/v2 FreeSync infopackets
      drm/amd/display: Use FreeSync v3 infopacket for sinks above 255 Hz

Dan Carpenter (1):
      drm/vmwgfx: Fix NULL vs error pointer bug in vmw_prime_import_sg_tabl=
e()

Dave Airlie (4):
      Merge tag 'drm-intel-fixes-2026-11-19' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.4-2026-11-19' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-11-19-1' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-11-20' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Davey Hughes (1):
      drm/amd/display: Keep FreeSync flip timing across plane resets

Dnyaneshwar Bhadane (2):
      drm/xe/log: Add VRAM, PAT, and HWMON DRIVER_HARDWARE components
      drm/xe/hwmon: Report errors using structured xe_log API

Egor Perevoshchikov (1):
      drm/amd/display: Restore PSR-SU guard in power module

Erhan Bilgili (1):
      drm/amdgpu: Fix UserQ slot availability checks

Fangzhi Zuo (2):
      drm/amd/display: Move HDMI FRL Polling Outside dc_lock
      drm/amd/display: Stop HDMI FRL status polling on fini

Fei Yu (1):
      drm/syncobj: Limit the number of handles and use kvmalloc for
user-sized arrays

Guangshuo Li (1):
      accel/rocket: put IOMMU domain on BO creation failure

Gyeyoung Baek (1):
      accel/rocket: Fix drm_mm UAF on close vs in-flight job

Hanson Wang (1):
      drm/i915/dsb: Realign GOSUB only for QW slots 6 and 7

Haoming Gao (1):
      accel/rocket: publish read fences for input buffers

Heiko Stuebner (1):
      MAINTAINERS: Add two reviewers to the Rockchip DRM entry

Henry Zhang (2):
      drm/vc4: dsi: Register the PHY clock provider with devm
      drm/vc4: dsi: Set the transfer result before completing the transfer

Hugo Sales (3):
      drm/amd/display: Take every stream out of self-refresh before a modes=
et
      drm/amd/display: Add the AUX backlight minimum once on the custom cur=
ve
      drm/amd/display: Hold the VRR vblank reference only on active CRTCs

Ian Forbes (2):
      drm/vmwgfx: Never destroy STDU zero's Screen Target
      drm/vmwgfx: Check whether CRTC is active when updating planes

Igor Paunovic (3):
      accel/rocket: release the shared device's devres on teardown
      accel/rocket: number the cores by devicetree position, not bind order
      accel/rocket: request the core clocks by name

Jackie Liu (1):
      drm/amd/display: Fix logger leak on perf trace allocation failure

Jaeyeong Lee (1):
      drm/vmwgfx: Erase the detached resource entry on resource release

Jesse Zhang (2):
      drm/amdkfd: don't check the HMM range when getting its pages failed
      drm/amdkfd: keep the DMA addresses of a range intact if splitting fai=
ls

Jiaming Fan (3):
      drm/radeon: only unregister the ATPX handler if we registered it
      drm/amdgpu: only unregister the ATPX handler if we registered it
      drm/amdgpu: unwind module init on failure

Jiaxing Hu (3):
      accel/rocket: take the completion register writes under job_lock
      accel/rocket: wait for a running IRQ handler before resetting a core
      accel/rocket: let the core suspend after a reset

Jing Zhou (1):
      drm/amd/display: Seed boot clocks to avoid lowering pre-OS display cl=
ocks

Joshua Horne (1):
      drm/amd/pm: send smu8 sclk level indices, not the level mask

Karol Wachowski (1):
      accel/ivpu: Defer recovery until probe completes

Karthik Poosa (1):
      drm/xe/hwmon: Propagate all hardware read errors

Kent Russell (3):
      drm/amdgpu: Run shader cleaner on all XCCs on faults
      drm/amdgpu: Fix fault shader cleaner on MI3
      drm/amdgpu: Fix fault cleaner race condition

Luigi Santivetti (1):
      drm/imagination: use appropriate poll function for non-iomem

Mario Limonciello (1):
      drm/amd: Select the firmware signing scheme the PSP reports

Markus Schneider-Pargmann (TI) (1):
      drm/tilcdc: Fix suspend/resume drvdata

Maxime Ripard (7):
      MAINTAINERS: Move armada DRM under drm-misc
      MAINTAINERS: Move Keem Bay DRM under drm-misc
      MAINTAINERS: Move Tegra DRM under drm-misc
      MAINTAINERS: Remove Jonas Karlman from bridge reviewers
      MAINTAINERS: Remove Andrzej Hajda from bridge maintainers
      MAINTAINERS: Remove myself for VC4 DRM driver
      MAINTAINERS: Add Dmitry Baryshkov as bridge maintainer

Ma=C3=ADra Canal (7):
      drm/vc4: Drop BO usecnt before releasing the old FB
      drm/vc4: Complete async page flips from an ordered workqueue
      drm/vc4: Look up the async page flip fence before committing the flip
      drm/vc4: Fix off-by-one in the shader record BO handle check
      drm/vc4: Check for a validated shader before reading its thread mode
      drm/vc4: Start shader code at varying offsets in its BO
      drm/vc4: Clear the slice caches before resetting a stalled GPU

Mohamed Ahmed (3):
      drm/nouveau: do not return early from a synchronous VM_BIND
      drm/nouveau/bar: take the GSP-RM flush pointer from the BAR2 io_mappi=
ng
      drm/nouveau/instmem: map only the part of BAR2 that is used

Ovidiu Bunea (1):
      drm/amd/display: Add support for more PSP footer sizes

Paul Menzel (1):
      drm/amd/display: Don't warn about vendor infoframe for non-infoframe =
sinks

Piotr Pi=C3=B3rkowski (1):
      drm/xe/guc: Reset TLB invalidation state in submit fini

Prike Liang (1):
      drm/amdgpu: keep reading the vblank counter in IRQ context during res=
et

Qiang Han (1):
      drm/amdkfd: wait for the queue quiesce in concurrent SVM evictions

Riana Tauro (1):
      drm/xe/ras: Treat non-fatal PCIe errors as recovered

Ruben Wauters (1):
      MAINTAINERS: Update Ruben Wauters email address

Sanjay Yadav (1):
      drm/xe/query: Use ordered clock reads for engine cycles cpu_delta

Suresh Guttula (1):
      drm/amdgpu: bypass IMU ucode loading for GC 11 APU

Thomas Hellstr=C3=B6m (1):
      drm/xe/dma-buf: Validate BOs on export to charge the exporter

Thomas Lamprecht (1):
      drm/amd/display: Don't warn about links without an HPD GPIO

Thomas Zimmermann (2):
      drm/vblank: timer: Do not block within critical section
      drm/vblank: Cancel vblank timer outside of critical section

Tomas M (1):
      drm/vmwgfx: include legacy hotspots in GB-only cursor images

Tomeu Vizoso (1):
      accel/rocket: Fix up sched array handling on open and close

Triet Hoang (2):
      accel/rocket: Check allocations before use
      accel/rocket: Keep scheduler allocation in rocket_file_priv

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915/cdclk: Ignore SWF18 in SKL CDCLK sanitization

Vladimir Popov (1):
      drm/vmwgfx: fix NULL pointer dereference in vmw_validation_bo_fence()

Wang Jiang (1):
      drm/amdgpu/gfx_v9_0: Add gfxoff quirk for Lenovo Picasso 318F

Wenjing Liu (1):
      drm/amd/display: Read DRAM channel width from SMU init table

Youssef Samir (1):
      accel/qaic: Harden checks in BO execute and wait IOCTLs

Zack Rusin (11):
      drm/vmwgfx: validate command body sizes before parsing
      drm/vmwgfx: validate backup buffer size in command buffer processing
      drm/vmwgfx: avoid underflow when stripping short GuestInfo replies
      drm/vmwgfx: bound MKSSTAT lengths before rounding to pages
      drm/vmwgfx: keep cursor mappings and pins with each plane state
      drm/vmwgfx: validate GB-only cursor command limits
      drm/vmwgfx: reserve dumb buffers while detaching their surfaces
      drm/vmwgfx: validate the framebuffer selected for cursor updates
      drm/vmwgfx: reserve cursor MOBs before unpinning them
      drm/vmwgfx: log missing primary planes only once
      drm/vmwgfx: log MOB limits outside the manager spinlock

Zongyao Bai (1):
      drm/xe/guc: Treat CT-disabled TLB invalidation as cancelled

 .mailmap                                           |   1 +
 MAINTAINERS                                        |  14 +-
 drivers/accel/ivpu/ivpu_pm.c                       |   9 +-
 drivers/accel/qaic/qaic_data.c                     |  16 ++
 drivers/accel/rocket/rocket_core.c                 |   4 +
 drivers/accel/rocket/rocket_core.h                 |  14 +-
 drivers/accel/rocket/rocket_drv.c                  | 104 ++++++----
 drivers/accel/rocket/rocket_drv.h                  |  14 +-
 drivers/accel/rocket/rocket_gem.c                  |  33 ++--
 drivers/accel/rocket/rocket_gem.h                  |   4 +-
 drivers/accel/rocket/rocket_job.c                  |  63 ++++--
 drivers/accel/rocket/rocket_job.h                  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  29 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  20 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |  35 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |  64 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  16 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c            | 104 ++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |  16 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h            |   3 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |  17 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   8 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c             |  47 +++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.h             |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c              |   2 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   7 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  67 +++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 154 ++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  19 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |   2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |   2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  19 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |  14 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |  90 ++++++---
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      | 214 +++++++++++++++++=
++++
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |   3 +
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c |   4 +
 .../gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h  |   3 +-
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  18 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |   5 +-
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.c  |   5 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h       |   4 +-
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.c     |   8 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |   2 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |  41 ++--
 .../drm/amd/display/modules/freesync/freesync.c    |  12 +-
 .../gpu/drm/amd/display/modules/power/power_psr.c  |   9 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |  14 +-
 drivers/gpu/drm/drm_syncobj.c                      |  42 ++--
 drivers/gpu/drm/drm_vblank.c                       |  92 +++++----
 drivers/gpu/drm/drm_vblank_helper.c                |  16 ++
 drivers/gpu/drm/i915/display/intel_cdclk.c         |  13 +-
 drivers/gpu/drm/i915/display/intel_dsb.c           |  16 +-
 drivers/gpu/drm/imagination/pvr_power.c            |   3 +-
 drivers/gpu/drm/nouveau/nouveau_sched.c            |   6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c    |   6 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/priv.h     |   1 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c  |  32 ++-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |  19 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h |   3 +
 drivers/gpu/drm/omapdrm/dss/output.c               |   3 +
 drivers/gpu/drm/radeon/radeon_atombios.c           |  22 ++-
 drivers/gpu/drm/radeon/radeon_atpx_handler.c       |  13 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |   6 +-
 drivers/gpu/drm/vc4/vc4_bo.c                       |  43 ++++-
 drivers/gpu/drm/vc4/vc4_crtc.c                     | 136 ++++++-------
 drivers/gpu/drm/vc4/vc4_drv.h                      |  21 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |   7 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |  20 +-
 drivers/gpu/drm/vc4/vc4_validate.c                 |  15 +-
 drivers/gpu/drm/vc4/vc4_validate_shaders.c         |   7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |   3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c       | 166 +++++++++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h       |   4 +
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            | 208 +++++++++++++++++=
+++
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                |  17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c      |  55 ++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |   3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |  21 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  19 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c       |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |  28 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h         |  13 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c               |   2 +-
 drivers/gpu/drm/xe/abi/xe_log_abi.h                |   3 +
 drivers/gpu/drm/xe/xe_dma_buf.c                    |  82 ++++----
 drivers/gpu/drm/xe/xe_guc_submit.c                 |   2 +
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c              |  14 +-
 drivers/gpu/drm/xe/xe_hwmon.c                      |  62 +++---
 drivers/gpu/drm/xe/xe_irq.c                        |   6 +-
 drivers/gpu/drm/xe/xe_query.c                      |   6 +-
 drivers/gpu/drm/xe/xe_ras.c                        |   2 +-
 include/drm/drm_crtc.h                             |   9 +
 include/drm/drm_vblank.h                           |  16 ++
 include/drm/drm_vblank_helper.h                    |   2 +
 114 files changed, 2092 insertions(+), 649 deletions(-)
