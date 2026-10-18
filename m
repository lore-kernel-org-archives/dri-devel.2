Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37228CCA490
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 18:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F17F10E104;
	Sun, 18 Oct 2026 18:51:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C1310E104
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 18:51:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A93DB400F8;
 Sun, 18 Oct 2026 18:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F561F000C4;
 Sun, 18 Oct 2026 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792349481;
 bh=nI0Mo9K6wNbpzc6WH1o0ex4u9xbK7kaPdxDmuDw24eA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Dku5uRPa+b4JnRohhs4dIyC7stFLjtCohgCs51GQxs5n4o6LNlfD5sDP5I+9rxK5N
 xc3CPquir26Tc56Og0zOOBBpqEGkPnYGBLygAc74ZBzB0fVIByDLTFXxByQT4LhPJJ
 VNt+/AkkI7Pj0MwEJop6f3zW51JMwHsT8usRZd3rw1mHVbo4+lVXUOAwTVY4ujV2Zh
 MNK19G/JJ1IOdc01iKlN9Za5+BiZjhSPBjk+UMinU5vjtMY/VImMsJUpuaVn4fnoIf
 Nf9CNJ+9MyB/9BXChq8F3SSGIUzTi0pU2qdomMMDj0Cn5fG1gOXcshkGWdUx3z2b4q
 DWCO0LkEmI6IQ==
Date: Sun, 18 Oct 2026 19:51:17 +0100
From: Conor Dooley <conor@kernel.org>
To: tianshi12127 <tianshi12127@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add smartisan
Message-ID: <20261018-delirious-equal-86755d897a0d@spud>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
 <20261017103250.800109-1-tianshi12127@gmail.com>
 <20261017103250.800109-2-tianshi12127@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lwjdUVkLnxoBgmOc"
Content-Disposition: inline
In-Reply-To: <20261017103250.800109-2-tianshi12127@gmail.com>
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

--lwjdUVkLnxoBgmOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--lwjdUVkLnxoBgmOc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatUVJAAKCRB4tDGHoIJi
0qqNAQCHjqcEBCc1TJ1D7e8eiw/2FXICrT55fWjoVLIa89ymzAD+IV1CY2I9fbVp
wB5G2DKF0KV7+X+2KUsvIIF6NixUGgM=
=X6Vv
-----END PGP SIGNATURE-----

--lwjdUVkLnxoBgmOc--
