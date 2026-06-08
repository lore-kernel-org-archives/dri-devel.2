Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E14CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC7AD10F6C6;
	Mon,  8 Jun 2026 16:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KEhIMCMz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D64D010F6C6
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:19:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C59A60098;
 Mon,  8 Jun 2026 16:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C62A1F00893;
 Mon,  8 Jun 2026 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780935546;
 bh=R3Z20AJRFlrn3I6gBIdCthY852ZvGcgCvslVKks3jdE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KEhIMCMzwxzkDHNdcZARfHslvG9abosPfkZjTXmBsRSaEeQbbtY2UC5cLmzaBYrY3
 WA6G2b4Sqm6A7f9y/8OSTZZsbeJxitCd3kkn7ZbqqmsvwtGeUVf4/3o+m/BVymhYGs
 6ULe9mNY9PvJzI9GriSFuO1dCWYQ6vhoBUep84nf/URq4g0BX1FjRubhvRSeXOiF6A
 6qAiI92N3um3PoheMk1Hk5oDZ+Jo+2XX9vaK67LrG1mriSDgZUJVVyAZHUYYSqAJMC
 FCJlpzX8xiM/qt9iNir1QPgxpPAUYg1Uq3AnGi36OusWa/QF4Pc2kSzYkXxZPP7SbG
 0p3lG4e+wIDkg==
Date: Mon, 8 Jun 2026 18:19:04 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Paul Kocialkowski <paulk@sys-base.io>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/logicvc: Avoid use-after-free with devm_kzalloc()
Message-ID: <20260608-beetle-of-infinite-atheism-bcfcee@houat>
References: <20260601-logicvc-uaf-v1-1-8c9ca5b3429c@bootlin.com>
 <20260601-ultra-wapiti-of-imagination-ba59e8@houat>
 <5Q6YIC1WTqOFVMFErYGBEQ@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="bovnjmgxpnjf6dtx"
Content-Disposition: inline
In-Reply-To: <5Q6YIC1WTqOFVMFErYGBEQ@bootlin.com>
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


--bovnjmgxpnjf6dtx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/logicvc: Avoid use-after-free with devm_kzalloc()
MIME-Version: 1.0

On Mon, Jun 08, 2026 at 05:41:11PM +0200, Romain Gantois wrote:
> Hi Maxime,
>=20
> On Monday, 1 June 2026 09:11:21 CEST Maxime Ripard wrote:
> > Hi,
> >=20
> > On Mon, Jun 01, 2026 at 08:52:44AM +0200, Romain Gantois wrote:
> > > The logicvc driver calls drm_universal_plane_init(),
> > > drm_crtc_init_with_planes(), and drm_encoder_alloc(). These functions
> > > should not be called with structs allocated with devm_kzalloc(), as t=
his
> > > can lead to use-after-free bugs. In fact, a use-after-free caused by =
this
> > > has been observed on a v6.6 kernel.
> > >=20
> > > Use DRM-managed allocations instead for panel, CRTC and encoder objec=
ts.
> > >=20
> > > Found using KASAN.
> > >=20
> > > Fixes: efeeaefe9be56 ("drm: Add support for the LogiCVC display
> > > controller") Cc: stable@vger.kernel.org
> > > Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> >=20
> > You're only partially fixing the issue. You also need to protect any
> > device resource (register mapping, clocks, etc) are no longer accessed
> > after the device has been removed, and this is typically done using
> > drm_dev_enter/exit.
>=20
> Sorry there's something which I don't quite understand: is this a new iss=
ue=20
> which is specifically introduced by my changes in this series, or a diffe=
rent=20
> issue in this driver which isn't handled by my series?

A bit of both I guess ? :)

My point was that while your commit log claims you avoid use-after-free,
and your patch definitely avoids some, you can still trivially trigger
some.

Whether you want to fix them all at once or prefer to defer it to a
later point in time is equally fine by me, but you need to be aware that
it's not done, and you probably want to have it in the commit log
somewhere too?

> IIUC all I'm doing here is just letting the drmm code handle cleaning up =
the=20
> plane, crtc, etc. objects instead of doing it "by hand" with devm_kzalloc=
=2E Why=20
> does this make it necessary to add additional protection of driver resour=
ces?

It's not necessary, but it's also kind of the same issue. The reason we
need to have drmm over devm is that the driver stays around longer than
its device, so devm-allocated memory would have been freed.

But that's also the case for *any* devm resource, or more generally any
resource linked to that device, so register mappings, clocks,
interrupts, etc.

So yeah, it's a different symptom of the same underlying cause.

Maxime

--bovnjmgxpnjf6dtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaibreAAKCRAnX84Zoj2+
dsb5AYDf3YIEOc+zBtjagjbZif5hVTnP4x8u4XFwYsJTD/yvBmtSc6IwUWam5dW3
KFQro4UBf3NGXq3qPZrHVrysusrcQYk1DElmCfFx+e4wlD2XDbQwDnKlLEnTbEhC
CdEQfoEZjQ==
=6Jqq
-----END PGP SIGNATURE-----

--bovnjmgxpnjf6dtx--
