Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18E1CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135E910F25C;
	Wed, 30 Sep 2026 08:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cXNGNwnJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C1910F25C
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 08:48:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F8E1600D4;
 Wed, 30 Sep 2026 08:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847D11F000FF;
 Wed, 30 Sep 2026 08:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790758102;
 bh=Nc/aa8xu9LXaTHuQoPMpSRjwWnzlHbzUU58AxGBc5qE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cXNGNwnJ4MHkJ3gixunQ/me8qoYEvsG9yBcsn8Q6jiVcvNLnuV0cJi4ioqggBZ/dt
 KkSK5pZR691N2FhapUdpIMHqxIg754rAwM7CXxxTMqsV0vNb4y1Bb10eD+oqWWsk1G
 KPIxSv8epfvelTE5D8JpJqut0wLg+0BCNDk9IsY0kfLN6nlZETisev5YAr9adonG7R
 P17+yQrVBk1MPQvklceluBNqGoIS3qE/KQ0tBhL3me9B/027UXssN0oce0JwRX1MAz
 3Xfn/e7Q0NRb+XSPQajFmLE04DQ4Q7LB75L4VSYhGIsyiHVqo2S8XMcBoTmTqb3EhA
 GvbZkIs9R53lg==
Date: Wed, 30 Sep 2026 10:48:19 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 4/6] drm/tegra: Add support for 8-bit CPU interface
Message-ID: <arzMjoi2LcyfxCzN@orome>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-5-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sfxgfbu7erd5aek2"
Content-Disposition: inline
In-Reply-To: <20260930070535.47130-5-clamor95@gmail.com>
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


--sfxgfbu7erd5aek2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 4/6] drm/tegra: Add support for 8-bit CPU interface
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 10:05:33AM +0300, Svyatoslav Ryhel wrote:
> The display controller in Tegra20/30 SoCs features an 8-bit SPI interface
> that closely resembles the MIPI DBI Type B protocol and is referred to as
> '8-bit CPU'. Each display controller provides two such interfaces, which
> can be used to send MIPI DCS commands to initialize and control the panel
> while image data is transmitted via 16/18/24-line RGB.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/Kconfig      |   7 +
>  drivers/gpu/drm/tegra/Makefile     |   1 +
>  drivers/gpu/drm/tegra/cpu-bridge.c | 427 +++++++++++++++++++++++++++++
>  3 files changed, 435 insertions(+)
>  create mode 100644 drivers/gpu/drm/tegra/cpu-bridge.c

This doesn't need to be a separate driver. It should all live in dc.c.
Or maybe even rgb.c, since it uses pretty much the same pins and is
quite similar to it.

Thierry

--sfxgfbu7erd5aek2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq8zNMACgkQ3SOs138+
s6HbVxAAsIqUHzRlTa+PVebDe1OL+9I7ADlIyY5pCPTGU6SfwmWSxZUN5KFu89ib
ME3TcAl4GcovrXFa33iN1mBI25olvhIlTcJw3CuTjQvc8ecrARVFVRxrGWAgJ5Fj
eYDiQ3IaFV2NJNxTCuvD+LEhptA3a7MmKi4JbTEJjDOmvv9dRKD4Hzfas0jFAYD1
2+ZdSaN4GE0bFQWiWvtkoE3D7cpKeF/bGO9JqQhln8Z4l1fx57dLlB/uOhlUd3Xf
ANTvqGNJohRFNCt4A+f6AnXQfCy6Nh34cHS9FAjm+KW0S+Frgb7mPpYoHBLBrT5/
l/ZZsHihMppsTFAjG3lIctNN43TsaUjIbRmAR4rVp5qNO7uws3ymxDjdkz5VxorI
ShvmHKhkWZtvYWLEmVezuumKIs2xTfMY0dPPFrXjL8avDsq+Digw1kvYA+iUJwiv
CjAbcERB42YAEl0qomHHtoprHt1/iL2pIgnm3/HrsFNgillUgWkfLMLnPql8zYJd
k1bGc1YFRMO81RVu9X02fBb3fcRsM8RBlOGsKKCGXPRwygk31mghrQLbMWUvvRa4
PY2+ckm7gjmQGTd66dexU3p14Jxa4eFufRMT0dG5LPuOLS9qkZS7FY/XpIYvwG0o
vOqpeJLDU7lUqSm5s7dJsWJP0wDU9JLJCgN2jtQdEDIejgEITtc=
=4+YO
-----END PGP SIGNATURE-----

--sfxgfbu7erd5aek2--
