Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF678606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLZgyTPQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D00310E6D1;
	Tue, 24 Nov 2026 12:04:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D33E010F527
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:03:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 121BB601D7;
 Tue, 24 Nov 2026 12:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEA61F000C0;
 Tue, 24 Nov 2026 12:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795521837;
 bh=oYbXj0yNjZiMy+eua3Y/lDjmzkocOFrtcKob1CzD7tc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eLZgyTPQtDsyO7fTRXI1d2QI9hjq4DaVrh/5ihKpp3XhmJxlN2/U1SmAjPNg3ByL3
 k32AD5shzBdF9o78UM++5Ku196qwtAwxSGMkSX8dWhnjyT+CPHnGCn87iyHJrild+n
 wCz4u+12xx8BCB3/5qhRHsmyvGAiomXfCdPH9Sqjpw806v07WDEsm2jnVd3Nl+w1az
 Fy1gqf+bPCZkSgPRqLbVihQkp1CgkqQTVYk9BbrVdTpJmrifHHsDoV3p5Bfpj6IvDk
 ib8n6+J4kX0cAZpfMZIkBOzJwnU65xctsb98K1fJtjD1jQ/Vu/YsEqSkxIwMOrDmxt
 u18tdC+b3p+cQ==
Message-ID: <sashiko-outbox-231094@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: st: stm32mp15xx-dhsom: fix bridge reset
 polarity
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261124-tc3-reset-v1-2-a5d27fe4b5de@kemnade.info>
References: <20261124-tc3-reset-v1-0-a5d27fe4b5de@kemnade.info>
 <20261124-tc3-reset-v1-2-a5d27fe4b5de@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:03:56 +0000
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
- [High] ARM: dts: stm32: GPIO_ACTIVE_LOW reset breaks attiny power
  sequencing
--

commit 5197ca21b0b76899dd25b433741d3989825b219f
Author: Andreas Kemnade <andreas@kemnade.info>

ARM: dts: st: stm32mp15xx-dhsom: fix bridge reset polarity

This commit changes the TC358762 bridge reset GPIO polarity from
GPIO_ACTIVE_HIGH to GPIO_ACTIVE_LOW in the Raspberry Pi 7-inch DSI panel
devicetree overlay.

> diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi=
7inch.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7i=
nch.dtsi
> index 518c269a1dba1..6342a6e757c12 100644
> --- a/arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.d=
tsi
> +++ b/arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.d=
tsi
> @@ -35,7 +35,7 @@ &dsi {
>  	bridge@0 {
>  		compatible =3D "toshiba,tc358762";
>  		reg =3D <0>;
> -		reset-gpios =3D <&attiny 0 GPIO_ACTIVE_HIGH>;
> +		reset-gpios =3D <&attiny 0 GPIO_ACTIVE_LOW>;
>  		vddc-supply =3D <&attiny>;
>  		status =3D "okay";

[Severity: High]
Does changing reset-gpios to GPIO_ACTIVE_LOW break power sequencing on the
attiny regulator and leave the panel unpowered?

During probe, tc358762_parse_dt() requests the reset GPIO using logical
GPIOD_OUT_LOW before vddc-supply is enabled:

drivers/gpu/drm/bridge/tc358762.c:tc358762_parse_dt() {
	...
	ctx->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
	...
}

With GPIO_ACTIVE_LOW, GPIOD_OUT_LOW drives a physical 1 on &attiny GPIO 0
(RST_BRIDGE_N).  In attiny_gpio_set(), driving RST_BRIDGE_N high sets
PC_RST_BRIDGE_N | PC_RST_LCD_N in REG_PORTC and writes the TC358762
registers over I2C while main power (PB_LCD_MAIN) is still off.

Because attiny_lcd_power_is_enabled() checks whether the regulator is
enabled by testing data & PC_RST_BRIDGE_N in REG_PORTC, the subsequent
regulator_enable() call sees the regulator as already enabled and skips
attiny_lcd_power_enable(), leaving PB_LCD_MAIN and PC_LED_EN turned off.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-tc3-reset-=
v1-0-a5d27fe4b5de@kemnade.info?part=3D2
