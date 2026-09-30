Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87A5CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D40510E75B;
	Wed, 30 Sep 2026 08:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J9JsBKGj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD1610F251
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 08:47:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 060CB439EF;
 Wed, 30 Sep 2026 08:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589D21F00893;
 Wed, 30 Sep 2026 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790758024;
 bh=dXYx3+EiBk9/ho0dEeq/QLvZ8MeUmFOk1BYe/4MQKZY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=J9JsBKGjgHoXeTcujl/ZvQ4JIhqK9A629I9OTXF7oiUBqn8WliL9TD7lg9Z/iIpYE
 ZHuDHIeAiCZ6d2a1uXjGBLIBkNimbztsI7gLcDVaG2qBY7moI1/QJHJoeAEjcj/9d9
 4dbIu0E7PYaHo8QetQV3uJ5gkG8/7XOCBG1MAEc5E0Fr4oJrFWUNpxDnn1/e7Qsq8s
 Q1ibi8kcRQ0ocdLYm23xmdXvRnJ/TQF5d7Nu+5Ic6KRTrC6n+BsUQDpmp/W9hpwJHu
 iNHZXlfbiKyEayBXxpo4Il8ApOGSx1DwFnvXrWGJuT1DBfdgMIijPGqa4BWky620pF
 PMR+BN/0N6HLA==
Date: Wed, 30 Sep 2026 10:47:02 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Message-ID: <arzMF0wjcF_SVxpE@orome>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-4-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w7pdjaspmarkr4mf"
Content-Disposition: inline
In-Reply-To: <20260930070535.47130-4-clamor95@gmail.com>
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


--w7pdjaspmarkr4mf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 10:05:32AM +0300, Svyatoslav Ryhel wrote:
> Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> Tegra20/30 SoCs display controller.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidi=
a,tegra-8bit-cpu.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,teg=
ra-8bit-cpu.yaml
> new file mode 100644
> index 0000000000000..f0dab608b2936
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8bit-c=
pu.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-8bit-cpu.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nvidia Tegra DC based MIPI DBI Type B bridge
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description: The display controller in Tegra20/30 SoCs features an
> +  8-bit SPI interface that closely resembles the MIPI DBI Type B
> +  protocol and is referred to as '8-bit CPU'. Each display controller
> +  provides two such interfaces, which can be used to send MIPI DCS
> +  commands to initialize and control the panel while image data is
> +  transmitted via 16/18/24-line RGB.
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra-8bit-cpu

The description says that this is a feature of the display controller,
so adding a new binding and compatible string for this is not the right
move. This is all covered by the "nvidia,tegra{20,30}-dc" already, just
need to extend that with whatever is new.

Thierry

--w7pdjaspmarkr4mf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq8zIMACgkQ3SOs138+
s6GTCg/+Kv7yeuHDG6BKZXdZH+vhsuXyRFcZVboHZi3zbPX7DueMcwpWGt84fSqg
RtyH+L1yGxAnT6+cblKGEkRkgbf7VvjwVMyCUm0JGYWj9zO+Nkl1f6jxGeq6SVel
erB+i9h45f5YVFh39KdCm8P/dLGas8m7eH6a5T+vzhtpQY9rm4euhsmda7ciovvo
zAJF/WIIG/KSoqnbcf5N5r+OsUJahZR2ciDi83bHA8ywSrT9fKfi5ZmLIbVZNhOR
A+l2delE4DyUJzCgq7eWPen1uJYMLReXGfU3QUsu4cOqLbQSoSAMtHlp6hgX1LLY
pCTtVWYCI4H5L4UHJsl6jPsOGm38kZTzn5Q43Ca6+6bzIGHXQKK+Tx+hLRdnpGIh
ReUQduCoW0HlkMdoTwfetbsikX6iOE5eg/76k6vZrtn9V/hT8/jkVnYjTNxYGGo5
8CgiWZDTITw2LUN3dFDMz8OeYuM2QWhdAHoakNoRM8FQcXbUNS+RPwa7hdPwOs4n
pVLkACNEz0YKTA6lE6QMVMEPCWTnHcNiGgjw+qHnw9K6RpOau0sQxmJIVPYVKCBa
rlMts7akcvkzDGWpqCc8GQYIOcB/V0RSoE0tmJmRH8Bz9RCGYkdoy2Xc1ShIRGD/
Rh+f6sEfTpVaAo61kHtLp7LUmxIppT5RC9BscIKwn08JqjedW6s=
=DvAr
-----END PGP SIGNATURE-----

--w7pdjaspmarkr4mf--
