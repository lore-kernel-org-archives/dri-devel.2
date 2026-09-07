Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97D0C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98A4410E010;
	Mon,  7 Sep 2026 14:01:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F9k65YpY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D91710E00C;
 Mon,  7 Sep 2026 14:01:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F5DF41FF1;
 Mon,  7 Sep 2026 14:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D711F00A3D;
 Mon,  7 Sep 2026 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788789665;
 bh=K9eg6wtFkWTMznV5PVTFHHwE7AtItq6fmRemD/gQ39E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=F9k65YpYSn95YLorXivh1lNvcQEXd6B15V0i+J/S5xiVvoPWb32IX+6T4nC/0e/As
 ABXb2hniSAc/wOo0/RpPVDNfsy5LrEPCRoL3XlrQuB2kdM0qY1sBBrgl2KMWwdKlVA
 nUV7KwKDJmbEmBUF62YhpcTBLrqlQCw1q9E5sPooaXnW6+nB14sL4XmSXPJrM+irBP
 pf2H+7ex3bez9MYOPqdzoYRFILeErmuEuk4/VeVNaHUFkIQGPboadv2hC5M3nfQonk
 jvxDlBzYaOufRSkdh6Iz1qilQS5Giyck/durXFl3lZTA8A0uanLYEHgHp6xXkpgnfH
 jmgFfu8XIEM6A==
Date: Mon, 7 Sep 2026 15:01:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <3076b44f-b499-42cc-92cf-f4a7a470fb2f@sirena.org.uk>
References: <apbbvQSfUbzYRFaw@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8G1W8X2ghs61Sw/4"
Content-Disposition: inline
In-Reply-To: <apbbvQSfUbzYRFaw@sirena.org.uk>
X-Cookie: Hackers of the world, unite!
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


--8G1W8X2ghs61Sw/4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 03:05:49PM +0100, Mark Brown wrote:
> Hi all,
>=20
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> /tmp/next/build/sound/soc/ti/omap-hdmi.c:408:6: error: no member named 'c=
ard' in 'struct hdmi_audio_data'
>   408 |         ad->card =3D card;
>       |         ~~  ^

This issue is still present today.

--8G1W8X2ghs61Sw/4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqew5wACgkQJNaLcl1U
h9AXkQf3TTyOJdRIdJbxEiYBPd0mr1H9u2Yj7TS5LTe4dxXi0lXZ2Ni4NhwRFNTw
76DKUk+wQshac7dUYdOrUpM22sUdR1PlOfMBCmJ8REVvspFryLhTiR1vRZo0fS1Q
8mbC+vECwUR2R+Ht8QRRz5mzvLshbfMmJN+mUA1l3YYRCPIOXLFcVYhRFDpUYZet
LSLzVlviuDDLgukDYHpuWB7iyLpWstDG3IPHV/cK9ZfrN2pFqxnO53/7OYTHu7LE
GfAiRiR2qT7JT6DeBimiu3LDzeL2r0N1OK70fwzLbUaRG+InVw6Zb0O1ruV28UfT
32D8gmzvVF79+74tWxIbqvWx1Ao0
=dKFx
-----END PGP SIGNATURE-----

--8G1W8X2ghs61Sw/4--
