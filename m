Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB45606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kilomjC4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0693510EF3F;
	Tue, 24 Nov 2026 07:46:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E8CB10EF3F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:46:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7B6F62155;
 Tue, 24 Nov 2026 07:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA271F000C6;
 Tue, 24 Nov 2026 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795506373;
 bh=Q5Vta8rAhvDkLSxALDcCyn900snk6x75mfn3Y4bQoW8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kilomjC4L41ZysXLQdZ6Ob8t3LIflotve3/9dxCiJCpkSSluzmkXDEX5frYEFOLTN
 +m1w3zFEiaqcoQRVATrler6axkYCbmQJTAjrXQIEzLdwC4LkLnXChzshCjrDMryCpF
 uk8hyzEk4DLk3++mtiQRXM025hGGU+16b9i0R45I1Tr7FVD8iDoMe4S9IPgvdmKN7H
 IHix44RU3u+0NU5PrDggdWiR0xCJRz1rLS02L/l13DlfRkEuaHD8xqjIoRtca4NlUo
 H/5UhlXNxcyZbx46Jqnpyqi8blqcUXca7iNSoXHO8quXIONBlN0zQFVnl8xmk9Gmld
 ErdC7wp9JszZA==
Message-ID: <sashiko-outbox-230669@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/20] ARM: dts: omap3pandora: Switch backlight to PWM
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <40321eb9223453f39536092d7095d3eff9901188.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <40321eb9223453f39536092d7095d3eff9901188.1795505160.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:46:12 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] ARM: dts: omap3pandora: default brightness 11 overflows
  64-cycle TWL4030 PWM
- [Medium] ARM: dts: omap3pandora: PWM0 stays enabled and pulsing when
  brightness is 0
- [Low] ARM: dts: omap3pandora: non-generic node name pwm-backlight used
  for backlight
--

commit f1da995614fb9b1711442126ec6e32081ef0bd39
Author: H. Nikolaus Schaller <hns@goldelico.com>

ARM: dts: omap3pandora: Switch backlight to PWM

This commit adds a pwm-backlight devicetree node using TWL4030 PWM0 in
64-cycle mode and attaches it to the Pandora LCD node.

> diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/a=
rm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> index a5633d93547a3..6bdfbd80b9fcd 100644
> --- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
> @@ -53,6 +53,25 @@ lcd_5v: fixed-regulator-lcd-5v {
>  		vin-supply =3D <&aux_5v>; /* logical enable dependency */
>  	};
> =20
> +	backlight: pwm-backlight {

[Severity: Low]
This isn't a bug, but the Devicetree Specification and pwm-backlight
binding expect the generic node name "backlight" rather than
"pwm-backlight".

> +		compatible =3D "pwm-backlight";
> +		pwms =3D <&twl_pwm 0 1922710>;

[Severity: Medium]
Does this leave TWL4030 PWM0 enabled and pulsing when brightness is set to
0?

Because this node defines neither power-supply nor enable-gpios,
pwm_backlight_update_status() sets state.enabled =3D true even at brightness
0:

drivers/video/backlight/pwm_bl.c:pwm_backlight_update_status() {
	...
		pwm_get_state(pb->pwm, &state);
		state.duty_cycle =3D 0;
		state.enabled =3D !pb->power_supply && !pb->enable_gpio;
		pwm_apply_might_sleep(pb->pwm, &state);
	...
}

In twl_pwm_config(), duty_ns =3D 0 maps duty_cycle =3D 1 to 2 (ON =3D 1, OF=
F =3D
2), so twl4030_pwm_apply() keeps PWM0 and its clock enabled and drives a
continuous 1/64 pulse train on the TPS61161 CTRL pin instead of disabling
PWM0 to hold CTRL low as the legacy pandora_bl driver did.

> +		/*
> +		 * TPS61161 analog dimming window: duty must stay above
> +		 * ~20-25 % (below that the regulator drops out, LED off)
> +		 * and the startup waveform must avoid long low intervals
> +		 * that could trigger EasyScale detection. The enable guard
> +		 * requests full duty; TWL4030 limits it to about 62/64.
> +		 * These levels were determined experimentally.
> +		 */
> +		brightness-levels =3D <
> +			  0 24 30 36 42 49 58 68 80 94 110 129 255
> +		>;
> +		default-brightness-level =3D <11>;

[Severity: High]
Does default-brightness-level =3D <11> overflow the 64-cycle TWL4030 PWM
counter and turn the backlight off after the 10 ms startup guard?

The table maximum is 255, so index 11 (level 129) requests duty_ns =3D
(129 * 1922710) / 255 =3D 972665 ns (~50.6% of period_ns).  However,
twl_pwm_config() scales duty_ns by TWL_PWM_MAX (127) and clamps against
TWL_PWM_MAX even when frame_64 is enabled:

drivers/pwm/pwm-twl.c:twl_pwm_config() {
	int duty_cycle =3D DIV64_U64_ROUND_UP(duty_ns * TWL_PWM_MAX, period_ns) + =
1;
	...
	if (frame_64 && duty_cycle > TWL_PWM_MAX)
		duty_cycle =3D TWL_PWM_MAX;
}

For duty_ns =3D 972665 ns, duty_cycle is 65 + 1 =3D 66 (0x42), which is not
clamped and writes 66 to PWM0_OFF.  In 64-cycle mode the 6-bit counter
wraps 66 to OFF =3D 2 (with ON =3D 1), producing a 1/64 (1.56%) duty cycle
that falls below the TPS61161 ~20-25% dropout threshold.  In addition,
because levels 1..11 (24..129) sit on a 0..255 scale to compensate for the
127 multiplier in twl_pwm_config(), levels 1..4 request 9.4%..16.5% duty
cycles from pwm-backlight (below the ~20-25% TPS61161 threshold noted in
the comment), and both levels 11 (129) and 12 (255) exceed the 64-cycle
counter limit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795505160.gi=
t.hns@goldelico.com?part=3D18
