Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2C0CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6439510F06D;
	Mon, 12 Oct 2026 12:26:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A48A10F06D
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:26:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 658F743449;
 Mon, 12 Oct 2026 12:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ADD1F0089C;
 Mon, 12 Oct 2026 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791807974;
 bh=obYHc3+M18UAdUeKmDPXnw9X5JtSIpmf0cWdGUwtbiQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HJ6YNnVP6iFJogscQhvHVvri5pOfqsTlhKI7S1qwBlYznAp0MBz0fsSNnAJ6xmZxm
 nKvXw/l+igSvMPM8p1nynFg4LeGGoNn7KB4iIE7Oo4oUBUanLWDGqmQ321CAB7in4Y
 rZ/XRAKireLRfZEiz1iyTbfEsk1gM6vSsYx2rx6mLmDiYhJpxBDKP27J7R+zqPSmX8
 k51MzIKpMNTbk1xYML1py31RL2SIDELLjTD8lZPDYlF7FBpNt3W0NbTsm6YfXU6I6d
 FihVkf6g0cyJXl6KM2SeaVCPPDvXo5VaR57Uk/XNY2TST9YYnxStGqjHnxSK3QUkuC
 huq+IyQYkcA0g==
Message-ID: <sashiko-outbox-168094@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Enable display on UNIHIKER
 M10 V1.2
To: "Miotsuki Mizuno" <founder@crepuse.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20261012121718.53481-3-founder@crepuse.com>
References: <20261012121718.53481-1-founder@crepuse.com>
 <20261012121718.53481-3-founder@crepuse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 12:26:13 +0000
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
- [Low] dt-bindings: undocumented compatible string dfrobot,unihiker-m10-di=
splay
--

commit bb7cab2e48d73305c4348ab50dde38a500cc0a23
Author: Mizuno Miotsuki <founder@crepuse.com>

arm64: dts: rockchip: Enable display on UNIHIKER M10 V1.2

Enable the onboard 240x320 SPI display using panel-mipi-dbi. Add its
D/C and reset GPIOs, display timing, and PWM1 backlight, and enable
SPI2 with a maximum transfer frequency of 50 MHz.

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
Does the dfrobot,unihiker-m10-display compatible string need to be added to
the corresponding YAML binding schema?

Since it is used here without being documented in the panel-mipi-dbi-spi
bindings, it might trigger validation warnings during make dtbs_check.

> +		reg =3D <0>;
> +		spi-max-frequency =3D <50000000>;
> +		pinctrl-names =3D "default";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012121718.5348=
1-1-founder@crepuse.com?part=3D2
