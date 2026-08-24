Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342C9C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709E010E10B;
	Mon, 24 Aug 2026 11:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VvrsdGE7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7862510E10B
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:00:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 884EF60120;
 Mon, 24 Aug 2026 11:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2CB1F00A3A;
 Mon, 24 Aug 2026 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787569226;
 bh=Aa4UCu0OaLUfyKzzk/a3SXI2I00XUDYQC6iX8Ye8QRw=;
 h=Date:From:To:Cc:Subject;
 b=VvrsdGE7jXOUBU/a65qiIizK1QIBcnfOwMpDwblmUOI/S21HiZxib4VsJWn1Irq97
 b0Z7aYR55rJYu5f9mf5WFAKqAL1SSBFG8bFfzuIWvRCHV+Y3nOVawiuFXg/C6aeugA
 pA8eZ3tgd9+MIOUNqjyurk5UmTm8zI2+agKbNVo7dGXnV7MHuZ0ltQhEHeggdpisnG
 BBBX31hEkgwDnT9BWIyJQ4YantxdvdY7hrXuABisETiyefx5oPI1vKSeyQToAsNYQs
 VT+z9Zvr7P2y6Lh/YEjiVqQF8HiubPoVUoACG4V1YJeATqoj7d18wtZtCQb+MzI3aj
 VSztI471N2Nzw==
Date: Mon, 24 Aug 2026 12:00:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Fixes tags need work in the drm tree
Message-ID: <aowkRsjyOWW4D-ta@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F8EZANPlbTFCez3V"
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


--F8EZANPlbTFCez3V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In commit

  6cd33b6f4155e ("drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value")

Fixes tag

  Fixes: 6b16f05aa39f ("drm/msm/dsi: Split clk rate setting and enable")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format='Fixes: %h ("%s")'

--F8EZANPlbTFCez3V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqMJEUACgkQJNaLcl1U
h9AbMAf/d2KMzHdlADK5mZTVI6hhm8NzUYKeeOVqWblVGjbCV3ZUl+of8Kz0NmK7
ldPF6kw902W0+CYIhQmjm4gXFR/Kh8voVdy4cV3tjJO9vfLDY4Rw3NKsQfEO1f9X
cnPSrNUjKxdRi/XlZQRKi1b9NHo+DcNDvH+Tj947VQ7QFt43llLdoC3CWJhJq/50
9f/jb6pBi21mxS3wvRc+UxqJC1OvcYdxQNs1sgxZv7A8KJ4omlwqmCux7aUJEJT7
dd8EdrWKyCFt11ixz2NHzDSFDlHJhbn1CKZI1mg+yBn5X5b48VndaPCmMGSCFQIW
PO+KhfgO2BEz3jVEbUZwPUFcopkU/w==
=LF65
-----END PGP SIGNATURE-----

--F8EZANPlbTFCez3V--
