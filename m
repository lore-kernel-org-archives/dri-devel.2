Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8396C44516
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A0610E461;
	Fri, 17 Jul 2026 13:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K8gGFkIg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7999A10E461
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:19:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D3D64012B;
 Fri, 17 Jul 2026 13:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEAC1F000E9;
 Fri, 17 Jul 2026 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784294352;
 bh=QiH16PBrIOrkRcGCAsgyufx2CrvqVxXsGN6htAGGOFI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K8gGFkIgrF7bzHmkrVQf/apfwOGLqcVGkmV/1jOf98jddR3gLlswNIjt16eeT5+Bg
 bhisZcSqvgU5fB7WDSIinu1XKYLEgxZfvTAmrR6xdakPtVYREKb4DWwqpgqwrxO4uI
 DwC5LZu+FXbEpJ7NF3MaN4H3dfZsBvuPLhgN39GyHaaUVTOMfRK10dAZNOpaG+IFx7
 ToEOCAkf8TtfIZ5kbb2ueMP0Xrt76pjY9p37TBQjc/LQ89Vrwd/Lm4x3Kdded1Up3m
 KDbKD3hYQpVIGoRYRWv34zkf15GV9shUdEkw5h7J7hHwaGZI3gyXAwcn1NJLsJ8g0P
 qOr4fnAkdE9/A==
Date: Fri, 17 Jul 2026 15:19:10 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 01/60] drm/simple-kms: Add create_plane_state hook
Message-ID: <20260717-naughty-umber-pig-1e98e4@houat>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-1-302d986fe5f0@kernel.org>
 <d043767d-585f-4e63-9da0-3cc92361616c@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="mruxdf5ghkuxo6lr"
Content-Disposition: inline
In-Reply-To: <d043767d-585f-4e63-9da0-3cc92361616c@suse.de>
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


--mruxdf5ghkuxo6lr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/60] drm/simple-kms: Add create_plane_state hook
MIME-Version: 1.0

On Thu, Jul 09, 2026 at 03:49:41PM +0200, Thomas Zimmermann wrote:
> Hi Maxime
>=20
> Am 09.07.26 um 13:50 schrieb Maxime Ripard:
> > The simple-kms helper provides a reset_plane hook to let drivers
> > override the default plane reset. However, the reset hook is
> > overloaded: it is used to create the initial software state at probe
> > time, but also to reset both the hardware and software state during
> > suspend/resume. These two roles have different expectations, and
> > reset is not fallible which makes error handling difficult.
> >=20
> > The atomic_create_state pattern was introduced to untangle this by
> > providing a hook that only allocates and initializes a pristine state
> > without any side effect.
> >=20
> > Add a create_plane_state hook to struct
> > drm_simple_display_pipe_funcs. When provided,
> > drm_simple_kms_plane_reset() will use it to allocate a fresh state,
> > falling back to reset_plane and then to the default
> > drm_atomic_helper_plane_reset().
> >=20
> > This will allow simple-kms drivers to be converted to the
> > atomic_create_state pattern.
>=20
> Have you seen
> https://lore.kernel.org/dri-devel/20260705-drm-simple-kms-removal-v1-0-b4=
e1ca053623@oss.qualcomm.com/
> ? Once this lands, simple-kms will have no users left and be gone soon
> after.

Oh, yeah, absolutely, if these get removed it makes much more sense to
just remove the code instead of converting to it.

Maxime

--mruxdf5ghkuxo6lr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCalorzgAKCRAnX84Zoj2+
dtixAX4nP6PJsLpMB5kGeEmzaaj95Jr/g/uInZ9ulpIVi53JsJwl6Rjs0BGDnYYX
mbe6yo4BgIeQdoMS4sdLUioMsTE3rgActngAbYntyxheVqPXORditEK7VMbQsIil
L2eitfA1rA==
=ndmL
-----END PGP SIGNATURE-----

--mruxdf5ghkuxo6lr--
