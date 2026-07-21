Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5D3C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA2B810E360;
	Tue, 21 Jul 2026 13:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f2GrUSkQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6FA10E360
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:20:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BFCE405AC;
 Tue, 21 Jul 2026 13:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82A31F000E9;
 Tue, 21 Jul 2026 13:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784640012;
 bh=GEPDHEaRDKqZ6dNu/J9CK7yq+4aTB7MUn/lfU2U1p6k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=f2GrUSkQ+dYENYlClXT0M2kBcCpxk1B46HnSHBgkfXdy0QW8AcHrD2wIrH+KPrmcv
 cwwlD1IMG5bN/4zAIw0vhD2qgfq4w17HYUOxBKBc7nvXa80jlBg+GwDM+QTA+ah+Xd
 fwI9OcS4ury3cowlUEW6G3gODpzvksrTSSDPREzBAP9aLB71P4XyxXXzC7hjbEFInZ
 73zf1OjYqdwBhKFnK3hYdTIuWOC6+ILefEgXA1bjrH+zaK0XpM8vXdhZf7f3Z+2Fj4
 +xpGnHuE8Jy6ytglrp1E6iu4CgUhmOTFy2SceYSogq5Sac23cMK9hQQR2qzUmJe4E9
 OWrYGue9pH2pQ==
Date: Tue, 21 Jul 2026 15:20:09 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Daniel Stone <daniel@fooishbar.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v7 2/5] drm/scdc-helper: Add scdc_status debugfs entry
Message-ID: <20260721-wooden-placid-bumblebee-73360c@houat>
References: <20260721-scdc-link-health-v7-0-92df1b6ad5fc@collabora.com>
 <20260721-scdc-link-health-v7-2-92df1b6ad5fc@collabora.com>
 <20260721-angelic-gay-caiman-26f7ab@houat>
 <Ds65RxhYQNiDhRyjzYaHhw@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="llbbhttkpl4ptwgh"
Content-Disposition: inline
In-Reply-To: <Ds65RxhYQNiDhRyjzYaHhw@collabora.com>
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


--llbbhttkpl4ptwgh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/5] drm/scdc-helper: Add scdc_status debugfs entry
MIME-Version: 1.0

On Tue, Jul 21, 2026 at 03:01:12PM +0200, Nicolas Frattaroli wrote:
> On Tuesday, 21 July 2026 14:41:42 Central European Summer Time Maxime Rip=
ard wrote:
> > On Tue, Jul 21, 2026 at 10:58:58AM +0200, Nicolas Frattaroli wrote:
> > > SCDC provides status information on the current display link. At the
> > > very least, it may be useful to expose this info through debugfs.
> > >
> > > Add a debugfs entry for it under the connector, which displays a few
> > > more details parsed out of the SCDC registers. A new
> > > drm_scdc_debugfs_init function can be called by the connector
> > > implementation to initialise the debugfs file.
> > >
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > ---
> > >  drivers/gpu/drm/display/drm_scdc_helper.c | 184 ++++++++++++++++++++=
++++++++++
> > >  include/drm/display/drm_scdc_helper.h     |  32 ++++++
> > >  2 files changed, 216 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/=
drm/display/drm_scdc_helper.c
> > > +/**
> > > + * drm_scdc_debugfs_init - Initialize scdc files in connector debugfs
> > > + * @connector: pointer to &struct drm_connector to operate on
> > > + * @root: debugfs &struct dentry for the debugfs root of @connector
> > > + *
> > > + * Creates SCDC-related debugfs files for @connector. Must be called=
 after
> > > + * @root is already created.
> > > + */
> > > +void drm_scdc_debugfs_init(struct drm_connector *connector, struct d=
entry *root)
> > > +{
> > > +	struct scdc_debugfs_priv *priv;
> > > +
> > > +	if (!root || !connector)
> > > +		return;
> > > +
> > > +	priv =3D drmm_kzalloc(connector->dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return;
> > > +
> > > +	priv->connector =3D connector;
> >=20
> > You need to take a reference to the connector pointer here with
> > drm_connector_get()
> >=20
> > With this fixed,
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> >=20
> > Maxime
> >=20
>=20
> I think sashiko is onto something here with the memleak and the
> entirety of the priv thing should go, which is fairly easy to do.
> We don't reuse the state anymore anyways.
>=20
> I'll then just pass the connector as the priv, which will be valid
> for the lifetime of the debugfs entry. This means there's no cleanup.

Connectors can be hotplugged, so they have a shorter (or equal) lifetime
than what drmm_kzalloc provides.

Maxime

--llbbhttkpl4ptwgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCal9yBQAKCRAnX84Zoj2+
djbVAYDohBqoOi6dEtLX0bqbl0aljhsUfHcZC3fb1TYOgKURiRy5KZAGugxyJU5z
298gN1kBfiaVDF/Xr+lM6KrsiLuapmElClTOMC4p9EsWGzz4+YFIiSurQylDLoP7
p4g1IkjsHg==
=Tmw5
-----END PGP SIGNATURE-----

--llbbhttkpl4ptwgh--
