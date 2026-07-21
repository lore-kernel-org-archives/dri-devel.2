Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CADFC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C4710E983;
	Tue, 21 Jul 2026 11:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ggo6kr75";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC24E10E75F;
 Tue, 21 Jul 2026 11:46:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EA0596004E;
 Tue, 21 Jul 2026 11:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BF11F00A3A;
 Tue, 21 Jul 2026 11:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784634391;
 bh=0wvV4a53mMDMORRPeE+UpXOHgo5YRjaLD4LHFIHgeug=;
 h=Date:From:To:Cc:Subject;
 b=ggo6kr75D3P8gHu6CvnWhCRBTsDIL/uw3Fnih1fjdsJ/qF2GMR2cjsdkpEIzUGZ6u
 tSiQ8v1cV3+TXLH1mTNgfUfhAz87Ir+sJeVYVCTjTcLSIdloZO4/YXqp0wdlPZvjNx
 K3qokSVGLBHEDMmLSOwZa3YjzPEJU7yxYTBb2OH3ngyk7j4wy98BrB6hvXd5Kkyvxt
 85fPD++JgIQy5I7GAfMSinfeXeYEXs+H/Ht8fS/qh9t0AFuCNpu7+9GEzPBcC+jC0M
 ymc88WA/7rex0y1WILmVDRJnql2Q5I9/V/gifkEfa73CY3MndPFoHfrn3LKY5cLRGR
 Kui571mFeTejA==
Date: Tue, 21 Jul 2026 12:46:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Unexpected files in the drm-misc tree
Message-ID: <al9cE1PAYd9jyCfZ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F/qVIg8LOFPH4swv"
Content-Disposition: inline
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


--F/qVIg8LOFPH4swv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit

  ac3baea883dab ("drm/panel: find_panel_by_fwnode() return a counted reference")

added this unexpected file:

 drivers/gpu/drm/drm_panel.c.orig


--F/qVIg8LOFPH4swv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpfXBMACgkQJNaLcl1U
h9BGOAf/Qg2e/6NfuC5Q5NIeXYX/dCx3IWB6Ry788nRbqm/WdE2dczfxLwKJSbKg
Ny/f7xpqPDiv6CtNAk0I2UMYQwrFXIwdE+erUVrs29KtQIiNg00rHf7SA6ob3R0t
V2DqtJgKuWi8l7Rn9oWO/PWSLbL+XrktlOMZmTGdlbqaifJENb9CtWKxx8MA2Sn/
k7C1cEAX4at9QjsMeVyh6YPM0uDIJ4lYrNdwwmUl5darRETbX1v28pYEgJuTib6M
ELdvvKnfXQhKIXTm34vuh1nS05mCt/C7k5rEczdFFJ8xZk+UrsQsbRBzTFojUN86
IOhfWOfCxzCJkL6PJIoRSXvQRzNpPg==
=t9Rb
-----END PGP SIGNATURE-----

--F/qVIg8LOFPH4swv--
