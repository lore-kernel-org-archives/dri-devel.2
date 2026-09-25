Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0B5C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 22:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80D810E20D;
	Fri, 25 Sep 2026 22:32:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cLaYRFKe";
	dkim-atps=neutral
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com
 [74.125.230.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5C6110E20D
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 22:31:59 +0000 (UTC)
Received: by mail-qk2-f13.google.com with SMTP id
 af79cd13be357-939eb3249c1so123506285a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790375519; cv=none;
 d=google.com; s=arc-20260327;
 b=NzMleLROO7fBriy9o717j2YJbBeztavBxvFYxNtG+/ApwjPuLIMgNPSRFjFPezOlrF
 HNV5TAhpFyPYzPme3Op8w35HaTl27txUOcbpc6M9PMiZl2usZ9qqmWqplSPdKVrsMs0m
 YSY98ZohmMM9mAUwG5nU4z7eloTxAKwPihTTsYDM+QTOlEhx32VbwgcQBrOQTKMP7u5m
 b6WLryb8h8KC7erkbpJlRgu4wIHI+o/xB7RNxZKoYQfwkrhPk2cpudE2FuCmjA1JTKqX
 O8aq0O7nlbK4J12lZSYjD9fnTbhKQrIZDmih6IUOfBy/qlQa2MLhzL92v5Sb117+Wgfv
 UGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=V3vqli2ndsVk/LMBVY4+gekll1+ICzZ8NkL1lheTiPo=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=hv0/7MzbnIjkM5GSCVwV2r6k3DDuM3xsOb6DGVUnwicksG20imu0HfFk9O2uHF4jCi
 oYZh3C74Xul/vqqNaZf9MNrdHM0sRnEpAx5LxRf+DDv1yP716IbCtWaKW/EWYJ6ko9Le
 egxjseUQwLKOhVfw2bhAjSVELeFsoi/wnGvs1HJiaYVYZBCJ+JmgoOdDSsFJuy3IToA6
 QRlysnWkUSIb2PkCRlxV40L0IcYdhgr5+w4VmVl6TaK0nUzJRrFXQPonhuePc296nNw1
 tBmVqu+Sm+RdwJScaFYxtUAsrhMu1TDerwzUu1YSBgjtKQ/FQsk3Lu27Ktirzz4UWPJY
 ++ew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790375519; x=1790980319; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V3vqli2ndsVk/LMBVY4+gekll1+ICzZ8NkL1lheTiPo=;
 b=cLaYRFKeAALHiYqfsFaiy5QlZS1e1x5s+jTTsDtgNrc6AORmvsivSbGNgOvN5yUf5W
 ln3dk51NydquQZb5mhfTi9JOeqUo1Uli771XY0xGczANFQxwESr8uGcWSLBC/jq7HrVc
 P46TXr3svaj61ZdChd00+njQWm87E/4/P5L2ZI8QtcsSl2XB/Zr2azmrsA5mjq0OaAx6
 LkkyHRkVbpUONybgnmH/p9SWJUYAVihgZSQhAHPfHh8rTlIdWjnrIerlelaeG8UftEvA
 qjwpkambm02LBoGFmckdyI34w+atDnH3Q9V2qxhARu8EpCNhLfHBBrMvo32wEA8s4zil
 Jruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790375519; x=1790980319;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=V3vqli2ndsVk/LMBVY4+gekll1+ICzZ8NkL1lheTiPo=;
 b=ExUiH8VMjgSMnkPCwlinNRL4Ve5A02g+2uUdibwu6/1tTJ8upYwnYFaXKVGVNLc0+M
 XmiyfLGzyI6huSd8KruJ3V2G9QVm8+hrrtAbwhA6Z1A76wgAYRd34lj0FRGE0lQUzJZy
 7gsOn5igtYjCMEWwGf3i8I/UpoT0W3O/bsQ4KKtBxjIJchsjcjPDzc/kviYVuRgycbd+
 XXAmZZXZv9paQdHXPRQvlXXo8tugD3dbTduomdJbnQVZQLcSoXDDGw/GpwmbHuMSgalM
 Ywp8R/uCQ1JrnRySAllfovIj2gxPy7elZ2jGKmlcTAQum5kkWbxvgkgI7bGLOSoB3Clx
 H64Q==
X-Gm-Message-State: AFuF++kfRs+6ZJPY/X+vZmL+KB4dcNyViLzkn2YD9b2UL2q1/ZQfEvZn
 irTejsam/045O8tSzje9Opcf+FL4xAEoDKuXOhoKsMjBPdGHr8dKn0NSLTPtWmrNAIRYntdAuqR
 f6brbcnEmszGB986tyxzsXaxbLlqcG3Y=
X-Gm-Gg: AYBFou0DArhldbzTBdlN4e/OLMOjXilUtDPIex4NG7Zz+AxmrJMUAnDW4n2ppjeOwgu
 6+wS4NggQL75upWI4uK0iMsrCUdkNfbR0RCgVeKGW9M3PVVgAtYe3G3NYT+AKhSHMwAXfdOPw0D
 528DKryK/Wa1jMD4MXT6ggPPZ5u82BPG7GqspzSsLr64SYGr7w61Z2nYE5OwRg7cqpeokX94N8C
 fvAijqEsWIlFlL+4AM7YzSGdnG7NAJNnrcfsoxQ1REzyFw1E7DUJ5ABonohEa7iwipMS0EFKc1F
 jkOnFE6LcLghmh4WHNF6gpvbW5ve2xVyco5c2WYnxudLPRHcfjlIsEQBqzus5JGIjDkc7kyU1m/
 SSlTnmsrKB5ti+Z+ykvwrCvIECblVfIF36h41WZxU4mWQsf9yYDY=
X-Received: by 2002:a05:620a:17ab:b0:93b:ebd8:9147 with SMTP id
 af79cd13be357-93c43c6a2e5mr670361385a.18.1790375518609; Fri, 25 Sep 2026
 15:31:58 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 26 Sep 2026 08:31:46 +1000
X-Gm-Features: AclHuK_bGNRuLRk5uKXZri1-wOBwJzbT64I-eOof3Ma0y1UaO6cjSrpVM4lGbag
Message-ID: <CAPM=9twjOfCE5-LzepSB58uaQtn4kS2yF2sOu52kiJp2xkJXkQ@mail.gmail.com>
Subject: [git pull] drm fixes for 7.3-rc5
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

While most of this is AI inspired fixes for error handling paths,
leaks and use after frees, there are some normal things. nouveau has
probably the biggest changes with some fixes to stabilise runtime
suspend/resume on 570 firmware which regressed after we moved from
535, there are some fixes to stackframe issues seen with amdgpu, and
otherwise the usual bunch of i915/xe/amdgpu fixes, and some virtio-gpu
fixes.

Hopefully it will start to quiten down a bit from here.

Dave.

drm-fixes-2026-09-26:
drm fixes for 7.3-rc5

client:
- fix restore of partially initialized client

i915:
- Fix incorrect RCU teardown order leading to endless loop
- Fix DP MST TU and FEC handling for disconnected streams
- Fix selective fetch disable, again
- Fix export namespace for kunit helpers
- Workaround eDP flicker on a specific laptop model

xe:
- CRI throttle reasons report
- TLB invalidation at wedge
- SVM eviction and VM close
- Display corruption on LNL on Xen PV
- W/a fix and addition

amdgpu:
- Display ref count fix
- Userq fixes
- VCN 4, 5 reset fixes
- Fixes for various error paths
- Stack frame size fixes for various combinations of compilers and configs

amdkfd:
- Possible UAF fix

nouveau:
- runtime suspend/resume fixes for newer firmware
- rcu free the scheduler
- fix VRAM pinning
- fix double free
- fix reference leaks
- fix runtime PM leak
- fix cursor list usage problems
- fix HDMI config rejection without SCDC

virtio:
- fix a bunch of object/memory leaks in failure paths
- add pixel blend mode property to cursor plane
- revert prime buffers import
- sync shmem backing on guest transfers

imagination:
- propogate map failures properly
- fix page count in map interface
- clamp freelist reconstruction requests

ivpu:
- use separate flag for job timeout

bridge:
- samsung-dsim: fix TE GPIO lifetime for host attach
The following changes since commit 93f51579e7df248780214094418f205253383cc5=
:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-09-26

for you to fetch changes up to a9ed3aa9b87ee41e8ab3ff471b1331c154767e45:

  Merge tag 'drm-misc-fixes-2026-09-24' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2026-09-26 07:58:24 +1000)

----------------------------------------------------------------
drm fixes for 7.3-rc5

client:
- fix restore of partially initialized client

i915:
- Fix incorrect RCU teardown order leading to endless loop
- Fix DP MST TU and FEC handling for disconnected streams
- Fix selective fetch disable, again
- Fix export namespace for kunit helpers
- Workaround eDP flicker on a specific laptop model

xe:
- CRI throttle reasons report
- TLB invalidation at wedge
- SVM eviction and VM close
- Display corruption on LNL on Xen PV
- W/a fix and addition

amdgpu:
- Display ref count fix
- Userq fixes
- VCN 4, 5 reset fixes
- Fixes for various error paths
- Stack frame size fixes for various combinations of compilers and configs

amdkfd:
- Possible UAF fix

nouveau:
- runtime suspend/resume fixes for newer firmware
- rcu free the scheduler
- fix VRAM pinning
- fix double free
- fix reference leaks
- fix runtime PM leak
- fix cursor list usage problems
- fix HDMI config rejection without SCDC

virtio:
- fix a bunch of object/memory leaks in failure paths
- add pixel blend mode property to cursor plane
- revert prime buffers import
- sync shmem backing on guest transfers

imagination:
- propogate map failures properly
- fix page count in map interface
- clamp freelist reconstruction requests

ivpu:
- use separate flag for job timeout

bridge:
- samsung-dsim: fix TE GPIO lifetime for host attach

----------------------------------------------------------------
Alex Deucher (1):
      drm/amd/display: Bump frame warning limit for all builds of dml

Alex Hung (1):
      drm/amd/display: Relax DML frame limit with UBSAN

Ankit Nautiyal (1):
      drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus 14-ew1

Asad Kamal (1):
      drm/amdkfd: fix use-after-free and multi-container gap in kfd_dev_map=
ping

Benjamin Leggett (1):
      drm/virtio: sync shmem backing on guest-bound transfers

Brajesh Gupta (2):
      drm/imagination: Propagate map failures correctly from pvr_mmu_map_sg=
l()
      drm/imagination: Fix page count for page table for map() interface

Christian K=C3=B6nig (1):
      drm/i915: fix incorrect RCU teardown order

Dan Carpenter (1):
      drm/nouveau/clk: fix list cursor use after loop in nvkm_clk_ustate_up=
date

Dave Airlie (4):
      Merge tag 'drm-intel-fixes-2026-09-24' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-09-24' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.3-2026-09-24' of
https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-09-24' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Dmitry Osipenko (1):
      Revert "drm/virtio: Allow importing prime buffers when 3D is enabled"

Francesco Magazzu (3):
      drm/nouveau/clk: don't use the pstate cursor after the loop
      drm/nouveau/device: don't use the pstate cursor after the loop
      drm/nouveau/clk: don't clobber reclock status when restoring volt/fan

Giuseppe Ranieri (1):
      drm/nouveau/disp: don't reject HDMI config on cards without SCDC

Guangshuo Li (1):
      drm/nouveau: fix autosuspend cleanup during teardown

Imre Deak (2):
      drm/i915/dp_mst: Fix configuring FEC for a disconnected stream
      drm/i915/dp_mst: Fix configuring TUs for a disconnected stream

Ivan Lipski (1):
      drm/amd/display: Bump frame warning limit for clang builds of dml

Jakub Pawlak (1):
      accel/ivpu: Use separate flag for job timeout

Jani Nikula (1):
      drm/i915/dp: use EXPORT_SYMBOL_IF_KUNIT() for kunit helpers

Jonghyuk Kim(MalHyuk) (1):
      drm/nouveau: RCU-free the scheduler-containing nouveau_sched

Junrui Luo (5):
      drm/nouveau/dmem: pin VRAM for the whole registered range
      drm/virtio: fix object leak when drm_gem_handle_create() fails
      drm/virtio: fix object leak in virtio_gpu_resource_create_ioctl()
      drm/virtio: fix object leaks in virtio_gpu_resource_create_blob_ioctl=
()
      drm/virtio: release the GEM object on virtio_gpu_vram_create() errors

Li Youhong (1):
      drm/bridge: samsung-dsim: fix TE GPIO lifetime for host attach

Lyude Paul (5):
      drm/nouveau/gsp/r570: Add support for INTERNAL_GCX_ENTRY_PREREQUISITE
      drm/nouveau/gsp/r535: Add support for MEMSYS_GET_STATIC_CONFIG
      drm/nouveau/gsp/r570: Add comp mode workaround from issue #3172217
      drm/nouveau/gsp/r570: Start saving comptag backing stores
      drm/nouveau/gsp/r570: Enable Gcoff in fbsr again

Matthew Auld (1):
      drm/xe/vm: nuke PTs only after unlinking contested VMAs

Matthew Brost (1):
      drm/xe: Keep walking on SVM eviction failure

Nemesa Garg (1):
      drm/i915/psr: Clear stale sel fetch enable bits on sel fetch disable

Peiyang He (5):
      drm/nouveau: fix double-free in nvif_vmm_dtor
      drm/nouveau/uvmm: fix UAF in nouveau_uvmm_sm when BO is in TTM_PL_SYS=
TEM
      drm/nouveau: don't bump pin count on failed re-pin in
nouveau_bo_pin_locked()
      drm/virtio: fix memory leak of fence event on execbuffer failure
      drm/virtio: fix NULL pointer dereference on fence allocation failure

Pengpeng Hou (1):
      drm/imagination: clamp freelist reconstruction requests

Prike Liang (1):
      drm/amdgpu: move userq fence wait out of signalling section

Shixiong Ou (1):
      drm/virtio: Add pixel blend mode property to cursor plane

Shuicheng Lin (1):
      drm/xe/tlb_inval: Treat wedged-device invalidations as complete

Sk Anirban (1):
      drm/xe/gt_throttle: Report power brake as a throttle reason on CRI

Sunil Khatri (3):
      drm/amdgpu/userq: fix double jiffies conversion in hang detect timeou=
t
      drm/amdgpu/vcn5.0.1: fix video_timeout unit mismatch in jpeg reset wa=
it
      drm/amdgpu/vcn4.0.3: fix video_timeout unit mismatch in jpeg reset wa=
it

Szymon Aceda=C5=84ski (1):
      drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV

Tangudu Tilak Tirumalesh (2):
      drm/xe: harden adjust_idledly() against divide-by-zero and overflow
      drm/xe: Add wa_14025941587 to xe2, xe3 and xe3p platforms

Wentao Liang (8):
      drm/nouveau: Fix bridge reference leak in nv1a_ram_new()
      drm/nouveau: Fix gem reference leak in validate_init()
      drm/nouveau: Fix runtime PM leak in nouveau_connector_detect()
      drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()
      drm/amdgpu: Fix vmid_wait fence leak in amdgpu_ring_init()
      drm/amdgpu: Fix acpi device leak in amdgpu_acpi_enumerate_xcc()
      drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()
      drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()

shechenglong (1):
      drm/client: fix restore of partially initialized client

 drivers/accel/ivpu/ivpu_drv.c                      |  3 +-
 drivers/accel/ivpu/ivpu_drv.h                      |  2 +-
 drivers/accel/ivpu/ivpu_job.c                      |  7 +-
 drivers/accel/ivpu/ivpu_mmu.c                      |  1 -
 drivers/accel/ivpu/ivpu_pm.c                       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 16 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           | 71 ++++++++++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  4 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |  4 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |  4 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |  2 +-
 drivers/gpu/drm/clients/drm_fbdev_client.c         |  8 ++
 drivers/gpu/drm/i915/display/intel_cursor.c        |  7 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |  2 +
 drivers/gpu/drm/i915/display/intel_dp_link_caps.c  |  6 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  4 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        | 24 +++++-
 drivers/gpu/drm/i915/display/intel_dp_mst.h        |  2 +
 drivers/gpu/drm/i915/display/intel_link_bw.c       |  3 +-
 drivers/gpu/drm/i915/display/intel_psr.c           | 15 ++++
 drivers/gpu/drm/i915/display/intel_quirks.c        |  3 +
 drivers/gpu/drm/i915/display/skl_universal_plane.c |  9 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |  2 +-
 drivers/gpu/drm/imagination/pvr_free_list.c        | 15 +++-
 drivers/gpu/drm/imagination/pvr_mmu.c              | 19 +++--
 drivers/gpu/drm/imagination/pvr_mmu.h              |  2 +-
 drivers/gpu/drm/imagination/pvr_vm.c               |  4 +-
 drivers/gpu/drm/nouveau/include/nvif/cl0080.h      | 10 +++
 drivers/gpu/drm/nouveau/include/nvif/device.h      |  1 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h  |  6 ++
 drivers/gpu/drm/nouveau/nouveau_bo.c               |  3 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  5 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |  4 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              | 18 +++-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |  2 +
 drivers/gpu/drm/nouveau/nouveau_sched.c            |  2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.h            |  1 +
 drivers/gpu/drm/nouveau/nouveau_uvmm.c             | 13 ++-
 drivers/gpu/drm/nouveau/nvif/device.c              | 13 +++
 drivers/gpu/drm/nouveau/nvif/vmm.c                 |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c  |  8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c  | 35 ++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c   |  3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c     | 31 ++++---
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c   |  2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c     | 10 +++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h     |  1 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  | 17 ++++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h | 45 ++++++++++
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 77 ++++++++++++++++-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c  | 36 ++++++++
 .../nouveau/nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h    | 29 +++++++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h |  7 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h    |  3 +
 drivers/gpu/drm/virtio/virtgpu_drv.h               |  5 ++
 drivers/gpu/drm/virtio/virtgpu_gem.c               |  2 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             | 49 ++++++++++-
 drivers/gpu/drm/virtio/virtgpu_plane.c             | 13 +++
 drivers/gpu/drm/virtio/virtgpu_prime.c             |  2 +-
 drivers/gpu/drm/virtio/virtgpu_submit.c            | 11 ++-
 drivers/gpu/drm/virtio/virtgpu_vq.c                | 46 +++++++++++
 drivers/gpu/drm/virtio/virtgpu_vram.c              | 17 ++--
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |  1 +
 drivers/gpu/drm/xe/xe_bo.c                         |  7 ++
 drivers/gpu/drm/xe/xe_bo.h                         | 19 +++++
 drivers/gpu/drm/xe/xe_gt_throttle.c                |  5 +-
 drivers/gpu/drm/xe/xe_guc_ads.c                    |  2 +-
 drivers/gpu/drm/xe/xe_hw_engine.c                  | 96 ++++++++++++++++++=
+---
 drivers/gpu/drm/xe/xe_tlb_inval.c                  |  3 +-
 drivers/gpu/drm/xe/xe_vm.c                         | 21 ++---
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |  2 +
 79 files changed, 810 insertions(+), 135 deletions(-)
