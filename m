Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213F1CD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 16:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B8410E537;
	Thu, 21 May 2026 16:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g+QqISau";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5614A10E537
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 16:59:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A6E1B601F3;
 Thu, 21 May 2026 16:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346391F000E9;
 Thu, 21 May 2026 16:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779382762;
 bh=EM0tOpRC6ixc7T8RIHjmgk36nAVQgn8lpdFzEdyfyNI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=g+QqISauQqVYxSIXaHqVaUlLJHDcMT4QNJN/9mxUtxf6sJycMYnsGFXAZU3wvySRq
 tfVy50AWhc8dHAB6jL2KIqy2aqEQdwp94yXY3Wpp+Gc1XtFJgHuWH2Hy6I7mletKwf
 8XN2+KM2UmpbI3mqBqctxzmNiaYUCYpQt41jrU+8QN4W3bDm9OLPpK7ic1jwvnuYCk
 2rzqJAeJKol7jUWW4iTOVuGywYeNKo3amm643l4OxM5RSkHV874dU0jP8VDYdcl6nZ
 SpADqiIHtY1es6/WpDQzJifaN4XoMcrq3sBLxF3jK8rn0MzJMreog3QgYveKDqZYTT
 wPlMSXrbx49Iw==
Date: Thu, 21 May 2026 17:59:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 13/15] dt-bindings: display: panel-lvds: Add
 dual-channel LVDS support
Message-ID: <20260521-cleaver-starboard-963eec225121@spud>
References: <20260521150038.103538-17-ivitro@gmail.com>
 <20260521150038.103538-30-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zZiN10fyI46t4nxn"
Content-Disposition: inline
In-Reply-To: <20260521150038.103538-30-ivitro@gmail.com>
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


--zZiN10fyI46t4nxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 04:00:49PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> The panel-lvds binding only supports single-channel panels.
> Extend it to support dual-channel LVDS panels by referencing the
> lvds-dual-ports schema when a ports container is present.
>=20
> Assisted-by: Claude:claude-sonnet-4.6
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Ah, this is part of what sashiko was talking about I guess.
nvm that email so.
Why can't your new device go into panel-simple-lvds-dual-ports?

> ---
>  .../bindings/display/panel/panel-lvds.yaml          | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.y=
aml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> index 7ed0c486870b..45183a1439ce 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> @@ -82,6 +82,17 @@ required:
>    - width-mm
>    - height-mm
>    - panel-timing
> -  - port
> +
> +oneOf:
> +  - required:
> +      - port
> +  - required:
> +      - ports
> +
> +if:
> +  required:
> +    - ports
> +then:
> +  $ref: /schemas/display/lvds-dual-ports.yaml#
> =20
>  ...
> --=20
> 2.54.0
>=20

--zZiN10fyI46t4nxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag855AAKCRB4tDGHoIJi
0l4mAP9LCzA3DYw150Odv8EVXwZMevxuRD/apsBgRbxPRJbN6wD/ZX/TS7nMkBei
vgOWMO7ndOs70m86sVKr1GJtxamNnAQ=
=xKXx
-----END PGP SIGNATURE-----

--zZiN10fyI46t4nxn--
