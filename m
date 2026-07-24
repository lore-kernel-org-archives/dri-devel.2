Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB7AC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0738510F1FE;
	Fri, 24 Jul 2026 09:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FxJ1EVBr";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F402010F1FE;
 Fri, 24 Jul 2026 09:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784886882;
 bh=XruCIx6d7uZ311OHt84y4/4qsmMcYTxk6m65qTUcIOM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FxJ1EVBrVNcouYDOXNKioe1xz1NtdGL7c00eLu/DqqzdiDGPwmz/hgzG8p1OpRE8+
 Q79DBLiTee105Od1KTYH8d6xtFYxRtBqLFP6FGeyIeXwppI+vvVHclSI7Wk74YbqiH
 8i0TZ0SCMtRw+kkAYInrrfptvv47J3tTwyrlT/teb2ryTi6X2Cge1FlAFx7rQp9wQN
 g8YrQ17bTJwMGQa5aTRaoufwC2FCCQnUMFG53t3NxpY5w4abSRot7rCkcKSgFk+NBa
 qMiTUx1OF8N8XZ+UIVCBmqo3VbpPhoxPdSRj3aaHHae+CWxu7C4r/UYQBkxOXgdXyn
 MNh6Of99IiW8g==
Received: from fluorite (unknown [100.64.0.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 28EA417E01F4;
 Fri, 24 Jul 2026 11:54:42 +0200 (CEST)
Date: Fri, 24 Jul 2026 12:54:29 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>, Melissa Wen
 <mwen@igalia.com>
Subject: Re: [PATCH v3 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
Message-ID: <20260724125429.5bf43ae5@fluorite>
In-Reply-To: <c4aaa599-d1d8-4418-ada7-2e141f7a9e3f@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
 <20260623164812.81110-2-harry.wentland@amd.com>
 <20260703135227.742fad19@fluorite>
 <c4aaa599-d1d8-4418-ada7-2e141f7a9e3f@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/w9I9EBcgv30nX4+rR+0qs8l";
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

--Sig_/w9I9EBcgv30nX4+rR+0qs8l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jul 2026 15:27:55 -0400
Harry Wentland <harry.wentland@amd.com> wrote:

> On 2026-07-03 06:52, Pekka Paalanen wrote:
> > On Tue, 23 Jun 2026 12:48:02 -0400
> > Harry Wentland <harry.wentland@amd.com> wrote:
> >  =20
> >> From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> >>
> >> Introduce DRM_COLOROP_FIXED_MATRIX, a new colorop type representing a
> >> hardware that performs a fixed matrix operation.
> >>
> >> Unlike CTM-based colorops, this block does not expose programmable
> >> coefficients. Instead, userspace selects one of the predefined
> >> hardware modes via a new FIXED_MATRIX_TYPE enum property. Supported mo=
des
> >> include common YCbCr->RGB and RGB709->RGB2020 conversions.
> >>
> >> v2:
> >>  - Naming changes (Pekka)
> >>
> >> v3:
> >>  - Fix NC matrix enum name and string (Melissa)
> >>  - Rebase
> >>
> >> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> >> Reviewed-by: Melissa Wen <mwen@igalia.com>
> >> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >> ---
> >>  drivers/gpu/drm/drm_atomic.c      |   4 ++
> >>  drivers/gpu/drm/drm_atomic_uapi.c |   4 ++
> >>  drivers/gpu/drm/drm_colorop.c     | 106 ++++++++++++++++++++++++++++++
> >>  include/drm/drm_colorop.h         |  84 +++++++++++++++++++++++
> >>  include/uapi/drm/drm_mode.h       |  12 ++++
> >>  5 files changed, 210 insertions(+)
> >> =20
> >=20
> > Hi,
> >=20
> > the UAPI looks good.
> >=20
> > Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> >=20
> > It's a little bit unfortunate that the colorop UAPI documentation is
> > embedded into kernel-private enum types' documentation.
> >  =20
>=20
> Agreed. This goes beyond this patchset. I'll have a look at a separate
> series to see if we can fix that.
>=20
> > Is RGB always full-range? The documentation could be more explicit
> > about that. Maybe the documentation should spell out the matrix
> > contents just to be clear? There are more than one form of limited
> > range IIRC (HDMI, JPEG, SDI). Or maybe JPEG was a different type of
> > full-range?
> >  =20
>=20
> It's always full-range. Agreed about spelling out the matrix contents.
>=20
> >> +	 * enum string "RGB709 to RGB2020"
> >> +	 *
> >> +	 * Selects the fixed-function CSC preset that converts RGB
> >> +	 * (BT.709) colorimetry to RGB (BT.2020). =20
> >=20
> > Why is this called a "CSC preset" rather than a matrix? This confuses
> > me.
> >  =20
>=20
> Will fix that up.
>=20
> I was taking Chaitanya's patch as-is and adding my changes in Patch 2
> but with all these changes I'll end up squashing the two commits
> together.
>=20
> > Was there a conclusion from discussions around compatible pixel formats
> > for a specific choice of a fixed matrix? How will userspace discover
> > that, or will it be based on documentation and enforced as a common
> > requirement over all drivers?
> >=20
> > ISTR some hardware requiring an YUV pixel format to be able to use the
> > YCbCr conversion matrices, or vice versa. Otherwise there is no reason
> > to have that limitation.
> >  =20
>=20
> We talked about this at the Hackfest (offline most likely) and the
> consensus is that there's no reason to limit this to certain pixel format=
s.
> We should treat it as a simple matrix that operates on the 3 input channe=
ls.
> If userspace decides to select a CSC matrix for an RGB buffer it's assumed
> that that's intentional and userspace knows what it's doing.

Excellent!

Thanks, Harry!
-pq

--Sig_/w9I9EBcgv30nX4+rR+0qs8l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmpjNlUACgkQI1/ltBGq
qqd27xAAnqOk3v/4/EUbaBqCjkR9yN/9TaIA7rhNa2ujgzaUany43/ZK0H2UYsv2
gfPdqD/kWB8HxsUcj4DpjJ6wx0fLQlEBJHC/sVX/qLq55B8dRp/dhfsoETuMj6hh
u0aYrw4iIYSksrXaid71ucBA4raR8PHUsvIOUOQaVivP6Nan2IG3aFrKBaIBd6cM
VZ1rvDcXG/me8pHOTgkkpyI5sRgoGsPiLO3c/u2cjc4ysmQTCL+znlsz+8bm79qV
0G5datyaA5fpsJQdBJQjSE12PEMjnOBkl+cjQaF9Vs2/P1bszL5QUyqVRsYXUfAw
plaMzILFKJCU1JXuBcFw5gWpL5DHEJrNQiaSzIZFt2G390y/r95ROd/BYpjPgSOg
RZs74o8iK/f9xdcxnhtK0iANOTWInHZ/ZGruHQF4TmokmoNoxu5D98u4O4xYyYny
vZVhkiPNNQ0GGVuMW32IkFRWJ9CtfboYc10kg6aP+ihS9FAe+K2zFydU5Ea9pFxv
mzn//X1VbarHl0fnnl/p5tO2zromyHR081cRNi319tMkZnP03ob819lG5e1eYZP0
ldhU7GuyP+o89/r8exO9aKMwgpBxHTnt63sq+OQJRfVZvVQ4GKMLMqbNOR9D3lpX
TEXaXHTkzl/YboE4Tfz05hDDP+9v43fvS7SSMnjjzlvEDPccsMI=
=Jn6r
-----END PGP SIGNATURE-----

--Sig_/w9I9EBcgv30nX4+rR+0qs8l--
