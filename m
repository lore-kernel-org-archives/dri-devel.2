Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6F4C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CAEC10F1BA;
	Fri, 18 Sep 2026 07:10:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E07D10EE1E;
 Thu, 17 Sep 2026 11:55:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE62541680;
 Thu, 17 Sep 2026 11:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CAD1F0089E;
 Thu, 17 Sep 2026 11:55:18 +0000 (UTC)
Date: Thu, 17 Sep 2026 13:55:14 +0200
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
Message-ID: <aqvVENQ4ksJEIcdb@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="l556737gsdzolcq4"
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:10:00 +0000
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


--l556737gsdzolcq4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PULL] drm-misc-fixes
MIME-Version: 1.0

Hi,

Here's this week drm-misc-fixes PR

Maxime

drm-misc-fixes-2026-09-17:
Two ttm fixes for ttm_tt_swapout(), one page-alignment and one overflow
fix for dma-buf, a drm_pending_vblank_event leak fix for drm,
suspend/resume fixes for nouveau, one out-of-bounds access fix for gud,
a use-after-free fix for vc4, a fence signaling fix, a race condition
fix for sched, planes formats fixes for verisilicon, and add the blend
mode property for loongson
The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-20=
26-09-17

for you to fetch changes up to 5535d5e61a77ad79118ea7665ce1c14f857f0f12:

  drm/loongson: Create blend mode property for cursor plane (2026-09-17 15:=
12:26 +0800)

----------------------------------------------------------------
Two ttm fixes for ttm_tt_swapout(), one page-alignment and one overflow
fix for dma-buf, a drm_pending_vblank_event leak fix for drm,
suspend/resume fixes for nouveau, one out-of-bounds access fix for gud,
a use-after-free fix for vc4, a fence signaling fix, a race condition
fix for sched, planes formats fixes for verisilicon, and add the blend
mode property for loongson

----------------------------------------------------------------
Christian K=F6nig (1):
      dma-buf/dma-fence: fix checking signaling bit for timeline and driver=
 name v3

David Hu (2):
      dma-buf: Fix silent overflow for phys vec to sgt
      dma-buf: Split sgl by largest page-aligned chunk

Huacai Chen (1):
      drm/loongson: Create blend mode property for cursor plane

Icenowy Zheng (3):
      drm/verisilicon: set blend mode for the cursor plane
      drm/verisilicon: add primary modifier for format tables
      drm/verisilicon: remove ARGB formats from primary plane

Karl Mehltretter (2):
      dma-buf: Make DMABUF_DEBUG default to y on DEBUG_KERNEL kernels
      drm/vc4: Use managed KMS polling to fix UAF on unbind

Lyude Paul (4):
      Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"
      drm/nouveau/gsp/r570: Set GcOff =3D 0 in fbsr
      drm/nouveau/gsp/r570: Enable S/R Display workaround in GSP
      drm/nouveau/gsp: Increase delay for magic sleep in r535_gsp_fini()

Maxime Ripard (1):
      Merge fdo/drm/drm-fixes into drm-misc-fixes

Sajal Gupta (1):
      drm/gud: fix out-of-bounds write in gud_plane_atomic_check()

Sophie D (1):
      drm/gud: Ignore damage clips in full update mode

Thadeu Lima de Souza Cascardo (1):
      drm: Fix drm_pending_vblank_event leak in error path for out_fence_ptr

Tvrtko Ursulin (1):
      drm/sched: Fix virtual runtime race

Vadim Nikitushkin (2):
      drm/ttm: fix swapped-out resources never leaving their bulk_move range
      drm/ttm: apply the swapout bulk_move fix to the intended condition

 drivers/dma-buf/Kconfig                            |  2 +-
 drivers/dma-buf/dma-buf-mapping.c                  | 31 ++++++++++-----
 drivers/dma-buf/dma-fence.c                        | 14 ++++++-
 drivers/gpu/drm/drm_atomic_uapi.c                  | 13 +++++--
 drivers/gpu/drm/gud/gud_pipe.c                     |  7 +++-
 drivers/gpu/drm/loongson/lsdc_plane.c              |  5 ++-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  |  8 +++-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c |  8 ++--
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c  |  3 +-
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h |  8 ++++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h    |  2 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |  8 +++-
 drivers/gpu/drm/scheduler/sched_rq.c               | 20 +++++-----
 drivers/gpu/drm/ttm/ttm_bo.c                       |  2 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |  2 +-
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c      |  2 +
 drivers/gpu/drm/verisilicon/vs_hwdb.c              | 44 +++---------------=
----
 drivers/gpu/drm/verisilicon/vs_hwdb.h              |  4 +-
 drivers/gpu/drm/verisilicon/vs_primary_plane.c     |  4 +-
 include/linux/dma-fence.h                          |  6 +++
 21 files changed, 110 insertions(+), 85 deletions(-)

--l556737gsdzolcq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaqvVIgAKCRAnX84Zoj2+
dnEgAX90JkLYTLQJyOLedTAfWZ0aj+eK0/GHmdeNjE6Yll62wrc99KZD73sbpsYo
Uqc+sPsBfRnlxKgUOk/tEuobnk5PHyPjqkZLl6sM1U06wFVjDyXJFWb8/sg1Y1At
lGFQIlLWoA==
=zb9x
-----END PGP SIGNATURE-----

--l556737gsdzolcq4--
