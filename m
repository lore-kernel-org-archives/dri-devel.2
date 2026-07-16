Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82673C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B50E10F208;
	Thu, 16 Jul 2026 08:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OfZ4ymHA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9964510F1E9
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 08:19:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BF1BE6001A;
 Thu, 16 Jul 2026 08:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10CA1F000E9;
 Thu, 16 Jul 2026 08:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784189942;
 bh=CQcSJu7ir1ZxyU06FWPT4r5MnZcOUIDMyXGHVCWBTk0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OfZ4ymHAWUb0RMyBLZH/IBDPQl0rkzOG8Fe1FsYTDnOoflWlpEF9Wt3igBepiqVcP
 qg1d66d4FFxj1YLKpP2ySujFBL+Xs42E1ctWY7nnpAf6AHblDFmL9r4gArj/PGt/C7
 MPs+cjhYP/xTsw1fbX+c4Be8FhfKe9kWvRQAFR3dR8J7j0U8Ke81f+UfK+BR4Qvf2L
 u3NI2aWNsom+kdy+WhdzYwebYkO5whtECElmpKk52AcBrXmWSOXkjPzpHW82dtptsK
 WVS9zZxOPDSSuD8kV2q3lPgRA1eW0N2G3kj+UphnHtCuqqYalBXHL2uWGDhJqpu9hw
 5J8O+sj33b1mw==
Date: Thu, 16 Jul 2026 10:18:59 +0200
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
Message-ID: <20260716-expert-crouching-bonobo-ffd0b6@houat>
References: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
 <CAFZQkGzw2MZGivy=oyYgZE3_dmxu-z-NbDgzh9uyqSsj=MG=2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="synlwefppugk5zgo"
Content-Disposition: inline
In-Reply-To: <CAFZQkGzw2MZGivy=oyYgZE3_dmxu-z-NbDgzh9uyqSsj=MG=2w@mail.gmail.com>
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


--synlwefppugk5zgo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 0/8] drm: Add DRM_MODE_ATOMIC_RESET flag
MIME-Version: 1.0

Hi Xaver,

On Wed, Jul 08, 2026 at 08:25:36PM +0200, Xaver Hugl wrote:
> Hi,
>=20
> Thanks for working on this, it'll be great to finally have this solved pr=
operly.
>=20
> > Open question: should DRM_MODE_ATOMIC_RESET require
> > DRM_MODE_ATOMIC_ALLOW_MODESET? A full state reset will change CRTC
> > active states, which is effectively a modeset. Without requiring it,
> > a reset could pass flag validation but fail later at atomic_check in
> > a confusing way.
>
> The compositor may use the same CRTC states, modes etc; whether or not
> the commit actually ends up requiring a modeset depends entirely on
> the exact contents of the commit. So I definitely wouldn't require
> ALLOW_MODESET.

Just to make sure we're on the same page, you're saying that when using
the reset flag, the compositor is expected to fill the state with enough
that a modeset is unlikely to happen anyway?

Maxime

--synlwefppugk5zgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaliT8wAKCRAnX84Zoj2+
dtj5AYDBzhLK638oLf5/0o6aTZv6zoEZ5aJivXx7/5FW/eanaFacq+6rnM810xbP
VNDA50EBgLW2bz5DIlh7gyE5yibQif6lGrNqW9lEiXoI7WO9GRg/DXDsDylo5gZy
lp8k8LZ8xg==
=xvJ5
-----END PGP SIGNATURE-----

--synlwefppugk5zgo--
