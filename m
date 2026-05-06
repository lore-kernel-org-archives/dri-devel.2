Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EB0CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 16:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5119710E1F4;
	Wed,  6 May 2026 16:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ou5KWIDB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F34710E1F4
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 16:58:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 848AA6013B;
 Wed,  6 May 2026 16:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1C5C2BCB0;
 Wed,  6 May 2026 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778086687;
 bh=aMkFGXzi8Egn2jdhjt/Bo9gCanCXDfSPDnXjNpmDKB0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ou5KWIDBRlPw5uY6Bz5p7kvavhQL701mIxTZSkuiPwLGwDu+R4FIXZhhgyFF0zh0b
 6rR+D8yi2bkjZEBgYs8NtJogY0Fd8NQCRSt40Vipz/amsJwqMfjYxCAZPl2jO79B0H
 dJOcgopwwOqCZG2Yw60Ni82NombFqokowM4Q+pSLO0IIwgNHWeI3PjWgHQ0N/7C/5+
 aSouXljf+6fUBvCXlVGEK2glvxRWzM4ZWuBcISIsYw4Q88A3gj8aUgGIy/QAgLJy1F
 lnuKiutIx0MmI0SzBhgurxLmA2uYl8Wp+8WO1QqCg68YtTUWnxmTMjScgWMMaa4aNZ
 tkCK8K7o9lV5Q==
Date: Wed, 6 May 2026 17:58:02 +0100
From: Conor Dooley <conor@kernel.org>
To: LiangCheng Wang <zaq14760@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: mayqueen,pixpaper: add
 pixpaper-426m
Message-ID: <20260506-clique-safely-6dd507d0593f@spud>
References: <20260506-bar-v1-0-12195406f4ef@gmail.com>
 <20260506-bar-v1-1-12195406f4ef@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XlmV61d7RTQpBGLX"
Content-Disposition: inline
In-Reply-To: <20260506-bar-v1-1-12195406f4ef@gmail.com>
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


--XlmV61d7RTQpBGLX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2026 at 02:25:37PM +0800, LiangCheng Wang wrote:
> Add the compatible string for the PIXPAPER 4.26 monochrome
> e-ink panel to the Mayqueen Pixpaper binding.
>=20
> The new panel uses the same SPI and GPIO control interface as
> the existing Pixpaper panel, so extend the existing binding
> instead of adding a separate schema. Document the new compatible
> string and add an example node for pixpaper-426m.
>=20
> Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
> ---
>  .../bindings/display/mayqueen,pixpaper.yaml        | 25 ++++++++++++++++=
+-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/mayqueen,pixpaper.=
yaml b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
> index cd27f8ba5ae1d94660818525b5fa71db98c8acb7..4b0db2b079ebea244eb149a52=
ee1d8dbab0f60bb 100644
> --- a/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
> +++ b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
> @@ -4,22 +4,23 @@
>  $id: http://devicetree.org/schemas/display/mayqueen,pixpaper.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Mayqueen Pixpaper e-ink display panel
> +title: Mayqueen Pixpaper e-ink display panels
> =20
>  maintainers:
>    - LiangCheng Wang <zaq14760@gmail.com>
> =20
>  description:
> -  The Pixpaper is an e-ink display panel controlled via an SPI interface.
> -  The panel has a resolution of 122x250 pixels and requires GPIO pins for
> -  reset, busy, and data/command control.
> +  Mayqueen Pixpaper e-ink display panels are controlled via an SPI inter=
face
> +  and require GPIO pins for reset, busy, and data/command control.
> =20
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> =20
>  properties:
>    compatible:
> -    const: mayqueen,pixpaper
> +    enum:
> +      - mayqueen,pixpaper
> +      - mayqueen,pixpaper-426m

The commit message makes it sound like both devices could be compatible,
but the diff says they are not. What actually makes them incompatible?

> =20
>    reg:
>      maxItems: 1
> @@ -61,3 +62,17 @@ examples:
>              dc-gpios =3D <&gpio1 19 GPIO_ACTIVE_HIGH>;
>          };
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        display@0 {
> +            compatible =3D "mayqueen,pixpaper-426m";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <1000000>;
> +            reset-gpios =3D <&gpio1 17 GPIO_ACTIVE_HIGH>;
> +            busy-gpios =3D <&gpio1 18 GPIO_ACTIVE_HIGH>;
> +            dc-gpios =3D <&gpio1 19 GPIO_ACTIVE_HIGH>;
> +        };
> +    };

This example just duplicates the existing one, there's no value in
adding it.

pw-bot: changes-requested

Cheers,
Conor.

>=20
> --=20
> 2.34.1
>=20

--XlmV61d7RTQpBGLX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaftzGgAKCRB4tDGHoIJi
0sxUAQCLu8SFH/T5I6Xp1bz4jhxFnR8ov5kVt8WibSDpgZoBbAEAv06FTy+aRbgh
URBJgr9cofJoYTIl7cejUjHC3xdcVgk=
=xFdR
-----END PGP SIGNATURE-----

--XlmV61d7RTQpBGLX--
