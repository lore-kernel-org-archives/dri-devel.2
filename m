Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44080C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D12897F0;
	Wed,  2 Sep 2026 08:21:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YKcAME0w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF62897F0
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 08:21:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 483CC600D0;
 Wed,  2 Sep 2026 08:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686821F000E9;
 Wed,  2 Sep 2026 08:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788337305;
 bh=ggCMOymjzta62KyOYmqN5sV9fnNSej/APcCJwAgLjdI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YKcAME0w0PsDZCSNyM82DjLCbJI/OTGXekMYRjvnh0HKzALlnf5nUht4kHbiGqOIh
 ERsDHDtVRCqDih85M+RgN2XW2ZnnLuH0EFxrmQnlOJR9fNhyxy2SIZ2P9LRwqL96N0
 7vK/UjhXhV4HW0pV0IMqJYy7tqUlSjtVet5ey1qioeJEJRRkxL0D/38nB/VUcBrq7X
 Ny6U4XigIt0GRqmxDmcLLcvGx9yVczNyiREQYKZSn1hfZd+mHQCrYxD7vqeAU1OY/h
 U+TL/CVvUlnFGd+5quq+CzinTDLS6tHrNwXkKspukdUhXiyRk2WG5MZHGhU56Tf5Mi
 /FyBF9hJWvWFg==
Date: Wed, 2 Sep 2026 10:21:41 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 llvm@lists.linux.dev
Subject: Re: [PATCH] drm/ci: Add CI pipeline for drm-misc branches
Message-ID: <apfchj1N41WQGlnU@houat>
References: <20260902-drm-drm-misc-ci-v1-1-49d05e228eab@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ti3nay26l7y5i6tt"
Content-Disposition: inline
In-Reply-To: <20260902-drm-drm-misc-ci-v1-1-49d05e228eab@kernel.org>
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


--ti3nay26l7y5i6tt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/ci: Add CI pipeline for drm-misc branches
MIME-Version: 1.0

On Wed, Sep 02, 2026 at 10:17:09AM +0200, Maxime Ripard wrote:
> The DRM CI infrastructure [1] builds upon Mesa's CI to run IGT tests
> on hardware. Its focus is on functional testing on a selected number
> of targets.
>=20
> The concern for drm-misc is different: it merges a large number of
> patches across many platforms, and build or unit test breakages happen
> on a regular basis. Adding build and unit testing for drm-misc has
> been on the back of our minds, and a first attempt was made last year.
> The feedback was to rely more on the existing infrastructure.
>=20
> Introduce a CI entry point for merge requests targeting drm-misc-next,
> drm-misc-fixes, and drm-misc-next-fixes. It reuses kunit.yml and the
> freedesktop ci-templates, while defining build templates inline to
> avoid pulling in the Mesa pipeline.
>=20
> A single Debian container with LLVM handles cross-compilation to all
> three architectures. The pipeline compiles the kernel using defconfigs
> from the drm/tip rerere-cache branch and runs the DRM KUnit tests.
>=20
> Link: https://lore.kernel.org/all/20250319-greedy-sturgeon-from-avalon-ac=
758f@houat/
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

A test run can be found here:
https://gitlab.freedesktop.org/mripard/kernel/-/pipelines/1738579

Maxime

--ti3nay26l7y5i6tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCapfclAAKCRAnX84Zoj2+
djAuAXkBJHNOgysY1OgeKxcwUqjXONoQ4pixDRE0gn0v/Sdi5bX83V5e8NQwHTLq
8IP7QkgBfA0EDNDsRtzl7kB2BZ/ZyGkoMZrudoBydqjGbgGOrCb5q2sVXl89tVXz
tdN2sAaRqg==
=njPd
-----END PGP SIGNATURE-----

--ti3nay26l7y5i6tt--
