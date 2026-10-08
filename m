Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC819CA600A
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E7510E792;
	Thu,  8 Oct 2026 09:05:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XjI53OhT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416E110E77F;
 Thu,  8 Oct 2026 09:05:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F3D6601EF;
 Thu,  8 Oct 2026 09:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E6A1F000FF;
 Thu,  8 Oct 2026 09:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791450345;
 bh=YukIs24ku5eXMFyDrQgCz9IpX8rOpx/Ss8mK/NLt3mY=;
 h=Date:From:To:Cc:Subject;
 b=XjI53OhTtmFpr35J/lOLX+7bINETHnWnTQoN10AjG3lT5xcEOUmqLx20KboiTl4Pb
 g9zhIGhaa0YeiFUhnyi0gNdJZhJTtVjokHOZddoZlUdxsbQOyeQrmMzjYH7hxa7WKo
 //E4ZaKx5td7ntsvEVf0ccNPYKLewPxjTb5uUexYRWqTmJVrzXlyObdX74bbxPsU2I
 dBnFIeSOuHJhqPjrlRr1Enk/NDXI5olAWLB4dDWVpgg+Y2JgkPn9K+QSIXYxddWNCM
 WnzfbC2D1fgJDd6imOMIcR7TsTTo4FFyOSCQrsH7WDXhHkVzwtRNJ8hvAza8ZJpvrY
 mSb7a2vvN3tSA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id EA02F1AC57CE; Thu, 08 Oct 2026 10:05:41 +0100 (BST)
Date: Thu, 8 Oct 2026 11:05:41 +0200
From: Mark Brown <broonie@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 DRI <dri-devel@lists.freedesktop.org>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with the drm-misc tree
Message-ID: <asdc5fk-KcV74jnx@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q9xfQlstLeq8UYA1"
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


--q9xfQlstLeq8UYA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c

between commit:

  6ccc5b5fc1d36 ("drm/fbdev: Move fbdev helpers into client library")

=66rom the drm-misc tree and commit:

  51a4359f7431a ("drm/amdgpu: serialize vblank counter reads against GPU re=
set")

=66rom the amdgpu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 51a7a4091376b,f34150d20a2f2..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@@ -28,8 -28,9 +28,9 @@@
 =20
  #include "amdgpu.h"
  #include <drm/amdgpu_drm.h>
 +#include <drm/clients/drm_fbdev_helper.h>
  #include <drm/drm_drv.h>
 -#include <drm/drm_fb_helper.h>
+ #include <drm/drm_vblank.h>
  #include "amdgpu_uvd.h"
  #include "amdgpu_vce.h"
  #include "atom.h"

--q9xfQlstLeq8UYA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCasdc4gAKCRAv73Ows9A4
iY/qAQDmwHMMWeRccgRE+tTVCTmNuMzLFIdc1NEMD0DF9yctVAEAhB70yDiLSRlv
IUx3V+JGlvl1BTztsQHThX0+M+KplQc=
=eM/5
-----END PGP SIGNATURE-----

--q9xfQlstLeq8UYA1--
