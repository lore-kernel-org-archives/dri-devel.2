Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D84C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 437B010E852;
	Mon,  7 Sep 2026 14:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ac6UY0i6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26FD10E850;
 Mon,  7 Sep 2026 14:09:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7DD2B43A1E;
 Mon,  7 Sep 2026 14:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD401F00A3A;
 Mon,  7 Sep 2026 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788790140;
 bh=3gEnQO7igmymbliYzPyF9A/iYI6gR6UJbwKNLu6CrkE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ac6UY0i6+jJamMl2tc6yXvCU7lvgRrHNcGpzh/oiVs9S/6nol3y2Sx9R6+jEI+E1W
 mBiLcJxHfXyOu4sFRV/lrNCsWmzA4MvtiYu+1/qGm+J09IY0fnBHGwOcWpShNeokaC
 jvX9/qoNvZB7UZB+VowzidPofvt2tA6b/QbHJxx63RnLigjYNdeoDxYNsT07wo+TNa
 WHum9tmfA8FBn01RgRooZEOIvMIEUUtW9qvsEhiOKUkOQJn2ct4G+iUsAKpP2BfuIV
 mqMkNJjSqJFIaDFNFMNwLmjRBQErX+9KhrJFievGzjSU0hWmfttNjSJiK7Av8/tFxj
 ha4qxnb34iZ0Q==
Date: Mon, 7 Sep 2026 15:08:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <c25601c4-1b82-4565-ac85-53496c2ef794@sirena.org.uk>
References: <apbbvQSfUbzYRFaw@sirena.org.uk>
 <3076b44f-b499-42cc-92cf-f4a7a470fb2f@sirena.org.uk>
 <72674692-9c3e-4f7b-a3d0-00df85ef938f@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M0z22QpE/U4IUUmP"
Content-Disposition: inline
In-Reply-To: <72674692-9c3e-4f7b-a3d0-00df85ef938f@ideasonboard.com>
X-Cookie: Who's on first?
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


--M0z22QpE/U4IUUmP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 07, 2026 at 05:03:22PM +0300, Tomi Valkeinen wrote:
> On 07/09/2026 17:01, Mark Brown wrote:

> > This issue is still present today.

> I have sent "[PATCH] ASoC: ti: omap-hdmi: Fix build error from a merge
> commit" (20260903-omap-hdmi-fix-v1-1-b0447a1d35d5@ideasonboard.com). Waiting
> for a R-b so I can push it via drm-misc.

I saw that, it is probably worth looking into what's going on with the
process here if what should be a relatively simple build failure fix is
taking this long to get integrated.

--M0z22QpE/U4IUUmP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqexXcACgkQJNaLcl1U
h9BLrQf/QKRVnEffVm0DuQEUIBb7BIGie6nlwa/qG4KJ22h8/d/AAn7tdRxHmcrV
KM4ttzeTKMFdZbPQZHFWN2BB7MDtoZ8aNEJY3NxjRjDAOonvWAhxtv9GU87wy282
clK2Bu+90TTt+yADfZippZb6Bn2iqa25fHeBn08FV4bv5MlLjNPIXdyHE7NMbcum
intkYrlzNnDTOtE1XiH/7Ubdo4waOsW/+ZwhO1b5z65aDoZMWiOnCq24pTCth0+u
+nDmosU4ZLR2WcbTmVCdFQk0u8sLV1TfIQTTBOdX7xD7imLLLgzEGWMDpiSKlqXN
SS1hz0UgRnY5X1BTmeH2z68LcsRawg==
=i0fl
-----END PGP SIGNATURE-----

--M0z22QpE/U4IUUmP--
