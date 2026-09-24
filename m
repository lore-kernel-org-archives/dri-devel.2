Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EF5C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C29B10F903;
	Fri, 25 Sep 2026 07:30:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2107B10F602;
 Thu, 24 Sep 2026 14:43:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C109F40A8A;
 Thu, 24 Sep 2026 14:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291F41F000FF;
 Thu, 24 Sep 2026 14:43:04 +0000 (UTC)
Date: Thu, 24 Sep 2026 16:43:01 +0200
From: Maxime Ripard <self@mripard.dev>
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
Message-ID: <arU22zzqUGDEco1y@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="7xeej45t6wsocj7w"
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:43 +0000
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


--7xeej45t6wsocj7w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [PULL] drm-misc-fixes
MIME-Version: 1.0

Hi Dave, Sima,

Here's this week drm-misc-fixes PR

Maxime

drm-misc-fixes-2026-09-24:
A number of fixes:
  - bridge:
    - samsung-dsim: fix GPIO lifetime
  - client: Null pointer dereference fix
  - imagination: error handling fix, page handling fix
  - nouveau: fix reference leaks, double-frees, out-of-bounds accesses,
    use-after-frees, don't reject config without SCDC,  a number of
    workarounds
  - virtio: fix memory leak, reference leaks, null pointer dereference,
    add pixel blend mode, cache coherency fix
The following changes since commit 5535d5e61a77ad79118ea7665ce1c14f857f0f12:

  drm/loongson: Create blend mode property for cursor plane (2026-09-17 15:12:26 +0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-09-24

for you to fetch changes up to 45585c3aa285854face65293acc95eff73063d6d:

  drm/imagination: clamp freelist reconstruction requests (2026-09-24 14:59:22 +0530)

----------------------------------------------------------------
A number of fixes:
  - bridge:
    - samsung-dsim: fix GPIO lifetime
  - client: Null pointer dereference fix
  - imagination: error handling fix, page handling fix
  - nouveau: fix reference leaks, double-frees, out-of-bounds accesses,
    use-after-frees, don't reject config without SCDC,  a number of
    workarounds
  - virtio: fix memory leak, reference leaks, null pointer dereference,
    add pixel blend mode, cache coherency fix

----------------------------------------------------------------
Benjamin Leggett (1):
      drm/virtio: sync shmem backing on guest-bound transfers

Brajesh Gupta (2):
      drm/imagination: Propagate map failures correctly from pvr_mmu_map_sgl()
      drm/imagination: Fix page count for page table for map() interface

Dan Carpenter (1):
      drm/nouveau/clk: fix list cursor use after loop in nvkm_clk_ustate_update

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

Jakub Pawlak (1):
      accel/ivpu: Use separate flag for job timeout

Jonghyuk Kim(MalHyuk) (1):
      drm/nouveau: RCU-free the scheduler-containing nouveau_sched

Junrui Luo (5):
      drm/nouveau/dmem: pin VRAM for the whole registered range
      drm/virtio: fix object leak when drm_gem_handle_create() fails
      drm/virtio: fix object leak in virtio_gpu_resource_create_ioctl()
      drm/virtio: fix object leaks in virtio_gpu_resource_create_blob_ioctl()
      drm/virtio: release the GEM object on virtio_gpu_vram_create() errors

Li Youhong (1):
      drm/bridge: samsung-dsim: fix TE GPIO lifetime for host attach

Lyude Paul (5):
      drm/nouveau/gsp/r570: Add support for INTERNAL_GCX_ENTRY_PREREQUISITE
      drm/nouveau/gsp/r535: Add support for MEMSYS_GET_STATIC_CONFIG
      drm/nouveau/gsp/r570: Add comp mode workaround from issue #3172217
      drm/nouveau/gsp/r570: Start saving comptag backing stores
      drm/nouveau/gsp/r570: Enable Gcoff in fbsr again

Peiyang He (5):
      drm/nouveau: fix double-free in nvif_vmm_dtor
      drm/nouveau/uvmm: fix UAF in nouveau_uvmm_sm when BO is in TTM_PL_SYSTEM
      drm/nouveau: don't bump pin count on failed re-pin in nouveau_bo_pin_locked()
      drm/virtio: fix memory leak of fence event on execbuffer failure
      drm/virtio: fix NULL pointer dereference on fence allocation failure

Pengpeng Hou (1):
      drm/imagination: clamp freelist reconstruction requests

Shixiong Ou (1):
      drm/virtio: Add pixel blend mode property to cursor plane

Wentao Liang (3):
      drm/nouveau: Fix bridge reference leak in nv1a_ram_new()
      drm/nouveau: Fix gem reference leak in validate_init()
      drm/nouveau: Fix runtime PM leak in nouveau_connector_detect()

shechenglong (1):
      drm/client: fix restore of partially initialized client

 drivers/accel/ivpu/ivpu_drv.c                      |  3 +-
 drivers/accel/ivpu/ivpu_drv.h                      |  2 +-
 drivers/accel/ivpu/ivpu_job.c                      |  7 +-
 drivers/accel/ivpu/ivpu_mmu.c                      |  1 -
 drivers/accel/ivpu/ivpu_pm.c                       |  1 +
 drivers/gpu/drm/bridge/samsung-dsim.c              |  2 +-
 drivers/gpu/drm/clients/drm_fbdev_client.c         |  8 +++
 drivers/gpu/drm/imagination/pvr_free_list.c        | 15 ++++-
 drivers/gpu/drm/imagination/pvr_mmu.c              | 19 ++++--
 drivers/gpu/drm/imagination/pvr_mmu.h              |  2 +-
 drivers/gpu/drm/imagination/pvr_vm.c               |  4 +-
 drivers/gpu/drm/nouveau/include/nvif/cl0080.h      | 10 +++
 drivers/gpu/drm/nouveau/include/nvif/device.h      |  1 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h  |  6 ++
 drivers/gpu/drm/nouveau/nouveau_bo.c               |  3 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  5 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |  4 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              | 18 ++++-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |  2 +
 drivers/gpu/drm/nouveau/nouveau_sched.c            |  2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.h            |  1 +
 drivers/gpu/drm/nouveau/nouveau_uvmm.c             | 13 +++-
 drivers/gpu/drm/nouveau/nvif/device.c              | 13 ++++
 drivers/gpu/drm/nouveau/nvif/vmm.c                 |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c  |  8 ++-
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c  | 35 ++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c   |  3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c     | 31 ++++++---
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c   |  2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c     | 10 +++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h     |  1 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  | 17 +++++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h | 45 +++++++++++++
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 77 +++++++++++++++++++++-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c  | 36 ++++++++++
 .../nouveau/nvkm/subdev/gsp/rm/r570/nvrm/fbsr.h    | 29 ++++++++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h |  7 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h    |  3 +
 drivers/gpu/drm/virtio/virtgpu_drv.h               |  5 ++
 drivers/gpu/drm/virtio/virtgpu_gem.c               |  2 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             | 49 +++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_plane.c             | 13 ++++
 drivers/gpu/drm/virtio/virtgpu_prime.c             |  2 +-
 drivers/gpu/drm/virtio/virtgpu_submit.c            | 11 +++-
 drivers/gpu/drm/virtio/virtgpu_vq.c                | 46 +++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vram.c              | 17 ++---
 46 files changed, 531 insertions(+), 61 deletions(-)

--7xeej45t6wsocj7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCarU29QAKCRAnX84Zoj2+
dsciAYCgVQRAgfrIkT1CXZY6X9UyVBjOE8sJWpbKykkrOml4OXLw8B1cXhP/0Bb+
bEfGWgwBegLIz7FMhRo9pbwMDM8SINw+OOlGhiFVnxw498nHGOcyglEu8g0Ww1SE
LWDNQn2OYw==
=PGv/
-----END PGP SIGNATURE-----

--7xeej45t6wsocj7w--
