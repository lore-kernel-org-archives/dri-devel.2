Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D79606A32D
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kO97JVYX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E9910E2D8;
	Fri,  6 Nov 2026 15:51:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B98E10E425
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:51:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 004CC601D5;
 Fri,  6 Nov 2026 15:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268191F008A1;
 Fri,  6 Nov 2026 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793980293;
 bh=badGVcjXYLu33rvUqhFwfV7h3p1+hHs0e3PjCdrYub4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kO97JVYXV+WZdMxw3KD+/M1wnRgW06OdDxSfNtfjslKXN6rAxRn68s3RXrVWxRBnl
 Bx0yEVaHPK6Y6z6vI/DLUs0LfaoI4I44P+cmh7em2/CFobLMcTFzxeUKKORZmeN1d6
 X00MN3lr0cXcinXIY9WWI6wWXoNzTl17sXqiG2U+vMp8yhRHL+HJZQZtZtCa9y0VzK
 vvc6WXE7x8Cm/4edC5z0Yp7x52UccqzwswM8foO3l1wJKHh6VGDWPXu9hk7Nc1+FLn
 t8XNcry4KfnqBOgK11iMyj8QRaieEOZw518PtDV4mJaONNz0/WHdWGnS6rbSQ/fiCp
 DJ8nVwxQ17iUQ==
Date: Fri, 6 Nov 2026 16:51:31 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/10] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Message-ID: <au33NIR4bCAkokJH@orome>
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-10-clamor95@gmail.com>
 <au3etybQlb5CtjBL@orome>
 <CAPVz0n3o5pc62eF6gv+PYmJh1KN1a5s=qmjxpNGJfxbCC4tqzQ@mail.gmail.com>
 <au3mloMMzQFPUept@orome>
 <CAPVz0n1j0M1Zjj90pEGCYiNqUQv00N89oPcAxZbA7upuxhoF9w@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4dphqbl3ubrnxlyn"
Content-Disposition: inline
In-Reply-To: <CAPVz0n1j0M1Zjj90pEGCYiNqUQv00N89oPcAxZbA7upuxhoF9w@mail.gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--4dphqbl3ubrnxlyn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 09/10] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
MIME-Version: 1.0

On Fri, Nov 06, 2026 at 04:48:17PM +0200, Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:=
40 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Fri, Nov 06, 2026 at 04:11:12PM +0200, Svyatoslav Ryhel wrote:
> > > =D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE=
 16:08 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Thu, Nov 05, 2026 at 04:05:09PM +0200, Svyatoslav Ryhel wrote:
> > > > > Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> > > > > Tegra20/30 SoCs display controller.
> > > > >
> > > > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  .../display/tegra/nvidia,tegra20-dbi.yaml     | 113 ++++++++++++=
++++++
> > > > >  .../display/tegra/nvidia,tegra20-dc.yaml      |  22 ++++
> > > > >  2 files changed, 135 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/display/teg=
ra/nvidia,tegra20-dbi.yaml
> > > > >
> > > > [...]
> > > > > diff --git a/Documentation/devicetree/bindings/display/tegra/nvid=
ia,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia=
,tegra20-dc.yaml
> > > > > index 69be95afd5627..ffeb124905dbf 100644
> > > > > --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegr=
a20-dc.yaml
> > > > > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegr=
a20-dc.yaml
> > > > > @@ -79,6 +79,16 @@ properties:
> > > > >    rgb:
> > > > >      type: object
> > > > >
> > > > > +  "#address-cells":
> > > > > +    const: 1
> > > > > +
> > > > > +  "#size-cells":
> > > > > +    const: 0
> > > > > +
> > > > > +patternProperties:
> > > > > +  "^dbi@[0-1]$":
> > > > > +    $ref: /schemas/display/tegra/nvidia,tegra20-dbi.yaml#
> > > >
> > > > I think it might be better to group these under a separate dbi node=
 at
> > > > the top-level, making it a sibling to the "rgb" node. If you add
> > > > #address-cells and #size-cells here, I think that means technically=
 the
> > > > "rgb" is now in the same address space as those new dbi nodes and w=
ould
> > > > need its own "reg" property and such.
> > > >
> > >
> > > Only 1 DBI node per DC is available. Adding address/size cells means
> > > nothing for rgb.
> >
> > If only one node is available, then "reg" isn't the right property.
> > "reg" indicates we're somehow addressing the child, which applies to all
> > children, so I don't think that would work here. A separate property
> > would make more sense in that case.
> >
>=20
> Check v5 and talk to Mikko

I checked v5. I disagree.

Thierry

--4dphqbl3ubrnxlyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrt94AACgkQ3SOs138+
s6E5ChAAtfIO3/13Os0v4C8Bi+ASzT/z6pjirTsujn0WkYYLXCnMYPNDPQEXXAHp
vIchNUxW5ZQ5ngVEYrIEAQikIcd+VXxgJNOKujiEcaN4BorI2fVDnvrpzi/oQvYm
UN88vY7AskjjaX5++WhaXRu+PipGxZ3RmF3hEzOtB9UTHBn7HODhOF28UgUsq3Uj
hyVWHeJmWa+Fl78CBjiZ3Kx9wKO2Bu2DM79ZueKRP2o8wvtk6acLOJjzJGVyyELi
/M4UztX2cQW+MO8X74vVcSjjQ+OR95teYhERxenjiTnooM2Qf0SGf1kZbf89oY2t
DNRhJ4WO7fTqG+gLPFXMNt9m6jGEsbRvK0/i4ODEdDc/p1eGzA5wSTWnt8ze2Ohb
U2+sNN+l9scplO7svmQ0BjdqOlYpt4DDgTHSTekN1q8+ai5pODFN3l3zR/HC1eNm
NarPdtHxhdXcsHmscsl1yTdX/KrH7cFlS6qgOAjVzIDT3WszlKG8E6/ETjdXhklp
0of9eVwKeBsSZIYa5hkiAnoIf4KZSeG6FewFHA1VidSy5v8CzsOCSpxbAk6/Ylmv
wYyBJL7GUEHc1OM2rE+4GuwFrSTAauvYGK1b1ypWOq4OsoEij8gI5Xkh82tndo0C
vloQ8ZYKfmAtjv+3mjX4jTlTI8dYYxd2TZwTlbGbgv5ea+XRtl8=
=z+S4
-----END PGP SIGNATURE-----

--4dphqbl3ubrnxlyn--
