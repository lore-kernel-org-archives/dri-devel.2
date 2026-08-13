Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C3FC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1CA10F1DE;
	Thu, 13 Aug 2026 08:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SaNGcVZH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6EA10F1DC
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:03:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F2F2C42A8E;
 Thu, 13 Aug 2026 08:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE1B1F01558;
 Thu, 13 Aug 2026 08:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786608179;
 bh=2bEeA3QcIy4db/6MIU9sw7QfU9y/J4Eq9FKa4t6/Eyg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SaNGcVZH+3Ya7NfZXWqej4DYOUcjJ3CJrW2XuQmj0L57Rq/dN2aVPhyFI0RGl9/8W
 HrfD/L23y+6E5jJxyzKAJ8UKCEAjeoXxUEbS7g3gG+8agprclXUqQxWYR5gDUUrjxl
 l+AcR04q6tfRLGAOjTTunEn/CRStaHxqOgX4SAGMTX+mO1fxXUaGgpvK8tz8uk5xha
 eL9ZmzuJeWV25Gdt2lDvPSG+U1GfdR+8hKp88OliPomQwyUvlTH+RudpcgAogCD6Lm
 XDSITicKR7ra0BFvUxoOQ1OZT0KDuC0StujWoiEgLvvKkqoCzo3g88btSHvw12nADT
 V1BDS57lsgajQ==
Date: Thu, 13 Aug 2026 10:02:57 +0200
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
Message-ID: <20260813-ethereal-sawfish-of-downpour-c23da9@houat>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros>
 <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat>
 <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat>
 <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="a4kqwszl6ozjan6r"
Content-Disposition: inline
In-Reply-To: <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
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


--a4kqwszl6ozjan6r
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
MIME-Version: 1.0

On Thu, Aug 13, 2026 at 01:50:47AM +0200, M=E0xim Pedraza Padilla wrote:
> El mi=E9, 12 ago 2026 a las 9:42, Maxime Ripard (<mripard@kernel.org>) es=
cribi=F3:
> > In such a case, you can (and really should) use KMS, and you should use
> > an initramfs and setup the splash screen there.
>=20
> Agreed that readout is the right answer where it applies, and I am not
> looking to duplicate it. Three cases where it does not:
>=20
>   - Hardware whose only in-tree display driver is fbdev. There is no KMS
>     state to read at all, and there are still around a hundred of those
>     drivers.

Which are entirely deprecated, and kept mostly for historical reason.
It's kind of irrelevant to this discussion.

>   - DRM drivers without readout implemented, which today is all of them
>     but tidss.

The obvious answer to that being "just implement readout then". We won't
merge a core feature to accomodate a driver not implementing an existing
feature.

>   - Falcon mode, where U-Boot proper never runs, so there is no image and
>     no programmed CRTC to inherit.

In this case, the first modeset is fine, and whoever does it doesn't
matter, so it might as well be userspace.

> On the initramfs: it moves the splash earlier, it does not close the gap.

Which gap are you talking about?

> Measured on our 4.19 product kernel:
>=20
>   1.09 s  tilcdc registers fb0, the logo can be drawn
>   2.68 s  ubi0 starts attaching        <- 1.59 s of built-in driver probes
>   3.39 s  Run /sbin/init               <- 0.70 s of UBI attach + UBIFS mo=
unt
>=20
> An initramfs removes the 0.70 s of storage. It cannot remove the 1.59 s,
> because PID 1 does not exist until the initcalls have run.

I mean, sure it can. Move built-in drivers to modules, and load them in
the initramfs. It will reduce the kernel image size (so load and
decompression time) and the kernel boot time itself.

I personally did a subsecond boot to userspace with Falcon Boot, UBI and
a similar platform (and no initramfs). 3.4s to run init seems subobtimal
to me.

> So the gap goes from 2.3 s to roughly 1.6 s, before the splash binary
> has loaded and drawn anything. That figure is an estimate; the
> breakdown it comes from is not.
>=20
> It is also worth saying what this series is and is not. The kernel has
> drawn a boot logo for decades; this does not add that. It changes where t=
he
> image comes from, so that one kernel binary can serve products that differ
> only in branding. If the position is that the kernel should not draw a lo=
go
> at all, that is an argument about CONFIG_LOGO rather than about these
> patches -- and drm_panic already calls fb_find_logo(), so the logo is not
> purely an fbdev concern either.

I understand where you're coming from. On the flip-side, why should we
add an interface we'll have to maintain forever, while making a
compromise because the fact that it should be in the DT to begin with is
arguable, on a deprecated subsystem, for something where we have
alternatives.

Maxime

--a4kqwszl6ozjan6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCan16LQAKCRAnX84Zoj2+
dsIUAYCz8NYpNrR0fsfu0V282mWPfF/ktotI46Lnf6bQsRzHz4DDDLe00UF3WRjU
SPEMxgkBgKlNP2ks2w3VUbh6Y8/fw4CerSji2OxDCYcAoQA+5Tgb+Qq57XwD47Xw
Lm9gnS4GVg==
=xQLQ
-----END PGP SIGNATURE-----

--a4kqwszl6ozjan6r--
