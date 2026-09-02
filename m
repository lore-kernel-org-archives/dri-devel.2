Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8501C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E91610E4C1;
	Wed,  2 Sep 2026 12:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J5gAWdxS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50EEF10E4C1;
 Wed,  2 Sep 2026 12:11:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4AD3E600D9;
 Wed,  2 Sep 2026 12:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D471F000E9;
 Wed,  2 Sep 2026 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788351085;
 bh=XwpTOnFpFlsR2IVVNgUhsYAsd1JKHnUT72fEns1VyDk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=J5gAWdxSbtz7dP1JzTLOnxnAJOhAgY2MQnAmvKT59vnDS3SEApgcm9S8d0qj7qoP3
 4lnWz3ClvHf7lYNCO/2Zwgwi4LSUrmXo9Soeu8mAUnck0kILcMmShlCdFtg9squIY+
 q6CmXwQZ9UixX552ode1kvcO6x572+2Tr1mlJ+DrlcLsLpBSl7LP2blMgp28ukS5yB
 0C7s1kuhwMtHweFVnFYVwr2khieCmSH5SijKuModD9gnHBB6utuMaDVDE8ZtYuQDPw
 wFM3FX2IY171fpBn8XL/Av4APOehNb2BaVqzbdpn15tWBOehvZX0kB/zP/c5GssCep
 4ULDVF9+wll6w==
Date: Wed, 2 Sep 2026 13:11:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <64bdb5bc-ced6-490c-b4c8-fd3dcabbbd4c@sirena.org.uk>
References: <apbbvQSfUbzYRFaw@sirena.org.uk>
 <3cd2c640-3ce8-4163-9f7b-3abba46ae072@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sh0NKln0pLxJxfm6"
Content-Disposition: inline
In-Reply-To: <3cd2c640-3ce8-4163-9f7b-3abba46ae072@gmail.com>
X-Cookie: Prevent forest fires.
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


--Sh0NKln0pLxJxfm6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 09:52:24AM +0300, Ivaylo Dimitrov wrote:
> On 1.09.26 =D0=B3. 17:05 =D1=87., Mark Brown wrote:

> > /tmp/next/build/sound/soc/ti/omap-hdmi.c:408:6: error: no member named =
'card' in 'struct hdmi_audio_data'
> >    408 |         ad->card =3D card;
> >        |         ~~  ^

> This seems to be due to an interaction between two patches:
> 1. 9af2c1d4f847 (ASoC: ti: omap-hdmi: remove unused *card) / 875e906efdc4
> (ASoC: ti: preparation for Card capsuling)

Those are in -rc1...

> 2. 699e5975e2a53 (drm/omap: Report HDMI hotplug events to the ASoC HDMI
> codec)

=2E..which the drm-misc tree has now merged so I don't expect it to build
independently of any other tree.  I'm a bit surprised this wasn't caught
when merging up -rc1.

--Sh0NKln0pLxJxfm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqYEmcACgkQJNaLcl1U
h9CEEQf9Hk/LuaEd+ZaphNyNmIa5ksIVwyIWx4i/IKB/nh2G137vfaU8FFpD/vhj
8WKJSFftQk6eVmdAsWmCM25R5loZcWfm8V5L13khKtvU1L4v47HyYKLj5PmGgUTn
DQ8uVo3aXmGo8KZNmhraFEvy+5bFzMfZHXLxHoDDSARdX+/TvDRkt6za2HJCqU/a
+QVCadknLQdCuP0tqXuR0xu1iS3K3vrKzGGNL84Gb5yKX3REFNUZpc92p7FY/tDs
SSrzi7yQ7Cpihkb3N7Opn/CHgslSso627hKcTcdxaDBWAahBaN7W7+3KnGLE88Ow
5Kz5rXtGyIsruw0tdirhWAr/SEOQew==
=xwIZ
-----END PGP SIGNATURE-----

--Sh0NKln0pLxJxfm6--
