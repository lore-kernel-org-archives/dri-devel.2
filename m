Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438B0C98332
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 13:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C4E910E1F4;
	Sat, 26 Sep 2026 13:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VV4Uqhwg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4E610E1F4
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 13:33:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 080D76020C;
 Sat, 26 Sep 2026 13:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717B91F000FF;
 Sat, 26 Sep 2026 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790429635;
 bh=f7zKPBnbUp6eUB/KEXui9d/UrTXlZyGna2N3UHmO1JU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VV4Uqhwg3goroXJnxSkntCl+TmsX91WAbIX36NP0HdAsMQqSpMWFeuVD/0l6lwyPe
 8DLlGyS1dPIeD6gS9Mxq2uLszlKaqoDG+RZtfUiXP6g3V4tQu0yRVK4Iu5Z+C2b+DD
 zNWeHwQIPTRjrjQkJ7FxFkVtciH4m/6gZeqIiqwAXuDjc6beCnLcDvFGVZPLodElLD
 bCxP+W08dYW3S/Cidgwhtv6Pi6hpsm5NHfyysFHWJsJAUU0gfBIghmPouRcPlFkFLE
 1s0RnnXPkZwccH/kjWQU4pTgZ2TBR8Dgo4Z4JVg4Nv/GMT8s9ucYnGPveH6APD+lEA
 h5G7/HSuWMfSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] fbdev: sh_mobile_lcdc: check for
 fb_deferred_io_init() error
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org
In-Reply-To: <20260926-fix-fbdefio-error-handling-v1-6-a94810b6e263@kernel.org>
References: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
 <20260926-fix-fbdefio-error-handling-v1-6-a94810b6e263@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 13:33:54 +0000
Message-Id: <20260926133355.717B91F000FF@smtp.kernel.org>
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
- [High] fbdev: sh_mobile_lcdc: clock leak on fb_deferred_io_init() failure
--

commit 5d69f4a8e3d4f95bd3f24c9c5188ad04101636e7
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

fbdev: sh_mobile_lcdc: check for fb_deferred_io_init() error

This commit updates sh_mobile_lcdc_start() to check the return value of
fb_deferred_io_init(). If it fails, info->fbdefio is cleared to prevent
sh_mobile_lcdc_stop() from cleaning up uninitialized deferred I/O state,
and the function returns the error.

> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev=
/sh_mobile_lcdcfb.c
> index e8324b01700f6..1409a5cc736b0 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -1042,7 +1042,11 @@ static int sh_mobile_lcdc_start(struct sh_mobile_l=
cdc_priv *priv)
>  			ch->defio.deferred_io =3D sh_mobile_lcdc_deferred_io;
>  			ch->defio.delay =3D msecs_to_jiffies(tmp);
>  			ch->info->fbdefio =3D &ch->defio;
> -			fb_deferred_io_init(ch->info);
> +			ret =3D fb_deferred_io_init(ch->info);
> +			if (ret) {
> +				ch->info->fbdefio =3D NULL;
> +				return ret;
> +			}

[Severity: High]
Does this early return bypass unwinding the clocks and stopping the hardwar=
e?

Earlier in sh_mobile_lcdc_start(), the clocks are enabled and the hardware =
is
started. When called via the FBIOPUT_VSCREENINFO ioctl through
sh_mobile_lcdc_set_par(), a failure here exits without disabling the clocks=
 or
stopping the hardware:

drivers/video/fbdev/sh_mobile_lcdcfb.c:sh_mobile_lcdc_set_par() {
    ...
	ret =3D sh_mobile_lcdc_start(ch->lcdc);
	if (ret < 0)
		dev_err(info->dev, "%s: unable to restart LCDC\n", __func__);
    ...
}

Additionally, in a multi-channel setup during probe, the failure on one
channel bypasses sh_mobile_lcdc_channel_fb_register(). This causes the error
handler sh_mobile_lcdc_stop() to explicitly call clk_on() for the successful
channel, creating an unmatched increment:

drivers/video/fbdev/sh_mobile_lcdcfb.c:sh_mobile_lcdc_stop() {
    ...
		if (ch->info && ch->info->fbdefio) {
			...
			sh_mobile_lcdc_clk_on(priv);
		}
    ...
}

Could this lead to a permanent leak of the hardware clock reference count
(priv->hw_usecnt) and leave the LCDC hardware running in an error state?

>  		}
> =20
>  		sh_mobile_lcdc_display_on(ch);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-fix-fbdefi=
o-error-handling-v1-0-a94810b6e263@kernel.org?part=3D6
