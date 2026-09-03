Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29699C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E8510F48F;
	Thu,  3 Sep 2026 09:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="b9USLalB";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="mQxPoDYJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96C710F48F
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788427642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=8u3TQg2cJAtoRCxT2xuz7Ezo38KqT0GhTI8HzDj8NjM=;
 b=b9USLalBY6KDvp/CqO0UMACkD+NT/VX2vwkD9Q3E4QAzWSVgykpxUaIY3rwdZ97F+wIL94
 uwdYzZosvYXs3a3x86JKoXS93XWkYe6B3tbP9KgFtxz4DJzWgDSiCsV1aWtN8BmPZ+eIZ1
 VcjNflJqrAAuUyMwffnZPQ9PD/Fs4Vc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-jXNCodF3PoCZR5sA03NLBg-1; Thu, 03 Sep 2026 05:27:20 -0400
X-MC-Unique: jXNCodF3PoCZR5sA03NLBg-1
X-Mimecast-MFC-AGG-ID: jXNCodF3PoCZR5sA03NLBg_1788427640
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d30035dso25315371cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788427640; x=1789032440; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8u3TQg2cJAtoRCxT2xuz7Ezo38KqT0GhTI8HzDj8NjM=;
 b=mQxPoDYJFrsF+XaOR9JVpajbqL1/xKaJA9r1cIL5gNjOaOMAT7tTeBbgLWDqzNEevN
 yEzhWy6rHK8vy20Vl8LGEhZKWFV6TQo1WFSie1KBQ/XjTq7C/iib5BHikE0E8teu7M/W
 QaAMsvEcZiGzKeNaIgPXbqucSkZROKZhOtUhX5+13YOkRwZ2l7lUenYYVGnjvB8rxWCb
 O7VYurjjfAnVNamOaaLtXpDmMXPIohJPP9TZlOUSZFMvAb6FIIKSAIfaOEjR9/FEwqxh
 Nh5aCNVIGp6SJXuPP2aWovy703C5LNLxPgKdmsY/7VkLVXetTzLKdyrzD5L/rctxSLP2
 ZyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788427640; x=1789032440;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8u3TQg2cJAtoRCxT2xuz7Ezo38KqT0GhTI8HzDj8NjM=;
 b=phT2nC1NxzvdFENK4jJ1uDeMsGf/X+WD26IlGJrfQl6wQDCsc4gFGldKm5FXE/wPtf
 0JQLRDgF1ZgVT49u1WlVd/VSrMVnZtVH1iHulIrFlGHvhVPR3SFKkhcIj0T15tMw6RT/
 Q6ZvJbwQ601HxnpWlSVvrbES+PrblwdFIxwKVUHQZdK0vHibhM+emo0DLBgOjKDttm7j
 0rW3MDy6gqnVo0+ZLIZ6EYio4StudkPSim02jzB5ahw5sUJevyLUmlO1GcmPSNa3LrxW
 R9FBJhP4O9bDCejzkmgGZv5ZVg0D1Dn1I4rEExI4Jr/gsbu1TxcELEBdDffgvRnFlb+S
 GSyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzglVsJgGMh5Y/SZk2neBsVjG4gURdOD7fmlQWuvGCT4Dx7Cn9Gc9YLt+ltPkYK4pm2B/kPk1TwZU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kDF42kwmUQVbe8Ky7mIwML7D+cSoDIoi7aERW4D8tbTaCJZFGG
 A6zed8wDCpK2diW9yjAZ9S2kT4UwbizaxEFzRzPWdv5AIbTKD1fq2tWrIFDkRMNAZhThTdA7f0I
 xmsUDFzxeNuTuES8sAIMwmIjLyZYa/46Nnc5IYfIyD/j/F/rj5bEpZd8ZCkuyI56NM8EzMA==
X-Gm-Gg: AYBFou3ogy7OJ5rXmRW1g4xkx5chfTFO4mVIZQIDodo2mxN+ZTUWwVNxpO1FXKMMH/O
 0lUCgK2mOukoVhO6fLKc3NB/Mzzl57lioEEH3gizCxkLANUSW04UNEg6e6m1RRB25bNLQoP0t6y
 UdNdPsakxovl3N0RTtMbzmrtcDClItEarT2C0ca2cCkpJAwgsy2g4h9cmapk7gCxhivu8uBSiBb
 tvMciy/0gxxz/PwEkENnE9oxKgSVvJEPhZDihcBGYVC/166GKSpdXqG4cHRyU3Vi3lgMci8UA9+
 I7WpuMk3N6SjwS91QPeEeyDfjALaDkIZOqKaE2YyUjTSCT+voPqA0CZO3rJyT3JQaVXAojO5
X-Received: by 2002:ac8:5e10:0:b0:52f:b0f9:e4f2 with SMTP id
 d75a77b69052e-53036b97d24mr121393961cf.1.1788427639608; 
 Thu, 03 Sep 2026 02:27:19 -0700 (PDT)
X-Received: by 2002:ac8:5e10:0:b0:52f:b0f9:e4f2 with SMTP id
 d75a77b69052e-53036b97d24mr121393341cf.1.1788427638874; 
 Thu, 03 Sep 2026 02:27:18 -0700 (PDT)
Received: from localhost ([193.32.126.212]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530332453a7sm38051241cf.26.2026.09.03.02.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 02:27:18 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:27:15 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Dave Airlie <airlied@gmail.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: [PULL] drm-misc-fixes
Message-ID: <apk9X5SkRLS9g4RF@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="t7h3iiiww7yymmtc"
Content-Disposition: inline
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


--t7h3iiiww7yymmtc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [PULL] drm-misc-fixes
MIME-Version: 1.0

Hi Dave, Sima,

Here's this week drm-misc-fixes PR

Maxime

drm-misc-fixes-2026-09-03:
A whole bunch of fixes for various drivers

- Fix drm_crtc_commit leak when PAGE_FLIP_EVENT is used,
- amd: plane blend mode fixes
- amdxdna: out-of-bounds access fix, reject commands chains with no
  commands, handle chained mapping BO failures, refuse to flush an
  imported BO
- atomic-state-helpers: set pixel_blend_mode to prop default on reset
- dma-buf: Publish the dma-buf only after copy_to_user succeeds, fix
  some kernel-doc warnings
- ethosu: handle mmio mapping failures, handle storage modes only on
  hardware that supports it, fix job completion fence cleanup
- fastrpc: Publish the dma-buf only after copy_to_user succeeds
- gud: Improve TV modes and rotation handling
- nouveau: use-after-free fixes, add scanline position support, HDMI
  and DP fixes, null pointer dereference fix, dmem accounting fixes for
  large folios, use write-combined maps for coherent
- pagemap: Prevent double migration of device pages, Reset migration
  page count on eviction retry, dma-unmap pages before handling
  migration errors, use after free fixes
- prime: fix prime exports tracing
- qaic: out-of-bounds access fix
- sysfb: Fix integer overflow, fix constant comparison bug
- tegra: Add blend mode properties
- virtio: exit path and error handling fixes
The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-09-03

for you to fetch changes up to d3609b540838945ab2ca5b65f32a2eb67bb284c8:

  MAINTAINERS, mailmap: use Aditya Garg's linux.dev account (2026-09-03 09:44:40 +0200)

----------------------------------------------------------------
A whole bunch of fixes for various drivers

- Fix drm_crtc_commit leak when PAGE_FLIP_EVENT is used,
- amd: plane blend mode fixes
- amdxdna: out-of-bounds access fix, reject commands chains with no
  commands, handle chained mapping BO failures, refuse to flush an
  imported BO
- atomic-state-helpers: set pixel_blend_mode to prop default on reset
- dma-buf: Publish the dma-buf only after copy_to_user succeeds, fix
  some kernel-doc warnings
- ethosu: handle mmio mapping failures, handle storage modes only on
  hardware that supports it, fix job completion fence cleanup
- fastrpc: Publish the dma-buf only after copy_to_user succeeds
- gud: Improve TV modes and rotation handling
- nouveau: use-after-free fixes, add scanline position support, HDMI
  and DP fixes, null pointer dereference fix, dmem accounting fixes for
  large folios, use write-combined maps for coherent
- pagemap: Prevent double migration of device pages, Reset migration
  page count on eviction retry, dma-unmap pages before handling
  migration errors, use after free fixes
- prime: fix prime exports tracing
- qaic: out-of-bounds access fix
- sysfb: Fix integer overflow, fix constant comparison bug
- tegra: Add blend mode properties
- virtio: exit path and error handling fixes

----------------------------------------------------------------
Aditya Garg (1):
      MAINTAINERS, mailmap: use Aditya Garg's linux.dev account

Anuj Bolewar (1):
      drm/virtio: reclaim pending vbufs before tearing down vqs

Arvind Yadav (2):
      drm/pagemap: Prevent double migration of device pages
      drm/pagemap: Reset migration page count on eviction retry

Baineng Shou (4):
      dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
      misc: fastrpc: don't publish fd before copy_to_user() succeeds
      drm/prime: use dma_buf_fd_install() to preserve export tracing
      selftests: dmabuf-heaps: add fd-leak-on-EFAULT regression test

Benjamin Leggett (1):
      drm/virtio: use the DMA API for resource backing on Xen

Dan Carpenter (1):
      drm/virtio: Fix a NULL vs ERR_PTR() bug in virtio_gpu_user_framebuffer_create()

Dave Airlie (1):
      nouveau/instmem: handle iomapping already existing

Deepanshu Kartikey (1):
      drm/gud: NUL-terminate TV mode names read from the device

Faith Ekstrand (1):
      drm/nouveau: Use write-combined maps for coherent

GuoHan Zhao (2):
      accel/ethosu: check MMIO mapping errors in probe
      accel/ethosu: fix job completion fence cleanup

Lizhi Hou (1):
      accel/amdxdna: Remove __counted_by from struct amdxdna_cmd_chain

Lyude Paul (1):
      drm/nouveau/disp/r535: Add scanline position support + head state support

Marek Czernohous (1):
      drm/nouveau: unsubscribe the channel-kill event before the fence context

Matthew Brost (2):
      drm/pagemap: dma-unmap pages before handling migration errors
      drm/pagemap: Fix folio allocation fallback and use-after-put

Maxime Ripard (1):
      Merge drm/drm-fixes into drm-misc-fixes

Melissa Wen (4):
      drm/atomic-state-helper: set pixel_blend_mode to prop default on reset
      drm/amd/display: fix missing blend-mode-prop warning for DCN
      drm/amd/display: advertise PIXEL_NONE and PREMULTI blend mode for DCE
      drm/amd/display: use plane color_mgmt_changed to track colorop changes

Mohamed Ahmed (8):
      drm/nouveau/disp: move GSP head-timing ISR and vblank helpers to tu102.c
      drm/nouveau/disp: move the GSP HDMI GCP AVMute write to engine/disp
      drm/nouveau/disp: route GSP-RM display MMIO through nvkm_disp_func hooks
      drm/nouveau/disp: fix HDMI vendor infoframes on GB20x
      drm/nouveau/disp: fix HDMI GCP AVMute register offsets on GB20x
      drm/nouveau/gsp: use per-version DP_CONFIG_STREAM params on r570 firmware
      drm/nouveau/disp: fix head state readback on GB20x
      drm/nouveau/gsp: fix vblank interrupts on GB20x

Randy Dunlap (1):
      dma-buf: fix some kernel-doc warnings

Sajal Gupta (1):
      drm/gud: validate GUD_ROTATION_0 is present in supported rotations

Shixiong Ou (2):
      drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation
      drm/sysfb: ofdrm: Fix is_avivo() constant comparison bug

Slawomir Stepien (1):
      drm/cirrus-qemu: Validate BAR0 size during probe

Taimuraz Kaitmazov (4):
      accel/amdxdna: return early from a zero-length flush
      accel/amdxdna: reject a command chain that carries no commands
      accel/amdxdna: put the chained BO when its mapping fails
      accel/amdxdna: refuse to flush an imported BO

Tao Yu (1):
      drm/gud: validate TV mode names before creating enum property

Thadeu Lima de Souza Cascardo (2):
      drm/atomic: remove bogus check for file_priv
      drm: Fix drm_crtc_commit leak if signaled when PAGE_FLIP_EVENT is used

Thierry Reding (1):
      drm/tegra: Add blend mode properties

Thomas Zimmermann (1):
      Merge drm/drm-fixes into drm-misc-fixes

Tomeu Vizoso (1):
      accel: ethosu: Don't read the U65 rounding mode as a storage mode

Youssef Samir (1):
      accel/qaic: Address potential out-of-bounds read in resp_worker()

Zhenhao Wan (5):
      drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE op
      drm/nouveau/uvmm: fix premature region free on failed OP_UNMAP_SPARSE
      drm/nouveau/uvmm: clear the dirty flag when unwinding an OP_UNMAP_SPARSE
      drm/nouveau/dmem: fix mismatched DMA unmap size for large folios
      drm/nouveau/dmem: fix callocated underflow on large folio split

shechenglong (1):
      drm/virtio: check return value of vgdev_output_init()

 .mailmap                                           |   3 +-
 MAINTAINERS                                        |   2 +-
 drivers/accel/amdxdna/aie2_message.c               |   2 +-
 drivers/accel/amdxdna/amdxdna_ctx.c                |   4 +-
 drivers/accel/amdxdna/amdxdna_ctx.h                |   2 +-
 drivers/accel/amdxdna/amdxdna_gem.c                |  10 +-
 drivers/accel/ethosu/ethosu_drv.c                  |   2 +
 drivers/accel/ethosu/ethosu_gem.c                  |   2 +-
 drivers/accel/ethosu/ethosu_job.c                  |  10 +-
 drivers/accel/qaic/qaic_control.c                  |  46 ++--
 drivers/dma-buf/dma-buf.c                          |  20 ++
 drivers/dma-buf/dma-heap.c                         |  80 +++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  31 ++-
 drivers/gpu/drm/drm_atomic_state_helper.c          |   7 +
 drivers/gpu/drm/drm_atomic_uapi.c                  |   5 +-
 drivers/gpu/drm/drm_pagemap.c                      | 270 ++++++++++++++++++---
 drivers/gpu/drm/drm_prime.c                        |   2 +-
 drivers/gpu/drm/gud/gud_connector.c                |  12 +-
 drivers/gpu/drm/gud/gud_drv.c                      |   2 +
 drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h |   1 +
 drivers/gpu/drm/nouveau/nouveau_chan.c             |   9 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |  18 +-
 drivers/gpu/drm/nouveau/nouveau_sgdma.c            |   4 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c             |   6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |  10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild    |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c   |  13 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c   | 191 +++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h    |   2 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h     |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h    |  17 ++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c   |  86 ++++++-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 125 ++++------
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c |  64 +++++
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c  |   9 +
 .../nouveau/nvkm/subdev/gsp/rm/r570/nvrm/disp.h    |   2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h    |   5 +
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |   3 +
 drivers/gpu/drm/sysfb/ofdrm.c                      |   8 +-
 drivers/gpu/drm/tegra/dc.c                         |   6 +
 drivers/gpu/drm/tegra/hub.c                        |   2 +
 drivers/gpu/drm/tiny/cirrus-qemu.c                 |   3 +
 drivers/gpu/drm/virtio/virtgpu_display.c           |   9 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |  21 ++
 drivers/gpu/drm/virtio/virtgpu_kms.c               |   1 +
 drivers/gpu/drm/virtio/virtgpu_object.c            |   2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |  21 +-
 drivers/misc/fastrpc.c                             |  16 +-
 include/drm/drm_pagemap.h                          |   8 +-
 include/linux/dma-buf.h                            |   1 +
 include/linux/dma-fence-array.h                    |   1 -
 include/linux/dma-fence-chain.h                    |   9 +-
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 113 ++++++++-
 54 files changed, 1072 insertions(+), 234 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c

--t7h3iiiww7yymmtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCapk9cgAKCRAnX84Zoj2+
dqexAYDzmTqjyMwqtU8o1XlH+Q45NuZ27Sfm2VE95amPbBXMqRuHmvnvM31DyVyn
hXNopr8Bfj4lbBiaRN6/o6JkNJFW6HqZMmgcyRLZheOevYzZ4qmaBVWvs2jp5ImN
23ETeCuIHg==
=KIe9
-----END PGP SIGNATURE-----

--t7h3iiiww7yymmtc--

