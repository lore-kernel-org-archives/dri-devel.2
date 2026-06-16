Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F34CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B260410EA3C;
	Tue, 16 Jun 2026 11:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LAh3jAlc";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FE2B10EA3C
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781609009;
 bh=tXrFgp97oBvrkRIGd7gIfWs2bjCoF1HJqYdYy4TBr10=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LAh3jAlc5L0bBbEFefIUDHqkBd16hpsAo93tUHl88AkeyygH/SZSfBPyOgA2Y4kE9
 7I7d1LM3dXa3Hs3bA5kindDxd70OC1wLyeKLDtb8Yw+xlzdeqFikKG8mqg3pZJB9rm
 gq+ZcPM+Cnf+ZHLRSIr0E82rWkqoqOkl8nnrfdK72496J2NnnZOJtAps79u2dYk6c3
 G1/wPEecQodTyeVG00th7GePJNhe77ke3kTO4kWZmLKd1uklLuIk/fTzo8XLrwY29t
 g3fLCsiW4ieMvZsozqPmbi1vKz7X3cnSogeRjpfptQwX6DpoA4nvt1LA4mmittaQx3
 G4qmNMFUCiznQ==
Received: from fluorite (unknown [100.64.0.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9104817E0979;
 Tue, 16 Jun 2026 13:23:28 +0200 (CEST)
Date: Tue, 16 Jun 2026 14:23:25 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH] drm/fourcc: document format naming scheme
Message-ID: <20260616142325.562b9668@fluorite>
In-Reply-To: <20260426151641.93763-1-contact@emersion.fr>
References: <20260426151641.93763-1-contact@emersion.fr>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8N/dPCSg2DoVjd_yqz7_cJ+";
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

--Sig_/8N/dPCSg2DoVjd_yqz7_cJ+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Apr 2026 15:16:58 +0000
Simon Ser <contact@emersion.fr> wrote:

> When adding a new format, one needs to pick a name and fourcc.
> This is not always an easy task: figuring out why current formats
> are named this way is tricky.
>=20
> Document current practice to make that process easier.
>=20
> See previous discussion at:
> https://lore.kernel.org/all/aocdbgbLe5WhUEOGeLg3P7fRDM8i72H9zBuUnoAjjsuvB=
LfMPofrPtaUEjII_43KXf1wCbv1G9UutJKMkWLaEcBSnrlUV78Wrhu6l_Z0xi8=3D@emersion.=
fr/
>=20
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Cc: Daniel Stone <daniel@fooishbar.org>
> ---
>  include/uapi/drm/drm_fourcc.h | 39 +++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index ac66fa93b5a3..dc737c4fa5f2 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -38,6 +38,45 @@ extern "C" {
>   * fourcc code, a Format Modifier may optionally be provided, in order to
>   * further describe the buffer's format - for example tiling or compress=
ion.
>   *
> + * Formats
> + * -------
> + *
> + * Formats describe how a buffer is interpreted to decode pixel color an=
d alpha
> + * values. Formats are uniquely identified by a four character code (fou=
rcc).
> + * Memory layout is always described in little-endian order.
> + *
> + * The following channels are defined:
> + *
> + * - "R", red
> + * - "G", green
> + * - "B", blue
> + * - "A", alpha
> + * - "C", color index (for paletted formats)
> + * - "D", darkness (inverse relationship between channel value and brigh=
tness)

Hi,

"inverse relationship between channel value and luminance"

> + * - "Y", luma/brightness

"luma"

That is, I would avoid using the term brightness here.


Thanks,
pq

> + * - "U", blue-difference chroma (Cb)
> + * - "V", red-difference chroma (Cr)
> + * - "X", a placeholder for undefined/unused contents
> + *
> + * Formats using the RGB color model have names made up of a list of cha=
nnels
> + * followed by the number of bits used by each channel, respectively. Any
> + * padding is explicitly indicated by the special "X" channel. Channels =
use
> + * unsigned integers, except when suffixed by "F" to indicate IEEE 754 f=
loats.
> + * An underscore "_" can be used to delimit planes.
> + *
> + * Multi-planar YUV formats use the following naming scheme for the most=
 part:
> + *
> + * - The first letter indicates the number of planes, channel alignment =
and
> + *   ordering. It is should not be a letter already used to denote a cha=
nnel.
> + * - The first digit indicates chroma sub-sampling: 0 for 2x2, 2 for 2x1=
, 4 for
> + *   none.
> + * - The two other digits indicate bits for the Y channel. If the Cb cha=
nnel
> + *   comes before Cr, the digits are reversed.
> + *
> + * Fourccs are allocated on a first-come, first-served basis. New format=
 names
> + * and fourccs should try to use the same naming scheme as existing, sim=
ilar
> + * formats.
> + *
>   * Format Modifiers
>   * ----------------
>   *


--Sig_/8N/dPCSg2DoVjd_yqz7_cJ+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmoxMi0ACgkQI1/ltBGq
qqet4A/9GXfKwIuWfa91d3WFtlQ5QYOn/PrQIAVPCiGqXa+JFadMVhUl+l64ZCap
Kjw4LBJteB/uFfZoh2P8uDGs+rdpY7emd/hdtX6yd37+SS/qxjeDMsYLQOXkYE/Z
nqh2ZURaZbbe6Rx5m9VuUXum/BFWXOmeG4NPktinTcwzD5QQufwrnNFARRn8rUh7
SDg8qa1egmqGjO0yS31IrPY354LfhxyKzzECqS0kBQC13NouNkhBsqeSd1kSUzq/
kEJ8vMtgzrKjtZcKI4O0GL9L/a5pYd87q4rTA2AFaP5bi4OYkQwU1aDJ6ugi4k4/
M6zigtaqnBVU40xj9M59whmvTmIUvrPZiXoLWv/NPI4Q7fnihX0xihRnNsk4M2Lj
EdytVkn8rDXP5Kk+p8bqnRxrqZ5VRJKPRKs0DUiOAUCND3lUmJxNHkQlASL3SBUH
mOv49nVaYYzazZJy2lCKWHcn++Syas2XQ6HSvhhV9DvgVEaODpFJWA3mzD4rQaGt
WGpbQU0PaOM2X2rf1vkGFLiOe4GUuYMR8BN+90ABZxYO5kq/BLdE9atRkX0sU7ww
YYpHnHzUXdNfVlJ9ECe5jrBQdXB/B4StDxJAWm2HQdJ6HEb2OF1byrlGeHKb4ZiO
QPKx/XgRHPOwIkKOPnUa6tlFjcSiARA4/HUyYCYIK6uNTpdc2rg=
=ytec
-----END PGP SIGNATURE-----

--Sig_/8N/dPCSg2DoVjd_yqz7_cJ+--
