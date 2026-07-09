Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6194BC44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B944410F59F;
	Thu,  9 Jul 2026 12:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bseccNL5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E8D210F59C;
 Thu,  9 Jul 2026 12:34:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7059600C3;
 Thu,  9 Jul 2026 12:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416DC1F000E9;
 Thu,  9 Jul 2026 12:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783600452;
 bh=PLcyfyRLh9N274iEIAU0fg4hnH+FVhFMtjqvfI8OHEc=;
 h=Date:From:To:Cc:Subject;
 b=bseccNL5IajMpaKml0Cf6JglRnD3jC+Q1AWQzLot0EA7gD7jKDk4l0haAHXGRfCIN
 BPPzP1WU4g7bjFNFd848ZgxKYl5C0c5zlvr++A6DIgcZCy+vBIaHBLHISEmr66opq6
 S8HfDiTkqzBXDer+bZWSySMNoSqFHy3lO1p4lmZ6f/yq+8OBqENDk4DvkCqQguS/zw
 EYNbQmr4+PCSEbcZl1/QKnNWnJDMrNDLQMrf7FYp3pVCu2+36cHodmVg0Ss9w9mDIJ
 O/XdRwlPHKSOQ8Xun6gbsx8Ot9dNBYtMWOy99Dj1J2xaADQoKhsnfmbc5DD40p84pU
 nrmmctDpz6aAA==
Date: Thu, 9 Jul 2026 13:34:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Fixes tags need work in the drm-misc tree
Message-ID: <ak-VQChNqm9ymtS6@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ySfZFTdHsc5H/OLM"
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


--ySfZFTdHsc5H/OLM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In commit

  0aeed866cb938 ("drm/amd/display: Fix dangling pointer in CRTC reset function")

Fixes tag

  Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_crtc and dm_crtc_state")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format='Fixes: %h ("%s")'

--ySfZFTdHsc5H/OLM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpPlUAACgkQJNaLcl1U
h9DuLwf/S7lHF1Sp6r6EGwnAz5Xpnr4wcgRT3e76kWqVLOglVplCjZsJPkBhbb4R
dEbXZM6pYa1ygK6Yefqr3W0sbTppN6l9e5q/a4fA+6PJoN5mFDHdXjyKCbBeZSsR
cyLjnZCT160raWAVLiSZpG6ETvdusRJehu0e4PEQ/qgORPLMRdZTUr2fkaGOz7xJ
WxxL7JX9El47q/uz88bvXzAD3iXJTbca+IpZ9COCyhe0cN2V6ojo90jyL/4xuwET
BEhlsCgKe4316jOWXAfaOjIFgXU9ns53YDdwPtrU/3vqmZghMT4M2LcbWJGeTPVS
KnADsQX5IgmW1NIINRqWZDuCIFN3og==
=glOm
-----END PGP SIGNATURE-----

--ySfZFTdHsc5H/OLM--
