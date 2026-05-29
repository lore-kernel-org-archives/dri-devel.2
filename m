Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D973CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 23:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF50C1125E2;
	Fri, 29 May 2026 23:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nDO9sR3p";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0CF1125E1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 23:10:32 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-8cccdf044e7so26253966d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 16:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780096231; cv=none;
 d=google.com; s=arc-20240605;
 b=kj/NLamUhfPKyBLH37wR8hGlcxDATt5JK8/jWZIe7u6DrWhV9v0kO/3J4Hki3Q2kPJ
 97X9gR2fcdqFT6mvaF5ahpYGCE9Dd4B37jrvhJd6+JcVpOM91SYg68hE4Ee2CFoU+pIs
 WfgMeEkpi4lhx3fXstsrQFRfkY6alGqlcvd2f6toXuDUSiVrOG74xY69+aXAVQVih+5l
 AT1LPYtsGgDnsx9fSfl+v57n3S4e6VIKa9IhAvgklQkFvZ0m3pY1RgdfSv8X25CFNt15
 Cr0RJv/Fv3DZLv+6B+TgfqU85vA5K4HIWIzm4EmK9mJq6jL+tMUjRRv1iqmzBfJyVX8W
 pSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=+gTFgnTQQ4tpmxBynjMKt9ZUb+Ns4xddpQUI62I5u+4=;
 fh=HQwGS/tgfrjuEQ8NZOhWLiLZo088fJVbEezIgNGsHOo=;
 b=aTaIlKGS9TdbLewK59Ak8UpkWc96RGy9qhTtE+Nz3Zhq20PYrsaSTQ+kL+tRooVy0o
 enEzTyippQgEQeMfynJqFiQ+MekBMAlxjrehwQfVrMkQUaJ/NNqHfA+vqJzkha9H73bH
 v6mG1l01Y3HmpNgaMREtIhXOGao3X+Va4MtAK0DZedlJl8U46Y6F6r9T4FT657tTqDoL
 r2jH4cNT9JkLFQJxruoEH5QuuNIT9HELi1kMviPUupMFzhWUeosDIsMYqm3XCPJm1tW+
 q3B6/OHZs2v7Lxq1dFEWPRCbVS8/vMb2U4OhzT4t6sBMA1cIWFZ540sNeuGJ+OFY2cM1
 Azfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780096231; x=1780701031; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+gTFgnTQQ4tpmxBynjMKt9ZUb+Ns4xddpQUI62I5u+4=;
 b=nDO9sR3pw4IWsxfICslAzaYJQrh3azKWmX23UuE36+YfhyL5+8cY46b2tfo1t2eG5V
 uIaMqlVfmDGznRjPX5wWakxIgtADbNi0jvT7SXV3p0sUPNcPGW603WxxRyWlp5z7GAiJ
 fnbdzqeMKyFDyHA8ALxQzM4exxkdbDSSJ6gF6VzmRwgGFU5GoeG5Fmgh6branxH7QJA1
 QGZ+PZBJ8OJTjROvcf0+WM097U6p3VDRNNpDBzcOKhh3O/HjseHHfEk9FGPQLnlY7XoC
 bnNRc8ic6l9Oxf3CEy0d3cxZ/KcUh6pZx9K3ssfV7WV/0frLELoc6g11/kuns1U6vRPH
 bhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780096231; x=1780701031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gTFgnTQQ4tpmxBynjMKt9ZUb+Ns4xddpQUI62I5u+4=;
 b=rlXHJmAOvoxrFTpMIbKhKUMR9gWJJyAfXkZjcVC7R/rdHAx7cpojj5lhDdZEBvl11E
 N1E/jxPppopMep4SScsFSaeTQwNCG19pP3L3mu0xGC87kB3awZ4/2RDeaM/VSAenEPpS
 9I32jetSAmwhvXVmiNZDuCZbFiiRjepuL4Zsr6zAmyGm6UKtvVujfk2husgyhlMmhw2Q
 gkqo70XawVLtzhlL6QXRCW/L4FgnNhFrQPvE0E8LKugpOyboDNRr3u76vAp+gX51PHXs
 jYAHc3U6Fv/w/eMNM7BbT0/JVKm+l4NgifIFeVSy9cdtm//F9p3pbOQSrJLpmbK8fsMc
 8diQ==
X-Gm-Message-State: AOJu0Yx+hymX2WS0z0puILHMFHqg0M9PvOuFvbe+F7ioB+1O3h4fElhl
 Xl/1e8qORKFUJy5yH8My/lAvwm2R47Bnf2BDOy0pD1JFBWTs2aXKHPZtWCsFBSxMXQdjVy4rSfX
 g8Nm6tW2f/OngSC6MAyMZ5IEvw8z5L2U=
X-Gm-Gg: Acq92OGYXs7X035EcuoDrjpJSsZheU6JhIHN/6MxvQIh07cThionAvQyza/Bnuhsq00
 yQPdfwL3NbzU0Tk8T/JyB9lm/H/Q0rWIwVGR1zUUCAT/f/s3VEz4NqtGXU6BEZGXYMcUUGy9CI0
 YQWgT9NSwgsI3b41YL6df2ooQlV8tqpaj58L5EoUKJfKDwSj6Cl+56VeAs0m4akvY5H/Qn6nly8
 sJ6GzYm8mANdRJi9bIVW/QOVJZpSJ9MUCNbtS68eb1Ugl7FwsBw+DVXOTQfQ+amRJ5RrQpWZfQz
 0ZX5oV9dNzQGeVS7AlChbbLHIafhYW+IRSfNDFqXYzpeowQuO8bTQzsRjlFbiHf/wcKqWdgsBSQ
 ZfA==
X-Received: by 2002:a05:6214:c6b:b0:8cc:ea2c:f2b3 with SMTP id
 6a1803df08f44-8ccefd9199cmr28455796d6.21.1780096230965; Fri, 29 May 2026
 16:10:30 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 30 May 2026 09:10:19 +1000
X-Gm-Features: AVHnY4IM44hvlFYytW66-G5QhAYPzhFuG1RGcfBEsdhJs0DpalN1A9L0jgJk2-4
Message-ID: <CAPM=9tw_rsuFEfRpcctpzCxeiAufCf_+5Z+wYXVzYg2JEcHJjA@mail.gmail.com>
Subject: [git pull] drm fixes for 7.1-rc6
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

Regular pull, doesn't seem too insane or AI owned, couple of UAF fixes
and another repair for an earlier fix, mostly amdgpu and i915 display
with xe/i915 accel, and misc core/driver fixes.

It might be a bit bigger than usual at this stage, but I'm not seeing
anything too scary here.

Regards,
Dave.

drm-fixes-2026-05-30:
drm fixes for 7.1-rc6

dumb-buffer:
- prevent overflows in dumb-buffer creation

dma-buf:
- fix UAF in dma_buf_fd() tracepoint

gem:
- fix for the fix for the fix for the change handle ioctl

i915:
- Fix potential UAF in TTM object purge
- Use polling when irqs are unavailable
- Fix HDR pre-CSC LUT programming loop
- Block DC states on vblank enable when Panel Replay supported
- Use DC_OFF wake reference to block DC6 on vblank enable

xe:
- Restore IDLEDLY regiter on engine reset

amdgpu:
- GEM_OP warning fix
- GEM_OP locking fix
- Userq fixes
- DCN 2.1 refclk fix
- SI fix
- HMM fixes

amdkfd:
- svm_range_set_attr locking fix
- CRIU restore fix
- KFD debugger fix

amdxdna:
- require IOMMU on AIE2

hyperv:
- improve protocol validation

ivpu:
- test write offset in debugfs

rocket:
- fix UAF in bo creation
The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d=
:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-05-30

for you to fetch changes up to 7164d78559b0ff29931a366a840a9e5dd53d4b7c:

  drm/gem: fix race between change_handle and handle_delete
(2026-05-30 07:01:39 +1000)

----------------------------------------------------------------
drm fixes for 7.1-rc6

dumb-buffer:
- prevent overflows in dumb-buffer creation

dma-buf:
- fix UAF in dma_buf_fd() tracepoint

gem:
- fix for the fix for the fix for the change handle ioctl

i915:
- Fix potential UAF in TTM object purge
- Use polling when irqs are unavailable
- Fix HDR pre-CSC LUT programming loop
- Block DC states on vblank enable when Panel Replay supported
- Use DC_OFF wake reference to block DC6 on vblank enable

xe:
- Restore IDLEDLY regiter on engine reset

amdgpu:
- GEM_OP warning fix
- GEM_OP locking fix
- Userq fixes
- DCN 2.1 refclk fix
- SI fix
- HMM fixes

amdkfd:
- svm_range_set_attr locking fix
- CRIU restore fix
- KFD debugger fix

amdxdna:
- require IOMMU on AIE2

hyperv:
- improve protocol validation

ivpu:
- test write offset in debugfs

rocket:
- fix UAF in bo creation

----------------------------------------------------------------
Balasubramani Vivekanandan (1):
      drm/xe: Restore IDLEDLY regiter on engine reset

Berkant Koc (2):
      drm/hyperv: validate resolution_count and fix WIN8 fallback
      drm/hyperv: validate VMBus packet size in receive callback

Christian K=C3=B6nig (2):
      drm/amdgpu: fix amdgpu_hmm_range_get_pages
      drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_invalidate_gfx

Dan Carpenter (1):
      accel/ivpu: prevent uninitialized data bug in debugfs

Dave Airlie (4):
      Merge tag 'drm-intel-fixes-2026-05-27' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2026-05-28' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-7.1-2026-05-28' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2026-05-29' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

David Carlier (1):
      dma-buf: fix UAF in dma_buf_fd() tracepoint

David Francis (1):
      drm/amdkfd: Check for pdd drm file first in CRIU restore path

Dhabaleshwar Das (1):
      accel/rocket: fix UAF via dangling GEM handle in create_bo

Eric Huang (2):
      drm/amdkfd: fix NULL pointer bug in svm_range_set_attr
      drm/amdkfd: fix a vulnerability of integer overflow in kfd debugger

Ivan Lipski (1):
      drm/amd/display: Write REFCLK to 48MHz on DCN21

Janusz Krzysztofik (1):
      drm/i915: Fix potential UAF in TTM object purge

Jouni H=C3=B6gander (2):
      drm/i915/psr: Block DC states on vblank enable when Panel Replay supp=
orted
      drm/i915/psr: Use DC_OFF wake reference to block DC6 on vblank enable

Lizhi Hou (1):
      accel/amdxdna: Block running when IOMMU is off

Michael Bommarito (1):
      drm/amdgpu: fix lock leak on ENOMEM in AMDGPU_GEM_OP_GET_MAPPING_INFO

Micha=C5=82 Grzelak (1):
      drm/i915/aux: use polling when irqs are unavailable

Pranay Samala (1):
      drm/i915/color: Fix HDR pre-CSC LUT programming loop

Rajat Gupta (1):
      drm: prevent integer overflows in dumb buffer creation helpers

Stanley.Yang (1):
      drm/amdgpu: fix potential overflow in fs_info.debugfs_name

Sunil Khatri (9):
      drm/amdgpu/userq: Fix doorbell object cleanup of queue
      drm/amdgpu/userq: Fix the mutex_init cleanup for fence_drv_lock
      drm/amdgpu: simplify return value in amdgpu_userq_get_doorbell_index
      drm/amdgpu/userq: add amdgpu_bo_unpin when amdgpu_ttm_alloc_gart fail=
s
      drm/amdgpu/userq: reserve root bo without interruption
      drm/amdgpu/userq: make sure queue is valid in the hang_detect_work
      drm/amdgpu/userq: remove amdgpu_userq_create/destroy_object wrapper
      drm/amdgpu/userq: move mqd_destroy to later stage to keep core obj va=
lid
      drm/amdgpu/userq: use array instead of list for userq_vas

Timur Krist=C3=B3f (1):
      drm/amd/pm/si: Disregard vblank time when no displays are connected

Zhenghang Xiao (1):
      drm/gem: fix race between change_handle and handle_delete

Ziyi Guo (1):
      drm/amdgpu: check num_entries in GEM_OP GET_MAPPING_INFO

 drivers/accel/amdxdna/aie2_pci.c                   |   5 +
 drivers/accel/ivpu/ivpu_debugfs.c                  |   2 +-
 drivers/accel/rocket/rocket_gem.c                  |  17 +-
 drivers/dma-buf/dma-buf.c                          |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 207 +++++------------=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  31 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   7 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  47 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  10 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   3 +
 .../gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c |  15 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |   4 +
 drivers/gpu/drm/drm_dumb_buffers.c                 |  14 +-
 drivers/gpu/drm/drm_gem.c                          |   2 +
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c          | 113 +++++++++--
 drivers/gpu/drm/i915/display/intel_color.c         |   2 +-
 drivers/gpu/drm/i915/display/intel_display_core.h  |   1 +
 drivers/gpu/drm/i915/display/intel_display_irq.c   |   8 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |   2 +
 drivers/gpu/drm/i915/display/intel_dp_aux.c        |  20 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  25 +--
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c            |  28 +--
 drivers/gpu/drm/xe/xe_guc_ads.c                    |   5 +
 27 files changed, 341 insertions(+), 272 deletions(-)
