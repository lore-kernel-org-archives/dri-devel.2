Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5EDC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB9310E20A;
	Thu, 20 Aug 2026 16:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XwWNvs61";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A7C10E20A
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:56:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 098AE43290;
 Thu, 20 Aug 2026 16:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE071F00A3F;
 Thu, 20 Aug 2026 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787244980;
 bh=1wz94m8/Rm1BrMXn5KssOA7yWJrCLD7GNr6D+TpdcXw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XwWNvs61m0jU8bunTOwQb0NDf9WBSgVXWyHvDzDDawCmg9TXPX7nzV5/7QitjEGcP
 eb7k7IfUIJnL40IyIvRO0cmdBG0jzi3em+hHpBwmta2680bzMlvfsDYDNvb3bOoVEJ
 iVV/EWTx07Zoz9fH2J/o6wY2C27KHOE2y+yyCg+SND5ix9K8ENPWSrThDdWmym/A8F
 KZULyocJyQ2k0B2XZn049DE/gatDKO98z7v0uRTlfw87QykHsudOr2Q0SSenE1ZH0S
 W3bF0Kop25gzUNkAFydXaUBTTFre8/8ehbBoO4zy9Zsmbxy3ZHXhtyw147SdohayrN
 9VeK18667sKZg==
Date: Thu, 20 Aug 2026 18:56:18 +0200
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
Subject: Re: [PATCH v10 07/69] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
Message-ID: <20260820-gorgeous-adder-of-reading-5a93f3@houat>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-7-294364b2cf15@collabora.com>
 <20260819-amigurumi-lorikeet-of-infinity-fd8c2d@houat>
 <ad65a396-02fb-4816-b978-e3a0c46688b2@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="vcfsf3o7dsosajam"
Content-Disposition: inline
In-Reply-To: <ad65a396-02fb-4816-b978-e3a0c46688b2@collabora.com>
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


--vcfsf3o7dsosajam
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 07/69] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
MIME-Version: 1.0

On Wed, Aug 19, 2026 at 10:33:04PM +0300, Cristian Ciocaltea wrote:
> On 8/19/26 1:12 PM, Maxime Ripard wrote:
> > On Fri, Jul 31, 2026 at 07:19:14PM +0300, Cristian Ciocaltea wrote:
> >> Add the connector-level infrastructure to support HDMI 2.0 scrambling:
> >>
> >> - A drm_connector_hdmi_scrambler_supported() helper to report whether
> >>   the source supports the scrambling capability, based on the presence
> >>   of the newly introduced .scrambler_{enable|disable}() callbacks in
> >>   drm_connector_hdmi_funcs are mandatory
> >> - A scrambler_needed flag to be managed by the hdmi state helpers based
> >>   on the negotiated TMDS character rate and the source/sink scrambling
> >>   capabilities
> >> - A scrambler_enabled flag to track whether scrambling is currently
> >>   active
> >> - A delayed work item (scdc_work) to monitor sink-side scrambling stat=
us
> >>   and retry the setup if the sink resets it
> >> - A scdc_work_initialized flag to support lazy initialization of the
> >>   work item on the first scrambling enable and guard the teardown paths
> >>
> >> These are intended to be used by SCDC scrambling helpers to coordinate
> >> scrambling setup and teardown between the source driver and the DRM
> >> core.
> >>
> >> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> >> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS=
, Rock 5B
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  drivers/gpu/drm/drm_connector.c | 31 ++++++++++++---
> >>  include/drm/drm_connector.h     | 83 ++++++++++++++++++++++++++++++++=
+++++++++
> >>  2 files changed, 109 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_con=
nector.c
> >> index 4721cdeafc84..a18410faf040 100644
> >> --- a/drivers/gpu/drm/drm_connector.c
> >> +++ b/drivers/gpu/drm/drm_connector.c
> >> @@ -622,12 +622,29 @@ int drmm_connector_hdmi_init(struct drm_device *=
dev,
> >>  	 * default with the actual controller capability. A value of zero ke=
eps
> >>  	 * the limit inferred from supported_hdmi_ver.
> >>  	 */
> >> -	if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_2_0)
> >> +	if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_2_0) {
> >> +		if (!hdmi_funcs->scrambler_enable || !hdmi_funcs->scrambler_disable=
) {
> >> +			drm_err(dev, "Scrambler callbacks missing for HDMI 2.x\n");
> >> +			return -EINVAL;
> >> +		}
> >> +
> >>  		connector->hdmi.max_tmds_char_rate =3D HDMI_2_0_TMDS_CHAR_RATE_MAX_=
HZ;
> >> -	else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_3)
> >> -		connector->hdmi.max_tmds_char_rate =3D HDMI_1_3_TMDS_CHAR_RATE_MAX_=
HZ;
> >> -	else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_0)
> >> -		connector->hdmi.max_tmds_char_rate =3D HDMI_1_0_TMDS_CHAR_RATE_MAX_=
HZ;
> >> +	} else {
> >> +		/*
> >> +		 * Scrambler callbacks are only valid for connectors advertising
> >> +		 * HDMI 2.0 capability. drm_connector_hdmi_scrambler_supported()
> >> +		 * relies on their presence to report scrambling support.
> >> +		 */
> >> +		if (hdmi_funcs->scrambler_enable || hdmi_funcs->scrambler_disable) {
> >> +			drm_err(dev, "Scrambler callbacks unexpected for HDMI 1.x\n");
> >> +			return -EINVAL;
> >> +		}
> >> +
> >> +		if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_3)
> >> +			connector->hdmi.max_tmds_char_rate =3D HDMI_1_3_TMDS_CHAR_RATE_MAX=
_HZ;
> >> +		else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_0)
> >> +			connector->hdmi.max_tmds_char_rate =3D HDMI_1_0_TMDS_CHAR_RATE_MAX=
_HZ;
> >> +	}
> >=20
> > I'd put it into a separate test (possibly earlier). Merging both the
> > tmds rate default and the scrambler callbacks check makes it messier
> > than it would be if we had two separate tests.
>=20
> Ack. How about the following?
>=20
> 	if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_2_0)
> 		connector->hdmi.max_tmds_char_rate =3D HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
> 	else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_3)
> 		connector->hdmi.max_tmds_char_rate =3D HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
> 	else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_0)
> 		connector->hdmi.max_tmds_char_rate =3D HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
>=20
> 	if (hdmi_funcs->supported_tmds_char_rate) {
> 		if (hdmi_funcs->supported_tmds_char_rate > connector->hdmi.max_tmds_cha=
r_rate) {
> 			drm_err(dev, "Enforced max_tmds_char_rate exceeds %llu spec limit\n",
> 				connector->hdmi.max_tmds_char_rate);
> 			return -EINVAL;
> 		}
>=20
> 		connector->hdmi.max_tmds_char_rate =3D hdmi_funcs->supported_tmds_char_=
rate;
> 	}
>=20
> 	if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_2_0) {
> 		if (!hdmi_funcs->scrambler_enable || !hdmi_funcs->scrambler_disable) {
> 			drm_err(dev, "Scrambler callbacks missing for HDMI 2.x\n");
> 			return -EINVAL;
> 		}
> 	} else {
> 		/*
> 		 * Scrambler callbacks are only valid for connectors advertising
> 		 * HDMI 2.0 capability. drm_connector_hdmi_scrambler_supported()
> 		 * relies on their presence to report scrambling support.
> 		 */
> 		if (hdmi_funcs->scrambler_enable || hdmi_funcs->scrambler_disable) {
> 			drm_err(dev, "Scrambler callbacks unexpected for HDMI 1.x\n");
> 			return -EINVAL;
> 		}
> 	}

I don't think we need the else clause at all. It's not valid, but it's
also not creating any issue.

I'd move that second check earlier together with the infoframe callbacks
checks and so on too.

>=20
> >>  	if (hdmi_funcs->supported_tmds_char_rate) {
> >>  		if (hdmi_funcs->supported_tmds_char_rate > connector->hdmi.max_tmds=
_char_rate) {
> >> @@ -635,6 +652,7 @@ int drmm_connector_hdmi_init(struct drm_device *de=
v,
> >>  				connector->hdmi.max_tmds_char_rate);
> >>  			return -EINVAL;
> >>  		}
> >> +
> >>  		connector->hdmi.max_tmds_char_rate =3D hdmi_funcs->supported_tmds_c=
har_rate;
> >>  	}
>=20
> [...]
>=20
> >> +	/**
> >> +	 * @scdc_work: Work item currently used to monitor sink-side scrambl=
ing
> >> +	 * status and retry setup if the sink resets it.
> >> +	 */
> >> +	struct delayed_work scdc_work;
> >> +
> >> +	/**
> >> +	 * @scdc_work_initialized: Tracks whether @scdc_work has been set up=
 via
> >> +	 * INIT_DELAYED_WORK(). The work item is initialized lazily on the f=
irst
> >> +	 * scrambling enable, so this guards the teardown paths against touc=
hing
> >> +	 * an uninitialized work item.
> >> +	 */
> >> +	bool scdc_work_initialized;
> >> +
> >=20
> > Why should we track whether it's initialized or not? I'd always
> > initialize it, but only ever schedule something if we're using the
> > scrambler.
>=20
> Having this initialized in the connector would lead to a module dependency
> cycle.
>=20
> Currently the work function lives in drm_hdmi_helper.c, which is built in=
to
> drm_display_helper module:
>=20
> static void drm_connector_hdmi_scdc_work(struct work_struct *work)
> {
> 	[...]
> 	if (READ_ONCE(connector->hdmi.scrambler_enabled) &&
> 	    !drm_scdc_get_scrambling_status(connector))
> 		drm_connector_hdmi_try_scrambling_setup(connector);
> 	[...]
> }
>=20
> int drm_connector_hdmi_enable_scrambling(struct drm_connector *connector,
> 					 const struct drm_connector_state *conn_state)
> {
>=20
> 	[...]
> 	if (!hdmi->scdc_work_initialized) {
> 		INIT_DELAYED_WORK(&hdmi->scdc_work,
> 				  drm_connector_hdmi_scdc_work);
> 		hdmi->scdc_work_initialized =3D true;
> 	}
> 	[...]
> }
>=20
> If we move INIT_DELAYED_WORK() into the connector (i.e. in drm.ko), the w=
ork
> function has to be reachable from there.  The following attempts to accom=
plish
> that would fail:
>
> - Keep the work function in drm_hdmi_helper.c and export it from
>   drm_display_helper.
>=20
> - Move the work function into drm_connector.c and export=20
>   drm_connector_hdmi_try_scrambling_setup(), or a wrapper function, from=
=20
>   drm_display_helper.

An alternative could be to move drm_connector_hdmi_init to
drm_hdmi_helper.c, no?

But yeah, if we can't let's keep it like that

Maxime

--vcfsf3o7dsosajam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaocxqwAKCRAnX84Zoj2+
duntAX9b4qHmIxNoYBU09FH1xHZGZIM8WVkRnpW7Fe4HJg3OVIukpHrME24FF+Ay
mjvaSgYBfik5n9TxNkKo9tCCKfzaUvGQjmaGBQvz3IXZQhNMcf/QMEomOQCdDwCr
gfNztp2WXg==
=a5cR
-----END PGP SIGNATURE-----

--vcfsf3o7dsosajam--
