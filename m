Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07249C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6675410E052;
	Thu,  9 Jul 2026 10:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LxvZSRo6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A3F10E1B3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:20:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B4226001A;
 Thu,  9 Jul 2026 10:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545EC1F000E9;
 Thu,  9 Jul 2026 10:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783592415;
 bh=Giyh/AYMD+/0jexkX4BgpX9MB8bptuUkeWgajJRS1WM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LxvZSRo6SJxYFP2AGx4F6wIXyUJY/IxNO6nEAIM3tx7a3Y5vBeGzosA6XkNGHxF1P
 RzSePcKT9wwTeUXCGXRlh7BifDfVyZj/n5hlowxzmlIvXxpCaOuegcu8G5LCbz2fwb
 FTJuPwxaRLCulGpZlW0WRPWd2xORKeoPX8qVzB3uTHi8missalB4i7u4BAXtBBQw0M
 mH04NsBILh5Fs9BcFdbNFHo9sBPG+V7+DY0Knmldr2TRnF4SA1BjGR4sr7i/JXJFR2
 7/Etk9DZ4HbyM0/ZXfeEBLMa+FqYH485tY6gNtfbTo8v0pVdMe/8jtGNclXGk4pwy2
 Lc5+rD7YBcuxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/11] drm/mediatek: mtk_dp: Fix hdmi codec and phy
 driver unregistration
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260709100617.42583-4-angelogioacchino.delregno@collabora.com>
References: <20260709100617.42583-1-angelogioacchino.delregno@collabora.com>
 <20260709100617.42583-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:20:13 +0000
Message-Id: <20260709102014.545EC1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Wrong device pointer passed to devm_add_action_or_reset() for the =
audio codec platform device causes a leak and double-free.
- [High] Manual platform_device_unregister() calls in the devm_add_action_o=
r_reset() error paths lead to double unregistrations.
--

--- Patch [3]: [PATCH v2 03/11] drm/mediatek: mtk_dp: Fix hdmi codec and ph=
y driver unregistration ---
commit ec9d95ddc19e68c697bea7b649dc680e85f406a8
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dp: Fix hdmi codec and phy driver unregistration

This commit attempts to fix platform device leaks during probe deferrals
by adding devm_add_action_or_reset() calls to automatically unregister
the HDMI codec and DisplayPort PHY platform devices.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index eefbc7e0f9c8d..2c738c16dafab 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c

[ ... ]

> @@ -2680,18 +2687,29 @@ static int mtk_dp_register_audio_driver(struct de=
vice *dev)
>  		.data =3D mtk_dp,
>  		.no_capture_mute =3D 1,
>  	};
> +	int ret;
> =20
>  	mtk_dp->audio_pdev =3D platform_device_register_data(dev,
>  							   HDMI_CODEC_DRV_NAME,
>  							   PLATFORM_DEVID_AUTO,
>  							   &codec_data,
>  							   sizeof(codec_data));
> -	return PTR_ERR_OR_ZERO(mtk_dp->audio_pdev);
> +	if (IS_ERR(mtk_dp->audio_pdev))
> +		return PTR_ERR(mtk_dp->audio_pdev);
> +
> +	ret =3D devm_add_action_or_reset(dev, mtk_dp_unregister_pdevs, mtk_dp->=
phy_dev);
                                                                     ^^^^^^=
^^^^^^^^^

[Severity: High]
Should this be passing mtk_dp->audio_pdev instead of mtk_dp->phy_dev?

Passing mtk_dp->phy_dev here registers a second unregister action for the p=
hy
device, which could lead to a double-free on driver unbind, while leaving
the audio device leaked.

> +	if (ret) {
> +		platform_device_unregister(mtk_dp->audio_pdev);

[Severity: High]
Will this cause a double unregistration if devm_add_action_or_reset() fails?

Since devm_add_action_or_reset() automatically executes the action callback
(mtk_dp_unregister_pdevs) upon failure, wouldn't calling
platform_device_unregister() here unregister it a second time?

> +		return dev_err_probe(dev, ret,
> +				     "Failed to add codec unregister devm action");
> +	}
> +	return 0;
>  }
> =20
>  static int mtk_dp_register_phy(struct mtk_dp *mtk_dp)
>  {
>  	struct device *dev =3D mtk_dp->dev;
> +	int ret;
> =20
>  	mtk_dp->phy_dev =3D platform_device_register_data(dev, "mediatek-dp-phy=
",
>  							PLATFORM_DEVID_AUTO,
> @@ -2701,6 +2719,13 @@ static int mtk_dp_register_phy(struct mtk_dp *mtk_=
dp)
>  		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy_dev),
>  				     "Failed to create device mediatek-dp-phy\n");
> =20
> +	ret =3D devm_add_action_or_reset(dev, mtk_dp_unregister_pdevs, mtk_dp->=
phy_dev);
> +	if (ret) {
> +		platform_device_unregister(mtk_dp->phy_dev);

[Severity: High]
Similarly, does this result in a double unregistration if the devm action
fails to allocate?

devm_add_action_or_reset() will call mtk_dp_unregister_pdevs(mtk_dp->phy_de=
v)
internally if it returns an error, making this manual unregister redundant =
and
potentially unsafe.

> +		return dev_err_probe(dev, ret,
> +				     "Failed to add phy unregister devm action");
> +	}
> +
>  	mtk_dp_get_calibration_data(mtk_dp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709100617.4258=
3-1-angelogioacchino.delregno@collabora.com?part=3D3
