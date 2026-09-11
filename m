Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F4DC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ACF610E09F;
	Fri, 11 Sep 2026 20:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SdMWP7jT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A9810E09F
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 20:26:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2DE160008;
 Fri, 11 Sep 2026 20:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250EA1F000FF;
 Fri, 11 Sep 2026 20:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789158359;
 bh=FMQ87La+n3zYM8L3jNEb48smDmU8bZ/yFQYBTNCegPg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SdMWP7jTM9YT1NkRuc16xD4tGNPe8xT40lNpXGBzNRsfIrS+ZKqB73RfRzmGy/gV+
 7qllLWGg1xvA3mPrjlU/fgjKpAmGx6tTwF0lGjZCeYfZTiw5OmjI8hRSgHzA1YY2xK
 /mCuhZhJspE8i9gbjWgAiHc4h9TqJMdh+knwqmQhP+hn7P44L1obI6dsRBCaQkjKZy
 k8WhyxddTLN00129ElwN3bm6itu0pHe7VNBrJaVRTOPwqhefju18WVNqu/KaUj1DwM
 9x5lNac/3V/dyoiOvVKfyYC19pSJYReCd9URIcFQ/DhW7Ll5dxzfwL/bOPDt4VMLL2
 ZepdRVtH0wWcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: display: panel: mipi-dbi-spi: add
 st7789v-tft28
To: "Enzo Frese" <freseenzo@gmail.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260911201920.72734-1-freseenzo@gmail.com>
References: <20260911201920.72734-1-freseenzo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 20:25:58 +0000
Message-Id: <20260911202559.250EA1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added compatible string `st7789v-tft28` lacks a mandatory=
 vendor prefix, violating Devicetree specification rules.
--

commit b9c6f3f7002bdc4087c21d6e0612fcb912f52747
Author: Enzo Frese <freseenzo@gmail.com>

dt-bindings: display: panel: mipi-dbi-spi: add st7789v-tft28

This commit adds a generic 2.8" 240x320 RGB LCD panel using the
Sitronix ST7789V controller to the panel-mipi-dbi-spi binding.

> diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-d=
bi-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-db=
i-spi.yaml
> index 6f0290c4e2917..c28659bd05dc1 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.=
yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.=
yaml
> @@ -75,6 +75,7 @@ properties:
>            - saef,sftc154b
>            - sainsmart18
>            - shineworld,lh133k
> +          - st7789v-tft28

[Severity: Low]
Does this compatible string violate the Devicetree specification rules
by missing a mandatory vendor prefix?

Modern dt-schema checks require compatible strings to be in the format
<vendor>,<device> to prevent global namespace pollution. Since this string
lacks a comma and an approved vendor prefix (such as sitronix,st7789v-tft28
or panel,st7789v-tft28), will this cause dt_binding_check to fail validatio=
n?

>        - const: panel-mipi-dbi-spi
> =20
>    reg:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911201920.7273=
4-1-freseenzo@gmail.com?part=3D1
