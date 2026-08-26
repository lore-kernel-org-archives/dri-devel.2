Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525D1C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA6510EC35;
	Wed, 26 Aug 2026 07:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bL4HkCy3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8760710EC22
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:44:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 910DE6020E;
 Wed, 26 Aug 2026 07:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64F41F000E9;
 Wed, 26 Aug 2026 07:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787730250;
 bh=8h6GdzRVA5R3G8aDu7rOguV+18CCfp1t2RwEklME0RU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bL4HkCy3hgKo/ndTfZUfTP0B/xRZZG1CK/kIRWsKXu7LKIyfRmBdFXxwWSlUON+NJ
 VEI71dOnNmjiy5DXWrjV4XKTugwyznAcOlzLqsaokSGxV5018gqAIr1DQuJoa7fNUc
 U4rAaUh+U1M8Z78V+2hO5YNcjAgDr2d1nMKktaJMNYmoe9y1lnCI8ag89rFTXQJxqY
 shDtvOHGxXyAuqfzcYeBwf4KMPCyYh08fkO6ql4vpB/8u3vo2MxvKyaKnrbmELUYGQ
 Q+T9BSpkbfo53N2YrhnCBYo11E7dc8xuS10Xt1ElOCmIHKygVQZ540FKE6SpDWZjGJ
 UDtOCjOoAPLVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] backlight: Add support for Orient Chip OCP8178
To: "Wim de With" <wf@dewith.io>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org,
 robh@kernel.org, linux-leds@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260826-ocp8178-backlight-v4-2-47d7acce882e@dewith.io>
References: <20260826-ocp8178-backlight-v4-0-47d7acce882e@dewith.io>
 <20260826-ocp8178-backlight-v4-2-47d7acce882e@dewith.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 07:44:09 +0000
Message-Id: <20260826074409.D64F41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing 1-wire initialization on system resume leaves the device u=
nresponsive or at maximum brightness.
- [High] Software bitbanging timings are too tight and will likely violate =
protocol requirements due to execution overhead.
- [High] Calling gpiod_set_value() with hardware interrupts disabled causes=
 a sleeping-in-atomic bug on PREEMPT_RT kernels.
- [Medium] Preemption during onewire initialization can cause silent failur=
e.
- [Low] Using dev_err() for expected, retryable preemption events will spam=
 the kernel log.
--

commit 999030427b1d2e4a9b850939beacde4b60c21042
Author: Wim de With <wf@dewith.io>

backlight: Add support for Orient Chip OCP8178

This patch introduces a new backlight driver for the Orient Chip OCP8178.
It implements a vendor-specific onewire protocol over GPIO to set static
brightness levels without requiring a continuous PWM signal.

> diff --git a/drivers/video/backlight/ocp8178_bl.c b/drivers/video/backlig=
ht/ocp8178_bl.c
> new file mode 100644
> index 0000000000000..6c1e8c9451f12
> --- /dev/null
> +++ b/drivers/video/backlight/ocp8178_bl.c

[ ... ]

> +static int ocp8178_bl_enable_onewire(struct ocp8178_bl *ocp8178)
> +{
> +	u64 start, duration;
> +
> +	gpiod_set_value(ocp8178->gpiod, 0);
> +	fsleep(OCP8178_T_OFF_US);
> +
> +	start =3D ktime_get_ns();
> +
> +	gpiod_set_value(ocp8178->gpiod, 1);
> +	udelay(OCP8178_1W_T_DELAY_US);
> +	gpiod_set_value(ocp8178->gpiod, 0);
> +	udelay(OCP8178_1W_T_DETECT_US);

[Severity: Medium]
Since this precise timing pulse is generated without preemption or IRQ
protection, could an interrupt stretch the 110us pulse?

If it stretches to 300us, the total duration (300 + 270 =3D 570us) still pa=
sses
the 1ms check below, but the malformed timing causes the hardware to reject
the switch to 1-wire mode, leading to a silent failure.

> +	gpiod_set_value(ocp8178->gpiod, 1);
> +
> +	duration =3D ktime_get_ns() - start;
> +
> +	if (duration >=3D OCP8178_1W_T_WIN_NS) {
> +		dev_err(ocp8178->dev,
> +			"onewire detection window exceeded (%llu ns)\n",
> +			duration);

[Severity: Low]
Because initialization runs with interrupts enabled, transient preemption w=
ill
cause this window to exceed 1ms and return -EAGAIN for an automatic retry.
Will using dev_err() here cause unnecessary log spam on busy systems?

> +		return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ocp8178_bl_write_u8(struct ocp8178_bl *ocp8178, u8 value)
> +{
> +	unsigned long flags;
> +
> +	gpiod_set_value(ocp8178->gpiod, 1);
> +	udelay(OCP8178_1W_T_START_US);
> +
> +	local_irq_save(flags);
> +
> +	for (int i =3D 7; i >=3D 0; i--) {
> +		if ((value >> i) & 1) {
> +			gpiod_set_value(ocp8178->gpiod, 0);

[Severity: High]
Does calling gpiod_set_value() with hardware interrupts disabled cause a
sleeping-in-atomic bug on PREEMPT_RT kernels?

Memory-mapped GPIO drivers typically use spinlock_t to serialize register
accesses, which becomes a sleepable rt_mutex on PREEMPT_RT. Any userspace
write to the brightness sysfs node will trigger this execution path.

> +			udelay(OCP8178_1W_HIGH_BIT_T_LOW_US);
> +			gpiod_set_value(ocp8178->gpiod, 1);
> +			udelay(OCP8178_1W_HIGH_BIT_T_HIGH_US);
> +		} else {
> +			gpiod_set_value(ocp8178->gpiod, 0);
> +			udelay(OCP8178_1W_LOW_BIT_T_LOW_US);
> +			gpiod_set_value(ocp8178->gpiod, 1);
> +			udelay(OCP8178_1W_LOW_BIT_T_HIGH_US);

[Severity: High]
Are these software bitbanging timings too tight to satisfy the protocol?

The protocol requires T_LOW > 2 * T_HIGH for a low bit. The driver uses
udelay(2) for T_HIGH and udelay(5) for T_LOW. After udelay(2), the loop log=
ic
evaluates conditions and decrements variables before pulling the line LOW a=
gain.

This CPU overhead executes while the line remains HIGH, stretching T_HIGH by
1-2us, making 2 * T_HIGH (~6-8us) strictly greater than T_LOW (5us) and bre=
aking
the requirement.

> +		}
> +	}
> +
> +	gpiod_set_value(ocp8178->gpiod, 0);
> +	udelay(OCP8178_1W_T_EOS_US);
> +	gpiod_set_value(ocp8178->gpiod, 1);
> +
> +	local_irq_restore(flags);
> +}

[ ... ]

> +static const struct backlight_ops ocp8178_bl_ops =3D {
> +	.options =3D BL_CORE_SUSPENDRESUME,

[Severity: High]
Does using BL_CORE_SUSPENDRESUME leave the device unresponsive after a
system suspend?

If the system is suspended and power is cut to the chip, or the GPIO line
goes low for >2.5ms, the device resets to its default PWM mode. On resume,
the backlight core simply restores the brightness by calling
ocp8178_bl_update_status() without ensuring the hardware is in 1-Wire mode.

Because the driver relies on BL_CORE_SUSPENDRESUME and lacks device PM ops =
in
ocp8178_bl_driver, it fails to re-transmit the required enable_onewire sequ=
ence.

> +	.update_status =3D ocp8178_bl_update_status,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-ocp8178-ba=
cklight-v4-0-47d7acce882e@dewith.io?part=3D2
