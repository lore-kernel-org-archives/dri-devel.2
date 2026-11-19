Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EEC606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAc2NLRm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 764FD10E4AA;
	Thu, 19 Nov 2026 17:50:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9721810E4AA
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:49:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91EC0621C9;
 Thu, 19 Nov 2026 17:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258EE1F000C4;
 Thu, 19 Nov 2026 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795110598;
 bh=cwnvE5ZeFGIwub6ucKfZkEWrWwezozotlhK7iduubCE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KAc2NLRm9bBMbaYzslkI2E7t9znLMFgTCz25Ken+tEwfdtfHw+myyGC000vz0xCiv
 oL7f5XLuHnWxyYk4zM8e2wu1ZMA+2raBxfNrMwaMZnDgWR8VFngA3LpLGkyy6rynMI
 Swvaf+1clJ1+U3beasLHqkMmaMyrWjCev7U5XprvFxynrBiIiH6S1zCtitrk+hrqAY
 TXc/44uzqnym5iidQfbfsNP4xX/bUzeK2p6EitfVvdRywsZfbcjeZrynkw1PCbUHTo
 BstFTzQjn2AQ1U6gL/YVdqAHM4ggmW9/5oI+w/ugiV/02A3I6Zcc92wIRHA1LlH/lH
 +S4OiIV7zIlIg==
Date: Thu, 19 Nov 2026 17:49:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Hefei <3066883572@qq.com>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: input: add Jadard JD9365TX touchscreen
 binding
Message-ID: <20261119-unmindful-bagel-6405d83c4fbc@spud>
References: <tencent_BF0B9E6C7E95501FC63D3F98AD08BEF70909@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X7+UfeTsliGi7hlS"
Content-Disposition: inline
In-Reply-To: <tencent_BF0B9E6C7E95501FC63D3F98AD08BEF70909@qq.com>
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

--X7+UfeTsliGi7hlS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 10:48:03AM +0800, Hefei wrote:
> Add the binding for the Jadard JD9365TX in-cell touchscreen used on
> the VIEWE 7KF82 module.
>=20
> Signed-off-by: Hefei <3066883572@qq.com>
> ---
>  .../input/touchscreen/jadard,jd9365tx.yaml    | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/j=
adard,jd9365tx.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,j=
d9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,j=
d9365tx.yaml
> new file mode 100644
> index 0000000..23696a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx=
=2Eyaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/jadard,jd9365tx.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Jadard JD9365TX in-cell touchscreen
> +
> +maintainers:
> +  - Hefei <3066883572@qq.com>
> +
> +description: |
> +  In-cell touch integrated with Jadard JD9365TX DSI panels. The module F=
PC
> +  often exposes only I2C (no interrupt GPIO); the driver polls coordinate
> +  reports.
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: jadard,jd9365tx
> +
> +  reg:
> +    maxItems: 1
> +
> +  poll-interval: true
> +
> +  jadard,coord-addr:
> +    description: Optional fixed coordinate SRAM address override
> +    $ref: /schemas/types.yaml#/definitions/uint32

Input folks, this does not really parse to me - does it make sense?

> +
> +required:
> +  - compatible
> +  - reg

The device has no power supplies?

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        touchscreen@68 {
> +            compatible =3D "jadard,jd9365tx";
> +            reg =3D <0x68>;
> +            touchscreen-size-x =3D <720>;
> +            touchscreen-size-y =3D <1280>;
> +            poll-interval =3D <16>;
> +        };
> +    };
> +...
> --=20
> 2.55.0.windows.5
>=20
>=20

--X7+UfeTsliGi7hlS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav82wgAKCRB4tDGHoIJi
0tHZAQC77AEClONCxlm2UftDzEnXPGEa0ZEewI6ktZlLmnBKLgD/a5xaq6VMlvcb
CTWDw3M2i/CHGG8q88NZWCjVCHIiBwU=
=0lw2
-----END PGP SIGNATURE-----

--X7+UfeTsliGi7hlS--
