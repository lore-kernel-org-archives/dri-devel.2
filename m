Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AC4CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707F410EC60;
	Wed, 17 Jun 2026 15:29:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ObyMeibR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E75410EC60
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:29:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E2BD44052F;
 Wed, 17 Jun 2026 15:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEEB1F00A3A;
 Wed, 17 Jun 2026 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781710140;
 bh=Qm29X9bRgJfe/zNK5NDa8OX8EJ9zbUiYDsEtZlc5aiU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ObyMeibRBgVTKtMe5WZe83QJJrwOioPRb1vP5hLRdoFOTuLodd4KiMhHgpBAkQFDA
 HZDNlKHkPBaa2jWmwssBzvfGs0ILqWJqv4jo6q9/eAp/nhoA01xMfU7oO7a7VzYjBl
 HxRRANi4mrOKCXU4XsbZLQV2KuX8ibvG0W9ZsDjblbuZDMoF7gB9fpDbh6v3wMGNdg
 VdGVfUw4G9OqEwgEZBR+CfLh7mWAL4sWgFpZPU6bS7WWWUx8pc6nRQYQYJ+1rlz6Io
 SgauVhnBMbcg5bgiLOfMYFCPVRgb0eEHf7RApEGwOrF1WvyPpId/ezXgprDlYuesmw
 68b0R0g7ADCYw==
Date: Wed, 17 Jun 2026 16:28:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Frank Binns <frank.binns@imgtec.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>, Matt Coster <matt.coster@imgtec.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: img,powervr-rogue: Document
 GE8300 GPU in Renesas R-Car D3
Message-ID: <20260617-startle-concept-dcd0c9f2ee02@spud>
References: <20260616175835.2109336-1-niklas.soderlund+renesas@ragnatech.se>
 <20260616175835.2109336-2-niklas.soderlund+renesas@ragnatech.se>
 <20260616182802.GB1662668@fsdn.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QKdl1J1UbC1dy/7+"
Content-Disposition: inline
In-Reply-To: <20260616182802.GB1662668@fsdn.se>
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


--QKdl1J1UbC1dy/7+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 08:28:02PM +0200, Niklas S=F6derlund wrote:
> On 2026-06-16 19:58:34 +0200, Niklas S=F6derlund wrote:
> > Document Imagination Technologies PowerVR Rogue GE8300 BNVC 22.67.54.30
> > present in Renesas R-Car R8A77995 D3 SoCs.
> >=20
> > Compared to other R-Car Gen3 SoCs the D3 only have one power domain and
> > it is always on. Extend the list of special cases for this to also cover
> > R8A77995 and update the description of it.
> >=20
> > Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.s=
e>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > * Changes since v1
> > - Sort img,img-ge8300 after img,img-ge7800.
> > - Fold special case for power domain into an existing one and update the
> >   description.
> > ---
> >  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.ya=
ml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > index a1f54dbae3f3..b93f49f1fa0a 100644
> > --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > @@ -25,6 +25,11 @@ properties:
> >                - renesas,r8a779a0-gpu
> >            - const: img,img-ge7800
> >            - const: img,img-rogue
> > +      - items:
> > +          - enum:
> > +              - renesas,r8a77995-gpu
> > +          - const: img,img-ge8300
> > +          - const: img,img-rogue
> >        - items:
> >            - enum:
> >                - ti,am62-gpu
> > @@ -114,6 +119,7 @@ allOf:
> >            contains:
> >              enum:
> >                - img,img-ge7800
> > +              - img,img-ge8300
> >                - img,img-gx6250
> >                - thead,th1520-gpu
> >      then:
> > @@ -159,14 +165,14 @@ allOf:
> >    - if:
> >        properties:
> >          compatible:
> > -          contains:
>=20
> The 'contains' node should have been kept, my bad. I wonder why 'make=20
> dt_binding_check' or `make dtbs_check' did not catch it. Sorry for the=20
> noise.

Because it's valid syntax, the contains syntax means that it'll match
against things that use the listed compatibles as fallbacks. What you
have done works for exact matches only.

I think recently Rob said the contains syntax is preferred, with some
rationale that escapes me.

>=20
> > -            const: thead,th1520-gpu
> > +          enum:
> > +            - renesas,r8a77995-gpu
> > +            - thead,th1520-gpu
> >      then:
> >        properties:
> >          power-domains:
> >            items:
> > -            - description: The single, unified power domain for the GP=
U on the
> > -                TH1520 SoC, integrating all internal IP power domains.
> > +            - description: The single, unified power domain for the GP=
U.
> >          power-domain-names: false
> >        required:
> >          - power-domains
> > --=20
> > 2.54.0
> >=20
>=20
> --=20
> Kind Regards,
> Niklas S=F6derlund

--QKdl1J1UbC1dy/7+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajK9NwAKCRB4tDGHoIJi
0mhPAQDo9PZ6IvEgtOJpBaLU41Smn083apLl4qhzETqAT0kfqAD+Ick9e8V/m3cF
mVF5pEd5mPmrdwL4QZ8aiNvrOeNR3wY=
=qivJ
-----END PGP SIGNATURE-----

--QKdl1J1UbC1dy/7+--
