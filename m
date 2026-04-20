Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDD0F588EE
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD5210E6DE;
	Mon, 20 Apr 2026 16:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="swOkxva2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F60B10E6DE
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:14:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 61FB860018;
 Mon, 20 Apr 2026 16:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D788C19425;
 Mon, 20 Apr 2026 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776701653;
 bh=5wfl9+P9EJ6L0BbEH5DhT3kSeK2UsySO5+x/zJBvc+o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=swOkxva2RIo1eoZaDhBcbzpgkwLo3Y6w3y+3BEAuNP/G/4cYN3sjthlv7M0JiSDPq
 3f51l9c9/2HNi0g+tHzmD7M50v9ac36kLpPMMTPQ3eG9O3+sjDuI/ZGnSPEehso8Pi
 bWSzUgzd5XZHfRL6A3LMfoU8qpyDke7K/buk6ddVJ2jAU5iyP9fntLEofv9sCLFYsp
 BFz6hln7W9811aSPPtN/cHMG12Ud9pMxeCJ5Zc0/f1Tjxki8ODw43nqyql0Hu/pr+D
 iXYebW52hocm1enFmsN7eIYciYBxudO4kZQm8DaFObB4crqxWVdO5pW1XiCLNiYQyh
 8UUxsn560/9Fw==
Date: Mon, 20 Apr 2026 17:14:06 +0100
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
Subject: Re: [PATCH 4/7] dt-bindings: soc: renesas: Document Renesas R-Car
 R8A779MD Geist
Message-ID: <20260420-bronze-umpire-e09056798343@spud>
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-5-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="buxOxV0Fkdmogddv"
Content-Disposition: inline
In-Reply-To: <20260419193718.133174-5-marek.vasut+renesas@mailbox.org>
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


--buxOxV0Fkdmogddv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 09:35:35PM +0200, Marek Vasut wrote:
> Document the compatible value for the Renesas R-Car M3Le (R8A779MD)
> SoC and the Renesas Geist development board. The Renesas M3Le SoC is
> a register-compatible variant of the R8A77965 (M3-N) with reduced set
> of peripherals. The Geist board is derived from Renesas Salvator-X/XS
> boards, with adjustment for the R8A779MD SoC.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--buxOxV0Fkdmogddv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeZQzgAKCRB4tDGHoIJi
0rHoAPwLbvnyrdiC+rmymK7fgljBrq9sHh6mZ0MGsGQxDoTIBgEAy9mnn4y7PJQJ
qPi87tC0puxDtHTscafpE95WrhTf6gM=
=6Nad
-----END PGP SIGNATURE-----

--buxOxV0Fkdmogddv--
