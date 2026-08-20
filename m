Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477D2C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B8910EF9A;
	Thu, 20 Aug 2026 10:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UygmRPmf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05E210EF9A
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:10:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B20243464;
 Thu, 20 Aug 2026 10:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE381F00A3F;
 Thu, 20 Aug 2026 10:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787220651;
 bh=tcc4wkxLTgTSQg0ktCkPrGENxcfhQ/cSa7F/3AbRwiY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UygmRPmf5pPxm/fBvyEuceXA5BvTByMEyOX2bTYsbkYr+IyPNGbf/rcWUqj35/SGz
 aoMeI4YZP0WYC/LOPhvaXxfcXeErW8gcW1yiTj49E4acPCeBE4rmWnCS/YGxVlAAVV
 GSHMHMHsdKmXkDGM2/MhBuSrTe+59gnM3ZX3jpTJazNcmAu3hkex75V/FREbVvKiN0
 EX7ZwGkQ6bJfuoPYHu0j8in9VXrLYb/nm2HDS90cmqIy+IfY08nPgm0VzL4cDy/IBd
 C6Lk9ttYHun7o0x6CZzf9tCN/EwwEw84wlznStZjZhc2byzW3UZa2fPFEs7pwOue9D
 BFd5Olkoe7hgQ==
Date: Thu, 20 Aug 2026 12:10:49 +0200
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
Message-ID: <20260820-strange-rich-tiger-78a5a4@houat>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-67-294364b2cf15@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ykye35pgouu6733l"
Content-Disposition: inline
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-67-294364b2cf15@collabora.com>
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


--ykye35pgouu6733l
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 67/69] drm/connector: Drop redundant hdmi
 vendor/product fields
MIME-Version: 1.0

On Fri, Jul 31, 2026 at 07:20:14PM +0300, Cristian Ciocaltea wrote:
> Now that all users migrated to the new drmm_connector_hdmi_init()
> signature, vendor and product are provided through struct
> drm_connector_hdmi_funcs, a reference to which is already stored in
> drm_connector_hdmi.
>=20
> Drop the redundant fields from drm_connector_hdmi and point its users to
> hdmi.funcs->vendor and hdmi.funcs->product instead.
>=20
> This allows simplifying the related connector registration tests by
> getting rid of the now unnecessary KUNIT_EXPECT_MEMEQ() checks.
>=20
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, R=
ock 5B
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c |  4 +--
>  drivers/gpu/drm/drm_connector.c                 |  4 ---
>  drivers/gpu/drm/tests/drm_connector_test.c      | 41 +++----------------=
------
>  include/drm/drm_connector.h                     | 14 ++-------
>  4 files changed, 8 insertions(+), 55 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 04c9e06b9dc1..83a8fcb41343 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -784,8 +784,8 @@ static int hdmi_generate_spd_infoframe(const struct d=
rm_connector *connector,
>  		return 0;
> =20
>  	ret =3D hdmi_spd_infoframe_init(frame,
> -				      connector->hdmi.vendor,
> -				      connector->hdmi.product);
> +				      connector->hdmi.funcs->vendor,
> +				      connector->hdmi.funcs->product);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index b2e8d99c0e9a..f5f38dc4bfa6 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -656,10 +656,6 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>  		connector->hdmi.max_tmds_char_rate =3D hdmi_funcs->supported_tmds_char=
_rate;
>  	}
> =20
> -	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
> -	strtomem_pad(connector->hdmi.vendor, hdmi_funcs->vendor, 0);
> -	strtomem_pad(connector->hdmi.product, hdmi_funcs->product, 0);
> -
>  	/*
>  	 * drm_connector_attach_max_bpc_property() requires the
>  	 * connector to have a state.
> diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm=
/tests/drm_connector_test.c
> index 3d8500ad8be9..42f804500de6 100644
> --- a/drivers/gpu/drm/tests/drm_connector_test.c
> +++ b/drivers/gpu/drm/tests/drm_connector_test.c
> @@ -771,14 +771,11 @@ static void drm_test_connector_hdmi_init_null_produ=
ct(struct kunit *test)
> =20
>  /*
>   * Test that the registration of a connector with a valid, shorter than
> - * the max length, product name succeeds, and is stored padded with 0.
> + * the max length, product name succeeds.
>   */
>  static void drm_test_connector_hdmi_init_product_valid(struct kunit *tes=
t)
>  {
>  	struct drm_connector_init_priv *priv =3D test->priv;
> -	const unsigned char expected_product[DRM_CONNECTOR_HDMI_PRODUCT_LEN] =
=3D {
> -		'P', 'r', 'o', 'd',
> -	};
>  	int ret;
> =20
>  	priv->hdmi_funcs =3D dummy_hdmi_funcs;
> @@ -793,25 +790,15 @@ static void drm_test_connector_hdmi_init_product_va=
lid(struct kunit *test)
>  				       DRM_MODE_CONNECTOR_HDMIA,
>  				       &priv->ddc);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
> -	KUNIT_EXPECT_MEMEQ(test,
> -			   priv->connector.hdmi.product,
> -			   expected_product,
> -			   sizeof(priv->connector.hdmi.product));
>  }
> =20
>  /*
>   * Test that the registration of a connector with a valid, at max
> - * length, product name succeeds, and is stored padded without any
> - * trailing \0.
> + * length, product name succeeds.
>   */
>  static void drm_test_connector_hdmi_init_product_length_exact(struct kun=
it *test)
>  {
>  	struct drm_connector_init_priv *priv =3D test->priv;
> -	const unsigned char expected_product[DRM_CONNECTOR_HDMI_PRODUCT_LEN] =
=3D {
> -		'P', 'r', 'o', 'd', 'u', 'c', 't',
> -		'P', 'r', 'o', 'd', 'u', 'c', 't',
> -		'P', 'r',
> -	};
>  	int ret;
> =20
>  	priv->hdmi_funcs =3D dummy_hdmi_funcs;
> @@ -826,10 +813,6 @@ static void drm_test_connector_hdmi_init_product_len=
gth_exact(struct kunit *test
>  				       DRM_MODE_CONNECTOR_HDMIA,
>  				       &priv->ddc);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
> -	KUNIT_EXPECT_MEMEQ(test,
> -			   priv->connector.hdmi.product,
> -			   expected_product,
> -			   sizeof(priv->connector.hdmi.product));
>  }
>
>  /*
> @@ -857,14 +840,11 @@ static void drm_test_connector_hdmi_init_product_le=
ngth_too_long(struct kunit *t
> =20
>  /*
>   * Test that the registration of a connector with a vendor name smaller
> - * than the maximum length succeeds, and is stored padded with zeros.
> + * than the maximum length succeeds.
>   */
>  static void drm_test_connector_hdmi_init_vendor_valid(struct kunit *test)
>  {
>  	struct drm_connector_init_priv *priv =3D test->priv;
> -	const char expected_vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] =3D {
> -		'V', 'e', 'n', 'd',
> -	};
>  	int ret;
> =20
>  	priv->hdmi_funcs =3D dummy_hdmi_funcs;
> @@ -879,24 +859,15 @@ static void drm_test_connector_hdmi_init_vendor_val=
id(struct kunit *test)
>  				       DRM_MODE_CONNECTOR_HDMIA,
>  				       &priv->ddc);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
> -	KUNIT_EXPECT_MEMEQ(test,
> -			   priv->connector.hdmi.vendor,
> -			   expected_vendor,
> -			   sizeof(priv->connector.hdmi.vendor));
>  }
> =20
>  /*
>   * Test that the registration of a connector with a vendor name at the
> - * maximum length succeeds, and is stored padded without the trailing
> - * zero.
> + * maximum length succeeds.
>   */
>  static void drm_test_connector_hdmi_init_vendor_length_exact(struct kuni=
t *test)
>  {
>  	struct drm_connector_init_priv *priv =3D test->priv;
> -	const char expected_vendor[DRM_CONNECTOR_HDMI_VENDOR_LEN] =3D {
> -		'V', 'e', 'n', 'd', 'o', 'r',
> -		'V', 'e',
> -	};
>  	int ret;
> =20
>  	priv->hdmi_funcs =3D dummy_hdmi_funcs;
> @@ -911,10 +882,6 @@ static void drm_test_connector_hdmi_init_vendor_leng=
th_exact(struct kunit *test)
>  				       DRM_MODE_CONNECTOR_HDMIA,
>  				       &priv->ddc);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
> -	KUNIT_EXPECT_MEMEQ(test,
> -			   priv->connector.hdmi.vendor,
> -			   expected_vendor,
> -			   sizeof(priv->connector.hdmi.vendor));
>  }

Unfortunately, these tests were useful, and are there to match what the
spec asks for.

Maxime

--ykye35pgouu6733l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaobSpAAKCRAnX84Zoj2+
dramAYCjWXzgq1MCtalAB+zYaNty4o3hVyz5fmoyZfOIGDeNkSVzfl/vUXhlAUk8
GrGtsbkBgP3nwqkr6NppanVeZeayDRLEyij3Ru99cTZoRLaV0ehGz39hZIN4ulFB
3pO+8KSu7w==
=CVix
-----END PGP SIGNATURE-----

--ykye35pgouu6733l--
