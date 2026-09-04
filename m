Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3873BC624DB
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 02:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AA510E1D8;
	Fri,  4 Sep 2026 02:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VMgUHii4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E115A10E1D8
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 02:00:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 868F140812;
 Fri,  4 Sep 2026 02:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406BD1F000E9;
 Fri,  4 Sep 2026 02:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788487243;
 bh=IhS0uYh78jAMwSian29c9dLjVg8kKauhzNm+tKZ21LY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VMgUHii4SsB7ZXiIQJqRXlMxub3lkVCp/6Dp2yzLX5pNkQ7l3wOcACBthHTQDzoKP
 ySgcEmsUpzlK/gS1E8CLW5Mo8Cc5MuN/0LSNTK/AJhVi09+BKbynyrPhUpf6rHqKhl
 BnVP9mi8Ah5aLlyUSeG2ZyzIW0jFmvyakZQp4kOyQEIv8DT55WIos8TRcoZkJ3GAPd
 NplumJTE24kxetCnLTct/2V8DnSZtnxFKBIwPyOiJN9vPX8C52H1cHv5D6l0wb56UX
 1hKy+hNh6PImr7EnrTMcZR9ddmI+PWeWyFNHPKLEK6LzIH0RNHfuZKZSBS1K2bsfCC
 NrftMnktDOdXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/bridge: samsung-dsim: fix TE GPIO lifetime for
 host attach
To: "Li Youhong" <dayou5941@163.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904014958.1572918-1-dayou5941@163.com>
References: <20260904014958.1572918-1-dayou5941@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 02:00:42 +0000
Message-Id: <20260904020043.406BD1F000E9@smtp.kernel.org>
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
- [High] dsi->te_gpio is not cleared to NULL after being freed via gpiod_pu=
t() or after an ERR_PTR assignment. This leaves a dangling pointer that can=
 lead to Use-After-Free and Double-Free bugs on subsequent attach/detach cy=
cles or IRQ enable/disable operations.
--

commit ae0d9af500f3fda4ddfaac130c60cd01aa1ce58f
Author: Li Youhong <liyouhong@kylinos.cn>
Subject: drm/bridge: samsung-dsim: fix TE GPIO lifetime for host attach

This commit switches the TE GPIO acquisition back from
devm_gpiod_get_optional() to gpiod_get_optional() to fix a lifetime issue on
host detach/reattach. It keeps explicit gpiod_put() calls on the error path
and in samsung_dsim_unregister_te_irq().

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index e2fc69fc51b60..8f3fd50e52f80 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1862,7 +1862,8 @@ static int samsung_dsim_register_te_irq(struct sams=
ung_dsim *dsi, struct device
>  	int te_gpio_irq;
>  	int ret;
> =20
> -	dsi->te_gpio =3D devm_gpiod_get_optional(dev, "te", GPIOD_IN);
> +	/* Released on host detach; do not use the managed get. */
> +	dsi->te_gpio =3D gpiod_get_optional(dev, "te", GPIOD_IN);
>  	if (!dsi->te_gpio)
>  		return 0;
>  	else if (IS_ERR(dsi->te_gpio))

[Severity: High]
This is a pre-existing issue, but is it possible we are leaving a dangling
pointer in dsi->te_gpio here?

If gpiod_get_optional() fails, dsi->te_gpio is assigned an error pointer and
the function returns early, leaving the error pointer exposed in the dsi
struct. If a video-mode panel is later attached and samsung_dsim_enable_irq=
()
is called, could this lead to an invalid memory access when it operates on =
the
error pointer?

There appear to be similar pre-existing issues where dsi->te_gpio isn't
cleared to NULL after being freed. For example, further down in the error
handling of samsung_dsim_register_te_irq():

	if (ret) {
		dev_err(dsi->dev, "request interrupt failed with %d\n", ret);
		gpiod_put(dsi->te_gpio);
		return ret;
	}

And in samsung_dsim_unregister_te_irq():

	if (dsi->te_gpio) {
		free_irq(gpiod_to_irq(dsi->te_gpio), dsi);
		gpiod_put(dsi->te_gpio);
	}

Since this patch addresses detach/reattach cycles where the device isn't
destroyed, if we switch from a command-mode panel to a video-mode panel,
could these dangling pointers lead to a use-after-free or double-free on a
subsequent cycle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904014958.1572=
918-1-dayou5941@163.com?part=3D1
