Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6394CCD98CF
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D8510E9FA;
	Tue, 16 Jun 2026 10:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Zw8qcEvN";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0699410E9FC
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781604976;
 bh=uRPBV3NRgFuJjsk3g49SsuzRkEgvpuHx1Qn5bx2Zt10=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Zw8qcEvNU509OUddW7E7ju71Qs0Zr+tL+42P85eP4A0YH31Xq5IHJaqFt353pOfu+
 EF4qXKs70W17awIziQ1mBRhdKDqj5dR0bOqE0xIQa5icjAvtWqGRWzhQsnsYIoU7J1
 CwEiGOAJeoRKXCQbaS9fvl7NeCf4qy4D52J257sMcNAmsV5YW/YSKkKbRyV95iwItB
 DLlcvBY0ytdpbhDa0ABuDjwcdsk9hRoVNDcWtsnglcNS7kCq1G4KlZ1W7PkvlOniLT
 vTudAHAEopzRJEUk9blil15C7ZyMksNF+t7dgCNHyJyv4DSzPOGGjoug+iXcicJEF/
 DXRxWWyQk8nhw==
Received: from fluorite (unknown [100.64.0.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 13FF717E02B5;
 Tue, 16 Jun 2026 12:16:16 +0200 (CEST)
Date: Tue, 16 Jun 2026 13:16:03 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com,
 daniels@collabora.com, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, ville.syrjala@linux.intel.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] drm/drm_blend: allow blend mode property without
 PREMULTI
Message-ID: <20260616131603.36419c30@fluorite>
In-Reply-To: <20260526181700.25310-1-leandro.ribeiro@collabora.com>
References: <20260526181700.25310-1-leandro.ribeiro@collabora.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yx7=DrV48uMLM6BaCx_wCJY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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

--Sig_/yx7=DrV48uMLM6BaCx_wCJY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 26 May 2026 15:16:58 -0300
Leandro Ribeiro <leandro.ribeiro@collabora.com> wrote:

> Some hardware only supports the COVERAGE blend mode and lacks PREMULTI
> support entirely. DRM currently requires that PREMULTI is present when
> creating a blend mode property, which prevents such drivers from being
> properly upstreamed.
>=20
> This series removes this restriction and allows drivers to create a blend
> mode property without PREMULTI.
>=20
> On Weston (userspace), we are working [1] towards adding support for
> this kind of hardware.
>=20
> [1] https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2046

Hi,

the series is:

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>

Thanks.

>=20
> v4:
> - Trigger warnings instead of errors when pixel format with alpha is
>   exposed but blend mode is not setup.
> - Require blend mode only when plane exposes pixel formats with alpha, not
>   when it supports the alpha property.
>=20
> v3:
> - Changed where we enforce drivers to expose blend mode for planes that
>   support the alpha property or pixel formats with alpha.
> - Fixed missing check to forbid calling
>   drm_plane_create_blend_mode_property() with a zero bitmask of
>   supported modes.
>=20
> v2:
> - Force drivers to expose blend mode if plane supports alpha property
>   or pixel format with alpha.
>=20
> Leandro Ribeiro (2):
>   drm/drm_blend: allow blend mode property without PREMULTI
>   drm: ensure blend mode supported if pixel format with alpha exposed
>=20
>  drivers/gpu/drm/drm_blend.c       | 20 ++++++++++++++------
>  drivers/gpu/drm/drm_mode_config.c | 21 +++++++++++++++++++++
>  2 files changed, 35 insertions(+), 6 deletions(-)
>=20


--Sig_/yx7=DrV48uMLM6BaCx_wCJY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmoxImMACgkQI1/ltBGq
qqdDMBAApAoj4pV0RNStqTOeK/bDLfyDkp/+AhsVtaF5CwjUDjmNKSN44WJ717O7
kJk4PH3aw2SgXxUNhYbdWMBjmFeLJmlpKQfiXCX+aRiuHQFqKfOZHxk7LLjAqsZ6
WEyhlA0QxEKH/EKEsUJzLyFEMvL0WF3aZsgqGiLZp1Z4tNFhpONXgpyQB7A3yFup
nc8kNZsauFS1bcJ4qvq0LZ9AEQ3pwxlJl6+Q5mIL5wjLLYQqoY7GFoCAqYldE89V
0ldBc8Z2p1Efe7mNcW9MOpsJmqyTLZzkMzcTRjwogia5+0eaXM+up4qzMdWFy+wl
SNqTn6OhGR3UK8BHJagiJG6OrRvD3qB6GOM0nToYvMBvud0DJfDbBUAIAwDhxX0C
w36jr0QR7eM96MHikwJykiCTETgzdDbUbsNldPcELhYxnOMskn3cJ1DZQ86m7GcA
oQZySfTg8bm3II1fXVVQ7K2KyrMN9tUeKQMugQU2k26+x808iqgZzSb7MAPrTEyH
bQ6fDBcZSXX/9cPJIUF6PP1M0I0s8MiBicLp4f0SOsn90TIyw/cn7olu7fw2qITC
5B9Z39csP3uG3IGzPlYvkh+WW6Vtjvj5RNPJUxTGfG6hhbfyHwwcVizX0V8/71J7
0e5UVBgQjq4vxje25LkSexZeSgELmYQ265q05ZkFT3fPGyoeX0Y=
=Fasu
-----END PGP SIGNATURE-----

--Sig_/yx7=DrV48uMLM6BaCx_wCJY--
