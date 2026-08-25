Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F8DC5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F40910E995;
	Tue, 25 Aug 2026 09:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YoLwcGy9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A98310E995
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 09:29:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F06D6011F;
 Tue, 25 Aug 2026 09:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A670C1F000E9;
 Tue, 25 Aug 2026 09:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787650196;
 bh=kDhALPMamfs8J9DX/MUW6kSV45nkQCQ8DCdIurOOpto=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YoLwcGy9xPn4EOaPipJ13rzqF+5OQHK0Ng4I2Pzmj048hObkYrSsmDtadOYin//0k
 9HwjRq4b15ha7NU86cMwHbio7y24oVOSBoxIwEweHTDnlXbDQ6tEJUscNOGfH/2Q8B
 DEva+o3WM8ntPLJFKMT/hC2XAJCtPqXXqMtvrTMnU2BYM9QGIIwjgDNAirY9Edes7o
 3xbojB0hO3r2jgJ5u4eaYW0REwPkciJxCEfgs7cdpH7HhGXPgCFB6dac7OdN7Wbrb1
 B6BGL4bManH+w8UDKu4Umn/vTLM0TxUISXLNYYxq1ZXs7Fnpw0SNruG9t/9fAVpbB8
 c53su173V4iWw==
Date: Tue, 25 Aug 2026 11:29:53 +0200
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
Message-ID: <20260825-massive-jolly-agama-a95e3d@penduick>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-7-294364b2cf15@collabora.com>
 <20260819-amigurumi-lorikeet-of-infinity-fd8c2d@houat>
 <ad65a396-02fb-4816-b978-e3a0c46688b2@collabora.com>
 <20260820-gorgeous-adder-of-reading-5a93f3@houat>
 <28743613-22ec-4208-ad55-d018764bf846@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="rknqritovu2w3mde"
Content-Disposition: inline
In-Reply-To: <28743613-22ec-4208-ad55-d018764bf846@collabora.com>
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


--rknqritovu2w3mde
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 07/69] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
MIME-Version: 1.0

On Fri, Aug 21, 2026 at 10:04:14PM +0300, Cristian Ciocaltea wrote:
> On 8/20/26 7:56 PM, Maxime Ripard wrote:
> > On Wed, Aug 19, 2026 at 10:33:04PM +0300, Cristian Ciocaltea wrote:
> >> On 8/19/26 1:12 PM, Maxime Ripard wrote:
> >>> On Fri, Jul 31, 2026 at 07:19:14PM +0300, Cristian Ciocaltea wrote:
> >>>> Add the connector-level infrastructure to support HDMI 2.0 scramblin=
g:
> >>>>
> >>>> - A drm_connector_hdmi_scrambler_supported() helper to report whether
> >>>>   the source supports the scrambling capability, based on the presen=
ce
> >>>>   of the newly introduced .scrambler_{enable|disable}() callbacks in
> >>>>   drm_connector_hdmi_funcs are mandatory
> >>>> - A scrambler_needed flag to be managed by the hdmi state helpers ba=
sed
> >>>>   on the negotiated TMDS character rate and the source/sink scrambli=
ng
> >>>>   capabilities
> >>>> - A scrambler_enabled flag to track whether scrambling is currently
> >>>>   active
> >>>> - A delayed work item (scdc_work) to monitor sink-side scrambling st=
atus
> >>>>   and retry the setup if the sink resets it
> >>>> - A scdc_work_initialized flag to support lazy initialization of the
> >>>>   work item on the first scrambling enable and guard the teardown pa=
ths
> >>>>
> >>>> These are intended to be used by SCDC scrambling helpers to coordina=
te
> >>>> scrambling setup and teardown between the source driver and the DRM
> >>>> core.
> >>>>
> >>>> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> >>>> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 L=
TS, Rock 5B
> >>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >>>> ---
> >>>>  drivers/gpu/drm/drm_connector.c | 31 ++++++++++++---
> >>>>  include/drm/drm_connector.h     | 83 ++++++++++++++++++++++++++++++=
+++++++++++
> >>>>  2 files changed, 109 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_c=
onnector.c
> >>>> index 4721cdeafc84..a18410faf040 100644
> >>>> --- a/drivers/gpu/drm/drm_connector.c
> >>>> +++ b/drivers/gpu/drm/drm_connector.c
> >>>> @@ -622,12 +622,29 @@ int drmm_connector_hdmi_init(struct drm_device=
 *dev,
> >>>>  	 * default with the actual controller capability. A value of zero =
keeps
> >>>>  	 * the limit inferred from supported_hdmi_ver.
> >>>>  	 */
> >>>> -	if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_2_0)
> >>>> +	if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_2_0) {
> >>>> +		if (!hdmi_funcs->scrambler_enable || !hdmi_funcs->scrambler_disab=
le) {
> >>>> +			drm_err(dev, "Scrambler callbacks missing for HDMI 2.x\n");
> >>>> +			return -EINVAL;
> >>>> +		}
> >>>> +
> >>>>  		connector->hdmi.max_tmds_char_rate =3D HDMI_2_0_TMDS_CHAR_RATE_MA=
X_HZ;
> >>>> -	else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_3)
> >>>> -		connector->hdmi.max_tmds_char_rate =3D HDMI_1_3_TMDS_CHAR_RATE_MA=
X_HZ;
> >>>> -	else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_0)
> >>>> -		connector->hdmi.max_tmds_char_rate =3D HDMI_1_0_TMDS_CHAR_RATE_MA=
X_HZ;
> >>>> +	} else {
> >>>> +		/*
> >>>> +		 * Scrambler callbacks are only valid for connectors advertising
> >>>> +		 * HDMI 2.0 capability. drm_connector_hdmi_scrambler_supported()
> >>>> +		 * relies on their presence to report scrambling support.
> >>>> +		 */
> >>>> +		if (hdmi_funcs->scrambler_enable || hdmi_funcs->scrambler_disable=
) {
> >>>> +			drm_err(dev, "Scrambler callbacks unexpected for HDMI 1.x\n");
> >>>> +			return -EINVAL;
> >>>> +		}
> >>>> +
> >>>> +		if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_3)
> >>>> +			connector->hdmi.max_tmds_char_rate =3D HDMI_1_3_TMDS_CHAR_RATE_M=
AX_HZ;
> >>>> +		else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_0)
> >>>> +			connector->hdmi.max_tmds_char_rate =3D HDMI_1_0_TMDS_CHAR_RATE_M=
AX_HZ;
> >>>> +	}
> >>>
> >>> I'd put it into a separate test (possibly earlier). Merging both the
> >>> tmds rate default and the scrambler callbacks check makes it messier
> >>> than it would be if we had two separate tests.
> >>
> >> Ack. How about the following?
> >>
> >> 	if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_2_0)
> >> 		connector->hdmi.max_tmds_char_rate =3D HDMI_2_0_TMDS_CHAR_RATE_MAX_H=
Z;
> >> 	else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_3)
> >> 		connector->hdmi.max_tmds_char_rate =3D HDMI_1_3_TMDS_CHAR_RATE_MAX_H=
Z;
> >> 	else if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_1_0)
> >> 		connector->hdmi.max_tmds_char_rate =3D HDMI_1_0_TMDS_CHAR_RATE_MAX_H=
Z;
> >>
> >> 	if (hdmi_funcs->supported_tmds_char_rate) {
> >> 		if (hdmi_funcs->supported_tmds_char_rate > connector->hdmi.max_tmds_=
char_rate) {
> >> 			drm_err(dev, "Enforced max_tmds_char_rate exceeds %llu spec limit\n=
",
> >> 				connector->hdmi.max_tmds_char_rate);
> >> 			return -EINVAL;
> >> 		}
> >>
> >> 		connector->hdmi.max_tmds_char_rate =3D hdmi_funcs->supported_tmds_ch=
ar_rate;
> >> 	}
> >>
> >> 	if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_2_0) {
> >> 		if (!hdmi_funcs->scrambler_enable || !hdmi_funcs->scrambler_disable)=
 {
> >> 			drm_err(dev, "Scrambler callbacks missing for HDMI 2.x\n");
> >> 			return -EINVAL;
> >> 		}
> >> 	} else {
> >> 		/*
> >> 		 * Scrambler callbacks are only valid for connectors advertising
> >> 		 * HDMI 2.0 capability. drm_connector_hdmi_scrambler_supported()
> >> 		 * relies on their presence to report scrambling support.
> >> 		 */
> >> 		if (hdmi_funcs->scrambler_enable || hdmi_funcs->scrambler_disable) {
> >> 			drm_err(dev, "Scrambler callbacks unexpected for HDMI 1.x\n");
> >> 			return -EINVAL;
> >> 		}
> >> 	}
> >=20
> > I don't think we need the else clause at all. It's not valid, but it's
> > also not creating any issue.
>=20
> As discussed a while ago, we used to have a scrambler_supported flag, inf=
erred
> from supported_hdmi_ver, which allowed helpers to verify the capability w=
hen
> needed.  That flag has now been removed and replaced by
> drm_connector_hdmi_scrambler_supported(), which relies exclusively on the
> presence of the scrambler callbacks to report whether the capability is
> supported.=20
>=20
> If we don't ensure that these callbacks are *not* set for HDMI 1.x cases,=
 one
> could set supported_hdmi_ver to HDMI_VERSION_1_4, for example, while still
> providing the scrambler_{enable,disable} funcs.  This would lead to an
> inconsistency between the maximum TMDS character rate inferred from
> supported_hdmi_ver and the capability reported by
> drm_connector_hdmi_scrambler_supported().

This is the problem then. scrambler is mandatory for HDMI2.0, and
HDMI1.4 will never reach HDMI2.0 TMDS rates.

scrambler supported is HDMI 2.0 and scrambler_enable and
scrambler_disable are set. if HDMI 1.4 is used, then the scrambler must
not be supported, ever.

> > I'd move that second check earlier together with the infoframe callbacks
> > checks and so on too.
>=20
> Ack.
>=20
> >>>>  	if (hdmi_funcs->supported_tmds_char_rate) {
> >>>>  		if (hdmi_funcs->supported_tmds_char_rate > connector->hdmi.max_tm=
ds_char_rate) {
> >>>> @@ -635,6 +652,7 @@ int drmm_connector_hdmi_init(struct drm_device *=
dev,
> >>>>  				connector->hdmi.max_tmds_char_rate);
> >>>>  			return -EINVAL;
> >>>>  		}
> >>>> +
> >>>>  		connector->hdmi.max_tmds_char_rate =3D hdmi_funcs->supported_tmds=
_char_rate;
> >>>>  	}
> >>
> >> [...]
> >>
> >>>> +	/**
> >>>> +	 * @scdc_work: Work item currently used to monitor sink-side scram=
bling
> >>>> +	 * status and retry setup if the sink resets it.
> >>>> +	 */
> >>>> +	struct delayed_work scdc_work;
> >>>> +
> >>>> +	/**
> >>>> +	 * @scdc_work_initialized: Tracks whether @scdc_work has been set =
up via
> >>>> +	 * INIT_DELAYED_WORK(). The work item is initialized lazily on the=
 first
> >>>> +	 * scrambling enable, so this guards the teardown paths against to=
uching
> >>>> +	 * an uninitialized work item.
> >>>> +	 */
> >>>> +	bool scdc_work_initialized;
> >>>> +
> >>>
> >>> Why should we track whether it's initialized or not? I'd always
> >>> initialize it, but only ever schedule something if we're using the
> >>> scrambler.
> >>
> >> Having this initialized in the connector would lead to a module depend=
ency
> >> cycle.
> >>
> >> Currently the work function lives in drm_hdmi_helper.c, which is built=
 into
> >> drm_display_helper module:
> >>
> >> static void drm_connector_hdmi_scdc_work(struct work_struct *work)
> >> {
> >> 	[...]
> >> 	if (READ_ONCE(connector->hdmi.scrambler_enabled) &&
> >> 	    !drm_scdc_get_scrambling_status(connector))
> >> 		drm_connector_hdmi_try_scrambling_setup(connector);
> >> 	[...]
> >> }
> >>
> >> int drm_connector_hdmi_enable_scrambling(struct drm_connector *connect=
or,
> >> 					 const struct drm_connector_state *conn_state)
> >> {
> >>
> >> 	[...]
> >> 	if (!hdmi->scdc_work_initialized) {
> >> 		INIT_DELAYED_WORK(&hdmi->scdc_work,
> >> 				  drm_connector_hdmi_scdc_work);
> >> 		hdmi->scdc_work_initialized =3D true;
> >> 	}
> >> 	[...]
> >> }
> >>
> >> If we move INIT_DELAYED_WORK() into the connector (i.e. in drm.ko), th=
e work
> >> function has to be reachable from there.  The following attempts to ac=
complish
> >> that would fail:
> >>
> >> - Keep the work function in drm_hdmi_helper.c and export it from
> >>   drm_display_helper.
> >>
> >> - Move the work function into drm_connector.c and export=20
> >>   drm_connector_hdmi_try_scrambling_setup(), or a wrapper function, fr=
om=20
> >>   drm_display_helper.
> >=20
> > An alternative could be to move drm_connector_hdmi_init to
> > drm_hdmi_helper.c, no?
>=20
> I haven't considered this option so far, as I believe it would also requi=
re some
> refactoring to get right - for example, moving HDMI-related initializatio=
n from
> the generic drm_connector_init_only() to drm_connector_hdmi_init(), and
> splitting drm_connector_cleanup() into a dedicated drm_connector_hdmi_cle=
anup()
> utility.
>=20
> > But yeah, if we can't let's keep it like that
>=20
> Should I proceed with this refactoring, or would it be better to postpone=
 it
> until I send out the HDMI 2.1 patches, to avoid expanding this series even
> further?

we can postpone it if you prefer, or even to a separate series

Maxime

--rknqritovu2w3mde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCao1gkAAKCRAnX84Zoj2+
djqXAX0Y6VbpTJNSZbe1MC1QKpKRbqoI0GO+AEUaoUFbEqKxoFeSG3oN8H6ze/73
1wzjEfoBfRJxfhnKeR12YZsvSMh8ty39/yGFcQZUWib9nFFeku70iJqArqd2JD4O
InyrPq+8tA==
=NLfL
-----END PGP SIGNATURE-----

--rknqritovu2w3mde--
