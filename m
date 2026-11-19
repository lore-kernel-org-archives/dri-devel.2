Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178C606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOXr4FIX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C9A10F03D;
	Thu, 19 Nov 2026 17:51:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813C110F03A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:51:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A36A6297B;
 Thu, 19 Nov 2026 17:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A5B1F000CA;
 Thu, 19 Nov 2026 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795110670;
 bh=91cixVM9xkYFwo/rM+qZds/LEL2+Y7pV6WbTYF8SOsc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gOXr4FIX+yvyM0UlExwGlCV50m2VGD8kM4tJPrAugMHZwWfyy1u6l0UvOoW/TvN37
 dS2BowK0I22uP/crYXPhVI0AAARfSc4vbmYGagFJgF8nRTR5jTOaBXenOey2WY5v9H
 TL2UZ7JQqnyOePlZnAFljZDTihnnS1YKznFxsz5Mufb+uN6CTPJYUF0NnvNKZ0IGs1
 BqBPt3dar7IPC4vwLU8MUU8PRrsTpIU3MSeTVFiFibrWmXZQs/Cya7i3oo+matFEfh
 oLO4FgLUh6VYOai/dyOslD3cYAdAg4Y0v0/hpznBkgikf8PdilzwWhobL6SkkOTmXC
 9En+XwPh4vqVg==
Date: Thu, 19 Nov 2026 17:51:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Hefei <3066883572@qq.com>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: backlight: add VIEWE I2C backlight
 binding
Message-ID: <20261119-gravity-unlighted-54fc29aa3dd8@spud>
References: <tencent_093E92ACAABFAB09F39EC07F4350A5C7BD09@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B+xvd9frcwCJyrJG"
Content-Disposition: inline
In-Reply-To: <tencent_093E92ACAABFAB09F39EC07F4350A5C7BD09@qq.com>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--B+xvd9frcwCJyrJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 10:48:05AM +0800, Hefei wrote:
> Add the binding for the VIEWE panel backlight MCU on I2C.
>=20
> Signed-off-by: Hefei <3066883572@qq.com>
> ---
>  .../leds/backlight/viewe,i2c-backlight.yaml   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/view=
e,i2c-backlight.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-b=
acklight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-=
backlight.yaml
> new file mode 100644
> index 0000000..ab60c2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backligh=
t.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/viewe,i2c-backlight.ya=
ml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VIEWE I2C panel backlight
> +
> +maintainers:
> +  - Hefei <3066883572@qq.com>
> +
> +description: |
> +  Simple I2C backlight used on VIEWE DSI modules. Default protocol is de=
vice
> +  address 0x45, register 0x86, brightness 0..255.
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: viewe,i2c-backlight

This seems far too generic.
Do we not have access to a part number or something to better identify
this device?

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        backlight@45 {
> +            compatible =3D "viewe,i2c-backlight";
> +            reg =3D <0x45>;
> +            default-brightness =3D <200>;
> +        };
> +    };
> +...
> --=20
> 2.55.0.windows.5
>=20
>=20

--B+xvd9frcwCJyrJG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav83CwAKCRB4tDGHoIJi
0psXAP99GO4RrsJ86JAlIZszQIbzJlsts5XXMquezkiU8jY4PQEAjGfcqVeXvoN9
kz5bj2BWP15kOH9+6UryflGXNgsQFwI=
=QNSA
-----END PGP SIGNATURE-----

--B+xvd9frcwCJyrJG--
