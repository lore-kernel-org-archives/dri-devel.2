Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13AD109C040
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21DA910E823;
	Wed, 25 Mar 2026 18:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y2B4ZUWZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B79AF10E823
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:22:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id ED372600C4;
 Wed, 25 Mar 2026 18:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5075DC4CEF7;
 Wed, 25 Mar 2026 18:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774462922;
 bh=YHNgcFIO6hQV4oLncfHbHayJjWhyYTZ7VYKpJ48Ex5w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y2B4ZUWZk/fZPOrzid/tq7Mm1EDIpGuOE11AQRY8S6NJNvOJwzqzpf0qrw1dYutFa
 siGnlKv3+I/w4ynBugQkJ9sAmTFyGYQiPwA8EgEwSfORV13iixtK7i1LfVyvRP4jDN
 cvs0PmMM5Yn3LrYWX1CHy7oLmEl3IVcLGsIvbNClqDFnPI8Gzx+QIlLlXAsoAWN4bc
 u2IoHN3JtdJdWiAiBjLRrmBiS9SYRTxF5Be1V4oU3YWoxlHFIhmA96vG1lGqij8N5W
 BjPZqwOueFAFsZWMfjFftOG/EGmwnwZ2nkQtSskRTaZyKRKjeTNKOth/VCevoIYbAW
 k9sfiJ+QN+mnQ==
Date: Wed, 25 Mar 2026 18:21:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Shawn Guo <shawnguo@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] dt-bindings: arm: fsl: add compatible for new Skov
 I.MX8MP variant
Message-ID: <20260325-trouble-dispersed-06a77ad41a90@spud>
References: <20260325-v7-0-topic-imx8mp-skov-dts-jutouch-7inch-v1-0-10255d236439@pengutronix.de>
 <20260325-v7-0-topic-imx8mp-skov-dts-jutouch-7inch-v1-3-10255d236439@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PZTvQgnWwJ6KjtKN"
Content-Disposition: inline
In-Reply-To: <20260325-v7-0-topic-imx8mp-skov-dts-jutouch-7inch-v1-3-10255d236439@pengutronix.de>
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


--PZTvQgnWwJ6KjtKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--PZTvQgnWwJ6KjtKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacQnxAAKCRB4tDGHoIJi
0o9CAQDXdpBhuEh7kTCcbiLCc1nFZHZqEImPwNnhaFu9T/buAQD+NTlLTJTRZ9pI
VxCTB/9AJtJtngY3mjOl2Q5qx7idhgA=
=BVDg
-----END PGP SIGNATURE-----

--PZTvQgnWwJ6KjtKN--
