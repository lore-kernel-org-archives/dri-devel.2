Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FCCC79FAF
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F8310ECA6;
	Tue,  8 Sep 2026 15:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WPbAemoO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD7310ECA4;
 Tue,  8 Sep 2026 15:22:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12462601DB;
 Tue,  8 Sep 2026 15:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A021F00A3A;
 Tue,  8 Sep 2026 15:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788880951;
 bh=cHMBp6i7INBNLIc6sx2XBcLlbWaM9vvHRGdTgduCTYE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WPbAemoOa8A4rITV/C6EFYULS6YrhsmJV0nmbdSVox1ASEKctBaAF25WpPDsm8/WF
 BMhTevd1GC2jEu1gmQrUW5ArJZ3g20w7T5GRraXS2CgVAWWjQTzW4WUTEF/5Ekgi7F
 TfHymkLf4XcMDxrYW3wNhYoVx2fZHTte0dV6NlGf37d6rmMGGP7OqL8uRkiphtLM2I
 CMwZwjSiu+9Ru5O5sUhI35tdiZrXJZDFBe/59lPN64X/Gq418orK+V+OF7Uhe75oz9
 nHhs8xm0GPzqI2jOxAfC2xME42bZXAHyK4GLLFs3Zno9uM2nKdrluU9eJB7tdUyTOG
 LXTABEgO4T6uw==
Date: Tue, 8 Sep 2026 16:22:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>, Alex Huang <Alex.Huang2@amd.com>,
 Mario Limonciello <superm1@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <fba3bcaf-628e-46a2-9c81-c8beee5e5e07@sirena.org.uk>
References: <aqAVSgsypMch2c0v@sirena.org.uk>
 <5d3de44a-c382-4ce6-8f52-62696e67fcd0@sirena.org.uk>
 <CADnq5_MiNmzkDqZRk70_RmJaJWTEXFtu0c+eV3TJ_At=uvJ54Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tEWCGMc5H55jZNzj"
Content-Disposition: inline
In-Reply-To: <CADnq5_MiNmzkDqZRk70_RmJaJWTEXFtu0c+eV3TJ_At=uvJ54Q@mail.gmail.com>
X-Cookie: The world is not octal despite DEC.
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


--tEWCGMc5H55jZNzj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 11:15:36AM -0400, Alex Deucher wrote:
> On Tue, Sep 8, 2026 at 10:07=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:

> > > Caused by commit

> > >    65198b3d0738 (drm/amd/display: Use HDMI FreeSync range from common=
 EDID parser)

> > Sorry, that should be f65198b3d07389afdcb48e4ad00fea2aded95dfd.

> > > I have continued to use the version from next-20260831 instead.

> Fixed here:
> https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/730c6d8072d8d9a6d=
bfd06c7c5ab4479167a792a

Thanks for getting on top of this so quickly.  This also suggests that
there's some issues with the setup of your KUnit tests and those of drm
in general, kunit is run as part of the coverage for -next and didn't
trip up.  --alltests is enabled so everything coverable should be being
covered but I see a distinct lack of any DRM stuff getting run.

--tEWCGMc5H55jZNzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqgKDIACgkQJNaLcl1U
h9DM2Af/f0C7C3wM/y2X3P+8Jnhe6naxs8ZefQH9Pm1AMtKE2mBHDy/R5TjgwazT
Rvg35scV34k4ko7zkfZHdnHVgeZthGEzpSde2unAcMyScx/40fUiTvlbdnIdV+R+
EHohf59bUkGIlRfDPujG3UKQh8UI+l+D/3nQtJE7PMkzScjMz4BpCiMt15fZMJAj
WKXomzVtJ6ndTdb0YHUo/+JyO2sZFrXfZ3i8m8d6riz3yw8DUGujgb94v+jZ7LXw
U36CB7ufEv+fBf+QaUriPqs3+YgrUYwC5azOpshC2ZSmVcl6Sjzzl0gHdzvpv+B+
5w+TiujVd1NpQm8WTVdRFOmS2XvMAQ==
=aJXx
-----END PGP SIGNATURE-----

--tEWCGMc5H55jZNzj--
