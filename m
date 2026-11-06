Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0E606D812
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ho07j9cZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DBC710EA0B;
	Fri,  6 Nov 2026 13:24:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 845A01128A2
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:23:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A707437C9;
 Fri,  6 Nov 2026 13:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812661F008BC;
 Fri,  6 Nov 2026 13:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971438;
 bh=/kodSX96ujDziaB7lGvbVTnU34UOPakkV0ayfzL5L94=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ho07j9cZPpIFko6+b33h7hgp49r0Jv5esWt04CGV55mDgMi4ztV5nlxeGDNtFvvHQ
 wNc84qttMZ6c1HH0Wz4zic72EazVEMi7rlYABUchxcFNmNlQvH7Pe93nq06YKijeXa
 JuaaH1BWG2w29Cz++yEB9wUtMPOYRli8YR1S2nu990V/l5jAiJ5HyoyZD630l1AVlt
 +V4LQSJpTCgWlI1CinOeTcKa5E1CPyUPbkZBG7zn0f8FXYph3Nl+zBcFP9F2KgVc/t
 9c/ieaiLntkWOx4jCKTRFbe3IDSn947+zyciyMZFoz3hqn+Nllc4b/4zxOJPBGB/eq
 Mrquu4m3cIfcg==
Date: Fri, 6 Nov 2026 14:23:55 +0100
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
Subject: Re: [PATCH v6 03/10] drm/panel: Convert LG LH400WV3-SD04 to use MIPI
 DBI bus
Message-ID: <au3UDDpLUmeIOwEH@orome>
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-4-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qkzlestmbzyulvpc"
Content-Disposition: inline
In-Reply-To: <20261105140510.165165-4-clamor95@gmail.com>
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


--qkzlestmbzyulvpc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 03/10] drm/panel: Convert LG LH400WV3-SD04 to use MIPI
 DBI bus
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 04:05:03PM +0200, Svyatoslav Ryhel wrote:
> Switch from a generic platform driver to a dedicated MIPI DBI driver.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-lg-lh400wv3.c | 103 ++++++++++------------
>  1 file changed, 46 insertions(+), 57 deletions(-)

Same comments as for the previous patch.

> diff --git a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c b/drivers/gpu/drm/=
panel/panel-lg-lh400wv3.c
[...]
> -#define panel_dbi_command(priv, cmd, seq...) \
> +#define panel_dbi_command(dbidev, cmd, seq...) \

This probably also applied to the previous patch, but there seems to be
no reason for this change and the related changes below.

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
[...]
> @@ -177,14 +166,13 @@ static int lg_lh400wv3_get_modes(struct drm_panel *=
panel,
>  static const struct drm_panel_funcs lg_lh400wv3_panel_funcs =3D {
>  	.prepare =3D lg_lh400wv3_prepare,
>  	.enable =3D lg_lh400wv3_enable,
> -	.disable =3D lg_lh400wv3_disable,
>  	.unprepare =3D lg_lh400wv3_unprepare,
>  	.get_modes =3D lg_lh400wv3_get_modes,
>  };

It's not obvious, and also not documented, why .disable is removed.

Thierry

--qkzlestmbzyulvpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrt1OsACgkQ3SOs138+
s6E7RhAAhYaqjQpfxuR0l1ZuY4dmYeegPdxooSOgCYqYp6c11Rh7fip7s4vdJYqE
emn9EvuSsZjwV0kF3BTkroWFkJBKtFZB1KpHqJMiUfB+l9zRZJEb1w1/rovBXP9n
XhAroklrn494LRa5A6WMuSU35U5AXCOvY2PX3euu9HJlTjwO4tKqoXLy+JvjPifE
LNCylIWfRgampR3y8wPzpjoon3e5QnIeK9yMOyLetAd1/dl9+pCH6ROlFc8eWiim
+6dJ5V2p2kDuauD3CVGI7oPTDV+jscsaUV+PjkB1urv9TVEGvNC2P3vDz4gTZa1s
FwnZNQqFj84PUho4vCZZKIffM7eV20S5jBPuzgWdagZVTY6wxKwsIH/OXY7E0FU0
dCRqGabKG4a4v8iqSdB1f1IrxVK7Ic8aQgliAVdt4SjtNu+/GbVm/FcinEbu4Psz
LbqDxv/T8HGc9YVhyqQdY7ni09OuEaTez7FdmmHZL1nzSaf0OjAHhqgCVyH+HDZo
nIeWl1MxRe1q0cuwHeYMQj0uQ6JSenhDHEILix2i6AFt6w3pspErjxkb3Xo7Dm4G
r+R9/oZPi/zcZ5oH0aCWQRTkK9a6WgVscbNh7K7dwQfPMMFZ51CWG1riVluLRxGf
+rdrQlldQVhAEJrgw3lwjVerdbSRz76nVMwadaXh+lhcbeR+3tU=
=TgBu
-----END PGP SIGNATURE-----

--qkzlestmbzyulvpc--
