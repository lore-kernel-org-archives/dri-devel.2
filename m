Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F838CD8C92
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1725F10E2F2;
	Tue,  9 Jun 2026 12:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N7u2vIFY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC7C10E2F2
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 12:44:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A5CA601DC;
 Tue,  9 Jun 2026 12:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D991F00893;
 Tue,  9 Jun 2026 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781009041;
 bh=Ydq/tbSss8qiRk9qUKdW43eESg1pJEOtT4lCL4jYh6s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=N7u2vIFY+mXuNNnLLpaRqQQiiR8gMcqNjl+Ywtc5PJAbkIDP3TNdWE9voyP941Lcl
 lAY981OOyMir/AB2trdLks4i1Jo1uqPCHW50Q6us0gFqRvYTXxTyU8NfkOGXMVNDnL
 nEkiqZkx5Qli4pRsNHs4dmwUfFU0XSkAieKH1d94FAKMK/IudMBnu7C3I2vAYcmQri
 15698UfsH6NFV/WNQ4NbcCg/BHBnA483JKHkFrm9fwDPg4dHsSvUdVWsTWJZqH/yiL
 R4e2MEmKpg93NC+QgtIlbGww/E1v5HbixBLU3zp/QwglgYLMn3CyNlrCzoeMjPZ3z0
 UMCSGEObXnF6g==
Date: Tue, 9 Jun 2026 14:43:59 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 23/37] drm/encoder: add drm_encoder_cleanup_from()
Message-ID: <20260609-hypnotic-honeybee-of-adventure-d89b7c@houat>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-23-45e2bdb3dfb4@bootlin.com>
 <20260608-mighty-woodlouse-of-reading-162bca@houat>
 <DJ4FR339GCKY.21P0315EZLRJU@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="gtamny6ghjahqeyo"
Content-Disposition: inline
In-Reply-To: <DJ4FR339GCKY.21P0315EZLRJU@bootlin.com>
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


--gtamny6ghjahqeyo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 23/37] drm/encoder: add drm_encoder_cleanup_from()
MIME-Version: 1.0

On Tue, Jun 09, 2026 at 12:10:39PM +0200, Luca Ceresoli wrote:
> On Mon Jun 8, 2026 at 2:10 PM CEST, Maxime Ripard wrote:
> > On Tue, May 19, 2026 at 12:37:40PM +0200, Luca Ceresoli wrote:
> >> Supporting hardware whose final part of the DRM pipeline can be physic=
ally
> >> removed requires the ability to detach all bridges from a given point =
to
> >> the end of the pipeline.
> >>
> >> Introduce a variant of drm_encoder_cleanup() for this.
> >>
> >> Take care to not try detaching non-attached bridges. This is needed be=
cause
> >> when two or more bridges are removed not in the backwards order,
> >> drm_encoder_cleanup_from() is called more than once for bridges closer=
 to
> >> the panel.
> >>
> >> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> >>
> >> ---
> >>
> >> Note: in theory drm_encoder_cleanup() is now a superset of
> >> drm_encoder_cleanup_from() and may be simplified to just call
> >> drm_encoder_cleanup_from() and then do the extra actions. However the
> >> common code is subtly different in terms of locking and checks, so this
> >> would complicate the code in this patch and has thus been kept separat=
e for
> >> the time being to make reviewing sompler. Reimplementing
> >> drm_encoder_cleanup() by using drm_encoder_cleanup_from() cvacn be done
> >> later on.
> >>
> >> A much simpler and now obsolete version of this patch (missing locking=
 and
> >> checks) previously appeared in
> >> https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-13-9d6f2c9=
c3058@bootlin.com/
> >> ---
> >>  drivers/gpu/drm/drm_encoder.c | 38 ++++++++++++++++++++++++++++++++++=
++++
> >>  include/drm/drm_encoder.h     |  1 +
> >>  2 files changed, 39 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encod=
er.c
> >> index 0d5dbed06db4..40ece477b302 100644
> >> --- a/drivers/gpu/drm/drm_encoder.c
> >> +++ b/drivers/gpu/drm/drm_encoder.c
> >> @@ -179,6 +179,44 @@ int drm_encoder_init(struct drm_device *dev,
> >>  }
> >>  EXPORT_SYMBOL(drm_encoder_init);
> >>
> >> +/**
> >> + * drm_encoder_cleanup_from - remove a given bridge and all the follo=
wing
> >> + * @encoder: encoder whole list of bridges shall be pruned
> >> + * @bridge: first bridge to remove
> >> + *
> >> + * Removes from an encoder all the bridges starting with a given brid=
ge
> >> + * and until the end of the chain.
> >> + *
> >> + * Does nothing if the bridge is not attached to an encoder chain.
> >> + *
> >> + * This should not be used in "normal" DRM pipelines. It is only usef=
ul for
> >> + * devices whose final part of the DRM chain can be physically remove=
d and
> >> + * later reconnected (possibly with different hardware).
> >> + */
> >> +void drm_encoder_cleanup_from(struct drm_encoder *encoder, struct drm=
_bridge *bridge)
> >> +{
> >> +	struct drm_bridge *next;
> >> +	LIST_HEAD(tmplist);
> >> +
> >> +	/*
> >> +	 * We need the bridge_chain_mutex to modify the chain, but
> >> +	 * drm_bridge_detach() will call DRM_MODESET_LOCK_ALL_BEGIN() (in
> >> +	 * drm_modeset_lock_fini()), resulting in a possible ABBA circular
> >> +	 * deadlock. Avoid it by first moving all the bridges to a
> >> +	 * temporary list holding the lock, and then calling
> >> +	 * drm_bridge_detach() without the lock.
> >> +	 */
> >> +	mutex_lock(&encoder->bridge_chain_mutex);
> >> +	if (!list_empty(&bridge->chain_node))
> >> +		list_for_each_entry_safe_from(bridge, next, &encoder->bridge_chain,=
 chain_node)
> >> +			list_move_tail(&bridge->chain_node, &tmplist);
> >> +	mutex_unlock(&encoder->bridge_chain_mutex);
> >> +
> >> +	while (!list_empty(&tmplist))
> >> +		drm_bridge_detach(list_first_entry(&tmplist, struct drm_bridge, cha=
in_node));
> >> +}
> >> +EXPORT_SYMBOL(drm_encoder_cleanup_from);
> >> +
> >
> > The name is super confusing, because it doesn't clean up anything.
> > drm_encoder_cleanup is called that way because it cleans up the encoder.
> > This function doesn't.
> >
> > Unlike what's being documented, it doesn't remove any bridge either. It
> > just detaches bridge, so let's just call it that way?
>=20
> Good point.
>=20
> What about:
>=20
>  * rename to drm_bridge_detach_from()
>  * drop the @encoder argument (get if from bridge->encoder)
>  * maybe even move to drm_bridge.c?

Yeah, sounds good
Maxime

--gtamny6ghjahqeyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaigKjgAKCRAnX84Zoj2+
dgQLAX42LEgszKsjPU/+3LFQz8tNGVf56HqdErx1pXdLpTvWmUKH+fpmdnsdAvbC
3ZlmGa4BgOnk3SuyXjrXLkyQvid/yT867XehPj4JCl3exDBnCQCUs5ObEmha8DRZ
+HJfoVLJ/Q==
=Ujr9
-----END PGP SIGNATURE-----

--gtamny6ghjahqeyo--
