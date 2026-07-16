Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04F4C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D7A10E388;
	Thu, 16 Jul 2026 13:50:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gND08iiP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56F3E10E388
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:50:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 79BD161380;
 Thu, 16 Jul 2026 13:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F691F000E9;
 Thu, 16 Jul 2026 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784209832;
 bh=ucTI3ctwz7P4bafmOQoOoow7pk9pdyLWWyIglYkCCtE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gND08iiPLrzULmDx5dMtcLqIrljf7N/ye9aV2+ow7d2CxVZdsL2cVYoEZZvAzBCCA
 ZQFibTZyt3zJ3gM6hbZW0Y7CS4it4S2tImxc+eP+uVlXrh1T9mtWPNmaEvt0FYUd7W
 sxxhNRYxj3OY9js0G675biSI3NFAG5FXRjM60oM/hVBAQxlsjgo/X45V3qeVQM2+ZR
 BlVqs2dd8QBAD5vWRm2eKVASKM8ZPBDurwUkVHjceXVIkhu/1iX5YBZVAaMGj9gC3Y
 3fyqVJqoOD6RZEDCKZsi485qbxbPu+l5shK7kwztDdxdxqMKdTGDpR7k9kmgf9/NGn
 yDGrlVSks6rLg==
Date: Thu, 16 Jul 2026 15:50:29 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v8 04/39] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
Message-ID: <20260716-astute-nippy-moose-bd22b5@houat>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-4-d79890d00b6a@collabora.com>
 <tjsidlnvswo2rdhqa6jybxrnb47lxgmxdlfrfbasuh67wjbqoy@3a45n3zawvnf>
 <17753a1c-824a-4835-ac2d-8b2796bba1eb@collabora.com>
 <534b921c-638c-4fc3-b89e-5dfc1f269f96@collabora.com>
 <20260713-statuesque-nonchalant-seagull-b9c39d@houat>
 <91c3a825-3344-4ff5-8ea0-f8f057665b3f@collabora.com>
 <20260715-ancient-zealous-eagle-b13e94@houat>
 <dfca9032-98ca-4c61-b1b1-85fd05283d77@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="e64try3cwjwjk5gn"
Content-Disposition: inline
In-Reply-To: <dfca9032-98ca-4c61-b1b1-85fd05283d77@collabora.com>
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


--e64try3cwjwjk5gn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 04/39] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
MIME-Version: 1.0

On Wed, Jul 15, 2026 at 01:46:12PM +0300, Cristian Ciocaltea wrote:
> On 7/15/26 11:55 AM, Maxime Ripard wrote:
> > On Mon, Jul 13, 2026 at 01:23:00PM +0300, Cristian Ciocaltea wrote:
> >> On 7/13/26 11:50 AM, Maxime Ripard wrote:
> >>> On Thu, Jul 09, 2026 at 10:25:54PM +0300, Cristian Ciocaltea wrote:
> >>>> On 7/3/26 11:54 PM, Cristian Ciocaltea wrote:
> >>>>> On 7/3/26 5:34 PM, Dmitry Baryshkov wrote:
> >>>>>> On Thu, Jul 02, 2026 at 05:46:17PM +0300, Cristian Ciocaltea wrote:
> >>>>>>> Add the connector-level infrastructure to support HDMI 2.0 scramb=
ling:
> >>>>>>>
> >>>>>>> - A scrambler_supported flag to indicate whether the source suppo=
rts the
> >>>>>>>   scrambling capability, in which case the newly introduced
> >>>>>>>   .scrambler_{enable|disable}() callbacks in drm_connector_hdmi_f=
uncs
> >>>>>>>   are mandatory
> >>>>>>
> >>>>>> Do we need a flag? What would it mean if the flag is set, but the
> >>>>>> callbacks are not? Can we drop the flag and use the presence of the
> >>>>>> callbacks as a way to identify that scrambler is enabled?
> >>>>>
> >>>>> The flag is intended to be set only within drmm_connector_hdmi_init=
_with_caps()
> >>>>> when drivers advertise HDMI 2.x capability, in which case it also e=
nsures the
> >>>>> callbacks are provided. =20
> >>>>>
> >>>>> We could drop the flag and instead have the init helper clear the c=
allbacks if
> >>>>> they were provided for HDMI 1.x.  This might slightly reduce code r=
eadability,
> >>>>> as it relies on checking the presence of individual callbacks - esp=
ecially since
> >>>>> we plan to extend this further with HDMI 2.1 support, providing fou=
r or five
> >>>>> additional FRL-specific callbacks.
> >>>>
> >>>> I tried to replace the flag with a helper that checks the presence o=
f (one of)
> >>>> the callbacks, but it's not straightforward to unset those for non-H=
DMI 2.x
> >>>> cases since the hdmi_funcs argument is immutable.
> >>>
> >>> I'm not sure why we would need to unset them. If the driver states th=
at
> >>> it support HDMI 2.0, then it needs to be there, if it doesn't, then w=
ho
> >>> cares? it's not going to be used. We can log a warning that it's
> >>> inconsistent I guess, but there's no need to actively remove it.
> >>
> >> I was trying to address the use case where drivers provide the scrambl=
er
> >> callbacks despite not supporting HDMI 2.0.
> >=20
> > Scrambling got introduced with HDMI 2.0. That doesn't make sense, but
> > it's not a total deal breaker, it's just going to be here unused. Hence
> > why I was suggesting to put a warning there if you wanted to.
> >=20
> >> If we replace the scrambler_supported flag with a helper checking the
> >> presence of the scrambler callbacks, then we would need to ensure the
> >> callbacks do not exist in this case.
> >=20
> > Keep it simple:
> >=20
> > if (hdmi_version >=3D HDMI_VERSION_2_0)
> >    if (funcs->scrambler_enable)
> >       hdmi->scramblers_supported =3D true
> >    else
> >       return -EINVAL
> > else
> >     drm_warn(warn, "Inconsistent HDMI version");
> >=20
> > We don't need anything more than that.
>=20
> I dropped the scrambler_supported flag and introduced a helper:
>=20
> static inline bool
> drm_connector_hdmi_scrambler_supported(struct drm_connector *connector)
> {
> 	return connector->hdmi.funcs && connector->hdmi.funcs->scrambler_enable;

I'd add disable to that test

> }
>=20
> Therefore we need to ensure the callbacks are not set in the HDMI 1.x cas=
es:
>=20
> int drmm_connector_hdmi_init_with_caps()
> {
> 	...
> 	if (caps->supported_hdmi_ver >=3D HDMI_VERSION_2_0) {
> 		if (!hdmi_funcs->scrambler_enable ||
> 		    !hdmi_funcs->scrambler_disable)
> 			return -EINVAL;
>=20
> 		connector->hdmi.max_tmds_char_rate =3D HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ;
> 	} else {
> 		/*
> 		 * Scrambler callbacks are only valid for connectors advertising
> 		 * HDMI 2.0 capability. drm_connector_hdmi_scrambler_supported()
> 		 * relies on their presence to report scrambling support.
> 		 */
> 		if (hdmi_funcs->scrambler_enable ||
> 		    hdmi_funcs->scrambler_disable)
> 			return -EINVAL;
>=20
> 		if (caps->supported_hdmi_ver >=3D HDMI_VERSION_1_3) {
> 			connector->hdmi.max_tmds_char_rate =3D HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ;
> 		} else if (caps->supported_hdmi_ver >=3D HDMI_VERSION_1_0) {
> 			connector->hdmi.max_tmds_char_rate =3D HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ;
> 		}
> 	}

Drivers might have a lower limit than the max allowed by the spec. It
should be provided by the driver, possibly optionally with a fallback to
what the spec states?

Maxime

--e64try3cwjwjk5gn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaljhpQAKCRAnX84Zoj2+
dtmfAX4hb36DjoE4VEr38K1RxVvH6fMaYc4tGgZ5azN7kKXkf+xx8ruXvL0qAOFh
VBxEz9IBfiL9+MgYvxA576doURHAq97OCDOVjqmqFBKmaZ51qcWE/LJhjrzU/1JC
BSNPP7oopA==
=Y9rm
-----END PGP SIGNATURE-----

--e64try3cwjwjk5gn--
