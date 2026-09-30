Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A173CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8308B10E18D;
	Wed, 30 Sep 2026 10:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nLFelxOT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFF810E18D
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:34:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD59C60239;
 Wed, 30 Sep 2026 10:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAEC1F008A1;
 Wed, 30 Sep 2026 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790764445;
 bh=wdtdcWDvIX3RhUgrcDsVcvdnSRLIn02KRn8evUdU690=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nLFelxOTnK5+4PmA3eQcRLkA5rLE3e5PcOCSBzAlgsE8zjuww7gr7DQhD9o2BuCGK
 3hYt3adxfH4KCIgG/Wh8Z4YFoGfQaIQ/+wslJg2J8VOnMsOios7ZQVLGsiW5FTEzXz
 rqgnlpfoU7rZBeyHU0SyB5929t87Deuua8qTkbVg5OiMNG/y2IH9aVcwXtQIlxxWjJ
 lsG4V4v1+QfvEURoJpkNwgvug0WFZcFmJhzv/C6trPT7sljjJEQ6/ZPqzaZSOlbimT
 ixqqsPlfCpX7iz3lxxgpaluHXQJ/dkLsMcZEebVrfAATKWHHhpg9K9eZQNWI3Qukdx
 pOFdKVQ4e1Egw==
Date: Wed, 30 Sep 2026 12:34:03 +0200
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
Message-ID: <arzlR8mCg9d_z62L@orome>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <arzMF0wjcF_SVxpE@orome>
 <CAPVz0n3Oc4ocUWrtGgd-MdrdJ3SgDEi8onOkXi92o7hAn3y0Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5qqv5e64sjmxmngg"
Content-Disposition: inline
In-Reply-To: <CAPVz0n3Oc4ocUWrtGgd-MdrdJ3SgDEi8onOkXi92o7hAn3y0Ww@mail.gmail.com>
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


--5qqv5e64sjmxmngg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 12:00:21PM +0300, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 11:47 Th=
ierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Sep 30, 2026 at 10:05:32AM +0300, Svyatoslav Ryhel wrote:
> > > Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> > > Tegra20/30 SoCs display controller.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++++++=
++
> > >  1 file changed, 138 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/tegra/n=
vidia,tegra-8bit-cpu.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,t=
egra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia=
,tegra-8bit-cpu.yaml
> > > new file mode 100644
> > > index 0000000000000..f0dab608b2936
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8b=
it-cpu.yaml
> > > @@ -0,0 +1,138 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-8bit-c=
pu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +description: The display controller in Tegra20/30 SoCs features an
> > > +  8-bit SPI interface that closely resembles the MIPI DBI Type B
> > > +  protocol and is referred to as '8-bit CPU'. Each display controller
> > > +  provides two such interfaces, which can be used to send MIPI DCS
> > > +  commands to initialize and control the panel while image data is
> > > +  transmitted via 16/18/24-line RGB.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: nvidia,tegra-8bit-cpu
> >
> > The description says that this is a feature of the display controller,
> > so adding a new binding and compatible string for this is not the right
> > move. This is all covered by the "nvidia,tegra{20,30}-dc" already, just
> > need to extend that with whatever is new.
> >
>=20
> How would you model it? I have tried to model 8bit-cpu as a bridge, simil=
ar
> to how DSI bridges are modeled. This reflects interface used to link RGB =
and
> panel, without inflating existing DC binding. If you have any ideas in mo=
delling
> this, I am open to any suggestions.

My suggestion is to integrate this into the existing "rgb" node, or, if
that becomes too convoluted, a separate "lcd" node (or "dbi", whatever).

Thierry

--5qqv5e64sjmxmngg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq85ZsACgkQ3SOs138+
s6E7XBAAuKQS8yR2SKtcJ9URq8iBstKVNV6cBYIfMkUMoznqJ8AofgjCNOXarHhT
OHOBwd+Uzir7Fq8eoqvuUuDqAi8imORaQ7KH4PWcrR+a/xEb3zQ8KW8DiRGyCEfp
QwnM2x7thvTxOA1OBDtqw1Y9rSAaaPmNj5jkTOekoU/zzWjJ9VoGqhb7T5S5BaYI
8xmQ12nMe6j4Y90n/hYwDwNAqt5ANugLi9jlJWA+vq3IgnezDXgYQyWklLHxwVPW
13smeQCeDVXhCa5jUSUyA6ZkEOhg3zX1DTLn8+1eUm0kMtEbaIjkz5gV2Hsw4VkO
RV94lLXCh069LMmcECHWhuhY4iReXyKZcRwoTy7gstWMzPyiXLmh4gfd/q/SSffm
RbBfr9gUkLfHHy6NsiFts6pyPPn7Zu3rJs0aSCKineH789EWeivIRqXgajUosk5r
h10A43EXwPMxCjM7DXOnHVbS+bIakm5eD+1gx6W4r/manLqyGv7kBHD8AJv7OVM4
iMaDifVlyo4T19XOnDsfNAvt4TqStn+IcDJshdC21RbtOD+siUe5OAhgTUeUn2Nk
ECZ2u+nUFBMD0Nl/5qLSgZq4x9mOzERH2jxr8n8TjZ+Q2r0s94RCNjGB6J0spTi0
brXx83ivY0QXxITb9vaeXp1QqNTXIsBSphMiOUzrBIfFnNJV2e4=
=9KZ+
-----END PGP SIGNATURE-----

--5qqv5e64sjmxmngg--
