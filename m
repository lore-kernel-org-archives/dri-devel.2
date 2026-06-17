Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35C8CD98F2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61DD110E023;
	Wed, 17 Jun 2026 15:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RTBv0m4T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D442510E023
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:36:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8995340814;
 Wed, 17 Jun 2026 15:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C7F1F000E9;
 Wed, 17 Jun 2026 15:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781710603;
 bh=Y8g66KJwBPZsW4kGLX7IfuRshXZ2752vVmoP7Phu2tQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RTBv0m4T8qa5Yd4T0uGzFrpIFMTIF+TSExgcX4UX9l7jnHKehY1bNgsNCbHJ5s//I
 niujBDjlpkhNXvjRIxuLpiEFNwXGNDWK/VQZLUtpf6b+9UDHp4Q8dsmaEGZZNG26bd
 6VHER+fgvM4Cvu68scIvQdIZPwYMeSfGxie4eHfZbgz0GGVOaZDGHNvn5NSwLdgMmy
 S+UL/REbSHx1okK8wISiWqza0qBcZ4oSLiuRBXjF3mzViEL+zDZnbnv4lUrRr5uRJn
 VqxDByyxXB3LqJlb4gV/2cupqNeTz3aOqshTrByM47H6aTMEOuYWs9q9AyX8GDBBBw
 7JmIMa0LB3eSQ==
Date: Wed, 17 Jun 2026 16:36:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Amit Barzilai <amit.barzilai22@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 airlied@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v2] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
Message-ID: <20260617-reorder-impale-3d79d9ae6c8c@spud>
References: <20260615175620.88828-1-amit.barzilai22@gmail.com>
 <20260616-nautical-obstinate-a92fd80ef483@spud>
 <87a4suzc0c.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="krgfDnuULe9BxIWJ"
Content-Disposition: inline
In-Reply-To: <87a4suzc0c.fsf@ocarina.mail-host-address-is-not-set>
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


--krgfDnuULe9BxIWJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 06:27:31PM +0200, Javier Martinez Canillas wrote:
> Conor Dooley <conor@kernel.org> writes:
>=20
> Hello Conor,
>=20
> > On Mon, Jun 15, 2026 at 08:56:20PM +0300, Amit Barzilai wrote:
> >> Add a device tree binding for the Solomon SSD1351, a 128x128 65k-color
> >> RGB OLED display controller driven over a 4-wire SPI bus. The binding
> >> builds on the shared solomon,ssd-common.yaml properties already used by
> >> the other Solomon display controllers.
> >>=20
> >> Assisted-by: Claude:claude-opus-4-8
> >> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
> >> ---
> >> Changes since v1:
> >> - Drop solomon,width / solomon,height: both are deducible from the
> >>   compatible and are already declared (as optional) by the referenced
> >>   solomon,ssd-common.yaml, so a local override is unnecessary.
> >> - Drop the rotation property: it has no consumer (rotation is being re=
moved from the driver).
> >> - Use dt-bindings/gpio/gpio.h flag defines in the example
> >>   (reset-gpios active-low, dc-gpios active-high).
> >
> > The user for this appears to be in staging. As far as I understand, the
> > policy is that we only add bindings for staging things when they move
> > out of staging.
> > Sure, this is straightforward but why should an exception be made here?
> > Are you working on moving this out of staging?
> >
>=20
>=20
> This DT binding was part of a series to add support for "solomon,ssd1351"
> to drivers/gpu/drm/solomon/ DRM driver. Amit only sent a v2 of the binding
> schema because he had some questions about the driver:
>=20
> https://lore.kernel.org/dri-devel/87cxxqzwxn.fsf@ocarina.mail-host-addres=
s-is-not-set/
>=20
> But yes, I agree that it would had been better for him to post this as a
> part of v2 (and I still expect him to do it), otherwise it is confusing.
>=20
> Specially since as you pointed out, there is an existing fbdev driver for
> the same device in staging.

Right, I'll expect this to reappear in a larger patchset then that
deals with the fbdev driver and adds the drm driver.

--krgfDnuULe9BxIWJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajK/BgAKCRB4tDGHoIJi
0r1zAP9f+sSGWQy6nGX3+0rvT7BTQZ5AedPyHULNyGMT5zpB5gEA8AJ7JTFTSP55
wNhtssW6Dw5KE7Mf4Ljmv4GYDS1e4gs=
=t6xE
-----END PGP SIGNATURE-----

--krgfDnuULe9BxIWJ--
