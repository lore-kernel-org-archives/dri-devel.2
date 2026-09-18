Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB28C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FEE10E51D;
	Fri, 18 Sep 2026 11:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RRCgdpXY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A68A110E8BA
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 11:14:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9BF760A80;
 Fri, 18 Sep 2026 11:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7971F000FF;
 Fri, 18 Sep 2026 11:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789730044;
 bh=KjJFsXZM286zFUj1yae5n7e3PNhdPVUj3C8Z8tDcazU=;
 h=Date:From:To:Cc:Subject;
 b=RRCgdpXYu2QpK21gH8A+0E82CVTWP0QBneCza3Z81FXVoLer0eDeDPhho5pVRb8nh
 2mK1EU3tGyR83+sIwU89NVEdiidGCVtL2q/9+I/+0E9pBjI7MdP3DYfQFzLzvKWBDe
 seTRD36TOhRh/9CyI3FuKL6mbZqJ7COG1Hc5j5VLbpIG1yZatle+sfXPAUW3ZrK2CX
 D4MTLi+6H6szneBsBK7cMk+4KOoHKtM/soSZYNPxa3XXf3iTCVvg98RP1Ev1VTM1jg
 y3yCDsDw+5ivPiPKiFfBJ/egSfE4d/c2k+xbBwDo2DL+vzSjesAnorC6nE+1ITNPK0
 3oKGFGKVhxoWA==
Date: Fri, 18 Sep 2026 12:14:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <aq0c-DBzXfUxY79u@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BlfRqiQYzSjxFV2l"
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


--BlfRqiQYzSjxFV2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c

between commit:

  63e19ef3ddab8 ("drm/amd/display: Atomize IRQ register read/modify/write o=
ps")

=66rom the drm-fixes tree and commit:

  63e19ef3ddab8 ("drm/amd/display: Atomize IRQ register read/modify/write o=
ps")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 74a8735168aaa,f997a50c1293e..0000000000000
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@@ -728,7 -713,12 +731,12 @@@ STATIC_IFN_KUNIT int amdgpu_dm_irq_hand
  			entry->src_id,
  			entry->src_data[0]);
 =20
+ 	if (!DAL_VALID_IRQ_SRC_NUM(src)) {
+ 		DRM_ERROR("DM_IRQ: invalid irq_source:%d!\n", src);
+ 		return 0;
+ 	}
+=20
 -	dc_interrupt_ack(adev->dm.dc, src);
 +	amdgpu_dm_irq_ack(adev, src);
 =20
  	/* Call high irq work immediately */
  	amdgpu_dm_irq_immediate_work(adev, src);

--BlfRqiQYzSjxFV2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqtHPcACgkQJNaLcl1U
h9BB1Qf9ESoLYk+wAEYMBi/xWYm/G+v7lp0LyTTX4BU6iGryeViG/QsfgBeepj2D
8BbF2vnsO85h9wHtkUKIaPUE6zYUSXH3v0ZTKcGAG1p1nxxrnJ4KO/gubB8Iw6JV
vKyw6QAgl8mbQ/6v2j9MjMrMDmepZNdIyNv2mvt/PKHs0iKKje1uZJhjQV5gZ7sF
HOV5gkBghFY7YQBe7oKUjBRJhT+RYFHkCN0H1eRHidD+4LKNY95XaJ+X2GiCnH1M
hoeFctTcdf/DOXLfr8v9DFtHWqOW7IaOSiYs+AGeXWQRRpbOSP1v/yFqqq53Kh9b
iK1mfHKbSFI1ASnUY4YTH8Kv3GaGfw==
=5UX0
-----END PGP SIGNATURE-----

--BlfRqiQYzSjxFV2l--
