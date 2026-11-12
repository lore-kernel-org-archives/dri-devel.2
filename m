Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D055606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERZ170QQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86B010E60D;
	Thu, 12 Nov 2026 15:15:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A300F10E60D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:15:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B63343530;
 Thu, 12 Nov 2026 15:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C5D1F000C2;
 Thu, 12 Nov 2026 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794496536;
 bh=58Mz0t/hlLLuiZeWpE0SHkeJJdrm5aAjKDDahhhZu60=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ERZ170QQOLV6LMyM+wGYGGkxa2sHB63VUjS329eQ3viUwnqbqoGebMZQj5pgfmG9Z
 /QshVXBegAj4XkYbVeMJvrIe3vSAmjHgVC+K+7Wj6gFCQ8NLX4W7E1HiGnKn4n75R0
 L1tw4Y53h3g39OXnqx4EK+nx3+B3oJ10QL3AYUVuaUmyHD7bpbPXmOQ+Y5Ut9GFr3H
 /JloEVLSO7TCcBLcaovMG3mHUXRAdwy3fYxO3HrZCog8vXmGWcishz2vmf8AFrDPy1
 4DRUH9XtWCy8tOSKZOP1lWArFDqMry2lpGTih1lOHMDPzuWRmCfC4f99hw6BJK1U3H
 GQB+VGT8JecxA==
Message-ID: <sashiko-outbox-211417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dt-bindings: display: panel: Make DSI panels port
 optional
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261112150650.137216-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261112150650.137216-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 15:15:35 +0000
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

commit bcf90e9f5f8315b117fe2401d0e209382d33f585
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

dt-bindings: display: panel: Make DSI panels port optional

This commit removes the port property from the required list in several
DSI display panel Device Tree binding schemas so that panels placed
directly under a DSI bus node do not require an OF graph port.

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
(registered with DRM_MODE_CONNECTOR_DPI in ili9806e_spi_probe()).  Because
its node sits under an SPI controller rather than a DSI host, the RGB
display controller still needs the OF graph port to link to the panel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112150650.1372=
16-2-krzysztof.kozlowski@oss.qualcomm.com?part=3D1
