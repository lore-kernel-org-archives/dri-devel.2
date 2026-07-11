Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC81C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7265C10E737;
	Sat, 11 Jul 2026 06:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SVJzTsvb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6DFF10E737
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:16:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 399EE600C3;
 Sat, 11 Jul 2026 06:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCF11F000E9;
 Sat, 11 Jul 2026 06:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783750577;
 bh=TsxwHRUdAoFCs4rmn9WpxfuzGLdKHzwN6S7lKjUzQpQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SVJzTsvbBvo4MrxAmwlPTJPdo1u/4FYZIloegOQRPYIDZkw5SLdccXnb19wv81Tte
 QEWNl8VYENgXJnqzau4SIrFM3tj4lMYvrVhkgDIM2zJx9dmpAan6ddWgGd0P+TQpC6
 pHrBfPUMm/as2wqwUAMrTnqzipcfT0pTtmP+20yo4jRNPR2JuqJt3Cj6zav+CIYqJU
 DKM4cPR6dcG38g9VN+UUjatfDd+EsCw6Zj5a37VverbP4swMH0kPGYwOCfOVeqLqP9
 YDeAx1WezgonAvVmwNEGYp+t7XJ+i2ZhRgt2fAnqjya075FJTGXWMa11Sav46PAfOy
 p+I+O4XIXfjRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/16] backlight: remove pandora_bl
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: mfd@lists.linux.dev, lee@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <f897f695c0e1e128d7ebb41be8dfdce4d634f552.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <f897f695c0e1e128d7ebb41be8dfdce4d634f552.1783749722.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:16:17 +0000
Message-Id: <20260711061617.8BCF11F000E9@smtp.kernel.org>
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
- [High] Removal of the TPS61161 backlight controller PWM mode initializati=
on sequence, potentially breaking backlight control.
- [Low] The 'pandora-backlight' platform device is still registered in lega=
cy pdata quirks despite the driver being removed, resulting in an unbound d=
ead device.
- [Low] Stale Kconfig reference to `CONFIG_BACKLIGHT_PANDORA` remains in `o=
map2plus_defconfig`.
--

--- Patch [15]: [PATCH 15/16] backlight: remove pandora_bl ---
commit 6eef80f63fc65c8cd1ed05d5c2e07cc3c726434e
Author: H. Nikolaus Schaller <hns@goldelico.com>

backlight: remove pandora_bl

Retire the platform specific pandora backlight driver since
it can now be replaced by twl_pm and device tree.

[Severity: Low]
Does this commit leave an unbound dead device registered in the system?

The pandora-backlight platform driver is removed here, but it appears
arch/arm/mach-omap2/pdata-quirks.c still statically defines and registers
the device in omap3_pandora_legacy_init():

    platform_device_register(&pandora_backlight);

Should this platform device registration be removed as well?

> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kc=
onfig
> index 7aa1c4b21111f..a250b3edc152c 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -451,13 +451,6 @@ config BACKLIGHT_MP3309C
[ ... ]
> -config BACKLIGHT_PANDORA
> -	tristate "Backlight driver for Pandora console"
> -	depends on TWL4030_CORE
> -	help
> -	  If you have a Pandora console, say Y to enable the
> -	  backlight driver.
> -

[Severity: Low]
Will this removal trigger a Kconfig warning during omap2plus_defconfig
generation?

The defconfig file still explicitly enables CONFIG_BACKLIGHT_PANDORA=3Dm.
Should arch/arm/configs/omap2plus_defconfig be updated to remove this stale
entry?

> diff --git a/drivers/video/backlight/pandora_bl.c b/drivers/video/backlig=
ht/pandora_bl.c
> deleted file mode 100644
> index 8a63ded0fa90f..0000000000000
> --- a/drivers/video/backlight/pandora_bl.c
> +++ /dev/null
> @@ -1,159 +0,0 @@
[ ... ]
> -	if (priv->old_state =3D=3D PANDORABL_WAS_OFF) {
> -		/*
> -		 * set PWM duty cycle to max. TPS61161 seems to use this
> -		 * to calibrate it's PWM sensitivity when it starts.
> -		 */
> -		twl_i2c_write_u8(TWL_MODULE_PWM, MAX_VALUE, TWL_PWM0_OFF);
> -
> -		/* first enable clock, then PWM0 out */
> -		twl_i2c_read_u8(TWL4030_MODULE_INTBR, &r, TWL_INTBR_GPBR1);
> -		r &=3D ~PWM0_ENABLE;
> -		r |=3D PWM0_CLK_ENABLE;
> -		twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
> -		r |=3D PWM0_ENABLE;
> -		twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
> -
> -		/*
> -		 * TI made it very easy to enable digital control, so easy that
> -		 * it often triggers unintentionally and disabes PWM control,
> -		 * so wait until 1 wire mode detection window ends.
> -		 */
> -		usleep_range(2000, 10000);
> -	}

[Severity: High]
When switching to the generic pwm-backlight driver, how is the TPS61161
initialized into PWM mode?

Because the TPS61161 shares its EN pin for both 1-wire EasyScale digital
control and PWM control, the removed pandora_bl driver included this
hardware workaround to force a 100% PWM duty cycle and sleep for 2-10ms at
startup.

Without this initialization pulse, could the TPS61161 misinterpret the init=
ial
PWM signal as a 1-wire EasyScale command and disable PWM control, preventing
the backlight from turning on properly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783749722.gi=
t.hns@goldelico.com?part=3D15
