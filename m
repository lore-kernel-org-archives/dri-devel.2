Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1573CC5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F7F910EEA0;
	Wed, 12 Aug 2026 07:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aKkZKzQ4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED6710EEA0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:42:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B868143BF0;
 Wed, 12 Aug 2026 07:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F01B1F00A3A;
 Wed, 12 Aug 2026 07:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786520557;
 bh=UB1jF7L3iPk9Rg0+1qtTwgCtX6bgx0/fZCeUDQ/DIwA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aKkZKzQ4Z2TKBfnpaCMI4tPl2gHvTd3QyNnrw/r1RkNMvVdXANvYhqVp4ZdKVDXwj
 qyyS6H5CdNZZjq+0ZuWWxrGSr8azN6lhiZvXdbNjvB4k+wO70NmRA/WAoo3mG4tE3T
 QWzixG6juj7qx2goYfPhQV+kItylHrhuWrpURJ+ob6fR/XQIWUuW+l2qEOz1w7ouRr
 DurzvNo2KByMTTz+wzI5K008b1B+iuTYz/uktjrYpPjJ2PfvJVLv2HyFu9zYCWR+P9
 fu7Hl5cs2A9ZROiXW/vRVVMPDn5DYue9wnkGGxAQLYGdMzgM4WqTy0EkX+y/UYjK66
 EPGxZhV8PFYrw==
Date: Wed, 12 Aug 2026 09:42:35 +0200
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Helge Deller <deller@gmx.de>, 
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
Message-ID: <20260812-neon-asp-of-completion-e9349e@houat>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros>
 <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat>
 <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ibzlmn7sqd2mt3nn"
Content-Disposition: inline
In-Reply-To: <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
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


--ibzlmn7sqd2mt3nn
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
MIME-Version: 1.0

On Wed, Aug 12, 2026 at 02:31:52AM +0200, M=E0xim Pedraza Padilla wrote:
> El lun, 10 ago 2026 a las 11:02, Maxime Ripard (<mripard@kernel.org>) esc=
ribi=F3:
> > If the sole reason for this series is to keep having something on the
> > display while the kernel boots until DRM catches up, then you probably
> > want to check [drm state readout]
>=20
> Thanks, I had missed it. I read it and then measured, having earlier
> claimed in this thread that our hardware kept no state worth reading. That
> was wrong.
>=20
> Dumping the LCDC registers at the top of tilcdc's probe, before the driver
> touches anything:
>=20
>   RASTER_CTRL=3D00280081  FB=3D9df13cc0..9dfcf4bc
>=20
> LCD_EN is set and the scanout address is exactly the framebuffer U-Boot
> reported, still holding the image. So readout would have something real to
> adopt here. tilcdc is not one of the drivers you implement, but that is
> work rather than a disagreement.
>=20
> One observation that may be worth your time. Pointing a simple-framebuffer
> node at that same memory, same device tree, only the driver differing:
>=20
>   simplefb   the image is still there afterwards
>   simpledrm  the buffer reads back as all zeros
>=20
> So where the CRTC is still scanning the bootloader's buffer, simpledrm
> wipes the image it was meant to carry over. I have not chased down the ca=
ll
> that clears it.
>=20
> What readout cannot cover is having no firmware splash to read. U-Boot's
> Falcon mode boots the kernel from SPL and skips U-Boot proper, where
> display init lives, so there is no image and no programmed CRTC to inherit
> -- and Falcon mode exists to shorten boot time, which is the same reason
> one cares about the logo appearing early.

In such a case, you can (and really should) use KMS, and you should use
an initramfs and setup the splash screen there. There's no need for the
kernel to do that work.

It's still significantly different from your earlier claim, since there
would be no gap between uboot and DRM, and no blanking either.

Maxime

--ibzlmn7sqd2mt3nn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCanwj5wAKCRAnX84Zoj2+
djk4AXoDaUpvlsLACdFgaEpmyXSq8tMZcRam1NtpdStxqjIXf0td0aHqsBW9yLHM
qHBynosBfjTL6/dGkQiTNe8d8My3Mh9Mv/26EX8/wJznUEx3OXSHeiBB5CfJ36OR
J3sTCZOWpQ==
=d3a1
-----END PGP SIGNATURE-----

--ibzlmn7sqd2mt3nn--
