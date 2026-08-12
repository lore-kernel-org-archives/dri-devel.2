Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6D3C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260658945A;
	Wed, 12 Aug 2026 13:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LZBh4kmm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4321010EFCF
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:26:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD14160A85;
 Wed, 12 Aug 2026 13:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C061F000E9;
 Wed, 12 Aug 2026 13:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786541181;
 bh=AaZdD0Jt+dr/QHiKkj96Jo5zBACuLKjiwAxMjMuJAwA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LZBh4kmmUksyKHZa+mXnWGq2pBxAUDiamDrSAMcw7aLbz7d8HTeH+YQ+RCWrPcbs+
 Ipprp6mHsl4SdnO4AZv+C4vXZ6Hd6j2K4nIHB24LVtv9+/h92JoJ3nHK+AGJOv5aGK
 uAzKJ06o7mtNGjej01Thnv35pTSBEyea6ODG/7+eAuB9z4fQlcDV+KnB4kDMfb8z2/
 VvWBU7TdLshAsMOdmVXPHjU84FMOQm7mJJ7+iB/8oySIzlkV/15juF8kaHo0GBtWFm
 qyOL4HvTz0+ejDw7foU1z0eJSaRyIKirFW2OSI2c8fwzLbz1OyPBed5J7mLs3Kc6Ma
 5hKxAc5Bcj8YA==
Date: Wed, 12 Aug 2026 15:26:19 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: luca.ceresoli@bootlin.com, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE panels
Message-ID: <20260812-psychedelic-accomplished-swift-4f0081@houat>
References: <20260812130429.16850-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="x7nqwg6ptt372roy"
Content-Disposition: inline
In-Reply-To: <20260812130429.16850-1-osama.abdelkader@gmail.com>
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


--x7nqwg6ptt372roy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE panels
MIME-Version: 1.0

On Wed, Aug 12, 2026 at 03:04:18PM +0200, Osama Abdelkader wrote:
> Use the managed MIPI DSI attach helper in BOE panel drivers and drop the
> corresponding manual detach calls from remove paths.
>=20
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
>=20
> ---
> v3:
> - Move the changelog after the `---`.
>=20
> v2:
> - break long description lines.
> - add Signed-off-by tag
>=20
>  drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c       | 8 +-------
>  drivers/gpu/drm/panel/panel-boe-himax8279d.c         | 8 +-------
>  drivers/gpu/drm/panel/panel-boe-td4320.c             | 8 +-------
>  drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 4 +---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c       | 8 +-------
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c       | 7 +------
>  6 files changed, 6 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu=
/drm/panel/panel-boe-bf060y8m-aj0.c
> index 84c21c62a43e..6a74523a6614 100644
> --- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> +++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> @@ -359,7 +359,7 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_dev=
ice *dsi)
> =20
>  	drm_panel_add(&boe->panel);
> =20
> -	ret =3D mipi_dsi_attach(dsi);
> +	ret =3D devm_mipi_dsi_attach(&dsi->dev, dsi);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
>  		return ret;
> @@ -371,12 +371,6 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_de=
vice *dsi)
>  static void boe_bf060y8m_aj0_remove(struct mipi_dsi_device *dsi)
>  {
>  	struct boe_bf060y8m_aj0 *boe =3D mipi_dsi_get_drvdata(dsi);
> -	int ret;
> -
> -	ret =3D mipi_dsi_detach(dsi);
> -	if (ret < 0)
> -		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> -
>  	drm_panel_remove(&boe->panel);
>  }

mipi_dsi_detach is now called after drm_panel_remove. Your commit log
should mention it, and explain why it's not a concern.

Maxime

--x7nqwg6ptt372roy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCanx0egAKCRAnX84Zoj2+
dqCKAX9M4Eg7ur6UTQI/ZPTS1KOSErq0BFjnX7tppCoUddSuhClwMlqxwNYO4mah
UDkJkn8BgKJnhYqrTLBhbDlGgu9KMBEE6oWoZI0U2s8lzBsBehDX4vFnYHg/uRIw
/JTV2CQuaw==
=ZVyQ
-----END PGP SIGNATURE-----

--x7nqwg6ptt372roy--
