Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE72CD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 20:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC2C89BEC;
	Tue, 12 May 2026 20:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E/Ds6pRw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DE9C89BEC
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 20:25:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C81F7600CB;
 Tue, 12 May 2026 20:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DF0C2BCB0;
 Tue, 12 May 2026 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778617513;
 bh=jrhhy1oHA57ylt9hf6z/42F0KO2nGzTAYcBMOukMeeg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E/Ds6pRwtPimFQyLRRQvMzpFeZWI6A2q91YtmstNykm+NiVy/XvIM7undsTsvDrw+
 0TR+R7WC5dDB7c2aRJEq7qIBEB9hsvJyzjGGEHUFh1KaRAsmeJKCRPa3Z+QzbJOAK8
 Ei36b3VyPP2uRHydTMQXwpkou5/2QUMXPRMKGw3QAnI6FXkk1yo2yIrYj7d1OkoJwf
 XZlfay2iLQlhG6eN4E9Wli/xECvB1ekQg66fb40yyE0unanV983QMBzmU8UB1ov/Iu
 QwVe9+wryorwKcyZoFoJxPIlPG0z6roaNfE3OelljVpeb8fcamiDtS6YzmUtqmfooV
 GMWR4K/8Z5/tA==
Date: Tue, 12 May 2026 21:25:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:DRM DRIVERS FOR FREESCALE IMX 5/6"
 <dri-devel@lists.freedesktop.org>, 
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, 
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, 
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: display: imx: add deprecated property
 'port' and 'display-timings'
Message-ID: <20260512-yeast-platypus-ec8af080f7be@spud>
References: <20260511220924.1905571-1-Frank.Li@nxp.com>
 <20260512-surgery-operative-046a90f84ef8@spud>
 <agNvt9RbRFQ395uE@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C9q5Jh7UHi2J/JRy"
Content-Disposition: inline
In-Reply-To: <agNvt9RbRFQ395uE@lizhi-Precision-Tower-5810>
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


--C9q5Jh7UHi2J/JRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 02:21:43PM -0400, Frank Li wrote:
> On Tue, May 12, 2026 at 05:47:11PM +0100, Conor Dooley wrote:
> > On Mon, May 11, 2026 at 06:09:24PM -0400, Frank Li wrote:
> > > Add deprecated property 'port' and 'display-timings' for i.MX5 SoCs (=
over
> > > 15 years) to fix below CHECK_DTBS warnings:
> > >   arm/boot/dts/nxp/imx/imx51-apf51dev.dtb: disp1 (fsl,imx-parallel-di=
splay): 'display-timings', 'port' do not match any of the regexes: '^pinctr=
l-[0-9]+$'
> > >         from schema $id: http://devicetree.org/schemas/display/imx/fs=
l,imx-parallel-display.yaml
> >
> > Instead of documenting the deprecated properties, could this
> > device/devicetree be converted to non-deprecated properties?
>=20
> Change dts will cause break back compatiblity. This is too old chips and

How would changing the dts impact backwards compatibility? That argument
doesn't make sense to me, I am of course not suggesting removing support
=66rom these properties from the driver.

I do accept that the argument of lacking info on the panel.
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> I have not information panel's detail information.
>=20
> Frank
>=20
> >
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../display/imx/fsl,imx-parallel-display.yaml         | 11 +++++++++=
++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-pa=
rallel-display.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx=
-parallel-display.yaml
> > > index bbcfe7e2958b7..b0c5869771fae 100644
> > > --- a/Documentation/devicetree/bindings/display/imx/fsl,imx-parallel-=
display.yaml
> > > +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-parallel-=
display.yaml
> > > @@ -42,6 +42,17 @@ properties:
> > >      unevaluatedProperties: false
> > >      description: output port connected to a panel
> > >
> > > +  port:
> > > +    $ref: /schemas/graph.yaml#/properties/port
> > > +    unevaluatedProperties: false
> > > +    deprecated: true
> > > +    description: input port connected to the IPU display interface, =
see port@0
> > > +
> > > +  display-timings:
> > > +    $ref: /schemas/display/panel/display-timings.yaml#
> > > +    unevaluatedProperties: false
> > > +    deprecated: true
> > > +
> > >  required:
> > >    - compatible
> > >
> > > --
> > > 2.43.0
> > >
>=20
>=20

--C9q5Jh7UHi2J/JRy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagOMowAKCRB4tDGHoIJi
0vX9APsEvcsFkyeyT6CRZELAoZLP0zPbTYB91dRklH1/iBnXJwEAwFxCMprMsgoN
X9HiNGN5youfvY5EoQapP1mcu580Qww=
=nK/w
-----END PGP SIGNATURE-----

--C9q5Jh7UHi2J/JRy--
