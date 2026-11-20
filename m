Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAAE606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F87qWrjh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27D9112A13;
	Fri, 20 Nov 2026 13:00:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B0C112A13
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:00:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 26097410EE;
 Fri, 20 Nov 2026 13:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659EA1F000CF;
 Fri, 20 Nov 2026 13:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179647;
 bh=+jBZAKYDNQ+SGKZHZbIBu5jHoCUDsnC2eaLqm4QRu6A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=F87qWrjhne/w7Bdy0BSJ823FU2iUNucS8DQpYayoPu6+pSju2c8YpRGpQhavoAdkX
 ahSjnJBuxuagVMJMRqBqOmsNG1JCN6WOWedBWLWyuM5mF4Hwec+wXOAa6ugp3gJbLG
 ut6kow/RvOUZHizs+4KLfBeOD1o+tZgC7dEFLjddPQ+pAmjrlw5Q+a9Le6ew3AbDsT
 wS5IGDGOw20ThQg7SAAtSdOfa4le6kOaBQrfWoBfWKmvT7YPi14IK7HwiGGB2LnW4s
 oA/8Yleqh0ysTX3ab3L2o28q5271U8OnZRjlJQiAPG4icaOQVGoaJnlH0tc/uPEHg/
 s29ck2yBlilsQ==
Date: Fri, 20 Nov 2026 14:00:44 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Paul Cercueil <paul@crapouillou.net>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>
Subject: Re: [PATCH v8 00/39] drm: Implement state readout support
Message-ID: <awBDY37sXERwmU_O@houat>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <ff10a7e1-3a5d-4e0f-be4b-aba3d05de1cd@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="qt2j3rgaziiz2ej2"
Content-Disposition: inline
In-Reply-To: <ff10a7e1-3a5d-4e0f-be4b-aba3d05de1cd@ideasonboard.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--qt2j3rgaziiz2ej2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 00/39] drm: Implement state readout support
MIME-Version: 1.0

Hi Tomi,

On Tue, Nov 17, 2026 at 05:17:42PM +0200, Tomi Valkeinen wrote:
> On 06/11/2026 15:14, Maxime Ripard wrote:
> > Here's a series that implement what i915 calls "fastboot", ie,
> > initializing the initial KMS state from the hardware state at boot, to
> > skip the first modeset if the firmware already set up the display.
> >=20
> > This series creates the infrastructure in KMS to create that state by
> > relying on driver specific hooks. It also implements some infrastructure
> > to check during non-blocking commits that the readout helpers work
> > properly by reading out the state that was just committed and comparing
> > it to what was supposed to be committed.
> >=20
> > This relies on another set of driver hooks to compare the entities
> > states, with helpers providing the default implementation.
> >=20
> > It then implements the readout support in the TIDSS driver, and was
> > tested with the SK-AM62 board. This board in particular is pretty
> > interesting, since it relies on an DPI to HDMI bridge, and uses the
> > drm_bridge_connector infrastructure.
> >=20
> > So the readout works with the current state of the art on embedded-ish
> > platforms.
> >=20
> > Unlike the earlier RFCs, it now works fine: the state is picked up
> > properly, doesn't trigger a modeset if what was programmed is the one
> > the first modeset tries to pick as well, will switch properly if it
> > isn't, etc.
> Sorry for taking so long with this, even if I said already a long time ba=
ck
> that I have additional patches for you. I now finally managed to get them
> into some kind of order, and I have pushed a branch to:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git
> ti/boot-splash-v8.5
>=20
> It's based on today's drm-misc-next, with the following posted series on
> top:
>=20
> - [PATCH RESEND 00/83] drm: Switch drivers to
> drm_mode_config_create_initial_state
> - [PATCH v8 00/39] drm: Implement state readout support
>=20
> However, from the SRO series, I dropped all the tidss patches. It was
> getting so difficult to make my changes at changes on top, so I decided to
> just make fresh clean ones. I've tried to keep authorship where applicabl=
e,
> but I could have missed some.
>=20
> After the SRO series, I have a pile of patches on top. It starts with tid=
ss
> patches that are not quite SRO related, but fix things or change the
> structure so that SRO gets easier to add:
>=20
> drm/tidss: Fix the plane staying disabled after a CRTC off and on
> drm/tidss: Remove the unused 'is_enabled'
> drm/tidss: Split requesting the interrupt from enabling it
> drm/tidss: Split dispc_init_hw() into steps called from probe
> drm/tidss: Reset the DSS after the probe steps that can defer
> drm/tidss: Keep the DSS enabled from the reset to the end of probe
>=20
> Then I have some non-tidss patches. Some of these, I think, you already h=
ad
> in a local tree or were posted in the tilcdc series. The panel side is
> lacking, so I labeled those as hacks. I'm not quite sure how to correctly
> implement that.
>=20
> drm/atomic_sro: Do not compare the plane zpos
> drm/atomic_sro: Do not compare planes on an inactive CRTC
> drm/atomic_sro: Add a device-level atomic_sro_install_state hook
> drm/bridge: Add an atomic_sro_install_state hook for bridges
> HACK: drm/bridge: panel: Prepare and enable the panel when installing the
> state
> HACK: drm/panel: simple: Set the sync polarities of Microtips MF-101HIEBC=
AF0
>=20
> Then I have tidss SRO patches. Many of these are based on yours, but there
> are plenty of details that have changed, fixing issues I found when testi=
ng
> different combinations.
>=20
> drm/tidss: Implement .hw_reset hook
> drm/tidss: Reset the DISPC at runtime suspend if probe did not reset it
> drm/tidss: dispc: Add helpers for the state readout
> drm/tidss: encoder: Implement atomic_sro_get_current_crtc
> drm/tidss: oldi: Implement hw readout support
> drm/tidss: dispc: Keep DPIENABLE of an active VP in dispc_vp_init()
> drm/tidss: crtc: Implement hw readout support
> drm/tidss: plane: Implement hw readout support
> drm/tidss: encoder: Implement bridge state readout
> drm/tidss: Implement hw readout support
>=20
> I have been testing these with AM62-SK, HDMI and OLDI, with all the
> different combinations I've come up with. However, I realized just today
> that the bootloader could still do things a bit differently, which wouldn=
't
> work with the current patches. I decided to ignore that for now.
>=20
> I also need to test all this on other TI boards, without SRO, or perhaps
> adding SRO if it's easy-ish.
>=20
> So... Again, thanks Maxime for the great work you've done here, I really
> like this series. It's annoyingly complicated to get to work reliably,
> though, but maybe we'll get there =3D). With all my tests now working, I'=
ll
> try to find the time to actually review the series.

Thanks a lot for your work too. I share the frustration because I don't
have access to all the hardware variants :)

I've just sent a new version that fixes a fair number of issues you were
facing and creates an install_state hook you needed. I've also split the
tidss readout changes to make it easier to review / modify, but then
your branch diverged a fair bit from mine and I didn't have a good
enough understanding of the tidss driver to reconcile most of the tidss
changes you made.

The core should have everything you need though, so hopefully we can
merge the core changes if sashiko doesn't anything of importance, and
merge the tidss changes once we have something reliable.

Maxime

--qt2j3rgaziiz2ej2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawBEfAAKCRAnX84Zoj2+
dijLAYCZ6Kt9X1o20xnHKgAUSQO4bNBEyWmB4U7dOLjTMDp4z8wPre3i0JhaLLr5
KbaZ1WMBgISVdE0t4CJYT9QgggzxMqlWwIJP8e3pd7WGsdmZoeNwI03lL2CzEhH6
SLO9mPfCVQ==
=ErJX
-----END PGP SIGNATURE-----

--qt2j3rgaziiz2ej2--
