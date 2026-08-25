Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A33CC61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22AEC10E8BE;
	Tue, 25 Aug 2026 09:25:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AjGBqDmY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A2510E8BE
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 09:25:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A56D43EF9;
 Tue, 25 Aug 2026 09:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4581F000E9;
 Tue, 25 Aug 2026 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787649907;
 bh=PbN3JcQcN/L3rATe2NIMWLdEy42ZH2rNAQSCQj1aE2s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AjGBqDmYl95HbEszRccwf7Fh9YtlOkJEUTIRswM4CIfyKKfyZdu9m5W79hzAvoc2y
 v2yMwJIRRIaSn6pdUYxKN996TJBxPQrWDuwmfWrfrajhlhZvjqRsoAOWbd218CE8tZ
 BeAdGyvR3QMOTwf3T4jAET5ASFrzlZouVe2jNiwB2ytgB7xCG9C8aeYkP/SWfF97wn
 oCm+HFgigiMaqioxYh3Im78NZu2UNC4wfnQMheQBBpbyGbhbgb1P3x+tMqEeW0E+XH
 NUKkPd9FuAf4hujsXJQyHYPWD7W4nqh0VHITh5yJwcuKMS9eMEHi7w0dGyFFOUMkmR
 rGfa1cnqFKbmg==
Date: Tue, 25 Aug 2026 11:25:04 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>,
 Phong LE <ple@baylibre.com>, 
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-rockchip@lists.infradead.org, 
 Maud Spierings <maud_spierings@hotmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>
Subject: Re: [PATCH v10 22/69] drm/display: hdmi-state-helper: Sync SCDC
 state on hotplug
Message-ID: <20260825-potoo-of-imaginary-unity-7b0999@penduick>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-22-294364b2cf15@collabora.com>
 <20260820-accomplished-curly-bandicoot-cc36ba@houat>
 <774c38bd-6569-4aff-9fbc-a4e017840a55@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="wvp34r75zg2fljmn"
Content-Disposition: inline
In-Reply-To: <774c38bd-6569-4aff-9fbc-a4e017840a55@collabora.com>
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


--wvp34r75zg2fljmn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 22/69] drm/display: hdmi-state-helper: Sync SCDC
 state on hotplug
MIME-Version: 1.0

On Thu, Aug 20, 2026 at 05:44:08PM +0300, Cristian Ciocaltea wrote:
> On 8/20/26 11:53 AM, Maxime Ripard wrote:
> > On Fri, Jul 31, 2026 at 07:19:29PM +0300, Cristian Ciocaltea wrote:
> >> drm_atomic_helper_connector_hdmi_hotplug() does not currently
> >> synchronize SCDC status on hotplug events, leaving the scrambler state
> >> potentially inconsistent after (re)connect.
> >>
> >> Hook drm_connector_hdmi_sync_scdc() into both the connect and disconne=
ct
> >> paths, replacing the existing TODOs around missing scrambler handling.
> >>
> >> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> >> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS=
, Rock 5B
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 23 ++++++++++++++--=
-------
> >>  1 file changed, 14 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers=
/gpu/drm/display/drm_hdmi_state_helper.c
> >> index 4a93c279c9a7..3377ea936120 100644
> >> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> >> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> >> @@ -1205,13 +1205,16 @@ drm_atomic_helper_connector_hdmi_update(struct=
 drm_connector *connector,
> >>  					enum drm_connector_status status)
> >>  {
> >>  	const struct drm_edid *drm_edid;
> >> +	int ret =3D 0;
> >> =20
> >>  	if (status =3D=3D connector_status_disconnected) {
> >> -		// TODO: also handle scramber, HDMI sink disconnected.
> >> -		drm_connector_hdmi_audio_plugged_notify(connector, false);
> >> -		drm_edid_connector_update(connector, NULL);
> >> -		drm_connector_cec_phys_addr_invalidate(connector);
> >> -		return 0;
> >> +		ret =3D drm_connector_hdmi_sync_scdc(connector, false, ctx);
> >> +		if (ret !=3D -EDEADLK) {
> >> +			drm_connector_hdmi_audio_plugged_notify(connector, false);
> >> +			drm_edid_connector_update(connector, NULL);
> >> +			drm_connector_cec_phys_addr_invalidate(connector);
> >> +		}
> >=20
> > If there's a deadlock, shouldn't we restart the whole sequence there?
>=20
> In that case we do already propagate -EDEADLK and let the callers
> (drm_helper_probe_detect_ctx(), drm_helper_probe_single_connector_modes())
> to ensure the sequence is restarted.
>=20
> > Ie, we should return ret all the time anyway? And if we do that, we
> > should return ret for drm_edid_connector_update() too.
>=20
> Per .detect_ctx() contract, implementations shall return a drm_connector_=
status
> value or -EDEADLK only.  On the other hand, .force_ctx() accepts any erro=
r code,
> but the probe helpers just log it.  Hence returning anything else wouldn't
> really have an impact on the functionality.
>=20
> Returning errors from drm_edid_connector_update() would potentially overr=
ide
> non-deadlock ones from sync_scdc().  Since both helpers already log their=
 own
> failures, I think it isn't worth the trouble.
>=20
> > Either way, a comment on why we're doing it this way would be nice.
>=20
> Indeed.  Would the following be too verbose?
>=20
> /*
>  * The SCDC resync may reset the CRTC, which might involve aquiring
>  * modeset locks.  If that fails, -EDEADLK is reported and the callers
>  * passing a non-NULL @ctx drop the locks and restart the sequence
>  * - see drm_helper_probe_detect_ctx() and
>  * drm_helper_probe_single_connector_modes().
>  *
>  * The resync runs first, and the audio and CEC helpers only once the
>  * link state has settled: the CRTC reset is a blocking commit, so on
>  * success the pipeline is already up again, while on -EDEADLK nothing
>  * has been resynced yet and the pending retry redoes everything.  This
>  * keeps userspace from acting upon a link that is about to be reset.
>  *
>  * -EDEADLK is the only status gating the helpers below, as it is the
>  * sole one guaranteeing a new run.  The other failures are merely
>  * reported: .force_ctx() accepts any error code and the probe helpers
>  * just log it, while .detect_ctx() has to swallow it, being only
>  * allowed to return a drm_connector_status value or -EDEADLK.
>  * Propagating the status of drm_edid_connector_update() on top would
>  * therefore only make it compete with an earlier resync failure over a
>  * value that triggers no recovery, the more so as both helpers already
>  * log their own errors.
>  */

You can tell your LLM to be more terse :)

Something like the following would be enough:

  /*
   * detect_ctx can only ever return an status or EDEADLK. Handle deadlocks=
, and report any !EDEADLK error.
   */
  ret =3D drm_connector_hdmi_sync_scdc(connector, false, ctx);
  if (ret)
     if (ret =3D=3D -EDEADLK) {
     	return ret;
     } else {
       drm_warn(connector->dev, "ignored error");
     }

  drm_connector_hdmi_audio_plugged_notify(connector, false);               =
                                                                           =
                                                                           =
                              =20
  ret =3D drm_edid_connector_update(connector, NULL);
  if (ret)
       drm_warn(connector->dev, "ignored error");
  drm_connector_cec_phys_addr_invalidate(connector);                       =
                                                                           =
                                                                           =
                              =20

Maxime

--wvp34r75zg2fljmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCao1fagAKCRAnX84Zoj2+
doO/AXsHJJ+Pjgm/6U6AMxPeQmsysVDIATZzk+Au8YVBssNtT1JX5uZmay3DbuzX
hfXttckBfApSrRSD0trH7kEFJ3aiyLrWuM06roPQ1keiAc2PKZsUeEVaE71QuTOa
Yucxq/WxyQ==
=RRtf
-----END PGP SIGNATURE-----

--wvp34r75zg2fljmn--
