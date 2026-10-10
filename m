Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCE2CA9ECA
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 23:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A2510E0D3;
	Sat, 10 Oct 2026 23:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JoBXnq7x";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 858C010E0D3
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 23:37:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6EB13600AA;
 Sat, 10 Oct 2026 23:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1291F000FF;
 Sat, 10 Oct 2026 23:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791675427;
 bh=3QamY1Gb8A8Ny5Yds8gfu5aA2p1komHGqOr0cDTdyZc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JoBXnq7xU0NY6OI1bgbHI8OhqZvV4/fW7ugv0TO+Sn+09/Fa8NtguUxGz14t2gXmb
 IYL57s1qyheT720qRiOBcnewvRHcW4TCWABrLv/FYQtTHDZ7qQrR+MH6BRncwl/MYU
 B5+besDNXFT8L9LyYFfsY/udcYSDdWiG0ig8c/ttSPrOjZ7n6mvjmLHIpeF2xmpIaS
 vRwVunkAKwKzmllXCJnYYIwOSScpexlZy1/KOhbvfmLEse5LkH2yHtkgglY3Glwihk
 cjMW28BjGWizJizELecN3Fok0wYdfJg40PCYGlnMKb2U6cMU3JzihM8nX5J96y7mGQ
 uFA+J7z+gz8Iw==
Message-ID: <sashiko-outbox-166934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Enable display on UNIHIKER
 M10 V1.2
To: "Miotsuki Mizuno" <founder@crepuse.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261010232857.26950-3-founder@crepuse.com>
References: <20261010232857.26950-1-founder@crepuse.com>
 <20261010232857.26950-3-founder@crepuse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 23:37:06 +0000
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
- [Low] dt-bindings: missing schema definition for 'dfrobot,unihiker-m10-di=
splay'
--

commit 6e141ce95f426918ca0341028cd073760d1b80d9
Author: Miotsuki Mizuno <founder@crepuse.com>

arm64: dts: rockchip: Enable display on UNIHIKER M10 V1.2

This commit enables the onboard SPI display for the UNIHIKER M10 V1.2 board.
It adds device tree nodes for the backlight, LCD control pins, and the SPI
display itself along with its timing and required properties.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3308-unihiker-m10-v1.2.dts b/=
arch/arm64/boot/dts/rockchip/rk3308-unihiker-m10-v1.2.dts
> index 270ea970c95a7..a3264ef23746e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308-unihiker-m10-v1.2.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3308-unihiker-m10-v1.2.dts

[ ... ]

> @@ -211,6 +230,40 @@ &sdmmc {
>  	status =3D "okay";
>  };
> =20
> +&spi2 {
> +	assigned-clocks =3D <&cru SCLK_SPI2>;
> +	assigned-clock-parents =3D <&cru PLL_DPLL>;
> +	assigned-clock-rates =3D <100000000>;
> +	status =3D "okay";
> +
> +	display@0 {
> +		compatible =3D "dfrobot,unihiker-m10-display", "panel-mipi-dbi-spi";

[Severity: Low]
Will make dtbs_check report a validation failure here?

The panel-mipi-dbi-spi driver parses the first compatible string to constru=
ct
the firmware filename, but the corresponding schema located at
Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
enforces an explicit list of valid compatible strings via an enum.

Since dfrobot,unihiker-m10-display does not appear to be added to the schem=
a,
does this violate the DT binding rules?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010232857.2695=
0-1-founder@crepuse.com?part=3D2
