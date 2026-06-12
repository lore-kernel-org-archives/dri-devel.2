Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B68CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAB8810EA7A;
	Fri, 12 Jun 2026 16:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H6k8mWy4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A74810EA7A
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:09:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7D90600AF;
 Fri, 12 Jun 2026 16:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730D61F000E9;
 Fri, 12 Jun 2026 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781280595;
 bh=aq30D6zmaSTWmTNk1Ul9iMUE0E6w3wNjjVKpsq5EvFk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=H6k8mWy4TC8tyaXRV2lAwWRt+GtZq9P8UssA7HzpXGV7c59YQAA+QA7bFju+UCbhi
 hh7mT3ggZdykbP//wPq0+ISWJILWKaX86hFTCYKPiXrFSQKbOF+O2RlUpuwcJYf7gp
 8aITC0X04i0rN5jdZ/TLNFmGIWyaBn1NbnmE6vJM9Vsvx8g2cLbE0g9pkgp4ponSDi
 CjGdnhAgyqn49qYaVmTC79tvMqeLKmLTq7ns2VqYbTmduxZa3rnqFDm/dW1lkCU9qH
 1F6EERd3sztheY6UkJbXynr54DcZxqWMiyBIhkoTfHXR8GPdcb+m2VcR2f3N4EHN+H
 t/c78+cbb/tzg==
Date: Fri, 12 Jun 2026 17:09:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: display: bridge: Document Renesas
 R-Car V4H DSC bindings
Message-ID: <20260612-landed-remedial-79582e900699@spud>
References: <20260515-rcar-du-dsc-v2-0-f6b9240a1240@ideasonboard.com>
 <20260515-rcar-du-dsc-v2-2-f6b9240a1240@ideasonboard.com>
 <20260515-fraying-trickle-7511a2eeaf44@spud>
 <81f89aa1-84d8-44e1-813b-2bbcafe3687e@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M3NyARh4jghnVALM"
Content-Disposition: inline
In-Reply-To: <81f89aa1-84d8-44e1-813b-2bbcafe3687e@ideasonboard.com>
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


--M3NyARh4jghnVALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 01:43:44PM +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> On 15/05/2026 20:32, Conor Dooley wrote:
> > On Fri, May 15, 2026 at 10:56:15AM +0300, Tomi Valkeinen wrote:
> > > From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > >=20
> > > The Renesas DSC Display Stream Compression is a bridge embedded in the
> > > Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
> > > 8k or 400 Mpixel/s .
> > >=20
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > [tomi.valkeinen: fix the example]
> > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.co=
m>
> > > ---
> > >   .../bindings/display/bridge/renesas,dsc.yaml       | 96 +++++++++++=
+++++++++++
> > >   1 file changed, 96 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/renesas=
,dsc.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.ya=
ml
> > > new file mode 100644
> > > index 000000000000..2918d592732b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.ya=
ml
> >=20
> > Filename matching the compatible please.
>=20
> All the other Documentation/devicetree/bindings/display/bridge/renesas,*
> files follow the same style, where the file name is in a generic format, =
but
> the actual compat strings are per SoC (and no generic compat string).

No idea why it's like that currently, but filename matching compatible
is the policy.

--M3NyARh4jghnVALM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiwvTAAKCRB4tDGHoIJi
0qMpAP4jTzOgRW+PnemiZMAnA+L5VxOTwHJSxg1B/d89AGSqYQD9EtGaiGfY4js1
HpJoegRSMqdIGa0omBue8WXQpiD9XQ8=
=IqDA
-----END PGP SIGNATURE-----

--M3NyARh4jghnVALM--
