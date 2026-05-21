Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFA8CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 16:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4380D10E50D;
	Thu, 21 May 2026 16:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q8cUeXab";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE4D510E50D
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 16:57:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FCBA41900;
 Thu, 21 May 2026 16:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD3F1F000E9;
 Thu, 21 May 2026 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779382642;
 bh=I55lHSd1Ysdw8ZeTKOs6GuGHFCThm01Fvnx0VC1jLqQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q8cUeXabxJU0IWTMJGWeV1jyVIfvz0S1Jqem5iE9CRf9Pq2+mWblC10QoinsHPl5I
 Q3ZL+QLPcbfH15rclKm+NAwAKcI8tZ/OYO3FPZX+WeMwWWBbTVZ+4RyAqeUcjl0r5l
 YHvznZYLs/8jKgJqaYSbKgkFpHDAPePw9mT+COCz+J9JcfnnOHxtawaXFvzLeMZqJ8
 cveGc4f0Y6zaJUVQtko6MRcp5gYokSoH3aJ7YeuWCOwxgTy65JiCGkgym7ddMIZgK4
 plIS9SiU7Fu/wUh9MZfkYNY4XnjyBXf1VTvQl+3BEFXHh6GtjbrF08s/x5VvBsVfHl
 fmGyhC6nqhBwQ==
Date: Thu, 21 May 2026 17:57:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 05/15] dt-bindings: display: panel-lvds: Add Riverdi
 RVT70HSLNWCA0 and RVT101HVLNWC00
Message-ID: <20260521-yogurt-tinker-1a5d0b7dc17a@spud>
References: <20260521150038.103538-17-ivitro@gmail.com>
 <20260521150038.103538-22-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kz3CuFPJ65DTj9OM"
Content-Disposition: inline
In-Reply-To: <20260521150038.103538-22-ivitro@gmail.com>
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


--kz3CuFPJ65DTj9OM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--kz3CuFPJ65DTj9OM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag85awAKCRB4tDGHoIJi
0pQPAQD3ZguE0qhACoyjjc36ilvY5dp10jnqrf6MIIYE4NZo/QEAuPhAFRZo+DP9
UGlRN4VyZELr3mPIjLY+grUb7XeIUwA=
=4KHE
-----END PGP SIGNATURE-----

--kz3CuFPJ65DTj9OM--
