Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534BBC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B8810E07B;
	Tue,  7 Jul 2026 12:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mz07CscP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 520EC10E07B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 12:30:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E9144416FD;
 Tue,  7 Jul 2026 12:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBFD1F000E9;
 Tue,  7 Jul 2026 12:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783427450;
 bh=wuj6q/qR8Vtu8XNH10SeX8kJHc/CvibnWDhOQpyb6fo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Mz07CscPi3n2etIOnR9W4lYqeVtJ3THn5tFlD/K24ioHk2HaIdHO7ZvKeB8zX26mZ
 Gis2d697HvCsp2capKLwsHTBGBavdmOhI4DPQcm5M0T/TvVOmGAclWec9BQTyhGX3M
 Qjqi20Eafd3aY1URV6BS8dgyX5hFZP8u+IgGOnBlwj7rJiVCwDy8ScWWbYwFcROBuv
 rXSrLjVtIb3roE/FMM41strF9A3o3Fg/oc9UnuJ+1FLuG2ueTXOpCpGinYl3yLZ7tf
 Jo3EuCilYnANfnanMdQ0M/IuSPPqLzhIc8sI8sjx3HxQzEPPgHawMRhlfWXFCzl38y
 1pniiVRkhak4A==
Date: Tue, 7 Jul 2026 14:30:48 +0200
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
Message-ID: <20260707-tested-alpaca-of-patience-e38d7c@penduick>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-4-d79890d00b6a@collabora.com>
 <tjsidlnvswo2rdhqa6jybxrnb47lxgmxdlfrfbasuh67wjbqoy@3a45n3zawvnf>
 <17753a1c-824a-4835-ac2d-8b2796bba1eb@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="33bj253ieh44czfg"
Content-Disposition: inline
In-Reply-To: <17753a1c-824a-4835-ac2d-8b2796bba1eb@collabora.com>
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


--33bj253ieh44czfg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 04/39] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
MIME-Version: 1.0

On Fri, Jul 03, 2026 at 11:54:33PM +0300, Cristian Ciocaltea wrote:
>> >> -	if (caps->supported_hdmi_ver >=3D HDMI_VERSION_2_0)
> >> +	if (caps->supported_hdmi_ver >=3D HDMI_VERSION_2_0) {
> >> +		if (!hdmi_funcs->scrambler_enable ||
> >> +		    !hdmi_funcs->scrambler_disable)
> >> +			return -EINVAL;
> >> +
> >> +		connector->hdmi.scrambler_supported =3D true;
> >>  		connector->hdmi.max_tmds_char_rate =3D HDMI_2_0_TMDS_CHAR_RATE_MAX_=
HZ;
> >> -	else if (caps->supported_hdmi_ver >=3D HDMI_VERSION_1_3)
> >> +	} else if (caps->supported_hdmi_ver >=3D HDMI_VERSION_1_3) {
> >>  		connector->hdmi.max_tmds_char_rate =3D HDMI_1_3_TMDS_CHAR_RATE_MAX_=
HZ;
> >> -	else if (caps->supported_hdmi_ver >=3D HDMI_VERSION_1_0)
> >> +	} else if (caps->supported_hdmi_ver >=3D HDMI_VERSION_1_0) {
> >>  		connector->hdmi.max_tmds_char_rate =3D HDMI_1_0_TMDS_CHAR_RATE_MAX_=
HZ;
> >> +	}
> >> =20
> >>  	if (caps->max_tmds_char_rate) {
> >>  		if (caps->max_tmds_char_rate > connector->hdmi.max_tmds_char_rate)
> >> +
> >> +	/** @scdc_cb: Callback to be invoked as part of @scdc_work.
> >> +	 *
> >> +	 * Currently used to monitor sink-side scrambling status and retry
> >> +	 * setup if the sink resets it.
> >> +	 *
> >> +	 * This is assigned by the framework when making use of
> >> +	 * drm_connector_hdmi_enable_scrambling() helper.
> >=20
> > No such helper.=20
>=20
> Right, I'll drop the reference to the helper name, as that's added later =
in the
> series.
>=20
> > Also, please explain in the commit message, why do we
> > need to keep it configurable. Why the default is not enough?
>=20
> We will need a separate callback to support HDMI 2.1, i.e. for link train=
ing
> management.  I=E2=80=99ll update the commit message accordingly.

I think I'm equally confused as Dmitry here. If scdc_cb is only called
if we're sending scrambled pixels but the monitor doesn't acknowledge it
initially, then the only thing we need to do is "if the scrambler's
enabled, call drm_scdc_set_scrambling()", then we don't need to set a
callback. And even if we ever need to deal with HDMI link training, then
we can still have the same function but with a couple of branches more.

Maxime

--33bj253ieh44czfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCakzxdwAKCRAnX84Zoj2+
dkLVAYDSNsdoe2xL0wTBgSQsEHtvgGUzAd9WwUpIf8wZd2IR1reV3VwM2TxiAj9p
6+5GT88BgIF1H1Gt9lywepKbAfBimGIA6pv7db3n49pZW3Z6eF96hs7hxRsDGWhZ
EWGkVsYUsQ==
=YXvO
-----END PGP SIGNATURE-----

--33bj253ieh44czfg--
