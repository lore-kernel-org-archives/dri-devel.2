Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B61CA5FE2
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554E110F7B4;
	Fri,  2 Oct 2026 08:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B8RtCgNT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D8510F795;
 Fri,  2 Oct 2026 08:00:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6809960A6A;
 Fri,  2 Oct 2026 08:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E3E1F000FF;
 Fri,  2 Oct 2026 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790928008;
 bh=tZaiyuolAH6x+obpvH2moD5Z/ak5nVr2jSoCPtokP+s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=B8RtCgNTeRqULctPxyg7fvHejJxeADFTmOOtHc6p744FBzUSCNyXpmMJ8mhbmpB9H
 MpZAkhudDCPe/j6BU58pRFoGbTgj6LSBI6mJJmyEYDuhBSVSUR0MYb10HTdhp51aXM
 GEmlgC8/1vMbewDbasmE63kTiaIqudGFHfLUxA1mQBOgQy6IQMs0zoqKql1tKrkMMf
 x7xeiNjJ3jt2d/RF4aJ/MkyuD149O1twTT2U1w/hNB4pOaevDpwAdH+a3azzXHdu3d
 G5qNVriBt0GsFog4ZqX8RoGBiW/f8mjkJdXO79cBDFfx2AsHgFfcRvb1CuYinluSXH
 nBALpfQZuCdhw==
Date: Fri, 2 Oct 2026 10:00:03 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>, 
 David Herrmann <dh.herrmann@gmail.com>, Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v8 04/14] drm: add connector backlight (LUMINANCE)
 infrastructure
Message-ID: <ar9kR_SmugvIVIuR@houat>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-5-mario.limonciello@amd.com>
 <25c3dd77-bedc-4822-b687-0ea429db0dc7@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="j5tnvnq3zihu4bat"
Content-Disposition: inline
In-Reply-To: <25c3dd77-bedc-4822-b687-0ea429db0dc7@amd.com>
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


--j5tnvnq3zihu4bat
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 04/14] drm: add connector backlight (LUMINANCE)
 infrastructure
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 03:12:25PM -0400, Harry Wentland wrote:
> On 2026-09-08 00:40, Mario Limonciello wrote:
> > Backlight brightness is a property of a display, and thus of a DRM
> > connector, yet it has historically only been controllable through the
> > separate backlight sysfs interface. Add a generic, backend-agnostic
> > per-connector LUMINANCE range property so brightness can be driven
> > through the atomic modeset path like any other connector state.
> >=20
> > A struct drm_backlight is embedded in every connector and initialized by
> > the core; drivers do not allocate it. A driver links a backend (today a
> > backlight_device, in the future DDC/CI, MIPI-DCS, ...) with
> > drm_backlight_link(), which creates the connector's LUMINANCE property
>=20
> I didn't follow the whole discussion so I'm curious why we decided to
> name this LUMINANCE. I think of nits or cd/m^2 when I hear luminance.
> I think it's dangerous when we use for a property that is currently
> not able to describe the output in nits. You would also then have to
> define whether you're dealing with a fully white screen, or parts that
> are white. In short, you're ending up in color management territory where
> these things have specific meanings and it's easy to get it wrong if
> we don't define the nuances right.
>=20
> Why not simply call it BACKLIGHT, which is what it is? Later, if we then
> add support for luminance (in absolute nits) we can use the LUMINANCE
> term for that. Otherwise it'll be lost to us and be apt to confuse
> people.
>=20
> I'm on the fence about calling it "drm brightness", as suggested by Jani,
> but could get onboard with something like PANEL_BRIGHTNESS.

I don't think we should mention panel here, it will be useful for at
least HDMI and DP too.

brightness works for me though

Maxime

--j5tnvnq3zihu4bat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar9kfAAKCRAnX84Zoj2+
dmQWAXoDUnrmiNPDLpf1OqQoClviOuUeVd4Th4UNuXY18mNg65dMIxJzbKmfeGMR
fO1deXYBgICtjGyVqQatKYKMBKk2rdqZbWXxoEgVHvZkBh0Y/ZhGjU8Ml2qw4+Rj
Y4Sv+GIlvg==
=rnwG
-----END PGP SIGNATURE-----

--j5tnvnq3zihu4bat--
