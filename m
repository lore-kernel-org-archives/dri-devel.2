Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FC4C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7580210EF80;
	Wed,  1 Jul 2026 12:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GtV9vcWe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F6710EF80
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:32:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C9696001D;
 Wed,  1 Jul 2026 12:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264E41F000E9;
 Wed,  1 Jul 2026 12:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782909178;
 bh=8Wqg6vwaB2WZcRomvBZS2whfJdMLY3bMu1eEIH5uhrc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GtV9vcWeJa0Nq6CgkhRbuoYd0UToILJgOt6KFUCQXj249tPrBcwd0SVv6ZIFmXNab
 OHydU4ZvDxmvOCYo+qlP2hTrkFAmJHIWcCSn8rOaJKBIDslsFYgCcuY5U3t/g9rPYq
 5lIqyvlPsC/BsbLnStMYX4OnCSfWh9iuUy4mp1g/4OjKhapzhQ3YXFFnRIytikXIuD
 UGGYsLwrsEGCvR/Mwgo0H4eX0QWLlP9goTLkbzKuLjbQhzUIv6vvHhsEzXAG/T5EK4
 zjrBX6h9Ss+dAfqXybFL4cu/58vg9zq3UG2R3FfzA8Ploqoqd5hcf3CyHLMXYxEzue
 WuktBJtzqUW/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] drm/mediatek: mtk_dp: Fix hdmi codec and phy
 driver unregistration
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260701122024.19557-4-angelogioacchino.delregno@collabora.com>
References: <20260701122024.19557-1-angelogioacchino.delregno@collabora.com>
 <20260701122024.19557-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:32:57 +0000
Message-Id: <20260701123258.264E41F000E9@smtp.kernel.org>
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
- [High] Double unregister of platform device in error paths causes Use-Aft=
er-Free
- [Medium] Incorrect pointer passed to devm_add_action_or_reset causes reso=
urce leak of audio platform device
--

commit 2bc8391d481088826fa13d96d05225e5c15e6457
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dp: Fix hdmi codec and phy driver unregistration

This commit introduces devm actions to unregister the HDMI Codec and
DisplayPort PHY platform devices, preventing multiple instantiations
during probe deferrals.

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

[Severity: Medium]
Is the correct platform device pointer being passed here?

This registers a cleanup action using mtk_dp->phy_dev rather than the
newly created mtk_dp->audio_pdev. This will likely leak the audio device on
probe deferral or driver unbind, and may attempt to unregister the PHY devi=
ce
at the wrong time instead.

> +	if (ret) {
> +		platform_device_unregister(mtk_dp->audio_pdev);
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
Could this cause a use-after-free?

When devm_add_action_or_reset() fails, it automatically executes the cleanup
action, which calls platform_device_unregister() on mtk_dp->phy_dev. Calling
platform_device_unregister() a second time here would double-free the devic=
e.

> +		return dev_err_probe(dev, ret,
> +				     "Failed to add phy unregister devm action");
> +	}
> +
>  	mtk_dp_get_calibration_data(mtk_dp);
> =20
>  	mtk_dp->phy =3D devm_phy_get(&mtk_dp->phy_dev->dev, "dp");

[Severity: High]
Can the error path for devm_phy_get() also trigger a double-free?

Looking at the rest of mtk_dp_register_phy() just below this diff:

mtk_dp_register_phy() {
    ...
    mtk_dp->phy =3D devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
    if (IS_ERR(mtk_dp->phy)) {
        platform_device_unregister(mtk_dp->phy_dev);
        return dev_err_probe(dev, PTR_ERR(mtk_dp->phy), "Failed to get phy\=
n");
    }
    ...
}

Since the devm unregister action was successfully registered above, returni=
ng
an error here will trigger the devm unwind loop. That will unregister the
device a second time after this explicit platform_device_unregister() call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122024.1955=
7-1-angelogioacchino.delregno@collabora.com?part=3D3
