Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B018C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AD510E4C6;
	Tue,  7 Jul 2026 11:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="edf/xvcN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73AFD10E4C6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 11:53:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1A2C6001D;
 Tue,  7 Jul 2026 11:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BE71F000E9;
 Tue,  7 Jul 2026 11:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783425194;
 bh=yLcmIYemCf1cRnUBNk4D8OZmmCanpB2R86aKBoTFfVc=;
 h=Date:From:To:Cc:Subject;
 b=edf/xvcNnTHb3/588lLCmKDUNmaz69s8rR8MswY/ZbH4zrMT4p76t+XKe3oIMfkVt
 i0EVXnxf4o6cnIzjU/qKRboXCwP9Rr6YYYyoPY3N1epzxT2QMP80258lPIRwkGB4PJ
 TqbSqxHCQ6cakjf3Ol5dxUG5Zvtw2D0hCM+1hFbrXCrUKMiJY6mYw/+cVDXZ3+9Lqj
 r6nK0GpyBVvcglB/BDNPLX/m1OSrQwK4gpzm3Sg1wldNKTcFMiF74Zmfy7cHmXsKia
 060boH46dLb2q/ZMSZLs7Ht2V4jP7zDm6DU/8ACbtom2CChisSvZ2J5/vhsNkXPmEb
 9voMoTGrsPH5w==
Date: Tue, 7 Jul 2026 12:53:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Fixes tags need work in the drm tree
Message-ID: <akzopmDBFY9Epm0V@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L5m3sJ6SNK/ieKlv"
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


--L5m3sJ6SNK/ieKlv
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

--L5m3sJ6SNK/ieKlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpM6KYACgkQJNaLcl1U
h9DhxQf/S9yn4pNhWSzSiGlV4R4L+5muw88eeqdSCVppC9tPpdeLq+b7T8oqhvc+
q9etySMgOAqStNrieQ1l+5yxydgExvv0+CqePT7i4zUm3QZwCTy6fj7fe3V4ruTX
9QXmZsgINPRQkOSj8HXB0n2/d+SOup8wFjsq/NSQ6BDbHptYJjcwVzQHbabbChEH
KFue+GEWzOOxj7gbF/EKOQtPH6x27L9wuyEZym5mPluC1yn8sZJcvPnp1Fc19tVi
5zDDhnTVSs3IP85iriu3qqWNiLjxTgiVzkd7h1UqJv8EEr9Vv0zT9BwToh4FRQSF
vE2BJJD6UCLZGKs8BY9UFtFZvSRYTg==
=KiEM
-----END PGP SIGNATURE-----

--L5m3sJ6SNK/ieKlv--
