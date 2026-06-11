Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3179FCD98CF
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492EA10EF48;
	Thu, 11 Jun 2026 13:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iHm2Fyv3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA4A10EF48
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 13:54:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3524C600AA;
 Thu, 11 Jun 2026 13:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75661F0089C;
 Thu, 11 Jun 2026 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781186076;
 bh=lUhjcWa4cl33papuj0akhgtxsIcEGGqf770vd/unceU=;
 h=Date:From:To:Cc:Subject;
 b=iHm2Fyv3PZEc0uUDNpNb79PpdUG6MGGO+oB0YHO+DKkyVKNukr+tBbb1VR83X2IN3
 9tuND0blqWacf2gXPLhJF0gJ+0KtpQJSihhSSdtbS2qcfXBC9dFLEDcaeE+iliInri
 PRf5Oxm74USA5kOCfuI3uVBiKHAWK2jxaugRx0vos9M+zc/BEHc/Z7OHPA7u3i88OT
 ZUOpJ/wPsy1lT4xZwbkkvjN8yLkMVn6XhiVO5qYiUwnwvDQlb2LGRzlHjU01lxT53/
 dpMjMUuQUXFNTKo55ND/ym1TcmhvaV+e0krgDLSH0TTABq/VZSUsOYCg9pbMMp/F/i
 pcgA/sGgh5HJA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id 707C51AC56C6; Thu, 11 Jun 2026 14:54:33 +0100 (BST)
Date: Thu, 11 Jun 2026 14:54:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Jani Nikula <jani.nikula@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Melissa Wen <melissa.srw@gmail.com>, Melissa Wen <mwen@igalia.com>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes tree
Message-ID: <aiq-GWegHjzdYJ2S@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sj32bbAeCvMOuiop"
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


--sj32bbAeCvMOuiop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/drm_atomic.c
  include/drm/drm_colorop.h

between commit:

  94ff735296d371 ("drm/colorop: make lut(1/3)d_interpolation props correctl=
y behave as mutable")

=66rom the drm-misc-fixes tree and commits:

  5164f7e7ff8ec7 ("drm: Rename struct drm_atomic_state to drm_atomic_commit=
")
  0c44d8dc6df988 ("drm/atomic: prefer drm_printf_indent() over inline \t")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--sj32bbAeCvMOuiop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoqvhgACgkQJNaLcl1U
h9DSCAf/YK/ukTzY2rdOQgIVUPLApQZh0WOvb48HcTQOlnrXxHzin29XyBgideml
NWbUu9sBXLXXKNmogX6aTKWq8nQkkHMVWVeV0NZKAJiJGiYtutP8PbuR18XWj6eo
2tmsJpViu1hQ6Y0TPhOfxHKymeQCBkkXzNZNNlQIkkhPqh4IzSOZlfZaONIBvKZy
lFrezVP5wz2m2lXba+p2XIX0K+aW8OcC12VMDkduE6DWItuQXZPHg/wpWMAhl4q+
7QtR/Fc4AzxGaBV+AWA9T5/KRUJax3uIPTxPqm1xYoAu7DgTMx+fhu6GEv8/GtMJ
9DxO6SNyPROW9XqgNE1uz7i78M7xUA==
=PvUH
-----END PGP SIGNATURE-----

--sj32bbAeCvMOuiop--
