Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613D8C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D6A10E42E;
	Wed, 12 Aug 2026 19:34:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zp6jMCjo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E1E10E42E
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:34:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 828AB43C22;
 Wed, 12 Aug 2026 19:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002A61F000E9;
 Wed, 12 Aug 2026 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786563297;
 bh=Znip7PbFf8GCT5Ebsj+IbmijdxxMfPwHMItRzdNAU1M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zp6jMCjoPk6NDMRrV8qM15JmirRV0v6aZC+FW+alrZfQpM6VyBzbUgI5u0LD26/xS
 aytTfL+v5DwGgOSX80ZuVdX8vH24xOaxekvKKK0LfGv/iT+EvIeeyPolAZC1kAlyad
 sam4fCF9MTi6Touo2wKBjpF7hiah11LTW5mnQTvNKp7yAZoz+xYDjNowCTFPmVcoK5
 hUBxo+a/ybkpbSeSvUa/qwpGHGc/PibAOp2jvd69A5O0n68NlmjYwwr7yVIdfswLUo
 YjhatFgSIqF+sXaYGAEf1bW6PSHGytB2RE+xGJVYOEj5g45P9V89/ZTl14Isf7yQme
 36XqGC0ANOhFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] backlight: Add support for Orient Chip OCP8178
To: "Wim de With" <wf@dewith.io>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, lee@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
 <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 19:34:56 +0000
Message-Id: <20260812193457.002A61F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The driver fails to re-initialize the 1-Wire mode after a power lo=
ss (e.g., during suspend), leaving the device stuck in PWM mode.
- [Medium] Lack of atomicity and timing validation across the 2-byte 1-Wire=
 transaction can cause silent brightness update failures due to preemption.
--

--- Patch [2]: [PATCH v2 2/2] backlight: Add support for Orient Chip OCP817=
8 ---
commit 11ca2bd66a2c85f8bb56c8b3475708379c8ddf5e
Author: Wim de With <wf@dewith.io>

backlight: Add support for Orient Chip OCP8178

Add a driver for the Orient Chip OCP8178 backlight controller.
The OCP8178 supports either PWM or a vendor-specific onewire protocol
over GPIO.

> diff --git a/drivers/video/backlight/ocp8178_bl.c b/drivers/video/backlig=
ht/ocp8178_bl.c
> new file mode 100644
> index 0000000000000..bc48636ef64e4
> --- /dev/null
> +++ b/drivers/video/backlight/ocp8178_bl.c
[ ... ]
> +static void ocp8178_bl_set_brightness(struct ocp8178_bl *ocp8178, u8 bri=
ghtness)
> +{
> +	u8 data =3D 0;
> +
> +	/*
> +	 * We cannot set RFA (request for acknowledge) unless the GPIO pin is
> +	 * configured as open drain.
> +	 */
> +	data |=3D FIELD_PREP(OCP8178_DATA_RFA, 0);
> +	data |=3D FIELD_PREP(OCP8178_DATA_ADDR, 0);
> +	data |=3D FIELD_PREP(OCP8178_DATA_VALUE, brightness);
> +
> +	ocp8178_bl_write_u8(ocp8178, OCP8178_DEVICE_ADDRESS);
> +	ocp8178_bl_write_u8(ocp8178, data);

[Severity: Medium]
Can a preemption or interrupt between these two byte writes delay the second
byte and violate the 1-Wire protocol timing?

The initialization sequence ocp8178_bl_enable_onewire() explicitly checks
duration >=3D OCP8178_1W_T_WIN_NS to verify that timing wasn't ruined by
preemption. However, in ocp8178_bl_set_brightness(), if the thread is preem=
pted
between the two ocp8178_bl_write_u8() calls, the GPIO line is left idle HIG=
H.

Would this cause the hardware's 1-Wire state machine to time out and treat =
the
subsequent data byte as a new command, resulting in a silently lost brightn=
ess
update since the driver doesn't read an ACK?

> +}
[ ... ]
> +static const struct backlight_ops ocp8178_bl_ops =3D {
> +	.options =3D BL_CORE_SUSPENDRESUME,
> +	.update_status =3D ocp8178_bl_update_status,
> +};
[ ... ]
> +static struct platform_driver ocp8178_bl_driver =3D {
> +	.driver =3D {
> +		.name =3D "ocp8178-bl",
> +		.of_match_table =3D ocp8178_bl_of_match,
> +	},
> +	.probe =3D ocp8178_bl_probe,
> +};

[Severity: High]
Does this driver need a resume PM hook to re-initialize the 1-Wire mode?

The BL_CORE_SUSPENDRESUME option causes the backlight core to call
update_status() on resume. Since power to the chip may be cut during suspen=
d,
the device defaults to PWM mode upon power-on.

Without a resume hook in the platform driver to call
ocp8178_bl_enable_onewire(), the chip will misinterpret the 1-Wire brightne=
ss
data as a PWM signal. This leaves the GPIO HIGH at the end of the transacti=
on,
which translates to 100% brightness in PWM mode.

> +module_platform_driver(ocp8178_bl_driver);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-ocp8178-ba=
cklight-v2-0-4ad18b48bef8@dewith.io?part=3D2
