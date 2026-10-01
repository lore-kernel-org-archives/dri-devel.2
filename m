Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE9ECA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A026310E328;
	Thu,  1 Oct 2026 09:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AxL7ENDT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFCE10E328;
 Thu,  1 Oct 2026 09:07:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 480326022F;
 Thu,  1 Oct 2026 09:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777241F000FF;
 Thu,  1 Oct 2026 09:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790845633;
 bh=UCX2fjAUxBiw0xNMGGZLheeHyZmV+sSFaQePCO29N14=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AxL7ENDTqEd2yfzG08HxH4tTcPM6U//KXX+DVrTzoHc+MesUklusYRds4GqlkYajz
 j08HsOuJH+XQXCulxE1XKZ2oAkxRvILE3/TSNYqKqDY1fSJ/M0mfZ53Bt1J5Yb1dwp
 BjqPQsZnHFQrRvXPsQk7fSkBS0mDBZGtU2+0wWsPkGrGsUBEMQn5BDMY9fDlxOCGez
 p85TplWmrKS/SmMxB7SLkEeiG2A3bmFbK8wf3Swci/jZTd0BDK7BTyui0lyUmPKT6r
 /vob0gpXy9bJM8EPMhz35Dj0jLbsEQ+fNTwI3+N6tlC2GyzKWq64B8qq4PPo1EajoY
 KFIyCE6vHlcMg==
Date: Thu, 1 Oct 2026 11:07:09 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 01/13] drm/atomic: Handle max bpc properties before
 connector state allocation
Message-ID: <ar4hkqz_yLhnk1Kl@houat>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-1-dbbf8b2b42bc@radxa.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="kpkqepbvurj5oxr5"
Content-Disposition: inline
In-Reply-To: <20260930-msm-dp-hdr10-v1-1-dbbf8b2b42bc@radxa.com>
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


--kpkqepbvurj5oxr5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/13] drm/atomic: Handle max bpc properties before
 connector state allocation
MIME-Version: 1.0

Hi,

On Wed, Sep 30, 2026 at 08:41:45PM +0800, Xilin Wu wrote:
> Bridge connectors can attach the max bpc property before their atomic
> state is allocated by drm_mode_config_reset(). Unconditionally updating
> connector->state in drm_connector_attach_max_bpc_property() dereferences
> a NULL pointer in this case. Adding max bpc support to MSM DP and eDP
> exposes this during display initialization, before a framebuffer console
> is available.
>=20
> Only update an existing state when attaching the property. Initialize
> max_requested_bpc and max_bpc from the property range when creating a
> connector state so that deferred allocation and subsequent resets both
> restore the default. Avoid leaving the bit depth at zero after reset,
> which would otherwise cause valid display configurations to be rejected.
>=20
> With MSM DP max bpc support applied, this also restores boot on the Lenovo
> Yoga Slim 7x.
>=20
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 5 +++++
>  drivers/gpu/drm/drm_connector.c           | 6 ++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/=
drm_atomic_state_helper.c
> index a2ef272e9f27..91d60bc7a2b2 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -34,6 +34,7 @@
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_plane.h>
>  #include <drm/drm_print.h>
> +#include <drm/drm_property.h>
>  #include <drm/drm_vblank.h>
>  #include <drm/drm_writeback.h>
> =20
> @@ -495,6 +496,10 @@ __drm_atomic_helper_connector_state_init(struct drm_=
connector_state *conn_state,
>  					 struct drm_connector *connector)
>  {
>  	conn_state->connector =3D connector;
> +	if (connector->max_bpc_property) {
> +		conn_state->max_requested_bpc =3D connector->max_bpc_property->values[=
1];
> +		conn_state->max_bpc =3D conn_state->max_requested_bpc;
> +	}

You should use drm_object_property_get_default_value() here

>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_connector_state_init);
> =20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 8b4baed060f3..34c30469f405 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2886,8 +2886,10 @@ int drm_connector_attach_max_bpc_property(struct d=
rm_connector *connector,
>  	}
> =20
>  	drm_object_attach_property(&connector->base, prop, max);
> -	connector->state->max_requested_bpc =3D max;
> -	connector->state->max_bpc =3D max;
> +	if (connector->state) {
> +		connector->state->max_requested_bpc =3D max;
> +		connector->state->max_bpc =3D max;
> +	}


Doesn't that also remove the new state allocation we have everywhere
(like in drmm_connector_hdmi_init, meson_encoder_hdmi_probe,
dw_hdmi_connector_create, etc.)

Maxime

--kpkqepbvurj5oxr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar4iuQAKCRAnX84Zoj2+
do9dAX92jUSipyFA0sv+CsXUvNVb3eVKSWUdl/fnfOlhHM1i4Pm+uQphL0gdRMWC
+KJKdYYBf3dlbJz5JR50vTOYdMo+ATs4m6GpxcFJPjZtArOK/pY47JWP6bKCq62k
30SzdCxJ3Q==
=PZMS
-----END PGP SIGNATURE-----

--kpkqepbvurj5oxr5--
