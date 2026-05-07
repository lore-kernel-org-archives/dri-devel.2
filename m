Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618A6CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F0410F1A3;
	Thu,  7 May 2026 14:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gUmfUBRK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B7210F1A3
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 14:57:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 58C9A419EA;
 Thu,  7 May 2026 14:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA878C2BCB2;
 Thu,  7 May 2026 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778165839;
 bh=Zj9goVZkk3uH3KcKgVT6uhDP1rHu9LmB95T0Lu/5iD4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gUmfUBRKvaW4imTXyrJQLH2gaLVPQdBnvUPHdNHVt3fJLkmOob9V5NSY1z5sMgKxj
 uHovTxAMxA0vNeQCFRI6GwptwZzXTZZ337ZdL3QPwrh7ceU34uPOSGj+tLtx3k1wJD
 cJc8E3QZzuI6ngUH45rSF+22lHvwB3PhBuInORqw9CvoAMLCgG01013Sq52y7ND2In
 /EbsFIBpzUG71JF22BLFoX4msEw1H/NzQXX1JY0g+0W5OZ6bQnA3TvIzrAVMKK0t8u
 076ZcgzXXQifgkmr+mjqp2jhyk/1K191qS4fRf5j/PMgtsJOgu2yrNK2hnTxQPVucq
 h/NKw0kTbhh7Q==
Date: Thu, 7 May 2026 16:57:16 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Michael Tretter <m.tretter@pengutronix.de>, 
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] drm/panel: Make drm_panel_init() static
Message-ID: <20260507-premium-curious-macaw-d43cbe@houat>
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-10-51f448c7c291@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="3la7iaptlro7xr2g"
Content-Disposition: inline
In-Reply-To: <20260507-drm_panel_init_rm-v1-10-51f448c7c291@redhat.com>
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


--3la7iaptlro7xr2g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 10/10] drm/panel: Make drm_panel_init() static
MIME-Version: 1.0

Hi,

On Thu, May 07, 2026 at 01:53:08PM +0200, Albert Esteve wrote:
> Now that all panel drivers use devm_drm_panel_alloc(),
> there are no external callers of drm_panel_init().
> Make it static to prevent new users from bypassing the
> refcounted allocation path.
>=20
> Remove stale references to drm_panel_init() in kdocs.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
>  drivers/gpu/drm/drm_panel.c             | 8 ++++----
>  include/drm/drm_panel.h                 | 4 ----
>  3 files changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index a697cc227e289..380ebf0fad2be 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -4626,7 +4626,7 @@ static const struct backlight_ops dp_aux_bl_ops =3D=
 {
>   * Backlight will then be handled transparently without requiring
>   * any intervention from the driver.
>   *
> - * drm_panel_dp_aux_backlight() must be called after the call to drm_pan=
el_init().
> + * drm_panel_dp_aux_backlight() must be called after devm_drm_panel_allo=
c().
>   *
>   * Return: 0 on success or a negative error code on failure.
>   */
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index d1e6598ea3bc0..e3e1c5ceb8ff8 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -56,8 +56,9 @@ static LIST_HEAD(panel_list);
>   * Initialize the panel structure for subsequent registration with
>   * drm_panel_add().
>   */
> -void drm_panel_init(struct drm_panel *panel, struct device *dev,
> -		    const struct drm_panel_funcs *funcs, int connector_type)
> +static void drm_panel_init(struct drm_panel *panel, struct device *dev,
> +			   const struct drm_panel_funcs *funcs,
> +			   int connector_type)
>  {
>  	if (connector_type =3D=3D DRM_MODE_CONNECTOR_Unknown)
>  		DRM_WARN("%s: %s: a valid connector type is required!\n", __func__, de=
v_name(dev));
> @@ -69,7 +70,6 @@ void drm_panel_init(struct drm_panel *panel, struct dev=
ice *dev,
>  	panel->funcs =3D funcs;
>  	panel->connector_type =3D connector_type;
>  }
> -EXPORT_SYMBOL(drm_panel_init);
> =20
>  /**
>   * drm_panel_add - add a panel to the global registry
> @@ -708,7 +708,7 @@ EXPORT_SYMBOL(devm_drm_panel_add_follower);
>   * A typical implementation for a panel driver supporting device tree
>   * will call this function at probe time. Backlight will then be handled
>   * transparently without requiring any intervention from the driver.
> - * drm_panel_of_backlight() must be called after the call to drm_panel_i=
nit().
> + * drm_panel_of_backlight() must be called after devm_drm_panel_alloc().

I think we can drop that sentence entirely. Now that we can only get a
panel structure through devm_drm_panel_alloc, and that it also
initializes it, we can't call drm_panel_of_backlight before having an
initialized drm_panel.

Maxime

--3la7iaptlro7xr2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCafyoSwAKCRAnX84Zoj2+
dvSIAX9U56ZHrDNtQnIQRYt3f8eEAzO6UVKoMIMDAm/gvUcNk3EafoLUQP8NeQYj
3So15UcBf19f/KH9ZAWRXGI3flN+olcDyE73XIJKV2mZSsLQ5Al7XAzy/81rBJV/
C7t3214oFg==
=jEIC
-----END PGP SIGNATURE-----

--3la7iaptlro7xr2g--
