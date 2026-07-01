Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7A7C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2630910E030;
	Wed,  1 Jul 2026 13:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kPSPwYxV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B76BE10E030
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 13:49:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12A856001D;
 Wed,  1 Jul 2026 13:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D08A1F000E9;
 Wed,  1 Jul 2026 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782913772;
 bh=X17R3fADM3REFIkxJd7QQUnqt3Ov70i0cJIuCYLwm6c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kPSPwYxVkXIA7n7RSBKTgZqpkB7lfg9VzwIOSo5mH1cyJ1462loZRHot960N2qLqM
 10mXai7o7Zh54aAYxM5qyeuYkhw706TFWZZJISgkD49EwOY7Mp4Im8WN26MWCXX2gb
 ng38PzqyiCqGkkcdMCgS3G2xAbxwy7iwRV0MgTls4BUSxOmTZBzs00qhVz8l0MNGb9
 W7jine1MtU5h5M3jA/zPfSoL3TIfJdBuriRLE05HN8N/VuLT7f3VWCd7r8ip1f7NdI
 O76vICJva7w5OiVAuXvgUVIrP12GraBVylndylgybm1abISOjzUGjFx2uzTsk3N+vZ
 gGX9eHkNG6MQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] backlight: aw99706: Fix DT property names to match
 binding
To: "Junjie Cao" <junjie.cao@linux.dev>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260701133918.33487-1-junjie.cao@linux.dev>
References: <20260701133918.33487-1-junjie.cao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:49:32 +0000
Message-Id: <20260701134932.7D08A1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The driver attempts to communicate with the chip via I2C before ac=
quiring and enabling the hardware via its enable GPIO.
--

commit a2f8eb8bf399f54262cbf37acb4512885c65a3b6
Author: Junjie Cao <junjie.cao@linux.dev>

backlight: aw99706: Fix DT property names to match binding

The driver reads four tuning properties without the unit suffixes that
the binding mandates. As a result, device_property_read_u32() never finds
these properties in a binding-conformant device tree and silently falls back
to the compiled-in defaults. This patch fixes the property name strings in
aw99706_dt_props[] to match the binding.

> diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/=
aw99706.c
> index 18299faf06ad4..e130f164303a2 100644
> --- a/drivers/video/backlight/aw99706.c
> +++ b/drivers/video/backlight/aw99706.c
> @@ -130,23 +130,23 @@ static const struct aw99706_dt_prop aw99706_dt_prop=
s[] =3D {

[ ... ]

This is a pre-existing issue, but I noticed something concerning in the
initialization sequence within aw99706_probe() in the same file:

drivers/video/backlight/aw99706.c:aw99706_probe() {
    ...
	ret =3D aw99706_chip_id_read(aw);
	if (ret !=3D AW99706_ID)
		return dev_err_probe(dev, -ENODEV,
				     "Unknown chip id 0x%02x\n", ret);

	aw99706_dt_parse(aw, &props);

	aw->hwen_gpio =3D devm_gpiod_get(aw->dev, "enable", GPIOD_OUT_LOW);
	if (IS_ERR(aw->hwen_gpio))
		return dev_err_probe(dev, PTR_ERR(aw->hwen_gpio),
				     "Failed to get enable gpio\n");

	ret =3D aw99706_hw_init(aw);
    ...
}

[Severity: High]
Does this sequence result in unconditional probe failure on platforms where=
 the
bootloader does not pre-enable the backlight hardware?

The driver attempts to communicate with the chip via I2C during
aw99706_chip_id_read() before the hardware enable GPIO is acquired and
asserted in aw99706_hw_init().

Because the hardware is likely powered down when aw99706_chip_id_read() is
called, it will not acknowledge the I2C transaction and will return an erro=
r.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701133918.3348=
7-1-junjie.cao@linux.dev?part=3D1
