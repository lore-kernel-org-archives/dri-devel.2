Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695AB606A321
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDEA10F7A9;
	Tue, 27 Oct 2026 19:04:11 +0000 (UTC)
Received: from aposti.net (aposti.net [185.119.170.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD36E10F7A9
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 19:04:09 +0000 (UTC)
Message-ID: <270ef5220fdd5ec3e0b88ba5c4ce044992fca41a.camel@crapouillou.net>
Subject: Re: [PATCH v2 2/5] dt-bindings: display: Add the Ingenic X1600 LCD
 controller
From: Paul Cercueil <paul@crapouillou.net>
To: Krzysztof Kozlowski <krzk@kernel.org>, Olivier Louvignes
 <olivier@mgcrea.io>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Neil
 Armstrong	 <neil.armstrong@linaro.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter	 <simona@ffwll.ch>, Jessica Zhang <jesszhan0024@gmail.com>,
 Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley	 <conor+dt@kernel.org>, "H . Nikolaus Schaller"
 <hns@goldelico.com>, 	dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 	linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2026 20:04:00 +0100
In-Reply-To: <20261027-hospitable-apricot-scallop-166448@quoll>
References: <20261025191640.13592-1-olivier@mgcrea.io>
 <20261025191640.13592-3-olivier@mgcrea.io>
 <20261027-hospitable-apricot-scallop-166448@quoll>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

Le mardi 27 octobre 2026 =C3=A0 12:00 +0100, Krzysztof Kozlowski a =C3=A9cr=
it=C2=A0:
> On Sun, Oct 25, 2026 at 08:16:37PM +0100, Olivier Louvignes wrote:
> > The X1600's display controller fetches frames through descriptors
> > and
> > keeps its interface and timings in register blocks of their own
> > (X1600
> > programming manual, chapter 10), so it shares nothing with the
> > controllers ingenic,lcd.yaml describes. Its registers are those of
> > the
> > X2000's display controller without the composer.
> >=20
> > Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> > ---
> > =C2=A0.../bindings/display/ingenic,x1600-lcd.yaml=C2=A0=C2=A0 | 70
> > +++++++++++++++++++
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 5 ++
> > =C2=A02 files changed, 75 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
> > b/Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
> > new file mode 100644
> > index 000000000000..171536c78f4b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/ingenic,x1600-
> > lcd.yaml
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/ingenic,x1600-lcd.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Ingenic X1600 LCD controller
> > +
> > +maintainers:
> > +=C2=A0 - Olivier Louvignes <olivier@mgcrea.io>
> > +
> > +description:
> > +=C2=A0 The display controller of the Ingenic X1600 SoC. It fetches
> > frames through
> > +=C2=A0 descriptors in memory and drives a parallel RGB panel or a smar=
t
> > panel;
> > +=C2=A0 its registers have nothing in common with the controllers
> > described in
> > +=C2=A0 ingenic,lcd.yaml.
> > +
> > +properties:
> > +=C2=A0 $nodename:
> > +=C2=A0=C2=A0=C2=A0 pattern: "^lcd-controller@[0-9a-f]+$"
>=20
> Individual device schemas do not need to enforce naming, you can drop
> nodename.
>=20
> > +
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 const: ingenic,x1600-lcd
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: The pixel clock, whose g=
ate also gates the
> > controller
> > +
> > +=C2=A0 clock-names:
> > +=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: lcd
>=20
> ... and drop clock-names, since it is the same as device name.
>=20
> > +
> > +=C2=A0 port:
> > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/graph.yaml#/properties/port
> > +=C2=A0=C2=A0=C2=A0 description: The output, to the panel or bridge.
>=20
> No port for IPU?

No IPU on the X1600 - the display IP is completely different there
(hence the new binding).

Cheers,
-Paul
