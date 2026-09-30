Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAA5CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5426410E85E;
	Wed, 30 Sep 2026 12:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NxD6b8CH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3362C10E85E
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:58:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 76882601DE;
 Wed, 30 Sep 2026 12:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D451F000FF;
 Wed, 30 Sep 2026 12:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790773084;
 bh=Q+GoB8bYL1DhDKxkMz+bG1dr0+NWXg3AiaR0Ssdl07Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NxD6b8CH+TqydyOSB3Mhdu3s94NCoOq93STCSe9AksUXf0VaYqbq6Mj4UtbolZa0S
 /T/LlBMevPexYIj0iW6JeKXSAsHO/b94i4iygS6zHgJHZEf+2zF/DH3udm3+Fgl59q
 gZqV803sMCalO+j7wAys+gTlA1TSAxrebulbQ0Cxl7WQTl+3vhZniuaHM796LuU91D
 n/Jpyf4d1zVwYIXSXyfOJdhA/WnUG9xG3biD2GTk+gTgb2Zh3NsUEcOe/h429rtEj1
 7ZcV79+dIccB0Fbs7MPdJl5yl+1PFEe620mS2OQQYpzqr+o4ps3Cd8xDhWvNrLiEPT
 pVKt0ZKFonQVw==
Date: Wed, 30 Sep 2026 14:58:01 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Message-ID: <ar0HCfSKR9yr9Z44@orome>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
 <UJZ22UtaS1GSRPlyAst1og@nvidia.com>
 <CAPVz0n2F8LBqFs2bJERmgvdNYgtt1OEVtK3++CP9y0gxW7gCGA@mail.gmail.com>
 <arzn-TNbOlqXqQgd@orome>
 <CAPVz0n33c_uwfhsSguEfFfJ3FV=26SPtNTEpHes9f5RjnPDA_w@mail.gmail.com>
 <arz1wzEI_7e7ruKi@orome>
 <CAPVz0n12oiuc=5wjeNCuNtJpe-M7Ys=rHn0TOExc0qkweVQnuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dlmrykjumhl467qu"
Content-Disposition: inline
In-Reply-To: <CAPVz0n12oiuc=5wjeNCuNtJpe-M7Ys=rHn0TOExc0qkweVQnuA@mail.gmail.com>
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


--dlmrykjumhl467qu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 02:56:26PM +0300, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 14:46 Th=
ierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Sep 30, 2026 at 01:56:40PM +0300, Svyatoslav Ryhel wrote:
> > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 13:5=
0 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Wed, Sep 30, 2026 at 12:52:18PM +0300, Svyatoslav Ryhel wrote:
> > > > > =D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE =
12:19 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > >
> > > > > > On Wednesday, September 30, 2026 4:05=E2=80=AFPM Svyatoslav Ryh=
el wrote:
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
> > > > > > > +
> > > > > > > +  dc-gpios:
> > > > > > > +    description: Data/command selection pin.
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  rw-gpios:
> > > > > > > +    description: Read/write pin.
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  cs-gpios:
> > > > > > > +    description: Chip select pin.
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  data-gpios:
> > > > > > > +    description: Specifies a set of 8 gpio pins used to tran=
sfer data.
> > > > > > > +    minItems: 8
> > > > > > > +    maxItems: 8
> > > > > >
> > > > > > Based on my admittedly brief research, according to the TRM the=
 display
> > > > > > controller can drive all of these pins - of which there are two=
 fixed
> > > > > > sets as you mention - directly. So we'd need to describe which =
interface
> > > > > > the display is connected to in DT, but not any GPIOs (which the=
y really
> > > > > > aren't).
> > > > > >
> > > > >
> > > > > I am perfectly fine to not expose any gpios in the binding, if th=
is is
> > > > > preferred. Only question, which method of interface checking woul=
d be
> > > > > preferred. I assume if primary then nothing, if secondary - boole=
an
> > > > > prop "nvidia,secondary"? Feel free to share your vision.
> > > >
> > > > The driver currently uses the GPIOs to program DBI commands, so I
> > > > suspect we do need some way of controlling those pins. Or is there =
a way
> > > > to have the display controller program the pins and send commands? =
That
> > > > would be much preferred because it would more accurately reflect th=
e HW
> > > > design and possibly also simplify the driver because it doesn't nee=
d to
> > > > parse the GPIOs and then also not use the GPIO API to set the value=
s.
> > > >
> > >
> > > From what I know, GPIOs must be used and freed after use. Sets of
> > > GPIOs are defined and remain fixed for primary and secondary
> > > interface.
> >
> > So you're saying that we need the GPIO handling in the RGB/DBI driver to
> > prevent anyone else from using these GPIOs and potentially messing with
> > the DBI communication?
> >
>=20
> No, gpios are used for dbi communcation while their sfio versions are
> used to transfer RGB data. So there is no risk in external
> intereference.
>=20
> > It feels like there should be a better mechanism for that than requiring
> > the DC driver to request all the GPIOs. Maybe these should be excluded
> > from the range of valid GPIOs?
> >
>=20
> NO! These gpios can be used for random purposes on devices with non-RGB s=
etups.
>=20
> > We can make sure that device tree isn't going to use these on a given
> > platform, but there's still the risk of users grabbing them via sysfs or
> > the chardev API.
> >
>=20
> Well, defining them in the schema as it is now and adding a note that
> gpios specified in the binding cannot be re-used/shared may be a
> solution. But overall it is impossible to reuse gpios dedicated for
> dbi by hw design. They cannot be shared or used for other purposes if
> dbi is used.

My concern was that somebody might try to use these pins as GPIOs, in
which case the GPIO and pin controllers are going to interoperate and
reprogram the pin functions, potentially making the DBI interface
malfunction.

Or is there some other hardware mechanism to prevent this from
happening?

Thierry

--dlmrykjumhl467qu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq9B1kACgkQ3SOs138+
s6F5HBAAk5BntFKWQ61emOnX3UDL2U79swjmQAaqWMHBclqwH9kyK2qtb3+p35Y5
XFS9FbE8j1X+XrwLXpvk04R08uo7iEJ0dlzDWW3tb0Zjxd+T/7VH0myJlru48fwN
gBb5uYg4m8zaEYMonyMToUVQuyHbGA9wFxSaPx175D7lB7+kUzh+DOYFxLRsgN8X
zx7aIuuWEJqpA9gZIBjaSHEk7T5Ow030Nlfh3BYZtP5wGC3evtjpmBSgrBlrPOGz
HHKQAIyn4eUtpSoQe1nfrC/cEGkdKMaCWK9uAqksbJIfHcSh8GgROaACT3ZiPEv7
7NYqkTVZQi4c6XrUgpwEbN/hexROEmjvkaXjeswDandfUTMMoLvcGRsZ49UnGn69
8tarLSTTjlp5PAFWHnhU6qkKjACxIke0MYZ0ZbaNfkLS07iOIPnA/7XjIO+PX5XQ
+it0SYiKT3hsFC8YjI0iBdlpbVgeJaLDF+0QxqXoTqv8GxmecYKWljO1U5hWfc9w
ry1HesveN4PWfW8jZWiWDFso6dqJanujD52KJut7+IOyYOA8TaUYgtN8P90oYq4p
ufxJtN/CmjCzFx5zaAF/wiUeQUOJQhbqLvIP8kcNncP1mQD2HvQi62EXrR38u5ZH
RTAZuk6SN7KQopu57V3Ty5HEqqyANtYeylUDo3ads9tdkMPYNS0=
=dalO
-----END PGP SIGNATURE-----

--dlmrykjumhl467qu--
