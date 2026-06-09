Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FE3CD8C92
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDEBB10E614;
	Tue,  9 Jun 2026 12:51:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FS9DuUCz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CB810E5F7
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 12:51:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BFBC7601D6;
 Tue,  9 Jun 2026 12:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CE81F00893;
 Tue,  9 Jun 2026 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781009475;
 bh=wT5O0doH4rB5Ix+kUGXb/ni44OSOLXiRGMnc2YBHp3A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FS9DuUCzxXvSnJ+p7cNdO+sQVyYBSnIWpzUwCsXhPTDXsyGfPnjpUS2GZT5XPWt8L
 CjXJu6WIp5JSahC8Ua/NdLGIRy9PkLvNbccO3Cx0l+R53x/V7WNUR5VH376JzGGmYd
 ANQ8decJAWmciYMSZLKx7RkX8TYbMxkMqOBpa+B0atchHOnyOlMz1DOMKGPJLMSAJ/
 CCdc7UWMyw7EFXKxY54JCcIpyGXNVQWbayJDWh54iUwMx9WDSOBot616g5812Rjxaw
 WkKcFUCCZjBHyZB5jzDOVR79v2FeNlX9rYIlo+vschN6HGYpFZRJxgKgebqBNoWTjT
 qLBRCdEkX/4Zg==
Date: Tue, 9 Jun 2026 14:51:12 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH 0/2] Make HDMI state helpers handle odd max bpc requests
Message-ID: <20260609-orthodox-cocky-bull-5ddef8@houat>
References: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="cf65uqpfrj3zpnoy"
Content-Disposition: inline
In-Reply-To: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
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


--cf65uqpfrj3zpnoy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] Make HDMI state helpers handle odd max bpc requests
MIME-Version: 1.0

Hi,

On Mon, Jun 08, 2026 at 01:19:06PM +0200, Nicolas Frattaroli wrote:
> With the "max bpc" KMS connector property, userspace can arbitrarily
> restrict the upper end of the bits-per-component range. This is fine and
> good, except the HDMI state helpers never considered that max_bpc could
> be influenced by a userspace setting, so assumed it'll always be an even
> value from the HDMI standards.
>=20
> This, unfortunately, is not the world we live in anymore. Patch 1
> corrects sink_supports_format_bpc to return false on BPCs outside of
> what HDMI allows. Patch 2 then corrects handling of odd-numbered max
> bpcs by rounding the loop start value down to an even number instead. It
> also adds a KUnit test to make sure nobody breaks this again in the
> future.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Do you have a bit more details on the world you live in? :)

In particular, why would erroring out on setting an odd value in
atomic_set_property not work?

Maxime

--cf65uqpfrj3zpnoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaigMQAAKCRAnX84Zoj2+
dj6hAYCPsKonV4oHzMWK0XAfZp0BVteVdQMjQBPVqifjsAS4X2yonDvPCNZKWvEs
bF/VidQBfAgt44hjOuGzswDDxh2j1qzi8bBmXf5KViQ92jKqJJDDlnhnMpj5xbjF
PXusHhmSHw==
=MVTK
-----END PGP SIGNATURE-----

--cf65uqpfrj3zpnoy--
