Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D739606A68B
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgxgwg3W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D310B10EE39;
	Tue, 24 Nov 2026 07:36:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D4310EE4B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:36:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C95C61CF8;
 Tue, 24 Nov 2026 07:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB04C1F000D0;
 Tue, 24 Nov 2026 07:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795505806;
 bh=UkC6d8LQvYCXp6JvOpSE1KNiAQORA3CVE3wuU2r+r8c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jgxgwg3Wu5m7//WOYuhcwg2+XPfay2l5D2YNixMJofy+oN4XjJMw7IMrCRx0lZdHP
 qfaHm+EN5uu74F4/OTuScHePTRzZ0cEUeoFOB3Rq8q4+O4oAlWkwJRJEHU7iTQ6xv8
 wwqWjKdLplKfra5JEkODdWFfX7LkshqU+UOPpXF7bbb6ZZKAJ3Kb3oADfW+SVa2c2E
 vqhoB3HB8ZMN0USP317bU3RppYCchCMyL86P3UIUGSM52IwoD/78Av/5mQl+e7S4ZQ
 8UA92xxVMNKIDUECS4mJ+cSng+XWJp0ZEjJvYYOjCua9Kk7beJ6ZdjN+JWsaorCAym
 1N8Gc2+CJqOnQ==
Message-ID: <sashiko-outbox-230649@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/20] backlight: pwm: Support enable guard period
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <54477b4e31e35af14677172088f94770ca5b9755.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <54477b4e31e35af14677172088f94770ca5b9755.1795505160.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:36:45 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] backlight: pwm_bl: guard period runs before
  pwm_backlight_power_on()
- [Medium] backlight: pwm_bl: guard pulse triggers before
  compute_duty_cycle()
- [Medium] backlight: pwm_bl: unchecked post-guard
  pwm_apply_might_sleep()
- [Low] backlight: pwm_bl: unused linux/minmax.h include added
--

commit e05803a769b6dbbf7722b07888a63c3cd2737641
Author: H. Nikolaus Schaller <hns@goldelico.com>

backlight: pwm: Support enable guard period

This commit adds support for a pwm-enable-guard-period-us device tree
property to apply a full duty cycle for a guard interval when enabling the
PWM from a disabled or zero-duty state.

Link: https://patchwork.kernel.org/project/linux-omap/patch/f897f695c0e1e12=
8d7ebb41be8dfdce4d634f552.1783749722.git.hns@goldelico.com/#27124981

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 3ad71ee3657af..1d0a463710926 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/minmax.h>

[Severity: Low]
This isn't a bug, but linux/minmax.h does not appear to be used by anything
in this change.

[ ... ]

> @@ -93,11 +98,39 @@ static int pwm_backlight_update_status(struct backlig=
ht_device *bl)
>  	struct pwm_bl_data *pb =3D bl_get_data(bl);
>  	int brightness =3D backlight_get_brightness(bl);
>  	struct pwm_state state;
> +	int ret;
> =20
>  	if (pb->notify)
>  		brightness =3D pb->notify(pb->dev, brightness);
> =20
>  	if (brightness > 0) {
> +		pwm_get_state(pb->pwm, &state);
> +
> +		/*
> +		 * Some LED drivers detect a one-wire control mode during
> +		 * a startup window (e.g. TI TPS61160/TPS61161, using
> +		 * the duration of low intervals on CTRL). Request full
> +		 * duty for the guard interval before normal dimming.
> +		 * The PWM provider may approximate full duty.
> +		 *
> +		 * Apply the guard if the previous PWM state was disabled
> +		 * or had zero duty cycle.
> +		 */
> +		if (pb->enable_guard_period_us &&
> +		    (!state.enabled || !state.duty_cycle)) {
> +			struct pwm_state guard =3D state;
> +
> +			guard.duty_cycle =3D guard.period;
> +			guard.enabled =3D true;
> +			ret =3D pwm_apply_might_sleep(pb->pwm, &guard);
> +			if (ret)
> +				return ret;
> +
> +			usleep_range(pb->enable_guard_period_us,
> +				     pb->enable_guard_period_us +
> +				     PWM_BL_GUARD_SLACK_US);
> +		}

[Severity: Medium]
Does checking brightness > 0 before calling compute_duty_cycle() cause a
full-brightness flash when a non-zero brightness level maps to a duty cycle
of 0?

When pb->lth_brightness is 0 and a low non-zero brightness index maps to 0
in pb->levels[] (or truncates to 0 in compute_duty_cycle()), the guard block
drives the PWM at 100% duty cycle for pb->enable_guard_period_us before
programming state.duty_cycle =3D 0.  Because state.duty_cycle remains 0,
subsequent updates at low brightness repeat the full-duty flash and delay.
In addition, if the target duty cycle is already equal to state.period,
the guard block sleeps and then applies the same full duty cycle a second
time.

> +
>  		pwm_get_state(pb->pwm, &state);
>  		state.duty_cycle =3D compute_duty_cycle(pb, brightness, &state);
>  		state.enabled =3D true;

[Severity: Medium]
Does running the guard interval before pwm_backlight_power_on(pb) leave the
LED driver unpowered or disabled while the guard pulse is on the line?

drivers/video/backlight/pwm_bl.c:pwm_backlight_update_status() {
    ...
		pwm_get_state(pb->pwm, &state);
		state.duty_cycle =3D compute_duty_cycle(pb, brightness, &state);
		state.enabled =3D true;
		pwm_apply_might_sleep(pb->pwm, &state);

		pwm_backlight_power_on(pb);
    ...
}

When a board also uses power-supply or enable-gpios, the full-duty guard
waveform and its usleep_range() delay finish and the PWM is already switched
to the dimmed duty cycle before pwm_backlight_power_on() enables
pb->power_supply or asserts pb->enable_gpio.  The LED driver IC powers up
only after normal PWM dimming has begun, bypassing the startup guard window.

[Severity: Medium]
What happens if the guard pwm_apply_might_sleep() succeeds, but the post-gu=
ard
pwm_apply_might_sleep() that sets the dimmed duty cycle fails?

Because the second call's return value is ignored, a transient failure on
that update leaves the PWM hardware running at 100% duty cycle from the
guard step while pwm_backlight_power_on() turns the backlight on and
pwm_backlight_update_status() returns 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795505160.gi=
t.hns@goldelico.com?part=3D11
