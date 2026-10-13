Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB1FCC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D90C10E105;
	Tue, 13 Oct 2026 18:18:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBEAE10F947
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:18:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCFCC43EAB;
 Tue, 13 Oct 2026 18:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396861F000FF;
 Tue, 13 Oct 2026 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791915496;
 bh=T0gTFaJO3iTsr8BCo3D5W+F7cIHHpVUmM2x3eJLdk70=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P22oiGL+O1fXooz80IOkVY1+jINJ1sMj6C6CdEBm02ZlSZomCtnSZx+LSxW/Fd6xc
 tQFyJZxggrb0h7+2172zrns9vy7ZHOqpL1wdG7B8jrxf1jB/d82Kl+/ayJELsu8yb/
 1vWySkJvlZesGSyTrKqlUgteyT18ToQAvknycVbhbtPROfe1hXPZCFS6L52RWZiQIP
 8jah1K9ScT/kkdjMAu6KdvagRKX/ybv1TnFPwNPaUjBTFeiMCGr4iJkc5nJcmp/UHs
 SPqkWKvscUGpjjLC3VQ5LGvkFSSyLonbNCC7jEVyAtMzstxM726EN9ehHjcTr1Wj0i
 SA9p7t+mJ4Rww==
Message-ID: <sashiko-outbox-170310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] mfd: aat2870: Add support for VIN and IN-LDO
 power supplies
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <20261013180933.487013-5-clamor95@gmail.com>
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-5-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:18:15 +0000
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
- [High] mfd: aat2870: Missing GPIO teardown causes backpowering risk
--

commit 878c16709c6ee44d1728f13a2ff6e9ad29023883
Author: Svyatoslav Ryhel <clamor95@gmail.com>

mfd: aat2870: Add support for VIN and IN-LDO power supplies

This commit adds support for retrieving and managing the VIN and IN-LDO
power supplies using the regulator framework to ensure proper power
supply dependencies and power-up sequencing.

> diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
> index 909c14ee60323..0bd430b90bc1b 100644
> --- a/drivers/mfd/aat2870-core.c
> +++ b/drivers/mfd/aat2870-core.c
[ ... ]
> @@ -309,6 +310,10 @@ static int aat2870_i2c_probe(struct i2c_client *clie=
nt)
> =20
>  	aat2870->reg_cache =3D aat2870_regs;
> =20
> +	ret =3D devm_regulator_get_enable(&client->dev, "vin");
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Failed to enable regulator\n"=
);
> +
>  	aat2870->en_pin =3D devm_gpiod_get_optional(&client->dev, "enable",
>  						  GPIOD_OUT_HIGH);

[Severity: High]
Does this unwinding order create a backpowering regression when the device
is removed?

Because the regulator is acquired before the GPIO, devres unwinds in reverse
order. It will release the GPIO descriptor first during device unbind (e.g.,
during parent I2C adapter removal), without actually driving the pin low.

After the GPIO descriptor is released, devm_regulator_get_enable() will
disable the vin regulator. This leaves the enable GPIO driven high into
the unpowered AAT2870 device.

Since aat2870_i2c_driver lacks a .remove callback to explicitly drive the
GPIO low before devres unwinds, could this backpowering state cause hardware
damage? Would it be safer to add a devm action or a .remove callback to pull
the enable pin low first?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013180933.4870=
13-1-clamor95@gmail.com?part=3D4
