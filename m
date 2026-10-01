Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC33CA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9057D10EAE0;
	Sun,  4 Oct 2026 17:18:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2458D10E6BC;
 Thu,  1 Oct 2026 14:37:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F77A602D4;
 Thu,  1 Oct 2026 14:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D2D1F000FF;
 Thu,  1 Oct 2026 14:37:31 +0000 (UTC)
Date: Thu, 1 Oct 2026 16:37:28 +0200
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
Message-ID: <ar5wE6ElDrxOfNBL@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="zyb7ugnrpnhe7ijh"
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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


--zyb7ugnrpnhe7ijh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PULL] drm-misc-fixes
MIME-Version: 1.0

Hi Dave, Simona,

Here's the drm-misc-fixes PR for this week

Maxime

drm-misc-fixes-2026-10-01:
Multiple patches for vc4 that improve memory safety and leaks, one error
handling fix and a wrongful cast fix for th1520-dw-hdmi, one input
validation fix and the blend mode property addition for vmwgfx, two
locking fixes for drm_bridge, an input validation fix for panthor, an
error handling fix for drm_dp_helper, EAGAIN handling fix for
drm_fb_helper, and a clock reference leakage fix for aspeed.
The following changes since commit 45585c3aa285854face65293acc95eff73063d6d:

  drm/imagination: clamp freelist reconstruction requests (2026-09-24 14:59=
:22 +0530)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-20=
26-10-01

for you to fetch changes up to bca45af5998a05f34b13a2ef11e639bac9c62643:

  drm/vc4: Use kvmalloc_objs() for the BO cache size list (2026-10-01 10:36=
:09 -0300)

----------------------------------------------------------------
Multiple patches for vc4 that improve memory safety and leaks, one error
handling fix and a wrongful cast fix for th1520-dw-hdmi, one input
validation fix and the blend mode property addition for vmwgfx, two
locking fixes for drm_bridge, an input validation fix for panthor, an
error handling fix for drm_dp_helper, EAGAIN handling fix for
drm_fb_helper, and a clock reference leakage fix for aspeed.

----------------------------------------------------------------
Cristian Ciocaltea (2):
      drm/bridge: Fix unlocked list_del in drm_bridge_add()
      drm/bridge: Fix unlocked list access in drm_bridge_attach()

Dave Airlie (1):
      nouveau: check gsp->rm as well as gsp pointer before gcx ready

Fan Wu (1):
      drm/vc4: drain the hangcheck timer and works on V3D unbind

Felix Gu (2):
      drm/bridge: th1520-dw-hdmi: Fix error check on dw_hdmi_probe() return=
 value
      drm/bridge: th1520-dw-hdmi: Fix remove() callback

Ian Forbes (1):
      drm/vmwgfx: Add blend mode property

Ma=EDra Canal (2):
      drm/vc4: Free the BO cache size list on teardown
      drm/vc4: Use kvmalloc_objs() for the BO cache size list

Myeonghun Pak (1):
      drm/aspeed: Balance the display clock enable on teardown

Nguyen Ngoc Thang (1):
      drm/fb-helper: defer setup when fbdev_probe() fails, not just on -EAG=
AIN

Oleg Keri (1):
      drm/dp: don't mark the AUX backlight enabled when enabling failed

Osama Abdelkader (1):
      drm/panthor: validate userspace queue count against initialized firmw=
are slot count

Wentao Liang (1):
      drm/vc4: Fix firmware reference leak in vc4_drm_bind()

Zack Rusin (1):
      drm/vmwgfx: validate pitch coming from userspace

 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c           |  5 ++---
 drivers/gpu/drm/bridge/th1520-dw-hdmi.c           |  8 +++----
 drivers/gpu/drm/display/drm_dp_helper.c           |  4 +++-
 drivers/gpu/drm/drm_bridge.c                      |  8 +++++--
 drivers/gpu/drm/drm_fb_helper.c                   |  6 +++---
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c |  2 +-
 drivers/gpu/drm/panthor/panthor_sched.c           |  3 +++
 drivers/gpu/drm/vc4/vc4_bo.c                      |  5 +++--
 drivers/gpu/drm/vc4/vc4_drv.c                     |  5 ++++-
 drivers/gpu/drm/vc4/vc4_v3d.c                     |  8 +++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c      | 26 ++++++++++++++++++-=
----
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c               |  8 +++++++
 12 files changed, 66 insertions(+), 22 deletions(-)

--zyb7ugnrpnhe7ijh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar5wJwAKCRAnX84Zoj2+
dhT0AX9rN3otdu2wvuFSPGYzN1pvflymrXAiRhqge17N/+TuNOtzfe4/11t+i94V
2gubkxQBgMJRR16AJDIbcS2ZPTXYFatdWy0FHOGVfFmf7jNUReMF72ErtsGvLKrH
t86OnvqaPg==
=IjRi
-----END PGP SIGNATURE-----

--zyb7ugnrpnhe7ijh--
