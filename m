Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68BBCD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B6C10FE47;
	Wed,  3 Jun 2026 13:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QqOhpWlY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DCC010FE45
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 13:32:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B22042DC6;
 Wed,  3 Jun 2026 13:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB821F00893;
 Wed,  3 Jun 2026 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780493539;
 bh=p1I17FRuv8bEhkHHCjKfI0Jt9CtnZoVqsBa3f0uKCVQ=;
 h=Date:From:To:Cc:Subject;
 b=QqOhpWlYAlE04AdGpaClK32I5Nj5jXzcgRxCml41uRxetF5eLY6d0ZvGV3UMg7HT7
 JUrpWXV6vVM1dyXpkoAaf9K5PDYcU9nimHfsdUugdq3Z5QmphamG9QmqmYtVG4rgdF
 AVS5hiII0TbB6pY9Lks/cRV0ShLoKXwKb7r256YpvC/JOqfBW6eIcwHFDaefFgPwNK
 OKlrw0cIuiROmSWjm/PBlx72qmAmdXTTjhTL6STbOA6srs9zVsAyIKGNhlNFfWXGU1
 cbLhtavpCJMDK/wE7nM8bWalrlo8rrFzu/zdfZ9td0sMm0LwAi9aenSovE0dJl1oOq
 zpk2pB1Yf/kXA==
Date: Wed, 3 Jun 2026 14:32:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm tree
Message-ID: <aiAs4By9Po-Y0K_N@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XEbAZGp9b5ALXzO/"
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


--XEbAZGp9b5ALXzO/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

/tmp/next/build/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1623:52: error: vari=
able 'bo' is uninitialized when used here [-Werror,-Wuninitialized]
 1623 |                 if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo=
->tbo.ttm) &&
      |                                                                  ^~
/tmp/next/build/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1603:22: note: initi=
alize the variable 'bo' to silence this warning
 1603 |         struct amdgpu_bo *bo;
      |                             ^
      |                              =3D NULL


Caused by the combination of

  1c824497d8acd ("drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_inv=
alidate_gfx")

=66rom the drm-fixes tree and commit:

  4cdbba5a16aaf ("drm/amdgpu: restructure VM state machine v4")

=66rom the drm tree.  I cherry picked the fix

  b6444d1bcbc34 (drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_inva=
lidate_gfx)

=66rom the amdgpu tree.

--XEbAZGp9b5ALXzO/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmogLN8ACgkQJNaLcl1U
h9BdKgf/WzQ+tZi8MeBlHogo0s+WA3Q1JUBxG4UBIqdHb7/Qx+DQykgpNoRwiGRR
whKREC99OQryVP2U2qCxNIBWoaIJC+zJmiHxrLNQxul/OGZXqWePuLXx3ByeUCJZ
lj0UWjanovcgigTbK1sVZojOPsPEkr/p16diu+ivM+U0niRJrciT/6OjeCajVLTE
UqANfQ1ki0urxhy76uliF+iBISa9rX3NjgEJT1f/gTVuOMbi1SKKAvv3U8V9ZmTU
AwZQyq3i2MA5/YiUT6eVEzkuNLI48zHOJL25rAD7X7hRW4Lea+uNnXTs+HDlpQIJ
xaW7wo3+CsgthvTS3zL7R/qXYJU3Lg==
=Ug0O
-----END PGP SIGNATURE-----

--XEbAZGp9b5ALXzO/--
