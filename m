Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E05CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6196B10F604;
	Fri, 19 Jun 2026 13:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KKR6zHVN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 195EB10F604
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 13:58:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8FAC40A01;
 Fri, 19 Jun 2026 13:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4593C1F000E9;
 Fri, 19 Jun 2026 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781877525;
 bh=7dHy2IMy05uC+053rssZh9G3s8xhfJQUnJqurH+rkC8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KKR6zHVNzHATTkVZSxjkH7R0nkURn4S4KcVzNVHCdvaZvzQwEVDiIzyWIFHY4LnCX
 k3mc7xPtvj824YeNJU4XbYWs4qAy9Kd0XZQaK4X4uwZLIQbV30Wb571M0Sul8LtV2H
 tSQVHWJfq9s+Tu0BSkUQ/JU/nsEOMlcnKJ4K0w+GawqLAToQgo0b2nPSuSmQJxLFVY
 6wUiA2JjI+TIdOK/1o/DETGPfcyFZkbnDV/q1qTsb4j/rN1jY8r0tViAqY/9H5MZY3
 1SyrTe9+oz2URRveEeNPkXpaO6dngHcTIaxgU4Nvb//KiiS2j9rSaieNzuA1ZNOoBm
 RJ4ji2RLZ4ELg==
Date: Fri, 19 Jun 2026 15:58:43 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 11/30] drm/display: bridge_connector: Wire up HDMI 2.0
 scrambler callbacks
Message-ID: <20260619-rough-jolly-poodle-bb7aed@houat>
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
 <20260602-dw-hdmi-qp-scramb-v7-11-445eb54ee1ed@collabora.com>
 <20260612-attractive-dashing-mule-309598@houat>
 <b14af457-0799-43cc-80b5-7ffff5901f24@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="sazsxitqywwstbp6"
Content-Disposition: inline
In-Reply-To: <b14af457-0799-43cc-80b5-7ffff5901f24@collabora.com>
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


--sazsxitqywwstbp6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 11/30] drm/display: bridge_connector: Wire up HDMI 2.0
 scrambler callbacks
MIME-Version: 1.0

On Fri, Jun 12, 2026 at 11:42:06PM +0300, Cristian Ciocaltea wrote:
> On 6/12/26 11:52 AM, Maxime Ripard wrote:
> > On Tue, Jun 02, 2026 at 01:44:11AM +0300, Cristian Ciocaltea wrote:
> >> Connect the bridge connector's .scrambler_{enable|disable} callbacks to
> >> the underlying bridge's .hdmi_scrambler_{enable|disable} funcs when
> >> DRM_BRIDGE_OP_HDMI_SCRAMBLER is advertised.
> >>
> >> This completes the bridge connector plumbing so that the SCDC
> >> scrambling helpers can control source-side scrambling through the
> >> bridge chain.
> >>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  drivers/gpu/drm/display/drm_bridge_connector.c | 41 +++++++++++++++++=
++++++++-
> >>  1 file changed, 40 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/=
gpu/drm/display/drm_bridge_connector.c
> >> index 9d21b1b57b0d..d048ab49eade 100644
> >> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> >> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> >> @@ -555,6 +555,32 @@ static int drm_bridge_connector_write_spd_infofra=
me(struct drm_connector *connec
> >>  	return bridge->funcs->hdmi_write_spd_infoframe(bridge, buffer, len);
> >>  }
> >> =20
> >> +static int drm_bridge_connector_scrambler_enable(struct drm_connector=
 *connector)
> >> +{
> >> +	struct drm_bridge_connector *bridge_connector =3D
> >> +		to_drm_bridge_connector(connector);
> >> +	struct drm_bridge *bridge;
> >> +
> >> +	bridge =3D bridge_connector->bridge_hdmi;
> >> +	if (!bridge)
> >> +		return -EINVAL;
> >> +
> >> +	return bridge->funcs->hdmi_scrambler_enable(bridge);
> >> +}
> >> +
> >> +static int drm_bridge_connector_scrambler_disable(struct drm_connecto=
r *connector)
> >> +{
> >> +	struct drm_bridge_connector *bridge_connector =3D
> >> +		to_drm_bridge_connector(connector);
> >> +	struct drm_bridge *bridge;
> >> +
> >> +	bridge =3D bridge_connector->bridge_hdmi;
> >> +	if (!bridge)
> >> +		return -EINVAL;
> >> +
> >> +	return bridge->funcs->hdmi_scrambler_disable(bridge);
> >> +}
> >> +
> >>  static const struct drm_edid *
> >>  drm_bridge_connector_read_edid(struct drm_connector *connector)
> >>  {
> >> @@ -580,7 +606,7 @@ static const struct drm_connector_hdmi_funcs drm_b=
ridge_connector_hdmi_funcs =3D {
> >>  		.clear_infoframe =3D drm_bridge_connector_clear_hdmi_infoframe,
> >>  		.write_infoframe =3D drm_bridge_connector_write_hdmi_infoframe,
> >>  	},
> >> -	/* audio, hdr_drm and spd are set dynamically during init */
> >> +	/* scrambler, audio, hdr_drm and spd are set dynamically during init=
 */
> >>  };
> >> =20
> >>  static const struct drm_connector_infoframe_funcs drm_bridge_connecto=
r_hdmi_audio_infoframe =3D {
> >> @@ -886,6 +912,11 @@ struct drm_connector *drm_bridge_connector_init(s=
truct drm_device *drm,
> >>  			     !bridge->funcs->hdmi_clear_spd_infoframe))
> >>  				return ERR_PTR(-EINVAL);
> >> =20
> >> +			if (bridge->ops & DRM_BRIDGE_OP_HDMI_SCRAMBLER &&
> >> +			    (!bridge->funcs->hdmi_scrambler_enable ||
> >> +			     !bridge->funcs->hdmi_scrambler_disable))
> >> +				return ERR_PTR(-EINVAL);
> >> +
> >>  			bridge_connector->bridge_hdmi =3D drm_bridge_get(bridge);
> >> =20
> >>  			if (bridge->supported_formats)
> >> @@ -990,6 +1021,14 @@ struct drm_connector *drm_bridge_connector_init(=
struct drm_device *drm,
> >>  			bridge_connector->hdmi_funcs.spd =3D
> >>  				drm_bridge_connector_hdmi_spd_infoframe;
> >> =20
> >> +		if (bridge_connector->bridge_hdmi->ops & DRM_BRIDGE_OP_HDMI_SCRAMBL=
ER) {
> >> +			bridge_connector->hdmi_funcs.scrambler_enable =3D
> >> +				drm_bridge_connector_scrambler_enable;
> >> +			bridge_connector->hdmi_funcs.scrambler_disable =3D
> >> +				drm_bridge_connector_scrambler_disable;
> >> +			connector->hdmi.scrambler_supported =3D true;
> >> +		}
> >> +
> >=20
> > I think we're taking this backwards. The scrambler support isn't
> > optional: either the controller supports HDMI < 2.0, and then it doesn't
> > exist, or it supports >=3D 2.0 and then it's mandatory.
> >=20
> > You're considering it optional here, when it's never actually optional
> > (unlike YUV420 for example)
> >=20
> > I still think we should list, somehow, the capabilities of the
> > controller to the helpers, like max tmds rate supported, formats, etc.
> > We've so far put everything as an argument to drmm_connector_hdmi_init
> > but it becomes a bit overloaded, and I wonder if introducing a callback
> > wouldn't solve this, kind of like what we have for planes and formats.
>=20
>=20
> What about introducing something like:
>=20
> struct drm_connector_hdmi_caps {
>     ...
>     unsigned int supported_formats;
>     enum hdmi_version supported_hdmi_ver;
> };
>=20
> struct drm_connector_hdmi_funcs {
>     ...
>     int (*get_caps)(struct drm_connector *connector,
>                     struct drm_connector_hdmi_caps *caps);
>     ...
> };
>=20
> int drmm_connector_hdmi_init(struct drm_device *dev, ...)
> {
>     ...
>     if (hdmi_funcs->get_caps) {
>         struct drm_connector_hdmi_caps caps =3D { };
>=20
>         ret =3D hdmi_funcs->get_caps(connector, &caps);
>         if (ret)
>             return ret;
>=20
>         connector->hdmi.supported_formats  =3D caps.supported_formats;
>         ...
>         if (caps.supported_hdmi_ver > HDMI_2_0)
>             connector->hdmi.frl_supported =3D true;
>         else if (caps.supported_hdmi_ver =3D=3D HDMI_2_0)
>             connector->hdmi.scrambler_supported =3D true;
>     }
>     ...
> }

That's what I initially had in mind, but it feels a bit over-the-top
when looking at it. I think I'd really like something that drivers
cannot forget about, screw up and/or mess with, so for example report
HDMI 2.1 but force disable FRL support, or report HDMI 1.4 but support
YUV420.

Adding more arguments to drm_connector_hdmi_init could work I guess, but
it won't scale to everything we need. Expecting the callers to fill
drm_connector_hdmi won't work either. So I somewhat think a get_caps
like we discussed is the less bad solution, but I'm definitely open to
suggestions.

> Not sure if max_tmds_char_rate should be listed as a capability, as we al=
ready
> have the .tmds_char_rate_valid() callback.

I guess it would make sense to move it there and consolidate
atomic_check / mode_valid checks, but I don't think it should be a
prerequisite for this patch either.

Maxime

--sazsxitqywwstbp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajVLDwAKCRAnX84Zoj2+
dnCEAYCOgXcDF9Oq4SiWJxWRNVN7nHEoV/jZOzr6KKyq+NfMYAGB64FhxdI8Jlga
EYRGPHsBfRfhXDC1fvjVdUW6o6PVMaHsji7GT+5Nw48HfxDiCeLFuXTvy/+wx5a2
fMWcqXooFA==
=w7pg
-----END PGP SIGNATURE-----

--sazsxitqywwstbp6--
