Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FF6CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92A6510E593;
	Wed,  7 Oct 2026 13:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VRtCQ22f";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF26F10F59B
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:11:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 458454029E;
 Wed,  7 Oct 2026 13:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5373B1F0089B;
 Wed,  7 Oct 2026 13:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791378692;
 bh=fU1GuLIm19BVy56Ks7brnn3nS8NIyYYLHC3fc8g43AI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VRtCQ22fEbfQ1dlzLF708OiRR5/rHAgOdNCo/U46SgQRZ9EkrZqbOU9n2X9qWbrD3
 D4PaJQNjeeGJRhpreBG072Pwo74Kzuemtww48AAWJUv7sP+9Rj8D8tZzEtxrzmKeXx
 1Vtd2/6Koyu+TUW2GmdadK4GOjIcKagf3kCpDqm1UVFSzQN5lxetDMp5W9trtkk9iC
 +zLjDdrEfiu6De5/INIcOCYGbA3ZwCeqbomaDfAFfOS2Mguqkp8D2MD4zUjO4E1dpR
 uwIDO+yEAOtxLJgiWYmEOlpWK/m9qoWzUmULSGIVvLK8hekazRyw7jgfR38rPyazQn
 74lxNHZi+8Kaw==
Date: Wed, 7 Oct 2026 14:11:27 +0100
From: Conor Dooley <conor@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, Frank.Li@kernel.org,
 imx@lists.linux.dev, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH v10 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb
 child node
Message-ID: <20261007-e9f7f08f98c153f0d0c97c91@squawk>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
 <20261006-dcif-upstreaming-v10-6-bcfb28de0aae@oss.nxp.com>
 <20261006123500.94C911F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rYN3Tj1AuBnBbp+q"
Content-Disposition: inline
In-Reply-To: <20261006123500.94C911F00893@smtp.kernel.org>
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

--rYN3Tj1AuBnBbp+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2026 at 12:34:59PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] dt-bindings: missing LDB constraints for nxp,imx95-lvds-csr va=
riant
> --
>=20
> commit ef256d56e7840a3d6a825d4ac33adad77eacd513
> Author: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
>=20
> dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb child node
>=20
> Since the BLK CTL registers, like the LVDS CSR, can be used to control the
> LVDS Display Bridge controllers, add 'ldb' child node to handle
> these use cases.
>=20
> > diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.=
yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > index fbbf1b3f17904..97fe816a38f94 100644
> > --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> [ ... ]
> > @@ -63,7 +67,9 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: nxp,imx95-camera-csr
> > +            enum:
> > +              - nxp,imx94-lvds-csr
> > +              - nxp,imx95-camera-csr
> >      then:
> >        required:
> >          - '#address-cells'
>=20
> [Severity: Medium]
> Could this introduce a regression where device tree validation incorrectl=
y fails
> for i.MX95 devices that define an ldb child node under the LVDS CSR?

This ldb child is new, how could there be a regression like this?

>=20
> This change restricts #address-cells and #size-cells to these two strings,
> forcing them to false for nxp,imx95-lvds-csr. Should nxp,imx95-lvds-csr a=
lso
> be included in this enum?
>=20
> [ ... ]
> > @@ -72,8 +78,24 @@ allOf:
> >        properties:
> >          '#address-cells': false
> >          '#size-cells': false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          not:
> > +            contains:
> > +              const: nxp,imx95-camera-csr
> > +    then:
> >        patternProperties:
> >          '^formatter@[0-9a-f]+$': false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          not:
> > +            contains:
> > +              const: nxp,imx94-lvds-csr
> > +    then:
> > +      patternProperties:
> > +        '^ldb@[0-9a-f]+$': false
>=20
> [Severity: Medium]
> Does this introduce a regression by preventing nxp,imx95-lvds-csr from
> declaring an ldb child node?
>=20
> This explicitly forbids the ldb child node for anything other than
> nxp,imx94-lvds-csr, thereby silently prohibiting it for nxp,imx95-lvds-cs=
r.
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20261006-dcif-upstre=
aming-v10-0-bcfb28de0aae@oss.nxp.com?part=3D6

--rYN3Tj1AuBnBbp+q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasZE/wAKCRB4tDGHoIJi
0pxvAPoDgU95rPok0uGP0uVoh/Yksvh22uL6LGRHfp/ZfKppLAD8CGqFqi59wvXk
5Bc26aOCnBFpESmlYWFOdNfSqL0pRwI=
=NzJU
-----END PGP SIGNATURE-----

--rYN3Tj1AuBnBbp+q--
