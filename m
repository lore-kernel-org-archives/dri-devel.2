Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755FE1088E6F
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE01A10EA93;
	Fri, 20 Mar 2026 09:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="icQhL9S/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B8210EAB9
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 09:25:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 984B560127;
 Fri, 20 Mar 2026 09:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0EEC4CEF7;
 Fri, 20 Mar 2026 09:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773998714;
 bh=hytdCJvyRmCwOZPRrZqiCYUso9HSoG5TaaQC5t9D8f8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=icQhL9S/Q5ILqqXlrUeozeOHXjb/GuPv/wHRchDoxgIv25tlaovbaH2PdqeloTdb9
 3i4JCMmJe9Ui0z/BtvEMISDKEQUmE5fa5bjrZ4E1a2zx8jYbChwzmDbjE8HBJjz5i5
 THy7f206/poUIYlud6rfmz+zpiPgMMeKqcZyGd852o49RFhzCe6vS0+cltyGY5iOBj
 zar98h6W6ZUcE6R1Q85cOiOZ+GqolTPmKAPiZYXu3yIDI1lIxv8T3TRTYsk5UfIV4c
 1b09b/KZQfza6Tt4Y7D2ezW7qMr+juQ7pmYHv9Qz1nksN8MEuCrHwPTc6a/LPzIkTU
 YmMtFdqil6vYA==
Date: Fri, 20 Mar 2026 10:25:11 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Marek Vasut <marex@nabladev.com>, 
 Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
 Stefan Agner <stefan@agner.ch>, Liu Ying <victor.liu@nxp.com>, 
 Simona Vetter <simona@ffwll.ch>, imx@lists.linux.dev,
 Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: i.MX8MP: Fix HDMI LCDIF FIFO underruns
Message-ID: <20260320-amiable-hairy-bullfinch-28bfda@houat>
References: <m3ms04caaj.fsf@t19.piap.pl>
 <32317022-3c44-4ead-9e2d-04caa12b28cb@nabladev.com>
 <m36pvjbo4xy2rtdymshjpmwu7icl3wlyiwcmmjaozo7jpe5lqk@zt7byx7iwmym>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="kqtw7ezuuh3ww2w4"
Content-Disposition: inline
In-Reply-To: <m36pvjbo4xy2rtdymshjpmwu7icl3wlyiwcmmjaozo7jpe5lqk@zt7byx7iwmym>
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


--kqtw7ezuuh3ww2w4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: i.MX8MP: Fix HDMI LCDIF FIFO underruns
MIME-Version: 1.0

On Fri, Mar 20, 2026 at 09:04:17AM +0100, Marco Felsch wrote:
> On 26-03-20, Marek Vasut wrote:
> > On 3/19/26 12:45 PM, Krzysztof Ha=C5=82asa wrote:
> > > Running (and terminating) Weston on i.MX8MP sometimes produced black
> > > or grey screens. The LCDIF3 INT_STATUS_D0 register showed a FIFO unde=
rrun:
> > >=20
> > > 32FC6024: 1000002
> > >=20
> > > The PANIC0_THRES register was set to:
> > >=20
> > > 32FC6238:  AA0154
> > >=20
> > > which apparently meant low =3D 2736 bytes (0xAA * 16 + 16), high =3D =
5456 bytes
> > > (0x154 * 16 + 16).
> > >=20
> > > With this patch (based on NXP's driver) the watermarks are only 16 by=
tes
> > > higher (register values increased by 1) and the underruns are gone.
> > >=20
> > > Tested on Solidrun Hummingboard Mate with a 1080p60 HDMI display.
> > >=20
> > > Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
> > >=20
> > > --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> > > +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> > > @@ -353,8 +353,8 @@ static void lcdif_enable_controller(struct lcdif_=
drm_private *lcdif)
> > >   	u32 reg;
> > >   	/* Set FIFO Panic watermarks, low 1/3, high 2/3 . */
> > > -	writel(FIELD_PREP(PANIC0_THRES_LOW_MASK, 1 * PANIC0_THRES_MAX / 3) |
> > > -	       FIELD_PREP(PANIC0_THRES_HIGH_MASK, 2 * PANIC0_THRES_MAX / 3),
> > > +	writel(FIELD_PREP(PANIC0_THRES_LOW_MASK, DIV_ROUND_UP(1 * PANIC0_TH=
RES_MAX, 3)) |
> > > +	       FIELD_PREP(PANIC0_THRES_HIGH_MASK, DIV_ROUND_UP(2 * PANIC0_T=
HRES_MAX, 3)),
> >=20
> > I am starting to wonder, whether this should be configurable in DT, bec=
ause
> > it seems there might be users that need to tweak the watermarks one way=
 or
> > the other for different video outputs ?
>=20
> +1 to provide a override mechanism via DT.

If this is related to the output resolution, the DT is the last place
you should deal with this.

Maxime

--kqtw7ezuuh3ww2w4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCab0SdgAKCRAnX84Zoj2+
dmj8AX0fLuO62vmJI+ySHByc+XZ8s3q4zviMe03MY5pK5cTsFHhJcFrOeMWaRAGv
9SSJUCgBfRDumumJyxKSS5n1QS/g5KofFiU8leZjI7jjZE73tL3qBmVQuuVtlQvX
A3w8KjXclw==
=0nyw
-----END PGP SIGNATURE-----

--kqtw7ezuuh3ww2w4--
