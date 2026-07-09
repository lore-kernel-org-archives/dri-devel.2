Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C617C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA4610F055;
	Thu,  9 Jul 2026 10:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kmB/dkru";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6779D10F055
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:55:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 04A83413DA;
 Thu,  9 Jul 2026 10:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9096C1F000E9;
 Thu,  9 Jul 2026 10:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783594558;
 bh=2X1PitPO16swJpGXR4Ylf1gJYaJBEkZV8itpiOkhNzo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kmB/dkruhVSAUuWPuT4Hniwf/0abzRlbQcvrB2+eOVOyKOBCs0VVOFoWhdNA6TjRs
 BpWZpfnuGnFiJfRkCU3uqNwZs4+zRj9UH4nh64mWxkm8zrQOPO+L/wfRMxOWkg6EHa
 hYp+vVjbix2596fhNAZo2SABfZZiOWHmMnOD4ps1FQ9Yqfs+nxkVsMzURIwkGVwgyt
 wzZ5WwMFtjrtsD+JmA1xWKphevZ0IY1bGoJ5AU/7WjN64NXOfxtXTz4GcQmd3DHhht
 JvZA7MXhtsPLF8KPPgq2j5GRUg4lvodDNubaD5tPek64NIZV4nbwjQ1lcjsXjSTVKG
 sTsmFYgAWS/PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/11] drm/mediatek: mtk_dp: Add support for PHY from
 devicetree
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260709103431.46616-8-angelogioacchino.delregno@collabora.com>
References: <20260709103431.46616-1-angelogioacchino.delregno@collabora.com>
 <20260709103431.46616-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:55:57 +0000
Message-Id: <20260709105558.9096C1F000E9@smtp.kernel.org>
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
- [High] Double unregister of the PHY platform device in the error path of =
`mtk_dp_register_phy()`.
- [High] `phy_power_on()` is called before `phy_init()` during eDP probe on=
 new devicetrees.
--

--- Patch [7]: [PATCH v3 07/11] drm/mediatek: mtk_dp: Add support for PHY f=
rom devicetree ---
commit 325a8fa9ebb5392753c0df0c9aa94be702f67e6e
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dp: Add support for PHY from devicetree

This commit adds support for passing a displayport PHY handle from the
devicetree. It introduces a check for the phys property to support newer
configurations while maintaining legacy fallback behavior.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index b4cb1996a3314..cabfc833c0a80 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c

[ ... ]

> @@ -2754,6 +2775,7 @@ static int mtk_dp_register_phy(struct mtk_dp *mtk_d=
p)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to add phy unregister devm action");
> =20
> +	/* PHY calibration data is in mtk_dp only for legacy devicetree */
>  	mtk_dp_get_calibration_data(mtk_dp);
> =20
>  	mtk_dp->phy =3D devm_phy_get(&mtk_dp->phy_dev->dev, "dp");

[Severity: High]
Could this error path trigger a double-free of the PHY platform device?

In mtk_dp_register_phy(), we register a devres action to unregister the
platform device via mtk_dp_unregister_pdevs(). If devm_phy_get() fails
and we return an error (like -EPROBE_DEFER), the explicit call to
platform_device_unregister() in the error path will free the device. When
the devres cleanup runs later, it will execute mtk_dp_unregister_pdevs()
and call platform_device_unregister() a second time on the same pointer.

[ ... ]

> @@ -2857,9 +2884,18 @@ static int mtk_dp_probe(struct platform_device *pd=
ev)
>  					     "Failed to register audio driver\n");
>  	}
> =20
> -	ret =3D mtk_dp_register_phy(mtk_dp);
> -	if (ret)
> -		return ret;
> +	if (!mtk_dp->legacy_regoff) {
> +		mtk_dp->phy =3D devm_phy_get(dev, NULL);
> +		if (IS_ERR(mtk_dp->phy))
> +			return dev_err_probe(dev, PTR_ERR(mtk_dp->phy),
> +					     "Failed to get phy\n");
> +
> +		mtk_dp->phy_dev =3D NULL;

[Severity: High]
Are we calling phy_power_on() before phy_init() for eDP displays on new
devicetrees?

During mtk_dp_probe() for eDP connectors, the driver calls
mtk_dp_power_enable() to read the EDID before the bridge is attached.
With the new PHY model, this executes phy_power_on(mtk_dp->phy):

mtk_dp_probe()
  mtk_dp_power_enable()
    phy_power_on(mtk_dp->phy);

However, phy_init() is not called until mtk_dp_bridge_attach() via
mtk_dp_poweron(). Violating the PHY API contract by powering on before
initialization can cause hardware initialization failures, as clocks
or regulators managed by phy_init() are not yet enabled.

> +	} else {
> +		ret =3D mtk_dp_register_phy(mtk_dp);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	mtk_dp->bridge.of_node =3D dev->of_node;
>  	mtk_dp->bridge.type =3D mtk_dp->data->bridge_type;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709103431.4661=
6-1-angelogioacchino.delregno@collabora.com?part=3D7
