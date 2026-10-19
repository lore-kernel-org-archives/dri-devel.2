Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B8606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GT3VhE0W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 306BD10E565;
	Mon, 19 Oct 2026 21:44:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1387C10E565
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:44:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE91343AD5;
 Mon, 19 Oct 2026 21:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A7A1F000C4;
 Mon, 19 Oct 2026 21:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792446280;
 bh=0gH035Ctt/IymfpW1MkjJssoA9dnmKGxwVzV9qVJRYQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GT3VhE0WJmwTy03LQnC9me3v0zHThFZaQsOHCad7Hj/gLVEqRe3TlAnoc+ol8iZto
 wbqHiEpaRRWKvC3bBjpqVBUCGXSugXxxxwHF7q3+EqIRbxPjIzgKBctZy7EOVOT4bE
 dAz++d0ulSejg+iGKWuiLlzdljlnJvlfkKbrdFE0kikGP3Y+2S45ybwmt2zqgzMWat
 GQdvGwtaXCck8zxv9lGWsEgi2W/8HjfjECBWOwl2/LWsmT7GDkzkN9Yo9w3s92nVfr
 /hurFOswslZx2brdmOkyTigNd+Qx8fbP5NSG5mPlPTnJo3BuIaMUb7jQqRexMHlMCH
 OQaQ5lqzrU8pg==
Message-ID: <sashiko-outbox-178273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/14] dt-bindings: display: solomon,ssd16xx: Add
 Solomon SSD1677 controller
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261019213726.4145532-4-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
 <20261019213726.4145532-4-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:44:40 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: display: ssd1683: bare solomon,ssd1677 compatible w=
ithout panel
--

commit 99bb2813cd624693670923f366680d97f3d2c796
Author: Devarsh Thakkar <devarsht@ti.com>

dt-bindings: display: solomon,ssd16xx: Add Solomon SSD1677 controller

This commit adds solomon,ssd1677 as a compatible string to the Solomon
SSD1683 e-paper display binding.

> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1683.ya=
ml b/Documentation/devicetree/bindings/display/solomon,ssd1683.yaml
> index 2e2aa195fb1e6..df8d9ff821a78 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd1683.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1683.yaml
> @@ -31,6 +31,7 @@ properties:
>                # Good Display 4.2" 400x300 monochrome e-paper panel
>                - gooddisplay,gdey042t81
>            - const: solomon,ssd1683
> +      - const: solomon,ssd1677
> =20
>    reg:
>      maxItems: 1

[Severity: Medium]
Should solomon,ssd1677 be used as a fallback behind a panel-specific
compatible in an items list rather than as a standalone const?

The SSD1677 is a display controller IC that supports panels of varying
resolutions (up to 960x680 pixels), physical dimensions, booster soft-start
tunings, and color configurations. Because this binding does not define
Device Tree properties for panel resolution, timings, or color mode, panel
parameters must be determined by a specific panel compatible string (just as
gooddisplay,gdey042t81 is paired with solomon,ssd1683 above, and as
ssd16xx_of_match in drivers/gpu/drm/solomon/ssd16xx.c expects when
ssd16xx_probe() looks up ssd16xx_device_configs[model]).

Defining solomon,ssd1677 as a standalone const under properties:compatible
allows a bare compatible =3D "solomon,ssd1677" node that lacks panel geomet=
ry
and cannot bind to the driver, while rejecting valid two-entry
panel-plus-controller compatible tuples during dtbs_check validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019213726.4145=
532-1-devarsht@ti.com?part=3D3
