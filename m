Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9506BC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 16:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE47C10E358;
	Thu, 24 Sep 2026 16:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kNCdcQU6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F5A610E18B;
 Thu, 24 Sep 2026 16:54:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 76E3C601EF;
 Thu, 24 Sep 2026 16:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6081F000FF;
 Thu, 24 Sep 2026 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790268872;
 bh=BkzAkiWdzegc3H0KCcLioXPh2WESOPx/9LTCwHSdQDI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kNCdcQU6ajBlxqBQ4LfRJawizexIf/eZEFukJwJ57sYk18nimzTBcWPVDNFLDHySK
 rCpOtZA+6PjhIT0E19ZwrY6scDJaa+kMEqqFeyfTdgpH8EUcEUxWofrpidInfRhorz
 EV6X5OWA1t8WELdvJb576pvporyY7+awdjs7lKrT6+Ll1DoQ31/5LDLw7+QWcbP3nj
 Do3oI4kuwVWIkgszw5O7APGw5hxlzcMtvWkXf5Tvxv/FI94tneDDkfx7FjvLobLgrB
 n1n3FLH+U0uyRftC8u+m/goilZncfB7C00KlmZ6CLUe0kDbxn5ZbDuYeweKevJcCBv
 Mw8EOwFeVQHaQ==
Date: Thu, 24 Sep 2026 17:54:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <4ddbd29e-3524-4f4c-b6d7-1e2e677641b5@sirena.org.uk>
References: <arPTRF4qS6o1Q3vD@sirena.co.uk>
 <CADnq5_NUH1MBU15Vs287by4P37YV+6F1Q3J1e4Q4KuOvPwK9Fw@mail.gmail.com>
 <arPhsTaiqXPgCqAU@sirena.co.uk>
 <CADnq5_OJ=kP+0=iXbpcjsWbTx8=sNfov0wLSW53qLcFU0fmVVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TfUEtMAqWQQDRMnd"
Content-Disposition: inline
In-Reply-To: <CADnq5_OJ=kP+0=iXbpcjsWbTx8=sNfov0wLSW53qLcFU0fmVVg@mail.gmail.com>
X-Cookie: Memory fault -- brain fried
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


--TfUEtMAqWQQDRMnd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 05:57:24PM -0400, Alex Deucher wrote:

> Your reports are valuable and we always take them seriously even if I
> don't reply as quickly as I should.  For the issues at hand they
> should all be fixed with the following patches:

> https://patchwork.freedesktop.org/patch/755725/?series=3D174828&rev=3D1
> https://patchwork.freedesktop.org/patch/755741/?series=3D174834&rev=3D1
> https://patchwork.freedesktop.org/patch/755769/?series=3D172614&rev=3D2

> I'll push a new -next branch with those fixes later today.

I'm still seeing at least:

/home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/dm=
l/dcn30/display_mode_vba_30.c: In function =E2=80=98UseMinimumDCFCLK=E2=80=
=99:
/home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/dm=
l/dcn30/display_mode_vba_30.c:6666:1: error: the frame size of 2064 bytes i=
s larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
 6666 | }
      | ^
/home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/dm=
l/dcn31/display_mode_vba_31.c: In function =E2=80=98UseMinimumDCFCLK=E2=80=
=99:
/home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/dm=
l/dcn31/display_mode_vba_31.c:7460:1: error: the frame size of 2128 bytes i=
s larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
 7460 | }
      | ^
/home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/dm=
l/dcn32/display_mode_vba_util_32.c: In function =E2=80=98dml32_UseMinimumDC=
FCLK=E2=80=99:
/home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/dm=
l/dcn32/display_mode_vba_util_32.c:3278:1: error: the frame size of 2176 by=
tes is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
 3278 | }
      | ^
/home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/dm=
l/dcn314/display_mode_vba_314.c: In function =E2=80=98UseMinimumDCFCLK=E2=
=80=99:
/home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/dm=
l/dcn314/display_mode_vba_314.c:7546:1: error: the frame size of 2128 bytes=
 is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
 7546 | }
      | ^
cc1: all warnings being treated as errors
make[7]: *** [/home/broonie/git/next/sfr/next/scripts/Makefile.build:290: d=
rivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.=
o] Error 1
make[7]: *** Waiting for unfinished jobs....
/home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/dm=
l2_0/display_mode_core.c: In function =E2=80=98dml_prefetch_check=E2=80=99:
/home/broonie/git/next/sfr/next/drivers/gpu/drm/amd/amdgpu/../display/dc/dm=
l2_0/display_mode_core.c:6821:1: error: the frame size of 2160 bytes is lar=
ger than 2056 bytes [-Werror=3Dframe-larger-than=3D]
 6821 | }
      | ^

after merging amdgpu today, note that this is in the -next merge and not
just the amdgpu tree in isolation.  I am currently holding drm and
drm-misc at next-20260921, there is a conflict with the old version of
them though that was just comments but they'll be in the history at the
point I'm building so possibly whatever git did with the merge is
causing issues.

Any fixes will also need to propagate into drm and drm-misc.

I'm also still carrying a build fix marking the display KUnit tests as
BROKEN due to the issues with the conflicting changes with drm-misc
which several people have noticed, for example there's this from Arnd
last week:

   https://lore.kernel.org/r/20260915201006.3526945-1-arnd@kernel.org

None of the mails I saw about that or the issues resulting from my
mismerge got any response either.

--TfUEtMAqWQQDRMnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1VcMACgkQJNaLcl1U
h9DVrwf/fFeeDT5pfDcxHGFhYdqb+fTkCDcSDPtwkCUrKEHGBTabJ2uY/V+h36yq
BgYE6dIWD14pzaSAhnum5ZSwk8Ht2+mf9uJFA9qx5Pa/TCLMZmkMijGwXMLR7vNe
oUOINfjXh2fVgdOZ0EfDoFOdOV9xtGI6Ar3sQV5pqvcFg7I5H4xUx8RAQJQdNBUC
kEB/dcwF2sLC7sHhaTdbkbnuRBgC9fkQbvurG8VJE35xKbd8x3xs3PTUbm4Egx6b
q+V4Ly9Qm8NZbNu1EvLy8XvgXfR+lpDJ5YjrQpBWPBkTVNJ/9O7dW/rItnEPHdEF
zbarZkyx0UmPvj5Aw1uvvvcWaAatPA==
=O+Zt
-----END PGP SIGNATURE-----

--TfUEtMAqWQQDRMnd--
