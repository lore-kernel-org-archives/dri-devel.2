Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CD4C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C373D10E973;
	Mon, 20 Jul 2026 14:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Krbtnd4v";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4EC910E973
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:44:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 38DC660A60;
 Mon, 20 Jul 2026 14:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FF21F000E9;
 Mon, 20 Jul 2026 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784558658;
 bh=ge0ST5uI8w0LQqp7rNRW6gqoEiJ8mVb/G7akG2udssM=;
 h=Date:From:To:Cc:Subject;
 b=Krbtnd4vecMFOM2O6Nj3MaNc3Xk5o68suqamkqsE6Ft7SAVA4kVrJyJpjKeULg1HG
 KNrNyf3Ou7w9onBYKGFrI3/w4x7ft54u9PLb/Alr5i/V12pPCBt/8YDIuT5TZwKKmd
 0aNl2kZq3ONH3qEOaVO5I24gWbRXGOeeaNkWkDPXo51twUXYRNp4VfAYcSJdVnfzml
 0885MEat6THdV5K3oZ3398rPHlJh28vmZ9HtsxM5Q0PJqsd6tMJ8gnfmAkeDrSz/99
 EHozwXZFeQX0SW/yPT55T63nPn0cRorEkN7BhLGYCoYFmjsqmZnUYibhajWv0fSwjl
 PnhZUQ9lLrKqw==
Date: Mon, 20 Jul 2026 15:44:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Laura Nao <laura.nao@collabora.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <al40PhpnfidCIYIU@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A4HRck5EADJCIPV6"
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


--A4HRck5EADJCIPV6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/xe/xe_device.c

between commit:

  130910bac905a ("drm/xe/pf: Disable display in admin only PF mode")

=66rom the origin tree and commit:

  21fcb222f0d1e ("drm: Remove DRIVER_GEM_GPUVA feature flag")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/xe/xe_device.c
index 9d119c95a569a,ad7f3e61d4579..0000000000000
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@@ -426,7 -427,8 +427,7 @@@ static const struct drm_ioctl_desc xe_i
 =20
  static const struct drm_driver admin_only_driver =3D {
  	.driver_features =3D
- 	    DRIVER_GEM | DRIVER_RENDER | DRIVER_GEM_GPUVA,
 -	    XE_DISPLAY_DRIVER_FEATURES |
+ 	    DRIVER_GEM | DRIVER_RENDER,
  	.open =3D xe_file_open,
  	.postclose =3D xe_file_close,
  	.ioctls =3D xe_ioctls_admin_only,

--A4HRck5EADJCIPV6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpeND0ACgkQJNaLcl1U
h9CqJwf+OK6omN5TO+ub2D7KHgCSLdVCLUuuG1l9m8rsY8LOt0wiFKWuCB+tudBA
GcfD99B7I0qPxI+tYyehHWMCxqsvMp/YJDqDV4YobRGuLp8buk/GtFSpQjXpcUY2
9lia1JpEi2Rr2UCvgyTu8BDEzMp3MPkaSwv77UrUiaolkeThXi71uFu1ictrnx2q
RoKon5gRTFWMzAOF7NFHnvDE7BQ6Xu3TZ1QufdNPPW8rpuQNxPt+4Lh6Mz+Mxv/s
jDNf6m0uoWiWp1uJDzpZxdmLOLtterr3ko8DUYhOwyfN0YuAEDhH4aq7IwPais1t
0+4woFaw12Bfi332grduBzhIotpPBg==
=40Mb
-----END PGP SIGNATURE-----

--A4HRck5EADJCIPV6--
