Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCECC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4DE610E070;
	Thu,  9 Jul 2026 10:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KtYb4snC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E6C10E070
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:46:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3778841632;
 Thu,  9 Jul 2026 10:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBE51F000E9;
 Thu,  9 Jul 2026 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783594011;
 bh=q7ScW9hJpjng45n+X/4/5Xe8MZhmqsiLLYoixjG84RQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KtYb4snCcoipava9zr2sU5riBZE5uo3l+Mk3D3Rs3/cVNfL014gOgtuPX147vNfwW
 VD740rriun0D23eoz5UE1sBlkBfnSxabqVk5Rn6VxMJX3bT1q/8CoSBBFQWyHmjs7G
 xpabMU5zhmk/XI8yFgfh5b57j2ycYRfSqQmCWsUzg/VbFx2XNWPJ5edCqZi4CKT0EO
 vGpb3/bT7ZxMb5KmU7PI2lSlpWjfPb5U+0lmOCNwFqBL7gtgVRs085QdXfah4p8te4
 L6Y80bEkCIx9dvbJDeaykCQVghEPTAKJqiLk0ebXPAnq4FYWTs5ZG7M9o27JcvKaLT
 ae6fkFdFOgVBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/11] drm/mediatek: mtk_dp: Fix hdmi codec and phy
 driver unregistration
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260709103431.46616-4-angelogioacchino.delregno@collabora.com>
References: <20260709103431.46616-1-angelogioacchino.delregno@collabora.com>
 <20260709103431.46616-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:46:50 +0000
Message-Id: <20260709104650.BFBE51F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Double free / use-after-free of mtk_dp->phy_dev on devm_phy_ge=
t error path.

Pre-existing issues:
- [High] Asynchronous pm_runtime_put() used immediately before pm_runtime_d=
isable() leaves hardware in incorrect power state.
--

--- Patch [3]: [PATCH v3 03/11] drm/mediatek: mtk_dp: Fix hdmi codec and ph=
y driver unregistration ---
commit ee2a644d342bfbaa916286b22d4e54ddc62e5878
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dp: Fix hdmi codec and phy driver unregistration

This commit adds devm actions to unregister the HDMI Codec and DisplayPort
PHY platform devices during probe. This prevents multiple instances of these
devices from being registered if the driver probe is deferred.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index eefbc7e0f9c8d..fefd1fae44c90 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
[ ... ]
> @@ -2701,6 +2718,11 @@ static int mtk_dp_register_phy(struct mtk_dp *mtk_=
dp)
>  		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy_dev),
>  				     "Failed to create device mediatek-dp-phy\n");
> =20
> +	ret =3D devm_add_action_or_reset(dev, mtk_dp_unregister_pdevs, mtk_dp->=
phy_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add phy unregister devm action");
> +
>  	mtk_dp_get_calibration_data(mtk_dp);
> =20
>  	mtk_dp->phy =3D devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
>  	if (IS_ERR(mtk_dp->phy)) {
>  		platform_device_unregister(mtk_dp->phy_dev);

[Severity: Critical]
Does this create a double-free on the error path?

Looking at mtk_dp_register_phy() in drivers/gpu/drm/mediatek/mtk_dp.c, if
devm_phy_get() fails (returning e.g. -EPROBE_DEFER), we manually call
platform_device_unregister() here.=20

However, since we successfully added the devm action earlier in the functio=
n,
returning the error from probe will cause the devres unwind mechanism to
execute mtk_dp_unregister_pdevs().

Won't that call platform_device_unregister() a second time on the already-f=
reed
mtk_dp->phy_dev pointer, resulting in memory corruption?

[ ... ]
> @@ -2870,9 +2892,6 @@ static void mtk_dp_remove(struct platform_device *p=
dev)
>  	struct mtk_dp *mtk_dp =3D platform_get_drvdata(pdev);
> =20
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to call
pm_runtime_put() immediately before pm_runtime_disable() here in
mtk_dp_remove()?

Since pm_runtime_put() queues an asynchronous suspend, calling
pm_runtime_disable() right after it cancels the pending suspend work.

Doesn't this leave the hardware in an active power state after the driver is
removed? Should this be changed to pm_runtime_put_sync() to ensure the susp=
end
completes before module unload?

>  	if (mtk_dp->data->bridge_type !=3D DRM_MODE_CONNECTOR_eDP)
>  		timer_delete_sync(&mtk_dp->debounce_timer);
> -	platform_device_unregister(mtk_dp->phy_dev);
> -	if (mtk_dp->audio_pdev)
> -		platform_device_unregister(mtk_dp->audio_pdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709103431.4661=
6-1-angelogioacchino.delregno@collabora.com?part=3D3
