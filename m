Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EF1C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 21:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0500F10E374;
	Fri,  3 Jul 2026 21:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VDElAqGt";
	dkim-atps=neutral
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E598D10E36D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 21:52:47 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-666275a685eso1285523d50.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 14:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783115567; cv=none;
 d=google.com; s=arc-20260327;
 b=M81S0IstbpFus+2cg4khJQpYhxO/5D/x2PvvgRNLIstia1Ertqa1ePFO3odPpQMnpS
 hiQzRTDnf7GegPOklWoOJunhZLgmlFiS2ifMdLeIu/Vq80SG8u099P8yosw8H3qlr5ce
 tjvn8XAJN1XTc0C3vcnRp95TUX29ASkbzBsvyJ23EiEmDd8W5FXdZkfvs5JiVNEdGh69
 NnKHyNMSp937vEIZD0B5Ds7kW172YVSPXjlyqF2JykRGHsM1zzdxxtKk0DYR7ORuYnzR
 4WjLVfa6TD6nWRnkPymeUNtoUfxznjFde5xv40qcuzhuMRKwUozQ/ClInoFdf7d1mMDV
 ydEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=Iuz6f9T/1WOWfq9X6LmBhv2xTqnGqCxVIrZ9LV09A2A=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=P0e6CMK7MUtThk1PjAcU4vYXsTRw2rVb4YTwYM0TaTfgIy8BEHlcAeX0fBuVf1JXua
 PbzHZkDOECEhNfOuKQ/EzC8OLz32YGMAc/ie1wWf5EocvVKN/LWzrmm3juabqGGG8Ncz
 ebQ89ZQOOi2D4Xsj0w3l8EicIoadKoqJSoV+oeOsu6rw+xYux5voDU2HtAmNDlIDD3eX
 kArYmRYZ4j9GlYv/DZSVdQVospIZzUVsoT1c+d8109Zt+m0STNlKEy2uSpM/D1wJi01n
 ZzOnRrLdHOHES1aVB3puGcLRtACUpwevJCf7KX1EY33aMCIylMfI7yzUrl/ZaeTqGfBH
 sJSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783115567; x=1783720367; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Iuz6f9T/1WOWfq9X6LmBhv2xTqnGqCxVIrZ9LV09A2A=;
 b=VDElAqGtLoEtW/8AvMprK/34WGOevD8PSgc+wnETD41T++ieXOcLmGdGTwX9wj4tfm
 JbiDyiZSsgxszXxf6gswnzbgf8bNGg8kSIIai3ABKtL/6F25xXbMDhgzaarhqjoIzb6r
 c6Pcc1cQ8MK/Lav1q1C3vaUc70veLOvctmEP3taPy17DR32+FFyM6IiW3sM272x+jbDf
 P1Q4cb0q8peX1jVQCDjh1o/IXnsdms1oYepvRFx7g5UPiJETYaYcPukasqnY7wA1/K4J
 Aiv88Fce53iEQE8DHwpWxNmA9/CYh3rx3BUnIXzLO9aXeHwNt7bQyShgPtA66fNQnybY
 gFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783115567; x=1783720367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iuz6f9T/1WOWfq9X6LmBhv2xTqnGqCxVIrZ9LV09A2A=;
 b=VYRUmlp3qTUKJxhoSd+HucGPZSffmTM1MdT81wzNr07FQmpUakHI1ISPepmTuamQ0R
 Q30z5J0wMngIqJPPBUVIm5bAbIrXmtxjjqzmN4SFhJxtkDSbCL4r/jjf22ts3Q7B8TM5
 TPKqUOMoJFSEaNEzeSheUAn1nqLlb8i/v4cOkR/Zf4nfzgHq0RKZXEuk26ieWTWx7ZpD
 xKK8wnQfW3odKPHisum0SZf56D8US+7rcJysKq/mA/kM64queUy1zEUQKbd8slNbUHS2
 OfxOZuDOK1RsV5pzlyI7fEwP1kV14P5GgsQjdZw492AXOpEHOvRazcY0B5a3s0ODqw3f
 tRwA==
X-Gm-Message-State: AOJu0YxeHJVvtmV4c8gNkpZe9qhbMuOj0ygir3dv1h5mpVNyG64jbg2Y
 TvtWAryVwkYumb0+OEtub/Un5FsUXF2jAmEsYfUgci7dFfs90CLvjNO1OtZp6Tbuxp64G4L1G5/
 XmejEpdreVJStS5nkKnC2UvjpgBbsTX8=
X-Gm-Gg: AfdE7cmEYTdpHfa7bAue2/qoZtcQ3Sxh80jUxwZDJ4W1UnRudo0xfasOSFSdlnW9lu2
 YxMhEgJKbTHkfa+lsGfWF470zwePjU7UsGv3KdJqd4Qg/KqYfAansc6KjHm1JR5DiIHoWMmpthH
 mJLPQiK49ShFKs0YKyXThj7Iwkj1zXD21GnNaGRkSsfxhtjPPT0HlP1OKFgKfxFgzMJvpF7X7Wb
 fnbHEZw7dMlbC2zFU3VO6P+IU0qBA5Ub1rQ77xgVEDRnI4h2VU0cnLHautnvUnFH37pEFpBmjzd
 qMoEwVt2kuqdRA+lE98rxyABXjyKZc08kSMi4Et9sXlJHEPIUHTYmJ/GTA==
X-Received: by 2002:a05:690c:4989:b0:813:1001:cf85 with SMTP id
 00721157ae682-817397ece25mr9982137b3.37.1783115566440; Fri, 03 Jul 2026
 14:52:46 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 4 Jul 2026 07:52:34 +1000
X-Gm-Features: AVVi8CcaFLQgc24qnTTDxFMz24fXFBNB28QuFPqkGUGTyorzipNH5sstpWIoyx8
Message-ID: <CAPM=9txPze-srvS8pEioF2kCdkTCcf-zAbXjUKuzgw35b6xubw@mail.gmail.com>
Subject: [git pull] drm fixes for 7.2-rc2
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

Weekly fixes for drm, this is large for rc2 but it's just a lot of
small fixes across a bunch of drivers, xe, amdgpu as usual, plus some
sashiko-inspired fixes for panthor, and some dma-fence updates.

Thanks,
Dave.

drm-fixes-2026-07-04:
drm fixes for 7.2-rc2

core:
- kernel doc fix
- include types.h in drm_ras.h

dma-fence:
- fix NULL ptr dereference
- use correct callback
- make dma_fence_dedup_array more robust

dp:
- handle torn down topology gracefully
- fix kernel doc

i915:
- Input validation fixes for BIOS and EDID
- Fix HDCP code buffer overflow and seq_num_v monotonic increase check
- Fix near-NULL deref in i915_active during GFP_ATOMIC exhaustion

xe:
- Wedge from the timeout handler only after releasing the queue
- Fix a NULL pointer dereference
- Remove redundant exec_queue_suspended
- RTP / OA whitelist fixes
- Return error on non-migratable faults requiring devmem
- Skip FORCE_WC and vm_bound check for external dma-bufs
- Hold notifier lock for write on inject test path
- Drop bogus static from finish in force_invalidate
- Fix double-free of managed BO in error path
- Don't attempt to process FAST_REQ or EVENT relays
- Fix NPD in bo_meminfo
- Prevent invalid cursor access for purged BOs
- Fix offset alignment for MERT WHITELST_OA_MERT_MMIO_TRG

amdgpu:
- Soc24 aborted suspend fix
- Drop unecessary BUG() and BUG_ON() from error paths
- SCPM fix
- Power reporting fix
- DCE HDR fix
- UVD boundary checks
- VCN boundary checks
- VCE boundary checks
- DCN 4.2 fixes
- Large stack allocation fixes
- Fix aperture mapping leak
- UserQ fixes
- Ignore_damage_clips fix
- ACP fixes
- DC boundary checks
- GPUVM fixes
- JPEG idle check fixes
- Userptr fix
- GC 11.7 updates
- Non-4K page fix
- SMU 13 fixes
- DP alt mode fix

amdkfd:
- Boundary checks
- CRIU fixes

amdxdna:
- fix device removal issues
- fix use after free in debug BO

imagination:
- fix double call to scheduler fini
- fix ioctl return values
- fix user array stride

virtio:
- handle EDIDs better

panthor:
- irq safe fence lock fix
- reset work fix
- fix invalid pointer
- fix iomem access in suspended state
- sched resume fix
- unplug suspend fix
- drop needless check
- eviction leak fix
- bail on group start/resume fix
- keep irqs masked

malidp:
- use clock bulk API

komeda:
- clock prepare fixes
The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482=
:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-07-04

for you to fetch changes up to acd7c71ba8d83808fa8d704196f3d53f7d58cf50:

  Merge tag 'drm-misc-fixes-2026-07-02' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2026-07-03 08:53:15 +1000)

----------------------------------------------------------------
drm fixes for 7.2-rc2

core:
- kernel doc fix
- include types.h in drm_ras.h

dma-fence:
- fix NULL ptr dereference
- use correct callback
- make dma_fence_dedup_array more robust

dp:
- handle torn down topology gracefully
- fix kernel doc

i915:
- Input validation fixes for BIOS and EDID
- Fix HDCP code buffer overflow and seq_num_v monotonic increase check
- Fix near-NULL deref in i915_active during GFP_ATOMIC exhaustion

xe:
- Wedge from the timeout handler only after releasing the queue
- Fix a NULL pointer dereference
- Remove redundant exec_queue_suspended
- RTP / OA whitelist fixes
- Return error on non-migratable faults requiring devmem
- Skip FORCE_WC and vm_bound check for external dma-bufs
- Hold notifier lock for write on inject test path
- Drop bogus static from finish in force_invalidate
- Fix double-free of managed BO in error path
- Don't attempt to process FAST_REQ or EVENT relays
- Fix NPD in bo_meminfo
- Prevent invalid cursor access for purged BOs
- Fix offset alignment for MERT WHITELST_OA_MERT_MMIO_TRG

amdgpu:
- Soc24 aborted suspend fix
- Drop unecessary BUG() and BUG_ON() from error paths
- SCPM fix
- Power reporting fix
- DCE HDR fix
- UVD boundary checks
- VCN boundary checks
- VCE boundary checks
- DCN 4.2 fixes
- Large stack allocation fixes
- Fix aperture mapping leak
- UserQ fixes
- Ignore_damage_clips fix
- ACP fixes
- DC boundary checks
- GPUVM fixes
- JPEG idle check fixes
- Userptr fix
- GC 11.7 updates
- Non-4K page fix
- SMU 13 fixes
- DP alt mode fix

amdkfd:
- Boundary checks
- CRIU fixes

amdxdna:
- fix device removal issues
- fix use after free in debug BO

imagination:
- fix double call to scheduler fini
- fix ioctl return values
- fix user array stride

virtio:
- handle EDIDs better

panthor:
- irq safe fence lock fix
- reset work fix
- fix invalid pointer
- fix iomem access in suspended state
- sched resume fix
- unplug suspend fix
- drop needless check
- eviction leak fix
- bail on group start/resume fix
- keep irqs masked

malidp:
- use clock bulk API

komeda:
- clock prepare fixes

----------------------------------------------------------------
Alex Deucher (13):
      drm/amdgpu/gfx8: drop unecessary BUG_ON()
      drm/amdgpu/gfx9: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx9.4.3: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx10: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx11: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx12: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx12.1: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma4.4.2: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.2: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma6.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma7.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma7.1: replace BUG_ON() with WARN_ON()

Andr=C3=A9 Draszik (1):
      dma-fence: use correct callback in dma_fence_timeline_name()

Arnd Bergmann (1):
      drm/amd/display: avoid large stack allocation in
commit_planes_do_stream_update_sequence

Asad Kamal (1):
      drm/amdgpu: fix aperture mapping leak

Ashutosh Dixit (10):
      drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists
      drm/xe/rtp: Maintain OA whitelists separately
      drm/xe/rtp: Keep track of non-OA nonpriv slots
      drm/xe/rtp: Generalize whitelist_apply_to_hwe
      drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
      drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
      drm/xe/rtp: (De-)whitelist OA registers for all hwe's for a gt
      drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
      drm/xe/rtp: Ensure locking/ref counting for OA whitelists
      drm/xe/oa: Fix offset alignment for MERT WHITELIST_OA_MERT_MMIO_TRG

Baineng Shou (1):
      dma-fence: Make dma_fence_dedup_array() robust against 0-count input

Boris Brezillon (10):
      drm/panthor: Always use the IRQ-safe variant when acquiring the fence=
 lock
      drm/panthor: Keep the reset work disabled until everything is initial=
ized
      drm/panthor: Fix potential invalid pointer deref in
group_process_tiler_oom()
      drm/panthor: Fix theoretical IOMEM access in suspended state
      drm/panthor: Don't overrule pending immediate ticks in sched_resume_t=
ick()
      drm/panthor: Fix panthor_pwr_unplug()
      drm/panthor: Drop a needless check in panthor_fw_unplug()
      drm/panthor: Fix a leak when a group is evicted before the tiler
OOM is serviced
      drm/panthor: Interrupt group start/resumption if group_bind_locked() =
fails
      drm/panthor: Keep interrupts masked until they are needed

Boyuan Zhang (5):
      drm/amdgpu: fix division by zero with invalid uvd dimensions
      drm/amdgpu/vcn4: avoid rereading IB param length
      drm/amdgpu/vce: fix integer overflow in image size
      drm/amdgpu/jpeg: fix jpeg_v5_0_1_is_idle detection
      drm/amdgpu/jpeg: fix jpeg_v4_0_3_is_idle detection

Brajesh Gupta (2):
      drm/imagination: Fix double call to drm_sched_entity_fini()
      drm/imagination: Fix returned size for DRM_IOCTL_PVR_DEV_QUERY

Bryam Vargas (1):
      drm/virtio: bound EDID block reads to the response buffer

Ce Sun (2):
      drm/amdgpu: fix resource leak on ACP reset timeout
      drm/amdgpu: invoke pm_genpd_remove() before freeing genpd

Christian K=C3=B6nig (1):
      drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx

Dave Airlie (4):
      Merge tag 'drm-intel-fixes-2026-07-02' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.2-2026-07-02' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-xe-fixes-2026-07-02' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-07-02' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

David Francis (1):
      drm/amdkfd: Use kvcalloc to allocate arrays

Donet Tom (1):
      drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K systems

Francois Dugast (1):
      drm/xe/pt: Fix NULL pointer dereference in xe_pt_zap_ptes_entry()

Granthali Vinodkumar Dhandar (2):
      drm/amdgpu: add support for GC IP version 11.7.0
      drm/amdgpu: add support for GC IP version 11.7.1

Gustavo Kenji Mendon=C3=A7a Kaneko (2):
      drm/arm/malidp: use clk_bulk API in runtime PM resume and suspend
      drm/arm/komeda: fix error handling for clk_prepare_enable() and calle=
rs

Gustavo Sousa (1):
      drm/xe/rtp: Add struct types for RTP tables

Harish Kasiviswanathan (1):
      drm/amdgpu: Fix kernel panic during driver load failure

Harry Wentland (1):
      drm/amd/display: guard against overflow in HDCP message dump

Honglei Huang (1):
      drm/amd/display: use kvzalloc to allocate struct dc

Jakob Linke (1):
      drm/amdgpu/soc24: reset dGPU if suspend got aborted

Jani Nikula (7):
      drm/i915/hdcp: check streams[] bounds before overflow
      drm/i915/hdcp: require monotonically increasing seq_num_v
      drm/dp: fix kernel-doc for struct drm_dp_as_sdp
      drm/fixed: fix kernel-doc for drm_sm2fixp()
      drm/ras: include linux/types.h in drm_ras.h
      drm/i915/vrr: require valid min/max vfreq for VRR
      drm/i915/bios: range check LFP Data Block panel_type2

Jesse Zhang (2):
      drm/amdgpu/gfx11: fix EOP interrupt routing for KQ and userq
      drm/amdgpu/gfx12: fix EOP interrupt routing for KQ and userq

Joonas Lahtinen (1):
      drm/i915: Return NULL on error in active_instance

Leorize (1):
      drm/amd/display: set MSA MISC1 bit 6 when using VSC SDP for DCE 11.x

Lizhi Hou (4):
      accel/amdxdna: Fix amdxdna_client lifetime race during device removal
      accel/amdxdna: Fix notifier_wq lifetime race during device removal
      accel/amdxdna: Fix iommu domain lifetime race during device removal
      accel/amdxdna: Fix use-after-free in debug BO command handling

Lu Yao (1):
      drm/xe: Remove redundant exec_queue_suspended() check in
submit_exec_queue()

Luca Coelho (1):
      drm/dp_mst: Handle torn-down topology gracefully in
drm_dp_mst_topology_queue_probe()

Maarten Lankhorst (1):
      Merge drm/drm-fixes into drm-misc-fixes

Matthew Auld (3):
      drm/xe/display: skip FORCE_WC and vm_bound check for external dma-buf=
s
      drm/xe: fix NPD in bo_meminfo()
      drm/xe/pt: prevent invalid cursor access for purged BOs

Matthew Brost (1):
      drm/xe: Return error on non-migratable faults requiring devmem

Matthew Stewart (2):
      drm/amd/display: Fix DCN42 null registers & register masks
      drm/amd/display: Remove DCCG registers not needed in DCN42

Michal Wajdeczko (1):
      drm/xe/pf: Don't attempt to process FAST_REQ or EVENT relays

Natalie Vock (2):
      drm/amdgpu: Only set bo->moved when the BO was actually moved
      drm/amdgpu: Rename moved state to needs_update

Perry Yuan (1):
      drm/amdgpu: flush pending RCU callbacks on module unload

Philipp Stanner (1):
      dma-buf: dma-fence: Fix potential NULL pointer dereference

Prike Liang (3):
      drm/amdgpu/mes11: set doorbell offset for suspending userq
      drm/amdgpu/mes12: set doorbell offset for suspending userq
      drm/amdgpu: add the doorbell index input for suspending userq

Rodrigo Vivi (1):
      drm/xe: wedge from the timeout handler only after releasing the queue

Shuicheng Lin (3):
      drm/xe/userptr: Hold notifier_lock for write on inject test path
      drm/xe/userptr: Drop bogus static from finish in force_invalidate
      drm/xe/hw_engine: Fix double-free of managed BO in error path

Shuvam Pandey (1):
      drm/imagination: Fix user array stride in pvr_set_uobj_array()

Thomas Hellstr=C3=B6m (1):
      drm/xe/rtp: Fix build error with clang < 21 and non-const initializer=
s

Thomas Zimmermann (1):
      drm/amd/display: Handle struct drm_plane_state.ignore_damage_clips

WenTao Liang (1):
      drm/amd/display: detect_link_and_local_sink: DP alt mode timeout
path leaks prev_sink reference

Xiaogang Chen (1):
      drm/amdkfd: Guard m->cp_hqd_eop_control setting by q->eop_ring_buffer=
_size

Yang Wang (3):
      drm/amd/pm: make pp_features read-only when scpm is enabled
      drm/amd/pm: fix amdgpu_pm_info power display units
      drm/amd/pm: fix smu13 power limit range calculation

Yongqiang Sun (1):
      drm/amdkfd: clamp v9 CRIU control stack checkpoint copy to BO size

Zhu Lingshan (1):
      drm/amdgpu: reject mapping a reserved doorbell to a new queue

 drivers/accel/amdxdna/aie2_ctx.c                   |  68 +++++++++----
 drivers/accel/amdxdna/amdxdna_ctx.h                |   1 +
 drivers/accel/amdxdna/amdxdna_iommu.c              |  43 +++++---
 drivers/accel/amdxdna/amdxdna_pci_drv.c            |  38 ++++----
 drivers/accel/amdxdna/amdxdna_pci_drv.h            |   1 +
 drivers/dma-buf/dma-fence-unwrap.c                 |   3 +
 drivers/dma-buf/dma-fence.c                        |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |  13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  12 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  46 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |  17 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  58 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  13 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  78 ++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  69 ++++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |  24 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   3 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |  11 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |   4 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |   2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   6 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  56 +++++++++++
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |  28 ++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |  15 +--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  12 +--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  10 ++
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  25 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |   4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  16 +--
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h |  62 ++++++------
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |  15 ++-
 .../drm/amd/display/dc/dce/dce_stream_encoder.h    |   3 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.c    |  30 +++---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |   2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  26 +++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  11 ++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  15 +--
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |   6 +-
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c    |  14 ++-
 drivers/gpu/drm/arm/malidp_drv.c                   |  22 +++--
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |   4 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |  36 +++++--
 drivers/gpu/drm/i915/display/intel_hdcp.c          |  12 ++-
 drivers/gpu/drm/i915/display/intel_vrr.c           |   4 +
 drivers/gpu/drm/i915/i915_active.c                 |   7 +-
 drivers/gpu/drm/imagination/pvr_context.c          |  18 ++--
 drivers/gpu/drm/imagination/pvr_drv.c              |  19 ++--
 drivers/gpu/drm/imagination/pvr_queue.c            |   6 +-
 drivers/gpu/drm/imagination/pvr_queue.h            |   2 +-
 drivers/gpu/drm/imagination/pvr_vm.c               |   6 +-
 drivers/gpu/drm/panthor/panthor_device.c           |   4 +
 drivers/gpu/drm/panthor/panthor_device.h           |  17 ++--
 drivers/gpu/drm/panthor/panthor_fw.c               |   6 +-
 drivers/gpu/drm/panthor/panthor_gpu.c              |   3 +-
 drivers/gpu/drm/panthor/panthor_mmu.c              |   9 +-
 drivers/gpu/drm/panthor/panthor_pwr.c              |  10 +-
 drivers/gpu/drm/panthor/panthor_sched.c            | 108 ++++++++++++-----=
----
 drivers/gpu/drm/virtio/virtgpu_vq.c                |   3 +-
 drivers/gpu/drm/xe/display/xe_display_bo.c         |   3 +-
 drivers/gpu/drm/xe/display/xe_fb_pin.c             |   3 +-
 drivers/gpu/drm/xe/tests/xe_rtp_test.c             | 103 ++++++++---------=
---
 drivers/gpu/drm/xe/xe_drm_client.c                 |  12 ++-
 drivers/gpu/drm/xe/xe_gt_debugfs.c                 |   4 +-
 drivers/gpu/drm/xe/xe_guc_relay.c                  |  13 ++-
 drivers/gpu/drm/xe/xe_guc_submit.c                 |   9 +-
 drivers/gpu/drm/xe/xe_hw_engine.c                  |  20 ++--
 drivers/gpu/drm/xe/xe_hw_engine_types.h            |   8 ++
 drivers/gpu/drm/xe/xe_oa.c                         |   7 ++
 drivers/gpu/drm/xe/xe_oa_types.h                   |   3 +
 drivers/gpu/drm/xe/xe_pt.c                         |  67 ++++++++++---
 drivers/gpu/drm/xe/xe_reg_whitelist.c              | 102 ++++++++++++++++-=
--
 drivers/gpu/drm/xe/xe_reg_whitelist.h              |   4 +
 drivers/gpu/drm/xe/xe_rtp.c                        |  31 +++---
 drivers/gpu/drm/xe/xe_rtp.h                        |  24 ++++-
 drivers/gpu/drm/xe/xe_rtp_types.h                  |  10 ++
 drivers/gpu/drm/xe/xe_svm.c                        |   6 +-
 drivers/gpu/drm/xe/xe_svm.h                        |  15 ++-
 drivers/gpu/drm/xe/xe_tuning.c                     |  45 ++++-----
 drivers/gpu/drm/xe/xe_userptr.c                    |   2 +-
 drivers/gpu/drm/xe/xe_wa.c                         |  89 +++++++++--------
 include/drm/display/drm_dp_helper.h                |   1 +
 include/drm/drm_fixed.h                            |   3 +-
 include/drm/drm_ras.h                              |   2 +
 115 files changed, 1228 insertions(+), 643 deletions(-)
