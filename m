Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57A0C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B9E210E0C6;
	Tue,  8 Sep 2026 12:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y/DBZGs0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5479410E0C6
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:26:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB96243CD9;
 Tue,  8 Sep 2026 12:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0DD1F00A3A;
 Tue,  8 Sep 2026 12:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788870405;
 bh=DpGlmdPDzmDERT45bYk/MvWOr5fnNDn8zt9NAJBNisI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Y/DBZGs0UZ0cDvPlE+QW2pFUAUW1IzlkSyX4rUcqj8uEsvnpY1T5HUCBeqeTAAQMO
 WdtrmvkZOI7iT+wFY1urNHk1w1kfAqJatAJVKm4Pel3+JtDd4oq9K+ehXlRd2vZ8uz
 ahhv1zW/TCHlyUsJbBsWxIzt7KhNkwkUJRTe2YSgHf4j+MCxIhxpsYXBym1e539ZdD
 7s0PLDPkh0GUVqjiJJVk5RKasBXRYV0NeeibdLlWy4drG2KIKlfNPJCyV0Q8mD55A1
 XHqRatw95q1TcV5y5v1QYfHO6xUdYcsEt83tz6Y0pDBdbR6nDwqSfLpKWVqmsX/jhB
 SgR9xOK8TWj3g==
Date: Tue, 8 Sep 2026 14:26:42 +0200
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
 Diederik de Haas <diederik@cknow-tech.com>
Subject: Re: [PATCH v10 67/69] drm/connector: Drop redundant hdmi
 vendor/product fields
Message-ID: <ap_-wHX6nw5IbFkH@houat>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-67-294364b2cf15@collabora.com>
 <20260820-strange-rich-tiger-78a5a4@houat>
 <4fc2a3b6-2771-438b-ae99-5574e9c6efc9@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="mw5khw3c4yqnzjnq"
Content-Disposition: inline
In-Reply-To: <4fc2a3b6-2771-438b-ae99-5574e9c6efc9@collabora.com>
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


--mw5khw3c4yqnzjnq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 67/69] drm/connector: Drop redundant hdmi
 vendor/product fields
MIME-Version: 1.0

On Fri, Aug 21, 2026 at 06:30:31PM +0300, Cristian Ciocaltea wrote:
> On 8/20/26 1:10 PM, Maxime Ripard wrote:
> > On Fri, Jul 31, 2026 at 07:20:14PM +0300, Cristian Ciocaltea wrote:
> >> Now that all users migrated to the new drmm_connector_hdmi_init()
> >> signature, vendor and product are provided through struct
> >> drm_connector_hdmi_funcs, a reference to which is already stored in
> >> drm_connector_hdmi.
> >>
> >> Drop the redundant fields from drm_connector_hdmi and point its users =
to
> >> hdmi.funcs->vendor and hdmi.funcs->product instead.
> >>
> >> This allows simplifying the related connector registration tests by
> >> getting rid of the now unnecessary KUNIT_EXPECT_MEMEQ() checks.
> >>
> >> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS=
, Rock 5B
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  drivers/gpu/drm/display/drm_hdmi_state_helper.c |  4 +--
> >>  drivers/gpu/drm/drm_connector.c                 |  4 ---
> >>  drivers/gpu/drm/tests/drm_connector_test.c      | 41 +++-------------=
---------
> >>  include/drm/drm_connector.h                     | 14 ++-------
> >>  4 files changed, 8 insertions(+), 55 deletions(-)
> >>
> [...]
>=20
> >>  /*
> >>   * Test that the registration of a connector with a vendor name at the
> >> - * maximum length succeeds, and is stored padded without the trailing
> >> - * zero.
> >> + * maximum length succeeds.
> >>   */
> >>  static void drm_test_connector_hdmi_init_vendor_length_exact(struct k=
unit *test)
> >>  {
> >>  	struct drm_connector_init_priv *priv =3D test->priv;
> >> -	const char expected_vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] =3D {
> >> -		'V', 'e', 'n', 'd', 'o', 'r',
> >> -		'V', 'e',
> >> -	};
> >>  	int ret;
> >> =20
> >>  	priv->hdmi_funcs =3D dummy_hdmi_funcs;
> >> @@ -911,10 +882,6 @@ static void drm_test_connector_hdmi_init_vendor_l=
ength_exact(struct kunit *test)
> >>  				       DRM_MODE_CONNECTOR_HDMIA,
> >>  				       &priv->ddc);
> >>  	KUNIT_EXPECT_EQ(test, ret, 0);
> >> -	KUNIT_EXPECT_MEMEQ(test,
> >> -			   priv->connector.hdmi.vendor,
> >> -			   expected_vendor,
> >> -			   sizeof(priv->connector.hdmi.vendor));
> >>  }
> >=20
> > Unfortunately, these tests were useful, and are there to match what the
> > spec asks for.
>=20
> I've just added a new test to cover this, as well as a couple of prerequi=
sites
> to consolidate SPD InfoFrame handling:
>=20
> * video/hdmi: Define SPD InfoFrame field lengths and use strtomem_pad()
>=20
>   HDMI specification defines the SPD InfoFrame Vendor Name and Product
>   Description as fixed-size fields, 8 and 16 bytes respectively, padded
>   with zeros and left without any trailing NUL when a name spans the whole
>   field.
>=20
>   Give those lengths a name and mark the fields as non-strings, so that
>   the copies can be handed over to strtomem_pad(), which implements
>   precisely the required semantics.  This also bounds the reads from the
>   source strings, whereas the open-coded strlen() could run past the end
>   of the buffer in the hdmi_spd_infoframe_unpack() path, where the names
>   come straight from the wire and are not NUL-terminated.
>=20
>   While at it, replace the related magic numbers in the pack and unpack
>   helpers with the new defines.
>=20
> * drm/connector: Use the SPD InfoFrame field length defines
>=20
>   DRM_CONNECTOR_HDMI_{VENDOR,PRODUCT}_LEN used to size the vendor and
>   product arrays in struct drm_connector_hdmi.  Those arrays are gone and
>   both names are now only validated before being copied into the SPD
>   InfoFrame, hence the limits they have to be checked against are the ones
>   of the SPD InfoFrame fields themselves.
>=20
>   Switch the remaining users over to
>   HDMI_SPD_INFOFRAME_{VENDOR,PRODUCT}_LEN and drop the DRM specific
>   defines, so that the two cannot drift apart.
>=20
> * drm/tests: hdmi: Add SPD InfoFrame vendor/product coverage
>=20
>   The vendor and product strings provided through struct
>   drm_connector_hdmi_funcs end up in the SPD InfoFrame, whose fields are
>   defined by the HDMI specification as fixed-size: 8 bytes for the vendor
>   name and 16 bytes for the product description, padded with zeros and
>   left without any trailing NUL when a name spans the whole field.
>=20
>   Nothing exercises that so far, since the SPD InfoFrame is only generated
>   for connectors implementing the related hooks, which none of the
>   existing test funcs provides.
>=20
>   Add a connector variant supplying those hooks, along with parametrized
>   tests covering both the padded and the exact length cases.

I'm not sure why we need to add a new test here. It's exactly what the
test above is supposed to check. Making it a shell of what it was
testing and then adding yet another one that tests what the former used
to test seems suboptimal to me.

Maxime

--mw5khw3c4yqnzjnq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCap//AQAKCRAnX84Zoj2+
dmV1AX9C0CCq47WAzcktH7nroGzH5jf3YfBuoDThDxYMvQUXOGArY4RKchPxzLoV
oG7oT+ABgOd1pJGkT2rbtRLnTouxxjJ6nHnL3LXDLK8dxBzCTehVOFTXy+asT5Tq
AmqnhwqTMQ==
=VB2m
-----END PGP SIGNATURE-----

--mw5khw3c4yqnzjnq--
