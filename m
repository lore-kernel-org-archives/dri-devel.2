Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC58C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27E510E267;
	Tue, 15 Sep 2026 10:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L283CLMF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABDAB10E267
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:08:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF5B3600D1;
 Tue, 15 Sep 2026 10:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B941F000FF;
 Tue, 15 Sep 2026 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789466890;
 bh=EFuDCCHhmZhIERh5IiRlVS1QYc7TG8UKGuigUyOVcYY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=L283CLMFEBfEbGEeFMGPcKWCa/RNEhZwUgD3INFHfRk576GcBOhUmUBi6B2xAor5O
 p1AQE3EPUIIOqE7CRWcJwSUr8l+kQ8C4Dbz6FDx/Vj7S9fjQM+bJGRo3CXqEoV123j
 6keeWjdGWuG8tnp5PaeeEs7GQf8n2yWHEHDwxzYm9SKha6sM6K1C1onN+hmttIIZHe
 B71ZeDejbNivyaAGYLFnL8IAj3TkTp1WpditcsHUkRpjIY3hJLu/PfiCK8ZtWUNvTZ
 NZA/WkgUhLuIMFcf3zV+BO5wxDCI+Yt99jo9j4r4jPMkLWQ7hSayvI5vROO905yZIu
 ZK7ZfkI5LEa8Q==
Date: Tue, 15 Sep 2026 12:08:06 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com, 
 andrzej.hajda@intel.com, devarsht@ti.com, dri-devel@lists.freedesktop.org, 
 jernej.skrabec@gmail.com, jonas@kwiboo.se, jyri.sarha@iki.fi, 
 laurent.pinchart+renesas@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 neil.armstrong@linaro.org, 
 rfoss@kernel.org, simona@ffwll.ch, tomi.valkeinen@ideasonboard.com, 
 tzimmermann@suse.de
Subject: Re: [PATCH v5 06/33] drm/bridge: Implement atomic_print_state
Message-ID: <aqkY7T9tQEjdfsk2@houat>
References: <20260907-drm-state-readout-v5-6-5fa1ac7a5148@kernel.org>
 <20260915092630.1708458-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="swtkgzpt5pm7mljh"
Content-Disposition: inline
In-Reply-To: <20260915092630.1708458-1-geert+renesas@glider.be>
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


--swtkgzpt5pm7mljh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 06/33] drm/bridge: Implement atomic_print_state
MIME-Version: 1.0

On Tue, Sep 15, 2026 at 11:26:30AM +0200, Geert Uytterhoeven wrote:
> 	Hi Maxime,
>=20
> > Bridges have some fields in their state worth printing, but we don't
> > provide an atomic_print_state implementation to show those fields.
> >=20
> > Provide one.
> >=20
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> Thanks for your patch, which is now commit 4a7a146f1cc6791a
> ("drm/bridge: Implement atomic_print_state") in drm-misc/for-linux-next.
>=20
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -548,14 +548,35 @@ drm_bridge_atomic_create_priv_state(struct drm_pr=
ivate_obj *obj)
> >  		return ERR_CAST(state);
> > =20
> >  	return &state->base;
> >  }
> > =20
> > +static void
> > +drm_bridge_atomic_print_priv_state(struct drm_printer *p,
> > +				   const struct drm_private_state *s)
> > +{
> > +	const struct drm_bridge_state *state =3D drm_priv_to_bridge_state(s);
>=20
> warning: passing argument 1 of =E2=80=98drm_priv_to_bridge_state=E2=80=99=
 discards =E2=80=98const=E2=80=99 qualifier from pointer target type [-Wdis=
carded-qualifiers]
>=20
> Apparently you lost "[PATCH v2 4/28] drm/atomic: Convert
> drm_priv_to_bridge_state to container_of_const"[1] along the way?

Yes, indeed. It should be fixed now, sorry
Maxime

--swtkgzpt5pm7mljh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaqkZBgAKCRAnX84Zoj2+
dmyKAX9UX3VtLBBo01Nyfb+WqsYLqn+rPgEnXpIlhruEGPy2Mvfdj7cOQ4FgMLBg
3xN/Oz0Bf2QW+RkqdWVdJz/VcX1SVDq7YnAlTbH7mIP6p9EhebQvWPTChtJvML7t
62xFqmDZzg==
=lBDS
-----END PGP SIGNATURE-----

--swtkgzpt5pm7mljh--
