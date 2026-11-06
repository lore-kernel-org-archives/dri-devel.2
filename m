Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F386606D832
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfapB1fY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE2D1127D9;
	Fri,  6 Nov 2026 13:19:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 458C41127D9
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:19:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 65450605DE;
 Fri,  6 Nov 2026 13:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAF81F008A2;
 Fri,  6 Nov 2026 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971185;
 bh=6xnoUPCG34prvBi+O4Scf73cUwDPa65VrgxlVCAgl8A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dfapB1fYp+dn4zwFiGHqN2ZrAZRdFsrB0ii13LZxXnvQcaNFx2af5pVDY3Wblq1Sh
 P5nrJ2ZW4pcmvMq/H4zsWS5p6tuiOJLF4kzlpMcLU/yQ6aJf8CyxzZw2UqnSUFHRHs
 LmbRE+tB7/jd1RNdX9AXyQaUpiWyNOM8Q4U7in+zD/EPr2WL4jAWDWDqIj0s1O3U1E
 x1HSPAhvpRrx0shqGa2pUFh4qlaeSaUIqOQ2lCyZIISNb1wGQCJkQ+nf0ps1lynMuS
 j507yF6D3qHk5oVWF1EgK/9OtAZZPdoLOrTTupj+K5JGDArlu2zIhdy32d7rXzt+MG
 4mCcWwtfioUug==
Date: Fri, 6 Nov 2026 14:19:42 +0100
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
Subject: Re: [PATCH v6 02/10] drm/panel: Convert Hitachi TX10D07VM0BAA to use
 MIPI DBI bus
Message-ID: <au3TcHXFt5Yhs_V8@orome>
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-3-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j6g7nrwzsepfj5te"
Content-Disposition: inline
In-Reply-To: <20261105140510.165165-3-clamor95@gmail.com>
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


--j6g7nrwzsepfj5te
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 02/10] drm/panel: Convert Hitachi TX10D07VM0BAA to use
 MIPI DBI bus
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 04:05:02PM +0200, Svyatoslav Ryhel wrote:
> Switch from a generic platform driver to a dedicated MIPI DBI driver.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 167 ++++++++----------
>  1 file changed, 78 insertions(+), 89 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/driver=
s/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> index 83c2af1be9755..d5d7ba2096608 100644
> --- a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> +++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> @@ -14,6 +14,7 @@
>  #include <video/mipi_display.h>
> =20
>  #include <drm/drm_mipi_dbi.h>
> +#include <drm/drm_mipi_dbi_bus.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_panel.h>
> @@ -25,7 +26,7 @@ static const struct regulator_bulk_data hitachi_tx10d07=
vm0baa_supplies[] =3D {
> =20
>  struct hitachi_tx10d07vm0baa {
>  	struct drm_panel panel;
> -	struct mipi_dbi *dbi;
> +	struct mipi_dbi_device *dbi;

It's somewhat difficult to exactly see the difference between mipi_dbi
and mipi_dbi_device. Maybe that should be explained better in the cover
letter of patch 1? Or the documentation added in patch1.

> =20
>  	struct regulator_bulk_data *supplies;
>  	struct gpio_desc *reset_gpio;
> @@ -36,13 +37,12 @@ static inline struct hitachi_tx10d07vm0baa *to_hitach=
i_tx10d07vm0baa(struct drm_
>  	return container_of(panel, struct hitachi_tx10d07vm0baa, panel);
>  }
> =20
> -#define panel_dbi_command(priv, cmd, seq...) \
> +#define panel_dbi_command(dbidev, cmd, seq...) \
>  ({ \
>  	const u8 d[] =3D { seq }; \
> -	struct drm_panel *panel =3D &(priv)->panel; \
> -	struct device *dev =3D panel->dev; \
> +	struct device *dev =3D &(dbidev)->dev; \
>  	int ret; \
> -	ret =3D mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE(d)); \
> +	ret =3D mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_SIZE(d))=
; \
>  	if (ret) \
>  		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret,=
 cmd); \
>  	ret; \
> @@ -54,10 +54,6 @@ static int hitachi_tx10d07vm0baa_prepare(struct drm_pa=
nel *panel)
>  	struct device *dev =3D panel->dev;
>  	int ret;
> =20
> -	priv->dbi =3D dev_get_drvdata(dev->parent);
> -	if (!priv->dbi)
> -		return -ENODEV;
> -
>  	gpiod_set_value_cansleep(priv->reset_gpio, 1);
> =20
>  	ret =3D regulator_bulk_enable(ARRAY_SIZE(hitachi_tx10d07vm0baa_supplies=
), priv->supplies);
> @@ -79,123 +75,116 @@ static int hitachi_tx10d07vm0baa_enable(struct drm_=
panel *panel)
>  {
>  	struct hitachi_tx10d07vm0baa *priv =3D to_hitachi_tx10d07vm0baa(panel);
> =20
> -	panel_dbi_command(priv, MIPI_DCS_SET_PARTIAL_ROWS, 0x00, 0x00, 0x03, 0x=
1f);
> -	panel_dbi_command(priv, MIPI_DCS_SET_SCROLL_AREA, 0x00, 0x00, 0x03, 0x2=
0,
> +	panel_dbi_command(priv->dbi, MIPI_DCS_SET_PARTIAL_ROWS, 0x00, 0x00, 0x0=
3, 0x1f);
> +	panel_dbi_command(priv->dbi, MIPI_DCS_SET_SCROLL_AREA, 0x00, 0x00, 0x03=
, 0x20,
>  			  0x00, 0x00);

The majority of the changes in this file are s/priv/priv->dbi/, so maybe
just make it so that priv =3D priv->db and keep the changes to a minimum?

Thierry

--j6g7nrwzsepfj5te
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrt0+4ACgkQ3SOs138+
s6HbdQ/7Br6s4Wjew+x9l34Dl/Ffj0BbE/CYwRghGlNi3KCIKaIIfDn9gH9hRa00
UJVYcOAD5llvog/Za0tGlyknycUZKMvxnR1nAlLGb8OGoHbFKnBYUdJnU2GicH5c
LsNWPjZU3fxBOphqiTH1PqnvZ1R5h700IDYhZ4rIOGQSsmQanadtwwxczPCKvsLC
dequH0ByrUopSXUTp/BIMxC/BQExwzn9VBCg3WDCCFF+wIKqZNpOJrAA7uiA+hyE
Ar4t/udyzT38zgy2A5c/pwP1nDpJNjCq0N9lMJxjeup7CC6npifxeB9mjsNkNq1a
NdygSaROA3GpvigMfBhvjJyGpbaVEPfLJZCa58kOBEoD3Eue9A1KWT+57SW0QZQk
JnEG/RUMFzxANxiNLKBupjrzxisdSmEFhbfeS0N0P9bGC/gtlMOSPgTtQB/Rbwkj
EmpuA7BCM1soKZ93qqKq3HvPodk9OINJks70qPwt6ifBRs3fGdoQ3cSJs59LWQ5T
SWwnlpEbGMmPqgQvSw+syu+b+9zR9Wz+W0h3Cdn7xxAUZnjc96drwvdeAB5tkLlK
gam7Mru1iepobA63VW2IdVJXKl/eK3Cd03VttopSWqOTZkb4hvMoAmRwYgJTAScs
guoYPGjs1wCRbzIbNnxQ2L/nuKRcsxJljYrfBDkFAlevIEk+vrI=
=ONe+
-----END PGP SIGNATURE-----

--j6g7nrwzsepfj5te--
