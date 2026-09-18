Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1E2C982DC
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A6510F2DF;
	Fri, 18 Sep 2026 11:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WskpxSdY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0CAE10F2DF
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 11:14:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A9DAA4384E;
 Fri, 18 Sep 2026 11:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791F31F000FF;
 Fri, 18 Sep 2026 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789730073;
 bh=Kuutvxa5QOfFNe/emeep5WZ9K8kyOggGj16iP5pCM6w=;
 h=Date:From:To:Cc:Subject;
 b=WskpxSdYHnnWly4FY2W1f19/eURP/yUxDnKQfnOtrOkFM3K8fPMTg9Q89yG4DZhP7
 MUvvzh7NfWgg8w7Q4RjXZVNJ5KHD2PAn1OxTbjxKn3uZjWpTnZxdUgsQJ5M2e2w0i1
 Q+TiU3zX+1NQR+sQgwpjLE53U5HYRxl9UI1rFxXcNJ7eYt9n/xYByoUNmzMmrABjNT
 RCii7y9dsTYagKyQKcEyPMqBcVAOPqqkzW29DiSS1LHVCPVqpFgz6APPOiyL0r9bkC
 WAerT0pjufRYNW+lG1NT/zjqhXHHPPanZltMkYg/CQHvVAjNN+Ub2hh15obFnX6a0U
 kUyZ1wFM934rA==
Date: Fri, 18 Sep 2026 12:14:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Lyude Paul <lyude@redhat.com>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes tree
Message-ID: <aq0dFhGo62Hbqt4B@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q2wXDt7ErM0nUYQz"
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


--Q2wXDt7ErM0nUYQz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c

between commits:

  12f6eff11ccf9 ("drm/nouveau/gsp/r570: Set GcOff =3D 0 in fbsr")
  adb87c20081e5 ("drm/nouveau/gsp/r570: Enable Gcoff in fbsr again")

=66rom the drm-misc-fixes tree and commit:

  c7abe771e0138 ("drm/nouveau/gsp/r570: Set GcOff =3D 0 in fbsr")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--Q2wXDt7ErM0nUYQz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqtHRUACgkQJNaLcl1U
h9DckQf+PiPWQ03VXLT9bpTg1sTG/vNBTQhBxDu8yvSqwnFTdXMy4dfdp5PzdN0s
FtixadN/chjJp5LuvVaDvZvdxYQjX5zolcEgiIVcXRq+f6W5lb+ijIWVGwo8uq+R
GK7DfpXuiElkgqtLkPrQRNv1hdB/LOVgpC/nyTtnCz+q6S+SLy0nf7uwYcSmOU+J
3RMM6CQ4ly3BVBMs0lp/el80HhhJPBH4YyU4lYneuNA6hSJKkjLMt6HSDlvOSY5M
UWQ2dkOIDIYKlxIaoWkCP0W54eJRy0nUiwGjeI5SPh1rAvUOi/xIG8u1nQJZZAc8
cwwHKf4Et2CMk17/rlWPSyweolUJPA==
=SG1x
-----END PGP SIGNATURE-----

--Q2wXDt7ErM0nUYQz--
