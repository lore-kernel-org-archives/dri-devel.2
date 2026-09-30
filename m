Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7E9CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91E810E23F;
	Wed, 30 Sep 2026 08:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aM+UxX3N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE2210E23F
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 08:29:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 30E054122A;
 Wed, 30 Sep 2026 08:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F9E1F000FF;
 Wed, 30 Sep 2026 08:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790756946;
 bh=qJaKz00fj7KxDc0CGeVJJ+tvs/tiUbxN90/yhOIRNLk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aM+UxX3Nsf7rGPDSu7WqIGPpBgtIL9y6uXTb03PDTCRdL1BV2wsbPkB8Tc1POFQ+g
 51T0NbnqKsbXyjol17cNTjMIthKpV4QHOKhpLoAMArFhGyGy5U8z4q5OKamMF9zplv
 E64LdT4GbWj5U6JvejiVIWyyw456gmiHaiAslm2NUxPoGoBpj4iSdU0dJxl7IMy5ep
 R+ZkuSIPi6I199YwCzkYLnduUoJbHo9emYfYyZ0fgN7ZZ859P7AL89ULIXsPL3pPMb
 9IwqwlNUmF/A+OMOiTlnggN7wglFo9a0UAibUh8dYuTA/iOSxEcxqU4b8pfxd5EauH
 Y9vB6QTwHqddA==
Date: Wed, 30 Sep 2026 10:29:03 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: dsi: Unconditionally manage reset line
Message-ID: <arzDId4Mxryrfa7m@orome>
References: <20260930-dalmore-fixes-dsi-reset-v1-1-58c9d12f5ebd@nvidia.com>
 <ary71zC1e-bySLFW@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="44hvupbkmw3pca6w"
Content-Disposition: inline
In-Reply-To: <ary71zC1e-bySLFW@orome>
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


--44hvupbkmw3pca6w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/tegra: dsi: Unconditionally manage reset line
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 09:40:51AM +0200, Thierry Reding wrote:
> On Wed, Sep 30, 2026 at 01:54:55PM +0900, Mikko Perttunen wrote:
> > The DSI driver ignores the reset line if a power domain is configured.
> > This was originally added to support Tegra210, where the power domain
> > provider has to control the reset line -- at that time, older SoCs
> > didn't have a power domain for DSI. Now, however, they do with the core
> > power domain.
> >=20
> > This happens to work on most systems due to DSI already being out of
> > reset when booting the kernel, but on Tegra114 Dalmore, this is not the
> > case and causes the system to hang during boot.
> >=20
> > Ownership of the reset line is no longer a problem with reset
> > acquire/release semantics, so control the DSI reset unconditionally
> > from the DSI driver (possibly in addition to the power domain driver).
> > The device tree bindings already require the reset and it is present
> > on all platforms, so this is safe to do.
>=20
> That seems backwards to me. The whole point of doing this via power
> domains was because it's explicitly not safe to toggle that reset line
> outside of the powergate switching sequence.
>=20
> Also, the power domain code paths are supposed to work regardless of
> whether the DSI was already out of reset or not. If that's not working
> right now, I think that would qualify as a bug in the power domain code
> rather than the DSI driver.
>=20
> Shouldn't this be fixed at the powergate level? My recollection is that
> DSI is tightly coupled to the display powergates, though it's been a
> long time. Do we maybe need to reflect that in DT? There's a TODO in
> tegra114.dtsi that seems to indicate that we're missing DIS and DISB
> powergate implementations, so maybe that's where we should start to try
> and resolve this.

Looking at this a bit more, pd_core doesn't seem to make sense for DSI.
Basically what that does, semantically, is claim that there's a power
domain responsible for powering up and down the device, but in reality
it doesn't to squat.

Does the hang you observe go away if you remove the power-domains
property for DSI? pd_core should probably be removed for both display
controllers and HDMI as well. Probably also TSEC, though the TRM isn't
clear about what power partition that's in (probably DISB because it's
used primary for HDMI, which is in DISB as well).

Thierry

--44hvupbkmw3pca6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq8yEsACgkQ3SOs138+
s6GyMxAAp9uLoaTsunXUnAeKt9b5BUcYGzsEZkNCKAszdDlAbAhjVNZbve4gxwOE
4JXThjK9j1V73ttROhKen3ki47423XeHNL1bbmeM6tm2MrjO92e6u8zsGLg5xbkg
HNCX6b/AuxxjgsqpDsWSAniwmc4orAHfkuvPoeZdQ4TSBnfHHhbWnmnuybHZy1/K
aM++rdwn75/rabxQF3qqkjc/aR4lYlrRQSHs3VQJlmZrDlUfk4lNSk3y/1MPICuA
hMKVHIy1AdDmWL5Es4Ie1+XoCtMWTDAiiaZl7nVy5AYXRxNlurZTAPeA3hzMXlxr
zGVQ87xzWYUwP2nBOJVqqE7tto+G6pbW3xoyoKMsXA3+dxCgxNjT3BR+sA9BaXuH
Vu82yaviphSxjUpTbKPQXVbN4qHPxVIMQUBQBDCnYqqWtZpcOB5/4de2+m44iKyV
ACiE7ajMIUVZvNbj/HDQ6aEEsZGWVq+4xtNPGgO0jMFPpukogDH8HdTV2xDsXT50
W1lQXpfjPK3qiWZjRTLHLka5UdGp2LRMW8QG6HtIIr5lS41glxtf/pIPBaatnAvp
oA9g2XCxdsuGnjBZOM3SMyh0TCwwuCzjffXohxqDzuDCybyuiHrPnu6W57VUBsbY
/I1BIjJGVjxDppiEtY67U1yaimL0Ca/F1YOez/i6DrRXCIhI4mg=
=ItIw
-----END PGP SIGNATURE-----

--44hvupbkmw3pca6w--
