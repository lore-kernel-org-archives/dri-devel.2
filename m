Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6E8C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C24E10F34F;
	Fri, 24 Jul 2026 10:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c974r5Dk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF5310F34F
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 10:24:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0484D600AA;
 Fri, 24 Jul 2026 10:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF731F000E9;
 Fri, 24 Jul 2026 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784888672;
 bh=FDERCKr0uap56WThdPTp3Nj4DCI51vDUy9QhoxLJhqI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c974r5DkgwWMMnaYoY2dBnvreCQrcP4GaGRWz7CCQXQMUScmOi/kPooGQuEAhN67d
 LQhsE3BSL+mO5rOF5mRGtMvxzYq0gJCTJ4g0g5doVi9YyL4CCHP2BjmqjeVB+axEk9
 ROargY+qkWsK5MDY2hpaBVATeEMWwEMf2Ot5X8Q3UEPqv9Zsd9dl/xOrGQ3HpCWder
 cg10wnxiCv5N3dlhYYaAUOe9/oc0dLm3bhxajBFAZO0Hgc8kXGmt/z8HyzyayiECMb
 caZCk/lfBbFy3V1iC03yG+HT5h9WAvdVyKQzY3BFBf7+TBoyimQ8NgCFABK5FE0RFx
 8HVHI16esXcHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: adv7511: handle regcache_sync() failure
 on power on
To: phucduc.bui@gmail.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724100803.50169-2-phucduc.bui@gmail.com>
References: <20260724100803.50169-1-phucduc.bui@gmail.com>
 <20260724100803.50169-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:24:31 +0000
Message-Id: <20260724102432.7CF731F000E9@smtp.kernel.org>
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
- [High] Incomplete error handling in `adv7511_power_on()` leaves state out=
 of sync

Pre-existing issues:
- [High] Missing `cancel_work_sync()` in removal path causes Use-After-Free
- [Low] I2C device ID array uses positional initializers
--

--- Patch [2]: [PATCH 2/2] drm/bridge: adv7511: handle regcache_sync() fail=
ure on power on ---
commit 5725e03d2519d4fb324dba03e70e2f0824a5bd67
Author: bui duc phuc <phucduc.bui@gmail.com>

drm/bridge: adv7511: handle regcache_sync() failure on power on

The commit adds error handling for regcache_sync() in adv7511_power_on().
If it fails, it logs an error and attempts to power off the chip.

> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index db55423781ea9..452180a95c384 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -367,12 +367,20 @@ static void __adv7511_power_on(struct adv7511 *adv7=
511)
> =20
>  static void adv7511_power_on(struct adv7511 *adv7511)
>  {
> +	int ret;
> +
>  	__adv7511_power_on(adv7511);
> =20
>  	/*
>  	 * Most of the registers are reset during power down or when HPD is low.
>  	 */
> -	regcache_sync(adv7511->regmap);
> +	ret =3D regcache_sync(adv7511->regmap);
> +	if (ret) {
> +		dev_err(&adv7511->i2c_main->dev,
> +			"Failed to sync register cache: %d\n", ret);
> +		__adv7511_power_off(adv7511);
> +		return;
> +	}

[Severity: High]
Does this early return leave the hardware state out of sync?

If adv7511_power_on() is called when the device was already logically
powered, this early return bypasses setting adv7511->powered =3D false and
skips calling adv7533_dsi_power_off().

Could this leave the DSI hardware powered on while the software state
remains powered =3D=3D true, causing subsequent EDID reads to fail because
they see powered =3D=3D true and attempt to read from a chip where the
rest of the components are powered off?

> =20
>  	if (adv7511->info->has_dsi)
>  		adv7533_dsi_power_on(adv7511);

While reviewing this, I noticed a pre-existing issue in the removal path:

> static void adv7511_remove(struct i2c_client *i2c)
> {
> 	struct adv7511 *adv7511 =3D i2c_get_clientdata(i2c);

[Severity: High]
This isn't a bug introduced by this patch, but does this function need to
cancel the hotplug work item?

If a hotplug interrupt fires and schedules adv7511->hpd_work just before or
during adv7511_remove(), the work could run after the memory is freed by
devres, resulting in a use-after-free.

Would adding cancel_work_sync(&adv7511->hpd_work) here prevent this?

I also noticed another pre-existing issue in the I2C device ID array:

> static const struct i2c_device_id adv7511_i2c_ids[] =3D {
> 	{ "adv7511", (kernel_ulong_t)&adv7511_chip_info },
> 	{ "adv7511w", (kernel_ulong_t)&adv7511_chip_info },

[Severity: Low]
This is a pre-existing issue, but the I2C subsystem guidelines state that
initialized arrays of type struct i2c_device_id must use named initializers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724100803.5016=
9-1-phucduc.bui@gmail.com?part=3D2
