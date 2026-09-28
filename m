Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238FACA5FA7
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E11F10E0EA;
	Mon, 28 Sep 2026 14:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iFqBoOZ/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F5D10E0A4;
 Mon, 28 Sep 2026 14:15:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 85E73601FA;
 Mon, 28 Sep 2026 14:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617621F000FF;
 Mon, 28 Sep 2026 14:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790604949;
 bh=Skh8DQCp2nv3OaiAXzd2UCRfKEC6MN1BjZflxEjDB9U=;
 h=Date:From:To:Cc:Subject;
 b=iFqBoOZ/q7+B5CQwwc+M8uol5zHMsGlDQmpAYuFuc8s0lphnAjxwE2ju4epnoAKii
 rIvcERcaUp9l8YicuDrzKdaPPjYg/kBMsUsV182dhBDU4IG1HfFiohiFttwKCKHlq3
 4NLGsGPfFc8+ZgLZCDwq9dFvT365MfEwGYmdL2mGF3Jb16rfZJzA9ufFLjE/3K/wVy
 0D+kWQmfQmIiDGEMCiurUB/JroNhWDojVONM8B01eosAFEgzSIZa/OPKsZ9xiTdaoX
 JCmNM1NPEQu7pUsy4A5BNhm2lRQYvOdTEJrLNZ8kDOf6mV0Ba3bFUhs7iB5M4hc0QY
 7e8khmS5Gq4UA==
Date: Mon, 28 Sep 2026 15:15:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, Song Li <songl@zju.edu.cn>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes tree
Message-ID: <arp2kBw-3U_092_A@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DpoZFWxevV8j37Ow"
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


--DpoZFWxevV8j37Ow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/vc4/vc4_v3d.c

between commit:

  94cf5971b1d04 ("drm/vc4: drain the hangcheck timer and works on V3D unbin=
d")

=66rom the drm-misc-fixes tree and commit:

  b4448823f151d ("drm/vc4: Use the reset controller to recover from a GPU h=
ang")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/vc4/vc4_v3d.c
index 0f0c090afa6e2,b40d98c9d1d28..0000000000000
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@@ -9,7 -9,7 +9,8 @@@
  #include <linux/component.h>
  #include <linux/platform_device.h>
  #include <linux/pm_runtime.h>
+ #include <linux/reset.h>
 +#include <linux/timer.h>
 =20
  #include <drm/drm_print.h>
 =20

--DpoZFWxevV8j37Ow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq6dpAACgkQJNaLcl1U
h9CO8gf7BapEijDrI3TElqUFtxQoStsBUWQF4tc6K9wQCdCUkqeQ/+e1WP3nMVaa
s1EBs4mdVfPUual6BlmGnnc6jtjs4ae8UbEOV0UejDdhuHsgPwBLdfxy34GWe6Rr
ZXRZ1hng4gyNGAORh7NhZJ3GSIrUZYETt3gd8nBnOcQ0M1s7P2y1VVDejW243QtR
FPe/Gkfwn7F10vF4rwg2zUEaxLqDe621whBF32YBXluW5SBYeEEo8AWp/lBME2Wf
VZ/9zlEZWyy2NR529mqWkm4YS1aO++EyA+7XzYrMIAohx2eFmYatRVnJUXU4jp0y
zgo29C1QMvEcThq+r3H+49sJVk4Xkg==
=T1Ux
-----END PGP SIGNATURE-----

--DpoZFWxevV8j37Ow--
