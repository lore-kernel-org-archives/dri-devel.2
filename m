Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787B4C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B609310EAFE;
	Tue, 18 Aug 2026 12:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hkjy9+XY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9963F10EAE8;
 Tue, 18 Aug 2026 12:25:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB690601DE;
 Tue, 18 Aug 2026 12:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19941F000E9;
 Tue, 18 Aug 2026 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787055950;
 bh=oSl6EIhXyBl5OB1rb4PPjwJI1HWPlb/7gnWzl/u9330=;
 h=Date:From:To:Cc:Subject;
 b=Hkjy9+XY6NWKmg2BNshiBe0pJ1hy878/Ry/5AnlqVHKer2B361eagW5JK5v4Zcbas
 adQBzv5JVz9xb9ES4IFEE5qbMkdp5SnFN127k1VGv9BJviwhpasJI6LHefOY9h18EJ
 tscAgcB7TjeehDC3v2lrxNyzhfWhCoBBvKderfDx4L0Fjg7baSx97/630spCiPD68V
 hGh04G7jOYddboqCD20BYmNT4dII1m31tgmjYt087ri1abKBR7IKlILtkHPNfUb5Ti
 xE0W+6d/HyAB7BzUUMofAIu4I6BVlOwLWkiZimEEZW9ZgGtvSUfHBmwYL7KSYZr/ku
 GmK9ETUmGFt2w==
Date: Tue, 18 Aug 2026 13:25:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Fixes tags need work in the drm-intel tree
Message-ID: <aoRPSlTUvPDlZCdy@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8M6BfoD15ssaWBU3"
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


--8M6BfoD15ssaWBU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In commit

  3b1f4d5e47b36 ("drm/amd/display: Fix dangling pointer in connector reset function")

Fixes tag

  Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_crtc and dm_crtc_state")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format='Fixes: %h ("%s")'

--8M6BfoD15ssaWBU3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqET0kACgkQJNaLcl1U
h9CqSQf/cUQPSWEG1xQ83SotvaTR9US+xfOy6ijhZt8D+ohEdOz8uS6e9KPTffaf
TbNBRHD8iPcQ03CK6hrxWDZFwk5jCo27T6cCXrIWjKb5YNBRWmigbfZe4cTZCOty
Pg5ItFcSl0zJoVpeMYFt3Tq1/uRt/ibkjCwBSoWHISBut+7TMeJGySgRB9ki5UC8
KoR4kghWYey1UbevZCjHLDk8jokgOpsoTxEHvXwjSa4B2tj98lHY/tMV6xtinWLV
dOGrRM6WlVt0JRuvxZ7axE0dJwgrGNbdELrDsPLKqBI+u+tYUSJ6+qr3CxBy4+6n
p2nwplF8kqOwekFUMnuazBam+BbLIQ==
=L6mP
-----END PGP SIGNATURE-----

--8M6BfoD15ssaWBU3--
