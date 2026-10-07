Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CEECA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE19A10F5E5;
	Wed,  7 Oct 2026 14:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dh+P1RXb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C5810F5F0
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 14:02:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2CD0601FF;
 Wed,  7 Oct 2026 14:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF1D1F0089B;
 Wed,  7 Oct 2026 14:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791381735;
 bh=Q11AWL/EPY/BIfVce6hC9e0RarRTo3nH7wZFJBgkAFk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dh+P1RXbYlDFbGN3suBP/RDNbylH2oJ6Gms2EMXYldoKY8E2nHzwHiFnEwdYs6W3l
 rzCIRKZL/2iqcKybG7RD0BwtEi/bq4DmkfqpcAlZLB4mbuYfEh1ZsU4gy05P5HOT2n
 NEY87qUfazr66eAYIt7kTX9znV4y6r4PtvY4BI1JE89teABSvP1yUye/8tBRlOKBS4
 zZ6QUo1bMqC7W/yvoZBKYDESwwmOVG8MQ6pnl/OjjxSxUYzvDH1LE7XN8/GU2GPNeS
 UcWsvKy6I+qmBNhd7oOvK5R+fgRjy1CWFelgmxhdKOuPc2onZzPCJxW8jy4vQhJ50K
 TiZM7D5W804PA==
Date: Wed, 7 Oct 2026 15:02:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v10 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb
 child node
Message-ID: <20261007-ebaeee3a3bbd50ebbdedcf72@squawk>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
 <20261006-dcif-upstreaming-v10-6-bcfb28de0aae@oss.nxp.com>
 <20261007-cb2d638508f306f3385c3799@squawk>
 <jr7zy2oxsuzfjrp4d74tl6gxiz5kg3pxl4qgigbbmtzyvjliwp@xaidoy4qvrdh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qfYFC1F6QFYmGCHK"
Content-Disposition: inline
In-Reply-To: <jr7zy2oxsuzfjrp4d74tl6gxiz5kg3pxl4qgigbbmtzyvjliwp@xaidoy4qvrdh>
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

--qfYFC1F6QFYmGCHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2026 at 04:57:45PM +0300, Laurentiu Palcu wrote:
> Hi Conor,
>=20
> On Wed, Oct 07, 2026 at 02:12:52PM +0100, Conor Dooley wrote:
> > On Tue, Oct 06, 2026 at 12:22:01PM +0000, Laurentiu Palcu wrote:
> > > Since the BLK CTL registers, like the LVDS CSR, can be used to contro=
l the
> > > LVDS Display Bridge controllers, add 'ldb' child node to handle
> > > these use cases.
> > >=20
> > > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > > ---
> > >  .../bindings/clock/nxp,imx95-blk-ctl.yaml          | 24 ++++++++++++=
+++++++++-
> > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ct=
l.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > > index fbbf1b3f17904..97fe816a38f94 100644
> > > --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > > @@ -51,6 +51,10 @@ patternProperties:
> > >      $ref: /schemas/media/fsl,imx95-csi-formatter.yaml#
> > >      unevaluatedProperties: false
> > > =20
> > > +  '^ldb@[0-9a-f]+$':
> > > +    type: object
> > > +    $ref: /schemas/display/bridge/fsl,ldb.yaml#
> >=20
> > The class of device is bridge, why not use that here?
>=20
> I'm sorry, your question is a bit vague... Are you referring to renaming
> the pattern to '^bridge@[0-9a-f]+$'? If yes, I don't have strong
> opinions against it. I can do it in the next iteration.

Yes, sorry.
That'd be great.

Thanks,
Conor.

pw-bot: changes-requested


--qfYFC1F6QFYmGCHK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasZQ4AAKCRB4tDGHoIJi
0vtMAP9BAzbT8CNXcasaaU+K6qO6MCMdqQyLCatmAZpSK81yRwEAudTtBZWLd7cb
w3GYYsCuwheg3bZe3nqy+OpPtql79AY=
=kp1o
-----END PGP SIGNATURE-----

--qfYFC1F6QFYmGCHK--
