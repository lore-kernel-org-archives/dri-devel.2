Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1148CA9EC5
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0BF710E387;
	Sat, 10 Oct 2026 11:45:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7771F10E189;
 Fri,  9 Oct 2026 13:18:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C6E960DC1;
 Fri,  9 Oct 2026 13:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF7C1F00893;
 Fri,  9 Oct 2026 13:18:25 +0000 (UTC)
Date: Fri, 9 Oct 2026 15:18:22 +0200
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
Message-ID: <asjkbknTHg2t8JGy@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="tsq25yhole3hlkt3"
Content-Disposition: inline
X-Mailman-Approved-At: Sat, 10 Oct 2026 11:45:03 +0000
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


--tsq25yhole3hlkt3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PULL] drm-misc-fixes
MIME-Version: 1.0

Hi Dave, Sima,

A bit late due to travel back from plumbers, but here's this week
drm-misc-fixes PR.

Maxime

drm-misc-fixes-2026-10-09:
A pointer assignment fix for gud, a reference fix and a preallocation
size fix for imagination, a suspend fix and an allocation fix when idle
for vc4, and a hardware variant fix for nouveau.
The following changes since commit bca45af5998a05f34b13a2ef11e639bac9c62643:

  drm/vc4: Use kvmalloc_objs() for the BO cache size list (2026-10-01 10:36=
:09 -0300)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-20=
26-10-09

for you to fetch changes up to 6ccf996a0dec1852dab94ad865f27b4904750e12:

  drm/nouveau: Skip the Turing CE workaround object for non-GR channels (20=
26-10-08 18:14:46 -0400)

----------------------------------------------------------------
A pointer assignment fix for gud, a reference fix and a preallocation
size fix for imagination, a suspend fix and an allocation fix when idle
for vc4, and a hardware variant fix for nouveau.

----------------------------------------------------------------
Gyeyoung Baek (2):
      drm/imagination: Fix reference and vm_bo handling in remap()
      drm/imagination: Size page table preallocation by device address

Mary Guillemard (1):
      drm/nouveau: Skip the Turing CE workaround object for non-GR channels

Ma=EDra Canal (2):
      drm/vc4: Disable the V3D interrupt across runtime suspend
      drm/vc4: Fix binner slot allocation failing on an idle GPU

Sajal Gupta (1):
      drm/gud: don't keep a connector without a CRTC as connector_state

 drivers/gpu/drm/gud/gud_pipe.c          |  1 +
 drivers/gpu/drm/imagination/pvr_mmu.c   | 25 +++++++--------
 drivers/gpu/drm/imagination/pvr_vm.c    |  8 ++---
 drivers/gpu/drm/nouveau/nouveau_abi16.c |  2 +-
 drivers/gpu/drm/vc4/vc4_drv.h           |  2 +-
 drivers/gpu/drm/vc4/vc4_gem.c           |  8 ++++-
 drivers/gpu/drm/vc4/vc4_irq.c           | 24 +++++---------
 drivers/gpu/drm/vc4/vc4_v3d.c           | 57 ++++++++++++++++-------------=
----
 drivers/gpu/drm/vc4/vc4_validate.c      |  2 +-
 9 files changed, 62 insertions(+), 67 deletions(-)

--tsq25yhole3hlkt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCasjpngAKCRAnX84Zoj2+
dnq+AX9VnzyYbqDsLI3klttBA8eM/1p70QjhoR5jPXkAYgLKSL9O0sRVawtZx8Wo
R2zx8vkBfiQUU7rGGc8g1ecy2HIEBkSZ9A9WaT4fZd2bteZxM71IzpxdCLXVGnwh
kgD4xkQeqA==
=wxDM
-----END PGP SIGNATURE-----

--tsq25yhole3hlkt3--
