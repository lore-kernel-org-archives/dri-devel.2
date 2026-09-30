Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A00ACA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8383F10E9F2;
	Wed, 30 Sep 2026 11:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NkJCUKXq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 981B310E9F2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:41:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C11FC60008;
 Wed, 30 Sep 2026 11:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B9D1F000FF;
 Wed, 30 Sep 2026 11:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790768474;
 bh=0uhaapHh1fQl5mGq6fUQF0C1kT9MNPfYwDQo75yZQyo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NkJCUKXq/aO1S6/xTKpuIdo9dBO93tuXErXptUkEc+qiDt09wkTKPbGX0bSLT8wsu
 kQTDAFRh53cfcRYpGgL3CsY9zrgSKpmcc+nKt7Eo5+5tJ/VFWfBMbj5h9VCBG1wBDy
 1uWSkLkycTrHPx6cuax16vYym4kRSmn/RCk8fSSPO1B2kTnVBcbfB0v2N1oUr1aSOt
 bCOPcTddnG+93WZtvpK0fjR7AUvIm2XviZ0ypVMPPy2CRbt0ZFKyN1fLPytuWhmHdD
 mcfvwiT+u+3QPb+ylJcPxOYCjgFv+idSPvV5b63Py++Nbe53LRf2JGAQ8vwidcCNad
 6zOKlM5q/FKsA==
Date: Wed, 30 Sep 2026 13:41:12 +0200
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
Message-ID: <arz1BYJT30VTosYj@orome>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <arzMF0wjcF_SVxpE@orome>
 <CAPVz0n3Oc4ocUWrtGgd-MdrdJ3SgDEi8onOkXi92o7hAn3y0Ww@mail.gmail.com>
 <arzlR8mCg9d_z62L@orome>
 <CAPVz0n0jnitNemUyhi9C2SgbRbJA9CinY1DrR-r7gnN=CaYGiQ@mail.gmail.com>
 <arzpluDc-Ib7q-K7@orome>
 <CAPVz0n0sQo-6xKOGzd3LsJzzAr7_TficW4KeU320Z-tcRUne9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r2niuoni5te5qsug"
Content-Disposition: inline
In-Reply-To: <CAPVz0n0sQo-6xKOGzd3LsJzzAr7_TficW4KeU320Z-tcRUne9w@mail.gmail.com>
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


--r2niuoni5te5qsug
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 02:10:15PM +0300, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:54 Th=
ierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Sep 30, 2026 at 01:42:17PM +0300, Svyatoslav Ryhel wrote:
> > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:3=
4 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Wed, Sep 30, 2026 at 12:00:21PM +0300, Svyatoslav Ryhel wrote:
> > > > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE =
11:47 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > >
> > > > > > On Wed, Sep 30, 2026 at 10:05:32AM +0300, Svyatoslav Ryhel wrot=
e:
> > > > > > > Document 8-bit CPU parallel MIPI DBI Type B interface provide=
d by
> > > > > > > Tegra20/30 SoCs display controller.
> > > > > > >
> > > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > > ---
> > > > > > >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++=
++++++++++
> > > > > > >  1 file changed, 138 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/display=
/tegra/nvidia,tegra-8bit-cpu.yaml
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/display/tegra/=
nvidia,tegra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegr=
a/nvidia,tegra-8bit-cpu.yaml
> > > > > > > new file mode 100644
> > > > > > > index 0000000000000..f0dab608b2936
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,=
tegra-8bit-cpu.yaml
> > > > > > > @@ -0,0 +1,138 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegr=
a-8bit-cpu.yaml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > > +
> > > > > > > +description: The display controller in Tegra20/30 SoCs featu=
res an
> > > > > > > +  8-bit SPI interface that closely resembles the MIPI DBI Ty=
pe B
> > > > > > > +  protocol and is referred to as '8-bit CPU'. Each display c=
ontroller
> > > > > > > +  provides two such interfaces, which can be used to send MI=
PI DCS
> > > > > > > +  commands to initialize and control the panel while image d=
ata is
> > > > > > > +  transmitted via 16/18/24-line RGB.
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    const: nvidia,tegra-8bit-cpu
> > > > > >
> > > > > > The description says that this is a feature of the display cont=
roller,
> > > > > > so adding a new binding and compatible string for this is not t=
he right
> > > > > > move. This is all covered by the "nvidia,tegra{20,30}-dc" alrea=
dy, just
> > > > > > need to extend that with whatever is new.
> > > > > >
> > > > >
> > > > > How would you model it? I have tried to model 8bit-cpu as a bridg=
e, similar
> > > > > to how DSI bridges are modeled. This reflects interface used to l=
ink RGB and
> > > > > panel, without inflating existing DC binding. If you have any ide=
as in modelling
> > > > > this, I am open to any suggestions.
> > > >
> > > > My suggestion is to integrate this into the existing "rgb" node, or=
, if
> > >
> > > Not an option since it is not clean RGB and there will be no way to
> > > distinguish RGB from 8bit-CPU.
> > >
> > > > that becomes too convoluted, a separate "lcd" node (or "dbi", whate=
ver).
> > >
> > > This is fine by me but nesting nodes without compatible feels weird. =
Oh well.
> > >
> > > dc {
> > >   compatible =3D "...";
> > >   rgb {
> > >     dbi {
> > >       ...
> > >     };
> > >   };
> > > };
> >
> > That's one option, but there's also many other ways you could
> > differentiate between RGB and DBI. Could be a simple "nvidia,interface"
> > property in the "rgb" node (that defaults to RGB if absent). It could
> > also be a node that is a sibling to "rgb" (rather than a child). Or the
> > child could work, too.
> >
> > Ultimately we're still describing aspects of the display controller here
> > since this is all registers within the display controller's MMIO region.
> > Nested nodes are purely for adding some logical structure for the
> > description that makes sense.
> >
>=20
> From my understanding data is sent basically as RGB, at least RGB
> configuration is still used in downstream. Panel commands are sent via
> DBI
>=20
> dc {
>    compatible =3D "...";
>=20
>    rgb {
>     port...
>    };
>=20
>    dbi {
>       ...
>    };
> };
>=20
> This would work nicely if DBI is modeled using bridge framework. I
> would strongly insist on keeping it as a stand-alone configuration
> separated from RGB and DC.

Okay, maybe give that a try then. But to clarify: this should all be
part of the Tegra DC driver and not need an extra compatible string or
separate driver. The DC itself should be able to function as a bridge.

Thierry

--r2niuoni5te5qsug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq89VcACgkQ3SOs138+
s6EHqQ//aYNTxuvXxI0k+05f8CFxJmke7aO8O+/XJmRJ/lLP9FC9z4B1y+S6Vu8v
L3FZzMSQlcyWBJtj9s1kQ+qCcgGQr2XSphLpjKTruz6udXibHzijktJIihwE2Rz3
XhQ/ryWzGFNkTnolHGJJdbowPZWXv+yF3RlghicR2L6zQhkGlTwKKLPFPscSUhLa
s6cvlP3xSV58K5tVCzaBk8i/ItaK91Z7oPpysDP0xRbSNFsGtNwT71kL+b/p6JPi
yqIKFsArZyCGzcm/r19mOyx00MDJpBttPjdM3w5ylL6pnaHYZ4dTkl6f/jUrKEOi
5poQ3w6fmjGTA4IkvtuVSY0UzMfQBrKeLOYZqTuIYEfanUqAVblo78Q0QLGZcn7e
DUTVjuzaKmYwfdgL0VfDMrNEHRX4Elq+1Wu9tphO1AsRLz0qcXjfcb8PpOWLgAa4
17GBOuFWkki3N0pGkP0s/4cuyDKso2E92wLqPL1Pzgq0KJcsYDQhzcDEYsRg6uBo
XzGpTZ/pOjtt6i9Dsb0NAOujaZdMeYQqyYqcwHZ+etOS0zqyHVplXvT0TBqzCw0Z
ArytEAf+kXPX4yUgDdEnqkxDukSjjiudNMy1Xzzqn3L0bZLfwe1GyuBLkgugRLUG
e+lk3rwrxcxs7dp9FKHQsZszLU9oX0nsyYaU0YJY5Aq0QPjrt8Y=
=hL8m
-----END PGP SIGNATURE-----

--r2niuoni5te5qsug--
