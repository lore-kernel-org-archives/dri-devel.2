Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6E0C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C488A10E5F8;
	Fri, 25 Sep 2026 16:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J3j4SUCF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8C510E290;
 Fri, 25 Sep 2026 16:47:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3AAC60136;
 Fri, 25 Sep 2026 16:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB86A1F000FF;
 Fri, 25 Sep 2026 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790354819;
 bh=HVzA8zpGb8erHOnd1U1VdxUvMQSCdU4iWTsvvyaSMg0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=J3j4SUCF3yr+vzf/Y4dNmYQl8PahFapSIfFNeAEnlWvgPuz3qqbkii3coPZ2M+qqz
 QIS9BTZ0B51FQK1FV8Hw9ruedD0KrdU4cHV9MyxNTPkL36xVZ2VkuQKIf17OLTePPU
 CQf+w8WszeRNuXG5ENZK5CB/bf+iC20bcc5iE9b9vs8y2yon5PtFfwaA5Pudr8HSHY
 s1b6SXULa/9jmzIYH7kwsY8GuH14Xu+wslEDdy/oJBg3SlZtlvdGvKm0ahXeiNvxk8
 KJtBGM87o3Eb3c0bGVAGRAOg3LvfY+M5MnW47CItcLA722/O8mxVnR1sWn1eKNHP7I
 fmPlw2qkp3y/A==
Date: Fri, 25 Sep 2026 17:46:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vigneshr@ti.com, nm@ti.com,
 u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com,
 Ritwick.Sharma@arm.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/3] dt-bindings: i2c: dw: Add ti,tda54-i2c compatible
Message-ID: <20260925-confront-award-35b6d0183a16@spud>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <20260925-tda54-upstream-i2c-v3-1-544d74e992ff@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sCGF9TGR9Si6lSV1"
Content-Disposition: inline
In-Reply-To: <20260925-tda54-upstream-i2c-v3-1-544d74e992ff@ti.com>
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

--sCGF9TGR9Si6lSV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 12:26:28PM +0530, Aniket Limaye wrote:
> Add the "ti,tda54-i2c" compatible for Synopsys Advanced I2C Controller
> (DWC_i2c) present on TDA54 SoC. Compared to the existing
> "snps,designware-i2c" (DW_apb_i2c), it broadly differs in its register
> offsets and some bit fields, requiring changes to interrupt handling,
> timing handling, etc.
>=20
> Unlike DW_apb_i2c, this IP has no COMP_PARAM_1 register to autodetect
> the FIFO depth from, so add snps,tx-fifo-depth and
> snps,rx-fifo-depth as required properties.
>=20
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>=20
> ---
>=20
> Changes in v2:
> - Rename snps,dwc-i2c to ti,tda54-i2c
> - Link to v1: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-1-=
b0b9f77be18b@ti.com/
> ---
>  .../bindings/i2c/snps,designware-i2c.yaml          | 33 ++++++++++++++++=
++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.ya=
ml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
> index 467bdcbb8538..80a9376d6de7 100644
> --- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
> @@ -21,12 +21,23 @@ allOf:
>        properties:
>          reg:
>            maxItems: 1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,tda54-i2c
> +    then:
> +      required:
> +        - snps,tx-fifo-depth
> +        - snps,rx-fifo-depth
> =20
>  properties:
>    compatible:
>      oneOf:
>        - description: Generic Synopsys DesignWare I2C controller
>          const: snps,designware-i2c
> +      - description: TI TDA54 SoC I2C controller (Synopsys DWC_i2c IP)
> +        const: ti,tda54-i2c
>        - description: Renesas RZ/N1D I2C controller
>          items:
>            - const: renesas,r9a06g032-i2c  # RZ/N1D
> @@ -121,6 +132,18 @@ properties:
>        low period of SCL line.
>      type: boolean
> =20
> +  snps,tx-fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The depth of the hardware TX FIFO. Required on the ti,tda54-i2c
> +      variant, where fifo depth cannot be autodetected.

Why is the compatible not sufficient to get this information from?
Does it vary across controllers on the same device?

> +
> +  snps,rx-fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The depth of the hardware RX FIFO. Required on the ti,tda54-i2c
> +      variant, where fifo depth cannot be autodetected.
> +
>  unevaluatedProperties: false
> =20
>  required:
> @@ -172,4 +195,14 @@ examples:
>        interrupts =3D <8>;
>        clocks =3D <&ahb_clk>;
>      };
> +  - |
> +    i2c@53b00000 {
> +      compatible =3D "ti,tda54-i2c";
> +      reg =3D <0x53b00000 0x1000>;
> +      interrupts =3D <166>;
> +      clocks =3D <&sysclk>;
> +      clock-frequency =3D <100000>;
> +      snps,tx-fifo-depth =3D <32>;
> +      snps,rx-fifo-depth =3D <32>;
> +    };
>  ...
>=20
> --=20
> 2.53.0
>=20

--sCGF9TGR9Si6lSV1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaralfAAKCRB4tDGHoIJi
0njqAP9fyVsdwViQaN/hsNZgjikNfcCErYU2efO/qx/w7M1u6gEAwUMNgzwWB9jR
JlQcMI+eKtzBEMignrKl9xZWQUEibgI=
=SVzn
-----END PGP SIGNATURE-----

--sCGF9TGR9Si6lSV1--
