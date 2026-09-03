Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C11DC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B7410F4AB;
	Thu,  3 Sep 2026 09:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CMPY8yma";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A46510F4AB
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:45:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4155D600C8;
 Thu,  3 Sep 2026 09:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E1D1F000E9;
 Thu,  3 Sep 2026 09:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788428739;
 bh=SGBgeoUf7GloQG9Y21fgZWD3ewtQFgAe1fhkHKrdPN0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CMPY8ymahjIxxVPBbvRPsiP0CBXTZFvIsRooFxE9OzvNtdzJDSXi5K5P3g59THtPW
 cVENVVnOZmAmukhdm/3bk6n4hVj3STdj4rwEfxxZwQlo5bgZVW7RHxnDqiG0wFE8rP
 mMcMh0d7MV2WFlTZEGYZMwUd94ytx23Zr8zBx7p8I4dCylRvZ7OSOXHKP+Emi7/00G
 Lziyf3rLYAJOjYAnhw1WmKPwHFvAQd5ccLDpkNIoMqZulRpcu+Qet4Ff//KbQKrj8h
 YasH4tvGDBHbAZ2C12Eem7vBDmRmSoAqd8ZtmjbJYVRgnPs85hAGcZB7jJFIxqnkd5
 V7xZBbimvKTHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ASoC: ti: omap-hdmi: Fix build error from a merge commit
To: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903-omap-hdmi-fix-v1-1-b0447a1d35d5@ideasonboard.com>
References: <20260903-omap-hdmi-fix-v1-1-b0447a1d35d5@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 09:45:38 +0000
Message-Id: <20260903094538.C0E1D1F000E9@smtp.kernel.org>
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
- [High] Incorrect devres device used for component and PCM registration ca=
using use-after-free on driver unbind.
--

commit d20d30b72e20d6e45546f7cb8a33e56c5ed791b9
Author: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

ASoC: ti: omap-hdmi: Fix build error from a merge commit
   =20
This commit removes an invalid assignment to a deleted member 'card' in the
hdmi_audio_data structure to fix a build error caused by an incorrect merge.

Closes: https://lore.kernel.org/all/apbbvQSfUbzYRFaw@sirena.org.uk/

> diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
> index c32ec7c0b0cf5..2cabd4cc5b0bd 100644
> --- a/sound/soc/ti/omap-hdmi.c
> +++ b/sound/soc/ti/omap-hdmi.c
> @@ -405,7 +405,6 @@ static int omap_hdmi_audio_probe(struct platform_devi=
ce *pdev)
>  	card->dev =3D dev;
> =20
>  	atomic_set(&ad->jack_state, -1);
> -	ad->card =3D card;

[Severity: High]
This isn't a bug introduced by this patch, but earlier in this function,
component and PCM devres registration are attached to the parent device
(ad->dssdev) instead of the child platform device (dev):

	ret =3D devm_snd_soc_register_component(ad->dssdev, &omap_hdmi_component,
					 dai_drv, 1);
	...
	ret =3D sdma_pcm_platform_register(ad->dssdev, "audio_tx", NULL);

Could this cause a use-after-free on child driver unbind?

If the omap-hdmi-audio driver is manually unbound via sysfs or its module
is unloaded, the child device's devres hooks execute and memory allocated
for the child (including the hdmi_audio_data struct ad) is freed.

Because devm_snd_soc_register_component() and sdma_pcm_platform_register()
were called using the parent device (ad->dssdev), their devres cleanup
hooks remain attached to the parent and do not execute during child unbind.

Does this leave the ASoC core with dangling pointers to the unloaded module=
's
static component structures and freed data?

> =20
>  	snd_soc_card_set_drvdata(card, ad);
>  	ret =3D devm_snd_soc_register_card(dev, card);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-omap-hdmi-=
fix-v1-1-b0447a1d35d5@ideasonboard.com?part=3D1
