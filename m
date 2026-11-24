Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E7606A330
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iD6FMO50
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D2710EE62;
	Tue, 24 Nov 2026 07:37:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 086A310EE63
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:37:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 810F361537;
 Tue, 24 Nov 2026 07:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5004C1F000CF;
 Tue, 24 Nov 2026 07:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795505845;
 bh=CXYUU2uRuU2m1NOGcdl2MUJjIMsS4b/pKjOrCLsrDwA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iD6FMO503IqpZs1HdOiQHrLcUQqiXIqTT4CbBWe85OfpPSHssW53Apu2ssoM3ey4V
 rCu3iTGzrq5NOYMevRPD1fXvgbx+enCWqzAmNsnas/9etTPz4ooX940yTehaF0XYhD
 JYCSBNxt8Py4cfxl+gHnZP+vZeiebaHqP1jgHEGYbM4Zg/K5XMJBa561PDPYhm9EaO
 CXFFFNBufRe59YXeY7i6Gqjjqocshh8Lqkjkil9JjUy0bxbonvVGM2YNLQxwa+LYGY
 UVNO7HShgLTrKKn1atiUG+snvjrhYbpYA59mBbuh7igXQFb7cyVWvPSotETeQtmBYx
 RdbC3dANTDt9A==
Message-ID: <sashiko-outbox-230650@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/20] pwm: twl: Support 64-cycle PWM frame
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <59fa3a5ee1a0d0bf13c85c08160c5acdaa95b7a4.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <59fa3a5ee1a0d0bf13c85c08160c5acdaa95b7a4.1795505160.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:37:24 +0000
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
- [High] pwm: twl: 64-cycle mode in twl_pwm_config() scales and clamps
  to 127 not 63
--

commit 9c38629d98d044b0860bfc5ea8bf71a8a5b8a626
Author: H. Nikolaus Schaller <hns@goldelico.com>

pwm: twl: Support 64-cycle PWM frame

This commit adds support for the ti,twl4030-pwm-frame-64 device tree
property to select a 64-clock-cycle PWM frame on TWL4030.

> diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
> index 99c1caf4f19c8..70567d5805f43 100644
> --- a/drivers/pwm/pwm-twl.c
> +++ b/drivers/pwm/pwm-twl.c
[ ... ]
> @@ -56,13 +60,35 @@ static inline struct twl_pwm_chip *to_twl(struct pwm_=
chip *chip)
>  	return pwmchip_get_drvdata(chip);
>  }
> =20
> +/*
> + * Note: this hardware (and driver) does not honor arbitrary periods.
> + * Only the duty ratio is implemented; the frame length is either
> + * 128 clock cycles (default) or - if selected through device tree -
> + * 64 clock cycles. Consumers requiring an accurate period must verify
> + * the actually provided period.
> + */
>  static int twl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			  u64 duty_ns, u64 period_ns)
>  {
> +	struct twl_pwm_chip *twl =3D to_twl(chip);
>  	int duty_cycle =3D DIV64_U64_ROUND_UP(duty_ns * TWL_PWM_MAX, period_ns)=
 + 1;
> +	bool frame_64 =3D twl_class_is_4030() && twl->twl4030_frame_64;
>  	u8 pwm_config[2] =3D { 1, 0 };
>  	int base, ret;
> =20
> +	if (frame_64)
> +		pwm_config[0] |=3D TWL4030_PWM_ON_FRAME_64;
> +
> +	/*
> +	 * In the 64-cycle frame the OFF counter wraps at 64. A requested
> +	 * duty_cycle of 64 (full duty) would therefore wrap to a constant
> +	 * high output. Saturate to the largest value that still produces
> +	 * a low pulse (OFF =3D 63, approximately 62/64 high) instead.
> +	 * This also applies to full-duty requests from PWM consumers.
> +	 */
> +	if (frame_64 && duty_cycle > TWL_PWM_MAX)
> +		duty_cycle =3D TWL_PWM_MAX;

[Severity: High]
Does twl_pwm_config() scale and clamp duty_cycle against 127 instead of 63
when frame_64 is enabled?

TWL_PWM_MAX is defined as 0x7f (127), which is the counter limit for the
128-cycle frame.  In 64-cycle mode, scaling duty_ns by TWL_PWM_MAX and
clamping to TWL_PWM_MAX produces pwm_config[1] values up to 127 rather
than 63.  As a result, the 6-bit OFF counter wraps around at roughly 50%
requested duty cycle (reaching OFF =3D 64 -> 0 and OFF =3D 65 -> 1, which
matches ON =3D 1 for constant high output) and repeats the duty ramp a
second time across the upper half of the range.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795505160.gi=
t.hns@goldelico.com?part=3D9
