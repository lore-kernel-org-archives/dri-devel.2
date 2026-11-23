Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C1606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMCqUx1r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11A510ECB7;
	Mon, 23 Nov 2026 10:58:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169A610E375
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:58:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB93D40781;
 Mon, 23 Nov 2026 10:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C4B1F000C0;
 Mon, 23 Nov 2026 10:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795431487;
 bh=55vp1rgyy0L+BcAK3ve3ZlJ1e2OePWPl2FZy/TQWsXw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fMCqUx1rfzUSVGsb2g0v260dZoKckJsNK6pNC67P0cpDtalX7T7xXKtnQ/MLFd4vf
 xSiYl3UhLsnFAeJrPoa/UIjXiAv+jZtjdgr1ePFEzaS1IPb4nJigdsx0q7QSthD3dn
 LmSMuBSDjgL9FZn12KGwEhm4lm05VY0L0cWmljwrqfIn6p4lB4eU2JsSkkVDZYgARS
 2ByMtEXj6klidW0eWPtax8Q53EA3FSqnRVRK3qk5m1bcJtfBBj/Rqx5BBC4UpopBbK
 pcbUrNkETezyGAWE1C2xAkTn1lBZd+03j9gKeQNwgvRogqYWRtnRbqzJnomX5aUV+C
 RDVnZS5UIAOIw==
Date: Mon, 23 Nov 2026 11:58:04 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] drm/panel: Add sro_install hook
Message-ID: <awQb7eQd6P7NatX4@houat>
References: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
 <20261122153032.2782768-3-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ha574b4xdcjtwxnj"
Content-Disposition: inline
In-Reply-To: <20261122153032.2782768-3-dario.binacchi@amarulasolutions.com>
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


--ha574b4xdcjtwxnj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 2/8] drm/panel: Add sro_install hook
MIME-Version: 1.0

Hi,

On Sun, Nov 22, 2026 at 04:30:02PM +0100, Dario Binacchi wrote:
> The panel bridge assumes the panel is enabled whenever its pipeline
> is read out as active, but the panel is left marked as unprepared and
> disabled. The following disable is then skipped, and the panel driver
> never gets the chance to acquire the resources it will release when
> unprepared.
>=20
> Add the sro_install hook, called when the state read out from the
> hardware is installed. On success the panel is marked as prepared and
> enabled.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>=20
>  drivers/gpu/drm/drm_panel.c | 16 ++++++++++++++++
>  include/drm/drm_panel.h     | 10 ++++++++++
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index bef0e6af73ba..daccf98e5513 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -346,6 +346,21 @@ panel_bridge_connector_readout(struct drm_bridge *br=
idge,
>  	return 0;
>  }
> =20
> +static void panel_bridge_install_state(struct drm_bridge *bridge,
> +				       struct drm_bridge_state *bridge_state)
> +{
> +	struct drm_panel *panel =3D drm_bridge_to_panel(bridge);
> +
> +	if (!panel->funcs || !panel->funcs->sro_install)
> +		return;
> +
> +	if (panel->funcs->sro_install(panel))
> +		return;
> +
> +	panel->prepared =3D true;
> +	panel->enabled =3D true;
> +}
> +
>  static const struct drm_bridge_funcs panel_bridge_bridge_funcs =3D {
>  	.attach =3D panel_bridge_attach,
>  	.detach =3D panel_bridge_detach,
> @@ -360,6 +375,7 @@ static const struct drm_bridge_funcs panel_bridge_bri=
dge_funcs =3D {
>  	.atomic_get_input_bus_fmts =3D drm_atomic_helper_bridge_propagate_bus_f=
mt,
>  	.debugfs_init =3D panel_bridge_debugfs_init,
>  	.atomic_sro_readout_state =3D panel_bridge_readout_state,
> +	.atomic_sro_install_state =3D panel_bridge_install_state,
>  	.atomic_sro_compare_state =3D drm_atomic_helper_bridge_compare_state,
>  	.atomic_sro_connector_readout =3D panel_bridge_connector_readout,
>  };
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 58113ea7d63a..66f9fc0828f1 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -148,6 +148,16 @@ struct drm_panel_funcs {
>  	 * Allows panels to create panels-specific debugfs files.
>  	 */
>  	void (*debugfs_init)(struct drm_panel *panel, struct dentry *root);
> +
> +	/**
> +	 * @sro_install:
> +	 *
> +	 * Acquire the resources of a panel found enabled when the hardware
> +	 * state was read out, without touching the hardware.
> +	 *
> +	 * This function is optional.
> +	 */
> +	int (*sro_install)(struct drm_panel *panel);

In the panel context, I'm not sure "install" is the better word here
since we don't have any state to install in the first place.
"sro_enable_resources" maybe?

Maxime

--ha574b4xdcjtwxnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawQcPAAKCRAnX84Zoj2+
dvBkAYCiIabbXhEPWOXGEzLDWnXhRX31FO3NJrLjEZgy0AX+Ptd3X5P9XLNjRF5b
eMxjDcYBegOfUhSrwp8IqSnJA4SnFZqhcZrXkZHXfCwqO1x8/7P3c4D0ivrNpsLW
bUmdSbMXFQ==
=C5UR
-----END PGP SIGNATURE-----

--ha574b4xdcjtwxnj--
