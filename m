Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9EACD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51B510EA3C;
	Tue, 12 May 2026 11:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J8YO0ZSO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08FFF10EA3A;
 Tue, 12 May 2026 11:20:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E86D600CB;
 Tue, 12 May 2026 11:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE45C2BCF7;
 Tue, 12 May 2026 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778584819;
 bh=2jedvzRODIy0aM0w0b/E87Dat827KNFORoAv3LWRrz4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J8YO0ZSOzIjflSZJr0DZKPnr+DRX60e09MiC6pW9JdF5OF34lueN+dZ0PZphtTH0e
 l9WILXKX2odoqHyWAy0oNOBQDr32THa7Khl7IQ5esV84ijRdQMhEQjNd2hDPQNtwKP
 CUmC6AZPr3/BkcTJ3grVxb4E62K8oVYzQQqXzJUndlDacVwwhUnu8mO9ca5NJSU90b
 dPShj06d1FySYphQkeqnA1EKB3oDt/0ZFHbY5D5gdJjncplMam3xpYKcYK9SfIdjdu
 T6hb46FbdEeBSPK47ciqG89Q/ZY4ldpcyB0aeMM0r/oRPRlESBPuK9+Mcg3LpQEaXu
 +bre36YCOR+ig==
Date: Tue, 12 May 2026 13:20:16 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Simon Ser <contact@emersion.fr>, 
 Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Alex Hung <alex.hung@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 17/20] drm/drv: Switch skeleton to
 drm_mode_config_create_initial_state()
Message-ID: <20260512-juicy-civet-of-finesse-ec3afa@houat>
References: <20260424-drm-mode-config-init-v3-0-8b68d9db0d8b@kernel.org>
 <20260424-drm-mode-config-init-v3-17-8b68d9db0d8b@kernel.org>
 <20260504180216.GU1344263@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="rygcy26rmi7yaxid"
Content-Disposition: inline
In-Reply-To: <20260504180216.GU1344263@killaraus.ideasonboard.com>
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


--rygcy26rmi7yaxid
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 17/20] drm/drv: Switch skeleton to
 drm_mode_config_create_initial_state()
MIME-Version: 1.0

On Mon, May 04, 2026 at 09:02:16PM +0300, Laurent Pinchart wrote:
> On Fri, Apr 24, 2026 at 12:18:57PM +0200, Maxime Ripard wrote:
> > The driver skeleton currently recommends calling
> > drm_mode_config_reset() at probe time to create the initial state.
> >=20
> > Now that drm_mode_config_create_initial_state() exists to handle
> > initial state allocation without hardware side effects, update the
> > skeleton to recommend it instead.
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  drivers/gpu/drm/drm_drv.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index 985c283cf59f..f537556b06a8 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -340,11 +340,13 @@ void drm_minor_release(struct drm_minor *minor)
> >   *
> >   *		// Further setup, display pipeline etc
> >   *
> >   *		platform_set_drvdata(pdev, drm);
> >   *
> > - *		drm_mode_config_reset(drm);
> > + *		ret =3D drm_mode_config_create_initial_state(drm);
> > + *		if (ret)
> > + *			return ret;
>=20
> There's one point I'm still not sure to understand properly. The
> skeleton example (and the tidss driver, which you convert to the new API
> in this series) both call drm_mode_config_helper_resume(). This in turn
> calls drm_atomic_helper_resume(), and drm_mode_config_reset(). For
> drivers that implement .atomic_create_state() instead of .reset() (such
> as tidss, after its conversion in this series), drm_mode_config_reset()
> will call the drm_mode_config_*_create_state() helpers, which allocate
> and initialize a new state (through .atomic_create_state()), and store
> that new state in the object's ->state field. Won't this leak the state
> previously stored there ?

Thanks for spotting this, you're totally right!

I'll fix it in the next version
Maxime

--rygcy26rmi7yaxid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCagMM8AAKCRAnX84Zoj2+
dqMTAX4+C/N/6qqumlD90BfbZjdzWkhPBQkqLDNaYwKx9LU0sBlx0VJLQ4knia38
EOykUagBgIU9TribMz2NX8ktAEEMvAeCv8zw4fHOO2haBPYlQ/2XygkooyEr/wld
Ls4x7K64WA==
=UCOU
-----END PGP SIGNATURE-----

--rygcy26rmi7yaxid--
