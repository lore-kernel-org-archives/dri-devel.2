Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A17CD3423
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 15:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5957110E1B1;
	Fri,  1 May 2026 15:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q/qbqEOk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735D710E1B1
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 15:51:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 479FA600AE;
 Fri,  1 May 2026 15:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728CFC2BCB4;
 Fri,  1 May 2026 15:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777650670;
 bh=Fkgyd2j//vivMvpbm5BeGCiSXXdWUFA+VDVHD/REf9U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q/qbqEOkgDC3AOOwqrWptr+d8TVHKehN2KgfWzxQe3SplNurG9bL3e8GABhPnsM09
 WktGE3x5YUzq6MGyZd2y/nsW5eyT6rTGeKrzo9+EOXvfmrNqP2MGAFz/Z35Iys0qqA
 sscHpQwQ3P614pZyQ8pKE59f634ulyxI1j93WcK4Pq0kvjukXq2mbqFehTqHlv3k9K
 N0dzVtcu30Ut8TdVULQ3zoLsadiwPOPn/dUbc58ywPskjV7k0Eri1VIOxJvks4/hyR
 +hWyw+mcsSz24Nmp41xo5R6MEbYPntkZXt9ZHStr5ZmD7An1ssmu4K4ANA5JAh+9By
 V11aTaCZitf5Q==
Date: Fri, 1 May 2026 16:51:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: Add Novatek NT37705
Message-ID: <20260501-yogurt-wise-2a2884e3ec59@spud>
References: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
 <20260501-fp6-panel-v1-1-e09cb05651cc@fairphone.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TCqlpNj/G+bOCtw3"
Content-Disposition: inline
In-Reply-To: <20260501-fp6-panel-v1-1-e09cb05651cc@fairphone.com>
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


--TCqlpNj/G+bOCtw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2026 at 03:52:45PM +0200, Luca Weiss wrote:
> Novatek NT37705 is a display driver IC used to drive AMOLED DSI panels.
>=20
> Describe it and the panel in the Fairphone (Gen. 6) (BJ631JHM-T71-D900
> from BOE) using it.
>=20
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../bindings/display/panel/novatek,nt37705.yaml    | 72 ++++++++++++++++=
++++++
>  1 file changed, 72 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37=
705.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.=
yaml
> new file mode 100644
> index 000000000000..1c796599f6fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/novatek,nt37705.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT37705-based DSI display panels
> +
> +maintainers:
> +  - Luca Weiss <luca.weiss@fairphone.com>
> +
> +description:
> +  The Novatek NT37705 is a generic DSI Panel IC used to control AMOLED p=
anels.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: boe,bj631jhm-t71-d900

Compatible doesn't match the filename, nor does the commit message match
what you've got here. Sounds like you're missing a fallback to
$filename.

pw-bot: changes-requested

Cheers,
Conor.

> +
> +  reg:
> +    maxItems: 1
> +
> +  vddio-supply:
> +    description: I/O voltage rail
> +
> +  dvdd-supply:
> +    description: Digital voltage rail
> +
> +  vci-supply:
> +    description: Analog voltage rail
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - vddio-supply
> +  - dvdd-supply
> +  - vci-supply
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        panel@0 {
> +            compatible =3D "boe,bj631jhm-t71-d900";
> +            reg =3D <0>;
> +
> +            reset-gpios =3D <&tlmm 12 GPIO_ACTIVE_LOW>;
> +
> +            vci-supply =3D <&vreg_l19b>;
> +            vddio-supply =3D <&vreg_l9b>;
> +            dvdd-supply =3D <&vreg_oled_dvdd_1p2>;
> +
> +            port {
> +                panel_in_0: endpoint {
> +                    remote-endpoint =3D <&dsi0_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
>=20
> --=20
> 2.54.0
>=20

--TCqlpNj/G+bOCtw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafTL6QAKCRB4tDGHoIJi
0kcFAQDkpJzCo4l7vUej3Ls7tED6BqFbk6tKidwZCIm2ei4sIwD/fATcdanpFsQN
pZmkVtXjY5+oh8AOr2rgaeHlNxv8KAo=
=mEw5
-----END PGP SIGNATURE-----

--TCqlpNj/G+bOCtw3--
