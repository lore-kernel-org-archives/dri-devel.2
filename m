Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C123CCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BB710E8AA;
	Mon, 19 Oct 2026 09:04:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2BF10E8AA
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:04:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5DD3640575;
 Mon, 19 Oct 2026 09:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C681F000C4;
 Mon, 19 Oct 2026 09:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792400668;
 bh=lqCAzwWkRjrKhDAqs7327yN7M41kUJgY3fMm1oVtl9s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X68MiJT3kEBdigJZY+/bM8qcZ90r+8Chv8EURyLAtQc5GoXcPKaqijryNER0PGv5w
 2aM1gQOUdbDJqSrl41wuY7+S9I3rxOuHUtG4foDyqPi1+zPZT7Ol66LoXbDD4Rzfd/
 4F6oHIAkdBhB0jRftXZgw/9OEvkLEheD79GO6n5fB0fqw8kphSno0A4Fb0Dcxh556W
 oGGDI5Py5aCmsLo+umQwgXrjL9vGb3oqjW+Ylik8w334QVZBuy5HGRDWtoQ+JcuPfw
 /K86RpYMmNXHpnBgibyRNSfxwd7y9ArkGzYDrOc5Q3Sv7DhrZGYMCBB99sEwxdRP4P
 SplbRGy7qOY8g==
Message-ID: <sashiko-outbox-176864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/14] drm/bridge: analogix_dp: Check all negative
 return values for &analogix_dp_device.irq
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019085836.3065008-3-damon.ding@rock-chips.com>
References: <20261019085836.3065008-1-damon.ding@rock-chips.com>
 <20261019085836.3065008-3-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:04:27 +0000
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
- [High] drm/bridge: analogix_dp: unsigned dp->irq < 0 check in analogix_dp=
_probe()
--

commit fcbed20d54db2072c70e2845510fbc672a7f0240
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Check all negative return values for &analogix_dp_=
device.irq

This commit updates analogix_dp_probe() to check for any negative return
value in dp->irq rather than only -ENXIO, and propagates the error code
instead of returning -ENODEV.

Link: https://lore.kernel.org/all/20260804083307.84ECA1F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 079f2f01f33b0..27c9a764e25fa 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1480,9 +1480,9 @@ analogix_dp_probe(struct device *dev, struct analog=
ix_dp_plat_data *plat_data)
>  		irq_flags =3D IRQF_NO_AUTOEN;
>  	}
> =20
> -	if (dp->irq =3D=3D -ENXIO) {
> +	if (dp->irq < 0) {
>  		dev_err(&pdev->dev, "failed to get irq\n");
> -		return ERR_PTR(-ENODEV);
> +		return ERR_PTR(dp->irq);
>  	}
> =20
>  	ret =3D devm_request_threaded_irq(&pdev->dev, dp->irq,

[Severity: High]
Can dp->irq < 0 ever be true here? In struct analogix_dp_device in
drivers/gpu/drm/bridge/analogix/analogix_dp_core.h, irq is declared as
unsigned int:

struct analogix_dp_device {
	...
	struct clk		*clock;
	unsigned int		irq;
	void __iomem		*reg_base;

When gpiod_to_irq() or platform_get_irq() returns a negative error code
(such as -EPROBE_DEFER, -ENOENT, or -ENXIO) in analogix_dp_probe(), the
value is stored in the unsigned dp->irq field.

Because dp->irq is unsigned, the dp->irq < 0 comparison is always false.
All negative error codes bypass this check and are passed as large
unsigned values to devm_request_threaded_irq(), which fails with -EINVAL
instead of propagating the original error code (breaking probe deferral).
Additionally, on 64-bit systems, passing an unsigned int to ERR_PTR()
zero-extends it to long rather than sign-extending it.

Would it make sense to change irq to int in struct analogix_dp_device, or
assign the return value of gpiod_to_irq() and platform_get_irq() to ret
first and check ret < 0 before storing it in dp->irq?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019085836.3065=
008-1-damon.ding@rock-chips.com?part=3D2
