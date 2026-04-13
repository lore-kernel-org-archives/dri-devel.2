Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63426F34C63
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E1310E4C6;
	Mon, 13 Apr 2026 15:39:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DSDcF0Mq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B39910E4C6
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 15:39:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E3336442AC;
 Mon, 13 Apr 2026 15:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BCCC2BCB0;
 Mon, 13 Apr 2026 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776094748;
 bh=5QadCKKgpXr3kgDA5Kh5wEnfHoR6sXkaWzTiQDRCL8E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DSDcF0MqFhxRfd6z8Mq9kpdj2Of1AdRqwPDq9/WY6gX67s2Fdpq091C3uhjJek37e
 rDJv5nnj58b4BsDHX/dhWlXb0pPPX2vrFlgmaA+81CqZMbvu3LEsMxSlgjr6eMwRur
 Tz343eqnCM8jtACyImiVQldcbgKsTEhVpRlume0ysXuOYIQAHX3p1n9TgandQaNPhE
 rUWsWd8fFM7y9EAen8wMbIAWKGhpAFpzsFzymBBbNimOixYXo7QN03Z6+I7zO2JgOw
 Q6w3+Gm4jiKZuwXVPVFfxUW3dl+30LSk4xDykzvSjVwGCzI27aNHVk6ODxfHzut7b0
 xT5BYngh1aqHQ==
Date: Mon, 13 Apr 2026 16:39:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Jie Gan <jie.gan@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 20/21] dt-bindings: gpio: describe Waveshare GPIO
 controller
Message-ID: <20260413-unwed-energy-02b0f152d165@spud>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
 <20260413-waveshare-dsi-touch-v3-20-3aeb53022c32@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mU8o5eBcLdlDCcZO"
Content-Disposition: inline
In-Reply-To: <20260413-waveshare-dsi-touch-v3-20-3aeb53022c32@oss.qualcomm.com>
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


--mU8o5eBcLdlDCcZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 05:05:43PM +0300, Dmitry Baryshkov wrote:
> The Waveshare DSI TOUCH family of panels has separate on-board GPIO
> controller, which controls power supplies to the panel and the touch
> screen and provides reset pins for both the panel and the touchscreen.
> Also it provides a simple PWM controller for panel backlight.
>=20
> Add bindings for these GPIO controllers. As overall integration might be
> not very obvious (and it differs significantly from the bindings used by
> the original drivers), provide complete example with the on-board
> regulators and the DSI panel.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--mU8o5eBcLdlDCcZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCad0OEgAKCRB4tDGHoIJi
0gC+APiip+54dvGW6xw4Pg/dOwwMiT7o7wl2wFDjy02hzx0xAQDTPdnt6DUjttpa
Sjd8YI561hvPMtRCDjboZ6XIiLoiAA==
=htZd
-----END PGP SIGNATURE-----

--mU8o5eBcLdlDCcZO--
