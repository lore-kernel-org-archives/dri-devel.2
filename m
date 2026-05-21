Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55CDCD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 19:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B6A10E576;
	Thu, 21 May 2026 19:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WW+dJHmQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62FD10E576
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 19:54:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E3EF44458;
 Thu, 21 May 2026 19:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5881F000E9;
 Thu, 21 May 2026 19:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779393263;
 bh=E5qxMVU7KNeTp5Z9eD048xkheSqBuHU9Rf+lOSg5bZE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WW+dJHmQVUmrlw5Sloc8UtUUdypQ0KChM61ytPXX9nOujJfAjfWMoKFbvKQzSXmK3
 JgizcQbvjJC+Zku1kqiWdFglDskPLCY//fkdHRlrUksi/I3iMSyjck49TIakUCXbgn
 M0kIJLSg9Zd03uvzutcXmITcSxCYG9l+KDNFDxZSVQ/S1pC+fHt0dw1gXU32o2looB
 /1LFgjkGQzXbF6loAylfFmyv+AgUjqqv3I2p+F2PnrPArq4p130j7DTK47rrC/nP21
 I2L2bHwkqjMaduSJ2RyGDy9zATsiCAHW9BInQ/hBKcf3eWQ6/WlKVUPhn1youHLV7t
 p66IaHTQnSviw==
Date: Thu, 21 May 2026 20:54:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com,
 nicolas.frattaroli@collabora.com, cristian.ciocaltea@collabora.com,
 sebastian.reichel@collabora.com, dmitry.baryshkov@oss.qualcomm.com,
 luca.ceresoli@bootlin.com, dianders@chromium.org,
 m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/10] dt-bindings: display: rockchip: analogix-dp:
 Fix hclk as third clock for RK3588
Message-ID: <20260521-waking-case-cd709f0a7712@spud>
References: <20260521080835.1362416-1-damon.ding@rock-chips.com>
 <20260521080835.1362416-2-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b8RwqbhFD4vyJf2C"
Content-Disposition: inline
In-Reply-To: <20260521080835.1362416-2-damon.ding@rock-chips.com>
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


--b8RwqbhFD4vyJf2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 04:08:26PM +0800, Damon Ding wrote:
> RK3588 eDP controller requires HCLK_VO1 to access the VO1 GRF
> registers and enable the video datapath.
>=20
> Previously, the clock was enabled implicitly via the 'rockchip,vo-grf'
> phandle reference, which allowed the eDP to work without explicitly
> managing the hclk_vo1 clock. However, this is not safe or explicit.
>=20
> To make the clock dependency explicit, enforce per-SoC clock-names
> requirements:
>  - RK3288: 2 clocks (dp, pclk)
>  - RK3399: 3 clocks (dp, pclk, grf)
>  - RK3588: 3 clocks (dp, pclk, hclk)
>=20
> Do not reuse the 'grf' clock name for RK3588 because it represents
> a different clock with distinct control logic:
> - The 'grf' clock is only for GRF register access and is toggled
>   dynamically during register access.
> - The 'hclk' clock controls both GRF access and video datapath
>   gating, and must remain enabled during probe.
>=20
> Fixes: f855146263b1 ("dt-bindings: display: rockchip: analogix-dp: Add su=
pport for RK3588")
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>=20
> ---
>=20
> Changes in v4:
> - Modify the commit msg.
>=20
> Changes in v5:
> - Enforce the correct third clock name on a per-compatible basis.
> - Modify the commit msg simultaneously.
>=20
> Changes in v6:
> - Expand more detail commit msg about using hclk instead of grf clock.
> ---
>  .../rockchip/rockchip,analogix-dp.yaml        | 37 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,=
analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockc=
hip,analogix-dp.yaml
> index d99b23b88cc5..8001c1facf98 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogi=
x-dp.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogi=
x-dp.yaml
> @@ -23,10 +23,7 @@ properties:
> =20
>    clock-names:
>      minItems: 2
> -    items:
> -      - const: dp
> -      - const: pclk
> -      - const: grf

Instead of removing this, you can make it

items:
 - const: dp
 - const pclk
 - enum:
     - grf
     - hclk

> +    maxItems: 3

And delete this.

> =20
>    power-domains:
>      maxItems: 1
> @@ -60,6 +57,33 @@ required:
>  allOf:
>    - $ref: /schemas/display/bridge/analogix,dp.yaml#
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3288-dp
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: dp
> +            - const: pclk

Then this becomes
  clock-names:
    maxItems: 2
  clocks:
    maxItems: 2

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3399-edp
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: dp
> +            - const: pclk
> +            - const: grf

maybe this needs a minItems: 3? Depends on if the grf clock is
mandatory. Also probably needs a
clocks:
  minItems: 3
if that's the case.

> +
>    - if:
>        properties:
>          compatible:
> @@ -68,6 +92,11 @@ allOf:
>                - rockchip,rk3588-edp
>      then:
>        properties:
> +        clock-names:
> +          items:
> +            - const: dp
> +            - const: pclk
> +            - const: hclk

And the same here as for the 3399.

Cheers,
Conor.

>          resets:
>            minItems: 2
>          reset-names:
> --=20
> 2.34.1
>=20
>=20

--b8RwqbhFD4vyJf2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag9i6AAKCRB4tDGHoIJi
0qOeAP4/TIm4lNwVPo8oG7XgOK2ViaUmDDyl9A6OWsGUOnJ6mAD/VEkf8xDaid1h
UX09FkCBYAnUiKsUzJi5SK/3mw2M8w4=
=FcL6
-----END PGP SIGNATURE-----

--b8RwqbhFD4vyJf2C--
