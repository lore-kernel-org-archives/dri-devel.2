Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F3FF589A4
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7161010F0D6;
	Thu, 23 Apr 2026 12:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Uci2kGEe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708D910F0D6
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:14:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 85D3B60125;
 Thu, 23 Apr 2026 12:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC0DC2BCB4;
 Thu, 23 Apr 2026 12:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776946450;
 bh=fwfsOCUr0TcQkp7tEbYBpDWspQA1NJ42HA1HzS41bhE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Uci2kGEeHACqNZt9VivFf/9FMudT22tazrokBtrF/957ZIkHz37JHkiBDbprO/n6o
 g6fleyuvbpUR1arqjsSJ8rVUu72Q3dWhE1e6MIbiFkjR/Rj/AfwUiD4YW+gwzzg+Pv
 Z2Y52o3iyfgZZbm54k3br+du44sTX3BKsSQR30vYbUHZjjLy8M1fMJnZrX39IwUw+j
 bEYnMi/jO2q4GAqosJEJWg9uKg7q4OQxIa2gd5aMulaX2dsZ9iBlQFmzDO+5uxsQhW
 n+No12ayuMBF8eBZERNyDvmal9mjaA6jE5B2HvpyeWoifJ5tKMXh7RHz3x0w9DdeSJ
 5JqA8hwgXWj0Q==
Date: Thu, 23 Apr 2026 14:14:07 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: simple: Add timings for Raspberry Pi 7"
 panel
Message-ID: <20260423-kickass-fat-boa-209f68@houat>
References: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
 <20260420-rpi-7inch-v1-2-e68d5c9c44bc@ideasonboard.com>
 <3z3u5mbngmbzsch3mzs3twlh3aec6r7jokstzv3ghxyusrzt6b@jqvdnuiapx6e>
 <af71183d-70b8-4a41-8466-67123e7aab02@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="l42rpwgug4qvdd4g"
Content-Disposition: inline
In-Reply-To: <af71183d-70b8-4a41-8466-67123e7aab02@ideasonboard.com>
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


--l42rpwgug4qvdd4g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drm/panel: simple: Add timings for Raspberry Pi 7"
 panel
MIME-Version: 1.0

Hi,

On Thu, Apr 23, 2026 at 03:01:51PM +0300, Tomi Valkeinen wrote:
> On 22/04/2026 22:22, Dmitry Baryshkov wrote:
> > On Mon, Apr 20, 2026 at 04:13:36PM +0300, Tomi Valkeinen wrote:
> > > Add timings for the panel used in Raspberry Pi 7" DSI Display module:
> > > https://www.raspberrypi.com/products/raspberry-pi-touch-display/
> > >=20
> > > This has been tested with version v1.1 of the display module.
> > >=20
> > > The panel is very strict about the back-porch values, they must be
> > > exactly 46 for hbp and 23 for vbp. Other timings can be defined quite
> > > freely.
> > >=20
> > > The panel is exclusive to Raspberry Pi, and different versions of the
> > > display module can have panels from different vendors which are fully
> > > compatible. Also, as the panel vendors are not public, the compatible
> > > string used is "raspberrypi,7inch-dsi".
> > >=20
> > > Note that while the display module has a DSI connector, and the
> > > compatible has "dsi" in it, we use DRM_MODE_CONNECTOR_DPI as the panel
> > > itself is a parallel video panel. The display module (as of v1.1) uses
> > > TC358762 DSI-to-DPI bridge to do the conversion.
> > >=20
> > > We could use DRM_MODE_CONNECTOR_DSI here, which would have the benefit
> > > of showing a "DSI-1" connector to the userspace. However, the panel I=
S a
> > > DPI panel, and gets its input from a DSI-to-DPI bridge, and the
> > > panel-simple.c behaves differently depending on the connector type us=
ed,
> > > so, DRM_MODE_CONNECTOR_DPI it is.
> > >=20
> > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > ---
> > >   drivers/gpu/drm/panel/panel-simple.c | 32 +++++++++++++++++++++++++=
+++++++
> > >   1 file changed, 32 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/p=
anel/panel-simple.c
> > > index 91ab280869ba..e75eb20301f2 100644
> > > --- a/drivers/gpu/drm/panel/panel-simple.c
> > > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > @@ -4208,6 +4208,35 @@ static const struct panel_desc rocktech_rk043f=
n48h =3D {
> > >   	.connector_type =3D DRM_MODE_CONNECTOR_DPI,
> > >   };
> > > +static const struct display_timing raspberrypi_7inch_timing =3D {
> > > +	.pixelclock =3D { 10000000, 30000000, 50000000 },
> > > +	.hactive =3D { 800, 800, 800 },
> > > +	.hfront_porch =3D { 16, 72, 354 },
> > > +	.hsync_len =3D { 1, 32, 40 },
> > > +	.hback_porch =3D { 46, 46, 46 },
> > > +	.vactive =3D { 480, 480, 480 },
> > > +	.vfront_porch =3D { 7, 21, 147 },
> > > +	.vsync_len =3D { 1, 2, 20 },
> > > +	.vback_porch =3D { 23, 23, 23 },
> > > +	.flags =3D DISPLAY_FLAGS_VSYNC_HIGH | DISPLAY_FLAGS_HSYNC_HIGH,
> > > +	/* Note: the rest of the flags are defined below in bus_flags */
> > > +};
> >=20
> > This looks pretty close to powertip panels that have been used before
> > hand in those modules. Are you sure that powertip,ph800480t013-idf02
> > or powertip,ph800480t032-zhc19 don't work for you?
>=20
> I haven't tested those, but the hbp and vbp do not seem to be the same. F=
or
> me, they had to be exactly as they are here. This was also confirmed from
> Raspberry Pi, the panel datasheet had min/typ/max values (i.e. not ranges)
> of 46 and 23 for back porches.
>=20
> Where did the information come from that powertip,ph800480t013-idf02 or
> powertip,ph800480t032-zhc19 are used in the display modules? Or did you m=
ean
> that while those models are not used in the Raspberry display module, peo=
ple
> have used them successfully?

It also looks like we have panel-raspberrypi-touchscreen.c and raspberrypi,=
dsi-7inch in
panel-ilitek-ili9881c.c.

There's clearly more than one "7-inch rpi panel" so clarifying how it
compares to the other two drivers would help.

Maxime

--l42rpwgug4qvdd4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaeoNCgAKCRAnX84Zoj2+
dhsWAX9AHrU2W2fFm/uveFasTWet7GE1drDNeX7LmFmoHRFj3yuOcmq0yX3kwvt3
AMZFopwBgIzJ95+EcE5i5ONE+nfqbyrDhIBSmdkZLMzc0si4yQtmVS/s4235D7SS
dYCczWlFyQ==
=03EF
-----END PGP SIGNATURE-----

--l42rpwgug4qvdd4g--
