Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEB0CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 18:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05EDC10F2E7;
	Thu, 14 May 2026 18:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VHo615zd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC54B10F2E7
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 18:23:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 65EFA417FC;
 Thu, 14 May 2026 18:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A359EC2BCC7;
 Thu, 14 May 2026 18:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778783009;
 bh=FbnqPx1PyG+vLXcxu/p7mAAyZB6jG62MlCbjDqegcOU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VHo615zdxBV5CnRnYQFbNnfeTEPg0c42CzSOCww0v6RZKq6FO8SHUD+jVIfssc53Q
 LYBTrXEdkvDr4xq57A11u0r7muhywEHg8ok+CUiiG1VGCSbA0R+ofTQQBchp9/wvk9
 8/1+JAegc4sTXECrl0iGip5A1g154qKDciQIwoc6Biop2+cEE0zp0UDIIIQqSZTH7H
 djPwsodLwayyKjL/xik87Q2kjaI4alIqpnC3XDUnyrQ6jOiWjKQnlcdIbLxnB0wLkp
 TNl7b8JPvH1r0nraQ/JeFbSSDSjElmKgsNCXBtjvzvDvH1FcZNqQqdcMTQg9erKeyP
 RFfpdv4kdxQJw==
Date: Thu, 14 May 2026 19:23:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add Chipone ICNA
 35xx OLED driver bindings
Message-ID: <20260514-accompany-expiring-c90c6af5f7a9@spud>
References: <20260514-icna35xx-v2-0-45acd1dfa566@gmail.com>
 <20260514-icna35xx-v2-1-45acd1dfa566@gmail.com>
 <20260514-ambush-salvation-ce6616190390@spud>
 <CALHNRZ8ukiSM2+uj+Qg6rVbUjjFeo88HQjLZsFHbHBs_GTy_1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QaqnQ43ZV9tPSjq0"
Content-Disposition: inline
In-Reply-To: <CALHNRZ8ukiSM2+uj+Qg6rVbUjjFeo88HQjLZsFHbHBs_GTy_1Q@mail.gmail.com>
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


--QaqnQ43ZV9tPSjq0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 01:20:57PM -0500, Aaron Kling wrote:
> On Thu, May 14, 2026 at 1:07=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Thu, May 14, 2026 at 12:24:49PM -0500, Aaron Kling via B4 Relay wrot=
e:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > The Chipone ICNA35xx series of DDICs are high refresh, low power
> > > MIPI-DSI drivers for OLED panels. The icna3512 is used by the Ayn Odi=
n 2
> > > Portal and the icna3520 is used by the Ayn Thor top panel and the Ayn
> > > Odin 3.
> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >  .../bindings/display/panel/chipone,icna35xx.yaml   | 79 ++++++++++++=
++++++++++
> > >  1 file changed, 79 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/chipone,=
icna35xx.yaml b/Documentation/devicetree/bindings/display/panel/chipone,icn=
a35xx.yaml
> > > new file mode 100644
> > > index 00000000000000..6464d8d0cf86d5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/panel/chipone,icna35x=
x.yaml
> >
> > Filename matching a compatible please.
>=20
> Does this require splitting / duplicating the files for each ddic, or
> can one be arbitrarily picked and the other stay with it?

Pick an arbitrary one. Maybe which one is older?

> > > @@ -0,0 +1,79 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/panel/chipone,icna35xx.ya=
ml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Chipone ICNA35xx display drivers
> > > +
> > > +maintainers:
> > > +  - Neil Armstrong <neil.armstrong@linaro.org>
> > > +
> > > +description:
> > > +  The Chipone ICNA35xx are a series of DDICs connected
> > > +  using a MIPI-DSI video interface.
> > > +
> > > +allOf:
> > > +  - $ref: panel-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - ayaneo,pocketds-panel-top
> > > +              - ayntec,odin2portal-panel
> > > +          - const: chipone,icna3512
> > > +
> > > +      - items:
> > > +          - enum:
> > > +              - ayntec,odin3-panel
> > > +              - ayntec,thor-panel-top
> > > +          - const: chipone,icna3520
> >
> > Commit message should state why these ddics are not compatible with one
> > another.
>=20
> Ack. Short version: some of the mipi vendor commands don't match.
>=20
> > Rest of this seems okay.
> >
> > pw-bot: changes-requested
> >
> > Thanks,
> > Conor.
>=20
> Aaron

--QaqnQ43ZV9tPSjq0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagYTHAAKCRB4tDGHoIJi
0qAHAQCcuD1m0Aug+tDgcu9OC2u4uROICoc6KGLbjktD42X11wEA1NPKmSPP5xHm
W16lFmxqdpLUsSx6/hAPF/rWsV02dQI=
=uBJJ
-----END PGP SIGNATURE-----

--QaqnQ43ZV9tPSjq0--
