Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119A606D837
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owrlddSJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E257310EA61;
	Fri,  6 Nov 2026 14:08:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D4510EA61
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:08:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7EDE1605D7;
 Fri,  6 Nov 2026 14:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82191F008A6;
 Fri,  6 Nov 2026 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974088;
 bh=Izey0YBOmcZkE1lp+pLrWr5YZYx/6LfMAQiArWMbf3s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=owrlddSJvI7VaXhET0+UXtEfznGpZVWBtrnnW5ZIDM+EZk5h58b58LB7pjJoRy+rw
 qBdsFQ3jBMEdSMNYWCtXSKpI4fQVkKuRPI+sQy25ai1y2ErK8etdaFIOlJo7/KYfxz
 tFeDz6jwxqO7gwtENb38BrMK/iMTPKLSsmbp1568rjoQtq7AYr5BldsnMihy/HO6U2
 HEfpNB7xfsZ4PvDtMrgZR6hyenTgx/jxXf9L3m6RuhbBYBl9gW5DeSBHNT+Dt//MFg
 JEQdVO8/4Nx0nSrgsgXnLWCadVvoELRhnAL3B/GAoICoZjf3mqQKbGvv0Mb1+RwgDn
 huejvWYUdFyvA==
Date: Fri, 6 Nov 2026 15:08:05 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/10] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Message-ID: <au3etybQlb5CtjBL@orome>
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-10-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="le22g3n3ml5qqrw4"
Content-Disposition: inline
In-Reply-To: <20261105140510.165165-10-clamor95@gmail.com>
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--le22g3n3ml5qqrw4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 09/10] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 04:05:09PM +0200, Svyatoslav Ryhel wrote:
> Document 8-bit CPU parallel MIPI DBI Type B interface provided by
> Tegra20/30 SoCs display controller.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra20-dbi.yaml     | 113 ++++++++++++++++++
>  .../display/tegra/nvidia,tegra20-dc.yaml      |  22 ++++
>  2 files changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidi=
a,tegra20-dbi.yaml
>=20
[...]
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20=
-dc.yaml
> index 69be95afd5627..ffeb124905dbf 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.y=
aml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.y=
aml
> @@ -79,6 +79,16 @@ properties:
>    rgb:
>      type: object
> =20
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^dbi@[0-1]$":
> +    $ref: /schemas/display/tegra/nvidia,tegra20-dbi.yaml#

I think it might be better to group these under a separate dbi node at
the top-level, making it a sibling to the "rgb" node. If you add
#address-cells and #size-cells here, I think that means technically the
"rgb" is now in the same address space as those new dbi nodes and would
need its own "reg" property and such.

Thierry

--le22g3n3ml5qqrw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrt30UACgkQ3SOs138+
s6GGVBAAubMFZSQ0mFCPlqAMqXSNCvqndsgYdUzR3UA/a03TL4Ii+ULGIqx6ux82
uibYRjgtaTaAxeuGUvL2KWes1lkUvWGEGt9hD3BS0jHUGEiYJN0u7yx79oAho8DJ
i+5HZ8CIpcERvEXpzczFo2vbw0ztc6sdvA+dsIo2S8pXTOCQ8GG8oTBZOMIADLBB
mgALNPpt9nWpY+gZYo179Sr4TIPpuFXDEg/ZIv/qlV641SYuhi/Ahs1exBCAJAZ8
CuOS1KAEVR9ZVVclHFN+24Hq+nbbX8giUue6Ii2dwL3YnBBmJaGdj0jbowdO1dQl
VOQha1/l350eA0wgPl8q9P6xCKLDic9j40HpaLVRoH7hXbK+4ZwYy6iubx+2hKjD
I7oPkf9BkCehmsPhPTim3yER6zV9eAnaHe+tm0TcCRw723d90dg4t8W/w22MGTr9
YXcSd1DlDePAMyzt4KR968mvSaa1B0jzkRa2Y0oFFWJ4qyfP+I/Ovq0OrsfHtcRd
UW0UtAE2JmFl2jLxaXsl+nIuX2bUNTBDwIfscb1n7oWr6fx4jxkL77yp8ffVxYrJ
eVDs9GZpDInSjSO6tgMOFjSG0+sc3wfyHw95YVD+h/qb8wHmxmiEeSHL0bsBdiNT
nK0YAYcHUjI7lGmB/uB6EWRCxs/9XX1iltQM1iAVawf4kNo1pD4=
=F4XT
-----END PGP SIGNATURE-----

--le22g3n3ml5qqrw4--
