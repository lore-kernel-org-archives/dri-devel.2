Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D5FCD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 22:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21D8112569;
	Fri, 29 May 2026 22:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jq/hnTMz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFB3112569
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 22:00:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D9FE5605E2;
 Fri, 29 May 2026 22:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2A21F00898;
 Fri, 29 May 2026 22:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780092036;
 bh=+42eiyHA15Orwbnpyv4/0KMsTUq8tUbuOuwO5RtK91o=;
 h=Date:From:To:Cc:Subject;
 b=Jq/hnTMz5sfTxuD/PbMddYfxO9jw/vBbjYSfP5KTO88LhAg2r7Ajrf0iRfuSz0NWY
 1zaq2JZZhEVojGnvQXFYM423L2mNZk/QCTYXmB5ykB/4BN2Tp8jugwNHgDojEyWwUY
 1YC/ihnWhLUj2CkvijOb2yvbTM+1fWBwq7Bs+ksfZCbh0naQGYuXhEGRb5Vr+pB1jn
 tWTRtHHxuGOsOmS4tdIf2qAkNBcujf3ZQERlYdD4LgcFUcM2wA7B6twNh3iZ7tv442
 Pmnx3d7Z1h1ByI87Xs+TKC1DqYeUcTUEfKVaRkPRZbWBxHucR1FHLUyufSoHuV+C84
 sSROAlAVv2nmQ==
Date: Fri, 29 May 2026 23:00:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <ahoMgAKQjN8AaJfg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u2azjrDFmhE+oAsu"
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


--u2azjrDFmhE+oAsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c

between commit:

  1c824497d8acd ("drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_inv=
alidate_gfx")

=66rom the drm-fixes tree and commit:

  4cdbba5a16aaf ("drm/amdgpu: restructure VM state machine v4")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c9f88ecce1a75,a99d01f9dc750..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@@ -1629,9 -1598,8 +1598,9 @@@ int amdgpu_vm_handle_moved(struct amdgp
  			   struct amdgpu_vm *vm,
  			   struct ww_acquire_ctx *ticket)
  {
- 	struct amdgpu_bo_va *bo_va;
+ 	struct amdgpu_bo_va *bo_va, *tmp;
  	struct dma_resv *resv;
 +	struct amdgpu_bo *bo;
  	bool clear, unlock;
  	int r;
 =20
@@@ -1645,19 -1609,17 +1610,18 @@@
  		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
  		if (r)
  			return r;
- 		spin_lock(&vm->status_lock);
  	}
 =20
- 	while (!list_empty(&vm->invalidated)) {
- 		bo_va =3D list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
- 					 base.vm_status);
- 		bo =3D bo_va->base.bo;
- 		resv =3D bo->tbo.base.resv;
- 		spin_unlock(&vm->status_lock);
+ 	spin_lock(&vm->individual_lock);
+ 	while (!list_empty(&vm->individual.moved)) {
+ 		bo_va =3D list_first_entry(&vm->individual.moved,
+ 					 typeof(*bo_va), base.vm_status);
+ 		resv =3D bo_va->base.bo->tbo.base.resv;
+ 		spin_unlock(&vm->individual_lock);
 =20
  		/* Try to reserve the BO to avoid clearing its ptes */
 -		if (!adev->debug_vm && dma_resv_trylock(resv)) {
 +		if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) &&
 +		    dma_resv_trylock(resv)) {
  			clear =3D false;
  			unlock =3D true;
  		/* The caller is already holding the reservation lock */

--u2azjrDFmhE+oAsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoaDIAACgkQJNaLcl1U
h9Db6gf/QhCEpJ8H503F+3q2ysApQ+nxQdrykW/+OlSEWBTs1fLOHziSsW2OO+71
BwVTgUtJ7gjWRcmF0x6uZA7BRe5TaouzQoktd6i8wXytRYfiTcII/CK2ILcT3jBs
zDEX4e+Lz40X9OJgGyhIG+FoEYTYhariLb4g5F+8NHB4Qo/PpKtW4MmPk3FnISat
+HTo+WwqYLULQC8jB/SMr4mE7pzq4SvTXbIEnOzIvF5i6DHF2Dwaw+yErCM8OJf+
8UD9+TFEinIWiN8zL83SnNhMPqPN6GVWA0ud2r+cCMFbKoDZEjy+h+xfg+BJk2Cq
Wsky7Foc3C1dNj7jcefd4k9u7UOXyg==
=iNeF
-----END PGP SIGNATURE-----

--u2azjrDFmhE+oAsu--
