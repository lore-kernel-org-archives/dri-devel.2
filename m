Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A4ACD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6364E10EA75;
	Fri, 12 Jun 2026 16:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ojTzO6Gn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BEF910EA75
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:17:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F5DA41A74;
 Fri, 12 Jun 2026 16:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764D91F000E9;
 Fri, 12 Jun 2026 16:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781281022;
 bh=6lcv6smypKBVP/k+IP4v2VpeyRBHll33BUw8mfEK7Rs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ojTzO6GntM09z9J7v6YDnBnhZx/ZiwgF70b86Iko3vlek1DtVUWYmVKHKh83p+Y6+
 kqCBw/tdUPAnrJ3Sg81bnAig2ukDfF6w+bFzTdFudH/AumzW+KSGI5zpz0sguzF/il
 aoYteeggp/cQ/wbatVNobFCqihOac9ZfdKSf70mVIX/0tG7rWEJWPucbAkZbbFjw1O
 S+0p5pRQAyxkz1ngg8Fi1aPFBeQiLEBuEiHQ7gOo98W2FRf5HsVGn/sd0loeFXyUmg
 7/q/15M3NzRG+YDeCrJirMRHfl6Ib60pBpmsX+WwTrd/PIrIL/mRdzI7ohD7hWDjFO
 aN042dQdjigCA==
Date: Fri, 12 Jun 2026 17:16:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: display: tegra: Changes to support
 Tegra264
Message-ID: <20260612-iphone-racing-c2f1934f3cf1@spud>
References: <20260612-t264-host1x-v1-0-8d934987de67@nvidia.com>
 <20260612-t264-host1x-v1-1-8d934987de67@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Vy/vJYyMUcuk+IsI"
Content-Disposition: inline
In-Reply-To: <20260612-t264-host1x-v1-1-8d934987de67@nvidia.com>
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


--Vy/vJYyMUcuk+IsI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 03:32:29PM +0900, Mikko Perttunen wrote:
> Add nvidia,tegra264-host1x compatible string. The Tegra264 host1x is
> similar to Tegra234, but with a different set of engines and layout.
>=20
> The engine register range is no longer continuous, so two range entries
> are also needed.

Please restrict the new ranges of 2 to only the new device.
pw-bot: changes-requested


Thanks,
Conor.

>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml     | 5=
 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,teg=
ra20-host1x.yaml
> index 3563378a01af..5b0e3158aa5b 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host=
1x.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host=
1x.yaml
> @@ -25,6 +25,7 @@ properties:
>            - nvidia,tegra186-host1x
>            - nvidia,tegra194-host1x
>            - nvidia,tegra234-host1x
> +          - nvidia,tegra264-host1x
> =20
>        - items:
>            - const: nvidia,tegra132-host1x
> @@ -57,7 +58,8 @@ properties:
>      enum: [1, 2]
> =20
>    ranges:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> =20
>    clocks:
>      description: Must contain one entry, for the module clock. See
> @@ -192,6 +194,7 @@ allOf:
>            contains:
>              enum:
>                - nvidia,tegra234-host1x
> +              - nvidia,tegra264-host1x
>      then:
>        properties:
>          reg-names:
>=20
> --=20
> 2.53.0
>=20

--Vy/vJYyMUcuk+IsI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiww+QAKCRB4tDGHoIJi
0ukTAP9Ty/QIkaqMGAQDKra+VKOj0SXchGyTRNzM0Vu4J+Dp9AD/edCng1nxpXOr
y7wJ5bLWUfsgvcyJ81a7C+uuk2wKOQk=
=sJ4O
-----END PGP SIGNATURE-----

--Vy/vJYyMUcuk+IsI--
