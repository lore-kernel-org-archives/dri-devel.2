Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B82F588E3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307F410E6DD;
	Mon, 20 Apr 2026 16:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GCyZafo9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745A010E6DD
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:13:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C76E402DB;
 Mon, 20 Apr 2026 16:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D94BC19425;
 Mon, 20 Apr 2026 16:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776701621;
 bh=qpZ7ncDNJr9ziiS+LAieulgSFEo8xxAIbpPMQA4F9mU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GCyZafo9Fh/dEQP8jQ4T8sWyAUyJHulyQiSm09OXDMB/R4IbmiYf6xsJvHLRdqwo1
 0jfy6MwgMWpQVX01lpDvwflFlluEV1a2RTdTLbUaCefLKt7HNClZyW8M/vx5y8TQdn
 +UMQu6xbNY4JPECRT/P/iqcSdZNYYlObDQ5wYl9MTcBlQqQ4HRZn9NUYdjQzZuMRXh
 TbGzQLN6MiE+5kTHeCPWNMnq7cOK4qR4tGUTV6wkuP6VU6smyd5dmJjO1N5Kw3qIww
 mlJjrsBan6puI5myoUQ05311quXsvxO9AQTXdMSbKqVVmqbjpM1pptOBNtJTVNMh7c
 kwUjFcKP5wk+w==
Date: Mon, 20 Apr 2026 17:13:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Stephen Boyd <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: clock: cs2000-cp: document CS2500
Message-ID: <20260420-silk-reshuffle-5cebd4e9b3eb@spud>
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-4-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pUBdod/Tj2QGPXtO"
Content-Disposition: inline
In-Reply-To: <20260419193718.133174-4-marek.vasut+renesas@mailbox.org>
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


--pUBdod/Tj2QGPXtO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 09:35:34PM +0200, Marek Vasut wrote:
> Document backward compatibility support for CS2500 chip, which
> is a drop-in replacement for CS2000 chip.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--pUBdod/Tj2QGPXtO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeZQrgAKCRB4tDGHoIJi
0pjsAQCA49Pk0dsLboQWtCSvqUAqlzI1AA+W9v49L7Jrjx+s9wD+PH5THnhWjMV3
tKapKVmvGgUb9hPLap9b+GLi4MSdzQs=
=SY59
-----END PGP SIGNATURE-----

--pUBdod/Tj2QGPXtO--
