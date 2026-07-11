Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3C4C44501
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63EA10E033;
	Sat, 11 Jul 2026 06:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U8AE9zeu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A0410E033
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:15:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4FFC9600C3;
 Sat, 11 Jul 2026 06:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960511F000E9;
 Sat, 11 Jul 2026 06:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783750508;
 bh=aLGh66e7KmCkxIhtJRtX2O1DwbOVWIeQasbM5QwE/J0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U8AE9zeuAifA+audOrYTNcozWLYLEqzX3PuKdGl8mxO4MgY72KD8XN4dAue97XGiQ
 EtIJlsKlGxAIbfI5kr6nXxnQ03AkgtNk9gWy1dta2e0m/DzqqAf9AeyAJrjVh2y9bW
 DWQlBsbldp4iqJcuBIVYy+AvsvyxmLmDYR2ejSRqeAcfNwOtMEGrX24lLntwkFeS0x
 NTKGEqn6yQY02EDWBsoG6wABstJGgbsR1BFpx/wS+nvoYbq7eZWBykKA8O2UoxP39r
 lzbWCPLNQHVdnZE7gZt098OEhNv1lkby+J9UV0dF22uvpGPUn+Xkg3hqFmxIirhI4j
 6sdT+pItx53iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/16] arm: dts: omap3-pandora-common: backlight: switch
 to twl4030 pwm and pwm_bl
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: conor+dt@kernel.org, lee@kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <e528e00899fb93f67e8480874fc114b21ae3e520.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <e528e00899fb93f67e8480874fc114b21ae3e520.1783749722.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:15:07 +0000
Message-Id: <20260711061507.960511F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing TPS61161 hardware initialization quirk causes backlight to=
 fail.
- [High] Concurrent probing of legacy and generic backlight drivers causes =
I2C register corruption.
- [Medium] Hardware misconfiguration due to unsupported PWM period, leading=
 to artificially restricted brightness range.
--

--- Patch [14]: [PATCH 14/16] arm: dts: omap3-pandora-common: backlight: sw=
itch to twl4030 pwm and pwm_bl ---
commit 062b6b894a7997d211a245d15a6bd9071869adad
Author: H. Nikolaus Schaller <hns@goldelico.com>

arm: dts: omap3-pandora-common: backlight: switch to twl4030 pwm and pwm_bl

This commit adds a generic pwm-backlight device tree node for the Pandora
backlight. The commit message states this allows removing the pandora_bl
driver and pdata-quirks.

> diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/a=
rm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> index 13821d926afb0..fea7132ce7c5e 100644
> --- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> @@ -31,6 +31,14 @@ hfclk_26m: oscillator {
>  		clock-frequency =3D <26000000>;
>  	};
> =20
> +	backlight {
> +		compatible =3D "pwm-backlight";

[Severity: High]
Will this result in a hardware conflict if the legacy driver isn't actually
removed in this patch?

The commit message mentions this allows removing the legacy pandora_bl driv=
er
and pdata-quirks.c registration, but this commit doesn't remove or
conditionally disable the legacy platform device registration.=20

If CONFIG_BACKLIGHT_PANDORA is enabled, both the legacy pandora_bl driver
and the new pwm-backlight driver will probe concurrently. Since pandora_bl
writes directly to I2C registers and bypasses the PWM framework, this dual
driver setup can cause race conditions, register corruption, and duplicate
sysfs entries for the backlight.

[Severity: High]
Does switching to the generic driver cause the backlight to fail on startup?

The legacy pandora_bl driver included a TPS61161 hardware quirk that forced
a 100% duty cycle for 2-10ms at startup. Without this continuous >2.5ms high
pulse, the TPS61161 enters 1-wire detection mode and disables PWM control.=
=20

The generic pwm-backlight driver immediately applies the computed duty cycle
on power-up, which lacks this required hardware initialization sequence.

> +		pwms =3D <&twl_pwm 0 1922710>;
> +
> +		brightness-levels =3D <0 150 158 166 174 185 205 230 255>;

[Severity: Medium]
Is this artificially restricted minimum brightness of 150/255 (59%) a
workaround for an unsupported PWM period?

The device tree requests a period of 1922710ns (64-tick mode), but the
pwm-twl driver unconditionally sets TWL_PWM0_ON to 1, forcing 128-tick mode
(~3.9ms period).=20

To prevent the longer off-times of this slower frequency from exceeding the
2.5ms threshold that triggers the TPS61161 1-wire mode, it appears the
minimum brightness was raised to 59%. This seems to be a significant
functional regression from the original 14% minimum brightness.

> +		default-brightness-level =3D <6>;
> +	};
> +
>  	tv: connector {
>  		compatible =3D "connector-analog-tv";
>  		label =3D "tv";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783749722.gi=
t.hns@goldelico.com?part=3D14
