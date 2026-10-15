Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261F5CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD96112244;
	Thu, 15 Oct 2026 09:15:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC501112255;
 Thu, 15 Oct 2026 09:15:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C31306022A;
 Thu, 15 Oct 2026 09:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BC01F000C4;
 Thu, 15 Oct 2026 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792055720;
 bh=6Tu5/t0+Q+Ocoy+vScQeHJhL4YXkcQqIYk8EY62cZUY=;
 h=Date:From:To:Cc:Subject;
 b=hzthE7ypCgW8ui4eXUgy3hwua8/wgbc3JMV8TI49mPT1niKRieUFUWnG1Qvm9yfPW
 NboeQRZgJTqfbPPvRlmEVQTG10oXptd0tzGvb6vx3CsT+qsQb4vUz6S2nkzUduew+J
 WkG4maRwRMZX5kNoQOvlA3o0LLFXBSrSmNl9pPg6edyS1mNJRakCpaEGNDa55r3Nq8
 6Kz4crjPVWBH/1ZkoaQ8mci9BdsyU9G+FFtquAC4gwgNKvQiJbqhNhgZA5UeifJsJ2
 3LZmd+ghVJp7g5aOyOf+UdKeTxgSsQ18syDILrfRDjVJh0hRfSie07kGNsB/ySP2id
 P323IUgMuHO9g==
Date: Thu, 15 Oct 2026 11:15:15 +0200
From: Maxime Ripard <mripard@kernel.org>
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
Message-ID: <atCZfcTvshZx6mcA@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="mmtizqyengsviu7m"
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


--mmtizqyengsviu7m
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PULL] drm-misc-fixes
MIME-Version: 1.0

Hi Dave, Sima,

Here's this week drm-misc-fixes PR

Maxime

drm-misc-fixes-2026-10-15:
A revert for the blend mode property patch being applied twice and a
patch to reset the device when frozen in virtio, a power state fix for
vc4, a Kconfig fix for amdxdna, an error handling, reference counting,
and a null pointer dereference fix for rocket, a revert for dma-buf for
a commit introducing a dangling reference, a locking fix for exec, and a
fix for panthor to handle 10-core GPUs.
The following changes since commit 6ccf996a0dec1852dab94ad865f27b4904750e12:

  drm/nouveau: Skip the Turing CE workaround object for non-GR channels (20=
26-10-08 18:14:46 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-20=
26-10-15

for you to fetch changes up to c347fef5f8f8927985bd67835331ce4cf7ff43a4:

  drm/panthor: fix immortalis condition (2026-10-14 16:57:52 +0100)

----------------------------------------------------------------
A revert for the blend mode property patch being applied twice and a
patch to reset the device when frozen in virtio, a power state fix for
vc4, a Kconfig fix for amdxdna, an error handling, reference counting,
and a null pointer dereference fix for rocket, a revert for dma-buf for
a commit introducing a dangling reference, a locking fix for exec, and a
fix for panthor to handle 10-core GPUs.

----------------------------------------------------------------
Andy Yan (1):
      MAINTAINERS: update my email address

Christian K=F6nig (1):
      drm/exec: don't immediately add prelocked obj to array of locked objs

Dave Stevenson (1):
      drm/vc4: hdmi: Move packet RAM enable to PM runtime

Dmitry Osipenko (1):
      Revert "drm/virtio: Add pixel blend mode property to cursor plane"

Erik Faye-Lund (1):
      drm/panthor: fix immortalis condition

Guangshuo Li (1):
      accel/rocket: clear rdev on device init failure

Heiko Stuebner (1):
      MAINTAINERS: Add myself as reviewer for the Rocket NPU driver

Igor Paunovic (2):
      accel/rocket: search every core slot when a core is removed
      accel/rocket: search every core slot when looking up a scheduler

Jianfeng Liu (1):
      Revert "dma-buf: Make DMABUF_DEBUG default to y on DEBUG_KERNEL kerne=
ls"

Liam R. Howlett (1):
      accel/amdxdna: Fix Kconfig invalid configuration

Yuho Choi (1):
      drm/virtio: Reset device before deleting virtqueues on freeze

 MAINTAINERS                            |  7 ++--
 drivers/accel/amdxdna/Kconfig          |  1 +
 drivers/accel/rocket/rocket_device.c   |  2 +
 drivers/accel/rocket/rocket_device.h   |  1 +
 drivers/accel/rocket/rocket_drv.c      |  7 +++-
 drivers/accel/rocket/rocket_job.c      |  2 +-
 drivers/dma-buf/Kconfig                |  2 +-
 drivers/gpu/drm/drm_exec.c             | 77 ++++++++++++++++++++----------=
----
 drivers/gpu/drm/panthor/panthor_hw.c   |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c         | 20 +++++----
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  1 +
 drivers/gpu/drm/virtio/virtgpu_plane.c | 13 ------
 include/drm/drm_exec.h                 | 15 ++++---
 13 files changed, 82 insertions(+), 68 deletions(-)

--mmtizqyengsviu7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCatCZowAKCRAnX84Zoj2+
dpxEAX0T5vyY7D63mEFBgwsxq0l/adl4E5xKoREeaagSWhqzBA/jxlAvNsjZZVzv
uZ8uRJwBgMhtRTyyUzQRSW7207tJ+4OGwHORHvN7jub9Fae5IdQFLwvMCP8CkXh/
2j71M24Peg==
=KcGx
-----END PGP SIGNATURE-----

--mmtizqyengsviu7m--
