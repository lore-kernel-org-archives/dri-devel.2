Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C366DCA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 19:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0722C10E49A;
	Mon, 12 Oct 2026 19:09:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D539810E49A
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 19:08:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D08842E5F;
 Mon, 12 Oct 2026 19:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40A31F0089B;
 Mon, 12 Oct 2026 19:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791832134;
 bh=AH2UirJCWDjtQ8R32qv313a+sS+NLZo8fy7CiVjRpSU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kQ+QH3abMyKT2hbftVxX9XFZgH/GiMSWph9bG9HxraLBUjQ0N+StNB9KsQYvvkwiV
 Pg5zYOmXvvYa3Pav0CLHRkwPPtTepSUXakhiy+ISkksn3WlIRe6epE3tuPBsZD9E4+
 T4UVCCqYso81hQAHLKcsK2wPvigYccynGcCJo7c/Uqw0lyw2X0CPRH3fr4jJgQtmjQ
 OUL4qwzUOKo3LY1N/bmEAKbXPpAD99z/H59Ll/FIYaLMbHm8xTH515OFgUxmPdgPPr
 lhv91rM7LpVaGtuyhW96p//w/btde2nlH81Bun4BOAP31gSqHn8Q52bsNA6PamT9c3
 scX6AQLgNr2wQ==
Date: Mon, 12 Oct 2026 20:08:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH 1/3] dt-bindings: display: bridge: simple: Add the
 Toradex Apalis iMX6 VGA DAC bridge
Message-ID: <20261012-overtly-powdered-c8c2869e4319@spud>
References: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
 <20261012-v1-apalis-imx6-enable-vga-v1-1-8905d8746504@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cfz7Ef1U0dsCKRCm"
Content-Disposition: inline
In-Reply-To: <20261012-v1-apalis-imx6-enable-vga-v1-1-8905d8746504@toradex.com>
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

--cfz7Ef1U0dsCKRCm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--cfz7Ef1U0dsCKRCm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0wPwAKCRB4tDGHoIJi
0jlnAP4yIPeZyDrdvqTGaV/8ySZ5uj9SUbamP+03AnBdo4AXpQEAzZ00qNI8KiIV
oDO4vZxCIctnH5UQGVexvOnOtgOWYA0=
=W8Vk
-----END PGP SIGNATURE-----

--cfz7Ef1U0dsCKRCm--
