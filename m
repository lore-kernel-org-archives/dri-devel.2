Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EF1C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A0A10E6A3;
	Thu,  9 Jul 2026 11:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gOaqk5SZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F7910E6A3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:13:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D950F41824;
 Thu,  9 Jul 2026 11:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4201F000E9;
 Thu,  9 Jul 2026 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783595603;
 bh=GvxeaAuBQwBrlWJObFxLSKPsg0nbQA9KkijlBGLM4u8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gOaqk5SZ3Rl/01qCCOHzwzamp8YVYK4+lsb9VFtghcjvzx3kAGUdhGGGbrYAkNYrc
 u+3TG/d7KMdpKC0sc3yH/RyFvt3uKt9ndmqf5BkdG2ajO+d+hG5359BqqNX6+N2hAd
 eQlnSPSssGHqL5B2EVYqUuYYDe4TeSJ9V3DCV20z24PlHHQ5N9zhv6OtHyDZFrW61O
 h6aDLlIp6/hskeDZXCrW2IqmPdtXFW4lWg3OBiFT2XrD/rJNo+DzA+3MCCNrM34KGT
 pMQLN6VNuKy0jBUhBQT8AipNTrAT1+TBHQMkvSTORt1GR0ROAEP2I6sGnhY5FUlPH6
 bt0lUEJZdvsvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/11] drm/mediatek: mtk_dp: Add support for PHY from
 devicetree
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260709100617.42583-8-angelogioacchino.delregno@collabora.com>
References: <20260709100617.42583-1-angelogioacchino.delregno@collabora.com>
 <20260709100617.42583-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:13:22 +0000
Message-Id: <20260709111323.6F4201F000E9@smtp.kernel.org>
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
- [High] Double-unregister of the `mediatek-dp-phy` platform device on `dev=
m_phy_get` failure.
--

--- Patch [7]: [PATCH v2 07/11] drm/mediatek: mtk_dp: Add support for PHY f=
rom devicetree ---
commit 21392ccaeb903069c1e4a92500d58612e1669daf
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: mtk_dp: Add support for PHY from devicetree

This commit adds support for parsing the DisplayPort PHY from the devicetree
via the phys property. For older devicetrees, it falls back to a legacy
configuration by registering a mediatek-dp-phy platform device and reading
legacy PHY calibration data.

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
Does this code double-unregister the mediatek-dp-phy platform device?

Earlier in mtk_dp_register_phy(), mtk_dp->phy_dev is registered with devres:

	ret =3D devm_add_action_or_reset(dev, mtk_dp_unregister_pdevs,
				       mtk_dp->phy_dev);

If devm_phy_get() fails immediately after the lines modified above:

	mtk_dp->phy =3D devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
	if (IS_ERR(mtk_dp->phy)) {
		platform_device_unregister(mtk_dp->phy_dev);
		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy),
				     "Failed to get phy\n");
	}

It explicitly calls platform_device_unregister() on the failure path. Since
devres will also execute mtk_dp_unregister_pdevs() (which unregisters the
same device) when probe fails, can this lead to a double-free and list
corruption in the driver core?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709100617.4258=
3-1-angelogioacchino.delregno@collabora.com?part=3D7
