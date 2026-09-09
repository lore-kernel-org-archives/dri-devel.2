Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575AAC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D45D10F16D;
	Wed,  9 Sep 2026 13:38:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DqOKe6PS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EBF810F16D
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:38:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 38898418B4;
 Wed,  9 Sep 2026 13:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523701F00A3A;
 Wed,  9 Sep 2026 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788961132;
 bh=HGGR++Bxj12lmQW85xJhvJa3QTXaJAiswbiR+ZJCm7k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DqOKe6PS9CHLaioeKIf0kkI8CL/v6bN1wYR6BU4santnzUIBKfwXf4PwVg+RjF7ZY
 QolWZxjJqf1RFBcMadN0tWoD5Ea8qp4Kq6fqc4dwE/inetf+cm2itcwzEpVmHyH/sd
 eUbIDlPlstfxupEVtzHwAnfY/FCohMnDvv0m0ZFP5s1CrDNcUH7hG5h2QpcSW7fk+p
 uOfi8yCSYPqOLEPriIDj5bXIPqCpKxrNsp0Vitrs5L091NL3zX0/BpJcCEjFFAz985
 vqzo7mHWcs6UwlILreuIxpKM7EGP7gUKZnRsxrzYdOMjF7M8MRb5pHWs2lspapcl/F
 caGns+iPpykZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/14] mfd: remove unused si476x driver
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org,
 dmitry.torokhov@gmail.com, lee@kernel.org, linux-input@vger.kernel.org,
 mfd@lists.linux.dev, media-ci@linuxtv.org, robh@kernel.org,
 linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260909132153.1596191-4-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-4-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:38:50 +0000
Message-Id: <20260909133851.523701F00A3A@smtp.kernel.org>
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
- [Low] The device tree binding 'fsl,imx-audio-si476x' is left orphaned in =
the fsl-asoc-card.yaml binding document.
--

commit d07c2cc9eb18a826ae9829a06854385c1084b44d
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused si476x driver
   =20
This commit removes the unused si476x driver, which was originally added
without devicetree support. It drops the MFD core, radio, and ASoC codec
drivers, along with cleaning up the corresponding build rules and the
fsl-asoc-card matching table.

> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 310ee4c282a1c..ff8ae6e514ea4 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c

[ ... ]

> @@ -1398,7 +1391,6 @@ static const struct of_device_id fsl_asoc_card_dt_i=
ds[] =3D {
>  	{ .compatible =3D "fsl,imx-audio-wm8960",         .data =3D &fsl_asoc_w=
m8960_pdata },
>  	{ .compatible =3D "fsl,imx-audio-mqs",            .data =3D &fsl_asoc_m=
qs_pdata },
>  	{ .compatible =3D "fsl,imx-audio-wm8524",         .data =3D &fsl_asoc_w=
m8524_pdata },
> -	{ .compatible =3D "fsl,imx-audio-si476x",         .data =3D &fsl_asoc_s=
i476x_pdata },
>  	{ .compatible =3D "fsl,imx-audio-wm8958",         .data =3D &fsl_asoc_w=
m8958_pdata },
>  	{ .compatible =3D "fsl,imx-audio-nau8822",        .data =3D &fsl_asoc_n=
au8822_pdata },
>  	{ .compatible =3D "fsl,imx-audio-wm8904",         .data =3D &fsl_asoc_w=
m8904_pdata },

[Severity: Low]
Since this patch removes the fsl,imx-audio-si476x compatible string from the
fsl_asoc_card_dt_ids matching table, should the devicetree bindings
documentation in Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
also be updated to remove the orphaned fsl,imx-audio-si476x entry?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D3
