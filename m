Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D5C1075290
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C8A410E946;
	Thu, 19 Mar 2026 10:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZW7C1giB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 350B110E0B0;
 Thu, 19 Mar 2026 10:00:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B70954417D;
 Thu, 19 Mar 2026 10:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42094C2BC87;
 Thu, 19 Mar 2026 10:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773914404;
 bh=9yXU7NQ8slXEU5uL7xqrxMIKdXIB5ElT1zkpvy07CWk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZW7C1giBmavYbJ2U/XdajEW8eqH6EnYEZ+196EThBtJ3vglejOgs0H0SgKJ5ccWh4
 y/4SgV6/z3b3tYL5bMFcATzOAxOKjLTmLWNiEMagfGn6Li+z3qnSs+g0bH9o5zas9E
 9nZEOyRD7TY4UP/MZTtq7DFFk/EeyIjaIIQysUmw0e/kMBJsqMIlT9ImSxrxUhhbqm
 E8WX+4NRe8OjGKEUsow/hYxVQLwLon1I2egOW+jwlLPzLDtyNooqTA6SosaMoHsC/X
 bZNaUZYEPeaBXbUcMCXaBTfOzWPRJtU1s1AlvSkKOeX+VH0h2JTDBHnw8s6Qt3qZ9t
 QxgYgjnwuHsJw==
Date: Thu, 19 Mar 2026 11:00:01 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Melissa Wen <mwen@igalia.com>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, contact@emersion.fr,
 sebastian.wick@redhat.com, 
 harry.wentland@amd.com, daniels@collabora.com, Alex Hung <alex.hung@amd.com>, 
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/drm_atomic: duplicate colorop states if plane
 color pipeline in use
Message-ID: <20260319-nocturnal-mighty-chupacabra-87cbd0@houat>
References: <20260318163629.300627-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="jw7zvxbahd33l427"
Content-Disposition: inline
In-Reply-To: <20260318163629.300627-1-mwen@igalia.com>
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


--jw7zvxbahd33l427
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/drm_atomic: duplicate colorop states if plane
 color pipeline in use
MIME-Version: 1.0

Hi Melissa,

On Wed, Mar 18, 2026 at 01:27:11PM -0300, Melissa Wen wrote:
> For suspend/resume to work correctly, do for colorop state the same we
> do for plane/crtc/connector states: duplicate the state of colorops in a
> color pipeline if it's in use by a given plane when suspending and
> restore cached colorop states when resuming.
>=20
> Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Only slightly related to this patch itself, so this discussion must not
block merging this patch.

I've been looking at revamping the state allocation / reset recently and
came across the colorop. It's not clear to me if it's something that
should be expected to be reset across a suspend/resume cycle or if it's
something that should be maintained across that cycle.

What is your opinion on that?

Thanks!
Maxime

--jw7zvxbahd33l427
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCabvJIQAKCRAnX84Zoj2+
dmeqAYCr1jnNEtAxaQT7UVPq8o1ooBh1J4PUEKxGoQlLuOJ1wfOFac76PHR3rotz
Dd7CdI0Bf1pvLvEjbWJBEcQfilNnv+YPdQXVnb5rQ2pOOXDY5IuVVWDfjcbcZML8
TJXlbkRILQ==
=iwc+
-----END PGP SIGNATURE-----

--jw7zvxbahd33l427--
