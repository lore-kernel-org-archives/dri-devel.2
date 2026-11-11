Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FF6606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lE7VM1/5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEED710E3B7;
	Wed, 11 Nov 2026 11:10:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9361B10E3B7
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:10:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4969B4690F;
 Wed, 11 Nov 2026 11:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80651F00A05;
 Wed, 11 Nov 2026 11:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794395447;
 bh=pLhx0B7rZp8JjL6NJ1Ii8OSP29Jgl2dZGv2AwdDNFQo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lE7VM1/57TRlXJ4WhNqXBNSixDkdrUfis8/oB9BFszCVq3YVtu62MnpI7pqrzUeXH
 zBrMM/DkB82x9aIpuyQniPYixko5JBgzd6QEbV5eamGTtLGXRvXAfv8cNHUvAAtoHG
 KukztDUfvDUcZYOVusougknME6uzg5vb7YBdt4VbQccS3+dpeHx6CRLXW5gQBOS8Op
 ArgplQvts5LgwSLhnP1hTjoQKwYQ6EbGZNuUxrf8/Mlykm2lBjYh8pyHjayPsOc/mH
 xLPHOR9uRAGHiUZIlSsd7wSOKZU2y3tJ/rGWarsLHuK7v+hp0rZSB2NuBkbvFmd4t8
 piSf2PlmumcKg==
Message-ID: <sashiko-outbox-208855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: display: panel: Make DSI panels port optional
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261111110338.81717-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261111110338.81717-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 11:10:46 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dt-bindings: display: panel: ilitek,ili9806e: port made optional
  for SPI panel
--

commit 2dd7afd9762ebccda9424fc16917d18216458223
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

dt-bindings: display: panel: Make DSI panels port optional

This commit removes the port property from the required list in 39 DSI
panel Device Tree bindings so that panels placed directly under a DSI bus
node do not have to specify an OF graph port.

> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili98=
06e.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.=
yaml
> index 2080d9e0ffac4..9a2602ddd9060 100644
> --- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
> @@ -33,7 +33,6 @@ required:
>    - vdd-supply
>    - reset-gpios
>    - backlight
> -  - port
> =20
>  if:
>    properties:

[Severity: Low]
Should port remain required in the conditional then branch for
rocktech,rk050hr345-ct106a?

While densitron,dmt028vghmcmi-1d and ortustech,com35h3p70ulc are MIPI-DSI
panels, rocktech,rk050hr345-ct106a is an SPI-controlled DPI/RGB panel
(driven by panel-ilitek-ili9806e-spi.c with DRM_MODE_CONNECTOR_DPI).
Because it sits under an SPI controller node, the RGB display controller
still needs the OF graph port to link to the panel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111110338.8171=
7-2-krzysztof.kozlowski@oss.qualcomm.com?part=3D1
