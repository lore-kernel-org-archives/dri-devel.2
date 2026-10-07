Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68386CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 740F110E5A9;
	Wed,  7 Oct 2026 13:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LU06ATxc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F5D610E5A9
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:12:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0665429F7;
 Wed,  7 Oct 2026 13:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A55B1F0089B;
 Wed,  7 Oct 2026 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791378778;
 bh=Kx0k0qBNIHathxhkLOSlyTa1tARm1WFDT7yHCpSRGUI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LU06ATxcWZ2nWDafWFzvHCTpqlZDNGYrgTM/9BfTYacfaHUaSdcRboiBWnknYb8OK
 cuCgntqyg++QhcV6DyyT1YHcJ+6IlFq4bFOU5tdsIPwBpE6qtyn7eJ5BY8P2ICM5NS
 G9hLDDZl2anudh01fba11n0ynTqfUQSbVOvqJWQmPGRV2uLtV/++SrGgcCDlQYzaMF
 TZmfD3CO05G3kLtpWEyE1v7M7ww+krCg3CcPz9t+3+E5r3S9sPmp8Af2C3Y3wqhP01
 mMuKeQtwR5jOUXyZlzsBaD7cCH4H4VoF76LBuvKVKOAJbr56fQ50mxmHifAwYXJ0QV
 Ty22q3xU6pPHg==
Date: Wed, 7 Oct 2026 14:12:52 +0100
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
Message-ID: <20261007-cb2d638508f306f3385c3799@squawk>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
 <20261006-dcif-upstreaming-v10-6-bcfb28de0aae@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z8+zZt/nTc0Rfe8E"
Content-Disposition: inline
In-Reply-To: <20261006-dcif-upstreaming-v10-6-bcfb28de0aae@oss.nxp.com>
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

--Z8+zZt/nTc0Rfe8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2026 at 12:22:01PM +0000, Laurentiu Palcu wrote:
> Since the BLK CTL registers, like the LVDS CSR, can be used to control the
> LVDS Display Bridge controllers, add 'ldb' child node to handle
> these use cases.
>=20
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  .../bindings/clock/nxp,imx95-blk-ctl.yaml          | 24 ++++++++++++++++=
+++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.ya=
ml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> index fbbf1b3f17904..97fe816a38f94 100644
> --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> @@ -51,6 +51,10 @@ patternProperties:
>      $ref: /schemas/media/fsl,imx95-csi-formatter.yaml#
>      unevaluatedProperties: false
> =20
> +  '^ldb@[0-9a-f]+$':
> +    type: object
> +    $ref: /schemas/display/bridge/fsl,ldb.yaml#

The class of device is bridge, why not use that here?

Thanks,
Conor.

> +
>  required:
>    - compatible
>    - reg
> @@ -63,7 +67,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: nxp,imx95-camera-csr
> +            enum:
> +              - nxp,imx94-lvds-csr
> +              - nxp,imx95-camera-csr
>      then:
>        required:
>          - '#address-cells'
> @@ -72,8 +78,24 @@ allOf:
>        properties:
>          '#address-cells': false
>          '#size-cells': false
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: nxp,imx95-camera-csr
> +    then:
>        patternProperties:
>          '^formatter@[0-9a-f]+$': false
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: nxp,imx94-lvds-csr
> +    then:
> +      patternProperties:
> +        '^ldb@[0-9a-f]+$': false
> =20
>  additionalProperties: false
> =20
>=20
> --=20
> 2.53.0

--Z8+zZt/nTc0Rfe8E
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasZFVAAKCRB4tDGHoIJi
0vuvAQCMuGFOHoyiVgxFDEw2VPLnr+yYh971SizxwVmIa7EqBQD/ZJ0Jk4MloW93
GfboWxtLy42RdX35LKACHj+5/AC6Hg0=
=kUg8
-----END PGP SIGNATURE-----

--Z8+zZt/nTc0Rfe8E--
