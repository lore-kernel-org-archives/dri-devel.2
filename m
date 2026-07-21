Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4A7C44533
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2EF10E352;
	Tue, 21 Jul 2026 14:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D1Eq2Afq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92CD210E34E;
 Tue, 21 Jul 2026 14:06:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FE9B6001A;
 Tue, 21 Jul 2026 14:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6391F000E9;
 Tue, 21 Jul 2026 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784642802;
 bh=Idt5G772KwxjQM6Cd/5RAUT8Wlfvka+iIYZrY3DWysw=;
 h=Date:From:To:Cc:Subject;
 b=D1Eq2Afq1MgQOx80XBoKQWiQfGWEs1oObt39VxNpJud6DFNnh36vAyqeJQI2DUktl
 wG6KVlkAyvJRjsBFe8DHFsXpcmsviBfE86ddnOAB3B754MHrXJSbT4le8ti9ew0HYq
 8bW6P5mv49FC9e/ElzVK9/DCNGvtJKHAxRkGwCdU9IIHkDCXrzSoBXYdT1Ko/+LovF
 0imp05Lfo0KYnGjp/AvBBiblHeTg4w39zMsMp14QTjY+wQXtedpCHfQbU7gYhIgHZl
 viUMEerKDaxBSSb85LrsZLqmlGSLHK/0+l8ca3rK+Ho5M7iUHBPvDhl3Nq//rKsv1T
 3J0ncQy2ImgLw==
Date: Tue, 21 Jul 2026 15:06:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>, Maxime Ripard <mripard@kernel.org>,
 Albert Esteve <aesteve@redhat.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <al987knJq4h66FcJ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KVSqdCw1em5yhpkZ"
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


--KVSqdCw1em5yhpkZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build
(arm64 defconfig) failed like this:

/tmp/next/build/drivers/gpu/drm/imx/dcss/dcss-kms.c: In function 'dcss_kms_=
bridge_connector_init':
/tmp/next/build/drivers/gpu/drm/imx/dcss/dcss-kms.c:81:17: error: implicit =
declaration of function 'drm_panel_put'; did you mean 'drm_dev_put'? [-Wimp=
licit-function-declaration]
   81 |                 drm_panel_put(panel);
      |                 ^~~~~~~~~~~~~
      |                 drm_dev_put
make[8]: *** [/tmp/next/build/scripts/Makefile.build:289: drivers/gpu/drm/i=
mx/dcss/dcss-kms.o] Error 1
make[7]: *** [/tmp/next/build/scripts/Makefile.build:549: drivers/gpu/drm/i=
mx/dcss] Error 2
make[6]: *** [/tmp/next/build/scripts/Makefile.build:549: drivers/gpu/drm/i=
mx] Error 2
make[6]: *** Waiting for unfinished jobs....
/tmp/next/build/drivers/gpu/drm/mxsfb/mxsfb_drv.c: In function 'mxsfb_attac=
h_bridge':
/tmp/next/build/drivers/gpu/drm/mxsfb/mxsfb_drv.c:130:17: error: implicit d=
eclaration of function 'drm_panel_put'; did you mean 'drm_dev_put'? [-Wimpl=
icit-function-declaration]
  130 |                 drm_panel_put(panel);
      |                 ^~~~~~~~~~~~~
      |                 drm_dev_put

Caused by commit

   b71a623598d31 (drm/panel: of_drm_find_panel() return a counted reference)
  =20
I have used the version from next-20260720 instead.

--KVSqdCw1em5yhpkZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpffO0ACgkQJNaLcl1U
h9ATzgf5Adwr9uCkP59givHL6GPZ5+UsW8JMEQnGh8XV745k1dzIUTyUtzoTjH4s
W6JFzvEr9doz8Z2Roj6QB8bApC3ogiS2ADhtXRcamNL/3S+lIY9GS/aAVFfUlqzs
JKxE6ZE9QFNlrwywGcY95q2WyGb70DfLZ15HDyHDi3rZAiYNi38R/BZ7xmlYfuJT
6uvOvp7litUarT5b/cxKlMbnfyGioIOMdqaBQc9PshwafVOmOJxQErgKgLDMuRfh
2FzU6QDaNHNF4fdBDuvU1c+lASaSTiQanASPjR/lPACrFIgydh82UFCnMF1+lv+A
xtOcoGdmZgOkhs/D3h78zOM1H2JQUg==
=HczC
-----END PGP SIGNATURE-----

--KVSqdCw1em5yhpkZ--
