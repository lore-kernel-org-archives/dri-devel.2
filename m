Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AFCCD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 11:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BA710EE00;
	Wed, 13 May 2026 11:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iAFtKj/Q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6536F10EE00
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:56:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4BAD74404F;
 Wed, 13 May 2026 11:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA66C2BCB7;
 Wed, 13 May 2026 11:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778673360;
 bh=rlilNasJWUJC6SDcuWXWpeqL3VgDAEA+rHvxSo8OB7o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iAFtKj/QG8K/likLAONPz/mvPKoT5r9NG7Jc77vGPoPFZ8EgJArIYFTO/F1zrWtvd
 d2MfV0Ag2MGCGRGJOcaWpB4gWGF+wODNrmBBFlwx9QZexCqevppE5Fjk/d89fsgYC1
 40PSM2ayZDHkIcCH4eyNl6l/x1Slg9kxDoF4SqvlVjNO3KDAA7gOIadIa26GE6NS9v
 dwX5DvVMdps+bQPasNz4X3QcG4HmZf+adcnxeKNcg+L++mJDu/G7+EezjIItkflEiP
 c7d5XbDz9qhUrLLfxGgQPZ6cGN6e8nj2VKDfa8QFJ+Z5n86DeZZVaAwUxUV3+ePXLi
 xxv59Nb025pxA==
Date: Wed, 13 May 2026 13:55:57 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
 David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>,
 Robert Foss <rfoss@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/2] drm/bridge: ite-it66121: Set TX mode in the
 .atomic_enable callback
Message-ID: <20260513-huge-mongoose-of-wealth-464fac@houat>
References: <20260512132232.333654-1-javierm@redhat.com>
 <20260512132232.333654-2-javierm@redhat.com>
 <20260512-romantic-qualified-hound-b5f9b9@houat>
 <87tsscxxuy.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="2gr3mafseznvxniq"
Content-Disposition: inline
In-Reply-To: <87tsscxxuy.fsf@ocarina.mail-host-address-is-not-set>
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


--2gr3mafseznvxniq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] drm/bridge: ite-it66121: Set TX mode in the
 .atomic_enable callback
MIME-Version: 1.0

On Tue, May 12, 2026 at 08:54:13PM +0200, Javier Martinez Canillas wrote:
> Maxime Ripard <mripard@kernel.org> writes:
>=20
> Thanks again for your feedback!
>=20
> > Hi,
> >
> > On Tue, May 12, 2026 at 03:22:15PM +0200, Javier Martinez Canillas wrot=
e:
> >> The HDMI transmission mode set and AVI infoframes enable are done in t=
he
> >> .mode_set callback, but it is more correct to do this in .atomic_enabl=
e.
> >>=20
> >> Because the information about the sink type is in the struct drm_conne=
ctor
> >> display_info.is_hdmi and this might not be available when the .mode_set
> >> callback is executed.
> >>=20
> >> Currently the driver is not checking display info to determine whether=
 the
> >> mode has to be set to HDMI or DVI, but this is a bug that will be fixe=
d by
> >> a follow-up change.
> >>=20
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> ---
> >>=20
> >> (no changes since v1)
> >>=20
> >>  drivers/gpu/drm/bridge/ite-it66121.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>=20
> >> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/br=
idge/ite-it66121.c
> >> index 19a027d75b61..648ca50712df 100644
> >> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> >> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> >> @@ -669,6 +669,22 @@ static int it66121_set_mute(struct it66121_ctx *c=
tx, bool mute)
> >>  			    IT66121_PKT_GEN_CTRL_ON | IT66121_PKT_GEN_CTRL_RPT);
> >>  }
> >> =20
> >> +static void it66121_set_tx_mode(struct it66121_ctx *ctx)
> >> +{
> >> +	mutex_lock(&ctx->lock);
> >> +
> >> +	/* Enable AVI infoframe */
> >> +	if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
> >> +			 IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
> >> +		goto unlock;
> >> +
> >> +	/* Set TX mode to HDMI */
> >> +	regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_H=
DMI);
> >> +
> >> +unlock:
> >> +	mutex_unlock(&ctx->lock);
> >> +}
> >> +
> >>  #define MAX_OUTPUT_SEL_FORMATS	1
> >> =20
> >>  static u32 *it66121_bridge_atomic_get_output_bus_fmts(struct drm_brid=
ge *bridge,
> >> @@ -729,6 +745,8 @@ static void it66121_bridge_enable(struct drm_bridg=
e *bridge,
> >>  	ctx->connector =3D drm_atomic_get_new_connector_for_encoder(state, b=
ridge->encoder);
> >> =20
> >>  	it66121_set_mute(ctx, false);
> >> +
> >> +	it66121_set_tx_mode(ctx);
> >>  }
> >
> > Having some part of it in mode_set and some part in enable is still kind
> > of weird. The best there would be to put everything in enable (and
> > pre_enable), and drop mode_set entirely.
> >
>=20
> I agree that this will be the correct approach. I wonder though if could =
be
> acceptable to land the changes in this series as a minimal fix for the DVI
> mode issue, and then do further refactoring as a follow-up.

The thing is that you're now making the driver and its interaction with
the hardware more complex. Like, what would happen if mode_set is now
called after atomic_enable? How does the hardware behavies if you modify
the SII902X_SYS_CTRL_DATA register only after it's been enabled?

Moving everything to atomic_enable keeps things simple and keep the
hardware access ordering the same.

And if you don't plan on sending that to fixes, the fact that the patch
is small is kind of irrelevant anyway.

Maxime

--2gr3mafseznvxniq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCagRmxQAKCRAnX84Zoj2+
dvTxAYCmJPl1Cste7SvsOtmy8sf0a3gTcOWhoa/gzMHZ37lJrmJGoCJqm7XqYdb7
g25ignEBgPoMc/Czmt9T0HNkJJT8LDMyKlpdmO6gFs3diNI33COKuV1OBbnfwML4
YBeujwOAWQ==
=Iq0L
-----END PGP SIGNATURE-----

--2gr3mafseznvxniq--
