Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55093C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F8E010E8BE;
	Mon, 20 Jul 2026 11:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IDjjU3B+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E0510E8BE
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:40:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A56960A8C;
 Mon, 20 Jul 2026 11:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316871F00A3D;
 Mon, 20 Jul 2026 11:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784547606;
 bh=LtBT5yJV3wwh1rF0TKf2ttwH1I4o12RgcLWPVDwDvvw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IDjjU3B+q9sFpPhOXHQoFC6n73P5Kspi7v0qnx+I6WUUCsDl/3V1Dj3BxDJYq4YFb
 U2eou6HFEBbOSsv0Rax4fLqtrIBBoihETb6s1haSViYlNwno+XdNwhurPrqkkJW8uL
 6DbNUxUrHJFfMG7bMmgav4AOsMmOFSKfP0urn6xMgGlBB6IpYTw7AYB+Xi3KTavdvw
 wPi5xBRVjZbiA53LL3sCRijSIxKUxJ58M73K0HRBihkRshl0WGnGOtgSvLJplpWwPD
 I8ZAjuOK0cN0OggmxuttrBMtZctzWioKqt2NEdJPVh7QyP46srfm8fHz8LA1Ez00mQ
 2MrvRLB3yfo2w==
Date: Mon, 20 Jul 2026 13:40:04 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Xaver Hugl <xaver.hugl@kde.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>,
 Jonas =?utf-8?B?w4VkYWhs?= <jadahl@redhat.com>, 
 Michel =?utf-8?Q?D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] drm: Add DRM_MODE_ATOMIC_RESET flag
Message-ID: <20260720-vigilant-serious-parakeet-ced4aa@houat>
References: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
 <CAFZQkGzw2MZGivy=oyYgZE3_dmxu-z-NbDgzh9uyqSsj=MG=2w@mail.gmail.com>
 <20260716-expert-crouching-bonobo-ffd0b6@houat>
 <CAFZQkGxf+GFq7HhrBOAgSfStxwptCXjYoXJjkptUoeyyN0=xVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="b7mzsale6gt6wtzj"
Content-Disposition: inline
In-Reply-To: <CAFZQkGxf+GFq7HhrBOAgSfStxwptCXjYoXJjkptUoeyyN0=xVQ@mail.gmail.com>
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


--b7mzsale6gt6wtzj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 0/8] drm: Add DRM_MODE_ATOMIC_RESET flag
MIME-Version: 1.0

On Fri, Jul 17, 2026 at 03:03:10PM +0200, Xaver Hugl wrote:
> Am Do., 16. Juli 2026 um 10:26 Uhr schrieb Maxime Ripard <mripard@kernel.=
org>:
> > > The compositor may use the same CRTC states, modes etc; whether or not
> > > the commit actually ends up requiring a modeset depends entirely on
> > > the exact contents of the commit. So I definitely wouldn't require
> > > ALLOW_MODESET.
> >
> > Just to make sure we're on the same page, you're saying that when using
> > the reset flag, the compositor is expected to fill the state with enough
> > that a modeset is unlikely to happen anyway?
>=20
> I'm saying that it's no different from a "normal" commit, and should
> just follow the normal rules for whether or not a commit needs
> allow_modeset. You can't make assumptions about which properties the
> compositor will or will not set.

Ah, I see what you mean now, thanks. It makes total sense indeed, I'll
drop that part from the cover letter.

Maxime

--b7mzsale6gt6wtzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCal4JEwAKCRAnX84Zoj2+
dh8LAXkBQvnLYARY9Kn5qebtqIsGFu3oXWmTW9jOFjyeOeL3z8yPi+q9o+pK8Cdx
f6AX9FEBf14ROH7brPKEeyivdKJBO9ZeP4xvcgQX8HlYc3YSwwOK8dQcI2INcjhP
Lqx+yvIAzQ==
=6K7v
-----END PGP SIGNATURE-----

--b7mzsale6gt6wtzj--
