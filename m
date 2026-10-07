Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A87CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C057A10E422;
	Wed,  7 Oct 2026 09:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ny1lOyzE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805BF10E422
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 09:55:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 70F3C60210;
 Wed,  7 Oct 2026 09:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E6E1F0089E;
 Wed,  7 Oct 2026 09:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791366902;
 bh=8JDCl8OrL+mKV42Pt6NN+0hbgXtTIi+Z0eAqdjwBzyw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ny1lOyzE2RwWpchdltjmSQrwfW0ie34h908cxxMrEkbATAaqzTa3i7wVAYW2cgzKJ
 GyWtZJ18tFh9CBXdU/QhZuNEn0eYnlS6I8Kh3TFBiPGJxJ4ubbVt6kQ91Y0sXRwTdT
 Hoy5BAemJEgRiBA34YSPb3BY78WM7r0xFFVsq+A+iAazU9Yx8bgS7y0I3g+yz1fdC3
 Wt0g9X0yTkw2bT1MaDkX7Dce4S7zpUanapN8ZQJqKJaOOVDH2stEknH7dYTh4wncno
 cOSNd/CKKuGfFP3m94LO+QbIwaLCm5cs9ExdOdseUA6lIJ7w8vtv8VVZSc1Y3hLcIT
 dy5JYSAu1tmBA==
Date: Wed, 7 Oct 2026 10:54:56 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: himax,hx8279: add
 vddp-supply
Message-ID: <asYW8MysZdSHdiZo@squawk>
References: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
 <20261006-panel-himax-hx8279-vddp-v1-1-50d884b42aae@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MMrK/lZdGg9SD1J/"
Content-Disposition: inline
In-Reply-To: <20261006-panel-himax-hx8279-vddp-v1-1-50d884b42aae@baylibre.com>
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

--MMrK/lZdGg9SD1J/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2026 at 03:25:01PM -0500, David Lechner wrote:
> Add a vddp-supply property and make it required for the Startek
> KD070FHFID078 panel.
>=20
> The Startek KD070FHFID078 panel has a separate VDDP power input, which
> feeds its DC-DC converter, in addition to VDD and IOVCC. On the MediaTek
> Genio 520 and 720 EVKs, VDDP is switched by its own GPIO-controlled
> regulator, and on the Genio 1200 EVK it comes from its own PMIC LDO.
> In both cases it is separate from the other two supplies, so it needs to
> be described to power the panel.
>=20
> Making it required means existing device trees with this panel without
> it no longer validate. This is ok since the Linux driver will still work
> with them because the regulator core uses a dummy regulator for any
> missing supply. And anyone who sees the warning about the missing
> supply should add it to their device tree.
>=20
> It stays optional for the Aoly SL101PM1794FOG-V15 panel, as it is not
> known whether that panel has a VDDP input.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--MMrK/lZdGg9SD1J/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasYW8AAKCRB4tDGHoIJi
0vXbAP9Pa+6o9Kvfp8rFOQt+MoySArv1ZxQQvEAhhO5aRzql7wEAsA3Sa8wW8ZfX
tpdF/lVwu2hYNt2s6KZ1TfaX77j5rgw=
=Mwgg
-----END PGP SIGNATURE-----

--MMrK/lZdGg9SD1J/--
