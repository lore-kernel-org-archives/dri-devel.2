Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E874BCA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CDB010E0B9;
	Mon,  5 Oct 2026 10:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PTNqbbtH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E68E10E0B9
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 10:52:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 67AF2600D4;
 Mon,  5 Oct 2026 10:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675E01F000FF;
 Mon,  5 Oct 2026 10:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791197527;
 bh=ipPqkob72lwiICznw3iaHl72u9I6k7Y65KFgTyU2QgY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PTNqbbtHgn2jLjA5N+bUnuG27HQLJUe9z/ekE0529Np6+e3GFepNzzvDRoLdgll4F
 McV6RhaHn/BhB2+Tq/HSopC0dXf8PS3A2A11a18B/Sum08aGXWO7XPD8Q2Yu1hFGNl
 vnXk0VkSFT29P1tOfFJ07XJPa4kug53ZnWPiYxgsPKKC5fgY4Sf5pbCr6n9waEQRhj
 0jx/BaNQ5NoSHLHkCjg97ML4Na5gJF6/PwpJoAKHiSJBp8YhG7jrYd8HNXxL0U+jUL
 /yllv2twSEXc0l88sIWJpsrAXDXqAdw0Ro+5TRww3Zfb7Ie3Z2AeYuWdiaK8MgxfFM
 moqiLUI7GuyOw==
Date: Mon, 5 Oct 2026 11:52:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
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
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: bridge: Add THine THC63LVD827
Message-ID: <asOBT9BYUHgtZHSl@squawk>
References: <20261005095006.20290-1-francesco@dolcini.it>
 <20261005095006.20290-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="of/0ohSULi3F3TqY"
Content-Disposition: inline
In-Reply-To: <20261005095006.20290-2-francesco@dolcini.it>
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

--of/0ohSULi3F3TqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--of/0ohSULi3F3TqY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasOBTwAKCRB4tDGHoIJi
0rwdAQDSpi5tpG2Muex4r3hjnkzBTH62ffvgnRxZL0zgijNWjQD/XndwmNAxYG0X
KdwDCKu4GpfeSUX1Vk+ZZN6d9WCobwc=
=a/zt
-----END PGP SIGNATURE-----

--of/0ohSULi3F3TqY--
