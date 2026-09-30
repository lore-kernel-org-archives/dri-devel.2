Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4ECCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 879C610E264;
	Wed, 30 Sep 2026 10:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DV5xoG3u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF8F10E264
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:54:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24DAE438E1;
 Wed, 30 Sep 2026 10:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772E11F000FF;
 Wed, 30 Sep 2026 10:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790765646;
 bh=b/tTKEB9F9drQd7lTWMiq1qfDMeBxT+4Vrb1FMn6SAU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DV5xoG3u7wyOQkORycbYji3v1zGRmdq5arYnHNyQOdjuPjRrKJdDFFi3LZHMtanXl
 B8ATxBuOTdZbWG1JfxYAO4fB4qVQk7YUI+qqjgqiNvIzI9xhpdlu+ajSxmlrDKCuHx
 OnuKc5pyxCFlYMoabDqnJfRn3QROjnXqVXMRDOROSRFDzXW444lO/ii7058yk9Qd2I
 aTmW3ku1S8WSl1pWM/WQfPS0j0Ss3JFt68Yd2JSi5uNqeLKuaDhOyaNDbMS8LjiSZK
 Z675mSqG3thaLzkrkPT7KrQFCmlVJ/qod4UBEZhhXYmfkXpiP9c3ou+4dEIR5UNHI9
 QsvV4ak84VJcg==
Date: Wed, 30 Sep 2026 12:54:03 +0200
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
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Message-ID: <arzpluDc-Ib7q-K7@orome>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <arzMF0wjcF_SVxpE@orome>
 <CAPVz0n3Oc4ocUWrtGgd-MdrdJ3SgDEi8onOkXi92o7hAn3y0Ww@mail.gmail.com>
 <arzlR8mCg9d_z62L@orome>
 <CAPVz0n0jnitNemUyhi9C2SgbRbJA9CinY1DrR-r7gnN=CaYGiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7buzhekiunqesz3w"
Content-Disposition: inline
In-Reply-To: <CAPVz0n0jnitNemUyhi9C2SgbRbJA9CinY1DrR-r7gnN=CaYGiQ@mail.gmail.com>
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


--7buzhekiunqesz3w
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 01:42:17PM +0300, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:34 Th=
ierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Sep 30, 2026 at 12:00:21PM +0300, Svyatoslav Ryhel wrote:
> > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 11:4=
7 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Wed, Sep 30, 2026 at 10:05:32AM +0300, Svyatoslav Ryhel wrote:
> > > > > Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> > > > > Tegra20/30 SoCs display controller.
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++=
++++++
> > > > >  1 file changed, 138 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/display/teg=
ra/nvidia,tegra-8bit-cpu.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/display/tegra/nvid=
ia,tegra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/nv=
idia,tegra-8bit-cpu.yaml
> > > > > new file mode 100644
> > > > > index 0000000000000..f0dab608b2936
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegr=
a-8bit-cpu.yaml
> > > > > @@ -0,0 +1,138 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-8b=
it-cpu.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > > > > +
> > > > > +maintainers:
> > > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > +
> > > > > +description: The display controller in Tegra20/30 SoCs features =
an
> > > > > +  8-bit SPI interface that closely resembles the MIPI DBI Type B
> > > > > +  protocol and is referred to as '8-bit CPU'. Each display contr=
oller
> > > > > +  provides two such interfaces, which can be used to send MIPI D=
CS
> > > > > +  commands to initialize and control the panel while image data =
is
> > > > > +  transmitted via 16/18/24-line RGB.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: nvidia,tegra-8bit-cpu
> > > >
> > > > The description says that this is a feature of the display controll=
er,
> > > > so adding a new binding and compatible string for this is not the r=
ight
> > > > move. This is all covered by the "nvidia,tegra{20,30}-dc" already, =
just
> > > > need to extend that with whatever is new.
> > > >
> > >
> > > How would you model it? I have tried to model 8bit-cpu as a bridge, s=
imilar
> > > to how DSI bridges are modeled. This reflects interface used to link =
RGB and
> > > panel, without inflating existing DC binding. If you have any ideas i=
n modelling
> > > this, I am open to any suggestions.
> >
> > My suggestion is to integrate this into the existing "rgb" node, or, if
>=20
> Not an option since it is not clean RGB and there will be no way to
> distinguish RGB from 8bit-CPU.
>=20
> > that becomes too convoluted, a separate "lcd" node (or "dbi", whatever).
>=20
> This is fine by me but nesting nodes without compatible feels weird. Oh w=
ell.
>=20
> dc {
>   compatible =3D "...";
>   rgb {
>     dbi {
>       ...
>     };
>   };
> };

That's one option, but there's also many other ways you could
differentiate between RGB and DBI. Could be a simple "nvidia,interface"
property in the "rgb" node (that defaults to RGB if absent). It could
also be a node that is a sibling to "rgb" (rather than a child). Or the
child could work, too.

Ultimately we're still describing aspects of the display controller here
since this is all registers within the display controller's MMIO region.
Nested nodes are purely for adding some logical structure for the
description that makes sense.

Thierry

--7buzhekiunqesz3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq86ksACgkQ3SOs138+
s6EA4A//aCwhfubUYs9RW/ktXNhuED8p72eaUusrTXMTaZWSWiJS8MRRQzQVadmi
N4MknAE+IhEAk44c8kBSKx2oIx16xPstVaxKtBrFFI3LqvDpSbB+IldCrIHUcPXS
jKFXrNkEOnJxk1/zijMWdfp8nO7U80V59ML2e9BVmGD3Yl5WNNb5Ik10rEpStq2F
bgTqMjVvpKissqVMKB9TAARVarKA9so/JmkMMzTimDb+cp6y2TT72RWyAgNykIe6
+ipXHdYDNCJR3JTu9uJeFMZbFfVQczsBVnr2tliKK01r3CKzHAaXNW/H8YxgbmOf
pPOvdp1i8csJcTA167hFAa/goioZ3wJpFB93HlNWG1qjMTEzctyDtlQ3k6DQ7G6n
6n4TiXcANPn3FoETJEVLcE1SUSn516Vcd2dzckmaPs3BicxORELtSeyAe+JfTyYs
rgDoPHk5KPaB4G/We1MPmolVMtE53bjagDUM9Cmtw/VX2VKryGJ7dN4JUuNlS3nQ
CgdKqwAMrRFib3wN9OHLO3wmwtfwrOFeW2cTotWaebleeIhomP7VTsBdVVs/ewsu
mZqVw5o412s3SURVlwXj1PhK1Wa4C2FCG5qR8nqJQuh7sHgIEZ3H31scwowU82Ey
NYXExuHw80mtf1S68pTyZ6JDAuR1ZfMRGvjkaUxHfFkogOIorCY=
=L/k0
-----END PGP SIGNATURE-----

--7buzhekiunqesz3w--
