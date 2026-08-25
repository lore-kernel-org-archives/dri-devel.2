Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED18C61CE2
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3199E10E9C2;
	Tue, 25 Aug 2026 10:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TUsHG3iq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C8910E9C2
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 10:20:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 243F96011F;
 Tue, 25 Aug 2026 10:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37C41F000E9;
 Tue, 25 Aug 2026 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787653208;
 bh=Gu55QArcsWkPYuH5BBASS35a+MN2cPs2dur4kYahtaM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TUsHG3iqv/WX6us9BqBQa3FFNkjzn6rOnSq8V5Ck3LA3rPnHwZPn3spVEwpNCNSk+
 IKGrDB8FhXeH4HA0OokVTjmsQcwUA7FSKs9IBcxkSqNco/yhyx3JvowNwx55iox5Ml
 9vsHyg/LU/liPtnJynJrbrCmJLAMHsepCNIRCQODVtAhONFh0bHcPGSb7kI9pdnSc2
 CqcmAilz7FJwDw42mGq60VwJfrVqhiLli/qJ6iKEYhiSlDgwgT3ANftmS70EcvzbHr
 dGEZ0+sDHNr+chELI96F36MLcr4r+4eHG8Us3AxedqBRyemWrZPDKzOKcx1FyosPMF
 1St2tStPAn5JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/mediatek: Add missing IS_ERR check for
 ovl_adaptor  platform device
To: "Haojie Li" <lihaojie@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260825100845.438893-1-lihaojie@kylinos.cn>
References: <7a3cbf55bf6a97835ee426eb38c34b2c153437eb.camel@mediatek.com>
 <20260825100845.438893-1-lihaojie@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:20:08 +0000
Message-Id: <20260825102008.A37C41F000E9@smtp.kernel.org>
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
- [High] platform_device_register_data() is incorrectly used to create a sh=
allow kmemdup copy of a 'struct device' object by value instead of passing =
a pointer.
--

--- Patch [1]: [PATCH v2] drm/mediatek: Add missing IS_ERR check for ovl_ad=
aptor  platform device ---
commit 7a17d0a013a729b24666cfaf3097488acb16a27b
Author: Haojie Li <lihaojie@kylinos.cn>

drm/mediatek: Add missing IS_ERR check for ovl_adaptor platform device

This commit adds an IS_ERR() check for the return value of
platform_device_register_data() when initializing the ovl_adaptor
device. This prevents a potential kernel crash caused by using an
invalid pointer if the registration fails.

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index c86a3f54f35bc..b281482ab8c82 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -1112,6 +1112,9 @@ static int mtk_drm_probe(struct platform_device *pd=
ev)
>  							    PLATFORM_DEVID_AUTO,
>  							    (void *)private->mmsys_dev,
>  							    sizeof(*private->mmsys_dev));

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to pass
sizeof(*private->mmsys_dev) to platform_device_register_data() here?

The size parameter instructs platform_device_register_data() to kmemdup
the entire struct device object into the new platform device's platform_dat=
a.

Later in mtk_disp_ovl_adaptor_probe():

drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:mtk_disp_ovl_adaptor_probe(=
) {
    ...
    priv->mmsys_dev =3D pdev->dev.platform_data;
    ...
}

This extracts the cloned struct device object. Copying a struct device by
value duplicates its internal state (like kobjects, list heads, and locks).
If this cloned device is passed to generic device APIs, it could risk list
corruption, use-after-free, or power management state desynchronization.

Should this be passing a pointer to the device object instead of copying
the object by value?

> +		if (IS_ERR(ovl_adaptor))
> +			return PTR_ERR(ovl_adaptor);
> +
>  		private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev =3D &ovl_adaptor-=
>dev;
>  		mtk_ddp_comp_init(dev, NULL, &private->ddp_comp[DDP_COMPONENT_DRM_OVL_=
ADAPTOR],
>  				  DDP_COMPONENT_DRM_OVL_ADAPTOR);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825100845.4388=
93-1-lihaojie@kylinos.cn?part=3D1
