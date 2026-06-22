Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6B8CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6272F10E5CA;
	Mon, 22 Jun 2026 09:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f+DOkQcO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6DC10E5CA;
 Mon, 22 Jun 2026 09:53:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F9356001A;
 Mon, 22 Jun 2026 09:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC741F000E9;
 Mon, 22 Jun 2026 09:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782122030;
 bh=PGlDS3j1bTwkm7/mR7g06bYQu8BEHF6QsnOVkjfGOVo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=f+DOkQcOUtCm9yLNGjvifSq5anPBduAl6GDg4kELHr/ypnG65aAFDlt9lpbBGSBWO
 94uBKgJQzB+ejF0bTld6/+M7OAE7IHZaaNUJblC2LEqmEQdGfeaGFlDeWu6i6N1X7G
 sWRsV5ZZL4OCiN7zeUQbQZtWhJ9Nh7sbUTaO52KFAPG5PyKdiHPqvX3vYKpkzevBOd
 BM9cYsiYCB/Kq09mUSeC0Kx5GEhPaFPTAgSeHifP0yrz+Gy+9Rmmjf7YGYJSlx2CxF
 LCunUP6PEw4lsykgY890WpZXbbXm2w+RxoL1bL+iE9/TfGZCmPeDQhP3S9WDcRMANp
 aeJmWnz1vUlqg==
Date: Mon, 22 Jun 2026 11:53:47 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Simon Ser <contact@emersion.fr>, Harry Wentland <harry.wentland@amd.com>, 
 Melissa Wen <mwen@igalia.com>, Sebastian Wick <sebastian.wick@redhat.com>, 
 Alex Hung <alex.hung@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 Daniel Stone <daniels@collabora.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v6 15/19] drm/connector: Add new atomic_create_state
 callback
Message-ID: <20260622-onyx-puma-of-honeydew-5aeff9@houat>
References: <20260526-drm-mode-config-init-v6-0-852346394200@kernel.org>
 <20260526-drm-mode-config-init-v6-15-852346394200@kernel.org>
 <DJD5YZ2K1047.3UJ5QMMLQO6UY@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="f6ogpizns56pjwao"
Content-Disposition: inline
In-Reply-To: <DJD5YZ2K1047.3UJ5QMMLQO6UY@bootlin.com>
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


--f6ogpizns56pjwao
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 15/19] drm/connector: Add new atomic_create_state
 callback
MIME-Version: 1.0

On Fri, Jun 19, 2026 at 06:24:46PM +0200, Luca Ceresoli wrote:
> Hello Maxime, Dmitry, all,
>=20
> On Tue May 26, 2026 at 6:46 PM CEST, Maxime Ripard wrote:
> > Commit 47b5ac7daa46 ("drm/atomic: Add new atomic_create_state callback
> > to drm_private_obj") introduced a new pattern for allocating drm object
> > states.
> >
> > Instead of relying on the reset() callback, it created a new
> > atomic_create_state hook. This is helpful because reset is a bit
> > overloaded: it's used to create the initial software state, reset it,
> > but also reset the hardware.
> >
> > It can also be used either at probe time, to create the initial state
> > and possibly reset the hardware to an expected default, but also during
> > suspend/resume.
> >
> > Both these cases come with different expectations too: during the
> > initialization, we want to initialize all states, but during
> > suspend/resume, drm_private_states for example are expected to be kept
> > around.
> >
> > reset() also isn't fallible, which makes it harder to handle
> > initialization errors properly. This is only really relevant for some
> > drivers though, since all the helpers for reset only create a new
> > state, and don't touch the hardware at all.
> >
> > It was thus decided to create a new hook that would allocate and
> > initialize a pristine state without any side effect:
> > atomic_create_state to untangle a bit some of it, and to separate the
> > initialization with the actual reset one might need during a
> > suspend/resume.
> >
> > Continue the transition to the new pattern with connectors.
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> As I'm rebasing another series on current drm-misc-next, which now includ=
es
> this patch, I ran into troubles and I'm not sure what is the right thing =
to
> do. I hope you can help me clarify this. See below for my question.
>=20
> FTR the series I'm rebasing is "drm bridge hotplug", but the question is
> not specific to that series.
>=20
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -616,11 +616,19 @@ int drmm_connector_hdmi_init(struct drm_device *d=
ev,
> >
> >  	/*
> >  	 * drm_connector_attach_max_bpc_property() requires the
> >  	 * connector to have a state.
> >  	 */
> > -	if (connector->funcs->reset)
> > +	if (connector->funcs->atomic_create_state) {
> > +		struct drm_connector_state *state;
> > +
> > +		state =3D connector->funcs->atomic_create_state(connector);
> > +		if (IS_ERR(state))
> > +			return PTR_ERR(state);
> > +
> > +		connector->state =3D state;
> > +	} else if (connector->funcs->reset)
> >  		connector->funcs->reset(connector);
>=20
> Here a state is added to connector->state, and that's fine.
>=20
> However non-HDMI connectors don't get a state created by default.

That's true, but I don't see how this particular patch affects it? The
call sites of reset are now falling back to atomic_create_state, but it
doesn't change anything wrt when reset is (or was?) called, which seems
to be what you're talking about.

> I was hit by this with the drm_bridge_connector which it can add either an
> HDMI or a non-HDMI connector [0]. In the former case it calls
> drmm_connector_hdmi_init(), which creates the state (in the hunk quoted
> above). In the latter case, as I experienced at runtime and confirmed by
> code inspection, it does not create a state: no one calls
> connector->funcs->atomic_create_state.
>=20
> I suspect this is related to patch 19/19 which converted the
> drm_bridge_connector from drm_atomic_helper_connector_reset() to
> drm_atomic_helper_connector_create_state(), and only the former sets
> 'connector->state =3D conn_state'.

But it's pretty much the same story here? it changes the implementation,
but it should be called at the same time it used to.

> Generally speaking, looks like a state is created only for HDMI
> connectors.
>=20
> The hardware I have uses the drm_bridge_connector in the non-HDMI case, so
> the state is not created and this results in a NULL pointer deref later o=
n,
> in my case it's in in drm_atomic_connector_get_property().
>=20
> Am I missing anything obvious?
>=20
> For now I've come up with a quick workaround, adding (roughly after
> connector init at [1]):
>=20
>         if (!connector->state)
>                 connector->state =3D drm_bridge_connector_create_state(co=
nnector);
>=20
> I'm not sure which would be the best solution. Maybe taking the whole
> atomic_create_state/reset state creation calls [2] from
> drmm_connector_hdmi_init() and hoist them up into
> drmm_connector_init(), so all connectors benefit?

Generally speaking, either drm_mode_config_reset() or
drm_mode_config_create_initial_state will fill $object->state on most
drivers. For dynamic connectors, you'll need to create the initial state
when creating the new connector.

That's what intel (in intel_connector_alloc()) is doing
https://elixir.bootlin.com/linux/v7.0.11/source/drivers/gpu/drm/i915/displa=
y/intel_dp_mst.c#L1684

amdgpu through the call to amdgpu_dm_connector_funcs_reset():
https://elixir.bootlin.com/linux/v7.0.11/source/drivers/gpu/drm/amd/display=
/amdgpu_dm/amdgpu_dm_mst_types.c#L632

nouveau through the call to mstc->connector.funcs->reset()
https://elixir.bootlin.com/linux/v7.0.11/source/drivers/gpu/drm/nouveau/dis=
pnv50/disp.c#L1262

Would it be possible that it's not a regression but rather that you just no=
ticed it?

Maxime

--f6ogpizns56pjwao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajkGKwAKCRAnX84Zoj2+
dtpWAX9tgWo9zSUmrWjC8/uaxeVPykFrAc1DwueWjnmG+mCx6vzsaVKAG/3PAohB
dAOBnMgBfi7zJ6FU39y9KifVnteeQ51HquN3WWD6SaLKoY1dAj6zvDAnAwd3tNx+
e9/+TgO1ng==
=ldTX
-----END PGP SIGNATURE-----

--f6ogpizns56pjwao--
