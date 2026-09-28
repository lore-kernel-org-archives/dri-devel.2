Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B09CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11DED88735;
	Mon, 28 Sep 2026 16:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IRuSkJvi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D8C10EB12
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:31:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6ED2E406A1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C711F000FF;
 Mon, 28 Sep 2026 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790613083;
 bh=EnF1lpL8yOAVbciKvQW9ui5UiqpwepMChIPZqx1gRuM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IRuSkJvi7ERiOqzVWjSyCEYf/Y3fU2wxA8HSAlOJeLzpvLiMiLQz6WqeeV6/iqh/3
 K81zJGtHSru8y3T0VPdTZN//WVr2UP59X1HbCpDsPv7JRIZHZIumOetrnGFI2SeYdA
 tRYXuOOoMCpPwpsZbNwqTT80Ohq4RmMpvgIgQZE1Hrx4b3suEX6sXahcM27rnfJC43
 HBpiplZ14fI6+TJpcp2d59zYMCI4nqf++Bddnv/2+C8hIQQ4F7LaRwQYWB20qCWP31
 Sq9pDWwTyGLiRA/ia6ov7KcRT5qlUJ+hHzFZDX6+DItsGp9b5j/+9S+p0a86lw0yFb
 STTXG75+jNG7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH DO NOT MERGE 6/6] arm64: dts: broadcom: Add Raspberry Pi
 ILI9881C DSI panel overlays
To: "Maxime Ripard" <mripard@kernel.org>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-6-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-6-5244926aace4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:31:22 +0000
Message-Id: <20260928163123.04C711F000FF@smtp.kernel.org>
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
- [Low] dt: node names use underscores instead of hyphens
--

commit 13a81e24cfdf82fcd1a6606b31ae481417af3552
Author: Maxime Ripard <mripard@kernel.org>

arm64: dts: broadcom: Add Raspberry Pi ILI9881C DSI panel overlays

This commit adds device tree overlays for the Raspberry Pi 5-inch and
7-inch MIPI-DSI panels on the Raspberry Pi 4 Model B. It introduces a
shared dtsi for the common display MCU and backlight components.

> diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-dsi-ili9881.dts=
i b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-dsi-ili9881.dtsi
> new file mode 100644
> index 0000000000000..bd08e22581a31
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-dsi-ili9881.dtsi

[ ... ]

> +&{/} {
> +	panel_backlight: panel_backlight {

[Severity: Low]
Should this node name use hyphens instead of underscores, such as
panel-backlight? Devicetree naming conventions generally prefer hyphens,
and using underscores here triggers node_name_chars_strict warnings when
building the device trees with standard strict dtc checks enabled.

> +		compatible =3D "pwm-backlight";
> +		brightness-levels =3D <0 31>;

[ ... ]

> +&i2c0_1 {
> +	status =3D "okay";
> +
> +	display_mcu: display_mcu@45 {

[Severity: Low]
Similarly, could this node be named display-mcu@45 instead? Replacing the
underscore with a hyphen avoids dtc compiler warnings for invalid node
name characters.

> +		compatible =3D "raspberrypi,touchscreen-panel-regulator-v2";
> +		reg =3D <0x45>;
> +		gpio-controller;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-drm-mipi-d=
si-panel-ebpf-v1-0-5244926aace4@kernel.org?part=3D6
