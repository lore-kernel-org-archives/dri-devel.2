Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D86C61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE6610F2E1;
	Fri, 28 Aug 2026 08:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TwLGKKRY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B11610F2E1
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 08:41:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EC3024147B;
 Fri, 28 Aug 2026 08:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C131F000E9;
 Fri, 28 Aug 2026 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787906503;
 bh=BIO3Wa/VXLO0wchwyep2Wc2FjbQqVlEf3xEI2dENRaY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TwLGKKRY5mxGPLenv3JEwdroZ51LFqSSWGNQAP3eYXPLQvViXtwgcgMHdQ9vtfehr
 bN4VIqGgkryUlm/7KeaShI8VFPa3dDZmJGirdiXEEBAlcW6Pp9b0LkA5RLHdvxLfXt
 vdkDSVdpBxOYVS914QQOX8Zsd+TGPPZLGXdoZayaos6v0BbZi9+CH4LtI7nhHlMUfn
 RJ0oSVa+nA1kRywEEyhk020CmT6FbXvvjJrmVz9mOMelkZy6mDCA8HAzjwYWy30rnr
 tFvANwRGbF7L+NUjLvySgkE//vkIwSLZMPyTVFJPVy4GJ9tcpFj1Ewj7KQqRuvodjY
 ypEWjgwApBWdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: bridge: adv7511: Stop power-on after cache sync
 failure
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828082935.82266-1-pengpeng@iscas.ac.cn>
References: <20260828082935.82266-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 08:41:43 +0000
Message-Id: <20260828084143.A5C131F000E9@smtp.kernel.org>
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
- [Medium] The error path in adv7511_power_on() performs an incomplete roll=
back of the hardware state compared to the standard power-off sequence.
--

commit 978a99aaf2683acfac949339d63b25eabfcf6074
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm: bridge: adv7511: Stop power-on after cache sync failure

This commit updates adv7511_power_on() to handle register cache sync failur=
es.
Instead of ignoring the failure, it attempts to roll back the power state,
marks the cache as dirty, and returns the error to prevent hotplug and
atomic-enable paths from continuing with incomplete hardware state.

> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index 038b852405b54..c57c566cf0ad6 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
[ ... ]
> @@ -341,18 +341,31 @@ static void __adv7511_power_on(struct adv7511 *adv7=
511)
>  				   ADV7511_REG_POWER2_HPD_SRC_NONE);
>  }
> =20
> -static void adv7511_power_on(struct adv7511 *adv7511)
> +static int adv7511_power_on(struct adv7511 *adv7511)
>  {
> +	int ret;
>  	__adv7511_power_on(adv7511);
> =20
>  	/*
>  	 * Most of the registers are reset during power down or when HPD is low.
>  	 */
> -	regcache_sync(adv7511->regmap);
> +	ret =3D regcache_sync(adv7511->regmap);
> +	if (ret) {
> +		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
> +				   ADV7511_POWER_POWER_DOWN,
> +				   ADV7511_POWER_POWER_DOWN);
> +		regcache_mark_dirty(adv7511->regmap);

[Severity: Medium]
Does this error path perform an incomplete rollback compared to the standard
power-off sequence?

When __adv7511_power_off() is called, it explicitly disables the HPD overri=
de
and DDC error interrupts in addition to setting the power down bit:

static void __adv7511_power_off(struct adv7511 *adv7511)
{
	if (adv7511->info->hpd_override_enable)
		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER2,
				   ADV7535_REG_POWER2_HPD_OVERRIDE, 0);

	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
			   ADV7511_POWER_POWER_DOWN,
			   ADV7511_POWER_POWER_DOWN);
	regmap_update_bits(adv7511->regmap,
			   ADV7511_REG_INT_ENABLE(1),
			   ADV7511_INT1_DDC_ERROR, 0);
	regcache_mark_dirty(adv7511->regmap);
}

Since __adv7511_power_on() enables these bits, open-coding the rollback here
without disabling ADV7511_INT1_DDC_ERROR and ADV7535_REG_POWER2_HPD_OVERRIDE
might leave the device in an inconsistent hardware state and lead to spurio=
us
interrupts or incorrect HPD state while purportedly powered down.

Could this error path call __adv7511_power_off() directly, or include the
same bit clearing logic?

> +		adv7511->powered =3D false;
> +		dev_err(&adv7511->i2c_main->dev,
> +			"failed to sync register cache: %d\n", ret);
> +		return ret;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828082935.8226=
6-1-pengpeng@iscas.ac.cn?part=3D1
