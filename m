Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F1EC531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 03:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7516D10F4C9;
	Sat, 25 Jul 2026 03:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hRAg+xb1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E343D10F4C9
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:18:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F7F64038B;
 Sat, 25 Jul 2026 03:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D9A1F000E9;
 Sat, 25 Jul 2026 03:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784949480;
 bh=XZar44MkxYatYAARV70UkTG/EWuR4iE7twsMWzPxu0U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hRAg+xb1M30dvWZmvIB2C292Apa90lH31gT+VJWqMZmUlUgHO7Q5uVrt/cPiRjTN8
 eya5Fycj89gG16Ow9ACVPBStKx3qIesFtFVbvuTQPgDrYu0oTrRejAjhYcOs4Wm9N2
 kgOeUDMdYbw2AWy9zYGU0QC85PlKrYc5wsQzcd7NmpViMCIV01kNUoDD2tKSuKCeON
 eySH1Khzv81CB2JtbTXN8FDc/QGxNMF1Lz9iBQ+2eeZ0JanFfgCsL6WxGhOnpKmMEd
 4/e2BthGKAhd/mwvRf+rviJ51ltRVP2GJ5h18ysflYOrQFOOagj82dOeWiYwocE3/j
 02t989QX0pZcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/13] drm/bridge: it6505: complete poweroff even if
 disabling regulators fails
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <a5b76e4b0c348dc19595d918a14867b785e8af07.1784947240.git.daniel@makrotopia.org>
References: <cover.1784947240.git.daniel@makrotopia.org>
 <a5b76e4b0c348dc19595d918a14867b785e8af07.1784947240.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 03:17:59 +0000
Message-Id: <20260725031800.62D9A1F000E9@smtp.kernel.org>
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

New issues:
- [Low] Missing newline (`\n`) in the newly added `dev_err` format strings.

Pre-existing issues:
- [High] The interrupt handler does not check the return value of `it6505_r=
ead()` for error codes, causing spurious interrupt triggers.
- [High] The power-off sequence disables the IVDD (`pwr18`) regulator befor=
e the OVDD (`ovdd`) regulator, violating the reverse-order power-down requi=
rement.
--

--- Patch [4]: [PATCH v6 04/13] drm/bridge: it6505: complete poweroff even =
if disabling regulators fails ---
commit 1009be5a50c31876cc2fed6f2166f7843b4776a3
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: complete poweroff even if disabling regulators fails
   =20
it6505_poweroff() returns early when regulator_disable() fails,
leaving it6505->powered set with the IRQ already disabled. The next
it6505_poweron() then takes its early return and never re-enables the
IRQ, leaving the bridge deaf to hotplug and link training interrupts.
The regulator core keeps the consumer's enable count on a failed
disable either way, so bailing out only adds a wedged bridge on top of
the leaked reference. Log the error and complete the power-off state
transition instead.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index c10cc6a786b5d..fb6030a2c18cb 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2811,13 +2811,15 @@ static int it6505_poweroff(struct it6505 *it6505)
>  	if (pdata->pwr18) {
>  		err =3D regulator_disable(pdata->pwr18);

[Severity: High]
This isn't a bug introduced by this patch, but does this power-off sequence
violate the reverse-order power-down requirement?

The it6505_poweron() function explicitly enforces pwr18 -> ovdd ordering,
but this disables the core voltage (IVDD/pwr18) before the IO voltage
(OVDD/ovdd).

Could this forward order create reverse current paths through ESD diodes,
leading to hardware latch-up or degradation?

Should we disable ovdd before pwr18 here?

>  		if (err)
> -			return err;
> +			dev_err(dev, "cannot disable pwr18 regulator: %d",
> +				err);

[Severity: Low]
Is this missing a trailing newline?

Without a \n in the format string, subsequent kernel log messages from other
subsystems might be concatenated on the same line, resulting in mangled
dmesg output.

>  	}
> =20
>  	if (pdata->ovdd) {
>  		err =3D regulator_disable(pdata->ovdd);
>  		if (err)
> -			return err;
> +			dev_err(dev, "cannot disable ovdd regulator: %d",
> +				err);

[Severity: Low]
Does this dev_err() also need a trailing newline?

>  	}
> =20
>  	it6505->powered =3D false;

[Severity: High]
This is a pre-existing issue, but does it6505_int_threaded_handler() fail
to check it6505_read() for error codes?

If an I2C read fails due to a transient bus error or occurring during
power-down, it6505_read() returns a negative error code (e.g., -ENODEV).

This negative value is directly assigned to the int_status array:

drivers/gpu/drm/bridge/ite-it6505.c:it6505_int_threaded_handler() {
	int_status[0] =3D it6505_read(it6505, INT_STATUS_01);
	int_status[1] =3D it6505_read(it6505, INT_STATUS_02);
	int_status[2] =3D it6505_read(it6505, INT_STATUS_03);
...
}

In two's complement, negative values have many high bits set. This causes
it6505_test_bit() to incorrectly evaluate to true for multiple random
interrupts.

Could this lead to the spurious execution of handlers and writing back garb=
age
to the interrupt clear register?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784947240.gi=
t.daniel@makrotopia.org?part=3D4
