Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CBBCD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 16:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBFB10E6B8;
	Tue, 26 May 2026 16:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WV0ha9NB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A089010E68E
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 16:39:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C9AD2600FC;
 Tue, 26 May 2026 16:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92B51F000E9;
 Tue, 26 May 2026 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779813589;
 bh=muQvscvrR0GygbyWY9xTCCnVzYrNRWHq2FyEs8Z2mhg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WV0ha9NBjJDXnyInyw9E6XVFcsb46b1ZidB7yHTv2A+62lesDDMgl4Ymotk9a0Vd6
 gdgMrxkfiiZJGFM7Pot5NNyYqyjkfWkhmvm1xZ9Z5+juouZQPlB4Svurg7ThTkimJB
 10SKX7kYGXG4sRSwJdYmfM+1TAMz924wXhe0OrXk42QpO+0EkKI2M+1f7qGxtR4GPp
 yj5VUIG7Ds8Qmu4CauXb709S45fG7bAZuTjLEeCewOsYnjgwcldzqA4q03TUKCos/k
 koeE75BD5mx9DGn4KHXb8E2l6zE69d2n3mzEfI6tjQKNzk8/E0E+EHJz5Bt9c7N6Z3
 KUgoUzz4UEDNg==
Date: Tue, 26 May 2026 17:39:42 +0100
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
Subject: Re: [PATCH v8 01/10] dt-bindings: display: rockchip: analogix-dp:
 Fix hclk as third clock for RK3588
Message-ID: <20260526-sizing-slush-ebb20673cdc9@spud>
References: <20260525125331.140059-1-damon.ding@rock-chips.com>
 <20260525125331.140059-2-damon.ding@rock-chips.com>
 <20260525-ominous-hurling-c24874030f5a@spud>
 <f6c2f07b-52b8-4181-aa1d-a7d8dcda245c@rock-chips.com>
 <0c6299ce-29a6-4443-9877-498d65c8881b@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zfz/XMY9sGbWvmeP"
Content-Disposition: inline
In-Reply-To: <0c6299ce-29a6-4443-9877-498d65c8881b@rock-chips.com>
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


--Zfz/XMY9sGbWvmeP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 07:27:55PM +0800, Damon Ding wrote:
> Hi Conor,
>=20
> On 5/26/2026 8:54 AM, Damon Ding wrote:
> > Hi Conor,
> >=20
> > On 5/26/2026 12:54 AM, Conor Dooley wrote:
> > > On Mon, May 25, 2026 at 08:53:22PM +0800, Damon Ding wrote:
> > > > RK3588 eDP controller requires HCLK_VO1 to access the VO1 GRF
> > > > registers and enable the video datapath.
> > > >=20
> > > > Previously, the clock was enabled implicitly via the 'rockchip,vo-g=
rf'
> > > > phandle reference, which allowed the eDP to work without explicitly
> > > > managing the hclk_vo1 clock. However, this is not safe or explicit.
> > > >=20
> > > > To make the clock dependency explicit, enforce per-SoC clock-names
> > > > requirements:
> > > > =A0 - RK3288: 2 clocks (dp, pclk)
> > > > =A0 - RK3399: 3 clocks (dp, pclk, grf)
> > > > =A0 - RK3588: 3 clocks (dp, pclk, hclk)
> > > >=20
> > > > Do not reuse the 'grf' clock name for RK3588 because it represents
> > > > a different clock with distinct control logic:
> > > > - The 'grf' clock is only for GRF register access and is toggled
> > > > =A0=A0 dynamically during register access.
> > > > - The 'hclk' clock controls both GRF access and video datapath
> > > > =A0=A0 gating, and must remain enabled during probe.
> > > >=20
> > > > Fixes: f855146263b1 ("dt-bindings: display: rockchip:
> > > > analogix-dp: Add support for RK3588")
> > > > Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> > > >=20
> > > > ---
> > > >=20
> > > > Changes in v4:
> > > > - Modify the commit msg.
> > > >=20
> > > > Changes in v5:
> > > > - Enforce the correct third clock name on a per-compatible basis.
> > > > - Modify the commit msg simultaneously.
> > > >=20
> > > > Changes in v6:
> > > > - Expand more detail commit msg about using hclk instead of grf clo=
ck.
> > > >=20
> > > > Changes in v7:
> > > > - List all valid clock names at the top level, and constrain the cl=
ock
> > > > =A0=A0 count for each platform with minItems/maxItems in allOf.
> > > >=20
> > > > Changes in v8:
> > > > - Fix indentation to 10 for enum in clock-names property.
> > > > ---
> > > > =A0 .../rockchip/rockchip,analogix-dp.yaml=A0=A0=A0=A0=A0=A0=A0 | 3=
4 ++++++++++++++++++-
> > > > =A0 1 file changed, 33 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/display/rockchip/
> > > > rockchip,analogix-dp.yaml b/Documentation/devicetree/bindings/
> > > > display/rockchip/rockchip,analogix-dp.yaml
> > > > index d99b23b88cc5..a1ab7a77bdd3 100644
> > > > --- a/Documentation/devicetree/bindings/display/rockchip/
> > > > rockchip,analogix-dp.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/rockchip/
> > > > rockchip,analogix-dp.yaml
> > > > @@ -26,7 +26,9 @@ properties:
> > > > =A0=A0=A0=A0=A0 items:
> > > > =A0=A0=A0=A0=A0=A0=A0 - const: dp
> > > > =A0=A0=A0=A0=A0=A0=A0 - const: pclk
> > > > -=A0=A0=A0=A0=A0 - const: grf
> > > > +=A0=A0=A0=A0=A0 - enum:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - grf
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - hclk
> > > > =A0=A0=A0 power-domains:
> > > > =A0=A0=A0=A0=A0 maxItems: 1
> > > > @@ -60,6 +62,32 @@ required:
> > > > =A0 allOf:
> > > > =A0=A0=A0 - $ref: /schemas/display/bridge/analogix,dp.yaml#
> > > > +=A0 - if:
> > > > +=A0=A0=A0=A0=A0 properties:
> > > > +=A0=A0=A0=A0=A0=A0=A0 compatible:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 contains:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - rockchip,rk3288-dp
> > > > +=A0=A0=A0 then:
> > > > +=A0=A0=A0=A0=A0 properties:
> > > > +=A0=A0=A0=A0=A0=A0=A0 clocks:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 maxItems: 2
> > > > +=A0=A0=A0=A0=A0=A0=A0 clock-names:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 maxItems: 2
> > > > +
> > > > +=A0 - if:
> > > > +=A0=A0=A0=A0=A0 properties:
> > > > +=A0=A0=A0=A0=A0=A0=A0 compatible:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 contains:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - rockchip,rk3399-edp
> > > > +=A0=A0=A0 then:
> > > > +=A0=A0=A0=A0=A0 properties:
> > > > +=A0=A0=A0=A0=A0=A0=A0 clocks:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 minItems: 3
> > > > +=A0=A0=A0=A0=A0=A0=A0 clock-names:
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 minItems: 3
> > >=20
> > > If you go back to v6, you'll see that I never asked you to remove the
> > > explict clock-names from here or below. Only the one from the 3288
> > > section. The minItems was an addition, not a replacement.
> > >=20
> > > pw-bot: changes-requested
> > >=20
> >=20
> > Sorry for the misunderstanding. I will restore the explicit clock-names
> > definitions and fix this in next version.
> >=20
>=20
> Sorry to bother you. I attempted to place the explicit clock-names under
> minItems:
>=20
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,=
analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockc=
hip,analogix-dp.yaml
> index a1ab7a77bdd3..ef03edf52de8 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogi=
x-dp.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogi=
x-dp.yaml
> @@ -87,6 +87,10 @@ allOf:
>            minItems: 3
>          clock-names:
>            minItems: 3
> +          items:
> +            - const: dp
> +            - const: pclk
> +            - const: grf
>=20
>    - if:
>        properties:
> @@ -100,6 +104,10 @@ allOf:
>            minItems: 3
>          clock-names:
>            minItems: 3
> +          items:
> +            - const: dp
> +            - const: pclk
> +            - const: hclk
>          resets:
>            minItems: 2
>          reset-names:
>=20
> make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings=
/display/rockchip/rockchip,analogix-dp.yaml
>=20
> Then the following errors occurred:
>=20
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   CHKDT   ./Documentation/devicetree/bindings
> /home/ding/drm-misc/Documentation/devicetree/bindings/display/rockchip/ro=
ckchip,analogix-dp.yaml:
> allOf:2:then:properties:clock-names: 'oneOf' conditional failed, one must=
 be
> fixed:
>         False schema does not allow 3
>         [{'const': 'dp'}, {'const': 'pclk'}, {'const': 'grf'}] is too long
>         [{'const': 'dp'}, {'const': 'pclk'}, {'const': 'grf'}] is too sho=
rt
>         1 was expected
>         3 is greater than the maximum of 2
>         hint: "minItems" is only needed if less than the "items" list len=
gth
>         from schema $id: http://devicetree.org/meta-schemas/items.yaml
> /home/ding/drm-misc/Documentation/devicetree/bindings/display/rockchip/ro=
ckchip,analogix-dp.yaml:
> allOf:3:then:properties:clock-names: 'oneOf' conditional failed, one must=
 be
> fixed:
>         False schema does not allow 3
>         [{'const': 'dp'}, {'const': 'pclk'}, {'const': 'hclk'}] is too lo=
ng
>         [{'const': 'dp'}, {'const': 'pclk'}, {'const': 'hclk'}] is too sh=
ort
>         1 was expected
>         3 is greater than the maximum of 2
>         hint: "minItems" is only needed if less than the "items" list len=
gth
>         from schema $id: http://devicetree.org/meta-schemas/items.yaml
>   LINT    ./Documentation/devicetree/bindings
>   DTEX Documentation/devicetree/bindings/display/rockchip/rockchip,analog=
ix-dp.example.dts
>   DTC [C] Documentation/devicetree/bindings/display/rockchip/rockchip,ana=
logix-dp.example.dtb
>=20
> Neither keeping only minItems nor only the explicit clock-names causes any
> errors. Would it be a better idea to keep just the explicit clock-names
> here?

Sure.

This feels like a bug because I have no idea where the "maximum of 2" is
coming from. I'll ask Rob about it.

--Zfz/XMY9sGbWvmeP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahXMywAKCRB4tDGHoIJi
0nNxAPdSXs3+yTeA4WF2uX8dr8/6syoPbTc3u7WbdikCLqnCAP41C/X0iWwW3uhW
CtmWRM45+bFWCcZWdgPOHmBAXes6Ag==
=H19y
-----END PGP SIGNATURE-----

--Zfz/XMY9sGbWvmeP--
