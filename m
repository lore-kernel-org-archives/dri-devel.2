Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC4BCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F81410E1DD;
	Wed, 30 Sep 2026 10:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="URdDuFZY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE99D10E1DD
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:39:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 188A960239;
 Wed, 30 Sep 2026 10:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA581F000FF;
 Wed, 30 Sep 2026 10:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790764745;
 bh=tGFtMM2F77TT7uxlHemaNZrtS7chdzgDhP0DLWrj3QE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=URdDuFZYMOB0KJ3EHnp/XFnKkA5OJRrie0b8tMbQgLKw5iE7YrjBIy1pxZGUlsT4u
 WUMueqTDoUT9Nt+yCPXvfKOTBa4Cp+438AM3xfumhShyR92YPfaBtI6k1PRlaxhVpV
 Nt1DVku/cbQzVUeLtwuw/1Y1RP30LJc5Ztiu9+3q/vrZ+I3CM6bZt7D84cqrReSSD2
 zB8Gq5C9FelfYvXQ20pvn9UDb3BPuUWfyg26VMWYoKLDXwZwXGnyIBrUc+QCJNe6PF
 Af03FNTHASTt0NeOs1zYtKFlpw67ugJxCplASx32oK9FsguwRWb3j/yxG6zvQbYurN
 khqawdi0AZ1+w==
Date: Wed, 30 Sep 2026 12:39:03 +0200
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
Message-ID: <arzmMa0tlhhJ2n78@orome>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-5-clamor95@gmail.com>
 <arzMjoi2LcyfxCzN@orome>
 <CAPVz0n1WnhwOqz2xOp_0SsbgUFuYAf5YBByoMv_+XUDPANvhFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mb6amis5vjytdup7"
Content-Disposition: inline
In-Reply-To: <CAPVz0n1WnhwOqz2xOp_0SsbgUFuYAf5YBByoMv_+XUDPANvhFw@mail.gmail.com>
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


--mb6amis5vjytdup7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 4/6] drm/tegra: Add support for 8-bit CPU interface
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 12:02:14PM +0300, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 11:48 Th=
ierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Sep 30, 2026 at 10:05:33AM +0300, Svyatoslav Ryhel wrote:
> > > The display controller in Tegra20/30 SoCs features an 8-bit SPI inter=
face
> > > that closely resembles the MIPI DBI Type B protocol and is referred t=
o as
> > > '8-bit CPU'. Each display controller provides two such interfaces, wh=
ich
> > > can be used to send MIPI DCS commands to initialize and control the p=
anel
> > > while image data is transmitted via 16/18/24-line RGB.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/gpu/drm/tegra/Kconfig      |   7 +
> > >  drivers/gpu/drm/tegra/Makefile     |   1 +
> > >  drivers/gpu/drm/tegra/cpu-bridge.c | 427 +++++++++++++++++++++++++++=
++
> > >  3 files changed, 435 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/tegra/cpu-bridge.c
> >
> > This doesn't need to be a separate driver. It should all live in dc.c.
> > Or maybe even rgb.c, since it uses pretty much the same pins and is
> > quite similar to it.
> >
>=20
> I don't mind moving this to dc or rgb, my intention was to avoid
> bloating them with smth that is not used often and is present only on
> Tegra20 and Tegra30.

I don't think we've ever used rgb beyond Tegra30, so I wouldn't worry
about that. Even with this integrated into rgb.c, we'll end up with
around 1000 lines of code in that file, which is still quite manageable.

Thierry

--mb6amis5vjytdup7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq85scACgkQ3SOs138+
s6Gtuw/9FP+6Dk73iUJajgZE7NHK28W/1w8RCo3JUL+muKlehzTvBjzkctjLTRJF
KjIhpyINwgN1yc+C6m/MpIBh7f1bD6HSfDY2rF0E+CpRh4gvUdVOX8gbCtHjyTRO
zPZFGJaHjfJkICMU6mtRbdfQ/JEkMBR0b6GJo8Ws93bsnOXVSuhN8Xm9vO6GgQHA
agtkwliX9oUy4Un82PHCqhcLZrvK2tZ75pcdVwpxeGvTWwEzEutbTafBXXUcShjq
f3hSw22zFMsXdH4zSh+sw6+TY++ZcfgzipkTDh24AOn4tHd4bTBH7nT6mlo83Ge1
/TFxTz/+Isq/7IBmQOSe8UXppM7uh6JD2qiPyC2yrijaz89t+k1DSqrUhkBgbRPZ
MqVqPqACZRh22x3AlvfHVh3L3jVhTTdMwrQeCUVabzoMvoD2BXZCOtyKOYI6NcyK
VoAXqfhC8q/4BBkCK0DbgWJDwLpC2mmf2xOahvStsV9UUnAhJVOpnVRsB5+BICb+
akRnpzln4nePAjNWD1RmFvA4XAcR/ASnxqCchp8VLovXb6ViPmaTYIxDQ6ZvSkqz
p8gkqtHIGPWNEmaCmeOjBFAI5qeyQpf8JGyVxV6aGa6YaOPgMdi1L6psDMLadYKt
hwibuXj954+zq08AqId5nyBb+RIKDeO65IXEa0modmdB9eUaexQ=
=OKun
-----END PGP SIGNATURE-----

--mb6amis5vjytdup7--
